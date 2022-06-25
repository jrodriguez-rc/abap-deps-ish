FUNCTION ishmed_tc_delegation_dlg.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'INS'
*"  CHANGING
*"     REFERENCE(CS_REQUEST) TYPE  RN1TC_REQUEST_DB
*"  RAISING
*"      CX_ISHMED_TC_DELEGATION_CANCEL
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
  g_vcode = i_vcode.
  g_delegation = on.
  MOVE-CORRESPONDING cs_request TO rn1tc_request_dlg.
  g_reason1 = cs_request-reason1.
  IF g_vcode = if_ish_constant_definition=>co_vcode_insert.
    PERFORM set_admin_data.
  ENDIF.

  PERFORM init_patname.

*  if g_popup = on.
    CALL SCREEN request_screen STARTING AT 3 3 ENDING AT 120 13.
*  else.
*    CALL SCREEN request_screen.
*  endif.
  IF ok_code = 'REQ_OKAY' OR ok_code = 'REQ_EMER'.
    MOVE-CORRESPONDING rn1tc_request_dlg TO cs_request.
    cs_request-reason1 = g_reason1.
    cs_request-req_type = co_delegation.
  ELSE.
    IF g_vcode NE if_ish_constant_definition=>co_vcode_display.
      IF g_check_tc = on.
        CALL FUNCTION 'ISH_TC_SWITCH_OFF_UNDO'.
      ENDIF.
      RAISE EXCEPTION TYPE cx_ishmed_tc_delegation_cancel.
    ENDIF.
  ENDIF.
  IF g_check_tc = on.
    CALL FUNCTION 'ISH_TC_SWITCH_OFF_UNDO'.
  ENDIF.


ENDFUNCTION.
