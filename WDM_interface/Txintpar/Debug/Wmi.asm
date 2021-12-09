	TITLE	E:\WDM interface\Txintpar\Wmi.cpp
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
;	COMDAT _IsEqualGUID@8
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _==@8
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?TxintPar_DispatchSystemControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	?TxintPar_DispatchSystemControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchSystemControl
EXTRN	__imp_@IofCallDriver@8:NEAR
;	COMDAT ?TxintPar_DispatchSystemControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
_TEXT	SEGMENT
_fdo$ = 8
_Irp$ = 12
_pdx$ = -4
?TxintPar_DispatchSystemControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z PROC NEAR ; TxintPar_DispatchSystemControl, COMDAT

; 9    : {							// TxintPar_DispatchSystemControl

	push	ebp
	mov	ebp, esp
	push	ecx

; 10   : 	IoSkipCurrentIrpStackLocation(Irp);

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	cl, BYTE PTR [eax+35]
	add	cl, 1
	mov	edx, DWORD PTR _Irp$[ebp]
	mov	BYTE PTR [edx+35], cl
	mov	eax, DWORD PTR _Irp$[ebp]
	mov	ecx, DWORD PTR [eax+96]
	add	ecx, 36					; 00000024H
	mov	edx, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [edx+96], ecx

; 11   : 	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	mov	eax, DWORD PTR _fdo$[ebp]
	mov	ecx, DWORD PTR [eax+40]
	mov	DWORD PTR _pdx$[ebp], ecx

; 12   : 	return IoCallDriver(pdx->LowerDeviceObject, Irp);

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR _pdx$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	call	DWORD PTR __imp_@IofCallDriver@8

; 13   : }							// TxintPar_DispatchSystemControl

	mov	esp, ebp
	pop	ebp
	ret	8
?TxintPar_DispatchSystemControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ENDP ; TxintPar_DispatchSystemControl
_TEXT	ENDS
END
