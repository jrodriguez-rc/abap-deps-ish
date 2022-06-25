FUNCTION ish_sdy_context_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_CONTEXT) TYPE REF TO  CL_ISH_SCR_CONTEXT
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(ES_PARENT) TYPE  RNSCR_PARENT
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"     REFERENCE(CR_DYNP_DATA) TYPE REF TO  DATA
*"----------------------------------------------------------------------

  CLEAR: gr_subscr_context,
         es_parent,
         e_rc.
* Handle process object.
  gr_subscr_context = ir_scr_context.
  IF gr_subscr_context IS INITIAL.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* program and dynpro
  CALL METHOD gr_subscr_context->get_parent
    IMPORTING
      es_parent = es_parent.

  CALL METHOD gr_subscr_context->get_data
    IMPORTING
      e_first_time = g_first_time.

** Export dynpro structure.
*  GET REFERENCE OF rn1_dynp_context INTO cr_dynp_data.

ENDFUNCTION.
