INTERFACE if_ish_gui_view
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

  CONSTANTS co_vcode_display TYPE tndym-vcode VALUE 'DIS'. "#EC NOTEXT
  CONSTANTS co_vcode_insert TYPE tndym-vcode VALUE 'INS'. "#EC NOTEXT
  CONSTANTS co_vcode_update TYPE tndym-vcode VALUE 'UPD'. "#EC NOTEXT

  METHODS actualize_layout
    RAISING
      cx_ish_static_handler.
  METHODS get_alv_variant_report_suffix
    RETURNING
      VALUE(r_suffix) TYPE string.
  METHODS get_application
    RETURNING
      VALUE(rr_application) TYPE REF TO if_ish_gui_application.
  METHODS get_child_views
    IMPORTING
      !i_with_subchildren TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(rt_child_view) TYPE ish_t_gui_viewid_hash.
  METHODS get_child_view_by_id
    IMPORTING
      !i_view_id TYPE n1gui_element_id
      !i_with_subchildren TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(rr_child_view) TYPE REF TO if_ish_gui_view.
  METHODS get_child_view_by_name
    IMPORTING
      !i_view_name TYPE n1gui_element_name
    RETURNING
      VALUE(rr_child_view) TYPE REF TO if_ish_gui_view.
  METHODS get_controller
    RETURNING
      VALUE(rr_controller) TYPE REF TO if_ish_gui_controller.
  METHODS get_errorfield_messages
    IMPORTING
      !i_with_child_views TYPE abap_bool DEFAULT abap_false
      !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
      !i_fieldname TYPE ish_fieldname OPTIONAL
    PREFERRED PARAMETER ir_model
    RETURNING
      VALUE(rr_messages) TYPE REF TO cl_ishmed_errorhandling.
  METHODS get_layout
    RETURNING
      VALUE(rr_layout) TYPE REF TO cl_ish_gui_view_layout.
  METHODS get_parent_view
    RETURNING
      VALUE(rr_parent_view) TYPE REF TO if_ish_gui_view.
  METHODS get_t_errorfield
    IMPORTING
      !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
      !i_fieldname TYPE ish_fieldname OPTIONAL
    RETURNING
      VALUE(rt_errorfield) TYPE ishmed_t_gui_errorfield_h.
  METHODS get_t_view_errorfields
    IMPORTING
      !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
      !i_fieldname TYPE ish_fieldname OPTIONAL
    RETURNING
      VALUE(rt_view_errorfields) TYPE ishmed_t_gv_errorfields_h.
  METHODS get_vcode
    RETURNING
      VALUE(r_vcode) TYPE tndym-vcode.
  METHODS has_errorfields
    IMPORTING
      !i_with_child_views TYPE abap_bool DEFAULT abap_false
      !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
      !i_fieldname TYPE ish_fieldname OPTIONAL
    PREFERRED PARAMETER ir_model
    RETURNING
      VALUE(r_has_errorfields) TYPE abap_bool.
  METHODS has_focus
    RETURNING
      VALUE(r_has_focus) TYPE abap_bool.
  METHODS is_first_display_done
    RETURNING
      VALUE(r_done) TYPE abap_bool.
  METHODS is_initialized
    RETURNING
      VALUE(r_initialized) TYPE abap_bool.
  METHODS is_in_first_display_mode
    RETURNING
      VALUE(r_first_display_mode) TYPE abap_bool.
  METHODS is_in_initialization_mode
    RETURNING
      VALUE(r_initialization_mode) TYPE abap_bool.
  METHODS register_child_view
    IMPORTING
      !ir_child_view TYPE REF TO if_ish_gui_view
    RAISING
      cx_ish_static_handler.
  METHODS save_layout
    IMPORTING
      !i_username TYPE username DEFAULT sy-uname
      !i_erdat TYPE ri_erdat DEFAULT sy-datum
      !i_ertim TYPE ri_ertim DEFAULT sy-uzeit
      !i_erusr TYPE ri_ernam DEFAULT sy-uname
    RETURNING
      VALUE(r_saved) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
  METHODS set_focus
    RETURNING
      VALUE(r_success) TYPE abap_bool.
  METHODS set_vcode
    IMPORTING
      !i_vcode TYPE tndym-vcode
      !i_with_child_views TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(r_changed) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
ENDINTERFACE.