INTERFACE if_ish_gui_control_view
  PUBLIC.

  INTERFACES if_ish_gui_view.

  ALIASES co_vcode_display
    FOR if_ish_gui_view~co_vcode_display.
  ALIASES co_vcode_insert
    FOR if_ish_gui_view~co_vcode_insert.
  ALIASES co_vcode_update
    FOR if_ish_gui_view~co_vcode_update.
  ALIASES actualize_layout
    FOR if_ish_gui_view~actualize_layout.
  ALIASES destroy
    FOR if_ish_gui_view~destroy.
  ALIASES get_application
    FOR if_ish_gui_view~get_application.
  ALIASES get_child_views
    FOR if_ish_gui_view~get_child_views.
  ALIASES get_child_view_by_id
    FOR if_ish_gui_view~get_child_view_by_id.
  ALIASES get_child_view_by_name
    FOR if_ish_gui_view~get_child_view_by_name.
  ALIASES get_controller
    FOR if_ish_gui_view~get_controller.
  ALIASES get_element_id
    FOR if_ish_gui_view~get_element_id.
  ALIASES get_element_name
    FOR if_ish_gui_view~get_element_name.
  ALIASES get_layout
    FOR if_ish_gui_view~get_layout.
  ALIASES get_parent_view
    FOR if_ish_gui_view~get_parent_view.
  ALIASES get_vcode
    FOR if_ish_gui_view~get_vcode.
  ALIASES has_focus
    FOR if_ish_gui_view~has_focus.
  ALIASES is_destroyed
    FOR if_ish_gui_view~is_destroyed.
  ALIASES is_first_display_done
    FOR if_ish_gui_view~is_first_display_done.
  ALIASES is_initialized
    FOR if_ish_gui_view~is_initialized.
  ALIASES is_in_destroy_mode
    FOR if_ish_gui_view~is_in_destroy_mode.
  ALIASES is_in_first_display_mode
    FOR if_ish_gui_view~is_in_first_display_mode.
  ALIASES is_in_initialization_mode
    FOR if_ish_gui_view~is_in_initialization_mode.
  ALIASES process_request
    FOR if_ish_gui_view~process_request.
  ALIASES register_child_view
    FOR if_ish_gui_view~register_child_view.
  ALIASES save_layout
    FOR if_ish_gui_view~save_layout.
  ALIASES set_focus
    FOR if_ish_gui_view~set_focus.
  ALIASES set_vcode
    FOR if_ish_gui_view~set_vcode.
  ALIASES ev_after_destroy
    FOR if_ish_gui_view~ev_after_destroy.
  ALIASES ev_before_destroy
    FOR if_ish_gui_view~ev_before_destroy.

  EVENTS ev_visibility_changed
    EXPORTING
      VALUE(e_visible) TYPE abap_bool.

  METHODS first_display
    IMPORTING
      !i_with_child_views TYPE abap_bool DEFAULT abap_false
    RAISING
      cx_ish_static_handler.
  METHODS get_control
    RETURNING
      VALUE(rr_control) TYPE REF TO cl_gui_control.
  METHODS get_control_layout
    RETURNING
      VALUE(rr_control_layout) TYPE REF TO cl_ish_gui_control_layout.
  METHODS get_visibility
    RETURNING
      VALUE(r_visible) TYPE abap_bool.
  METHODS refresh_display
    IMPORTING
      !i_force TYPE abap_bool DEFAULT abap_false
      !i_with_child_views TYPE abap_bool DEFAULT abap_false
    PREFERRED PARAMETER i_force
    RAISING
      cx_ish_static_handler.
  METHODS set_visibility
    IMPORTING
      !i_visible TYPE abap_bool DEFAULT abap_true
    RETURNING
      VALUE(r_changed) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
ENDINTERFACE.