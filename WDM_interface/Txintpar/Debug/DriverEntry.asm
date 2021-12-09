	TITLE	E:\WDM_interface\Txintpar\DriverEntry.cpp
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
_BSS	SEGMENT PARA USE32 PUBLIC 'BSS'
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
init	SEGMENT PARA USE32 PUBLIC ''
init	ENDS
;	COMDAT _IsEqualGUID@8
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _==@8
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _DriverEntry@8
init	SEGMENT PARA USE32 PUBLIC ''
init	ENDS
;	COMDAT ?TxintPar_DriverUnload@@YGXPAU_DRIVER_OBJECT@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT ?TxP_ForwardAndWait@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
page	SEGMENT PARA USE32 PUBLIC ''
page	ENDS
;	COMDAT ?TxP_OnRequestComplete@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAU_KEVENT@@@Z
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT __chkesp
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
;	COMDAT _GUID_DEVCLASS_HDC
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_FDC
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_GPS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_INFRARED
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_SYSTEM
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MONITOR
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_TXINT_PAR
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_DISKDRIVE
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_USB
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NET
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_FLOPPYDISK
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_IMAGE
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_KEYBOARD
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_PRINTER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MEDIUM_CHANGER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_HIDCLASS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_SOUND
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MTD
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_CDROM
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_PRINTERUPGRADE
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_BATTERY
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_COMPUTER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_SMARTCARDREADER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_SCSIADAPTER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MODEM
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_LEGACYDRIVER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_UNKNOWN
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_ADAPTER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_DISPLAY
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_PORTS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NETSERVICE
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NODRIVER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_VOLUME
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MULTIPORTSERIAL
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_PCMCIA
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NETTRANS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MULTIFUNCTION
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_TAPEDRIVE
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_APMSUPPORT
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_1394
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MOUSE
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NETCLIENT
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_DECODER
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MEDIA
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_GUID_DEVCLASS_1394
PUBLIC	_GUID_DEVCLASS_ADAPTER
PUBLIC	_GUID_DEVCLASS_APMSUPPORT
PUBLIC	_GUID_DEVCLASS_BATTERY
PUBLIC	_GUID_DEVCLASS_CDROM
PUBLIC	_GUID_DEVCLASS_COMPUTER
PUBLIC	_GUID_DEVCLASS_DECODER
PUBLIC	_GUID_DEVCLASS_DISKDRIVE
PUBLIC	_GUID_DEVCLASS_DISPLAY
PUBLIC	_GUID_DEVCLASS_FDC
PUBLIC	_GUID_DEVCLASS_FLOPPYDISK
PUBLIC	_GUID_DEVCLASS_GPS
PUBLIC	_GUID_DEVCLASS_HDC
PUBLIC	_GUID_DEVCLASS_HIDCLASS
PUBLIC	_GUID_DEVCLASS_IMAGE
PUBLIC	_GUID_DEVCLASS_INFRARED
PUBLIC	_GUID_DEVCLASS_KEYBOARD
PUBLIC	_GUID_DEVCLASS_LEGACYDRIVER
PUBLIC	_GUID_DEVCLASS_MEDIA
PUBLIC	_GUID_DEVCLASS_MEDIUM_CHANGER
PUBLIC	_GUID_DEVCLASS_MODEM
PUBLIC	_GUID_DEVCLASS_MONITOR
PUBLIC	_GUID_DEVCLASS_MOUSE
PUBLIC	_GUID_DEVCLASS_MTD
PUBLIC	_GUID_DEVCLASS_MULTIFUNCTION
PUBLIC	_GUID_DEVCLASS_MULTIPORTSERIAL
PUBLIC	_GUID_DEVCLASS_NET
PUBLIC	_GUID_DEVCLASS_NETCLIENT
PUBLIC	_GUID_DEVCLASS_NETSERVICE
PUBLIC	_GUID_DEVCLASS_NETTRANS
PUBLIC	_GUID_DEVCLASS_NODRIVER
PUBLIC	_GUID_DEVCLASS_PCMCIA
PUBLIC	_GUID_DEVCLASS_PORTS
PUBLIC	_GUID_DEVCLASS_PRINTER
PUBLIC	_GUID_DEVCLASS_PRINTERUPGRADE
PUBLIC	_GUID_DEVCLASS_SCSIADAPTER
PUBLIC	_GUID_DEVCLASS_SMARTCARDREADER
PUBLIC	_GUID_DEVCLASS_SOUND
PUBLIC	_GUID_DEVCLASS_SYSTEM
PUBLIC	_GUID_DEVCLASS_TAPEDRIVE
PUBLIC	_GUID_DEVCLASS_UNKNOWN
PUBLIC	_GUID_DEVCLASS_USB
PUBLIC	_GUID_DEVCLASS_VOLUME
PUBLIC	_GUID_TXINT_PAR
PUBLIC	?pdxDummy@@3U_DEVICE_EXTENSION@@A		; pdxDummy
_BSS	SEGMENT
?pdxDummy@@3U_DEVICE_EXTENSION@@A DB 0b0H DUP (?)	; pdxDummy
_BSS	ENDS
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
;	COMDAT _GUID_DEVCLASS_1394
CONST	SEGMENT
_GUID_DEVCLASS_1394 DD 06bdd1fc1H
	DW	0810fH
	DW	011d0H
	DB	0beH
	DB	0c7H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e2H
	DB	09H
	DB	02fH
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_ADAPTER
CONST	SEGMENT
_GUID_DEVCLASS_ADAPTER DD 04d36e964H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_APMSUPPORT
CONST	SEGMENT
_GUID_DEVCLASS_APMSUPPORT DD 0d45b1c18H
	DW	0c8faH
	DW	011d1H
	DB	09fH
	DB	077H
	DB	00H
	DB	00H
	DB	0f8H
	DB	05H
	DB	0f5H
	DB	030H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_BATTERY
CONST	SEGMENT
_GUID_DEVCLASS_BATTERY DD 072631e54H
	DW	078a4H
	DW	011d0H
	DB	0bcH
	DB	0f7H
	DB	00H
	DB	0aaH
	DB	00H
	DB	0b7H
	DB	0b3H
	DB	02aH
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_CDROM
CONST	SEGMENT
_GUID_DEVCLASS_CDROM DD 04d36e965H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_COMPUTER
CONST	SEGMENT
_GUID_DEVCLASS_COMPUTER DD 04d36e966H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_DECODER
CONST	SEGMENT
_GUID_DEVCLASS_DECODER DD 06bdd1fc2H
	DW	0810fH
	DW	011d0H
	DB	0beH
	DB	0c7H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e2H
	DB	09H
	DB	02fH
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_DISKDRIVE
CONST	SEGMENT
_GUID_DEVCLASS_DISKDRIVE DD 04d36e967H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_DISPLAY
CONST	SEGMENT
_GUID_DEVCLASS_DISPLAY DD 04d36e968H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_FDC
CONST	SEGMENT
_GUID_DEVCLASS_FDC DD 04d36e969H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_FLOPPYDISK
CONST	SEGMENT
_GUID_DEVCLASS_FLOPPYDISK DD 04d36e980H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_GPS
CONST	SEGMENT
_GUID_DEVCLASS_GPS DD 06bdd1fc3H
	DW	0810fH
	DW	011d0H
	DB	0beH
	DB	0c7H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e2H
	DB	09H
	DB	02fH
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_HDC
CONST	SEGMENT
_GUID_DEVCLASS_HDC DD 04d36e96aH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_HIDCLASS
CONST	SEGMENT
_GUID_DEVCLASS_HIDCLASS DD 0745a17a0H
	DW	074d3H
	DW	011d0H
	DB	0b6H
	DB	0feH
	DB	00H
	DB	0a0H
	DB	0c9H
	DB	0fH
	DB	057H
	DB	0daH
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_IMAGE
CONST	SEGMENT
_GUID_DEVCLASS_IMAGE DD 06bdd1fc6H
	DW	0810fH
	DW	011d0H
	DB	0beH
	DB	0c7H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e2H
	DB	09H
	DB	02fH
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_INFRARED
CONST	SEGMENT
_GUID_DEVCLASS_INFRARED DD 06bdd1fc5H
	DW	0810fH
	DW	011d0H
	DB	0beH
	DB	0c7H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e2H
	DB	09H
	DB	02fH
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_KEYBOARD
CONST	SEGMENT
_GUID_DEVCLASS_KEYBOARD DD 04d36e96bH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_LEGACYDRIVER
CONST	SEGMENT
_GUID_DEVCLASS_LEGACYDRIVER DD 08ecc055dH
	DW	047fH
	DW	011d1H
	DB	0a5H
	DB	037H
	DB	00H
	DB	00H
	DB	0f8H
	DB	075H
	DB	03eH
	DB	0d1H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MEDIA
CONST	SEGMENT
_GUID_DEVCLASS_MEDIA DD 04d36e96cH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MEDIUM_CHANGER
CONST	SEGMENT
_GUID_DEVCLASS_MEDIUM_CHANGER DD 0ce5939aeH
	DW	0ebdeH
	DW	011d0H
	DB	0b1H
	DB	081H
	DB	00H
	DB	00H
	DB	0f8H
	DB	075H
	DB	03eH
	DB	0c4H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MODEM
CONST	SEGMENT
_GUID_DEVCLASS_MODEM DD 04d36e96dH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MONITOR
CONST	SEGMENT
_GUID_DEVCLASS_MONITOR DD 04d36e96eH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MOUSE
CONST	SEGMENT
_GUID_DEVCLASS_MOUSE DD 04d36e96fH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MTD
CONST	SEGMENT
_GUID_DEVCLASS_MTD DD 04d36e970H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MULTIFUNCTION
CONST	SEGMENT
_GUID_DEVCLASS_MULTIFUNCTION DD 04d36e971H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_MULTIPORTSERIAL
CONST	SEGMENT
_GUID_DEVCLASS_MULTIPORTSERIAL DD 050906cb8H
	DW	0ba12H
	DW	011d1H
	DB	0bfH
	DB	05dH
	DB	00H
	DB	00H
	DB	0f8H
	DB	05H
	DB	0f5H
	DB	030H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NET
CONST	SEGMENT
_GUID_DEVCLASS_NET DD 04d36e972H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NETCLIENT
CONST	SEGMENT
_GUID_DEVCLASS_NETCLIENT DD 04d36e973H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NETSERVICE
CONST	SEGMENT
_GUID_DEVCLASS_NETSERVICE DD 04d36e974H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NETTRANS
CONST	SEGMENT
_GUID_DEVCLASS_NETTRANS DD 04d36e975H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_NODRIVER
CONST	SEGMENT
_GUID_DEVCLASS_NODRIVER DD 04d36e976H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_PCMCIA
CONST	SEGMENT
_GUID_DEVCLASS_PCMCIA DD 04d36e977H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_PORTS
CONST	SEGMENT
_GUID_DEVCLASS_PORTS DD 04d36e978H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_PRINTER
CONST	SEGMENT
_GUID_DEVCLASS_PRINTER DD 04d36e979H
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_PRINTERUPGRADE
CONST	SEGMENT
_GUID_DEVCLASS_PRINTERUPGRADE DD 04d36e97aH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_SCSIADAPTER
CONST	SEGMENT
_GUID_DEVCLASS_SCSIADAPTER DD 04d36e97bH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_SMARTCARDREADER
CONST	SEGMENT
_GUID_DEVCLASS_SMARTCARDREADER DD 050dd5230H
	DW	0ba8aH
	DW	011d1H
	DB	0bfH
	DB	05dH
	DB	00H
	DB	00H
	DB	0f8H
	DB	05H
	DB	0f5H
	DB	030H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_SOUND
CONST	SEGMENT
_GUID_DEVCLASS_SOUND DD 04d36e97cH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_SYSTEM
CONST	SEGMENT
_GUID_DEVCLASS_SYSTEM DD 04d36e97dH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_TAPEDRIVE
CONST	SEGMENT
_GUID_DEVCLASS_TAPEDRIVE DD 06d807884H
	DW	07d21H
	DW	011cfH
	DB	080H
	DB	01cH
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_UNKNOWN
CONST	SEGMENT
_GUID_DEVCLASS_UNKNOWN DD 04d36e97eH
	DW	0e325H
	DW	011ceH
	DB	0bfH
	DB	0c1H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e1H
	DB	03H
	DB	018H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_USB
CONST	SEGMENT
_GUID_DEVCLASS_USB DD 036fc9e60H
	DW	0c465H
	DW	011cfH
	DB	080H
	DB	056H
	DB	044H
	DB	045H
	DB	053H
	DB	054H
	DB	00H
	DB	00H
CONST	ENDS
;	COMDAT _GUID_DEVCLASS_VOLUME
CONST	SEGMENT
_GUID_DEVCLASS_VOLUME DD 071a27cddH
	DW	0812aH
	DW	011d0H
	DB	0beH
	DB	0c7H
	DB	08H
	DB	00H
	DB	02bH
	DB	0e2H
	DB	09H
	DB	02fH
CONST	ENDS
;	COMDAT _GUID_TXINT_PAR
CONST	SEGMENT
_GUID_TXINT_PAR DD 0c8ebdfb0H
	DW	0b510H
	DW	011d0H
	DB	080H
	DB	0e9H
	DB	00H
	DB	00H
	DB	0f8H
	DB	01eH
	DB	01bH
	DB	030H
CONST	ENDS
_DATA	SEGMENT
	ORG $+1
_?devcount@?6??TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z@4JA$S8828 DD 0ffffffffH
_DATA	ENDS
PUBLIC	?TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z ; TxintPar_AddDevice
PUBLIC	?TxintPar_DriverUnload@@YGXPAU_DRIVER_OBJECT@@@Z ; TxintPar_DriverUnload
PUBLIC	_DriverEntry@8
EXTRN	?TxintPar_DispatchPnp@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z:NEAR ; TxintPar_DispatchPnp
EXTRN	?TxintPar_DispatchPower@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z:NEAR ; TxintPar_DispatchPower
EXTRN	?TxintPar_DispatchSystemControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z:NEAR ; TxintPar_DispatchSystemControl
EXTRN	?TxintPar_DispatchCreate@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z:NEAR ; TxintPar_DispatchCreate
EXTRN	?TxintPar_DispatchDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z:NEAR ; TxintPar_DispatchDeviceControl
;	COMDAT _DriverEntry@8
init	SEGMENT
_DriverObject$ = 8
_DriverEntry@8 PROC NEAR				; COMDAT

; 24   : {							// DriverEntry

	push	ebp
	mov	ebp, esp

; 25   : 	
; 26   : 	DriverObject->DriverExtension->AddDevice = TxintPar_AddDevice;

	mov	eax, DWORD PTR _DriverObject$[ebp]
	mov	ecx, DWORD PTR [eax+24]
	mov	DWORD PTR [ecx+4], OFFSET FLAT:?TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z ; TxintPar_AddDevice

; 27   : 	DriverObject->DriverUnload				 = TxintPar_DriverUnload;

	mov	edx, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [edx+52], OFFSET FLAT:?TxintPar_DriverUnload@@YGXPAU_DRIVER_OBJECT@@@Z ; TxintPar_DriverUnload

; 28   : 
; 29   : 	DriverObject->MajorFunction[IRP_MJ_PNP]			   = TxintPar_DispatchPnp;

	mov	eax, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [eax+164], OFFSET FLAT:?TxintPar_DispatchPnp@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchPnp

; 30   : 	DriverObject->MajorFunction[IRP_MJ_POWER]		   = TxintPar_DispatchPower;

	mov	ecx, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [ecx+144], OFFSET FLAT:?TxintPar_DispatchPower@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchPower

; 31   : 	DriverObject->MajorFunction[IRP_MJ_SYSTEM_CONTROL] = TxintPar_DispatchSystemControl;

	mov	edx, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [edx+148], OFFSET FLAT:?TxintPar_DispatchSystemControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchSystemControl

; 32   : 	DriverObject->MajorFunction[IRP_MJ_CREATE]		   = TxintPar_DispatchCreate;

	mov	eax, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [eax+56], OFFSET FLAT:?TxintPar_DispatchCreate@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchCreate

; 33   : 	
; 34   : 	// User-mode DeviceIoControl() calls will be routed here
; 35   :     DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL] = TxintPar_DispatchDeviceControl;

	mov	ecx, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [ecx+112], OFFSET FLAT:?TxintPar_DispatchDeviceControl@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxintPar_DispatchDeviceControl

; 36   : 	
; 37   : 	// Internal device control requests will be routed here
; 38   : 	// No: we don't need this, we should do this *to* parclass
; 39   : 	//DriverObject->MajorFunction[IRP_MJ_INTERNAL_DEVICE_CONTROL] = TxintPar_DispatchInternalDeviceControl;
; 40   : 	
; 41   : 	return STATUS_SUCCESS;

	xor	eax, eax

; 42   : }							// DriverEntry

	pop	ebp
	ret	8
_DriverEntry@8 ENDP
init	ENDS
EXTRN	__imp__RtlAssert@16:NEAR
EXTRN	__imp__KeGetCurrentIrql@0:NEAR
EXTRN	_DbgPrint:NEAR
;	COMDAT ?TxintPar_DriverUnload@@YGXPAU_DRIVER_OBJECT@@@Z
; File E:\WDM_interface\Txintpar\DriverEntry.cpp
page	SEGMENT
$SG8810	DB	'EX: Pageable code called at IRQL %d', 0aH, 00H
	ORG $+3
$SG8812	DB	'E:\WDM_interface\Txintpar\DriverEntry.cpp', 00H
	ORG $+2
$SG8813	DB	'FALSE', 00H
?TxintPar_DriverUnload@@YGXPAU_DRIVER_OBJECT@@@Z PROC NEAR ; TxintPar_DriverUnload, COMDAT

; 49   : {							// TxintPar_DriverUnload

	push	ebp
	mov	ebp, esp

; 50   : 	PAGED_CODE();

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	cmp	eax, 1
	jle	SHORT $L8809
	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	push	eax
	push	OFFSET FLAT:$SG8810
	call	_DbgPrint
	add	esp, 8
	mov	eax, 1
	test	eax, eax
	je	SHORT $L8811
	push	0
	push	50					; 00000032H
	push	OFFSET FLAT:$SG8812
	push	OFFSET FLAT:$SG8813
	call	DWORD PTR __imp__RtlAssert@16
$L8811:
$L8809:

; 51   : }							// TxintPar_DriverUnload

	pop	ebp
	ret	4
?TxintPar_DriverUnload@@YGXPAU_DRIVER_OBJECT@@@Z ENDP	; TxintPar_DriverUnload
page	ENDS
EXTRN	__imp__ExAllocatePoolWithTag@12:NEAR
EXTRN	__imp__IoAttachDeviceToDeviceStack@8:NEAR
EXTRN	__imp__IoCreateDevice@28:NEAR
EXTRN	__imp__IoCreateSymbolicLink@8:NEAR
EXTRN	__imp__IoDeleteDevice@4:NEAR
EXTRN	__except_handler3:NEAR
EXTRN	__except_list:DWORD
EXTRN	__imp___snwprintf:NEAR
EXTRN	__imp__RtlInitUnicodeString@8:NEAR
EXTRN	__imp_@InterlockedIncrement@4:NEAR
EXTRN	__imp__RtlCopyUnicodeString@8:NEAR
EXTRN	__imp__RtlFreeUnicodeString@4:NEAR
;	COMDAT ?TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z
; File E:\WDM_interface\Txintpar\DriverEntry.cpp
page	SEGMENT
$SG8818	DB	'EX: Pageable code called at IRQL %d', 0aH, 00H
	ORG $+3
$SG8820	DB	'E:\WDM_interface\Txintpar\DriverEntry.cpp', 00H
	ORG $+2
$SG8821	DB	'FALSE', 00H
	ORG $+2
$SG8829	DB	'\', 00H, 'D', 00H, 'e', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, '\', 00H, 'T', 00H, 'x', 00H, 'i', 00H, 'n', 00H, 't'
	DB	00H, 'P', 00H, 'a', 00H, 'r', 00H, '%', 00H, 'd', 00H, 00H, 00H
	ORG $+2
$SG8830	DB	'\', 00H, 'D', 00H, 'e', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, '\', 00H, 'T', 00H, 'x', 00H, 'i', 00H, 'n', 00H, 't'
	DB	00H, 'P', 00H, 'a', 00H, 'r', 00H, 00H, 00H
	ORG $+2
$SG8831	DB	'\', 00H, 'D', 00H, 'o', 00H, 's', 00H, 'D', 00H, 'e', 00H
	DB	'v', 00H, 'i', 00H, 'c', 00H, 'e', 00H, 's', 00H, '\', 00H, 'T'
	DB	00H, 'x', 00H, 'i', 00H, 'n', 00H, 't', 00H, 'P', 00H, 'a', 00H
	DB	'r', 00H, 00H, 00H
	ORG $+2
$SG8835	DB	'TxintPar - IoCreateDevice failed - %X', 0aH, 00H
	ORG $+1
$SG8843	DB	'TxintPar - Unable to allocate %d bytes for copy of name', 0aH
	DB	00H
page	ENDS
;	COMDAT CONST
CONST	SEGMENT
$T8988	DD	0ffffffffH
	DD	00H
	DD	FLAT:$L8985
CONST	ENDS
;	COMDAT ?TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z
page	SEGMENT
_DriverObject$ = 8
_pdo$ = 12
_status$ = -108
_fdo$ = -104
_devname$ = -32
_symlinkname$ = -116
_namebuf$ = -96
_pdx$ = -100
__$SEHRec$ = -24
?TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z PROC NEAR ; TxintPar_AddDevice, COMDAT

; 58   : {							// TxintPar_AddDevice

	push	ebp
	mov	ebp, esp
	push	-1
	push	OFFSET FLAT:$T8988
	push	OFFSET FLAT:__except_handler3
	mov	eax, DWORD PTR fs:__except_list
	push	eax
	mov	DWORD PTR fs:__except_list, esp
	add	esp, -100				; ffffff9cH
	push	ebx
	push	esi
	push	edi

; 59   : 	PAGED_CODE();

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	cmp	eax, 1
	jle	SHORT $L8817
	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	push	eax
	push	OFFSET FLAT:$SG8818
	call	_DbgPrint
	add	esp, 8
	mov	eax, 1
	test	eax, eax
	je	SHORT $L8819
	push	0
	push	59					; 0000003bH
	push	OFFSET FLAT:$SG8820
	push	OFFSET FLAT:$SG8821
	call	DWORD PTR __imp__RtlAssert@16
$L8819:
$L8817:

; 60   : 
; 61   : 	NTSTATUS status;
; 62   : 
; 63   : 	//////////////////////////////////////////////////////////
; 64   : 	// Create a functional device object to represent the hardware we're managing.
; 65   : 	PDEVICE_OBJECT fdo;
; 66   : 	
; 67   : 	// This is not done in WDM drivers
; 68   : 	UNICODE_STRING devname;
; 69   : 	UNICODE_STRING symlinkname;
; 70   : 	WCHAR namebuf[32];
; 71   : 	static LONG devcount = -1;
; 72   : 	_snwprintf(namebuf, arraysize(namebuf), L"\\Device\\TxintPar%d", InterlockedIncrement(&devcount));

	mov	ecx, OFFSET FLAT:_?devcount@?6??TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z@4JA$S8828
	call	DWORD PTR __imp_@InterlockedIncrement@4
	push	eax
	push	OFFSET FLAT:$SG8829
	push	32					; 00000020H
	lea	ecx, DWORD PTR _namebuf$[ebp]
	push	ecx
	call	DWORD PTR __imp___snwprintf
	add	esp, 16					; 00000010H

; 73   : 	//RtlInitUnicodeString(&devname, namebuf);
; 74   : 	RtlInitUnicodeString(&devname, L"\\Device\\TxintPar");

	push	OFFSET FLAT:$SG8830
	lea	edx, DWORD PTR _devname$[ebp]
	push	edx
	call	DWORD PTR __imp__RtlInitUnicodeString@8

; 75   : 	RtlInitUnicodeString(&symlinkname, L"\\DosDevices\\TxintPar");

	push	OFFSET FLAT:$SG8831
	lea	eax, DWORD PTR _symlinkname$[ebp]
	push	eax
	call	DWORD PTR __imp__RtlInitUnicodeString@8

; 76   : 
; 77   : 	// NOTE: TxintPar0 is the name that will be used in CreateFile() in the user-mode app
; 78   : 	// NO: there should be no name for PnP drivers!!!
; 79   : 	//
; 80   : 	// A Windows 2000 or WDM driver does not name its device objects. Instead, when the driver
; 81   : 	// calls IoCreateDevice to create a device object, it should specify a NULL string for the
; 82   : 	// device name. Bus drivers should set the FILE_AUTOGENERATED_DEVICE_NAME flag. All PnP 
; 83   : 	// function, filter, and bus drivers should set the FILE_DEVICE_SECURE_OPEN flag. In 
; 84   : 	// response, the system chooses a unique device name for the PDO.
; 85   : 	//
; 86   : 	// In the user-mode app use:
; 87   : 	// SetupDiGetClassDevs()
; 88   : 	// SetupDiEnumDeviceInterfaces()
; 89   : 	// SetupDiGetDeviceInterfaceDetail()
; 90   : 	// to get symbolic link name.
; 91   : 	//
; 92   : 	// DeviceInterfaceData points to a structure that identifies a requested device interface.
; 93   : 	// To get detailed information about an interface, call SetupDiGetDeviceInterfaceDetail. 
; 94   : 	// The detailed information includes the name of the device interface that can be passed
; 95   : 	// to a Win32® function such as CreateFile to get a handle to the interface.
; 96   : 	//
; 97   : 	//
; 98   : 	// Create the functional device object
; 99   : 	//status = IoCreateDevice(DriverObject, sizeof(DEVICE_EXTENSION), &devname,
; 100  : 	//	FILE_DEVICE_UNKNOWN, 0, FALSE, &fdo);
; 101  : 	//
; 102  : 	// Should make FILE_DEVICE_PARALLEL_PORT (see: parsimp)
; 103  : 	status = IoCreateDevice(DriverObject, sizeof(DEVICE_EXTENSION), &devname,
; 104  : 		FILE_DEVICE_PARALLEL_PORT, 0, FALSE, &fdo);

	lea	ecx, DWORD PTR _fdo$[ebp]
	push	ecx
	push	0
	push	0
	push	22					; 00000016H
	lea	edx, DWORD PTR _devname$[ebp]
	push	edx
	push	176					; 000000b0H
	mov	eax, DWORD PTR _DriverObject$[ebp]
	push	eax
	call	DWORD PTR __imp__IoCreateDevice@28
	mov	DWORD PTR _status$[ebp], eax

; 105  : 
; 106  : 
; 107  : 	if (!NT_SUCCESS(status))

	cmp	DWORD PTR _status$[ebp], 0
	jge	SHORT $L8834

; 109  : 		KdPrint(("TxintPar - "
; 110  : 			"IoCreateDevice failed - %X\n", status));

	mov	ecx, DWORD PTR _status$[ebp]
	push	ecx
	push	OFFSET FLAT:$SG8835
	call	_DbgPrint
	add	esp, 8

; 111  : 		return status;

	mov	eax, DWORD PTR _status$[ebp]
	jmp	$L8816
$L8834:

; 113  : 
; 114  : 
; 115  : 	// Now that the device has been created,
; 116  :     // set up the device extension.
; 117  : 	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	mov	edx, DWORD PTR _fdo$[ebp]
	mov	eax, DWORD PTR [edx+40]
	mov	DWORD PTR _pdx$[ebp], eax

; 118  : 	RtlZeroMemory(pdx, sizeof(DEVICE_EXTENSION));

	mov	ecx, 44					; 0000002cH
	xor	eax, eax
	mov	edi, DWORD PTR _pdx$[ebp]
	rep stosd

; 119  : 
; 120  : 
; 121  :     //ObDereferenceObject(fileObject);
; 122  : 
; 123  :     //extension->DeviceObject->StackSize =
; 124  :     //        extension->PortDeviceObject->StackSize + 1;
; 125  : 
; 126  : 
; 127  :     // Initialize an empty work queue.
; 128  :     InitializeListHead(&pdx->WorkQueue);

	mov	ecx, DWORD PTR _pdx$[ebp]
	add	ecx, 68					; 00000044H
	mov	edx, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR [edx+72], ecx
	mov	eax, DWORD PTR _pdx$[ebp]
	mov	ecx, DWORD PTR _pdx$[ebp]
	mov	edx, DWORD PTR [ecx+72]
	mov	DWORD PTR [eax+68], edx

; 129  :     pdx->CurrentIrp = NULL;

	mov	eax, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR [eax+76], 0

; 130  : 
; 131  : 
; 132  : 	
; 133  : 	// This is not done by PnP drivers, use IoRegisterDeviceInterface() instead
; 134  : 	status = IoCreateSymbolicLink( &symlinkname, &devname );

	lea	ecx, DWORD PTR _devname$[ebp]
	push	ecx
	lea	edx, DWORD PTR _symlinkname$[ebp]
	push	edx
	call	DWORD PTR __imp__IoCreateSymbolicLink@8
	mov	DWORD PTR _status$[ebp], eax

; 135  : 
; 136  : 	
; 137  : 	/*/////////////////////////////////////////////////////////////
; 138  : 	// Now we have to register the device interface to make sure CreateFile() can find 
; 139  : 	// the symbolic name
; 140  : 	UNICODE_STRING SymbolicLinkName;
; 141  : 	RtlInitUnicodeString(&SymbolicLinkName, NULL);
; 142  : 
; 143  : 	status = IoRegisterDeviceInterface( pdo,
; 144  : 										&GUID_DEVCLASS_MEDIA,
; 145  : 										NULL,
; 146  : 										&SymbolicLinkName );
; 147  : 
; 148  : 	if (!NT_SUCCESS(status))
; 149  : 	{						// can't register device interface
; 150  : 		KdPrint(("TxintPar - "
; 151  : 			"IoRegisterDeviceInterface failed - %X\n", status));
; 152  : 		return status;
; 153  : 	}						// can't register device interface
; 154  : 	//////////////////////////////////////////////////////////////*/
; 155  : 
; 156  : 
; 157  : 	/*/////////////////////////////////////////////////////////////
; 158  : 	// Now we still have to enable the device interface
; 159  : 	// NOTE: we do this in response to an IRP_MN_START_DEVICE because
; 160  : 	// TxP_StartDevice gets called on IRP_MN_START_DEVICE
; 161  : 	status = IoSetDeviceInterfaceState( &SymbolicLinkName,
; 162  : 										TRUE );
; 163  : 
; 164  : 	if (!NT_SUCCESS(status))
; 165  : 	{						// can't enable device interface
; 166  : 		KdPrint(("TxintPar - "
; 167  : 			"IoSetDeviceInterfaceState failed - %X\n", status));
; 168  : 		return status;
; 169  : 	}						// can't enable device interface
; 170  : 	//////////////////////////////////////////////////////////////*/
; 171  : 
; 172  : 
; 173  : 	// RtlFreeUnicodeString(&SymbolicLinkName);
; 174  : 
; 175  : 
; 176  : 	
; 177  : 	// From this point forward, any error will have side effects that need to
; 178  : 	// be cleaned up. Using a try-finally block allows us to modify the program
; 179  : 	// easily without losing track of the side effects.
; 180  : 
; 181  : 	__try

	mov	DWORD PTR __$SEHRec$[ebp+20], 0

; 183  : 		pdx->DeviceObject = fdo;

	mov	eax, DWORD PTR _pdx$[ebp]
	mov	ecx, DWORD PTR _fdo$[ebp]
	mov	DWORD PTR [eax], ecx

; 184  : 		pdx->Pdo = pdo;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	eax, DWORD PTR _pdo$[ebp]
	mov	DWORD PTR [edx+8], eax

; 185  : 
; 186  : 		// Make a copy of the device name
; 187  : 		// Should we do this with the SymbolicLinkName instead?
; 188  : 		pdx->devname.Buffer = (PWCHAR) ExAllocatePool(NonPagedPool, devname.MaximumLength);

	push	544040023				; 206d6457H
	mov	ecx, DWORD PTR _devname$[ebp+2]
	and	ecx, 65535				; 0000ffffH
	push	ecx
	push	0
	call	DWORD PTR __imp__ExAllocatePoolWithTag@12
	mov	edx, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR [edx+16], eax

; 189  : 		if (!pdx->devname.Buffer)

	mov	eax, DWORD PTR _pdx$[ebp]
	cmp	DWORD PTR [eax+16], 0
	jne	SHORT $L8841

; 191  : 			status = STATUS_INSUFFICIENT_RESOURCES;

	mov	DWORD PTR _status$[ebp], -1073741670	; c000009aH

; 192  : 			KdPrint(("TxintPar - "
; 193  : 				"Unable to allocate %d bytes for copy of name\n", devname.MaximumLength));

	mov	ecx, DWORD PTR _devname$[ebp+2]
	and	ecx, 65535				; 0000ffffH
	push	ecx
	push	OFFSET FLAT:$SG8843
	call	_DbgPrint
	add	esp, 8

; 194  : 			__leave;

	jmp	SHORT $L8839
$L8841:

; 196  : 		pdx->devname.MaximumLength = devname.MaximumLength;

	mov	edx, DWORD PTR _pdx$[ebp]
	mov	ax, WORD PTR _devname$[ebp+2]
	mov	WORD PTR [edx+14], ax

; 197  : 		RtlCopyUnicodeString(&pdx->devname, &devname);

	lea	ecx, DWORD PTR _devname$[ebp]
	push	ecx
	mov	edx, DWORD PTR _pdx$[ebp]
	add	edx, 12					; 0000000cH
	push	edx
	call	DWORD PTR __imp__RtlCopyUnicodeString@8

; 198  : 
; 199  : 		fdo->Flags |= DO_POWER_PAGABLE;

	mov	eax, DWORD PTR _fdo$[ebp]
	mov	ecx, DWORD PTR [eax+28]
	or	ch, 32					; 00000020H
	mov	edx, DWORD PTR _fdo$[ebp]
	mov	DWORD PTR [edx+28], ecx

; 200  : 
; 201  : 		// Attach device to device stack
; 202  : 		pdx->LowerDeviceObject = IoAttachDeviceToDeviceStack(fdo, pdo);

	mov	eax, DWORD PTR _pdo$[ebp]
	push	eax
	mov	ecx, DWORD PTR _fdo$[ebp]
	push	ecx
	call	DWORD PTR __imp__IoAttachDeviceToDeviceStack@8
	mov	edx, DWORD PTR _pdx$[ebp]
	mov	DWORD PTR [edx+4], eax

; 203  : 		fdo->Flags &= ~DO_DEVICE_INITIALIZING;

	mov	eax, DWORD PTR _fdo$[ebp]
	mov	ecx, DWORD PTR [eax+28]
	and	cl, 127					; 0000007fH
	mov	edx, DWORD PTR _fdo$[ebp]
	mov	DWORD PTR [edx+28], ecx
$L8839:

; 204  : 	}						// finish initialization

	mov	DWORD PTR __$SEHRec$[ebp+20], -1
	call	$L8985
	jmp	SHORT $L8987
$L8985:

; 207  : 		if (!NT_SUCCESS(status))

	cmp	DWORD PTR _status$[ebp], 0
	jge	SHORT $L8845

; 209  : 			if (pdx->devname.Buffer)

	mov	eax, DWORD PTR _pdx$[ebp]
	cmp	DWORD PTR [eax+16], 0
	je	SHORT $L8846

; 210  : 				RtlFreeUnicodeString(&pdx->devname);

	mov	ecx, DWORD PTR _pdx$[ebp]
	add	ecx, 12					; 0000000cH
	push	ecx
	call	DWORD PTR __imp__RtlFreeUnicodeString@4
$L8846:

; 211  : 			IoDeleteDevice(fdo);

	mov	edx, DWORD PTR _fdo$[ebp]
	push	edx
	call	DWORD PTR __imp__IoDeleteDevice@4
$L8845:
$L8986:

; 213  : 	}						// cleanup side effects

	ret	0
$L8987:

; 214  : 
; 215  : 	return STATUS_SUCCESS;

	xor	eax, eax
$L8816:

; 216  : }							// TxintPar_AddDevice

	mov	ecx, DWORD PTR __$SEHRec$[ebp+8]
	mov	DWORD PTR fs:__except_list, ecx
	pop	edi
	pop	esi
	pop	ebx
	mov	esp, ebp
	pop	ebp
	ret	8
?TxintPar_AddDevice@@YGJPAU_DRIVER_OBJECT@@PAU_DEVICE_OBJECT@@@Z ENDP ; TxintPar_AddDevice
page	ENDS
PUBLIC	?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z		; TxP_CompleteRequest
EXTRN	__imp_@IofCompleteRequest@8:NEAR
;	COMDAT ?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z
_TEXT	SEGMENT
_Irp$ = 8
_status$ = 12
_info$ = 16
?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z PROC NEAR	; TxP_CompleteRequest, COMDAT

; 225  : {							// TxP_CompleteRequest

	push	ebp
	mov	ebp, esp

; 226  : 	Irp->IoStatus.Status = status;

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	ecx, DWORD PTR _status$[ebp]
	mov	DWORD PTR [eax+24], ecx

; 227  : 	Irp->IoStatus.Information = info;

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR _info$[ebp]
	mov	DWORD PTR [edx+28], eax

; 228  : 	IoCompleteRequest(Irp, IO_NO_INCREMENT);

	xor	dl, dl
	mov	ecx, DWORD PTR _Irp$[ebp]
	call	DWORD PTR __imp_@IofCompleteRequest@8

; 229  : 	return status;

	mov	eax, DWORD PTR _status$[ebp]

; 230  : }							// TxP_CompleteRequest

	pop	ebp
	ret	12					; 0000000cH
?TxP_CompleteRequest@@YGJPAU_IRP@@JK@Z ENDP		; TxP_CompleteRequest
_TEXT	ENDS
PUBLIC	?TxP_OnRequestComplete@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAU_KEVENT@@@Z ; TxP_OnRequestComplete
PUBLIC	?TxP_ForwardAndWait@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ; TxP_ForwardAndWait
EXTRN	__imp_@IofCallDriver@8:NEAR
EXTRN	__imp__KeInitializeEvent@12:NEAR
EXTRN	__imp__KeWaitForSingleObject@20:NEAR
;	COMDAT ?TxP_ForwardAndWait@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z
; File E:\WDM_interface\Txintpar\DriverEntry.cpp
page	SEGMENT
$SG8857	DB	'E:\WDM_interface\Txintpar\DriverEntry.cpp', 00H
	ORG $+2
$SG8858	DB	'KeGetCurrentIrql() == PASSIVE_LEVEL', 00H
$SG8860	DB	'EX: Pageable code called at IRQL %d', 0aH, 00H
	ORG $+3
$SG8862	DB	'E:\WDM_interface\Txintpar\DriverEntry.cpp', 00H
	ORG $+2
$SG8863	DB	'FALSE', 00H
	ORG $+2
$SG8875	DB	'E:\WDM_interface\Txintpar\DriverEntry.cpp', 00H
	ORG $+2
$SG8876	DB	'(1) | (1) | (1) ? ((PIO_COMPLETION_ROUTINE) TxP_OnReques'
	DB	'tComplete) != NULL : TRUE', 00H
_fdo$ = 8
_Irp$ = 12
_event$ = -20
_irpSp$8865 = -28
_nextIrpSp$8866 = -24
_irpSp$8872 = -32
_pdx$ = -4
?TxP_ForwardAndWait@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z PROC NEAR ; TxP_ForwardAndWait, COMDAT

; 237  : {							// TxP_ForwardAndWait

	push	ebp
	mov	ebp, esp
	sub	esp, 32					; 00000020H
	push	esi
	push	edi

; 238  : 	ASSERT(KeGetCurrentIrql() == PASSIVE_LEVEL);

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	test	eax, eax
	je	SHORT $L8856
	push	0
	push	238					; 000000eeH
	push	OFFSET FLAT:$SG8857
	push	OFFSET FLAT:$SG8858
	call	DWORD PTR __imp__RtlAssert@16
$L8856:

; 239  : 	PAGED_CODE();

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	cmp	eax, 1
	jle	SHORT $L8859
	call	DWORD PTR __imp__KeGetCurrentIrql@0
	and	eax, 255				; 000000ffH
	push	eax
	push	OFFSET FLAT:$SG8860
	call	_DbgPrint
	add	esp, 8
	mov	eax, 1
	test	eax, eax
	je	SHORT $L8861
	push	0
	push	239					; 000000efH
	push	OFFSET FLAT:$SG8862
	push	OFFSET FLAT:$SG8863
	call	DWORD PTR __imp__RtlAssert@16
$L8861:
$L8859:

; 240  : 	
; 241  : 	KEVENT event;
; 242  : 	KeInitializeEvent(&event, NotificationEvent, FALSE);

	push	0
	push	0
	lea	ecx, DWORD PTR _event$[ebp]
	push	ecx
	call	DWORD PTR __imp__KeInitializeEvent@12

; 243  : 
; 244  : 	IoCopyCurrentIrpStackLocationToNext(Irp);

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR [edx+96]
	mov	DWORD PTR _irpSp$8865[ebp], eax
	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR [ecx+96]
	sub	edx, 36					; 00000024H
	mov	DWORD PTR _nextIrpSp$8866[ebp], edx
	mov	ecx, 7
	mov	esi, DWORD PTR _irpSp$8865[ebp]
	mov	edi, DWORD PTR _nextIrpSp$8866[ebp]
	rep movsd
	mov	eax, DWORD PTR _nextIrpSp$8866[ebp]
	mov	BYTE PTR [eax+3], 0

; 246  : 		(PVOID) &event, TRUE, TRUE, TRUE);

	mov	ecx, OFFSET FLAT:?TxP_OnRequestComplete@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAU_KEVENT@@@Z ; TxP_OnRequestComplete
	neg	ecx
	sbb	ecx, ecx
	neg	ecx
	test	ecx, ecx
	jne	SHORT $L8874
	push	0
	push	246					; 000000f6H
	push	OFFSET FLAT:$SG8875
	push	OFFSET FLAT:$SG8876
	call	DWORD PTR __imp__RtlAssert@16
$L8874:
	mov	edx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR [edx+96]
	sub	eax, 36					; 00000024H
	mov	DWORD PTR _irpSp$8872[ebp], eax
	mov	ecx, DWORD PTR _irpSp$8872[ebp]
	mov	DWORD PTR [ecx+28], OFFSET FLAT:?TxP_OnRequestComplete@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAU_KEVENT@@@Z ; TxP_OnRequestComplete
	mov	edx, DWORD PTR _irpSp$8872[ebp]
	lea	eax, DWORD PTR _event$[ebp]
	mov	DWORD PTR [edx+32], eax
	mov	ecx, DWORD PTR _irpSp$8872[ebp]
	mov	BYTE PTR [ecx+3], 0
	mov	edx, 1
	test	edx, edx
	je	SHORT $L8879
	mov	eax, DWORD PTR _irpSp$8872[ebp]
	mov	BYTE PTR [eax+3], 64			; 00000040H
$L8879:
	mov	ecx, 1
	test	ecx, ecx
	je	SHORT $L8880
	mov	edx, DWORD PTR _irpSp$8872[ebp]
	mov	al, BYTE PTR [edx+3]
	or	al, 128					; 00000080H
	mov	ecx, DWORD PTR _irpSp$8872[ebp]
	mov	BYTE PTR [ecx+3], al
$L8880:
	mov	edx, 1
	test	edx, edx
	je	SHORT $L8881
	mov	eax, DWORD PTR _irpSp$8872[ebp]
	mov	cl, BYTE PTR [eax+3]
	or	cl, 32					; 00000020H
	mov	edx, DWORD PTR _irpSp$8872[ebp]
	mov	BYTE PTR [edx+3], cl
$L8881:

; 247  : 
; 248  : 	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	mov	eax, DWORD PTR _fdo$[ebp]
	mov	ecx, DWORD PTR [eax+40]
	mov	DWORD PTR _pdx$[ebp], ecx

; 249  : 	IoCallDriver(pdx->LowerDeviceObject, Irp);

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR _pdx$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	call	DWORD PTR __imp_@IofCallDriver@8

; 250  : 	KeWaitForSingleObject(&event, Executive, KernelMode, FALSE, NULL);

	push	0
	push	0
	push	0
	push	0
	lea	ecx, DWORD PTR _event$[ebp]
	push	ecx
	call	DWORD PTR __imp__KeWaitForSingleObject@20

; 251  : 	return Irp->IoStatus.Status;

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR [edx+24]

; 252  : }							// TxP_ForwardAndWait

	pop	edi
	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	8
?TxP_ForwardAndWait@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@@Z ENDP ; TxP_ForwardAndWait
page	ENDS
EXTRN	__imp__KeSetEvent@12:NEAR
;	COMDAT ?TxP_OnRequestComplete@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAU_KEVENT@@@Z
_TEXT	SEGMENT
_pev$ = 16
?TxP_OnRequestComplete@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAU_KEVENT@@@Z PROC NEAR ; TxP_OnRequestComplete, COMDAT

; 259  : {							// TxP_OnRequestComplete

	push	ebp
	mov	ebp, esp

; 260  : 	KeSetEvent(pev, 0, FALSE);

	push	0
	push	0
	mov	eax, DWORD PTR _pev$[ebp]
	push	eax
	call	DWORD PTR __imp__KeSetEvent@12

; 261  : 	return STATUS_MORE_PROCESSING_REQUIRED;

	mov	eax, -1073741802			; c0000016H

; 262  : }							// TxP_OnRequestComplete

	pop	ebp
	ret	12					; 0000000cH
?TxP_OnRequestComplete@@YGJPAU_DEVICE_OBJECT@@PAU_IRP@@PAU_KEVENT@@@Z ENDP ; TxP_OnRequestComplete
_TEXT	ENDS
PUBLIC	__chkesp
;	COMDAT __chkesp
; File E:\WDM_interface\Txintpar\DriverEntry.cpp
_TEXT	SEGMENT
$SG8893	DB	'Stack pointer mismatch!', 00H
$SG8894	DB	'E:\WDM_interface\Txintpar\DriverEntry.cpp', 00H
	ORG $+2
$SG8895	DB	'!"Stack pointer mismatch!"', 00H
__chkesp PROC NEAR					; COMDAT

; 270  : 	_asm je okay

	je	SHORT $okay$8891

; 271  : 	ASSERT(!"Stack pointer mismatch!");

	mov	eax, OFFSET FLAT:$SG8893
	test	eax, eax
	je	SHORT $L8892
	push	0
	push	271					; 0000010fH
	push	OFFSET FLAT:$SG8894
	push	OFFSET FLAT:$SG8895
	call	DWORD PTR __imp__RtlAssert@16
$L8892:
$okay$8891:

; 273  : 	_asm ret

	ret	0
__chkesp ENDP
_TEXT	ENDS
END
