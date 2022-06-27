CLASS cl_ish_gui_application DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_element
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_ish_destroyable.
    INTERFACES if_ish_gui_application.
    INTERFACES if_ish_gui_request_processor.
    INTERFACES if_ish_gui_request_sender.

    ALIASES co_ucomm_back FOR if_ish_gui_application~co_ucomm_back.
    ALIASES co_ucomm_cancel FOR if_ish_gui_application~co_ucomm_cancel.
    ALIASES co_ucomm_check FOR if_ish_gui_application~co_ucomm_check.
    ALIASES co_ucomm_config_layout FOR if_ish_gui_application~co_ucomm_config_layout.
    ALIASES co_ucomm_delete FOR if_ish_gui_application~co_ucomm_delete.
    ALIASES co_ucomm_end FOR if_ish_gui_application~co_ucomm_end.
    ALIASES co_ucomm_enter FOR if_ish_gui_application~co_ucomm_enter.
    ALIASES co_ucomm_save FOR if_ish_gui_application~co_ucomm_save.
    ALIASES co_ucomm_swi2dis FOR if_ish_gui_application~co_ucomm_swi2dis.
    ALIASES co_ucomm_swi2upd FOR if_ish_gui_application~co_ucomm_swi2upd.
    ALIASES co_ucomm_transport FOR if_ish_gui_application~co_ucomm_transport.
    ALIASES build_alv_variant_report FOR if_ish_gui_application~build_alv_variant_report.
    ALIASES cancel_next_mdyevt_proc FOR if_ish_gui_application~cancel_next_mdyevt_proc.
    ALIASES clear_crspos_message FOR if_ish_gui_application~clear_crspos_message.
    ALIASES destroy FOR if_ish_gui_application~destroy.
    ALIASES get_alv_variant_report_prefix FOR if_ish_gui_application~get_alv_variant_report_prefix.
    ALIASES get_crspos_message FOR if_ish_gui_application~get_crspos_message.
    ALIASES get_focussed_view FOR if_ish_gui_application~get_focussed_view.
    ALIASES get_layout FOR if_ish_gui_application~get_layout.
    ALIASES get_main_controller FOR if_ish_gui_application~get_main_controller.
    ALIASES get_startup_settings FOR if_ish_gui_application~get_startup_settings.
    ALIASES get_vcode FOR if_ish_gui_application~get_vcode.
    ALIASES is_destroyed FOR if_ish_gui_application~is_destroyed.
    ALIASES is_embedded FOR if_ish_gui_application~is_embedded.
    ALIASES is_initialized FOR if_ish_gui_application~is_initialized.
    ALIASES is_in_destroy_mode FOR if_ish_gui_application~is_in_destroy_mode.
    ALIASES is_in_initialization_mode FOR if_ish_gui_application~is_in_initialization_mode.
    ALIASES is_ish_scrm_supported FOR if_ish_gui_application~is_ish_scrm_supported.
    ALIASES is_next_mdyevt_proc_cancelled FOR if_ish_gui_application~is_next_mdyevt_proc_cancelled.
    ALIASES is_pai_in_process FOR if_ish_gui_application~is_pai_in_process.
    ALIASES is_pbo_in_process FOR if_ish_gui_application~is_pbo_in_process.
    ALIASES is_running FOR if_ish_gui_application~is_running.
    ALIASES load_layout FOR if_ish_gui_application~load_layout.
    ALIASES process_request FOR if_ish_gui_application~process_request.
    ALIASES run FOR if_ish_gui_application~run.
    ALIASES save_layout FOR if_ish_gui_application~save_layout.
    ALIASES set_focussed_view FOR if_ish_gui_application~set_focussed_view.
    ALIASES set_vcode FOR if_ish_gui_application~set_vcode.
    ALIASES ev_after_destroy FOR if_ish_gui_application~ev_after_destroy.
    ALIASES ev_before_destroy FOR if_ish_gui_application~ev_before_destroy.

    CONSTANTS co_def_messages_view_name TYPE n1gui_element_name VALUE 'MESSAGES_VIEW'. "#EC NOTEXT
    CONSTANTS co_ucomm_crspos TYPE syucomm VALUE '#GUI_CRSPOS'. "#EC NOTEXT
    CONSTANTS co_ucomm_exit_by_control_event TYPE syucomm VALUE '#GUI_EXIT_BY_CONTROL_EVENT'. "#EC NOTEXT
    CONSTANTS co_ucomm_noproc TYPE syucomm VALUE '#GUI_NOPROC'. "#EC NOTEXT

    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL.
    METHODS get_main_view
      RETURNING
        VALUE(rr_main_view) TYPE REF TO if_ish_gui_mdy_view.
  PROTECTED SECTION.
*"* protected components of class CL_ISH_GUI_APPLICATION
*"* do not include other source files here!!!

    DATA gr_cb_destroyable TYPE REF TO if_ish_cb_destroyable.
    DATA gr_focussed_view TYPE REF TO if_ish_gui_view.
    DATA gr_layout TYPE REF TO cl_ish_gui_appl_layout.
    DATA gr_main_controller TYPE REF TO if_ish_gui_main_controller.
    DATA gr_messages TYPE REF TO cl_ishmed_errorhandling.
    DATA gr_okcode_request TYPE REF TO cl_ish_gui_okcode_request.
    DATA gr_request_4_arp TYPE REF TO cl_ish_gui_request.
    DATA gr_run_result TYPE REF TO cl_ish_gui_appl_result.
    DATA gr_startup_settings TYPE REF TO cl_ish_gui_startup_settings.
    DATA gs_crspos_message TYPE rn1message.
    DATA g_cancel_next_mdyevt_proc TYPE abap_bool.
    DATA g_control_event_in_process TYPE abap_bool.
    DATA g_default_ucomm TYPE syucomm.
    DATA g_destroyed TYPE abap_bool.
    DATA g_destroy_mode TYPE abap_bool.
    DATA g_embedded TYPE abap_bool.
    DATA g_initialization_mode TYPE abap_bool.
    DATA g_initialized TYPE abap_bool.
    DATA g_messages_view_name TYPE n1gui_element_name.
    DATA g_pai_in_process TYPE abap_bool.
    DATA g_pbo_in_process TYPE abap_bool.
    DATA g_running TYPE abap_bool.
    DATA g_vcode TYPE tndym-vcode.

    METHODS on_mdy_exit
      FOR EVENT ev_exit OF if_ish_gui_mdy_view
      IMPORTING
        !sender.
    METHODS on_message_click
      FOR EVENT message_click OF cl_ishmed_errorhandling
      IMPORTING
        !e_message
        !sender.
    METHODS on_message_function
      FOR EVENT message_function OF cl_ishmed_errorhandling
      IMPORTING
        !e_ucomm
        !sender.
    METHODS _adjust_to_layout
      IMPORTING
        !ir_layout TYPE REF TO cl_ish_gui_layout
        !i_config_rc TYPE ish_method_rc OPTIONAL
      RETURNING
        VALUE(rr_messages) TYPE REF TO cl_ishmed_errorhandling
      RAISING
        cx_ish_static_handler.
    METHODS _after_command_request
      IMPORTING
        !ir_command_request TYPE REF TO cl_ish_gui_command_request
        !ir_response TYPE REF TO cl_ish_gui_response
      CHANGING
        !c_exit TYPE abap_bool.
    METHODS _after_event_request
      IMPORTING
        !ir_event_request TYPE REF TO cl_ish_gui_event_request
        !ir_response TYPE REF TO cl_ish_gui_response OPTIONAL
      CHANGING
        !c_exit TYPE abap_bool.
    METHODS _after_pai
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _after_pai_main
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _after_pbo
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _after_pbo_main
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _after_run.
    METHODS _are_views_changed
      RETURNING
        VALUE(r_changed) TYPE abap_bool.
    METHODS _before_command_request
      IMPORTING
        !ir_command_request TYPE REF TO cl_ish_gui_command_request
      CHANGING
        !c_no_further_processing TYPE abap_bool
        !c_exit TYPE abap_bool.
    METHODS _before_event_request
      IMPORTING
        !ir_event_request TYPE REF TO cl_ish_gui_event_request
      CHANGING
        !c_no_further_processing TYPE abap_bool
        !c_exit TYPE abap_bool.
    METHODS _before_pai
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _before_pai_main
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _before_pbo
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _before_pbo_main
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _before_run
      RAISING
        cx_ish_static_handler.
    METHODS _check_load_view_layout
      IMPORTING
        !ir_view TYPE REF TO if_ish_gui_view
        !ir_controller TYPE REF TO if_ish_gui_controller OPTIONAL
        !ir_parent_view TYPE REF TO if_ish_gui_view OPTIONAL
        !i_layout_name TYPE n1gui_layout_name OPTIONAL
        !i_username TYPE username DEFAULT sy-uname
      RETURNING
        VALUE(r_load) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _check_save_view_layout
      IMPORTING
        !ir_view TYPE REF TO if_ish_gui_view
        !ir_layout TYPE REF TO cl_ish_gui_layout
        !i_explicit TYPE abap_bool
        !i_username TYPE username DEFAULT sy-uname
      RETURNING
        VALUE(r_save) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _check_views
      RETURNING
        VALUE(rr_result) TYPE REF TO cl_ish_result
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_exit_by_control_event
      IMPORTING
        !ir_command_request TYPE REF TO cl_ish_gui_command_request
      RETURNING
        VALUE(r_exit) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _collect_exception
      IMPORTING
        !ir_exception TYPE REF TO cx_root.
    METHODS _collect_message
      IMPORTING
        !i_typ TYPE sy-msgty
        !i_kla TYPE sy-msgid
        !i_num TYPE sy-msgno
        !i_mv1 TYPE any OPTIONAL
        !i_mv2 TYPE any OPTIONAL
        !i_mv3 TYPE any OPTIONAL
        !i_mv4 TYPE any OPTIONAL
        !i_par TYPE bapiret2-parameter OPTIONAL
        !i_row TYPE bapiret2-row OPTIONAL
        !i_field TYPE bapiret2-field OPTIONAL
        !ir_object TYPE nobjectref OPTIONAL
        !i_line_key TYPE char100 OPTIONAL
        !ir_error_obj TYPE REF TO cl_ish_error OPTIONAL.
    METHODS _collect_messages
      IMPORTING
        !ir_messages TYPE REF TO cl_ishmed_errorhandling.
    METHODS _collect_message_by_syst
      IMPORTING
        !i_typ TYPE sy-msgty DEFAULT sy-msgty
        !i_par TYPE bapiret2-parameter OPTIONAL
        !i_row TYPE bapiret2-row OPTIONAL
        !i_field TYPE bapiret2-field OPTIONAL
        !ir_object TYPE nobjectref OPTIONAL
        !i_line_key TYPE char100 OPTIONAL.
    METHODS _create_main_controller ABSTRACT
      RETURNING
        VALUE(rr_main_controller) TYPE REF TO if_ish_gui_main_controller
      RAISING
        cx_ish_static_handler.
    METHODS _create_messages
      RETURNING
        VALUE(rr_messages) TYPE REF TO cl_ishmed_errorhandling.
    METHODS _create_messages_view
      RETURNING
        VALUE(rr_messages_view) TYPE REF TO if_ish_gui_container_view
      RAISING
        cx_ish_static_handler.
    METHODS _create_run_result
      RETURNING
        VALUE(rr_result) TYPE REF TO cl_ish_gui_appl_result
      EXCEPTIONS
        cx_ish_static_handler.
    METHODS _destroy.
    METHODS _display_messages
      RETURNING
        VALUE(r_displayed) TYPE abap_bool.
    METHODS _finalize_run_result
      RETURNING
        VALUE(rr_result) TYPE REF TO cl_ish_gui_appl_result
      RAISING
        cx_ish_static_handler.
    METHODS _get_layointkey
      RETURNING
        VALUE(r_layointkey) TYPE n1guilayointkey.
    METHODS _get_messages_view
      RETURNING
        VALUE(rr_messages_view) TYPE REF TO if_ish_gui_container_view.
    METHODS _get_messages_view_title
      RETURNING
        VALUE(r_title) TYPE lvc_title.
    METHODS _get_okcodereq_by_controlev
      IMPORTING
        !ir_control_event TYPE REF TO cl_ish_gui_control_event
      RETURNING
        VALUE(rr_okcode_request) TYPE REF TO cl_ish_gui_okcode_request.
    METHODS _help_request
      IMPORTING
        !ir_dynpro_view TYPE REF TO if_ish_gui_dynpro_view
        !i_fieldname TYPE ish_fieldname
      RETURNING
        VALUE(r_processed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _init_appl
      IMPORTING
        !i_vcode TYPE tndym-vcode DEFAULT if_ish_gui_view=>co_vcode_display
        !ir_layout TYPE REF TO cl_ish_gui_appl_layout OPTIONAL
        !i_messages_view_name TYPE n1gui_element_name DEFAULT co_def_messages_view_name
        !i_default_ucomm TYPE syucomm DEFAULT space
        !i_embedded TYPE abap_bool DEFAULT abap_false
        !ir_startup_settings TYPE REF TO cl_ish_gui_startup_settings OPTIONAL
      RAISING
        cx_ish_static_handler.
    METHODS _process_command_request
      IMPORTING
        !ir_command_request TYPE REF TO cl_ish_gui_command_request
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _process_control_event
      IMPORTING
        !ir_control_event TYPE REF TO cl_ish_gui_control_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _process_dynpro_event
      IMPORTING
        !ir_dynpro_event TYPE REF TO cl_ish_gui_dynpro_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _process_event_request
      IMPORTING
        !ir_event_request TYPE REF TO cl_ish_gui_event_request
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _process_exception_event
      IMPORTING
        !ir_exception_event TYPE REF TO cl_ish_gui_exception_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _process_mdy_event
      IMPORTING
        !ir_mdy_event TYPE REF TO cl_ish_gui_mdy_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _process_message_event
      IMPORTING
        !ir_message_event TYPE REF TO cl_ish_gui_message_event
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _run ABSTRACT
      RAISING
        cx_ish_static_handler.
    METHODS _set_vcode
      IMPORTING
        !i_vcode TYPE ish_vcode
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _value_request
      IMPORTING
        !ir_dynpro_view TYPE REF TO if_ish_gui_dynpro_view
        !i_fieldname TYPE ish_fieldname
      EXPORTING
        !e_processed TYPE abap_bool
        !et_changed_field TYPE ish_t_dynpread
      RAISING
        cx_ish_static_handler.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_application IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD on_message_function.

  ENDMETHOD.


  METHOD _check_load_view_layout.

  ENDMETHOD.


  METHOD _collect_message.

  ENDMETHOD.


  METHOD get_main_view.

  ENDMETHOD.


  METHOD if_ish_destroyable~destroy.

  ENDMETHOD.


  METHOD if_ish_destroyable~is_destroyed.

  ENDMETHOD.


  METHOD if_ish_destroyable~is_in_destroy_mode.

  ENDMETHOD.


  METHOD if_ish_gui_application~build_alv_variant_report.

  ENDMETHOD.


  METHOD if_ish_gui_application~cancel_next_mdyevt_proc.

  ENDMETHOD.


  METHOD if_ish_gui_application~clear_crspos_message.

  ENDMETHOD.


  METHOD if_ish_gui_application~get_alv_variant_report_prefix.

  ENDMETHOD.


  METHOD if_ish_gui_application~get_crspos_message.

  ENDMETHOD.


  METHOD if_ish_gui_application~get_focussed_view.

  ENDMETHOD.


  METHOD if_ish_gui_application~get_layout.

  ENDMETHOD.


  METHOD if_ish_gui_application~get_main_controller.

  ENDMETHOD.


  METHOD if_ish_gui_application~get_startup_settings.

  ENDMETHOD.


  METHOD if_ish_gui_application~get_vcode.

  ENDMETHOD.


  METHOD if_ish_gui_application~is_embedded.

  ENDMETHOD.


  METHOD if_ish_gui_application~is_initialized.

  ENDMETHOD.


  METHOD if_ish_gui_application~is_in_initialization_mode.

  ENDMETHOD.


  METHOD if_ish_gui_application~is_ish_scrm_supported.

  ENDMETHOD.


  METHOD if_ish_gui_application~is_next_mdyevt_proc_cancelled.

  ENDMETHOD.


  METHOD if_ish_gui_application~is_pai_in_process.

  ENDMETHOD.


  METHOD if_ish_gui_application~is_pbo_in_process.

  ENDMETHOD.


  METHOD if_ish_gui_application~is_running.

  ENDMETHOD.


  METHOD if_ish_gui_application~load_layout.

  ENDMETHOD.


  METHOD if_ish_gui_application~load_view_layout.

  ENDMETHOD.


  METHOD if_ish_gui_application~run.

  ENDMETHOD.


  METHOD if_ish_gui_application~save_layout.

  ENDMETHOD.


  METHOD if_ish_gui_application~save_view_layout.

  ENDMETHOD.


  METHOD if_ish_gui_application~set_focussed_view.

  ENDMETHOD.


  METHOD if_ish_gui_application~set_vcode.

  ENDMETHOD.


  METHOD if_ish_gui_request_processor~after_request_processing.

  ENDMETHOD.


  METHOD if_ish_gui_request_processor~process_request.

  ENDMETHOD.


  METHOD if_ish_gui_request_sender~get_okcodereq_by_controlev.

  ENDMETHOD.


  METHOD on_mdy_exit.

  ENDMETHOD.


  METHOD on_message_click.

  ENDMETHOD.


  METHOD _adjust_to_layout.

  ENDMETHOD.


  METHOD _after_command_request.

  ENDMETHOD.


  METHOD _after_event_request.

  ENDMETHOD.


  METHOD _after_pai.
  ENDMETHOD.


  METHOD _after_pai_main.

  ENDMETHOD.


  METHOD _after_pbo.
  ENDMETHOD.


  METHOD _after_pbo_main.

  ENDMETHOD.


  METHOD _after_run.

  ENDMETHOD.


  METHOD _are_views_changed.

  ENDMETHOD.


  METHOD _before_command_request.

  ENDMETHOD.


  METHOD _before_event_request.

  ENDMETHOD.


  METHOD _before_pai.
  ENDMETHOD.


  METHOD _before_pai_main.

  ENDMETHOD.


  METHOD _before_pbo.
  ENDMETHOD.


  METHOD _before_pbo_main.

  ENDMETHOD.


  METHOD _before_run.

  ENDMETHOD.


  METHOD _check_save_view_layout.

  ENDMETHOD.


  METHOD _check_views.

  ENDMETHOD.


  METHOD _cmd_exit_by_control_event.

  ENDMETHOD.


  METHOD _collect_exception.

  ENDMETHOD.


  METHOD _collect_messages.

  ENDMETHOD.


  METHOD _collect_message_by_syst.

  ENDMETHOD.


  METHOD _create_messages.

  ENDMETHOD.


  METHOD _create_messages_view.

  ENDMETHOD.


  METHOD _create_run_result.

  ENDMETHOD.


  METHOD _destroy.

  ENDMETHOD.


  METHOD _display_messages.

  ENDMETHOD.


  METHOD _finalize_run_result.

  ENDMETHOD.


  METHOD _get_layointkey.

  ENDMETHOD.


  METHOD _get_messages_view.

  ENDMETHOD.


  METHOD _get_messages_view_title.

  ENDMETHOD.


  METHOD _get_okcodereq_by_controlev.

  ENDMETHOD.


  METHOD _help_request.
  ENDMETHOD.


  METHOD _init_appl.

  ENDMETHOD.


  METHOD _process_command_request.

  ENDMETHOD.


  METHOD _process_control_event.

  ENDMETHOD.


  METHOD _process_dynpro_event.

  ENDMETHOD.


  METHOD _process_event_request.

  ENDMETHOD.


  METHOD _process_exception_event.

  ENDMETHOD.


  METHOD _process_mdy_event.

  ENDMETHOD.


  METHOD _process_message_event.

  ENDMETHOD.


  METHOD _set_vcode.

  ENDMETHOD.


  METHOD _value_request.
  ENDMETHOD.


ENDCLASS.