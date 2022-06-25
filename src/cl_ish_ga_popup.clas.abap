class CL_ISH_GA_POPUP definition
  public
  inheriting from CL_ISH_GUI_APPLICATION
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GA_POPUP
*"* do not include other source files here!!!

  constants CO_CTRNAME_POPUP type N1GUI_ELEMENT_NAME value 'POPUP_CTR'. "#EC NOTEXT
  constants CO_MDY_DYNNR type SYDYNNR value '0100'. "#EC NOTEXT
  constants CO_MDY_DYNNR_TO type SYDYNNR value '0110'. "#EC NOTEXT
  constants CO_MDY_REPID type SYREPID value 'SAPLN1_GUI_MDY_POPUP_SIMPLE'. "#EC NOTEXT
  constants CO_VIEWNAME_POPUP type N1GUI_ELEMENT_NAME value 'SC_POPUP'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional .
  methods GET_POPUP_CTR
    returning
      value(RR_CTR) type ref to IF_ISH_GUI_CONTROLLER .
  methods GET_POPUP_VIEW
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_SDY_VIEW .
protected section.
*"* protected components of class CL_ISH_GA_POPUP
*"* do not include other source files here!!!

  data G_END_COL type I .
  data G_END_ROW type I .
  data G_START_COL type I .
  data G_START_ROW type I .

  type-pools ABAP .
  methods _CMD_CANCEL
    returning
      value(R_EXIT) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CMD_ENTER
  abstract
    returning
      value(R_EXIT) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CREATE_PFSTATUS
    returning
      value(RR_PFSTATUS) type ref to CL_ISH_GUI_MDY_PFSTATUS
    raising
      CX_ISH_STATIC_HANDLER .
  methods _CREATE_TITLEBAR
    returning
      value(RR_TITLEBAR) type ref to CL_ISH_GUI_MDY_TITLEBAR
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_TITLE_TEXT
  abstract
    returning
      value(R_TITLE_TEXT) type STRING
    raising
      CX_ISH_STATIC_HANDLER .
  interface IF_ISH_GUI_VIEW load .
  methods _INIT_GA_POPUP
    importing
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !IR_LAYOUT type ref to CL_ISH_GUI_APPL_LAYOUT optional
      !I_MESSAGES_VIEW_NAME type N1GUI_ELEMENT_NAME default CO_DEF_MESSAGES_VIEW_NAME
      !I_DEFAULT_UCOMM type SYUCOMM default SPACE
      !I_START_ROW type I default 0
      !I_START_COL type I default 0
      !I_END_ROW type I default 0
      !I_END_COL type I default 0
    raising
      CX_ISH_STATIC_HANDLER .
  methods _LOAD_POPUP_VIEW
  abstract
    raising
      CX_ISH_STATIC_HANDLER .

  methods _BEFORE_RUN
    redefinition .
  methods _CREATE_MAIN_CONTROLLER
    redefinition .
  methods _PROCESS_COMMAND_REQUEST
    redefinition .
  methods _PROCESS_MDY_EVENT
    redefinition .
  methods _RUN
    redefinition .
private section.
*"* private components of class CL_ISH_GA_POPUP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GA_POPUP IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD GET_POPUP_CTR.

  CHECK gr_main_controller IS BOUND.

  rr_ctr = gr_main_controller->get_child_controller_by_name( co_ctrname_popup ).

ENDMETHOD.


METHOD GET_POPUP_VIEW.

  DATA lr_ctr           TYPE REF TO if_ish_gui_controller.

  lr_ctr = get_popup_ctr( ).
  CHECK lr_ctr IS BOUND.

  TRY.
      rr_view ?= lr_ctr->get_view( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD _BEFORE_RUN.

* Call the super method.
  super->_before_run( ).

* Load the popup view.
  _load_popup_view( ).

ENDMETHOD.


METHOD _CMD_CANCEL.

  r_exit = abap_true.

ENDMETHOD.


METHOD _CREATE_MAIN_CONTROLLER.

  DATA lr_main_ctr                    TYPE REF TO cl_ish_gc_main_simple.
  DATA lr_main_view                   TYPE REF TO cl_ish_gv_mdy_simple.
  DATA lr_titlebar                    TYPE REF TO cl_ish_gui_mdy_titlebar.
  DATA l_title_text                   TYPE string.
  DATA lr_pfstatus                    TYPE REF TO cl_ish_gui_mdy_pfstatus.
  DATA lt_exclfunc                    TYPE syucomm_t.

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

*     Create the main titlebar.
      lr_titlebar = _create_titlebar( ).

*     Create the main pfstatus objects.
      lr_pfstatus = _create_pfstatus( ).

*     Initialize the main controller.
      lr_main_ctr->initialize(
          ir_application  = me
          ir_view         = lr_main_view
          i_vcode         = g_vcode ).

*     Initialize the main view.
      lr_main_view->initialize(
          ir_controller     = lr_main_ctr
          i_repid           = co_mdy_repid
          i_dynnr           = co_mdy_dynnr
          i_dynnr_to        = co_mdy_dynnr_to
          ir_titlebar       = lr_titlebar
          ir_pfstatus       = lr_pfstatus
          i_vcode           = g_vcode ).

*     On any errors we have to cleanup.
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


METHOD _CREATE_PFSTATUS.

  DATA lt_exclfunc                    TYPE ui_functions.

  IF g_vcode = if_ish_gui_view=>co_vcode_display.
    INSERT co_ucomm_enter INTO TABLE lt_exclfunc.
  ENDIF.

  rr_pfstatus = cl_ish_gui_mdy_pfstatus=>create(
    i_element_name  = cl_ish_gui_mdy_pfstatus=>co_def_pfstatus_name
    i_pfkey         = '0100'
    i_repid         = co_mdy_repid
    it_exclfunc     = lt_exclfunc ).

ENDMETHOD.


METHOD _CREATE_TITLEBAR.

  DATA l_title_text                   TYPE string.

  l_title_text = _get_title_text( ).

  rr_titlebar = cl_ish_gui_mdy_titlebar=>create(
    i_element_name  = cl_ish_gui_mdy_titlebar=>co_def_titlebar_name
    i_title         = '0100'
    i_repid         = co_mdy_repid
    i_par1          = l_title_text ).

ENDMETHOD.


METHOD _init_ga_popup.

  DATA lr_badiappl            TYPE REF TO if_ish_gui_badiappl.
  DATA l_badiapplid           TYPE n1gui_badiapplid.
  DATA lr_badi_setpopcoord    TYPE REF TO ish_gui_setpopcoord.


* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'INITIALIZE'
        i_mv3        = 'CL_ISH_GA_POPUP' ).
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_appl(
          i_vcode               = i_vcode
          ir_layout             = ir_layout
          i_messages_view_name  = i_messages_view_name
          i_default_ucomm       = i_default_ucomm ).
      IF i_start_row <= 0.
        g_start_row = 10.
      ELSE.
        g_start_row = i_start_row.
      ENDIF.
      IF i_start_col <= 0.
        g_start_col = 10.
      ELSE.
        g_start_col = i_start_col.
      ENDIF.
      g_end_row   = i_end_row.
      g_end_col   = i_end_col.
*     Call badi setpopcoord to finalize the popup coordinates.
      DO 1 TIMES.
        TRY.
            lr_badiappl ?= me.
          CATCH cx_sy_move_cast_error.
            EXIT.
        ENDTRY.
        l_badiapplid = lr_badiappl->get_badiapplid( ).
        CHECK l_badiapplid IS NOT INITIAL.
        TRY.
            GET BADI lr_badi_setpopcoord
              FILTERS
                n1gui_badiapplid = l_badiapplid
              CONTEXT
                lr_badiappl.
          CATCH cx_badi.
            EXIT.
        ENDTRY.
        CHECK lr_badi_setpopcoord IS BOUND.
        CALL BADI lr_badi_setpopcoord->set_popup_coordinates
          EXPORTING
            ir_application = me
          CHANGING
            c_start_col    = g_start_col
            c_start_row    = g_start_row
            c_end_col      = g_end_col
            c_end_row      = g_end_row.
      ENDDO.
    CLEANUP.
      g_initialization_mode = abap_false.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD _PROCESS_COMMAND_REQUEST.

  DATA l_exit                   TYPE abap_bool.
  DATA lx_root                  TYPE REF TO cx_root.

  CHECK ir_command_request IS BOUND.

  TRY.
      CASE ir_command_request->get_fcode( ).
        WHEN co_ucomm_enter.
          l_exit = _cmd_enter( ).
        WHEN OTHERS.
          rr_response = super->_process_command_request( ir_command_request = ir_command_request ).
          RETURN.
      ENDCASE.
    CATCH cx_ish_static_handler INTO lx_root.
      _collect_exception( ir_exception = lx_root ).
      rr_response = cl_ish_gui_response=>create(
          ir_request    = ir_command_request
          ir_processor  = me ).
      RETURN.
  ENDTRY.

  rr_response = cl_ish_gui_response=>create(
      ir_request    = ir_command_request
      ir_processor  = me
      i_exit        = l_exit ).

ENDMETHOD.


METHOD _process_mdy_event.

  DATA l_exit           TYPE abap_bool.
  DATA lx_static        TYPE REF TO cx_ish_static_handler.

  CHECK ir_mdy_event IS BOUND.

  TRY.
      CASE ir_mdy_event->get_ucomm( ).
        WHEN co_ucomm_cancel.
          CHECK ir_mdy_event->is_exit_command( ) = abap_true. "Führer, 6.4.09
          l_exit = _cmd_cancel( ).
        WHEN OTHERS.
          rr_response = super->_process_mdy_event( ir_mdy_event ).
          RETURN.
      ENDCASE.
    CATCH cx_ish_static_handler INTO lx_static.
      IF lx_static->gr_errorhandler IS BOUND.
        lx_static->gr_errorhandler->display_messages( ).
      ENDIF.
      rr_response = cl_ish_gui_response=>create(
          ir_request    = ir_mdy_event
          ir_processor  = me
          i_exit        = abap_true ).
      RETURN.
  ENDTRY.

  rr_response = cl_ish_gui_response=>create(
      ir_request    = ir_mdy_event
      ir_processor  = me
      i_exit        = l_exit ).

ENDMETHOD.


METHOD _run.

  DATA lr_popup_view          TYPE REF TO if_ish_gui_sdy_view.
  DATA l_popup_repid          TYPE syrepid.
  DATA l_popup_dynnr          TYPE sydynnr.
  DATA ls_dyhead              TYPE d020s.
  DATA l_end_col              TYPE i.
  DATA l_end_row              TYPE i.
  DATA l_start_col            TYPE i.
  DATA l_start_row            TYPE i.

  l_start_col = g_start_col.
  l_start_row = g_start_row.

  l_end_col = g_end_col.
  l_end_row = g_end_row.

  IF l_end_col > g_start_col AND
     l_end_row > g_start_row.
    l_end_col   = g_end_col.
    l_end_row   = g_end_row.
  ELSE.
    DO 1 TIMES.
      lr_popup_view = get_popup_view( ).
      CHECK lr_popup_view IS BOUND.
      l_popup_repid = lr_popup_view->get_repid( ).
      l_popup_dynnr = lr_popup_view->get_dynnr( ).
      CALL FUNCTION 'RPY_DYNPRO_READ_NATIVE'
        EXPORTING
          progname             = l_popup_repid
          dynnr                = l_popup_dynnr
          suppress_corr_checks = abap_true
        IMPORTING
          header               = ls_dyhead
        EXCEPTIONS
          OTHERS               = 1.
      CHECK sy-subrc = 0.
      l_end_col = ls_dyhead-bzbr + g_start_col.
      l_end_row = ls_dyhead-bzmx + g_start_row.
    ENDDO.
  ENDIF.

  IF l_end_col <= l_start_col OR
     l_end_row <= l_start_row.
    CALL FUNCTION 'ISH_GUI_MDY_POPUP_SIMPLE'
      EXPORTING
        ir_application = me.
  ELSE.
    CALL FUNCTION 'ISH_GUI_MDY_POPUP_SIMPLE'
      EXPORTING
        ir_application = me
        i_start_col    = l_start_col
        i_start_row    = l_start_row
        i_end_col      = l_end_col
        i_end_row      = l_end_row.
    g_start_col = l_start_col.
    g_start_row = l_start_row.
    g_end_col   = l_end_col.
    g_end_row   = l_end_row.
  ENDIF.

ENDMETHOD.
ENDCLASS.
