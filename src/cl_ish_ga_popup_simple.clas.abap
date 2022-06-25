class CL_ISH_GA_POPUP_SIMPLE definition
  public
  inheriting from CL_ISH_GA_POPUP
  create public .

public section.
*"* public components of class CL_ISH_GA_POPUP_SIMPLE
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional .
  methods GET_POPUP_MODEL
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL .
  interface IF_ISH_GUI_VIEW load .
  methods INITIALIZE
    importing
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !IR_LAYOUT type ref to CL_ISH_GUI_APPL_LAYOUT optional
      !I_MESSAGES_VIEW_NAME type N1GUI_ELEMENT_NAME default CO_DEF_MESSAGES_VIEW_NAME
      !I_DEFAULT_UCOMM type SYUCOMM default SPACE
      !I_START_ROW type I optional
      !I_START_COL type I optional
      !I_END_ROW type I optional
      !I_END_COL type I optional
      !I_TITLE_TEXT type STRING
      !I_POPUP_REPID type SYREPID
      !I_POPUP_DYNNR type SYDYNNR
      !I_POPUP_DYNPSTRUCT_NAME type TABNAME optional
      !IR_POPUP_MODEL type ref to IF_ISH_GUI_MODEL optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GA_POPUP_SIMPLE
*"* do not include other source files here!!!

  data GR_POPUP_MODEL type ref to IF_ISH_GUI_MODEL .
  data G_POPUP_DYNNR type SYDYNNR .
  data G_POPUP_DYNPSTRUCT_NAME type TABNAME .
  data G_POPUP_REPID type SYREPID .
  data G_TITLE_TEXT type STRING .

  methods _CMD_ENTER
    redefinition .
  methods _GET_TITLE_TEXT
    redefinition .
  methods _LOAD_POPUP_VIEW
    redefinition .
private section.
*"* private components of class CL_ISH_GA_POPUP_SIMPLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GA_POPUP_SIMPLE IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD get_popup_model.

  rr_model = gr_popup_model.

ENDMETHOD.


METHOD initialize.

* Mandatory parameters.
  IF i_popup_repid IS INITIAL OR
     i_popup_dynnr IS INITIAL OR
     i_title_text IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GA_POPUP_SIMPLE' ).
  ENDIF.

* Initialize self.
  _init_ga_popup(
      i_vcode               = i_vcode
      ir_layout             = ir_layout
      i_messages_view_name  = i_messages_view_name
      i_default_ucomm       = i_default_ucomm
      i_start_row           = i_start_row
      i_start_col           = i_start_col
      i_end_row             = i_end_row
      i_end_col             = i_end_col ).

* Initialize attributes.
  g_popup_repid           = i_popup_repid.
  g_popup_dynnr           = i_popup_dynnr.
  g_title_text            = i_title_text.
  g_popup_dynpstruct_name = i_popup_dynpstruct_name.
  gr_popup_model          = ir_popup_model.

ENDMETHOD.


METHOD _cmd_enter.

  r_exit = abap_true.

ENDMETHOD.


METHOD _get_title_text.

  r_title_text = g_title_text.

ENDMETHOD.


METHOD _load_popup_view.

  DATA lr_old_popup_ctr               TYPE REF TO if_ish_gui_controller.
  DATA lr_main_view                   TYPE REF TO if_ish_gui_mdy_view.
  DATA lr_popup_ctr                   TYPE REF TO cl_ish_gc_simple.
  DATA lr_popup_view                  TYPE REF TO cl_ish_gv_sdy_simple.
  DATA lx_root                        TYPE REF TO cx_root.

* Destroy the "old" popup controller.
  lr_old_popup_ctr = get_popup_ctr( ).
  IF lr_old_popup_ctr IS BOUND.
    lr_old_popup_ctr->destroy( ).
  ENDIF.

* Create and initialize the popup controller + view.
  TRY.
      lr_main_view = get_main_view( ).
      lr_popup_ctr = cl_ish_gc_simple=>create( i_element_name = co_ctrname_popup ).
      lr_popup_view = cl_ish_gv_sdy_simple=>create( i_element_name = co_viewname_popup ).
      lr_popup_ctr->initialize(
          ir_parent_controller = gr_main_controller
          ir_model             = gr_popup_model
          ir_view              = lr_popup_view
          i_vcode              = g_vcode ).
      lr_popup_view->initialize(
          ir_controller     = lr_popup_ctr
          ir_parent_view    = lr_main_view
          i_repid           = g_popup_repid
          i_dynnr           = g_popup_dynnr
          i_vcode           = g_vcode
          i_dynpstruct_name = g_popup_dynpstruct_name ).
    CLEANUP.
      IF lr_popup_ctr IS BOUND.
        lr_popup_ctr->destroy( ).
      ENDIF.
  ENDTRY.

ENDMETHOD.
ENDCLASS.
