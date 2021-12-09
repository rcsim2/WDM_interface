	TITLE	E:\WDM interface\Txintpar\InternalDeviceControl.cpp
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
;	COMDAT ?TxintPar_DispatchInternalDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
_DATA	SEGMENT
_ModeQualifier$S8335 DB 0aaH
	DB	055H
	DB	00H
	DB	0ffH
	DB	087H
	DB	078H
	DB	0ffH
	ORG $+1
_LegacyZipModeQualifier$S8337 DB 00H
	DB	03cH
	DB	020H
_DATA	ENDS
PUBLIC	?TxintPar_DispatchInternalDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchInternalDeviceControl
;	COMDAT ?TxintPar_DispatchInternalDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
page	SEGMENT
_Irp$ = 12
_irpStack$ = -4
?TxintPar_DispatchInternalDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z PROC NEAR ; TxintPar_DispatchInternalDeviceControl, COMDAT

; 13   : {							// TxintPar_DispatchInternalDeviceControl

	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 14   : 	
; 15   : 	// Get Irp stack location
; 16   : 	PIO_STACK_LOCATION irpStack = IoGetCurrentIrpStackLocation( Irp );

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	ecx, DWORD PTR [eax+96]
	mov	DWORD PTR _irpStack$[ebp], ecx

; 17   : 
; 18   : 	switch (irpStack->Parameters.DeviceIoControl.IoControlCode)

	mov	edx, DWORD PTR _irpStack$[ebp]
	mov	eax, DWORD PTR [edx+12]
	mov	DWORD PTR -8+[ebp], eax

; 32   : 
; 33   : 	return STATUS_SUCCESS;

	xor	eax, eax

; 34   : }							// TxintPar_DispatchInternalDeviceControl

	mov	esp, ebp
	pop	ebp
	ret	8
?TxintPar_DispatchInternalDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ENDP ; TxintPar_DispatchInternalDeviceControl
page	ENDS
END
