*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_COMMENTF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  pai_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pai_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_comment IS INITIAL.

  CALL METHOD gr_subscr_comment->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                                                    " pai_0100
*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pbo_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_comment IS INITIAL.

  CALL METHOD gr_subscr_comment->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  CALL METHOD gr_subscr_comment->get_dynpro_comment
    IMPORTING
      e_pgm_comment   = g_dynpg
      e_dynnr_comment = g_dynnr.

ENDFORM.                                                    " pbo_0100
