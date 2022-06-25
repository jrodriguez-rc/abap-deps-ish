class CL_ISH_GUI_SDY_VIEW definition
  public
  inheriting from CL_ISH_GUI_DYNPRO_VIEW
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_SDY_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_SDY_VIEW .

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_SDY_VIEW
*"* do not include other source files here!!!

  methods _INIT_SDY_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW optional
      !IR_LAYOUT type ref to CL_ISH_GUI_DYNPRO_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_REPID type SYREPID
      !I_DYNNR type SYDYNNR
      !I_DYNNR_TO type SYDYNNR optional
      !I_DYNPSTRUCT_NAME type TABNAME optional
      !IT_DYNPLAY_VCODE type ISH_T_GUI_DYNPLAY_VCODE_H optional
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GUI_SDY_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_SDY_VIEW IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD _init_sdy_view.

  DATA lr_parent_view                   TYPE REF TO if_ish_gui_dynpro_view.
  DATA lr_parent_ctr                    TYPE REF TO if_ish_gui_controller.

* Get the parent view.
  IF ir_parent_view IS BOUND.
    lr_parent_view = ir_parent_view.
  ELSE.
    IF ir_controller IS BOUND.
      lr_parent_ctr = ir_controller->get_parent_controller( ).
      IF lr_parent_ctr IS BOUND.
        TRY.
            lr_parent_view ?= lr_parent_ctr->get_view( ).
          CATCH cx_sy_move_cast_error.
            CLEAR lr_parent_view.
        ENDTRY.
      ENDIF.
    ENDIF.
  ENDIF.
  IF lr_parent_view IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_INIT_SDY_VIEW'
        i_mv3        = 'CL_ISH_GUI_SDY_VIEW' ).
  ENDIF.

* Further processing by _init_dynpro_view.
  _init_dynpro_view(
      ir_controller       = ir_controller
      ir_parent_view      = lr_parent_view
      ir_layout           = ir_layout
      i_vcode             = i_vcode
      i_repid             = i_repid
      i_dynnr             = i_dynnr
      i_dynnr_to          = i_dynnr_to
      i_dynpstruct_name   = i_dynpstruct_name
      it_dynplay_vcode    = it_dynplay_vcode ).

ENDMETHOD.
ENDCLASS.
