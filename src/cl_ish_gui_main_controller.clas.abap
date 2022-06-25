class CL_ISH_GUI_MAIN_CONTROLLER definition
  public
  inheriting from CL_ISH_GUI_CONTROLLER
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GUI_MAIN_CONTROLLER
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_MAIN_CONTROLLER .

  aliases CO_DEF_MAIN_CONTROLLER_NAME
    for IF_ISH_GUI_MAIN_CONTROLLER~CO_DEF_MAIN_CONTROLLER_NAME .
  aliases GET_MDY_VIEW
    for IF_ISH_GUI_MAIN_CONTROLLER~GET_MDY_VIEW .

  methods IF_ISH_GUI_CONTROLLER~GET_APPLICATION
    redefinition .
  methods IF_ISH_GUI_CONTROLLER~GET_MAIN_CONTROLLER
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_MAIN_CONTROLLER
*"* do not include other source files here!!!

  data GR_APPLICATION type ref to IF_ISH_GUI_APPLICATION .

  interface IF_ISH_GUI_VIEW load .
  methods _INIT_MAIN_CTR
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IR_VIEW type ref to IF_ISH_GUI_MDY_VIEW
      !I_VCODE type TNDYM-VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .

  methods _DESTROY
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_MAIN_CONTROLLER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_MAIN_CONTROLLER IMPLEMENTATION.


METHOD if_ish_gui_controller~get_application.

  rr_application = gr_application.

ENDMETHOD.


METHOD if_ish_gui_controller~get_main_controller.

  rr_main_controller = me.

ENDMETHOD.


METHOD if_ish_gui_main_controller~get_mdy_view.

  TRY.
      rr_mdy_view ?= get_view( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD _destroy.

* Call the super method.
  super->_destroy( ).

* Clear attributes.
  CLEAR: gr_application.

ENDMETHOD.


METHOD _init_main_ctr.

* The application has to be specified.
  IF ir_application IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* The given view has to be specified.
  IF ir_view IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* Further initialization by _init_ctr.
  _init_ctr( ir_model = ir_model
             ir_view  = ir_view
             i_vcode  = i_vcode ).

* Initialize attributes.
  gr_application = ir_application.

ENDMETHOD.
ENDCLASS.
