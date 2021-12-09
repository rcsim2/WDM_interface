	TITLE	E:\WDM interface\Txintpar\Create.cpp
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
;	COMDAT ?TxintPar_DispatchCreate@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	?TxintPar_DispatchCreate@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchCreate
EXTRN	__imp__RtlAssert@16:NEAR
EXTRN	__imp__KeGetCurrentIrql@0:NEAR
EXTRN	_DbgPrint:NEAR
;	COMDAT ?TxintPar_DispatchCreate@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
; File E:\WDM interface\Txintpar\Create.cpp
page	SEGMENT
$SG8213	DB	'EX: Pageable code called at IRQL %d', 0aH, 00H
	ORG $+3
$SG8215	DB	'E:\WDM interface\Txintpar\Create.cpp', 00H
	ORG $+3
$SG8216	DB	'FALSE', 00H
?TxintPar_DispatchCreate@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z PROC NEAR ; TxintPar_DispatchCreate, COMDAT

; 11   : {							// TxintPar_DispatchCreate

	push	ebp
	mov	ebp, esp

; 12   : 	PAGED_CODE();

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
	push	12					; 0000000cH
	push	OFFSET FLAT:$SG8215
	push	OFFSET FLAT:$SG8216
	call	DWORD PTR __imp__RtlAssert@16
$L8214:
$L8212:

; 13   : 	
; 14   : 	return STATUS_SUCCESS;

	xor	eax, eax

; 15   : }							// TxintPar_DispatchCreate

	pop	ebp
	ret	8
?TxintPar_DispatchCreate@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ENDP ; TxintPar_DispatchCreate
page	ENDS
END
