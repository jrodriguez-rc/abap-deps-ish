class CL_ISH_GV_DD_BY_HTML_CODE definition
  public
  inheriting from CL_ISH_GUI_DD_VIEW
  create protected .

public section.
*"* public components of class CL_ISH_GV_DD_BY_HTML_CODE
*"* do not include other source files here!!!
  type-pools SDYDO .

  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_CONTAINER_VIEW
      !IR_LAYOUT type ref to CL_ISH_GUI_CONTROL_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME
      !IT_HTML_CODE type SDYDO_HTML_TABLE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GV_DD_BY_HTML_CODE
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GV_DD_BY_HTML_CODE
*"* do not include other source files here!!!

  data GT_HTML_CODE type SDYDO_HTML_TABLE .

  methods _MERGE_DD
    redefinition .
private section.
*"* private components of class CL_ISH_GV_DD_BY_HTML_CODE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GV_DD_BY_HTML_CODE IMPLEMENTATION.


METHOD create.

  IF it_html_code IS INITIAL.
    cl_ish_utl_exception=>raise_static(
              i_typ        = 'E'
              i_kla        = 'N1BASE'
              i_num        = '030'
              i_mv1        = '1'
              i_mv2        = 'CREATE'
              i_mv3        = 'CL_ISH_GV_DD_BY_HTML_CODE' ).
  ENDIF.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name = i_element_name.

  CHECK rr_instance IS BOUND.
  rr_instance->gt_html_code = it_html_code.

ENDMETHOD.


METHOD initialize.
  CALL METHOD me->_initialize
    EXPORTING
      ir_controller  = ir_controller
      ir_parent_view = ir_parent_view
      ir_layout      = ir_layout
      i_vcode        = i_vcode.
ENDMETHOD.


METHOD _merge_dd.

* Add the HTML table to cr_dd_document
  CALL METHOD ir_dd->add_static_html
    EXPORTING
      table_with_html = gt_html_code.

ENDMETHOD.
ENDCLASS.
