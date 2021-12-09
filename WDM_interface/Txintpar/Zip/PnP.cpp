// Plug and Play handlers for TxintPar driver

#include "stddcls.h"
#include "driver.h"

///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS TxintPar_DispatchPnp( IN PDEVICE_OBJECT fdo, IN PIRP Irp )
{							// TxintPar_DispatchPnp
	PAGED_CODE();

	PIO_STACK_LOCATION stack = IoGetCurrentIrpStackLocation(Irp);
	ULONG fcn = stack->MinorFunction;
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;

	switch (fcn)
	{						// process PNP request
		case IRP_MN_START_DEVICE:
		{						// IRP_MN_START_DEVICE
			NTSTATUS status = TxP_ForwardAndWait(fdo, Irp);
			if (!NT_SUCCESS(status))
				return TxP_CompleteRequest(Irp, status, Irp->IoStatus.Information);

			PCM_PARTIAL_RESOURCE_LIST raw = stack->Parameters.StartDevice.AllocatedResources
				? &stack->Parameters.StartDevice.AllocatedResources->List[0].PartialResourceList
				: NULL;

			PCM_PARTIAL_RESOURCE_LIST translated = stack->Parameters.StartDevice.AllocatedResourcesTranslated
				? &stack->Parameters.StartDevice.AllocatedResourcesTranslated->List[0].PartialResourceList
				: NULL;

			// Start 'r up, Ma!
			status = TxP_StartDevice(fdo, raw, translated);

			return TxP_CompleteRequest(Irp, status, 0);
		}						// IRP_MN_START_DEVICE

		case IRP_MN_QUERY_STOP_DEVICE:
		case IRP_MN_QUERY_REMOVE_DEVICE:
			return TxP_CompleteRequest(Irp, STATUS_UNSUCCESSFUL, 0);

		default:
			IoSkipCurrentIrpStackLocation(Irp);
			return IoCallDriver(pdx->LowerDeviceObject, Irp);
	
	}						// process PNP request
}							// TxintPar_DispatchPnp