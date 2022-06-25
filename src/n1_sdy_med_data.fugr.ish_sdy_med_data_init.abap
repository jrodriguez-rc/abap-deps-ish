FUNCTION ish_sdy_med_data_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_MED_DATA) TYPE REF TO  CL_ISH_SCR_MED_DATA
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(ES_PARENT) TYPE  RNSCR_PARENT
*"  CHANGING
*"     REFERENCE(CR_DYNP_DATA) TYPE REF TO  DATA
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

  CLEAR: gr_subscr_med_data,
         es_parent,
         e_rc.

* Handle process object.
  gr_subscr_med_data = ir_scr_med_data.
  IF gr_subscr_med_data IS INITIAL.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* program and dynpro
  CALL METHOD gr_subscr_med_data->get_parent
    IMPORTING
      es_parent = es_parent.

* Export dynpro structure.
  GET REFERENCE OF rn1_dynp_med_data INTO cr_dynp_data.

ENDFUNCTION.
