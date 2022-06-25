*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_PUSHBUTTONF01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  pbo
*&---------------------------------------------------------------------*
*       Process Before Output
*----------------------------------------------------------------------*
FORM pbo .

  DATA: l_pbname         LIKE pb_100,
        l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS: <l_pb>  LIKE pb_100.

  CHECK NOT gr_screen IS INITIAL.

* Get the name of the pushbutton.
  l_pbname = gr_screen->get_pbname( ).

* Assign a field-symbol to the pushbutton.
  ASSIGN (l_pbname) TO <l_pb>.

  CHECK <l_pb> IS ASSIGNED.

* Set pushbutton.
  <l_pb> = gr_screen->get_pbstring( ).

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
