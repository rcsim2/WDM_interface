	TITLE	E:\WDM interface\Txintpar\ReadWrite.cpp
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
;	COMDAT ?TxP_StartDevice@@YGJPAU_DEVICE_OBJECT@@PAU_CM_PARTIAL_RESOURCE_LIST@@1@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?TxP_ConnectInterrupt@@YGJPAU_DEVICE_EXTENSION@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?TxP_InterruptService@@YGEPAU_KINTERRUPT@@PAX@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	?TxP_StartDevice@@YGJPAU_DEVICE_OBJECT@@PAU_CM_PARTIAL_RESOURCE_LIST@@1@Z ; TxP_StartDevice
PUBLIC	?TxP_ConnectInterrupt@@YGJPAU_DEVICE_EXTENSION@@@Z ; TxP_ConnectInterrupt
;	COMDAT ?TxP_StartDevice@@YGJPAU_DEVICE_OBJECT@@PAU_CM_PARTIAL_RESOURCE_LIST@@1@Z
page	SEGMENT
_fdo$ = 8
_translated$ = 16
_status$ = -32
_pdx$ = -20
_foundPort$ = -36
_foundInterrupt$ = -8
_foundMemory$ = -12
_foundDma$ = -16
_resource$ = -4
_nres$ = -24
_i$ = -28
?TxP_StartDevice@@YGJPAU_DEVICE_OBJECT@@PAU_CM_PARTIAL_RESOURCE_LIST@@1@Z PROC NEAR ; TxP_StartDevice, COMDAT

; 12   : {							// TxP_StartDevice

	push	ebp
	mov	ebp, esp
	sub	esp, 40					; 00000028H

; 13   : 
; 14   : 	NTSTATUS status = STATUS_SUCCESS;

	mov	DWORD PTR _status$[ebp], 0

; 15   : 	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	mov	eax, DWORD PTR _fdo$[ebp]
	mov	ecx, DWORD PTR [eax+40]
	mov	DWORD PTR _pdx$[ebp], ecx

; 16   : 
; 17   : 	BOOLEAN foundPort	   = FALSE;

	mov	BYTE PTR _foundPort$[ebp], 0

; 18   : 	BOOLEAN foundInterrupt = FALSE;

	mov	BYTE PTR _foundInterrupt$[ebp], 0

; 19   : 	BOOLEAN foundMemory    = FALSE;

	mov	BYTE PTR _foundMemory$[ebp], 0

; 20   : 	BOOLEAN foundDma	   = FALSE;

	mov	BYTE PTR _foundDma$[ebp], 0

; 21   : 
; 22   : 	// test
; 23   : 	//pdx->Ch5 = 1750;
; 24   : 
; 25   : 	// TODO: we are leaving here because the PnP manager gives us no translated
; 26   : 	// resources. How can we get them? Or should we just grab them?
; 27   : 	if (!translated)

	cmp	DWORD PTR _translated$[ebp], 0
	jne	SHORT $L8221

; 28   : 		return STATUS_SUCCESS;	// nothing to do if no resources

	xor	eax, eax
	jmp	$L8212
$L8221:

; 29   : 
; 30   : 	// Identify the I/O resources we're supposed to use.	
; 31   : 	PCM_PARTIAL_RESOURCE_DESCRIPTOR resource = translated->PartialDescriptors;

	mov	edx, DWORD PTR _translated$[ebp]
	add	edx, 8
	mov	DWORD PTR _resource$[ebp], edx

; 32   : 	ULONG nres = translated->Count;

	mov	eax, DWORD PTR _translated$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	DWORD PTR _nres$[ebp], ecx

; 33   : 	for (ULONG i = 0; i < nres; ++i, ++resource)

	mov	DWORD PTR _i$[ebp], 0
	jmp	SHORT $L8226
$L8227:
	mov	edx, DWORD PTR _i$[ebp]
	add	edx, 1
	mov	DWORD PTR _i$[ebp], edx
	mov	eax, DWORD PTR _resource$[ebp]
	add	eax, 16					; 00000010H
	mov	DWORD PTR _resource$[ebp], eax
$L8226:
	mov	ecx, DWORD PTR _i$[ebp]
	cmp	ecx, DWORD PTR _nres$[ebp]
	jae	SHORT $L8228

; 35   : 		switch (resource->Type)

	mov	edx, DWORD PTR _resource$[ebp]
	mov	al, BYTE PTR [edx]
	mov	BYTE PTR -40+[ebp], al
	cmp	BYTE PTR -40+[ebp], 1
	je	SHORT $L8233
	cmp	BYTE PTR -40+[ebp], 2
	je	SHORT $L8234
	jmp	SHORT $L8243
$L8233:

; 37   : 
; 38   : 			case CmResourceTypePort:
; 39   : 				break;

	jmp	SHORT $L8230
$L8234:

; 40   : 		
; 41   : 			case CmResourceTypeInterrupt:
; 42   : 				// got it
; 43   : 				foundInterrupt = TRUE;

	mov	BYTE PTR _foundInterrupt$[ebp], 1

; 44   : 
; 45   : 				// Obsolete
; 46   : 				// We get the Vector with HalGetInterruptVector()
; 47   :                 //pdx->Vector = HalGetInterruptVector( resource->InterfaceType,
; 48   : 				//									   resource->BusNumber,
; 49   : 				//								       resource->u.Interrupt.Level,
; 50   : 				//									   resource->u.Interrupt.Vector,
; 51   : 				//								       &(pdx->Irql),
; 52   : 				//								       &(pdx->ProcessorEnableMask) );
; 53   : 
; 54   : 				// looks like we don't even get here: 
; 55   : 				// cause: no interrupt resources in resource list
; 56   : 				// test
; 57   : 				pdx->Ch5 = 1750;

	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR [ecx+100], 1750		; 000006d6H

; 58   : 
; 59   : 				// Get interrupt resources 
; 60   : 				pdx->Vector = resource->u.Interrupt.Vector;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	eax, DWORD PTR _resource$[ebp]
	mov	ecx, DWORD PTR [eax+8]
	mov	DWORD PTR [edx+32], ecx

; 61   : 				pdx->Irql = (KIRQL)resource->u.Interrupt.Level;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	eax, DWORD PTR _resource$[ebp]
	mov	cl, BYTE PTR [eax+4]
	mov	BYTE PTR [edx+36], cl

; 62   : 				pdx->SynchronizeIrql = (KIRQL)resource->u.Interrupt.Level;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	eax, DWORD PTR _resource$[ebp]
	mov	cl, BYTE PTR [eax+4]
	mov	BYTE PTR [edx+37], cl

; 63   : 				pdx->InterruptMode = Latched;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR [edx+40], 1

; 64   : 				pdx->ShareVector = TRUE;

	mov	eax, DWORD PTR _pdx$[ebp]
	mov	BYTE PTR [eax+44], 1

; 65   : 				pdx->ProcessorEnableMask = resource->u.Interrupt.Affinity; 

	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	edx, DWORD PTR _resource$[ebp]
	mov	eax, DWORD PTR [edx+12]
	mov	DWORD PTR [ecx+48], eax

; 66   : 				pdx->FloatingSave = FALSE;

	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	BYTE PTR [ecx+52], 0

; 67   : 
; 68   : 				// Let's connect it
; 69   : 				TxP_ConnectInterrupt( pdx );

	mov	edx, DWORD PTR _pdx$[ebp]
	push	edx
	call	?TxP_ConnectInterrupt@@YGJPAU_DEVICE_EXTENSION@@@Z ; TxP_ConnectInterrupt
$L8243:
$L8230:

; 82   : 	}						// for each resource

	jmp	$L8227
$L8228:

; 83   : 
; 84   : 
; 85   : 
; 86   : 	return status;

	mov	eax, DWORD PTR _status$[ebp]
$L8212:

; 87   : }							// TxP_StartDevice

	mov	esp, ebp
	pop	ebp
	ret	12					; 0000000cH
?TxP_StartDevice@@YGJPAU_DEVICE_OBJECT@@PAU_CM_PARTIAL_RESOURCE_LIST@@1@Z ENDP ; TxP_StartDevice
page	ENDS
PUBLIC	?TxP_InterruptService@@YGEPAU_KINTERRUPT@@PAX@Z	; TxP_InterruptService
EXTRN	__imp__IoConnectInterrupt@44:NEAR
;	COMDAT ?TxP_ConnectInterrupt@@YGJPAU_DEVICE_EXTENSION@@@Z
page	SEGMENT
_pdx$ = 8
_status$ = -4
?TxP_ConnectInterrupt@@YGJPAU_DEVICE_EXTENSION@@@Z PROC NEAR ; TxP_ConnectInterrupt, COMDAT

; 94   : {							// TxP_ConnectInterrupt

	push	ebp
	mov	ebp, esp
	push	ecx

; 95   : 
; 96   : 	NTSTATUS status;
; 97   : /*
; 98   : 	// Before actually connecting the interrupt let's initialize our channel and
; 99   : 	// interrupt variables.
; 100  : 	// These will be used in our ISR (TxP_InterruptService()).
; 101  : 	pdx->IntCount = 0;
; 102  : 	pdx->PrevIntTime = 0;
; 103  : 	pdx->GotIntTime = 0;
; 104  : 	pdx->PulseLength = 0;
; 105  : 	pdx->GotSync = 0;
; 106  : 	pdx->ChannelCount = 0;
; 107  : 	pdx->SyncPulse = 0;
; 108  : 	pdx->Ch1 = 0;
; 109  : 	pdx->Ch2 = 0;
; 110  : 	pdx->Ch3 = 0;
; 111  : 	pdx->Ch4 = 0;
; 112  : 	pdx->Ch5 = 0;
; 113  : 	pdx->Ch6 = 0;
; 114  : 	pdx->Ch7 = 0;
; 115  : 	pdx->Ch8 = 0;
; 116  : 	pdx->Ch9 = 0;
; 117  : 	pdx->Ch10 = 0;
; 118  : */
; 119  : 
; 120  : 	// test
; 121  : 	//pdx->Ch5 = 1750;
; 122  : 
; 123  : 	
; 124  : 	// NOTE: We must use parport's IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT
; 125  : 	// instead of IoConnectInterrupt()
; 126  : 	// Connect the interrupt
; 127  :     status = IoConnectInterrupt( &(pdx->InterruptObject),
; 128  :                                  TxP_InterruptService,
; 129  :                                  pdx,
; 130  :                                  NULL,
; 131  :                                  pdx->Vector,
; 132  :                                  pdx->Irql,
; 133  :                                  pdx->SynchronizeIrql,
; 134  :                                  pdx->InterruptMode,
; 135  :                                  pdx->ShareVector,
; 136  :                                  pdx->ProcessorEnableMask,
; 137  :                                  pdx->FloatingSave );

	mov	eax, DWORD PTR _pdx$[ebp]
	mov	cl, BYTE PTR [eax+52]
	push	ecx
	mov	edx, DWORD PTR _pdx$[ebp]
	mov	eax, DWORD PTR [edx+48]
	push	eax
	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	dl, BYTE PTR [ecx+44]
	push	edx
	mov	eax, DWORD PTR _pdx$[ebp]
	mov	ecx, DWORD PTR [eax+40]
	push	ecx
	mov	edx, DWORD PTR _pdx$[ebp]
	mov	al, BYTE PTR [edx+37]
	push	eax
	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	dl, BYTE PTR [ecx+36]
	push	edx
	mov	eax, DWORD PTR _pdx$[ebp]
	mov	ecx, DWORD PTR [eax+32]
	push	ecx
	push	0
	mov	edx, DWORD PTR _pdx$[ebp]
	push	edx
	push	OFFSET FLAT:?TxP_InterruptService@@YGEPAU_KINTERRUPT@@PAX@Z ; TxP_InterruptService
	mov	eax, DWORD PTR _pdx$[ebp]
	add	eax, 20					; 00000014H
	push	eax
	call	DWORD PTR __imp__IoConnectInterrupt@44
	mov	DWORD PTR _status$[ebp], eax

; 138  : 
; 139  : 
; 140  : 
; 141  : 	//; Enable IRQ on Par. Port!!!!!!!!!!
; 142  : 	//_asm {
; 143  : 	//						//; Enable IRQ on Par. Port!!!!!!!!!!
; 144  : 	//	mov	dx, 378h+2		//; got to use dx for ports > 255 (dec)
; 145  : 	//	in	al, dx			//; read par. port Control register (378h + 2)
; 146  : 	//	or 	al, 10h			//; enable interrupts on line 10 (ACK) (set bit 4)
; 147  : 	//	out	dx, al			//; write back to Control register
; 148  : 	//}
; 149  : 
; 150  : 
; 151  : 	return status;

	mov	eax, DWORD PTR _status$[ebp]

; 152  : }							// TxP_ConnectInterrupt

	mov	esp, ebp
	pop	ebp
	ret	4
?TxP_ConnectInterrupt@@YGJPAU_DEVICE_EXTENSION@@@Z ENDP	; TxP_ConnectInterrupt
page	ENDS
;	COMDAT ?TxP_InterruptService@@YGEPAU_KINTERRUPT@@PAX@Z
_TEXT	SEGMENT
_ServiceContext$ = 12
_pdx$ = -4
?TxP_InterruptService@@YGEPAU_KINTERRUPT@@PAX@Z PROC NEAR ; TxP_InterruptService, COMDAT

; 160  : {							// TxP_InterruptService

	push	ebp
	mov	ebp, esp
	push	ecx

; 161  : 
; 162  : 	// Our ServiceContext is the device extension (third param of IoConnectInterrupt())
; 163  : 	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) ServiceContext;

	mov	eax, DWORD PTR _ServiceContext$[ebp]
	mov	DWORD PTR _pdx$[ebp], eax

; 164  : 
; 165  : 	// test
; 166  : 	pdx->Ch5 = 1750;

	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR [ecx+100], 1750		; 000006d6H

; 167  : 
; 168  : /*
; 169  : 	// Keep count of how many interrupts we processed
; 170  : 	pdx->IntCount++;
; 171  : 
; 172  : 	// Start time stamping: we need resolution fine enough for 1000-2000 uS (1-2 ms)
; 173  : 	// KeQueryTickCount()			coarse grained
; 174  : 	// KeQueryInterruptTime()		fine grained: 100-nanosecond units == 0.1 uS
; 175  : 	// KeQueryPerformanceCounter()	finest grained
; 176  : 
; 177  : 	// Time stamp first interrupt
; 178  : 	if ( !pdx->GotIntTime ) {
; 179  : 		pdx->PrevIntTime = (int)KeQueryInterruptTime();
; 180  : 		pdx->GotIntTime = true;
; 181  : 		return TRUE;
; 182  : 	}
; 183  : 
; 184  : 	// Subtract previous time stamp from current time stamp
; 185  : 	// We don't need ULONGLONG, only int
; 186  : 	pdx->PulseLength = (int)KeQueryInterruptTime() - pdx->PrevIntTime;
; 187  : 
; 188  : 	// Save current time stamp for next time
; 189  : 	pdx->PrevIntTime = (int)KeQueryInterruptTime();
; 190  : 
; 191  : 	// If timer goes from FFFFFFFFh to 00000000h we get a great negative value:
; 192  : 	// Compensate it
; 193  : 	if ( pdx->PulseLength < 0 )
; 194  : 		pdx->PulseLength += 0xFFFFFFFF;
; 195  : 
; 196  : 	// It is more convenient to work with with 1 uS units
; 197  : 	pdx->PulseLength /= 10;
; 198  : 
; 199  : 	// Check if it is the sync pulse
; 200  : 	if ( pdx->PulseLength > 5000 ) {
; 201  : 		pdx->GotSync = true;
; 202  : 		pdx->ChannelCount = 0;
; 203  : 		pdx->SyncPulse = pdx->PulseLength;
; 204  : 		return TRUE;
; 205  : 	}
; 206  : 
; 207  : 	// Set channels
; 208  : 	if ( pdx->GotSync ) {
; 209  : 		pdx->ChannelCount++;
; 210  : 
; 211  : 		switch ( pdx->ChannelCount ) 
; 212  : 		{
; 213  : 			case 1: pdx->Ch1 = pdx->PulseLength; return TRUE; break;
; 214  : 			case 2: pdx->Ch2 = pdx->PulseLength; return TRUE; break;
; 215  : 			case 3: pdx->Ch3 = pdx->PulseLength; return TRUE; break;
; 216  : 			case 4: pdx->Ch4 = pdx->PulseLength; return TRUE; break;
; 217  : 			case 5: pdx->Ch5 = pdx->PulseLength; return TRUE; break;
; 218  : 			case 6: pdx->Ch6 = pdx->PulseLength; return TRUE; break;
; 219  : 			case 7: pdx->Ch7 = pdx->PulseLength; return TRUE; break;
; 220  : 			case 8: pdx->Ch8 = pdx->PulseLength; return TRUE; break;
; 221  : 			case 9: pdx->Ch9 = pdx->PulseLength; return TRUE; break;
; 222  : 			case 10: pdx->Ch10 = pdx->PulseLength; return TRUE; break;
; 223  : 		}
; 224  : 	}
; 225  : 
; 226  : 	// test
; 227  : 	//pdx->Ch3 = 1750;
; 228  : */
; 229  : 	return TRUE;

	mov	al, 1

; 230  : }							// TxP_InterruptService

	mov	esp, ebp
	pop	ebp
	ret	8
?TxP_InterruptService@@YGEPAU_KINTERRUPT@@PAX@Z ENDP	; TxP_InterruptService
_TEXT	ENDS
END
