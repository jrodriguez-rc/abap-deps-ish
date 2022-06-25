*----------------------------------------------------------------------*
***INCLUDE L0N1TCO10 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  SET_RESP_TYPE_200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module SET_RESP_TYPE_200 output.

  perform SET_RESP_TYPE_200.

endmodule.                 " SET_RESP_TYPE_200  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  SET_ORGKB_300  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module SET_ORGKB_300 output.

  IF v_tn1tc_ou_rp_ou-deptou NE ' ' AND
     v_tn1tc_ou_rp_ou-deptou NE '*'.
    PERFORM set_orgkb_300  USING  v_tn1tc_ou_rp_ou-institution_id
                                  v_tn1tc_ou_rp_ou-deptou
                         CHANGING v_tn1tc_ou_rp_ou-deptou_kb.
  ELSE.
    CLEAR v_tn1tc_ou_rp_ou-deptou_kb.
  ENDIF.

  IF v_tn1tc_ou_rp_ou-treaou NE ' ' AND
     v_tn1tc_ou_rp_ou-treaou NE '*'.
    PERFORM set_orgkb_300  USING  v_tn1tc_ou_rp_ou-institution_id
                                  v_tn1tc_ou_rp_ou-treaou
                         CHANGING v_tn1tc_ou_rp_ou-treaou_kb.
  ELSE.
    CLEAR v_tn1tc_ou_rp_ou-treaou_kb.
  ENDIF.

endmodule.                 " SET_ORGKB_300  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  EXCL_FUNCTIONS_400  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module EXCL_FUNCTIONS_400 output.

  MOVE 'DELM' TO EXCL_CUA_FUNCT-FUNCTION. COLLECT EXCL_CUA_FUNCT.

endmodule.                 " EXCL_FUNCTIONS_400  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  INIT_600  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_600 OUTPUT.

  IF extract[] IS INITIAL.
    g_first_call = abap_on.
  ELSE.
    g_first_call = abap_off.
  ENDIF.

ENDMODULE.                 " INIT_600  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  SET_ORGKB_600  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_orgkb_600 OUTPUT.

  IF v_tn1tc_times_ou-deptou NE ' ' AND
     v_tn1tc_times_ou-deptou NE '*'.
    PERFORM set_orgkb_300  USING  v_tn1tc_times_ou-institution_id
                                  v_tn1tc_times_ou-deptou
                         CHANGING v_tn1tc_times_ou-deptou_kb.
  ELSE.
    CLEAR v_tn1tc_times_ou-deptou_kb.
  ENDIF.

  IF v_tn1tc_times_ou-treaou NE ' ' AND
     v_tn1tc_times_ou-treaou NE '*'.
    PERFORM set_orgkb_300  USING  v_tn1tc_times_ou-institution_id
                                  v_tn1tc_times_ou-treaou
                         CHANGING v_tn1tc_times_ou-treaou_kb.
  ELSE.
    CLEAR v_tn1tc_times_ou-treaou_kb.
  ENDIF.

ENDMODULE.                 " SET_ORGKB_600  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  CREATE_TAB_F4_OU_OU_600  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE create_tab_f4_ou_ou_600 OUTPUT.

  IF g_first_call = abap_on.
*   execute 'create_tab_f4_ou_ou_600' only at first call of application
    PERFORM create_tab_f4_ou_ou_600.
  ENDIF.

ENDMODULE.                 " CREATE_TAB_F4_OU_OU_600  OUTPUT
