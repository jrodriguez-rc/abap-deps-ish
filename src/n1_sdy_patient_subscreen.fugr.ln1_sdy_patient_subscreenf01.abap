*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_ADMISSIONF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pbo_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling,
        lt_messages           TYPE ishmed_t_bapiret2.

  CHECK NOT gr_subscr_patient IS INITIAL.

  CALL METHOD gr_subscr_patient->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  CALL METHOD gr_subscr_patient->get_dynpro_pat
    IMPORTING
      e_pgm_pat   = g_dynpg
      e_dynnr_pat = g_dynnr.

*-- begin Grill, ID-17621
* Errorhandling
  CHECK NOT lr_error IS INITIAL.
  CALL METHOD lr_error->get_messages
    IMPORTING
      t_messages = lt_messages.

  CHECK NOT lt_messages[] IS INITIAL.

  CALL METHOD gr_subscr_patient->raise_ev_error
    EXPORTING
      ir_errorhandler = lr_error.
*-- end Grill, ID-17621
ENDFORM.                                                    "pbo_0100
*&---------------------------------------------------------------------*
*&      Form  pai_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pai_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling,
        lt_messages           TYPE ishmed_t_bapiret2.


  CHECK NOT gr_subscr_patient IS INITIAL.

  CALL METHOD gr_subscr_patient->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

*-- begin Grill, ID-17621
* Errorhandling
  CHECK NOT lr_error IS INITIAL.
  CALL METHOD lr_error->get_messages
    IMPORTING
      t_messages = lt_messages.

  CHECK NOT lt_messages[] IS INITIAL.

  CALL METHOD gr_subscr_patient->raise_ev_error
    EXPORTING
      ir_errorhandler = lr_error.
*-- end Grill, ID-17621

ENDFORM.                                                    " pai_0100
*&---------------------------------------------------------------------*
*&      Form  after_call_subscr_pbo
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM after_call_subscr_pbo.

  DATA:lt_messages TYPE ishmed_t_bapiret2.

  FIELD-SYMBOLS: <lr_errorhandler>  TYPE REF TO cl_ishmed_errorhandling.

  CHECK gr_subscr_patient IS BOUND.

  ASSIGN ('(SAPLN1VPS)GR_ERRORHANDLER') TO <lr_errorhandler>.

*  CHECK sy-subrc = 0.
*-- grill, ID-17621
  check <lr_errorhandler> is ASSIGNED. "ED, ID 20448
  CHECK NOT <lr_errorhandler> IS INITIAL.
  CALL METHOD <lr_errorhandler>->get_messages
    IMPORTING
      t_messages = lt_messages.

  CHECK NOT lt_messages[] IS INITIAL.
*-- end Grill, ID-17621
  CALL METHOD gr_subscr_patient->raise_ev_error
    EXPORTING
      ir_errorhandler = <lr_errorhandler>.

ENDFORM.      "after_call_subscr_pbo
