class CL_ISH_GUI_CUSTCONT_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTAINER_VIEW
  create protected .

public section.
*"* public components of class CL_ISH_GUI_CUSTCONT_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_CUSTCONT_VIEW .

  aliases GET_CUSTOM_CONTAINER
    for IF_ISH_GUI_CUSTCONT_VIEW~GET_CUSTOM_CONTAINER .
  aliases GET_EMBEDDED_CONTROL_VIEW
    for IF_ISH_GUI_CUSTCONT_VIEW~GET_EMBEDDED_CONTROL_VIEW .

  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_CUSTCONT_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_AND_INITIALIZE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IR_PARENT_CTR type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW
      !I_CTRNAME type N1GUI_ELEMENT_NAME optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !IR_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
      !I_CONTAINER_NAME type ISH_FIELDNAME optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_CUSTCONT_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_CONTAINER_NAME type ISH_FIELDNAME optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GUI_CUSTCONT_VIEW
*"* do not include other source files here!!!

  data G_CONTAINER_NAME type ISH_FIELDNAME .

  methods _INIT_CUSTCONT_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_CONTAINER_NAME type ISH_FIELDNAME optional
    raising
      CX_ISH_STATIC_HANDLER .

  methods _ADD_CHILD_VIEW
    redefinition .
  methods _CREATE_CONTROL
    redefinition .
private section.
*"* private components of class ZCL_MM_GUI_CUSTCONT_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_CUSTCONT_VIEW IMPLEMENTATION.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD create_and_initialize.

  DATA lr_ctr                     TYPE REF TO cl_ish_gc_simple.

* Create the controller.
  lr_ctr = cl_ish_gc_simple=>create(
      i_element_name    = i_ctrname
      ir_cb_destroyable = ir_cb_destroyable ).

* Create the view.
  rr_instance = create(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

* Initialize the controller.
  lr_ctr->initialize(
      ir_parent_controller = ir_parent_ctr
      ir_model             = ir_model
      ir_view              = rr_instance
      i_vcode              = i_vcode ).

* Initialize the view.
  rr_instance->initialize(
      ir_controller     = lr_ctr
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode
      i_container_name  = i_container_name ).

ENDMETHOD.


METHOD if_ish_gui_custcont_view~get_custom_container.

  TRY.
      rr_custom_container ?= get_control( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_custcont_view~get_embedded_control_view.

  DATA lt_child_view            TYPE ish_t_gui_viewid_hash.
  DATA lr_child_view            TYPE REF TO if_ish_gui_view.

  FIELD-SYMBOLS <ls_child_view> TYPE rn1_gui_viewid_hash.

  lt_child_view = get_child_views(
      i_with_subchildren = abap_false ).
  CHECK lt_child_view IS NOT INITIAL.

  LOOP AT lt_child_view ASSIGNING <ls_child_view>.
    TRY.
        rr_view ?= <ls_child_view>-r_view.
      CATCH cx_sy_move_cast_error.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = 'GET_EMBEDDED_CONTROL_VIEW'
            i_mv3        = 'CL_ISH_GUI_CUSTCONT_VIEW' ).
    ENDTRY.
    RETURN.
  ENDLOOP.

ENDMETHOD.


METHOD initialize.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GUI_CUSTCONT_VIEW' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_custcont_view(
          ir_controller     = ir_controller
          ir_parent_view    = ir_parent_view
          ir_layout         = ir_layout
          i_vcode           = i_vcode
          i_container_name  = i_container_name ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD _add_child_view.

  IF get_child_views( ) IS NOT INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_ADD_CHILD_VIEW'
        i_mv3        = 'CL_ISH_GUI_CUSTCONT_VIEW' ).
  ENDIF.

  super->_add_child_view( ir_child_view = ir_child_view ).

ENDMETHOD.


METHOD _create_control.

  IF g_container_name IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_CUSTCONT_VIEW' ).
  ENDIF.

  CREATE OBJECT rr_control
    TYPE
      cl_gui_custom_container
    EXPORTING
      container_name          = g_container_name
    EXCEPTIONS
      OTHERS                  = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_CREATE_CONTROL'
        i_mv3        = 'CL_ISH_GUI_CUSTCONT_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _init_custcont_view.

* If the container_name is not specified we use the element_name.
  IF i_container_name IS INITIAL.
    g_container_name = get_element_name( ).
  ELSE.
    g_container_name = i_container_name.
  ENDIF.
  IF g_container_name IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_INIT_CUSTCONT_VIEW'
        i_mv3        = 'CL_ISH_GUI_CUSTCONT_VIEW' ).
  ENDIF.

* Further processing by _init_container_view.
  _init_container_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode ).

ENDMETHOD.
ENDCLASS.
