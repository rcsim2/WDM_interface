// DeviceControl request handler for TxintPar driver
// User-mode DeviceIoControl() calls will be routed here

#include "stddcls.h"
#include "driver.h"
									  
///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS TxintPar_DispatchDeviceControl( IN PDEVICE_OBJECT fdo, IN PIRP Irp )
{							// TxintPar_DispatchDeviceControl
	
	// this macro checks if this code is pageable 
	PAGED_CODE();

	/////////////////////////////////////////////////
	// This is the buffer we give to the user-mode app
	// RetInfo[0]  == SyncPulse
	//
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
	//
	// RetInfo[11] == IntCount
	// RetInfo[12] == PulseLength
	// RetInfo[13] == ChannelCount
	/////////////////////////////////////////////////


	// Get Irp stack location
	PIO_STACK_LOCATION irpStack = IoGetCurrentIrpStackLocation( Irp );


	// Check I/O control code (do we have to?) Yes!!!
	// We must define a IOCTL using the CTL_CODE macro. 
	// CTL_CODE is defined in Wdm.h (for drivers) and in WinIoctl.h (for Win32 apps).
	// Define the IOCTL in the app and the driver, send it from the app to the driver
	// in the second param of DeviceIoControl() and then check for it here.
	// Make sure TransferType is METHOD_BUFFERED.
	//
	switch (irpStack->Parameters.DeviceIoControl.IoControlCode)
	{
	case IOCTL_TXINTPAR_READ:

		// Get pointer to device extension
		PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

		// Get pointer to the output buffer
		// It is Irp->UserBuffer!!! not Irp->AssociatedIrp.SystemBuffer!!!
		//PVOID pOutBuffer = Irp->AssociatedIrp.SystemBuffer;
		PVOID pOutBuffer = Irp->UserBuffer;

		// Get size of the output buffer
		ULONG OutBufferLength = irpStack->Parameters.DeviceIoControl.OutputBufferLength;


		// Test values
		pdx->SyncPulse = 8000;
		pdx->Ch1 = 1300;
		pdx->Ch2 = 1400;
		pdx->Ch3 = 1500;
		//pdx->Ch4 = 0;
		//pdx->Ch5 = 0;
		//pdx->Ch6 = 0;
		//pdx->Ch7 = 0;		
		//pdx->Ch8 = 0;
		//pdx->Ch9 = 0;
		//pdx->Ch10 = 0;
		pdx->IntCount = 7777;
		pdx->PulseLength = 1500;
		pdx->ChannelCount = 8;


		// Create a buffer
		int Buffer[14];

		// Fill the buffer
		Buffer[0] = pdx->SyncPulse;
		Buffer[1] = pdx->Ch1;
		Buffer[2] = pdx->Ch2;
		Buffer[3] = pdx->Ch3;
		Buffer[4] = pdx->Ch4;
		Buffer[5] = pdx->Ch5;
		Buffer[6] = pdx->Ch6;
		Buffer[7] = pdx->Ch7;
		Buffer[8] = pdx->Ch8;
		Buffer[9] = pdx->Ch9;
		Buffer[10] = pdx->Ch10;
		Buffer[11] = pdx->IntCount;
		Buffer[12] = pdx->PulseLength;
		Buffer[13] = pdx->ChannelCount;

		// Move the buffer to the output buffer
		RtlCopyMemory( pOutBuffer, Buffer, sizeof(Buffer) );
		//memmove( pOutBuffer, Buffer, sizeof(Buffer) );
		//*pOutBuffer = 666; // illegal indirection because pOutBuffer is PVOID and VOID
							// is of unknown size, workaround: cast to PLONG
		//*((PLONG) pOutBuffer+4) = 1666;


		// This is necessary?
		Irp->IoStatus.Information = OutBufferLength;
		
		break;
	}

	return STATUS_SUCCESS;
}							// TxintPar_DispatchDeviceControl
