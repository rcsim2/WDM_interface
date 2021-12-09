// Declarations for TxintPar driver

#ifndef DRIVER_H
#define DRIVER_H

#include <parallel.h>

#define INTERRUPT_NEEDED    1

///////////////////////////////////////////////////////////////////////////////
// Device extension structure

typedef struct _DEVICE_EXTENSION {

	PDEVICE_OBJECT DeviceObject;			// device object this extension belongs to
	PDEVICE_OBJECT LowerDeviceObject;		// next lower driver in same stack
	PDEVICE_OBJECT Pdo;						// the PDO
	UNICODE_STRING devname;
	
    //
    // Points to the port device object that this class device is
    // connected to.
    //
    PDEVICE_OBJECT PortDeviceObject;


	// The parallel port interrupt object
	//PKINTERRUPT InterruptObject;
	PKSERVICE_ROUTINE ServiceRoutine;
	PVOID ServiceContext;
	//PKSPIN_LOCK SpinLock;
	ULONG Vector;
	KIRQL Irql;
	KIRQL SynchronizeIrql;
	KINTERRUPT_MODE InterruptMode;
	BOOLEAN ShareVector;
	KAFFINITY ProcessorEnableMask;
	BOOLEAN FloatingSave;


#ifdef INTERRUPT_NEEDED

    //
    // Set 'IgnoreInterrupts' to TRUE unless the port is owned by
    // this device.
    //

    BOOLEAN IgnoreInterrupts;
    PKINTERRUPT InterruptObject;

    //
    // Keep the interrupt level alloc and free routines.
    //

    PPARALLEL_TRY_ALLOCATE_ROUTINE TryAllocatePortAtInterruptLevel;
    PVOID TryAllocateContext;

#endif

	//
    // Work queue.  Manipulate with cancel spin lock.
    //
    LIST_ENTRY WorkQueue;
    PIRP CurrentIrp;

    //
    // This holds the result of the get parallel port info
    // request to the port driver.
    //
    PHYSICAL_ADDRESS OriginalController;
    PUCHAR Controller;
    ULONG SpanOfController;
    PPARALLEL_FREE_ROUTINE FreePort;
    PVOID FreePortContext;


	// Channel and interrupt variables
	int IntCount;
	int PrevIntTime;
	int GotIntTime;
	int PulseLength;
	int GotSync;
	int ChannelCount;
	int SyncPulse;
	int Ch1;
	int Ch2;
	int Ch3;
	int Ch4;
	int Ch5;
	int Ch6;
	int Ch7;
	int Ch8;
	int Ch9;
	int Ch10;

} DEVICE_EXTENSION, *PDEVICE_EXTENSION;



// I/O Control Codes
#define IOCTL_TXINTPAR_READ \
   CTL_CODE(FILE_DEVICE_UNKNOWN, 0x800, METHOD_BUFFERED, \
         FILE_READ_DATA | FILE_WRITE_DATA)






///////////////////////////////////////////////////////////////////////////////
// Global functions

NTSTATUS TxP_CompleteRequest( IN PIRP Irp, IN NTSTATUS status, IN ULONG_PTR info );
NTSTATUS TxP_OnRequestComplete( IN PDEVICE_OBJECT fdo, IN PIRP Irp, IN PKEVENT pev );

NTSTATUS TxP_ForwardAndWait( IN PDEVICE_OBJECT fdo, IN PIRP Irp );
NTSTATUS TxP_StartDevice( PDEVICE_OBJECT fdo, PCM_PARTIAL_RESOURCE_LIST raw, PCM_PARTIAL_RESOURCE_LIST translated );

NTSTATUS TxP_ConnectInterrupt( IN PDEVICE_EXTENSION pdx );
BOOLEAN TxP_InterruptService( IN PKINTERRUPT Interrupt, IN PVOID ServiceContext );


#ifdef INTERRUPT_NEEDED

BOOLEAN
ParInterruptService(
    IN      PKINTERRUPT Interrupt,
    IN OUT  PVOID       Extension
    );

VOID
ParDpcForIsr(
    IN  PKDPC           Dpc,
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp,
    IN  PVOID           Extension
    );

VOID
ParDeferredPortCheck(
    IN  PVOID   Extension
    );

#endif

VOID
ParAllocPort(
    IN  PDEVICE_EXTENSION   Extension
    );

VOID
ParAllocPortWithNext(
    IN OUT  PDEVICE_EXTENSION   Extension
    );

NTSTATUS
ParReadCompletionRoutine(
    IN  PDEVICE_OBJECT  DeviceObject,
    IN  PIRP            Irp,
    IN  PVOID           Extension
    );

VOID
ParCompleteRequest(
    IN  PDEVICE_EXTENSION   Extension
    );


// I/O request handlers

NTSTATUS TxintPar_AddDevice(IN PDRIVER_OBJECT DriverObject, IN PDEVICE_OBJECT pdo);
VOID TxintPar_DriverUnload(IN PDRIVER_OBJECT fdo);

NTSTATUS TxintPar_DispatchPnp( PDEVICE_OBJECT fdo, PIRP Irp );
NTSTATUS TxintPar_DispatchPower( PDEVICE_OBJECT fdo, PIRP Irp );
NTSTATUS TxintPar_DispatchSystemControl( PDEVICE_OBJECT fdo, PIRP Irp );
NTSTATUS TxintPar_DispatchCreate( PDEVICE_OBJECT fdo, PIRP Irp );
NTSTATUS TxintPar_DispatchDeviceControl( PDEVICE_OBJECT fdo, PIRP Irp );
NTSTATUS TxintPar_DispatchInternalDeviceControl( PDEVICE_OBJECT fdo, PIRP Irp );


#endif // DRIVER_H
