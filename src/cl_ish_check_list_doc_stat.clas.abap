class CL_ISH_CHECK_LIST_DOC_STAT definition
  public
  inheriting from CL_ISH_CHECK_LIST
  create public .

*"* public components of class CL_ISH_CHECK_LIST_DOC_STAT
*"* do not include other source files here!!!
public section.

  methods CONSTRUCTOR
    importing
      value(I_PARENT) type ref to CL_GUI_CONTAINER
      value(I_MARK) type RNT40-MARK default '2'
      value(I_CALLER) type N1CALLER
      value(IT_TDWST) type DMS_TBL_TDWST optional
      value(I_VCODE) type ISH_VCODE default 'UPD' .
  methods CREATE_OUTTAB
    importing
      !IT_TDWST type DMS_TBL_TDWST optional .
  methods GET_SELECTED_ENTRIES
    exporting
      value(ET_TDWST) type DMS_TBL_TDWST .
  methods SET_SELECTED_ENTRIES
    importing
      value(IT_TDWST) type DMS_TBL_TDWST .
  methods SET_VCODE
    importing
      value(I_VCODE) type ISH_VCODE default 'UPD' .
  methods SET_ALL_RELEASED
    exporting
      value(ET_TDWST) type DMS_TBL_TDWST .
protected section.
*"* protected components of class CL_ISHMED_CHECK_LIST_POB
*"* do not include other source files here!!!

  methods CREATE_FIELDCAT .

  methods FILL_FIELDCAT
    redefinition .
private section.
*"* private components of class CL_ISH_CHECK_LIST_DOC_STAT
*"* do not include other source files here!!!

  data G_CALLER type N1CALLER .
  data GT_TDWST type DMS_TBL_TDWST .

  methods FILL_OUTTAB_LINE
    importing
      value(IS_TDWST) type TDWST
    exporting
      value(ES_OUTTAB) type TY_CHECKLIST .
  methods SET_LAYOUT
    exporting
      value(ES_LAYOUT) type LVC_S_LAYO .
ENDCLASS.



CLASS CL_ISH_CHECK_LIST_DOC_STAT IMPLEMENTATION.


METHOD constructor .

  DATA: ls_grid_layout    TYPE lvc_s_layo,
        lt_tdwst          TYPE dms_tbl_tdwst.

  CALL METHOD super->constructor
    EXPORTING
      i_parent = i_parent.

* Caller
  g_caller = i_caller.

* Set the global variable for type of selection (1, 2 oder 3)
  g_mark = i_mark.

* Set mode (UPD or DIS)
  g_vcode = i_vcode.

* Set layout
  CALL METHOD me->set_layout
    IMPORTING
      es_layout = ls_grid_layout.

* Create outtab
  CALL METHOD me->create_outtab
    EXPORTING
      it_tdwst = lt_tdwst.

* Create fieldcatalog
  CALL METHOD me->create_fieldcat.

* Set_table_for_first_display and mark selected lines
  CALL METHOD me->create_display
    EXPORTING
      i_mark        = g_mark
      i_grid_layout = ls_grid_layout.

ENDMETHOD.


METHOD CREATE_FIELDCAT .

  CALL METHOD me->fill_fieldcat
    EXPORTING
      i_mark     = g_mark
    RECEIVING
      t_fieldcat = gt_fieldcat[].

ENDMETHOD.


METHOD create_outtab .

  DATA: ls_outtab  LIKE LINE OF gt_outtab.
  DATA: ls_tdwst   TYPE tdwst,
        lt_tdwst   TYPE dms_tbl_tdwst.
  DATA: lt_tdwo    TYPE TABLE OF tdwo,
        lt_tdws    TYPE TABLE OF tdws.

  IF it_tdwst[] IS INITIAL.
    SELECT dokar FROM tdwo INTO CORRESPONDING FIELDS OF TABLE lt_tdwo
           WHERE  dokob  = 'N2MED'.
    IF sy-subrc = 0.
      SELECT dokst FROM tdws INTO CORRESPONDING FIELDS OF TABLE lt_tdws
             FOR ALL ENTRIES IN lt_tdwo
             WHERE  dokar  = lt_tdwo-dokar.
    ENDIF.

    DESCRIBE TABLE lt_tdws.

    IF sy-tfill > 0.
      SELECT * FROM tdwst
               INTO CORRESPONDING FIELDS
               OF TABLE lt_tdwst
               FOR ALL ENTRIES IN lt_tdws
               WHERE cvlang = sy-langu
                 AND dokst  = lt_tdws-dokst.
    ENDIF.

    IF sy-subrc = 0.
      SORT lt_tdwst BY stabk dokst.
      DELETE ADJACENT DUPLICATES FROM lt_tdwst COMPARING stabk.
    ENDIF.

  ENDIF.

* Fill outtab
  CLEAR: ls_tdwst, ls_outtab.
  ls_tdwst-dokst = '00'.
  ls_tdwst-stabk = '00'.
  ls_tdwst-dostx = 'kein Dokument'(009).

  CALL METHOD me->fill_outtab_line
    EXPORTING
      is_tdwst  = ls_tdwst
    IMPORTING
      es_outtab = ls_outtab.
  APPEND ls_outtab TO gt_outtab.

  LOOP AT lt_tdwst INTO ls_tdwst.
    CALL METHOD me->fill_outtab_line
      EXPORTING
        is_tdwst  = ls_tdwst
      IMPORTING
        es_outtab = ls_outtab.
    APPEND ls_outtab TO gt_outtab.
  ENDLOOP.

* Set global table
  gt_tdwst = lt_tdwst.

ENDMETHOD.


METHOD fill_fieldcat .

  DATA: ls_fieldcat TYPE lvc_s_fcat.
  DATA: lt_fieldcat TYPE lvc_t_fcat.

  REFRESH lt_fieldcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'RN1CHECKLIST'
    CHANGING
      ct_fieldcat            = lt_fieldcat[]
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    CLEAR ls_fieldcat.
  ENDIF.

  LOOP AT lt_fieldcat INTO ls_fieldcat.
    CASE ls_fieldcat-fieldname.
      WHEN 'FIELD1'.
*       Kürzel des Dokumentstatus
        ls_fieldcat-col_pos   = '1'.
        ls_fieldcat-outputlen = '8'.
        ls_fieldcat-reptext   = 'Status'(002).
        ls_fieldcat-seltext   = ls_fieldcat-reptext.
      WHEN 'FIELD2'.
        ls_fieldcat-no_out = 'X'.
      WHEN 'FIELD3'.
*       Bezeichnung
        ls_fieldcat-col_pos   = 2.
        ls_fieldcat-outputlen = '30'.
        ls_fieldcat-reptext   = 'Bezeichnung'(001).
        ls_fieldcat-seltext   = ls_fieldcat-reptext.
        ls_fieldcat-scrtext_l = ls_fieldcat-seltext.
        ls_fieldcat-scrtext_m = ls_fieldcat-seltext.
        ls_fieldcat-scrtext_s = ls_fieldcat-seltext.
        ls_fieldcat-tooltip   = ls_fieldcat-seltext.
      WHEN 'FIELD4'.
        ls_fieldcat-no_out = 'X'.
      WHEN 'FIELD5'.
        ls_fieldcat-no_out = 'X'.
      WHEN OTHERS.
        ls_fieldcat-no_out = 'X'.
    ENDCASE.
    MODIFY lt_fieldcat FROM ls_fieldcat.
  ENDLOOP.

  t_fieldcat[] = lt_fieldcat[].

ENDMETHOD.


METHOD FILL_OUTTAB_LINE .

  DATA: lt_style      TYPE lvc_t_styl,
        l_style       LIKE LINE OF lt_style.
  DATA: lt_color      TYPE lvc_t_scol,
        l_color       LIKE LINE OF lt_color.

  CLEAR es_outtab.

  REFRESH: lt_style, lt_color.

* Dokumentstatus
  es_outtab-field1 = is_tdwst-dokst.

* Bezeichnung des Dokumentstatus
  es_outtab-field3 = is_tdwst-dostx.

* Markierungsfeld (nur bei Marierungsart 1 oder 3 in Verwendung)
  IF g_mark = co_checkbox.
    es_outtab-field6 = ' '.
  ELSEIF g_mark = co_standard.
    es_outtab-field6 = ' '.
  ELSE.
    es_outtab-field6 = icon_led_inactive.
  ENDIF.

* Style-Tabelle
  INSERT LINES OF lt_style INTO TABLE es_outtab-style.

* Color-Tabelle
  INSERT LINES OF lt_color INTO TABLE es_outtab-ct.

ENDMETHOD.


METHOD get_selected_entries .

  DATA: lt_outtab_mark  TYPE ish_t_rn1checklist,
        ls_outtab_mark   LIKE LINE OF lt_outtab_mark.
  DATA: ls_tdwst TYPE tdwst.

  CALL METHOD me->get_sel_entries
    IMPORTING
      e_outtab_mark = lt_outtab_mark.

  LOOP AT lt_outtab_mark INTO ls_outtab_mark.
    CLEAR: ls_tdwst.
    ls_tdwst-dokst = ls_outtab_mark-field1.
    ls_tdwst-dostx = ls_outtab_mark-field2.
    APPEND ls_tdwst TO et_tdwst.
  ENDLOOP.

ENDMETHOD.


METHOD set_all_released .
  DATA: lt_tdwst TYPE dms_tbl_tdwst.
  DATA: ls_tdwst TYPE tdwst.

* Loop on all status
  LOOP AT gt_tdwst INTO ls_tdwst.
    SELECT SINGLE dokst INTO ls_tdwst-dokst
             FROM tdws
            WHERE dokst = ls_tdwst-dokst
              AND frknz = 'X'.

*   Document status is released
    IF sy-subrc = 0.
      APPEND ls_tdwst to lt_tdwst.
    ENDIF.
  ENDLOOP.

  et_tdwst[] = lt_tdwst[].
ENDMETHOD.


METHOD SET_LAYOUT .

  CLEAR es_layout.

* No toolbar visible
  es_layout-no_toolbar = 'X'.

* Grid eingabefähig, wenn Markierungsfeld eine Checkbox sein soll
  IF g_vcode = co_update    AND
     g_mark  = co_checkbox.
    es_layout-edit       = 'X'.
    es_layout-edit_mode  = 'X'.
  ENDIF.

  IF g_mark   = co_checkbox OR
     g_mark   = co_button   OR
     g_vcode <> co_update.
    es_layout-no_rowmark = 'X'.
  ENDIF.

* Color Table
  es_layout-ctab_fname = 'CT'.

* Set the fieldname for the style-column
  es_layout-stylefname = 'CELLSTYLE'.
ENDMETHOD.


METHOD set_selected_entries .

  DATA: lt_outtab_mark   TYPE ish_t_rn1checklist.
  DATA: ls_outtab_mark   LIKE LINE OF lt_outtab_mark.
  DATA: ls_outtab        LIKE LINE OF gt_outtab.

  DATA: ls_tdwst         TYPE tdwst.

* Loop on document status
  LOOP AT it_tdwst INTO ls_tdwst.
    IF  ls_tdwst-dokst = '00'.
      ls_tdwst-stabk = '00'.
      ls_tdwst-dostx = 'kein Dokument'(009).
    ELSE.
      IF ls_tdwst-dostx IS INITIAL.
*     There was no text in the list, so find it
        SELECT SINGLE dostx INTO ls_tdwst-dostx
                            FROM tdwst
                           WHERE dokst  = ls_tdwst-dokst
                             AND cvlang = sy-langu.
        IF sy-subrc NE 0.
          CONTINUE.
        ENDIF.
      ENDIF.
    ENDIF.

*   Fill outtab line
    CALL METHOD me->fill_outtab_line
      EXPORTING
        is_tdwst  = ls_tdwst
      IMPORTING
        es_outtab = ls_outtab.

*   Fill outtab_mark
    CLEAR ls_outtab_mark.
    MOVE-CORRESPONDING ls_outtab TO ls_outtab_mark.
    APPEND ls_outtab_mark TO lt_outtab_mark.

  ENDLOOP.

* Select entries
  CALL METHOD me->set_sel_entries
    EXPORTING
      i_outtab_mark = lt_outtab_mark
      i_mark        = g_mark.

ENDMETHOD.


METHOD SET_VCODE .

  DATA: l_grid_layout         TYPE lvc_s_layo.

  CHECK i_vcode <> g_vcode.

  g_vcode = i_vcode.

* set layout
  CALL METHOD me->set_layout
    IMPORTING
      es_layout = l_grid_layout.

* set frontend layout
  CALL METHOD g_check_list->set_frontend_layout
    EXPORTING
      is_layout = l_grid_layout.

* refreshing the ALV grid on the frontend
  CALL METHOD me->refresh_table_display.

ENDMETHOD.
ENDCLASS.
