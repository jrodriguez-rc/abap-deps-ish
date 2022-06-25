*----------------------------------------------------------------------*
***INCLUDE LN1TC_TESTI02 .
*&---------------------------------------------------------------------*
*&      Module  TC_TEST_ON_EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE tc_test_on_exit INPUT.
*      LEAVE TO SCREEN search_pat_screen.
  CLEAR g_init.

  SET SCREEN 0.
  LEAVE TO SCREEN 0.
ENDMODULE.                 " TC_TEST_ON_EXIT  INPUT
*&---------------------------------------------------------------------*
*&      Module  TC_TEST_USER_COMMAND  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE tc_test_user_command INPUT.
  CLEAR g_answer_text.
  CASE ok_code.
    WHEN 'TC_UMATRIX'.
      PERFORM show_matrix_user.
    WHEN 'TC_CHECK_ONE'.
      PERFORM start_task USING 'Prüfung Eins durchführen'(300).
      PERFORM check_one.
      PERFORM stop_task.
    WHEN 'TC_CHECK_TWO'.
      PERFORM start_task USING 'Prüfung Zwei durchführen'(307).
      PERFORM check_two.
      PERFORM stop_task.
    WHEN 'TC_DELEGATE'.
      PERFORM delegation.
    WHEN 'TC_MATRIX'.
      PERFORM show_matrix.
    WHEN 'SL_CHANGE' OR 'SET_GDATA'.
      PERFORM start_task USING 'System Daten ändern (ggf. Matix aufbaun)'(301).
      PERFORM change_global_data.
      PERFORM stop_task.
    WHEN 'TC_DEL_BUF'.
      PERFORM start_task USING 'Buffer Daten aus DB löschen'(306).
      PERFORM delete_db_buffer.
      PERFORM stop_task.
  ENDCASE.
ENDMODULE.                 " TC_TEST_USER_COMMAND  INPUT
