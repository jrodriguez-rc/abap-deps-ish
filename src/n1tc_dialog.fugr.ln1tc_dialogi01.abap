*----------------------------------------------------------------------*
***INCLUDE LN1TC_DIALOGI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  REQUEST_SCREEN_EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE request_screen_exit INPUT.
  PERFORM free_content.
  SET SCREEN 0.
  LEAVE SCREEN.
ENDMODULE.                 " REQUEST_SCREEN_EXIT  INPUT
*&---------------------------------------------------------------------*
*&      Module  REQUEST_SCREEN_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE request_screen_command INPUT.
  CASE g_state_request.
    WHEN 'OK'.
      CASE ok_code.
        WHEN 'REQ_OKAY'.
          Perform set_admin_Data.
          PERFORM free_content.
          SET SCREEN 0.
          LEAVE SCREEN.
        WHEN 'REQ_EMER'.
          Perform set_admin_Data.
          perform set_emergency_data.
          PERFORM free_content.
          SET SCREEN 0.
          LEAVE SCREEN.
* MED-67191 Begin
        WHEN 'CAT_CHA'.
          Perform set_reason_edit.
* MED-67191 Begin
        WHEN OTHERS.
          CLEAR ok_code.
      ENDCASE.
    when 'NO_REASON'.
      MESSAGE s701(n1tc).
*   Begründung muss angegeben werden
      g_cursor_field = 'RN1TC_REQUEST_DLG-REASON1'.
      g_cursor_intensified = true.
      SET SCREEN request_screen.
    when 'NO_USER'.
      MESSAGE s702(n1tc).
*   Benutzer muss angegeben werden
      g_cursor_field = 'RN1TC_REQUEST_DLG-UNAME'.
      g_cursor_intensified = true.
      SET SCREEN request_screen.
    when 'WRONG_USER'.
      MESSAGE s004(n1tc) WITH rn1tc_request_dlg-uname.
*   Benutzer muss angegeben werden
      g_cursor_field = 'RN1TC_REQUEST_DLG-UNAME'.
      g_cursor_intensified = true.
      SET SCREEN request_screen.
    when 'WRONG_BEZ'.
      MESSAGE s703(n1tc).
*   Benutzer muss angegeben werden
      g_cursor_field = 'RN1TC_REQUEST_DLG-RESP_TYPE'.
      g_cursor_intensified = true.
      SET SCREEN request_screen.
    when 'NO_BEZ'.
      MESSAGE s704(n1tc).
*   Benutzer muss angegeben werden
      g_cursor_field = 'RN1TC_REQUEST_DLG-RESP_TYPE'.
      g_cursor_intensified = true.
      SET SCREEN request_screen.
    WHEN OTHERS.
      CLEAR ok_code.
  ENDCASE.

ENDMODULE.                 " REQUEST_SCREEN_COMMAND  INPUT
*&---------------------------------------------------------------------*
*&      Module  REQUEST_SCREEN_CHECK_DATA  INPUT
*&---------------------------------------------------------------------*
*  check if date entrance is ok
*----------------------------------------------------------------------*
MODULE request_screen_check_data INPUT.
  PERFORM request_screen_check_data.
ENDMODULE.                 " REQUEST_SCREEN_CHECK_DATA  INPUT
