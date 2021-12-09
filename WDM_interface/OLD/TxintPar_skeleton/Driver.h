// Declarations for TxintPar driver

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

NTSTATUS TxP_CompleteRequest(IN PIRP Irp, IN NTSTATUS status, IN ULONG_PTR info);
NTSTATUS TxP_ForwardAndWait(IN PDEVICE_OBJECT fdo, IN PIRP Irp);
NTSTATUS TxP_StartDevice(PDEVICE_OBJECT fdo, PCM_PARTIAL_RESOURCE_LIST raw, PCM_PARTIAL_RESOURCE_LIST translated);

// I/O request handlers

NTSTATUS TxintPar_DispatchPower(PDEVICE_OBJECT fdo, PIRP Irp);
NTSTATUS TxintPar_DispatchWmi(PDEVICE_OBJECT fdo, PIRP Irp);
NTSTATUS TxintPar_DispatchPnp(PDEVICE_OBJECT fdo, PIRP Irp);

#endif // DRIVER_H
