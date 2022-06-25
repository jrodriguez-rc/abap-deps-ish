class CL_ISH_VIEW definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_VIEW
*"* do not include other source files here!!!
  type-pools ICON .

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_LIST_DISPLAY .

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
  aliases CO_SEL_DSPCLS
    for IF_ISH_LIST_DISPLAY~CO_SEL_DSPCLS .
  aliases CO_SEL_DSPOBJ
    for IF_ISH_LIST_DISPLAY~CO_SEL_DSPOBJ .
  aliases CO_SEL_IMPOBJ
    for IF_ISH_LIST_DISPLAY~CO_SEL_IMPOBJ .
  aliases CO_SEL_OBJECT
    for IF_ISH_LIST_DISPLAY~CO_SEL_OBJECT .
  aliases CO_SEL_SRVOBJ
    for IF_ISH_LIST_DISPLAY~CO_SEL_SRVOBJ .
  aliases CO_SORT_DATE
    for IF_ISH_LIST_DISPLAY~CO_SORT_DATE .
  aliases CO_SORT_INDIVIDUAL
    for IF_ISH_LIST_DISPLAY~CO_SORT_INDIVIDUAL .
  aliases CO_SORT_OPOU
    for IF_ISH_LIST_DISPLAY~CO_SORT_OPOU .
  aliases CO_SORT_OP_STD
    for IF_ISH_LIST_DISPLAY~CO_SORT_OP_STD .
  aliases CO_SORT_REQUESTER
    for IF_ISH_LIST_DISPLAY~CO_SORT_REQUESTER .
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
  aliases CHECK_IF_EMPTY
    for IF_ISH_LIST_DISPLAY~CHECK_IF_EMPTY .
  aliases DESTROY
    for IF_ISH_LIST_DISPLAY~DESTROY .
  aliases DISPLAY
    for IF_ISH_LIST_DISPLAY~DISPLAY .
  aliases GET_DATA
    for IF_ISH_LIST_DISPLAY~GET_DATA .
  aliases GET_SELECTION
    for IF_ISH_LIST_DISPLAY~GET_SELECTION .
  aliases GET_TOOLBAR
    for IF_ISH_LIST_DISPLAY~GET_TOOLBAR .
  aliases INSERT_DATA
    for IF_ISH_LIST_DISPLAY~INSERT_DATA .
  aliases REFRESH
    for IF_ISH_LIST_DISPLAY~REFRESH .
  aliases REFRESH_DATA
    for IF_ISH_LIST_DISPLAY~REFRESH_DATA .
  aliases REMOVE_DATA
    for IF_ISH_LIST_DISPLAY~REMOVE_DATA .
  aliases SET_SCROLL_POSITION
    for IF_ISH_LIST_DISPLAY~SET_SCROLL_POSITION .
  aliases SET_SELECTION
    for IF_ISH_LIST_DISPLAY~SET_SELECTION .
  aliases SET_SORT_CRITERIA
    for IF_ISH_LIST_DISPLAY~SET_SORT_CRITERIA .
  aliases AFTER_USER_COMMAND
    for IF_ISH_LIST_DISPLAY~AFTER_USER_COMMAND .
  aliases BEFORE_USER_COMMAND
    for IF_ISH_LIST_DISPLAY~BEFORE_USER_COMMAND .
  aliases CONTEXT_MENU
    for IF_ISH_LIST_DISPLAY~CONTEXT_MENU .
  aliases DOUBLE_CLICK
    for IF_ISH_LIST_DISPLAY~DOUBLE_CLICK .
  aliases HOTSPOT_CLICK
    for IF_ISH_LIST_DISPLAY~HOTSPOT_CLICK .
  aliases IS_EMPTY
    for IF_ISH_LIST_DISPLAY~IS_EMPTY .
  aliases ONDRAG
    for IF_ISH_LIST_DISPLAY~ONDRAG .
  aliases ONDROP
    for IF_ISH_LIST_DISPLAY~ONDROP .
  aliases USER_COMMAND
    for IF_ISH_LIST_DISPLAY~USER_COMMAND .

  constants CO_DD_FLAVOR type CHAR20 value 'ISH_PERF_PAT'. "#EC NOTEXT
  constants CO_OTYPE_VIEW type ISH_OBJECT_TYPE value 12013. "#EC NOTEXT
  data GT_NODES_OPEN type ISHMED_T_DISPLAY_FIELDS .
  data G_DRAGDROP type ref to CL_DRAGDROP .
  class-data G_DRAG_LINE type I .
  data G_GRID type ref to CL_GUI_ALV_GRID .
  data G_INSTITUTION type EINRI .
  data G_NODES_OPEN type ISH_ON_OFF .
  data G_TREE type ref to CL_GUI_ALV_TREE .
  data G_VIEW_ID type NWVIEW-VIEWID .
  data G_VIEW_TYPE type NWVIEW-VIEWTYPE .
  data G_WPLACE_ID type NWPLACE-WPLACEID .

  methods GET_FRONTEND_LAYOUT
    exporting
      !E_LAYOUT type LVC_S_LAYO
      !ET_FIELDCAT type LVC_T_FCAT
      !ET_SORT type LVC_T_SORT
      !ET_FILTER type LVC_T_FILT .
  methods GET_OBJECT_FOR_IDENT
    importing
      value(I_OBJECT) type ref to OBJECT
    exporting
      value(ET_SEL_OBJECT) type ISH_T_SEL_OBJECT
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_OBJECT_FOR_IMPOBJ
    importing
      value(I_IMPOBJ) type ref to OBJECT
    exporting
      value(ET_SEL_OBJECT) type ISH_T_SEL_OBJECT
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_WP_ISH_OBJECT
    importing
      value(I_SEL_ATTRIBUTE) type ISH_SEL_OBJECT-ATTRIBUTE default '*'
      value(I_SET_EXTERN_VALUES) type ISH_ON_OFF default SPACE
      value(I_INSTITUTION) type EINRI
      value(I_VIEW_ID) type NWVIEW-VIEWID
      value(I_VIEW_TYPE) type NWVIEW-VIEWTYPE
      !IT_OBJECT type ISH_T_SEL_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ET_ISH_OBJECT type ISH_T_DRAG_DROP_DATA
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods NODE_OPENCLOSE_ALL
    importing
      value(I_NODE_ATTRIBUTE) type ISH_ON_OFF default '*'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_FUNCTION_CODE
    importing
      value(I_UCOMM) type SY-UCOMM .
  methods SET_VIEW_DATA
    importing
      value(I_VIEWID) type NWVIEW-VIEWID
      value(I_PLACEID) type NWPLACE-WPLACEID .
protected section.
*"* protected components of class CL_ISH_VIEW
*"* do not include other source files here!!!

  aliases GT_FIELDCAT
    for IF_ISH_LIST_DISPLAY~GT_FIELDCAT .
  aliases GT_FILTER
    for IF_ISH_LIST_DISPLAY~GT_FILTER .
  aliases GT_SEL_CRIT
    for IF_ISH_LIST_DISPLAY~GT_SEL_CRIT .
  aliases GT_SORT
    for IF_ISH_LIST_DISPLAY~GT_SORT .
  aliases G_CONSTRUCT
    for IF_ISH_LIST_DISPLAY~G_CONSTRUCT .
  aliases G_CONTAINER
    for IF_ISH_LIST_DISPLAY~G_CONTAINER .
  aliases G_LAYOUT
    for IF_ISH_LIST_DISPLAY~G_LAYOUT .
  aliases G_TOOLBAR
    for IF_ISH_LIST_DISPLAY~G_TOOLBAR .
  aliases BUILD_FIELDCAT
    for IF_ISH_LIST_DISPLAY~BUILD_FIELDCAT .
  aliases INITIALIZE
    for IF_ISH_LIST_DISPLAY~INITIALIZE .
  aliases SET_LAYOUT
    for IF_ISH_LIST_DISPLAY~SET_LAYOUT .

  data GT_EXCEPT_QINFO type LVC_T_QINF .
  data GT_SORT_OBJECT type ISHMED_T_SORT_OBJECT .
  data G_DUMMY_CONTAINER type ref to CL_GUI_CUSTOM_CONTAINER .
  data G_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  data G_SORT type N1SORTNO .

  methods ADD_DATA_TO_DRAG_DROP_CONT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional
      value(C_DRAGDROPOBJ) type ref to CL_ISH_DISPLAY_DRAG_DROP_CONT optional .
  methods CALL_BADI_VIEW_TITLE
    importing
      !IT_OUTTAB type ANY .
  methods EXCL_TOOLBAR
    exporting
      !ET_TOOLBAR_EXCL type UI_FUNCTIONS .
  methods GET_ROWID_FOR_OBJECT
    importing
      value(IT_OBJECT) type ISH_OBJECTLIST optional
    exporting
      value(ET_INDEX_ROWS) type LVC_T_ROW
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_GRID_AFTER_USER_COMMAND
    for event AFTER_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !E_NOT_PROCESSED
      !SENDER .
  methods HANDLE_GRID_BEFORE_USER_COMM
    for event BEFORE_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !SENDER .
  methods HANDLE_GRID_CONTEXT_MENU
    for event CONTEXT_MENU_REQUEST of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !SENDER .
  methods HANDLE_GRID_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !SENDER .
  methods HANDLE_GRID_HOTSPOT_CLICK
    for event HOTSPOT_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW_ID
      !E_COLUMN_ID
      !ES_ROW_NO
      !SENDER .
  methods HANDLE_GRID_MENU_BUTTON
    for event MENU_BUTTON of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_UCOMM
      !SENDER .
  methods HANDLE_GRID_ONDRAG
    for event ONDRAG of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !E_DRAGDROPOBJ
      !SENDER .
  methods HANDLE_GRID_ONDROP
    for event ONDROP of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !E_DRAGDROPOBJ
      !SENDER .
  methods HANDLE_GRID_TOOLBAR
    for event TOOLBAR of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_INTERACTIVE
      !SENDER .
  methods HANDLE_GRID_USER_COMMAND
    for event USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !SENDER .
  methods NODE_OPENCLOSE
    importing
      value(I_NODE_ATTRIBUTE) type ISH_ON_OFF default '*'
      value(I_OUTTAB) type RN1DISPLAY_FIELDS
      value(I_FIELDNAME) type LVC_FNAME
      value(IT_FIELDCAT) type LVC_T_FCAT
    exporting
      value(ET_OUTTAB) type ISHMED_T_DISPLAY_FIELDS
      value(E_REFRESH) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods READ_OUTTAB_LINE
    importing
      value(I_INDEX) type LVC_INDEX optional
      value(IT_INDEX_ROWS) type LVC_T_ROW optional
    exporting
      value(E_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      value(ET_OUTTAB_LINES) type ISHMED_T_DISPLAY_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REGISTER_EVENTS .
  methods SET_SEL_CRITERIA
    importing
      !IT_SEL_CRITERIA type ISHMED_T_RSPARAMS optional .
  methods SET_VIEW_LAYOUT .
  methods SORT
    importing
      value(I_SORT) type N1SORTNO optional
      value(IT_SORT_OBJECT) type ISHMED_T_SORT_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_VIEW IMPLEMENTATION.


METHOD add_data_to_drag_drop_cont .                         "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD call_badi_view_title .

  CHECK NOT g_view_type IS INITIAL.

* change view title (user-defined with a BADI)
  CALL FUNCTION 'ISH_BADI_WP_VIEW_TITLE'
    EXPORTING
      i_view_type    = g_view_type
      it_sel_crit    = gt_sel_crit
      it_view_list_1 = it_outtab
*      it_ish_objects =
    CHANGING
      i_title        = g_layout-grid_title.

ENDMETHOD.


METHOD EXCL_TOOLBAR .

  CLASS cl_gui_alv_grid DEFINITION LOAD.

  REFRESH et_toolbar_excl.

* exclude all standard functions from toolbar
  APPEND cl_gui_alv_grid=>mc_mb_export           TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_detail           TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_sum              TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_mb_sum              TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_info             TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_subtot           TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_separator        TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_sort_asc         TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_sort_dsc         TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_filter           TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_find             TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_col_invisible    TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_col_optimize     TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_fix_columns      TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_unfix_columns    TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_print            TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_maintain_variant TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_current_variant  TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_load_variant     TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_save_variant     TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_graph            TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_views            TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_print_back       TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_print_prev       TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_loc_cut          TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_loc_copy         TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_loc_paste        TO et_toolbar_excl.

ENDMETHOD.


METHOD get_frontend_layout .

  CLEAR e_layout.
  REFRESH: et_fieldcat, et_sort, et_filter.

* get layout of ALV grid
  IF NOT g_grid IS INITIAL.
    CALL METHOD g_grid->get_frontend_layout
      IMPORTING
        es_layout = e_layout.

    IF e_layout-cwidth_opt = '1'.                           "ID 18790
      e_layout-cwidth_opt = 'X'.                            "ID 18790
    ENDIF.                                                  "ID 18790

    CALL METHOD g_grid->get_frontend_fieldcatalog
      IMPORTING
        et_fieldcatalog = et_fieldcat.
    CALL METHOD g_grid->get_sort_criteria
      IMPORTING
        et_sort = et_sort.
    CALL METHOD g_grid->get_filter_criteria
      IMPORTING
        et_filter = et_filter.
  ENDIF.

* get layout of ALV tree
  IF NOT g_tree IS INITIAL.
    CALL METHOD g_tree->get_frontend_fieldcatalog
      IMPORTING
        et_fieldcatalog = et_fieldcat.
  ENDIF.

*  CALL METHOD cl_gui_cfw=>flush.                      " REM ID 18724

ENDMETHOD.


METHOD get_object_for_ident.                 "#EC NEEDED

* to be implemented in subclasses.

* (Realisierung muss in den Subklassen erfolgen, da dort die
* Ausgabetabelle bekannt ist)

ENDMETHOD.


METHOD get_object_for_impobj .                              "#EC NEEDED

* to be implemented in subclasses.

* (Realisierung muss in den Subklassen erfolgen, da dort die
* Ausgabetabelle bekannt ist)

ENDMETHOD.


METHOD get_rowid_for_object .                               "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD get_wp_ish_object .

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
  CALL METHOD cl_ish_display_tools=>get_wp_ish_object
    EXPORTING
      i_sel_attribute     = i_sel_attribute
      i_set_extern_values = i_set_extern_values
      i_institution       = i_institution
      i_view_id           = i_view_id
      i_view_type         = i_view_type
      it_object           = it_object
    IMPORTING
      e_rc                = e_rc
      et_ish_object       = et_ish_object
    CHANGING
      c_errorhandler      = c_errorhandler.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_after_user_command .

* raise event
  RAISE EVENT after_user_command
    EXPORTING
      i_ucomm = e_ucomm.

ENDMETHOD.


METHOD handle_grid_before_user_comm .

* raise event
  RAISE EVENT before_user_command
    EXPORTING
      i_ucomm = e_ucomm.

ENDMETHOD.


METHOD handle_grid_context_menu .

* add context menu functions
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_current_variant
      text  = text-001.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_col_invisible
      text  = text-002.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_fix_columns
      text  = text-006.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_unfix_columns
      text  = text-007.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_col_optimize
      text  = text-003.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_find
      text  = text-004.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_filter
      text  = text-005.

* raise event
  RAISE EVENT context_menu
    EXPORTING
      i_object = e_object.

ENDMETHOD.


METHOD handle_grid_double_click .

* Lokale Tabelle
  DATA: lt_outtab        TYPE ishmed_t_display_fields,
        lt_sel_object    TYPE ish_t_sel_object.
* Workareas
  DATA: l_outtab         LIKE LINE OF lt_outtab.
* Hilfsfelder und -strukturen
  DATA: l_rc             TYPE ish_method_rc,
        l_fieldname      TYPE lvc_fname,
        l_ucomm          TYPE sy-ucomm.

* ---------- ---------- ----------
* Zeile der Ausgabetabelle ermitteln
  CALL METHOD me->read_outtab_line
    EXPORTING
      i_index       = e_row-index
    IMPORTING
      e_outtab_line = l_outtab
      e_rc          = l_rc.
  CHECK l_rc = 0.
  CLEAR: lt_outtab[].
  INSERT l_outtab INTO TABLE lt_outtab.
* ---------- ---------- ----------
  l_fieldname = e_column-fieldname.
* ---------- ---------- ----------
* Ereignis bevor Benutzeraktion
  l_ucomm = l_fieldname.
  RAISE EVENT before_user_command
    EXPORTING
      i_ucomm = l_ucomm.
* ---------- ---------- ----------
* Ermittlung der ausgewählten Objekte
  CLEAR: lt_sel_object[].
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls        = me
      i_sel_attribute = '*'
      i_fieldname     = l_fieldname
      it_outtab       = lt_outtab
    IMPORTING
      et_sel_object   = lt_sel_object.
* ---------- ---------- ----------
  RAISE EVENT double_click
    EXPORTING
      i_fieldname = l_fieldname
      it_object   = lt_sel_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_hotspot_click .

* Lokale Tabelle
  DATA: lt_outtab        TYPE ishmed_t_display_fields,
        lt_sel_object    TYPE ish_t_sel_object.
* Workareas
  DATA: l_outtab         LIKE LINE OF lt_outtab.
* Hilfsfelder und -strukturen
  DATA: l_rc             TYPE ish_method_rc,
        l_refresh        TYPE ish_on_off,
        l_fieldname      TYPE lvc_fname,
        l_ucomm          TYPE sy-ucomm.
* Objekte
  DATA: l_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
* ---------- ---------- ----------
  CREATE OBJECT l_errorhandler.
  CLEAR: l_refresh.
* ---------- ---------- ----------
* Zeile der Ausgabetabelle ermitteln
  CALL METHOD me->read_outtab_line
    EXPORTING
      i_index       = e_row_id-index
    IMPORTING
      e_outtab_line = l_outtab
      e_rc          = l_rc.
  CHECK l_rc = 0.
  CLEAR: lt_outtab[].
  INSERT l_outtab INTO TABLE lt_outtab.
* ---------- ---------- ----------
  l_fieldname = e_column_id.
* ---------- ---------- ----------
* Ereignis bevor Benutzeraktion
  l_ucomm = l_fieldname.
  RAISE EVENT before_user_command
    EXPORTING
      i_ucomm = l_ucomm.
* ---------- ---------- ----------
* Ermittlung der ausgewählten Objekte
  CLEAR: lt_sel_object[].
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls        = me
      i_sel_attribute = '*'
      i_fieldname     = l_fieldname
      it_outtab       = lt_outtab
    IMPORTING
      et_sel_object   = lt_sel_object.
* ---------- ---------- ----------
* Knoten öffnen/schließen
  IF l_fieldname = 'OPENCLOSE'.
    CALL METHOD me->node_openclose
      EXPORTING
        i_outtab       = l_outtab
        i_fieldname    = l_fieldname
        it_fieldcat    = gt_fieldcat
      IMPORTING
        et_outtab      = lt_outtab
        e_refresh      = l_refresh
        e_rc           = l_rc
      CHANGING
        c_errorhandler = l_errorhandler.
    IF l_rc <> 0.
      EXIT.
    ENDIF.
*   ---------- ----------
*   Aktualisierung der Anzeige durchführen
    IF l_refresh = on.
      CALL METHOD me->refresh.
    ENDIF.
  ELSE.
*   Ereignis HOTSPOT CLICK
    RAISE EVENT hotspot_click
      EXPORTING
        i_fieldname = l_fieldname
        it_object   = lt_sel_object.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_menu_button .

  DATA: lt_toolbar      TYPE TABLE OF v_nwbutton,
        l_toolbar       TYPE v_nwbutton,
        lt_menu_button  TYPE TABLE OF v_nwfvarp,
        l_menu_button   TYPE v_nwfvarp,
        l_fcode         TYPE ui_func,
        l_text          TYPE gui_text,
        l_repid         TYPE sy-repid.

  l_repid = sy-repid.

* get the functions of view
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_placeid     = g_wplace_id
      i_viewid      = g_view_id
      i_viewtype    = g_view_type
      i_caller      = l_repid
    TABLES
      t_fvar_button = lt_toolbar
      t_fvar_futxt  = lt_menu_button.

* in viewtype OP some functions should not be displayed sometimes
  IF g_view_type = '011'.
    CALL FUNCTION 'ISHMED_VP_FVAR_011'
      TABLES
        t_fvar_button = lt_toolbar
        t_fvar_futxt  = lt_menu_button.
  ENDIF.

* set the menu of the button e_ucomm with the user defined functions
  SORT lt_menu_button BY lfdnr.
  LOOP AT lt_toolbar INTO l_toolbar WHERE fcode EQ e_ucomm.
    LOOP AT lt_menu_button INTO  l_menu_button
                           WHERE fvar     EQ l_toolbar-fvar
                           AND   buttonnr EQ l_toolbar-buttonnr.
      IF l_menu_button-fcode   IS INITIAL AND
         l_menu_button-tb_butt IS INITIAL.
        CALL METHOD e_object->add_separator.
      ELSE.
        l_fcode = l_menu_button-fcode.
        l_text  = l_menu_button-txt.
        CALL METHOD e_object->add_function
          EXPORTING
            fcode = l_fcode
            text  = l_text.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD handle_grid_ondrag .

* Lokale Tabellen
  DATA: lt_outtab_complete   TYPE ishmed_t_display_fields,
        lt_sel_object        TYPE ish_t_sel_object,
        lt_index_rows        TYPE lvc_t_row,
        lt_cells             TYPE lvc_t_cell.
* Workareas
  DATA: l_cell               LIKE LINE OF lt_cells.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc,
        l_fieldname          TYPE lvc_fname.
* Objekt-Instanzen
  DATA: l_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        l_drag_object        TYPE REF TO cl_ish_display_drag_drop_cont.
* ---------- ---------- ----------
* Initialisierung
  l_rc = 0.
  CREATE OBJECT l_errorhandler.
* Obejekt für Drag & Drop instanzieren.
  CREATE OBJECT l_drag_object.
* ---------- ---------- ----------
  l_fieldname = e_column-fieldname.
* ---------- ---------- ----------
* Ermittlung der ausgewählte(n) Zeile(n).
* Bei DD kann dzt. immer nur eine gesamte Zeile gewählt werden.
  CLEAR: lt_index_rows[].
  CALL METHOD g_grid->get_selected_rows
    IMPORTING
      et_index_rows = lt_index_rows.
  IF lt_index_rows[] IS INITIAL.
*   Konnte keine Zeile ermittelt werden Ermittlung der ausgewählten
*   Zelle und daraus die Zeile bestimmen.
    CALL METHOD g_grid->get_selected_cells
      IMPORTING
        et_cell = lt_cells.
*   Bestimmtung der Zeilen.
    CLEAR: lt_index_rows[].
    LOOP AT lt_cells INTO l_cell.
      INSERT l_cell-row_id INTO TABLE lt_index_rows.
    ENDLOOP.
*   Markierung der Zeilen setzen (damit Auswahl transparenter wird).
    CALL METHOD g_grid->set_selected_rows
      EXPORTING
        it_index_rows = lt_index_rows.
  ENDIF.
* ---------- ---------- ----------
* Einträge der Ausgabetabelle ermitteln.
  CALL METHOD me->read_outtab_line
    EXPORTING
      it_index_rows   = lt_index_rows
    IMPORTING
      et_outtab_lines = lt_outtab_complete
      e_rc            = l_rc
    CHANGING
      c_errorhandler  = l_errorhandler.
  IF l_rc <> 0.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Jene ausgewähten Einträge aus der Tabelle entfernen,
* die nicht gedragt werden dürfen.
  DELETE lt_outtab_complete WHERE dragable = off.
* Bleibt kein Eintrag übrig Drag&Drop abbrechen.
  IF lt_outtab_complete[] IS INITIAL.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Ausgewählte Objekte ermitteln.
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls      = me
      it_outtab     = lt_outtab_complete
    IMPORTING
      et_sel_object = lt_sel_object.
* ---------- ---------- ----------
  l_drag_object->gt_sel_object[]  = lt_sel_object[].
  CALL METHOD me->add_data_to_drag_drop_cont
    IMPORTING
      e_rc           = l_rc
    CHANGING
      c_errorhandler = l_errorhandler
      c_dragdropobj  = l_drag_object.
  IF l_rc <> 0.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* Object zuweisen
  e_dragdropobj->object = l_drag_object.
* ---------- ---------- ----------
* Ereignis auslösen
  RAISE EVENT ondrag
    EXPORTING
      e_fieldname     = l_fieldname
      e_drag_drop_obj = l_drag_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_ondrop .

* Lokale Tabellen
  DATA: lt_outtab_complete   TYPE ishmed_t_display_fields,
        lt_sel_object        TYPE ish_t_sel_object.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc,
        l_fieldname          TYPE lvc_fname.
*        l_obj_type           TYPE i.       "REM MED-9409
* Objekt-Instanzen
  DATA: l_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        l_drag_object        TYPE REF TO cl_ish_display_drag_drop_cont,
        lr_object            TYPE REF TO if_ish_identify_object.
* ---------- ---------- ----------
* Initialisierung
  l_rc = 0.
  CREATE OBJECT l_errorhandler
     EXPORTING
        i_control = on.
* ---------- ---------- ----------
  l_fieldname = e_column-fieldname.
* ---------- ---------- ----------
* Einträge der Ausgabetabelle ermitteln.
  CALL METHOD me->read_outtab_line
    EXPORTING
      i_index         = e_row-index
    IMPORTING
      et_outtab_lines = lt_outtab_complete
      e_rc            = l_rc
    CHANGING
      c_errorhandler  = l_errorhandler.
  IF l_rc <> 0.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Prüfen ob drop möglich ist.
  DELETE lt_outtab_complete WHERE dropable = off.
  IF lt_outtab_complete[] IS INITIAL.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Prüfen, welche Art von Objekt gedragged wurde
  REFRESH lt_sel_object.
*-------- BEGIN C.Honeder MED-9409
  TRY.
    lr_object ?= e_dragdropobj->object.
    IF lr_object->is_inherited_from( cl_ish_display_drag_drop_cont=>co_otype_dd_obj_display ) = on.
*     Drag innerhalb des Klinischen Arbeitsplatzes
      l_drag_object   ?= lr_object.
    ELSE.
*     Drag kommt von außerhalb des Klin. Arbeitsplatzes
      CREATE OBJECT l_drag_object.
      l_drag_object->gr_dd_cont_variable ?= lr_object.
    ENDIF.
  CATCH cx_sy_move_cast_error.    "#EC NO_HANDLER
  ENDTRY.

*    lr_object ?= e_dragdropobj->object.
*  CALL METHOD lr_object->('GET_TYPE')
*    IMPORTING
*      e_object_type = l_obj_type.
*  CASE l_obj_type.
*    WHEN cl_ish_display_drag_drop_cont=>co_otype_dd_obj_display.
**     Drag innerhalb des Klinischen Arbeitsplatzes
*      l_drag_object   ?= lr_object.
*    WHEN OTHERS.
**     Drag kommt von außerhalb des Klin. Arbeitsplatzes
*      CREATE OBJECT l_drag_object.
*      l_drag_object->gr_dd_cont_variable ?= lr_object.
*  ENDCASE.
* ---------- ---------- ----------
*-------- END C.Honeder MED-9409


* Ausgewählte Objekte ermitteln.
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls      = me
      it_outtab     = lt_outtab_complete
    IMPORTING
      et_sel_object = lt_sel_object.
* ---------- ---------- ----------
  l_drag_object->gt_sel_object[]  = lt_sel_object[].
* ---------- ---------- ----------
* Ereignis auslösen
* ---------- ---------- ----------
  RAISE EVENT ondrop
    EXPORTING
      e_fieldname     = l_fieldname
      e_drag_drop_obj = l_drag_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_toolbar .

  DATA: lt_toolbar         TYPE TABLE OF v_nwbutton,
        l_toolbar          TYPE v_nwbutton,
        lt_menu_button     TYPE TABLE OF v_nwfvarp,
        l_menu_button      TYPE v_nwfvarp,              "#EC NEEDED
        l_repid            TYPE sy-repid,
        l_alv_toolbar      TYPE stb_button,
        lt_toolbar_button  TYPE ttb_button,
        l_toolbar_button   LIKE LINE OF lt_toolbar_button,
        l_index            TYPE sy-tabix.

  l_repid = sy-repid.

* get functions for view
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_placeid     = g_wplace_id
      i_viewid      = g_view_id
      i_viewtype    = g_view_type
      i_caller      = l_repid
    TABLES
      t_fvar_button = lt_toolbar
      t_fvar_futxt  = lt_menu_button.

* in viewtype OP some functions should not be displayed sometimes
  IF g_view_type = '011'.
    CALL FUNCTION 'ISHMED_VP_FVAR_011'
      TABLES
        t_fvar_button = lt_toolbar
        t_fvar_futxt  = lt_menu_button.
  ENDIF.

* append a separator to normal toolbar
  CLEAR l_alv_toolbar.
  MOVE 3 TO l_alv_toolbar-butn_type.
  APPEND l_alv_toolbar TO e_object->mt_toolbar.
* set the toolbar with user defined buttons
  SORT lt_toolbar BY buttonnr.
  SORT lt_menu_button BY lfdnr.
  LOOP AT lt_toolbar INTO l_toolbar.
    CLEAR l_alv_toolbar.
    IF l_toolbar-fcode EQ space.
      MOVE 3 TO l_alv_toolbar-butn_type.   "separator
    ELSE.
      MOVE 0 TO l_alv_toolbar-butn_type.   "button
*      IF l_toolbar-fcode EQ 'DVIEW'.       "show a secondarily view
*        MOVE 2 TO l_alv_toolbar-butn_type. "menu button
*      ENDIF.
    ENDIF.
    l_alv_toolbar-function = l_toolbar-fcode.
    IF l_toolbar-icon NE space.
      l_alv_toolbar-icon      = l_toolbar-icon.
      l_alv_toolbar-quickinfo = l_toolbar-icon_q.
    ELSE.
      l_alv_toolbar-icon      = icon_space.
    ENDIF.
    l_alv_toolbar-text = l_toolbar-buttontxt.
    l_alv_toolbar-disabled = ' '.
*   set the type of the menu button
    LOOP AT lt_menu_button INTO l_menu_button
                          WHERE fvar     EQ l_toolbar-fvar
                          AND   buttonnr EQ l_toolbar-buttonnr
                          AND   tb_butt  EQ '01'.
      MOVE 2 TO l_alv_toolbar-butn_type.    "menu button
      IF l_alv_toolbar-function NE space.
        MOVE 1 TO l_alv_toolbar-butn_type.  "menu button + default
      ENDIF.
    ENDLOOP.
    APPEND l_alv_toolbar TO e_object->mt_toolbar.
  ENDLOOP.

* ---------- ---------- -----------
* Ermittlung der Funktionen, welche der Aufrufer eingetragen hat.
  IF NOT g_toolbar IS INITIAL.
    lt_toolbar_button = g_toolbar->m_table_button.
  ENDIF.
* ---------- ---------- -----------
  LOOP AT lt_toolbar_button INTO l_toolbar_button.
    READ TABLE e_object->mt_toolbar INTO l_alv_toolbar
       WITH KEY function = l_toolbar_button-function.
    IF sy-subrc = 0.
      l_index = sy-tabix.
      l_alv_toolbar-icon      = l_toolbar_button-icon.
      l_alv_toolbar-quickinfo = l_toolbar_button-quickinfo.
      l_alv_toolbar-butn_type = l_toolbar_button-butn_type.
      l_alv_toolbar-text      = l_toolbar_button-text.
      l_alv_toolbar-checked   = l_toolbar_button-checked.
      MODIFY e_object->mt_toolbar FROM l_alv_toolbar
         INDEX l_index.
    ELSE.
      l_alv_toolbar-function  = l_toolbar_button-function.
      l_alv_toolbar-icon      = l_toolbar_button-icon.
      l_alv_toolbar-quickinfo = l_toolbar_button-quickinfo.
      l_alv_toolbar-butn_type = l_toolbar_button-butn_type.
      l_alv_toolbar-text      = l_toolbar_button-text.
      l_alv_toolbar-checked   = l_toolbar_button-checked.
      INSERT l_alv_toolbar INTO TABLE e_object->mt_toolbar.
    ENDIF.
  ENDLOOP.
* ---------- ---------- -----------

ENDMETHOD.


METHOD handle_grid_user_command .

  DATA: l_fcode           TYPE n1fcode,
        lt_sel_object     TYPE ish_t_sel_object,
        l_rc              TYPE ish_method_rc,             "#EC NEEDED
        l_errorhandler    TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT g_grid IS INITIAL.

  CREATE OBJECT l_errorhandler.

* Markierte Einträge holen
  CALL METHOD me->get_selection
    EXPORTING
      i_sel_attribute = '*'
    IMPORTING
      et_object       = lt_sel_object
      e_rc            = l_rc
    CHANGING
      c_errorhandler  = l_errorhandler.

* Ereigniss auslösen
  l_fcode = e_ucomm.
  RAISE EVENT user_command
    EXPORTING
      i_fcode        = l_fcode
      it_object      = lt_sel_object.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .                    "#EC NEEDED

  e_object_type = co_otype_view.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.                         "#EC NEEDED

  IF i_object_type = co_otype_view.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.            "#EC NEEDED

  IF i_object_type = co_otype_view.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_list_display~build_fieldcat .                 "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD if_ish_list_display~check_if_empty .                 "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


method IF_ISH_LIST_DISPLAY~DESTROY .

  DATA: l_is_valid       TYPE i.

* free ALV grid
  IF NOT g_grid IS INITIAL.
    CALL METHOD g_grid->is_valid
      IMPORTING
        RESULT = l_is_valid.
    IF l_is_valid EQ 1.
      CALL METHOD g_grid->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2.
      IF sy-subrc <> 0.
        MESSAGE a700(n4) WITH 'FREE_GRID' sy-subrc.
      ENDIF.
    ENDIF.
    CLEAR g_grid.
  ENDIF.

* free ALV tree
  IF NOT g_tree IS INITIAL.
    CALL METHOD g_tree->is_valid
      IMPORTING
        RESULT = l_is_valid.
    IF l_is_valid EQ 1.
      CALL METHOD g_tree->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2.
      IF sy-subrc <> 0.
        MESSAGE s700(n4) WITH 'FREE_TREE' sy-subrc.
      ENDIF.
    ENDIF.
    CLEAR g_tree.
  ENDIF.

* refresh some internal tables
  REFRESH: gt_fieldcat, gt_sel_crit.

endmethod.


METHOD if_ish_list_display~display.                         "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD if_ish_list_display~get_data .                       "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD if_ish_list_display~get_selection .

  DATA: lt_list_row_ids    TYPE lvc_t_row,
        l_list_row_id      LIKE LINE OF lt_list_row_ids,
        ls_row_id          TYPE lvc_s_row,
        lt_outtab          TYPE ishmed_t_display_fields,
        l_outtab           LIKE LINE OF lt_outtab,
        l_rc               TYPE ish_method_rc.

  REFRESH: et_object, lt_list_row_ids, lt_outtab.

  CLEAR e_rc.

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  IF NOT g_grid IS INITIAL.
    IF i_sel_type IS INITIAL OR i_sel_type = '*'.
*     get marked rows from ALV grid
      CALL METHOD g_grid->get_selected_rows
        IMPORTING
          et_index_rows = lt_list_row_ids.
    ENDIF.
    IF i_sel_type = 'Z' OR i_sel_type = '*'.
*     get marked cell from ALV grid
      CLEAR: ls_row_id, l_list_row_id.
      CALL METHOD g_grid->get_current_cell
        IMPORTING
          es_row_id = ls_row_id.
      l_list_row_id = ls_row_id.
      APPEND l_list_row_id TO lt_list_row_ids.
    ENDIF.
    DESCRIBE TABLE lt_list_row_ids.
    IF sy-tfill > 0.
*     set return data for each selected line
      LOOP AT lt_list_row_ids INTO l_list_row_id.
        CALL METHOD me->read_outtab_line
          EXPORTING
            i_index        = l_list_row_id-index
          IMPORTING
            e_outtab_line  = l_outtab
            e_rc           = l_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc = 0.
          INSERT l_outtab INTO TABLE lt_outtab.
        ELSE.
          e_rc = l_rc.
          EXIT.
        ENDIF.
      ENDLOOP.
*     ---------- ---------- ----------
*     Ausgewählte Objekte ermitteln.
      CALL METHOD cl_ish_display_tools=>get_sel_object
        EXPORTING
          i_dspcls        = me
          i_sel_attribute = i_sel_attribute
          it_outtab       = lt_outtab
        IMPORTING
          et_sel_object   = et_object.
    ENDIF.
  ENDIF.

ENDMETHOD.


method IF_ISH_LIST_DISPLAY~GET_TOOLBAR .

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: e_toolbar.
* ---------- ---------- ----------
  IF NOT g_toolbar IS INITIAL.
*   Weitere Verarbeitung nicht mehr nötig, Toolbar
*   bereits vorhanden.
    e_toolbar = g_toolbar.
    EXIT.
  ENDIF.
  CHECK g_toolbar IS INITIAL.
* ---------- ---------- ----------
* Dummy-Container instanzieren - falls nötig.
  IF g_dummy_container IS INITIAL.
    CREATE OBJECT g_dummy_container
      EXPORTING
        container_name              = 'DUMMY'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* Falls nötig Toolbar instanzieren.
  CREATE OBJECT g_toolbar
    EXPORTING
      parent             = g_dummy_container
    EXCEPTIONS
      cntl_install_error = 1
      cntl_error         = 2
      cntb_wrong_version = 3
      OTHERS             = 4.
  IF sy-subrc = 0.
    e_toolbar = g_toolbar.
  ELSE.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

endmethod.


METHOD if_ish_list_display~initialize .

  CLEAR: g_container,
         g_grid,
         g_tree,
         g_toolbar,
         g_construct,
         g_institution,
         g_view_id,
         g_view_type,
         g_wplace_id,
         g_dragdrop,
         g_nodes_open,
         g_layout.

  REFRESH: gt_fieldcat,
           gt_sort,
           gt_filter,
           gt_nodes_open,
           gt_except_qinfo.

ENDMETHOD.


METHOD if_ish_list_display~insert_data.                     "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD if_ish_list_display~refresh .                        "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD if_ish_list_display~refresh_data .                   "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD if_ish_list_display~remove_data.                     "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD if_ish_list_display~set_layout .                     "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


method IF_ISH_LIST_DISPLAY~SET_SCROLL_POSITION .

* Lokale Tabellen
  DATA: lt_index_rows        TYPE lvc_t_row.
* Workareas
  DATA: l_index_row          LIKE LINE OF lt_index_rows.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc,
*        l_page_row_info      TYPE lvc_s_row,
        l_page_col_info      TYPE lvc_s_col.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Zeilenindex für übergebene (erzeugende) Objekte ermitteln.
  CALL METHOD me->get_rowid_for_object
    EXPORTING
      it_object      = it_object
    IMPORTING
      et_index_rows  = lt_index_rows
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  CHECK NOT lt_index_rows[] IS INITIAL.
* ---------- ---------- ----------
  IF NOT g_grid IS INITIAL.
*   Ermittlung der "aktuellen" Zelle (Cursor-Pos.)
    CALL METHOD g_grid->get_current_cell
      IMPORTING
        es_col_id = l_page_col_info.
**   Aktuelle Scroll-Information bestimmen.
*    CALL METHOD g_grid->get_scroll_info_via_id         " REM ID 18724
*      IMPORTING
**        es_row_info = l_page_row_info
*        es_col_info = l_page_col_info.
**   Flush durchführen; damit Informationen auch
**   tatsächlich zur Verfügung stehen.
*    CALL METHOD cl_gui_cfw=>flush.                     " REM ID 18724
*   ---------- ----------
*   Positionierung auf ersten Eintrag vornehmen
    SORT lt_index_rows BY index ASCENDING.
    READ TABLE lt_index_rows INTO l_index_row
       INDEX 1.
*   Durch Methode "set_scroll_info_via_id" wird der
*   entsprechende Eintrag an erster Position angzeigt.
*   Dies soll verhindert werden da somit die Anzeige
*   nicht stabil bleibt (es gibt leider keine
*   Möglichkeit um zu entscheiden ob die entsprechende
*   Zeile "sichtbar" ist oder nicht).
*    CALL METHOD g_grid->set_scroll_info_via_id
*      EXPORTING
*        is_row_info = l_index_row
*        is_col_info = l_page_col_info.
*     Cursor in die zuvor ausgewählte Zelle positionieren
*   Durch Methode "set_current_cell_via_id" wird der
*   Cursor in die angegebene Zeile + Spalte positioniert.
*   Vorteil: falls angegebene Zeile nicht sichtbar wird
*   automatisch gescrollt
    CALL METHOD g_grid->set_current_cell_via_id
      EXPORTING
        is_row_id    = l_index_row
        is_column_id = l_page_col_info.
  ENDIF.
* ---------- ---------- ----------

endmethod.


method IF_ISH_LIST_DISPLAY~SET_SELECTION .

* Lokale Tabellen
  DATA: lt_index_rows        TYPE lvc_t_row.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Zeilenindex für übergebene (erzeugende) Objekte ermitteln.
  CALL METHOD me->get_rowid_for_object
    EXPORTING
      it_object      = it_object
    IMPORTING
      et_index_rows  = lt_index_rows
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Zeilen markieren.
  IF NOT g_grid IS INITIAL.
    CALL METHOD g_grid->set_selected_rows
      EXPORTING
        it_index_rows = lt_index_rows.
  ENDIF.
* ---------- ---------- ----------

endmethod.


method IF_ISH_LIST_DISPLAY~SET_SORT_CRITERIA .

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
  IF i_sort = co_sort_individual.
    gt_sort_object = it_sort_object.
  ENDIF.
  g_sort = i_sort.
* ---------- ---------- ----------

endmethod.


METHOD node_openclose .

  DATA: l_openclose              TYPE ish_on_off,
        ls_nodes_open            LIKE LINE OF gt_nodes_open.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_outtab[], e_refresh, l_openclose.
* ---------- ---------- ----------
  IF i_outtab-dspobj IS INITIAL.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Derzeit gibt es pro Anzeigeklasse nur einen Knoten zu öffnen
* bzw. zu schliessen.
* Trotzdem Feldnamen angeben um in Zukunft flexibler zu sein.
  CHECK i_fieldname = 'OPENCLOSE'.
* ---------- ---------- ----------
  e_refresh = on.
* ---------- ---------- ----------
* i_node_attribute = 'X'
* => Knoten öffnen
  IF i_node_attribute = on.
    CALL METHOD i_outtab-dspobj->('SET_NODE')
      EXPORTING
        i_node_open = 'X'.
    l_openclose = 'X'.
* i_node_attribute = ' '
* => Knoten schließen
  ELSEIF i_node_attribute = off.
    CALL METHOD i_outtab-dspobj->('SET_NODE')
      EXPORTING
        i_node_open = ' '.
    l_openclose = ' '.
* i_node_attribute = '*'
* => Knoten schließen wenn geöffnet
*    Knoten öffnen wenn geschlossen
  ELSE.
    IF i_outtab-openclose = icon_closed_folder.
*     Knoten öffnen
      CALL METHOD i_outtab-dspobj->('SET_NODE')
        EXPORTING
          i_node_open = 'X'.
      l_openclose = 'X'.
    ELSEIF i_outtab-openclose = icon_open_folder.
*     Knoten schließen
      CALL METHOD i_outtab-dspobj->('SET_NODE')
        EXPORTING
          i_node_open = ' '.
      l_openclose = ' '.
    ELSE.
      e_refresh = off.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

* MED-30311: remember state of node
  READ TABLE gt_nodes_open INTO ls_nodes_open WITH KEY keyno = i_outtab-keyno.
  IF sy-subrc = 0.
    ls_nodes_open-openclose = l_openclose.
    MODIFY gt_nodes_open FROM ls_nodes_open INDEX sy-tabix.
  ELSE.
    CLEAR ls_nodes_open.
    ls_nodes_open-keyno     = i_outtab-keyno.
    ls_nodes_open-openclose = l_openclose.
    APPEND ls_nodes_open TO gt_nodes_open.
  ENDIF.

ENDMETHOD.


METHOD node_openclose_all .                                 "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD read_outtab_line .                                   "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.


METHOD register_events .

  IF NOT g_grid IS INITIAL.
*   --- --- --- --- --- --- --- ---
*   Toolbar
    SET HANDLER me->handle_grid_toolbar FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Toolbar Menü Button
    SET HANDLER me->handle_grid_menu_button FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Vor einer Benutzeraktion
    SET HANDLER me->handle_grid_before_user_comm FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Benutzeraktion
    SET HANDLER me->handle_grid_user_command FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Nach einer Benutzeraktion
    SET HANDLER me->handle_grid_after_user_command FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Doppelklick
    SET HANDLER me->handle_grid_double_click FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Hotspot
    SET HANDLER me->handle_grid_hotspot_click FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Kontextmenü
    SET HANDLER me->handle_grid_context_menu FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Drag&Drop
    SET HANDLER me->handle_grid_ondrag FOR g_grid.
    SET HANDLER me->handle_grid_ondrop FOR g_grid.
*   --- --- --- --- --- --- --- ---
  ENDIF.

ENDMETHOD.


METHOD set_function_code .

  CHECK NOT i_ucomm IS INITIAL.

* print the actual ALV grid
  IF NOT g_grid  IS INITIAL.
    CALL METHOD g_grid->set_function_code
      CHANGING
        c_ucomm = i_ucomm.
  ENDIF.

* print the actual ALV tree
  IF NOT g_tree IS INITIAL.
    CALL METHOD g_tree->set_function_code
      EXPORTING
        i_ucomm = i_ucomm.
  ENDIF.

  CALL METHOD cl_gui_cfw=>flush.

ENDMETHOD.


METHOD set_sel_criteria .

  DATA: l_repid      TYPE sy-repid.

* view-ID and view-type are necessary
* (workplace-ID could be empty)
  CHECK NOT g_view_id   IS INITIAL AND
        NOT g_view_type IS INITIAL.

  l_repid = sy-repid.

  REFRESH gt_sel_crit.

* START MED-40483 2010/06/18
  IF it_sel_criteria IS NOT INITIAL.
    gt_sel_crit = it_sel_criteria.
  ELSE.
* END MED-40483
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_placeid  = g_wplace_id
        i_viewid   = g_view_id
        i_viewtype = g_view_type
        i_caller   = l_repid
      TABLES
        t_selvar   = gt_sel_crit.
  ENDIF.                                                    "MED-40483#

ENDMETHOD.


METHOD set_view_data .

  g_view_id   = i_viewid.

  g_wplace_id = i_placeid.

ENDMETHOD.


METHOD set_view_layout .

  DATA: l_view                     TYPE v_nwview,
*        l_viewvar                  TYPE rnviewvar,        "#EC NEEDED
        l_repid                    TYPE sy-repid,
        l_mark_button_alv_on_off   TYPE ish_on_off.

  CHECK NOT g_view_id   IS INITIAL AND
        NOT g_view_type IS INITIAL.

  l_repid = sy-repid.
* reading the user defined view data
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_placeid         = g_wplace_id
      i_viewid          = g_view_id
      i_viewtype        = g_view_type
      i_caller          = l_repid
    IMPORTING
      e_view            = l_view
*     e_viewvar         = l_viewvar
      e_grid_row_marker = l_mark_button_alv_on_off
    CHANGING
      c_dispvar         = gt_fieldcat
      c_dispsort        = gt_sort
      c_dispfilter      = gt_filter
      c_layout          = g_layout.

* set view title
  g_layout-grid_title = l_view-txt.

* set the type of mark-button that should be used
  IF l_mark_button_alv_on_off EQ 'X'.
    g_layout-sel_mode = 'A'.
  ELSE.
    g_layout-sel_mode = 'C'.
  ENDIF.

* set further layout options
*  g_layout-no_toolbar = ' '.           " no toolbar
*  g_layout-smalltitle = ' '.           " small title
*  g_layout-cwidth_opt = ' '.           " optimize the column width

* declare field LINECOLOR for line coloring
  g_layout-info_fname = 'LINECOLOR'.

* declare table CELLCOLOR for cell coloring
  g_layout-ctab_fname = 'CELLCOLOR'.

* declare table DRAGDROP for drag&drop behaviour for
* special rows/cells
  g_layout-s_dragdrop-fieldname = 'DRAGDROP'.

ENDMETHOD.


METHOD sort .                                               "#EC NEEDED

* to be implemented in subclasses.

ENDMETHOD.
ENDCLASS.
