class CL_ISH_GV_SDY_TEXTEDIT definition
  public
  inheriting from CL_ISH_GV_SDY_CUSTCONT
  create public .

*"* public components of class CL_ISH_GV_SDY_TEXTEDIT
*"* do not include other source files here!!!
public section.

  constants CO_DEF_CTRNAME_TEXTEDIT type N1GUI_ELEMENT_NAME value 'TEXTEDIT_CTR'. "#EC NOTEXT
  constants CO_DEF_VIEWNAME_TEXTEDIT type N1GUI_ELEMENT_NAME value 'TEXTEDIT_VIEW'. "#EC NOTEXT

  methods GET_TEXTEDIT_CTR
    returning
      value(RR_CTR) type ref to IF_ISH_GUI_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_TEXTEDIT_VIEW
    returning
      value(RR_VIEW) type ref to CL_ISH_GUI_TEXTEDIT_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods INIT_SDY_TEXTEDIT
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !I_CTRNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CO_DEF_CTRNAME_CUSTCONT
      !I_VIEWNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CO_DEF_VIEWNAME_CUSTCONT
      !IR_CUSTCONT_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
      !I_CTRNAME_TEXTEDIT type N1GUI_ELEMENT_NAME default CO_DEF_CTRNAME_TEXTEDIT
      !I_VIEWNAME_TEXTEDIT type N1GUI_ELEMENT_NAME default CO_DEF_VIEWNAME_TEXTEDIT
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GV_SDY_TEXTEDIT
*"* do not include other source files here!!!

  data G_CTRNAME_TEXTEDIT type N1GUI_ELEMENT_NAME .
  data G_VIEWNAME_TEXTEDIT type N1GUI_ELEMENT_NAME .

  methods _LOAD_CUSTCONT_VIEW
    redefinition .
private section.
*"* private components of class CL_ISH_GV_SDY_TEXTEDIT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GV_SDY_TEXTEDIT IMPLEMENTATION.


METHOD get_textedit_ctr.

  TRY.
      rr_ctr ?= get_control_ctr( ).
    CATCH cx_sy_move_cast_error.
      CLEAR rr_ctr.
  ENDTRY.

ENDMETHOD.


METHOD get_textedit_view.

  TRY.
      rr_view ?= get_control_view( ).
    CATCH cx_sy_move_cast_error.
      CLEAR rr_view.
  ENDTRY.

ENDMETHOD.


METHOD init_sdy_textedit.

  g_ctrname_textedit  = i_ctrname_textedit.
  g_viewname_textedit = i_viewname_textedit.

  initialize(
      ir_controller       = ir_controller
      i_vcode             = i_vcode
      i_ctrname_custcont  = i_ctrname_custcont
      i_viewname_custcont = i_viewname_custcont
      ir_custcont_layout  = ir_custcont_layout ).

ENDMETHOD.


METHOD _load_custcont_view.

  DATA lr_textedit_ctr          TYPE REF TO cl_ish_gc_simple.
  DATA lr_textedit_view         TYPE REF TO cl_ish_gui_textedit_view.
  DATA lr_model                 TYPE REF TO if_ish_gui_model.
  DATA lr_custcont_view         TYPE REF TO if_ish_gui_container_view.
  DATA lr_sdy_textedit_ctr      TYPE REF TO cl_ish_gc_sdy_textedit.
  DATA l_fieldname_text         TYPE ish_fieldname.

  TRY.
      lr_sdy_textedit_ctr ?= gr_controller.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

  super->_load_custcont_view(
      ir_custcont_layout = ir_custcont_layout ).

  lr_textedit_ctr = cl_ish_gc_simple=>create(
      i_element_name    = g_ctrname_textedit
      ir_cb_destroyable = gr_cb_destroyable ).

  CREATE OBJECT lr_textedit_view
    EXPORTING
      i_element_name    = g_viewname_textedit
      ir_cb_destroyable = gr_cb_destroyable.

  IF gr_controller IS BOUND.
    lr_model = gr_controller->get_model( ).
  ENDIF.
  lr_textedit_ctr->initialize(
      ir_parent_controller = gr_controller
      ir_model             = lr_model
      ir_view              = lr_textedit_view
      i_vcode              = g_vcode ).

  lr_custcont_view = get_custcont_view( ).
  IF lr_sdy_textedit_ctr IS BOUND.
    l_fieldname_text = lr_sdy_textedit_ctr->get_fieldname_text( ).
  ENDIF.
  lr_textedit_view->initialize(
      ir_controller    = lr_textedit_ctr
      ir_parent_view   = lr_custcont_view
      i_vcode          = g_vcode
      i_fieldname_text = l_fieldname_text ).

ENDMETHOD.
ENDCLASS.
