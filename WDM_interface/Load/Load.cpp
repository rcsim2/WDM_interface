/****************************************************************************
*                                                                           *
* THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY     *
* KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE       *
* IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR     *
* PURPOSE.                                                                  *
*                                                                           *
* Copyright 2002  Black Sphere Corp.  All Rights Reserved.           		*
*                                                                           *
****************************************************************************/

/****************************************************************************
*
* PROGRAM: LOAD.C
*
* PURPOSE: Simple Win32 console application for calling TXINTPAR WDM Driver.
*		   TXINTPAR will return values to this application through the
*	       DeviceIoControl interface.
*
****************************************************************************/

#include <stdio.h>
#include <windows.h>
#include <conio.h>
#include <winioctl.h>

//#include <vmm.h>
//#include <vxdldr.h>


#define TXINTPAR_APIFUNC_1 1
#define TXINTPAR_APIFUNC_2 2


// I/O Control Codes
#define IOCTL_TXINTPAR_OPEN \
   CTL_CODE(FILE_DEVICE_PARALLEL_PORT, 0x800, METHOD_BUFFERED, \
         FILE_ANY_ACCESS )

#define IOCTL_TXINTPAR_CLOSE \
   CTL_CODE(FILE_DEVICE_PARALLEL_PORT, 0x801, METHOD_BUFFERED, \
         FILE_ANY_ACCESS )
         
#define IOCTL_TXINTPAR_FREE \
   CTL_CODE(FILE_DEVICE_PARALLEL_PORT, 0x802, METHOD_BUFFERED, \
         FILE_ANY_ACCESS )

#define IOCTL_TXINTPAR_INIT \
   CTL_CODE(FILE_DEVICE_PARALLEL_PORT, 0x803, METHOD_BUFFERED, \
         FILE_ANY_ACCESS )

#define IOCTL_TXINTPAR_READ \
   CTL_CODE(FILE_DEVICE_PARALLEL_PORT, 0x804, METHOD_BUFFERED, \
         FILE_ANY_ACCESS )

#define IOCTL_TXINTPAR_WRITE \
   CTL_CODE(FILE_DEVICE_PARALLEL_PORT, 0x805, METHOD_BUFFERED, \
         FILE_ANY_ACCESS )




// prototypes
void cls( HANDLE hConsole );


int main()
{
	CONSOLE_CURSOR_INFO cci;// = {50,TRUE}; // struct init only compulsary in C
	cci.dwSize = 50; //99; buggy bugger 100==invisible
	cci.bVisible = FALSE; //TRUE;

	COORD coord = {0,0};
	//DWORD NumberOfAttrsWritten;

	//HANDLE hConsoleOutput = CreateConsoleScreenBuffer( 
	//								GENERIC_READ|GENERIC_WRITE,
	//								FILE_SHARE_READ|FILE_SHARE_WRITE,
	//								NULL, CONSOLE_TEXTMODE_BUFFER, NULL);
	//
	//if(hConsoleOutput==INVALID_HANDLE_VALUE)
	//	printf("Could not get hConsoleOutput");
	
	//SetConsoleActiveScreenBuffer(hConsoleOutput);
	
	HANDLE hConsoleOutput= GetStdHandle(STD_OUTPUT_HANDLE);
	
	// No cursor
	SetConsoleCursorInfo(hConsoleOutput, &cci);

	// Color
	//FillConsoleOutputAttribute(hConsoleOutput, BACKGROUND_RED|BACKGROUND_BLUE,
	//										80*25, coord, &NumberOfAttrsWritten);
	//SetConsoleTextAttribute(hConsoleOutput, BACKGROUND_RED|BACKGROUND_BLUE); 





	HANDLE  hWDM = 0;
	DWORD   cbBytesReturned;
	DWORD   dwErrorCode;
	//DWORD   RetInfo[14];	// 1 Sync Pulse + 10 Channels + 1 IntCount + 1 PulseLength + 1 ChannelCount
	
	// ints rule!!!!!
	// Note: better use int because DWORD is unsigned!!!!!!!!!!!
	int		RetInfo[88]; 	// big sucker to test
	//int	PrevRetInfo[88]; 
	
	int		IntCount = 0;
	int		ChannelTotal = 0;

	//int		Buffer[32];
	//DWORD	dwNumberOfBytesRead;

/*	
	CHAR*   strWDMFileName = "Txintpar.sys";
	CHAR    lpBuffer[MAX_PATH];
	CHAR    strWDMFilePath[MAX_PATH];
	
	if ( !GetSystemDirectory(lpBuffer, MAX_PATH) ) {
		dwErrorCode = GetLastError();
		printf("Could not get Sys Dir, Error code: %ld\n", dwErrorCode);    
	} else {
		strcpy(strWDMFilePath, "\\\\.\\");
		strcat(strWDMFilePath, lpBuffer);
		strcat(strWDMFilePath, "32\\Drivers\\");
		strcat(strWDMFilePath, strWDMFileName);         
	}   
*/
	// Load and prepare to call TXINTPAR
	// The CREATE_NEW flag is not necessary
	// Note: if we have added version info into the vxd with adrc2vxd we will only see
	// that info in System Information if we load the vxd from the Windows\System dir
	//hWDM = CreateFile("\\\\.\\C:\\Windows\\System32\\Drivers\\Txintpar.sys", 0,0,0,
	//                    CREATE_NEW, FILE_FLAG_DELETE_ON_CLOSE, 0);
	
	//hWDM = CreateFile(strWDMFilePath, 0, 0, NULL, 0, FILE_FLAG_DELETE_ON_CLOSE, NULL);

	// NOTE: User-mode code must use SetupDiXxx functions to find out about registered, 
	// enabled device interfaces.
	//
	// Use:
	// SetupDiGetClassDevs()
	// SetupDiEnumDeviceInterfaces()
	// SetupDiGetDeviceInterfaceDetail()
	// to get symbolic link name.
	//
	// DeviceInterfaceData points to a structure that identifies a requested device interface.
	// To get detailed information about an interface, call SetupDiGetDeviceInterfaceDetail. 
	// The detailed information includes the name of the device interface that can be passed
	// to a Win32® function such as CreateFile to get a handle to the interface.
	//
	//hWDM = CreateFile("\\\\.\\TxintPar", 
	//					GENERIC_READ|GENERIC_WRITE,0,0,
	//                   CREATE_NEW, FILE_FLAG_DELETE_ON_CLOSE, 0);

	//printf("\nTest qqq\n");
	//while ( !_kbhit() );

	hWDM = CreateFile("\\\\.\\TXINTPAR",
                         GENERIC_READ|GENERIC_WRITE,
                         FILE_SHARE_READ|FILE_SHARE_WRITE,
                         NULL,
                         OPEN_EXISTING,
                         0,
                         NULL
                         );



	if ( hWDM == INVALID_HANDLE_VALUE )
	{
		dwErrorCode = GetLastError();
		if ( dwErrorCode == ERROR_NOT_SUPPORTED )
		{
			printf("WDM loaded but device does not support DeviceIOCTL, Error code: %ld\n", dwErrorCode);
			
			printf("\nHit any key to quit\n");
			while ( !_kbhit() );
		}
		if ( dwErrorCode == ERROR_FILE_NOT_FOUND )
		{
			printf("Could not find WDM or it is not dynamically loadable, Error code: %ld\n", dwErrorCode);
			
			printf("\nHit any key to quit\n");
			while ( !_kbhit() );
		}
	}
	else
	{
		printf("WDM loaded and DeviceIOCTL ready to go!\n\n");
		
		RetInfo[0]=666; // test value, the vxd should change this value

		//MessageBox(NULL, "Yo!", "Blacksphere", MB_OK);
		
		
/*		
		printf("\nHit any key to init interrupt\n");
		while ( !_kbhit() );
		_getch();		
		
		// Init and connect interrupt
		if ( DeviceIoControl(hWDM, IOCTL_TXINTPAR_INIT,
				(LPVOID)NULL, 0,
				(LPVOID)RetInfo, sizeof(RetInfo),
				&cbBytesReturned, NULL) )
		{
		}
		else 
		{
		}
*/
/*		
		// Does this send a IRP_MJ_READ??? Yes
		printf("\nHit any key to call ReadFile()\n");
		while ( !_kbhit() );
		_getch();

		ReadFile(hWDM, &Buffer, (DWORD)1, &dwNumberOfBytesRead, NULL );
*/		
				
				
		
		// Make 1st WDM call here
		if ( DeviceIoControl(hWDM, IOCTL_TXINTPAR_READ,
				(LPVOID)NULL, 0,
				(LPVOID)RetInfo, sizeof(RetInfo),
				&cbBytesReturned, NULL) )
		{
			printf("Yo! WDM call 1\n");

			// NOTE: it might not be a good idee to poll the device like this.
			// It is probably better to get a memory pointer from the device
			// and then poll that memory
			// This polling probably causes Load.exe to get stuck on the Process
			// list.
			// NO: this does not cause it
			//
			// Loop /////////////////////////////////////////////////
			while ( !_kbhit() ) {
				
				// Poll the WDM values
				DeviceIoControl(hWDM, IOCTL_TXINTPAR_READ,
					(LPVOID)NULL, 0,
					(LPVOID)RetInfo, sizeof(RetInfo),
					&cbBytesReturned, NULL);

				
				// This is the buffer we get from the WDM
				// RetInfo[0]  == SyncPulse

				// RetInfo[1]  == Ch1
				// RetInfo[2]  == Ch2
				// RetInfo[3]  == Ch3
				// RetInfo[4]  == Ch4
				// RetInfo[5]  == Ch5
				// RetInfo[6]  == Ch6
				// RetInfo[7]  == Ch7			
				// RetInfo[8]  == Ch8
				// RetInfo[9]  == Ch9
				// RetInfo[10] == Ch10

				// RetInfo[11] == IntCount
				// RetInfo[12] == PulseLength
				// RetInfo[13] == ChannelCount


				
				char* ChL[11];	// We don't use ChL[0] to keep channel numbers the same
								// Watch out for wild pointers
				// safety first
				// Can't do that like this: we must initialize to same size as L ?????
				ChL[0] = NULL;
				ChL[1] = NULL;
				ChL[2] = NULL;
				ChL[3] = NULL;
				ChL[4] = NULL;
				ChL[5] = NULL;
				ChL[6] = NULL;
				ChL[7] = NULL;
				ChL[8] = NULL;
				ChL[9] = NULL;
				ChL[10]= NULL;


				char* L[21];

				L[0] = "\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1"; 
				L[1] = "\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[2] = "\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[3] = "\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[4] = "\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[5] = "\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[6] = "\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[7] = "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[8] = "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[9] = "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[10]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[11]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[12]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[13]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1\xB1";
				L[14]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1\xB1";
				L[15]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1\xB1";
				L[16]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1\xB1";
				L[17]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1\xB1";
				L[18]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1\xB1";
				L[19]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xB1";
				L[20]= "\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB\xDB";

			

				for (int i=1; i<=10; i++) {
					if		(RetInfo[i]<1300) ChL[i]= L[0] ;
					else if (RetInfo[i]<1350) ChL[i]= L[1] ;
					else if (RetInfo[i]<1400) ChL[i]= L[2] ;
					else if (RetInfo[i]<1450) ChL[i]= L[3] ;
					else if (RetInfo[i]<1500) ChL[i]= L[4] ;
					else if (RetInfo[i]<1550) ChL[i]= L[5] ;
					else if (RetInfo[i]<1600) ChL[i]= L[6] ;
					else if (RetInfo[i]<1650) ChL[i]= L[7] ;
					else if (RetInfo[i]<1700) ChL[i]= L[8] ;
					else if (RetInfo[i]<1750) ChL[i]= L[9] ;
					else if (RetInfo[i]<1800) ChL[i]= L[10];
					else if (RetInfo[i]<1850) ChL[i]= L[11];
					else if (RetInfo[i]<1900) ChL[i]= L[12];
					else if (RetInfo[i]<1950) ChL[i]= L[13];
					else if (RetInfo[i]<2000) ChL[i]= L[14];
					else if (RetInfo[i]<2050) ChL[i]= L[15];
					else if (RetInfo[i]<2100) ChL[i]= L[16];
					else if (RetInfo[i]<2150) ChL[i]= L[17];
					else if (RetInfo[i]<2200) ChL[i]= L[18];
					else if (RetInfo[i]<2250) ChL[i]= L[19];
					else					  ChL[i]= L[20];
				}
				
				// pas waarde een beetje aan zodat we 1000-2000 uS printen.
				// (In de VxD gebruiken we een timer die elke 0.8 uS increment. Daardoor
				// komen we hoger uit dan de standaard 1000-2000 uS (1-2 ms) per channel).
				for (i=0; i<=10; i++) {
					if (RetInfo[i] != 0) RetInfo[i]-=250; // leave unused channels alone
					// RetInfo[i] must be signed here!!!!!!!!!!!!!!!!!!
					// We've changed it from DWORD to int so it's OK now
					if (RetInfo[i] < 0)  RetInfo[i] =  0; // never print negative values
				}	
				
				
				
				// NOTE: DWORD is unsigned and causes that we never get 777
				//for (i=0; i<=10; i++) {
				//	RetInfo[i] = -666; // minus is prob
				//
				//	// Huh, why not???
				//	if ( RetInfo[i] < 0 ) RetInfo[i]=777; // we never get 777
				//}
				//
				//Instead do this:
				//for (i=0; i<=10; i++) {
				//	(int)RetInfo[i] = 666;
				//	if ( RetInfo[i] < 667 ) RetInfo[i]=777; // now we get 777
				//}
				/////////////////////////////////////////////////////////////////////////
				
				
				// TODO: handle the occasional Ch9 and Ch10 printf caused bij interference signals
				// DONE:

				// get total number of channels
				if ( RetInfo[13] > ChannelTotal )
					ChannelTotal = RetInfo[13];

				// set unused channels at length 0
				for (i=10; i>ChannelTotal; i--) {
					RetInfo[i] = 0;
					ChL[i] = L[0];
				}


				// TODO: handle Frame Data Defective when the signal is lost
				// b.v. op basis van extreem lange of korte pulsen
				// TODO: catch Frame Data Defective: dat is wanneer sync pulse of channels
				// buiten de te verwachten waarden vallen
				// Als de zender uit wordt gezet zal in
				// de WDM ChannelCount op blijft lopen (omdat geen Sync Pulse meer zal worden
				// gevonden die ChannelCount op 0 zet)
				//bool datadef = false;
				for (i=1; i<=ChannelTotal; i++) {
					if (RetInfo[i] < 500 || RetInfo[i] > 2500) {
						//datadef = true;
						ChannelTotal = 0;
						//ChL[i] = L[0];
					}
				}




				printf("                     Blacksphere WDM Utilities (C) 2002\n\n");
				
				if (ChannelTotal == 0)
					printf(" Signal Defective    Channel Total: %ld   Interrupt Count: %ld\n\n", ChannelTotal, RetInfo[11]);
				else
					printf(" Sync Pulse: %-5ld   Channel Total: %ld   Interrupt Count: %ld\n\n", RetInfo[0], ChannelTotal, RetInfo[11]);

				printf(" Channel  1: %s %ld\n\n", ChL[1],  RetInfo[1] );
				printf(" Channel  2: %s %ld\n\n", ChL[2],  RetInfo[2] );
				printf(" Channel  3: %s %ld\n\n", ChL[3],  RetInfo[3] );
				printf(" Channel  4: %s %ld\n\n", ChL[4],  RetInfo[4] );
				printf(" Channel  5: %s %ld\n\n", ChL[5],  RetInfo[5] );
				printf(" Channel  6: %s %ld\n\n", ChL[6],  RetInfo[6] );
				printf(" Channel  7: %s %ld\n\n", ChL[7],  RetInfo[7] );
				printf(" Channel  8: %s %ld\n\n", ChL[8],  RetInfo[8] );
				printf(" Channel  9: %s %ld\n\n", ChL[9],  RetInfo[9] );
				printf(" Channel 10: %s %ld\n\n", ChL[10], RetInfo[10]);
				
				//printf("Interrupt Count: %ld\n\n", RetInfo[11]);
				//printf("Pulse Length: %ld\n\n", RetInfo[12]);
				
				
				/* Can't call ints from Win32 App!
				__asm {
					mov	ah, 1	; make cursor disappear
					mov	ch, 20h
					int	10h
					
					mov	ah, 2	; move cursor ah=2
					mov	bh, 0
					mov	dh, 0
					mov	dl, 0
					int	10h
				}
				*/
				
				// Only for GUI apps
				//ShowCursor(FALSE);
				 
				//SetConsoleCursorPosition();
				//SetConsoleCursorInfo(hConsoleOutput, &cci);

				// Clear screen
				Sleep(50);
				//system("CLS");
				cls(hConsoleOutput);
			}
			// End Loop //////////////////////////////////////////////
		}
		else
		{
			printf("Device does not support the requested CTL_CODE\n");
		}

		// Make 2nd WDM call here
		//if ( DeviceIoControl(hWDM, TXINTPAR_APIFUNC_2,
		//		(LPVOID)NULL, 0,
		//		(LPVOID)RetInfo, sizeof(RetInfo),
		//		&cbBytesReturned, NULL) )
		//{
		//	//printf("System VM Handle: %lx\n", RetInfo[0]);
		//	//printf("VKD_Get_Kbd_Owner: %lx\n", RetInfo[1]);
		//	printf("Yo! WDM call 2\n");
		//}
		//else
		//{
		//	printf("Device does not support the requested API\n");
		//}


		// Use _getch to throw key away and test again for keystroke
		_getch();
		printf("\nHit any key to start unloading WDM with CloseHandle()\n");
		while ( !_kbhit() );
		
		// Dynamically UNLOAD the Virtual Device
		//if ( CloseHandle(hWDM) ) {
		//	printf("\nWDM handle closed successfully, \
		//		\nVXDLDR will now try to unload the WDM but may still fail\n");
		//} else {
		//	printf("\nWDM handle close failed\n");
		//}

		// Close WDM driver
		if ( CloseHandle(hWDM) ) {
			printf("\nWDM handle closed successfully\n");
		} else {
			printf("\nWDM handle close failed\n");
		}

/*      
		// This should only be necessary in rare cases
		// Hell, this always returns success, even when vxd isn't loaded!!!
		// Note: DeleteFile() is buggy when unloading VXDs:
		// It returns:
		// 0 when successful
		// nonzero when it fails
		if ( DeleteFile("\\\\.\\TXINTPAR") ) {
			//printf("\nDeleteFile() successful\n");
			printf("\nDeleteFile() failed\n");
		} else {
			//printf("\nDeleteFile() failed\n");
			printf("\nDeleteFile() successful\n");
		}
*/      

		// Use _getch to throw key away and test again for keystroke
		_getch(); 
		printf("\nHit any key to quit\n");
		while ( !_kbhit() );
		  
	}
	
	exit(0);
	
	return(0);
}



// Clears screen in Win32 console app 
void cls( HANDLE hConsole )
{
    COORD coordScreen = { 0, 0 };    /* here's where we'll home the cursor */
	COORD coordScreen2 = { 18, 0 };
    BOOL bSuccess;
	DWORD cCharsWritten;
    CONSOLE_SCREEN_BUFFER_INFO csbi; /* to get buffer info */ 
    DWORD dwConSize;                /* number of character cells in the current buffer */
	
    /* get the number of character cells in the current buffer */
	bSuccess = GetConsoleScreenBufferInfo( hConsole, &csbi );
	//PERR( bSuccess, "GetConsoleScreenBufferInfo" );
    dwConSize = csbi.dwSize.X * csbi.dwSize.Y;
    
	/* fill the entire screen with blanks */ 
    bSuccess = FillConsoleOutputCharacter( hConsole, (TCHAR) ' ', dwConSize, coordScreen, &cCharsWritten );
    //PERR( bSuccess, "FillConsoleOutputCharacter" );
    
	/* get the current text attribute */ 
    bSuccess = GetConsoleScreenBufferInfo( hConsole, &csbi );
	//PERR( bSuccess, "ConsoleScreenBufferInfo" );
    
	/* now set the buffer's attributes accordingly */ 
    //bSuccess = FillConsoleOutputAttribute( hConsole, csbi.wAttributes, dwConSize, coordScreen, &cCharsWritten );
    //PERR( bSuccess, "FillConsoleOutputAttribute" );
	//FillConsoleOutputAttribute( hConsole, BACKGROUND_BLUE, 40, coordScreen2, &cCharsWritten );

	// Better use WriteConsoleOutputCharacter() to write:
	// "Blacksphere WDM Utilities (C) 2001\n\n"
    
	/* put the cursor at (0, 0) */ 
    bSuccess = SetConsoleCursorPosition( hConsole, coordScreen );
	//PERR( bSuccess, "SetConsoleCursorPosition" );    
	
	return;
} 

