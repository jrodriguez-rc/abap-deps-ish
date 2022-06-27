*"* components of interface IF_ISH_GUI_CONTROLLER
INTERFACE if_ish_gui_controller
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

  METHODS get_application
    RETURNING
      VALUE(rr_application) TYPE REF TO if_ish_gui_application.
  METHODS get_child_controllers
    IMPORTING
      !i_with_subchildren TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(rt_child_controller) TYPE ish_t_gui_ctrid_hash.
  METHODS get_child_controller_by_id
    IMPORTING
      !i_controller_id TYPE n1gui_element_id
      !i_with_subchildren TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(rr_child_controller) TYPE REF TO if_ish_gui_controller.
  METHODS get_child_controller_by_name
    IMPORTING
      !i_controller_name TYPE n1gui_element_name
    RETURNING
      VALUE(rr_child_controller) TYPE REF TO if_ish_gui_controller.
  METHODS get_main_controller
    RETURNING
      VALUE(rr_main_controller) TYPE REF TO if_ish_gui_main_controller.
  METHODS get_model
    RETURNING
      VALUE(rr_model) TYPE REF TO if_ish_gui_model.
  METHODS get_parent_controller
    RETURNING
      VALUE(rr_parent_controller) TYPE REF TO if_ish_gui_controller.
  METHODS get_vcode
    RETURNING
      VALUE(r_vcode) TYPE tndym-vcode.
  METHODS get_view
    RETURNING
      VALUE(rr_view) TYPE REF TO if_ish_gui_view.
  METHODS is_initialized
    RETURNING
      VALUE(r_initialized) TYPE abap_bool.
  METHODS is_in_initialization_mode
    RETURNING
      VALUE(r_initialization_mode) TYPE abap_bool.
  METHODS register_child_controller
    IMPORTING
      !ir_child_controller TYPE REF TO if_ish_gui_controller
    RAISING
      cx_ish_static_handler.
  METHODS set_vcode
    IMPORTING
      !i_vcode TYPE tndym-vcode
      !i_with_child_controllers TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(r_changed) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
ENDINTERFACE.