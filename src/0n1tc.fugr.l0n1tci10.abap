*----------------------------------------------------------------------*
***INCLUDE L0N1TCI10 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  CHECK_INSTITUTION_ID_100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_institution_id_100 INPUT.

  IF v_tn1tc_glob_set-institution_id   IS INITIAL      AND
     ( v_tn1tc_glob_set-security_level IS NOT INITIAL  OR
       v_tn1tc_glob_set-security_level GE 0 ).
    SET CURSOR FIELD 'V_TN1TC_GLOB_SET-INSTITUTION_ID'
               LINE  <vim_tctrl>-current_line.

*   Eingabe in Feld Einrichtung erforderlich
    MESSAGE e350(n0).
  ENDIF.

ENDMODULE.                 " CHECK_INSTITUTION_ID_100  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_EINRI_100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_security_level_100 INPUT.

  IF v_tn1tc_glob_set-security_level   IS INITIAL      AND
     ( v_tn1tc_glob_set-institution_id IS NOT INITIAL  OR
       v_tn1tc_glob_set-security_level GE 0 ).
    SET CURSOR FIELD 'V_TN1TC_GLOB_SET-SECURITY_LEVEL'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine Sicherheitsstufe
    MESSAGE e152(n1tc).
  ENDIF.

ENDMODULE.                 " CHECK_EINRI_100  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_OU_RESP_200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_ou_resp_200 INPUT.

  IF v_tn1tc_ou_resp-ou_resp      IS INITIAL.
    SET CURSOR FIELD 'V_TN1TC_OU_RESP-OU_RESP'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine OE-Zuständigkeit
    MESSAGE e151(n1tc).
  ENDIF.

  IF v_tn1tc_ou_resp-ou_resp_text IS INITIAL      AND
     v_tn1tc_ou_resp-ou_resp      IS NOT INITIAL.
    SET CURSOR FIELD 'V_TN1TC_OU_RESP-OU_RESP_TEXT'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie einen Bezeichner zur OE-Zuständigkeit
    MESSAGE e155(n1tc).
  ENDIF.

ENDMODULE.                 " CHECK_OU_RESP_200  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_RESP_TYPE_200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_resp_type_200 INPUT.

  IF v_tn1tc_ou_resp-resp_type    IS INITIAL      AND
     v_tn1tc_ou_resp-ou_resp   IS NOT INITIAL.
    SET CURSOR FIELD 'V_TN1TC_OU_RESP-RESP_TYPE'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine Bezugsebene zur OE-Zuständigkeit
    MESSAGE e153(n1tc).
  ENDIF.

ENDMODULE.                 " CHECK_RESP_TYPE_200  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_OU_RESP_300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_ou_resp_300 INPUT.

  IF v_tn1tc_ou_rp_ou-ou_resp IS INITIAL.
    SET CURSOR FIELD 'V_TN1TC_OU_RP_OU-OU_RESP'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine OE-Zuständigkeit
    MESSAGE e151(n1tc).
*  ELSE.
*    SELECT COUNT(*) FROM tn1tc_ou_resp
*       WHERE ou_resp = v_tn1tc_ou_rp_ou-ou_resp.
*
*    IF sy-dbcnt = 0.
*      SET CURSOR FIELD 'V_TN1TC_OU_RP_OU-OU_RESP'
*                 LINE  <vim_tctrl>-current_line.
**     Die OE-Zuständigkeit existiert nicht
*      MESSAGE e156(n1tc) WITH v_tn1tc_ou_rp_ou-ou_resp.
*    ENDIF.
  ENDIF.

ENDMODULE.                 " CHECK_OU_RESP_300  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_OU_ID_300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_ou_id_300 INPUT.

  IF v_tn1tc_ou_rp_ou-deptou IS INITIAL.
*    SET CURSOR FIELD 'V_TN1TC_OU_RP_OU-DEPTOU'
*               LINE  <vim_tctrl>-current_line.
**   Bitte erfassen Sie eine OE-Zuständigkeit
*    MESSAGE e768(n2).
    IF v_tn1tc_ou_rp_ou-treaou IS INITIAL.
      SET CURSOR FIELD 'V_TN1TC_OU_RP_OU-DEPTOU'
                 LINE  <vim_tctrl>-current_line.
*     Erfassen Sie mindestens eine fachliche oder eine pflegerische OE
      MESSAGE e157(n1tc).
    ENDIF.
  ELSE.
    IF v_tn1tc_ou_rp_ou-deptou NE '*'.
      PERFORM check_ou_id_300 USING v_tn1tc_ou_rp_ou-institution_id
                                    v_tn1tc_ou_rp_ou-deptou
                                    'F'
                           CHANGING g_rc.

      IF g_rc > 0.
        SET CURSOR FIELD 'V_TN1TC_OU_RP_OU-DEPTOU'
                   LINE  <vim_tctrl>-current_line.
        IF g_rc = 1.
*         Organisationseinheit & existiert nicht
          MESSAGE e204(n1) WITH v_tn1tc_ou_rp_ou-deptou.
        ELSE.
          IF g_rc = 2.
*           Org.einheit & ist nicht für fachliche Zuweisung vorgesehen
            MESSAGE e294(n2) WITH v_tn1tc_ou_rp_ou-deptou.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  IF v_tn1tc_ou_rp_ou-treaou IS NOT INITIAL AND
     v_tn1tc_ou_rp_ou-treaou NE '*'.

    PERFORM check_ou_id_300 USING  v_tn1tc_ou_rp_ou-institution_id
                                   v_tn1tc_ou_rp_ou-treaou
                                  'P'
                         CHANGING g_rc.

    IF g_rc > 0.
      SET CURSOR FIELD 'V_TN1TC_OU_RP_OU-TREAOU'
                 LINE  <vim_tctrl>-current_line.

      IF g_rc = 1.
*         Organisationseinheit & existiert nicht
        MESSAGE e204(n1) WITH v_tn1tc_ou_rp_ou-treaou.
      ELSE.
        IF g_rc = 2.
*           Org.einheit ist nicht für pflegerische Zuweisung vorgesehen
          MESSAGE e295(n2) WITH v_tn1tc_ou_rp_ou-treaou.
        ENDIF.
      ENDIF.
    ELSE.
      IF v_tn1tc_ou_rp_ou-deptou IS NOT INITIAL AND
         v_tn1tc_ou_rp_ou-deptou NE '*'.

        PERFORM check_org_hierarchy_300
                USING    v_tn1tc_ou_rp_ou-institution_id
                         v_tn1tc_ou_rp_ou-deptou
                         v_tn1tc_ou_rp_ou-treaou
                CHANGING g_rc.

        IF g_rc > 0.
          SET CURSOR FIELD 'V_TN1TC_OU_RP_OU-TREAOU'
                     LINE  <vim_tctrl>-current_line.
*         Die OE &1 ist der fachlichen OE &2 nicht untergeordnet
          MESSAGE e158(n1tc) WITH v_tn1tc_ou_rp_ou-treaou
                                  v_tn1tc_ou_rp_ou-deptou.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDIF.

ENDMODULE.                 " CHECK_OU_ID_300  INPUT
*&---------------------------------------------------------------------*
*&      Module  SHOW_ORGID_DEPT_300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE show_orgid_dept_300 INPUT.

  PERFORM show_orgid_dept_300 USING v_tn1tc_ou_rp_ou-institution_id
                           CHANGING v_tn1tc_ou_rp_ou-deptou.

ENDMODULE.                 " SHOW_ORGID_300  INPUT
*&---------------------------------------------------------------------*
*&      Module  SHOW_ORGID_TREA_300  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE show_orgid_trea_300 INPUT.

  PERFORM show_orgid_trea_300 USING v_tn1tc_ou_rp_ou-institution_id
                           CHANGING v_tn1tc_ou_rp_ou-treaou.

ENDMODULE.                 " SHOW_ORGID_300  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_OU_RESP_400  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_ou_resp_400 INPUT.

  if v_tn1tc_resp_rol-ou_resp is initial.
    set cursor field 'V_TN1TC_RESP_ROL-OU_RESP'
               line  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine OE-Zuständigkeit
    message e151(n1tc).
  else.
    if v_tn1tc_resp_rol-ou_resp ne '*'.
      select count(*) from tn1tc_ou_resp
         where ou_resp = v_tn1tc_resp_rol-ou_resp.

      if sy-dbcnt = 0.
        set cursor field 'V_TN1TC_RESP_ROL-OU_RESP'
                   line  <vim_tctrl>-current_line.
*       Die OE-Zuständigkeit existiert nicht
        message e156(n1tc) with v_tn1tc_resp_rol-ou_resp.
      endif.
    endif.
  endif.

ENDMODULE.                 " CHECK_OU_RESP_400  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_VALID_PERIOD_400  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_valid_period_400 INPUT.

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_resp_rol.

  IF v_tn1tc_resp_rol-begdt > v_tn1tc_resp_rol-enddt.
    SET CURSOR FIELD 'V_TN1TC_RESP_ROL-ENDDT'
               LINE  <vim_tctrl>-current_line.
*   Bitte ein Ende-Datum angeben, das nach dem Beginn-Datum liegt
    MESSAGE e046(sv).
  ENDIF.

  LOOP AT total.
    ASSIGN <vim_total_struc> TO <fs>.

*   don't check against the modified entry
    IF <fs>-agr_name = v_tn1tc_resp_rol-agr_name AND
       <fs>-ou_resp  = v_tn1tc_resp_rol-ou_resp  AND
       <fs>-begdt    = v_tn1tc_resp_rol-begdt.
      CONTINUE.
    ENDIF.

    IF <fs>-agr_name NE v_tn1tc_resp_rol-agr_name OR
       <fs>-ou_resp  NE v_tn1tc_resp_rol-ou_resp.
      CONTINUE.
    ENDIF.

    IF ( v_tn1tc_resp_rol-begdt GE <fs>-begdt  AND
         v_tn1tc_resp_rol-begdt LE <fs>-enddt ) OR
       ( v_tn1tc_resp_rol-enddt GE <fs>-begdt  AND
         v_tn1tc_resp_rol-enddt LE <fs>-enddt ) OR
       ( v_tn1tc_resp_rol-begdt LE <fs>-begdt  AND
         v_tn1tc_resp_rol-enddt GE <fs>-enddt ).

*     Der Gültigkeitszeitraum überlappt sich mit anderen Zeiträumen
      MESSAGE e154(n1tc)
         WITH v_tn1tc_resp_rol-ou_resp v_tn1tc_resp_rol-agr_name.
    ENDIF.
  ENDLOOP.

ENDMODULE.                 " CHECK_VALID_PERIOD_400  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_AGR_NAME_400  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_agr_name_400 INPUT.

  IF v_tn1tc_resp_rol-agr_name IS INITIAL.
    SET CURSOR FIELD 'V_TN1TC_RESP_ROL-AGR_NAME'
               LINE  <vim_tctrl>-current_line.
*   Bitte geben Sie eine Rolle an
    MESSAGE e222(s#).
*  ELSE.
*    SELECT COUNT(*) FROM agr_define
*       WHERE agr_name = v_tn1tc_resp_rol-agr_name.
*
*    IF sy-dbcnt = 0.
*      SET CURSOR FIELD 'V_TN1TC_RESP_ROL-AGR_NAME'
*                 LINE  <vim_tctrl>-current_line.
**     Die Rolle existiert nicht.
*      MESSAGE e410(s#) WITH v_tn1tc_resp_rol-agr_name.
*    ENDIF.
  ENDIF.

ENDMODULE.                 " CHECK_AGR_NAME_400  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_OU_RESP_500  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_ou_resp_500 INPUT.

  IF v_tn1tc_times_in-ou_resp IS INITIAL.
    SET CURSOR FIELD 'V_TN1TC_TIMES_IN-OU_RESP'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine OE-Zuständigkeit
    MESSAGE e151(n1tc).
  ELSE.
    IF v_tn1tc_times_in-ou_resp NE '*'.
      SELECT COUNT(*) FROM tn1tc_ou_resp
         WHERE ou_resp = v_tn1tc_times_in-ou_resp.

      IF sy-dbcnt = 0.
        SET CURSOR FIELD 'V_TN1TC_TIMES_IN-OU_RESP'
                   LINE  <vim_tctrl>-current_line.
*       Die OE-Zuständigkeit existiert nicht
        MESSAGE e156(n1tc) WITH v_tn1tc_times_in-ou_resp.
      ENDIF.
    ENDIF.
  ENDIF.

ENDMODULE.                 " CHECK_OU_RESP_500  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_OU_RESP_600  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_ou_resp_600 INPUT.

  IF v_tn1tc_times_ou-ou_resp IS INITIAL.
    SET CURSOR FIELD 'V_TN1TC_TIMES_OU-OU_RESP'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine OE-Zuständigkeit
    MESSAGE e151(n1tc).
  ELSE.
    SELECT COUNT(*) FROM tn1tc_ou_resp
       WHERE ou_resp = v_tn1tc_times_ou-ou_resp.

    IF sy-dbcnt = 0.
      SET CURSOR FIELD 'V_TN1TC_TIMES_OU-OU_RESP'
                 LINE  <vim_tctrl>-current_line.
*       Die OE-Zuständigkeit existiert nicht
      MESSAGE e156(n1tc) WITH v_tn1tc_times_ou-ou_resp.
    ENDIF.
  ENDIF.

ENDMODULE.                 " CHECK_OU_RESP_600  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_OU_ID_600  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_ou_id_600 INPUT.

  LOOP AT gt_double_asterisk_ou_resp INTO gs_double_asterisk_ou_resp
          WHERE ou_resp = v_tn1tc_times_ou-ou_resp.
  ENDLOOP.

  IF sy-subrc = 0.
*   double-asterisk in TN1TC_OU_RESP_OU
    PERFORM check_ou_id_asterisks_600.
    RETURN.
  ENDIF.

  IF v_tn1tc_times_ou-deptou IS INITIAL AND
     v_tn1tc_times_ou-treaou IS INITIAL.
    SET CURSOR FIELD 'V_TN1TC_TIMES_OU-DEPTOU'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine gültige OE-Konstellation
    MESSAGE e159(n1tc).
  ELSE.
*   check ou_combination
    LOOP AT gt_times_ou_f4 into gs_times_ou_f4
      WHERE ou_resp = v_tn1tc_times_ou-ou_resp  AND
            deptou  = v_tn1tc_times_ou-deptou   AND
            treaou  = v_tn1tc_times_ou-treaou.
    ENDLOOP.

    IF sy-subrc > 0.
      SET CURSOR FIELD 'V_TN1TC_TIMES_OU-DEPTOU'
                 LINE  <vim_tctrl>-current_line.
*     Bitte erfassen Sie eine gültige OE-Konstellation
      MESSAGE e159(n1tc).
    ENDIF.
  ENDIF.

ENDMODULE.                 " CHECK_OU_ID_600  INPUT
*&---------------------------------------------------------------------*
*&      Module  SHOW_ORGID_DEPT_600  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE show_orgid_dept_600 INPUT.

  PERFORM show_orgid_dept_600 USING v_tn1tc_times_ou-institution_id
                           CHANGING v_tn1tc_times_ou-deptou.

ENDMODULE.                 " SHOW_ORGID_DEPT_600 INPUT
*&---------------------------------------------------------------------*
*&      Module  SHOW_ORGID_TREA_600  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE show_orgid_trea_600 INPUT.

  PERFORM show_orgid_trea_600 USING v_tn1tc_times_ou-institution_id
                           CHANGING v_tn1tc_times_ou-treaou.

ENDMODULE.                 " SHOW_ORGID_TREA_600  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_CATEGORY_700  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
* MED-67191 Begin
MODULE check_category_700 INPUT.
  IF v_tn1tc_category-category IS INITIAL.
    SET CURSOR FIELD 'V_TN1TC_CATEGORY-CATEGORY'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine gültige OE-Konstellation
    MESSAGE e160(n1tc).
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CHECK_SPRAS_700  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_spras_700 INPUT.
  IF v_tn1tc_category-spras IS INITIAL.
    SET CURSOR FIELD 'V_TN1TC_CATEGORY-SPRAS'
               LINE  <vim_tctrl>-current_line.
*   Bitte erfassen Sie eine gültige OE-Konstellation
    MESSAGE e161(n1tc).
  ENDIF.
ENDMODULE.
* MED-67191 End
