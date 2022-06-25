FUNCTION ishmed_tc_request_dlg.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'INS'
*"     REFERENCE(I_DIALOG_MODE) TYPE  ISH_ON_OFF
*"         DEFAULT CL_ISHMED_TC_API=>ON
*"  CHANGING
*"     REFERENCE(CS_REQUEST) TYPE  RN1TC_REQUEST_DB
*"  RAISING
*"      CX_ISHMED_TC_REQUEST_CANCELED
*"----------------------------------------------------------------------

  CLEAR rn1tc_request_dlg.
  g_check_tc = on.
  g_popup = on.

  CALL FUNCTION 'ISH_TC_SWITCH_OFF_CHECK'
    CHANGING
      c_check_tc = g_check_tc.

  IF g_check_tc = on.
    CALL FUNCTION 'ISH_TC_SWITCH_OFF'.
*    CALL FUNCTION 'ISH_TC_SWITCH_OFF_BY_FUNCTION'
*      EXPORTING
*        i_fcode = 'REPORT'.
  ENDIF.

* MED-70766 Begin by C5004356
  IF cs_request-resp_type EQ if_ishmed_tc_constant_def=>co_resp_type_special.
    g_special_request = true.
    cs_request-resp_type =  if_ishmed_tc_constant_def=>co_resp_type_patient.
  else.
    g_special_request = false.
  ENDIF.
* MED-70766 End by C5004356

  g_delegation = off.
  g_vcode = i_vcode.
  MOVE-CORRESPONDING cs_request TO rn1tc_request_dlg.
* MED-70766 Begin by C5004356
  IF g_special_request = true..
    g_reason1 = text-103.
  else.
    g_reason1 = cs_request-reason1.
  ENDIF.
* MED-70766 End by C5004356
  IF g_vcode = if_ish_constant_definition=>co_vcode_insert.
    PERFORM set_admin_data.
  ENDIF.
  PERFORM init_patname.

* <<< MED-60843 Note 2255594 Bi
* Do not show pop-up if dialog mode is disabled and all required data is available
  IF i_dialog_mode EQ off.
    CLEAR: ok_code.

*   Emergency
    IF cs_request-emergency EQ 'X'.
      FREE lr_ttc_helper.
      CREATE OBJECT lr_ttc_helper
        EXPORTING
          is_data = rn1tc_request_dlg.
      IF lr_ttc_helper IS BOUND AND lr_ttc_helper->check_emergency_possible( ) EQ on.
        ok_code = 'REQ_EMER'.
      ENDIF.
    ENDIF.

*   Normal request with reason
    IF ok_code IS INITIAL AND cs_request-reason1 IS NOT INITIAL.
      ok_code = 'REQ_OKAY'.
    ENDIF.
  ENDIF.
* >>> MED-60843 Note 2255594 Bi

*  IF g_vcode = if_ish_constant_definition=>co_vcode_display.
*    CALL SCREEN request_screen STARTING AT 3 3 ENDING AT  120 14.
*  ELSE.
*  CALL SCREEN request_screen STARTING AT 3 3 ENDING AT  120 14.          " MED-60843 Note 2255594 Bi
*  ENDIF.

*  if cs_request-case_id is INITIAL.
*    cs_request-resp_type = if_ishmed_tc_constant_def=>co_resp_type_patient.
*  endif.

* <<< MED-60843 Note 2255594 Bi
  IF i_dialog_mode EQ on OR ok_code IS INITIAL.
    CLEAR ok_code.
    CALL SCREEN request_screen STARTING AT 3 3 ENDING AT  120 16. "MED-67191
  ENDIF.
* >>> MED-60843 Note 2255594 Bi

  IF ok_code = 'REQ_OKAY' OR ok_code = 'REQ_EMER'.
    MOVE-CORRESPONDING rn1tc_request_dlg TO cs_request.
    cs_request-uname = sy-uname.
    cs_request-reason1 = g_reason1.
    cs_request-req_type = co_request.
  ELSE.
    IF g_vcode NE if_ish_constant_definition=>co_vcode_display.
      IF g_check_tc = on.
        CALL FUNCTION 'ISH_TC_SWITCH_OFF_UNDO'.
      ENDIF.
      RAISE EXCEPTION TYPE cx_ishmed_tc_request_canceled.
    ENDIF.
  ENDIF.
  IF g_check_tc = on.
    CALL FUNCTION 'ISH_TC_SWITCH_OFF_UNDO'.
  ENDIF.
ENDFUNCTION.
