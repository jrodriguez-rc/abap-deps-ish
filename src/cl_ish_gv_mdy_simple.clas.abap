class CL_ISH_GV_MDY_SIMPLE definition
  public
  inheriting from CL_ISH_GUI_MDY_VIEW
  create protected .

public section.
*"* public components of class CL_ISH_GV_MDY_SIMPLE
*"* do not include other source files here!!!

  class-methods CREATE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GV_MDY_SIMPLE .
  class-methods CREATE_AND_INITIALIZE
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_CTRNAME type N1GUI_ELEMENT_NAME optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !IR_LAYOUT type ref to CL_ISH_GUI_DYNPRO_LAYOUT optional
      !I_REPID type SYREPID
      !I_DYNNR type SYDYNNR
      !I_DYNNR_TO type SYDYNNR optional
      !IR_TITLEBAR type ref to CL_ISH_GUI_MDY_TITLEBAR optional
      !IT_TITLEBAR type ISH_T_GUI_MDYTITLENAME_HASH optional
      !IR_PFSTATUS type ref to CL_ISH_GUI_MDY_PFSTATUS optional
      !IT_PFSTATUS type ISH_T_GUI_MDYPFSTATNAME_HASH optional
      !I_DYNPSTRUCT_NAME type TABNAME optional
      !IT_DYNPLAY_VCODE type ISH_T_GUI_DYNPLAY_VCODE_H optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GV_MDY_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_MAIN_CONTROLLER
      !IR_LAYOUT type ref to CL_ISH_GUI_DYNPRO_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_REPID type SYREPID
      !I_DYNNR type SYDYNNR
      !I_DYNNR_TO type SYDYNNR optional
      !IR_TITLEBAR type ref to CL_ISH_GUI_MDY_TITLEBAR optional
      !IT_TITLEBAR type ISH_T_GUI_MDYTITLENAME_HASH optional
      !IR_PFSTATUS type ref to CL_ISH_GUI_MDY_PFSTATUS optional
      !IT_PFSTATUS type ISH_T_GUI_MDYPFSTATNAME_HASH optional
      !I_DYNPSTRUCT_NAME type TABNAME optional
      !IT_DYNPLAY_VCODE type ISH_T_GUI_DYNPLAY_VCODE_H optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GV_MDY_SIMPLE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GV_MDY_SIMPLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GV_MDY_SIMPLE IMPLEMENTATION.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD create_and_initialize.

  DATA lr_ctr                     TYPE REF TO cl_ish_gc_main_simple.

* Create the controller.
  lr_ctr = cl_ish_gc_main_simple=>create(
      i_element_name    = i_ctrname
      ir_cb_destroyable = ir_cb_destroyable ).

* Create the view.
  rr_instance = create(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

* Initialize the controller.
  lr_ctr->initialize(
      ir_application = ir_application
      ir_model       = ir_model
      ir_view        = rr_instance
      i_vcode        = i_vcode ).

* Initialize the view.
  rr_instance->initialize(
      ir_controller     = lr_ctr
      ir_layout         = ir_layout
      i_vcode           = i_vcode
      i_repid           = i_repid
      i_dynnr           = i_dynnr
      i_dynnr_to        = i_dynnr_to
      ir_titlebar       = ir_titlebar
      it_titlebar       = it_titlebar
      ir_pfstatus       = ir_pfstatus
      it_pfstatus       = it_pfstatus
      i_dynpstruct_name = i_dynpstruct_name
      it_dynplay_vcode  = it_dynplay_vcode ).

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
        i_mv3        = 'CL_ISH_GV_MDY_SIMPLE' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_mdy_view(
          ir_controller     = ir_controller
          ir_layout         = ir_layout
          i_vcode           = i_vcode
          i_repid           = i_repid
          i_dynnr           = i_dynnr
          i_dynnr_to        = i_dynnr_to
          ir_titlebar       = ir_titlebar
          it_titlebar       = it_titlebar
          ir_pfstatus       = ir_pfstatus
          it_pfstatus       = it_pfstatus
          i_dynpstruct_name = i_dynpstruct_name
          it_dynplay_vcode  = it_dynplay_vcode ).
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.
ENDCLASS.
