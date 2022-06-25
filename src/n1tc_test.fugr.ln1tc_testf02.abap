*----------------------------------------------------------------------*
***INCLUDE LN1TC_TESTF02 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  START_TASK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0025   text
*----------------------------------------------------------------------*
FORM start_task
  USING    value(p_task) TYPE n1tc_task_desc.
  DATA lv_timestamp TYPE timestamp.

  rn1tc_stop_clock-task = p_task.

  TRY.
      GET TIME STAMP FIELD rn1tc_stop_clock-start_timestamp.
      GET TIME STAMP FIELD lv_timestamp.

      cl_abap_tstmp=>systemtstmp_utc2syst(
        EXPORTING
          utc_tstmp = lv_timestamp    " UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss)
        IMPORTING
*       syst_date = syst_date    " System Datum
          syst_time = rn1tc_stop_clock-start_time    " System Zeit
      ).
    CATCH cx_parameter_invalid_range.    " Parameter mit ungültigem Wertebereich
      rn1tc_stop_clock-start_time = sy-uzeit.
  ENDTRY.
ENDFORM.                    " START_TASK
*&---------------------------------------------------------------------*
*&      Form  STOP_TASK
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM stop_task .
  DATA lv_timestamp TYPE timestamp.

  GET TIME STAMP FIELD rn1tc_stop_clock-stop_timestamp.
*  lv_duration = lv_stop_timestamp - lv_start_timestamp.

  TRY.
      cl_abap_tstmp=>subtract(
        EXPORTING
          tstmp1 = rn1tc_stop_clock-stop_timestamp    " UTC-Zeitstempel
          tstmp2 = rn1tc_stop_clock-start_timestamp    " UTC-Zeitstempel
        RECEIVING
          r_secs = rn1tc_stop_clock-duration    " Zeitspanne in Sekunden
      ).
    CATCH cx_parameter_invalid_range.    " Parameter mit ungültigem Wertebereich
      CLEAR rn1tc_stop_clock-duration.
    CATCH cx_parameter_invalid_type.    " Parameter mit ungültigem Typ
      CLEAR rn1tc_stop_clock-duration.
  ENDTRY.

  WRITE rn1tc_stop_clock-duration TO rn1tc_stop_clock-duration_ms.

  GET TIME STAMP FIELD lv_timestamp.
  TRY.
      cl_abap_tstmp=>systemtstmp_utc2syst(
        EXPORTING
          utc_tstmp = lv_timestamp    " UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss)
        IMPORTING
*       syst_date = syst_date    " System Datum
          syst_time = rn1tc_stop_clock-stop_time    " System Zeit
      ).
    CATCH cx_parameter_invalid_range.    " Parameter mit ungültigem Wertebereich
      rn1tc_stop_clock-stop_time = sy-uzeit.
  ENDTRY.
ENDFORM.                    " STOP_TASK
*&---------------------------------------------------------------------*
*&      Form  SHOW_MATRIX_USER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM show_matrix_user .
  IF g_uname IS INITIAL.
    g_uname = sy-uname.
  ENDIF.
  cl_ishmed_tc_tools=>show_matrix_fo_user(
    EXPORTING
      i_institution_id = rnpa1-einri    " IS-H: Einrichtung
      i_uname          = g_uname    " Benutzername im Benutzerstamm
  ).
ENDFORM.                    " SHOW_MATRIX_USER
*&---------------------------------------------------------------------*
*&      Form  SHOW_MATRIX
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM show_matrix .
  CALL FUNCTION 'ISHMED_TC_SHOW_MATRIX'
    EXPORTING
      i_institution_id = rnpa1-einri
*     IT_MATRIX        =
    .
ENDFORM.                    " SHOW_MATRIX
*&---------------------------------------------------------------------*
*&      Form  CHANGE_GLOBAL_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM change_global_data .
  IF gr_tc_api IS BOUND.
    gr_tc_api->set_glob_settings_for_test( i_security_level = g_security_level i_decay_time = g_decay_time i_uname = g_uname  ).
  ENDIF.
ENDFORM.                    " CHANGE_SECURITY_LEVEL
*&---------------------------------------------------------------------*
*&      Form  CHECK_ONE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM check_one .
  DATA l_tc_exist TYPE ish_true_false.
  DATA ls_message TYPE bapiret2.


  IF gr_tc_api IS BOUND.
    TRY.
        IF g_use_log = on.
          gr_tc_api->check(
            EXPORTING
               i_patient_id  = rnpa1-patnr    " IS-H: Patientennummer
               i_case_id     = rnpa1-falnr    " IS-H: Fallnummer
               i_dialog_mode = cl_ishmed_tc_api=>off    " Check läuft im Dilaog => temp. BA
               is_log_info   = rn1tc_log_info    " Informationen zum Loggen von Zugriffen über temp. Beh. Auftr
             IMPORTING
               e_tc_exist = l_tc_exist
               es_message = ls_message
             ).
        ELSE.
          gr_tc_api->check(
           EXPORTING
              i_patient_id  = rnpa1-patnr    " IS-H: Patientennummer
              i_case_id     = rnpa1-falnr    " IS-H: Fallnummer
              i_dialog_mode = cl_ishmed_tc_api=>off    " Check läuft im Dilaog => temp. BA
            IMPORTING
              e_tc_exist = l_tc_exist
              es_message = ls_message
            ).

        ENDIF.
      CATCH cx_ishmed_tc.    " Behandlungsauftrag
        g_answer_text = 'Beim Check ist die Ausnahme CX_ISHMED_TC aufgetreten'(305).
    ENDTRY.
  ENDIF.

  IF l_tc_exist EQ if_ish_constant_definition=>true.
    g_answer_text = 'Ein Behandlungsauftrag liegt vor'(001).
  ELSE.
    g_answer_text = ls_message-message.
  ENDIF.

ENDFORM.                    " CHECK_ONE
*&---------------------------------------------------------------------*
*&      Form  DELETE_DB_BUFFER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM delete_db_buffer .
  DELETE FROM n1tc_buffer WHERE uname = sy-uname.       "#EC CI_NOFIRST.
  DELETE FROM n1tc_buffer_pap WHERE uname = sy-uname.   "#EC CI_NOFIRST.
  DELETE FROM n1tc_matrix_buf WHERE ubname = sy-uname.  "#EC CI_NOFIRST.
*MED-68399 BEGIN
  DELETE FROM n1tc_matrix_b_in WHERE ubname = sy-uname.  "#EC CI_NOFIRST.
*MED-68399 END

*MED-70070 BEGIN
  DELETE FROM n1tc_matrix_b_h. "#EC CI_NOWHERE
*MED-70070 END

  COMMIT WORK.
  gr_tc_api->reinit_for_test( ).
  MESSAGE s018(n1tc).
*   Puffer wurden gelöscht
ENDFORM.                    " DELETE_DB_BUFFER
*&---------------------------------------------------------------------*
*&      Form  CHECK_TOW
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM check_two .
  DATA l_tc_exist TYPE ish_true_false.
  DATA ls_message TYPE bapiret2.

  IF gr_tc_api IS BOUND.
    TRY.
        IF g_use_log = on.
          gr_tc_api->check(
            EXPORTING
               i_patient_id  = rnpa1-patnr    " IS-H: Patientennummer
               i_case_id     = rnpa1-falnr    " IS-H: Fallnummer
               i_dialog_mode = cl_ishmed_tc_api=>on    " Check läuft im Dilaog => temp. BA
               is_log_info   = rn1tc_log_info    " Informationen zum Loggen von Zugriffen über temp. Beh. Auftr
            IMPORTING
               e_tc_exist = l_tc_exist
               es_message = ls_message
              ).
        ELSE.
          gr_tc_api->check(
            EXPORTING
               i_patient_id  = rnpa1-patnr    " IS-H: Patientennummer
               i_case_id     = rnpa1-falnr    " IS-H: Fallnummer
               i_dialog_mode = cl_ishmed_tc_api=>on    " Check läuft im Dilaog => temp. BA
             IMPORTING
               e_tc_exist = l_tc_exist
               es_message = ls_message
             ).
        ENDIF.
      CATCH cx_ishmed_tc.    " Behandlungsauftrag
        g_answer_text = 'Beim Check ist die Ausnahme CX_ISHMED_TC aufgetreten'(305).
    ENDTRY.
  ENDIF.

  IF l_tc_exist EQ if_ish_constant_definition=>true.
    g_answer_text = 'Ein Behandlungsauftrag liegt vor'(001).
  ELSE.
    g_answer_text = ls_message-message.
  ENDIF.
ENDFORM.                    " CHECK_TOW
*&---------------------------------------------------------------------*
*&      Form  DELEGATION
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM delegation .
  DATA lx_ishmed_tc TYPE REF TO cx_ishmed_tc.
  DATA lr_error           TYPE REF TO cl_ishmed_errorhandling.
**********************************************************************

  TRY.
      gr_tc_api->request_delegation(
        EXPORTING
          i_patient_id = rnpa1-patnr   " IS-H: Patientennummer
          i_case_id    = rnpa1-falnr    " IS-H: Fallnummer
          i_uname      = g_uname    " Benutzername im Benutzerstamm
      ).
    CATCH cx_ishmed_tc INTO lx_ishmed_tc.
      lx_ishmed_tc->get_errorhandler( IMPORTING er_errorhandler = lr_error ).
      IF lr_error IS BOUND.
        lr_error->display_messages(
         EXPORTING
             i_send_if_one          = 'X'    " Kein Popup, wenn nur eine Msg vorhanden
             i_control              = 'X'
        ).
      ENDIF.
  ENDTRY.
ENDFORM.                    " DELEGATION
