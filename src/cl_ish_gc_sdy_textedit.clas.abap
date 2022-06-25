class CL_ISH_GC_SDY_TEXTEDIT definition
  public
  inheriting from CL_ISH_GC_SDY_CUSTCONT
  create public .

*"* public components of class CL_ISH_GC_SDY_TEXTEDIT
*"* do not include other source files here!!!
public section.

  interface IF_ISH_GUI_VIEW load .
  class CL_ISH_GV_SDY_CUSTCONT definition load .
  class-methods CREATE_AND_INIT_TEXTEDIT
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
      !I_CTRNAME_TEXTEDIT type N1GUI_ELEMENT_NAME optional
      !I_VIEWNAME_TEXTEDIT type N1GUI_ELEMENT_NAME optional
      !I_FIELDNAME_TEXT type ISH_FIELDNAME
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GC_SDY_TEXTEDIT
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_FIELDNAME_TEXT
    returning
      value(R_FIELDNAME_TEXT) type ISH_FIELDNAME .
  methods GET_TEXTEDIT_CTR
    returning
      value(RR_TEXTEDIT_CTR) type ref to IF_ISH_GUI_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_TEXTEDIT_VIEW
    returning
      value(RR_TEXTEDIT_VIEW) type ref to CL_ISH_GUI_TEXTEDIT_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE_TEXTEDIT
    importing
      !IR_PARENT_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_VCODE type TNDYM-VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !I_VIEWNAME_SDY_CUSTCONT type N1GUI_ELEMENT_NAME
      !I_CTRNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_CUSTCONT=>CO_DEF_CTRNAME_CUSTCONT
      !I_VIEWNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_CUSTCONT=>CO_DEF_VIEWNAME_CUSTCONT
      !IR_CUSTCONT_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
      !I_CTRNAME_TEXTEDIT type N1GUI_ELEMENT_NAME optional
      !I_VIEWNAME_TEXTEDIT type N1GUI_ELEMENT_NAME optional
      !I_FIELDNAME_TEXT type ISH_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GC_SDY_TEXTEDIT
*"* do not include other source files here!!!

  data G_FIELDNAME_TEXT type ISH_FIELDNAME .
private section.
*"* private components of class CL_ISH_GC_SDY_TEXTEDIT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GC_SDY_TEXTEDIT IMPLEMENTATION.


METHOD create_and_init_textedit.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

  rr_instance->initialize_textedit(
      ir_parent_controller    = ir_parent_controller
      ir_model                = ir_model
      i_vcode                 = i_vcode
      i_viewname_sdy_custcont = i_viewname_sdy_custcont
      i_ctrname_custcont      = i_ctrname_custcont
      i_viewname_custcont     = i_viewname_custcont
      ir_custcont_layout      = ir_custcont_layout
      i_ctrname_textedit      = i_ctrname_textedit
      i_viewname_textedit     = i_viewname_textedit
      i_fieldname_text        = i_fieldname_text ).

ENDMETHOD.


METHOD get_fieldname_text.

  r_fieldname_text = g_fieldname_text.

ENDMETHOD.


METHOD get_textedit_ctr.

  rr_textedit_ctr = get_control_ctr( ).

ENDMETHOD.


METHOD get_textedit_view.

  TRY.
      rr_textedit_view ?= get_control_view( ).
    CATCH cx_sy_move_cast_error.
      CLEAR rr_textedit_view.
  ENDTRY.

ENDMETHOD.


METHOD initialize_textedit.

  DATA lr_sdy_textedit_view           TYPE REF TO cl_ish_gv_sdy_textedit.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GC_SDY_TEXTEDIT' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      CREATE OBJECT lr_sdy_textedit_view
        EXPORTING
          i_element_name = i_viewname_sdy_custcont.
      _init_ctr( ir_parent_controller = ir_parent_controller
                 ir_model             = ir_model
                 ir_view              = lr_sdy_textedit_view
                 i_vcode              = i_vcode ).
      g_fieldname_text = i_fieldname_text.
      lr_sdy_textedit_view->initialize(
          ir_controller       = me
          i_vcode             = g_vcode
          i_ctrname_custcont  = i_ctrname_custcont
          i_viewname_custcont = i_viewname_custcont
          ir_custcont_layout  = ir_custcont_layout ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.
ENDCLASS.
