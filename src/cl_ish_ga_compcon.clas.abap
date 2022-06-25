class CL_ISH_GA_COMPCON definition
  public
  inheriting from CL_ISH_GUI_APPLICATION
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GA_COMPCON
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_GM_COMPCON type ref to CL_ISH_GM_COMPCON .
  methods GET_GM_COMPCON
    returning
      value(RR_GM_COMPCON) type ref to CL_ISH_GM_COMPCON .
protected section.
*"* protected components of class CL_ISH_GA_COMPCON
*"* do not include other source files here!!!

  data GR_GM_COMPCON type ref to CL_ISH_GM_COMPCON .

  methods _GET_MDY_DYNNR
  abstract
    returning
      value(R_DYNNR) type SYDYNNR .
  methods _GET_MDY_DYNPSTRUCT_NAME
  abstract
    returning
      value(R_DYNPSTRUCT_NAME) type TABNAME .
  methods _GET_MDY_MODEL
    returning
      value(RR_MDY_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods _GET_MDY_REPID
  abstract
    returning
      value(R_REPID) type SYREPID .
  methods _INITIALIZE
    importing
      !IR_LAYOUT type ref to CL_ISH_GUI_APPL_LAYOUT optional
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .

  methods _CREATE_MAIN_CONTROLLER
    redefinition .
  methods _RUN
    redefinition .
  methods _DESTROY
    redefinition .
private section.
*"* private components of class CL_ISH_GA_COMPCON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GA_COMPCON IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

  gr_gm_compcon = ir_gm_compcon.

ENDMETHOD.


METHOD get_gm_compcon.

  rr_gm_compcon = gr_gm_compcon.

ENDMETHOD.


METHOD _create_main_controller.

  DATA lr_main_ctr                            TYPE REF TO cl_ish_gc_main_simple.
  DATA lr_main_view                           TYPE REF TO cl_ish_gv_mdy_simple.

* Process only if we do not have already a main controller.
  rr_main_controller = get_main_controller( ).
  CHECK rr_main_controller IS NOT BOUND.

* On any errors we have to cleanup.
  TRY.

*     Create the main controller.
      lr_main_ctr = cl_ish_gc_main_simple=>create(
        i_element_name = if_ish_gui_main_controller=>co_def_main_controller_name ).

*     Create the main view.
      lr_main_view = cl_ish_gv_mdy_simple=>create(
        i_element_name = if_ish_gui_mdy_view=>co_def_main_view_name ).

*     Initialize the main controller.
      lr_main_ctr->initialize(
          ir_application  = me
          ir_model        = _get_mdy_model( )
          ir_view         = lr_main_view ).

*     Initialize the main view.
      lr_main_view->initialize(
          ir_controller     = lr_main_ctr
          i_repid           = _get_mdy_repid( )
          i_dynnr           = _get_mdy_dynnr( )
          i_dynpstruct_name = _get_mdy_dynpstruct_name( )
          i_vcode           = g_vcode ).

*   On any errors we have to cleanup.
    CLEANUP.

      IF lr_main_ctr IS BOUND.
        lr_main_ctr->destroy( ).
      ENDIF.
      IF lr_main_view IS BOUND.
        lr_main_view->destroy( ).
      ENDIF.

  ENDTRY.

* Export.
  rr_main_controller = lr_main_ctr.

ENDMETHOD.


METHOD _destroy.

  super->_destroy( ).

  CLEAR gr_gm_compcon.

ENDMETHOD.


METHOD _get_mdy_model.

  rr_mdy_model = gr_gm_compcon.

ENDMETHOD.


METHOD _initialize.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = '_INITIALIZE'
        i_mv3 = 'CL_ISH_GA_COMPCON' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.

*     Default initialization.
      _init_appl(
          i_vcode         = i_vcode
          ir_layout       = ir_layout
          i_default_ucomm = co_ucomm_enter
          i_embedded      = abap_true ).

*   On any errors we have to cleanup.
    CLEANUP.

      g_initialization_mode = abap_false.

  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


method _RUN.
endmethod.
ENDCLASS.
