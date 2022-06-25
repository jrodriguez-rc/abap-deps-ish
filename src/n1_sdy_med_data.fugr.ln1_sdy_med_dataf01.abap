*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_MED_DATAF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  value_request
*&---------------------------------------------------------------------*
*       F4-Help
*----------------------------------------------------------------------*
*FORM value_request.
*
** definitions
*  DATA: l_rc                  TYPE ish_method_rc,
*        lr_error              TYPE REF TO cl_ishmed_errorhandling.
*
*  CALL METHOD gr_subscr_med_data->value_request
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = lr_error.
*
*ENDFORM.                    " VALUE_REQUEST
*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       process before output
*----------------------------------------------------------------------*
FORM pbo_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling,
        l_risc_facts          TYPE ish_on_off,
        l_icon(10)            TYPE c.

  CHECK NOT gr_subscr_med_data IS INITIAL.

* Set dynpro fields
  CALL METHOD gr_subscr_med_data->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  CHECK l_rc = 0.

* check button RISK_FACTS
* if there are risk facts for the patient -> then show icon
  CALL METHOD gr_subscr_med_data->check_risc_facts_for_patient
    IMPORTING
      e_risc_facts    = l_risc_facts
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  CHECK l_rc = 0.
  IF l_risc_facts = on.
    l_icon = icon_warning.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name                  = l_icon
        text                  = 'Risikofaktoren'(001)
        info                  = 'Risikofaktoren'(001)
      IMPORTING
*       RESULT                = risk_facts                    "REM MED-34948
        result                = rn1_dynp_med_data-risk_facts      "MED-34948
      EXCEPTIONS
        icon_not_found        = 1
        outputfield_too_short = 2
        OTHERS                = 3.
    l_rc = sy-subrc.
    CHECK l_rc = 0.
*    CONCATENATE 'Risikofaktoren'(001) l_icon INTO risk_facts
*    SEPARATED BY space.
  ELSE.
*    risk_facts = 'Risikofaktoren'(001).                "REM MED-34948
    rn1_dynp_med_data-risk_facts = 'Risikofaktoren'(001).   "MED-34948
  ENDIF.

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

  CHECK NOT gr_subscr_med_data IS INITIAL.

  CALL METHOD gr_subscr_med_data->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  CHECK l_rc = 0.

ENDFORM.                                                    " pai_0100
