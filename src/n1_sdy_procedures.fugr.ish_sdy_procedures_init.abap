FUNCTION ISH_SDY_PROCEDURES_INIT.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_PROCEDURES) TYPE REF TO  CL_ISH_SCR_PROCEDURES
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(ES_PARENT) TYPE  RNSCR_PARENT
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"     REFERENCE(CR_DYNP_DATA) TYPE REF TO  DATA
*"----------------------------------------------------------------------

  CLEAR: gr_subscr_procedures,
         es_parent,
         e_rc.

* Handle process object.
  gr_subscr_procedures = ir_scr_procedures.
  IF gr_subscr_procedures IS INITIAL.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* program and dynpro
  CALL METHOD gr_subscr_procedures->get_parent
    IMPORTING
      es_parent = es_parent.

** Export dynpro structure.
*  GET REFERENCE OF npat INTO cr_dynp_data.

ENDFUNCTION.
