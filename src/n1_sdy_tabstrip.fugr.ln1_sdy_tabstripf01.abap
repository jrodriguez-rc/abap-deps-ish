*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_TABSTRIPF01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  pbo
*&---------------------------------------------------------------------*
*       Process Before Output
*----------------------------------------------------------------------*
FORM pbo .

  DATA: l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_scr_tabstrip IS INITIAL.

* Let the screen object do pbo.
  CALL METHOD gr_scr_tabstrip->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* Errorhandling
  IF l_rc <> 0.
    CALL METHOD gr_scr_tabstrip->raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                    " pbo


*&---------------------------------------------------------------------*
*&      Form  pbo_subscreen
*&---------------------------------------------------------------------*
*       Process Before Output for SC_TABSTRIP.
*----------------------------------------------------------------------*
FORM pbo_subscreen .

  DATA: l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_scr_tabstrip IS INITIAL.

* Let the screen object do pbo.
  CALL METHOD gr_scr_tabstrip->pbo_subscreen
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* Errorhandling
  IF l_rc <> 0.
    CALL METHOD gr_scr_tabstrip->raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                    " pbo_subscreen


*&---------------------------------------------------------------------*
*&      Form  pai
*&---------------------------------------------------------------------*
*       Process After Input.
*----------------------------------------------------------------------*
FORM pai .

  DATA: l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_scr_tabstrip IS INITIAL.

* Let the screen object do pai.
  CALL METHOD gr_scr_tabstrip->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* Errorhandling
  IF l_rc <> 0.
    CALL METHOD gr_scr_tabstrip->raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                    " pai


*&---------------------------------------------------------------------*
*&      Form  pai_subscreen
*&---------------------------------------------------------------------*
*       Process After Input for SC_TABSTRIP.
*----------------------------------------------------------------------*
FORM pai_subscreen .

  DATA: l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_scr_tabstrip IS INITIAL.

* Let the screen object do pai.
  CALL METHOD gr_scr_tabstrip->pai_subscreen
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* Errorhandling
  IF l_rc <> 0.
    CALL METHOD gr_scr_tabstrip->raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                    " pai_subscreen
