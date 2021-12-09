/*++

Copyright (c) 1993 Microsoft Corporation
Copyright (c) 2002 Black Sphere Corp.

Module Name:

    parsimp.c

Abstract:

    This module contains the code for a simple parallel class driver.

    Unload and Cleanup are supported.  The model for grabing and
    releasing the parallel port is embodied in the code for IRP_MJ_READ.
    Other IRP requests could be implemented similarly.

    Basically, every READ requests that comes in gets
    passed down to the port driver as a parallel port allocate
    request.  This IRP will return to this driver when the driver
    owns the port.  By uncommenting the '#define TIMEOUT_ALLOCS'
    line below, code will be added to timeout the allocate
    requests after a specified amount of time and return
    STATUS_IO_TIMEOUT for that read request.

    Device drivers who wish to use the parallel port interrupt
    can uncomment the '#define INTERRUPT_NEEDED' line below.
    This will add support for using the interrupt in a shared manner
    so that many parallel class drivers can share it.
    
    
    //////////////////////////////////////////////////////
    Kernel-mode:			User-mode:    
    IRP_MJ_CREATE 			=> CreateFile()
    IRP_MJ_CLOSE  			=> CloseHandle()
    IRP_MJ_DEVICE_CONTROL 	=> DeviceIoControl()
    IRP_MJ_READ   			=> ReadFile()
    IRP_MJ_WRITE 			=> WriteFile()
    //////////////////////////////////////////////////////
    

	/////////////////////////////////////////////////////////////////////////////////    
    NOTE: In order to allow interrupts on the par port:
    1. Choose "Use any interrupts assigned to the port" in par port tab in Device Manager
    2. Add and set an EnableConnectInterruptIoctl reg val to 0x1 (DWORD)
      (under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\Root\*PNP0400\PnPBIOS_10\Device Parameters)
    3. Make sure bit 4 (0x10) is set on the par port's Control Register
    /////////////////////////////////////////////////////////////////////////////////
    
    
    //////////////////////////////////////////////////////////////
    AT LAST: IT WORKS: 
    We have it confirmed that the ISR actually gets connected to
    the par port: but we have to write 0x10 to the control reg
    (offset 2) first by means of Thesycon's UPPDEMO. This means that probably
    ParDeferredPortCheck() never gets properly called in our driver.
    Fix it!!!
    
	Note:
    Our ISR gets connected at system start-up right away. No need to 
    run Load.exe. This is because the code connects the ISR right away.
    Het enige wat er voor zorgt dat de ISR niet meteen werkt heeft
    puur te maken met het feit dat ParDeferredPortCheck() nooit aangeroepen
    wordt en dus de par port controller interrupts *NIET AANZET*.
    ParDeferredPortCheck() is the culprit.
    
    TODO:
    1. Write EnableConnectInterruptIoctl to registry
    2. Set bit 4 (0x10) on the par port's Control Register
    //////////////////////////////////////////////////////////////
    

Author(s):

    Norbert P. Kusters 25-Jan-1994
    Rik Goossens 2-10-2002

Environment:

    Kernel mode

Revision History :

--*/

#include "ntddk.h"
#include "parallel.h"

// #define TIMEOUT_ALLOCS      1
#define INTERRUPT_NEEDED    1

#include "parsimp.h"
#include "parlog.h"

static const PHYSICAL_ADDRESS PhysicalZero = {0};

DEVICE_EXTENSION pExtensionDummy;

NTSTATUS
DriverEntry(
    IN  PDRIVER_OBJECT  DriverObject,
    IN  PUNICODE_STRING RegistryPath
    );

BOOLEAN
ParMakeNames(
    IN  ULONG           ParallelPortNumber,
    OUT PUNICODE_STRING PortName,
    OUT PUNICODE_STRING ClassName,
    OUT PUNICODE_STRING LinkName
    );

VOID
ParInitializeDeviceObject(
    IN  PDRIVER_OBJECT  DriverObject,
    IN  ULONG           ParallelPortNumber
    );

NTSTATUS
ParGetPortInfoFromPortDevice(
    IN OUT  PDEVICE_EXTENSION   Extension
    );

#ifdef INTERRUPT_NEEDED

NTSTATUS
ParInitializeInterruptObject(
    IN      PDRIVER_OBJECT      DriverObject,
    IN OUT  PDEVICE_EXTENSION   Extension
    );

#ifdef ALLOC_PRAGMA
#pragma alloc_text(INIT,ParInitializeInterruptObject)
#endif

#endif // INTERRUPT_NEEDED

VOID
ParAllocPort(
    IN  PDEVICE_EXTENSION   Extension
    );

#ifdef ALLOC_PRAGMA
#pragma alloc_text(INIT,DriverEntry)
#pragma alloc_text(INIT,ParInitializeDeviceObject)
#pragma alloc_text(INIT,ParMakeNames)
#pragma alloc_text(INIT,ParGetPortInfoFromPortDevice)
#endif




NTSTATUS
DriverEntry(
    IN  PDRIVER_OBJECT  DriverObject,
    IN  PUNICODE_STRING RegistryPath
    )

/*++

Routine Description:

    This routine is called at system initialization time to initialize
    this driver.

Arguments:

    DriverObject    - Supplies the driver object.

    RegistryPath    - Supplies the registry path for this driver.

Return Value:

    STATUS_SUCCESS          - We could initialize at least one device.
    STATUS_NO_SUCH_DEVICE   - We could not initialize even one device.

--*/

{
    ULONG       i;

    
    //////////////////////////////////////////////////
    // NOTE: we moeten deze code niet meteen tijdens DriverEntry triggeren.
    // Dit moeten we in Load.exe doen met een IOCTL_TXINTPAR_INIT via DeviceIoControl()
    // We kunnen dan beter volgen wat er gebeurd in DebugView en we claimen de par port
    // niet meteen zodat er minder snel conflicten zijn met andere drivers.
    // Tenminste: we moeten zoveel uitvoeren tot de symbolic link is gemaakt.
    // Het initieren van de poort en het eraan hangen van een interrupt kunnen
    // we beter via DeviceIoControl() doen. Zie: Thesycon's UPPDEMO.
    //
    for (i = 0; i < IoGetConfigurationInformation()->ParallelCount; i++) {
        ParInitializeDeviceObject(DriverObject, 0/*i*/);
    }

    if (!DriverObject->DeviceObject) {
        return STATUS_NO_SUCH_DEVICE;
    }    
    //////////////////////////////////////////////////
  

    //
    // Initialize the Driver Object with driver's entry points
    //

    DriverObject->MajorFunction[IRP_MJ_CREATE] = ParCreateClose;
    DriverObject->MajorFunction[IRP_MJ_CLOSE] = ParCreateClose;
    DriverObject->MajorFunction[IRP_MJ_READ] = ParRead;
    DriverObject->MajorFunction[IRP_MJ_CLEANUP] = ParCleanup;
    DriverObject->DriverUnload = ParUnload;

	// User-mode DeviceIoControl() calls will be routed here
    DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL] = ParDeviceControl;

    return STATUS_SUCCESS;
}

VOID
ParLogError(
    IN  PDRIVER_OBJECT      DriverObject,
    IN  PDEVICE_OBJECT      DeviceObject OPTIONAL,
    IN  PHYSICAL_ADDRESS    P1,
    IN  PHYSICAL_ADDRESS    P2,
    IN  ULONG               SequenceNumber,
    IN  UCHAR               MajorFunctionCode,
    IN  UCHAR               RetryCount,
    IN  ULONG               UniqueErrorValue,
    IN  NTSTATUS            FinalStatus,
    IN  NTSTATUS            SpecificIOStatus
    )

/*++

Routine Description:

    This routine allocates an error log entry, copies the supplied data
    to it, and requests that it be written to the error log file.

Arguments:

    DriverObject        - Supplies a pointer to the driver object for the
                            device.

    DeviceObject        - Supplies a pointer to the device object associated
                            with the device that had the error, early in
                            initialization, one may not yet exist.

    P1,P2               - Supplies the physical addresses for the controller
                            ports involved with the error if they are available
                            and puts them through as dump data.

    SequenceNumber      - Supplies a ulong value that is unique to an IRP over
                            the life of the irp in this driver - 0 generally
                            means an error not associated with an irp.

    MajorFunctionCode   - Supplies the major function code of the irp if there
                            is an error associated with it.

    RetryCount          - Supplies the number of times a particular operation
                            has been retried.

    UniqueErrorValue    - Supplies a unique long word that identifies the
                            particular call to this function.

    FinalStatus         - Supplies the final status given to the irp that was
                            associated with this error.  If this log entry is
                            being made during one of the retries this value
                            will be STATUS_SUCCESS.

    SpecificIOStatus    - Supplies the IO status for this particular error.

Return Value:

    None.

--*/

{
    PIO_ERROR_LOG_PACKET    errorLogEntry;
    PVOID                   objectToUse;
    SHORT                   dumpToAllocate;

    if (ARGUMENT_PRESENT(DeviceObject)) {
        objectToUse = DeviceObject;
    } else {
        objectToUse = DriverObject;
    }

    dumpToAllocate = 0;

    if (P1.LowPart != 0 || P1.HighPart != 0) {
        dumpToAllocate = (SHORT) sizeof(PHYSICAL_ADDRESS);
    }

    if (P2.LowPart != 0 || P2.HighPart != 0) {
        dumpToAllocate += (SHORT) sizeof(PHYSICAL_ADDRESS);
    }

    errorLogEntry = IoAllocateErrorLogEntry(objectToUse,
            (UCHAR) (sizeof(IO_ERROR_LOG_PACKET) + dumpToAllocate));

    if (!errorLogEntry) {
        return;
    }

    errorLogEntry->ErrorCode = SpecificIOStatus;
    errorLogEntry->SequenceNumber = SequenceNumber;
    errorLogEntry->MajorFunctionCode = MajorFunctionCode;
    errorLogEntry->RetryCount = RetryCount;
    errorLogEntry->UniqueErrorValue = UniqueErrorValue;
    errorLogEntry->FinalStatus = FinalStatus;
    errorLogEntry->DumpDataSize = dumpToAllocate;

    if (dumpToAllocate) {

        RtlCopyMemory(errorLogEntry->DumpData, &P1, sizeof(PHYSICAL_ADDRESS));

        if (dumpToAllocate > sizeof(PHYSICAL_ADDRESS)) {

            RtlCopyMemory(((PUCHAR) errorLogEntry->DumpData) +
                          sizeof(PHYSICAL_ADDRESS), &P2,
                          sizeof(PHYSICAL_ADDRESS));
        }
    }

    IoWriteErrorLogEntry(errorLogEntry);
}

VOID
ParInitializeDeviceObject(
    IN  PDRIVER_OBJECT  DriverObject,
    IN  ULONG           ParallelPortNumber
    )

/*++

Routine Description:

    This routine is called for every parallel port in the system.  It
    will create a class device upon connecting to the port device
    corresponding to it.

Arguments:

    DriverObject        - Supplies the driver object.

    ParallelPortNumber  - Supplies the number for this port.

Return Value:

    None.

--*/

{
    UNICODE_STRING      portName, className, linkName;
    NTSTATUS            status;
    PDEVICE_OBJECT      deviceObject;
    PDEVICE_EXTENSION   extension;
    PFILE_OBJECT        fileObject;


    // Cobble together the port and class device names.

    if (!ParMakeNames(ParallelPortNumber, &portName, &className, &linkName)) {

        ParLogError(DriverObject, NULL, PhysicalZero, PhysicalZero, 0, 0, 0, 1,
                    STATUS_SUCCESS, PAR_INSUFFICIENT_RESOURCES);

        return;
    }


    // Create the device object.

    status = IoCreateDevice(DriverObject, sizeof(DEVICE_EXTENSION),
                            &className, FILE_DEVICE_PARALLEL_PORT, 0, FALSE,
                            &deviceObject);
    if (!NT_SUCCESS(status)) {

        ParLogError(DriverObject, NULL, PhysicalZero, PhysicalZero, 0, 0, 0, 2,
                    STATUS_SUCCESS, PAR_INSUFFICIENT_RESOURCES);

        ExFreePool(linkName.Buffer);
        goto Cleanup;
    }


    // Now that the device has been created,
    // set up the device extension.

    extension = deviceObject->DeviceExtension;
    RtlZeroMemory(extension, sizeof(DEVICE_EXTENSION));
    
    // Added
    //extension->DriverObject = DriverObject;

    extension->DeviceObject = deviceObject;
    deviceObject->Flags |= DO_BUFFERED_IO;

    status = IoGetDeviceObjectPointer(&portName, FILE_ALL_ACCESS,
                                      &fileObject,
                                      &extension->PortDeviceObject);
    if (!NT_SUCCESS(status)) {

        ParLogError(DriverObject, deviceObject, PhysicalZero, PhysicalZero,
                    0, 0, 0, 3, STATUS_SUCCESS, PAR_CANT_FIND_PORT_DRIVER);

        IoDeleteDevice(deviceObject);
        ExFreePool(linkName.Buffer);
        goto Cleanup;
    }
    
 
    ObDereferenceObject(fileObject);

    extension->DeviceObject->StackSize =
            extension->PortDeviceObject->StackSize + 1;


    // Initialize an empty work queue.

    InitializeListHead(&extension->WorkQueue);
    extension->CurrentIrp = NULL;


    // Get the port information from the port device object.

    status = ParGetPortInfoFromPortDevice(extension);
    if (!NT_SUCCESS(status)) {

        ParLogError(DriverObject, deviceObject, PhysicalZero, PhysicalZero,
                    0, 0, 0, 4, STATUS_SUCCESS, PAR_CANT_FIND_PORT_DRIVER);

        IoDeleteDevice(deviceObject);
        ExFreePool(linkName.Buffer);
        goto Cleanup;
    }


    // Set up the symbolic link for windows apps.

    status = IoCreateUnprotectedSymbolicLink(&linkName, &className);
    if (!NT_SUCCESS(status)) {

        ParLogError(DriverObject, deviceObject, extension->OriginalController,
                    PhysicalZero, 0, 0, 0, 5, STATUS_SUCCESS,
                    PAR_NO_SYMLINK_CREATED);

        extension->CreatedSymbolicLink = FALSE;
        ExFreePool(linkName.Buffer);
        goto Cleanup;
    }


    // We were able to create the symbolic link, so record this
    // value in the extension for cleanup at unload time.

    extension->CreatedSymbolicLink = TRUE;
    extension->SymbolicLinkName = linkName;
    

#ifdef INTERRUPT_NEEDED

    // Ignore interrupts until we own the port.

    extension->IgnoreInterrupts = TRUE;


    // Connect the interrupt.

	// NOTE: the Dpc will cause a crash: we can initialize it, but
	// should *not* call it in our ISR!!! (with IoRequestDpc())
    IoInitializeDpcRequest(extension->DeviceObject, ParDpcForIsr);
    
    status = ParInitializeInterruptObject(DriverObject, extension);

    if (!NT_SUCCESS(status)) {

        ParLogError(DriverObject, deviceObject, extension->OriginalController,
                    PhysicalZero, 0, 0, 0, 6, STATUS_SUCCESS,
                    PAR_INTERRUPT_NOT_INITIALIZED);

        IoDeleteDevice(deviceObject);
        ExFreePool(linkName.Buffer);
        goto Cleanup;
    }

#endif

#ifdef TIMEOUT_ALLOCS

    // Prepare a timeout value of 5 seconds for port allocation.

    KeInitializeTimer(&extension->AllocTimer);
    KeInitializeDpc(&extension->AllocTimerDpc, ParAllocTimerDpc, extension);
    extension->AllocTimeout.QuadPart = -(5*1000*10000);
    extension->CurrentIrpRefCount = 0;
    KeInitializeSpinLock(&extension->ControlLock);

    extension->TimedOut = FALSE;

#endif

Cleanup:
    ExFreePool(portName.Buffer);
    ExFreePool(className.Buffer);
}

BOOLEAN
ParMakeNames(
    IN  ULONG           ParallelPortNumber,
    OUT PUNICODE_STRING PortName,
    OUT PUNICODE_STRING ClassName,
    OUT PUNICODE_STRING LinkName
    )

/*++

Routine Description:

    This routine generates the names \Device\ParallelPortN and
    \Device\ParallelSimpleN, \DosDevices\LPTSIMPLEn.

Arguments:

    ParallelPortNumber  - Supplies the port number.

    PortName            - Returns the port name.

    ClassName           - Returns the class name.

    LinkName            - Returns the symbolic link name.

Return Value:

    FALSE   - Failure.
    TRUE    - Success.

--*/
{
    UNICODE_STRING  prefix, digits, linkPrefix, linkDigits;
    WCHAR           digitsBuffer[10], linkDigitsBuffer[10];
    UNICODE_STRING  portSuffix, classSuffix, linkSuffix;
    NTSTATUS        status;

    // Put together local variables for constructing names.

    RtlInitUnicodeString(&prefix, L"\\Device\\");
    RtlInitUnicodeString(&linkPrefix, L"\\DosDevices\\");
    RtlInitUnicodeString(&portSuffix, DD_PARALLEL_PORT_BASE_NAME_U);
    RtlInitUnicodeString(&classSuffix, L"ParallelSimple");
    RtlInitUnicodeString(&linkSuffix, L"TXINTPAR");
    digits.Length = 0;
    digits.MaximumLength = 20;
    digits.Buffer = digitsBuffer;
    linkDigits.Length = 0;
    linkDigits.MaximumLength = 20;
    linkDigits.Buffer = linkDigitsBuffer;
    status = RtlIntegerToUnicodeString(ParallelPortNumber, 10, &digits);
    if (!NT_SUCCESS(status)) {
        return FALSE;
    }
    status = RtlIntegerToUnicodeString(ParallelPortNumber + 1, 10, &linkDigits);
    if (!NT_SUCCESS(status)) {
        return FALSE;
    }

    // Make the port name.

    PortName->Length = 0;
    PortName->MaximumLength = prefix.Length + portSuffix.Length +
                              digits.Length + sizeof(WCHAR);
    PortName->Buffer = ExAllocatePool(PagedPool, PortName->MaximumLength);
    if (!PortName->Buffer) {
        return FALSE;
    }
    RtlZeroMemory(PortName->Buffer, PortName->MaximumLength);
    RtlAppendUnicodeStringToString(PortName, &prefix);
    RtlAppendUnicodeStringToString(PortName, &portSuffix);
    RtlAppendUnicodeStringToString(PortName, &digits);


    // Make the class name.

    ClassName->Length = 0;
    ClassName->MaximumLength = prefix.Length + classSuffix.Length +
                               digits.Length + sizeof(WCHAR);
    ClassName->Buffer = ExAllocatePool(PagedPool, ClassName->MaximumLength);
    if (!ClassName->Buffer) {
        ExFreePool(PortName->Buffer);
        return FALSE;
    }
    RtlZeroMemory(ClassName->Buffer, ClassName->MaximumLength);
    RtlAppendUnicodeStringToString(ClassName, &prefix);
    RtlAppendUnicodeStringToString(ClassName, &classSuffix);
    RtlAppendUnicodeStringToString(ClassName, &digits);


    // Make the link name.

    LinkName->Length = 0;
    LinkName->MaximumLength = linkPrefix.Length + linkSuffix.Length +
                             linkDigits.Length + sizeof(WCHAR);
    LinkName->Buffer = ExAllocatePool(PagedPool, LinkName->MaximumLength);
    if (!LinkName->Buffer) {
        ExFreePool(PortName->Buffer);
        ExFreePool(ClassName->Buffer);
        return FALSE;
    }
    RtlZeroMemory(LinkName->Buffer, LinkName->MaximumLength);
    RtlAppendUnicodeStringToString(LinkName, &linkPrefix);
    RtlAppendUnicodeStringToString(LinkName, &linkSuffix);
    //RtlAppendUnicodeStringToString(LinkName, &linkDigits);

    return TRUE;
}

NTSTATUS
ParGetPortInfoFromPortDevice(
    IN OUT  PDEVICE_EXTENSION   Extension
    )

/*++

Routine Description:

    This routine will request the port information from the port driver
    and fill it in the device extension.

Arguments:

    Extension   - Supplies the device extension.

Return Value:

    STATUS_SUCCESS  - Success.
    !STATUS_SUCCESS - Failure.

--*/

{
    KEVENT                      event;
    PIRP                        irp;
    PARALLEL_PORT_INFORMATION   portInfo;
    IO_STATUS_BLOCK             ioStatus;
    NTSTATUS                    status;

    KeInitializeEvent(&event, NotificationEvent, FALSE);

    irp = IoBuildDeviceIoControlRequest(IOCTL_INTERNAL_GET_PARALLEL_PORT_INFO,
                                        Extension->PortDeviceObject,
                                        NULL, 0, &portInfo,
                                        sizeof(PARALLEL_PORT_INFORMATION),
                                        TRUE, &event, &ioStatus);

    if (!irp) {
        return STATUS_INSUFFICIENT_RESOURCES;
    }

    status = IoCallDriver(Extension->PortDeviceObject, irp);

    if (!NT_SUCCESS(status)) {
        return status;
    }

    status = KeWaitForSingleObject(&event, Executive, KernelMode, FALSE, NULL);

    if (!NT_SUCCESS(status)) {
        return status;
    }

    Extension->OriginalController = portInfo.OriginalController;
    Extension->Controller = portInfo.Controller;
    Extension->SpanOfController = portInfo.SpanOfController;
    Extension->FreePort = portInfo.FreePort;
    Extension->FreePortContext = portInfo.Context;

    if (Extension->SpanOfController < PARALLEL_REGISTER_SPAN) {
        return STATUS_INSUFFICIENT_RESOURCES;
    }

    return status;
}

#ifdef INTERRUPT_NEEDED

NTSTATUS
ParInitializeInterruptObject(
    IN      PDRIVER_OBJECT      DriverObject,
    IN OUT  PDEVICE_EXTENSION   Extension
    )

/*++

Routine Description:

    This routine sets up this devices interrupt routine by
    registering it with the port device.

Arguments:

    DriverObject    - Supplies the driver object.

    Extension       - Supplies the device extension.

Return Value:

    STATUS_SUCCESS  - The interrupt was successfully connected.
    Otherwise, an error occurred.

--*/

{
    KEVENT                              event;
    PIRP                                irp;
    PARALLEL_INTERRUPT_SERVICE_ROUTINE  interruptService;
    PARALLEL_INTERRUPT_INFORMATION      interruptInfo;
    IO_STATUS_BLOCK                     ioStatus;
    NTSTATUS                            status;
    ULONG 								EnableConnectInterruptIoctl;
    
    // test
    //KdPrint(("Entering ParInitializeInterruptObject\n"));
    
    
       
    // TEST TEST TEST Here???
    // Make sure that interrupts are enabled on Controller:
    // ParSetBit()
    
        
    // TEST TEST TEST Here???
    // Yes here. Got to write EnableConnectInterruptIoctl BEFORE trying to
    // connect the interrupt!!!
    // Make sure that interrupts are enabled in Registry:
    // ParSetValueKey()
    EnableConnectInterruptIoctl = 1;
	ParSetValueKey( Extension->PortDeviceObject, 
                  (PWSTR)L"EnableConnectInterruptIoctl", 
                  &EnableConnectInterruptIoctl ); 
    
    
    // Get the interrupt information from the port device.

    KeInitializeEvent(&event, NotificationEvent, FALSE);

    interruptService.InterruptServiceRoutine = ParInterruptService;
    interruptService.InterruptServiceContext = Extension;
    interruptService.DeferredPortCheckRoutine = ParDeferredPortCheck;
    interruptService.DeferredPortCheckContext = Extension;

    irp = IoBuildDeviceIoControlRequest(IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT,
                                        Extension->PortDeviceObject,
                                        &interruptService,
                                        sizeof(PARALLEL_INTERRUPT_SERVICE_ROUTINE),
                                        &interruptInfo,
                                        sizeof(PARALLEL_INTERRUPT_INFORMATION),
                                        TRUE, &event, &ioStatus);

    if (!irp) {
        return STATUS_INSUFFICIENT_RESOURCES;
    }
 
    
    
	// TEST TEST TEST
	// Make sure that interrupts are enabled on Controller
	// Can we call ParSetBit() like this???
	// YES: ParBitSet() gets called and we no longer have to set the bit
	// using Thesycon's UPPDEMO.
	// But our interrupt still crashes the system...
    IoSetCompletionRoutine(irp,
                           ParSetBit,
                           Extension, TRUE, TRUE, TRUE); 
                            
    
           

    status = IoCallDriver(Extension->PortDeviceObject, irp);

    if (!NT_SUCCESS(status)) { 
        return status;
    }

    status = KeWaitForSingleObject(&event, Executive, KernelMode, FALSE, NULL);

    if (!NT_SUCCESS(status)) { 
        return status;
    }

    status = ioStatus.Status;

    if (!NT_SUCCESS(status)) {
        return status;
    }

    Extension->InterruptObject = interruptInfo.InterruptObject;
    Extension->TryAllocatePortAtInterruptLevel =
            interruptInfo.TryAllocatePortAtInterruptLevel;
    Extension->TryAllocateContext = interruptInfo.Context;
    
       	   	
    // test: OK we get here, which means interrupt is connected
	//Extension->Ch5 = 1750;	
	//KdPrint(("Leaving ParInitializeInterruptObject: Interrupt is connected\n"));
	//DbgPrint("Leaving ParInitializeInterruptObject: Interrupt is connected\n");	
	   
 	
    return status;
}

#endif // INTERRUPT_NEEDED

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

    extension = Extension;

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
	LARGE_INTEGER PerfFreq;
	LARGE_INTEGER liTimeStamp;
	
 
    extension = Extension; 

	// test
	//extension->Ch5 = 1750;
	KdPrint(("We're in ParInterruptService\n"));	  


	// We've placed this one at the end
/*
    if (extension->IgnoreInterrupts) {

        // The port is not allocated by this driver.  
        // If appropriate this device can try to grab the port if it
        // is free.

        if (!extension->TryAllocatePortAtInterruptLevel(
            extension->TryAllocateContext)) {

            return FALSE;
        }
    }
*/

    // Do some stuff and then queue a DPC to complete the request and
    // free the port.



	// Here's our interrupt stuff /////////////////////////////////////////////
	
	// test
	//extension->Ch6 = 1751;


	// Keep count of how many interrupts we processed
	extension->IntCount++;

	// Start time stamping: we need resolution fine enough for 1000-2000 uS (1-2 ms)
	// KeQueryTickCount()			coarse grained
	// KeQueryInterruptTime()		fine grained: 100-nanosecond units == 0.1 uS (not fine enough?!)
	// KeQueryPerformanceCounter()	finest grained -> Use this one!!!
	
	// Get time stamp
	liTimeStamp = KeQueryPerformanceCounter(&PerfFreq);
	//DbgPrint("KeQueryPerformanceCounter: %i\n", (int)liTimeStamp.QuadPart);

	// Time stamp first interrupt
	if ( !extension->GotIntTime ) {
		extension->PrevIntTime = (int)liTimeStamp.QuadPart;
		extension->GotIntTime = TRUE;
		return TRUE;
	}

	// Subtract previous time stamp from current time stamp
	// We don't need LONGLONG, only int
	extension->PulseLength = (int)liTimeStamp.QuadPart - extension->PrevIntTime;
	
	DbgPrint("PulseLength: %i\n", extension->PulseLength);
	//DbgPrint("KeQueryInterruptTime: %i\n", (int)KeQueryInterruptTime());
	//liTimeStamp = KeQueryPerformanceCounter(&PerfFreq);
	//DbgPrint("KeQueryPerformanceCounter: %i\n", (int)liTimeStamp.QuadPart);

	// Save current time stamp for next time
	extension->PrevIntTime = (int)liTimeStamp.QuadPart;

	// If timer goes from FFFFFFFFh to 00000000h we get a great negative value:
	// Compensate it
	if ( extension->PulseLength < 0 )
		extension->PulseLength += 0xFFFFFFFF;

	
	// Check if it is the sync pulse
	if ( extension->PulseLength > 5000 ) {
		extension->GotSync = TRUE;
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
	//extension->Ch6 = 1750;

	///////////////////////////////////////////////////////////////////////////
	
	
/*	
	if (extension->IgnoreInterrupts) {

        // The port is not allocated by this driver.  
        // If appropriate this device can try to grab the port if it
        // is free.

        if (!extension->TryAllocatePortAtInterruptLevel(
            extension->TryAllocateContext)) {

            return FALSE;
        }
    }
*/

	// YES!!!!!
	// Here's the final bugger: it is causing a STOP error of DRIVER_IRQL_NOT_LESS_OR_EQUAL
	// Uncomment it!!!
    //IoRequestDpc(extension->DeviceObject, extension->CurrentIrp, extension);

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
    PDEVICE_EXTENSION   extension = Extension;
    UCHAR               u;

    // Make sure that interrupts are turned on.

    u = READ_PORT_UCHAR(extension->Controller + 2);
    u |= 0x10;
    WRITE_PORT_UCHAR(extension->Controller + 2, u);
    
     // test: YES, there's the rub: we never get here, which means
     // this function never gets called, which means interrupts
     // will not be enabled
	//extension->Ch5 =  1755; //(int)extension->Controller + 250;	
	DbgPrint(("We're in ParDeferredPortCheck\n"));
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

#ifdef TIMEOUT_ALLOCS
        if (Extension->TimedOut) {
            Irp->IoStatus.Status = STATUS_IO_TIMEOUT;
        }
#endif

        IoCompleteRequest(Irp, IO_NO_INCREMENT);
        ParAllocPortWithNext(Extension);
        return;
    }


#ifdef INTERRUPT_NEEDED

    KeSynchronizeExecution(Extension->InterruptObject,
                           ParSetFalse,
                           &Extension->IgnoreInterrupts); // IgnoreInterrupts will be set to false
   
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

#ifdef TIMEOUT_ALLOCS

VOID
ParAllocTimerDpc(
    IN  PKDPC   Dpc,
    IN  PVOID   Extension,
    IN  PVOID   SystemArgument1,
    IN  PVOID   SystemArgument2
    )

/*++

Routine Description:

    This routine is called when an allocate request times out.
    This routine cancels the current irp, unless it is being
    processed.

Arguments:

    Dpc             - Supplies the DPC.

    Extension       - Supplies the device extension.

    SystemArgument1 - Ignored.

    SystemArgument2 - Ignored.

Return Value:

    None.

--*/

{
    PDEVICE_EXTENSION   extension;
    KIRQL               oldIrql;
    LONG                irpRef;

    extension = Extension;

    extension->TimedOut = TRUE;

    // Try to cancel the IRP.

    IoCancelIrp(extension->CurrentIrp);

    KeAcquireSpinLock(&extension->ControlLock, &oldIrql);
    ASSERT(extension->CurrentIrpRefCount & IRP_REF_TIMER);
    irpRef = (extension->CurrentIrpRefCount -= IRP_REF_TIMER);
    KeReleaseSpinLock(&extension->ControlLock, oldIrql);

    if (!irpRef) {

        // Complete the request if the request was not completed
        // by the completion routine.

        ParCompleteRequest(extension);
    }
}

#endif

VOID
ParCancel(
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp
    )

/*++

Routine Description:

    This is the cancel routine for this driver.

Arguments:

    DeviceObject    - Supplies the device object.

    Irp             - Supplies the I/O request packet.

Return Value:

    None.

--*/

{
    RemoveEntryList(&Irp->Tail.Overlay.ListEntry);
    IoReleaseCancelSpinLock(Irp->CancelIrql);

    Irp->IoStatus.Information = 0;
    Irp->IoStatus.Status = STATUS_CANCELLED;

    IoCompleteRequest(Irp, IO_NO_INCREMENT);
}

NTSTATUS
ParCreateClose(
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp
    )

/*++

Routine Description:

    This routine is the dispatch for create requests.

Arguments:

    DeviceObject    - Supplies the device object.

    Irp             - Supplies the I/O request packet.

Return Value:

    STATUS_SUCCESS          - Success.
    STATUS_NOT_A_DIRECTORY  - This device is not a directory.

--*/

{
    PIO_STACK_LOCATION  irpSp;
    NTSTATUS            status;
    
    DbgPrint("We're in ParCreateClose\n");

    irpSp = IoGetCurrentIrpStackLocation(Irp);

    if (irpSp->MajorFunction == IRP_MJ_CREATE &&
        irpSp->Parameters.Create.Options & FILE_DIRECTORY_FILE) {

        status = STATUS_NOT_A_DIRECTORY;
    } else {
        status = STATUS_SUCCESS;
    }

    Irp->IoStatus.Status = status;
    Irp->IoStatus.Information = 0;
    IoCompleteRequest(Irp, IO_NO_INCREMENT);
    return status;
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
    
    DbgPrint("We're in ParReadCompletionRoutine\n");

    extension = Extension;    
    
           
    // TEST TEST TEST Here???
    // Make sure that interrupts are enabled on Controller:
    // Probleem is dat we in ParSetBit() READ_PORT_UCHAR en WRITE_PORT_UCHAR
    // hebben. Deze genereren IRP's dus kunnen we ParSetBit() nooit aanroepen
    // als we al in een IRP zitten. In ParReadCompletionRoutine() is dat niet
    // het geval: we komen hier net van een IRP_MJ_READ vandaan.
    // NO: doesn't work either: we can call ReadFile() in Load.exe and
    // ParBitSet() gets called, but when our device is generating interrupts
    // we immediately crash. Hell! 
    //ParSetBit(extension);
    

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

    ParCompleteRequest(extension);

    // If the IRP was completed.  It was completed with 'IoCompleteRequest'.

    return STATUS_MORE_PROCESSING_REQUIRED;
}

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
    
    DbgPrint("We're in ParAllocPort\n");

    nextSp = IoGetNextIrpStackLocation(Extension->CurrentIrp);
    nextSp->MajorFunction = IRP_MJ_INTERNAL_DEVICE_CONTROL;
    nextSp->Parameters.DeviceIoControl.IoControlCode =
            IOCTL_INTERNAL_PARALLEL_PORT_ALLOCATE;

    IoSetCompletionRoutine(Extension->CurrentIrp,
                           ParReadCompletionRoutine,
                           Extension, TRUE, TRUE, TRUE);


#ifdef TIMEOUT_ALLOCS

    Extension->TimedOut = FALSE;
    Extension->CurrentIrpRefCount = IRP_REF_TIMER + IRP_REF_COMPLETION_ROUTINE;
    KeSetTimer(&Extension->AllocTimer, Extension->AllocTimeout,
               &Extension->AllocTimerDpc);

#endif

    IoCallDriver(Extension->PortDeviceObject, Extension->CurrentIrp);
}

NTSTATUS
ParRead(
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp
    )

/*++

Routine Description:

    This routine is the dispatch for device control requests.

Arguments:

    DeviceObject    - Supplies the device object.

    Irp             - Supplies the I/O request packet.

Return Value:

    STATUS_PENDING  - Request pending.

--*/

{
    PDEVICE_EXTENSION   extension;
    KIRQL               cancelIrql;
    BOOLEAN             allocatePort;
    
    DbgPrint("We're in ParRead\n");

    extension = DeviceObject->DeviceExtension;

    IoAcquireCancelSpinLock(&cancelIrql);

    if (extension->CurrentIrp) {
        IoSetCancelRoutine(Irp, ParCancel);
        InsertTailList(&extension->WorkQueue, &Irp->Tail.Overlay.ListEntry);
        allocatePort = FALSE;
    } else {
        extension->CurrentIrp = Irp;
        allocatePort = TRUE;
    }

    IoReleaseCancelSpinLock(cancelIrql);

    IoMarkIrpPending(Irp);

    if (allocatePort) {
        ParAllocPort(extension);
    }

    return STATUS_PENDING;
}

NTSTATUS
ParCleanup(
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp
    )

/*++

Routine Description:

    This routine completes all IRPs on the work queue.

Arguments:

    DeviceObject    - Supplies the device object.

    Irp             - Supplies the I/O request packet.

Return Value:

    STATUS_SUCCESS

--*/

{
    PDEVICE_EXTENSION   extension;
    KIRQL               cancelIrql;
    PLIST_ENTRY         head;
    PIRP                irp;
    
    DbgPrint("We're in ParCleanup\n");

    extension = DeviceObject->DeviceExtension;

    IoAcquireCancelSpinLock(&cancelIrql);

    while (!IsListEmpty(&extension->WorkQueue)) {

        head = RemoveHeadList(&extension->WorkQueue);
        irp = CONTAINING_RECORD(head, IRP, Tail.Overlay.ListEntry);
        irp->Cancel = TRUE;
        irp->CancelIrql = cancelIrql;
        irp->CancelRoutine = NULL;
        ParCancel(DeviceObject, irp);

        IoAcquireCancelSpinLock(&cancelIrql);
    }

    IoReleaseCancelSpinLock(cancelIrql);

    Irp->IoStatus.Status = STATUS_SUCCESS;
    Irp->IoStatus.Information = 0;

    IoCompleteRequest(Irp, IO_NO_INCREMENT);

    return STATUS_SUCCESS;
}

VOID
ParUnload(
    IN  PDRIVER_OBJECT  DriverObject
    )

/*++

Routine Description:

    This routine loops through the device list and cleans up after
    each of the devices.

Arguments:

    DriverObject    - Supplies the driver object.

Return Value:

    None.

--*/

{
    PDEVICE_OBJECT                      currentDevice;
    PDEVICE_EXTENSION                   extension;
    KEVENT                              event;
    PARALLEL_INTERRUPT_SERVICE_ROUTINE  interruptService;
    PIRP                                irp;
    IO_STATUS_BLOCK                     ioStatus;
    
    DbgPrint("We're in ParUnload\n");

    while (currentDevice = DriverObject->DeviceObject) {

        extension = currentDevice->DeviceExtension;

        if (extension->CreatedSymbolicLink) {
            IoDeleteSymbolicLink(&extension->SymbolicLinkName);
            ExFreePool(extension->SymbolicLinkName.Buffer);
        }

#ifdef INTERRUPT_NEEDED

        KeInitializeEvent(&event, NotificationEvent, FALSE);
    
        interruptService.InterruptServiceRoutine = ParInterruptService;
        interruptService.InterruptServiceContext = extension;
        interruptService.DeferredPortCheckRoutine = ParDeferredPortCheck;
        interruptService.DeferredPortCheckContext = extension;
    
        irp = IoBuildDeviceIoControlRequest(IOCTL_INTERNAL_PARALLEL_DISCONNECT_INTERRUPT,
                                            extension->PortDeviceObject,
                                            &interruptService,
                                            sizeof(PARALLEL_INTERRUPT_SERVICE_ROUTINE),
                                            NULL, 0, TRUE, &event, &ioStatus);
    
        if (irp &&
            NT_SUCCESS(IoCallDriver(extension->PortDeviceObject, irp))) {

            KeWaitForSingleObject(&event, Executive, KernelMode, FALSE, NULL);
        }
        
#endif

        IoDeleteDevice(currentDevice);
    }
    
    DbgPrint("We're leaving ParUnload\n");
}




////////////////////////////////////////////////////////////////
NTSTATUS
ParDeviceControl( 
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp 
	)
{

	PDEVICE_EXTENSION   extension;
	PIO_STACK_LOCATION  irpSp;
    NTSTATUS            status;
	PVOID 				pOutBuffer;
	ULONG 				OutBufferLength;
	int 				Buffer[14];
	ULONG 				i;
	
	ULONG	EnableConnectInterruptIoctl;
	KIRQL   newIrql;
	KIRQL   oldIrql;
	
	
	// test
	//KdPrint(("We're in ParDeviceControl\n"));
	DbgPrint("We're in ParDeviceControl\n");

    

	// this macro checks if this code is pageable 
	PAGED_CODE();

	/////////////////////////////////////////////////
	// This is the buffer we give to the user-mode app
	// RetInfo[0]  == SyncPulse
	//
	// RetInfo[1]  == Ch1
	// RetInfo[2]  == Ch2
	// RetInfo[3]  == Ch3
	// RetInfo[4]  == Ch4
	// RetInfo[5]  == Ch5
	// RetInfo[6]  == Ch6
	// RetInfo[7]  == Ch7			
	// RetInfo[8]  == Ch8
	// RetInfo[9]  == Ch9
	// RetInfo[10] == Ch10
	//
	// RetInfo[11] == IntCount
	// RetInfo[12] == PulseLength
	// RetInfo[13] == ChannelCount
	/////////////////////////////////////////////////


	// Get Irp stack location
	irpSp = IoGetCurrentIrpStackLocation( Irp );
	
	// Get pointer to device extension
	extension = (PDEVICE_EXTENSION) DeviceObject->DeviceExtension;


	// Check I/O control code (do we have to?) Yes!!!
	// We must define a IOCTL using the CTL_CODE macro. 
	// CTL_CODE is defined in Wdm.h (for drivers) and in WinIoctl.h (for Win32 apps).
	// Define the IOCTL in the app and the driver, send it from the app to the driver
	// in the second param of DeviceIoControl() and then check for it here.
	// Make sure TransferType is METHOD_BUFFERED.
	//
	switch (irpSp->Parameters.DeviceIoControl.IoControlCode)
	{
	case IOCTL_TXINTPAR_READ:
	
		DbgPrint("We're in IOCTL_TXINTPAR_READ\n");	
		
		// NOTE:
		// Input buffer: Irp->AssociatedIrp.SystemBuffer 
		// Input buffer length: irpSp->Parameters.DeviceIoControl.InputBufferLength
		// Output buffer: Irp->UserBuffer????????
		// Output buffer length: irpSp->Parameters.DeviceIoControl.OutputBufferLength

		// Get pointer to the output buffer
		// It is Irp->UserBuffer!!! not Irp->AssociatedIrp.SystemBuffer!!!
		//pOutBuffer = Irp->AssociatedIrp.SystemBuffer;
		pOutBuffer = Irp->UserBuffer;

		// Get size of the output buffer
		OutBufferLength = irpSp->Parameters.DeviceIoControl.OutputBufferLength;


		// Test values
		// NOTE: must set extension->ChannelCount = 10 and extension->SyncPulse = 8000
		// or else Load.exe does not show the values!!!
//		extension->SyncPulse = 8000;
//		extension->Ch1 = 1300;
		//extension->Ch2 = 1400;
		//extension->Ch3 = 1500;
		//extension->Ch4 = 0;
		//extension->Ch5 = 0;
		//extension->Ch6 = 0;
		//extension->Ch7 = 0;		
		//extension->Ch8 = 0;
		//extension->Ch9 = 0;
		//extension->Ch10 = 0;
		//extension->IntCount = 7777;
		//extension->PulseLength = 1500;
//		extension->ChannelCount = 10;


		// Create a buffer
		//int Buffer[14];

		// Fill the buffer
		Buffer[0] = extension->SyncPulse;
		Buffer[1] = extension->Ch1;
		Buffer[2] = extension->Ch2;
		Buffer[3] = extension->Ch3;
		Buffer[4] = extension->Ch4;
		Buffer[5] = extension->Ch5;
		Buffer[6] = extension->Ch6;
		Buffer[7] = extension->Ch7;
		Buffer[8] = extension->Ch8;
		Buffer[9] = extension->Ch9;
		Buffer[10] = extension->Ch10;
		Buffer[11] = extension->IntCount;
		Buffer[12] = extension->PulseLength;
		Buffer[13] = extension->ChannelCount;

		// Move the buffer to the output buffer
		RtlCopyMemory( pOutBuffer, Buffer, sizeof(Buffer) );
		//memmove( pOutBuffer, Buffer, sizeof(Buffer) );
		//*pOutBuffer = 666; // illegal indirection because pOutBuffer is PVOID and VOID
							// is of unknown size, workaround: cast to PLONG
		//*((PLONG) pOutBuffer+4) = 1666;


		// This is necessary?
		Irp->IoStatus.Information = OutBufferLength;		
		break;

	
	case IOCTL_TXINTPAR_INIT:
				
		DbgPrint("We're in IOCTL_TXINTPAR_INIT\n");
		
			
		// TEST TEST TEST
		// Can we call ParSetBit() like this???
		// No: it seems like this Irp never gets completed
		// It is probably because Load.exe keeps polling the device
		// with DeviceIoControl() IRP's. 
	    //IoSetCompletionRoutine(Irp,
	    //                       ParSetBit,
	    //                       extension, TRUE, TRUE, TRUE);  
		
		
		// TEST TEST TEST Here???
		// Waarschijnlijk hebben we een IRP_MJ_WRITE nodig en 
		// moeten we een write IRP sturen naar het device vanuit
		// de driver. We krijgen namelijk een MULTIPLE_IRP_COMPLETE_REQUESTS
		// STOP error.
		//
    	// Make sure that interrupts are enabled on Controller:
    	//ParSetBit(extension);
    	//KeAcquireSpinLock(&extension->ControlLock, &oldIrql);
    	//KeRaiseIrql(&newIrql, &oldIrql);    
    	//   	
    	//KeSynchronizeExecution(extension->InterruptObject,
        //                   		ParSetBit,
        //                   		extension);
		//
		//KeLowerIrql(&newIrql);
		//KeReleaseSpinLock(&extension->ControlLock, oldIrql);
			 

/*   
	    // TEST TEST TEST Here???
	    // NO NOT HERE!!! If we write EnableConnectInterruptIoctl to the registry here
	    // the interrupt can't be connected at system start-up, so the device will not
	    // install, and Load.exe can't find the device.
	    // We can only do this here if we connect the interrupt after this point.
	    // Make sure that interrupts are enabled in Registry:
	    // ParSetValueKey()
	    EnableConnectInterruptIoctl = 1;
		ParSetValueKey( extension->PortDeviceObject, 
	                  (PWSTR)L"EnableConnectInterruptIoctl", 
	                  &EnableConnectInterruptIoctl );
*/                  

                  
/*		
#ifdef INTERRUPT_NEEDED

    // Ignore interrupts until we own the port.

    extension->IgnoreInterrupts = TRUE;


    // Connect the interrupt.

    IoInitializeDpcRequest(DeviceObject, ParDpcForIsr);
    status = ParInitializeInterruptObject(extension->DriverObject, extension);

    if (!NT_SUCCESS(status)) {
    	
    	DbgPrint("ParInitializeInterruptObject failed\n");

        ParLogError(extension->DriverObject, DeviceObject, extension->OriginalController,
                    PhysicalZero, 0, 0, 0, 6, STATUS_SUCCESS,
                    PAR_INTERRUPT_NOT_INITIALIZED);

        IoDeleteDevice(DeviceObject);
        //ExFreePool(linkName.Buffer);
        //goto Cleanup;
    }
   
#endif
*/
		break;
		
	case IOCTL_TXINTPAR_OPEN:
		break;
		
	case IOCTL_TXINTPAR_CLOSE:
		break;
		
	case IOCTL_TXINTPAR_FREE:
		break;
		
	case IOCTL_TXINTPAR_WRITE:
		break;
		
	}

	return STATUS_SUCCESS;
}



////////////////////////////////////////////////////////////////
//BOOLEAN
//ParSetBit(
//    IN PVOID Context
//    )
NTSTATUS
ParSetBit(
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp,
    IN  PVOID           Extension
    )
{
    PDEVICE_EXTENSION   extension;
    UCHAR               u;
    
    
    // Get pointer to device extension
	extension = Extension; //= Context;

    // Make sure that interrupts are turned on.

    u = READ_PORT_UCHAR(extension->Controller + 2);
    u |= 0x10;
    WRITE_PORT_UCHAR(extension->Controller + 2, u);
    
    // test: YES, there's the rub: we never get here, which means
    // this function never gets called, which means interrupts
    // will not be enabled
    extension->Ch5 = 1750;
	DbgPrint("We're in ParSetBit\n");
	
	//return TRUE;
	return STATUS_SUCCESS;
}


/////////////////////////////////////////////////////////////////////
// NOTE:
// We should call this function as follows:
// ULONG EnableConnectInterruptIoctl = 1;
// ParSetValueKey( Extension->PortDeviceObject, 
//                   (PWSTR)L"EnableConnectInterruptIoctl", 
//                   &EnableConnectInterruptIoctl );
// NOTE: Registry contains: Key Value Data
// We just have to create a Value: EnableConnectInterruptIoctl
// with Data: 1 under Key: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\
// Enum\Root\*PNP0400\PnPBIOS_10\Device Parameters
// We don't have to create a key!!!
/////////////////////////////////////////////////////////////////////
NTSTATUS
ParSetValueKey(
   	IN PDEVICE_OBJECT  PortDeviceObject,
    IN PWSTR           ParameterValue,
    IN PULONG          ParameterData
    )
{
	NTSTATUS            status;
    HANDLE              hKey;
    UNICODE_STRING      valueName;

	PDEVICE_OBJECT    	pdo;   
    IO_STACK_LOCATION 	request;
    ULONG_PTR         	info;
    
    
 
    
    // test
	DbgPrint("We're in ParSetValueKey\n");

    PAGED_CODE();
    
      
    // This code is taken from Parclass sample //////////////////////
    // It seems we can't just use PortDeviceObject in IoOpenDeviceRegistryKey()
    // but we must find the pdo by means of an IRP down the driver-stack to
    // the par port device. What a bore! 
    request.MajorFunction                        = IRP_MJ_PNP;
    request.MinorFunction                        = IRP_MN_QUERY_DEVICE_RELATIONS;
    request.Parameters.QueryDeviceRelations.Type = TargetDeviceRelation;

    status = MfSendPnpIrp(PortDeviceObject, &request, &info);
    if( !NT_SUCCESS(status) ) {
    	DbgPrint("MfSendPnpIrp failed\n");
        return status;
    }

    pdo = ((PDEVICE_RELATIONS)info)->Objects[0];
    ExFreePool((PVOID)info);

    if( !pdo ) {
        // NULL pdo?, bail out
        //return;
        DbgPrint("Got no pdo\n");
    }   
    /////////////////////////////////////////////////////////////////
    

    // Open key
    // NOTE: this opens HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\
	// Enum\Root\*PNP0400\PnPBIOS_10\Device Parameters
    status = IoOpenDeviceRegistryKey(pdo, PLUGPLAY_REGKEY_DEVICE, KEY_ALL_ACCESS, &hKey);    

    if( !NT_SUCCESS( status ) ) {
    	DbgPrint("openKey FAILED\n");
    	if (status==STATUS_INVALID_PARAMETER) 		DbgPrint("STATUS_INVALID_PARAMETER\n");
    	if (status==STATUS_INVALID_DEVICE_REQUEST)  DbgPrint("STATUS_INVALID_DEVICE_REQUEST\n");
        return status;
    }
    

	// Set key value
	RtlInitUnicodeString( &valueName, ParameterValue );	

    // NOTE: From the docs: ZwOpenKey or ZwCreateKey must be called before any of the 
    // Zw...Key routines that require an input KeyHandle. But it seems IoOpenDeviceRegistryKey()
    // is sufficient.
    // NOTE: This replaces or creates a value-data entry for a key in the registry
    status = ZwSetValueKey( hKey, &valueName, 0, REG_DWORD, ParameterData, sizeof(ULONG) );
    
    if( !NT_SUCCESS( status ) ) {
    	DbgPrint("setValue FAILED\n");
    }
    
	// Close key
    ZwClose(hKey);

    return status;
}



/////////////////////////////////////////////////////////////////////
NTSTATUS
MfSendPnpIrp(
    IN PDEVICE_OBJECT DeviceObject,
    IN PIO_STACK_LOCATION Location,
    OUT PULONG_PTR Information OPTIONAL
    )

/*++

Routine Description:

    This builds and send a pnp irp to a device.
    
Arguments:

    DeviceObject - The a device in the device stack the irp is to be sent to - 
        the top of the device stack is always found and the irp sent there first.
    
    Location - The initial stack location to use - contains the IRP minor code
        and any parameters
    
    Information - If provided contains the final value of the irps information
        field.

Return Value:

    The final status of the completed irp or an error if the irp couldn't be sent
    
--*/

{

    NTSTATUS status;                         
    PIRP irp = NULL;
    PIO_STACK_LOCATION irpStack;
    PDEVICE_OBJECT targetDevice = NULL;
    KEVENT irpCompleted;
    IO_STATUS_BLOCK statusBlock;
    
    ASSERT(Location->MajorFunction == IRP_MJ_PNP);

    //
    // Find out where we are sending the irp
    //
    
    targetDevice = IoGetAttachedDeviceReference(DeviceObject);

    //
    // Get an IRP
    //
    
    KeInitializeEvent(&irpCompleted, SynchronizationEvent, FALSE);

    irp = IoBuildSynchronousFsdRequest(IRP_MJ_PNP,
                                       targetDevice,
                                       NULL,    // Buffer
                                       0,       // Length
                                       0,       // StartingOffset
                                       &irpCompleted,
                                       &statusBlock
                                       );
    
    
    if (!irp) {
        goto cleanup;
    }
    
    irp->IoStatus.Status = STATUS_NOT_SUPPORTED;
    irp->IoStatus.Information = 0;
    
    //
    // Initialize the stack location
    //

    irpStack = IoGetNextIrpStackLocation(irp);
    
    ASSERT(irpStack->MajorFunction == IRP_MJ_PNP);

    irpStack->MinorFunction = Location->MinorFunction;
    irpStack->Parameters = Location->Parameters;
    
    //
    // Call the driver and wait for completion
    //

    status = IoCallDriver(targetDevice, irp);

    if (status == STATUS_PENDING) {
    
        KeWaitForSingleObject(&irpCompleted, Executive, KernelMode, FALSE, NULL);
        status = statusBlock.Status;
    }

    if (!NT_SUCCESS(status)) {
        goto cleanup;
    }

    //
    // Return the information
    //

    if (ARGUMENT_PRESENT(Information)) {
        *Information = statusBlock.Information;
    }

    ObDereferenceObject(targetDevice);
    
    ASSERT(status == STATUS_PENDING || status == statusBlock.Status);

    return statusBlock.Status;

cleanup:

    if (targetDevice) {
        ObDereferenceObject(targetDevice);
    }

    return status;
}