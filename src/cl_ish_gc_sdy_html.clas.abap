class CL_ISH_GC_SDY_HTML definition
  public
  inheriting from CL_ISH_GUI_CONTROLLER
  create public .

*"* public components of class CL_ISH_GC_SDY_HTML
*"* do not include other source files here!!!
public section.

  constants CO_DEF_CTRNAME_HTML type N1GUI_ELEMENT_NAME value 'HTML_CTR'. "#EC NOTEXT
  constants CO_DEF_VIEWNAME_HTML type N1GUI_ELEMENT_NAME value 'HTML_VIEW'. "#EC NOTEXT

  interface IF_ISH_GUI_VIEW load .
  class CL_ISH_GV_SDY_CUSTCONT definition load .
  type-pools CO .
  class-methods CREATE_AND_INITIALIZE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_PARENT_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !I_VIEWNAME_SDY_CUSTCONT type N1GUI_ELEMENT_NAME
      !I_CTRNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_CUSTCONT=>CO_DEF_CTRNAME_CUSTCONT
      !I_VIEWNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_CUSTCONT=>CO_DEF_VIEWNAME_CUSTCONT
      !IR_CUSTCONT_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
      !IR_HTML_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL optional
      !I_FIELDNAME_URL type ISH_FIELDNAME optional
      !I_URL type N1URL_WWW optional
      !I_CTRNAME_HTML type N1GUI_ELEMENT_NAME default CO_DEF_CTRNAME_HTML
      !I_VIEWNAME_HTML type N1GUI_ELEMENT_NAME default CO_DEF_VIEWNAME_HTML
      !IR_HTML_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GC_SDY_HTML
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_HTML_CTR
    returning
      value(RR_CTR) type ref to IF_ISH_GUI_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_HTML_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_CONTROL_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CUSTCONT_CTR
    returning
      value(RR_CTR) type ref to IF_ISH_GUI_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CUSTCONT_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_CUSTCONT_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_SDY_CUSTCONT_VIEW
    returning
      value(RR_VIEW) type ref to CL_ISH_GV_SDY_CUSTCONT
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !IR_PARENT_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !I_VIEWNAME_SDY_CUSTCONT type N1GUI_ELEMENT_NAME
      !I_CTRNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_CUSTCONT=>CO_DEF_CTRNAME_CUSTCONT
      !I_VIEWNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_CUSTCONT=>CO_DEF_VIEWNAME_CUSTCONT
      !IR_CUSTCONT_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
      !IR_HTML_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL optional
      !I_FIELDNAME_URL type ISH_FIELDNAME optional
      !I_URL type N1URL_WWW optional
      !I_CTRNAME_HTML type N1GUI_ELEMENT_NAME default CO_DEF_CTRNAME_HTML
      !I_VIEWNAME_HTML type N1GUI_ELEMENT_NAME default CO_DEF_VIEWNAME_HTML
      !IR_HTML_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GC_SDY_CUSTCONT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GC_SDY_HTML
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GC_SDY_HTML IMPLEMENTATION.


METHOD create_and_initialize.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

  rr_instance->initialize(
      ir_parent_controller    = ir_parent_controller
      ir_model                = ir_model
      i_vcode                 = i_vcode
      i_viewname_sdy_custcont = i_viewname_sdy_custcont
      i_ctrname_custcont      = i_ctrname_custcont
      i_viewname_custcont     = i_viewname_custcont
      ir_custcont_layout      = ir_custcont_layout
      ir_html_model           = ir_html_model
      i_fieldname_url         = i_fieldname_url
      i_url                   = i_url
      i_ctrname_html          = i_ctrname_html
      i_viewname_html         = i_viewname_html
      ir_html_layout          = ir_html_layout ).

ENDMETHOD.


METHOD get_custcont_ctr.

  DATA lr_sdy_custcont_view           TYPE REF TO cl_ish_gv_sdy_custcont.

  lr_sdy_custcont_view = get_sdy_custcont_view( ).
  CHECK lr_sdy_custcont_view IS BOUND.

  rr_ctr = lr_sdy_custcont_view->get_custcont_ctr( ).

ENDMETHOD.


METHOD get_custcont_view.

  DATA lr_sdy_custcont_view           TYPE REF TO cl_ish_gv_sdy_custcont.

  lr_sdy_custcont_view = get_sdy_custcont_view( ).
  CHECK lr_sdy_custcont_view IS BOUND.

  rr_view = lr_sdy_custcont_view->get_custcont_view( ).

ENDMETHOD.


METHOD get_html_ctr.

  DATA lr_sdy_custcont_view           TYPE REF TO cl_ish_gv_sdy_custcont.

  lr_sdy_custcont_view = get_sdy_custcont_view( ).
  CHECK lr_sdy_custcont_view IS BOUND.

  rr_ctr = lr_sdy_custcont_view->get_control_ctr( ).

ENDMETHOD.


METHOD get_html_view.

  DATA lr_sdy_custcont_view           TYPE REF TO cl_ish_gv_sdy_custcont.

  lr_sdy_custcont_view = get_sdy_custcont_view( ).
  CHECK lr_sdy_custcont_view IS BOUND.

  TRY.
      rr_view ?= lr_sdy_custcont_view->get_control_view( ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_HTML_VIEW'
          i_mv3        = 'CL_ISH_GC_SDY_HTML' ).
  ENDTRY.

ENDMETHOD.


METHOD get_sdy_custcont_view.

  TRY.
      rr_view ?= gr_view.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_SDY_CUSTCONT_VIEW'
          i_mv3        = 'CL_ISH_GC_SDY_HTML' ).
  ENDTRY.

ENDMETHOD.


METHOD initialize.

  DATA lr_sdy_custcont_view           TYPE REF TO cl_ish_gv_sdy_custcont.
  DATA lr_custcont_ctr                TYPE REF TO if_ish_gui_controller.
  DATA lr_custcont_view               TYPE REF TO if_ish_gui_custcont_view.
  DATA lr_html_ctr                    TYPE REF TO cl_ish_gc_simple.
  DATA lr_html_view                   TYPE REF TO cl_ish_gui_html_view.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GC_SDY_HTML' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      CREATE OBJECT lr_sdy_custcont_view
        EXPORTING
          i_element_name = i_viewname_sdy_custcont.
      _init_ctr( ir_parent_controller = ir_parent_controller
                 ir_model             = ir_model
                 ir_view              = lr_sdy_custcont_view
                 i_vcode              = i_vcode ).
      lr_sdy_custcont_view->initialize(
          ir_controller       = me
          i_vcode             = g_vcode
          i_ctrname_custcont  = i_ctrname_custcont
          i_viewname_custcont = i_viewname_custcont
          ir_custcont_layout  = ir_custcont_layout ).
      lr_custcont_ctr = get_custcont_ctr( ).
      lr_custcont_view = get_custcont_view( ).
      lr_html_ctr = cl_ish_gc_simple=>create(
          i_element_name = i_ctrname_html ).
      CREATE OBJECT lr_html_view
        EXPORTING
          i_element_name = i_viewname_html.
      lr_html_ctr->initialize(
          ir_parent_controller  = lr_custcont_ctr
          ir_view               = lr_html_view
          ir_model              = ir_html_model
          i_vcode               = i_vcode ).
      lr_html_view->initialize(
          ir_controller   = lr_html_ctr
          ir_parent_view  = lr_custcont_view
          ir_layout       = ir_html_layout
          i_vcode         = i_vcode
          i_fieldname_url = i_fieldname_url
          i_url           = i_url ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.
ENDCLASS.
