FUNCTION ISH_SDY_INSURANCE_INIT.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_INSURANCE) TYPE REF TO  CL_ISH_SCR_INSURANCE
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(ES_PARENT) TYPE  RNSCR_PARENT
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"     REFERENCE(CR_DYNP_DATA) TYPE REF TO  DATA
*"----------------------------------------------------------------------

  CLEAR: gr_subscr_insurance,
         es_parent,
         e_rc.

* Handle process object.
  gr_subscr_insurance = ir_scr_insurance.
  IF gr_subscr_insurance IS INITIAL.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* program and dynpro
  CALL METHOD gr_subscr_insurance->get_parent
    IMPORTING
      es_parent = es_parent.

** Export dynpro structure.
*  GET REFERENCE OF npat INTO cr_dynp_data.

ENDFUNCTION.
