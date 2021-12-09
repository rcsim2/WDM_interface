// Main program for TxintUsb driver

#include "stddcls.h"
#include "driver.h"

NTSTATUS AddDevice(IN PDRIVER_OBJECT DriverObject, IN PDEVICE_OBJECT pdo);
VOID DriverUnload(IN PDRIVER_OBJECT fdo);
NTSTATUS OnRequestComplete(IN PDEVICE_OBJECT fdo, IN PIRP Irp, IN PKEVENT pev);

///////////////////////////////////////////////////////////////////////////////

#pragma INITCODE

extern "C" NTSTATUS DriverEntry(IN PDRIVER_OBJECT DriverObject,
	IN PUNICODE_STRING RegistryPath)
{							// DriverEntry
	
	DriverObject->DriverExtension->AddDevice = AddDevice;
	DriverObject->DriverUnload = DriverUnload;

	DriverObject->MajorFunction[IRP_MJ_PNP] = DispatchPnp;
	DriverObject->MajorFunction[IRP_MJ_POWER] = DispatchPower;
	DriverObject->MajorFunction[IRP_MJ_SYSTEM_CONTROL] = DispatchWmi;
	
	
	return STATUS_SUCCESS;
}							// DriverEntry

///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

VOID DriverUnload(IN PDRIVER_OBJECT DriverObject)
{							// DriverUnload
	PAGED_CODE();
}							// DriverUnload

///////////////////////////////////////////////////////////////////////////////

NTSTATUS AddDevice(IN PDRIVER_OBJECT DriverObject, IN PDEVICE_OBJECT pdo)
{							// AddDevice
	PAGED_CODE();

	NTSTATUS status;

	// Create a functional device object to represent the hardware we're managing.

	PDEVICE_OBJECT fdo;
	
	UNICODE_STRING devname;
	WCHAR namebuf[32];
	static LONG devcount = -1;
	_snwprintf(namebuf, arraysize(namebuf), L"\\Device\\TxintUsb_%d", InterlockedIncrement(&devcount));
	RtlInitUnicodeString(&devname, namebuf);

	status = IoCreateDevice(DriverObject, sizeof(DEVICE_EXTENSION), &devname,
		FILE_DEVICE_UNKNOWN, 0, FALSE, &fdo);
	if (!NT_SUCCESS(status))
	{						// can't create device object
		KdPrint(("TxintUsb - "
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
			KdPrint(("TxintUsb - "
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
}							// AddDevice

///////////////////////////////////////////////////////////////////////////////

#pragma LOCKEDCODE

NTSTATUS CompleteRequest(IN PIRP Irp, IN NTSTATUS status, IN ULONG_PTR info)
{							// CompleteRequest
	Irp->IoStatus.Status = status;
	Irp->IoStatus.Information = info;
	IoCompleteRequest(Irp, IO_NO_INCREMENT);
	return status;
}							// CompleteRequest

///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS ForwardAndWait(IN PDEVICE_OBJECT fdo, IN PIRP Irp)
{							// ForwardAndWait
	ASSERT(KeGetCurrentIrql() == PASSIVE_LEVEL);
	PAGED_CODE();
	
	KEVENT event;
	KeInitializeEvent(&event, NotificationEvent, FALSE);

	IoCopyCurrentIrpStackLocationToNext(Irp);
	IoSetCompletionRoutine(Irp, (PIO_COMPLETION_ROUTINE) OnRequestComplete,
		(PVOID) &event, TRUE, TRUE, TRUE);

	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;
	IoCallDriver(pdx->LowerDeviceObject, Irp);
	KeWaitForSingleObject(&event, Executive, KernelMode, FALSE, NULL);
	return Irp->IoStatus.Status;
}							// ForwardAndWait

///////////////////////////////////////////////////////////////////////////////

#pragma LOCKEDCODE

NTSTATUS OnRequestComplete(IN PDEVICE_OBJECT fdo, IN PIRP Irp, IN PKEVENT pev)
{							// OnRequestComplete
	KeSetEvent(pev, 0, FALSE);
	return STATUS_MORE_PROCESSING_REQUIRED;
}							// OnRequestComplete

///////////////////////////////////////////////////////////////////////////////

#pragma LOCKEDCODE

extern "C" void __declspec(naked) __cdecl _chkesp()
{
	_asm je okay
	ASSERT(!"Stack pointer mismatch!");
okay:
	_asm ret
}
