// Main program for TxintPar driver

#include "stddcls.h"
#include "driver.h"

NTSTATUS TxintPar_AddDevice(IN PDRIVER_OBJECT DriverObject, IN PDEVICE_OBJECT pdo);
VOID TxintPar_DriverUnload(IN PDRIVER_OBJECT fdo);

NTSTATUS TxP_OnRequestComplete(IN PDEVICE_OBJECT fdo, IN PIRP Irp, IN PKEVENT pev);

///////////////////////////////////////////////////////////////////////////////

#pragma INITCODE

extern "C" NTSTATUS DriverEntry( IN PDRIVER_OBJECT DriverObject,
	IN PUNICODE_STRING RegistryPath )
{							// DriverEntry
	
	DriverObject->DriverExtension->AddDevice = TxintPar_AddDevice;
	DriverObject->DriverUnload = TxintPar_DriverUnload;

	DriverObject->MajorFunction[IRP_MJ_PNP]			   = TxintPar_DispatchPnp;
	DriverObject->MajorFunction[IRP_MJ_POWER]		   = TxintPar_DispatchPower;
	DriverObject->MajorFunction[IRP_MJ_SYSTEM_CONTROL] = TxintPar_DispatchSystemControl; // 
	
	
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

	// Create a functional device object to represent the hardware we're managing.

	PDEVICE_OBJECT fdo;
	
	UNICODE_STRING devname;
	WCHAR namebuf[32];
	static LONG devcount = -1;
	_snwprintf(namebuf, arraysize(namebuf), L"\\Device\\TxintPar_%d", InterlockedIncrement(&devcount));
	RtlInitUnicodeString(&devname, namebuf);

	status = IoCreateDevice(DriverObject, sizeof(DEVICE_EXTENSION), &devname,
		FILE_DEVICE_UNKNOWN, 0, FALSE, &fdo);
	if (!NT_SUCCESS(status))
	{						// can't create device object
		KdPrint(("TxintPar - "
			"IoCreateDevice failed - %X\n", status));
		return status;
	}						// can't create device object
	
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	// From this point forward, any error will have side effects that need to
	// be cleaned up. Using a try-finally block allows us to modify the program
	// easily without losing track of the side effects.

	__try
	{						// finish initialization
		pdx->DeviceObject = fdo;
		pdx->Pdo = pdo;

		// Make a copy of the device name

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
