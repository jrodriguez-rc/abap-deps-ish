CLASS cl_ish_gui_view DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_element
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_ish_destroyable.
    INTERFACES if_ish_gui_cb_structure_model.
    INTERFACES if_ish_gui_request_processor.
    INTERFACES if_ish_gui_request_sender.
    INTERFACES if_ish_gui_view.

    ALIASES co_vcode_display FOR if_ish_gui_view~co_vcode_display.
    ALIASES co_vcode_insert FOR if_ish_gui_view~co_vcode_insert.
    ALIASES co_vcode_update FOR if_ish_gui_view~co_vcode_update.
    ALIASES actualize_layout FOR if_ish_gui_view~actualize_layout.
    ALIASES destroy FOR if_ish_gui_view~destroy.
    ALIASES get_alv_variant_report_suffix FOR if_ish_gui_view~get_alv_variant_report_suffix.
    ALIASES get_application FOR if_ish_gui_view~get_application.
    ALIASES get_child_views FOR if_ish_gui_view~get_child_views.
    ALIASES get_child_view_by_id FOR if_ish_gui_view~get_child_view_by_id.
    ALIASES get_child_view_by_name FOR if_ish_gui_view~get_child_view_by_name.
    ALIASES get_controller FOR if_ish_gui_view~get_controller.
    ALIASES get_errorfield_messages FOR if_ish_gui_view~get_errorfield_messages.
    ALIASES get_layout FOR if_ish_gui_view~get_layout.
    ALIASES get_parent_view FOR if_ish_gui_view~get_parent_view.
    ALIASES get_t_errorfield FOR if_ish_gui_view~get_t_errorfield.
    ALIASES get_t_view_errorfields FOR if_ish_gui_view~get_t_view_errorfields.
    ALIASES get_vcode FOR if_ish_gui_view~get_vcode.
    ALIASES has_errorfields FOR if_ish_gui_view~has_errorfields.
    ALIASES has_focus FOR if_ish_gui_view~has_focus.
    ALIASES is_destroyed FOR if_ish_gui_view~is_destroyed.
    ALIASES is_first_display_done FOR if_ish_gui_view~is_first_display_done.
    ALIASES is_initialized FOR if_ish_gui_view~is_initialized.
    ALIASES is_in_destroy_mode FOR if_ish_gui_view~is_in_destroy_mode.
    ALIASES is_in_first_display_mode FOR if_ish_gui_view~is_in_first_display_mode.
    ALIASES is_in_initialization_mode FOR if_ish_gui_view~is_in_initialization_mode.
    ALIASES process_request FOR if_ish_gui_view~process_request.
    ALIASES register_child_view FOR if_ish_gui_view~register_child_view.
    ALIASES save_layout FOR if_ish_gui_view~save_layout.
    ALIASES set_focus FOR if_ish_gui_view~set_focus.
    ALIASES set_vcode FOR if_ish_gui_view~set_vcode.
    ALIASES ev_after_destroy FOR if_ish_gui_view~ev_after_destroy.
    ALIASES ev_before_destroy FOR if_ish_gui_view~ev_before_destroy.

    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
      PREFERRED PARAMETER i_element_name.
  PROTECTED SECTION.
    DATA gr_cb_destroyable TYPE REF TO if_ish_cb_destroyable.
    DATA gr_controller TYPE REF TO if_ish_gui_controller.
    DATA gr_layout TYPE REF TO cl_ish_gui_view_layout.
    DATA gr_parent_view TYPE REF TO if_ish_gui_view.
    DATA gt_child_view TYPE ish_t_gui_viewname_hash.
    DATA gt_errorfield TYPE ishmed_t_gui_errorfield_h.
    DATA g_cb_layout TYPE abap_bool.
    DATA g_destroyed TYPE abap_bool.
    DATA g_destroy_mode TYPE abap_bool.
    DATA g_first_display_done TYPE abap_bool.
    DATA g_first_display_mode TYPE abap_bool.
    DATA g_initialization_mode TYPE abap_bool.
    DATA g_initialized TYPE abap_bool.
    DATA g_vcode TYPE tndym-vcode.

    METHODS on_childview_after_destroy
      FOR EVENT ev_after_destroy OF if_ish_gui_view
      IMPORTING
        !sender.
    METHODS on_childview_before_destroy
      FOR EVENT ev_before_destroy OF if_ish_gui_view
      IMPORTING
        !sender.
    METHODS _add_child_view
      IMPORTING
        !ir_child_view TYPE REF TO if_ish_gui_view
      RAISING
        cx_ish_static_handler.
    METHODS _destroy.
    METHODS _get_errorfield_messages
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_fieldname TYPE ish_fieldname
      RETURNING
        VALUE(rr_messages) TYPE REF TO cl_ishmed_errorhandling.
    METHODS _get_model
      RETURNING
        VALUE(rr_model) TYPE REF TO if_ish_gui_model.
    METHODS _get_okcodereq_by_controlev
      IMPORTING
        !ir_control_event TYPE REF TO cl_ish_gui_control_event
      RETURNING
        VALUE(rr_okcode_request) TYPE REF TO cl_ish_gui_okcode_request.
    METHODS _init_view
      IMPORTING
        !ir_controller TYPE REF TO if_ish_gui_controller
        !ir_parent_view TYPE REF TO if_ish_gui_view OPTIONAL
        !ir_layout TYPE REF TO cl_ish_gui_view_layout OPTIONAL
        !i_vcode TYPE tndym-vcode DEFAULT if_ish_gui_view=>co_vcode_display
      RAISING
        cx_ish_static_handler.
    METHODS _is_pai_in_process
      RETURNING
        VALUE(r_pai_in_process) TYPE abap_bool.
    METHODS _load_layout
      IMPORTING
        !ir_controller TYPE REF TO if_ish_gui_controller
        !ir_parent_view TYPE REF TO if_ish_gui_view
        !i_layout_name TYPE n1gui_layout_name OPTIONAL
        !i_username TYPE username DEFAULT sy-uname
      RETURNING
        VALUE(rr_layout) TYPE REF TO cl_ish_gui_layout.
    METHODS _process_command_request
      IMPORTING
        !ir_command_request TYPE REF TO cl_ish_gui_command_request
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _process_event_request
      IMPORTING
        !ir_event_request TYPE REF TO cl_ish_gui_event_request
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _propagate_exception
      IMPORTING
        !ir_exception TYPE REF TO cx_root
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _propagate_message
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
    METHODS _propagate_messages
      IMPORTING
        !ir_messages TYPE REF TO cl_ishmed_errorhandling
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _propagate_request
      IMPORTING
        !ir_request TYPE REF TO cl_ish_gui_request
      RETURNING
        VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
    METHODS _remove_child_view
      IMPORTING
        !ir_child_view TYPE REF TO if_ish_gui_view
      RETURNING
        VALUE(r_removed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _remove_errorfield
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_fieldname TYPE ish_fieldname
      RETURNING
        VALUE(r_removed) TYPE abap_bool.
    METHODS _set_child_view_vcode
      IMPORTING
        !ir_child_view TYPE REF TO if_ish_gui_view
        !i_vcode TYPE ish_vcode
        !i_with_child_views TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _set_errorfield
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_fieldname TYPE ish_fieldname
        !ir_messages TYPE REF TO cl_ishmed_errorhandling.
    METHODS _set_vcode
      IMPORTING
        !i_vcode TYPE tndym-vcode
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS __get_field_content
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_fieldname TYPE ish_fieldname
      CHANGING
        !c_content TYPE any
      RAISING
        cx_ish_static_handler.
    METHODS __set_field_content
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_content TYPE any
        !i_fieldname TYPE ish_fieldname
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_view IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD if_ish_destroyable~destroy.

  ENDMETHOD.


  METHOD if_ish_destroyable~is_destroyed.

  ENDMETHOD.


  METHOD if_ish_destroyable~is_in_destroy_mode.

  ENDMETHOD.


  METHOD if_ish_gui_cb_structure_model~cb_set_field_content.

  ENDMETHOD.


  METHOD if_ish_gui_request_processor~after_request_processing.

  ENDMETHOD.


  METHOD if_ish_gui_request_processor~process_request.

  ENDMETHOD.


  METHOD if_ish_gui_request_sender~get_okcodereq_by_controlev.

  ENDMETHOD.


  METHOD if_ish_gui_view~actualize_layout.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_alv_variant_report_suffix.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_application.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_child_views.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_child_view_by_id.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_child_view_by_name.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_controller.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_errorfield_messages.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_layout.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_parent_view.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_t_errorfield.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_t_view_errorfields.

  ENDMETHOD.


  METHOD if_ish_gui_view~get_vcode.

  ENDMETHOD.


  METHOD if_ish_gui_view~has_errorfields.
  ENDMETHOD.


  METHOD if_ish_gui_view~has_focus.
  ENDMETHOD.


  METHOD if_ish_gui_view~is_first_display_done.

  ENDMETHOD.


  METHOD if_ish_gui_view~is_initialized.

  ENDMETHOD.


  METHOD if_ish_gui_view~is_in_first_display_mode.

  ENDMETHOD.


  METHOD if_ish_gui_view~is_in_initialization_mode.

  ENDMETHOD.


  METHOD if_ish_gui_view~register_child_view.

  ENDMETHOD.


  METHOD if_ish_gui_view~save_layout.

  ENDMETHOD.


  METHOD if_ish_gui_view~set_focus.

  ENDMETHOD.


  METHOD if_ish_gui_view~set_vcode.

  ENDMETHOD.


  METHOD on_childview_after_destroy.

  ENDMETHOD.


  METHOD on_childview_before_destroy.
  ENDMETHOD.


  METHOD _add_child_view.

  ENDMETHOD.


  METHOD _destroy.

  ENDMETHOD.


  METHOD _get_errorfield_messages.

  ENDMETHOD.


  METHOD _get_model.

  ENDMETHOD.


  METHOD _get_okcodereq_by_controlev.

  ENDMETHOD.


  METHOD _init_view.

  ENDMETHOD.


  METHOD _is_pai_in_process.

  ENDMETHOD.


  METHOD _load_layout.

  ENDMETHOD.


  METHOD _process_command_request.
  ENDMETHOD.


  METHOD _process_event_request.
  ENDMETHOD.


  METHOD _propagate_exception.

  ENDMETHOD.


  METHOD _propagate_message.

  ENDMETHOD.


  METHOD _propagate_messages.

  ENDMETHOD.


  METHOD _propagate_request.

  ENDMETHOD.


  METHOD _remove_child_view.

  ENDMETHOD.


  METHOD _remove_errorfield.

  ENDMETHOD.


  METHOD _set_child_view_vcode.

  ENDMETHOD.


  METHOD _set_errorfield.

  ENDMETHOD.


  METHOD _set_vcode.

  ENDMETHOD.


  METHOD __get_field_content.

  ENDMETHOD.


  METHOD __set_field_content.

  ENDMETHOD.


ENDCLASS.