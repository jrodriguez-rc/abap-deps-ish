*----------------------------------------------------------------------*
***INCLUDE L0N1TCF10 .
*----------------------------------------------------------------------*

DATA:   lt_dynpfields   TYPE TABLE OF dynpread,
        ls_dynpfields   TYPE dynpread,

        gt_tn1tc_ou_resp_ou   TYPE TABLE OF tn1tc_ou_resp_ou,
        gt_tn1tc_ou_resp_ou_2 TYPE TABLE OF tn1tc_ou_resp_ou,

        g_first_call    TYPE  xfeld.

TYPES: BEGIN OF tys_double_asterisk_ou_resp.
TYPES: ou_resp  TYPE n1tc_ou_resp,
       END OF tys_double_asterisk_ou_resp.

DATA:   gt_double_asterisk_ou_resp
                          TYPE TABLE OF tys_double_asterisk_ou_resp,
        gs_double_asterisk_ou_resp TYPE tys_double_asterisk_ou_resp,

        g_rc            TYPE sysubrc.

FIELD-SYMBOLS: <fs_tn1tc_ou_resp_ou>   TYPE tn1tc_ou_resp_ou,
               <fs_tn1tc_ou_resp_ou_2> TYPE tn1tc_ou_resp_ou.

TYPES: BEGIN OF tys_times_ou_f4.
TYPES: ou_resp  TYPE n1tc_ou_resp,
       deptou   TYPE n1tc_deptou,
       treaou   TYPE n1tc_treaou,
       END OF tys_times_ou_f4.

DATA:  gt_times_ou_f4 TYPE TABLE OF tys_times_ou_f4,
       gs_times_ou_f4 TYPE tys_times_ou_f4.

FIELD-SYMBOLS: <fs_times_ou_f4> TYPE tys_times_ou_f4.

*&---------------------------------------------------------------------*
*&      Form  Z01_SET_DATA_BEF_SAVE_100
*&---------------------------------------------------------------------*
*       Felder füllen, die nicht auf dem Dynpro erscheinen
*       Die Statements sind nach dem Beispiel in
*       Info zu Erw. TabPflege programmiert
*----------------------------------------------------------------------*
FORM z01_set_data_bef_save_100.                     "glob_set.

  DATA: l_index_extr LIKE sy-tabix.   "Index der Tabelle EXTRACT

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_glob_set.

  LOOP AT total.
    CASE <action>.
      WHEN neuer_eintrag.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-erdat = sy-datum.
        <fs>-erusr = sy-uname.
        CLEAR: <fs>-updat,             "no Update-Infos in copies
               <fs>-upusr.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
      WHEN aendern.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-updat = sy-datum.
        <fs>-upusr = sy-uname.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
    ENDCASE.
  ENDLOOP.
  sy-subrc = 0.

ENDFORM.                             " Z01_SET_DATA_BEF_SAVE_100
*&---------------------------------------------------------------------*
*&      Form  Z01_SET_DATA_BEF_SAVE_200
*&---------------------------------------------------------------------*
*       Zeitpunkt 01:
*       Felder füllen, die nicht auf dem Dynpro erscheinen
*       Die Statements sind nach dem Beispiel in
*       Info zu Erw. TabPflege programmiert
*----------------------------------------------------------------------*
FORM z01_set_data_bef_save_200.

  DATA: l_index_extr LIKE sy-tabix.   "Index der Tabelle EXTRACT

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_ou_resp.

  LOOP AT total.
    CASE <action>.
      WHEN neuer_eintrag.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-erdat = sy-datum.
        <fs>-erusr = sy-uname.
        CLEAR: <fs>-updat,             "no Update-Infos in copies
               <fs>-upusr.
* <<< MED-70766 Note 2741408 Bi
        IF <fs>-resp_type EQ 'S'.
          MESSAGE 'Bezugsebene "Sonderzugriff" ist nicht zulässig'(002) TYPE 'S' DISPLAY LIKE 'E'.
          sy-subrc = 2.
          RETURN. " --- RETURN --->
        ENDIF.
* >>> MED-70766 Note 2741408 Bi

        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
      WHEN aendern.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-updat = sy-datum.
        <fs>-upusr = sy-uname.
* <<< MED-70766 Note 2741408 Bi
        IF <fs>-resp_type EQ 'S'.
          MESSAGE 'Bezugsebene "Sonderzugriff" ist nicht zulässig'(002) TYPE 'S' DISPLAY LIKE 'E'.
          sy-subrc = 2.
          RETURN. " --- RETURN --->
        ENDIF.
* >>> MED-70766 Note 2741408 Bi

        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
    ENDCASE.
  ENDLOOP.
  sy-subrc = 0.

ENDFORM.                              " Z01_SET_DATA_BEFORE_SAVE_200
*&---------------------------------------------------------------------*
*&      Form  Z01_SET_DATA_BEF_SAVE_300
*&---------------------------------------------------------------------*
*       Felder füllen, die nicht auf dem Dynpro erscheinen
*       Die Statements sind nach dem Beispiel in
*       Info zu Erw. TabPflege programmiert
*----------------------------------------------------------------------*
FORM z01_set_data_bef_save_300.

  DATA: l_index_extr LIKE sy-tabix.   "Index der Tabelle EXTRACT

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_ou_rp_ou.

  LOOP AT total.
    CASE <action>.
      WHEN neuer_eintrag.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-erdat = sy-datum.
        <fs>-erusr = sy-uname.
        CLEAR: <fs>-updat,             "no Update-Infos in copies
               <fs>-upusr.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
      WHEN aendern.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-updat = sy-datum.
        <fs>-upusr = sy-uname.
        IF <fs>-delflag = abap_off.
          CLEAR: <fs>-deldat,
                 <fs>-delusr.
        ELSE.
          IF <fs>-delusr IS INITIAL.
            <fs>-deldat = sy-datum.
            <fs>-delusr = sy-uname.
          ENDIF.
        ENDIF.

        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
    ENDCASE.
  ENDLOOP.
  sy-subrc = 0.

ENDFORM.                            " Z01_SET_DATA_BEF_SAVE_300
*&---------------------------------------------------------------------*
*&      Form  Z01_SET_DATA_BEF_SAVE_400
*&---------------------------------------------------------------------*
*       Felder füllen, die nicht auf dem Dynpro erscheinen
*       Die Statements sind nach dem Beispiel in
*       Info zu Erw. TabPflege programmiert
*----------------------------------------------------------------------*
FORM z01_set_data_bef_save_400.

  DATA: l_index_extr LIKE sy-tabix.   "Index der Tabelle EXTRACT

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_resp_rol.

  LOOP AT total.
    CASE <action>.
      WHEN neuer_eintrag.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-erdat = sy-datum.
        <fs>-erusr = sy-uname.
        CLEAR: <fs>-updat,             "no Update-Infos in copies
               <fs>-upusr.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
      WHEN aendern.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-updat = sy-datum.
        <fs>-upusr = sy-uname.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
    ENDCASE.
  ENDLOOP.
  sy-subrc = 0.

ENDFORM.                             " Z01_SET_DATA_BEF_SAVE_400
*&---------------------------------------------------------------------*
*&      Form  Z01_SET_DATA_BEF_SAVE_500
*&---------------------------------------------------------------------*
*       Felder füllen, die nicht auf dem Dynpro erscheinen
*       Die Statements sind nach dem Beispiel in
*       Info zu Erw. TabPflege programmiert
*----------------------------------------------------------------------*
FORM z01_set_data_bef_save_500.

  DATA: l_index_extr LIKE sy-tabix.   "Index der Tabelle EXTRACT

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_times_in.

  LOOP AT total.
    CASE <action>.
      WHEN neuer_eintrag.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-erdat = sy-datum.
        <fs>-erusr = sy-uname.
        CLEAR: <fs>-updat,             "no Update-Infos in copies
               <fs>-upusr.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
      WHEN aendern.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-updat = sy-datum.
        <fs>-upusr = sy-uname.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
    ENDCASE.
  ENDLOOP.
  sy-subrc = 0.

ENDFORM.                             " Z01_SET_DATA_BEF_SAVE_500
*&---------------------------------------------------------------------*
*&      Form  Z01_SET_DATA_BEF_SAVE_600
*&---------------------------------------------------------------------*
*       Felder füllen, die nicht auf dem Dynpro erscheinen
*       Die Statements sind nach dem Beispiel in
*       Info zu Erw. TabPflege programmiert
*----------------------------------------------------------------------*
FORM z01_set_data_bef_save_600.

  DATA: l_index_extr LIKE sy-tabix.   "Index der Tabelle EXTRACT

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_times_ou.

  LOOP AT total.
    CASE <action>.
      WHEN neuer_eintrag.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-erdat = sy-datum.
        <fs>-erusr = sy-uname.
        CLEAR: <fs>-updat,             "no Update-Infos in copies
               <fs>-upusr.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
      WHEN aendern.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-updat = sy-datum.
        <fs>-upusr = sy-uname.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
    ENDCASE.
  ENDLOOP.
  sy-subrc = 0.

ENDFORM.                             " Z01_SET_DATA_BEF_SAVE_600
*&---------------------------------------------------------------------*
*&      Form  Z01_SET_DATA_BEF_SAVE_700
*&---------------------------------------------------------------------*
*       Felder füllen, die nicht auf dem Dynpro erscheinen
*       Die Statements sind nach dem Beispiel in
*       Info zu Erw. TabPflege programmiert
*----------------------------------------------------------------------*
* MED-67191 Begin
FORM z01_set_data_bef_save_700.

   DATA: l_index_extr LIKE sy-tabix.   "Index der Tabelle EXTRACT

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_category.

  LOOP AT total.
    CASE <action>.
      WHEN neuer_eintrag.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-erdat = sy-datum.
        <fs>-erusr = sy-uname.
*        <fs>-spras = sy-langu.
        CLEAR: <fs>-updat,             "no Update-Infos in copies
               <fs>-upusr.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
      WHEN aendern.
        READ TABLE extract WITH KEY total.
        IF sy-subrc EQ 0.
          l_index_extr = sy-tabix.
        ELSE.
          CLEAR l_index_extr.
        ENDIF.
        ASSIGN <vim_total_struc> TO <fs>.
        <fs>-updat = sy-datum.
        <fs>-upusr = sy-uname.
        MODIFY total.
        CHECK l_index_extr GT 0.
        extract = total.
        MODIFY extract INDEX l_index_extr.
    ENDCASE.
  ENDLOOP.
  sy-subrc = 0.

ENDFORM.                             " Z01_SET_DATA_BEF_SAVE_700
* MED-67191 End
*&---------------------------------------------------------------------*
*&      Form  Z05_SET_DEFAULTS_N_ENTRIES_200
*&---------------------------------------------------------------------*
*       Point in time 05:
*       Assignment of defaults to special fields.
*       In conformity with the online manual it is allowed
*       to use directly the viewfiels.
*----------------------------------------------------------------------*
FORM z05_set_defaults_n_entries_200.

  IF v_tn1tc_ou_resp-resp_type IS INITIAL.
    v_tn1tc_ou_resp-resp_type = 'P'.
  ENDIF.

ENDFORM.                    "Z05_SET_DEFAULTS_N_ENTRIES_200
*&---------------------------------------------------------------------*
*&      Form  Z03_CHECK_FUNCTION_DEL_200
*&---------------------------------------------------------------------*
*       Point in time 03:
*       It is not allowed to delete entries, if cross reference to
*       other customizing tables is positive
*----------------------------------------------------------------------*
FORM z03_check_function_del_200.

  DATA: lv_entry_in_other_table_exists TYPE c.

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_ou_resp.

  LOOP AT extract.
    ASSIGN <vim_extract_struc> TO <fs>.
    IF <xmark> NE 'M'.
      CONTINUE.
    ENDIF.

*   cross reference to other customizing tables
    lv_entry_in_other_table_exists = abap_off.
    DO 1 TIMES.
      SELECT COUNT(*) FROM tn1tc_ou_resp_ou
             WHERE ou_resp = <fs>-ou_resp.

      IF sy-dbcnt > 0.
        lv_entry_in_other_table_exists = abap_on.
        EXIT.
      ENDIF.

      SELECT COUNT(*) FROM tn1tc_resp_role
             WHERE ou_resp = <fs>-ou_resp.

      IF sy-dbcnt > 0.
        lv_entry_in_other_table_exists = abap_on.
        EXIT.
      ENDIF.

      SELECT COUNT(*) FROM tn1tc_times_inst
             WHERE ou_resp = <fs>-ou_resp.

      IF sy-dbcnt > 0.
        lv_entry_in_other_table_exists = abap_on.
        EXIT.
      ENDIF.

      SELECT COUNT(*) FROM tn1tc_times_ou
             WHERE ou_resp = <fs>-ou_resp.

      IF sy-dbcnt > 0.
        lv_entry_in_other_table_exists = abap_on.
        EXIT.
      ENDIF.
    ENDDO.

    IF lv_entry_in_other_table_exists = abap_on.
      MOVE uebergehen TO <xmark>.
      READ TABLE total WITH KEY <vim_extract_key> BINARY SEARCH.
      MOVE uebergehen TO <mark>.
      MODIFY total INDEX sy-tabix.
      MODIFY extract.
*     ignored_entries_exist = on.
    ENDIF.
  ENDLOOP.

  sy-subrc = 0.

ENDFORM.                    "Z03_CHECK_FUNCTION_DEL_200
*&---------------------------------------------------------------------*
*&      Form  Z04_CHECK_FUNCTION_DEL_200
*&---------------------------------------------------------------------*
*       Point in time 04:
*       Mark skipped (not deleted) entries again and show message
*----------------------------------------------------------------------*
FORM z04_check_function_del_200.

  DATA: lv_entry_in_other_table_exists TYPE c,
        lv_counter_not_deleted_entries TYPE sytabix.

  FIELD-SYMBOLS: <fs> TYPE v_tn1tc_ou_resp.

  LOOP AT total.
    CHECK <mark> EQ uebergehen.
    <mark> = 'M'.
*   <eigene Aktionen>
    MODIFY total.
  ENDLOOP.

  LOOP AT extract.
    CHECK <xmark> EQ uebergehen.
    <xmark> = 'M'.
*   <eigene Aktionen>
    MODIFY extract.
    ADD 1 TO lv_counter_not_deleted_entries.
  ENDLOOP.

  IF lv_counter_not_deleted_entries > 0.
    MESSAGE s150(n1tc).
  ENDIF.

  sy-subrc = 0.

ENDFORM.                    "Z04_CHECK_FUNCTION_DEL_200
*&---------------------------------------------------------------------*
*&      Form  SET_RESP_TYPE_200
*&---------------------------------------------------------------------*
*       Set defaults for dynpro 200
*----------------------------------------------------------------------*
FORM set_resp_type_200.

  IF v_tn1tc_ou_resp-resp_type IS INITIAL  AND
     v_tn1tc_ou_resp-ou_resp   IS INITIAL.
*    alternative:  status-action eq hinzufuegen.
    v_tn1tc_ou_resp-resp_type = 'P'.
  ENDIF.

ENDFORM.                    " SET_RESP_TYPE_200
*&---------------------------------------------------------------------*
*&      Form  SET_ORGKB_300
*&---------------------------------------------------------------------*
*       Set shortname for OU in dynpro 300
*----------------------------------------------------------------------*
FORM set_orgkb_300 USING p_einri p_orgid
                CHANGING p_orgkb.


  DATA: lt_norg  TYPE ish_t_norg,
        ls_norg  TYPE norg.


  CALL FUNCTION 'ISH_READ_NORG'
    EXPORTING
      einri         = p_einri
      orgid         = p_orgid
    IMPORTING
      norg_e        = ls_norg
    EXCEPTIONS
      missing_orgid = 1
      OTHERS        = 2.

  IF sy-subrc = 0.
    p_orgkb = ls_norg-orgkb.
  ENDIF.

ENDFORM.                  " SET_ORGKB_300
*&---------------------------------------------------------------------*
*&      Form  SHOW_ORGID_DEPT_300
*&---------------------------------------------------------------------*
*       F4-Help for ORGID_DEPT
*----------------------------------------------------------------------*
*      -->P_V_TN1TC_OU_R_OU_INSTITUTION_I  text
*      <--P_V_TN1TC_OU_R_OU_DEPTOU  text
*----------------------------------------------------------------------*
FORM show_orgid_dept_300  USING p_einri
                       CHANGING p_orgid.

  DATA: lv_placed_above_orgfa TYPE orgid,
        lv_placed_above_orgpf TYPE orgid,
        lv_start_orgfa        TYPE orgid,
        lv_start_orgpf        TYPE orgid.


  PERFORM dynpro_value_300 USING 'R' 'V_TN1TC_OU_RP_OU-DEPTOU'.

  CALL FUNCTION 'ISH_GRAPHIC_ORGID_SELECT'
    EXPORTING
      einri              = p_einri
      fazuw              = abap_on
*     pfzuw              = abap_off
*     ambes              = abap_off
      no_bauid           = abap_on
      disp_not_rel       = abap_on
      start_orgfa        = v_tn1tc_ou_rp_ou-deptou
      start_orgpf        = v_tn1tc_ou_rp_ou-treaou
    IMPORTING
      placed_above_orgfa = lv_placed_above_orgfa
      placed_above_orgpf = lv_placed_above_orgpf
      selected_orgid     = p_orgid
    EXCEPTIONS
      bauid_not_in_nbau  = 1
      einri_not_in_tn01  = 2
      no_hierarchy       = 3
      orgid_not_in_norg  = 4
      OTHERS             = 5.

*  PERFORM dynpro_value_300 USING 'W' 'V_TN1TC_OU_RP_OU-DEPTOU'.

  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

ENDFORM.                    " SHOW_ORGID_DEPT_300
*&---------------------------------------------------------------------*
*&      Form  SHOW_ORGID_TREA_300
*&---------------------------------------------------------------------*
*       F4-Help for ORGID_TREA
*----------------------------------------------------------------------*
*      -->P_V_TN1TC_OU_R_OU_INSTITUTION_I  text
*      <--P_V_TN1TC_OU_R_OU_DEPTOU  text
*----------------------------------------------------------------------*
FORM show_orgid_trea_300 USING    p_einri
                         CHANGING p_orgid.

  DATA: lv_placed_above_orgfa TYPE orgid,
        lv_placed_above_orgpf TYPE orgid,
        lv_start_orgfa        TYPE orgid,
        lv_start_orgpf        TYPE orgid.


  PERFORM dynpro_value_300 USING 'R' 'V_TN1TC_OU_RP_OU-TREAOU'.

  CALL FUNCTION 'ISH_GRAPHIC_ORGID_SELECT'
    EXPORTING
      einri              = p_einri
*     fazuw              = abap_off
      pfzuw              = abap_on
      ambes              = abap_on
      no_bauid           = abap_on
      disp_not_rel       = abap_on
      start_orgfa        = v_tn1tc_ou_rp_ou-deptou
*     start_orgpf        = V_tn1tc_ou_rp_ou-treaou
    IMPORTING
      placed_above_orgfa = lv_placed_above_orgfa
      placed_above_orgpf = lv_placed_above_orgpf
      selected_orgid     = p_orgid
    EXCEPTIONS
      bauid_not_in_nbau  = 1
      einri_not_in_tn01  = 2
      no_hierarchy       = 3
      orgid_not_in_norg  = 4
      OTHERS             = 5.

*  IF sy-subrc <> 0.
*    EXIT.
*  ENDIF.

  IF lv_placed_above_orgfa   IS NOT INITIAL.
    v_tn1tc_ou_rp_ou-deptou = lv_placed_above_orgfa.
  ENDIF.

  PERFORM dynpro_value_300 USING 'W' 'V_TN1TC_OU_RP_OU-TREAOU'.

ENDFORM.                    " SHOW_ORGID_TREA_300

*&---------------------------------------------------------------------*
*&      Form  DYNPRO_VALUE_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0926   text
*----------------------------------------------------------------------*
FORM dynpro_value_300  USING value(mode) TYPE c value(fname) TYPE c.

  DATA: l_repid         TYPE progname,
        l_dynnr         TYPE sychar04,

        cursorline      TYPE sycurow,
        cursorfield(30) TYPE c.


* Program and Dynpro
  l_repid = sy-repid.
  l_dynnr = sy-dynnr.

  GET CURSOR FIELD cursorfield LINE cursorline.

  CASE mode.
    WHEN 'R'.                          " R e a d m o d u s
      CLEAR: lt_dynpfields, ls_dynpfields.  " REFRESH lt_dynpfields.

      CASE fname.
        WHEN 'V_TN1TC_OU_RP_OU-DEPTOU'.
          ls_dynpfields-fieldname = 'V_TN1TC_OU_RP_OU-TREAOU'.
          ls_dynpfields-stepl        = cursorline.
          APPEND ls_dynpfields TO lt_dynpfields.

        WHEN 'V_TN1TC_OU_RP_OU-TREAOU'.
          ls_dynpfields-fieldname = 'V_TN1TC_OU_RP_OU-DEPTOU'.
          ls_dynpfields-stepl        = cursorline.
          APPEND ls_dynpfields TO lt_dynpfields.
      ENDCASE.

*     Read values of dynprofields
      CALL FUNCTION 'ISH_DYNP_VALUES_READ'
        EXPORTING
          dyname     = l_repid
          dynumb     = l_dynnr
        TABLES
          dynpfields = lt_dynpfields.

*     Take over the values of  DYNPFIELDS-Table
      CASE fname.
        WHEN 'V_TN1TC_OU_RP_OU-DEPTOU'.
          READ TABLE lt_dynpfields INTO ls_dynpfields
                     WITH KEY fieldname = 'V_TN1TC_OU_RP_OU-TREAOU'.
          IF sy-subrc = 0.
            v_tn1tc_ou_rp_ou-treaou = ls_dynpfields-fieldvalue.
          ENDIF.

        WHEN 'V_TN1TC_OU_RP_OU-TREAOU'.
          READ TABLE lt_dynpfields INTO ls_dynpfields
                     WITH KEY fieldname = 'V_TN1TC_OU_RP_OU-DEPTOU'.
          IF sy-subrc = 0.
            v_tn1tc_ou_rp_ou-deptou = ls_dynpfields-fieldvalue.
          ENDIF.

*          READ TABLE DYNPFIELDS WITH KEY 'RNDIA-DITXT'.
*          IF SY-SUBRC EQ 0.
*            DYNPFIELDS-FIELDVALUE = RNDIA-DITXT.
*            MODIFY DYNPFIELDS INDEX SY-TABIX.
*          ENDIF.

      ENDCASE.                         " CASE FNAME

    WHEN 'W'.                          " W r i t e m o d u s

      CASE fname.
*        WHEN 'V_TN1TC_OU_R_OU-DEPTOU'.
*          ls_dynpfields-fieldname = 'V_TN1TC_OU_RP_OU-TREAOU'.
*          ls_dynpfields-stepl        = cursorline.
*          APPEND ls_dynpfields TO lt_dynpfields.

        WHEN 'V_TN1TC_OU_RP_OU-TREAOU'.
          READ TABLE lt_dynpfields INTO ls_dynpfields
                     WITH KEY fieldname = 'V_TN1TC_OU_RP_OU-DEPTOU'.
          IF sy-subrc = 0.
            ls_dynpfields-fieldvalue = v_tn1tc_ou_rp_ou-deptou.
            MODIFY lt_dynpfields FROM ls_dynpfields
                   INDEX sy-tabix.
          ENDIF.

      ENDCASE.

*     Read values of dynprofields
      CALL FUNCTION 'DYNP_VALUES_UPDATE'
        EXPORTING
          dyname     = l_repid
          dynumb     = l_dynnr
        TABLES
          dynpfields = lt_dynpfields.

  ENDCASE.                             " CASE MODE


ENDFORM.                    " DYNPRO_VALUE_300
*&---------------------------------------------------------------------*
*&      Form  CHECK_OU_ID_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_V_TN1TC_OU_R_OU_INSTITUTION_I  text
*      -->P_V_TN1TC_OU_R_OU_ID  text
*      -->P_ZUW_TYP   type of assignment
*      <--P_G_RC      returncode
*----------------------------------------------------------------------*
FORM check_ou_id_300  USING    p_einri
                               p_orgid
                               value(p_zuw_typ)
                      CHANGING p_g_rc.


  DATA: lt_norg  TYPE ish_t_norg,
        ls_norg  TYPE norg.

  CLEAR p_g_rc.

  CALL FUNCTION 'ISH_READ_NORG'
    EXPORTING
      einri         = p_einri
      orgid         = p_orgid
    IMPORTING
      norg_e        = ls_norg
    EXCEPTIONS
      missing_orgid = 1
      OTHERS        = 2.

  IF sy-subrc = 0.
    IF p_zuw_typ      = 'F'      AND
       ls_norg-fazuw NE abap_on.
*     invalid assignment
      p_g_rc = 2.
    ENDIF.

    IF p_zuw_typ      = 'P'      AND
       ls_norg-fazuw = abap_on.
*     invalid assignment
      p_g_rc = 2.
    ENDIF.
  ELSE.
*     invalid orgid
    p_g_rc = 1.
  ENDIF.

ENDFORM.                    " CHECK_OU_ID_300
*&---------------------------------------------------------------------*
*&      Form  CHECK_ORG_HIERARCHY_300
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_ZV_TN1TC_OU_R_OU_INSTITUTION_I  text
*      -->P_ZV_TN1TC_OU_R_OU_DEPTOU  text
*      -->P_ZV_TN1TC_OU_R_OU_TREAOU  text
*      <--P_G_RC  text
*----------------------------------------------------------------------*
FORM check_org_hierarchy_300  USING    p_institution_id
                                       p_deptou
                                       p_treaou
                              CHANGING p_g_rc.

  DATA: l_orgfa_id     TYPE orgid,
        ls_orgfa       TYPE norg,

        lt_tn10i_up    TYPE ishmed_t_tn10i,
        ls_tn10i_up    TYPE tn10i.


  CLEAR p_g_rc.

* step-1: check organizational hierarchy for inter-departmental
  CALL METHOD cl_ish_dbr_org_interdep=>get_t_org_interdep_up
    EXPORTING
      i_orgin           = p_treaou
*     it_orgin          =
*     it_orgin_range    =
      i_read_db         = abap_on
*     i_begdt           = SY-DATUM
*     i_enddt           = SY-DATUM
*     i_fieldname_orgin = SPACE
    IMPORTING
      et_tn10i          = lt_tn10i_up
      e_rc              = p_g_rc.
*    CHANGING
*      cr_errorhandler   =

  IF g_rc = 0.
    LOOP AT lt_tn10i_up INTO ls_tn10i_up
            WHERE orgbe = p_deptou.
    ENDLOOP.
    IF sy-subrc = 0.
      RETURN.
    ENDIF.
  ELSE.
    CLEAR p_g_rc.
  ENDIF.

* step-2: check organizational hierarchy
  CALL FUNCTION 'ISH_GET_ORGFA_ABOVE_ORGPF'
    EXPORTING
      i_einri          = p_institution_id
      i_orgpf          = p_treaou
      i_date           = sy-datum
      i_consider_orgpf = abap_off
    IMPORTING
      e_orgfa_id       = l_orgfa_id
      e_orgfa          = ls_orgfa
    EXCEPTIONS
      not_found_orgfa  = 1
      not_found_orgpf  = 2
      OTHERS           = 3.

  IF sy-subrc < 2.
    IF l_orgfa_id NE p_deptou.
      p_g_rc = 1.
    ENDIF.
  ENDIF.

ENDFORM.                    " CHECK_ORG_HIERARCHY_300
*&---------------------------------------------------------------------*
*&      Form  CREATE_TAB_F4_OU_OU_600
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM create_tab_f4_ou_ou_600.

  DATA: lv_ou_resp_before      TYPE n1tc_ou_resp,

        lv_hier_level_before   TYPE rn1_hier_lev,
        lv_level_above         TYPE rn1_hier_lev,

        lines_lt_oe_hier       TYPE sytfill,
        lv_tabix               TYPE sy-tabix,

        lt_oe_hier             TYPE ishmed_t_dynp_oe_hier,
        lt_oe_hier_2           TYPE ishmed_t_dynp_oe_hier,
        ls_oe_hier_2           TYPE rn1_dynp_oe_hier,
        ls_oe_hier_last_entry  TYPE rn1_dynp_oe_hier,

        lt_oe_hier_last_level  TYPE ishmed_t_dynp_oe_hier,
        ls_oe_hier_last_level  TYPE rn1_dynp_oe_hier,

        ls_hier_last_level     TYPE rn1_dynp_oe_hier.


  FIELD-SYMBOLS: <fs_oe_hier>   TYPE rn1_dynp_oe_hier.

  CLEAR: gt_tn1tc_ou_resp_ou,
         gt_tn1tc_ou_resp_ou_2,
         gt_times_ou_f4.


  SELECT * FROM tn1tc_ou_resp_ou INTO TABLE gt_tn1tc_ou_resp_ou
           WHERE institution_id = v_tn1tc_times_ou-institution_id
             AND delflag        = abap_off.

  SORT gt_tn1tc_ou_resp_ou
       BY ou_resp
          deptou
          treaou.

  gt_tn1tc_ou_resp_ou_2[] = gt_tn1tc_ou_resp_ou[].

  LOOP AT gt_tn1tc_ou_resp_ou ASSIGNING <fs_tn1tc_ou_resp_ou>.

    IF <fs_tn1tc_ou_resp_ou>-ou_resp = gs_double_asterisk_ou_resp.
      CONTINUE.
    ENDIF.

    CLEAR gs_times_ou_f4.

    AT NEW ou_resp.
      CLEAR gs_double_asterisk_ou_resp.

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*     step-1: check deptou = '*' and treaou = '*'
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      LOOP AT gt_tn1tc_ou_resp_ou_2 ASSIGNING <fs_tn1tc_ou_resp_ou_2>
        WHERE ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp
          AND deptou = '*'
          AND treaou = '*'.

        gs_double_asterisk_ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp.
        APPEND gs_double_asterisk_ou_resp TO gt_double_asterisk_ou_resp.
        EXIT.
      ENDLOOP. " loop step-1

      IF gs_double_asterisk_ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp.
*       stop handling for this ou_resp
        CONTINUE.
      ENDIF.

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*     step-2: check deptou <> (initial and *) and treaou  = '*'
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      LOOP AT gt_tn1tc_ou_resp_ou_2 ASSIGNING <fs_tn1tc_ou_resp_ou_2>
        WHERE ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp
          AND deptou IS NOT INITIAL
          AND deptou NE '*'
          AND treaou  = '*'.

        CLEAR: lt_oe_hier,
               lt_oe_hier_last_level,
               ls_oe_hier_last_entry.

*        +++ inactivated MED-54643  note 2004335   +++
*        CALL METHOD cl_ishmed_utl_wizard=>get_ou_hier
*          EXPORTING
*            i_sel_bu   = abap_off
*            i_inderdis = abap_on
*            i_zimkz    = abap_off      "on
*            i_bettkz   = abap_off      "on
*            i_datum    = sy-datum
*            i_einri    = v_tn1tc_times_ou-institution_id
*            i_sperr    = abap_off           "off
*            i_loekz    = abap_off           "off
*            i_freig    = abap_on            "on
*            i_start_ou = <fs_tn1tc_ou_resp_ou_2>-deptou
*          RECEIVING
*            rt_oe_hier = lt_oe_hier.

*       begin MED-54643  note 2004335
        CALL METHOD cl_ishmed_utl_wizard=>get_ou_hier_tc
          EXPORTING
            i_sel_bu   = abap_off
            i_inderdis = abap_on
            i_zimkz    = abap_off      "on
            i_bettkz   = abap_off      "on
            i_datum    = sy-datum
            i_einri    = v_tn1tc_times_ou-institution_id
            i_sperr    = abap_off           "off
            i_loekz    = abap_off           "off
            i_freig    = abap_on            "on
            i_start_ou = <fs_tn1tc_ou_resp_ou_2>-deptou
          receiving
            rt_oe_hier = lt_oe_hier
          EXCEPTIONS
            invalid_entry = 1
            others        = 2.

        IF sy-subrc <> 0.
*         no message necessary; if at all use message-typ 'S'
*          MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
*                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          CONTINUE.
        ENDIF.
*       end MED-54643  note 2004335


        lines_lt_oe_hier = lines( lt_oe_hier ).


*       data processing backwards against last-entry of lt_oe_hier
        LOOP AT lt_oe_hier ASSIGNING <fs_oe_hier>.
          lv_tabix = sy-tabix.

          IF <fs_oe_hier>-hier_level LE
              ls_oe_hier_last_entry-hier_level.

*           get entry of last hierarchy-level
            COMPUTE lv_level_above =
                    ls_oe_hier_last_entry-hier_level - 1.
            READ TABLE lt_oe_hier_last_level
                       WITH KEY hier_level = lv_level_above
                           INTO ls_hier_last_level.

*           check conditions to transfer last entry into gt_times_ou_f4
            IF ls_hier_last_level-fazuw = abap_on  AND
              ( ls_oe_hier_last_entry-pfzuw = abap_on  OR
                ls_oe_hier_last_entry-ambes = abap_on ).

              CLEAR gs_times_ou_f4.
              gs_times_ou_f4-ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp.
              gs_times_ou_f4-deptou = <fs_tn1tc_ou_resp_ou_2>-deptou.
              gs_times_ou_f4-treaou = ls_oe_hier_last_entry-orgid.
              APPEND gs_times_ou_f4 TO gt_times_ou_f4.
            ENDIF.
          ELSE.    "hier_level > last_entry-hier_level

*           fill lt_oe_hier_last_level with entry of last-level
            IF ls_oe_hier_last_entry-hier_level > 0.
              DELETE lt_oe_hier_last_level
                  WHERE hier_level = ls_oe_hier_last_entry-hier_level.

              ls_oe_hier_last_level = ls_oe_hier_last_entry.
              APPEND ls_oe_hier_last_level TO lt_oe_hier_last_level.
            ENDIF.
          ENDIF.

          ls_oe_hier_last_entry = <fs_oe_hier>.

*         data processing for last entry of table
          IF lv_tabix = lines_lt_oe_hier.
            IF <fs_oe_hier>-hier_level LE
                ls_oe_hier_last_entry-hier_level.
              CLEAR gs_times_ou_f4.
              gs_times_ou_f4-ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp.
              gs_times_ou_f4-deptou = <fs_tn1tc_ou_resp_ou_2>-deptou.
              gs_times_ou_f4-treaou = ls_oe_hier_last_entry-orgid.
              APPEND gs_times_ou_f4 TO gt_times_ou_f4.
            ENDIF.
          ENDIF.

        ENDLOOP.   " AT lt_oe_hier ASSIGNING <fs_oe_hier>.

      ENDLOOP.   " loop step-2

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*     step-3: check deptou = '*' and treaou <> (initial and *)
*             (that means inter-departmental occupancy)
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      LOOP AT gt_tn1tc_ou_resp_ou_2 ASSIGNING <fs_tn1tc_ou_resp_ou_2>
        WHERE ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp
          AND deptou  = '*'
          AND treaou IS NOT INITIAL
          AND treaou NE '*'.


        CLEAR: lt_oe_hier,
               lt_oe_hier_2.

*        +++ inactivated MED-54643  note 2004335   +++
*        CALL METHOD cl_ishmed_utl_wizard=>get_ou_hier
*          EXPORTING
*            i_sel_bu   = abap_off
*            i_inderdis = abap_on
*            i_zimkz    = abap_off      "on
*            i_bettkz   = abap_off      "on
*            i_datum    = sy-datum
*            i_einri    = v_tn1tc_times_ou-institution_id
*            i_sperr    = abap_off           "off
*            i_loekz    = abap_off           "off
*            i_freig    = abap_on            "on
*            i_start_ou = '*'   "<fs_tn1tc_ou_resp_ou_2>-deptou
*          RECEIVING
*            rt_oe_hier = lt_oe_hier.

*       begin MED-54643  note 2004335
        CALL METHOD cl_ishmed_utl_wizard=>get_ou_hier_tc
          EXPORTING
            i_sel_bu   = abap_off
            i_inderdis = abap_on
            i_zimkz    = abap_off      "on
            i_bettkz   = abap_off      "on
            i_datum    = sy-datum
            i_einri    = v_tn1tc_times_ou-institution_id
            i_sperr    = abap_off           "off
            i_loekz    = abap_off           "off
            i_freig    = abap_on            "on
            i_start_ou = '*'   "<fs_tn1tc_ou_resp_ou_2>-deptou
          receiving
            rt_oe_hier = lt_oe_hier
          EXCEPTIONS
            invalid_entry = 1
            others        = 2.

        IF sy-subrc <> 0.
*         no message necessary; if at all use message-typ 'S'
*          MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
*                  WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
          CONTINUE.
        ENDIF.
*       end MED-54643  note 2004335

        lines_lt_oe_hier = lines( lt_oe_hier ).

        lt_oe_hier_2[] = lt_oe_hier.

        LOOP AT lt_oe_hier ASSIGNING <fs_oe_hier>
          WHERE orgid = <fs_tn1tc_ou_resp_ou_2>-treaou.

          lv_tabix = sy-tabix.

          IF <fs_oe_hier>-pfzuw NE abap_on AND
             <fs_oe_hier>-ambes NE abap_on.
            CONTINUE.
          ENDIF.

*         get deptou for treaou
          DO.
            lv_tabix = lv_tabix - 1.
            if lv_tabix = 0.               "Ba MED-54729 note 2004508
              exit.
            endif.
            READ TABLE lt_oe_hier_2 INDEX lv_tabix
                 INTO  ls_oe_hier_2.

            IF ls_oe_hier_2-hier_level < <fs_oe_hier>-hier_level  AND
               ls_oe_hier_2-fazuw = abap_on.

              CLEAR gs_times_ou_f4.
              gs_times_ou_f4-ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp.
              gs_times_ou_f4-deptou  = ls_oe_hier_2-orgid.
              gs_times_ou_f4-treaou = <fs_tn1tc_ou_resp_ou_2>-treaou.
              APPEND gs_times_ou_f4 TO gt_times_ou_f4.

              EXIT.
            ENDIF.

          ENDDO.

        ENDLOOP.    " AT lt_oe_hier ASSIGNING <fs_oe_hier>

      ENDLOOP.   " loop step-3

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*     step-4: check deptou = ' ' and treaou <> (initial and *)
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      LOOP AT gt_tn1tc_ou_resp_ou_2 ASSIGNING <fs_tn1tc_ou_resp_ou_2>
        WHERE ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp
          AND deptou = ' '
          AND treaou IS NOT INITIAL
          AND treaou  NE '*'.

        MOVE-CORRESPONDING <fs_tn1tc_ou_resp_ou_2> TO gs_times_ou_f4.
        APPEND gs_times_ou_f4 TO gt_times_ou_f4.

      ENDLOOP. " loop step-4
*

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*     step-5: check deptou <> (initial and *) and treaou = ' '
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      LOOP AT gt_tn1tc_ou_resp_ou_2 ASSIGNING <fs_tn1tc_ou_resp_ou_2>
        WHERE ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp

          AND deptou IS NOT INITIAL
          AND deptou NE '*'
          AND treaou  = ' '.

        MOVE-CORRESPONDING <fs_tn1tc_ou_resp_ou_2> TO gs_times_ou_f4.
        APPEND gs_times_ou_f4 TO gt_times_ou_f4.

      ENDLOOP. " loop step-5

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*     step-6: check deptou <> (initial and *) and
*                   treaou <> (initial and *)
* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

      LOOP AT gt_tn1tc_ou_resp_ou_2 ASSIGNING <fs_tn1tc_ou_resp_ou_2>
        WHERE ou_resp = <fs_tn1tc_ou_resp_ou>-ou_resp

          AND deptou IS NOT INITIAL
          AND deptou NE '*'
          AND treaou IS NOT INITIAL
          AND treaou  NE '*'.

        MOVE-CORRESPONDING <fs_tn1tc_ou_resp_ou_2> TO gs_times_ou_f4.
        APPEND gs_times_ou_f4 TO gt_times_ou_f4.

      ENDLOOP. " loop step-6

* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    ENDAT.    " AT NEW ou_resp.

  ENDLOOP.  " AT gt_tn1tc_ou_resp_ou


  SORT gt_times_ou_f4 BY ou_resp deptou treaou.
  DELETE ADJACENT DUPLICATES FROM gt_times_ou_f4
                        COMPARING ou_resp deptou treaou.


ENDFORM.                    " CREATE_TAB_F4_OU_OU_600
*&---------------------------------------------------------------------*
*&      Form  SHOW_ORGID_DEPT_600
*&---------------------------------------------------------------------*
*       F4-Help for ORGID_DEPT
*----------------------------------------------------------------------*
*      -->P_V_TN1TC_OU_R_OU_INSTITUTION_I  text
*      <--P_V_TN1TC_OU_R_OU_DEPTOU  text
*----------------------------------------------------------------------*
FORM show_orgid_dept_600  USING p_einri
                          CHANGING p_orgid.

  DATA: lv_placed_above_orgfa TYPE orgid,
        lv_placed_above_orgpf TYPE orgid,
        lv_start_orgfa        TYPE orgid,
        lv_start_orgpf        TYPE orgid.


  PERFORM dynpro_value_600 USING 'R' 'V_TN1TC_TIMES_OU-DEPTOU'.

  LOOP AT gt_double_asterisk_ou_resp INTO gs_double_asterisk_ou_resp
          WHERE ou_resp = v_tn1tc_times_ou-ou_resp.
  ENDLOOP.

  IF sy-subrc > 0.
    PERFORM show_orgid_const_dept_600
            USING v_tn1tc_times_ou-ou_resp.

  ELSE.

    CALL FUNCTION 'ISH_GRAPHIC_ORGID_SELECT'
      EXPORTING
        einri              = p_einri
        fazuw              = abap_on
*       pfzuw              = abap_off
*       ambes              = abap_off
        no_bauid           = abap_on
        disp_not_rel       = abap_on
        start_orgfa        = v_tn1tc_times_ou-deptou
        start_orgpf        = v_tn1tc_times_ou-treaou
      IMPORTING
        placed_above_orgfa = lv_placed_above_orgfa
        placed_above_orgpf = lv_placed_above_orgpf
        selected_orgid     = p_orgid
      EXCEPTIONS
        bauid_not_in_nbau  = 1
        einri_not_in_tn01  = 2
        no_hierarchy       = 3
        orgid_not_in_norg  = 4
        OTHERS             = 5.

*  PERFORM dynpro_value_600 USING 'W' 'V_TN1TC_TIMES_OU-DEPTOU'.

    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

  ENDIF.


ENDFORM.                    " SHOW_ORGID_DEPT_600
*&---------------------------------------------------------------------*
*&      Form  SHOW_ORGID_TREA_600
*&---------------------------------------------------------------------*
*       F4-Help for ORGID_DEPT
*----------------------------------------------------------------------*
*      -->P_V_TN1TC_OU_R_OU_INSTITUTION_I  text
*      <--P_V_TN1TC_OU_R_OU_DEPTOU  text
*----------------------------------------------------------------------*
FORM show_orgid_trea_600      USING p_einri
                           CHANGING p_orgid.

  DATA: lv_placed_above_orgfa TYPE orgid,
        lv_placed_above_orgpf TYPE orgid,
        lv_start_orgfa        TYPE orgid,
        lv_start_orgpf        TYPE orgid.


  PERFORM dynpro_value_600 USING 'R' 'V_TN1TC_TIMES_OU-TREAOU'.

  LOOP AT gt_double_asterisk_ou_resp INTO gs_double_asterisk_ou_resp
          WHERE ou_resp = v_tn1tc_times_ou-ou_resp.
  ENDLOOP.

  IF sy-subrc > 0.
    PERFORM show_orgid_const_trea_600
            USING v_tn1tc_times_ou-ou_resp.

  ELSE.

    CALL FUNCTION 'ISH_GRAPHIC_ORGID_SELECT'
      EXPORTING
        einri              = p_einri
*       fazuw              = abap_off
        pfzuw              = abap_on
        ambes              = abap_on
        no_bauid           = abap_on
        disp_not_rel       = abap_on
        start_orgfa        = v_tn1tc_times_ou-deptou
*       start_orgpf        = zv_tn1tc_ou_r_ou-treaou
      IMPORTING
        placed_above_orgfa = lv_placed_above_orgfa
        placed_above_orgpf = lv_placed_above_orgpf
        selected_orgid     = p_orgid
      EXCEPTIONS
        bauid_not_in_nbau  = 1
        einri_not_in_tn01  = 2
        no_hierarchy       = 3
        orgid_not_in_norg  = 4
        OTHERS             = 5.

    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

    IF lv_placed_above_orgfa   IS NOT INITIAL.
      v_tn1tc_times_ou-deptou = lv_placed_above_orgfa.
    ENDIF.

    PERFORM dynpro_value_600 USING 'W' 'V_TN1TC_TIMES_OU-TREAOU'.

  ENDIF.


ENDFORM.                    " SHOW_ORGID_TREA_600
*&---------------------------------------------------------------------*
*&      Form  DYNPRO_VALUE_600
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_0926   text
*----------------------------------------------------------------------*
FORM dynpro_value_600  USING value(mode) TYPE c value(fname) TYPE c.

  DATA: l_repid         TYPE progname,
        l_dynnr         TYPE sychar04,

        cursorline      TYPE sycurow,
        cursorfield(30) TYPE c.


* Program and Dynpro
  l_repid = sy-repid.
  l_dynnr = sy-dynnr.

  GET CURSOR FIELD cursorfield LINE cursorline.

  CASE mode.
    WHEN 'R'.                          " R e a d m o d u s
      CLEAR: lt_dynpfields, ls_dynpfields.  " REFRESH lt_dynpfields.

      CASE fname.
        WHEN 'V_TN1TC_TIMES_OU-DEPTOU'.
          ls_dynpfields-fieldname = 'V_TN1TC_TIMES_OU-TREAOU'.
          ls_dynpfields-stepl        = cursorline.
          APPEND ls_dynpfields TO lt_dynpfields.
          ls_dynpfields-fieldname = 'V_TN1TC_TIMES_OU-OU_RESP'.
          ls_dynpfields-stepl        = cursorline.
          APPEND ls_dynpfields TO lt_dynpfields.

        WHEN 'V_TN1TC_TIMES_OU-TREAOU'.
          ls_dynpfields-fieldname = 'V_TN1TC_TIMES_OU-DEPTOU'.
          ls_dynpfields-stepl        = cursorline.
          APPEND ls_dynpfields TO lt_dynpfields.
          ls_dynpfields-fieldname = 'V_TN1TC_TIMES_OU-OU_RESP'.
          ls_dynpfields-stepl        = cursorline.
          APPEND ls_dynpfields TO lt_dynpfields.

      ENDCASE.

*     Read values of dynprofields
      CALL FUNCTION 'ISH_DYNP_VALUES_READ'
        EXPORTING
          dyname     = l_repid
          dynumb     = l_dynnr
        TABLES
          dynpfields = lt_dynpfields.

*     Take over the values of  DYNPFIELDS-Table
      CASE fname.
        WHEN 'V_TN1TC_TIMES_OU-DEPTOU'.
          READ TABLE lt_dynpfields INTO ls_dynpfields
                     WITH KEY fieldname = 'V_TN1TC_TIMES_OU-TREAOU'.
          IF sy-subrc = 0.
            v_tn1tc_times_ou-treaou = ls_dynpfields-fieldvalue.
          ENDIF.

          READ TABLE lt_dynpfields INTO ls_dynpfields
           WITH KEY fieldname = 'V_TN1TC_TIMES_OU-OU_RESP'.
          IF sy-subrc = 0.
            v_tn1tc_times_ou-ou_resp = ls_dynpfields-fieldvalue.
          ENDIF.

        WHEN 'V_TN1TC_TIMES_OU-TREAOU'.
          READ TABLE lt_dynpfields INTO ls_dynpfields
                     WITH KEY fieldname = 'V_TN1TC_TIMES_OU-DEPTOU'.
          IF sy-subrc = 0.
            v_tn1tc_times_ou-deptou = ls_dynpfields-fieldvalue.
          ENDIF.

          READ TABLE lt_dynpfields INTO ls_dynpfields
           WITH KEY fieldname = 'V_TN1TC_TIMES_OU-OU_RESP'.
          IF sy-subrc = 0.
            v_tn1tc_times_ou-ou_resp = ls_dynpfields-fieldvalue.
          ENDIF.

      ENDCASE.                         " CASE FNAME

    WHEN 'W'.                          " W r i t e m o d u s

      CASE fname.
*        WHEN 'V_TN1TC_TIMES_OU-DEPTOU'.
*          ls_dynpfields-fieldname = 'V_TN1TC_TIMES_OU-TREAOU'.
*          ls_dynpfields-stepl        = cursorline.
*          APPEND ls_dynpfields TO lt_dynpfields.

        WHEN 'V_TN1TC_TIMES_OU-TREAOU'.
          READ TABLE lt_dynpfields INTO ls_dynpfields
                     WITH KEY fieldname = 'V_TN1TC_TIMES_OU-DEPTOU'.
          IF sy-subrc = 0.
            ls_dynpfields-fieldvalue = v_tn1tc_times_ou-deptou.
            MODIFY lt_dynpfields FROM ls_dynpfields
                   INDEX sy-tabix.
          ENDIF.

      ENDCASE.

*     Read values of dynprofields
      CALL FUNCTION 'DYNP_VALUES_UPDATE'
        EXPORTING
          dyname     = l_repid
          dynumb     = l_dynnr
        TABLES
          dynpfields = lt_dynpfields.

  ENDCASE.                             " CASE MODE

ENDFORM.                    " DYNPRO_VALUE_600
*&---------------------------------------------------------------------*
*&      Form  CHECK_OU_ID_ASTERISKS_600
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM check_ou_id_asterisks_600 .

  IF v_tn1tc_times_ou-deptou IS INITIAL.
*    SET CURSOR FIELD 'V_TN1TC_TIMES_OU-DEPTOU'
*               LINE  <vim_tctrl>-current_line.
**   Bitte erfassen Sie eine OE-Zuständigkeit
*    MESSAGE e768(n2).
    IF v_tn1tc_times_ou-treaou IS INITIAL.
      SET CURSOR FIELD 'V_TN1TC_TIMES_OU-DEPTOU'
                 LINE  <vim_tctrl>-current_line.
*     Erfassen Sie mindestens eine fachliche oder eine pflegerische OE
      MESSAGE e157(n1tc).
    ENDIF.
  ELSE.
    PERFORM check_ou_id_300 USING v_tn1tc_times_ou-institution_id
                                  v_tn1tc_times_ou-deptou
                                  'F'
                         CHANGING g_rc.

    IF g_rc > 0.
      SET CURSOR FIELD 'V_TN1TC_TIMES_OU-DEPTOU'
                 LINE  <vim_tctrl>-current_line.
      IF g_rc = 1.
*         Organisationseinheit & existiert nicht
        MESSAGE e204(n1) WITH v_tn1tc_times_ou-deptou.
      ELSE.
        IF g_rc = 2.
*           Org.einheit & ist nicht für fachliche Zuweisung vorgesehen
          MESSAGE e294(n2) WITH v_tn1tc_times_ou-deptou.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  IF v_tn1tc_times_ou-treaou IS NOT INITIAL AND
     v_tn1tc_times_ou-treaou NE '*'.

    PERFORM check_ou_id_300 USING  v_tn1tc_times_ou-institution_id
                                   v_tn1tc_times_ou-treaou
                                  'P'
                         CHANGING g_rc.

    IF g_rc > 0.
      SET CURSOR FIELD 'V_TN1TC_TIMES_OU-TREAOU'
                 LINE  <vim_tctrl>-current_line.

      IF g_rc = 1.
*         Organisationseinheit & existiert nicht
        MESSAGE e204(n1) WITH v_tn1tc_times_ou-treaou.
      ELSE.
        IF g_rc = 2.
*         Org.einheit ist nicht für pflegerische Zuweisung vorgesehen
          MESSAGE e295(n2) WITH v_tn1tc_times_ou-treaou.
        ENDIF.
      ENDIF.
    ELSE.
      IF v_tn1tc_times_ou-deptou IS NOT INITIAL AND
         v_tn1tc_times_ou-deptou NE '*'.

        PERFORM check_org_hierarchy_300
                USING    v_tn1tc_times_ou-institution_id
                         v_tn1tc_times_ou-deptou
                         v_tn1tc_times_ou-treaou
                CHANGING g_rc.

        IF g_rc > 0.
          SET CURSOR FIELD 'V_TN1TC_TIMES_OU-TREAOU'
                     LINE  <vim_tctrl>-current_line.
*         Die OE &1 ist der fachlichen OE &2 nicht untergeordnet
          MESSAGE e158(n1tc) WITH v_tn1tc_times_ou-treaou
                                  v_tn1tc_times_ou-deptou.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDIF.

ENDFORM.                    " CHECK_OU_ID_ASTERISKS_600
*&---------------------------------------------------------------------*
*&      Form  SHOW_ORGID_CONST_DEPT_600
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_V_TN1TC_TIMES_OU_OU_RESP  text
*----------------------------------------------------------------------*
FORM show_orgid_const_dept_600  USING  p_ou_resp.

  DATA: lt_return TYPE  TABLE OF ddshretval.
  FIELD-SYMBOLS: <fs_return> TYPE ddshretval.

  DATA: lt_mapfields TYPE TABLE OF dselc,
        ls_mapfields TYPE dselc,

        lt_field_tab TYPE TABLE OF dfies,
        ls_field_tab TYPE dfies,

        lv_dynnr      TYPE sydynnr.

  TYPES: BEGIN OF tys_ou_const_f4.
  TYPES: deptou   TYPE n1tc_deptou,
         treaou   TYPE n1tc_treaou,
         END OF tys_ou_const_f4.

  DATA:  lt_ou_const_f4 TYPE TABLE OF tys_ou_const_f4,
         ls_ou_const_f4 TYPE tys_ou_const_f4.

  FIELD-SYMBOLS: <ou_const_f4> TYPE tys_ou_const_f4.


  LOOP AT gt_times_ou_f4 ASSIGNING <fs_times_ou_f4>
    WHERE ou_resp = p_ou_resp.

    MOVE-CORRESPONDING <fs_times_ou_f4> TO ls_ou_const_f4.
    APPEND ls_ou_const_f4 TO lt_ou_const_f4.

  ENDLOOP.

  IF NOT lt_ou_const_f4[] IS INITIAL.

    ls_mapfields-fldname   = 'TREAOU'.
    ls_mapfields-dyfldname = 'V_TN1TC_TIMES_OU-TREAOU'.
    APPEND ls_mapfields  TO lt_mapfields.

    ls_field_tab-tabname   = 'RN1F4_TN1TC_TIMES_OU'.
    ls_field_tab-fieldname = 'DEPTOU'.
    APPEND ls_field_tab TO lt_field_tab.
    ls_field_tab-tabname   = 'RN1F4_TN1TC_TIMES_OU'.
    ls_field_tab-fieldname = 'TREAOU'.
    APPEND ls_field_tab TO lt_field_tab.
*
    lv_dynnr = sy-dynnr.


    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield        = 'DEPTOU'
        dynpprog        = 'SAPL0N1TC'
        dynpnr          = lv_dynnr
        dynprofield     = 'V_TN1TC_TIMES_OU-DEPTOU'
        window_title    = 'OE-Konstellationen'(001)
        value_org       = 'S'
      TABLES
        value_tab       = lt_ou_const_f4
        field_tab       = lt_field_tab
        return_tab      = lt_return
        dynpfld_mapping = lt_mapfields
      EXCEPTIONS
        parameter_error = 1
        no_values_found = 2
        OTHERS          = 3.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
*      READ TABLE lt_return ASSIGNING <fs_return> INDEX 1.
*      IF sy-subrc = 0.
*        zv_tn1tc_time_ou-deptou = <fs_return>-fieldval.
*      ENDIF.
    ENDIF.
  ELSE.   "lt_ou_const_f4[] IS INITIAL
*   no entries in TN1TC_OU_RESP_OU for p_ou_resp
  ENDIF.

ENDFORM.                    " SHOW_ORGID_CONST_DEPT_600
*&---------------------------------------------------------------------*
*&      Form  SHOW_ORGID_CONST_TREA_600
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_V_TN1TC_TIMES_OU_OU_RESP  text
*----------------------------------------------------------------------*
FORM show_orgid_const_trea_600  USING  p_ou_resp.

  DATA: lt_return TYPE  TABLE OF ddshretval.
  FIELD-SYMBOLS: <fs_return> TYPE ddshretval.

  DATA: lt_mapfields TYPE TABLE OF dselc,
        ls_mapfields TYPE dselc,

        lt_field_tab TYPE TABLE OF dfies,
        ls_field_tab TYPE dfies,

        lv_dynnr      TYPE sydynnr.

  TYPES: BEGIN OF tys_ou_const_f4.
  TYPES: deptou   TYPE n1tc_deptou,
         treaou   TYPE n1tc_treaou,
         END OF tys_ou_const_f4.

  DATA:  lt_ou_const_f4 TYPE TABLE OF tys_ou_const_f4,
         ls_ou_const_f4 TYPE tys_ou_const_f4.

  FIELD-SYMBOLS: <ou_const_f4> TYPE tys_ou_const_f4.


  LOOP AT gt_times_ou_f4 ASSIGNING <fs_times_ou_f4>
    WHERE ou_resp = p_ou_resp.

    MOVE-CORRESPONDING <fs_times_ou_f4> TO ls_ou_const_f4.
    APPEND ls_ou_const_f4 TO lt_ou_const_f4.

  ENDLOOP.

  IF NOT lt_ou_const_f4[] IS INITIAL.

    ls_mapfields-fldname   = 'DEPTOU'.
    ls_mapfields-dyfldname = 'V_TN1TC_TIMES_OU-DEPTOU'.
    APPEND ls_mapfields  TO lt_mapfields.

    ls_field_tab-tabname   = 'RN1F4_TN1TC_TIMES_OU'.
    ls_field_tab-fieldname = 'DEPTOU'.
    APPEND ls_field_tab TO lt_field_tab.

    ls_field_tab-tabname   = 'RN1F4_TN1TC_TIMES_OU'.
    ls_field_tab-fieldname = 'TREAOU'.
    APPEND ls_field_tab TO lt_field_tab.
*
    lv_dynnr = sy-dynnr.

    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
        retfield        = 'TREAOU'
        dynpprog        = 'SAPL0N1TC'
        dynpnr          = lv_dynnr
        dynprofield     = 'V_TN1TC_TIMES_OU-TREAOU'
        window_title    = 'OE-Konstellationen'(001)
        value_org       = 'S'
      TABLES
        value_tab       = lt_ou_const_f4
        field_tab       = lt_field_tab
        return_tab      = lt_return
        dynpfld_mapping = lt_mapfields
      EXCEPTIONS
        parameter_error = 1
        no_values_found = 2
        OTHERS          = 3.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
              WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
*      READ TABLE lt_return ASSIGNING <fs_return> INDEX 1.
*      IF sy-subrc = 0.
*        zv_tn1tc_time_ou-deptou = <fs_return>-fieldval.
*      ENDIF.
    ENDIF.
  ELSE.   "lt_ou_const_f4[] IS INITIAL
*   no entries in TN1TC_OU_RESP_OU for p_ou_resp
  ENDIF.

ENDFORM.                    " SHOW_ORGID_CONST_TREA_600
