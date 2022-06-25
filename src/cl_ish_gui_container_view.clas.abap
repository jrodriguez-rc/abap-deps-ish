class CL_ISH_GUI_CONTAINER_VIEW definition
  public
  inheriting from CL_ISH_GUI_CONTROL_VIEW
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_CONTAINER_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_CONTAINER_VIEW .

  aliases GET_CONTAINER
    for IF_ISH_GUI_CONTAINER_VIEW~GET_CONTAINER .
  aliases GET_CONTAINER_FOR_CHILD_VIEW
    for IF_ISH_GUI_CONTAINER_VIEW~GET_CONTAINER_FOR_CHILD_VIEW .
protected section.
*"* protected components of class CL_ISH_GUI_CONTAINER_VIEW
*"* do not include other source files here!!!

  type-pools ABAP .
  methods _INIT_CONTAINER_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTAINER_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !I_AUTOSAVE_LAYOUT type ABAP_BOOL default ABAP_FALSE
    raising
      CX_ISH_STATIC_HANDLER .

  methods _FIRST_DISPLAY
    redefinition .
  methods _REFRESH_DISPLAY
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_CONTAINER_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_CONTAINER_VIEW IMPLEMENTATION.


METHOD if_ish_gui_container_view~get_container.

  TRY.
      rr_container ?= get_control( ).
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_container_view~get_container_for_child_view.

  DATA l_element_name TYPE n1gui_element_name.

* The child view has to be specified.
  CHECK ir_child_view IS BOUND.

* The specified view has to be a child view of self.
  l_element_name = ir_child_view->get_element_name( ).
  CHECK get_child_view_by_name( i_view_name = l_element_name ) = ir_child_view.

* Return our container.
  rr_container = get_container( ).

ENDMETHOD.


METHOD _first_display.

  DATA lr_container             TYPE REF TO cl_gui_container.

  _create_control_on_demand( ).

  lr_container = get_container( ).
  IF lr_container IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_FIRST_DISPLAY'
        i_mv3 = 'CL_ISH_GUI_CONTAINER_VIEW' ).
  ENDIF.

ENDMETHOD.


METHOD _init_container_view.

  _init_control_view(
      ir_controller     = ir_controller
      ir_parent_view    = ir_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode ).

ENDMETHOD.


METHOD _refresh_display.

* Not needed.

ENDMETHOD.
ENDCLASS.
