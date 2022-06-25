class CL_ISH_ABSENCE_EDITOR_CORD definition
  public
  create public .

public section.
*"* public components of class CL_ISH_ABSENCE_EDITOR_CORD
*"* do not include other source files here!!!

  interfaces IF_ISH_ALV_CONTROL_CONSTANTS .
  interfaces IF_ISH_CONSTANT_DEFINITION .

  constants CO_VCODE_UPDATE type VCODE value 'UPD'. "#EC NOTEXT
  constants CO_VCODE_DISPLAY type VCODE value 'DIS'. "#EC NOTEXT
  constants CO_VARIANT_HANDLE_GENERAL type DISVARIANT-HANDLE value 'ABS1'. "#EC NOTEXT
  data G_EDIT_MODE type ISH_ON_OFF .

  methods SET_CELLSTYLE_OUTTAB
    importing
      value(I_VCODE) type VCODE
      value(I_REFRESH) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      value(I_PARENT) type ref to CL_GUI_CONTAINER
      value(I_EINRI) type EINRI
      value(I_EDIT_MODE) type ISH_ON_OFF default 'X'
      value(I_VARIANT_HANDLE) type DISVARIANT-HANDLE optional
    exceptions
      CNTL_ERROR .
  methods DESTROY .
  methods DISPLAY_EDITOR
    importing
      !I_CORDER type ref to CL_ISH_CORDER
      !I_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT
      value(I_VCODE) type VCODE default 'UPD'
    exporting
      !E_RC type SY-SUBRC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods GET_DATAS
    exporting
      value(E_RC) type SY-SUBRC
      value(ET_ABSENCES) type ISH_T_ABSENCE_EDIT
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING .
  methods HANDLE_ON_MESSAGE_CLICK
    for event MESSAGE_CLICK of CL_ISHMED_ERRORHANDLING
    importing
      !E_MESSAGE
      !SENDER .
  methods SET_EDITOR
    importing
      value(I_READY_FOR_INPUT) type TRUE_FALSE
      value(I_VCODE) type VCODE default 'UPD'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PAI_GRID
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_FIELDCATALOG
    exporting
      value(ET_FIELDCAT) type LVC_T_FCAT .
  methods SET_FIELDCATALOG
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT
      value(I_VCODE) type ISH_VCODE .
  type-pools CNTB .
  class CL_ISH_OBJECTBASE definition load .
protected section.
*"* protected components of class CL_ISH_ABSENCE_EDITOR_CORD
*"* do not include other source files here!!!

  data G_EDITOR type ref to CL_GUI_ALV_GRID .
  data G_VARIANT_HANDLE type DISVARIANT-HANDLE .
  data GT_FIELDCAT type LVC_T_FCAT .
  class-data GT_OUTTAB type ISH_T_ABSENCE_EDIT .
  data G_LAYOUT type LVC_S_LAYO .
  data G_EINRI type NLEI-EINRI .
  data GT_SORT type LVC_T_SORT .
  data G_VARIANT type DISVARIANT .
  data G_CORDER type ref to CL_ISH_CORDER .
  data G_PAI_CODE type CHAR10 .
  constants CO_PAI_FROMGRID type CHAR10 value 'FROMGRID'. "#EC NOTEXT
  constants CO_PAI_NORMALPAI type CHAR10 value 'NORMALPAI'. "#EC NOTEXT

  methods BUILD_FIELDCATALOG .
  methods BUILD_FUNCTIONS .
  methods BUILD_OUTTAB
    importing
      !I_CORDER type ref to CL_ISH_CORDER
      value(I_VCODE) type VCODE default 'UPD'
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods HANDLE_AFTER_USER_COMMAND
    for event AFTER_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !E_NOT_PROCESSED .
  methods HANDLE_ON_DATA_CHANGED
    for event DATA_CHANGED of CL_GUI_ALV_GRID
    importing
      !ER_DATA_CHANGED
      !E_ONF4
      !E_ONF4_BEFORE
      !E_ONF4_AFTER .
  methods HANDLE_ON_F4
    for event ONF4 of CL_GUI_ALV_GRID
    importing
      !E_FIELDNAME
      !E_FIELDVALUE
      !ES_ROW_NO
      !ER_EVENT_DATA
      !ET_BAD_CELLS
      !E_DISPLAY .
  methods HANDLE_TOOLBAR
    for event TOOLBAR of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_INTERACTIVE .
  methods HANDLE_USER_COMMAND
    for event USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  methods INITIALIZE .
  methods REGISTER_EVENTS .
  methods HANDLE_BEFORE_USER_COMMAND
    for event BEFORE_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  methods HANDLE_ON_AFTER_REFRESH
    for event AFTER_REFRESH of CL_GUI_ALV_GRID .
  methods HANDLE_DATA_CHANGED_FINISHED
    for event DATA_CHANGED_FINISHED of CL_GUI_ALV_GRID
    importing
      !E_MODIFIED .
  methods BUILD_VARIANT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING
 optional .
  methods HANDLE_ON_CONTEXT_MENU_REQUEST
    for event CONTEXT_MENU_REQUEST of CL_GUI_ALV_GRID
    importing
      !E_OBJECT .
private section.
*"* private components of class CL_ISH_ABSENCE_EDITOR_CORD
*"* do not include other source files here!!!

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases ALV_COL_STYLE_AUTO_VALUE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_AUTO_VALUE .
  aliases ALV_COL_STYLE_AVERAGE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_AVERAGE .
  aliases ALV_COL_STYLE_CHARACTERISTIC
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_CHARACTERISTIC .
  aliases ALV_COL_STYLE_EXCEPTION
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_EXCEPTION .
  aliases ALV_COL_STYLE_FILTER
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_FILTER .
  aliases ALV_COL_STYLE_FIXED
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_FIXED .
  aliases ALV_COL_STYLE_HASREF
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_HASREF .
  aliases ALV_COL_STYLE_KEY
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_KEY .
  aliases ALV_COL_STYLE_KEYFIGURE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_KEYFIGURE .
  aliases ALV_COL_STYLE_MAX
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_MAX .
  aliases ALV_COL_STYLE_MERGE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_MERGE .
  aliases ALV_COL_STYLE_MIN
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_MIN .
  aliases ALV_COL_STYLE_NO_DISP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_NO_DISP .
  aliases ALV_COL_STYLE_SIGNED_KEYFIGURE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_SIGNED_KEYFIGURE .
  aliases ALV_COL_STYLE_SORT_DOWN
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_SORT_DOWN .
  aliases ALV_COL_STYLE_SORT_UP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_SORT_UP .
  aliases ALV_COL_STYLE_SUBTOTAL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_SUBTOTAL .
  aliases ALV_COL_STYLE_TOTAL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_COL_STYLE_TOTAL .
  aliases ALV_STYLE2_NO_BORDER_BOTTOM
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE2_NO_BORDER_BOTTOM .
  aliases ALV_STYLE2_NO_BORDER_LEFT
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE2_NO_BORDER_LEFT .
  aliases ALV_STYLE2_NO_BORDER_RIGHT
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE2_NO_BORDER_RIGHT .
  aliases ALV_STYLE2_NO_BORDER_TOP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE2_NO_BORDER_TOP .
  aliases ALV_STYLE4_LINK
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE4_LINK .
  aliases ALV_STYLE4_LINK_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE4_LINK_NO .
  aliases ALV_STYLE4_STOP_MERGE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE4_STOP_MERGE .
  aliases ALV_STYLE4_ZEBRA_ROW
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE4_ZEBRA_ROW .
  aliases ALV_STYLE_ALIGN_CENTER_BOTTOM
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_CENTER_BOTTOM .
  aliases ALV_STYLE_ALIGN_CENTER_CENTER
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_CENTER_CENTER .
  aliases ALV_STYLE_ALIGN_CENTER_TOP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_CENTER_TOP .
  aliases ALV_STYLE_ALIGN_LEFT_BOTTOM
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_LEFT_BOTTOM .
  aliases ALV_STYLE_ALIGN_LEFT_CENTER
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_LEFT_CENTER .
  aliases ALV_STYLE_ALIGN_LEFT_TOP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_LEFT_TOP .
  aliases ALV_STYLE_ALIGN_RIGHT_BOTTOM
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_RIGHT_BOTTOM .
  aliases ALV_STYLE_ALIGN_RIGHT_CENTER
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_RIGHT_CENTER .
  aliases ALV_STYLE_ALIGN_RIGHT_TOP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ALIGN_RIGHT_TOP .
  aliases ALV_STYLE_BUTTON
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_BUTTON .
  aliases ALV_STYLE_BUTTON_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_BUTTON_NO .
  aliases ALV_STYLE_CHECKBOX_CHECKED
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_CHECKBOX_CHECKED .
  aliases ALV_STYLE_CHECKBOX_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_CHECKBOX_NO .
  aliases ALV_STYLE_CHECKBOX_NOT_CHECKED
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_CHECKBOX_NOT_CHECKED .
  aliases ALV_STYLE_COLOR_BACKGROUND
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_BACKGROUND .
  aliases ALV_STYLE_COLOR_GROUP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_GROUP .
  aliases ALV_STYLE_COLOR_HEADING
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_HEADING .
  aliases ALV_STYLE_COLOR_INT_BACKGROUND
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INT_BACKGROUND .
  aliases ALV_STYLE_COLOR_INT_GROUP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INT_GROUP .
  aliases ALV_STYLE_COLOR_INT_HEADING
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INT_HEADING .
  aliases ALV_STYLE_COLOR_INT_KEY
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INT_KEY .
  aliases ALV_STYLE_COLOR_INT_NEGATIVE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INT_NEGATIVE .
  aliases ALV_STYLE_COLOR_INT_NORMAL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INT_NORMAL .
  aliases ALV_STYLE_COLOR_INT_POSITIVE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INT_POSITIVE .
  aliases ALV_STYLE_COLOR_INT_TOTAL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INT_TOTAL .
  aliases ALV_STYLE_COLOR_INV_BACKGROUND
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INV_BACKGROUND .
  aliases ALV_STYLE_COLOR_INV_GROUP
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INV_GROUP .
  aliases ALV_STYLE_COLOR_INV_HEADING
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INV_HEADING .
  aliases ALV_STYLE_COLOR_INV_KEY
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INV_KEY .
  aliases ALV_STYLE_COLOR_INV_NEGATIVE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INV_NEGATIVE .
  aliases ALV_STYLE_COLOR_INV_NORMAL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INV_NORMAL .
  aliases ALV_STYLE_COLOR_INV_POSITIVE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INV_POSITIVE .
  aliases ALV_STYLE_COLOR_INV_TOTAL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_INV_TOTAL .
  aliases ALV_STYLE_COLOR_KEY
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_KEY .
  aliases ALV_STYLE_COLOR_NEGATIVE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_NEGATIVE .
  aliases ALV_STYLE_COLOR_NORMAL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_NORMAL .
  aliases ALV_STYLE_COLOR_POSITIVE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_POSITIVE .
  aliases ALV_STYLE_COLOR_TOTAL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_COLOR_TOTAL .
  aliases ALV_STYLE_DISABLED
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_DISABLED .
  aliases ALV_STYLE_ENABLED
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_ENABLED .
  aliases ALV_STYLE_F4
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_F4 .
  aliases ALV_STYLE_F4_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_F4_NO .
  aliases ALV_STYLE_FONT_BOLD
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_FONT_BOLD .
  aliases ALV_STYLE_FONT_BOLD_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_FONT_BOLD_NO .
  aliases ALV_STYLE_FONT_ITALIC
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_FONT_ITALIC .
  aliases ALV_STYLE_FONT_ITALIC_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_FONT_ITALIC_NO .
  aliases ALV_STYLE_FONT_SYMBOL
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_FONT_SYMBOL .
  aliases ALV_STYLE_FONT_SYMBOL_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_FONT_SYMBOL_NO .
  aliases ALV_STYLE_FONT_UNDERLINED
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_FONT_UNDERLINED .
  aliases ALV_STYLE_FONT_UNDERLINED_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_FONT_UNDERLINED_NO .
  aliases ALV_STYLE_IMAGE
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_IMAGE .
  aliases ALV_STYLE_NO_DELETE_ROW
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_NO_DELETE_ROW .
  aliases ALV_STYLE_RADIO_CHECKED
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_RADIO_CHECKED .
  aliases ALV_STYLE_RADIO_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_RADIO_NO .
  aliases ALV_STYLE_RADIO_NOT_CHECKED
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_RADIO_NOT_CHECKED .
  aliases ALV_STYLE_SINGLE_CLK_EVENT
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_SINGLE_CLK_EVENT .
  aliases ALV_STYLE_SINGLE_CLK_EVENT_NO
    for IF_ISH_ALV_CONTROL_CONSTANTS~ALV_STYLE_SINGLE_CLK_EVENT_NO .
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
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
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

  data GT_EXCLUDED_FUNCTIONS type UI_FUNCTIONS .
  data G_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  data GT_ABSENCE_REASONS type ISH_T_ABSRSN .

  methods DROP_DOWN_ABSENCE_REASON .
  methods SET_CURSOR_FIRST_ERROR
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING .
  methods MODIFY_CELL
    importing
      value(I_OUTTAB) type RNWLM_EDIT
      value(I_FIELDNAME) type LVC_S_FCAT-FIELDNAME
      value(I_VALUE) type ANY .
ENDCLASS.



CLASS CL_ISH_ABSENCE_EDITOR_CORD IMPLEMENTATION.


METHOD BUILD_FIELDCATALOG .

* Workareas
  DATA: l_fieldcat          LIKE LINE OF gt_fieldcat.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
       EXPORTING
            i_structure_name       = 'RNWLM_EDIT'
            i_bypassing_buffer     = ' '
       CHANGING
            ct_fieldcat            = gt_fieldcat[]
       EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2
            OTHERS                 = 3.
*   --- --- --- --- --- --- --- --- --- ---
  CHECK sy-subrc = 0.

  LOOP AT gt_fieldcat INTO l_fieldcat.
    CASE l_fieldcat-fieldname.
*       technische Felder kennzeichnen
      WHEN 'ABSOBJ'    OR
           'DRDN_HNDL' OR
           'STYLE'     OR
           'ABSRSN'.
        l_fieldcat-tech   = on.
        l_fieldcat-no_out = on.
      WHEN 'ABSRSNTX'.
*        l_fieldcat-edit        =  g_edit_mode.
        l_fieldcat-outputlen   =  20.
*         Drop-Down-Listbox
        l_fieldcat-drdn_hndl   =  1.
    ENDCASE.
    MODIFY gt_fieldcat FROM l_fieldcat.
  ENDLOOP.

ENDMETHOD.


METHOD BUILD_FUNCTIONS .

  DATA: l_excl_functions LIKE LINE OF gt_excluded_functions.

  IF gt_excluded_functions[] IS INITIAL.

*   Detail
    l_excl_functions = cl_gui_alv_grid=>mc_fc_detail.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Undo
    l_excl_functions = cl_gui_alv_grid=>mc_fc_loc_undo.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Suchen
    l_excl_functions = cl_gui_alv_grid=>mc_fc_find.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Filter setzen ...
    l_excl_functions = cl_gui_alv_grid=>mc_fc_filter.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Summe
    l_excl_functions = cl_gui_alv_grid=>mc_fc_sum.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
    l_excl_functions = cl_gui_alv_grid=>mc_mb_sum.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Zwischensumme
    l_excl_functions = cl_gui_alv_grid=>mc_fc_subtot.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
    l_excl_functions = cl_gui_alv_grid=>mc_mb_subtot.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Drucken
    l_excl_functions = cl_gui_alv_grid=>mc_fc_print.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
    l_excl_functions = cl_gui_alv_grid=>mc_fc_print_back.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Ansichten
    l_excl_functions = cl_gui_alv_grid=>mc_mb_view.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Exportieren
    l_excl_functions = cl_gui_alv_grid=>mc_mb_export.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Grafik anzeigen
    l_excl_functions = cl_gui_alv_grid=>mc_fc_graph.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Aufsteigend Sortieren
    l_excl_functions = cl_gui_alv_grid=>mc_fc_sort_asc.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Absteigend Sortieren
    l_excl_functions = cl_gui_alv_grid=>mc_fc_sort_dsc.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Kopieren
    l_excl_functions = cl_gui_alv_grid=>mc_fc_loc_copy.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Refresh
    l_excl_functions = cl_gui_alv_grid=>mc_fc_refresh.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Menu button Paste
    l_excl_functions = cl_gui_alv_grid=>mc_mb_paste.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Menu button Variant
    l_excl_functions = cl_gui_alv_grid=>mc_mb_variant.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
*   Info
    l_excl_functions = cl_gui_alv_grid=>mc_fc_info.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.

    l_excl_functions = cl_gui_alv_grid=>mc_fc_fix_columns.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.

    l_excl_functions = cl_gui_alv_grid=>mc_fc_unfix_columns.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.

    l_excl_functions = cl_gui_alv_grid=>mc_fc_col_optimize.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.

    l_excl_functions = cl_gui_alv_grid=>mc_fc_col_invisible.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.

    l_excl_functions = cl_gui_alv_grid=>mc_fc_loc_cut.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.

    l_excl_functions = cl_gui_alv_grid=>mc_fc_loc_paste.
    INSERT l_excl_functions INTO TABLE gt_excluded_functions.
  ENDIF.


ENDMETHOD.


METHOD build_outtab .
  DATA: lt_conn_object  TYPE ish_objectlist,
        ls_conn_object  TYPE ish_object,
        lt_absences     TYPE ish_objectlist,
        ls_absence      TYPE ish_object,
        l_absence       TYPE REF TO cl_ish_waiting_list_absence,
        ls_data         TYPE rnwlm_attrib,
        ls_outtab       TYPE rnwlm_edit,
        l_edit_lines    TYPE i,
        l_rc            TYPE ish_method_rc,
        ls_style        TYPE lvc_s_styl,
        l_lines         TYPE i,
        l_lin_out       TYPE sy-tfill.

* get all absences to the given corder
  CALL METHOD cl_ish_corder=>get_absences_for_corder
    EXPORTING
      ir_corder       = i_corder
      ir_environment  = g_environment
    IMPORTING
      e_rc            = l_rc
      et_absences     = lt_absences
    CHANGING
      cr_errorhandler = c_errorhandler.

  IF gt_outtab[] IS INITIAL.
* fill the editor table with absence data
    LOOP AT lt_absences INTO ls_absence.
      CLEAR ls_outtab.
      l_absence ?= ls_absence-object.
      CALL METHOD l_absence->get_data
        IMPORTING
          es_data        = ls_data
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc = 0.
        ls_outtab-absobj ?= l_absence.
        MOVE-CORRESPONDING ls_data TO ls_outtab.
        CALL FUNCTION 'ISH_ABSRSN_CHECK'
          EXPORTING
            ss_einri    = g_einri
            ss_absrsn   = ls_data-absrsn
          IMPORTING
            ss_absrsntx = ls_outtab-absrsntx
          EXCEPTIONS
            OTHERS      = 0.
        APPEND ls_outtab TO gt_outtab.
      ENDIF.
    ENDLOOP.
    IF sy-subrc <> 0 AND g_edit_mode = on.
      DO 5 TIMES.
        APPEND INITIAL LINE TO gt_outtab.
      ENDDO.
    ELSEIF sy-subrc EQ 0 AND g_edit_mode = on.
      DESCRIBE TABLE lt_absences.
      l_lines = 5 - sy-tfill.
      DO l_lines TIMES.
        APPEND INITIAL LINE TO gt_outtab.
      ENDDO.
    ENDIF.
  ELSE.
* 5 Leerzeilen einfügen
    IF i_vcode <> co_vcode_display.
*      DESCRIBE TABLE lt_absences lines l_lin_abs.
      DESCRIBE TABLE gt_outtab LINES l_lin_out.
      l_lines = 5 - l_lin_out.
      DO l_lines TIMES.
        APPEND INITIAL LINE TO gt_outtab.
      ENDDO.
    ENDIF.
  ENDIF.

ENDMETHOD.


method BUILD_VARIANT .
  g_variant-report   = 'CL_ISH_ABSENCE_EDITOR'.
  g_variant-username = sy-uname.
  g_variant-handle   = g_variant_handle.
endmethod.


METHOD check .

  DATA: l_outtab           LIKE LINE OF gt_outtab,
        l_what_to_check    TYPE rnwlmx,
        l_rc               TYPE ish_method_rc.

  e_rc = 0.
  l_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Event "data_changed" anstoßen => Änderungen übernehmen
  CALL METHOD g_editor->check_changed_data.

* Der "aktuell" bearbeitete Fehler wird rot dargestellt. Bevor eine
* neuerliche Prüfung der Werte erfolgt müssen alle farblichen
* Kennzeichnungen von Fehlern zurückgenommen werden.
  LOOP AT gt_outtab INTO l_outtab
     WHERE NOT style IS INITIAL.
    DELETE l_outtab-style WHERE style = alv_style_color_inv_negative.
    MODIFY gt_outtab FROM l_outtab.
  ENDLOOP.

* Anzeige der Liste aktualisieren.
  CALL METHOD g_editor->refresh_table_display.

* Prüfung der Daten.
  l_what_to_check-absbdt_x = on.
  l_what_to_check-absedt_x = on.
  l_what_to_check-absrsn_x = on.

  LOOP AT gt_outtab INTO l_outtab
     WHERE NOT absobj IS INITIAL.
    CALL METHOD l_outtab-absobj->check
      EXPORTING
        i_check_conn_objects = off
        is_what_to_check     = l_what_to_check
      IMPORTING
        e_rc                 = l_rc
      CHANGING
        c_errorhandler       = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD CONSTRUCTOR .

* --- --- --- --- --- --- ---
* Instanz für ALV-Grid-Control erzeugen
  CLEAR g_editor.
  CREATE OBJECT g_editor
    EXPORTING
      i_parent            = i_parent
   EXCEPTIONS
     error_cntl_create   = 1
     error_cntl_init     = 2
     error_cntl_link     = 3
     error_dp_create     = 4
     others              = 5.

  IF sy-subrc <> 0.
    RAISE cntl_error.
  ENDIF.
* --- --- --- --- --- --- ---
* Einrichtung
  g_einri           =  i_einri.
* Handle für Varianten
  g_variant_handle  =  i_variant_handle.
* Defaultwert (sollte nicht benutzt werden).
  IF g_variant_handle IS INITIAL.
    g_variant_handle = co_variant_handle_general.
  ENDIF.
* --- --- --- --- --- --- ---
* Initialisierungen vornehmen.
  CALL METHOD me->initialize.
* Änderungsmodus
  g_edit_mode = i_edit_mode.
* Feldkatalog befüllen
  CALL METHOD me->build_fieldcatalog.
* Funktionen befüllen
  CALL METHOD me->build_functions.

ENDMETHOD.


METHOD DESTROY .
  SET HANDLER me->handle_on_message_click
     FOR ALL INSTANCES ACTIVATION space.
  CHECK NOT g_editor IS INITIAL.
  CALL METHOD g_editor->free.
  CLEAR: g_editor.
*  clear: gt_outtab[].
ENDMETHOD.


METHOD display_editor .
* ...
* Hilfsfelder
  DATA: l_variant     TYPE disvariant.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  g_environment ?= i_environment.
  g_corder      ?= i_corder.

* Drop-Down-Listboxen befüllen
  CALL METHOD me->drop_down_absence_reason.

* Ausgabetabelle befüllen
  CALL METHOD me->build_outtab
    EXPORTING
      i_corder       = i_corder
      i_vcode        = i_vcode
    CHANGING
      c_errorhandler = c_errorhandler.

* set the cellstyle of the outtab
  CALL METHOD me->set_cellstyle_outtab
    EXPORTING
      i_vcode         = i_vcode
      i_refresh       = off
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

  CALL METHOD me->build_variant
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

* Layout definieren.
  g_layout-cwidth_opt = ' '.           " Spaltenbreite optimieren
  g_layout-smalltitle = on.
  g_layout-no_toolbar = on.
  g_layout-grid_title = text-001.
* Das Einfügen von neuen Zeilen nicht zulassen.
*  g_layout-no_rowins  = 'X'.
  g_layout-sel_mode   = 'B'.
** Keine eigene Spalte für eine Zeilenmarkierung.
*  g_layout-no_rowmark = 'X'.
* Style
  g_layout-stylefname = 'STYLE'.
* Edit
  g_layout-edit = g_edit_mode.
* --- --- --- --- --- --- --- ---
  CALL METHOD g_editor->set_table_for_first_display
    EXPORTING
      is_variant                    = g_variant
*     benutzerspezifische und globale Varianten können
*     gespeichert werden
      i_save                        = 'A'
*     I_DEFAULT                     = 'X'
      is_layout                     = g_layout
*     IS_PRINT                      =
      it_toolbar_excluding          = gt_excluded_functions
    CHANGING
      it_outtab                     = gt_outtab
      it_fieldcatalog               = gt_fieldcat
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.

* Prüfen ob eine Variante als Voreinstellung gepflegt worden ist.
  CALL METHOD g_editor->get_variant
    IMPORTING
      es_variant = l_variant.
  IF NOT l_variant-variant IS INITIAL.
*   Voreinstellung vorhanden
*   => aktueller Feldkatalog kann erst jetzt ermittelt werden
    CALL METHOD g_editor->get_frontend_fieldcatalog
      IMPORTING
        et_fieldcatalog = gt_fieldcat.
  ENDIF.
  CALL METHOD me->register_events.

ENDMETHOD.


METHOD DROP_DOWN_ABSENCE_REASON .

* Tabellen
  DATA: lt_drop_down     TYPE lvc_t_drop.
* Workareas
  DATA: l_drop_down      TYPE lvc_s_drop,
        l_reason         LIKE LINE OF gt_absence_reasons.

  SELECT w~absrsn absrsntx FROM tn42w as w inner join tn42d as d
       on w~einri  = d~einri  and             "#EC CI_BUFFJOIN
          w~absrsn = d~absrsn
       INTO CORRESPONDING FIELDS OF TABLE gt_absence_reasons
       WHERE w~spras = sy-langu
       AND   w~einri = g_einri
       and   d~loekz = off.

  LOOP AT gt_absence_reasons INTO l_reason.

    CLEAR l_drop_down.
    l_drop_down-handle = 1.
    IF NOT l_reason-absrsntx IS INITIAL.
      l_drop_down-value = l_reason-absrsntx.
    ELSE.
      l_drop_down-value = l_reason-absrsn.
    ENDIF.

    append l_drop_down TO lt_drop_down.

  ENDLOOP.

* ... sämtliche Werte übergeben
  CALL METHOD g_editor->set_drop_down_table
    EXPORTING
      it_drop_down = lt_drop_down.

ENDMETHOD.


METHOD GET_DATAS .

  DATA: ls_absence               TYPE rnwlm_edit,
        l_outtab                 LIKE LINE OF gt_outtab,
        l_rc                     TYPE sy-subrc.

  e_rc = 0.

  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Event "data_changed" anstoßen => Änderungen übernehmen
  CALL METHOD g_editor->check_changed_data.

  LOOP AT gt_outtab INTO l_outtab.

    IF l_outtab-absobj IS INITIAL.
*     Fehler; eine Instanz muß immer vorhanden sein.
      CONTINUE.
    ENDIF.

    ls_absence = l_outtab.
    APPEND ls_absence TO et_absences.
  ENDLOOP.

ENDMETHOD.


METHOD get_fieldcatalog.

  et_fieldcat[] = gt_fieldcat[].

ENDMETHOD.


METHOD HANDLE_AFTER_USER_COMMAND .



ENDMETHOD.


METHOD HANDLE_BEFORE_USER_COMMAND .

* Objektinstanzen
  DATA: l_errorhandler        TYPE REF TO cl_ishmed_errorhandling.

* --- --- --- --- --- --- --- --- --- ---
  CASE e_ucomm.
    WHEN cl_gui_alv_grid=>mc_fc_check.
*     Instanz für Errorhandling erzeugen
      CREATE OBJECT l_errorhandler.
*     Initialisierung vornehmen
      CALL METHOD l_errorhandler->initialize.
*     Prüfungen durchführen
      CALL METHOD me->check
        CHANGING
          c_errorhandler = l_errorhandler.
*     Fehlermeldungen ausgeben
      CALL METHOD l_errorhandler->display_messages
        EXPORTING
          i_amodal  = on.
*     Positionierung auf ersten Fehler ...
      CALL METHOD me->set_cursor_first_error
        CHANGING
          c_errorhandler = l_errorhandler.
*     Standardverarbeitung nicht mehr durchführen.
      CALL METHOD g_editor->set_user_command
        EXPORTING
          i_ucomm = space.
  ENDCASE.
* --- --- --- --- --- --- --- --- --- ---


ENDMETHOD.


METHOD handle_data_changed_finished .

  DATA: ls_outtab       TYPE rnwlm_edit,
        lt_conn_object  TYPE ish_objectlist,
        ls_conn_object  TYPE ish_object,
        lt_absences     TYPE ish_objectlist,
        l_absence       TYPE ish_object,
        ls_data         TYPE rnwlm_attrib,
        ls_reason       LIKE LINE OF gt_absence_reasons,
        c_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_absobj        TYPE REF TO cl_ish_waiting_list_absence,
        l_fieldname     TYPE lvc_fname,
        l_rc            TYPE ish_method_rc.


  ls_conn_object-object ?= g_corder.
  APPEND ls_conn_object TO lt_conn_object.

* Ausgabetabelle updaten

  LOOP AT gt_outtab INTO ls_outtab.

*   Leerzeilen nicht berücksichtigen
    CHECK NOT ls_outtab-absbdt IS INITIAL OR
          NOT ls_outtab-absedt IS INITIAL OR
          NOT ls_outtab-absrsn IS INITIAL OR
          NOT ls_outtab-absobj IS INITIAL.

*   Abwesenheitsgrund aus Drop Downliste verschlüsseln
    READ TABLE gt_absence_reasons INTO ls_reason
               WITH KEY absrsntx = ls_outtab-absrsntx.
    IF sy-subrc = 0.
      ls_outtab-absrsn = ls_reason-absrsn.
      l_fieldname = 'ABSRSN'.
      CALL METHOD me->modify_cell
        EXPORTING
          i_outtab    = ls_outtab
          i_fieldname = l_fieldname
          i_value     = ls_outtab-absrsn.
    ENDIF.

*   Abwesenheitsinstanz erzeugen wenn nicht vorhanden
    IF ls_outtab-absobj IS INITIAL.
      MOVE-CORRESPONDING ls_outtab TO ls_data.
      CALL METHOD cl_ish_waiting_list_absence=>create
        EXPORTING
          is_data              = ls_data
          i_environment        = g_environment
          it_connected_objects = lt_conn_object
        IMPORTING
          e_instance           = ls_outtab-absobj
        EXCEPTIONS
          missing_environment  = 1
          OTHERS               = 2.
    ENDIF.
    MODIFY gt_outtab FROM ls_outtab.

  ENDLOOP.

** gelöschte Abwesenheit stornieren
*  CALL METHOD cl_ish_corder=>get_absences_for_corder
*    EXPORTING
*      i_cancelled_datas = off
*      i_prereg          = g_prereg
*      i_environment     = g_environment
*    IMPORTING
*      e_rc              = l_rc
*      et_absences       = lt_absences
*    CHANGING
*      c_errorhandler    = c_errorhandler.

*-- begin Grill, ID-17999
  CALL METHOD cl_ish_corder=>get_absences_for_corder
    EXPORTING
      i_cancelled_datas = off
      ir_corder         = g_corder
      ir_environment    = g_environment
    IMPORTING
      e_rc              = l_rc
      et_absences       = lt_absences
    CHANGING
      cr_errorhandler   = c_errorhandler.
  CHECK l_rc EQ 0.
*-- end Grill, ID-17999

  IF l_rc = 0.
    LOOP AT lt_absences INTO l_absence.
      l_absobj ?= l_absence-object.
      READ TABLE gt_outtab INTO ls_outtab
                           WITH KEY absobj = l_absobj.
      IF sy-subrc <> 0.
        CALL METHOD l_absobj->cancel
          CHANGING
            c_errorhandler = c_errorhandler.
      ENDIF.
    ENDLOOP.
  ENDIF.
ENDMETHOD.


METHOD HANDLE_ON_AFTER_REFRESH .

ENDMETHOD.


method HANDLE_ON_CONTEXT_MENU_REQUEST .
data: l_gui_text type gui_text.
    l_gui_text = text-002.
    call method e_object->add_function
             exporting fcode = cl_gui_alv_grid=>mc_fc_loc_append_row
                       text  = l_gui_text.
    l_gui_text = text-003.
    call method e_object->add_function
             exporting fcode = cl_gui_alv_grid=>mc_fc_loc_delete_row
                       text  = l_gui_text.
endmethod.


METHOD HANDLE_ON_DATA_CHANGED .

* Worakreas
  DATA: l_mod_cells          TYPE lvc_s_modi,
        l_outtab             LIKE LINE OF gt_outtab.

  SORT er_data_changed->mt_good_cells BY row_id.

* Datenänderungen übernehmen.
  LOOP AT er_data_changed->mt_good_cells INTO l_mod_cells.
    READ TABLE gt_outtab INTO l_outtab
       INDEX l_mod_cells-row_id.
    IF sy-subrc <> 0.
      CONTINUE.
    ENDIF.

*   Änderung in die entsprechende Abwesenheitinstanz übernehmen.
    CALL METHOD me->modify_cell
      EXPORTING
        i_outtab    = l_outtab
        i_fieldname = l_mod_cells-fieldname
        i_value     = l_mod_cells-value.
  ENDLOOP.

ENDMETHOD.


METHOD HANDLE_ON_F4 .
* ...

ENDMETHOD.


METHOD handle_on_message_click .

* Lokale Tabelle
  DATA: lt_extended_msg TYPE ishmed_t_messages.
* Workareas
  DATA: l_outtab      LIKE LINE OF gt_outtab,
        l_style       TYPE lvc_s_styl.
* Hilfsfelder und -strukturen
  DATA: l_abs_obj     TYPE REF TO cl_ish_waiting_list_absence,
        l_row_id      TYPE lvc_s_row,
        l_column_id   TYPE lvc_s_col,
*        l_object_type TYPE ish_object_type,            "REM MED-9409
        l_index       TYPE sy-tabix.
* Objektkinstanzen
  DATA: l_errorhandler TYPE REF TO cl_ishmed_errorhandling.

*-- begin Grill, MED-34087
  l_row_id = e_message-row.
  l_column_id   = e_message-field.
*-- end Grill. MED-34087

*-- begin Grill, MED-34087
** --- --- --- --- --- --- ---
** Eigene Instanz für Fehlerhandling erzeugen.
*  CREATE OBJECT l_errorhandler.
** Daten erneut prüfen, ev. wurden bereits Fehler korrigiert.
*  CALL METHOD me->check
*    CHANGING
*      c_errorhandler = l_errorhandler.
** ----------
** Weitere Verarbeitung nur durchlaufen wenn der Fehler noch nicht
** korrigiert worden ist.
*  CALL METHOD l_errorhandler->get_messages
*    IMPORTING
*      t_extended_msg = lt_extended_msg.
*  READ TABLE lt_extended_msg TRANSPORTING NO FIELDS
*     WITH KEY object    = e_message-object
*              parameter = e_message-parameter
*              field     = e_message-field.
*  IF sy-subrc <> 0.
*    EXIT.
*  ENDIF.
** --- --- --- --- --- --- ---
** Fehlermeldung eines Objektes, Typ ermitteln und ev. ...
*  IF NOT e_message-object IS INITIAL.
**-------- BEGIN C.Honeder MED-9409
*    TRY.
*      l_abs_obj ?= e_message-object.
*    CATCH cx_sy_move_cast_error.      "#EC NO_HANDLER
*      EXIT.
*    ENDTRY.
**   CALL METHOD e_message-object->('GET_TYPE')
**      IMPORTING
**        e_object_type = l_object_type.
**    IF l_object_type <> cl_ish_waiting_list_absence=>co_otype_wl_absence.
**      EXIT.
**    ENDIF.
***   ... Abwesenheitobjekt zuweisen
**    l_abs_obj ?= e_message-object.
**-------- END C.Honeder MED-9409
*  ENDIF.
** --- --- --- --- --- --- ---
** Fehlerhaften Wert "rot" einfärben und Cursor in das Feld
** positionieren.
*  IF NOT l_abs_obj IS INITIAL.
**   Abwesenheit ausgewählt
*    READ TABLE gt_outtab INTO l_outtab
*       WITH KEY absobj = l_abs_obj.
*    IF sy-subrc = 0.
*      l_row_id-index        = sy-tabix.
*      l_column_id-fieldname = e_message-field.
*    ELSE.
*      EXIT.
*    ENDIF.
*  ENDIF.
** ----------
** Kann das fehlerhafte Feld in der Abwesenheitseditor eingegeben werden.
*  READ TABLE gt_fieldcat TRANSPORTING NO FIELDS
*     WITH KEY fieldname = e_message-field
*              edit      = on.
*  IF sy-subrc = 0.
**   ... einfärben
*    l_style-fieldname = e_message-field.
*    l_style-style     = alv_style_color_inv_negative.
*    INSERT l_style INTO TABLE l_outtab-style.
*    MODIFY gt_outtab FROM l_outtab INDEX l_row_id-index.
*  ENDIF.
*-- eng Grill, med-34087
* ----------
* Anzeige des ALV-Grid's aktualisieren (bzgl. Farbe)
  CALL METHOD g_editor->refresh_table_display.
* Fokus in die Abwesenheitseditor setzen.
  CALL METHOD cl_gui_alv_grid=>set_focus
    EXPORTING
      control = g_editor.
* Cursor in das fehlerhafte Feld positionieren
  CALL METHOD g_editor->set_current_cell_via_id
    EXPORTING
*-- begin Grill, MED-34087
*      is_row_id    = l_row_id
*      is_column_id = l_column_id.
      is_row_id    = l_row_id
      is_column_id = l_column_id .
*-- end Grill, MED-34087
* Den fehlerhaften Wert markieren.
  CALL METHOD g_editor->select_text_in_curr_cell.
* --- --- --- --- --- --- ---

ENDMETHOD.


METHOD HANDLE_TOOLBAR .


* Alle Trennstriche entfernen, damit der Platz der Toolbar optimal
* ausgenutzt wird.
  DELETE e_object->mt_toolbar WHERE butn_type = cntb_btype_sep.


ENDMETHOD.


METHOD HANDLE_USER_COMMAND .

ENDMETHOD.


METHOD initialize .

  CLEAR: gt_fieldcat[], gt_outtab[].

ENDMETHOD.


METHOD MODIFY_CELL .

  DATA: ls_what_to_change  TYPE rnwlmx,
        l_rc               TYPE ish_method_rc,
        l_errorhandler     TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS: <l_field>  TYPE ANY.

* Weitere Verarbeitung nur wenn Abwesenheitsinstanz vorhanden ist.
  CHECK NOT i_outtab-absobj IS INITIAL.

* I_FIELDNAME enthält das zu ändernde Feld.
  ASSIGN COMPONENT i_fieldname OF STRUCTURE ls_what_to_change
     TO <l_field>.
  IF sy-subrc = 0.
*   Wert übernehmen.
    <l_field>  =  i_value.
*   KZ für Änderung setzen.
    CONCATENATE i_fieldname '_X' INTO i_fieldname.
    ASSIGN COMPONENT i_fieldname OF STRUCTURE ls_what_to_change
       TO <l_field>.
    IF sy-subrc = 0.
      <l_field> = on.
    ENDIF.
  ENDIF.
* Änderung der Abwesenheitsinstanz vornehmen.
  CALL METHOD i_outtab-absobj->change
    EXPORTING
      is_what_to_change = ls_what_to_change
    CHANGING
      c_errorhandler    = l_errorhandler.

ENDMETHOD.


METHOD pai_grid .

  e_rc = 0.

* ---------------------------------------------------------
* Fire event DATA_CHANGED of the grid to get the changed values
* into the OUTTAB
* If the grid has raised event "DATA_CHANGED_FINISHED" itself,
* the corresponding handler of this class has been processed and
* it has set G_PAI_CODE to CO_PAI_FROMGRID to avoid that the
* DATA_CHANGED is raised a second time.
* See also method HANDLE_DATA_CHANGED_FINISHED!
  IF g_pai_code <> co_pai_fromgrid.
*   Avoid an infinite-loop by setting the global pai-code to
*   NORMALPAI. When G_PAI_CODE has this value, the Grid-handler
*   HANDLE_DATA_CHANGED_FINISHED does NOT raise an user-command
*   again
    g_pai_code = co_pai_normalpai.
    CALL METHOD g_editor->check_changed_data.
  ENDIF.

ENDMETHOD.


METHOD REGISTER_EVENTS .

* --- --- --- --- --- --- --- ---
* Toolbar
  SET HANDLER me->handle_toolbar FOR g_editor.
* ---
  CALL METHOD g_editor->set_toolbar_interactive.
* --- --- --- --- --- --- --- ---
* Benutzeraktion
  SET HANDLER me->handle_user_command FOR g_editor.
* --- --- --- --- --- --- --- ---
* Nach erfolgter Benutzeraktion
  SET HANDLER me->handle_after_user_command FOR g_editor.
* --- --- --- --- --- --- --- ---
* Nach vor einer Benutzeraktion
  SET HANDLER me->handle_before_user_command FOR g_editor.
* --- --- --- --- --- --- --- ---
* Reaktion auf F4-Hilfe.
  SET HANDLER me->handle_on_f4 FOR g_editor.

* Nach erfolgter Änderung der Daten.
  SET HANDLER me->handle_data_changed_finished FOR g_editor.
* --- --- --- --- --- --- --- ---
* Reaktion auf Änderung der Daten.
  SET HANDLER me->handle_on_data_changed FOR g_editor.
* Erweiterung Kontextmenü
  SET HANDLER me->handle_on_context_menu_request FOR g_editor.
* --- --- --- --- --- --- --- ---
* ÄNDERUNG der Daten
* Um auf Änderungen reagieren zu können muß folgende Methode aufge-
* rufen werden. Es wird bekannt gegeben durch welche Aktion das
* Ereignis ausgelöst werden soll.
* Prinzipiell stehen zwei Möglichkeiten zur Verfügung:
*    Ereignis wird bei ENTER aufgerufen
*    Ereignis wird immer dann angestossen, wenn eine Änderung der
*    Daten erfolgte (dies ist hier der Fall).
*  CALL METHOD g_editor->register_edit_event
*    EXPORTING
*      i_event_id = cl_gui_alv_grid=>mc_evt_enter
*    EXCEPTIONS
*      error      = 1
*      OTHERS     = 2.

  CALL METHOD g_editor->register_edit_event
    EXPORTING
      i_event_id = cl_gui_alv_grid=>mc_evt_modified
    EXCEPTIONS
      error      = 1
      OTHERS     = 2.

* --- --- --- --- --- --- --- ---
* Auswahl einer Fehlermeldung
  SET HANDLER me->handle_on_message_click FOR ALL INSTANCES.
* --- --- --- --- --- --- --- ---
ENDMETHOD.


METHOD set_cellstyle_outtab .

  DATA: ls_outtab       TYPE rnwlm_edit,
        l_rc            TYPE ish_method_rc,
        ls_style        TYPE lvc_s_styl,
        ls_stable       TYPE lvc_s_stbl.

  e_rc = 0.

* set the cellstyle -> enabled or disabled
  CLEAR: ls_outtab.
  LOOP AT gt_outtab INTO ls_outtab.
    CLEAR: ls_outtab-style[].
*   ABSRSNTX
    ls_style-fieldname = 'ABSRSNTX'.
    IF i_vcode <> co_vcode_display.
      ls_style-style     =
                        cl_gui_alv_grid=>mc_style_enabled.
    ELSE.
      ls_style-style     =
                        cl_gui_alv_grid=>mc_style_disabled.
    ENDIF.
    INSERT ls_style INTO TABLE ls_outtab-style.
*   ABSBDT
    ls_style-fieldname = 'ABSBDT'.
    IF i_vcode <> co_vcode_display.
      ls_style-style     =
                        cl_gui_alv_grid=>mc_style_enabled.
    ELSE.
      ls_style-style     =
                        cl_gui_alv_grid=>mc_style_disabled.
    ENDIF.
    INSERT ls_style INTO TABLE ls_outtab-style.
*   ABSEDT
    ls_style-fieldname = 'ABSEDT'.
    IF i_vcode <> co_vcode_display.
      ls_style-style     =
                        cl_gui_alv_grid=>mc_style_enabled.
    ELSE.
      ls_style-style     =
                        cl_gui_alv_grid=>mc_style_disabled.
    ENDIF.
    INSERT ls_style INTO TABLE ls_outtab-style.
*   ABSRSN
    ls_style-fieldname = 'ABSRSN'.
    IF i_vcode <> co_vcode_display.
      ls_style-style     =
                        cl_gui_alv_grid=>mc_style_enabled.
    ELSE.
      ls_style-style     =
                        cl_gui_alv_grid=>mc_style_disabled.
    ENDIF.
    INSERT ls_style INTO TABLE ls_outtab-style.
    MODIFY gt_outtab FROM ls_outtab.
  ENDLOOP.

* Refresh grid, but keep it stable: That means that the entry
* which is now visible in the first row stays also in the first
* row after the grid is refreshed
  CHECK i_refresh = on.
  CLEAR: ls_stable.
  ls_stable-row = on.
  ls_stable-col = on.
  IF NOT g_editor IS INITIAL.
    CALL METHOD g_editor->refresh_table_display
      EXPORTING
        is_stable = ls_stable
      EXCEPTIONS
        finished  = 1
        OTHERS    = 2.
    l_rc = sy-subrc.
    IF l_rc <> 0.
*     error in calling method....
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '030'
          i_mv1           = l_rc
          i_mv2           = 'REFRESH_TABLE_DISPLAY'
          i_mv3           = 'CL_GUI_ALV_GRID'
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.

    EXIT.
  ENDIF.

ENDMETHOD.


METHOD SET_CURSOR_FIRST_ERROR .

* Lokale Tabellen
  DATA: lt_extended_msg      TYPE ishmed_t_messages.
* Workareas
  DATA: l_message            LIKE LINE OF lt_extended_msg.
* --- --- --- --- --- --- ---
* Zuerst die Fehlermeldungen ermitteln
  CALL METHOD c_errorhandler->get_messages
    IMPORTING
      t_extended_msg  = lt_extended_msg.
* --- --- --- --- --- --- ---
  LOOP AT lt_extended_msg INTO l_message.
*   Prüfen ob es sich um eine "eigene" Fehlermeldung handelt ...
    IF NOT l_message-object    IS INITIAL AND
           l_message-parameter =  'NWLM'.
      READ TABLE gt_fieldcat TRANSPORTING NO FIELDS
         WITH KEY fieldname = l_message-field
                  edit      = on.
      IF sy-subrc = 0.
        CALL METHOD me->handle_on_message_click
          EXPORTING
            e_message = l_message
            sender    = c_errorhandler.
        EXIT.
      ENDIF.
    ENDIF.
  ENDLOOP.
* --- --- --- --- --- --- ---

ENDMETHOD.


METHOD set_editor .

  CLEAR: e_rc.

* build the outtab
  CALL METHOD me->build_outtab
    EXPORTING
      i_corder       = g_corder
      i_vcode        = i_vcode
    CHANGING
      c_errorhandler = cr_errorhandler.

* set the cellstyle of the outtab
  call method me->set_cellstyle_outtab
    exporting
      i_vcode   = i_vcode
      i_refresh = on
    importing
      e_rc      = e_rc
    changing
      cr_errorhandler = cr_errorhandler.
      check e_rc = 0.

ENDMETHOD.


METHOD set_fieldcatalog.

  DATA: ls_fieldcat          TYPE lvc_s_fcat,
        ls_fieldcat_modified TYPE lvc_s_fcat,
        ls_stable            TYPE lvc_s_stbl,
        ls_outtab       TYPE rnwlm_edit,
        ls_style        TYPE lvc_s_styl.

  LOOP AT it_fieldcat INTO ls_fieldcat_modified.
    READ TABLE gt_fieldcat INTO ls_fieldcat
        WITH KEY fieldname = ls_fieldcat_modified-fieldname.
    CHECK sy-subrc EQ 0.
    ls_fieldcat-tech = ls_fieldcat_modified-tech.
    ls_fieldcat-edit = ls_fieldcat_modified-edit.
    MODIFY gt_fieldcat FROM ls_fieldcat
          TRANSPORTING tech edit
          WHERE fieldname = ls_fieldcat-fieldname.
  ENDLOOP.

  CALL METHOD g_editor->set_frontend_fieldcatalog
    EXPORTING
      it_fieldcatalog = gt_fieldcat.

* set the cellstyle -> enabled or disabled
  CLEAR: ls_outtab, ls_fieldcat.
  LOOP AT gt_outtab INTO ls_outtab.
    CLEAR: ls_outtab-style[].
*   ABSRSNTX
    ls_style-fieldname = 'ABSRSNTX'.
    READ TABLE it_fieldcat INTO ls_fieldcat
        WITH KEY fieldname = 'ABSRSNTX'.
    IF sy-subrc EQ 0.
      IF ls_fieldcat-edit = on.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_enabled.
      ELSE.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_disabled.
      ENDIF.
    ELSE.
      IF i_vcode <> co_vcode_display.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_enabled.
      ELSE.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_disabled.
      ENDIF.
    ENDIF.
    INSERT ls_style INTO TABLE ls_outtab-style.
*   ABSBDT
    ls_style-fieldname = 'ABSBDT'.
    READ TABLE it_fieldcat INTO ls_fieldcat
        WITH KEY fieldname = 'ABSBDT'.
    IF sy-subrc EQ 0.
      IF ls_fieldcat-edit = on.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_enabled.
      ELSE.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_disabled.
      ENDIF.
    ELSE.
      IF i_vcode <> co_vcode_display.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_enabled.
      ELSE.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_disabled.
      ENDIF.
    ENDIF.
    INSERT ls_style INTO TABLE ls_outtab-style.
*   ABSEDT
    ls_style-fieldname = 'ABSEDT'.
    READ TABLE it_fieldcat INTO ls_fieldcat
        WITH KEY fieldname = 'ABSEDT'.
    IF sy-subrc EQ 0.
      IF ls_fieldcat-edit = on.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_enabled.
      ELSE.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_disabled.
      ENDIF.
    ELSE.
      IF i_vcode <> co_vcode_display.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_enabled.
      ELSE.
        ls_style-style     =
                          cl_gui_alv_grid=>mc_style_disabled.
      ENDIF.
    ENDIF.
    INSERT ls_style INTO TABLE ls_outtab-style.
    MODIFY gt_outtab FROM ls_outtab.
  ENDLOOP.

* Refresh table display.
  CLEAR: ls_stable.
  ls_stable-row = on.
  ls_stable-col = on.

  CALL METHOD g_editor->refresh_table_display
    EXPORTING
      is_stable = ls_stable
    EXCEPTIONS
      finished  = 1
      OTHERS    = 2.

ENDMETHOD.
ENDCLASS.
