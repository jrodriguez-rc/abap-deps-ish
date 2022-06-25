*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_ADMISSIONF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  value_request
*&---------------------------------------------------------------------*
*       F4-Help for Fields
*----------------------------------------------------------------------*
FORM value_request.

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CALL METHOD gr_subscr_waiting_list->value_request
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                    " value_request
*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pbo_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_waiting_list IS INITIAL.

* Set dynpro fields
  CALL METHOD gr_subscr_waiting_list->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  CALL METHOD gr_subscr_waiting_list->get_dynpro_waiting_list
    IMPORTING
      e_pgm_waiting_list   = g_dynpg
      e_dynnr_waiting_list = g_dynnr.

ENDFORM.                                                    "pbo_0100
*&---------------------------------------------------------------------*
*&      Form  pai_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pai_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_waiting_list IS INITIAL.

  CALL METHOD gr_subscr_waiting_list->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                                                    " pai_0100
