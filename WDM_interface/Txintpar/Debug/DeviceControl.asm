	TITLE	E:\WDM interface\Txintpar\DeviceControl.cpp
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
;	COMDAT ?TxintPar_DispatchDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	?TxintPar_DispatchDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchDeviceControl
EXTRN	__imp__RtlAssert@16:NEAR
EXTRN	__imp__KeGetCurrentIrql@0:NEAR
EXTRN	_DbgPrint:NEAR
;	COMDAT ?TxintPar_DispatchDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
; File E:\WDM interface\Txintpar\DeviceControl.cpp
page	SEGMENT
$SG8213	DB	'EX: Pageable code called at IRQL %d', 0aH, 00H
	ORG $+3
$SG8215	DB	'E:\WDM interface\Txintpar\DeviceControl.cpp', 00H
$SG8216	DB	'FALSE', 00H
_fdo$ = 8
_Irp$ = 12
_irpStack$ = -4
_pdx$8227 = -68
_pOutBuffer$8229 = -64
_OutBufferLength$8230 = -72
_Buffer$8232 = -60
?TxintPar_DispatchDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z PROC NEAR ; TxintPar_DispatchDeviceControl, COMDAT

; 12   : {							// TxintPar_DispatchDeviceControl

	push	ebp
	mov	ebp, esp
	sub	esp, 76					; 0000004cH
	push	esi
	push	edi

; 13   : 	
; 14   : 	// this macro checks if this code is pageable 
; 15   : 	PAGED_CODE();

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	cmp	eax, 1
	jle	SHORT $L8212
	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	push	eax
	push	OFFSET FLAT:$SG8213
	call	_DbgPrint
	add	esp, 8
	mov	eax, 1
	test	eax, eax
	je	SHORT $L8214
	push	0
	push	15					; 0000000fH
	push	OFFSET FLAT:$SG8215
	push	OFFSET FLAT:$SG8216
	call	DWORD PTR __imp__RtlAssert@16
$L8214:
$L8212:

; 16   : 
; 17   : 	/////////////////////////////////////////////////
; 18   : 	// This is the buffer we give to the user-mode app
; 19   : 	// RetInfo[0]  == SyncPulse
; 20   : 	//
; 21   : 	// RetInfo[1]  == Ch1
; 22   : 	// RetInfo[2]  == Ch2
; 23   : 	// RetInfo[3]  == Ch3
; 24   : 	// RetInfo[4]  == Ch4
; 25   : 	// RetInfo[5]  == Ch5
; 26   : 	// RetInfo[6]  == Ch6
; 27   : 	// RetInfo[7]  == Ch7			
; 28   : 	// RetInfo[8]  == Ch8
; 29   : 	// RetInfo[9]  == Ch9
; 30   : 	// RetInfo[10] == Ch10
; 31   : 	//
; 32   : 	// RetInfo[11] == IntCount
; 33   : 	// RetInfo[12] == PulseLength
; 34   : 	// RetInfo[13] == ChannelCount
; 35   : 	/////////////////////////////////////////////////
; 36   : 
; 37   : 
; 38   : 	// Get Irp stack location
; 39   : 	PIO_STACK_LOCATION irpStack = IoGetCurrentIrpStackLocation( Irp );

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR [ecx+96]
	mov	DWORD PTR _irpStack$[ebp], edx

; 40   : 
; 41   : 
; 42   : 	// Check I/O control code (do we have to?) Yes!!!
; 43   : 	// We must define a IOCTL using the CTL_CODE macro. 
; 44   : 	// CTL_CODE is defined in Wdm.h (for drivers) and in WinIoctl.h (for Win32 apps).
; 45   : 	// Define the IOCTL in the app and the driver, send it from the app to the driver
; 46   : 	// in the second param of DeviceIoControl() and then check for it here.
; 47   : 	// Make sure TransferType is METHOD_BUFFERED.
; 48   : 	//
; 49   : 	switch (irpStack->Parameters.DeviceIoControl.IoControlCode)

	mov	eax, DWORD PTR _irpStack$[ebp]
	mov	ecx, DWORD PTR [eax+12]
	mov	DWORD PTR -76+[ebp], ecx
	cmp	DWORD PTR -76+[ebp], 2285568		; 0022e000H
	je	SHORT $L8226
	jmp	$L8223
$L8226:

; 51   : 	case IOCTL_TXINTPAR_READ:
; 52   : 
; 53   : 		// Get pointer to device extension
; 54   : 		PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	mov	edx, DWORD PTR _fdo$[ebp]
	mov	eax, DWORD PTR [edx+40]
	mov	DWORD PTR _pdx$8227[ebp], eax

; 55   : 
; 56   : 		// Get pointer to the output buffer
; 57   : 		// It is Irp->UserBuffer!!! not Irp->AssociatedIrp.SystemBuffer!!!
; 58   : 		//PVOID pOutBuffer = Irp->AssociatedIrp.SystemBuffer;
; 59   : 		PVOID pOutBuffer = Irp->UserBuffer;

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR [ecx+60]
	mov	DWORD PTR _pOutBuffer$8229[ebp], edx

; 60   : 
; 61   : 		// Get size of the output buffer
; 62   : 		ULONG OutBufferLength = irpStack->Parameters.DeviceIoControl.OutputBufferLength;

	mov	eax, DWORD PTR _irpStack$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	DWORD PTR _OutBufferLength$8230[ebp], ecx

; 63   : 
; 64   : 
; 65   : 		// Test values
; 66   : 		pdx->SyncPulse = 8000;

	mov	edx, DWORD PTR _pdx$8227[ebp]
	mov	DWORD PTR [edx+80], 8000		; 00001f40H

; 67   : 		pdx->Ch1 = 1300;

	mov	eax, DWORD PTR _pdx$8227[ebp]
	mov	DWORD PTR [eax+84], 1300		; 00000514H

; 68   : 		pdx->Ch2 = 1400;

	mov	ecx, DWORD PTR _pdx$8227[ebp]
	mov	DWORD PTR [ecx+88], 1400		; 00000578H

; 69   : 		pdx->Ch3 = 1500;

	mov	edx, DWORD PTR _pdx$8227[ebp]
	mov	DWORD PTR [edx+92], 1500		; 000005dcH

; 70   : 		//pdx->Ch4 = 0;
; 71   : 		//pdx->Ch5 = 0;
; 72   : 		//pdx->Ch6 = 0;
; 73   : 		//pdx->Ch7 = 0;		
; 74   : 		//pdx->Ch8 = 0;
; 75   : 		//pdx->Ch9 = 0;
; 76   : 		//pdx->Ch10 = 0;
; 77   : 		pdx->IntCount = 7777;

	mov	eax, DWORD PTR _pdx$8227[ebp]
	mov	DWORD PTR [eax+56], 7777		; 00001e61H

; 78   : 		pdx->PulseLength = 1500;

	mov	ecx, DWORD PTR _pdx$8227[ebp]
	mov	DWORD PTR [ecx+68], 1500		; 000005dcH

; 79   : 		pdx->ChannelCount = 8;

	mov	edx, DWORD PTR _pdx$8227[ebp]
	mov	DWORD PTR [edx+76], 8

; 80   : 
; 81   : 
; 82   : 		// Create a buffer
; 83   : 		int Buffer[14];
; 84   : 
; 85   : 		// Fill the buffer
; 86   : 		Buffer[0] = pdx->SyncPulse;

	mov	eax, DWORD PTR _pdx$8227[ebp]
	mov	ecx, DWORD PTR [eax+80]
	mov	DWORD PTR _Buffer$8232[ebp], ecx

; 87   : 		Buffer[1] = pdx->Ch1;

	mov	edx, DWORD PTR _pdx$8227[ebp]
	mov	eax, DWORD PTR [edx+84]
	mov	DWORD PTR _Buffer$8232[ebp+4], eax

; 88   : 		Buffer[2] = pdx->Ch2;

	mov	ecx, DWORD PTR _pdx$8227[ebp]
	mov	edx, DWORD PTR [ecx+88]
	mov	DWORD PTR _Buffer$8232[ebp+8], edx

; 89   : 		Buffer[3] = pdx->Ch3;

	mov	eax, DWORD PTR _pdx$8227[ebp]
	mov	ecx, DWORD PTR [eax+92]
	mov	DWORD PTR _Buffer$8232[ebp+12], ecx

; 90   : 		Buffer[4] = pdx->Ch4;

	mov	edx, DWORD PTR _pdx$8227[ebp]
	mov	eax, DWORD PTR [edx+96]
	mov	DWORD PTR _Buffer$8232[ebp+16], eax

; 91   : 		Buffer[5] = pdx->Ch5;

	mov	ecx, DWORD PTR _pdx$8227[ebp]
	mov	edx, DWORD PTR [ecx+100]
	mov	DWORD PTR _Buffer$8232[ebp+20], edx

; 92   : 		Buffer[6] = pdx->Ch6;

	mov	eax, DWORD PTR _pdx$8227[ebp]
	mov	ecx, DWORD PTR [eax+104]
	mov	DWORD PTR _Buffer$8232[ebp+24], ecx

; 93   : 		Buffer[7] = pdx->Ch7;

	mov	edx, DWORD PTR _pdx$8227[ebp]
	mov	eax, DWORD PTR [edx+108]
	mov	DWORD PTR _Buffer$8232[ebp+28], eax

; 94   : 		Buffer[8] = pdx->Ch8;

	mov	ecx, DWORD PTR _pdx$8227[ebp]
	mov	edx, DWORD PTR [ecx+112]
	mov	DWORD PTR _Buffer$8232[ebp+32], edx

; 95   : 		Buffer[9] = pdx->Ch9;

	mov	eax, DWORD PTR _pdx$8227[ebp]
	mov	ecx, DWORD PTR [eax+116]
	mov	DWORD PTR _Buffer$8232[ebp+36], ecx

; 96   : 		Buffer[10] = pdx->Ch10;

	mov	edx, DWORD PTR _pdx$8227[ebp]
	mov	eax, DWORD PTR [edx+120]
	mov	DWORD PTR _Buffer$8232[ebp+40], eax

; 97   : 		Buffer[11] = pdx->IntCount;

	mov	ecx, DWORD PTR _pdx$8227[ebp]
	mov	edx, DWORD PTR [ecx+56]
	mov	DWORD PTR _Buffer$8232[ebp+44], edx

; 98   : 		Buffer[12] = pdx->PulseLength;

	mov	eax, DWORD PTR _pdx$8227[ebp]
	mov	ecx, DWORD PTR [eax+68]
	mov	DWORD PTR _Buffer$8232[ebp+48], ecx

; 99   : 		Buffer[13] = pdx->ChannelCount;

	mov	edx, DWORD PTR _pdx$8227[ebp]
	mov	eax, DWORD PTR [edx+76]
	mov	DWORD PTR _Buffer$8232[ebp+52], eax

; 100  : 
; 101  : 		// Move the buffer to the output buffer
; 102  : 		RtlCopyMemory( pOutBuffer, Buffer, sizeof(Buffer) );

	mov	ecx, 14					; 0000000eH
	lea	esi, DWORD PTR _Buffer$8232[ebp]
	mov	edi, DWORD PTR _pOutBuffer$8229[ebp]
	rep movsd

; 103  : 		//memmove( pOutBuffer, Buffer, sizeof(Buffer) );
; 104  : 		//*pOutBuffer = 666; // illegal indirection because pOutBuffer is PVOID and VOID
; 105  : 							// is of unknown size, workaround: cast to PLONG
; 106  : 		//*((PLONG) pOutBuffer+4) = 1666;
; 107  : 
; 108  : 
; 109  : 		// This is necessary?
; 110  : 		Irp->IoStatus.Information = OutBufferLength;

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR _OutBufferLength$8230[ebp]
	mov	DWORD PTR [ecx+28], edx
$L8223:

; 114  : 
; 115  : 	return STATUS_SUCCESS;

	xor	eax, eax

; 116  : }							// TxintPar_DispatchDeviceControl

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	8
?TxintPar_DispatchDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ENDP ; TxintPar_DispatchDeviceControl
page	ENDS
END
