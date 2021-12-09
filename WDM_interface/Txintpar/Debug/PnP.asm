	TITLE	E:\WDM_interface\Txintpar\PnP.cpp
	.386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
_BSS	SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS	ENDS
$$SYMBOLS	SEGMENT BYTE USE32 'DEBSYM'
$$SYMBOLS	ENDS
$$TYPES	SEGMENT BYTE USE32 'DEBTYP'
$$TYPES	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
;	COMDAT ??_C@_0BD@NLMG@e?3?2NTDDK?2inc?2wdm?4h?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BN@IHIP@allocateCommonBuffer?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BJ@FPNP@freeCommonBuffer?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BP@OCPD@allocateAdapterChannel?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BM@MGEC@flushAdapterBuffers?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BL@HGFH@freeAdapterChannel?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BJ@BLDF@freeMapRegisters?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BE@CIAH@mapTransfer?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BI@MFGJ@getDmaAlignment?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT ??_C@_0BH@HIMN@readDmaCounter?5?$CB?$DN?5NULL?$AA@
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT _IsEqualGUID@8
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _==@8
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?TxintPar_DispatchPnp@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParSetTrue@@YGEPAX@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParDpcForIsr@@YGXPAU_KDPC@@PAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParInterruptService@@YGEPAU_KINTERRUPT@@PAX@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParDeferredPortCheck@@YGXPAX@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParSetFalse@@YGEPAX@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParAllocPort@@YGXPAU_DEVICE_EXTENSION@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParAllocPortWithNext@@YGXPAU_DEVICE_EXTENSION@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParReadCompletionRoutine@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?ParCompleteRequest@@YGXPAU_DEVICE_EXTENSION@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
_DATA	SEGMENT
_ModeQualifier$S8250 DB 0aaH
	DB	055H
	DB	00H
	DB	0ffH
	DB	087H
	DB	078H
	DB	0ffH
	ORG $+1
_LegacyZipModeQualifier$S8252 DB 00H
	DB	03cH
	DB	020H
_DATA	ENDS
PUBLIC	?ParInterruptService@@YGEPAU_KINTERRUPT@@PAX@Z	; ParInterruptService
PUBLIC	?ParDpcForIsr@@YGXPAU_KDPC@@PAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z ; ParDpcForIsr
PUBLIC	?ParDeferredPortCheck@@YGXPAX@Z			; ParDeferredPortCheck
PUBLIC	?TxintPar_DispatchPnp@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchPnp
EXTRN	__imp__IoBuildDeviceIoControlRequest@36:NEAR
EXTRN	?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z:NEAR	; TxP_CompleteRequest
EXTRN	__imp_@IofCallDriver@8:NEAR
EXTRN	?TxP_ForwardAndWait@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z:NEAR ; TxP_ForwardAndWait
EXTRN	__imp__IoGetDeviceObjectPointer@16:NEAR
EXTRN	__imp__RtlAssert@16:NEAR
EXTRN	__imp__KeInitializeDpc@12:NEAR
EXTRN	__imp__RtlInitUnicodeString@8:NEAR
EXTRN	__imp__KeInitializeEvent@12:NEAR
EXTRN	__imp__KeGetCurrentIrql@0:NEAR
EXTRN	_DbgPrint:NEAR
EXTRN	__imp__KeWaitForSingleObject@20:NEAR
;	COMDAT ?TxintPar_DispatchPnp@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
; File E:\WDM_interface\Txintpar\PnP.cpp
page	SEGMENT
$SG8754	DB	'EX: Pageable code called at IRQL %d', 0aH, 00H
	ORG $+3
$SG8756	DB	'E:\WDM_interface\Txintpar\PnP.cpp', 00H
	ORG $+2
$SG8757	DB	'FALSE', 00H
	ORG $+2
$SG8781	DB	'\', 00H, 'D', 00H, 'e', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, '\', 00H, 'P', 00H, 'a', 00H, 'r', 00H, 'a', 00H, 'l'
	DB	00H, 'l', 00H, 'e', 00H, 'l', 00H, 'P', 00H, 'o', 00H, 'r', 00H
	DB	't', 00H, '0', 00H, 00H, 00H
$SG8785	DB	'E:\WDM_interface\Txintpar\PnP.cpp', 00H
	ORG $+2
$SG8786	DB	'PortIrp->StackCount > 0', 00H
_fdo$ = 8
_Irp$ = 12
_stack$ = -76
_fcn$ = -36
_pdx$ = -72
_PortDeviceObjectName$ = -44
_PortFileObject$ = -88
_PortDeviceObject$ = -80
_PortIrp$ = -84
_Event$ = -32
_IoStatus$ = -68
_ParIsr$ = -60
_ParInterruptInfo$ = -16
_status$8777 = -92
?TxintPar_DispatchPnp@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z PROC NEAR ; TxintPar_DispatchPnp, COMDAT

; 13   : {							// TxintPar_DispatchPnp

	push	ebp
	mov	ebp, esp
	sub	esp, 96					; 00000060H

; 14   : 	PAGED_CODE();

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	cmp	eax, 1
	jle	SHORT $L8753
	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	push	eax
	push	OFFSET FLAT:$SG8754
	call	_DbgPrint
	add	esp, 8
	mov	eax, 1
	test	eax, eax
	je	SHORT $L8755
	push	0
	push	14					; 0000000eH
	push	OFFSET FLAT:$SG8756
	push	OFFSET FLAT:$SG8757
	call	DWORD PTR __imp__RtlAssert@16
$L8755:
$L8753:

; 15   : 
; 16   : 	PIO_STACK_LOCATION stack = IoGetCurrentIrpStackLocation(Irp);

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR [ecx+96]
	mov	DWORD PTR _stack$[ebp], edx

; 17   : 	ULONG fcn = stack->MinorFunction;

	mov	eax, DWORD PTR _stack$[ebp]
	xor	ecx, ecx
	mov	cl, BYTE PTR [eax+1]
	mov	DWORD PTR _fcn$[ebp], ecx

; 18   : 	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	mov	edx, DWORD PTR _fdo$[ebp]
	mov	eax, DWORD PTR [edx+40]
	mov	DWORD PTR _pdx$[ebp], eax

; 19   : 
; 20   : 	// parallel stuff
; 21   : 	UNICODE_STRING PortDeviceObjectName;
; 22   : 	//RtlInitUnicodeString(&PortDevName, L"\\Device\\LPT1");
; 23   : 	PFILE_OBJECT PortFileObject;
; 24   : 	PDEVICE_OBJECT PortDeviceObject;
; 25   : 	PIRP PortIrp;
; 26   : 	KEVENT Event;
; 27   : 	IO_STATUS_BLOCK IoStatus;
; 28   : 	PARALLEL_INTERRUPT_SERVICE_ROUTINE ParIsr;
; 29   : 	PARALLEL_INTERRUPT_INFORMATION ParInterruptInfo;
; 30   : 
; 31   : 
; 32   : 	switch (fcn)

	mov	ecx, DWORD PTR _fcn$[ebp]
	mov	DWORD PTR -96+[ebp], ecx
	cmp	DWORD PTR -96+[ebp], 0
	je	SHORT $L8776
	cmp	DWORD PTR -96+[ebp], 1
	je	$L8796
	cmp	DWORD PTR -96+[ebp], 5
	je	$L8796
	jmp	$L8798
$L8776:

; 36   : 			
; 37   : 			NTSTATUS status = TxP_ForwardAndWait(fdo, Irp);

	mov	edx, DWORD PTR _Irp$[ebp]
	push	edx
	mov	eax, DWORD PTR _fdo$[ebp]
	push	eax
	call	?TxP_ForwardAndWait@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxP_ForwardAndWait
	mov	DWORD PTR _status$8777[ebp], eax

; 38   : 			if (!NT_SUCCESS(status)) {

	cmp	DWORD PTR _status$8777[ebp], 0
	jge	SHORT $L8779

; 39   : 				return TxP_CompleteRequest(Irp, status, Irp->IoStatus.Information);

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR [ecx+28]
	push	edx
	mov	eax, DWORD PTR _status$8777[ebp]
	push	eax
	mov	ecx, DWORD PTR _Irp$[ebp]
	push	ecx
	call	?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z	; TxP_CompleteRequest
	jmp	$L8752
$L8779:

; 41   : 
; 42   : 			// TODO: we must have a CM_RESOURCE_LIST with I/O Port and IRQ resources
; 43   : 			// PnP devices build these on basis of .INF file
; 44   : 			// But the list does not seem to get build when we specify I/O Port and IRQ
; 45   : 			// in the INF...
; 46   : 			// Where in the reg are the res lists??? Should we just build one ourselves???
; 47   : 			//
; 48   : 			// Win2K and WinXP do not allow us to just access the IRQ and I/O port that the
; 49   : 			// par port already possesses. We should write a parclass driver and then supply
; 50   : 			// an ISR. (Note: interrupts on the par port are disabled by default on Win2K.
; 51   : 			// Make sure they are enabled!).
; 52   : 			// When we have a parclass device it will use the resources that the par port
; 53   : 			// uses and find them here??
; 54   : 			// We should use IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT instead of
; 55   : 			// IoConnectInterrupt().
; 56   : 			// devguid.h: Defines GUIDs for device classes used in Plug & Play. We should use
; 57   : 			// GUID_DEVCLASS_PORTS in the INF.
; 58   : 			// The IOCTL_INTERNAL_PARCLASS_CONNECT request returns information about the 
; 59   : 			// parallel port and the callback routines that Parclass provides. Typically,
; 60   : 			// a client first uses a connect request to obtain connect information, and then
; 61   : 			// uses a lock port request to allocate exclusive use of the parallel port for a 
; 62   : 			// parallel device. Parclass does not queue this request.
; 63   : 			//
; 64   : 			// If we define GUID_DEVCLASS_PORTS in the INF will we get the resources we want???
; 65   : 			// 
; 66   : 			// The connect interrupt request is enabled by the registry entry value 
; 67   : 			// EnableConnectInterruptIoctl under the Plug and Play registry key for the 
; 68   : 			// parallel port device. The type of the entry value is REG_DWORD and the default
; 69   : 			// value is 0x0 (disabled). 
; 70   : 			// We must change this reg value in order to enable interrupts on the par port.
; 71   : 			// The par port will then catch interrupts from our Tx interface device???
; 72   : 			//
; 73   : 			// Parport maintains a list of the ISRs that are connected to a parallel port.
; 74   : 			// Parport calls all the connected ISRs after an interrupt on the parallel port.
; 75   : 			//
; 76   : 			// We must set the PnP registry entry value EnableConnectInterruptIoctl to 0x1
; 77   : 			// We must request parport: IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT, IOCTL_INTERNAL_GET_MORE_PARALLEL_PORT_INFO
; 78   : 			// We must request parclass: IOCTL_INTERNAL_PARCLASS_CONNECT, IOCTL_INTERNAL_LOCK_PORT
; 79   : 			// (In de VxD hebben we een lock vergeten: dit zorgt voor onstabiele waardes als
; 80   : 			// andere drivers de poort aanspreken)
; 81   : 
; 82   : 
; 83   : 
; 84   : 
; 85   : 			// Use these functions to send IOCTLs (IRPs) to parport and parclass:
; 86   : 			//
; 87   : 			// NTSTATUS 
; 88   : 			//   IoGetDeviceObjectPointer(
; 89   : 			//   IN PUNICODE_STRING  ObjectName,
; 90   : 			//   IN ACCESS_MASK  DesiredAccess,
; 91   : 			//   OUT PFILE_OBJECT  *FileObject,
; 92   : 			//   OUT PDEVICE_OBJECT  *DeviceObject
; 93   : 			//   );
; 94   : 			// 
; 95   : 			// Irp = IoBuildDeviceIoControlRequest(IOCTL_INTERNAL_GET_PARALLEL_PORT_INFO,
; 96   : 			//                                         Extension->PortDeviceObject,
; 97   : 			//                                         NULL, 
; 98   : 			//                                         0, 
; 99   : 			//                                         &PortInfo,
; 100  : 			//                                         sizeof(PARALLEL_PORT_INFORMATION),
; 101  : 			//                                         TRUE, 
; 102  : 			//                                         &Event, 
; 103  : 			//                                         &IoStatus);
; 104  : 			// 
; 105  : 			// IoCallDriver(DeviceObject, Irp);
; 106  : 
; 107  : 			////////////////////////////////////////////////////////////////////////////
; 108  : 			// Let's connect an ISR to the parallel port
; 109  : 			// Should do this in DriverEntry(). (But can also do it here).
; 110  : 			// If a class driver wishes to use the parallel port's interrupt then
; 111  : 			// it should connect to this interrupt by calling
; 112  : 			// IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT during its DriverEntry
; 113  : 			// routine. (But can also do it here).
; 114  : 			// Please refer to the PARSIMP driver code for a template of a simple
; 115  : 			// parallel class driver.
; 116  : 			// TODO: In order to allow interrupts on the par port:
; 117  : 			// 1. Choose "Use any interrupts assigned to the port" in par port tab in Device Manager
; 118  : 			// 2. Add and set an EnableConnectInterruptIoctl reg val to 0x1 (DWORD)
; 119  : 			// (under HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\Root\*PNP0400\PnPBIOS_10\Device Parameters)
; 120  : 			//(PWSTR)L"EnableConnectInterruptIoctl"
; 121  : 			// TODO: send IOCTL_INTERNAL_PARALLEL_PORT_ALLOCATE to acquire the port
; 122  : 			// NOTE: DpcForIsr() is required for an ISR (see: NT4 DDK's parsimp sample)
; 123  : 			// TODO: hack all INTERRUPT_NEEDED stuff from parsimp into this driver
; 124  : 
; 125  : 			// A DPC is required for an ISR
; 126  : 			IoInitializeDpcRequest(fdo, ParDpcForIsr);

	mov	edx, DWORD PTR _fdo$[ebp]
	push	edx
	push	OFFSET FLAT:?ParDpcForIsr@@YGXPAU_KDPC@@PAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z ; ParDpcForIsr
	mov	eax, DWORD PTR _fdo$[ebp]
	add	eax, 116				; 00000074H
	push	eax
	call	DWORD PTR __imp__KeInitializeDpc@12

; 127  : 
; 128  : 
; 129  : 			// NOTE: DD_PARALLEL_PORT_BASE_NAME_U is #defined as "ParallelPort" (see: parsimp)
; 130  : 			//RtlInitUnicodeString(&PortDeviceObjectName, L"\\DosDevices\\LPT1");
; 131  : 			//RtlInitUnicodeString(&PortDeviceObjectName, L"\\Device\\Parallel0");
; 132  : 			RtlInitUnicodeString(&PortDeviceObjectName, L"\\Device\\ParallelPort0");

	push	OFFSET FLAT:$SG8781
	lea	ecx, DWORD PTR _PortDeviceObjectName$[ebp]
	push	ecx
	call	DWORD PTR __imp__RtlInitUnicodeString@8

; 133  : 
; 134  : 
; 135  : 			status = IoGetDeviceObjectPointer(&PortDeviceObjectName, FILE_ALL_ACCESS,
; 136  : 							&PortFileObject, &PortDeviceObject);

	lea	edx, DWORD PTR _PortDeviceObject$[ebp]
	push	edx
	lea	eax, DWORD PTR _PortFileObject$[ebp]
	push	eax
	push	2032127					; 001f01ffH
	lea	ecx, DWORD PTR _PortDeviceObjectName$[ebp]
	push	ecx
	call	DWORD PTR __imp__IoGetDeviceObjectPointer@16
	mov	DWORD PTR _status$8777[ebp], eax

; 137  : 
; 138  : 			if (!NT_SUCCESS(status)) {

	cmp	DWORD PTR _status$8777[ebp], 0
	jge	SHORT $L8783

; 139  : 				return status;

	mov	eax, DWORD PTR _status$8777[ebp]
	jmp	$L8752
$L8783:

; 141  : 
; 142  : 			// save in extension
; 143  : 			pdx->PortDeviceObject = PortDeviceObject;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	eax, DWORD PTR _PortDeviceObject$[ebp]
	mov	DWORD PTR [edx+20], eax

; 144  : 
; 145  : 			KeInitializeEvent(&Event, NotificationEvent, FALSE);

	push	0
	push	0
	lea	ecx, DWORD PTR _Event$[ebp]
	push	ecx
	call	DWORD PTR __imp__KeInitializeEvent@12

; 146  : 			//ParIsr.InterruptServiceRoutine = TxP_InterruptService;
; 147  : 			//ParIsr.InterruptServiceContext = NULL;
; 148  : 			ParIsr.InterruptServiceRoutine = ParInterruptService;

	mov	DWORD PTR _ParIsr$[ebp], OFFSET FLAT:?ParInterruptService@@YGEPAU_KINTERRUPT@@PAX@Z ; ParInterruptService

; 149  : 			ParIsr.InterruptServiceContext = pdx;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR _ParIsr$[ebp+4], edx

; 150  : 			ParIsr.DeferredPortCheckRoutine = ParDeferredPortCheck;

	mov	DWORD PTR _ParIsr$[ebp+8], OFFSET FLAT:?ParDeferredPortCheck@@YGXPAX@Z ; ParDeferredPortCheck

; 151  : 			ParIsr.DeferredPortCheckContext = pdx;

	mov	eax, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR _ParIsr$[ebp+12], eax

; 152  : 
; 153  : 			PortIrp = IoBuildDeviceIoControlRequest(IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT,
; 154  : 														PortDeviceObject,
; 155  : 														&ParIsr, 
; 156  : 														sizeof(ParIsr), 
; 157  : 														&ParInterruptInfo,
; 158  : 														sizeof(ParInterruptInfo),
; 159  : 														TRUE, 
; 160  : 														&Event, 
; 161  : 														&IoStatus);

	lea	ecx, DWORD PTR _IoStatus$[ebp]
	push	ecx
	lea	edx, DWORD PTR _Event$[ebp]
	push	edx
	push	1
	push	16					; 00000010H
	lea	eax, DWORD PTR _ParInterruptInfo$[ebp]
	push	eax
	push	16					; 00000010H
	lea	ecx, DWORD PTR _ParIsr$[ebp]
	push	ecx
	mov	edx, DWORD PTR _PortDeviceObject$[ebp]
	push	edx
	push	1441844					; 00160034H
	call	DWORD PTR __imp__IoBuildDeviceIoControlRequest@36
	mov	DWORD PTR _PortIrp$[ebp], eax

; 162  : 
; 163  : 			ASSERT(PortIrp->StackCount > 0);

	mov	eax, DWORD PTR _PortIrp$[ebp]
	movsx	ecx, BYTE PTR [eax+34]
	test	ecx, ecx
	jg	SHORT $L8784
	push	0
	push	163					; 000000a3H
	push	OFFSET FLAT:$SG8785
	push	OFFSET FLAT:$SG8786
	call	DWORD PTR __imp__RtlAssert@16
$L8784:

; 164  : 
; 165  : 			if (!PortIrp) {

	cmp	DWORD PTR _PortIrp$[ebp], 0
	jne	SHORT $L8787

; 166  : 				return STATUS_INSUFFICIENT_RESOURCES;

	mov	eax, -1073741670			; c000009aH
	jmp	$L8752
$L8787:

; 168  : 
; 169  : 			status = IoCallDriver(PortDeviceObject, PortIrp);

	mov	edx, DWORD PTR _PortIrp$[ebp]
	mov	ecx, DWORD PTR _PortDeviceObject$[ebp]
	call	DWORD PTR __imp_@IofCallDriver@8
	mov	DWORD PTR _status$8777[ebp], eax

; 170  : 
; 171  : 			if (!NT_SUCCESS(status)) {

	cmp	DWORD PTR _status$8777[ebp], 0
	jge	SHORT $L8790

; 172  : 				return status;

	mov	eax, DWORD PTR _status$8777[ebp]
	jmp	$L8752
$L8790:

; 174  : 
; 175  : 			status = KeWaitForSingleObject(&Event, Executive, KernelMode, FALSE, NULL);

	push	0
	push	0
	push	0
	push	0
	lea	edx, DWORD PTR _Event$[ebp]
	push	edx
	call	DWORD PTR __imp__KeWaitForSingleObject@20
	mov	DWORD PTR _status$8777[ebp], eax

; 176  : 
; 177  : 			if (!NT_SUCCESS(status)) {

	cmp	DWORD PTR _status$8777[ebp], 0
	jge	SHORT $L8792

; 178  : 				return status;

	mov	eax, DWORD PTR _status$8777[ebp]
	jmp	SHORT $L8752
$L8792:

; 180  : 
; 181  : 			status = IoStatus.Status;

	mov	eax, DWORD PTR _IoStatus$[ebp]
	mov	DWORD PTR _status$8777[ebp], eax

; 182  : 
; 183  : 			if (!NT_SUCCESS(status)) {

	cmp	DWORD PTR _status$8777[ebp], 0
	jge	SHORT $L8795

; 184  : 				return(status);

	mov	eax, DWORD PTR _status$8777[ebp]
	jmp	SHORT $L8752
$L8795:

; 186  : 
; 187  : 			pdx->InterruptObject = ParInterruptInfo.InterruptObject;

	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	edx, DWORD PTR _ParInterruptInfo$[ebp]
	mov	DWORD PTR [ecx+56], edx

; 188  : 			pdx->TryAllocatePortAtInterruptLevel =
; 189  : 					ParInterruptInfo.TryAllocatePortAtInterruptLevel;

	mov	eax, DWORD PTR _pdx$[ebp]
	mov	ecx, DWORD PTR _ParInterruptInfo$[ebp+4]
	mov	DWORD PTR [eax+60], ecx

; 190  : 			pdx->TryAllocateContext = ParInterruptInfo.Context;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	eax, DWORD PTR _ParInterruptInfo$[ebp+12]
	mov	DWORD PTR [edx+64], eax

; 191  : 
; 192  : 
; 193  : 			//KeWaitForSingleObject()
; 194  : 			//IoCompleteRequest()
; 195  : 			//////////////////////////////////////////////////////////////////////////
; 196  : 
; 197  : 
; 198  : 			// TODO: get the resources from LPT1 into translated
; 199  : 			// (The user will be forced to use LPT1)
; 200  : 			// Force the fucker
; 201  : 			//pdx->Vector = 7;
; 202  : 			//pdx->Irql = DISPATCH_LEVEL; //(KIRQL)resource->u.Interrupt.Level;
; 203  : 			//pdx->SynchronizeIrql = DISPATCH_LEVEL; //(KIRQL)resource->u.Interrupt.Level;
; 204  : 			//pdx->InterruptMode = Latched;
; 205  : 			//pdx->ShareVector = TRUE;
; 206  : 			//pdx->ProcessorEnableMask = -1; //resource->u.Interrupt.Affinity; 
; 207  : 			//pdx->FloatingSave = FALSE;
; 208  : 
; 209  : 			// Let's connect it
; 210  : 			//TxP_ConnectInterrupt( pdx );
; 211  : 			///////////////////////////////////////////////////////
; 212  : 
; 213  : 
; 214  : 
; 215  : 			/////////////////////////////////////////////////////////////////
; 216  : 			// No use for this stuff as we will be using the par port's resources
; 217  : 			//
; 218  : 			//PCM_PARTIAL_RESOURCE_LIST raw = stack->Parameters.StartDevice.AllocatedResources
; 219  : 			//	? &stack->Parameters.StartDevice.AllocatedResources->List[0].PartialResourceList
; 220  : 			//	: NULL;
; 221  : 			//
; 222  : 			//PCM_PARTIAL_RESOURCE_LIST translated = stack->Parameters.StartDevice.AllocatedResourcesTranslated
; 223  : 			//	? &stack->Parameters.StartDevice.AllocatedResourcesTranslated->List[0].PartialResourceList
; 224  : 			//	: NULL;
; 225  : 			//
; 226  : 			// Start 'r up, Ma!
; 227  : 			//status = TxP_StartDevice(fdo, raw, translated);
; 228  : 			/////////////////////////////////////////////////////////////////////
; 229  : 
; 230  : 			return TxP_CompleteRequest(Irp, status, 0);

	push	0
	mov	ecx, DWORD PTR _status$8777[ebp]
	push	ecx
	mov	edx, DWORD PTR _Irp$[ebp]
	push	edx
	call	?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z	; TxP_CompleteRequest
	jmp	SHORT $L8752
$L8796:

; 232  : 
; 233  : 		case IRP_MN_QUERY_STOP_DEVICE:
; 234  : 		case IRP_MN_QUERY_REMOVE_DEVICE:
; 235  : 			return TxP_CompleteRequest(Irp, STATUS_UNSUCCESSFUL, 0);

	push	0
	push	-1073741823				; c0000001H
	mov	eax, DWORD PTR _Irp$[ebp]
	push	eax
	call	?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z	; TxP_CompleteRequest
	jmp	SHORT $L8752
$L8798:

; 236  : 
; 237  : 		default:
; 238  : 			IoSkipCurrentIrpStackLocation(Irp);

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	dl, BYTE PTR [ecx+35]
	add	dl, 1
	mov	eax, DWORD PTR _Irp$[ebp]
	mov	BYTE PTR [eax+35], dl
	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR [ecx+96]
	add	edx, 36					; 00000024H
	mov	eax, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [eax+96], edx

; 239  : 			return IoCallDriver(pdx->LowerDeviceObject, Irp);

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	ecx, DWORD PTR [ecx+4]
	call	DWORD PTR __imp_@IofCallDriver@8
$L8752:

; 242  : }							// TxintPar_DispatchPnp

	mov	esp, ebp
	pop	ebp
	ret	8
?TxintPar_DispatchPnp@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ENDP ; TxintPar_DispatchPnp
page	ENDS
PUBLIC	?ParSetTrue@@YGEPAX@Z				; ParSetTrue
;	COMDAT ?ParSetTrue@@YGEPAX@Z
page	SEGMENT
_Context$ = 8
?ParSetTrue@@YGEPAX@Z PROC NEAR				; ParSetTrue, COMDAT

; 254  : {

	push	ebp
	mov	ebp, esp

; 255  :     *((PBOOLEAN) Context) = TRUE;

	mov	eax, DWORD PTR _Context$[ebp]
	mov	BYTE PTR [eax], 1

; 256  :     return(TRUE);

	mov	al, 1

; 257  : }

	pop	ebp
	ret	4
?ParSetTrue@@YGEPAX@Z ENDP				; ParSetTrue
page	ENDS
PUBLIC	?ParAllocPortWithNext@@YGXPAU_DEVICE_EXTENSION@@@Z ; ParAllocPortWithNext
EXTRN	__imp_@IofCompleteRequest@8:NEAR
EXTRN	__imp__KeSynchronizeExecution@12:NEAR
;	COMDAT ?ParDpcForIsr@@YGXPAU_KDPC@@PAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z
page	SEGMENT
_Irp$ = 16
_Extension$ = 20
_extension$ = -4
?ParDpcForIsr@@YGXPAU_KDPC@@PAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z PROC NEAR ; ParDpcForIsr, COMDAT

; 289  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 290  :     PDEVICE_EXTENSION   extension;
; 291  : 
; 292  :     extension = (PDEVICE_EXTENSION)Extension;

	mov	eax, DWORD PTR _Extension$[ebp]
	mov	DWORD PTR _extension$[ebp], eax

; 293  : 
; 294  :     //
; 295  :     // Perform defered actions for Interrupt service routine.
; 296  :     //
; 297  : 
; 298  :     //
; 299  :     // Complete the IRP, free the port, and start up the next IRP in
; 300  :     // the queue.
; 301  :     //
; 302  : 
; 303  :     Irp->IoStatus.Status = STATUS_SUCCESS;

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [ecx+24], 0

; 304  :     Irp->IoStatus.Information = 0;

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [edx+28], 0

; 305  :     IoCompleteRequest(Irp, IO_PARALLEL_INCREMENT);

	mov	dl, 1
	mov	ecx, DWORD PTR _Irp$[ebp]
	call	DWORD PTR __imp_@IofCompleteRequest@8

; 306  : 
; 307  :     KeSynchronizeExecution(extension->InterruptObject,
; 308  :                            ParSetTrue,
; 309  :                            &extension->IgnoreInterrupts);

	mov	eax, DWORD PTR _extension$[ebp]
	add	eax, 53					; 00000035H
	push	eax
	push	OFFSET FLAT:?ParSetTrue@@YGEPAX@Z	; ParSetTrue
	mov	ecx, DWORD PTR _extension$[ebp]
	mov	edx, DWORD PTR [ecx+56]
	push	edx
	call	DWORD PTR __imp__KeSynchronizeExecution@12

; 310  : 
; 311  :     extension->FreePort(extension->FreePortContext);

	mov	eax, DWORD PTR _extension$[ebp]
	mov	ecx, DWORD PTR [eax+100]
	push	ecx
	mov	edx, DWORD PTR _extension$[ebp]
	call	DWORD PTR [edx+96]

; 312  : 
; 313  :     ParAllocPortWithNext(extension);

	mov	eax, DWORD PTR _extension$[ebp]
	push	eax
	call	?ParAllocPortWithNext@@YGXPAU_DEVICE_EXTENSION@@@Z ; ParAllocPortWithNext

; 314  : }

	mov	esp, ebp
	pop	ebp
	ret	16					; 00000010H
?ParDpcForIsr@@YGXPAU_KDPC@@PAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z ENDP ; ParDpcForIsr
page	ENDS
EXTRN	__imp__KeInsertQueueDpc@12:NEAR
;	COMDAT ?ParInterruptService@@YGEPAU_KINTERRUPT@@PAX@Z
page	SEGMENT
_Extension$ = 12
_extension$ = -4
?ParInterruptService@@YGEPAU_KINTERRUPT@@PAX@Z PROC NEAR ; ParInterruptService, COMDAT

; 347  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 348  :     PDEVICE_EXTENSION   extension;
; 349  : 
; 350  :     extension = (PDEVICE_EXTENSION)Extension;

	mov	eax, DWORD PTR _Extension$[ebp]
	mov	DWORD PTR _extension$[ebp], eax

; 351  : 
; 352  :     if (extension->IgnoreInterrupts) {

	mov	ecx, DWORD PTR _extension$[ebp]
	xor	edx, edx
	mov	dl, BYTE PTR [ecx+53]
	test	edx, edx
	je	SHORT $L8816

; 359  :             extension->TryAllocateContext)) {

	mov	eax, DWORD PTR _extension$[ebp]
	mov	ecx, DWORD PTR [eax+64]
	push	ecx
	mov	edx, DWORD PTR _extension$[ebp]
	call	DWORD PTR [edx+60]
	and	eax, 255				; 000000ffH
	test	eax, eax
	jne	SHORT $L8817

; 360  : 
; 361  :             return FALSE;

	xor	al, al
	jmp	SHORT $L8813
$L8817:
$L8816:

; 364  : 
; 365  :     // Do some stuff and then queue a DPC to complete the request and
; 366  :     // free the port.
; 367  : 
; 368  : 	// Here's our interrupt stuff ////////////////////////////////////
; 369  : 	
; 370  : 	// test
; 371  : 	extension->Ch5 = 1750;

	mov	eax, DWORD PTR _extension$[ebp]
	mov	DWORD PTR [eax+148], 1750		; 000006d6H

; 372  : 
; 373  : /*
; 374  : 	// Keep count of how many interrupts we processed
; 375  : 	extension->IntCount++;
; 376  : 
; 377  : 	// Start time stamping: we need resolution fine enough for 1000-2000 uS (1-2 ms)
; 378  : 	// KeQueryTickCount()			coarse grained
; 379  : 	// KeQueryInterruptTime()		fine grained: 100-nanosecond units == 0.1 uS
; 380  : 	// KeQueryPerformanceCounter()	finest grained
; 381  : 
; 382  : 	// Time stamp first interrupt
; 383  : 	if ( !extension->GotIntTime ) {
; 384  : 		extension->PrevIntTime = (int)KeQueryInterruptTime();
; 385  : 		extension->GotIntTime = true;
; 386  : 		return TRUE;
; 387  : 	}
; 388  : 
; 389  : 	// Subtract previous time stamp from current time stamp
; 390  : 	// We don't need ULONGLONG, only int
; 391  : 	extension->PulseLength = (int)KeQueryInterruptTime() - extension->PrevIntTime;
; 392  : 
; 393  : 	// Save current time stamp for next time
; 394  : 	extension->PrevIntTime = (int)KeQueryInterruptTime();
; 395  : 
; 396  : 	// If timer goes from FFFFFFFFh to 00000000h we get a great negative value:
; 397  : 	// Compensate it
; 398  : 	if ( extension->PulseLength < 0 )
; 399  : 		extension->PulseLength += 0xFFFFFFFF;
; 400  : 
; 401  : 	// It is more convenient to work with with 1 uS units
; 402  : 	extension->PulseLength /= 10;
; 403  : 
; 404  : 	// Check if it is the sync pulse
; 405  : 	if ( extension->PulseLength > 5000 ) {
; 406  : 		extension->GotSync = true;
; 407  : 		extension->ChannelCount = 0;
; 408  : 		extension->SyncPulse = extension->PulseLength;
; 409  : 		return TRUE;
; 410  : 	}
; 411  : 
; 412  : 	// Set channels
; 413  : 	if ( extension->GotSync ) {
; 414  : 		extension->ChannelCount++;
; 415  : 
; 416  : 		switch ( extension->ChannelCount ) 
; 417  : 		{
; 418  : 			case 1: extension->Ch1 = extension->PulseLength; return TRUE; break;
; 419  : 			case 2: extension->Ch2 = extension->PulseLength; return TRUE; break;
; 420  : 			case 3: extension->Ch3 = extension->PulseLength; return TRUE; break;
; 421  : 			case 4: extension->Ch4 = extension->PulseLength; return TRUE; break;
; 422  : 			case 5: extension->Ch5 = extension->PulseLength; return TRUE; break;
; 423  : 			case 6: extension->Ch6 = extension->PulseLength; return TRUE; break;
; 424  : 			case 7: extension->Ch7 = extension->PulseLength; return TRUE; break;
; 425  : 			case 8: extension->Ch8 = extension->PulseLength; return TRUE; break;
; 426  : 			case 9: extension->Ch9 = extension->PulseLength; return TRUE; break;
; 427  : 			case 10: extension->Ch10 = extension->PulseLength; return TRUE; break;
; 428  : 		}
; 429  : 	}
; 430  : 
; 431  : 	// test
; 432  : 	//extension->Ch3 = 1750;
; 433  : */
; 434  : 	////////////////////////////////////////////////////////////////////////
; 435  : 
; 436  : 
; 437  :     IoRequestDpc(extension->DeviceObject, extension->CurrentIrp, extension);

	mov	ecx, DWORD PTR _extension$[ebp]
	push	ecx
	mov	edx, DWORD PTR _extension$[ebp]
	mov	eax, DWORD PTR [edx+76]
	push	eax
	mov	ecx, DWORD PTR _extension$[ebp]
	mov	edx, DWORD PTR [ecx]
	add	edx, 116				; 00000074H
	push	edx
	call	DWORD PTR __imp__KeInsertQueueDpc@12

; 438  : 
; 439  :     return TRUE;

	mov	al, 1
$L8813:

; 440  : }

	mov	esp, ebp
	pop	ebp
	ret	8
?ParInterruptService@@YGEPAU_KINTERRUPT@@PAX@Z ENDP	; ParInterruptService
page	ENDS
EXTRN	__imp__READ_PORT_UCHAR@4:NEAR
EXTRN	__imp__WRITE_PORT_UCHAR@8:NEAR
;	COMDAT ?ParDeferredPortCheck@@YGXPAX@Z
page	SEGMENT
_Extension$ = 8
_extension$ = -8
_u$ = -4
?ParDeferredPortCheck@@YGXPAX@Z PROC NEAR		; ParDeferredPortCheck, COMDAT

; 466  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 467  :     PDEVICE_EXTENSION   extension = (PDEVICE_EXTENSION)Extension;

	mov	eax, DWORD PTR _Extension$[ebp]
	mov	DWORD PTR _extension$[ebp], eax

; 468  :     UCHAR               u;
; 469  : 
; 470  :     // Make sure that interrupts are turned on.
; 471  : 
; 472  :     u = READ_PORT_UCHAR(extension->Controller + 2);

	mov	ecx, DWORD PTR _extension$[ebp]
	mov	edx, DWORD PTR [ecx+88]
	add	edx, 2
	push	edx
	call	DWORD PTR __imp__READ_PORT_UCHAR@4
	mov	BYTE PTR _u$[ebp], al

; 473  : 	u |= 0x10;

	mov	al, BYTE PTR _u$[ebp]
	or	al, 16					; 00000010H
	mov	BYTE PTR _u$[ebp], al

; 474  :     WRITE_PORT_UCHAR(extension->Controller + 2, u);

	mov	cl, BYTE PTR _u$[ebp]
	push	ecx
	mov	edx, DWORD PTR _extension$[ebp]
	mov	eax, DWORD PTR [edx+88]
	add	eax, 2
	push	eax
	call	DWORD PTR __imp__WRITE_PORT_UCHAR@8

; 475  : }

	mov	esp, ebp
	pop	ebp
	ret	4
?ParDeferredPortCheck@@YGXPAX@Z ENDP			; ParDeferredPortCheck
page	ENDS
PUBLIC	?ParSetFalse@@YGEPAX@Z				; ParSetFalse
;	COMDAT ?ParSetFalse@@YGEPAX@Z
page	SEGMENT
_Context$ = 8
?ParSetFalse@@YGEPAX@Z PROC NEAR			; ParSetFalse, COMDAT

; 481  : {

	push	ebp
	mov	ebp, esp

; 482  :     *((PBOOLEAN) Context) = FALSE;

	mov	eax, DWORD PTR _Context$[ebp]
	mov	BYTE PTR [eax], 0

; 483  :     return(TRUE);

	mov	al, 1

; 484  : }

	pop	ebp
	ret	4
?ParSetFalse@@YGEPAX@Z ENDP				; ParSetFalse
page	ENDS
PUBLIC	?ParAllocPort@@YGXPAU_DEVICE_EXTENSION@@@Z	; ParAllocPort
PUBLIC	?ParReadCompletionRoutine@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z ; ParReadCompletionRoutine
;	COMDAT ?ParAllocPort@@YGXPAU_DEVICE_EXTENSION@@@Z
; File E:\WDM_interface\Txintpar\PnP.cpp
page	SEGMENT
$SG8834	DB	'E:\WDM_interface\Txintpar\PnP.cpp', 00H
	ORG $+2
$SG8835	DB	'(1) | (1) | (1) ? (ParReadCompletionRoutine) != NULL : T'
	DB	'RUE', 00H
_Extension$ = 8
_nextSp$ = -4
_irpSp$8832 = -8
?ParAllocPort@@YGXPAU_DEVICE_EXTENSION@@@Z PROC NEAR	; ParAllocPort, COMDAT

; 511  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 512  :     PIO_STACK_LOCATION  nextSp;
; 513  : 
; 514  :     nextSp = IoGetNextIrpStackLocation(Extension->CurrentIrp);

	mov	eax, DWORD PTR _Extension$[ebp]
	mov	ecx, DWORD PTR [eax+76]
	mov	edx, DWORD PTR [ecx+96]
	sub	edx, 36					; 00000024H
	mov	DWORD PTR _nextSp$[ebp], edx

; 515  :     nextSp->MajorFunction = IRP_MJ_INTERNAL_DEVICE_CONTROL;

	mov	eax, DWORD PTR _nextSp$[ebp]
	mov	BYTE PTR [eax], 15			; 0000000fH

; 516  :     nextSp->Parameters.DeviceIoControl.IoControlCode =
; 517  :             IOCTL_INTERNAL_PARALLEL_PORT_ALLOCATE;

	mov	ecx, DWORD PTR _nextSp$[ebp]
	mov	DWORD PTR [ecx+12], 1441836		; 0016002cH

; 520  :                            ParReadCompletionRoutine,
; 521  :                            Extension, TRUE, TRUE, TRUE);

	mov	edx, OFFSET FLAT:?ParReadCompletionRoutine@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z ; ParReadCompletionRoutine
	neg	edx
	sbb	edx, edx
	neg	edx
	test	edx, edx
	jne	SHORT $L8833
	push	0
	push	521					; 00000209H
	push	OFFSET FLAT:$SG8834
	push	OFFSET FLAT:$SG8835
	call	DWORD PTR __imp__RtlAssert@16
$L8833:
	mov	eax, DWORD PTR _Extension$[ebp]
	mov	ecx, DWORD PTR [eax+76]
	mov	edx, DWORD PTR [ecx+96]
	sub	edx, 36					; 00000024H
	mov	DWORD PTR _irpSp$8832[ebp], edx
	mov	eax, DWORD PTR _irpSp$8832[ebp]
	mov	DWORD PTR [eax+28], OFFSET FLAT:?ParReadCompletionRoutine@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z ; ParReadCompletionRoutine
	mov	ecx, DWORD PTR _irpSp$8832[ebp]
	mov	edx, DWORD PTR _Extension$[ebp]
	mov	DWORD PTR [ecx+32], edx
	mov	eax, DWORD PTR _irpSp$8832[ebp]
	mov	BYTE PTR [eax+3], 0
	mov	ecx, 1
	test	ecx, ecx
	je	SHORT $L8836
	mov	edx, DWORD PTR _irpSp$8832[ebp]
	mov	BYTE PTR [edx+3], 64			; 00000040H
$L8836:
	mov	eax, 1
	test	eax, eax
	je	SHORT $L8837
	mov	ecx, DWORD PTR _irpSp$8832[ebp]
	mov	dl, BYTE PTR [ecx+3]
	or	dl, 128					; 00000080H
	mov	eax, DWORD PTR _irpSp$8832[ebp]
	mov	BYTE PTR [eax+3], dl
$L8837:
	mov	ecx, 1
	test	ecx, ecx
	je	SHORT $L8838
	mov	edx, DWORD PTR _irpSp$8832[ebp]
	mov	al, BYTE PTR [edx+3]
	or	al, 32					; 00000020H
	mov	ecx, DWORD PTR _irpSp$8832[ebp]
	mov	BYTE PTR [ecx+3], al
$L8838:

; 522  : 
; 523  : /*
; 524  : #ifdef TIMEOUT_ALLOCS
; 525  : 
; 526  :     Extension->TimedOut = FALSE;
; 527  :     Extension->CurrentIrpRefCount = IRP_REF_TIMER + IRP_REF_COMPLETION_ROUTINE;
; 528  :     KeSetTimer(&Extension->AllocTimer, Extension->AllocTimeout,
; 529  :                &Extension->AllocTimerDpc);
; 530  : 
; 531  : #endif
; 532  : */
; 533  :     IoCallDriver(Extension->PortDeviceObject, Extension->CurrentIrp);

	mov	edx, DWORD PTR _Extension$[ebp]
	mov	edx, DWORD PTR [edx+76]
	mov	eax, DWORD PTR _Extension$[ebp]
	mov	ecx, DWORD PTR [eax+20]
	call	DWORD PTR __imp_@IofCallDriver@8

; 534  : }

	mov	esp, ebp
	pop	ebp
	ret	4
?ParAllocPort@@YGXPAU_DEVICE_EXTENSION@@@Z ENDP		; ParAllocPort
page	ENDS
EXTRN	__imp__IoAcquireCancelSpinLock@4:NEAR
EXTRN	__imp__IoReleaseCancelSpinLock@4:NEAR
EXTRN	__imp_@InterlockedExchange@8:NEAR
;	COMDAT ?ParAllocPortWithNext@@YGXPAU_DEVICE_EXTENSION@@@Z
page	SEGMENT
_Extension$ = 8
_cancelIrql$ = -8
_head$ = -4
__EX_Blink$8845 = -16
__EX_Flink$8846 = -12
?ParAllocPortWithNext@@YGXPAU_DEVICE_EXTENSION@@@Z PROC NEAR ; ParAllocPortWithNext, COMDAT

; 559  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H

; 560  :     KIRQL       cancelIrql;
; 561  :     PLIST_ENTRY head;
; 562  : 
; 563  :     IoAcquireCancelSpinLock(&cancelIrql);

	lea	eax, DWORD PTR _cancelIrql$[ebp]
	push	eax
	call	DWORD PTR __imp__IoAcquireCancelSpinLock@4

; 564  : 
; 565  :     Extension->CurrentIrp = NULL;

	mov	ecx, DWORD PTR _Extension$[ebp]
	mov	DWORD PTR [ecx+76], 0

; 566  : 
; 567  :     if (IsListEmpty(&Extension->WorkQueue)) {

	mov	edx, DWORD PTR _Extension$[ebp]
	add	edx, 68					; 00000044H
	mov	eax, DWORD PTR _Extension$[ebp]
	cmp	DWORD PTR [eax+68], edx
	jne	SHORT $L8843

; 568  :         IoReleaseCancelSpinLock(cancelIrql);

	mov	cl, BYTE PTR _cancelIrql$[ebp]
	push	ecx
	call	DWORD PTR __imp__IoReleaseCancelSpinLock@4

; 569  :     } else {

	jmp	SHORT $L8844
$L8843:

; 570  : 
; 571  :         head = RemoveHeadList(&Extension->WorkQueue);

	mov	edx, DWORD PTR _Extension$[ebp]
	mov	eax, DWORD PTR [edx+68]
	mov	DWORD PTR _head$[ebp], eax
	mov	ecx, DWORD PTR _Extension$[ebp]
	mov	edx, DWORD PTR [ecx+68]
	mov	eax, DWORD PTR [edx]
	mov	DWORD PTR __EX_Flink$8846[ebp], eax
	mov	ecx, DWORD PTR _Extension$[ebp]
	mov	edx, DWORD PTR [ecx+68]
	mov	eax, DWORD PTR [edx+4]
	mov	DWORD PTR __EX_Blink$8845[ebp], eax
	mov	ecx, DWORD PTR __EX_Blink$8845[ebp]
	mov	edx, DWORD PTR __EX_Flink$8846[ebp]
	mov	DWORD PTR [ecx], edx
	mov	eax, DWORD PTR __EX_Flink$8846[ebp]
	mov	ecx, DWORD PTR __EX_Blink$8845[ebp]
	mov	DWORD PTR [eax+4], ecx

; 572  :         Extension->CurrentIrp = CONTAINING_RECORD(head, IRP,
; 573  :                                                   Tail.Overlay.ListEntry);

	mov	edx, DWORD PTR _head$[ebp]
	sub	edx, 88					; 00000058H
	mov	eax, DWORD PTR _Extension$[ebp]
	mov	DWORD PTR [eax+76], edx

; 574  :         IoSetCancelRoutine(Extension->CurrentIrp, NULL);

	xor	edx, edx
	mov	ecx, DWORD PTR _Extension$[ebp]
	mov	ecx, DWORD PTR [ecx+76]
	add	ecx, 56					; 00000038H
	call	DWORD PTR __imp_@InterlockedExchange@8

; 575  :         IoReleaseCancelSpinLock(cancelIrql);

	mov	dl, BYTE PTR _cancelIrql$[ebp]
	push	edx
	call	DWORD PTR __imp__IoReleaseCancelSpinLock@4

; 576  : 
; 577  :         ParAllocPort(Extension);

	mov	eax, DWORD PTR _Extension$[ebp]
	push	eax
	call	?ParAllocPort@@YGXPAU_DEVICE_EXTENSION@@@Z ; ParAllocPort
$L8844:

; 579  : }

	mov	esp, ebp
	pop	ebp
	ret	4
?ParAllocPortWithNext@@YGXPAU_DEVICE_EXTENSION@@@Z ENDP	; ParAllocPortWithNext
page	ENDS
PUBLIC	?ParCompleteRequest@@YGXPAU_DEVICE_EXTENSION@@@Z ; ParCompleteRequest
;	COMDAT ?ParReadCompletionRoutine@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z
page	SEGMENT
_Extension$ = 16
_extension$ = -12
?ParReadCompletionRoutine@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z PROC NEAR ; ParReadCompletionRoutine, COMDAT

; 611  : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH

; 612  :     PDEVICE_EXTENSION   extension;
; 613  :     KIRQL               oldIrql;
; 614  :     LONG                irpRef;
; 615  : 
; 616  :     extension = (PDEVICE_EXTENSION)Extension;

	mov	eax, DWORD PTR _Extension$[ebp]
	mov	DWORD PTR _extension$[ebp], eax

; 617  : /*
; 618  : #ifdef TIMEOUT_ALLOCS
; 619  : 
; 620  :     // Try to cancel the timer.
; 621  : 
; 622  :     if (KeCancelTimer(&extension->AllocTimer)) {
; 623  : 
; 624  :         // The timer was cancelled.  The completion routine has the IRP.
; 625  :         extension->CurrentIrpRefCount = 0;
; 626  : 
; 627  :     } else {
; 628  : 
; 629  :         // We're in contention with the timer DPC.  Establish who
; 630  :         // will complete the IRP via the 'CurrentIrpRefCount'.
; 631  : 
; 632  :         KeAcquireSpinLock(&extension->ControlLock, &oldIrql);
; 633  :         ASSERT(extension->CurrentIrpRefCount & IRP_REF_COMPLETION_ROUTINE);
; 634  :         irpRef = (extension->CurrentIrpRefCount -= IRP_REF_COMPLETION_ROUTINE);
; 635  :         KeReleaseSpinLock(&extension->ControlLock, oldIrql);
; 636  : 
; 637  :         if (irpRef) {
; 638  : 
; 639  :             // The IRP will be completed by the timer DPC.
; 640  : 
; 641  :             return STATUS_MORE_PROCESSING_REQUIRED;
; 642  :         }
; 643  :     }
; 644  : 
; 645  :     // At this point, the timer DPC is guaranteed not to
; 646  :     // mess with the CurrentIrp.
; 647  : 
; 648  : #endif
; 649  : */
; 650  :     ParCompleteRequest(extension);

	mov	ecx, DWORD PTR _extension$[ebp]
	push	ecx
	call	?ParCompleteRequest@@YGXPAU_DEVICE_EXTENSION@@@Z ; ParCompleteRequest

; 651  : 
; 652  :     // If the IRP was completed.  It was completed with 'IoCompleteRequest'.
; 653  : 
; 654  :     return STATUS_MORE_PROCESSING_REQUIRED;

	mov	eax, -1073741802			; c0000016H

; 655  : }

	mov	esp, ebp
	pop	ebp
	ret	12					; 0000000cH
?ParReadCompletionRoutine@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAX@Z ENDP ; ParReadCompletionRoutine
page	ENDS
;	COMDAT ?ParCompleteRequest@@YGXPAU_DEVICE_EXTENSION@@@Z
page	SEGMENT
_Extension$ = 8
_Irp$ = -4
?ParCompleteRequest@@YGXPAU_DEVICE_EXTENSION@@@Z PROC NEAR ; ParCompleteRequest, COMDAT

; 680  : {

	push	ebp
	mov	ebp, esp
	push	ecx

; 681  :     PIRP    Irp;
; 682  : 
; 683  :     Irp = Extension->CurrentIrp;

	mov	eax, DWORD PTR _Extension$[ebp]
	mov	ecx, DWORD PTR [eax+76]
	mov	DWORD PTR _Irp$[ebp], ecx

; 684  : 
; 685  :     // If the allocate failed, then fail this request and try again
; 686  :     // with the next IRP.
; 687  : 
; 688  :     if (!NT_SUCCESS(Irp->IoStatus.Status)) {

	mov	edx, DWORD PTR _Irp$[ebp]
	cmp	DWORD PTR [edx+24], 0
	jge	SHORT $L8871

; 689  : /*
; 690  : #ifdef TIMEOUT_ALLOCS
; 691  :         if (Extension->TimedOut) {
; 692  :             Irp->IoStatus.Status = STATUS_IO_TIMEOUT;
; 693  :         }
; 694  : #endif
; 695  : */
; 696  :         IoCompleteRequest(Irp, IO_NO_INCREMENT);

	xor	dl, dl
	mov	ecx, DWORD PTR _Irp$[ebp]
	call	DWORD PTR __imp_@IofCompleteRequest@8

; 697  :         ParAllocPortWithNext(Extension);

	mov	eax, DWORD PTR _Extension$[ebp]
	push	eax
	call	?ParAllocPortWithNext@@YGXPAU_DEVICE_EXTENSION@@@Z ; ParAllocPortWithNext

; 698  :         return;

	jmp	SHORT $L8868
$L8871:

; 705  :                            ParSetFalse,
; 706  :                            &Extension->IgnoreInterrupts);

	mov	ecx, DWORD PTR _Extension$[ebp]
	add	ecx, 53					; 00000035H
	push	ecx
	push	OFFSET FLAT:?ParSetFalse@@YGEPAX@Z	; ParSetFalse
	mov	edx, DWORD PTR _Extension$[ebp]
	mov	eax, DWORD PTR [edx+56]
	push	eax
	call	DWORD PTR __imp__KeSynchronizeExecution@12
$L8868:

; 707  : #endif
; 708  : 
; 709  :     //
; 710  :     // This is where the driver specific stuff should go.  The driver
; 711  :     // has exclusive access to the parallel port in this space.
; 712  :     //
; 713  : 
; 714  : #ifdef INTERRUPT_NEEDED
; 715  : 
; 716  :     //
; 717  :     // We're waiting for an interrupt before we can complete the IRP.
; 718  :     //
; 719  : 
; 720  : #else
; 721  : 
; 722  :     //
; 723  :     // Complete the IRP, free the port, and start up the next IRP in
; 724  :     // the queue.
; 725  :     //
; 726  : 
; 727  :     Irp->IoStatus.Status = STATUS_SUCCESS;
; 728  :     Irp->IoStatus.Information = 0;
; 729  :     IoCompleteRequest(Irp, IO_PARALLEL_INCREMENT);
; 730  : 
; 731  :     Extension->FreePort(Extension->FreePortContext);
; 732  : 
; 733  :     ParAllocPortWithNext(Extension);
; 734  : 
; 735  : #endif
; 736  : }

	mov	esp, ebp
	pop	ebp
	ret	4
?ParCompleteRequest@@YGXPAU_DEVICE_EXTENSION@@@Z ENDP	; ParCompleteRequest
page	ENDS
END
