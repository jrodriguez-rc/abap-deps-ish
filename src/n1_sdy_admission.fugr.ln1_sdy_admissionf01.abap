*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_ADMISSIONF01 .
*----------------------------------------------------------------------*


* Michael Manoch, 11.02.2010, MED-38637
* Whole dynpros redesigned.
* No more forms needed.


**&---------------------------------------------------------------------*
**&      Form  value_request
**&---------------------------------------------------------------------*
**       F4-Help for Field BEKAT
**----------------------------------------------------------------------*
*FORM value_request.
*
** definitions
*  DATA: l_rc                  TYPE ish_method_rc,
*        lr_error              TYPE REF TO cl_ishmed_errorhandling.
*
*  CALL METHOD gr_subscr_admission->value_request
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_error.
*
*ENDFORM.                    " value_request
**&---------------------------------------------------------------------*
**&      Form  pbo_0100
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
*FORM pbo_0100 .
*
** definitions
*  DATA: l_rc                  TYPE ish_method_rc,
*        lr_error              TYPE REF TO cl_ishmed_errorhandling.
*
*  CHECK NOT gr_subscr_admission IS INITIAL.
*
** Set dynpro fields
*  CALL METHOD gr_subscr_admission->process_before_output
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_error.
*
*ENDFORM.                                                    "pbo_0100
**&---------------------------------------------------------------------*
**&      Form  pai_0100
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
*FORM pai_0100 .
*
** definitions
*  DATA: l_rc                  TYPE ish_method_rc,
*        lr_error              TYPE REF TO cl_ishmed_errorhandling.
*
*  CHECK NOT gr_subscr_admission IS INITIAL.
*
*  CALL METHOD gr_subscr_admission->process_after_input
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_error.
*
*ENDFORM.                                                    " pai_0100
*
*
**&---------------------------------------------------------------------*
**&      Form  pbo_lb_falar_0100
**&---------------------------------------------------------------------*
**       Process Before Output for SC_LB_FALAR on dynpro 0100.
**----------------------------------------------------------------------*
*FORM pbo_lb_falar_0100 .
*
*  DATA: l_rc             TYPE ish_method_rc,
*        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.
*
*  CHECK NOT gr_subscr_admission IS INITIAL.
*
** Let the screen object do pbo.
*  CALL METHOD gr_subscr_admission->pbo_lb_falar
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_errorhandler.
*
** Errorhandling
*  IF l_rc <> 0.
*    CALL METHOD gr_subscr_admission->raise_ev_error
*      EXPORTING
*        ir_errorhandler = lr_errorhandler.
*  ENDIF.
*
*ENDFORM.                    " pbo_lb_falar_0100
*
**&---------------------------------------------------------------------*
**&      Form  pbo_lb_fatyp_0100
**&---------------------------------------------------------------------*
**       Process Before Output for SC_LB_FATYP on dynpro 0100.
**----------------------------------------------------------------------*
*FORM pbo_lb_fatyp_0100 .
*
*  DATA: l_rc             TYPE ish_method_rc,
*        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.
*
*  CHECK NOT gr_subscr_admission IS INITIAL.
*
** Let the screen object do pbo.
*  CALL METHOD gr_subscr_admission->pbo_lb_fatyp
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_errorhandler.
*
** Errorhandling
*  IF l_rc <> 0.
*    CALL METHOD gr_subscr_admission->raise_ev_error
*      EXPORTING
*        ir_errorhandler = lr_errorhandler.
*  ENDIF.
*
*ENDFORM.                    " pbo_lb_fatyp_0100
*
**&---------------------------------------------------------------------*
**&      Form  pbo_lb_bewar_0100
**&---------------------------------------------------------------------*
**       Process Before Output for SC_LB_BEWAR on dynpro 0100.
**----------------------------------------------------------------------*
*FORM pbo_lb_bewar_0100 .
*
*  DATA: l_rc             TYPE ish_method_rc,
*        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.
*
*  CHECK NOT gr_subscr_admission IS INITIAL.
*
** Let the screen object do pbo.
*  CALL METHOD gr_subscr_admission->pbo_lb_bewar
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_errorhandler.
*
** Errorhandling
*  IF l_rc <> 0.
*    CALL METHOD gr_subscr_admission->raise_ev_error
*      EXPORTING
*        ir_errorhandler = lr_errorhandler.
*  ENDIF.
*
*ENDFORM.                    " pbo_lb_bewar_0100
*
*
**&---------------------------------------------------------------------*
**&      Form  pai_lb_falar_0100
**&---------------------------------------------------------------------*
**       Process After Input for SC_LB_FALAR on dynpro 0100.
**----------------------------------------------------------------------*
*FORM pai_lb_falar_0100 .
*
*  DATA: l_rc             TYPE ish_method_rc,
*        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.
*
*  CHECK NOT gr_subscr_admission IS INITIAL.
*
** Let the screen object do pai.
*  CALL METHOD gr_subscr_admission->pai_lb_falar
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_errorhandler.
*
** Errorhandling
*  IF l_rc <> 0.
*    CALL METHOD gr_subscr_admission->raise_ev_error
*      EXPORTING
*        ir_errorhandler = lr_errorhandler.
*  ENDIF.
*
*ENDFORM.                    " pai_lb_falar_0100
*
**&---------------------------------------------------------------------*
**&      Form  pai_lb_falar_0100
**&---------------------------------------------------------------------*
**       Process After Input for SC_LB_FATYP on dynpro 0100.
**----------------------------------------------------------------------*
*FORM pai_lb_fatyp_0100 .
*
*  DATA: l_rc             TYPE ish_method_rc,
*        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.
*
*  CHECK NOT gr_subscr_admission IS INITIAL.
*
** Let the screen object do pai.
*  CALL METHOD gr_subscr_admission->pai_lb_fatyp
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_errorhandler.
*
** Errorhandling
*  IF l_rc <> 0.
*    CALL METHOD gr_subscr_admission->raise_ev_error
*      EXPORTING
*        ir_errorhandler = lr_errorhandler.
*  ENDIF.
*
*ENDFORM.                    " pai_lb_fatyp_0100
*
**&---------------------------------------------------------------------*
**&      Form  pai_lb_bewar_0100
**&---------------------------------------------------------------------*
**       Process After Input for SC_LB_BEWAR on dynpro 0100.
**----------------------------------------------------------------------*
*FORM pai_lb_bewar_0100 .
*
*  DATA: l_rc             TYPE ish_method_rc,
*        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.
*
*  CHECK NOT gr_subscr_admission IS INITIAL.
*
** Let the screen object do pai.
*  CALL METHOD gr_subscr_admission->pai_lb_bewar
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_errorhandler.
*
** Errorhandling
*  IF l_rc <> 0.
*    CALL METHOD gr_subscr_admission->raise_ev_error
*      EXPORTING
*        ir_errorhandler = lr_errorhandler.
*  ENDIF.
*
*ENDFORM.                    " pai_lb_bewar_0100
