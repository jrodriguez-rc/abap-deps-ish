class CL_ISH_GUI_DRAG_OBJECT definition
  public
  create public .

*"* public components of class CL_ISH_GUI_DRAG_OBJECT
*"* do not include other source files here!!!
public section.

  methods CONSTRUCTOR
    importing
      !IR_DRAG_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_DRAG_REQUEST type ref to CL_ISH_GUI_REQUEST
      !IR_DROP_PROCESSOR type ref to IF_ISH_GUI_DROP_PROCESSOR optional
      !IR_INFO_OBJECT type ref to OBJECT optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DRAG_REQUEST
  final
    returning
      value(RR_DRAG_REQUEST) type ref to CL_ISH_GUI_REQUEST .
  methods GET_DRAG_VIEW
  final
    returning
      value(RR_DRAG_VIEW) type ref to IF_ISH_GUI_VIEW .
  methods GET_DROP_PROCESSOR
  final
    returning
      value(RR_DROP_PROCESSOR) type ref to IF_ISH_GUI_DROP_PROCESSOR .
  methods GET_INFO_OBJECT
  final
    returning
      value(RR_INFO_OBJECT) type ref to OBJECT .
protected section.
*"* protected components of class CL_ISH_GUI_DRAG_OBJECT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_DRAG_OBJECT
*"* do not include other source files here!!!

  data GR_DRAG_REQUEST type ref to CL_ISH_GUI_REQUEST .
  data GR_DRAG_VIEW type ref to IF_ISH_GUI_VIEW .
  data GR_DROP_PROCESSOR type ref to IF_ISH_GUI_DROP_PROCESSOR .
  data GR_INFO_OBJECT type ref to OBJECT .
ENDCLASS.



CLASS CL_ISH_GUI_DRAG_OBJECT IMPLEMENTATION.


METHOD constructor.

  IF ir_drag_view IS NOT BOUND OR
     ir_drag_request IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_GUI_DRAG_OBJECT' ).
  ENDIF.

  gr_drag_view      = ir_drag_view.
  gr_drag_request   = ir_drag_request.
  gr_drop_processor = ir_drop_processor.
  gr_info_object    = ir_info_object.

ENDMETHOD.


METHOD get_drag_request.

  rr_drag_request = gr_drag_request.

ENDMETHOD.


METHOD get_drag_view.

  rr_drag_view = gr_drag_view.

ENDMETHOD.


METHOD get_drop_processor.

  rr_drop_processor = gr_drop_processor.

ENDMETHOD.


METHOD get_info_object.

  rr_info_object = gr_info_object.

ENDMETHOD.
ENDCLASS.
