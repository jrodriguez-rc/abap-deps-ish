*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_ORDERF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       process before output
*----------------------------------------------------------------------*
FORM pbo_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_order IS INITIAL.

* Set dynpro fields
  CALL METHOD gr_subscr_order->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                                                    "pbo_0100
*&---------------------------------------------------------------------*
*&      Form  pai_0100
*&---------------------------------------------------------------------*
*       process after input
*----------------------------------------------------------------------*
FORM pai_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_order IS INITIAL.

  CALL METHOD gr_subscr_order->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                                                    " pai_0100
*&---------------------------------------------------------------------*
*&      Form  value_request
*&---------------------------------------------------------------------*
*       F4-help
*----------------------------------------------------------------------*
FORM value_request.

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CALL METHOD gr_subscr_order->value_request
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                    " value_request
