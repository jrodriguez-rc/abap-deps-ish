class CL_ISHMED_CANCEL_TREE definition
  public
  final
  create public .

public section.

*"* public components of class CL_ISHMED_CANCEL_TREE
*"* do not include other source files here!!!
  interfaces IF_ISH_ALV_CONTROL_CONSTANTS .
  interfaces IF_ISH_CONSTANT_DEFINITION .

  constants CO_2ND_SURG type N1POOBJECTID value '2NDSURG' ##NO_TEXT.
  constants CO_APPMNT type N1POOBJECTID value 'APPMNT' ##NO_TEXT.
  constants CO_CASE type N1POOBJECTID value 'CASE' ##NO_TEXT.
  constants CO_CONTEXT type N1POOBJECTID value 'CONTEXT' ##NO_TEXT.
  constants CO_CORDER type N1POOBJECTID value 'CORDER' ##NO_TEXT.
  constants CO_CYCLE type N1POOBJECTID value 'CYCLE' ##NO_TEXT.
  constants CO_CYCLEDEF type N1POOBJECTID value 'CYCLEDEF' ##NO_TEXT.
  constants CO_DIAGNOSIS type N1POOBJECTID value 'DIAGNOSIS' ##NO_TEXT.
  constants CO_INSURANCE_POL_PROV type N1POOBJECTID value 'INS_POL_PR' ##NO_TEXT.
  constants CO_ME_EVENT type N1POOBJECTID value 'ME_EVENT' ##NO_TEXT.
  constants CO_ME_EVENT_DRUG type N1POOBJECTID value 'ME_EDRUG' ##NO_TEXT.
  constants CO_ME_ORDER type N1POOBJECTID value 'ME_ORDER' ##NO_TEXT.
  constants CO_ME_ORDER_DRUG type N1POOBJECTID value 'ME_ODRUG' ##NO_TEXT.
  constants CO_ME_ORDER_RATE type N1POOBJECTID value 'ME_ORATE' ##NO_TEXT.
  constants CO_MOVEMENT type N1POOBJECTID value 'MOVEMENT' ##NO_TEXT.
  constants CO_N2OK type N1POOBJECTID value 'N2OK' ##NO_TEXT.
  constants CO_N2ZEITEN type N1POOBJECTID value 'N2ZEITEN' ##NO_TEXT.
  constants CO_NDOC type N1POOBJECTID value 'NDOC' ##NO_TEXT.
  constants CO_NICP type N1POOBJECTID value 'NICP' ##NO_TEXT.
  constants CO_NLEI type N1POOBJECTID value 'NLEI' ##NO_TEXT.
  constants CO_NMATV type N1POOBJECTID value 'MATERIAL' ##NO_TEXT.
  constants CO_PREREG type N1POOBJECTID value 'PREREG' ##NO_TEXT.
  constants CO_PROV_DIAGNOSIS type N1POOBJECTID value 'PROV_DIA' ##NO_TEXT.
  constants CO_PROV_PATIENT type N1POOBJECTID value 'NPAP' ##NO_TEXT.
  constants CO_PROV_PROCEDURE type N1POOBJECTID value 'PROV_PROC' ##NO_TEXT.
  constants CO_REQUEST type N1POOBJECTID value 'REQUEST' ##NO_TEXT.
  constants CO_SERVICE type N1POOBJECTID value 'SERVICE' ##NO_TEXT.
  constants CO_SURGERY type N1POOBJECTID value 'SURGERY' ##NO_TEXT.
  constants CO_TEAM type N1POOBJECTID value 'TEAM' ##NO_TEXT.
  constants CO_TRANSPORT type N1POOBJECTID value 'TRANSPORT' ##NO_TEXT.
  constants CO_UNKNOWN type N1POOBJECTID value 'UNKNOWN' ##NO_TEXT.
  constants CO_VITPAR type N1POOBJECTID value 'VITPAR' ##NO_TEXT.
  constants CO_WL_ABSENCE type N1POOBJECTID value 'WL_ABS' ##NO_TEXT.
  constants FALSE type ISH_TRUE_FALSE value '0' ##NO_TEXT.
  constants OFF type ISH_ON_OFF value SPACE ##NO_TEXT.
  constants ON type ISH_ON_OFF value 'X' ##NO_TEXT.
  constants TRUE type ISH_TRUE_FALSE value '1' ##NO_TEXT.
  constants CO_SRV_SERVICE type N1POOBJECTID value 'SRV_SERVICE' ##NO_TEXT.
  constants CO_PORDER type N1POOBJECTID value 'PORDER' ##NO_TEXT.
  constants CO_CYSRVTPL type N1POOBJECTID value 'CYSRVTPL' ##NO_TEXT.

  events TREE_CHANGED .

  class-methods BUILD_PATIENT_DATA
    importing
      value(I_OBJECT) type ref to OBJECT optional
      value(I_PATNR) type NPAT-PATNR optional
      value(I_PAPID) type NPAP-PAPID optional
    exporting
      value(E_PATNAME) type ANY
      value(E_PATTEXT) type ANY .
  methods CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      value(I_PARENT) type ref to CL_GUI_CONTAINER
      value(I_EDIT_MODE) type ISH_ON_OFF default 'X'
      value(I_CANCEL) type ref to CL_ISH_CANCEL
      value(I_VARIANT_HANDLE) type DISVARIANT-HANDLE
    exceptions
      CNTL_ERROR
      FCAT_ERROR
      OTHER_ERROR .
  methods DISPLAY_CANCEL_TREE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FREE .
  class-methods READ_DTEL_TEXT
    importing
      value(I_DTNAME) type ANY
    exporting
      value(E_TEXT) type ANY .
  methods REFRESH_CANCEL_TREE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_CURSOR_ON_NODE
    importing
      value(I_RN1MESSAGE) type RN1MESSAGE .
protected section.
*"* protected components of class CL_ISHMED_CANCEL_TREE
*"* do not include other source files here!!!

  class-methods GET_NODE_ICON
    importing
      value(I_OUTTAB) type RN1CANCEL_TREE_FIELDS
      value(I_DATA_LINE) type ANY optional
    exporting
      value(E_ICON) type TV_IMAGE .
private section.

*"* private components of class CL_ISHMED_CANCEL_TREE
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
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  types:
    begin of ty_cramp,
           cramp_node_key  type lvc_nkey,
           cramp_shown     type ish_on_off,
           cramp_node_text type lvc_value,
           data_key        type rn1cancel_key_fields,
         end of ty_cramp .
  types:
    tyt_cramp type standard table of ty_cramp .

  data GT_CRAMP type TYT_CRAMP .
  data GT_EXCL_FUNCTION type UI_FUNCTIONS .
  data GT_FIELDCAT type LVC_T_FCAT .
  data GT_OUTTAB type ISHMED_T_CANCEL_TREE_TAB .
  data G_CANCEL type ref to CL_ISH_CANCEL .
  data G_CANCEL_ALL type ref to CL_ISH_CANCEL .
  data G_TREE type ref to CL_GUI_ALV_TREE .
  data G_VARIANT type DISVARIANT .
  data G_VCODE type VCODE value 'UPD' ##NO_TEXT.

  class-methods BUILD_CONTEXT_TEXT
    importing
      value(I_OBJECT) type ref to OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_TEXT) type ANY
      value(E_ICON) type TV_IMAGE
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_FIELDCATALOG
    importing
      value(I_CANCEL) type ref to CL_ISH_CANCEL
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_FIELDCAT type LVC_T_FCAT
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_FUNCTIONS
    importing
      value(I_CANCEL) type ref to CL_ISH_CANCEL
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_FUNCTION type UI_FUNCTIONS
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_HIERARCHY_HEADER
    changing
      value(C_HEADER) type TREEV_HHDR .
  class-methods BUILD_MAINOBJ_LIGHT
    importing
      value(I_CANCEL) type ref to CL_ISH_CANCEL
      value(I_OUTTAB) type RN1CANCEL_TREE_FIELDS
      value(I_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING
    exporting
      value(E_ICON) type TV_IMAGE .
  methods BUILD_OUTTAB
    importing
      value(I_CANCEL) type ref to CL_ISH_CANCEL
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_OUTTAB) type ISHMED_T_CANCEL_TREE_TAB
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods BUILD_TYPE_TEXT
    importing
      value(I_OUTTAB) type RN1CANCEL_TREE_FIELDS
      value(I_COUNT) type I default 0
    exporting
      value(E_TYPE_TEXT) type ANY
      value(E_TEXT_PLURAL) type ANY
      value(E_COUNT_NODE) type ANY .
  class-methods CHANGE_HIERARCHY_MARK_TABLE
    importing
      value(I_CHECKED) type ISH_ON_OFF
      value(I_CRAMP_CLICKED) type ISH_ON_OFF
      value(IT_OUTTAB) type ISHMED_T_CANCEL_TREE_TAB
      value(IS_OUTTAB) type RN1CANCEL_TREE_FIELDS
      !IR_CANCEL type ref to CL_ISH_CANCEL
    exporting
      value(ET_ADDITIONAL_HIERARCHY) type ISHMED_T_CANCEL_HIERARCHY
      value(E_APPEND_HIERARCHY) type ISH_ON_OFF
    changing
      !CT_CANCEL_HIERARCHY type ISHMED_T_CANCEL_HIERARCHY
      !CT_MARK type ISHMED_T_CANCEL_MARK .
  methods FILL_TREE_CONTROL
    importing
      value(IT_OUTTAB) type ISHMED_T_CANCEL_TREE_TAB
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_UNMARKED_ENTRIES
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_UNMARKED_ENTRIES) type ISHMED_T_CANCEL_DATAS .
  methods HANDLE_CHECKBOX_CHANGE
    for event CHECKBOX_CHANGE of CL_GUI_ALV_TREE
    importing
      !NODE_KEY
      !FIELDNAME
      !CHECKED .
  methods INITIALIZE .
  class-methods OUTTAB_FROM_APPMNT
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_CONTEXT
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_CORDER
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_INSURANCE_POL_PROV
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_MED_SRV
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_NLEI) type VNLEI optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_ME_EVENT
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ES_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_ME_ORDER
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ES_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_N1FAT
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_N1FAT) type VN1FAT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_N2OK
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_N2OK) type VN2OK optional
      value(I_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_N2ZEITEN
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_N2ZEITEN) type VN2ZEITEN optional
      value(I_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_NBEW
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_NBEW) type VNBEW optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_NDIA
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_NDIA) type VNDIA optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_NDOC
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_NDOC) type RNDOC optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_NFAL
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(IS_NFAL) type NFAL optional
    exporting
      !ES_OUTTAB type RN1CANCEL_TREE_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_NICP
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_NICP) type VNICP optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_NLEI
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_NLEI) type VNLEI optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_NMATV
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_NMATV) type VNMATV optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_OBJECT
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_NO_OUTTAB) type ISH_ON_OFF
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_PREREG
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_PRE_DIAG
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_PRE_PROC
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_PROV_PAT
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_REQUEST
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_SURGERY
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_TEAM
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_UNKNOWN
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_VITPAR
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_WAIT_ABS
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(I_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !E_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods READ_HIERARCHY_DOWN
    importing
      value(I_INITIALIZE) type ISH_ON_OFF default OFF
      value(IR_OBJECT) type ref to OBJECT optional
      value(I_LINE_KEY) type RN1MESSAGE-LINE_KEY optional
      !IT_CANCEL_HIER type ISHMED_T_CANCEL_HIERARCHY
    exporting
      !ET_CANCEL_HIER type ISHMED_T_CANCEL_HIERARCHY .
  methods REGISTER_EVENTS .
  class-methods SEARCH_IN_MSGTAB
    importing
      value(I_KEYFIELDS) type RN1CANCEL_KEY_FIELDS
      value(IT_MSG) type ISHMED_T_MESSAGES
    exporting
      value(E_TYPE) type ANY .
  class-methods SEARCH_RECURSIVE_HIERARCHY
    importing
      value(I_KEYFIELDS) type RN1CANCEL_KEY_FIELDS
      value(I_MANDATORY) type ANY
      value(I_INITIALIZE) type ISH_ON_OFF default OFF
      !IT_MSG type ISHMED_T_MESSAGES
      !IT_CANCEL_HIER type ISHMED_T_CANCEL_HIERARCHY
    exporting
      value(E_MSGTYPE) type ANY
      value(E_MANDATORY) type ISH_ON_OFF .
  class-methods OUTTAB_FROM_SRV_SERVICE
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ES_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_CYSRVTPL
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ES_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods OUTTAB_FROM_PORDER
    importing
      value(I_DEPENDENT) type ISH_ON_OFF optional
      value(IR_OBJECT) type ref to OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ES_OUTTAB type RN1CANCEL_TREE_FIELDS
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
ENDCLASS.



CLASS CL_ISHMED_CANCEL_TREE IMPLEMENTATION.


method BUILD_CONTEXT_TEXT.
  data: l_context     type ref to cl_ish_context,
        l_nctx        type nctx,
        l_rc          type ish_method_rc.
  data: lt_ncxtyt     type ishmed_t_ncxtyt,
        l_ncxtyt      type ncxtyt.

* Initialisierungen
  e_rc = 0.
  clear: l_nctx.

  check not i_object is initial.

  l_context ?= i_object.
  CALL METHOD l_context->get_data
    EXPORTING
      I_FILL_CONTEXT = OFF
    IMPORTING
      E_RC           = e_rc
      E_NCTX         = l_nctx
    CHANGING
      C_ERRORHANDLER = c_errorhandler.
  check e_rc = 0.

  CALL METHOD cl_ish_master_dp=>read_contexttype_text
    EXPORTING
      I_SPRAS         = SY-LANGU
      I_CXTYP         = l_nctx-cxtyp
*      I_DEL_DATA      = SPACE
    IMPORTING
      E_RC            = l_rc
      ET_NCXTYT       = lt_ncxtyt
    CHANGING
      C_ERRORHANDLER  = c_errorhandler.
  e_text = l_nctx-cxtyp.
  if l_rc = 0.
    read table lt_ncxtyt into l_ncxtyt index 1.
    if sy-subrc = 0.
      e_text = l_ncxtyt-cxtypnm.
    endif.
  endif.

  CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
    EXPORTING
      I_OBJECT             = i_object
    IMPORTING
      E_RC                 = l_rc
      E_ICON               = e_icon.
endmethod.


method BUILD_FIELDCATALOG.
  data: lt_fieldcat type lvc_t_fcat,
        l_fcat      type lvc_s_fcat.

* Initialisierungen
  e_rc = 0.
  if c_errorhandler is initial.
    CREATE OBJECT c_errorhandler.
  endif.

* Feldkatalog zun zusammenbauen
  if ct_fieldcat[] is initial.
*   Kein Feldkatalog vorhanden => Feldkatalog zusammenstellen
    refresh lt_fieldcat.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        I_STRUCTURE_NAME             = 'RN1CANCEL_TREE_FIELDS'
        I_BYPASSING_BUFFER           = ' '
      CHANGING
        ct_fieldcat                  = lt_fieldcat
      EXCEPTIONS
        INCONSISTENT_INTERFACE       = 1
        PROGRAM_ERROR                = 2
        OTHERS                       = 3.
    e_rc = sy-subrc.
    if e_rc <> 0.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          I_TYP           = 'E'
          I_KLA           = 'NFCL'
          I_NUM           = '134'
          I_MV1           = 'CL_ISHMED_CANCEL_TREE'
          I_LAST          = space.
      exit.
    endif.

*   Manuelle Übersteuerung der Feldeinstellungen
    loop at lt_fieldcat into l_fcat.
      case l_fcat-fieldname.
*       Technische Felder speziell kennzeichnen
        when 'OBJECT'     or
             'EINRI'      or
             'FALNR'      or
             'LNRLS'      or
             'LFDBEW'     or
             'LFDDIA'     or
             'ZPID'       or
             'AVB_LFDNR'  or
             'LNRLM'      or
             'LNRIC'      or
             'DOKAR'      or
             'DOKNR'      or
             'DOKVR'      or
             'DOKTL'      or
             'LFDDOK'     or
             'DATATYPE'   or
             'LINE_KEY'   or
             'PATNR'      or
             'PAPID'      or
             'GROUP_NR'   or
             'DEPENDENT'  or
             'NODE_KEY'   or
             'TYPE'       or
             'PATNAME'    or
             'ICON'       or
             'MARK'       or
             'CAUSECHNG'  or
             'CAUSEICON'.
          l_fcat-tech   = on.
          l_fcat-no_out = on.

        when 'CAOU'.
          l_fcat-col_pos   = 1.
          l_fcat-outputlen = 13.

        when 'CADATE'.
          l_fcat-col_pos   = 2.
          l_fcat-outputlen = 13.

        when 'CATIME'.
          l_fcat-col_pos   = 3.
          l_fcat-edit_mask = '__:__'.
          l_fcat-outputlen = 7.

        when 'CASTATE'.
          l_fcat-col_pos   = 4.
          l_fcat-outputlen = 7.

        when 'CAKEY'.
          l_fcat-col_pos   = 5.
          l_fcat-outputlen = 13.

        when 'CATEXT'.
          l_fcat-col_pos   = 6.
          l_fcat-outputlen = 35.

        when 'CAGPART'.
          l_fcat-col_pos   = 7.
          l_fcat-outputlen = 13.

        when 'CACLASS'.
          l_fcat-outputlen = 13.

        when 'CACOICON'.
          l_fcat-icon      = on.
      endcase.
      modify lt_fieldcat from l_fcat.
    endloop.
    check e_rc = 0.
    ct_fieldcat[] = lt_fieldcat[].
  else.
*   Wird noch nicht unterstützt
    exit.
  endif.
endmethod.


method BUILD_FUNCTIONS.
  data: l_func like line of ct_function.

* Initialisierungen
  e_rc = 0.
  if c_errorhandler is initial.
    CREATE OBJECT c_errorhandler.
  endif.

  refresh ct_function.

* Kalkulations-Funktionen
  l_func = cl_gui_alv_tree=>mc_fc_calculate_avg.
  insert l_func into table ct_function.
  l_func = cl_gui_alv_tree=>mc_fc_calculate_max.
  insert l_func into table ct_function.
  l_func = cl_gui_alv_tree=>mc_fc_calculate_min.
  insert l_func into table ct_function.
  l_func = cl_gui_alv_tree=>mc_fc_calculate_sum.
  insert l_func into table ct_function.
  l_func = cl_gui_alv_tree=>mc_fc_calculate.
  insert l_func into table ct_function.

** Drucken
*  l_func = cl_gui_alv_grid=>mc_fc_print.
*  insert l_func into table ct_function.
*  l_func = cl_gui_alv_grid=>mc_fc_print_back.
*  insert l_func into table ct_function.
** Exportieren
*  l_func = cl_gui_alv_grid=>mc_mb_export.
*  insert l_func into table ct_function.
** Grafik anzeigen
*  l_func = cl_gui_alv_grid=>mc_fc_graph.
*  insert l_func into table ct_function.
** Einfügen in neue Zeile
*  l_func = cl_gui_alv_grid=>mc_fc_loc_paste_new_row.
*  insert l_func into table ct_function.
endmethod.


method BUILD_HIERARCHY_HEADER.
  clear c_header.
  c_header-heading   = 'Patient'(001).
  c_header-tooltip   = c_header-heading.
  c_header-width     = 35.
  c_header-width_pix = space.
endmethod.


method BUILD_MAINOBJ_LIGHT.
  data: lt_cancel_hier type ishmed_t_cancel_hierarchy,
        l_cancel_hier  type rn1cancel_hierarchy,
        l_cancel_h2    type rn1cancel_hierarchy,
        l_mandatory    type ish_on_off,
        lt_msg         type ishmed_t_messages,
        l_msgtype      type c.

* Initialisierungen
  e_icon = icon_green_light.

* Zuerst feststellen, ob es sich beim übergebenen Objekt auch
* wirklich um ein Hauptobjekt handelt. Denn nur dort dürfen
* überhaupt Ampeln ausgegeben werden
  refresh lt_cancel_hier.
  CALL METHOD i_cancel->get_data
    IMPORTING
      ET_CANCEL_HIERARCHY = lt_cancel_hier.
  if not i_outtab-object is initial.
    read table lt_cancel_hier into l_cancel_hier
               with key micro-object = i_outtab-object
                        level        = 1.
  elseif not i_outtab-lfdbew is initial.
    read table lt_cancel_hier into l_cancel_hier
               with key micro-einri  = i_outtab-einri
                        micro-falnr  = i_outtab-falnr
                        micro-lfdbew = i_outtab-lfdbew
                        level        = 1.
  endif.
  check sy-subrc = 0.

* Fehlermeldungen aus dem Errorhandler holen. Dabei sind besonders
* die Spalten OBJECT und LINE_KEY wichtig, denn damit kann man
* die fehlerhaften Objekte identifizieren
  refresh lt_msg.
  CALL METHOD i_errorhandler->get_messages
    IMPORTING
      T_EXTENDED_MSG  = lt_msg.

* Nun feststellen, ob eines der Objekte im Errorhandler enthalten
* ist. Wenn ja, dann muss die Ampel <> Grün gesetzt werden
* Ob die Ampel nun gelb oder rot ist, entscheidet sie wie folgt:
* (Siehe auch Nr 9682, Punkt 27)
* 'E'-Meldung UND Mandatory => Ampel ist rot, weil dieses Objekt
*     unbedingt mitstorniert werden muss
* 'W'-Meldung ODER nicht Mandatory => Ampel ist gelb, da das Obj
*     entweder eh storniert werden darf (Warnung) oder nicht
*     unbedingt mitstorniert werden muss (nicht Mandatory)
* Dazu die Hierarchietabelle rekursiv durchsuchen
  CALL METHOD cl_ishmed_cancel_tree=>search_recursive_hierarchy
    EXPORTING
      i_keyfields    = l_cancel_hier-micro
      i_mandatory    = on
      i_initialize   = on
      it_msg         = lt_msg
      it_cancel_hier = lt_cancel_hier
    IMPORTING
      E_MSGTYPE      = l_msgtype
      E_MANDATORY    = l_mandatory.
  if l_msgtype = 'E'.
    e_icon = icon_red_light.
  elseif l_msgtype = 'W'.
    e_icon = icon_yellow_light.
  else.
*   Ist eines der untergeordneten Objekte optional, muss auch
*   eine gelbe Ampel ausgegeben werden!
    if l_mandatory = off.
      e_icon = icon_yellow_light.
    else.
      e_icon = icon_green_light.
    endif.
  endif.
endmethod.


METHOD build_outtab.
  DATA: lt_obj         TYPE ish_objectlist,
        l_obj          TYPE ish_object,
        l_vnlei        TYPE vnlei,
        l_vn2zeiten    TYPE vn2zeiten,
        l_vn2ok        TYPE vn2ok,
        l_vnmatv       TYPE vnmatv,
        l_vnbew        TYPE vnbew,
        l_vndia        TYPE vndia,
        l_vnicp        TYPE vnicp,
        l_vn1fat       TYPE vn1fat,
        l_rndoc        TYPE rndoc.
  DATA: l_type         TYPE i,
        l_flag         TYPE ish_on_off,
        l_rc           TYPE ish_method_rc,
        l_no_outtab    TYPE ish_on_off,
        l_environment  TYPE REF TO cl_ish_environment.
  DATA: lt_cancel_data TYPE ishmed_t_cancel_datas,
        l_cancel_data  TYPE LINE OF ishmed_t_cancel_datas,
        l_outtab       LIKE LINE OF gt_outtab.

* Käfer, ID: 12776 - Begin
  DATA: l_nfal         TYPE nfal.
* Käfer, ID: 12776 - End

* GROUP_NR: Gruppierungsnummer: Diese Nummer ist bei allen Sätzen
* die einem übergeordneten Objekt zugeordnet sind gleich, d.h.
* damit werden alle Datensätze zu einem übergeordneten Objekt
* gruppiert
  DATA: l_group_nr     TYPE rn1cancel_tree_fields-group_nr.

* Initialisierungen
  e_rc = 0.
  REFRESH: et_outtab,
           lt_obj.
  CLEAR: l_environment.

  CALL METHOD i_cancel->get_data
    IMPORTING
      et_cancel_data = lt_cancel_data
      e_environment  = l_environment.

* ---------------------------------------------------------
* Objekte, die in objektorientierter Form vorliegen
  l_group_nr = 1.
  LOOP AT lt_cancel_data INTO l_cancel_data.
    l_no_outtab = off.
*   Übergeordnetes Objekt, das der Benutzer stornieren
*   möchte auswerten. Daraus kommt die Zuordnung zu einem
*   Patienten/vorl.Patienten und auch die zweite Ebene mit
*   den zu stornierenden Daten
*   Objektorientierte Daten
    IF NOT l_cancel_data-object IS INITIAL.
*     Im Tree werden nur Objekte gezeigt, die noch nicht das
*     Stornoflag gesetzt haben. Denn vor allem in der Vormerkung
*     wird ja das Storno mehrmals aufgerufen und es darf nicht
*     sein, dass dieselben (bereits stornierten) Objekte immer
*     wieder auftauchen
      CALL METHOD l_cancel_data-object->('IS_CANCELLED')
        IMPORTING
          e_cancelled = l_flag.
      CHECK l_flag = off.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_object
        EXPORTING
          i_dependent    = space    " Übergeordnetes Objekt
          i_object       = l_cancel_data-object
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
          e_no_outtab    = l_no_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
    ENDIF.

*   Bewegung
    IF NOT l_cancel_data-lfdnr IS INITIAL.
      READ TABLE l_cancel_data-t_vnbew INTO l_vnbew
                 WITH KEY einri = l_cancel_data-einri
                          falnr = l_cancel_data-falnr
                          lfdnr = l_cancel_data-lfdnr.
      IF sy-subrc = 0.
        CALL METHOD cl_ishmed_cancel_tree=>outtab_from_nbew
          EXPORTING
            i_dependent    = space    " Übergeordnetes Objekt
            i_nbew         = l_vnbew
          IMPORTING
            e_rc           = l_rc
            e_outtab       = l_outtab
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
        ENDIF.
      ENDIF.
    ENDIF.
*   Datensatz nur einfügen, wenn das auch sein soll, d.h. wenn
*   NO_OUTTAB <> ON!
    CHECK l_no_outtab <> on.

    l_outtab-group_nr = l_group_nr.
    APPEND l_outtab TO et_outtab.

*   -------------------------------------------------------
*   Alle untergeordneten Objekte, die storniert werden müssen
*   (bzw. dürfen), weil das übergeordnete Objekt storniert werden
*   muss
    LOOP AT l_cancel_data-t_obj INTO l_obj.
*     Das erste Objekt ist identisch mit dem übergeordneten Objekt
      CHECK l_obj-object <> l_cancel_data-object.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_object
        EXPORTING
          i_dependent    = 'X'    " untergeordnetes Objekt
          i_object       = l_obj-object
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
          e_no_outtab    = l_no_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      CHECK l_no_outtab <> on.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

*   -------------------------------------------------------
*   Alle untergeordneten nicht objektorientierten Daten wie
*   Diagnosen, Bewegungen usw.
*   BEWEGUNG
    LOOP AT l_cancel_data-t_vnbew INTO l_vnbew.
*     Die erste Bewegung ist identisch mit der übergeordneten Bew.
      CHECK l_vnbew-einri <> l_cancel_data-einri  OR
            l_vnbew-falnr <> l_cancel_data-falnr  OR
            l_vnbew-lfdnr <> l_cancel_data-lfdnr.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_nbew
        EXPORTING
          i_dependent    = 'X'    " untergeordnetes Objekt
          i_nbew         = l_vnbew
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

*   Käfer, ID: 12776 - Begin
*   CASE
*   the case must also be displayed at the storno-dialog, so
*   create an outtab-entry for the case
*   change from case-structure to an internal table to be able
*   to handle more than one case
*    if not l_cancel_data-s_nfal is initial.
*      l_nfal = l_cancel_data-s_nfal.
    LOOP AT l_cancel_data-t_nfal INTO l_nfal.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_nfal
        EXPORTING
          i_dependent     = on
          is_nfal         = l_nfal
        IMPORTING
          es_outtab       = l_outtab
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = c_errorhandler.

      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.
*    endif.
*   Käfer, ID: 12776 - End

*   DIAGNOSE
    LOOP AT l_cancel_data-t_vndia INTO l_vndia.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_ndia
        EXPORTING
          i_dependent    = 'X'    " untergeordnetes Objekt
          i_ndia         = l_vndia
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

*   MATERIAL (NMATV)
    LOOP AT l_cancel_data-t_vnmatv INTO l_vnmatv.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_nmatv
        EXPORTING
          i_dependent    = 'X'
          i_nmatv        = l_vnmatv
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

*   OP-Zeiten
    LOOP AT l_cancel_data-t_vn2zeiten INTO l_vn2zeiten.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_n2zeiten
        EXPORTING
          i_dependent    = 'X'
          i_n2zeiten     = l_vn2zeiten
          i_environment  = l_environment
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

*   OP-Komplikationen
    LOOP AT l_cancel_data-t_vn2ok INTO l_vn2ok.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_n2ok
        EXPORTING
          i_dependent    = 'X'
          i_n2ok         = l_vn2ok
          i_environment  = l_environment
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

*   Krankenfahrauftrag
    LOOP AT l_cancel_data-t_vn1fat INTO l_vn1fat.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_n1fat
        EXPORTING
          i_dependent    = 'X'
          i_n1fat        = l_vn1fat
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

*   ISH-Leistung
*   Nr 9682, 41: ISH-Leistungen werden überhaupt nicht ausgegeben
*    loop at l_cancel_data-t_vnlei into l_vnlei.
*      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_nlei
*        EXPORTING
*          I_DEPENDENT    = 'X'
*          I_NLEI         = l_vnlei
*        IMPORTING
*          E_RC           = l_rc
*          E_OUTTAB       = l_outtab
*        CHANGING
*          C_ERRORHANDLER = c_errorhandler.
*      if l_rc <> 0.
*        e_rc = l_rc.
*      endif.
*      l_outtab-group_nr = l_group_nr.
*      append l_outtab to et_outtab.
*    endloop.

*   Dokument
    LOOP AT l_cancel_data-t_vndoc INTO l_rndoc.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_ndoc
        EXPORTING
          i_dependent    = 'X'
          i_ndoc         = l_rndoc
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

*   ICPM-Prozedur
    LOOP AT l_cancel_data-t_vnicp INTO l_vnicp.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_nicp
        EXPORTING
          i_dependent    = 'X'
          i_nicp         = l_vnicp
        IMPORTING
          e_rc           = l_rc
          e_outtab       = l_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
      l_outtab-group_nr = l_group_nr.
      APPEND l_outtab TO et_outtab.
    ENDLOOP.

    l_group_nr = l_group_nr + 1.
  ENDLOOP.   " loop at lt_obj
ENDMETHOD.


METHOD build_patient_data.

  DATA: l_pattext     TYPE lvc_value,
        l_patname     TYPE lvc_value,
        l_type        TYPE i,
        l_rc          TYPE ish_method_rc,
        l_environment TYPE REF TO cl_ish_environment,
        l_prov_pat    TYPE REF TO cl_ish_patient_provisional,
        lr_identify   TYPE REF TO if_ish_identify_object.

  CLEAR: e_pattext,
         e_patname,
         l_prov_pat,
         l_environment.

  IF i_patnr IS INITIAL  AND
     i_papid IS INITIAL  AND
     NOT i_object IS INITIAL.
*   Keine PATNR und PAPID übergeben => Eventuell handelt es sich
*   um ein ganz neues (noch nicht gespeichertes) Objekt, das
*   storniert werden muss. In diesem Fall kann ein Vorläufiger Pat.
*   mit dem Objekt verbunden sein
    lr_identify ?= i_object.
    CALL METHOD cl_ish_utl_base_patient=>get_pap_for_object
      EXPORTING
        i_object  = lr_identify
      IMPORTING
        e_pap_obj = l_prov_pat
        e_rc      = l_rc.
  ENDIF.

  CALL METHOD cl_ishmed_patorg=>create_patstring
    EXPORTING
      i_mandt     = sy-mandt
      i_patnr     = i_patnr
      i_papid     = i_papid
      i_prov_pat  = l_prov_pat
    IMPORTING
      e_patstring = l_pattext
      e_patname   = l_patname.

  e_pattext = l_pattext.
  e_patname = l_patname.

ENDMETHOD.


method BUILD_TYPE_TEXT.
  data: l_todo_text(20)   type c,
        l_type_text(30)   type c,
        l_text_plural(30) type c,
        l_text(10)        type c,
        l_rc              type ish_method_rc.

  clear: e_type_text,
         e_count_node,
         l_type_text,
         l_text_plural,
         l_todo_text.

* Zuerst den Typtext und das Plural davon ermitteln
  CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
    EXPORTING
      I_OBJECT             = i_outtab-object
      I_DATA_NAME          = i_outtab-datatype
    IMPORTING
      E_RC                 = l_rc
      E_TEXT               = l_type_text
      E_TEXT_PLURAL        = l_text_plural.

* Weiteren Text ermitteln
  check not i_outtab-type is initial.
  case i_outtab-type.
    when co_service.
      l_todo_text   = 'werden storniert'(003).

    when co_request.
      l_todo_text   = 'werden storniert'(003).

    when co_prereg.
      l_todo_text   = 'werden storniert'(003).

    when co_appmnt.
      l_todo_text   = 'werden storniert'(003).

    when co_vitpar.
      l_todo_text   = 'werden storniert'(003).

    when co_diagnosis.
      l_todo_text   = 'werden gelöscht'(004).

    when co_ndoc.
      l_todo_text   = 'werden gelöscht'(004).

    when others.
      l_todo_text   = 'werden storniert'(003).
**     Typ hier nicht explizit angegeben => Wenn ein Objekt
**     angegeben ist, wird dort nach dieser Methode gesucht
*      if not i_outtab-object is initial.
*        CATCH SYSTEM-EXCEPTIONS dynamic_call_method_errors = 1.
*          CALL METHOD i_outtab-object->('BUILD_TYPE_TEXT')
*            EXPORTING
*              I_COUNT       = i_count
*            IMPORTING
*              E_TYPE_TEXT   = e_type_text
*              E_TEXT_PLURAL = e_text_plural
*              E_COUNT_NODE  = e_count_node.
*        ENDCATCH.
*      endif.
  endcase.

  if e_count_node is requested.
    clear l_text.
    l_text = i_count.
    condense l_text no-gaps.
    concatenate '(' l_text ')'
                into l_text.
    concatenate l_text_plural l_text l_todo_text
                into e_count_node
                separated by space.
  endif.
  e_type_text   = l_type_text.
  e_text_plural = l_text_plural.
endmethod.


METHOD change_hierarchy_mark_table .


******** DATA-DECLARATIONS ******
  DATA: l_checked            TYPE ish_on_off,
        l_cramp_clicked      TYPE ish_on_off,
        ls_cancel_hierarchy  TYPE rn1cancel_hierarchy,
        ls_cancel_hierarchy2 TYPE rn1cancel_hierarchy,
        lt_mark              TYPE ishmed_t_cancel_mark,
        ls_mark              TYPE rn1cancel_mark,
        ls_outtab            TYPE rn1cancel_tree_fields,
        lr_identify_object   TYPE REF TO if_ish_identify_object,
        lr_service           TYPE REF TO cl_ishmed_service,
        lr_cordpos           TYPE REF TO cl_ishmed_prereg,
        ls_n1vkg             TYPE n1vkg,
        lr_appmnt            TYPE REF TO cl_ish_appointment,
        ls_ntmn              TYPE ntmn,
        ls_nbew              TYPE nbew,
        ls_nlei              TYPE nlei,
        l_falnr              TYPE nfal-falnr,
        l_rc                 TYPE ish_method_rc,
        ls_nicp              TYPE nicp,
        ls_nicp2             TYPE nicp,
        l_case_exists        TYPE ish_on_off,
        l_index              TYPE i,
        ls_nfal              TYPE nfal,
        lt_cancel_hierarchy  TYPE ishmed_t_cancel_hierarchy,
        lt_nbew              TYPE STANDARD TABLE OF nbew,
        l_count              TYPE i,
        lt_objects           TYPE ish_objectlist,
        ls_object            TYPE ish_object,
        lt_cancel_hier       TYPE ishmed_t_cancel_hierarchy,
        ls_cancel_hier       TYPE rn1cancel_hierarchy,
        l_is_op              TYPE ish_on_off,
        lt_cancel_hier2      TYPE ishmed_t_cancel_hierarchy,
        lt_cancel_hier3      TYPE ishmed_t_cancel_hierarchy.

****** INITIALIZATIONS *******

  CLEAR:   ls_nbew,
           ls_nlei,
           lr_service,
           lr_identify_object,
           l_checked,
           l_cramp_clicked,
           ls_mark,
           ls_cancel_hierarchy,
           ls_cancel_hierarchy2,
           ls_outtab.

  REFRESH: lt_mark,
           lt_cancel_hierarchy,
           lt_nbew.

  l_checked = i_checked.
  l_cramp_clicked = i_cramp_clicked.
  e_append_hierarchy = off.

* the checkbox of a movement was now deactivated.

  IF l_checked = off.

*   is the case to this movement within the storno-list
*   and is the deactivated movement in the hierarchy-table
*   directly connected to the case
    READ TABLE ct_cancel_hierarchy INTO ls_cancel_hierarchy
         WITH KEY micro-datatype = 'NFAL'
                  macro-datatype = 'NBEW'
                  macro-line_key = is_outtab-line_key.

*   the case is whithin the storno - list
    IF sy-subrc = 0.
      l_falnr = ls_cancel_hierarchy-micro-falnr.


*     OPTIONALIZATION of MATERIALS AND PROCEDURES
*     set for all materials and procedures which are connected
*     to this case over the service the mandatory flag to off, so
*     that they are deactivated too
      LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
             WHERE ( micro-datatype = 'NMATV' OR
                     micro-datatype = 'NICP' )
               AND NOT macro-object IS INITIAL.
*               AND mandatory = on.

        CLEAR lr_identify_object.
        lr_identify_object ?= ls_cancel_hierarchy-macro-object.

*       now check, whether the material is connected to a service,
*       which now will be not cancelled, so the mandatory flag in
*       the hierarchy-table for the material must be set to ON and
*       the mark - flag in the mark-table have to be set to OFF.
        IF lr_identify_object->is_inherited_from(
            cl_ishmed_service=>co_otype_med_service ) = on OR
           lr_identify_object->is_inherited_from(
            cl_ishmed_service=>co_otype_anchor_srv ) = on.

          CLEAR: lr_service,
                 ls_nlei.

          lr_service ?= ls_cancel_hierarchy-macro-object.

          CALL METHOD lr_service->get_data
            EXPORTING
              i_fill_service = off
            IMPORTING
              e_rc           = l_rc
              e_nlei         = ls_nlei.

          IF l_rc = 0 AND ls_nlei-falnr = l_falnr.
*           when a movement sequence was deactivated
*           all materials and procedures, which are connected
*           to the deactivated movements over the service, must
*           be marked and the mandatory flag must be set to ON,
*           so that these objects will not be editable.
            IF l_cramp_clicked = on.
              READ TABLE it_outtab TRANSPORTING NO FIELDS
                WITH KEY lfdbew   = ls_nlei-lfdbew
                         datatype = 'NBEW'.
              IF sy-subrc = 0.
                CLEAR ls_mark.
                LOOP AT ct_mark INTO ls_mark WHERE
                      line_key = ls_cancel_hierarchy-micro-line_key.
                  ls_mark-mark = off.
                  MODIFY ct_mark FROM ls_mark.
                  ls_cancel_hierarchy-mandatory = on.
                  MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy.

                ENDLOOP.
              ELSE.
                IF ls_cancel_hierarchy-micro-datatype = 'NICP'.
                  LOOP AT ct_mark INTO ls_mark WHERE
                      line_key = ls_cancel_hierarchy-micro-line_key.
                    ls_mark-mark = off.
                    MODIFY ct_mark FROM ls_mark.
                  ENDLOOP.
                ENDIF.
                ls_cancel_hierarchy-mandatory = off.
                MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy.
              ENDIF.
            ELSE.

              CALL METHOD ir_cancel->get_data
                IMPORTING
                  et_cancel_hierarchy = lt_cancel_hierarchy.

*             demark the procedures only, when the case is within the
*             actual hierarchy from instance g_cancel.
              READ TABLE lt_cancel_hierarchy TRANSPORTING NO FIELDS
                WITH KEY micro-datatype = 'NFAL'
                         micro-falnr    = is_outtab-falnr.

              IF sy-subrc = 0.
                IF ls_cancel_hierarchy-micro-datatype = 'NICP'.
                  LOOP AT ct_mark INTO ls_mark
                    WHERE line_key = ls_cancel_hierarchy-micro-line_key.
                    ls_mark-mark = off.
                    MODIFY ct_mark FROM ls_mark.
                  ENDLOOP.
                ENDIF.
              ENDIF.
*             make the corresponding checkbox editable
              ls_cancel_hierarchy-mandatory = off.
              MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.
*   the deactivated movement is not directly connected to the case
*   within the hierarchy-table. A movement-sequence was deactivated
*   so for all materials and procedures the mandatory-flag must be set
*   to off, except for the materials, which are connected via service
*   to the deactivated movements.
*   For these materials and procedures the MARK-flag must be set to off
*   and the mandatory-flag to ON
    ELSEIF l_cramp_clicked = on.
      LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
           WHERE ( micro-datatype = 'NMATV' OR
                   micro-datatype = 'NICP' )
             AND NOT macro-object IS INITIAL.
*             AND mandatory = off.

        CLEAR lr_identify_object.
        lr_identify_object ?= ls_cancel_hierarchy-macro-object.

*         now check, whether the material is connected to a service,
*         which now will be not cancelled, so the mandatory flag in
*         the hierarchy-table for the material must be set to ON and
*         the mark - flag in the mark-table have to be set to OFF.
        IF lr_identify_object->is_inherited_from(
                cl_ishmed_service=>co_otype_med_service ) = on OR
           lr_identify_object->is_inherited_from(
                cl_ishmed_service=>co_otype_anchor_srv ) = on.

          CLEAR: lr_service,
                 ls_nlei.

          lr_service ?= ls_cancel_hierarchy-macro-object.

          CALL METHOD lr_service->get_data
            EXPORTING
              i_fill_service = off
            IMPORTING
              e_rc           = l_rc
              e_nlei         = ls_nlei.

          IF l_rc = 0 AND ls_nlei-falnr = is_outtab-falnr.
            READ TABLE it_outtab TRANSPORTING NO FIELDS
              WITH KEY lfdbew   = ls_nlei-lfdbew
                       datatype = 'NBEW'.
            IF sy-subrc = 0.
              CLEAR ls_mark.
              LOOP AT ct_mark INTO ls_mark WHERE
                    line_key = ls_cancel_hierarchy-micro-line_key.
                ls_mark-mark = off.
                MODIFY ct_mark FROM ls_mark.
                ls_cancel_hierarchy-mandatory = on.
                MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy.

              ENDLOOP.
            ELSE.
              ls_cancel_hierarchy-mandatory = off.
              MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.
*   the movment, which was deactivated is not part of a movement

    ELSE.
*     first check whether the case of the movement is within the
*     hierarchy-table. if this is the case for all materials and
*     procedures which are connected to this case (movement) via
*     service the mandatory-flag must be set to OFF.
      CLEAR l_case_exists.
      LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
          WHERE micro-datatype = 'NFAL'.

        IF ls_cancel_hierarchy-micro-falnr = is_outtab-falnr.
          l_case_exists = on.
          EXIT.
        ENDIF.
      ENDLOOP.

      IF l_case_exists = on.
        LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
             WHERE ( micro-datatype = 'NMATV' OR
                     micro-datatype = 'NICP' )
               AND NOT macro-object IS INITIAL.
*               AND mandatory = on.

          CLEAR lr_identify_object.
          lr_identify_object ?= ls_cancel_hierarchy-macro-object.

*         now check, whether the material is connected to a service,
*         which now will be not cancelled, so the mandatory flag in
*         the hierarchy-table for the material must be set to ON and
*         the mark - flag in the mark-table have to be set to OFF.
          IF lr_identify_object->is_inherited_from(
                  cl_ishmed_service=>co_otype_med_service ) = on OR
             lr_identify_object->is_inherited_from(
                  cl_ishmed_service=>co_otype_anchor_srv ) = on.

            CLEAR: lr_service,
                   ls_nlei.

            lr_service ?= ls_cancel_hierarchy-macro-object.

            CALL METHOD lr_service->get_data
              EXPORTING
                i_fill_service = off
              IMPORTING
                e_rc           = l_rc
                e_nlei         = ls_nlei.

            IF l_rc = 0 AND ls_nlei-falnr = is_outtab-falnr.

              CALL METHOD ir_cancel->get_data
                IMPORTING
                  et_cancel_hierarchy = lt_cancel_hierarchy.

*             demark the procedures only, when the case is within the
*             actual hierarchy from instance g_cancel.
              READ TABLE lt_cancel_hierarchy TRANSPORTING NO FIELDS
                WITH KEY micro-datatype = 'NFAL'
                         micro-falnr    = is_outtab-falnr.

              IF sy-subrc = 0.
                IF ls_cancel_hierarchy-micro-datatype = 'NICP'.
                  LOOP AT ct_mark INTO ls_mark
                    WHERE line_key = ls_cancel_hierarchy-micro-line_key.
                    ls_mark-mark = off.
                    MODIFY ct_mark FROM ls_mark.
                  ENDLOOP.
                ENDIF.
              ENDIF.
              ls_cancel_hierarchy-mandatory = off.
              MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.

    ENDIF.

*** OPTIONALIZATION of ORDERPOSITIONS
*** when the movement was deactivated, the case will automatically will
*   be deactivated, so select all orderpositions, which are connected to
*   this case and set the mandatory-flag to off and put the
*   orderposition into mark table with mark = OFF

***** ATTENTION, check only the orderpositions, with this case
*     this check must be inserted the next time. !!!!!!!

    CLEAR l_case_exists.
    LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
      WHERE micro-datatype = 'NFAL'.

      IF ls_cancel_hierarchy-micro-falnr = is_outtab-falnr.
        l_case_exists = on.
*       Select the hierarchy down the case. this is necessary for
*       the right optionalization of the orderposition, because
*       for an orderposition, which is in the hierarchy under the case
*       its mandatory flag must not be changed (set to off)
        REFRESH lt_cancel_hier.
        CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
          EXPORTING
            i_initialize   = on
            i_line_key     = ls_cancel_hierarchy-micro-line_key
            it_cancel_hier = ct_cancel_hierarchy
          IMPORTING
            et_cancel_hier = lt_cancel_hier.

        EXIT.
      ENDIF.
    ENDLOOP.

*   Käfer, ID: 13995 - Begin
*   if a movement-sequence was deactivated, select the hierarchy
*   down the deactivated movements, because the flag MANDATORY for the
*   orderpositions, which are within this hierarchy must not be set to
*   off. -> no optionalization
    IF l_cramp_clicked = on.
      REFRESH: lt_cancel_hier3,
               lt_cancel_hier2.
      LOOP AT it_outtab INTO ls_outtab.
        REFRESH lt_cancel_hier2.
        CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
          EXPORTING
            i_initialize   = on
            i_line_key     = ls_outtab-line_key
            it_cancel_hier = ct_cancel_hierarchy
          IMPORTING
            et_cancel_hier = lt_cancel_hier2.

        APPEND LINES OF lt_cancel_hier2 TO lt_cancel_hier3.

      ENDLOOP.
    ENDIF.
*   Käfer, ID: 13995 - End

    IF l_case_exists = on.
      LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
        WHERE NOT micro-object IS INITIAL.
        CLEAR lr_identify_object.
        lr_identify_object ?= ls_cancel_hierarchy-micro-object.
        IF lr_identify_object->is_inherited_from(
           cl_ishmed_prereg=>co_otype_prereg ) = on.

          CHECK NOT ls_cancel_hierarchy-macro-object IS INITIAL.
          CLEAR lr_identify_object.
          lr_identify_object ?= ls_cancel_hierarchy-macro-object.
          IF lr_identify_object->is_inherited_from(
            cl_ish_corder=>co_otype_corder ) = on.
            CONTINUE.
          ENDIF.
*         if the orderposition is selected to the case (in hierarchy
*         under case) -> the mandatory flag must not be set to off.
          READ TABLE lt_cancel_hier TRANSPORTING NO FIELDS
            WITH KEY micro-object = ls_cancel_hierarchy-micro-object.
          IF sy-subrc = 0.
            LOOP AT ct_mark INTO ls_mark
              WHERE object = ls_cancel_hierarchy-micro-object.
              ls_mark-mark = off.
              MODIFY ct_mark FROM ls_mark.
            ENDLOOP.
            CONTINUE.
          ENDIF.

*         Käfer, ID: 13995 - Begin
*         is the current orderposition within the hierarchy under the
*         deactivated movements do not set the flag Mandatory to OFF
*         only set the MARK-FLAG in MARK-TABLE to OFF
          IF l_cramp_clicked = on.
            READ TABLE lt_cancel_hier3 TRANSPORTING NO FIELDS
              WITH KEY micro-object = ls_cancel_hierarchy-micro-object.
            IF sy-subrc = 0.
              LOOP AT ct_mark INTO ls_mark
                WHERE object = ls_cancel_hierarchy-micro-object.
                ls_mark-mark = off.
                MODIFY ct_mark FROM ls_mark.
              ENDLOOP.
              CONTINUE.
            ENDIF.
          ENDIF.
*         Käfer, ID: 13995 - End
          lr_cordpos ?= ls_cancel_hierarchy-micro-object.

*         Käfer, ID: 13995 - Begin
          CLEAR l_is_op.
          CALL METHOD lr_cordpos->is_op
            IMPORTING
              e_is_op = l_is_op
              e_rc    = l_rc.

          IF l_rc <> 0.
            CLEAR l_is_op.
          ENDIF.

          IF l_is_op = on.
            LOOP AT ct_mark INTO ls_mark
              WHERE object = ls_cancel_hierarchy-micro-object.
              ls_mark-mark = off.
              MODIFY ct_mark FROM ls_mark.
            ENDLOOP.
            CONTINUE.
          ENDIF.
*         Käfer, ID: 13995 - End

          CLEAR ls_n1vkg.
          CALL METHOD lr_cordpos->get_data
            IMPORTING
              e_n1vkg = ls_n1vkg.

          IF ls_n1vkg-falnr = is_outtab-falnr.

            ls_cancel_hierarchy-mandatory = off.
            MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy.
            LOOP AT ct_mark INTO ls_mark
              WHERE object = ls_cancel_hierarchy-micro-object.
              ls_mark-mark = off.
              MODIFY ct_mark FROM ls_mark.
            ENDLOOP.
          ENDIF.
        ENDIF.
*       search for all appointments to this case, which will be
*       deactivated right now and which is also the main-object
*       of storno. if an appointment was found select all Services
*       to this appointment and set the mandatory flag to off and
*       set the mark flag in mark-table to off.
        IF lr_identify_object->is_inherited_from(
          cl_ish_appointment=>co_otype_appointment ) = on.
          CHECK ls_cancel_hierarchy-macro-object IS INITIAL
            AND ls_cancel_hierarchy-macro-line_key IS INITIAL.

          lr_appmnt ?= ls_cancel_hierarchy-micro-object.
          CLEAR ls_ntmn.
          CALL METHOD lr_appmnt->get_data
            EXPORTING
              i_fill_appointment = off
            IMPORTING
              es_ntmn            = ls_ntmn.

          IF ls_ntmn-falnr = is_outtab-falnr.
            REFRESH lt_objects.
            CALL METHOD cl_ish_appointment=>get_services_for_appmnt
              EXPORTING
                i_empty_services = off
                i_appointment    = lr_appmnt
              IMPORTING
                et_services      = lt_objects.

            IF NOT lt_objects IS INITIAL.
              LOOP AT lt_objects INTO ls_object.
               READ TABLE ct_cancel_hierarchy INTO ls_cancel_hierarchy2
                 WITH KEY micro-object = ls_object-object.
                IF sy-subrc = 0.
                  ls_cancel_hierarchy2-mandatory = off.
                  MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy2
                      INDEX sy-tabix.
                  LOOP AT ct_mark INTO ls_mark
                    WHERE object = ls_object-object.
*                   Käfer, ID: 13995 - Begin
*                   now its default, that the services will be marked
*                   when the appointment will be cancelled as main-
*                   object
                    ls_mark-mark = on.
*                    ls_mark-mark = off.
*                   Käfer, ID: 13995 - End
                    MODIFY ct_mark FROM ls_mark.
                  ENDLOOP.
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDLOOP.

    ELSE.
      IF l_cramp_clicked = on.
*       if a movement-sequence was deactivated, but the case is not
*       within the storno-list the the flag MANDATORY for the
*       orderpositions which are directly connected to the movements
*       which will be deactivated now, must set to ON (no
*       optionalization) and the MARK-FLAG must be set to off.
        LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
          WHERE NOT micro-object IS INITIAL.
          CLEAR lr_identify_object.
          lr_identify_object ?= ls_cancel_hierarchy-micro-object.
          IF lr_identify_object->is_inherited_from(
            cl_ishmed_prereg=>co_otype_prereg ) = on.

            CHECK NOT ls_cancel_hierarchy-macro-object IS INITIAL.
            CLEAR lr_identify_object.
            lr_identify_object ?= ls_cancel_hierarchy-macro-object.
            IF lr_identify_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
              CONTINUE.
            ENDIF.

*           check whether the orderposition is within the hierarchy,
*           under the movements which will be deactivated
*           if this is the case the mandatory flag must be set to on
*           and the flag mark in mark-table must be set to off.
            READ TABLE lt_cancel_hier3 TRANSPORTING NO FIELDS
              WITH KEY micro-object = ls_cancel_hierarchy-micro-object.
            IF sy-subrc = 0.
              ls_cancel_hierarchy-mandatory = on.
              MODIFY ct_cancel_hierarchy FROM ls_cancel_hierarchy.
              LOOP AT ct_mark INTO ls_mark
                WHERE object = ls_cancel_hierarchy-micro-object.
                ls_mark-mark = off.
                MODIFY ct_mark FROM ls_mark.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.

* the chechbox for a movement or a movement - sequence was activated
  ELSE.

    READ TABLE ct_cancel_hierarchy INTO ls_cancel_hierarchy
      WITH KEY micro-datatype = 'NFAL'
               micro-falnr    = is_outtab-falnr
               macro-datatype = 'NBEW'
               macro-lfdbew   = is_outtab-lfdbew.

*   the activated movement is directly connected to the case
*   within the storno hierarchy (ct_cancel_hierarchy)
    IF sy-subrc = 0.
*     movement-sequence.
      IF l_cramp_clicked = on.
        REFRESH ct_mark.
        EXIT.
      ELSE.

*       movement directly under case -> check whether all
*       movements of the case are within the hierarchy
        CALL METHOD ir_cancel->get_data
          IMPORTING
            et_cancel_hierarchy = lt_cancel_hierarchy.

        SELECT * FROM nbew INTO TABLE lt_nbew
          WHERE einri = ls_cancel_hierarchy-micro-einri
            AND falnr = ls_cancel_hierarchy-micro-falnr
            AND storn = off.

        LOOP AT lt_nbew INTO ls_nbew.
          READ TABLE lt_cancel_hierarchy TRANSPORTING NO FIELDS
            WITH KEY micro-lfdbew = ls_nbew-lfdnr
                     micro-falnr  = ls_nbew-falnr
                     micro-datatype = 'NBEW'.
          IF sy-subrc = 0.
            DELETE lt_nbew.
          ENDIF.
        ENDLOOP.

        DELETE lt_nbew WHERE lfdnr = is_outtab-lfdbew.

        DESCRIBE TABLE lt_nbew LINES l_count.

*       all movements are within the cancel-hierarchy, so set the
*       flag MARK for all materials and procedures, which are connected
*       to the movement (case) via service to ON.
*       it there is another case within the hierarchy,
*       all entries of the hierarchy down the case must be selected
*       and lateron appended to the hierarchy, which will be generated
*       during setting the default-marks (Method HANDLE_CHECKBOX_CHANGE
*       ID: 12776)
        IF l_count = 0.

          LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
            WHERE ( micro-datatype = 'NMATV' OR
                    micro-datatype = 'NICP' )
              AND NOT macro-object IS INITIAL.

            CLEAR lr_identify_object.
            lr_identify_object ?= ls_cancel_hierarchy-macro-object.

            IF lr_identify_object->is_inherited_from(
                  cl_ishmed_service=>co_otype_med_service ) = on OR
               lr_identify_object->is_inherited_from(
                  cl_ishmed_service=>co_otype_anchor_srv ) = on.

              CLEAR: lr_service,
                     ls_nlei.

              lr_service ?= ls_cancel_hierarchy-macro-object.

              CALL METHOD lr_service->get_data
                EXPORTING
                  i_fill_service = off
                IMPORTING
                  e_rc           = l_rc
                  e_nlei         = ls_nlei.

              IF l_rc = 0 AND NOT ls_nlei IS INITIAL.
                IF ls_nlei-falnr = is_outtab-falnr.
                  READ TABLE ct_mark INTO ls_mark
               WITH KEY line_key = ls_cancel_hierarchy-micro-line_key.
                  IF sy-subrc = 0.
                    l_index = sy-tabix.
                    ls_mark-mark = on.
                    MODIFY ct_mark INDEX l_index FROM ls_mark.
                  ELSE.
                    CLEAR ls_mark.
                  ls_mark-line_key = ls_cancel_hierarchy-micro-line_key.
                    ls_mark-mark = on.
                  ENDIF.

                ENDIF.
              ENDIF.
            ENDIF.
          ENDLOOP.
*         check, whether there is another case within the cancel-
*         hierarchy
          LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
            WHERE micro-datatype = 'NFAL'
              AND micro-falnr <> is_outtab-falnr.

            READ TABLE lt_cancel_hierarchy TRANSPORTING NO FIELDS
              WITH KEY micro-datatype = 'NFAL'
                       micro-falnr = ls_cancel_hierarchy-micro-falnr.

*           Is the case at the old cancel_hierarchy too?

            IF sy-subrc <> 0.
              APPEND ls_cancel_hierarchy TO et_additional_hierarchy.

              CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
              EXPORTING
                i_initialize   = on
                i_line_key     = ls_cancel_hierarchy-micro-line_key
                it_cancel_hier = ct_cancel_hierarchy
              IMPORTING
                et_cancel_hier = et_additional_hierarchy.

            ENDIF.
          ENDLOOP.
          IF sy-subrc = 0.
            e_append_hierarchy = on.
          ENDIF.
          EXIT.
        ELSE.
*         another movements of the case is not within the list.
*         so the setting of the cancel_hierarchy for the instance
*         g_cancel_all must be prevented in method
*         HANDLE_CHECKBOX_CHANGE
          READ TABLE ct_cancel_hierarchy INTO ls_cancel_hierarchy
            WITH KEY micro-datatype = 'NFAL'
                     macro-datatype = 'NBEW'
                     macro-lfdbew   = is_outtab-lfdbew.

          APPEND ls_cancel_hierarchy TO et_additional_hierarchy.

          CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
            EXPORTING
              i_initialize   = on
              i_line_key     = ls_cancel_hierarchy-micro-line_key
              it_cancel_hier = ct_cancel_hierarchy
            IMPORTING
              et_cancel_hier = et_additional_hierarchy.

        ENDIF.
        EXIT.
      ENDIF.
    ENDIF.

*   now check, whether the case of the currently activated movement
*   is within the hierarchy.
    READ TABLE ct_cancel_hierarchy INTO ls_cancel_hierarchy
     WITH KEY micro-datatype = 'NFAL'
              micro-falnr    = is_outtab-falnr.

*   The case is within the storno - list
    IF sy-subrc = 0.

*     check, whether all movements of the case are within the
*     storno list.
      CALL METHOD ir_cancel->get_data
        IMPORTING
          et_cancel_hierarchy = lt_cancel_hierarchy.

      SELECT * FROM nbew INTO TABLE lt_nbew
        WHERE einri = ls_cancel_hierarchy-micro-einri
          AND falnr = ls_cancel_hierarchy-micro-falnr
          AND storn = off.

      LOOP AT lt_nbew INTO ls_nbew.
        READ TABLE lt_cancel_hierarchy TRANSPORTING NO FIELDS
          WITH KEY micro-lfdbew = ls_nbew-lfdnr
                   micro-falnr  = ls_nbew-falnr
                   micro-datatype = 'NBEW'.
        IF sy-subrc = 0.
          DELETE lt_nbew.
        ENDIF.
      ENDLOOP.

      DELETE lt_nbew WHERE lfdnr = is_outtab-lfdbew.

      DESCRIBE TABLE lt_nbew LINES l_count.
*     there are not all movements within the storno list.
*     check whether there is another case within the storno-list.
*     it this is the case the hierarchy down the case must be appended
*     to the new cancel_hierarchy to the instance g_cancel_all
*     (method HANDLE_CHECKBOX_CHANGE)
      IF l_count > 0.


        APPEND ls_cancel_hierarchy TO et_additional_hierarchy.

        CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
          EXPORTING
            i_initialize   = on
            i_line_key     = ls_cancel_hierarchy-micro-line_key
            it_cancel_hier = ct_cancel_hierarchy
          IMPORTING
            et_cancel_hier = et_additional_hierarchy.

        LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
          WHERE micro-datatype = 'NFAL'
            AND micro-falnr <> is_outtab-falnr.

          READ TABLE lt_cancel_hierarchy TRANSPORTING NO FIELDS
            WITH KEY micro-datatype = 'NFAL'
                     micro-falnr = ls_cancel_hierarchy-micro-falnr.

          IF sy-subrc <> 0.
            APPEND ls_cancel_hierarchy TO et_additional_hierarchy.

            CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
            EXPORTING
              i_initialize   = on
              i_line_key     = ls_cancel_hierarchy-micro-line_key
              it_cancel_hier = ct_cancel_hierarchy
            IMPORTING
              et_cancel_hier = et_additional_hierarchy.

          ENDIF.
        ENDLOOP.
        IF sy-subrc = 0.
          e_append_hierarchy = on.
        ENDIF.

*     all movements of the case are within the hierarchy.
*     check, whether there is another case within the hierarchy
*     and its movements not. If this is the case the hierarchy of
*     this case must be appended to the new generated hierarchy and
*     set as new hierarchy for the instance g_cancel_all (mehtod
*     HANDLE_CHECKBOX_CHANGE)
      ELSE.
        LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
          WHERE micro-datatype = 'NFAL'
            AND micro-falnr <> is_outtab-falnr.

          READ TABLE lt_cancel_hierarchy TRANSPORTING NO FIELDS
            WITH KEY micro-datatype = 'NFAL'
                     micro-falnr = ls_cancel_hierarchy-micro-falnr.

          IF sy-subrc <> 0.
            APPEND ls_cancel_hierarchy TO et_additional_hierarchy.

            CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
            EXPORTING
              i_initialize   = on
              i_line_key     = ls_cancel_hierarchy-micro-line_key
              it_cancel_hier = ct_cancel_hierarchy
            IMPORTING
              et_cancel_hier = et_additional_hierarchy.

          ENDIF.
        ENDLOOP.
        IF sy-subrc = 0.
          e_append_hierarchy = on.
        ENDIF.

      ENDIF.
*   the case of the currently activated movements is not within the
*   hierarchy.
    ELSE.
*     a movement - sequence was activated.
      IF l_cramp_clicked = on.
        LOOP AT ct_cancel_hierarchy INTO ls_cancel_hierarchy
            WHERE ( micro-datatype = 'NMATV' OR
                    micro-datatype = 'NICP' )
              AND NOT macro-object IS INITIAL.

          READ TABLE ct_mark TRANSPORTING NO FIELDS
            WITH KEY line_key = ls_cancel_hierarchy-micro-line_key.
          CHECK sy-subrc = 0.
          l_index = sy-tabix.

          CLEAR lr_identify_object.
          lr_identify_object ?= ls_cancel_hierarchy-macro-object.

          IF lr_identify_object->is_inherited_from(
                cl_ishmed_service=>co_otype_med_service ) = on OR
             lr_identify_object->is_inherited_from(
                cl_ishmed_service=>co_otype_anchor_srv ) = on.

            CLEAR: lr_service,
                   ls_nlei.

            lr_service ?= ls_cancel_hierarchy-macro-object.

            CALL METHOD lr_service->get_data
              EXPORTING
                i_fill_service = off
              IMPORTING
                e_rc           = l_rc
                e_nlei         = ls_nlei.

            IF l_rc = 0 AND NOT ls_nlei IS INITIAL.
              LOOP AT it_outtab INTO ls_outtab.
                IF ls_nlei-falnr = ls_outtab-falnr AND
                  ls_nlei-lfdbew = ls_outtab-lfdbew.
                  DELETE ct_mark INDEX l_index.
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDLOOP.
        EXIT.
*     a single movement was activated.
      ELSE.
        READ TABLE ct_cancel_hierarchy INTO ls_cancel_hierarchy
          WITH KEY micro-datatype = 'NFAL'.
        CHECK sy-subrc = 0.

*         the hierarchy down the case must be selected and put
*         into an internal table.
        APPEND ls_cancel_hierarchy TO et_additional_hierarchy.

        CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
          EXPORTING
            i_initialize   = on
            i_line_key     = ls_cancel_hierarchy-micro-line_key
            it_cancel_hier = ct_cancel_hierarchy
          IMPORTING
            et_cancel_hier = et_additional_hierarchy.


      ENDIF.
    ENDIF.
  ENDIF.

*      this coding is prepared for optionalizing the preregistration
*      and its depending objects like service and appointment
*      !!!!!!!!!!!!!!!!!!!!!!! (is not complete)
*      read table lt_cancel_hierarchy into l_cancel_hierarchy
*          with key macro-datatype = 'NBEW'
*                   macro-line_key = l_outtab_nbew-line_key
*                   micro-datatype = 'NFAL'.
*      if sy-subrc = 0.
*
*        CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
*          EXPORTING
*          I_INITIALIZE   = ON
*          I_LINE_KEY     = l_cancel_hierarchy-micro-line_key
*          it_cancel_hier = lt_cancel_hierarchy
*        IMPORTING
*          ET_CANCEL_HIER = lt_cancel_hierarchy2.
*
*        loop at lt_cancel_hierarchy2 into l_cancel_hierarchy.
*          if l_cancel_hierarchy-mandatory = on.
*            continue.
*          else.
*            l_cancel_hierarchy-mandatory = on.
*            modify lt_cancel_hierarchy2 from l_cancel_hierarchy.
*          endif.
*        endloop.
*
*        loop at lt_cancel_hierarchy into l_cancel_hierarchy.
*          read table lt_cancel_hierarchy2 into l_cancel_hierarchy2
*              with key macro = l_cancel_hierarchy-macro
*                       micro = l_cancel_hierarchy-micro.
*
*          if sy-subrc = 0.
*            modify lt_cancel_hierarchy from l_cancel_hierarchy2.
*          endif.
*        endloop.
*
*      endif.

ENDMETHOD.


method CHECK.
  CALL METHOD g_cancel->check
    IMPORTING
      E_RC           = e_rc
    CHANGING
      C_ERRORHANDLER = c_errorhandler.
endmethod.


method CONSTRUCTOR.
  data: l_errorhandler type ref to cl_ishmed_errorhandling,
        l_rc           type ish_method_rc,
        lt_excl_data   type ishmed_t_cancel_excl_data,
        l_cancel_flags type rn1cancel_flags,
        l_environment  type ref to cl_ish_environment.

* Initialisierung
  CALL METHOD me->initialize.

* Tree-Control instanzieren
  CREATE OBJECT g_tree
    EXPORTING
      PARENT                      = i_parent
      NODE_SELECTION_MODE         =
            cl_gui_column_Tree=>node_sel_mode_single
      ITEM_SELECTION              = on
      NO_HTML_HEADER              = on
    EXCEPTIONS
      CNTL_ERROR                  = 1
      CNTL_SYSTEM_ERROR           = 2
      CREATE_ERROR                = 3
      LIFETIME_ERROR              = 4
      ILLEGAL_NODE_SELECTION_MODE = 5
      FAILED                      = 6
      ILLEGAL_COLUMN_NAME         = 7
      others                      = 8.
  if sy-subrc <> 0.
    raise cntl_error.
  endif.

* Übernahme der Importing-Parameter
* G_CANCEL enthält nur die Daten, die im Tree markiert
* sind und die storniert werden sollen (und somit auch geprüft
* werden sollen!!)
  g_cancel = i_cancel.

* G_CANCEL_ALL enthält ALLE Daten, die im Tree angezeigt werden, so
* auch die, die nicht markiert sind und die deshalb auch nicht
* storniert werden sollen
* Von G_CANCEL_ALL wird die Excluding-Tab gelöscht, damit diese
* Instanz auch wirklich ALLE Daten enthält
* Fall zu Beginn alles markiert ist, ist G_CANCEL = G_CANCEL_ALL
* G_CANCEL ist die Instanz der Cancel-Klasse, mit der im
* Tree gearbeitet wird, d.h. die auch verändert wird usw.
  clear: lt_excl_data[],
         l_cancel_flags,
         l_environment.
  CALL METHOD g_cancel->get_data
    IMPORTING
      E_CANCEL_FLAGS      = l_cancel_flags
      ET_EXCL_DATA        = lt_excl_data
      E_ENVIRONMENT       = l_environment.

*  if lt_excl_data[] is initial.  "KG, MED-29862
    g_cancel_all = i_cancel.
*  KG, MED-29862 - Begin
*  set allways importing cancel object to cancel-object holding all objects to cancel.
*  Otherwise it is possible, that you will get an empty storno-dialog by calling the
*  storno for the second time.
*  else.
**   Eigene Instanz für G_CANCEL_ALL anlegen (mit leerer EXCL-Tab)
**   und dafür die Daten einlesen. G_CANCEL_ALL enthält dann eben
**   wirklich ALLE Daten
*    CALL METHOD cl_ish_cancel=>create
*      EXPORTING
*        I_ENVIRONMENT  = l_environment
*      IMPORTING
*        E_INSTANCE     = g_cancel_all
*        E_RC           = l_rc.
*    if l_rc <> 0.
*      raise other_error.
*    else.
*      CALL METHOD g_cancel_all->refresh
*        EXPORTING
*          I_CANCEL_FLAGS     = l_cancel_flags
*        IMPORTING
*          E_RC               = l_rc
*        CHANGING
*          C_ERRORHANDLER     = l_errorhandler.
*      if l_rc <> 0.
*        raise other_error.
*      endif.
*    endif.
*  endif.
* KG, MED-29862 - End

* Handle für Varianten
  g_variant-report   = 'CL_ISHMED_CANCEL_TREE'.
  g_variant-username = sy-uname.
  g_variant-handle   = i_variant_handle.

* Änderungsmodus oder Anzeigemodus?
  IF i_edit_mode = on.
    g_vcode = 'UPD'.
  ELSE.
    g_vcode = 'DIS'.
  ENDIF.

* Feldkatalog befüllen
  CALL METHOD me->build_fieldcatalog
    EXPORTING
      i_cancel       = g_cancel
    IMPORTING
      E_RC           = l_rc
    changing
      ct_fieldcat    = gt_fieldcat
      C_ERRORHANDLER = l_errorhandler.
  if l_rc <> 0.
    raise fcat_error.
  endif.

* Toolbar befüllen
  CALL METHOD me->build_functions
    EXPORTING
      i_cancel       = g_cancel
    IMPORTING
      E_RC           = l_rc
    changing
      ct_function    = gt_excl_function
      C_ERRORHANDLER = l_errorhandler.
  if l_rc <> 0.
    raise fcat_error.
  endif.
endmethod.


method DISPLAY_CANCEL_TREE.
  data: l_hier_header type treev_hhdr,
        lt_outtab     type ISHMED_T_CANCEL_TREE_TAB,
        l_rc          type ish_method_rc.
  data: l_toolbar     type ref to cl_gui_toolbar,
        lt_event      type cntl_simple_events,
        l_event       type cntl_simple_event.

* Initialisierungen
  e_rc = 0.

* Header für Hierarchie-Spalte aufbauen
  clear l_hier_header.
  CALL METHOD me->build_hierarchy_header
    CHANGING
      c_header = l_hier_header.

* Achtung: Für diesen Aufruf muss die Tabelle GT_OUTTAB noch
* leer sein! Sie darf nur mit den Methoden des Trees befüllt
* werden
  refresh gt_outtab.
  CALL METHOD g_tree->set_table_for_first_display
    EXPORTING
*      I_STRUCTURE_NAME     =
      IS_VARIANT           = g_variant
*     benutzerspezifische und globale Varianten können
*     gespeichert werden
      I_SAVE               = 'A'
      IS_HIERARCHY_HEADER  = l_hier_header
*      IS_EXCEPTION_FIELD   =
*      IT_LIST_COMMENTARY   =
      IT_TOOLBAR_EXCLUDING = gt_excl_function
    CHANGING
      it_outtab            = gt_outtab
      IT_FIELDCATALOG      = gt_fieldcat.

* Der Tree baut seinen Toolbar so auf, dass Application-Events
* für die Funktionen gesetzt werden. Das bedeutet, dass bei
* jeder Funktion ein OK-Code ausgelöst wird. Das ist aber
* hier nicht gewünscht
  clear l_toolbar.
  CALL METHOD g_tree->get_toolbar_object
    IMPORTING
      ER_TOOLBAR = l_toolbar.
  if not l_toolbar is initial.
*   Zuerst bestehende Events einlesen
    refresh lt_event.
    CALL METHOD l_toolbar->get_registered_events
      IMPORTING
        EVENTS     = lt_event
      EXCEPTIONS
        CNTL_ERROR = 1
        others     = 2.
    if sy-subrc = 0.
      loop at lt_event into l_event.
        l_event-appl_event = off.
        modify lt_event from l_event.
      endloop.
      call method l_toolbar->set_registered_events
        exporting
          events                    = lt_event
        exceptions
          cntl_error                = 1
          cntl_system_error         = 2
          illegal_event_combination = 3.
    endif.
  endif.

* Jetzt kann auch die OUTTAB fertig befüllt werden.
* ACHTUNG: Hier NICHT die GT_OUTTAB befüllen, denn die
* befüllt der Tree mit der Methode ADD_NODE ja selbst!
  refresh lt_outtab.
  CALL METHOD me->build_outtab
    EXPORTING
      i_cancel       = g_cancel_all
    IMPORTING
      E_RC           = l_rc
      ET_OUTTAB      = lt_outtab
    CHANGING
      C_ERRORHANDLER = c_errorhandler.
  if l_rc <> 0.
*   Hier die Methode nicht verlassen! Es kann durchaus sein,
*   dass aus dem BUILD_OUTTAB Fehler kommen, denn dort werden
*   zu den Klassen ja auch die GET_...-Methoden aufgerufen,
*   die Fehler bringen können.
*   Trotzdem muss der Tree aufgebaut werden!
    e_rc = l_rc.
  endif.

* Prüfungen, ob storniert werden darf.
* ACHTUNG: Hier nicht den Returncode in E_RC übernehmen, denn
* es ist durchaus normal, dass hier Fehler auftreten können.
* Diese Fehler sollen dann ja im Popup angezeigt werden!
  CALL METHOD me->check
    IMPORTING
      E_RC           = l_rc
    CHANGING
      C_ERRORHANDLER = c_errorhandler.

* Aufbauen des Trees
  CALL METHOD me->fill_tree_control
    EXPORTING
      it_outtab      = lt_outtab
    IMPORTING
      E_RC           = l_rc
    CHANGING
      C_ERRORHANDLER = c_errorhandler.
  if l_rc <> 0.
    e_rc = l_rc.
  endif.

* Einige Spalten in der Breite optimieren
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         =
              cl_gui_alv_tree=>c_hierarchy_column_name
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         = 'CASTATE'
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         = 'CAOU'
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         = 'CADATE'
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         = 'CATIME'
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         = 'CAKEY'
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         = 'CAGPART'
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         = 'CACOTEXT'
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.
  CALL METHOD g_tree->column_optimize
    EXPORTING
      I_START_COLUMN         = 'CACOICON'
      I_INCLUDE_HEADING      = on
    EXCEPTIONS
      START_COLUMN_NOT_FOUND = 1
      END_COLUMN_NOT_FOUND   = 2
      others                 = 3.

* Ereignisse des Trees nun registrieren und Event-Handler
* installieren
  CALL METHOD me->register_events.

  CALL METHOD g_tree->frontend_update.
endmethod.


METHOD fill_tree_control .
  TYPES: BEGIN OF lty_rootnode,
           node_key TYPE lvc_nkey,
         END OF lty_rootnode.
  TYPES: BEGIN OF lty_typecnt,
           group_nr TYPE rn1cancel_tree_fields-group_nr,
           type     TYPE n1poobjectid,
           count    TYPE i,
           state(1) TYPE c,       " Status (für Ampel)
         END OF lty_typecnt.
  DATA: lt_rootnode    TYPE STANDARD TABLE OF lty_rootnode,
        l_rootnode     TYPE lty_rootnode.
  DATA: lt_typecnt     TYPE STANDARD TABLE OF lty_typecnt,
        l_typecnt      TYPE lty_typecnt.
  DATA: l_outtab       TYPE LINE OF ishmed_t_cancel_tree_tab,
        l_outtab2      TYPE LINE OF ishmed_t_cancel_tree_tab,
        l_old_out      TYPE LINE OF ishmed_t_cancel_tree_tab,
        lt_outtab_mark TYPE ishmed_t_cancel_tree_tab,
        l_main_keystr  TYPE string,
        l_lay_node     TYPE lvc_s_layn,
        l_node_key     TYPE lvc_nkey,
        l_node_k2      TYPE lvc_nkey,
        l_countnode    TYPE lvc_nkey,
        l_root_node    TYPE lvc_nkey,
        l_temp_node    TYPE lvc_nkey,
        l_node_text    TYPE lvc_value,
        l_exp_subtree  TYPE as4flag,
        lt_lay_item    TYPE lvc_t_layi,
        l_lay_item     TYPE lvc_s_layi.
  DATA: l_rc           TYPE ish_method_rc,
        l_flag         TYPE ish_on_off,
        l_type         TYPE i,
        l_main_obj_cnt TYPE i,
        l_text(45)     TYPE c,
        l_icon         TYPE tv_image,
        l_cancel_hier  TYPE rn1cancel_hierarchy,
        lt_cancel_hier TYPE ishmed_t_cancel_hierarchy,
        l_cramp        TYPE ty_cramp,
        l_cramp2       TYPE ty_cramp,
        lt_mark        TYPE ishmed_t_cancel_mark,
        l_mark         TYPE LINE OF ishmed_t_cancel_mark.

* Käfer, ID 13578 130204 - Begin
  DATA: lt_cancel_hier_new TYPE ishmed_t_cancel_hierarchy,
        ls_cancel_hier_new TYPE rn1cancel_hierarchy,
        l_index            LIKE sy-tabix.
* Käfer, ID 13578 - End

* Initialisierungen
  e_rc = 0.
  REFRESH: lt_rootnode,
           lt_typecnt,
           gt_cramp.
  l_temp_node = '99999'.

* Die Hierarchietabelle der Cancel-Klasse wird auch benötigt
* um damit die Hierarchie aller anzuzeigenden Daten aufbauen
* zu können (deshalb wird hier G_CANCEL_ALL benutzt, denn dort
* stehen ja ALLE Daten)
  REFRESH lt_cancel_hier.
  CALL METHOD g_cancel_all->get_data
    IMPORTING
      et_cancel_hierarchy = lt_cancel_hier.


* Käfer, ID: 13578 130204 - Begin
* get the hierarchy of the cancel-instance g_cancel
* this is not the whole hierarchy, but if a Movement is within
* the stornolist, the actual mandatory-flags are within this
* hierarchy.
  REFRESH lt_cancel_hier_new.
  CALL METHOD g_cancel->get_data
    IMPORTING
      et_cancel_hierarchy = lt_cancel_hier_new.
* Käfer, ID: 13578 - End

* OUTTAB sortieren und dann daraus die Tree-Struktur aufbauen
  SORT it_outtab BY patname patnr papid
                    group_nr
                    dependent
                    type.

* Markierungstabelle aus dem Storno holen
  REFRESH lt_mark.
  CALL METHOD g_cancel->get_data
    IMPORTING
      et_mark = lt_mark.

* Nun noch aus den markierten Daten auch eine OUTTAB erzeugen.
* Diese wird gebraucht, um die Checkboxen und die Zählerknoten
* setzen zu können
  REFRESH lt_outtab_mark.
  CALL METHOD me->build_outtab
    EXPORTING
      i_cancel  = g_cancel
    IMPORTING
      e_rc      = l_rc
      et_outtab = lt_outtab_mark.

* ---------------------------------------------------------
* Nun die Zähler ermitteln, d.h. wieviele Objekte pro Typ zu
* jedem Hauptobjekt (das sind die Objekte, die der Benutzer
* stornieren möchte) mitstorniert werden müssen
* Hier werden auch gleich die Status für die Ampelanzeige der
* Hauptobjekte ermittelt
  CLEAR: l_main_obj_cnt,
         l_typecnt,
         l_old_out.
  LOOP AT it_outtab INTO l_outtab.
*   Hier auch gleich die Klammertabelle bilden, d.h.
*   -) Termine suchen, zu denen es Leistungen gibt
*   -) Bewegungen suchen, zu denen es Folgebewegungen gibt
    IF NOT l_outtab-object IS INITIAL.
      CALL METHOD l_outtab-object->('GET_TYPE')
        IMPORTING
          e_object_type = l_type.
      CASE l_type.
        WHEN cl_ish_appointment=>co_otype_appointment.
*         Gibt es Leistungen unter(!) diesem Termin?
          l_temp_node = l_temp_node - 1.
          LOOP AT lt_cancel_hier INTO l_cancel_hier
                  WHERE macro-object = l_outtab-object.
*                 Klammerknoten nur wenn das Objekt optional ist
*                  and   mandatory    = off.  "ID 13578
            CHECK NOT l_cancel_hier-micro-object IS INITIAL.
            CALL METHOD l_cancel_hier-micro-object->('GET_TYPE')
              IMPORTING
                e_object_type = l_type.
            CHECK l_type = cl_ishmed_service=>co_otype_med_service  OR
                  l_type = cl_ishmed_service=>co_otype_anchor_srv.
*           Käfer, ID 13578 130204 - Begin
            l_index = sy-tabix.
            IF l_cancel_hier-mandatory = off.
              READ TABLE lt_cancel_hier_new INTO ls_cancel_hier_new
                WITH KEY micro-object = l_cancel_hier-micro-object.
              IF sy-subrc = 0 AND ls_cancel_hier_new-mandatory = on.
                l_cancel_hier-mandatory = on.
                MODIFY lt_cancel_hier FROM l_cancel_hier INDEX l_index.
                CONTINUE.
              ENDIF.
            ELSE.
              READ TABLE lt_cancel_hier_new INTO ls_cancel_hier_new
                WITH KEY micro-object = l_cancel_hier-micro-object.
              IF sy-subrc = 0 AND ls_cancel_hier_new-mandatory = off.
                l_cancel_hier-mandatory = off.
                MODIFY lt_cancel_hier FROM l_cancel_hier INDEX l_index.
              ELSE.
                CONTINUE.
              ENDIF.
            ENDIF.
*           Käfer, ID 13578 - End
            CLEAR l_cramp.
            l_cramp-cramp_node_key  = l_temp_node.
            l_cramp-cramp_node_text = 'Zugeordnete Leistungen'(t05).
            l_cramp-data_key-object = l_cancel_hier-micro-object.
            APPEND l_cramp TO gt_cramp.
          ENDLOOP.
      ENDCASE.
    ELSE.
      IF l_outtab-datatype = 'NBEW'.
*       Nur prüfen, wenn diese Bewegung noch nicht in der
*       Klammertabelle enthalten ist
        READ TABLE gt_cramp TRANSPORTING NO FIELDS
                   WITH KEY data_key-line_key = l_outtab-line_key.
        IF sy-subrc <> 0.
*         Gibt es Folgebewegungen zu dieser Bewegung?
          l_temp_node = l_temp_node - 1.
          LOOP AT lt_cancel_hier INTO l_cancel_hier
                  WHERE macro-line_key = l_outtab-line_key
                  AND   mandatory      = off.
            CHECK l_cancel_hier-micro-datatype = 'NBEW'.
            CLEAR l_cramp.
            l_cramp-cramp_node_key    = l_temp_node.
            l_cramp-cramp_node_text   = 'Folgebewegungen'(t06).
            l_cramp-data_key-line_key = l_cancel_hier-micro-line_key.
            APPEND l_cramp TO gt_cramp.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.

*   Nur die Objekte zählen, die mitstorniert werden müssen
    IF l_outtab-dependent = off.
      CONTINUE.
    ENDIF.

    IF l_old_out-group_nr <> l_outtab-group_nr  OR
       l_old_out-type <> l_outtab-type.
*     Neuer Typ hat begonnen => Zählerdatensatz von vorhin
*     kann abgelegt werden
      IF NOT l_typecnt-type IS INITIAL.
        APPEND l_typecnt TO lt_typecnt.
      ENDIF.
*     Neuen Datensatz vorbereiten
      CLEAR l_typecnt.
      l_typecnt-group_nr = l_outtab-group_nr.
      l_typecnt-type     = l_outtab-type.
    ENDIF.
*   Zähler nur incrementieren, wenn das Objekt in L_OUTTAB auch
*   wirklich markiert ist. Dazu muss quasi G_CANCEL befragt
*   werden (dazu wurde weiter oben die LT_OUTTAB_MARK gebildet)
    IF NOT l_outtab-object IS INITIAL.
      READ TABLE lt_outtab_mark TRANSPORTING NO FIELDS
                 WITH KEY object = l_outtab-object.
    ELSE.
      READ TABLE lt_outtab_mark TRANSPORTING NO FIELDS
                 WITH KEY line_key = l_outtab-line_key.
    ENDIF.
    IF sy-subrc = 0.
*     Auch die Mark-Tab nicht vergessen
      CALL METHOD g_cancel->is_obj_in_marktab
        EXPORTING
          i_object   = l_outtab-object
          i_line_key = l_outtab-line_key
        IMPORTING
          e_marked   = l_flag.
      IF l_flag = on.
        l_typecnt-count = l_typecnt-count + 1.
      ENDIF.
    ENDIF.

    l_old_out = l_outtab.
  ENDLOOP.
  APPEND l_typecnt TO lt_typecnt.

* ---------------------------------------------------------
* Jetzt kann der Tree aufgebaut werden
  CLEAR: l_old_out,
         l_root_node,
         l_node_key.
  LOOP AT it_outtab INTO l_outtab.
    CLEAR: l_lay_item,
           l_lay_node.
    IF l_outtab-patname <> l_old_out-patname  OR
       l_outtab-patnr   <> l_old_out-patnr    OR
       l_outtab-papid   <> l_old_out-papid.
*     -----------------------------------------------------
*     Neuer Patient ist dran => WURZELKNOTEN einfügen
      l_lay_node-isfolder = 'X'.
      IF NOT l_outtab-patnr IS INITIAL.
*       "Echter" Patient
        CLEAR l_lay_node-n_image.
        l_lay_node-exp_image = l_lay_node-n_image.
      ELSE.
*       "Vorläufiger Patient
        CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
          EXPORTING
            i_data_name = 'NPAP'
          IMPORTING
            e_icon      = l_lay_node-n_image.
        l_lay_node-exp_image = l_lay_node-n_image.
      ENDIF.
*     Hier einige Felder unbedingt unsichtbar machen
      REFRESH lt_lay_item.
      CLEAR l_lay_item.
      l_lay_item-fieldname = 'CATIME'.
      l_lay_item-hidden    = on.
      APPEND l_lay_item TO lt_lay_item.
      l_node_text = l_outtab-patname.
      CALL METHOD g_tree->add_node
        EXPORTING
          i_relat_node_key     = space      " Ein Wurzelknoten
          i_relationship       = cl_gui_column_tree=>relat_last_child
          is_node_layout       = l_lay_node
          it_item_layout       = lt_lay_item
          i_node_text          = l_node_text
        IMPORTING
          e_new_node_key       = l_root_node
        EXCEPTIONS
          relat_node_not_found = 1
          node_not_found       = 2
          OTHERS               = 3.
      l_rc = sy-subrc.
      IF l_rc <> 0.
        e_rc = l_rc.
*       Fehler & beim Aufruf der Methode & der Klasse &
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NFCL'
            i_num  = '091'
            i_mv1  = l_rc
            i_mv2  = 'ADD_NODE'
            i_mv3  = 'CL_GUI_ALV_TREE'
            i_last = space.
        EXIT.
      ENDIF.
      IF l_lay_node-isfolder = 'X'.
        l_rootnode-node_key = l_root_node.
        APPEND l_rootnode TO lt_rootnode.
      ENDIF.
    ENDIF.

*   Für diesen Eintrag muss auch noch ein normaler- oder ein
*   Sammelknoten eingefügt werden
    IF l_outtab-dependent = off.
*     -----------------------------------------------------
*     Knoten für das Hauptobjekt ausgeben
      l_main_obj_cnt = l_main_obj_cnt + 1.
      CLEAR l_lay_node.
      IF l_outtab-icon IS INITIAL.
        l_lay_node-n_image   = icon_space.
      ELSE.
        l_lay_node-n_image   = l_outtab-icon.
      ENDIF.
      l_lay_node-exp_image = l_lay_node-n_image.
      CALL METHOD cl_ishmed_cancel_tree=>build_type_text
        EXPORTING
          i_outtab    = l_outtab
        IMPORTING
          e_type_text = l_node_text.
*     Key herleiten (wird für Zählerknoten gebraucht)
      IF NOT l_outtab-object IS INITIAL.
        CALL METHOD l_outtab-object->('GET_KEY_STRING')
          IMPORTING
            e_key = l_main_keystr.
      ELSE.
        l_main_keystr = l_outtab-line_key.
      ENDIF.
      REFRESH lt_lay_item.
      CLEAR l_lay_item.
      l_lay_item-fieldname =
              cl_gui_alv_tree=>c_hierarchy_column_name.
      CALL METHOD cl_ishmed_cancel_tree=>build_mainobj_light
        EXPORTING
          i_cancel       = g_cancel_all
          i_outtab       = l_outtab
          i_errorhandler = c_errorhandler
        IMPORTING
          e_icon         = l_lay_item-t_image.
      APPEND l_lay_item TO lt_lay_item.
      CALL METHOD g_tree->add_node
        EXPORTING
          i_relat_node_key     = l_root_node
          i_relationship       =
                        cl_gui_column_tree=>relat_last_child
          is_outtab_line       = l_outtab
          is_node_layout       = l_lay_node
          it_item_layout       = lt_lay_item
          i_node_text          = l_node_text
        IMPORTING
          e_new_node_key       = l_node_key
        EXCEPTIONS
          relat_node_not_found = 1
          node_not_found       = 2
          OTHERS               = 3.
      l_rc = sy-subrc.
      IF l_rc = 0.
*       Den echten Node-Key in die OUTTAB reinstellen, denn man
*       muss später auch von einem OUTTAB-Satz auf den NODE_KEY
*       schließen können!
        CALL METHOD g_tree->change_item
          EXPORTING
            i_node_key     = l_node_key
            i_fieldname    = 'NODE_KEY'
            i_data         = l_node_key
          EXCEPTIONS
            node_not_found = 1
            OTHERS         = 2.
      ELSE.
        e_rc = l_rc.
*       Fehler & beim Aufruf der Methode & der Klasse &
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NFCL'
            i_num  = '091'
            i_mv1  = l_rc
            i_mv2  = 'ADD_NODE2'
            i_mv3  = 'CL_GUI_ALV_TREE'
            i_last = space.
        EXIT.
      ENDIF.
    ELSE.

*     -----------------------------------------------------
*     Sammelknoten mit Zähler ausgeben
      IF l_outtab-group_nr  <> l_old_out-group_nr  OR
         l_outtab-type      <> l_old_out-type      OR
         l_outtab-dependent <> l_old_out-dependent.
        CLEAR l_lay_node.
        IF NOT l_outtab-icon IS INITIAL.
          l_lay_node-n_image   = l_outtab-icon.
        ENDIF.
        l_lay_node-exp_image = l_lay_node-n_image.
        READ TABLE lt_typecnt INTO l_typecnt
                   WITH KEY group_nr = l_outtab-group_nr
                            type     = l_outtab-type.
        CALL METHOD cl_ishmed_cancel_tree=>build_type_text
          EXPORTING
            i_outtab     = l_outtab
            i_count      = l_typecnt-count
          IMPORTING
            e_count_node = l_node_text.
*       Auch hier eine (nur teilweise befüllte) OUTTAB-Zeile
*       angeben
        CLEAR l_outtab2.
        l_outtab2-group_nr  = l_outtab-group_nr.
        l_outtab2-type      = l_outtab-type.
        CONCATENATE l_outtab-type l_main_keystr
                    INTO l_outtab2-line_key.
*       Hier einige Felder unbedingt unsichtbar machen
        REFRESH lt_lay_item.
        CLEAR l_lay_item.
        l_lay_item-fieldname = 'CATIME'.
        l_lay_item-hidden    = on.
        APPEND l_lay_item TO lt_lay_item.
        IF NOT l_node_text IS INITIAL.
          CALL METHOD g_tree->add_node
            EXPORTING
              i_relat_node_key     = l_node_key
              i_relationship       =
                        cl_gui_column_tree=>relat_last_child
              is_outtab_line       = l_outtab2
              is_node_layout       = l_lay_node
              it_item_layout       = lt_lay_item
              i_node_text          = l_node_text
            IMPORTING
              e_new_node_key       = l_countnode
            EXCEPTIONS
              relat_node_not_found = 1
              node_not_found       = 2
              OTHERS               = 3.
          l_rc = sy-subrc.
          IF l_rc = 0.
*           Den echten Node-Key in die OUTTAB reinstellen, denn man
*           muss später auch von einem OUTTAB-Satz auf den NODE_KEY
*           schließen können!
            CALL METHOD g_tree->change_item
              EXPORTING
                i_node_key     = l_countnode
                i_fieldname    = 'NODE_KEY'
                i_data         = l_countnode
              EXCEPTIONS
                node_not_found = 1
                OTHERS         = 2.
          ELSE.
            e_rc = l_rc.
*           Fehler & beim Aufruf der Methode & der Klasse &
            CALL METHOD c_errorhandler->collect_messages
              EXPORTING
                i_typ  = 'E'
                i_kla  = 'NFCL'
                i_num  = '091'
                i_mv1  = l_rc
                i_mv2  = 'ADD_NODE3'
                i_mv3  = 'CL_GUI_ALV_TREE'
                i_last = space.
            EXIT.
          ENDIF.
        ENDIF.
      ENDIF.

*     -----------------------------------------------------
*     Klammer-Knoten einfügen. Normalerweise wäre hier ein
*     Einzelobjekt dran, aber zuvor muss eventuell ein
*     Klammerknoten (wie für die Leistungen eines Termins oder
*     für Folgebewegungen einer Bewegung) ausgegeben werden
*     Gibt es für das auszugebende Objekt einen Eintrag in der
*     Klammertabelle muss eben der Klammerknoten ausgegeben werden
      IF NOT l_outtab-object IS INITIAL.
        READ TABLE gt_cramp INTO l_cramp
                   WITH KEY data_key-object = l_outtab-object
                            cramp_shown     = off.
      ELSE.
        READ TABLE gt_cramp INTO l_cramp
                   WITH KEY data_key-line_key = l_outtab-line_key
                            cramp_shown       = off.
      ENDIF.
      IF sy-subrc = 0.
        CLEAR l_lay_node.
        l_lay_node-n_image   = 'BNONE'.
        l_lay_node-exp_image = l_lay_node-n_image.
        REFRESH lt_lay_item.
        CLEAR l_lay_item.
        l_lay_item-fieldname =
                cl_gui_alv_tree=>c_hierarchy_column_name.
        l_lay_item-class     =
                cl_gui_column_tree=>item_class_checkbox.
        CLEAR l_cancel_hier.
*       Ist die Checkbox eingabebereit?
        l_lay_item-editable = off.
        l_lay_item-disabled = on.
        IF NOT l_cramp-data_key-object IS INITIAL.
          READ TABLE lt_cancel_hier INTO l_cancel_hier
                     WITH KEY micro-object = l_outtab-object.
          IF l_cancel_hier-mandatory = off.
            l_lay_item-editable = on.
            l_lay_item-disabled = off.
          ENDIF.
        ELSE.
          READ TABLE lt_cancel_hier INTO l_cancel_hier
                     WITH KEY micro-line_key = l_outtab-line_key.
          IF l_cancel_hier-mandatory = off.
            l_lay_item-editable = on.
            l_lay_item-disabled = off.
          ENDIF.
        ENDIF.
*       Ist die Checkbox angekreuzt? Das ist sie nur, wenn das
*       aktuelle Objekt auch in G_CANCEL enthalten ist
*       Ob die Checkbox angekreuzt ist, entscheidet auch die
*       Markierungstabelle der Cancel-Klasse
        IF NOT l_cramp-data_key-object IS INITIAL.
          READ TABLE lt_mark INTO l_mark
               WITH KEY object = l_cramp-data_key-object.
          IF sy-subrc <> 0.
            l_mark-mark = on.
          ENDIF.
          READ TABLE lt_outtab_mark TRANSPORTING NO FIELDS
               WITH KEY object = l_cramp-data_key-object.
        ELSE.
          READ TABLE lt_mark INTO l_mark
               WITH KEY line_key = l_cramp-data_key-line_key.
          IF sy-subrc <> 0.
            l_mark-mark = on.
          ENDIF.
          READ TABLE lt_outtab_mark TRANSPORTING NO FIELDS
               WITH KEY line_key = l_cramp-data_key-line_key.
        ENDIF.
        IF sy-subrc = 0  AND  l_mark-mark = on.
          l_lay_item-chosen = on.
        ELSE.
          l_lay_item-chosen = off.
        ENDIF.
        APPEND l_lay_item TO lt_lay_item.
*       Hier einige Felder unbedingt unsichtbar machen
        CLEAR l_lay_item.
        l_lay_item-fieldname = 'CATIME'.
        l_lay_item-hidden    = on.
        APPEND l_lay_item TO lt_lay_item.
        CLEAR l_node_text.
        l_node_text = l_cramp-cramp_node_text.
        CALL METHOD g_tree->add_node
          EXPORTING
            i_relat_node_key     = l_countnode
            i_relationship       =
                          cl_gui_column_tree=>relat_last_child
            is_node_layout       = l_lay_node
            it_item_layout       = lt_lay_item
            i_node_text          = l_node_text
          IMPORTING
            e_new_node_key       = l_cramp2-cramp_node_key
          EXCEPTIONS
            relat_node_not_found = 1
            node_not_found       = 2
            OTHERS               = 3.
        l_rc = sy-subrc.
        IF l_rc = 0.
*         Klammer wird nun angezeigt => Flag setzen
          l_cramp2-cramp_shown = on.
*         Den echten Node-Key in die GT_CRAMP reinstellen.
          MODIFY gt_cramp FROM l_cramp2
                 TRANSPORTING cramp_node_key
                              cramp_shown
                 WHERE cramp_node_key = l_cramp-cramp_node_key.
        ELSE.
          e_rc = l_rc.
*         Fehler & beim Aufruf der Methode & der Klasse &
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NFCL'
              i_num  = '091'
              i_mv1  = l_rc
              i_mv2  = 'ADD_NODE4'
              i_mv3  = 'CL_GUI_ALV_TREE'
              i_last = space.
          EXIT.
        ENDIF.
      ENDIF.

*     -----------------------------------------------------
*     Einzelknoten für Objekt ausgeben, das zum Hauptobjekt
*     mitstorniert werden muss
      CLEAR l_lay_node.
      l_lay_node-n_image   = 'BNONE'.
      l_lay_node-exp_image = l_lay_node-n_image.
      REFRESH lt_lay_item.
      CLEAR l_lay_item.
      l_lay_item-fieldname =
              cl_gui_alv_tree=>c_hierarchy_column_name.
      l_lay_item-class     =
              cl_gui_column_tree=>item_class_checkbox.
      CLEAR l_cancel_hier.
*     Ist die Checkbox eingabebereit?
*     (Checkbox auch nicht eingabebereit, wenn Objekt in einer
*     Klammer enthalten)
      l_lay_item-editable = off.
      l_lay_item-disabled = on.
      IF NOT l_outtab-object IS INITIAL.
        LOOP AT lt_cancel_hier INTO l_cancel_hier
                WHERE micro-object = l_outtab-object.
          IF l_cancel_hier-mandatory = on.
            EXIT.
          ENDIF.
        ENDLOOP.
        READ TABLE gt_cramp TRANSPORTING NO FIELDS
                   WITH KEY data_key-object = l_outtab-object.
        IF sy-subrc <> 0  AND  l_cancel_hier-mandatory = off.
          l_lay_item-editable = on.
          l_lay_item-disabled = off.
        ENDIF.
      ELSE.
        LOOP AT lt_cancel_hier INTO l_cancel_hier
                WHERE micro-line_key = l_outtab-line_key.
          IF l_cancel_hier-mandatory = on.
            EXIT.
          ENDIF.
        ENDLOOP.
        READ TABLE gt_cramp TRANSPORTING NO FIELDS
                   WITH KEY data_key-line_key = l_outtab-line_key.
        IF sy-subrc <> 0  AND  l_cancel_hier-mandatory = off.
          l_lay_item-editable = on.
          l_lay_item-disabled = off.
        ENDIF.
      ENDIF.
*     Ist die Checkbox angekreuzt? Das ist sie nur, wenn das
*     aktuelle Objekt auch in G_CANCEL enthalten ist
*     Ob die Checkbox angekreuzt ist, entscheidet auch die
*     Markierungstabelle der Cancel-Klasse
      IF NOT l_outtab-object IS INITIAL.
        READ TABLE lt_mark INTO l_mark
             WITH KEY object = l_outtab-object.
        IF sy-subrc <> 0.
          l_mark-mark = on.
        ENDIF.
        READ TABLE lt_outtab_mark TRANSPORTING NO FIELDS
                   WITH KEY object = l_outtab-object.
      ELSE.
        READ TABLE lt_mark INTO l_mark
             WITH KEY line_key = l_outtab-line_key.
        IF sy-subrc <> 0.
          l_mark-mark = on.
        ENDIF.
        READ TABLE lt_outtab_mark TRANSPORTING NO FIELDS
                   WITH KEY line_key = l_outtab-line_key.
      ENDIF.
      IF sy-subrc = 0  AND  l_mark-mark = on.
        l_lay_item-chosen = on.
      ELSE.
        l_lay_item-chosen = off.
      ENDIF.
      APPEND l_lay_item TO lt_lay_item.
      CLEAR l_node_text.
      l_node_text = l_outtab-catext.
      CALL METHOD g_tree->add_node
        EXPORTING
          i_relat_node_key     = l_countnode
          i_relationship       =
                        cl_gui_column_tree=>relat_last_child
          is_outtab_line       = l_outtab
          is_node_layout       = l_lay_node
          it_item_layout       = lt_lay_item
          i_node_text          = l_node_text
        IMPORTING
          e_new_node_key       = l_node_k2
        EXCEPTIONS
          relat_node_not_found = 1
          node_not_found       = 2
          OTHERS               = 3.
      l_rc = sy-subrc.
      IF l_rc = 0.
*       Den echten Node-Key in die OUTTAB reinstellen, denn man
*       muss später auch von einem OUTTAB-Satz auf den NODE_KEY
*       schließen können!
        CALL METHOD g_tree->change_item
          EXPORTING
            i_node_key     = l_node_k2
            i_fieldname    = 'NODE_KEY'
            i_data         = l_node_k2
          EXCEPTIONS
            node_not_found = 1
            OTHERS         = 2.
      ELSE.
        e_rc = l_rc.
*       Fehler & beim Aufruf der Methode & der Klasse &
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NFCL'
            i_num  = '091'
            i_mv1  = l_rc
            i_mv2  = 'ADD_NODE4'
            i_mv3  = 'CL_GUI_ALV_TREE'
            i_last = space.
        EXIT.
      ENDIF.
    ENDIF.   " if l_outtab-dependent = off.

*   Outtab für Gruppenwechsel merken
    l_old_out = l_outtab.
  ENDLOOP.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

* Die obersten Knoten mit den Patienten werden gleich offen
* präsentiert
* Gibt es nur ein Hauptobjekt, d.h. wollte der Benutzer nur
* genau ein Objekt stornieren, soll der gesamte Tree sofort
* geöffnet werden (Nr 9682, Punkt 3)
  l_exp_subtree = off.
  IF l_main_obj_cnt = 1.
    l_exp_subtree = on.
  ENDIF.
  LOOP AT lt_rootnode INTO l_rootnode.
    CALL METHOD g_tree->expand_node
      EXPORTING
        i_node_key          = l_rootnode-node_key
*        I_LEVEL_COUNT       =
        i_expand_subtree    = l_exp_subtree
      EXCEPTIONS
        failed              = 1
        illegal_level_count = 2
        cntl_system_error   = 3
        node_not_found      = 4
        cannot_expand_leaf  = 5
        OTHERS              = 6.
    l_rc = sy-subrc.
    IF l_rc <> 0.
      e_rc = l_rc.
*     Fehler & beim Aufruf der Methode & der Klasse &
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NFCL'
          i_num  = '091'
          i_mv1  = l_rc
          i_mv2  = 'EXPAND_NODE'
          i_mv3  = 'CL_GUI_ALV_TREE'
          i_last = space.
      EXIT.
    ENDIF.
  ENDLOOP.
ENDMETHOD.


method FREE.
  check not g_tree is initial.
  clear g_tree.
endmethod.


method GET_NODE_ICON.
  data: l_n1poobj type n1poobjecttype,
        l_rc      type ish_method_rc.

* Initialisierungen
  clear: e_icon.

  CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
    EXPORTING
      I_OBJECT             = i_outtab-object
      I_DATA_NAME          = i_outtab-datatype
      I_DATA_LINE          = i_data_line
    IMPORTING
      E_RC                 = l_rc
      E_ICON               = e_icon.
endmethod.


method GET_UNMARKED_ENTRIES.
  data: lt_all_data    type ishmed_t_cancel_datas,
        lt_marked_data type ishmed_t_cancel_datas,
        l_data         type line of ishmed_t_cancel_datas,
        l_data2        type line of ishmed_t_cancel_datas.
  data: l_obj          type ish_object,
        l_vnlei        type vnlei,
        l_vn2zeiten    type vn2zeiten,
        l_vn2ok        type vn2ok,
        l_vnmatv       type vnmatv,
        l_vnbew        type vnbew,
        l_vndia        type vndia,
        l_vndoc        type rndoc,
        l_vnicp        type vnicp,
        l_vn1fat       type vn1fat.

* Initialisierungen
  e_rc = 0.
  clear e_unmarked_entries.

* Die unmarkierten Einträge werden wie folgt ermittelt: In
* G_CANCEL_ALL stehen ALLE Einträge. In G_CANCEL stehen die
* markierten Einträge => G_CANCEL_ALL minus G_CANCEL ergibt
* die nicht markierten Einträge
  check not g_cancel_all is initial.

  refresh: lt_all_data,
           lt_marked_data.
  CALL METHOD g_cancel->get_data
    IMPORTING
      ET_CANCEL_DATA      = lt_marked_data.
  CALL METHOD g_cancel_all->get_data
    IMPORTING
      ET_CANCEL_DATA      = lt_all_data.

  loop at lt_marked_data into l_data.
*   Objektorientierte Daten
    loop at l_data-t_obj into l_obj.
      loop at lt_all_data into l_data2.
        delete l_data2-t_obj where object = l_obj-object.
      endloop.
    endloop.

*   NLEI
    loop at l_data-t_vnlei into l_vnlei.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vnlei where lnrls = l_vnlei-lnrls.
      endloop.
    endloop.

*   N2ZEITEN
    loop at l_data-t_vn2zeiten into l_vn2zeiten.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vn2zeiten
               where einri      = l_vn2zeiten-einri
               and   ankerleist = l_vn2zeiten-ankerleist
               and   zpid       = l_vn2zeiten-zpid.
      endloop.
    endloop.

*   N2OK
    loop at l_data-t_vn2ok into l_vn2ok.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vn2ok
               where einri      = l_vn2ok-einri
               and   ankerleist = l_vn2ok-ankerleist
               and   avb_lfdnr  = l_vn2ok-avb_lfdnr.
      endloop.
    endloop.

*   NMATV
    loop at l_data-t_vnmatv into l_vnmatv.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vnmatv where lnrlm = l_vnmatv-lnrlm.
      endloop.
    endloop.

*   NBEW
    loop at l_data-t_vnbew into l_vnbew.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vnbew
               where einri = l_vnbew-einri
               and   falnr = l_vnbew-falnr
               and   lfdnr = l_vnbew-lfdnr.
      endloop.
    endloop.

*   NDIA
    loop at l_data-t_vndia into l_vndia.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vndia
               where einri = l_vndia-einri
               and   falnr = l_vndia-falnr
               and   lfdnr = l_vndia-lfdnr.
      endloop.
    endloop.

*   NDOC
    loop at l_data-t_vndoc into l_vndoc.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vndoc
               where dokar  = l_vndoc-dokar
               and   doknr  = l_vndoc-doknr
               and   dokvr  = l_vndoc-dokvr
               and   doktl  = l_vndoc-doktl
               and   lfddok = l_vndoc-lfddok.
      endloop.
    endloop.

*   NICP
    loop at l_data-t_vnicp into l_vnicp.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vnicp
               where lnric = l_vnicp-lnric.
      endloop.
    endloop.


*   N1FAT
    loop at l_data-t_vn1fat into l_vn1fat.
      loop at lt_all_data into l_data2.
        delete l_data2-t_vn1fat
               where fatid = l_vn1fat-fatid.
      endloop.
    endloop.
  endloop.

  e_unmarked_entries[] = lt_all_data[].
endmethod.


METHOD handle_checkbox_change.

  DATA: l_environment  TYPE REF TO cl_ish_environment,
        lt_outtab      TYPE ishmed_t_cancel_tree_tab,
        l_outtab       TYPE rn1cancel_tree_fields,
        lt_excl_data   TYPE ishmed_t_cancel_excl_data,
        l_excl_data    TYPE LINE OF ishmed_t_cancel_excl_data,
        lt_cancel_data TYPE ishmed_t_cancel_datas,
        l_cancel_flags TYPE rn1cancel_flags,
        l_errorhandler TYPE REF TO cl_ishmed_errorhandling,
        l_rc           TYPE ish_method_rc,
        l_nbew         TYPE nbew,
        l_object       TYPE REF TO object,
        l_obj          TYPE ish_object,
        l_vnbew        TYPE vnbew,
        l_vndia        TYPE vndia,
        l_vn2ok        TYPE vn2ok,
        l_vn2zeiten    TYPE vn2zeiten,
        l_rndoc        TYPE rndoc,
        l_vnicp        TYPE vnicp,
        l_vnlei        TYPE vnlei,
        l_vnmatv       TYPE vnmatv,
        l_vn1fat       TYPE vn1fat,
        l_node_key     TYPE lvc_nkey,
        l_parent_node  TYPE lvc_nkey,
        lt_nodes       TYPE lvc_t_nkey,
        lt_vnbew       TYPE ish_yt_vnbew,
        lt_object      TYPE ish_objectlist,
        l_cramp        TYPE ty_cramp,
        l_mark_changed TYPE ish_on_off,                     " Nr 10081
        lt_mark_temp   TYPE ishmed_t_cancel_mark,           " Nr 10081
        lt_mark        TYPE ishmed_t_cancel_mark,
        l_mark         TYPE LINE OF ishmed_t_cancel_mark.

* Käfer, ID: 12776 - Begin
  DATA: lt_cancel_hierarchy  TYPE ishmed_t_cancel_hierarchy,
        lt_cancel_hierarchy2 TYPE ishmed_t_cancel_hierarchy,
        l_cancel_hierarchy   TYPE rn1cancel_hierarchy,
        l_cancel_hierarchy2  TYPE rn1cancel_hierarchy,
        l_cancel_hierarchy3  TYPE rn1cancel_hierarchy,
        lt_cancel_hier_down  TYPE ishmed_t_cancel_hierarchy,
        l_outtab_nbew        TYPE rn1cancel_tree_fields,
        l_falnr              TYPE falnr,
        l_nicp               TYPE nicp,
        l_nicp2              TYPE nicp,
        l_nmatv              TYPE nmatv,
        l_nmatv2             TYPE nmatv,
        lt_mark_hlp          TYPE ishmed_t_cancel_mark,
        l_mark_hlp           TYPE LINE OF ishmed_t_cancel_mark,
        l_flag               TYPE ish_on_off,
        ls_nlei              TYPE nlei,
        ls_nbew              TYPE nbew,
        l_count              TYPE i,
        l_cramp_click        TYPE ish_on_off,
        lt_additional_hier   TYPE ishmed_t_cancel_hierarchy,
        l_append_hierarchy   TYPE ish_on_off.


  CLEAR l_cramp_click.
* Käfer, ID: 12776 - End

* Cancel-Flags usw. aus der globalen Instanz der Cancel-
* Klasse holen
  REFRESH lt_mark.
  CALL METHOD g_cancel->get_data
    IMPORTING
      e_cancel_flags = l_cancel_flags
      et_mark        = lt_mark
      e_environment  = l_environment.

* Jetzt in G_CANCEL_MARKED eine neue Instanz der Cancel-Klasse
* anlegen und dort die EXCL-Tab befüllen und das
* COLLECT_OBJ_CANCEL aufrufen. Da dieses G_CANCEL_MARKED dann
* auch wirklich nur die markierten, d.h. die zu stornierenden
* Daten enthält, wird damit u.a. auch die geprüft
* Das G_CANCEL hier nicht ändern!
* Zuvor aber noch die EXCL-Tab aus der "alten" Instanz holen,
* denn die muss ja geändert werden
  REFRESH lt_excl_data.
  CALL METHOD g_cancel->get_data
    IMPORTING
      et_excl_data = lt_excl_data.

* Checkbox in der Hierarchiespalte wurde angeklickt
  IF fieldname = cl_gui_alv_tree=>c_hierarchy_column_name.
    REFRESH lt_outtab.
*   Wurde die Checkbox in einem Klammerknoten angeklickt?
    LOOP AT gt_cramp INTO l_cramp
            WHERE cramp_node_key = node_key.
      IF NOT l_cramp-data_key-object IS INITIAL.
        READ TABLE gt_outtab INTO l_outtab
                   WITH KEY object = l_cramp-data_key-object.
      ELSE.
        READ TABLE gt_outtab INTO l_outtab
                   WITH KEY line_key = l_cramp-data_key-line_key.
      ENDIF.
      IF sy-subrc = 0.
        APPEND l_outtab TO lt_outtab.
      ELSE.
*       Eintrag ist nicht in der Outtab enthalten => Das kann
*       z.B eine Ankerleistung sein, die ja nicht angezeigt
*       wird. Trotzdem muss sie natürlich ausgenommen werden!
        CLEAR l_outtab.
        l_outtab-object   = l_cramp-data_key-object.
        l_outtab-line_key = l_cramp-data_key-line_key.
        APPEND l_outtab TO lt_outtab.
      ENDIF.
*     Käfer, ID: 13578 - Begin
      l_cramp_click = on.
*     Käfer, ID: 13578 - End
    ENDLOOP.
    IF sy-subrc <> 0.
      CALL METHOD g_tree->get_outtab_line
        EXPORTING
          i_node_key     = node_key
        IMPORTING
          e_outtab_line  = l_outtab
        EXCEPTIONS
          node_not_found = 1
          OTHERS         = 2.
      IF sy-subrc = 0.
        APPEND l_outtab TO lt_outtab.
      ELSE.
        EXIT.
      ENDIF.
    ENDIF.

* Käfer, ID: 12776/13578 - Begin
* if the checkbox of the movement was selected (checked = off)
* it is necessary to skip the checkboxes of the procedures and
* materials, which were found through a service to editable
* (mandatory = off), but only the procedures and materials should
* be selected, which are connected to a case, which is also within
* the current storno-list
    IF NOT l_outtab IS INITIAL AND l_outtab-datatype = 'NBEW'.

      l_outtab_nbew = l_outtab.

      IF NOT g_cancel_all IS INITIAL.
        CALL METHOD g_cancel_all->get_data
          IMPORTING
            et_cancel_hierarchy = lt_cancel_hierarchy.
      ELSE.
        CALL METHOD g_cancel->get_data
          IMPORTING
            et_cancel_hierarchy = lt_cancel_hierarchy.
      ENDIF.

      REFRESH: lt_mark_hlp[],
               lt_additional_hier.
      lt_mark_hlp[] = lt_mark.

      CALL METHOD cl_ishmed_cancel_tree=>change_hierarchy_mark_table
        EXPORTING
          i_checked               = checked
          i_cramp_clicked         = l_cramp_click
          it_outtab               = lt_outtab
          is_outtab               = l_outtab
          ir_cancel               = g_cancel
        IMPORTING
          et_additional_hierarchy = lt_additional_hier
          e_append_hierarchy      = l_append_hierarchy
        CHANGING
          ct_cancel_hierarchy     = lt_cancel_hierarchy
          ct_mark                 = lt_mark_hlp.

    ENDIF.
* Käfer, ID: 12776/13578 - End

*   Das Objekt der Checkbox bei demarkierter Checkbox in die
*   Excluding-Tab der Cancel-Klasse stellen oder bei markierter
*   Checkbox aus der Excluding-Tab rausnehmen. Das dient dazu auch
*   Objekte, die von diesem Objekt abhängig sind zu markieren oder
*   zu demarkieren
*   Fichte, Nr 10081: Markierungen nicht einfach so aus GT_MARK
*   löschen, sondern schön markieren bzw. demarkieren
**   Ist das Objekt auch in der MARK-Tab enthalten, kann es von
**   dort entfernt werden (denn die Mark-Tab dient eigentlich nur
**   zum vorDEmarkieren von Daten)
    REFRESH lt_mark_temp.
    l_mark_changed = off.
    LOOP AT lt_outtab INTO l_outtab.
*      delete lt_mark where object   = l_outtab-object
*                     and   line_key = l_outtab-line_key.
      LOOP AT lt_mark INTO l_mark
              WHERE object   = l_outtab-object
              AND   line_key = l_outtab-line_key.
        l_mark_changed = on.
        l_mark-mark = checked.
        APPEND l_mark TO lt_mark_temp.
      ENDLOOP.
      IF sy-subrc = 0.
*       Fichte, Nr 11154: To leave this loop is wrong. It must be
*       continued!
*        exit.
        CONTINUE.
*       Fichte, Nr 11154 - End
      ENDIF.
*     Fichte, Nr 10081 - Ende
      IF checked = on.
        IF NOT l_outtab-object IS INITIAL.
          DELETE lt_excl_data WHERE object = l_outtab-object.
        ELSEIF NOT l_outtab-line_key IS INITIAL.
          DELETE lt_excl_data WHERE line_key = l_outtab-line_key.
        ENDIF.

      ELSE.   " if i_checked = on
        CLEAR l_excl_data.
        IF NOT l_outtab-object IS INITIAL.
          l_excl_data-object = l_outtab-object.
          APPEND l_excl_data TO lt_excl_data.
        ELSEIF NOT l_outtab-line_key IS INITIAL.
          l_excl_data-line_key = l_outtab-line_key.
          APPEND l_excl_data TO lt_excl_data.
        ENDIF.
      ENDIF.   " else if i_checked = on
    ENDLOOP.   " loop at lt_outtab into l_outtab.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

*   Markierungen wurden von der Methode vervollständigt, d.h.
*   abhängige Daten wurden mit markiert bzw. demarkiert.
*   Aber da man bedenken muss, dass ja auch noch andere Daten
*   in der MarkTab der Cancel-Klasse enthalten gewesen ist,
*   hier die neuen Markierungen mit den alten abgleichen
    IF l_mark_changed = on.
      CALL METHOD g_cancel->set_mark_tab
        EXPORTING
          it_mark = lt_mark_temp.
      REFRESH lt_mark_temp.
      CALL METHOD g_cancel->get_data
        IMPORTING
          et_mark = lt_mark_temp.
*     In LT_MARK stehen die ursprünglichen Markierungen, bevor
*     der Benutzer im Tree eine Checkbox angeklickt hat. Alles
*     was dort drinnen steht, aber nicht mehr in LT_MARK_TEMP,
*     muss erneut in die Mark-Tab der Cancel-Klasse hinein
      LOOP AT lt_mark INTO l_mark.
        READ TABLE lt_mark_temp TRANSPORTING NO FIELDS
                   WITH KEY object   = l_mark-object
                            line_key = l_mark-line_key.
        CHECK sy-subrc <> 0.
        APPEND l_mark TO lt_mark_temp.
      ENDLOOP.
*     Nun sind in LT_MARK_TEMP die neuen Markierungen und die
*     ursprünglichen gesammelt. Damit das Cancel versorgen ...
      CALL METHOD g_cancel->set_mark_tab
        EXPORTING
          it_mark = lt_mark_temp.
*     ... und die Anzeige des Trees auffrischen
      RAISE EVENT tree_changed.
*     Es ist nun nicht mehr notwendig das Einlesen der Cancel-
*     Daten neu zu starten, da es sich hier wirklich nur um eine
*     Änderung der Markierungen gehandelt hat
      EXIT.
    ENDIF.
*   Fichte, Nr 10081 - Ende

*   Markierungstabelle wieder an die Cancel-Klasse übergeben
    CALL METHOD g_cancel->set_mark_tab
      EXPORTING
        it_mark = lt_mark.

    IF g_cancel_all = g_cancel.
*     Eigene Instanz für G_CANCEL_ALL anlegen (enthält ALLE Daten)
      CALL METHOD cl_ish_cancel=>create
        EXPORTING
          i_copy_of  = g_cancel
        IMPORTING
          e_instance = g_cancel_all
          e_rc       = l_rc.
    ENDIF.

*   Und nun in G_CANCEL die EXCLTAB setzen
    CALL METHOD g_cancel->set_excl_data
      EXPORTING
        it_excl_data = lt_excl_data.

*   -------------------------------------------------------
*   Einlesen der Daten für die Objekte dieses Patienten nun
*   neu starten
*   Dazu aber zuerst die Knoten für diese Objekte ermitteln!
*   In dieser Schleife arbeitet man sich nach oben, bis zum
*   Wurzelknoten (d.h. bis zum Patienten)
    l_node_key = node_key.
    DO.
      CALL METHOD g_tree->get_parent
        EXPORTING
          i_node_key        = l_node_key
        IMPORTING
          e_parent_node_key = l_parent_node.
      IF l_parent_node IS INITIAL  OR
         l_parent_node = cl_gui_alv_tree=>c_virtual_root_node.
        EXIT.
      ENDIF.
      l_node_key = l_parent_node.
    ENDDO.

*   In L_NODE_KEY steht der Nodekey des Patientenknotens.
*   Darunter sind die Knoten der Hauptobjekte und die werden
*   ja gebraucht
    IF NOT l_node_key IS INITIAL.
      REFRESH lt_nodes.
      CALL METHOD g_tree->get_children
        EXPORTING
          i_node_key  = l_node_key
        IMPORTING
          et_children = lt_nodes.
    ENDIF.

*   Nun hat man die Nodekeys der Hauptobjekte in LT_NODES
*   stehen. Damit kommt man auf die OUTTAB und mit diesen
*   Daten kann man das COLLECT_OBJ_CANCEL erneut durchführen
    REFRESH: lt_vnbew,
             lt_object.
    LOOP AT lt_nodes INTO l_node_key.
      CLEAR l_outtab.
      CALL METHOD g_tree->get_outtab_line
        EXPORTING
          i_node_key     = l_node_key
        IMPORTING
          e_outtab_line  = l_outtab
        EXCEPTIONS
          node_not_found = 1
          OTHERS         = 2.
      CHECK sy-subrc = 0.

      CLEAR: l_object,
             l_vnbew.
      IF NOT l_outtab-object IS INITIAL.
        l_obj-object = l_outtab-object.
        APPEND l_obj TO lt_object.
      ELSEIF NOT l_outtab-lfdbew IS INITIAL.
*       Käfer, ID: 13578 - Begin
        l_vnbew-mandt = sy-mandt.
*       Käfer, ID: 13578 - End
        l_vnbew-einri = l_outtab-einri.
        l_vnbew-falnr = l_outtab-falnr.
        l_vnbew-lfdnr = l_outtab-lfdbew.
        APPEND l_vnbew TO lt_vnbew.
      ENDIF.
    ENDLOOP.
    IF sy-subrc = 0.
      CALL METHOD g_cancel->refresh
        EXPORTING
          it_object      = lt_object
          it_nbew        = lt_vnbew
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = l_errorhandler.
    ENDIF.

*   Käfer, ID: 12776/13578 - Begin
*   this coding is responsible for setting the new optionalizations
*   for new instance of g_cancel_all, which is responsible for
*   representation of the datas on dialog
    IF NOT l_outtab_nbew IS INITIAL.
*   the checkbox of the movement was deactivated
      IF checked = off.
*       Took the new hierarchy, which was built in the coding
*       above (12776) and set it for instance g_cancel_all
        CALL METHOD g_cancel_all->set_cancel_hierarchy
          EXPORTING
            it_cancel_hierarchy = lt_cancel_hierarchy.

        CALL METHOD g_cancel->call_set_default_marks
          EXPORTING
            i_default_marks = on
            it_mark         = lt_mark_hlp.

*        CALL METHOD g_cancel->set_mark_tab
*          EXPORTING
*            it_mark = lt_mark_hlp.

*     the checkbox of the movement was activated
      ELSE.

        CALL METHOD g_cancel->call_set_default_marks
          EXPORTING
            i_default_marks = on
            it_mark         = lt_mark_hlp.

*       get the new hierarchy of the instance g_cancel, where the
*       default-marks are included


        CALL METHOD g_cancel->get_data
          IMPORTING
            et_cancel_hierarchy = lt_cancel_hierarchy.

*       set the hierarchy from g_cancel to g_cancel_all.
*       this instance will be taken for presentation on dialog
*       but only, when it is necessary. Perhaps it is necessary to
*       append some entries to the new hierarchy, which were selected
*       through method CHANGE_HIERARCHY_MARK_TABLE

        IF lt_additional_hier IS INITIAL.

          CALL METHOD g_cancel_all->set_cancel_hierarchy
            EXPORTING
              it_cancel_hierarchy = lt_cancel_hierarchy.
        ELSEIF l_append_hierarchy = on.
          APPEND LINES OF lt_additional_hier TO lt_cancel_hierarchy.
          CALL METHOD g_cancel_all->set_cancel_hierarchy
            EXPORTING
              it_cancel_hierarchy = lt_cancel_hierarchy.
        ENDIF.
      ENDIF.
    ENDIF.
*   Käfer, ID: 12776/13578 - End

*   Event auslösen, dass sich im Tree etwas geändert hat. Der
*   Aufrufer kann dann einen OK-Code auslösen und neu prüfen und
*   den Tree auffrischen (Zähler-Knoten usw.)
    RAISE EVENT tree_changed.
  ENDIF.   " if fieldname = cl_gui_alv_tree=>c_hierarchy.....

ENDMETHOD.


method INITIALIZE.
  clear: g_tree,
         g_variant,
         g_cancel,
         g_cancel_all.
  refresh: gt_fieldcat,
           gt_outtab.
endmethod.


method OUTTAB_FROM_APPMNT .
  data: l_appmnt      type ref to cl_ish_appointment,
        l_ntmn        type ntmn,
        lt_napp       type ish_t_napp,
        l_napp        type line of ish_t_napp,
        l_dspty_text  type TN40A-DTEXT,
        l_n1ptit      type line of ishmed_t_n1ptit,
        lt_n1ptit     type ishmed_t_n1ptit,
        l_rc          type ish_method_rc.
  data: lt_obj        type ish_objectlist,
        l_obj         type ish_object,
        l_environment type ref to cl_ish_environment.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab,
         l_ntmn,
         l_environment.

  if not i_object is initial.
    l_appmnt ?= i_object.
    CALL METHOD l_appmnt->get_data
      EXPORTING
        I_FILL_APPOINTMENT = off
      IMPORTING
        ES_NTMN            = l_ntmn
        ET_NAPP            = lt_napp
        E_RC               = e_rc
      CHANGING
        C_ERRORHANDLER     = c_errorhandler.
    CALL METHOD l_appmnt->get_environment
      IMPORTING
        E_ENVIRONMENT = l_environment.
  else.
    e_rc = 1.
    exit.
  endif.
  check e_rc = 0.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_appmnt.
  e_outtab-object    = i_object.
  e_outtab-einri     = l_ntmn-einri.
  e_outtab-falnr     = l_ntmn-falnr.
  e_outtab-patnr     = l_ntmn-patnr.
  e_outtab-papid     = l_ntmn-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_OBJECT  = l_appmnt
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.

  read table lt_napp into l_napp index 1.
  if sy-subrc = 0.
    l_rc = 0.
    if l_ntmn-bewty = '4'.
*     Normaler OP/Behandlungstermin
      CALL FUNCTION 'ISH_DISPO_CHECK'
        EXPORTING
          ss_einri             = l_ntmn-einri
          ss_orgid             = l_napp-orgpf
          ss_dispo             = l_napp-dspty
          SS_VALID_CHECK       = off
        IMPORTING
          SS_DTEXT             = l_dspty_text
*         SS_TN40B             =
        EXCEPTIONS
          NOT_FOUND            = 1
          NOT_VALID            = 2
          OTHERS               = 3.
    else.
*     Aufnahmetermin
      refresh lt_n1ptit.
      CALL METHOD cl_ishmed_master_dp=>read_inpatient_dispotype
        EXPORTING
          I_SPRAS         = SY-LANGU
          I_EINRI         = l_ntmn-einri
          I_PTINP         = l_napp-ptinp
        IMPORTING
          E_RC            = l_rc
          ET_N1PTIT       = lt_n1ptit.
      read table lt_n1ptit into l_n1ptit index 1.
      if sy-subrc = 0.
        l_dspty_text = l_n1ptit-ptint.
      endif.
    endif.
    if sy-subrc = 0  and
       l_rc = 0  and
       not l_dspty_text is initial.
      e_outtab-catext = l_dspty_text.
    else.
      e_outtab-catext = l_napp-dspty.
    endif.
  endif.
  e_outtab-cadate    = l_ntmn-tmndt.
  e_outtab-catime    = l_ntmn-tmnzt.
  e_outtab-caou      = l_ntmn-tmnoe.
*  e_outtab-cagpart   =      " Bei Terminen leer
*  e_outtab-castate   =      " Bei Terminen leer
*  e_outtab-caclass   =      " Bei Terminen leer
*  e_outtab-key       =      " Bei Terminen leer

* Kontext des Termins ermitteln
  CALL METHOD cl_ish_appointment=>get_context_for_appmnt
    EXPORTING
      i_appointment               = l_appmnt
      i_environment               = l_environment
*     Den Kontext auch lesen, wenn der das Stornoflag bereits
*     gesetzt hat
      I_CANCELLED_DATAS           = on
    IMPORTING
      ET_CONTEXT                  = lt_obj
      E_RC                        = l_rc
    CHANGING
      C_ERRORHANDLER              = c_errorhandler.
  if l_rc <> 0.
    e_rc = l_rc.
  else.
    read table lt_obj into l_obj index 1.
    if sy-subrc = 0.
      CALL METHOD cl_ishmed_cancel_tree=>build_context_text
        EXPORTING
          i_object       = l_obj-object
        IMPORTING
          E_TEXT         = e_outtab-cacotext
          E_ICON         = e_outtab-cacoicon.
    endif.
  endif.

  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


METHOD outtab_from_context.
  DATA: l_context     TYPE REF TO cl_ish_context,
        l_environment TYPE REF TO cl_ish_environment,
        l_nctx        TYPE nctx,
        l_type        TYPE i,
        l_rc          TYPE ish_method_rc.
  DATA: lt_obj        TYPE ish_objectlist,
        l_obj         TYPE ish_object,
        l_service     TYPE REF TO cl_ishmed_service,
        l_request     TYPE REF TO cl_ishmed_request,
        l_prereg      TYPE REF TO cl_ishmed_prereg,
        l_appmnt      TYPE REF TO cl_ish_appointment,
        l_nlei        TYPE nlei,
        l_nlem        TYPE nlem,
        l_n1anf       TYPE n1anf,
        l_n1vkg       TYPE n1vkg,
        l_ntmn        TYPE ntmn.

* Initialisierungen
  e_rc = 0.
  CLEAR: e_outtab,
         l_nctx,
         l_environment.

  IF NOT i_object IS INITIAL.
    l_context ?= i_object.
    CALL METHOD l_context->get_data
      EXPORTING
        i_fill_context = off
      IMPORTING
        e_rc           = e_rc
        e_nctx         = l_nctx
      CHANGING
        c_errorhandler = c_errorhandler.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.
  CHECK e_rc = 0.

* Die Objektdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_context.
  e_outtab-object    = i_object.
* Einrichtung usw. kommen aus den Objekten des Kontexts
  CALL METHOD l_context->get_environment
    IMPORTING
      e_environment = l_environment.
  CALL METHOD cl_ish_context=>get_objects_for_context
    EXPORTING
      i_cancelled_datas = on
      i_context         = l_context
      i_environment     = l_environment
    IMPORTING
      e_rc              = l_rc
      et_objects        = lt_obj
    CHANGING
      c_errorhandler    = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  LOOP AT lt_obj INTO l_obj.
    CALL METHOD l_obj-object->('GET_TYPE')
      IMPORTING
        e_object_type = l_type.
    CASE l_type.
      WHEN cl_ishmed_service=>co_otype_med_service  OR
           cl_ishmed_service=>co_otype_anchor_srv.
        l_service ?= l_obj-object.
        CALL METHOD l_service->get_data
          EXPORTING
            i_fill_service = off
          IMPORTING
            e_rc           = l_rc
            e_nlei         = l_nlei
            e_nlem         = l_nlem
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
        e_outtab-einri = l_nlei-einri.
        e_outtab-falnr = l_nlei-falnr.
        e_outtab-patnr = l_nlem-patnr.
        e_outtab-papid = l_nlem-papid.

      WHEN cl_ishmed_request=>co_otype_request.
        l_request ?= l_obj-object.
        CALL METHOD l_request->get_data
          EXPORTING
            i_fill_request = off
          IMPORTING
            e_rc           = l_rc
            e_n1anf        = l_n1anf
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
        e_outtab-einri = l_n1anf-einri.
        e_outtab-falnr = l_n1anf-falnr.
        e_outtab-patnr = l_n1anf-patnr.

      WHEN cl_ish_appointment=>co_otype_appointment.
        l_appmnt ?= l_obj-object.
        CALL METHOD l_appmnt->get_data
          EXPORTING
            i_fill_appointment = off
          IMPORTING
            es_ntmn            = l_ntmn
            e_rc               = l_rc
          CHANGING
            c_errorhandler     = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
        e_outtab-einri = l_ntmn-einri.
        e_outtab-falnr = l_ntmn-falnr.
        e_outtab-patnr = l_ntmn-patnr.
        e_outtab-papid = l_ntmn-papid.

      WHEN cl_ishmed_prereg=>co_otype_prereg OR
           cl_ishmed_cordpos=>co_otype_cordpos_med.
        l_prereg ?= l_obj-object.
        CALL METHOD l_prereg->get_data
          EXPORTING
            i_fill_prereg  = off
          IMPORTING
            e_rc           = l_rc
            e_n1vkg        = l_n1vkg
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
        e_outtab-einri = l_n1vkg-einri.
        e_outtab-falnr = l_n1vkg-falnr.
        e_outtab-patnr = l_n1vkg-patnr.
        e_outtab-papid = l_n1vkg-papid.

      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    EXIT.
  ENDLOOP.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = l_obj-object
      i_patnr   = e_outtab-patnr
      i_papid   = e_outtab-papid
    IMPORTING
      e_pattext = e_outtab-patname.
  e_rc = 0.
  CHECK e_rc = 0.

* Text
  CALL METHOD cl_ishmed_cancel_tree=>build_context_text
    EXPORTING
      i_object = l_context
    IMPORTING
      e_rc     = l_rc
      e_text   = e_outtab-catext
      e_icon   = e_outtab-icon.

*  e_outtab-cadate    =
  e_outtab-catime    = '      '.
*  e_outtab-caou      = l_n1vkg-orgid.
  e_outtab-cagpart   = l_nctx-cxrsp.

* Status
  e_outtab-castate = l_nctx-cxsta.
*  e_outtab-caclass   =
*  e_outtab-cakey     =
ENDMETHOD.


METHOD outtab_from_corder .
  DATA: lr_corder   TYPE REF TO cl_ish_corder,
        l_n1corder  TYPE n1corder.

* Initialisierungen
  e_rc = 0.
  CLEAR: e_outtab,
         l_n1corder.

  IF NOT i_object IS INITIAL.
    lr_corder ?= i_object.
    CALL METHOD lr_corder->get_data
      EXPORTING
        i_fill          = off
      IMPORTING
        es_n1corder     = l_n1corder
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.
  CHECK e_rc = 0.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_corder.
  e_outtab-object    = i_object.
  e_outtab-einri     = l_n1corder-einri.
  e_outtab-falnr     = ' '.                       "TODO
  e_outtab-patnr     = l_n1corder-patnr.
  e_outtab-papid     = l_n1corder-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = lr_corder
      i_patnr   = e_outtab-patnr
      i_papid   = e_outtab-papid
    IMPORTING
      e_pattext = e_outtab-patname.
  e_rc = 0.

  e_outtab-catext    = l_n1corder-cordtitle.      "TODO
  e_outtab-cadate    = l_n1corder-erdat.
  e_outtab-catime    = l_n1corder-ertim.
* Käfer, ID: 13578 - Begin
* if the order is caused by an gpa the oe must not be displayed
  CASE l_n1corder-etrby.
    WHEN '1'.
      e_outtab-caou = l_n1corder-etroe.
      e_outtab-cagpart = l_n1corder-etrgp.
    WHEN '2'.
      e_outtab-caou = ' '.
      e_outtab-cagpart = l_n1corder-etrgp.
    WHEN OTHERS.
      e_outtab-caou = ' '.
      e_outtab-cagpart = ' '.
  ENDCASE.
*  e_outtab-caou      = l_n1corder-etroe.          "TODO
*  e_outtab-cagpart   = l_n1corder-etrgp.          "TODO
* Käfer, ID: 13578 - End

  SELECT SINGLE wlstx FROM tn42v
                      INTO e_outtab-castate
                      WHERE spras = sy-langu
                      AND   einri = l_n1corder-einri
                      AND   wlsta = l_n1corder-wlsta.
  e_outtab-caclass   = ' '.                       "TODO
  WRITE l_n1corder-prgnr TO e_outtab-cakey USING EDIT MASK '==ALPHA'.
*  e_outtab-cakey     = l_n1corder-corderid.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      e_icon   = e_outtab-icon.
ENDMETHOD.


METHOD outtab_from_cysrvtpl.

* Begin, Siegl MED-34863
  DATA: lr_cysrvtpl       TYPE REF TO cl_ishmed_cycle_srv_tpl,
        ls_n1cysrvtpl     TYPE n1cysrvtpl,
        l_rc              TYPE ish_method_rc.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  e_rc = 0.
  CLEAR: es_outtab.

  IF ir_object IS INITIAL.
    e_rc = 8.
    EXIT.
  ENDIF.

* get data from the object
  lr_cysrvtpl ?= ir_object.

  CALL METHOD lr_cysrvtpl->get_data
    IMPORTING
      e_rc            = l_rc
      es_n1cysrvtpl   = ls_n1cysrvtpl
    CHANGING
      cr_errorhandler = cr_errorhandler.

  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.


* fill table for output
  es_outtab-dependent = i_dependent.
  es_outtab-type      = co_cysrvtpl.
  es_outtab-object    = ir_object.
  es_outtab-einri     = ls_n1cysrvtpl-einri.
  es_outtab-cakey     = ls_n1cysrvtpl-leist.
  es_outtab-catime    = '      '.

  CALL METHOD lr_cysrvtpl->get_service_text
    IMPORTING
      e_text = es_outtab-catext.

  CALL METHOD lr_cysrvtpl->if_ish_get_patient~get_patient
    IMPORTING
      e_patnr         = es_outtab-patnr
      e_papid         = es_outtab-papid
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = lr_cysrvtpl
      i_patnr   = es_outtab-patnr
      i_papid   = es_outtab-papid
    IMPORTING
      e_pattext = es_outtab-patname.

* get icon
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = es_outtab
    IMPORTING
      e_icon   = es_outtab-icon.

* End, Siegl MED-34863

ENDMETHOD.


method OUTTAB_FROM_INSURANCE_POL_PROV.
  data: l_insurance   type ref to cl_ish_insurance_policy_prov,
        l_environment type ref to cl_ish_environment,
        l_nipp_data   type rnipp_attrib,
*        l_vn1vkg      type vn1vkg,                      " Käfer, 13178
*        l_prereg      type ref to cl_ishmed_prereg.     " Käfer, 13178
        ls_n1corder   type n1corder,                     " Käfer, 13178
        lr_corder     type ref to cl_ish_corder.         " Käfer, 13178

* Initialisierungen
  e_rc = 0.
  clear: e_outtab,
*         l_prereg,                                      " Käfer, 13178
         lr_corder,                                      " Käfer, 13178
         l_environment,
         l_insurance,
         l_nipp_data.

  if not i_object is initial.
    l_insurance ?= i_object.
    CALL METHOD l_insurance->get_data
      IMPORTING
*       ES_KEY         =
        ES_DATA        = l_nipp_data
        E_RC           = e_rc
      CHANGING
        C_ERRORHANDLER = c_errorhandler.
  else.
    e_rc = 1.
    exit.
  endif.
  check e_rc = 0.

  CALL METHOD l_insurance->get_environment
    IMPORTING
      E_ENVIRONMENT = l_environment.

* Die Objektdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_insurance_pol_prov.
  e_outtab-object    = i_object.


* Käfer, ID: 13178 - Begin

* now the insurance policy provision doesn´t longer depend to the
* orderposition. From now it is connected directly to the ORDER

* Die Felder EINRI, FALNR, PATNR, PAPID kommen aus der Vormerkung,
* der das Objekt zugeordnet ist
*  clear l_vn1vkg.
*  CALL METHOD cl_ish_insurance_policy_prov=>get_prereg_for_insur_policy
*    EXPORTING
*      i_policy          = l_insurance
*      i_environment     = l_environment
*    IMPORTING
*      E_RC              = e_rc
*      E_N1VKG           = l_vn1vkg
*      E_PREREG          = l_prereg
*    CHANGING
*      C_ERRORHANDLER    = c_errorhandler.
*  check e_rc = 0.
*  e_outtab-einri     = l_vn1vkg-einri.
*  e_outtab-falnr     = l_vn1vkg-falnr.
*  e_outtab-patnr     = l_vn1vkg-patnr.
*  e_outtab-papid     = l_vn1vkg-papid.

  clear ls_n1corder.
  CALL METHOD l_insurance->get_corder
    EXPORTING
      IR_ENVIRONMENT  = l_environment
    IMPORTING
      ER_CORDER       = lr_corder
      E_RC            = e_rc
    CHANGING
      CR_ERRORHANDLER = c_errorhandler.

  check e_rc = 0.

  if not lr_corder is initial.
    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder = ls_n1corder.
  endif.

  e_outtab-einri    = ls_n1corder-einri.
  e_outtab-patnr    = ls_n1corder-patnr.
  e_outtab-papid    = ls_n1corder-papid.

* Käfer, ID: 13178 - End

  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
*      I_OBJECT  = l_prereg                        " Käfer, ID 13178
      I_OBJECT  = lr_corder                        " Käfer, ID 13178
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.

* CAText (Text des Knotens)
  e_outtab-catext     = l_nipp_data-kname.
  if l_nipp_data-kname is initial.
    e_outtab-catext = l_nipp_data-ipid.
  endif.
*  e_outtab-cadate    =
  e_outtab-catime    = '      '.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
*  e_outtab-caclass   =
*  e_outtab-cakey     =
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_MED_SRV .
  data: l_srv         type ref to cl_ishmed_service,
        l_environment type ref to cl_ish_environment,
        l_nlei        type nlei,
        l_nlem        type nlem,
        l_rnpap_key   type rnpap-key,
        l_rc          type ish_method_rc.
  data: lt_n1lsstt    type ishmed_t_n1lsstt,
        l_n1lsstt     type line of ishmed_t_n1lsstt,
        l_vntmn       type vntmn,
        l_ktxt        type RNFP1T-KTXTCONC,
        l_gpart       type ngpa-gpart.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab,
         l_environment,
         l_nlei,
         l_nlem.

* Objekt hat Vorrang vor NLEI
  if not i_object is initial.
    l_srv ?= i_object.
    CALL METHOD l_srv->get_data
      EXPORTING
        I_FILL_SERVICE = OFF
      IMPORTING
        E_RC           = e_rc
        E_NLEI         = l_nlei
        E_NLEM         = l_nlem
        E_GPART        = l_gpart
      CHANGING
        C_ERRORHANDLER = c_errorhandler.
    CALL METHOD l_srv->get_environment
      IMPORTING
        E_ENVIRONMENT = l_environment.
  elseif not i_nlei-lnrls is initial.
    l_nlei = i_nlei.
  else.
    e_rc = 1.
    exit.
  endif.
  check e_rc = 0.

* Termin der Leistung ermitteln, um zu prüfen ob dieser uhrzeit-
* oder tagesgenau ist
  CALL METHOD cl_ishmed_service=>get_appmnt_for_service
    EXPORTING
      i_service          = l_srv
      i_environment      = l_environment
    IMPORTING
      E_NTMN             = l_vntmn
      E_RC               = l_rc.
  if l_rc <> 0.
    clear l_vntmn.
  endif.

* Die Leistungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_service.
  e_outtab-object    = i_object.
  e_outtab-einri     = l_nlei-einri.
  e_outtab-lnrls     = l_nlei-lnrls.
  e_outtab-falnr     = l_nlei-falnr.
  e_outtab-patnr     = l_nlem-patnr.
  e_outtab-papid     = l_nlem-papid.
  if e_outtab-patnr is initial  and
     e_outtab-papid is initial.
    CALL METHOD cl_ishmed_service=>get_patient_provi
      EXPORTING
        i_service          = l_srv
        i_environment      = l_environment
      IMPORTING
        E_PAP_KEY          = l_rnpap_key
        E_RC               = l_rc.
    if l_rc = 0.
      e_outtab-papid = l_rnpap_key-papid.
    endif.
  endif.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_OBJECT  = l_srv
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.
  CALL METHOD cl_ishmed_service=>build_service_text
    EXPORTING
      I_NLEI    = l_nlei
      I_SERVICE = l_srv
    IMPORTING
      E_TEXT    = e_outtab-catext.

  e_outtab-cadate    = l_nlei-ibgdt.
* Uhrzeit '       ' ausgeben, wenn Termin tagesgenau
  if l_vntmn-tmtag = on.
    e_outtab-catime = '      '.
  else.
    e_outtab-catime = l_nlei-ibzt.
  endif.
  e_outtab-caou      = l_nlei-erboe.
  e_outtab-cagpart   = l_gpart.

  if not l_nlem-lnrls is initial.
    if not l_nlem-lsstae is initial.
*      CALL METHOD cl_ishmed_master_dp=>read_servicestate_text
*        EXPORTING
*          I_SPRAS         = SY-LANGU
*          I_EINRI         = l_nlei-einri
*          I_LSSTAE        = l_nlem-lsstae
**          I_BUFFER_ACTIVE = SPACE
**          I_READ_DB       = SPACE
*        IMPORTING
*          E_RC            = e_rc
*          ET_N1LSSTT      = lt_n1lsstt
*        CHANGING
*          C_ERRORHANDLER  = c_errorhandler.
*      check e_rc = 0.
*      read table lt_n1lsstt into l_n1lsstt index 1.
*      if sy-subrc = 0.
*        e_outtab-castate = l_n1lsstt-lssttxt.
*      endif.
      e_outtab-castate = l_nlem-lsstae.
    endif.   " if not l_nlem-lsstae is initial
  endif.   " if not l_nlem-lnrls is initial
*  e_outtab-caclass     =        " Bei Leistung leer
  write l_nlei-leist to e_outtab-cakey no-zero.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method outtab_from_me_event .

  data: ls_n1meevent      type n1meevent,
        ls_vn1meorder     type vn1meorder,
        ls_tn1estatus     type tn1estatus,
        ls_ext_stat       type tn1estatust.

  data: lr_event          type ref to cl_ishmed_me_event,
        lr_order          type ref to cl_ishmed_me_order.

  data: l_order_descr     type n1me_order_descr,
        l_rc              type ish_method_rc.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  e_rc = 0.
  clear: es_outtab, ls_n1meevent.

  if ir_object is initial.
    e_rc = 8.
    exit.
  endif.

* get data from the object
  lr_event ?= ir_object.

  call method lr_event->get_data
    importing
      e_rc            = e_rc
      es_n1meevent    = ls_n1meevent
    changing
      cr_errorhandler = cr_errorhandler.

  if e_rc <> 0.
    exit.
  endif.

* fill table for output
  es_outtab-dependent = i_dependent.
  es_outtab-type      = co_me_event.
  es_outtab-object    = ir_object.
  es_outtab-einri     = ls_n1meevent-einri.
  es_outtab-falnr     = ls_n1meevent-falnr.

* get patient id
  call method cl_ishmed_me_event=>get_order_for_event
    exporting
      ir_event        = lr_event
    importing
      e_rc            = e_rc
      er_order        = lr_order
      es_n1meorder    = ls_vn1meorder
    changing
      cr_errorhandler = cr_errorhandler.

  if e_rc <> 0.
    exit.
  endif.

  es_outtab-patnr = ls_vn1meorder-patnr.

  call method cl_ishmed_cancel_tree=>build_patient_data
    exporting
      i_object  = lr_event
      i_patnr   = es_outtab-patnr
    importing
      e_pattext = es_outtab-patname.

* get internal status
  call method cl_ishmed_me_event=>get_status_internal
    exporting
      i_einri         = ls_n1meevent-einri
      i_mesid         = ls_n1meevent-mesid
      ir_object       = lr_event
    importing
      es_tn1estatus   = ls_tn1estatus
      e_rc            = e_rc
    changing
      cr_errorhandler = cr_errorhandler.

  if e_rc <> 0.
    exit.
  endif.

  case ls_tn1estatus-intst.
    when '01' or       "saved
         '02' or       "confirmed
         '03'.         "in progress
*     -> internal status until "administered"
      es_outtab-caou    = ls_vn1meorder-orgpf.
      es_outtab-cadate  = ls_n1meevent-pbdad.      "plan date
      es_outtab-catime  = ls_n1meevent-pbtad.      "plan time
      es_outtab-cagpart = ls_vn1meorder-moresp1.

    when '04' or       "administered
         '06'.         "ended                      "RW ID 19064
*     -> internal status from "administered"
      es_outtab-caou    = ls_n1meevent-medocou.
      es_outtab-cadate  = ls_n1meevent-rbdad.      "real date
      es_outtab-catime  = ls_n1meevent-rbtad.      "real time
      es_outtab-cagpart = ls_n1meevent-meresp1.

    when others.
      exit.
  endcase.

  call method cl_ishmed_me_event=>get_status_external
    exporting
      i_einri          = ls_n1meevent-einri
      i_mesid          = ls_n1meevent-mesid
      ir_object        = lr_event
      i_etype          = ls_n1meevent-etype   " Fichte, ID 15967
    importing
      es_last_ext_stat = ls_ext_stat
      e_rc             = l_rc.

  if l_rc <> 0.
    clear es_outtab-castate.
  else.
    es_outtab-castate = ls_ext_stat-userst.
  endif.

  es_outtab-cakey    = ls_n1meevent-meevtid.
  es_outtab-caclass  = 'Verordnung'(t09).
  es_outtab-cacotext = ls_vn1meorder-meordid.

  clear: l_rc, l_order_descr.

* get order description
  call method cl_ishmed_me_order=>get_description_for_order
    exporting
      ir_order      = lr_order
    importing
      e_order_descr = l_order_descr
      e_rc          = l_rc.

  if l_rc <> 0.
    clear es_outtab-catext.
  else.
    es_outtab-catext = l_order_descr.
  endif.

* get icon
  call method cl_ishmed_cancel_tree=>get_node_icon
    exporting
      i_outtab = es_outtab
    importing
      e_icon   = es_outtab-icon.

endmethod.


method outtab_from_me_order .

  data: ls_ext_stat        type tn1ostatust,
        ls_n1meorder       type n1meorder.

  data: lr_order           type ref to cl_ishmed_me_order.

  data: l_order_descr      type n1me_order_descr,
        l_rc               type ish_method_rc.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  e_rc = 0.
  clear: es_outtab, ls_n1meorder.

  if ir_object is initial.
    e_rc = 8.
    exit.
  endif.

* get data from the object
  lr_order ?= ir_object.
  call method lr_order->get_data
    importing
      e_rc            = e_rc
      es_n1meorder    = ls_n1meorder
    changing
      cr_errorhandler = cr_errorhandler.

  if e_rc <> 0.
    exit.
  endif.

* fill table for output
  es_outtab-dependent = i_dependent.
  es_outtab-type      = co_me_order.
  es_outtab-object    = ir_object.
  es_outtab-einri     = ls_n1meorder-einri.
  es_outtab-falnr     = ls_n1meorder-falnr.
  es_outtab-patnr     = ls_n1meorder-patnr.
  es_outtab-caou      = ls_n1meorder-orgpf.
  es_outtab-cadate    = ls_n1meorder-movdf.    "Validity date from
  es_outtab-catime    = ls_n1meorder-movtf.    "Validity time from

  clear l_rc.

  call method cl_ishmed_me_order=>get_status_external
    exporting
      i_einri          = ls_n1meorder-einri
      i_mosid          = ls_n1meorder-mosid
      ir_object        = lr_order
    importing
      es_last_ext_stat = ls_ext_stat
      e_rc             = l_rc.

  if l_rc <> 0.
    clear es_outtab-castate.
  else.
    es_outtab-castate = ls_ext_stat-userst.
  endif.

  clear: l_rc, l_order_descr.

* get order description
  call method cl_ishmed_me_order=>get_description_for_order
    exporting
      ir_order      = lr_order
    importing
      e_order_descr = l_order_descr
      e_rc          = l_rc.

  if l_rc <> 0.
    clear es_outtab-catext.
  else.
    es_outtab-catext = l_order_descr.
  endif.

  es_outtab-cakey     = ls_n1meorder-meordid.
  es_outtab-cagpart   = ls_n1meorder-moresp1.
  es_outtab-caclass   = 'Rezept'(t08).
  es_outtab-cacotext  = ls_n1meorder-mpresnr.

  call method cl_ishmed_cancel_tree=>build_patient_data
    exporting
      i_object  = lr_order
      i_patnr   = es_outtab-patnr
    importing
      e_pattext = es_outtab-patname.

* get icon
  call method cl_ishmed_cancel_tree=>get_node_icon
    exporting
      i_outtab = es_outtab
    importing
      e_icon   = es_outtab-icon.

endmethod.


method OUTTAB_FROM_N1FAT.
  data: l_vn1fat      type vn1fat,
        l_rc          type ish_method_rc.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_vn1fat = i_n1fat.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_transport.
  e_outtab-datatype  = 'N1FAT'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = i_n1fat
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_vn1fat-einri.
  e_outtab-patnr     = l_vn1fat-patnr.
  e_outtab-papid     = l_vn1fat-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.
  if not l_vn1fat-orgzl is initial.
    concatenate l_vn1fat-orgag '->' l_vn1fat-orgzl
                into e_outtab-catext.
  else.
    e_outtab-catext = l_vn1fat-orgag.
  endif.
*  e_outtab-cadate    = l_vnbew-bwidt.
  e_outtab-catime    = '      '.
*  e_outtab-caou      = l_vnbew-orgpf.
*  e_outtab-cagpart   =
*  e_outtab-castate   = l_statu_ex.
*  e_outtab-caclass   =      " Bei Terminen leer
*  e_outtab-key       =
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_N2OK.
  data: l_vn2ok       type vn2ok,
        l_dd07v       type dd07v,
        l_service     type ref to cl_ishmed_service,
        l_nlem        type nlem,
        l_nlei        type nlei,
        l_text        type rn1cancel_tree_fields-catext,
        l_rc          type ish_method_rc.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_vn2ok = i_n2ok.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_n2ok.
  e_outtab-datatype  = 'N2OK'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = i_n2ok
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_vn2ok-einri.

* Aus der Ankerleistung FALNR/PATNR/PAPID ermitteln
  CALL METHOD cl_ishmed_service=>load
    EXPORTING
      i_lnrls              = l_vn2ok-ankerleist
      i_environment        = i_environment
    IMPORTING
      E_INSTANCE           = l_service
      E_RC                 = l_rc
    CHANGING
      C_ERRORHANDLER       = c_errorhandler.
  if l_rc <> 0.
    e_rc = l_rc.
    exit.
  endif.
  CALL METHOD l_service->get_data
    EXPORTING
      I_FILL_SERVICE = OFF
    IMPORTING
      E_RC           = l_rc
      E_NLEI         = l_nlei
      E_NLEM         = l_nlem
    CHANGING
      C_ERRORHANDLER = c_errorhandler.
  if l_rc <> 0.
    e_rc = l_rc.
    exit.
  endif.
  e_outtab-falnr     = l_nlei-falnr.
  e_outtab-patnr     = l_nlem-patnr.
  e_outtab-papid     = l_nlem-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.

* Text besteht aus Schlüssel, Schweregrad und Zeitpunkt
  l_text = l_vn2ok-ishm_avbna.
  clear l_dd07v.
  CALL FUNCTION 'ISH_N2_READ_DOMAIN_VALUES'
    EXPORTING
      ss_domain          = 'N2_STUFEKO'
      SS_VALUE           = l_vn2ok-ishm_iavbs
    IMPORTING
      SS_DD07V           = l_dd07v
    EXCEPTIONS
      NOT_FOUND          = 1
      OTHERS             = 2.
  if sy-subrc = 0.
    concatenate l_text l_dd07v-ddtext into l_text.
  endif.
  clear l_dd07v.
  CALL FUNCTION 'ISH_N2_READ_DOMAIN_VALUES'
    EXPORTING
      ss_domain          = 'N2_ZTKOMP'
      SS_VALUE           = l_vn2ok-ishm_avbzp
    IMPORTING
      SS_DD07V           = l_dd07v
    EXCEPTIONS
      NOT_FOUND          = 1
      OTHERS             = 2.
  if sy-subrc = 0.
    concatenate l_text l_dd07v-ddtext into l_text.
  endif.
  e_outtab-catext    = l_text.
  e_outtab-cadate    = l_vn2ok-ishm_avbd.
  e_outtab-catime    = l_vn2ok-ishm_avbu.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
*  e_outtab-caclass   =      " Bei Terminen leer
*  e_outtab-key       =
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_N2ZEITEN.
  data: l_vn2zeiten   type vn2zeiten,
        l_service     type ref to cl_ishmed_service,
        l_nlem        type nlem,
        l_nlei        type nlei,
        l_text        type rn1cancel_tree_fields-catext,
        l_rc          type ish_method_rc.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_vn2zeiten = i_n2zeiten.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_n2zeiten.
  e_outtab-datatype  = 'N2ZEITEN'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = i_n2zeiten
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_vn2zeiten-einri.

* Aus der Ankerleistung FALNR/PATNR/PAPID ermitteln
  CALL METHOD cl_ishmed_service=>load
    EXPORTING
      i_lnrls              = l_vn2zeiten-ankerleist
      i_environment        = i_environment
    IMPORTING
      E_INSTANCE           = l_service
      E_RC                 = l_rc
    CHANGING
      C_ERRORHANDLER       = c_errorhandler.
  if l_rc <> 0.
    e_rc = l_rc.
    exit.
  endif.
  CALL METHOD l_service->get_data
    EXPORTING
      I_FILL_SERVICE = OFF
    IMPORTING
      E_RC           = l_rc
      E_NLEI         = l_nlei
      E_NLEM         = l_nlem
    CHANGING
      C_ERRORHANDLER = c_errorhandler.
  if l_rc <> 0.
    e_rc = l_rc.
    exit.
  endif.
  e_outtab-falnr     = l_nlei-falnr.
  e_outtab-patnr     = l_nlem-patnr.
  e_outtab-papid     = l_nlem-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.

* Text besteht nur aus der Zeitpunktbezeichnung
  select single zpbez from N2ZTPDEFT into l_text
                where einri = l_vn2zeiten-einri
                and   zpid  = l_vn2zeiten-zpid
                and   spras = sy-langu.
  if sy-subrc <> 0.
    l_text = l_vn2zeiten-zpid.
  endif.
  e_outtab-catext    = l_text.
  e_outtab-cadate    = l_vn2zeiten-datum.
  e_outtab-catime    = l_vn2zeiten-uhrzeit.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
*  e_outtab-caclass   =      " Bei Terminen leer
*  e_outtab-key       =
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_NBEW.
  data: l_vnbew       type vnbew,
        l_nfal        type nfal,
        l_statu_ex    type TN14E-STATUS_EX,
        lt_tn14u      type ISHMED_T_TN14U,
        l_tn14u       type line of ishmed_t_tn14u,
        l_tn14t       type tn14t,
        l_rc          type ish_method_rc.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_vnbew = i_nbew.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_movement.
  e_outtab-datatype  = 'NBEW'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = i_nbew
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_vnbew-einri.
  e_outtab-falnr     = l_vnbew-falnr.
  e_outtab-lfdbew    = l_vnbew-lfdnr.
  CALL FUNCTION 'ISH_READ_NFAL'
    EXPORTING
      ss_einri                 = e_outtab-einri
      ss_falnr                 = e_outtab-falnr
*     SS_READ_DB               = ' '
      SS_CHECK_AUTH            = off
    IMPORTING
      SS_NFAL                  = l_nfal
    EXCEPTIONS
      NOT_FOUND                = 1
      NOT_FOUND_ARCHIVED       = 2
      NO_AUTHORITY             = 3
      OTHERS                   = 4.
  if sy-subrc = 0.
    e_outtab-patnr = l_nfal-patnr.
  endif.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.
  if not l_vnbew-bwart is initial.
    refresh lt_tn14u.
    CALL METHOD cl_ishmed_master_dp=>read_movementtype_text
      EXPORTING
        I_EINRI         = l_vnbew-einri
        I_BEWTY         = l_vnbew-bewty
        I_BWART         = l_vnbew-bwart
        I_BUFFER_ACTIVE = on
      IMPORTING
        E_RC            = l_rc
        ET_TN14U        = lt_tn14u.
    read table lt_tn14u into l_tn14u
                        with key spras = sy-langu
                                 einri = l_vnbew-einri
                                 bewty = l_vnbew-bewty
                                 bwart = l_vnbew-bwart.
    if sy-subrc = 0.
      e_outtab-catext = l_tn14u-bwatx.
    else.
      e_outtab-catext = l_vnbew-bwart.
    endif.
  else.
    select single * from tn14t into l_tn14t
                    where einri = l_vnbew-einri
                    and   bewty = l_vnbew-bewty
                    and   spras = sy-langu.
    if sy-subrc = 0.
      e_outtab-catext = l_tn14t-bewtx.
    endif.
  endif.
  e_outtab-cadate    = l_vnbew-bwidt.
  e_outtab-catime    = l_vnbew-bwizt.
  e_outtab-caou      = l_vnbew-orgpf.
*  e_outtab-cagpart   =
  if not l_vnbew-statu is initial.
    clear l_statu_ex.
    CALL FUNCTION 'ISH_CONVERT_VISITSTATUS_OUTPUT'
      EXPORTING
        ss_einri            = e_outtab-einri
        ss_status_in        = l_vnbew-statu
      IMPORTING
        SS_STATUS_EX        = l_statu_ex
      EXCEPTIONS
        NOT_FOUND           = 1
        OTHERS              = 2.
    if sy-subrc = 0.
      e_outtab-castate = l_statu_ex.
    endif.
  endif.
*  e_outtab-caclass   =      " Bei Terminen leer
*  e_outtab-key       =
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_NDIA.
  data: l_vndia         type vndia,
        l_nfal          type nfal,
        l_nbew          type nbew,
        l_rc            type ish_method_rc,
        l_text          type rn1cancel_tree_fields-cagpart,
        l_dtname        type dd04v-scrtext_l,
        lt_nkdi         type ishmed_t_nkdi,
        l_nkdi          type nkdi.
  constants: lco_sep(2) type c value ',|'.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_vndia = i_ndia.

* Die Daten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_diagnosis.
  e_outtab-datatype  = 'NDIA'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = i_ndia
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_vndia-einri.
  e_outtab-falnr     = l_vndia-falnr.
  e_outtab-lfdbew    = l_vndia-lfdbew.
  CALL FUNCTION 'ISH_READ_NFAL'
    EXPORTING
      ss_einri                 = e_outtab-einri
      ss_falnr                 = e_outtab-falnr
*     SS_READ_DB               = ' '
      SS_CHECK_AUTH            = off
    IMPORTING
      SS_NFAL                  = l_nfal
    EXCEPTIONS
      NOT_FOUND                = 1
      NOT_FOUND_ARCHIVED       = 2
      NO_AUTHORITY             = 3
      OTHERS                   = 4.
  if sy-subrc = 0.
    e_outtab-patnr = l_nfal-patnr.
  endif.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.

* CAText
  if not l_vndia-ditxt is initial.
    e_outtab-catext = l_vndia-ditxt.
  else.
    clear l_nkdi.
    select single * from nkdi into l_nkdi
                    where spras = sy-langu
                    and   dkat  = l_vndia-dkat1
                    and   dkey  = l_vndia-dkey1.
    if sy-subrc = 0.
      concatenate l_nkdi-dtext1 l_nkdi-dtext2
                  into e_outtab-catext.
      concatenate e_outtab-catext l_nkdi-dtext3
                  into e_outtab-catext.
    endif.
  endif.

* Datum/Zeit
  e_outtab-cadate    = l_vndia-diadt.
  e_outtab-catime    = l_vndia-diazt.

* OrgId (aus ORGFA(!) der Bewegung)
  if not l_vndia-einri  is initial  and
     not l_vndia-falnr  is initial  and
     not l_vndia-lfdbew is initial.
*   Fichte, Nr 10099: ISH_NBEWTAB_GET_LFDNR durch
*   ISHMED_READ_NBEW ersetzt
    CALL FUNCTION 'ISHMED_READ_NBEW'
      EXPORTING
        I_EINRI              = l_vndia-einri
        I_FALNR              = l_vndia-falnr
        I_LFDNR              = l_vndia-lfdbew
      IMPORTING
        E_RC                 = l_rc
        E_NBEW               = l_nbew.
    if l_rc = 0.
      e_outtab-caou = l_nbew-orgfa.
    endif.
*   Fichte, Nr 10099 - Ende
  endif.

* GPART
  if not l_vndia-diape is initial.
    CALL FUNCTION 'ISHMED_GET_VMA_TEXT'
         EXPORTING
              i_einri       = l_vndia-einri
              i_gpart       = l_vndia-diape
         IMPORTING
              e_vmatext     = l_text
         EXCEPTIONS
              vma_not_found = 1
              OTHERS        = 2.
    IF sy-subrc <> 0.
      CLEAR l_text.
    ENDIF.
    e_outtab-cagpart = l_text.
  endif.

* CAKlass (Klassifikation)
  clear e_outtab-caclass.
  if not l_vndia-ewdia IS INITIAL.
    clear l_dtname.
    l_dtname(5) = 'BehD'(D01).
    concatenate e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-afdia is initial.
    CALL METHOD cl_ishmed_cancel_tree=>read_dtel_text
      EXPORTING
        i_dtname = 'KZ_AUFND'
      IMPORTING
        E_TEXT   = l_dtname.
    CONCATENATE e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-ardia is initial.
    CALL METHOD cl_ishmed_cancel_tree=>read_dtel_text
      EXPORTING
        i_dtname = 'N2_KZARDIA'
      IMPORTING
        E_TEXT   = l_dtname.
    CONCATENATE e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-podia is initial.
    CALL METHOD cl_ishmed_cancel_tree=>read_dtel_text
      EXPORTING
        i_dtname = 'N2_KZPODIA'
      IMPORTING
        E_TEXT   = l_dtname.
    CONCATENATE e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-opdia IS INITIAL.
    clear l_dtname.
    l_dtname(5) = 'OPDia'(D02).
    concatenate e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-endia IS INITIAL.
    clear l_dtname.
    l_dtname(5) = 'EntD'(D03).
    concatenate e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-tudia is initial.
    CALL METHOD cl_ishmed_cancel_tree=>read_dtel_text
      EXPORTING
        i_dtname = 'N2_KZTUDIA'
      IMPORTING
        E_TEXT   = l_dtname.
    CONCATENATE e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-fhdia IS INITIAL.
    clear l_dtname.
    l_dtname(5) = 'FaHD'(D04).
    concatenate e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-khdia IS INITIAL.
    clear l_dtname.
    l_dtname(5) = 'KrhHD'(D05).
    concatenate e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
  if not l_vndia-bhdia is initial  and
     e_outtab-caclass is initial.
    clear l_dtname.
    l_dtname(5) = 'BehD'(D01).
    concatenate e_outtab-caclass lco_sep l_dtname
                into e_outtab-caclass.
  endif.
* Ersten beiden Stellen enthalten den Separator
  e_outtab-caclass = e_outtab-caclass+2.
  translate e_outtab-caclass using '| '.

* Weitere Felder
*  e_outtab-castate   =
  concatenate l_vndia-dkat1 l_vndia-dkey1 into e_outtab-cakey
              separated by space.
  concatenate e_outtab-cakey l_vndia-dtyp1 into e_outtab-cakey.

  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_NDOC.
  data: l_rndoc    type rndoc,
        l_tn2flag  type tn2flag.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_rndoc = i_ndoc.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_ndoc.
  e_outtab-datatype  = 'NDOC'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = l_rndoc
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_rndoc-einri.
  e_outtab-patnr     = l_rndoc-patnr.
  e_outtab-falnr     = l_rndoc-falnr.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
    IMPORTING
      E_PATTEXT = e_outtab-patname.

* CATEXT: Aus dem Dokumenttyptext
  select single dtkb from n2dtt into e_outtab-catext
                where spras  = sy-langu
                and   einri  = l_rndoc-einri
                and   dtid   = l_rndoc-dtid
                and   dtvers = l_rndoc-dtvers.
  if sy-subrc <> 0.
    clear e_outtab-catext.
  endif.

  e_outtab-cagpart   = l_rndoc-mitarb.
  e_outtab-cadate    = l_rndoc-dodat.
  e_outtab-catime    = l_rndoc-dotim.
  e_outtab-caou      = l_rndoc-orgdo.
  select single dokst from draw into e_outtab-castate
                where dokar = l_rndoc-dokar
                and   doknr = l_rndoc-doknr
                and   dokvr = l_rndoc-dokvr
                and   doktl = l_rndoc-doktl.

* Klassifizierung und Icon: Aus NDOC-PCODE
  clear l_tn2flag.
  if not l_rndoc-pcode is initial.
    select single * from tn2flag into l_tn2flag
                    where einri  = l_rndoc-einri
                    and   flagid = l_rndoc-pcode.
    if sy-subrc = 0.
      e_outtab-icon    = l_tn2flag-icon.
      e_outtab-caclass = l_tn2flag-text.
    endif.
  endif.
  e_outtab-cakey = l_rndoc-dtid.

  if e_outtab-icon is initial.
    CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
      EXPORTING
        i_outtab    = e_outtab
        i_data_line = l_rndoc
      IMPORTING
        E_ICON      = e_outtab-icon.
  endif.
endmethod.


method OUTTAB_FROM_NFAL .
* This method was created in course of implementing
* the cancel of the case (ID: 12776)
  data: ls_nfal        type nfal,
        l_rc          type ish_method_rc.

* Initializations
  e_rc = 0.
  clear: es_outtab.
  ls_nfal = is_nfal.

* now put the necessary datas into outtab-structure
  es_outtab-dependent = i_dependent.
  es_outtab-type      = co_case.
  es_outtab-datatype  = 'NFAL'.

  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = is_nfal
      i_datatype = es_outtab-datatype
    IMPORTING
      E_LINE_KEY = es_outtab-line_key.

  es_outtab-einri     = ls_nfal-einri.
  es_outtab-falnr     = ls_nfal-falnr.

  es_outtab-patnr = ls_nfal-patnr.

  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = es_outtab-patnr
      I_PAPID   = es_outtab-papid
    IMPORTING
      E_PATTEXT = es_outtab-patname.

  if not ls_nfal-falar is initial.
    case ls_nfal-falar.
      when '1'.
        es_outtab-catext = 'Stationaerer Fall'(028).
      when '2'.
        es_outtab-catext = 'Ambulanter Fall'(029).
      when '3'.
        es_outtab-catext = 'Teilstationaerer Fall'(030).
    endcase.
  endif.

  es_outtab-cadate    = ls_nfal-begdt.
*  e_outtab-catime    = l_vnbew-bwizt.
  es_outtab-caou      = ls_nfal-fachr.
*  es_outtab-cagpart   = ls_nfal-erusr.

*  e_outtab-caclass   =      " Bei Terminen leer
  es_outtab-cakey       = ls_nfal-falnr.
  es_outtab-castate = ls_nfal-statu.

* the method get_node_icon is responsible for searching the
* right icon for the case. Within this method the function
* ISHMED_GET_DATA_ICON_AND_TEXT will be called.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = es_outtab
    IMPORTING
      E_ICON   = es_outtab-icon.

endmethod.


method OUTTAB_FROM_NICP.
  data: l_vnicp       type vnicp,
        l_nfal        type nfal,
        l_nbew        type nbew,
        l_int         type i,
        l_text        type RNFP1T-KTXTCONC,
        l_rc          type ish_method_rc.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_vnicp = i_nicp.

* Bewegung wird auch gebraucht
  clear l_nbew.
  if not l_vnicp-lfdbew is initial.
*   Fichte, Nr 10099: ISH_NBEWTAB_GET_LFDNR durch
*   ISHMED_READ_NBEW ersetzt
    CALL FUNCTION 'ISHMED_READ_NBEW'
      EXPORTING
        I_EINRI              = l_vnicp-einri
        I_FALNR              = l_vnicp-falnr
        I_LFDNR              = l_vnicp-lfdbew
      IMPORTING
        E_RC                 = l_rc
        E_NBEW               = l_nbew.
    if l_rc <> 0.
      clear l_nbew.
    endif.
*   Fichte, Nr 10099 - Ende
  endif.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_nicp.
  e_outtab-datatype  = 'NICP'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = i_nicp
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_vnicp-einri.
  e_outtab-falnr     = l_vnicp-falnr.
  CALL FUNCTION 'ISH_READ_NFAL'
    EXPORTING
      ss_einri                 = e_outtab-einri
      ss_falnr                 = e_outtab-falnr
*     SS_READ_DB               = ' '
      SS_CHECK_AUTH            = off
    IMPORTING
      SS_NFAL                  = l_nfal
    EXCEPTIONS
      NOT_FOUND                = 1
      NOT_FOUND_ARCHIVED       = 2
      NO_AUTHORITY             = 3
      OTHERS                   = 4.
  if sy-subrc = 0.
    e_outtab-patnr = l_nfal-patnr.
  endif.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.

* CATEXT
  if not l_vnicp-btext is initial.
    e_outtab-catext = l_vnicp-btext.
  else.
    CALL FUNCTION 'ISH_READ_NTPT'
         EXPORTING
              einri     = l_vnicp-einri
              talst     = l_vnicp-icpml
              tarif     = l_vnicp-icpmk
         IMPORTING
              ktxtconc  = l_text
         EXCEPTIONS
              not_found = 1
              OTHERS    = 2.
    if sy-subrc <> 0.
      e_outtab-catext = l_vnicp-icpml.
    else.
      e_outtab-catext = l_text.
    endif.
  endif.

  if not l_vnicp-lfdbew is initial.
    e_outtab-cadate    = l_nbew-bwidt.
    e_outtab-catime    = l_nbew-bwizt.
  else.
    e_outtab-cadate    = l_vnicp-bgdop.
    e_outtab-catime    = l_vnicp-bztop.
  endif.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
  if l_vnicp-icphc = on.
    e_outtab-caclass   = 'HC'(t07).
  endif.
  e_outtab-cakey     = l_vnicp-icpml.

  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_NLEI.
  data: l_nlei     type nlei,
        l_nfal     type nfal,
        l_vnlei    type vnlei.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_vnlei = i_nlei.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
* 9682, 41: ISH-Leistungen wie ISHMED-Leistungen ausgeben
  e_outtab-type      = co_service.
*  e_outtab-type      = co_nlei.
  e_outtab-datatype  = 'NLEI'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = l_vnlei
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_vnlei-einri.
  e_outtab-lnrls     = l_vnlei-lnrls.
  e_outtab-falnr     = l_vnlei-falnr.
  if not e_outtab-falnr is initial.
    CALL FUNCTION 'ISH_READ_NFAL'
      EXPORTING
        ss_einri                 = l_vnlei-einri
        ss_falnr                 = l_vnlei-falnr
        SS_CHECK_AUTH            = off
      IMPORTING
        SS_NFAL                  = l_nfal
      EXCEPTIONS
        NOT_FOUND                = 1
        NOT_FOUND_ARCHIVED       = 2
        NO_AUTHORITY             = 3
        OTHERS                   = 4.
    if sy-subrc = 0.
      e_outtab-patnr = l_nfal-patnr.
    else.
      clear l_nfal.
    endif.
  endif.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = l_nfal-patnr
    IMPORTING
      E_PATTEXT = e_outtab-patname.
  l_nlei = l_vnlei.
  CALL METHOD cl_ishmed_service=>build_service_text
    EXPORTING
      I_NLEI    = l_nlei
    IMPORTING
      E_TEXT    = e_outtab-catext.

  e_outtab-cadate    = l_vnlei-ibgdt.
  e_outtab-catime    = l_vnlei-ibzt.
  e_outtab-caou      = l_vnlei-erboe.

*  e_outtab-castate   =
*  e_outtab-caclass     =        " Bei Leistung leer
  e_outtab-cakey       = l_vnlei-leist.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_NMATV.
  data: l_vnmatv      type vnmatv,
        l_nfal        type nfal,
        l_int         type i,
        l_text(20)    type c,
        l_rc          type ish_method_rc.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab.
  l_vnmatv = i_nmatv.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_nmatv.
  e_outtab-datatype  = 'NMATV'.
  CALL METHOD cl_ishmed_errorhandling=>build_line_key
    EXPORTING
      i_data     = i_nmatv
      i_datatype = e_outtab-datatype
    IMPORTING
      E_LINE_KEY = e_outtab-line_key.
  e_outtab-einri     = l_vnmatv-einri.
  e_outtab-falnr     = l_vnmatv-falnr.
  CALL FUNCTION 'ISH_READ_NFAL'
    EXPORTING
      ss_einri                 = e_outtab-einri
      ss_falnr                 = e_outtab-falnr
*     SS_READ_DB               = ' '
      SS_CHECK_AUTH            = off
    IMPORTING
      SS_NFAL                  = l_nfal
    EXCEPTIONS
      NOT_FOUND                = 1
      NOT_FOUND_ARCHIVED       = 2
      NO_AUTHORITY             = 3
      OTHERS                   = 4.
  if sy-subrc = 0.
    e_outtab-patnr = l_nfal-patnr.
  endif.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.
* Menge ohne Nachkommastellen!
  l_int  = l_vnmatv-menge.
  if l_int > l_vnmatv-menge.
    l_int = l_int - 1.
  endif.
  l_text = l_int.
  condense l_text.
  select single maktx from makt into e_outtab-catext
                where matnr = l_vnmatv-matnr
                and   spras = sy-langu.
  if sy-subrc = 0.
    concatenate e_outtab-catext ':§§' l_text ',§§' l_vnmatv-meins "#EC *
                into e_outtab-catext.
  else.
    concatenate l_vnmatv-matnr ':§§' l_text ',§§' l_vnmatv-meins  "#EC *
                into e_outtab-catext.
  endif.
  do.
    replace '§§' with ' ' into e_outtab-catext.  "#EC *
    if sy-subrc <> 0.
      exit.
    endif.
  enddo.
*  e_outtab-cadate    =
  e_outtab-catime    = '      '.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
*  e_outtab-caclass   =
  e_outtab-cakey     = l_vnmatv-lnrlm.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


METHOD outtab_from_object .

  DATA: l_type TYPE i,
        l_rc   TYPE ish_method_rc.
  DATA: lr_identify_object TYPE REF TO if_ish_identify_object.

  e_rc = 0.
  e_no_outtab = off.
  CLEAR e_outtab.

  CHECK NOT i_object IS INITIAL.

* Replace GET_TYPE with IS_INHERITED_FROM ID13178 ANDERLN231003
  lr_identify_object ?= i_object.

* services
  IF lr_identify_object->is_inherited_from(
       cl_ishmed_service=>co_otype_med_service ) = on.
*   Normale medizinische Leistung
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_med_srv
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Ankerleistung:
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_service=>co_otype_anchor_srv )  = on.

*     Eine OP wird nur angezeigt, wenn sie das Hauptobjekt ist. Wird
*     sie dagegen nur mitstorniert, wird lediglich eine Warnung
*     ausgegeben
    IF i_dependent = on.
      e_no_outtab = on.
    ENDIF.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_surgery
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Anforderung
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_request=>co_otype_request ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_request
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Vormerkung
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_prereg=>co_otype_prereg ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_prereg
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Termin
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ish_appointment=>co_otype_appointment ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_appmnt
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Vitalparameter
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_vitpar=>co_otype_vitpar ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_vitpar
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Team
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_team=>co_otype_team ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_team
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Kontext
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ish_context=>co_otype_context ) = on.
*     Kontext wird nur angezeigt, wenn er das Hauptobjekt ist. Wird
*     er dagegen nur mitstorniert ist er nicht sichtbar
    IF i_dependent = on.
      e_no_outtab = on.
    ELSE.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_context
        EXPORTING
          i_dependent    = i_dependent
          i_object       = i_object
        IMPORTING
          e_rc           = l_rc
          e_outtab       = e_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
    ENDIF.

* Vorläufiger Patient
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_patient_provisional=>co_otype_prov_patient ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_prov_pat
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Vorläufiges Versicherungsverhältnis (NIPP)
  ELSEIF lr_identify_object->is_inherited_from(
    cl_ish_insurance_policy_prov=>co_otype_prov_insurance_policy ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_insurance_pol_prov
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Diagnosen zur Vormerkung (NDIP)
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_pre_diag
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Prozeduren zur Vormerkung (NPCP)
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ish_prereg_procedure=>co_otype_prereg_procedure ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_pre_proc
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Abwesenheiten von der Warteliste (NWLM)
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ish_waiting_list_absence=>co_otype_wl_absence ) = on.
*     Objekt wird nur angezeigt, wenn er das Hauptobjekt ist. Wird
*     er dagegen nur mitstorniert ist er nicht sichtbar
    IF i_dependent = on.
      e_no_outtab = on.
    ELSE.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_wait_abs
        EXPORTING
          i_dependent    = i_dependent
          i_object       = i_object
        IMPORTING
          e_rc           = l_rc
          e_outtab       = e_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
    ENDIF.

* clinical Order
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_corder=>co_otype_corder ) = on.
    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_corder
      EXPORTING
        i_dependent    = i_dependent
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
        e_outtab       = e_outtab
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Medical order
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_me_order=>co_otype_me_order ) = on.

    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_me_order
      EXPORTING
        i_dependent     = i_dependent
        ir_object       = i_object
      IMPORTING
        e_rc            = l_rc
        es_outtab       = e_outtab
      CHANGING
        cr_errorhandler = c_errorhandler.

    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

* Medical event
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_me_event=>co_otype_me_event ) = on.

    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_me_event
      EXPORTING
        i_dependent     = i_dependent
        ir_object       = i_object
      IMPORTING
        e_rc            = l_rc
        es_outtab       = e_outtab
      CHANGING
        cr_errorhandler = c_errorhandler.

    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

*   Hoebarth MED-33288 BEGIN
*   service (N1SRV)
* Medical event
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_srv_service=>co_otype_srv_service ) = on.

    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_srv_service
      EXPORTING
        i_dependent     = i_dependent
        ir_object       = i_object
      IMPORTING
        e_rc            = l_rc
        es_outtab       = e_outtab
      CHANGING
        cr_errorhandler = c_errorhandler.

    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
*   Hoebarth MED-33288 END

* Begin, Siegl MED-34863
* Cycle Service Template
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_cycle_srv_tpl=>co_otype_cycle_srv_tpl ) = on.

    IF i_dependent = on.
      e_no_outtab = on.
    ELSE.
      CALL METHOD cl_ishmed_cancel_tree=>outtab_from_cysrvtpl
        EXPORTING
          i_dependent     = i_dependent
          ir_object       = i_object
        IMPORTING
          e_rc            = l_rc
          es_outtab       = e_outtab
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
    ENDIF.
* End, Siegl MED-34863

* begin IXX-272
* Anordnung
  ELSEIF lr_identify_object->is_inherited_from(
       cl_ishmed_pord_run_dta=>co_otype_porder ) = on.

    CALL METHOD cl_ishmed_cancel_tree=>outtab_from_porder
      EXPORTING
        i_dependent     = i_dependent
        ir_object       = i_object
      IMPORTING
        e_rc            = l_rc
        es_outtab       = e_outtab
      CHANGING
        cr_errorhandler = c_errorhandler.

    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
* end IXX-272

*   Fremdes Objekt: Hier soll kein Eintrag in die OUTTAB
*   aufgenommen werden => E_NO_OUTTAB = ON setzen
  ELSE.
    CATCH SYSTEM-EXCEPTIONS dynamic_call_method_errors = 1.
      CALL METHOD i_object->('BUILD_OUTTAB_CANCEL_TREE')
        EXPORTING
          i_dependent    = i_dependent
        IMPORTING
          e_rc           = l_rc
          e_outtab       = e_outtab
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
    ENDCATCH.
    IF sy-subrc <> 0.
      e_no_outtab = on.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD outtab_from_porder.
* new for IXX-272

  DATA: lr_pord_run_dta TYPE REF TO cl_ishmed_pord_run_dta,
        lr_status       TYPE REF TO cl_ish_estat,
        ls_n1pord       TYPE n1pord,
        l_rc            TYPE ish_method_rc,
        l_j_status      TYPE j_status.


  e_rc = 0.
  CLEAR: es_outtab.

  IF ir_object IS INITIAL.
    e_rc = 8.
    EXIT.
  ENDIF.

* get data from the object
  lr_pord_run_dta ?= ir_object.

  CALL METHOD lr_pord_run_dta->get_data
    IMPORTING
      e_rc           = l_rc
      e_porder       = ls_n1pord
    CHANGING
      c_errorhandler = cr_errorhandler.

  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.


* fill table for output
  es_outtab-dependent = i_dependent.
  es_outtab-type      = co_porder.
  es_outtab-object    = ir_object.
  es_outtab-catext    = ls_n1pord-order_short_text.
  es_outtab-cadate    = ls_n1pord-erdat.
  es_outtab-catime    = ls_n1pord-ertim.
  es_outtab-patnr     = ls_n1pord-patient_id.

  es_outtab-einri     = ls_n1pord-institution_id.
  es_outtab-falnr     = ls_n1pord-case_id.
  es_outtab-lfdbew    = ls_n1pord-movemnt_seqno.
  es_outtab-caou      = ls_n1pord-placer_nurs_ou.
  es_outtab-cagpart   = ls_n1pord-employee_resp.
  es_outtab-castate   = ls_n1pord-stokz.
  es_outtab-cakey     = ls_n1pord-porder_id .

  es_outtab-caclass   = 'Anordnung'(T10).


  CALL FUNCTION 'STATUS_BUFFER_REFRESH'.
  cl_ish_status=>read_status(
    EXPORTING
      i_objnr         = ls_n1pord-objnr
    IMPORTING
      e_estat         = l_j_status
      er_estat        = lr_status ).

  IF lr_status IS NOT INITIAL.
    es_outtab-castate = lr_status->get_txt30( ).
  ENDIF.



  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = lr_pord_run_dta
      i_patnr   = es_outtab-patnr
      i_papid   = es_outtab-papid
    IMPORTING
      e_pattext = es_outtab-patname.

* get icon
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = es_outtab
    IMPORTING
      e_icon   = es_outtab-icon.

ENDMETHOD.


METHOD outtab_from_prereg.
  DATA: l_prereg      TYPE REF TO cl_ishmed_prereg,
        l_n1vkg       TYPE n1vkg,
        lt_nprtt      TYPE ishmed_t_nprtt,
        l_nprtt       TYPE LINE OF ishmed_t_nprtt,
        ls_n1cordtypt TYPE n1cordtypt.

  DATA: lr_estat      TYPE REF TO cl_ish_estat,             "ID 17499
        l_txt30       TYPE tj30t-txt30.                     "ID 17499

* Initialisierungen
  e_rc = 0.
  CLEAR: e_outtab,
         l_n1vkg.

  IF NOT i_object IS INITIAL.
    l_prereg ?= i_object.
    CALL METHOD l_prereg->get_data
      EXPORTING
        i_fill_prereg  = off
      IMPORTING
        e_rc           = e_rc
        e_n1vkg        = l_n1vkg
      CHANGING
        c_errorhandler = c_errorhandler.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.
  CHECK e_rc = 0.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_prereg.
  e_outtab-object    = i_object.
  e_outtab-einri     = l_n1vkg-einri.
  e_outtab-falnr     = l_n1vkg-falnr.
  e_outtab-patnr     = l_n1vkg-patnr.
  e_outtab-papid     = l_n1vkg-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = l_prereg
      i_patnr   = e_outtab-patnr
      i_papid   = e_outtab-papid
    IMPORTING
      e_pattext = e_outtab-patname.
  e_rc = 0.
  REFRESH lt_nprtt.

* handle old version
  IF NOT l_n1vkg-prtid IS INITIAL.
    CALL METHOD cl_ish_master_dp=>read_nprt
      EXPORTING
        i_prtid        = l_n1vkg-prtid
      IMPORTING
        e_rc           = e_rc
        et_nprtt       = lt_nprtt
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_nprtt INTO l_nprtt
                        INDEX 1.
    IF sy-subrc = 0.
      e_outtab-catext = l_nprtt-prtnm.
    ELSE.
      e_outtab-catext = l_n1vkg-prtid.
    ENDIF.

  ELSEIF NOT l_n1vkg-cordtypid IS INITIAL.
* handle new version clinical order
    SELECT SINGLE * FROM  n1cordtypt INTO ls_n1cordtypt
           WHERE  cordtypid  = l_n1vkg-cordtypid
           AND    spras      = sy-langu.
    IF sy-subrc EQ 0.
      e_outtab-catext = ls_n1cordtypt-cordtname.
    ENDIF.
  ENDIF.

  e_outtab-cadate    = l_n1vkg-erdat.
  e_outtab-catime    = '      '.
  e_outtab-caou      = l_n1vkg-orgid.
*  e_outtab-cagpart   =      " Bei Vormerkung leer

*  e_outtab-castate   = l_n1vkg-wlsta.                  "REM ID 17499
*  SELECT SINGLE wlstx FROM tn42v                       "REM ID 17499
*                      INTO e_outtab-castate
*                      WHERE spras = sy-langu
*                      AND   einri = l_n1vkg-einri
*                      AND   wlsta = l_n1vkg-wlsta.
  CALL METHOD l_prereg->get_status                          "ID 17499
    IMPORTING
      er_estat        = lr_estat
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF e_rc = 0                                               "ID 17499
     AND NOT lr_estat IS INITIAL.                           "ID 19773
    CALL METHOD lr_estat->get_txt30                         "ID 17499
      RECEIVING
        r_txt30 = l_txt30.

    e_outtab-castate   = l_txt30.                           "ID 17499
  ENDIF.                                                    "ID 17499

*  e_outtab-caclass     =    " Bei Vormerkung leer
  e_outtab-cakey     = l_n1vkg-prtid.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      e_icon   = e_outtab-icon.
ENDMETHOD.


method OUTTAB_FROM_PRE_DIAG.
  data: l_pre_diag    type ref to cl_ish_prereg_diagnosis,
        l_environment type ref to cl_ish_environment,
        l_ndip_data   type rndip_attrib,
*        l_vn1vkg      type vn1vkg,                      " Käfer, 13178
*        l_prereg      type ref to cl_ishmed_prereg,     " Käfer, 13178
        ls_n1corder   type n1corder,                     " Käfer, 13178
        lr_corder     type ref to cl_ish_corder,         " Käfer, 13178
        l_nkdi        type nkdi.


* Initialisierungen
  e_rc = 0.
  clear: e_outtab,
         l_environment,
*         l_prereg,                  " Käfer, ID: 13178
         lr_corder,                   " Käfer, ID: 13178
         l_pre_diag,
         l_ndip_data.

  if not i_object is initial.
    l_pre_diag ?= i_object.
    CALL METHOD l_pre_diag->get_data
      IMPORTING
*        ES_KEY         =
        ES_DATA        = l_ndip_data
        E_RC           = e_rc
      CHANGING
        C_ERRORHANDLER = c_errorhandler.
  else.
    e_rc = 1.
    exit.
  endif.
  check e_rc = 0.

  CALL METHOD l_pre_diag->get_environment
    IMPORTING
      E_ENVIRONMENT = l_environment.

* Die Objektdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_prov_diagnosis.
  e_outtab-object    = i_object.

* Käfer, ID: 13178 - Begin
* now the diagnose doesn´t longer depend to the orderposition. From now
* it is connected directly to the ORDER

* Die Felder EINRI, FALNR, PATNR, PAPID kommen aus der Vormerkung,
* der das Objekt zugeordnet ist
*  clear l_vn1vkg.
*  CALL METHOD cl_ish_prereg_diagnosis=>get_prereg_for_diagnosis
*    EXPORTING
*      i_diagnosis       = l_pre_diag
*      i_environment     = l_environment
*    IMPORTING
*      E_RC              = e_rc
*      E_N1VKG           = l_vn1vkg
*      E_PREREG          = l_prereg
*    CHANGING
*      C_ERRORHANDLER    = c_errorhandler.
*  check e_rc = 0.
*  e_outtab-einri     = l_vn1vkg-einri.
*  e_outtab-falnr     = l_vn1vkg-falnr.
*  e_outtab-patnr     = l_vn1vkg-patnr.
*  e_outtab-papid     = l_vn1vkg-papid.
*  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
*    EXPORTING
*      I_OBJECT  = l_prereg
*      I_PATNR   = e_outtab-patnr
*      I_PAPID   = e_outtab-papid
*    IMPORTING
*      E_PATTEXT = e_outtab-patname.

  clear ls_n1corder.
  CALL METHOD l_pre_diag->get_corder
    EXPORTING
      IR_ENVIRONMENT  = l_environment
    IMPORTING
      ER_CORDER       = lr_corder
      E_RC            = e_rc
    CHANGING
      CR_ERRORHANDLER = c_errorhandler.

  check e_rc = 0.

  if not lr_corder is initial.
    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder = ls_n1corder.
  endif.

  e_outtab-einri    = ls_n1corder-einri.
  e_outtab-patnr    = ls_n1corder-patnr.
  e_outtab-papid    = ls_n1corder-papid.

  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = lr_corder
      i_patnr   = e_outtab-patnr
      i_papid   = e_outtab-papid
    IMPORTING
      e_pattext = e_outtab-patname.

* Käfer, ID: 13178 - End

* CAText (Text des Knotens)
  clear l_nkdi.
  select single * from nkdi into l_nkdi
                  where spras = sy-langu
                  and   dkat  = l_ndip_data-dcat
                  and   dkey  = l_ndip_data-dkey.
  if sy-subrc = 0.
    concatenate l_nkdi-dtext1 l_nkdi-dtext2
                into e_outtab-catext.
    concatenate e_outtab-catext l_nkdi-dtext3
                into e_outtab-catext.
  endif.

* Weitere Felder
*  e_outtab-cadate    =
  e_outtab-catime    = '      '.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
*  e_outtab-caclass   =
  concatenate l_ndip_data-dcat l_ndip_data-dkey into e_outtab-cakey
              separated by space.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


METHOD outtab_from_pre_proc.
  DATA: l_pre_proc    TYPE REF TO cl_ish_prereg_procedure,
        l_environment TYPE REF TO cl_ish_environment,
        l_npcp_data   TYPE rnpcp_attrib,
*        l_vn1vkg      type vn1vkg,                       " Käfer, 13178
*        l_prereg      type ref to cl_ishmed_prereg,      " Käfer, 13178
        ls_n1corder   TYPE n1corder,                      " Käfer, 13178
        lr_corder     TYPE REF TO cl_ish_corder,          " Käfer, 13178
        l_text        TYPE rnfp1t-ktxtconc.

* Initialisierungen
  e_rc = 0.
  CLEAR: e_outtab,
*         l_prereg,                                      " Käfer, 13178
         lr_corder,                                     " Käfer, 13178
         l_environment,
         l_pre_proc,
         l_npcp_data.

  IF NOT i_object IS INITIAL.
    l_pre_proc ?= i_object.
    CALL METHOD l_pre_proc->get_data
      IMPORTING
*        ES_KEY         =
        es_data        = l_npcp_data
        e_rc           = e_rc
      CHANGING
        c_errorhandler = c_errorhandler.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.
  CHECK e_rc = 0.

  CALL METHOD l_pre_proc->get_environment
    IMPORTING
      e_environment = l_environment.

* Die Objektdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_prov_procedure.
  e_outtab-object    = i_object.


* Käfer, ID: 13178 - Begin
* now the procedure doesn´t longer depend to the orderposition. From now
* it is connected directly to the ORDER

* Die Felder EINRI, FALNR, PATNR, PAPID kommen aus der Vormerkung,
* der das Objekt zugeordnet ist
*  clear l_vn1vkg.
*  CALL METHOD cl_ish_prereg_procedure=>get_prereg_for_procedure
*    EXPORTING
*      i_procedure       = l_pre_proc
*      i_environment     = l_environment
*    IMPORTING
*      E_RC              = e_rc
*      E_N1VKG           = l_vn1vkg
*      E_PREREG          = l_prereg
*    CHANGING
*      C_ERRORHANDLER    = c_errorhandler.
*  check e_rc = 0.
*  e_outtab-einri     = l_vn1vkg-einri.
*  e_outtab-falnr     = l_vn1vkg-falnr.
*  e_outtab-patnr     = l_vn1vkg-patnr.
*  e_outtab-papid     = l_vn1vkg-papid.

  CLEAR ls_n1corder.
  CALL METHOD l_pre_proc->get_corder
    EXPORTING
      ir_environment  = l_environment
    IMPORTING
      er_corder       = lr_corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.

  CHECK e_rc = 0.

  IF NOT lr_corder IS INITIAL.
    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder = ls_n1corder.
  ENDIF.

  e_outtab-einri     = ls_n1corder-einri.
  e_outtab-patnr     = ls_n1corder-patnr.
  e_outtab-papid     = ls_n1corder-papid.

* Käfer, ID: 13178 - End

  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
*      I_OBJECT  = l_prereg                  " Käfer, ID 13178
      i_object  = lr_corder                  " Käfer, ID 13178
      i_patnr   = e_outtab-patnr
      i_papid   = e_outtab-papid
    IMPORTING
      e_pattext = e_outtab-patname.

* CAText (Text des Knotens)
  CLEAR l_text.
  CALL FUNCTION 'ISH_READ_NTPT'
    EXPORTING
*      einri           = l_vn1vkg-einri      " Käfer, ID 13178
      einri           = ls_n1corder-einri    " Käfer, ID 13178
      spras           = sy-langu
      talst           = l_npcp_data-icpm
      tarif           = l_npcp_data-icpmc
    IMPORTING
      ktxtconc        = l_text
    EXCEPTIONS
      not_found       = 1
      OTHERS          = 2.
  IF sy-subrc = 0.
    e_outtab-catext = l_text.
  ELSE.
    e_outtab-catext = l_npcp_data-icpm.
  ENDIF.
*  e_outtab-cadate    =
  e_outtab-catime    = '      '.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
*  e_outtab-caclass   =
*  e_outtab-cakey     =
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      e_icon   = e_outtab-icon.
ENDMETHOD.


method OUTTAB_FROM_PROV_PAT.
  data: l_prov_pat  type ref to cl_ish_patient_provisional,
        l_npap_data type rnpap_attrib,
        l_npap_key  type rnpap_key.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab,
         l_npap_data,
         l_npap_key.

  if not i_object is initial.
    l_prov_pat ?= i_object.
    CALL METHOD l_prov_pat->get_data
*      EXPORTING                          " Fichte, Nr 9249
*        I_AUTHORITY_CHECK = off          " Fichte, Nr 9249
      IMPORTING
        ES_KEY            = l_npap_key
        ES_DATA           = l_npap_data
        E_RC              = e_rc
      CHANGING
        C_ERRORHANDLER    = c_errorhandler.
  else.
    e_rc = 1.
    exit.
  endif.
  check e_rc = 0.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_prov_patient.
  e_outtab-object    = i_object.
*  e_outtab-einri     = l_n1vkg-einri.
*  e_outtab-falnr     =
*  e_outtab-patnr     =
  e_outtab-papid     = l_npap_key-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_OBJECT  = l_prov_pat
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.
  e_rc = 0.
  e_outtab-catext = e_outtab-patname.
*  e_outtab-cadate    =
  e_outtab-catime    = '      '.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
*  e_outtab-caclass   =
*  e_outtab-cakey     =
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_REQUEST .
  data: l_req         type ref to cl_ishmed_request,
        l_n1anf       type n1anf,
        lt_n1anftyp   type ishmed_t_n1anftyp,
        l_n1anftyp    type line of ishmed_t_n1anftyp,
        lt_n1anmsz    type standard table of n1anmsz,
        l_n1anmsz     type n1anmsz.
  data: l_rc          type ish_method_rc,
        lt_obj        type ish_objectlist,
        l_obj         type ish_object,
        l_environment type ref to cl_ish_environment.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab,
         l_n1anf,
         l_environment.

  if not i_object is initial.
    l_req ?= i_object.
    CALL METHOD l_req->get_data
      EXPORTING
        I_FILL_REQUEST = OFF
      IMPORTING
        E_RC           = e_rc
        E_N1ANF        = l_n1anf
      CHANGING
        C_ERRORHANDLER = c_errorhandler.
    CALL METHOD l_req->get_environment
      IMPORTING
        E_ENVIRONMENT = l_environment.
  else.
    e_rc = 1.
    exit.
  endif.
  check e_rc = 0.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_request.
  e_outtab-object    = i_object.
  e_outtab-einri     = l_n1anf-einri.
  e_outtab-falnr     = l_n1anf-falnr.
  e_outtab-patnr     = l_n1anf-patnr.
  e_outtab-papid     = l_n1anf-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.
  CALL METHOD cl_ishmed_master_dp=>read_request_category
    EXPORTING
      I_ANFTY         = l_n1anf-anfty
      I_BUFFER_ACTIVE = SPACE
      I_READ_DB       = SPACE
    IMPORTING
      E_RC            = e_rc
      ET_N1ANFTYP     = lt_n1anftyp
    CHANGING
      C_ERRORHANDLER  = c_errorhandler.
  check e_rc = 0.
  read table lt_n1anftyp into l_n1anftyp index 1.
  if sy-subrc = 0.
    e_outtab-catext = l_n1anftyp-anfna.
  else.
    e_outtab-catext = l_n1anf-anfty.
  endif.
  e_outtab-cadate    = l_n1anf-erdat.
  e_outtab-catime    = '      '.
  e_outtab-caou      = l_n1anf-orgid.

* CAGPART
  refresh lt_n1anmsz.
  select * from n1anmsz into table lt_n1anmsz
           where einri = l_n1anf-einri
           and   anfid = l_n1anf-anfid.
  sort lt_n1anmsz descending by erdat ertim.
  read table lt_n1anmsz into l_n1anmsz index 1.
  if sy-subrc = 0.
    e_outtab-cagpart = l_n1anmsz-gpart.
  endif.

  e_outtab-castate   = l_n1anf-anstae.
*  e_outtab-caclass     =    " Bei Anforderung leer
  e_outtab-cakey     = l_n1anf-anfty.

* Kontext des Termins ermitteln
  CALL METHOD cl_ishmed_request=>get_context_for_request
    EXPORTING
      i_request                   = l_req
      i_environment               = l_environment
*     Den Kontext auch lesen, wenn der das Stornoflag bereits
*     gesetzt hat
      I_CANCELLED_DATAS           = on
    IMPORTING
      ET_CONTEXT                  = lt_obj
      E_RC                        = l_rc
    CHANGING
      C_ERRORHANDLER              = c_errorhandler.
  if l_rc <> 0.
    e_rc = l_rc.
  else.
    read table lt_obj into l_obj index 1.
    if sy-subrc = 0.
      CALL METHOD cl_ishmed_cancel_tree=>build_context_text
        EXPORTING
          i_object       = l_obj-object
        IMPORTING
          E_TEXT         = e_outtab-cacotext
          E_ICON         = e_outtab-cacoicon.
    endif.
  endif.

  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


METHOD outtab_from_srv_service .
* Hoebarth MED-33288 method created
  DATA: lr_service        TYPE REF TO cl_ishmed_srv_service.

  DATA: l_rc              TYPE ish_method_rc.
* --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  e_rc = 0.
  CLEAR: es_outtab.

  IF ir_object IS INITIAL.
    e_rc = 8.
    EXIT.
  ENDIF.

* get data from the object
  lr_service ?= ir_object.

* fill table for output
  es_outtab-dependent = i_dependent.
  es_outtab-type      = co_srv_service.
  es_outtab-object    = ir_object.
  es_outtab-einri     = lr_service->get_einri( ).
  es_outtab-patnr     = lr_service->get_patnr( ).
  es_outtab-caou      = lr_service->get_orgid( ).
  es_outtab-cakey     = lr_service->get_bcpextid( ).
  es_outtab-castate   = lr_service->get_lssttxt( ).
  es_outtab-caclass   = 'Leistung'(010).
  es_outtab-cadate    = lr_service->get_date( ).
  es_outtab-catime    = lr_service->get_time( ).
  es_outtab-catext    = lr_service->get_name( ).
  es_outtab-cagpart   = lr_service->get_vma_actual_status( ).
*  es_outtab-cacotext  = lr_service->get_einri( ).

  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = lr_service
      i_patnr   = es_outtab-patnr
    IMPORTING
      e_pattext = es_outtab-patname.

* get icon
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = es_outtab
    IMPORTING
      e_icon   = es_outtab-icon.

ENDMETHOD.


method OUTTAB_FROM_SURGERY.
* OP-Daten werden nicht auf dem Tree ausgegeben. Stattdessen
* wird eine Warnungsmeldung ausgegeben
  data: l_srv         type ref to cl_ishmed_service,
        l_environment type ref to cl_ish_environment,
        l_rnpap_key   type rnpap_key,
        l_nlei        type nlei,
        l_nlem        type nlem,
        l_patname(20) type c.
  data: lt_n1lsstt    type ishmed_t_n1lsstt,
        l_n1lsstt     type line of ishmed_t_n1lsstt,
        l_ktxt        type RNFP1T-KTXTCONC,
        l_gpart       type ngpa-gpart,
        l_rc          type ish_method_rc.

* Initialisierungen
  e_rc = 0.
  clear: l_environment,
         e_outtab,
         l_nlei,
         l_nlem.

  if not i_object is initial.
    l_srv ?= i_object.
    CALL METHOD l_srv->get_data
      EXPORTING
        I_FILL_SERVICE = OFF
      IMPORTING
        E_RC           = e_rc
        E_NLEI         = l_nlei
        E_NLEM         = l_nlem
        E_GPART        = l_gpart
      CHANGING
        C_ERRORHANDLER = c_errorhandler.
    CALL METHOD l_srv->get_environment
      IMPORTING
        E_ENVIRONMENT = l_environment.
  else.
    e_rc = 1.
    exit.
  endif.
  check e_rc = 0.

* Die Leistungsdaten nun in die OUTTAB übernehmen
  if l_nlem-ankls = 'X'.
*   Hauptankerleistung
    e_outtab-type      = co_surgery.
  elseif l_nlem-ankls = 'N'.
*   Neben-OP-Ankerleistung
    e_outtab-type      = co_2nd_surg.
  else.
*   Andere Ankerleistung (z.B AN-Anker): Diese wird nicht im
*   Tree angezeigt
    exit.
  endif.
* Eine OP wird nur angezeigt, wenn sie das Hauptobjekt ist. Wird
* sie dagegen nur mitstorniert, wird lediglich eine Warnung
* ausgegeben
  if i_dependent = on.
*    clear l_patname.
*    CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
*      EXPORTING
*        I_OBJECT  = l_srv
*        I_PATNR   = l_nlem-patnr
*        I_PAPID   = l_nlem-papid
*      IMPORTING
*        E_PATNAME = l_patname.
**   Patient &: Operation auf & wird storniert
*    CALL METHOD c_errorhandler->collect_messages
*      EXPORTING
*        I_TYP           = 'W'
*        I_KLA           = 'NFCL'
*        I_NUM           = '155'
*        I_MV1           = l_patname
*        I_MV2           = l_nlei-erboe
*        I_LAST          = space
*        I_OBJECT        = i_object.
    exit.
  endif.

  e_outtab-dependent = i_dependent.
  e_outtab-object    = i_object.
  e_outtab-einri     = l_nlei-einri.
  e_outtab-lnrls     = l_nlei-lnrls.
  e_outtab-falnr     = l_nlei-falnr.
  e_outtab-patnr     = l_nlem-patnr.
  e_outtab-papid     = l_nlem-papid.
  if e_outtab-patnr is initial  and
     e_outtab-papid is initial.
    CALL METHOD cl_ishmed_service=>get_patient_provi
      EXPORTING
        i_service          = l_srv
        i_environment      = l_environment
      IMPORTING
        E_PAP_KEY          = l_rnpap_key
        E_RC               = l_rc.
    if l_rc = 0.
      e_outtab-papid = l_rnpap_key-papid.
    endif.
  endif.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_OBJECT  = l_srv
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.
  CALL METHOD cl_ishmed_service=>build_service_text
    EXPORTING
      I_NLEI    = l_nlei
      I_SERVICE = l_srv
    IMPORTING
      E_TEXT    = e_outtab-catext.

  e_outtab-cadate    = l_nlei-ibgdt.
  e_outtab-catime    = l_nlei-ibzt.
  e_outtab-caou      = l_nlei-erboe.
  e_outtab-cagpart   = l_gpart.

  if not l_nlem-lnrls is initial.
    if not l_nlem-lsstae is initial.
      e_outtab-castate = l_nlem-lsstae.
    endif.   " if not l_nlem-lsstae is initial
  endif.   " if not l_nlem-lnrls is initial

*  e_outtab-caclass     =        " Bei Leistung leer
  e_outtab-cakey       = l_nlei-leist.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


METHOD outtab_from_team.

  DATA: l_team      TYPE REF TO cl_ishmed_team,
        l_service   TYPE REF TO cl_ishmed_service,
        l_n1lsteam  TYPE n1lsteam,
        l_ngpa      TYPE ngpa,
        l_nlei      TYPE nlei,
        l_nlem      TYPE nlem.

* Initialisierungen
  e_rc = 0.
  CLEAR: e_outtab,
         l_service,
         l_n1lsteam.

  IF NOT i_object IS INITIAL.
    l_team ?= i_object.
    CALL METHOD l_team->get_data
      EXPORTING
        i_fill_team    = off
      IMPORTING
        e_rc           = e_rc
        e_n1lsteam     = l_n1lsteam
      CHANGING
        c_errorhandler = c_errorhandler.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.
  CHECK e_rc = 0.

* Die Objektdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_team.
  e_outtab-object    = i_object.

* Die Felder EINRI, FALNR, PATNR, PAPID kommen aus der Leistung,
* der das TEAM zugeordnet ist
  CALL METHOD cl_ishmed_team=>get_service_for_team
    EXPORTING
      i_team         = l_team
    IMPORTING
      e_nlei         = l_nlei
      e_nlem         = l_nlem
      e_service      = l_service
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  e_outtab-einri     = l_nlei-einri.
  e_outtab-falnr     = l_nlei-falnr.
  e_outtab-patnr     = l_nlem-patnr.
  e_outtab-papid     = l_nlem-papid.
  e_outtab-lnrls     = l_n1lsteam-lnrls.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = l_service
      i_patnr   = e_outtab-patnr
      i_papid   = e_outtab-papid
    IMPORTING
      e_pattext = e_outtab-patname.

* CAText (Text des Knotens)
  CLEAR l_ngpa.
  IF l_n1lsteam-gpart IS INITIAL.
    l_ngpa-name1 = l_n1lsteam-name1.
    l_ngpa-name2 = l_n1lsteam-name2.
    l_ngpa-titel = l_n1lsteam-titel.
    CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
      EXPORTING
        i_gpart = 'DUMMY'
        is_ngpa = l_ngpa
      IMPORTING
        e_pname = e_outtab-catext.
  ELSE.
    CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
      EXPORTING
        i_gpart = l_n1lsteam-gpart
      IMPORTING
        e_pname = e_outtab-catext.
  ENDIF.
  CONCATENATE l_n1lsteam-vorgang e_outtab-catext
              INTO e_outtab-catext
              SEPARATED BY space.

  e_outtab-cadate    = l_n1lsteam-begdt.
  IF l_n1lsteam-begzt CO ' 0'.
    e_outtab-catime = '      '.
  ELSE.
    e_outtab-catime    = l_n1lsteam-begzt.
  ENDIF.
*  e_outtab-caou      =
  e_outtab-cagpart   = l_n1lsteam-gpart.
*  e_outtab-castate   =
*  e_outtab-caclass   =
  e_outtab-cakey     = l_n1lsteam-vrgnr.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      e_icon   = e_outtab-icon.

ENDMETHOD.


method OUTTAB_FROM_UNKNOWN.
* Initialisierungen
  e_rc = 0.
  clear: e_outtab.


* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_unknown.
  e_outtab-object    = i_object.
  e_rc = 0.
  e_outtab-catext = 'Unbekannter Typ'(002).
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


method OUTTAB_FROM_VITPAR.
  data: l_vitpar      type ref to cl_ishmed_vitpar,
        l_n1vp        type n1vp.

* Initialisierungen
  e_rc = 0.
  clear: e_outtab,
         l_n1vp.

  if not i_object is initial.
    l_vitpar ?= i_object.
    CALL METHOD l_vitpar->get_data
      EXPORTING
        I_FILL_VITPAR  = OFF
      IMPORTING
        E_RC           = e_rc
        E_N1VP         = l_n1vp
      CHANGING
        C_ERRORHANDLER = c_errorhandler.
  else.
    e_rc = 1.
    exit.
  endif.
  check e_rc = 0.

* Die Anforderungsdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_vitpar.
  e_outtab-object    = i_object.
  e_outtab-einri     = l_n1vp-einri.
*  e_outtab-falnr     = Vitalparameter sind Patientenbezogen
  e_outtab-patnr     = l_n1vp-patnr.
*  e_outtab-papid     = Keine Vitalparameter zu vorl. Patienten
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      I_PATNR   = e_outtab-patnr
      I_PAPID   = e_outtab-papid
    IMPORTING
      E_PATTEXT = e_outtab-patname.

* CAText (Text des Knotens)
  concatenate l_n1vp-vppid l_n1vp-vwert
              into e_outtab-catext
              separated by space.
  e_outtab-cadate    = l_n1vp-vdate.
  e_outtab-catime    = l_n1vp-vtime.
  e_outtab-caou      = l_n1vp-erfoe.
*  e_outtab-cagpart   =
*  e_outtab-castate   =      " Bei Terminen leer
*  e_outtab-caclass   =      " Bei Terminen leer
  e_outtab-cakey     = l_n1vp-vppid.
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      E_ICON   = e_outtab-icon.
endmethod.


METHOD outtab_from_wait_abs.
  DATA: l_wl_abs      TYPE REF TO cl_ish_waiting_list_absence,
        l_environment TYPE REF TO cl_ish_environment,
        l_nwlm_data   TYPE rnwlm_attrib,
        ls_n1corder   TYPE n1corder,
        lr_corder     TYPE REF TO cl_ish_corder,
        l_text(20)    TYPE c,
        l_tn42w       TYPE tn42w.

* Initialisierungen
  e_rc = 0.
  CLEAR: e_outtab,
         lr_corder,
         l_environment,
         l_wl_abs,
         l_nwlm_data.

  IF NOT i_object IS INITIAL.
    l_wl_abs ?= i_object.
    CALL METHOD l_wl_abs->get_data
      IMPORTING
*       ES_KEY         =
        es_data        = l_nwlm_data
        e_rc           = e_rc
      CHANGING
        c_errorhandler = c_errorhandler.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.
  CHECK e_rc = 0.

  CALL METHOD l_wl_abs->get_environment
    IMPORTING
      e_environment = l_environment.

* Die Objektdaten nun in die OUTTAB übernehmen
  e_outtab-dependent = i_dependent.
  e_outtab-type      = co_wl_absence.
  e_outtab-object    = i_object.

* Die Felder EINRI, FALNR, PATNR, PAPID kommen aus dem Klinischen
* Auftrag, der das Objekt zugeordnet ist
  CLEAR ls_n1corder.
  CALL METHOD l_wl_abs->get_corder
    EXPORTING
      ir_environment  = l_environment
    IMPORTING
      er_corder       = lr_corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_corder IS INITIAL.
    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder = ls_n1corder.
  ENDIF.
  e_outtab-einri     = ls_n1corder-einri.
  e_outtab-patnr     = ls_n1corder-patnr.
  e_outtab-papid     = ls_n1corder-papid.
  CALL METHOD cl_ishmed_cancel_tree=>build_patient_data
    EXPORTING
      i_object  = lr_corder
      i_patnr   = e_outtab-patnr
      i_papid   = e_outtab-papid
    IMPORTING
      e_pattext = e_outtab-patname.

* CAText (Text des Knotens)
  IF l_nwlm_data-absbdt = l_nwlm_data-absedt.
    WRITE l_nwlm_data-absbdt TO l_text DD/MM/YY.
    IF NOT l_nwlm_data-absrsn IS INITIAL.
      SELECT SINGLE * FROM tn42w INTO l_tn42w
                      WHERE spras  = sy-langu
                      AND   einri  = ls_n1corder-einri
                      AND   absrsn = l_nwlm_data-absrsn.
      IF sy-subrc = 0.
        CONCATENATE 'abwesend am'(t01) l_text
                    'wegen'(t02) l_tn42w-absrsntx
                    INTO e_outtab-catext
                    SEPARATED BY space.
      ELSE.
        CONCATENATE 'abwesend am'(t01) l_text
                    INTO e_outtab-catext
                    SEPARATED BY space.
      ENDIF.
    ELSE.
      CONCATENATE 'abwesend am'(t01) l_text
                  INTO e_outtab-catext
                  SEPARATED BY space.
    ENDIF.
  ELSE.
    WRITE l_nwlm_data-absbdt TO l_text DD/MM/YY.
    CONCATENATE 'abwesend von'(t03) l_text
                INTO e_outtab-catext
                SEPARATED BY space.
    WRITE l_nwlm_data-absedt TO l_text DD/MM/YY.
    CONCATENATE e_outtab-catext 'bis'(t04) l_text
                INTO e_outtab-catext
                SEPARATED BY space.
    IF NOT l_nwlm_data-absrsn IS INITIAL.
      SELECT SINGLE * FROM tn42w INTO l_tn42w
                      WHERE spras  = sy-langu
                      AND   einri  = ls_n1corder-einri
                      AND   absrsn = l_nwlm_data-absrsn.
      IF sy-subrc = 0.
        CONCATENATE e_outtab-catext 'wegen'(t02) l_tn42w-absrsntx
                    INTO e_outtab-catext
                    SEPARATED BY space.
      ENDIF.
    ENDIF.
  ENDIF.
*  e_outtab-cadate    =
  e_outtab-catime    = '      '.
*  e_outtab-caou      =
*  e_outtab-cagpart   =
*  e_outtab-castate   =
*  e_outtab-caclass   =
*  e_outtab-cakey     =
  CALL METHOD cl_ishmed_cancel_tree=>get_node_icon
    EXPORTING
      i_outtab = e_outtab
    IMPORTING
      e_icon   = e_outtab-icon.
ENDMETHOD.


method READ_DTEL_TEXT.
  DATA: l_dd04v  type dd04v,
        l_dtname type DDOBJNAME,
        l_langu  type sy-langu.

  clear: e_text,
         l_dd04v.
  l_langu  = sy-langu.
  l_dtname = i_dtname.
  CALL FUNCTION 'DDIF_DTEL_GET'
       EXPORTING
            name          = l_dtname
            langu         = l_langu
       IMPORTING
            dd04v_wa      = l_dd04v
       EXCEPTIONS
            illegal_input = 1
            OTHERS        = 2.
  IF sy-subrc <> 0.
    CLEAR e_text.
  ELSE.
    if not l_dd04v-scrtext_m is initial.
      e_text = l_dd04v-scrtext_m.

    elseif not l_dd04v-scrtext_s is initial.
      e_text = l_dd04v-scrtext_s.

    elseif not l_dd04v-scrtext_l is initial.
      e_text = l_dd04v-scrtext_l.
    endif.
  ENDIF.
endmethod.


method READ_HIERARCHY_DOWN .
* This method was created in course of implementing
* the cancel of the case (ID: 12776)
  data: l_msgtype     type c,
        l_mandatory   type c,
        l_mand2       type c,
        ls_cancel_hier type rn1cancel_hierarchy.
  statics: lst_call_count type i.

* lst_call_count shall prevent an endless-loop
  if i_initialize = on.
    lst_call_count = 0.
*    refresh et_cancel_hier.        " Käfer, ID 13578
  endif.
  lst_call_count = lst_call_count + 1.
  if lst_call_count > 100.
*   More than 100 hierarchy-steps are not possible => an
*   endless-loop occured, so cancel
    exit.
  endif.

  if not ir_object is initial.
    loop at it_cancel_hier into ls_cancel_hier
            where macro-object = ir_object.
      append ls_cancel_hier to et_cancel_hier.
      CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
        EXPORTING
          I_INITIALIZE   = OFF
          IR_OBJECT       = ls_cancel_hier-micro-object
          I_LINE_KEY     = ls_cancel_hier-micro-line_key
          it_cancel_hier = it_cancel_hier
        IMPORTING
          ET_CANCEL_HIER = et_cancel_hier.
    endloop.
  elseif not i_line_key is initial.
    loop at it_cancel_hier into ls_cancel_hier
            where macro-line_key = i_line_key.
      append ls_cancel_hier to et_cancel_hier.
      CALL METHOD cl_ishmed_cancel_tree=>read_hierarchy_down
        EXPORTING
          I_INITIALIZE   = OFF
          IR_OBJECT       = ls_cancel_hier-micro-object
          I_LINE_KEY     = ls_cancel_hier-micro-line_key
          it_cancel_hier = it_cancel_hier
        IMPORTING
          ET_CANCEL_HIER = et_cancel_hier.
    endloop.
  endif.

endmethod.


method REFRESH_CANCEL_TREE.
  data: l_hier_header   type treev_hhdr,
        lt_outtab_open  type ishmed_t_cancel_tree_tab,
        lt_outtab       type ISHMED_T_CANCEL_TREE_TAB,
        l_outtab        type line of ishmed_t_cancel_tree_tab,
        l_outt2         type line of ishmed_t_cancel_tree_tab,
        lt_node         type lvc_t_nkey,
        l_node          type lvc_nkey,
        l_rc            type ish_method_rc.

* Käfer, ID: 13231 - Begin
  data: l_top_node            type lvc_nkey,
        l_first_node          type lvc_nkey,
        ls_outtab_top         type line of ishmed_t_cancel_tree_tab,
        ls_outtab_tmp         type line of ishmed_t_cancel_tree_tab.
* Käfer, ID: 13231 - End

* Initialisierungen
  e_rc = 0.

* Zuerst die geöffneten Knoten ermitteln und merken, denn diese
* sollen auch nach dem Refresh geöffnet sein
  refresh lt_outtab_open.
  CALL METHOD g_tree->get_expanded_nodes
    CHANGING
      ct_expanded_nodes = lt_node
    EXCEPTIONS
      CNTL_SYSTEM_ERROR = 1
      DP_ERROR          = 2
      FAILED            = 3
      others            = 4.
  if sy-subrc = 0.
*   Die OUTTAB muss gemerkt werden. Eine Tabelle mit NODE_KEYs
*   bringt wenig, denn die NODE_KEYs können später andere sein
    loop at lt_node into l_node.
      CALL METHOD g_tree->get_outtab_line
        EXPORTING
          i_node_key     = l_node
        IMPORTING
          E_OUTTAB_LINE  = l_outtab
        EXCEPTIONS
          NODE_NOT_FOUND = 1
          others         = 2.
      if sy-subrc = 0.
        append l_outtab to lt_outtab_open.
      endif.
    endloop.
  endif.

* Käfer, ID: 13231 - Begin
* to guarantee that the old top-node is after refresh at the top again
* following coding is necessary.

  clear: l_top_node,
         l_first_node,
         ls_outtab_top,
         ls_outtab_tmp.

  CALL METHOD g_tree->get_top_node
    IMPORTING
      E_NODE_KEY        = l_top_node
    EXCEPTIONS
      CNTL_SYSTEM_ERROR = 1
      FAILED            = 2
      others            = 3.

* now get the corresponding outtab_line for the selected node_key
  IF sy-subrc = 0.
    CALL METHOD g_tree->get_outtab_line
      EXPORTING
        i_node_key     = l_top_node
      IMPORTING
        E_OUTTAB_LINE  = ls_outtab_tmp
      EXCEPTIONS
        NODE_NOT_FOUND = 1
        others         = 2.
    IF sy-subrc = 0.
      ls_outtab_top = ls_outtab_tmp.
    ENDIF.

  ENDIF.

* Käfer, ID: 13231 - End

* Dann alle Knoten löschen
  CALL METHOD g_tree->delete_all_nodes
    EXCEPTIONS
      FAILED            = 1
      CNTL_SYSTEM_ERROR = 2
      others            = 3.

* Nun den Tree neu aufbauen
* ACHTUNG: Hier NICHT die GT_OUTTAB befüllen, denn die
* befüllt der Tree mit der Methode ADD_NODE ja selbst!
* Hier unbedingt mit G_CANCEL_ALL arbeiten, denn der enthält
* wirklich ALLE anzuzeigenden Daten. G_CANCEL dagegen enthält
* ja nur die Daten, die markiert sind!
  refresh lt_outtab.
  CALL METHOD me->build_outtab
    EXPORTING
      i_cancel       = g_cancel_all
    IMPORTING
      E_RC           = e_rc
      ET_OUTTAB      = lt_outtab
    CHANGING
      C_ERRORHANDLER = c_errorhandler.
  check e_rc = 0.

* Prüfungen, ob storniert werden darf.
* ACHTUNG: Hier nicht den Returncode in E_RC übernehmen, denn
* es ist durchaus normal, dass hier Fehler auftreten können.
* Diese Fehler sollen dann ja im Popup angezeigt werden!
  CALL METHOD me->check
    IMPORTING
      E_RC           = l_rc
    CHANGING
      C_ERRORHANDLER = c_errorhandler.

* Aufbauen des Trees
  CALL METHOD g_tree->set_screen_update
    EXPORTING
      i_update          = off.
  CALL METHOD me->fill_tree_control
    EXPORTING
      it_outtab      = lt_outtab
    IMPORTING
      E_RC           = e_rc
    CHANGING
      C_ERRORHANDLER = c_errorhandler.

* Die Knoten, die zuvor geöffnet waren nun auch wieder öffnen
  loop at lt_outtab_open into l_outtab.
    if not l_outtab-object is initial.
      read table gt_outtab into l_outt2
                 with key object = l_outtab-object.
      check sy-subrc = 0.
    else.
      read table gt_outtab into l_outt2
                 with key line_key = l_outtab-line_key.
    endif.
    CALL METHOD g_tree->expand_node
      EXPORTING
        i_node_key          = l_outt2-node_key
      EXCEPTIONS
        FAILED              = 1
        ILLEGAL_LEVEL_COUNT = 2
        CNTL_SYSTEM_ERROR   = 3
        NODE_NOT_FOUND      = 4
        CANNOT_EXPAND_LEAF  = 5
        others              = 6.
  endloop.

* Käfer, ID: 13231 - Begin
  clear l_outt2.
  if not ls_outtab_top is initial.
    if not ls_outtab_top-object is initial.

      read table gt_outtab into l_outt2
              with key object = ls_outtab_top-object.
    else.
      read table gt_outtab into l_outt2
              with key line_key = ls_outtab_top-line_key.
    endif.

    if not l_outt2 is initial.

      CALL METHOD g_tree->set_top_node
        EXPORTING
          i_node_key        = l_outt2-node_key
        EXCEPTIONS
          CNTL_SYSTEM_ERROR = 1
          NODE_NOT_FOUND    = 2
          FAILED            = 3
          others            = 4.

    endif.
* The Tree was at the top (patient-data)
* For the patient header the outtab-entry is initial
  elseif not l_top_node is initial.

*   first select the first entry in OUTTAB, which is not initial
    loop at gt_outtab into l_outt2
        where not object is initial
           or not line_key is initial.
      exit.
    endloop.

*   get the parent node_key for the selected entry from outtab
*   this node_key is the new node_key of the patient-header
    CALL METHOD g_tree->get_parent
      EXPORTING
        i_node_key        = l_outt2-node_key
      IMPORTING
        E_PARENT_NODE_KEY = l_first_node.

    CALL METHOD g_tree->set_top_node
      EXPORTING
        i_node_key        = l_first_node
      EXCEPTIONS
        CNTL_SYSTEM_ERROR = 1
        NODE_NOT_FOUND    = 2
        FAILED            = 3
        others            = 4.
  endif.
* Käfer, ID: 13231 - End
  CALL METHOD g_tree->set_screen_update
    EXPORTING
      i_update          = on.
endmethod.


method REGISTER_EVENTS.
  data: lt_event         type cntl_simple_events,
        l_event          type cntl_simple_event.
*       l_event_receiver type ref to lcl_tree_event_receiver.

* Zuerst bestehende Events einlesen
  refresh lt_event.
  CALL METHOD g_tree->get_registered_events
    IMPORTING
      EVENTS     = lt_event
    EXCEPTIONS
      CNTL_ERROR = 1
      others     = 2.
* Im Fehlerfall sind halt keine Events möglich.
  check sy-subrc = 0.

* Checkbox abfangen
  l_event-eventid = cl_gui_column_tree=>eventid_checkbox_change.
  append l_event to lt_event.

  call method g_tree->set_registered_events
    exporting
      events                    = lt_event
    exceptions
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3.
  if sy-subrc <> 0.
    exit.
  endif.

  set handler me->handle_checkbox_change
              for g_tree.
endmethod.


method SEARCH_IN_MSGTAB.
  data: l_msg      type rn1message,
        l_errorlvl type i.

  l_errorlvl = 99.
  if not i_keyfields-object is initial.
    loop at it_msg into l_msg
            where object = i_keyfields-object.
      if l_msg-type ca 'EAX'.
        l_errorlvl = 1.
        exit.
      elseif l_msg-type ca 'W'  and  l_errorlvl > 2.
        l_errorlvl = 2.
      elseif l_errorlvl > 3.
        l_errorlvl = 3.
      endif.
    endloop.
  elseif not i_keyfields-line_key is initial.
    loop at it_msg into l_msg
            where line_key = i_keyfields-line_key.
      if l_msg-type ca 'EAX'.
        l_errorlvl = 1.
        exit.
      elseif l_msg-type ca 'W'  and  l_errorlvl > 2.
        l_errorlvl = 2.
      elseif l_errorlvl > 3.
        l_errorlvl = 3.
      endif.
    endloop.
  endif.
  if l_errorlvl = 1.
    e_type = 'E'.
  elseif l_errorlvl = 2.
    e_type = 'W'.
  elseif l_errorlvl > 2.
    e_type = 'I'.
  endif.
endmethod.


method SEARCH_RECURSIVE_HIERARCHY.
  data: l_msgtype     type c,
        l_mandatory   type c,
        l_mand2       type c,
        l_cancel_hier type rn1cancel_hierarchy.
  statics: lt_keyfields type standard table of rn1cancel_key_fields.

* Initialisierungen
  e_mandatory = on.
  e_msgtype   = space.
  if i_initialize = on.
    refresh lt_keyfields.
  else.
*   Das übergebene Objekt in einer Tabelle merken, um
*   Endlosschleifen vermeiden zu können
    loop at lt_keyfields transporting no fields
            where object   = i_keyfields-object
            and   line_key = i_keyfields-line_key.
      exit.
    endloop.
    if sy-subrc = 0.
      exit.
    endif.
  endif.
  append i_keyfields to lt_keyfields.

* Gibt es bereits für das übergebene Objekt Meldungen?
  CALL METHOD cl_ishmed_cancel_tree=>search_in_msgtab
    EXPORTING
      i_keyfields = i_keyfields
      it_msg      = it_msg
    IMPORTING
      E_TYPE      = l_msgtype.
  if l_msgtype = 'E'.
*   Für dieses Objekt gibt es Fehler und außerdem ist das Objekt
*   unbedingt zum Storno notwendig => Rote Ampel + Es
*   kann sofort abgebrochen werden
    e_msgtype = 'E'.
    exit.
  else.
    if l_msgtype ca 'EW'.
      e_msgtype = l_msgtype.
    else.
      e_msgtype = space.
    endif.
  endif.

* Für das übergebene Objekt gibt es keine Meldungen oder zumindest
* keine E-Meldungen => Die Objekte unter dem Objekt auch noch
* prüfen
  loop at it_cancel_hier into l_cancel_hier
          where macro = i_keyfields.
    l_mandatory = i_mandatory.
    if l_mandatory = on.
      l_mandatory = l_cancel_hier-mandatory.
    endif.
    CALL METHOD cl_ishmed_cancel_tree=>search_recursive_hierarchy
      EXPORTING
        i_keyfields    = l_cancel_hier-micro
        i_mandatory    = l_mandatory
        it_msg         = it_msg
        it_cancel_hier = it_cancel_hier
      IMPORTING
        E_MSGTYPE      = l_msgtype
        E_MANDATORY    = l_mand2.
*   Ist irgendeines der untergeordneten Objekte, gleichgültig auf
*   welcher Ebene optional (d.h. MANDATORY = OFF), dann ist nur
*   das entscheidend und muss bis nach ganz oben durchgereicht
*   werden
    if l_mand2 = off.
      e_mandatory = off.
    else.
      if e_mandatory = on.
        e_mandatory = l_mandatory.
      endif.
    endif.
    if l_msgtype = 'E'.
      e_msgtype = l_msgtype.
      exit.
    elseif l_msgtype = 'W'.
      e_msgtype = l_msgtype.
    elseif e_msgtype <> 'W'.
      e_msgtype = l_msgtype.
    endif.
  endloop.
endmethod.


method SET_CURSOR_ON_NODE.
  data: l_outtab    type RN1CANCEL_TREE_FIELDS,
        lt_node_key type lvc_t_nkey.

* Eintrag in der OUTTAB suchen und dann nach oben und dabei
* alle Knoten öffnen
  if not i_rn1message-object is initial.
    read table gt_outtab into l_outtab
               with key object = i_rn1message-object.
  else.
    read table gt_outtab into l_outtab
               with key line_key = i_rn1message-line_key.
  endif.
  check sy-subrc = 0.

* Mit dem NODE_KEY aus der GT_OUTTAB nun die Zeile markieren
  refresh lt_node_key.
  append l_outtab-node_key to lt_node_key.
  CALL METHOD g_tree->set_selected_nodes
    EXPORTING
      it_selected_nodes       = lt_node_key
    EXCEPTIONS
      CNTL_SYSTEM_ERROR       = 1
      DP_ERROR                = 2
      FAILED                  = 3
      ERROR_IN_NODE_KEY_TABLE = 4
      others                  = 5.
endmethod.
ENDCLASS.
