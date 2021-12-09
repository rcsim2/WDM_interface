// Read/Write request processors for TxintPar driver

#include "stddcls.h"
#include "driver.h"

#pragma PAGEDCODE

///////////////////////////////////////////////////////////////////////////////

NTSTATUS TxP_StartDevice( PDEVICE_OBJECT fdo, PCM_PARTIAL_RESOURCE_LIST raw, 
							PCM_PARTIAL_RESOURCE_LIST translated )
{							// TxP_StartDevice

	NTSTATUS status = STATUS_SUCCESS;
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	BOOLEAN foundPort	   = FALSE;
	BOOLEAN foundInterrupt = FALSE;
	BOOLEAN foundMemory    = FALSE;
	BOOLEAN foundDma	   = FALSE;

	// test
	//pdx->Ch5 = 1750;

	// TODO: we are leaving here because the PnP manager gives us no translated
	// resources. How can we get them? Or should we just grab them?
	if (!translated)
		return STATUS_SUCCESS;	// nothing to do if no resources

	// Identify the I/O resources we're supposed to use.	
	PCM_PARTIAL_RESOURCE_DESCRIPTOR resource = translated->PartialDescriptors;
	ULONG nres = translated->Count;
	for (ULONG i = 0; i < nres; ++i, ++resource)
	{						// for each resource
		switch (resource->Type)
		{					// switch on resource type

			case CmResourceTypePort:
				break;
		
			case CmResourceTypeInterrupt:
				// got it
				foundInterrupt = TRUE;

				// Obsolete
				// We get the Vector with HalGetInterruptVector()
                //pdx->Vector = HalGetInterruptVector( resource->InterfaceType,
				//									   resource->BusNumber,
				//								       resource->u.Interrupt.Level,
				//									   resource->u.Interrupt.Vector,
				//								       &(pdx->Irql),
				//								       &(pdx->ProcessorEnableMask) );

				// looks like we don't even get here: 
				// cause: no interrupt resources in resource list
				// test
				pdx->Ch5 = 1750;

				// Get interrupt resources 
				pdx->Vector = resource->u.Interrupt.Vector;
				pdx->Irql = (KIRQL)resource->u.Interrupt.Level;
				pdx->SynchronizeIrql = (KIRQL)resource->u.Interrupt.Level;
				pdx->InterruptMode = Latched;
				pdx->ShareVector = TRUE;
				pdx->ProcessorEnableMask = resource->u.Interrupt.Affinity; 
				pdx->FloatingSave = FALSE;

				// Let's connect it
				TxP_ConnectInterrupt( pdx );
				break;
			
			case CmResourceTypeMemory:
				break;

			case CmResourceTypeDma:
				break;

			default:
				break;

		}					// switch on resource type
	}						// for each resource



	return status;
}							// TxP_StartDevice



///////////////////////////////////////////////////////////////////////////////

NTSTATUS TxP_ConnectInterrupt( IN PDEVICE_EXTENSION pdx )
{							// TxP_ConnectInterrupt

	NTSTATUS status;
/*
	// Before actually connecting the interrupt let's initialize our channel and
	// interrupt variables.
	// These will be used in our ISR (TxP_InterruptService()).
	pdx->IntCount = 0;
	pdx->PrevIntTime = 0;
	pdx->GotIntTime = 0;
	pdx->PulseLength = 0;
	pdx->GotSync = 0;
	pdx->ChannelCount = 0;
	pdx->SyncPulse = 0;
	pdx->Ch1 = 0;
	pdx->Ch2 = 0;
	pdx->Ch3 = 0;
	pdx->Ch4 = 0;
	pdx->Ch5 = 0;
	pdx->Ch6 = 0;
	pdx->Ch7 = 0;
	pdx->Ch8 = 0;
	pdx->Ch9 = 0;
	pdx->Ch10 = 0;
*/

	// test
	//pdx->Ch5 = 1750;

	
	// NOTE: We must use parport's IOCTL_INTERNAL_PARALLEL_CONNECT_INTERRUPT
	// instead of IoConnectInterrupt()
	// Connect the interrupt
    status = IoConnectInterrupt( &(pdx->InterruptObject),
                                 TxP_InterruptService,
                                 pdx,
                                 NULL,
                                 pdx->Vector,
                                 pdx->Irql,
                                 pdx->SynchronizeIrql,
                                 pdx->InterruptMode,
                                 pdx->ShareVector,
                                 pdx->ProcessorEnableMask,
                                 pdx->FloatingSave );



	//; Enable IRQ on Par. Port!!!!!!!!!!
	//_asm {
	//						//; Enable IRQ on Par. Port!!!!!!!!!!
	//	mov	dx, 378h+2		//; got to use dx for ports > 255 (dec)
	//	in	al, dx			//; read par. port Control register (378h + 2)
	//	or 	al, 10h			//; enable interrupts on line 10 (ACK) (set bit 4)
	//	out	dx, al			//; write back to Control register
	//}


	return status;
}							// TxP_ConnectInterrupt


///////////////////////////////////////////////////////////////////////////////

#pragma LOCKEDCODE

BOOLEAN TxP_InterruptService( IN PKINTERRUPT Interrupt, IN PVOID ServiceContext )
{							// TxP_InterruptService

	// Our ServiceContext is the device extension (third param of IoConnectInterrupt())
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) ServiceContext;

	// test
	pdx->Ch5 = 1750;

/*
	// Keep count of how many interrupts we processed
	pdx->IntCount++;

	// Start time stamping: we need resolution fine enough for 1000-2000 uS (1-2 ms)
	// KeQueryTickCount()			coarse grained
	// KeQueryInterruptTime()		fine grained: 100-nanosecond units == 0.1 uS
	// KeQueryPerformanceCounter()	finest grained

	// Time stamp first interrupt
	if ( !pdx->GotIntTime ) {
		pdx->PrevIntTime = (int)KeQueryInterruptTime();
		pdx->GotIntTime = true;
		return TRUE;
	}

	// Subtract previous time stamp from current time stamp
	// We don't need ULONGLONG, only int
	pdx->PulseLength = (int)KeQueryInterruptTime() - pdx->PrevIntTime;

	// Save current time stamp for next time
	pdx->PrevIntTime = (int)KeQueryInterruptTime();

	// If timer goes from FFFFFFFFh to 00000000h we get a great negative value:
	// Compensate it
	if ( pdx->PulseLength < 0 )
		pdx->PulseLength += 0xFFFFFFFF;

	// It is more convenient to work with with 1 uS units
	pdx->PulseLength /= 10;

	// Check if it is the sync pulse
	if ( pdx->PulseLength > 5000 ) {
		pdx->GotSync = true;
		pdx->ChannelCount = 0;
		pdx->SyncPulse = pdx->PulseLength;
		return TRUE;
	}

	// Set channels
	if ( pdx->GotSync ) {
		pdx->ChannelCount++;

		switch ( pdx->ChannelCount ) 
		{
			case 1: pdx->Ch1 = pdx->PulseLength; return TRUE; break;
			case 2: pdx->Ch2 = pdx->PulseLength; return TRUE; break;
			case 3: pdx->Ch3 = pdx->PulseLength; return TRUE; break;
			case 4: pdx->Ch4 = pdx->PulseLength; return TRUE; break;
			case 5: pdx->Ch5 = pdx->PulseLength; return TRUE; break;
			case 6: pdx->Ch6 = pdx->PulseLength; return TRUE; break;
			case 7: pdx->Ch7 = pdx->PulseLength; return TRUE; break;
			case 8: pdx->Ch8 = pdx->PulseLength; return TRUE; break;
			case 9: pdx->Ch9 = pdx->PulseLength; return TRUE; break;
			case 10: pdx->Ch10 = pdx->PulseLength; return TRUE; break;
		}
	}

	// test
	//pdx->Ch3 = 1750;
*/
	return TRUE;
}							// TxP_InterruptService
