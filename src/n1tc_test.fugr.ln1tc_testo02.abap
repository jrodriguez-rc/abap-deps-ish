*----------------------------------------------------------------------*
***INCLUDE LN1TC_TESTO02 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  TC_TEST_STATUS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module TC_TEST_STATUS output.
  SET PF-STATUS 'TC_TEST'.
  SET TITLEBAR  'TC_TEST'.
endmodule.                 " TC_TEST_STATUS  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  TC_TEST_INIT  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module TC_TEST_INIT output.
  if gr_tc_api is not BOUND.
    g_uname = sy-uname.
    rn1tc_log_info-tcode = sy-tcode.
    rn1tc_log_info-object_key = 'OBJ_TC_TEST_KEY'. "#ETC-NOTEXT
    rn1tc_log_info-object_type = 112233.
    rn1tc_log_info-vcode = 'DIS'.
    perform Start_task using 'Instanz der API laden'(303).
    gr_tc_api = cl_ishmed_tc_api=>load( rnpa1-einri ).
    perform stop_task.

    SELECT single SECURITY_LEVEL DECAY_TIME from tn1tc_glob_set INTO (g_security_level, g_decay_time)
      where INSTITUTION_ID = rnpa1-einri.
    if sy-subrc NE 0.
      clear g_security_level.
      g_decay_time = 0.
    ENDIF.
  endif.
endmodule.                 " TC_TEST_INIT  OUTPUT
