FUNCTION ISH_SDY_REFERRAL_INIT.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_REFERRAL) TYPE REF TO  CL_ISH_SCR_REFERRAL
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(ES_PARENT) TYPE  RNSCR_PARENT
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"     REFERENCE(CR_DYNP_DATA) TYPE REF TO  DATA
*"----------------------------------------------------------------------

  CLEAR: gr_subscr_referral,
         es_parent,
         e_rc.

* Handle process object.
  gr_subscr_referral = ir_scr_referral.
  IF gr_subscr_referral IS INITIAL.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* program and dynpro
  CALL METHOD gr_subscr_referral->get_parent
    IMPORTING
      es_parent    = es_parent.

* Export dynpro structure.
  GET REFERENCE OF rn1_dynp_referral INTO cr_dynp_data.

ENDFUNCTION.
