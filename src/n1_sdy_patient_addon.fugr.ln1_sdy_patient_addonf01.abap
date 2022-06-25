*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_PATIENT_ADDONF01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       PBO processing for dynpro 0100.
*----------------------------------------------------------------------*
FORM pbo_0100 .

  DATA: l_rc            TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_scr_patient_addon IS INITIAL.

* Let the screen object do pbo.
  CALL METHOD gr_scr_patient_addon->pbo
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_errorhandler.

* Errorhandling
  IF l_rc <> 0.
    CALL METHOD gr_scr_patient_addon->raise_ev_error
      EXPORTING
        ir_errorhandler = lr_errorhandler.
    EXIT.
  ENDIF.

ENDFORM.                                                    " pbo_0100
