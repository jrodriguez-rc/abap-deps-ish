class CL_ISH_GC_SIMPLE definition
  public
  inheriting from CL_ISH_GUI_CONTROLLER
  create protected .

public section.
*"* public components of class CL_ISH_GC_SIMPLE
*"* do not include other source files here!!!

  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GC_SIMPLE .
  interface IF_ISH_GUI_VIEW load .
  methods INITIALIZE
    importing
      !IR_PARENT_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !IR_VIEW type ref to IF_ISH_GUI_VIEW optional
      !I_VCODE type TNDYM-VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GC_SIMPLE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GC_SIMPLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GC_SIMPLE IMPLEMENTATION.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

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
       i_mv3        = 'CL_ISH_GC_SIMPLE' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_ctr( ir_parent_controller = ir_parent_controller
                 ir_model             = ir_model
                 ir_view              = ir_view
                 i_vcode              = i_vcode ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.
ENDCLASS.
