// Main program for TxintPar driver
// NOTE: #include sequence is crucial!!! See:
// 1.6.2 Including GUIDs in Driver Code

#include "stddcls.h"
#include "driver.h"

#include <initguid.h>
#include <devguid.h>

#include "guid.h"


// Dummy to make DEVICE_EXTENSION struct show in Class View
_DEVICE_EXTENSION pdxDummy;


///////////////////////////////////////////////////////////////////////////////

#pragma INITCODE

extern "C" NTSTATUS DriverEntry( IN PDRIVER_OBJECT DriverObject,
	IN PUNICODE_STRING RegistryPath )
{							// DriverEntry
	
	DriverObject->DriverExtension->AddDevice = TxintPar_AddDevice;
	DriverObject->DriverUnload				 = TxintPar_DriverUnload;

	DriverObject->MajorFunction[IRP_MJ_PNP]			   = TxintPar_DispatchPnp;
	DriverObject->MajorFunction[IRP_MJ_POWER]		   = TxintPar_DispatchPower;
	DriverObject->MajorFunction[IRP_MJ_SYSTEM_CONTROL] = TxintPar_DispatchSystemControl;
	DriverObject->MajorFunction[IRP_MJ_CREATE]		   = TxintPar_DispatchCreate;
	
	// User-mode DeviceIoControl() calls will be routed here
    DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL] = TxintPar_DispatchDeviceControl;
	
	// Internal device control requests will be routed here
	// No: we don't need this, we should do this *to* parclass
	//DriverObject->MajorFunction[IRP_MJ_INTERNAL_DEVICE_CONTROL] = TxintPar_DispatchInternalDeviceControl;
	
	return STATUS_SUCCESS;
}							// DriverEntry

///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

VOID TxintPar_DriverUnload( IN PDRIVER_OBJECT DriverObject )
{							// TxintPar_DriverUnload
	PAGED_CODE();
}							// TxintPar_DriverUnload



///////////////////////////////////////////////////////////////////////////////

NTSTATUS TxintPar_AddDevice( IN PDRIVER_OBJECT DriverObject, IN PDEVICE_OBJECT pdo )
{							// TxintPar_AddDevice
	PAGED_CODE();

	NTSTATUS status;

	//////////////////////////////////////////////////////////
	// Create a functional device object to represent the hardware we're managing.
	PDEVICE_OBJECT fdo;
	
	// This is not done in WDM drivers
	UNICODE_STRING devname;
	UNICODE_STRING symlinkname;
	WCHAR namebuf[32];
	static LONG devcount = -1;
	_snwprintf(namebuf, arraysize(namebuf), L"\\Device\\TxintPar%d", InterlockedIncrement(&devcount));
	//RtlInitUnicodeString(&devname, namebuf);
	RtlInitUnicodeString(&devname, L"\\Device\\TxintPar");
	RtlInitUnicodeString(&symlinkname, L"\\DosDevices\\TxintPar");

	// NOTE: TxintPar0 is the name that will be used in CreateFile() in the user-mode app
	// NO: there should be no name for PnP drivers!!!
	//
	// A Windows 2000 or WDM driver does not name its device objects. Instead, when the driver
	// calls IoCreateDevice to create a device object, it should specify a NULL string for the
	// device name. Bus drivers should set the FILE_AUTOGENERATED_DEVICE_NAME flag. All PnP 
	// function, filter, and bus drivers should set the FILE_DEVICE_SECURE_OPEN flag. In 
	// response, the system chooses a unique device name for the PDO.
	//
	// In the user-mode app use:
	// SetupDiGetClassDevs()
	// SetupDiEnumDeviceInterfaces()
	// SetupDiGetDeviceInterfaceDetail()
	// to get symbolic link name.
	//
	// DeviceInterfaceData points to a structure that identifies a requested device interface.
	// To get detailed information about an interface, call SetupDiGetDeviceInterfaceDetail. 
	// The detailed information includes the name of the device interface that can be passed
	// to a Win32� function such as CreateFile to get a handle to the interface.
	//
	//
	// Create the functional device object
	//status = IoCreateDevice(DriverObject, sizeof(DEVICE_EXTENSION), &devname,
	//	FILE_DEVICE_UNKNOWN, 0, FALSE, &fdo);
	//
	// Should make FILE_DEVICE_PARALLEL_PORT (see: parsimp)
	status = IoCreateDevice(DriverObject, sizeof(DEVICE_EXTENSION), &devname,
		FILE_DEVICE_PARALLEL_PORT, 0, FALSE, &fdo);


	if (!NT_SUCCESS(status))
	{						// can't create device object
		KdPrint(("TxintPar - "
			"IoCreateDevice failed - %X\n", status));
		return status;
	}						// can't create device object


	// Now that the device has been created,
    // set up the device extension.
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;
	RtlZeroMemory(pdx, sizeof(DEVICE_EXTENSION));


    //ObDereferenceObject(fileObject);

    //extension->DeviceObject->StackSize =
    //        extension->PortDeviceObject->StackSize + 1;


    // Initialize an empty work queue.
    InitializeListHead(&pdx->WorkQueue);
    pdx->CurrentIrp = NULL;


	
	// This is not done by PnP drivers, use IoRegisterDeviceInterface() instead
	status = IoCreateSymbolicLink( &symlinkname, &devname );

	
	/*/////////////////////////////////////////////////////////////
	// Now we have to register the device interface to make sure CreateFile() can find 
	// the symbolic name
	UNICODE_STRING SymbolicLinkName;
	RtlInitUnicodeString(&SymbolicLinkName, NULL);

	status = IoRegisterDeviceInterface( pdo,
										&GUID_DEVCLASS_MEDIA,
										NULL,
										&SymbolicLinkName );

	if (!NT_SUCCESS(status))
	{						// can't register device interface
		KdPrint(("TxintPar - "
			"IoRegisterDeviceInterface failed - %X\n", status));
		return status;
	}						// can't register device interface
	//////////////////////////////////////////////////////////////*/


	/*/////////////////////////////////////////////////////////////
	// Now we still have to enable the device interface
	// NOTE: we do this in response to an IRP_MN_START_DEVICE because
	// TxP_StartDevice gets called on IRP_MN_START_DEVICE
	status = IoSetDeviceInterfaceState( &SymbolicLinkName,
										TRUE );

	if (!NT_SUCCESS(status))
	{						// can't enable device interface
		KdPrint(("TxintPar - "
			"IoSetDeviceInterfaceState failed - %X\n", status));
		return status;
	}						// can't enable device interface
	//////////////////////////////////////////////////////////////*/


	// RtlFreeUnicodeString(&SymbolicLinkName);


	
	// From this point forward, any error will have side effects that need to
	// be cleaned up. Using a try-finally block allows us to modify the program
	// easily without losing track of the side effects.

	__try
	{						// finish initialization
		pdx->DeviceObject = fdo;
		pdx->Pdo = pdo;

		// Make a copy of the device name
		// Should we do this with the SymbolicLinkName instead?
		pdx->devname.Buffer = (PWCHAR) ExAllocatePool(NonPagedPool, devname.MaximumLength);
		if (!pdx->devname.Buffer)
		{					// can't allocate buffer
			status = STATUS_INSUFFICIENT_RESOURCES;
			KdPrint(("TxintPar - "
				"Unable to allocate %d bytes for copy of name\n", devname.MaximumLength));
			__leave;
		}					// can't allocate buffer
		pdx->devname.MaximumLength = devname.MaximumLength;
		RtlCopyUnicodeString(&pdx->devname, &devname);

		fdo->Flags |= DO_POWER_PAGABLE;

		// Attach device to device stack
		pdx->LowerDeviceObject = IoAttachDeviceToDeviceStack(fdo, pdo);
		fdo->Flags &= ~DO_DEVICE_INITIALIZING;
	}						// finish initialization
	__finally
	{						// cleanup side effects
		if (!NT_SUCCESS(status))
		{					// need to cleanup
			if (pdx->devname.Buffer)
				RtlFreeUnicodeString(&pdx->devname);
			IoDeleteDevice(fdo);
		}					// need to cleanup
	}						// cleanup side effects

	return STATUS_SUCCESS;
}							// TxintPar_AddDevice



///////////////////////////////////////////////////////////////////////////////

#pragma LOCKEDCODE

NTSTATUS TxP_CompleteRequest(IN PIRP Irp, IN NTSTATUS status, IN ULONG_PTR info)
{							// TxP_CompleteRequest
	Irp->IoStatus.Status = status;
	Irp->IoStatus.Information = info;
	IoCompleteRequest(Irp, IO_NO_INCREMENT);
	return status;
}							// TxP_CompleteRequest

///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS TxP_ForwardAndWait( IN PDEVICE_OBJECT fdo, IN PIRP Irp )
{							// TxP_ForwardAndWait
	ASSERT(KeGetCurrentIrql() == PASSIVE_LEVEL);
	PAGED_CODE();
	
	KEVENT event;
	KeInitializeEvent(&event, NotificationEvent, FALSE);

	IoCopyCurrentIrpStackLocationToNext(Irp);
	IoSetCompletionRoutine(Irp, (PIO_COMPLETION_ROUTINE) TxP_OnRequestComplete,
		(PVOID) &event, TRUE, TRUE, TRUE);

	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;
	IoCallDriver(pdx->LowerDeviceObject, Irp);
	KeWaitForSingleObject(&event, Executive, KernelMode, FALSE, NULL);
	return Irp->IoStatus.Status;
}							// TxP_ForwardAndWait

///////////////////////////////////////////////////////////////////////////////

#pragma LOCKEDCODE

NTSTATUS TxP_OnRequestComplete( IN PDEVICE_OBJECT fdo, IN PIRP Irp, IN PKEVENT pev )
{							// TxP_OnRequestComplete
	KeSetEvent(pev, 0, FALSE);
	return STATUS_MORE_PROCESSING_REQUIRED;
}							// TxP_OnRequestComplete

///////////////////////////////////////////////////////////////////////////////

#pragma LOCKEDCODE

extern "C" void __declspec(naked) __cdecl _chkesp()
{
	_asm je okay
	ASSERT(!"Stack pointer mismatch!");
okay:
	_asm ret
}
