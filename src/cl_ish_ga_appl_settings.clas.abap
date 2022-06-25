class CL_ISH_GA_APPL_SETTINGS definition
  public
  inheriting from CL_ISH_GUI_APPLICATION
  create public .

*"* public components of class CL_ISH_GA_APPL_SETTINGS
*"* do not include other source files here!!!
public section.

  constants CO_UCOMM_CONFIRM type SYUCOMM value 'CONFIRM'. "#EC NOTEXT

  interface IF_ISH_GUI_VIEW load .
  methods INITIALIZE
    importing
      !IR_SETTINGS2PROCESS type ref to CL_ISH_GUI_APPL_SETTINGS
      !IR_LAYOUT type ref to CL_ISH_GUI_APPL_LAYOUT optional
      !I_VCODE type TNDYM-VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !I_REPID_SC_SETTINGS type SY-REPID default 'SAPLN1_SDY_GUI_APPL_SETTINGS'
      !I_DYNNR_SC_SETTINGS type SY-DYNNR default '0100'
      !I_DYNPSTRUCT_NAME_SC_SETTINGS type TABNAME default 'RN1_GUI_APPL_SETTINGS'
      !I_STARTING_ROW type I default 10
      !I_STARTING_COL type I default 10
      !I_ENDING_ROW type I default 0
      !I_ENDING_COL type I default 0
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GA_APPL_SETTINGS
*"* do not include other source files here!!!

  data GR_SETTINGS2PROCESS type ref to CL_ISH_GUI_APPL_SETTINGS .
  data GR_SETTINGS_IN type ref to CL_ISH_GUI_APPL_SETTINGS .
  data G_DYNNR_SC_SETTINGS type SY-DYNNR .
  data G_DYNPSTRUCT_NAME_SC_SETTINGS type TABNAME .
  data G_ENDING_COL type I .
  data G_ENDING_ROW type I .
  data G_REPID_SC_SETTINGS type SY-REPID .
  data G_STARTING_COL type I .
  data G_STARTING_ROW type I .

  methods _CREATE_MAIN_CONTROLLER
    redefinition .
  methods _DESTROY
    redefinition .
  methods _PROCESS_COMMAND_REQUEST
    redefinition .
  methods _RUN
    redefinition .
private section.
*"* private components of class CL_ISH_GA_APPL_SETTINGS
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GA_APPL_SETTINGS IMPLEMENTATION.


METHOD initialize.

  DATA:
    ls_dyhead            TYPE rpy_dyhead.

* Self has to be not initialized.
  IF is_initialized( ) = abap_true OR
     is_in_initialization_mode( ) = abap_true.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* The settings2process have to be specified.
  IF ir_settings2process IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* We are in initialization mode.
  g_initialization_mode = abap_true.

* Initialize self.
  TRY.
      _init_appl(
          i_vcode   = i_vcode
          ir_layout = ir_layout ).
      gr_settings_in                = ir_settings2process.
      gr_settings2process           = ir_settings2process->get_clone( ).
      g_repid_sc_settings           = i_repid_sc_settings.
      g_dynnr_sc_settings           = i_dynnr_sc_settings.
      g_dynpstruct_name_sc_settings = i_dynpstruct_name_sc_settings.
      g_starting_row                = i_starting_row.
      g_starting_col                = i_starting_col.
      g_ending_row                  = i_ending_row.
      g_ending_col                  = i_ending_col.
      IF g_ending_row = 0 OR
         g_ending_col = 0.
        CALL FUNCTION 'RPY_DYNPRO_READ'
          EXPORTING
            progname = g_repid_sc_settings
            dynnr    = g_dynnr_sc_settings
          IMPORTING
            header   = ls_dyhead
          EXCEPTIONS
            OTHERS   = 1.
        IF sy-subrc = 0.
          g_ending_row = g_starting_row + ls_dyhead-lines.
          g_ending_col = g_starting_col + ls_dyhead-columns.
        ELSE.
          g_starting_row = 0.
          g_starting_col = 0.
          g_ending_row   = 0.
          g_ending_col   = 0.
        ENDIF.
      ENDIF.
*   On any errors we have to cleanup.
    CLEANUP.
      g_initialization_mode = abap_false.
      CLEAR:
        gr_settings_in,
        gr_settings2process,
        g_repid_sc_settings,
        g_dynnr_sc_settings,
        g_dynpstruct_name_sc_settings,
        g_starting_row,
        g_starting_col,
        g_ending_row,
        g_ending_col.
  ENDTRY.

* We are initialized.
  g_initialization_mode = abap_false.
  g_initialized         = abap_true.

ENDMETHOD.


METHOD _create_main_controller.

  DATA:
    lr_main_controller       TYPE REF TO cl_ish_gc_main_simple,
    lr_main_view             TYPE REF TO cl_ish_gv_mdy_simple,
    lr_main_titlebar         TYPE REF TO cl_ish_gui_mdy_titlebar,
    lr_main_pfstatus         TYPE REF TO cl_ish_gui_mdy_pfstatus,
    lr_settings_view         TYPE REF TO cl_ish_gv_sdy_simple,
    lt_exclfunc              TYPE syucomm_t,
    lx_root                  TYPE REF TO cx_root.

* Process only if we do not have already a main controller.
  rr_main_controller = get_main_controller( ).
  CHECK rr_main_controller IS NOT BOUND.

* On any errors we have to cleanup.
  TRY.

*     Create the main controller.
      lr_main_controller = cl_ish_gc_main_simple=>create( i_element_name = if_ish_gui_main_controller=>co_def_main_controller_name ).

*     Create the main view.
      lr_main_view = cl_ish_gv_mdy_simple=>create( i_element_name = if_ish_gui_mdy_view=>co_def_main_view_name ).

*     Create the main titlebar.
      lr_main_titlebar = cl_ish_gui_mdy_titlebar=>create( i_element_name = cl_ish_gui_mdy_titlebar=>co_def_titlebar_name
                                                          i_title        = '0100'
                                                          i_repid        = 'SAPLN1_MDY_GUI_APPL_SETTINGS' ).

*     Create the main pfstatus.
      IF g_vcode = if_ish_gui_view=>co_vcode_display.
        INSERT co_ucomm_confirm INTO TABLE lt_exclfunc.
      ENDIF.
      lr_main_pfstatus = cl_ish_gui_mdy_pfstatus=>create( i_element_name = cl_ish_gui_mdy_pfstatus=>co_def_pfstatus_name
                                                          i_pfkey        = '0100'
                                                          i_repid        = 'SAPLN1_MDY_GUI_APPL_SETTINGS'
                                                          it_exclfunc    = lt_exclfunc ).

*     Create the settings view.
      lr_settings_view = cl_ish_gv_sdy_simple=>create( i_element_name = 'SC_SETTINGS' ).

*     Initialize the main controller.
      lr_main_controller->initialize( ir_application = me
                                      ir_model       = gr_settings2process
                                      ir_view        = lr_main_view ).

*     Initialize the main view.
      lr_main_view->initialize( ir_controller     = lr_main_controller
                                i_repid           = 'SAPLN1_MDY_GUI_APPL_SETTINGS'
                                i_dynnr           = '0100'
                                ir_titlebar       = lr_main_titlebar
                                ir_pfstatus       = lr_main_pfstatus
                                i_vcode           = g_vcode ).

*     Initialize the settings view.
      lr_settings_view->initialize( ir_controller     = lr_main_controller
                                    ir_parent_view    = lr_main_view
                                    i_repid           = g_repid_sc_settings
                                    i_dynnr           = g_dynnr_sc_settings
                                    i_vcode           = g_vcode
                                    i_dynpstruct_name = g_dynpstruct_name_sc_settings ).

*   On any errors we have to cleanup.
    CLEANUP.

      IF lr_main_controller IS BOUND.
        lr_main_controller->destroy( ).
      ENDIF.
      IF lr_main_view IS BOUND.
        lr_main_view->destroy( ).
      ENDIF.
      IF lr_settings_view IS BOUND.
        lr_settings_view->destroy( ).
      ENDIF.

  ENDTRY.

* Export.
  rr_main_controller = lr_main_controller.

ENDMETHOD.


METHOD _destroy.

  CLEAR:
    gr_settings2process,
    gr_settings_in,
    g_dynnr_sc_settings,
    g_dynpstruct_name_sc_settings,
    g_repid_sc_settings,
    g_starting_row,
    g_starting_col,
    g_ending_row,
    g_ending_col.

  super->_destroy( ).

ENDMETHOD.


METHOD _process_command_request.

  DATA:
    lx_root            TYPE REF TO cx_root.

* The request has to be specified.
  CHECK ir_command_request IS BOUND.

* Process the request.
  CASE ir_command_request->get_fcode( ).

*   Confirm
    WHEN co_ucomm_confirm.

      CHECK gr_settings_in IS BOUND.
      CHECK gr_settings2process IS BOUND.
      TRY.
          gr_settings_in->set_data_by_other( gr_settings2process ).
        CATCH cx_ish_static_handler INTO lx_root.
          _collect_exception( lx_root ).
          rr_response = cl_ish_gui_response=>create( ir_request   = ir_command_request
                                                     ir_processor = me ).
          RETURN.
      ENDTRY.
      rr_response = cl_ish_gui_response=>create( ir_request   = ir_command_request
                                                 ir_processor = me
                                                 i_exit       = abap_true ).
      RETURN.

*   For all other requests call the super method.
    WHEN OTHERS.
      rr_response = super->_process_command_request( ir_command_request = ir_command_request ).

  ENDCASE.

ENDMETHOD.


METHOD _run.

* Start the dialog.
  IF g_starting_row < 1 OR
     g_starting_col < 1 OR
     g_ending_row   < 1 OR
     g_ending_col   < 1.
    CALL FUNCTION 'ISHMED_GUI_APPL_SETTINGS'.
  ELSE.
    CALL FUNCTION 'ISHMED_GUI_APPL_SETTINGS'
      EXPORTING
        i_starting_row = g_starting_row
        i_starting_col = g_starting_col
        i_ending_row   = g_ending_row
        i_ending_col   = g_ending_col.
  ENDIF.

ENDMETHOD.
ENDCLASS.
