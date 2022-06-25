class CL_ISH_CHECK_LIST_STATUS definition
  public
  inheriting from CL_ISH_CHECK_LIST
  create public .

*"* public components of class CL_ISH_CHECK_LIST_STATUS
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .

  constants CO_OBTYP_CORD type TJ21-OBTYP value 'N1K'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      value(I_PARENT) type ref to CL_GUI_CONTAINER
      value(I_MARK) type RNT40-MARK default '2'
      value(I_CALLER) type N1CALLER
      value(I_OBTYP) type J_OBTYP optional
      value(IT_STSMA) type ISH_T_STSMA optional
      value(I_VCODE) type ISH_VCODE default 'UPD'
      value(I_NO_STSMA_IF_ONE) type ISH_ON_OFF default 'X'
      value(I_LENGTH_TXT) type I default 30 .
  methods CREATE_OUTTAB
    importing
      value(IT_STSMA) type ISH_T_STSMA optional .
  methods GET_SELECTED_ENTRIES
    exporting
      value(ET_STATUS) type ISH_T_STATUS
      value(ET_STATUS_OBJ) type ISH_T_STATUS_OBJ
      value(ET_STSMA) type ISH_T_STSMA
      value(ET_ESTAT) type ISH_T_ESTAT .
  class-methods GET_STATUS_TXT
    importing
      value(I_NO_STSMA_IF_ONE) type ISH_ON_OFF default 'X'
      value(IT_STSMA) type ISH_T_STSMA optional
      value(IT_ESTAT) type ISH_T_ESTAT optional
    exporting
      value(ET_STATUS_TXT) type ISH_T_STATUS_TXT
      value(ET_STATUS_OBJ) type ISH_T_STATUS_OBJ .
  methods SET_SELECTED_ENTRIES
    importing
      value(IT_STATUS) type ISH_T_STATUS optional
      value(IT_STSMA) type ISH_T_STSMA optional
      value(IT_ESTAT) type ISH_T_ESTAT optional .
  methods SET_VCODE
    importing
      value(I_VCODE) type ISH_VCODE default 'UPD' .
protected section.
*"* protected components of class CL_ISHMED_CHECK_LIST_POB
*"* do not include other source files here!!!

  methods CREATE_FIELDCAT .

  methods FILL_FIELDCAT
    redefinition .
private section.
*"* private components of class CL_ISH_CHECK_LIST_STATUS
*"* do not include other source files here!!!

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  data GT_STATUS_OBJ type ISH_T_STATUS_OBJ .
  data G_CALLER type N1CALLER .
  data G_NO_STSMA_IF_ONE type ISH_ON_OFF .
  data G_LENGTH_TEXT type I .
  data G_OBTYP type J_OBTYP .

  methods FILL_OUTTAB_LINE
    importing
      value(I_STATUS_TXT) type RN1STATUS_TXT
    exporting
      value(E_OUTTAB) type TY_CHECKLIST .
  methods SET_LAYOUT
    exporting
      value(E_LAYOUT) type LVC_S_LAYO .
ENDCLASS.



CLASS CL_ISH_CHECK_LIST_STATUS IMPLEMENTATION.


METHOD constructor .

  DATA: l_grid_layout    TYPE lvc_s_layo,
        lt_stsma         TYPE ish_t_stsma,
        ls_exc           TYPE lvc_s_qinf,
        lt_exc           TYPE lvc_t_qinf.

* First call super method
  CALL METHOD super->constructor
    EXPORTING
      i_parent = i_parent.

* Aufrufendes Programm
  g_caller = i_caller.

* Art der Markierung (1, 2 oder 3) dem globalem Attribut zuweisen
  g_mark = i_mark.

* Verarbeitungsmodus (UPD oder DIS) zuweisen
  g_vcode = i_vcode.

* Objekttyp
  g_obtyp = i_obtyp.

* Keine Zeile für Statusschema anzeigen, wenn nur 1 Statusschema
* vorhanden vorhanden ist
  g_no_stsma_if_one = i_no_stsma_if_one.

* Länge der Spalte 'Bezeichnung'
  g_length_text = i_length_txt.

* Übergebene Statusschemata übernehmen ODER
* alle für gewünschten Objekttyp lesen
  REFRESH lt_stsma.
  DESCRIBE TABLE it_stsma.
  IF sy-tfill > 0.
    lt_stsma[] = it_stsma[].
  ELSE.
    CALL METHOD cl_ish_stsma=>get_t_available_stsma
      EXPORTING
        i_obtyp  = i_obtyp
      IMPORTING
        et_stsma = lt_stsma.
  ENDIF.

* Layout festlegen
  CALL METHOD me->set_layout
    IMPORTING
      e_layout = l_grid_layout.

* Ausgabetabelle erstellen
  CALL METHOD me->create_outtab
    EXPORTING
      it_stsma = lt_stsma.

* Feldkatalog zusammenstellen
  CALL METHOD me->create_fieldcat.

* Set a tooltip for all grid rows with color (MED-30050)
  CLEAR: ls_exc, lt_exc.
  ls_exc-type  = cl_salv_tooltip=>c_type_color.
  ls_exc-value = cl_gui_resources=>list_col_heading.
  ls_exc-text  = 'Statusschema'(004).
  APPEND ls_exc TO lt_exc.

* Feldkatalog erweitern (wenn er noch nicht erstellt worden ist, dann
* wird ein 'Default'-Feldkatalog ermittelt), set_table_for_first_display
* und vorbelegte Datensätze markieren
  CALL METHOD me->create_display
    EXPORTING
      i_mark         = g_mark
      i_grid_layout  = l_grid_layout
      i_except_qinfo = lt_exc.                              " MED-30050

ENDMETHOD.


METHOD CREATE_FIELDCAT .

  CALL METHOD me->fill_fieldcat
    EXPORTING
      i_mark     = g_mark
    RECEIVING
      t_fieldcat = gt_fieldcat[].

ENDMETHOD.


METHOD CREATE_OUTTAB .

  DATA: l_stsma           LIKE LINE OF it_stsma,
        l_outtab          LIKE LINE OF gt_outtab,
        lt_estat          TYPE ish_t_estat,
        l_estat           LIKE LINE OF lt_estat,
        l_tj20            TYPE tj20,
        l_tj20t           TYPE tj20t,
        l_tj30            TYPE tj30,
        l_tj30t           TYPE tj30t,
        l_status_obj      LIKE LINE OF gt_status_obj,
        lt_status_txt     TYPE ish_t_status_txt,
        l_status_txt      LIKE LINE OF lt_status_txt.

  REFRESH: gt_outtab, gt_status_obj, lt_status_txt.

  CALL METHOD cl_ish_check_list_status=>get_status_txt
    EXPORTING
      i_no_stsma_if_one = g_no_stsma_if_one
      it_stsma          = it_stsma
    IMPORTING
      et_status_txt     = lt_status_txt
      et_status_obj     = gt_status_obj.

  SORT lt_status_txt BY stsma_txt stonr.

* Aus den Statusschemata + Anwenderstatus die Ausgabetabelle bilden
  LOOP AT lt_status_txt INTO l_status_txt.
    CALL METHOD me->fill_outtab_line
      EXPORTING
        i_status_txt = l_status_txt
      IMPORTING
        e_outtab     = l_outtab.
    APPEND l_outtab TO gt_outtab.
  ENDLOOP.

ENDMETHOD.


METHOD fill_fieldcat .

  DATA: l_wa_fieldcat TYPE lvc_s_fcat.

  REFRESH gt_fieldcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'RN1CHECKLIST'
    CHANGING
      ct_fieldcat            = gt_fieldcat[]
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
  ENDIF.

  LOOP AT gt_fieldcat INTO l_wa_fieldcat.
    CASE l_wa_fieldcat-fieldname.
      WHEN 'FIELD1'.
*       Statusschema
        l_wa_fieldcat-tech = 'X'.
      WHEN 'FIELD2'.
*       Anwenderstatus
        l_wa_fieldcat-tech = 'X'.
      WHEN 'FIELD3'.
*       Kürzel des Anwenderstatus
        l_wa_fieldcat-col_pos   = 1.
        l_wa_fieldcat-outputlen = '5'.
        l_wa_fieldcat-reptext   = 'Status'(002).
        l_wa_fieldcat-seltext   = l_wa_fieldcat-reptext.
        l_wa_fieldcat-scrtext_l = l_wa_fieldcat-seltext.
        l_wa_fieldcat-scrtext_m = l_wa_fieldcat-seltext.
        l_wa_fieldcat-scrtext_s = l_wa_fieldcat-seltext.
        l_wa_fieldcat-tooltip   = l_wa_fieldcat-seltext.
*        IF g_obtyp = co_obtyp_cord.
*          l_wa_fieldcat-rollname  = 'N1STATUS'.
*        ELSE.
        l_wa_fieldcat-rollname  = 'N1STATUS'.
*        ENDIF.
        IF i_mark = co_checkbox.
          l_wa_fieldcat-style = cl_gui_alv_grid=>mc_style_enabled.
        ENDIF.
      WHEN 'FIELD4'.
*       Bezeichnung
        l_wa_fieldcat-col_pos   = 2.
        IF g_length_text = 0 OR g_length_text > 30.
          l_wa_fieldcat-outputlen = '30'.
        ELSE.
          l_wa_fieldcat-outputlen = g_length_text.
        ENDIF.
        l_wa_fieldcat-reptext   = 'Bezeichnung'(001).
        l_wa_fieldcat-seltext   = l_wa_fieldcat-reptext.
        l_wa_fieldcat-scrtext_l = l_wa_fieldcat-seltext.
        l_wa_fieldcat-scrtext_m = l_wa_fieldcat-seltext.
        l_wa_fieldcat-scrtext_s = l_wa_fieldcat-seltext.
        l_wa_fieldcat-tooltip   = l_wa_fieldcat-seltext.
*        IF g_obtyp = co_obtyp_cord.
*          l_wa_fieldcat-rollname  = 'N1STATUS_TXT'.
*        ELSE.
        l_wa_fieldcat-rollname  = 'N1STATUS_TXT'.
*        ENDIF.
        IF i_mark = co_checkbox.
          l_wa_fieldcat-style = cl_gui_alv_grid=>mc_style_enabled.
        ENDIF.
      WHEN 'FIELD5'.
        l_wa_fieldcat-tech = 'X'.
      WHEN OTHERS.
    ENDCASE.
    MODIFY gt_fieldcat FROM l_wa_fieldcat.
  ENDLOOP.

  t_fieldcat[] = gt_fieldcat[].

ENDMETHOD.


METHOD fill_outtab_line .

  DATA: lt_style      TYPE lvc_t_styl,
        l_style       LIKE LINE OF lt_style.
  DATA: lt_color      TYPE lvc_t_scol,
        l_color       LIKE LINE OF lt_color.

  CLEAR e_outtab.

  REFRESH: lt_style, lt_color.

* Statusschema (Keyfeld 1 - technisch)
  e_outtab-field1 = i_status_txt-stsma.

* Anwenderstatus (Keyfeld 2 - technisch)
  e_outtab-field2 = i_status_txt-estat.

* Kürzel des Anwenderstatus
  e_outtab-field3 = i_status_txt-estat_txt04.

* Bezeichnung (Text des Statusschemas oder Anwenderstatus)
  IF i_status_txt-estat IS INITIAL.
    e_outtab-field4 = i_status_txt-stsma_txt.
    CLEAR l_color.
    l_color-color-col = cl_gui_resources=>list_col_heading.
*    l_color-color-int = cl_gui_resources=>list_intensified. MED-30050
    l_color-fname = 'FIELD4'.
    APPEND l_color TO lt_color.
    l_color-fname = 'FIELD3'.
    APPEND l_color TO lt_color.
*    l_style-style     = cl_gui_resources=>list_col_normal.  "MED-30050
*    APPEND l_style TO lt_style.
  ELSE.
    e_outtab-field4 = i_status_txt-estat_txt30.
  ENDIF.

* Ordnungsnummer (technisch)
  e_outtab-field5 = i_status_txt-stonr.

* Markierungsfeld (nur bei Marierungsart 1 oder 3 in Verwendung)
  IF g_mark = co_checkbox.
    e_outtab-field6 = ' '.
  ELSEIF g_mark = co_standard.
    e_outtab-field6 = ' '.
  ELSE.
    e_outtab-field6 = icon_led_inactive.
  ENDIF.

* Style-Tabelle
  INSERT LINES OF lt_style INTO TABLE e_outtab-style.

* Color-Tabelle
  INSERT LINES OF lt_color INTO TABLE e_outtab-ct.

ENDMETHOD.


METHOD get_selected_entries .

  DATA: lt_outtab_mark  TYPE ish_t_rn1checklist,
        l_outtab_mark   LIKE LINE OF lt_outtab_mark,
        l_st_obj        LIKE LINE OF gt_status_obj,
        l_status        LIKE LINE OF et_status,
        l_status_obj    LIKE LINE OF et_status_obj,
        l_stsma         TYPE REF TO cl_ish_stsma,
        l_estat         TYPE REF TO cl_ish_estat.
*        l_object_type   TYPE i.                              "REM MED-9409
  DATA: lr_identify     TYPE REF TO if_ish_identify_object.       "MED-9409

  REFRESH: et_status, et_status_obj, et_stsma, et_estat.

  CALL METHOD me->get_sel_entries
    IMPORTING
      e_outtab_mark = lt_outtab_mark.

  LOOP AT lt_outtab_mark INTO l_outtab_mark.
    IF et_status IS REQUESTED.
      CLEAR: l_status.
      l_status-stsma = l_outtab_mark-field1.
      l_status-estat = l_outtab_mark-field2.
      APPEND l_status TO et_status.
    ENDIF.
    IF et_status_obj IS REQUESTED OR
       et_stsma      IS REQUESTED OR et_estat IS REQUESTED.
      CLEAR: l_status_obj.
      l_status_obj-stsma = l_outtab_mark-field1.
      l_status_obj-estat = l_outtab_mark-field2.
      READ TABLE gt_status_obj INTO l_st_obj
                 WITH KEY stsma = l_status_obj-stsma
                          estat = l_status_obj-estat.
      IF sy-subrc = 0.
        l_status_obj-object = l_st_obj-object.
        APPEND l_status_obj TO et_status_obj.
      ENDIF.
*-------- BEGIN C.Honeder MED-9409
      TRY.
          lr_identify ?= l_st_obj-object.
          IF lr_identify->is_inherited_from( cl_ish_stsma=>co_otype_stsma ) = on.
*      CALL METHOD l_st_obj-object->('GET_TYPE')
*        IMPORTING
*          e_object_type = l_object_type.
*      IF l_object_type = cl_ish_stsma=>co_otype_stsma.
*-------- END C.Honeder MED-9409
            l_stsma ?= l_st_obj-object.
            APPEND l_stsma TO et_stsma.
          ELSEIF lr_identify->is_inherited_from( cl_ish_estat=>co_otype_estat ) = on.     "MED-9409
*      ELSEIF l_object_type = cl_ish_estat=>co_otype_estat.                           "REM MED-9409
            l_estat ?= l_st_obj-object.
            APPEND l_estat TO et_estat.
          ENDIF.
        CATCH cx_sy_move_cast_error.    "#EC NO_HANDLER                                   "MED-9409
      ENDTRY.                                                                             "MED-9409
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_status_txt .

  DATA: l_stsma           LIKE LINE OF it_stsma,
        lt_estat          TYPE ish_t_estat,
        l_estat           LIKE LINE OF lt_estat,
        l_tj20            TYPE tj20,
        l_tj20t           TYPE tj20t,
        l_tj30            TYPE tj30,
        l_tj30t           TYPE tj30t,
        l_no_stsma        TYPE ish_on_off,
        l_status_obj      LIKE LINE OF et_status_obj,
        l_status_txt      LIKE LINE OF et_status_txt.

  REFRESH: et_status_obj, et_status_txt.

  l_no_stsma = off.
  DESCRIBE TABLE it_stsma.
  IF sy-tfill = 1 AND i_no_stsma_if_one = on.
    l_no_stsma = on.
  ENDIF.

  LOOP AT it_stsma INTO l_stsma.
    CALL METHOD l_stsma->get_data
      IMPORTING
        es_tj20  = l_tj20
        es_tj20t = l_tj20t.
    IF l_no_stsma = off.
      CLEAR l_status_txt.
      l_status_txt-stsma       = l_tj20-stsma.
      l_status_txt-stsma_txt   = l_tj20t-txt.
      APPEND l_status_txt TO et_status_txt.
      CLEAR l_status_obj.
      l_status_obj-object      = l_stsma.
      l_status_obj-stsma       = l_tj20-stsma.
      APPEND l_status_obj TO et_status_obj.
    ENDIF.
*   Alle Anwenderstatus zum Statusschema lesen
    REFRESH lt_estat.
    CALL METHOD l_stsma->get_t_estat
      IMPORTING
        et_estat = lt_estat.
    LOOP AT lt_estat INTO l_estat.
      CALL METHOD l_estat->get_data
        IMPORTING
          es_tj30  = l_tj30
          es_tj30t = l_tj30t.
      CLEAR l_status_txt.
      l_status_txt-stsma       = l_tj20-stsma.
      l_status_txt-estat       = l_tj30-estat.
      l_status_txt-stonr       = l_tj30-stonr.
      l_status_txt-stsma_txt   = l_tj20t-txt.
      l_status_txt-estat_txt04 = l_tj30t-txt04.
      l_status_txt-estat_txt30 = l_tj30t-txt30.
      APPEND l_status_txt TO et_status_txt.
      CLEAR l_status_obj.
      l_status_obj-object      = l_estat.
      l_status_obj-stsma       = l_tj20-stsma.
      l_status_obj-estat       = l_tj30-estat.
      APPEND l_status_obj TO et_status_obj.
    ENDLOOP.
  ENDLOOP.

  LOOP AT it_estat INTO l_estat.
    CALL METHOD l_estat->get_data
      IMPORTING
        es_tj30  = l_tj30
        es_tj30t = l_tj30t.
    CLEAR l_stsma.
    CALL METHOD cl_ish_stsma=>load
      EXPORTING
        i_stsma     = l_tj30-stsma
      IMPORTING
        er_instance = l_stsma.
    CHECK NOT l_stsma IS INITIAL.                           " ID 15502
    CALL METHOD l_stsma->get_data
      IMPORTING
        es_tj20  = l_tj20
        es_tj20t = l_tj20t.
    CLEAR l_status_txt.
    l_status_txt-stsma       = l_tj20-stsma.
    l_status_txt-estat       = l_tj30-estat.
    l_status_txt-stonr       = l_tj30-stonr.
    l_status_txt-stsma_txt   = l_tj20t-txt.
    l_status_txt-estat_txt04 = l_tj30t-txt04.
    l_status_txt-estat_txt30 = l_tj30t-txt30.
    APPEND l_status_txt TO et_status_txt.
    CLEAR l_status_obj.
    l_status_obj-object      = l_estat.
    l_status_obj-stsma       = l_tj20-stsma.
    l_status_obj-estat       = l_tj30-estat.
    APPEND l_status_obj TO et_status_obj.
  ENDLOOP.

ENDMETHOD.


METHOD set_layout .

  CLEAR e_layout.

* Toolbar ausblenden
  e_layout-no_toolbar = 'X'.

  e_layout-grid_title = 'Klinische Auftragspositionen'(003).
  e_layout-smalltitle = 'X'.

* Grid eingabefähig, wenn Markierungsfeld eine Checkbox sein soll
  IF g_vcode = co_update    AND
     g_mark  = co_checkbox.
    e_layout-edit       = 'X'.
    e_layout-edit_mode  = 'X'.
  ENDIF.

  IF g_mark   = co_checkbox OR
     g_mark   = co_button   OR
     g_vcode <> co_update.
    e_layout-no_rowmark = 'X'.
  ENDIF.

* Color Table
  e_layout-ctab_fname = 'CT'.

ENDMETHOD.


METHOD set_selected_entries .

  DATA: l_status         LIKE LINE OF it_status,
        l_st_obj         LIKE LINE OF gt_status_obj,
        l_stsma          TYPE REF TO cl_ish_stsma,
        l_estat          TYPE REF TO cl_ish_estat,
        lt_stsma         TYPE ish_t_stsma,
        lt_estat         TYPE ish_t_estat,
        lt_outtab_mark   TYPE ish_t_rn1checklist,
        lt_status_txt    TYPE ish_t_status_txt,
        l_status_txt     LIKE LINE OF lt_status_txt,
        l_object_type    TYPE i,
        l_outtab_mark    LIKE LINE OF lt_outtab_mark,
        l_outtab         LIKE LINE OF gt_outtab.
  DATA: lr_identify      TYPE REF TO if_ish_identify_object."MED-9409

  REFRESH: lt_outtab_mark, lt_stsma, lt_estat.

  lt_stsma[] = it_stsma[].
  lt_estat[] = it_estat[].

  IF NOT it_status[] IS INITIAL.
    LOOP AT it_status INTO l_status.
      READ TABLE gt_status_obj INTO l_st_obj
                 WITH KEY stsma = l_status-stsma
                          estat = l_status-estat.
      CHECK sy-subrc = 0.
*-------- BEGIN C.Honeder MED-9409
      TRY.
          lr_identify ?= l_st_obj-object.
          IF lr_identify->is_inherited_from( cl_ish_stsma=>co_otype_stsma ) = on.
*      CALL METHOD l_st_obj-object->('GET_TYPE')
*        IMPORTING
*          e_object_type = l_object_type.
*      IF l_object_type = cl_ish_stsma=>co_otype_stsma.
*-------- END C.Honeder MED-9409
            l_stsma ?= l_st_obj-object.
            APPEND l_stsma TO lt_stsma.
          ELSEIF lr_identify->is_inherited_from( cl_ish_estat=>co_otype_estat ) = on. "MED-9409
*      ELSEIF l_object_type = cl_ish_estat=>co_otype_estat.                       "REM MED-9409
            l_estat ?= l_st_obj-object.
            APPEND l_estat TO lt_estat.
          ENDIF.
        CATCH cx_sy_move_cast_error."#EC NO_HANDLER                                    "MED-9409
      ENDTRY.                                                                          "MED-9409
    ENDLOOP.
  ENDIF.

  IF NOT lt_stsma[] IS INITIAL OR NOT lt_estat[] IS INITIAL.
    CALL METHOD cl_ish_check_list_status=>get_status_txt
      EXPORTING
        i_no_stsma_if_one = off                 " g_no_stsma_if_one
        it_stsma          = lt_stsma
        it_estat          = lt_estat
      IMPORTING
        et_status_txt     = lt_status_txt.
  ENDIF.

  LOOP AT lt_status_txt INTO l_status_txt.
    CALL METHOD me->fill_outtab_line
      EXPORTING
        i_status_txt = l_status_txt
      IMPORTING
        e_outtab     = l_outtab.
    CLEAR l_outtab_mark.
    MOVE-CORRESPONDING l_outtab TO l_outtab_mark.
    APPEND l_outtab_mark TO lt_outtab_mark.
  ENDLOOP.

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
      e_layout = l_grid_layout.

* set frontend layout
  CALL METHOD g_check_list->set_frontend_layout
    EXPORTING
      is_layout = l_grid_layout.

* refreshing the ALV grid on the frontend
  CALL METHOD me->refresh_table_display.

ENDMETHOD.
ENDCLASS.
