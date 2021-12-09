// Windows Management Instrumentation handlers for TxintPar driver

#include "stddcls.h"
#include "driver.h"

///////////////////////////////////////////////////////////////////////////////

NTSTATUS TxintPar_DispatchSystemControl( IN PDEVICE_OBJECT fdo, IN PIRP Irp )
{							// TxintPar_DispatchSystemControl
	IoSkipCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION pdx = (PDEVICE_EXTENSION) fdo->DeviceExtension;
	return IoCallDriver(pdx->LowerDeviceObject, Irp);
}							// TxintPar_DispatchSystemControl
