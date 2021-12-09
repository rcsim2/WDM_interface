// Windows Management Instrumentation handlers for TxintUsb driver

#include "stddcls.h"
#include "driver.h"

///////////////////////////////////////////////////////////////////////////////

NTSTATUS DispatchWmi(IN PDEVICE_OBJECT fdo, IN PIRP Irp)
{							// DispatchWmi
	IoSkipCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;
	return IoCallDriver(pdx->LowerDeviceObject, Irp);
}							// DispatchWmi
