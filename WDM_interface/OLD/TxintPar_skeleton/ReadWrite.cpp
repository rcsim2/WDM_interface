// Read/Write request processors for TxintPar driver

#include "stddcls.h"
#include "driver.h"

#pragma PAGEDCODE

///////////////////////////////////////////////////////////////////////////////

NTSTATUS TxP_StartDevice(PDEVICE_OBJECT fdo, PCM_PARTIAL_RESOURCE_LIST raw, PCM_PARTIAL_RESOURCE_LIST translated)
{							// TxP_StartDevice

	NTSTATUS status;
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

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
