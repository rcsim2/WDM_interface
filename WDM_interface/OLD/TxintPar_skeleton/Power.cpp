// Power request handler TxintPar driver

#include "stddcls.h"
#include "driver.h"
									  
///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS TxintPar_DispatchPower(IN PDEVICE_OBJECT fdo, IN PIRP Irp)
{							// TxintPar_DispatchPower
	PAGED_CODE();
	PoStartNextPowerIrp(Irp);	// must be done while we own the IRP
	IoSkipCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;
	return PoCallDriver(pdx->LowerDeviceObject, Irp);
}							// TxintPar_DispatchPower
