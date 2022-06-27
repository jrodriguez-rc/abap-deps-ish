*"* components of interface IF_ISH_GUI_APPLICATION
INTERFACE if_ish_gui_application
  PUBLIC.

  INTERFACES if_ish_destroyable.
  INTERFACES if_ish_gui_element.
  INTERFACES if_ish_gui_request_processor.
  INTERFACES if_ish_gui_request_sender.

  ALIASES destroy
    FOR if_ish_destroyable~destroy.
  ALIASES get_element_id
    FOR if_ish_gui_element~get_element_id.
  ALIASES get_element_name
    FOR if_ish_gui_element~get_element_name.
  ALIASES is_destroyed
    FOR if_ish_destroyable~is_destroyed.
  ALIASES is_in_destroy_mode
    FOR if_ish_destroyable~is_in_destroy_mode.
  ALIASES process_request
    FOR if_ish_gui_request_processor~process_request.
  ALIASES ev_after_destroy
    FOR if_ish_destroyable~ev_after_destroy.
  ALIASES ev_before_destroy
    FOR if_ish_destroyable~ev_before_destroy.

  CONSTANTS co_ucomm_back TYPE syucomm VALUE 'BACK'. "#EC NOTEXT
  CONSTANTS co_ucomm_cancel TYPE syucomm VALUE 'CANCEL'. "#EC NOTEXT
  CONSTANTS co_ucomm_check TYPE syucomm VALUE 'CHECK'. "#EC NOTEXT
  CONSTANTS co_ucomm_config_layout TYPE syucomm VALUE 'CONFIG_LAYOUT'. "#EC NOTEXT
  CONSTANTS co_ucomm_delete TYPE syucomm VALUE 'DELETE'. "#EC NOTEXT
  CONSTANTS co_ucomm_end TYPE syucomm VALUE 'END'. "#EC NOTEXT
  CONSTANTS co_ucomm_enter TYPE syucomm VALUE 'ENTER'. "#EC NOTEXT
  CONSTANTS co_ucomm_save TYPE syucomm VALUE 'SAVE'. "#EC NOTEXT
  CONSTANTS co_ucomm_swi2dis TYPE syucomm VALUE 'SWI2DIS'. "#EC NOTEXT
  CONSTANTS co_ucomm_swi2upd TYPE syucomm VALUE 'SWI2UPD'. "#EC NOTEXT
  CONSTANTS co_ucomm_transport TYPE syucomm VALUE 'TRANSPORT'. "#EC NOTEXT

  METHODS build_alv_variant_report
    IMPORTING
      !ir_view TYPE REF TO if_ish_gui_view OPTIONAL
    RETURNING
      VALUE(r_report) TYPE repid.
  METHODS cancel_next_mdyevt_proc.
  METHODS clear_crspos_message.
  METHODS get_alv_variant_report_prefix
    IMPORTING
      !ir_view TYPE REF TO if_ish_gui_view OPTIONAL
    RETURNING
      VALUE(r_prefix) TYPE string.
  METHODS get_crspos_message
    RETURNING
      VALUE(rs_crspos_message) TYPE rn1message.
  METHODS get_focussed_view
    RETURNING
      VALUE(rr_view) TYPE REF TO if_ish_gui_view.
  METHODS get_layout
    RETURNING
      VALUE(rr_layout) TYPE REF TO cl_ish_gui_appl_layout.
  METHODS get_main_controller
    RETURNING
      VALUE(rr_main_controller) TYPE REF TO if_ish_gui_main_controller.
  METHODS get_startup_settings
    RETURNING
      VALUE(rr_startup_settings) TYPE REF TO cl_ish_gui_startup_settings.
  METHODS get_vcode
    RETURNING
      VALUE(r_vcode) TYPE tndym-vcode.
  METHODS is_embedded
    RETURNING
      VALUE(r_embedded) TYPE abap_bool.
  METHODS is_initialized
    RETURNING
      VALUE(r_initialized) TYPE abap_bool.
  METHODS is_in_initialization_mode
    RETURNING
      VALUE(r_initialization_mode) TYPE abap_bool.
  METHODS is_ish_scrm_supported
    IMPORTING
      !ir_view TYPE REF TO if_ish_gui_dynpro_view OPTIONAL
    RETURNING
      VALUE(r_supported) TYPE abap_bool.
  METHODS is_next_mdyevt_proc_cancelled
    RETURNING
      VALUE(r_cancelled) TYPE abap_bool.
  METHODS is_pai_in_process
    RETURNING
      VALUE(r_pai_in_process) TYPE abap_bool.
  METHODS is_pbo_in_process
    RETURNING
      VALUE(r_pbo_in_process) TYPE abap_bool.
  METHODS is_running
    RETURNING
      VALUE(r_running) TYPE abap_bool.
  METHODS load_layout
    IMPORTING
      !i_layout_name TYPE n1gui_layout_name
      !i_username TYPE username DEFAULT sy-uname
    RETURNING
      VALUE(rr_layout) TYPE REF TO cl_ish_gui_layout
    RAISING
      cx_ish_static_handler.
  METHODS load_view_layout
    IMPORTING
      !ir_view TYPE REF TO if_ish_gui_view
      !ir_controller TYPE REF TO if_ish_gui_controller OPTIONAL
      !ir_parent_view TYPE REF TO if_ish_gui_view OPTIONAL
      !i_layout_name TYPE n1gui_layout_name OPTIONAL
      !i_username TYPE username DEFAULT sy-uname
    RETURNING
      VALUE(rr_layout) TYPE REF TO cl_ish_gui_layout
    RAISING
      cx_ish_static_handler.
  METHODS run
    RETURNING
      VALUE(rr_result) TYPE REF TO cl_ish_gui_appl_result
    RAISING
      cx_ish_static_handler.
  METHODS save_layout
    IMPORTING
      !ir_layout TYPE REF TO cl_ish_gui_layout
      !i_username TYPE username DEFAULT sy-uname
      !i_erdat TYPE ri_erdat DEFAULT sy-datum
      !i_ertim TYPE ri_ertim DEFAULT sy-uzeit
      !i_erusr TYPE ri_ernam DEFAULT sy-uname
    RETURNING
      VALUE(r_saved) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
  METHODS save_view_layout
    IMPORTING
      !ir_view TYPE REF TO if_ish_gui_view
      !i_explicit TYPE abap_bool
      !i_username TYPE username DEFAULT sy-uname
      !i_erdat TYPE ri_erdat DEFAULT sy-datum
      !i_ertim TYPE ri_ertim DEFAULT sy-uzeit
      !i_erusr TYPE ri_ernam DEFAULT sy-uname
    RETURNING
      VALUE(r_saved) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
  METHODS set_focussed_view
    IMPORTING
      !ir_view TYPE REF TO if_ish_gui_view
    RETURNING
      VALUE(r_success) TYPE abap_bool.
  METHODS set_vcode
    IMPORTING
      !i_vcode TYPE ish_vcode
    RETURNING
      VALUE(r_changed) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
ENDINTERFACE.