*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_PROCEDURESF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pbo_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_procedures IS INITIAL.

  CALL METHOD gr_subscr_procedures->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  CALL METHOD gr_subscr_procedures->get_dynpro_procedures
    IMPORTING
      e_pgm_procedures   = g_dynpg
      e_dynnr_procedures = g_dynnr.

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

  CHECK NOT gr_subscr_procedures IS INITIAL.

  CALL METHOD gr_subscr_procedures->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                                                    " pai_0100
