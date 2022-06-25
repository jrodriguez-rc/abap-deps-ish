FUNCTION ish_sdy_comment_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_COMMENT) TYPE REF TO  CL_ISH_SCR_COMMENT
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(ES_PARENT) TYPE  RNSCR_PARENT
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"     REFERENCE(CR_DYNP_DATA) TYPE REF TO  DATA
*"----------------------------------------------------------------------

  CLEAR: gr_subscr_comment,
         es_parent,
         e_rc.

* Handle process object.
  gr_subscr_comment = ir_scr_comment.
  IF gr_subscr_comment IS INITIAL.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* program and dynpro
  CALL METHOD gr_subscr_comment->get_parent
    IMPORTING
      es_parent = es_parent.

** Export dynpro structure.
*  GET REFERENCE OF npat INTO cr_dynp_data.

ENDFUNCTION.
