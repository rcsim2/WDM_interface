// Declarations for TxintUsb driver

#ifndef DRIVER_H
#define DRIVER_H

///////////////////////////////////////////////////////////////////////////////
// Device extension structure

typedef struct tagDEVICE_EXTENSION {
	PDEVICE_OBJECT DeviceObject;			// device object this extension belongs to
	PDEVICE_OBJECT LowerDeviceObject;		// next lower driver in same stack
	PDEVICE_OBJECT Pdo;						// the PDO
	UNICODE_STRING devname;
} DEVICE_EXTENSION, *PDEVICE_EXTENSION;

///////////////////////////////////////////////////////////////////////////////
// Global functions

NTSTATUS CompleteRequest(IN PIRP Irp, IN NTSTATUS status, IN ULONG_PTR info);
NTSTATUS ForwardAndWait(IN PDEVICE_OBJECT fdo, IN PIRP Irp);
NTSTATUS StartDevice(PDEVICE_OBJECT fdo, PCM_PARTIAL_RESOURCE_LIST raw, PCM_PARTIAL_RESOURCE_LIST translated);

// I/O request handlers

NTSTATUS DispatchPower(PDEVICE_OBJECT fdo, PIRP Irp);
NTSTATUS DispatchWmi(PDEVICE_OBJECT fdo, PIRP Irp);
NTSTATUS DispatchPnp(PDEVICE_OBJECT fdo, PIRP Irp);

#endif // DRIVER_H
