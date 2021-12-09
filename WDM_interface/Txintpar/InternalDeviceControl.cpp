// Internal Device Control request handler for TxintPar driver

#include "stddcls.h"
#include "driver.h"

#include <parallel.h>
									  
///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS TxintPar_DispatchInternalDeviceControl( IN PDEVICE_OBJECT fdo, IN PIRP Irp )
{							// TxintPar_DispatchInternalDeviceControl
	
	// Get Irp stack location
	PIO_STACK_LOCATION irpStack = IoGetCurrentIrpStackLocation( Irp );

	switch (irpStack->Parameters.DeviceIoControl.IoControlCode)
	{
	case IOCTL_INTERNAL_PARCLASS_CONNECT:
		break;

	case IOCTL_INTERNAL_PARCLASS_DISCONNECT:
		break;

	case IOCTL_INTERNAL_LOCK_PORT:
		break;

	case IOCTL_INTERNAL_UNLOCK_PORT:
		break;
	}

	return STATUS_SUCCESS;
}							// TxintPar_DispatchInternalDeviceControl
