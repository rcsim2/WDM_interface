// Read/Write request processors for TxintPar driver

#include "stddcls.h"
#include "driver.h"

#pragma PAGEDCODE

///////////////////////////////////////////////////////////////////////////////

NTSTATUS TxP_StartDevice( PDEVICE_OBJECT fdo, PCM_PARTIAL_RESOURCE_LIST raw, 
							PCM_PARTIAL_RESOURCE_LIST translated )
{							// TxP_StartDevice

	NTSTATUS status;
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	BOOLEAN foundPort	   = FALSE;
	BOOLEAN foundInterrupt = FALSE;
	BOOLEAN foundMemory    = FALSE;
	BOOLEAN foundDma	   = FALSE;


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

				// Get interrupt resources 
				pdx->Vector = resource->u.Interrupt.Vector;
				pdx->Irql = (KIRQL)resource->u.Interrupt.Level;
				pdx->SynchronizeIrql = (KIRQL)resource->u.Interrupt.Level;
				pdx->InterruptMode = Latched;
				pdx->ShareVector = FALSE;
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


	



	return STATUS_SUCCESS;
}							// TxP_StartDevice



///////////////////////////////////////////////////////////////////////////////

NTSTATUS TxP_ConnectInterrupt( IN PDEVICE_EXTENSION pdx )
{							// TxP_ConnectInterrupt

	NTSTATUS status;

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


	return status;;
}							// TxP_ConnectInterrupt


///////////////////////////////////////////////////////////////////////////////

BOOLEAN TxP_InterruptService( IN PKINTERRUPT Interrupt, IN PVOID ServiceContext )
{							// TxP_InterruptService
	return FALSE;
}							// TxP_InterruptService
