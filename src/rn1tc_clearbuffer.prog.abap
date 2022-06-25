*&---------------------------------------------------------------------*
*& Report  RN1TC_CLEARBUFFER
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  rn1tc_clearbuffer.

TABLES n1tc_buffer.

DATA g_count_buffer       TYPE i.
DATA g_count_buffer_pap   TYPE i.
DATA g_count_matrix_buf   TYPE i.
DATA g_check_ok           TYPE ish_on_off.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (31) g_b01 FOR FIELD gt_user.
SELECT-OPTIONS: gt_user FOR n1tc_buffer-uname NO INTERVALS MATCHCODE OBJECT user_comp.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (34) g_b02 FOR FIELD g_all.
PARAMETERS g_all   TYPE ish_on_off DEFAULT ' ' AS CHECKBOX USER-COMMAND all_changed.
SELECTION-SCREEN END OF LINE.

INITIALIZATION.
  PERFORM init.

AT SELECTION-SCREEN OUTPUT.
  PERFORM modify_screen.

AT SELECTION-SCREEN.
  PERFORM modify_screen.

START-OF-SELECTION.
* check user input
  IF gt_user IS INITIAL AND g_all IS INITIAL.
    MESSAGE s016(n1tc).
    EXIT.
  ENDIF.
  g_check_ok = 'X'.
  PERFORM check_user CHANGING g_check_ok.
  IF g_check_ok NE 'X'.
    EXIT.
  ENDIF.

  PERFORM run.

*&---------------------------------------------------------------------*
*&      Form  init
*&---------------------------------------------------------------------*
FORM init.
* init text of selection screen
  MESSAGE s014(n1tc) INTO g_b01.
  MESSAGE s015(n1tc) INTO g_b02.
ENDFORM.                    "init

*&---------------------------------------------------------------------*
*&      Form  modify_screen
*&---------------------------------------------------------------------*
FORM modify_screen.
* modify screen
  IF g_all IS NOT INITIAL.
    LOOP AT SCREEN.
      IF screen-name EQ 'GT_USER-LOW'.
        screen-input = space.
        screen-value_help = space.
        screen-output = space.
        MODIFY SCREEN.
      ELSEIF screen-name = '%_GT_USER_%_APP_%-VALU_PUSH'.
        screen-invisible = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ELSE.
    LOOP AT SCREEN.
      IF screen-name EQ 'GT_USER-LOW'.
        screen-input = 1.
        screen-value_help = 1.
        screen-output = 1.
        MODIFY SCREEN.
      ELSEIF screen-name = '%_GT_USER_%_APP_%-VALU_PUSH'.
        screen-invisible = space.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

ENDFORM.                    "modify_screen

*&---------------------------------------------------------------------*
*&      Form  run
*&---------------------------------------------------------------------*
FORM run.

  DATA lt_n1tc_buffer       TYPE STANDARD TABLE OF n1tc_buffer.
  DATA lt_n1tc_buffer_pap   TYPE STANDARD TABLE OF n1tc_buffer_pap.
  DATA lt_n1tc_matrix_buf   TYPE STANDARD TABLE OF n1tc_matrix_buf.
*MED-68399 BEGIN
  DATA lt_n1tc_matrix_b_in   TYPE STANDARD TABLE OF n1tc_matrix_b_in.
*MED-68399 END

  IF g_all = abap_true AND gt_user IS INITIAL.
    SELECT * FROM n1tc_buffer INTO TABLE lt_n1tc_buffer.          "#EC CI_NOWHERE.
    SELECT * FROM n1tc_buffer_pap INTO TABLE lt_n1tc_buffer_pap.  "#EC CI_NOWHERE.
    SELECT * FROM n1tc_matrix_buf INTO TABLE lt_n1tc_matrix_buf.  "#EC CI_NOWHERE.
*MED-68399 BEGIN
    SELECT * FROM n1tc_matrix_b_in INTO TABLE lt_n1tc_matrix_b_in.  "#EC CI_NOWHERE.
*MED-68399 END
  ELSEIF gt_user IS NOT INITIAL.
    SELECT * FROM n1tc_buffer INTO TABLE lt_n1tc_buffer
      WHERE uname IN gt_user.                                     "#EC CI_NOFIRST.
    SELECT * FROM n1tc_buffer_pap INTO TABLE lt_n1tc_buffer_pap
      WHERE uname IN gt_user.                                     "#EC CI_NOFIRST.
    SELECT * FROM n1tc_matrix_buf INTO TABLE lt_n1tc_matrix_buf
      WHERE ubname IN gt_user.                                    "#EC CI_NOFIRST.
*MED-68399 BEGIN
    SELECT * FROM n1tc_matrix_b_in INTO TABLE lt_n1tc_matrix_b_in
      WHERE ubname IN gt_user.                                    "#EC CI_NOFIRST.
*MED-68399 END
  ENDIF.

  DELETE n1tc_buffer FROM TABLE lt_n1tc_buffer.
  g_count_buffer = sy-dbcnt.

  DELETE n1tc_buffer_pap FROM TABLE lt_n1tc_buffer_pap.
  g_count_buffer_pap = sy-dbcnt.

  DELETE n1tc_matrix_buf FROM TABLE lt_n1tc_matrix_buf.
*MED-68399 BEGIN
*  g_count_matrix_buf = sy-dbcnt.

  DELETE n1tc_matrix_b_in FROM TABLE lt_n1tc_matrix_b_in.
  g_count_matrix_buf = sy-dbcnt.
*MED-68399 END

*MED-70070 BEGIN
  "Clear user independant OU-responsibility - OU buffer
  DELETE FROM n1tc_matrix_b_h. "#EC CI_NOWHERE
*MED-70070 END
  COMMIT WORK.

  PERFORM write_list.

ENDFORM.                    "run

*&---------------------------------------------------------------------*
*&      Form  write_list
*&---------------------------------------------------------------------*
FORM write_list.

  WRITE: / 'Anzahl der gelöschten Einträge'(001).
  ULINE.
  WRITE: / 'Buffer für Patienten'(002),g_count_buffer.
  WRITE: / 'Buffer für vorläufige Patienten'(003),g_count_buffer_pap.
  WRITE: / 'Buffer für OE-Zuständigkeiten'(004),g_count_matrix_buf.

ENDFORM.                    "write_list
*&---------------------------------------------------------------------*
*&      Form  CHECK_USER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_G_CHECK_OK  text
*----------------------------------------------------------------------*
FORM check_user  CHANGING p_g_check_ok.
  DATA ls_user LIKE LINE OF gt_user.

  LOOP AT gt_user INTO ls_user.
    CALL FUNCTION 'SUSR_USER_CHECK_EXISTENCE'
      EXPORTING
        user_name = ls_user-low
    exceptions
      user_name_not_exists       = 1
        OTHERS               = 2.
    IF sy-subrc <> 0.
      MESSAGE s004(n1tc) WITH ls_user-low.
      CLEAR p_g_check_ok.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " CHECK_USER
