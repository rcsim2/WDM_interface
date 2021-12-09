// Plug and Play handlers for TxintPar driver

#include "stddcls.h"
#include "driver.h"



///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS TxintPar_DispatchPnp( IN PDEVICE_OBJECT fdo, IN PIRP Irp )
{							// TxintPar_DispatchPnp
	PAGED_CODE();

	PIO_STACK_LOCATION stack = IoGetCurrentIrpStackLocation(Irp);
	ULONG fcn = stack->MinorFunction;
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	// parallel stuff
	UNICODE_STRING PortDeviceObjectName;
	//RtlInitUnicodeString(&PortDevName, L"\\Device\\LPT1");
	PFILE_OBJECT PortFileObject;
	PDEVICE_OBJECT PortDeviceObject;
	PIRP PortIrp;
	KEVENT Event;
	IO_STATUS_BLOCK IoStatus;
	PARALLEL_INTERRUPT_SERVICE_ROUTINE ParIsr;
	PARALLEL_INTERRUPT_INFORMATION ParInterruptInfo;


	switch (fcn)
	{						// process PNP request
		case IRP_MN_START_DEVICE:
		{						// IRP_MN_START_DEVICE
			
			NTSTATUS status = TxP_ForwardAndWait(fdo, Irp);
			if (!NT_SUCCESS(status)) {
				return TxP_CompleteRequest(Irp, status, Irp->IoStatus.Information);
			}

			// TODO: we must have a CM_RESOURCE_LIST with I/O Port and IRQ resources
			// PnP devices build these on basis of .INF file
			// But the list does not seem to get build when we specify I/O Port and IRQ
			// in the INF...
			// Where in the reg are the res lists??? Should we just build one ourselves???
			//
			// Win2K and WinXP do not allow us to just access the IRQ and I/O port that the
			// par port already possesses. We should write a parclass driver and then supply
			// an ISR. (Note: interrupts on the par port are disabled by default on Win2K.
			// Make sure they are enabled!).
			// When we have a parclass device it will use the resources that the par port
			// uses and find them here??
			// We should use IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT instead of
			// IoConnectInterrupt().
			// devguid.h: Defines GUIDs for device classes used in Plug & Play. We should use
			// GUID_DEVCLASS_PORTS in the INF.
			// The IOCTL_INTERNAL_PARCLASS_CONNECT request returns information about the 
			// parallel port and the callback routines that Parclass provides. Typically,
			// a client first uses a connect request to obtain connect information, and then
			// uses a lock port request to allocate exclusive use of the parallel port for a 
			// parallel device. Parclass does not queue this request.
			//
			// If we define GUID_DEVCLASS_PORTS in the INF will we get the resources we want???
			// 
			// The connect interrupt request is enabled by the registry entry value 
			// EnableConnectInterruptIoctl under the Plug and Play registry key for the 
			// parallel port device. The type of the entry value is REG_DWORD and the default
			// value is 0x0 (disabled). 
			// We must change this reg value in order to enable interrupts on the par port.
			// The par port will then catch interrupts from our Tx interface device???
			//
			// Parport maintains a list of the ISRs that are connected to a parallel port.
			// Parport calls all the connected ISRs after an interrupt on the parallel port.
			//
			// We must set the PnP registry entry value EnableConnectInterruptIoctl to 0x1
			// We must request parport: IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT, IOCTL_INTERNAL_GET_MORE_PARALLEL_PORT_INFO
			// We must request parclass: IOCTL_INTERNAL_PARCLASS_CONNECT, IOCTL_INTERNAL_LOCK_PORT
			// (In de VxD hebben we een lock vergeten: dit zorgt voor onstabiele waardes als
			// andere drivers de poort aanspreken)




			// Use these functions to send IOCTLs (IRPs) to parport and parclass:
			//
			// NTSTATUS 
			//   IoGetDeviceObjectPointer(
			//   IN PUNICODE_STRING  ObjectName,
			//   IN ACCESS_MASK  DesiredAccess,
			//   OUT PFILE_OBJECT  *FileObject,
			//   OUT PDEVICE_OBJECT  *DeviceObject
			//   );
			// 
			// Irp = IoBuildDeviceIoControlRequest(IOCTL_INTERNAL_GET_PARALLEL_PORT_INFO,
			//                                         Extension->PortDeviceObject,
			//                                         NULL, 
			//                                         0, 
			//                                         &PortInfo,
			//                                         sizeof(PARALLEL_PORT_INFORMATION),
			//                                         TRUE, 
			//                                         &Event, 
			//                                         &IoStatus);
			// 
			// IoCallDriver(DeviceObject, Irp);

			////////////////////////////////////////////////////////////////////////////
			// Let's connect an ISR to the parallel port
			// Should do this in DriverEntry(). (But can also do it here).
			// If a class driver wishes to use the parallel port's interrupt then
			// it should connect to this interrupt by calling
			// IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT during its DriverEntry
			// routine. (But can also do it here).
			// Please refer to the PARSIMP driver code for a template of a simple
			// parallel class driver.
			// TODO: In order to allow interrupts on the par port:
			// 1. Choose "Use any interrupts assigned to the port" in par port tab in Device Manager
			// 2. Add and set an EnableConnectInterruptIoctl reg val to 0x1 (DWORD)
			// (under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\Root\*PNP0400\PnPBIOS_10\Device Parameters)
			//(PWSTR)L"EnableConnectInterruptIoctl"
			// TODO: send IOCTL_INTERNAL_PARALLEL_PORT_ALLOCATE to acquire the port
			// NOTE: DpcForIsr() is required for an ISR (see: NT4 DDK's parsimp sample)
			// TODO: hack all INTERRUPT_NEEDED stuff from parsimp into this driver

			// A DPC is required for an ISR
			IoInitializeDpcRequest(fdo, ParDpcForIsr);


			// NOTE: DD_PARALLEL_PORT_BASE_NAME_U is #defined as "ParallelPort" (see: parsimp)
			//RtlInitUnicodeString(&PortDeviceObjectName, L"\\DosDevices\\LPT1");
			//RtlInitUnicodeString(&PortDeviceObjectName, L"\\Device\\Parallel0");
			RtlInitUnicodeString(&PortDeviceObjectName, L"\\Device\\ParallelPort0");


			status = IoGetDeviceObjectPointer(&PortDeviceObjectName, FILE_ALL_ACCESS,
							&PortFileObject, &PortDeviceObject);

			if (!NT_SUCCESS(status)) {
				return status;
			}

			// save in extension
			pdx->PortDeviceObject = PortDeviceObject;

			KeInitializeEvent(&Event, NotificationEvent, FALSE);
			//ParIsr.InterruptServiceRoutine = TxP_InterruptService;
			//ParIsr.InterruptServiceContext = NULL;
			ParIsr.InterruptServiceRoutine = ParInterruptService;
			ParIsr.InterruptServiceContext = pdx;
			ParIsr.DeferredPortCheckRoutine = ParDeferredPortCheck;
			ParIsr.DeferredPortCheckContext = pdx;

			PortIrp = IoBuildDeviceIoControlRequest(IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT,
														PortDeviceObject,
														&ParIsr, 
														sizeof(ParIsr), 
														&ParInterruptInfo,
														sizeof(ParInterruptInfo),
														TRUE, 
														&Event, 
														&IoStatus);

			ASSERT(PortIrp->StackCount > 0);

			if (!PortIrp) {
				return STATUS_INSUFFICIENT_RESOURCES;
			}

			status = IoCallDriver(PortDeviceObject, PortIrp);

			if (!NT_SUCCESS(status)) {
				return status;
			}

			status = KeWaitForSingleObject(&Event, Executive, KernelMode, FALSE, NULL);

			if (!NT_SUCCESS(status)) {
				return status;
			}

			status = IoStatus.Status;

			if (!NT_SUCCESS(status)) {
				return(status);
			}

			pdx->InterruptObject = ParInterruptInfo.InterruptObject;
			pdx->TryAllocatePortAtInterruptLevel =
					ParInterruptInfo.TryAllocatePortAtInterruptLevel;
			pdx->TryAllocateContext = ParInterruptInfo.Context;


			//KeWaitForSingleObject()
			//IoCompleteRequest()
			//////////////////////////////////////////////////////////////////////////


			// TODO: get the resources from LPT1 into translated
			// (The user will be forced to use LPT1)
			// Force the fucker
			//pdx->Vector = 7;
			//pdx->Irql = DISPATCH_LEVEL; //(KIRQL)resource->u.Interrupt.Level;
			//pdx->SynchronizeIrql = DISPATCH_LEVEL; //(KIRQL)resource->u.Interrupt.Level;
			//pdx->InterruptMode = Latched;
			//pdx->ShareVector = TRUE;
			//pdx->ProcessorEnableMask = -1; //resource->u.Interrupt.Affinity; 
			//pdx->FloatingSave = FALSE;

			// Let's connect it
			//TxP_ConnectInterrupt( pdx );
			///////////////////////////////////////////////////////



			/////////////////////////////////////////////////////////////////
			// No use for this stuff as we will be using the par port's resources
			//
			//PCM_PARTIAL_RESOURCE_LIST raw = stack->Parameters.StartDevice.AllocatedResources
			//	? &stack->Parameters.StartDevice.AllocatedResources->List[0].PartialResourceList
			//	: NULL;
			//
			//PCM_PARTIAL_RESOURCE_LIST translated = stack->Parameters.StartDevice.AllocatedResourcesTranslated
			//	? &stack->Parameters.StartDevice.AllocatedResourcesTranslated->List[0].PartialResourceList
			//	: NULL;
			//
			// Start 'r up, Ma!
			//status = TxP_StartDevice(fdo, raw, translated);
			/////////////////////////////////////////////////////////////////////

			return TxP_CompleteRequest(Irp, status, 0);
		}						// IRP_MN_START_DEVICE

		case IRP_MN_QUERY_STOP_DEVICE:
		case IRP_MN_QUERY_REMOVE_DEVICE:
			return TxP_CompleteRequest(Irp, STATUS_UNSUCCESSFUL, 0);

		default:
			IoSkipCurrentIrpStackLocation(Irp);
			return IoCallDriver(pdx->LowerDeviceObject, Irp);
	
	}						// process PNP request
}							// TxintPar_DispatchPnp





#ifdef INTERRUPT_NEEDED

BOOLEAN
ParSetTrue(
    OUT  PVOID  Context
    )
{
    *((PBOOLEAN) Context) = TRUE;
    return(TRUE);
}

VOID
ParDpcForIsr(
    IN  PKDPC           Dpc,
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp,
    IN  PVOID           Extension
    )

/*++

Routine Description:

    This is the DPC for the interrupt service routine below.

Arguments:

    Dpc             - Supplies the DPC.

    DeviceObject    - Supplies the device object.

    Irp             - Supplies the I/O request packet.

    Extension       - Supplies the device extension.

Return Value:

    None.

--*/

{
    PDEVICE_EXTENSION   extension;

    extension = (PDEVICE_EXTENSION)Extension;

    //
    // Perform defered actions for Interrupt service routine.
    //

    //
    // Complete the IRP, free the port, and start up the next IRP in
    // the queue.
    //

    Irp->IoStatus.Status = STATUS_SUCCESS;
    Irp->IoStatus.Information = 0;
    IoCompleteRequest(Irp, IO_PARALLEL_INCREMENT);

    KeSynchronizeExecution(extension->InterruptObject,
                           ParSetTrue,
                           &extension->IgnoreInterrupts);

    extension->FreePort(extension->FreePortContext);

    ParAllocPortWithNext(extension);
}




BOOLEAN
ParInterruptService(
    IN      PKINTERRUPT Interrupt,
    IN OUT  PVOID       Extension
    )

/*++

Routine Description:

    This routine is the interrupt service routine for this parallel
    driver.  If this device does not own the parallel port then it
    will return FALSE so as to let this shared interrupt be taken
    by another driver.

Arguments:

    Interrupt   - Supplies the interrupt object.

    Extension   - Supplies the device extension.

Return Value:

    FALSE   - The interrupt was not handled.
    TRUE    - The interrupt was handled.

--*/

{
    PDEVICE_EXTENSION   extension;

    extension = (PDEVICE_EXTENSION)Extension;

    if (extension->IgnoreInterrupts) {

        // The port is not allocated by this driver.  
        // If appropriate this device can try to grab the port if it
        // is free.

        if (!extension->TryAllocatePortAtInterruptLevel(
            extension->TryAllocateContext)) {

            return FALSE;
        }
    }

    // Do some stuff and then queue a DPC to complete the request and
    // free the port.

	// Here's our interrupt stuff ////////////////////////////////////
	
	// test
	extension->Ch5 = 1750;

/*
	// Keep count of how many interrupts we processed
	extension->IntCount++;

	// Start time stamping: we need resolution fine enough for 1000-2000 uS (1-2 ms)
	// KeQueryTickCount()			coarse grained
	// KeQueryInterruptTime()		fine grained: 100-nanosecond units == 0.1 uS
	// KeQueryPerformanceCounter()	finest grained

	// Time stamp first interrupt
	if ( !extension->GotIntTime ) {
		extension->PrevIntTime = (int)KeQueryInterruptTime();
		extension->GotIntTime = true;
		return TRUE;
	}

	// Subtract previous time stamp from current time stamp
	// We don't need ULONGLONG, only int
	extension->PulseLength = (int)KeQueryInterruptTime() - extension->PrevIntTime;

	// Save current time stamp for next time
	extension->PrevIntTime = (int)KeQueryInterruptTime();

	// If timer goes from FFFFFFFFh to 00000000h we get a great negative value:
	// Compensate it
	if ( extension->PulseLength < 0 )
		extension->PulseLength += 0xFFFFFFFF;

	// It is more convenient to work with with 1 uS units
	extension->PulseLength /= 10;

	// Check if it is the sync pulse
	if ( extension->PulseLength > 5000 ) {
		extension->GotSync = true;
		extension->ChannelCount = 0;
		extension->SyncPulse = extension->PulseLength;
		return TRUE;
	}

	// Set channels
	if ( extension->GotSync ) {
		extension->ChannelCount++;

		switch ( extension->ChannelCount ) 
		{
			case 1: extension->Ch1 = extension->PulseLength; return TRUE; break;
			case 2: extension->Ch2 = extension->PulseLength; return TRUE; break;
			case 3: extension->Ch3 = extension->PulseLength; return TRUE; break;
			case 4: extension->Ch4 = extension->PulseLength; return TRUE; break;
			case 5: extension->Ch5 = extension->PulseLength; return TRUE; break;
			case 6: extension->Ch6 = extension->PulseLength; return TRUE; break;
			case 7: extension->Ch7 = extension->PulseLength; return TRUE; break;
			case 8: extension->Ch8 = extension->PulseLength; return TRUE; break;
			case 9: extension->Ch9 = extension->PulseLength; return TRUE; break;
			case 10: extension->Ch10 = extension->PulseLength; return TRUE; break;
		}
	}

	// test
	//extension->Ch3 = 1750;
*/
	////////////////////////////////////////////////////////////////////////


    IoRequestDpc(extension->DeviceObject, extension->CurrentIrp, extension);

    return TRUE;
}



VOID
ParDeferredPortCheck(
    IN  PVOID   Extension
    )

/*++

Routine Description:

    This routine is called when the parallel port is inactive.
    It makes sure that interrupts are enabled.

Arguments:

    Extension   - Supplies the device extension.

Return Value:

    None.

--*/

{
    PDEVICE_EXTENSION   extension = (PDEVICE_EXTENSION)Extension;
    UCHAR               u;

    // Make sure that interrupts are turned on.

    u = READ_PORT_UCHAR(extension->Controller + 2);
	u |= 0x10;
    WRITE_PORT_UCHAR(extension->Controller + 2, u);
}

BOOLEAN
ParSetFalse(
    OUT  PVOID  Context
    )
{
    *((PBOOLEAN) Context) = FALSE;
    return(TRUE);
}

#endif // INTERRUPT_NEEDED


VOID
ParAllocPort(
    IN  PDEVICE_EXTENSION   Extension
    )

/*++

Routine Description:

    This routine takes the 'CurrentIrp' and sends it down to the
    port driver as an allocate parallel port request.

Arguments:

    Extension   - Supplies the device extension.

Return Value:

    None.

--*/

{
    PIO_STACK_LOCATION  nextSp;

    nextSp = IoGetNextIrpStackLocation(Extension->CurrentIrp);
    nextSp->MajorFunction = IRP_MJ_INTERNAL_DEVICE_CONTROL;
    nextSp->Parameters.DeviceIoControl.IoControlCode =
            IOCTL_INTERNAL_PARALLEL_PORT_ALLOCATE;

    IoSetCompletionRoutine(Extension->CurrentIrp,
                           ParReadCompletionRoutine,
                           Extension, TRUE, TRUE, TRUE);

/*
#ifdef TIMEOUT_ALLOCS

    Extension->TimedOut = FALSE;
    Extension->CurrentIrpRefCount = IRP_REF_TIMER + IRP_REF_COMPLETION_ROUTINE;
    KeSetTimer(&Extension->AllocTimer, Extension->AllocTimeout,
               &Extension->AllocTimerDpc);

#endif
*/
    IoCallDriver(Extension->PortDeviceObject, Extension->CurrentIrp);
}


VOID
ParAllocPortWithNext(
    IN OUT  PDEVICE_EXTENSION   Extension
    )

/*++

Routine Description:

    This routine takes the next IRP on the work queue and passes it
    down to the port device to allocate the port.

Arguments:

    Extension   - Supplies the device extension.

Return Value:

    None.

--*/

{
    KIRQL       cancelIrql;
    PLIST_ENTRY head;

    IoAcquireCancelSpinLock(&cancelIrql);

    Extension->CurrentIrp = NULL;

    if (IsListEmpty(&Extension->WorkQueue)) {
        IoReleaseCancelSpinLock(cancelIrql);
    } else {

        head = RemoveHeadList(&Extension->WorkQueue);
        Extension->CurrentIrp = CONTAINING_RECORD(head, IRP,
                                                  Tail.Overlay.ListEntry);
        IoSetCancelRoutine(Extension->CurrentIrp, NULL);
        IoReleaseCancelSpinLock(cancelIrql);

        ParAllocPort(Extension);
    }
}


NTSTATUS
ParReadCompletionRoutine(
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp,
    IN  PVOID           Extension
    )

/*++

Routine Description:

    This is the completion routine for the device control request.
    This driver has exclusive access to the parallel port in this
    routine.

Arguments:

    DeviceObject    - Supplies the device object.

    Irp             - Supplies the I/O request packet.

    Extension       - Supplies the device extension.

Return Value:

    STATUS_MORE_PROCESSING_REQUIRED

--*/

{
    PDEVICE_EXTENSION   extension;
    KIRQL               oldIrql;
    LONG                irpRef;

    extension = (PDEVICE_EXTENSION)Extension;
/*
#ifdef TIMEOUT_ALLOCS

    // Try to cancel the timer.

    if (KeCancelTimer(&extension->AllocTimer)) {

        // The timer was cancelled.  The completion routine has the IRP.
        extension->CurrentIrpRefCount = 0;

    } else {

        // We're in contention with the timer DPC.  Establish who
        // will complete the IRP via the 'CurrentIrpRefCount'.

        KeAcquireSpinLock(&extension->ControlLock, &oldIrql);
        ASSERT(extension->CurrentIrpRefCount & IRP_REF_COMPLETION_ROUTINE);
        irpRef = (extension->CurrentIrpRefCount -= IRP_REF_COMPLETION_ROUTINE);
        KeReleaseSpinLock(&extension->ControlLock, oldIrql);

        if (irpRef) {

            // The IRP will be completed by the timer DPC.

            return STATUS_MORE_PROCESSING_REQUIRED;
        }
    }

    // At this point, the timer DPC is guaranteed not to
    // mess with the CurrentIrp.

#endif
*/
    ParCompleteRequest(extension);

    // If the IRP was completed.  It was completed with 'IoCompleteRequest'.

    return STATUS_MORE_PROCESSING_REQUIRED;
}


VOID
ParCompleteRequest(
    IN  PDEVICE_EXTENSION   Extension
    )

/*++

Routine Description:

    This routine completes the 'CurrentIrp' after it was returned
    from the port driver.

Arguments:

    Extension   - Supplies the device extension.

Return Value:

    None.

--*/

{
    PIRP    Irp;

    Irp = Extension->CurrentIrp;

    // If the allocate failed, then fail this request and try again
    // with the next IRP.

    if (!NT_SUCCESS(Irp->IoStatus.Status)) {
/*
#ifdef TIMEOUT_ALLOCS
        if (Extension->TimedOut) {
            Irp->IoStatus.Status = STATUS_IO_TIMEOUT;
        }
#endif
*/
        IoCompleteRequest(Irp, IO_NO_INCREMENT);
        ParAllocPortWithNext(Extension);
        return;
    }


#ifdef INTERRUPT_NEEDED

    KeSynchronizeExecution(Extension->InterruptObject,
                           ParSetFalse,
                           &Extension->IgnoreInterrupts);
#endif

    //
    // This is where the driver specific stuff should go.  The driver
    // has exclusive access to the parallel port in this space.
    //

#ifdef INTERRUPT_NEEDED

    //
    // We're waiting for an interrupt before we can complete the IRP.
    //

#else

    //
    // Complete the IRP, free the port, and start up the next IRP in
    // the queue.
    //

    Irp->IoStatus.Status = STATUS_SUCCESS;
    Irp->IoStatus.Information = 0;
    IoCompleteRequest(Irp, IO_PARALLEL_INCREMENT);

    Extension->FreePort(Extension->FreePortContext);

    ParAllocPortWithNext(Extension);

#endif
}
