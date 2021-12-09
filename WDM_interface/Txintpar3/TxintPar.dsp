# Microsoft Developer Studio Project File - Name="TxintPar" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 5.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=TxintPar - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "TxintPar.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "TxintPar.mak" CFG="TxintPar - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "TxintPar - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "TxintPar - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "TxintPar - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Gz /W3 /O2 /I "$(DDKPATH)\inc" /FI"$(DDKPATH)\inc\warning.h" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D _X86_=1 /D i386=1 /D "STD_CALL" /D CONDITION_HANDLING=1 /D NT_UP=1 /D NT_INST=0 /D WIN32=100 /D _NT1X_=100 /D WINNT=1 /D _WIN32_WINNT=0x0500 /D _WIN32_IE=0x0400 /D WIN32_LEAN_AND_MEAN=1 /D DBG=1 /D DEVL=1 /D FPO=0 /D _DLL=1 /D "DRIVER" /D "_IDWBUILD" /FR /Yu"stddcls.h" /FD /Zel -cbstring /QIfdiv- /QI0f /GF /Oxs /c
# ADD CPP /nologo /Gz /W3 /O2 /I "e:\NTDDK\inc" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D _X86_=1 /D i386=1 /D "STD_CALL" /D CONDITION_HANDLING=1 /D NT_UP=1 /D NT_INST=0 /D WIN32=100 /D _NT1X_=100 /D WINNT=1 /D _WIN32_WINNT=0x0500 /D _WIN32_IE=0x0400 /D WIN32_LEAN_AND_MEAN=1 /D DBG=1 /D DEVL=1 /D FPO=0 /D _DLL=1 /D "DRIVER" /D "_IDWBUILD" /FAs /FR /Yu"stddcls.h" /FD /Zel -cbstring /QIfdiv- /QI0f /GF /Oxs /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib int64.lib wdm.lib usbd.lib /nologo /base:"0x10000" /version:4.0 /entry:"DriverEntry@8" /subsystem:windows /pdb:none /machine:I386 /nodefaultlib /out:"release\TxintPar.sys" /libpath:"$(DDKPATH)\lib\i386\free" -MERGE:_PAGE=PAGE -MERGE:_TEXT=.text -MERGE:.rdata=.text -SECTION:INIT,d -OPT:REF -FORCE:MULTIPLE -RELEASE -FULLBUILD -IGNORE:4001,4037,4039,4065,4070,4078,4087,4089,4096 -osversion:4.00 -optidata -driver -align:0x20 -subsystem:native,4.00 -debug:notmapped,minimal
# ADD LINK32 int64.lib wdm.lib /nologo /base:"0x10000" /version:4.0 /entry:"DriverEntry@8" /subsystem:windows /pdb:none /machine:I386 /nodefaultlib /out:"release\TxintPar.sys" /libpath:"e:\NTDDK\libchk\i386" -MERGE:_PAGE=PAGE -MERGE:_TEXT=.text -MERGE:.rdata=.text -SECTION:INIT,d -OPT:REF -FORCE:MULTIPLE -RELEASE -FULLBUILD -IGNORE:4001,4037,4039,4065,4070,4078,4087,4089,4096 -osversion:4.00 -optidata -driver -align:0x20 -subsystem:native,4.00 -debug:notmapped,minimal

!ELSEIF  "$(CFG)" == "TxintPar - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "objchk\i386\"
# PROP Intermediate_Dir "objchk\i386\"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Gz /W3 /Z7 /Oi /Gy /I "$(DDKPATH)\inc" /FI"$(DDKPATH)\inc\warning.h" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D _X86_=1 /D i386=1 /D "STD_CALL" /D CONDITION_HANDLING=1 /D NT_UP=1 /D NT_INST=0 /D WIN32=100 /D _NT1X_=100 /D WINNT=1 /D _WIN32_WINNT=0x0500 /D _WIN32_IE=0x0400 /D WIN32_LEAN_AND_MEAN=1 /D DBG=1 /D DEVL=1 /D FPO=0 /D "NDEBUG" /D _DLL=1 /D "DRIVER" /D "_IDWBUILD" /D "RDRDBG" /D "SRVDBG" /FR /Yu"stddcls.h" /FD /GZ /Zel -cbstring /QIfdiv- /QI0f /GF /QIf /c
# ADD CPP /nologo /Gz /W3 /WX /Z7 /Gy /I "i386\\" /I "." /I "..\inc" /I "..\..\inc" /I "F:\NTDDK\inc" /I "F:\NTDDK\inc\ddk" /I "F:\NTDDK\inc\ddk\wdm" /I "F:\NTDDK\private\inc" /FI"F:\NTDDK\inc\warning.h" /D _X86_=1 /D i386=1 /D "STD_CALL" /D CONDITION_HANDLING=1 /D NT_UP=1 /D NT_INST=0 /D WIN32=100 /D _NT1X_=100 /D WINNT=1 /D _WIN32_WINNT=0x0500 /D WINVER=0x0500 /D _WIN32_IE=0x0501 /D WIN32_LEAN_AND_MEAN=1 /D DBG=1 /D DEVL=1 /D FPO=0 /D "NDEBUG" /D _DLL=1 /Zel -cbstring /QIfdiv- /QIf /QI0f /GF /Oxs /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /i "..\inc" /i "..\..\inc" /i "F:\NTDDK\inc" /i "F:\NTDDK\inc\ddk" /i "F:\NTDDK\inc\ddk\wdm" /i "F:\NTDDK\private\inc" /d _X86_=1 /d i386=1 /d "STD_CALL" /d CONDITION_HANDLING=1 /d NT_UP=1 /d NT_INST=0 /d WIN32=100 /d _NT1X_=100 /d WINNT=1 /d _WIN32_WINNT=0x0500 /d WINVER=0x0500 /d _WIN32_IE=0x0501 /d WIN32_LEAN_AND_MEAN=1 /d DBG=1 /d DEVL=1 /d FPO=0 /d "NDEBUG" /d _DLL=1
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o"TxintPar.bsc"
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib int64.lib wdm.lib usbd.lib /nologo /base:"0x10000" /version:4.0 /entry:"DriverEntry@8" /subsystem:windows /pdb:none /debug /debugtype:both /machine:I386 /nodefaultlib /out:"debug\TxintPar.sys" /libpath:"$(DDKPATH)\lib\i386\checked" -MERGE:_PAGE=PAGE -MERGE:_TEXT=.text -MERGE:.rdata=.text -SECTION:INIT,d -OPT:REF -FORCE:MULTIPLE -RELEASE -FULLBUILD -IGNORE:4001,4037,4039,4065,4070,4078,4087,4089,4096 -osversion:4.00 -optidata -driver -align:0x20 -subsystem:native,4.00 -debug:notmapped,FULL
# ADD LINK32 objchk\i386\pch.obj objchk\i386\parclass.res objchk\i386\becp.obj objchk\i386\byte.obj objchk\i386\debug.obj objchk\i386\devobj.obj objchk\i386\ecp.obj objchk\i386\epp.obj objchk\i386\errlog.obj objchk\i386\exports.obj objchk\i386\hwecp.obj objchk\i386\hwepp.obj objchk\i386\ieee1284.obj objchk\i386\initunld.obj objchk\i386\ioctl.obj objchk\i386\nibble.obj objchk\i386\openclos.obj objchk\i386\p12843dl.obj objchk\i386\par12843.obj objchk\i386\parclass.obj objchk\i386\parharns.obj objchk\i386\parloop.obj objchk\i386\parstl.obj objchk\i386\pnp.obj objchk\i386\pnpfdo.obj objchk\i386\pnppdo.obj objchk\i386\port.obj objchk\i386\power.obj objchk\i386\ppa3x.obj objchk\i386\queue.obj objchk\i386\readwrit.obj objchk\i386\rescan.obj objchk\i386\spp.obj objchk\i386\sppieee.obj objchk\i386\swecp.obj objchk\i386\swepp.obj objchk\i386\test.obj objchk\i386\thread.obj objchk\i386\util.obj objchk\i386\wmipdo.obj F:\NTDDK\libchk\i386\ntoskrnl.lib F:\NTDDK\libchk\i386\hal.lib F:\NTDDK\libchk\i386\wmilib.lib /base:"0x10000" /version:5.0 /stack:0x40000,0x1000 /entry:"DriverEntry@8" /incremental:no /map /machine:IX86 /nodefaultlib /out:"objchk\i386\TxintPar.sys" -MERGE:_PAGE=PAGE -MERGE:_TEXT=.text -SECTION:INIT,d -OPT:REF -OPT:ICF -IGNORE:4001,4037,4039,4044,4065,4070,4078,4087,4089,4198 -FULLBUILD -FORCE:MULTIPLE -NOCOMMENT /release -debug:FULL -osversion:5.00 -optidata -driver -align:0x20 -subsystem:native,5.00

!ENDIF 

# Begin Target

# Name "TxintPar - Win32 Release"
# Name "TxintPar - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\becp.c
# End Source File
# Begin Source File

SOURCE=.\byte.c
# End Source File
# Begin Source File

SOURCE=.\debug.c
# End Source File
# Begin Source File

SOURCE=.\devobj.c
# End Source File
# Begin Source File

SOURCE=.\ecp.c
# End Source File
# Begin Source File

SOURCE=.\epp.c
# End Source File
# Begin Source File

SOURCE=.\errlog.c
# End Source File
# Begin Source File

SOURCE=.\exports.c
# End Source File
# Begin Source File

SOURCE=.\hwecp.c
# End Source File
# Begin Source File

SOURCE=.\hwepp.c
# End Source File
# Begin Source File

SOURCE=.\ieee1284.c
# End Source File
# Begin Source File

SOURCE=.\initunld.c
# End Source File
# Begin Source File

SOURCE=.\ioctl.c
# End Source File
# Begin Source File

SOURCE=.\nibble.c
# End Source File
# Begin Source File

SOURCE=.\openclos.c
# End Source File
# Begin Source File

SOURCE=.\p12843dl.c
# End Source File
# Begin Source File

SOURCE=.\par12843.c
# End Source File
# Begin Source File

SOURCE=.\parclass.c
# End Source File
# Begin Source File

SOURCE=.\parharns.c
# End Source File
# Begin Source File

SOURCE=.\parloop.c
# End Source File
# Begin Source File

SOURCE=.\parstl.c
# End Source File
# Begin Source File

SOURCE=.\pnp.c
# End Source File
# Begin Source File

SOURCE=.\pnpfdo.c
# End Source File
# Begin Source File

SOURCE=.\pnppdo.c
# End Source File
# Begin Source File

SOURCE=.\port.c
# End Source File
# Begin Source File

SOURCE=.\power.c
# End Source File
# Begin Source File

SOURCE=.\ppa3x.c
# End Source File
# Begin Source File

SOURCE=.\queue.c
# End Source File
# Begin Source File

SOURCE=.\readwrit.c
# End Source File
# Begin Source File

SOURCE=.\rescan.c
# End Source File
# Begin Source File

SOURCE=.\spp.c
# End Source File
# Begin Source File

SOURCE=.\sppieee.c
# End Source File
# Begin Source File

SOURCE=.\swecp.c
# End Source File
# Begin Source File

SOURCE=.\swepp.c
# End Source File
# Begin Source File

SOURCE=.\test.c
# End Source File
# Begin Source File

SOURCE=.\thread.c
# End Source File
# Begin Source File

SOURCE=.\util.c
# End Source File
# Begin Source File

SOURCE=.\wmipdo.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\debug.h
# End Source File
# Begin Source File

SOURCE=.\ecp.h
# End Source File
# Begin Source File

SOURCE=.\funcdecl.h
# End Source File
# Begin Source File

SOURCE=.\hwecp.h
# End Source File
# Begin Source File

SOURCE=.\log.h
# End Source File
# Begin Source File

SOURCE=.\parclass.h
# End Source File
# Begin Source File

SOURCE=.\parharns.h
# End Source File
# Begin Source File

SOURCE=.\parstl.h
# End Source File
# Begin Source File

SOURCE=.\pch.h
# End Source File
# Begin Source File

SOURCE=.\queue.h
# End Source File
# Begin Source File

SOURCE=.\readwrit.h
# End Source File
# Begin Source File

SOURCE=.\test.h
# End Source File
# Begin Source File

SOURCE=.\util.h
# End Source File
# Begin Source File

SOURCE=.\wmipdo.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\parclass.rc

!IF  "$(CFG)" == "TxintPar - Win32 Release"

!ELSEIF  "$(CFG)" == "TxintPar - Win32 Debug"

!ENDIF 

# End Source File
# End Group
# Begin Source File

SOURCE=.\TxintPar.inf
# End Source File
# End Target
# End Project
