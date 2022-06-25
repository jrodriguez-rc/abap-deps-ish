class CL_ISH_GC_SDY_COLLAPSIBLE definition
  public
  inheriting from CL_ISH_GUI_CONTROLLER
  create public .

*"* public components of class CL_ISH_GC_SDY_COLLAPSIBLE
*"* do not include other source files here!!!
public section.

  class CL_ISH_GV_SDY_COLLAPSIBLE definition load .
  class-methods CREATE_AND_INITIALIZE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_PARENT_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !I_VIEWNAME_SDY_COLLAPSIBLE type N1GUI_ELEMENT_NAME
      !I_CTRNAME_COLLAPSED type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_COLLAPSIBLE=>CO_DEF_CTRNAME_COLLAPSED
      !I_VIEWNAME_COLLAPSED type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_COLLAPSIBLE=>CO_DEF_VIEWNAME_COLLAPSED
      !I_CTRNAME_EXPANDED type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_COLLAPSIBLE=>CO_DEF_CTRNAME_EXPANDED
      !I_VIEWNAME_EXPANDED type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_COLLAPSIBLE=>CO_DEF_VIEWNAME_EXPANDED
      !I_INITIALLY_COLLAPSED type ISH_ON_OFF optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GC_SDY_COLLAPSIBLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_SDY_COLLAPSIBLE_VIEW
    returning
      value(RR_VIEW) type ref to CL_ISH_GV_SDY_COLLAPSIBLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !IR_PARENT_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_VCODE type TNDYM-VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !I_VIEWNAME_SDY_COLLAPSIBLE type N1GUI_ELEMENT_NAME
      !I_CTRNAME_COLLAPSED type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_COLLAPSIBLE=>CO_DEF_CTRNAME_COLLAPSED
      !I_VIEWNAME_COLLAPSED type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_COLLAPSIBLE=>CO_DEF_VIEWNAME_COLLAPSED
      !I_CTRNAME_EXPANDED type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_COLLAPSIBLE=>CO_DEF_CTRNAME_EXPANDED
      !I_VIEWNAME_EXPANDED type N1GUI_ELEMENT_NAME default CL_ISH_GV_SDY_COLLAPSIBLE=>CO_DEF_VIEWNAME_EXPANDED
      !I_INITIALLY_COLLAPSED type ISH_ON_OFF optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GC_SDY_COLLAPSIBLE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GC_SDY_COLLAPSIBLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GC_SDY_COLLAPSIBLE IMPLEMENTATION.


METHOD create_and_initialize.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

  rr_instance->initialize(
      ir_parent_controller       = ir_parent_controller
      ir_model                   = ir_model
      i_vcode                    = i_vcode
      i_viewname_sdy_collapsible = i_viewname_sdy_collapsible
      i_ctrname_collapsed        = i_ctrname_collapsed
      i_viewname_collapsed       = i_viewname_collapsed
      i_ctrname_expanded         = i_ctrname_expanded
      i_viewname_expanded        = i_viewname_expanded
      i_initially_collapsed      = i_initially_collapsed ).

ENDMETHOD.


METHOD get_sdy_collapsible_view.

  TRY.
      rr_view ?= gr_view.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_SDY_COLLAPSIBLE_VIEW'
          i_mv3        = 'CL_ISH_GC_SDY_COLLAPSIBLE' ).
  ENDTRY.

ENDMETHOD.


METHOD initialize.

  DATA lr_sdy_collapsible_view           TYPE REF TO cl_ish_gv_sdy_collapsible.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GC_SDY_COLLAPSIBLE' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      CREATE OBJECT lr_sdy_collapsible_view
        EXPORTING
          i_element_name = i_viewname_sdy_collapsible.
      _init_ctr( ir_parent_controller = ir_parent_controller
                 ir_model             = ir_model
                 ir_view              = lr_sdy_collapsible_view
                 i_vcode              = i_vcode ).
      lr_sdy_collapsible_view->initialize(
          ir_controller         = me
          i_vcode               = g_vcode
          i_ctrname_collapsed   = i_ctrname_collapsed
          i_viewname_collapsed  = i_viewname_collapsed
          i_ctrname_expanded   = i_ctrname_expanded
          i_viewname_expanded  = i_viewname_expanded
          i_initially_collapsed = i_initially_collapsed ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.
ENDCLASS.
