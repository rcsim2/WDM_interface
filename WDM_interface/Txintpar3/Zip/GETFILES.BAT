copy ..\*.cpp  	.\*.cpp
copy ..\*.h  	.\*.h
copy ..\*.def 	.\*.def
copy ..\*.rc 	.\*.rc
copy ..\*.bat	.\*.bat
copy ..\*.sys	.\*.sys

dir /on /b .\*.cpp >  filelist.txt
dir /on /b .\*.h   >> filelist.txt
dir /on /b .\*.def >> filelist.txt
dir /on /b .\*.rc  >> filelist.txt
dir /on /b .\*.bat >> filelist.txt
dir /on /b .\*.sys >> filelist.txt

pkzip TxintParSource.zip *.* -x*.zip


rem copy TxintParSource.zip A:
rem copy TxintParSource.zip L: