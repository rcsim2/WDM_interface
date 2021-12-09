// Create request handler for TxintPar driver

#include "stddcls.h"
#include "driver.h"
									  
///////////////////////////////////////////////////////////////////////////////

#pragma PAGEDCODE

NTSTATUS TxintPar_DispatchCreate( IN PDEVICE_OBJECT fdo, IN PIRP Irp )
{							// TxintPar_DispatchCreate
	PAGED_CODE();
	
	return STATUS_SUCCESS;
}							// TxintPar_DispatchCreate
