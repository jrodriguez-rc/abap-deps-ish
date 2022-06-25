FUNCTION ISH_GET_PARAMETER_ID .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PARAMETER_ID) TYPE  ANY
*"  EXPORTING
*"     VALUE(E_PARAMETER_VALUE) TYPE  ANY
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"----------------------------------------------------------------------

* Initialization
  e_rc = 0.
  clear: e_parameter_value.

* Get value of this parameter
  check not i_parameter_id is initial.

  get parameter id i_parameter_id field e_parameter_value.
ENDFUNCTION.
