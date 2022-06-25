class CL_ISH_GV_SDY_CUSTCONT definition
  public
  inheriting from CL_ISH_GUI_SDY_VIEW
  create public .

public section.
*"* public components of class CL_ISH_GV_SDY_CUSTCONT
*"* do not include other source files here!!!

  constants CO_DEF_CTRNAME_CUSTCONT type N1GUI_ELEMENT_NAME value 'CUSTCONT_CTR'. "#EC NOTEXT
  constants CO_DEF_VIEWNAME_CUSTCONT type N1GUI_ELEMENT_NAME value 'CUSTCONT_VIEW'. "#EC NOTEXT

  methods GET_CONTROL_CTR
    returning
      value(RR_CTR) type ref to IF_ISH_GUI_CONTROLLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CONTROL_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_CONTROL_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CUSTCONT_CTR
    returning
      value(RR_CTR) type ref to IF_ISH_GUI_CONTROLLER .
  methods GET_CUSTCONT_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_CUSTCONT_VIEW
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools CO .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !I_CTRNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CO_DEF_CTRNAME_CUSTCONT
      !I_VIEWNAME_CUSTCONT type N1GUI_ELEMENT_NAME default CO_DEF_VIEWNAME_CUSTCONT
      !IR_CUSTCONT_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GV_SDY_CUSTCONT
*"* do not include other source files here!!!

  constants CO_CC_PREFIX type STRING value 'CC'. "#EC NOTEXT
  constants CO_DYNNR_FROM type SYDYNNR value '0101'. "#EC NOTEXT
  constants CO_DYNNR_TO type SYDYNNR value '0199'. "#EC NOTEXT
  constants CO_REPID type SYREPID value 'SAPLN1_GUI_SDY_CUSTCONT'. "#EC NOTEXT
  data G_CTRNAME_CUSTCONT type N1GUI_ELEMENT_NAME .
  data G_VIEWNAME_CUSTCONT type N1GUI_ELEMENT_NAME .

  methods _LOAD_CUSTCONT_VIEW
    importing
      !IR_CUSTCONT_LAYOUT type ref to CL_ISH_GUI_CUSTCONT_LAYOUT optional
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GV_SDY_CUSTCONT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GV_SDY_CUSTCONT IMPLEMENTATION.


METHOD get_control_ctr.

  DATA lr_control_view            TYPE REF TO if_ish_gui_control_view.

  lr_control_view = get_control_view( ).
  CHECK lr_control_view IS BOUND.

  rr_ctr = lr_control_view->get_controller( ).

ENDMETHOD.


METHOD get_control_view.

  DATA lr_custcont_view           TYPE REF TO if_ish_gui_custcont_view.

  lr_custcont_view = get_custcont_view( ).
  CHECK lr_custcont_view IS BOUND.

  rr_view = lr_custcont_view->get_embedded_control_view( ).

ENDMETHOD.


METHOD get_custcont_ctr.

  CHECK gr_controller IS BOUND.

  rr_ctr = gr_controller->get_child_controller_by_name( g_ctrname_custcont ).

ENDMETHOD.


METHOD get_custcont_view.

  TRY.
      rr_view ?= get_child_view_by_name( g_viewname_custcont ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_CUSTCONT_VIEW'
          i_mv3        = 'CL_ISH_GUI_SDY_VIEW' ).
  ENDTRY.

ENDMETHOD.


METHOD initialize.

  DATA l_dynnr                          TYPE sydynnr.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GV_SDY_CUSTCONT' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
*     Call super method.
      _init_sdy_view( ir_controller     = ir_controller
                      i_repid           = co_repid
                      i_dynnr           = co_dynnr_from
                      i_dynnr_to        = co_dynnr_to
                      i_vcode           = i_vcode ).
*     Load the custcont controller + view.
      g_ctrname_custcont  = i_ctrname_custcont.
      g_viewname_custcont = i_viewname_custcont.
      _load_custcont_view(
          ir_custcont_layout  = ir_custcont_layout ).
    CLEANUP.
      g_initialization_mode = abap_false.
      IF l_dynnr IS NOT INITIAL.
        cl_ish_gui_dynpro_connector=>disconnect(
            ir_view        = me
            i_repid        = co_repid
            i_dynnr        = l_dynnr ).
      ENDIF.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD _load_custcont_view.

  DATA l_container_name                   TYPE ish_fieldname.
  DATA lr_model                           TYPE REF TO if_ish_gui_model.
  DATA lr_custcont_ctr                    TYPE REF TO cl_ish_gc_simple.
  DATA lr_custcont_view                   TYPE REF TO cl_ish_gui_custcont_view.

* Build the container_name.
  CONCATENATE
    co_cc_prefix
    g_dynnr
    INTO l_container_name
    SEPARATED BY '_'.

* Get the model.
  IF gr_controller IS BOUND.
    lr_model = gr_controller->get_model( ).
  ENDIF.

* Instantiate the custcont controller.
  lr_custcont_ctr = cl_ish_gc_simple=>create(
      i_element_name = g_ctrname_custcont ).

* Instantiate the custcont view.
  lr_custcont_view = cl_ish_gui_custcont_view=>create(
      i_element_name = g_viewname_custcont ).

  lr_custcont_ctr->initialize(
      ir_parent_controller = gr_controller
      ir_model             = lr_model
      ir_view              = lr_custcont_view
      i_vcode              = g_vcode ).

  lr_custcont_view->initialize(
      ir_controller     = lr_custcont_ctr
      ir_parent_view    = me
      ir_layout         = ir_custcont_layout
      i_vcode           = g_vcode
      i_container_name  = l_container_name ).

ENDMETHOD.
ENDCLASS.
