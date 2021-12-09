// Power request handler TxintUsb driver

#include "stddcls.h"
#include "driver.h"
									  
///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS DispatchPower(IN PDEVICE_OBJECT fdo, IN PIRP Irp)
{							// DispatchPower
	PAGED_CODE();
	PoStartNextPowerIrp(Irp);	// must be done while we own the IRP
	IoSkipCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;
	return PoCallDriver(pdx->LowerDeviceObject, Irp);
}							// DispatchPower
