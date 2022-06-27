*"* components of interface IF_ISH_GUI_TREE_VIEW
INTERFACE if_ish_gui_tree_view
  PUBLIC.


  INTERFACES if_ish_gui_control_view.

  ALIASES co_vcode_display
    FOR if_ish_gui_control_view~co_vcode_display.
  ALIASES co_vcode_insert
    FOR if_ish_gui_control_view~co_vcode_insert.
  ALIASES co_vcode_update
    FOR if_ish_gui_control_view~co_vcode_update.
  ALIASES actualize_layout
    FOR if_ish_gui_control_view~actualize_layout.
  ALIASES destroy
    FOR if_ish_gui_control_view~destroy.
  ALIASES first_display
    FOR if_ish_gui_control_view~first_display.
  ALIASES get_application
    FOR if_ish_gui_control_view~get_application.
  ALIASES get_child_views
    FOR if_ish_gui_control_view~get_child_views.
  ALIASES get_child_view_by_id
    FOR if_ish_gui_control_view~get_child_view_by_id.
  ALIASES get_child_view_by_name
    FOR if_ish_gui_control_view~get_child_view_by_name.
  ALIASES get_control
    FOR if_ish_gui_control_view~get_control.
  ALIASES get_controller
    FOR if_ish_gui_control_view~get_controller.
  ALIASES get_control_layout
    FOR if_ish_gui_control_view~get_control_layout.
  ALIASES get_element_id
    FOR if_ish_gui_control_view~get_element_id.
  ALIASES get_element_name
    FOR if_ish_gui_control_view~get_element_name.
  ALIASES get_layout
    FOR if_ish_gui_control_view~get_layout.
  ALIASES get_parent_view
    FOR if_ish_gui_control_view~get_parent_view.
  ALIASES get_vcode
    FOR if_ish_gui_control_view~get_vcode.
  ALIASES get_visibility
    FOR if_ish_gui_control_view~get_visibility.
  ALIASES has_focus
    FOR if_ish_gui_control_view~has_focus.
  ALIASES is_destroyed
    FOR if_ish_gui_control_view~is_destroyed.
  ALIASES is_first_display_done
    FOR if_ish_gui_control_view~is_first_display_done.
  ALIASES is_initialized
    FOR if_ish_gui_control_view~is_initialized.
  ALIASES is_in_destroy_mode
    FOR if_ish_gui_control_view~is_in_destroy_mode.
  ALIASES is_in_first_display_mode
    FOR if_ish_gui_control_view~is_in_first_display_mode.
  ALIASES is_in_initialization_mode
    FOR if_ish_gui_control_view~is_in_initialization_mode.
  ALIASES process_request
    FOR if_ish_gui_control_view~process_request.
  ALIASES refresh_display
    FOR if_ish_gui_control_view~refresh_display.
  ALIASES register_child_view
    FOR if_ish_gui_control_view~register_child_view.
  ALIASES save_layout
    FOR if_ish_gui_control_view~save_layout.
  ALIASES set_focus
    FOR if_ish_gui_control_view~set_focus.
  ALIASES set_vcode
    FOR if_ish_gui_control_view~set_vcode.
  ALIASES set_visibility
    FOR if_ish_gui_control_view~set_visibility.
  ALIASES ev_after_destroy
    FOR if_ish_gui_control_view~ev_after_destroy.
  ALIASES ev_before_destroy
    FOR if_ish_gui_control_view~ev_before_destroy.
  ALIASES ev_visibility_changed
    FOR if_ish_gui_control_view~ev_visibility_changed.

  METHODS check_model
    IMPORTING
      !ir_model TYPE REF TO if_ish_gui_model
    RETURNING
      VALUE(rt_checked_nkey) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
  METHODS check_models
    IMPORTING
      !it_model TYPE ish_t_gui_model_objhash
    RETURNING
      VALUE(rt_checked_nkey) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
  METHODS check_nkey
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RAISING
      cx_ish_static_handler.
  METHODS check_nkeys
    IMPORTING
      !it_nkey TYPE lvc_t_nkey OPTIONAL
    RETURNING
      VALUE(rt_checked_nkey) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
  METHODS collapse_all_nodes
    RETURNING
      VALUE(rt_nkey_collapsed) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
  METHODS collapse_node
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(r_collapsed) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
  METHODS collapse_nodes
    IMPORTING
      !it_nkey TYPE lvc_t_nkey
    RETURNING
      VALUE(r_collapsed) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
  METHODS deselect_all
    RETURNING
      VALUE(r_deselected) TYPE abap_bool.
  METHODS expand_all_nodes
    RETURNING
      VALUE(rt_nkey_expanded) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
  METHODS expand_node
    IMPORTING
      !i_nkey TYPE lvc_nkey
      !i_level_count TYPE i DEFAULT 1
      !i_expand_subtree TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(r_expanded) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
  METHODS expand_nodes
    IMPORTING
      !it_nkey TYPE lvc_t_nkey
      !i_level_count TYPE i DEFAULT 1
      !i_expand_subtree TYPE abap_bool DEFAULT abap_false
    RETURNING
      VALUE(r_expanded) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
  METHODS get_all_checked_child_models
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rt_model) TYPE ish_t_gui_model_objhash.
  METHODS get_all_checked_child_nkeys
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rt_nkey) TYPE lvc_t_nkey.
  METHODS get_all_child_nkeys
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rt_nkey) TYPE lvc_t_nkey.
  METHODS get_alv_tree
    RETURNING
      VALUE(rr_alv_tree) TYPE REF TO cl_gui_alv_tree.
  METHODS get_alv_tree_toolbar
    RETURNING
      VALUE(rr_toolbar) TYPE REF TO cl_gui_toolbar.
  METHODS get_checked_child_models
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rt_model) TYPE ish_t_gui_model_objhash.
  METHODS get_checked_child_nkeys
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rt_nkey) TYPE lvc_t_nkey.
  METHODS get_checked_models
    RETURNING
      VALUE(rt_model) TYPE ish_t_gui_model_objhash.
  METHODS get_checked_nkeys
    RETURNING
      VALUE(rt_nkey) TYPE lvc_t_nkey.
  METHODS get_checked_parent_model
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rr_parent_model) TYPE REF TO if_ish_gui_model.
  METHODS get_checked_parent_nkey
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(r_parent_nkey) TYPE lvc_nkey.
  METHODS get_child_nkeys
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rt_nkey) TYPE lvc_t_nkey.
  METHODS get_model_by_nkey
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rr_model) TYPE REF TO if_ish_gui_model.
  METHODS get_nkeys_by_model
    IMPORTING
      !ir_model TYPE REF TO if_ish_gui_model
    RETURNING
      VALUE(rt_nkey) TYPE lvc_t_nkey.
  METHODS get_nkey_by_child_model
    IMPORTING
      !i_parent_nkey TYPE lvc_nkey
      !ir_child_model TYPE REF TO if_ish_gui_model
    RETURNING
      VALUE(r_nkey) TYPE lvc_nkey.
  METHODS get_parent_model_by_nkey
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rr_model) TYPE REF TO if_ish_gui_model.
  METHODS get_parent_nkey
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(r_parent_nkey) TYPE lvc_nkey.
  METHODS get_parent_nkeys
    IMPORTING
      !i_child_nkey TYPE lvc_nkey
    RETURNING
      VALUE(rt_parent_nkey) TYPE lvc_t_nkey.
  METHODS get_root_nkeys
    RETURNING
      VALUE(rt_root_nkey) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
  METHODS get_selected_model
    RETURNING
      VALUE(rr_model) TYPE REF TO if_ish_gui_model
    RAISING
      cx_ish_static_handler.
  METHODS get_selected_models
    RETURNING
      VALUE(rt_model) TYPE ish_t_gui_model_objhash.
  METHODS get_selected_nkey
    RETURNING
      VALUE(r_nkey) TYPE lvc_nkey
    RAISING
      cx_ish_static_handler.
  METHODS get_selected_nkeys
    RETURNING
      VALUE(rt_nkey) TYPE lvc_t_nkey.
  METHODS get_tree_layout
    RETURNING
      VALUE(rr_tree_layout) TYPE REF TO cl_ish_gui_tree_layout.
  METHODS has_parent_nkey
    IMPORTING
      !i_child_nkey TYPE lvc_nkey
      !i_parent_nkey TYPE lvc_nkey
    RETURNING
      VALUE(r_has_parent_nkey) TYPE abap_bool.
  METHODS is_nkey_checked
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(r_checked) TYPE abap_bool.
  METHODS set_selected_model
    IMPORTING
      !ir_model TYPE REF TO if_ish_gui_model
    RETURNING
      VALUE(r_selected) TYPE abap_bool.
  METHODS set_selected_models
    IMPORTING
      !it_model TYPE ish_t_gui_model_objhash
    RETURNING
      VALUE(r_selected) TYPE abap_bool.
  METHODS set_selected_nkey
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RETURNING
      VALUE(r_selected) TYPE abap_bool.
  METHODS set_selected_nkeys
    IMPORTING
      !it_nkey TYPE lvc_t_nkey
    RETURNING
      VALUE(r_selected) TYPE abap_bool.
  METHODS uncheck_model
    IMPORTING
      !ir_model TYPE REF TO if_ish_gui_model
    RETURNING
      VALUE(rt_unchecked_nkey) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
  METHODS uncheck_models
    IMPORTING
      !it_model TYPE ish_t_gui_model_objhash
    RETURNING
      VALUE(rt_unchecked_nkey) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
  METHODS uncheck_nkey
    IMPORTING
      !i_nkey TYPE lvc_nkey
    RAISING
      cx_ish_static_handler.
  METHODS uncheck_nkeys
    IMPORTING
      !it_nkey TYPE lvc_t_nkey OPTIONAL
    PREFERRED PARAMETER it_nkey
    RETURNING
      VALUE(rt_unchecked_nkey) TYPE lvc_t_nkey
    RAISING
      cx_ish_static_handler.
ENDINTERFACE.