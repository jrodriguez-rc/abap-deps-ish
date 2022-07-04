INTERFACE if_ish_gui_grid_view
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

  METHODS get_alv_grid
    RETURNING
      VALUE(rr_alv_grid) TYPE REF TO cl_gui_alv_grid.
  METHODS get_grid_layout
    RETURNING
      VALUE(rr_grid_layout) TYPE REF TO cl_ish_gui_grid_layout.
  METHODS get_model_by_idx
    IMPORTING
      !i_idx TYPE lvc_index
    RETURNING
      VALUE(rr_model) TYPE REF TO if_ish_gui_model.
  METHODS get_outtab_row_models
    RETURNING
      VALUE(rt_model) TYPE ish_t_gui_model_objhash.
  METHODS get_row_by_idx
    IMPORTING
      !i_idx TYPE lvc_index
    RETURNING
      VALUE(rr_row) TYPE REF TO data.
  METHODS get_selected_idx
    RETURNING
      VALUE(r_idx) TYPE lvc_index
    RAISING
      cx_ish_static_handler.
  METHODS get_selected_idxs
    RETURNING
      VALUE(rt_idx) TYPE lvc_t_indx.
  METHODS get_selected_model
    RETURNING
      VALUE(rr_model) TYPE REF TO if_ish_gui_model
    RAISING
      cx_ish_static_handler.
  METHODS get_selected_models
    RETURNING
      VALUE(rt_model) TYPE ish_t_gui_model_objhash
    RAISING
      cx_ish_static_handler.
  METHODS set_selected_rows_by_idxs
    IMPORTING
      !it_idx TYPE lvc_t_indx.
  METHODS set_selected_rows_by_models
    IMPORTING
      !it_model TYPE ish_t_gui_model_objhash.
  METHODS set_selected_row_by_idx
    IMPORTING
      !i_idx TYPE lvc_index.
  METHODS set_selected_row_by_model
    IMPORTING
      !ir_model TYPE REF TO if_ish_gui_model.
  METHODS set_selected_cell
    IMPORTING
      !i_row_idx TYPE lvc_index
      !i_col_fieldname TYPE ish_fieldname
    RETURNING
      VALUE(r_selected) TYPE abap_bool.
ENDINTERFACE.