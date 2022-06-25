*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_LISTBOXF01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  pbo
*&---------------------------------------------------------------------*
*       Process Before Output
*----------------------------------------------------------------------*
FORM pbo .

  DATA: l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_screen IS INITIAL.

* Let the screen object do pbo.
  CALL METHOD gr_screen->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* Errorhandling
  IF l_rc <> 0.
    CALL METHOD gr_screen->if_ish_screen~raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                    " pbo


*&---------------------------------------------------------------------*
*&      Form  pai
*&---------------------------------------------------------------------*
*       Process After Input
*----------------------------------------------------------------------*
FORM pai .

  DATA: l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_screen IS INITIAL.

* Let the screen object do pai.
  CALL METHOD gr_screen->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* Errorhandling
  IF l_rc <> 0.
    CALL METHOD gr_screen->if_ish_screen~raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                    " pai


*&---------------------------------------------------------------------*
*&      Form  help
*&---------------------------------------------------------------------*
*       help request
*----------------------------------------------------------------------*
FORM help .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

  CHECK NOT gr_screen IS INITIAL.

* Let the screen object do help-request.
  CALL METHOD gr_screen->help_request
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* Errorhandling.
  IF l_rc <> 0.
    CALL METHOD gr_screen->raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                    " help
