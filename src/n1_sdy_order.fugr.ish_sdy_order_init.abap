FUNCTION ish_sdy_order_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_ORDER) TYPE REF TO  CL_ISH_SCR_ORDER
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(ES_PARENT) TYPE  RNSCR_PARENT
*"  CHANGING
*"     REFERENCE(CR_DYNP_DATA) TYPE REF TO  DATA
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

  CLEAR: gr_subscr_order,
         es_parent,
         e_rc.

* Handle process object.
  gr_subscr_order = ir_scr_order.
  IF gr_subscr_order IS INITIAL.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* program and dynpro
  CALL METHOD gr_subscr_order->get_parent
    IMPORTING
      es_parent = es_parent.

* Export dynpro structure.
  GET REFERENCE OF rn1_dynp_order INTO cr_dynp_data.

ENDFUNCTION.
