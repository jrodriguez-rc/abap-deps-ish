*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_COMPCON_SRVTEAMF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM pbo_0100 .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

  CHECK NOT gr_screen IS INITIAL.

  CALL METHOD gr_screen->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

  IF l_rc <> 0.
    CALL METHOD gr_screen->raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                                                    " pbo_0100


*&---------------------------------------------------------------------*
*&      Form  pai_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM pai_0100 .

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

  CHECK NOT gr_screen IS INITIAL.

  CALL METHOD gr_screen->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

  IF l_rc <> 0.
    CALL METHOD gr_screen->raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
  ENDIF.

ENDFORM.                                                    " pai_0100
