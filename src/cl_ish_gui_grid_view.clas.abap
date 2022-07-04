CLASS cl_ish_gui_grid_view DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_control_view
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_ish_gui_grid_view.

    ALIASES get_alv_grid FOR if_ish_gui_grid_view~get_alv_grid.
    ALIASES get_grid_layout FOR if_ish_gui_grid_view~get_grid_layout.
    ALIASES get_model_by_idx FOR if_ish_gui_grid_view~get_model_by_idx.
    ALIASES get_outtab_row_models FOR if_ish_gui_grid_view~get_outtab_row_models.
    ALIASES get_row_by_idx FOR if_ish_gui_grid_view~get_row_by_idx.
    ALIASES get_selected_idx FOR if_ish_gui_grid_view~get_selected_idx.
    ALIASES get_selected_idxs FOR if_ish_gui_grid_view~get_selected_idxs.
    ALIASES get_selected_model FOR if_ish_gui_grid_view~get_selected_model.
    ALIASES get_selected_models FOR if_ish_gui_grid_view~get_selected_models.
    ALIASES set_selected_cell FOR if_ish_gui_grid_view~set_selected_cell.
    ALIASES set_selected_rows_by_idxs FOR if_ish_gui_grid_view~set_selected_rows_by_idxs.
    ALIASES set_selected_rows_by_models FOR if_ish_gui_grid_view~set_selected_rows_by_models.
    ALIASES set_selected_row_by_idx FOR if_ish_gui_grid_view~set_selected_row_by_idx.
    ALIASES set_selected_row_by_model FOR if_ish_gui_grid_view~set_selected_row_by_model.

    CONSTANTS co_cmdresult_exit TYPE i VALUE '3'. "#EC NOTEXT
    CONSTANTS co_cmdresult_noproc TYPE i VALUE '0'. "#EC NOTEXT
    CONSTANTS co_cmdresult_okcode TYPE i VALUE '2'. "#EC NOTEXT
    CONSTANTS co_cmdresult_processed TYPE i VALUE '1'. "#EC NOTEXT
    CONSTANTS co_def_fieldname_cellstyle TYPE ish_fieldname VALUE 'CELLSTYLE'. "#EC NOTEXT
    CONSTANTS co_def_fieldname_r_model TYPE ish_fieldname VALUE 'R_MODEL'. "#EC NOTEXT

    CLASS-METHODS class_constructor.
    CLASS-METHODS sbuild_default_exclfuncs
      RETURNING
        VALUE(rt_exclfunc) TYPE ui_functions.
    CLASS-METHODS sbuild_default_fcat
      IMPORTING
        !i_outtab_structname TYPE tabname
      RETURNING
        VALUE(rt_fcat) TYPE lvc_t_fcat
      RAISING
        cx_ish_static_handler.
    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
      PREFERRED PARAMETER i_element_name.
  PROTECTED SECTION.
    DATA gr_outtab TYPE REF TO data.
    DATA gr_tmp_model_dcf TYPE REF TO if_ish_gui_model.
    DATA gt_dral_hash TYPE ish_t_gui_dral_hash.
    DATA gt_good_cells TYPE lvc_t_modi.
    DATA gt_tmp_model_dcf TYPE ish_t_gui_model_objhash.
    DATA g_fieldname_cellstyle TYPE ish_fieldname.
    DATA g_fieldname_r_model TYPE ish_fieldname.
    DATA g_tmp_fieldname_dcf TYPE ish_fieldname.

    CLASS-METHODS _add_grid_to_flush_buffer
      IMPORTING
        !ir_alv_grid TYPE REF TO cl_gui_alv_grid
        !i_stable_row TYPE abap_bool DEFAULT abap_true
        !i_stable_col TYPE abap_bool DEFAULT abap_true
        !i_soft_refresh TYPE abap_bool DEFAULT abap_true.
    CLASS-METHODS _check_r_outtab
      IMPORTING
        !ir_outtab TYPE REF TO data
      RAISING
        cx_ish_static_handler.
    METHODS on_after_user_command
      FOR EVENT after_user_command OF cl_gui_alv_grid
      IMPORTING
        !e_ucomm
        !e_saved
        !e_not_processed
        !sender.
    METHODS on_before_user_command
      FOR EVENT before_user_command OF cl_gui_alv_grid
      IMPORTING
        !e_ucomm
        !sender.
    METHODS on_button_click
      FOR EVENT button_click OF cl_gui_alv_grid
      IMPORTING
        !es_col_id
        !es_row_no
        !sender.
    METHODS on_data_changed
      FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        !er_data_changed
        !e_onf4
        !e_onf4_after
        !e_onf4_before
        !e_ucomm
        !sender.
    METHODS on_data_changed_finished
      FOR EVENT data_changed_finished OF cl_gui_alv_grid
      IMPORTING
        !e_modified
        !et_good_cells
        !sender.
    METHODS on_double_click
      FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
        !e_row
        !e_column
        !es_row_no
        !sender.
    METHODS on_drag
      FOR EVENT ondrag OF cl_gui_alv_grid
      IMPORTING
        !es_row_no
        !e_column
        !e_dragdropobj
        !e_row.
    METHODS on_drop
      FOR EVENT ondrop OF cl_gui_alv_grid
      IMPORTING
        !es_row_no
        !e_column
        !e_dragdropobj
        !e_row.
    METHODS on_drop_complete
      FOR EVENT ondropcomplete OF cl_gui_alv_grid
      IMPORTING
        !es_row_no
        !e_column
        !e_dragdropobj
        !e_row.
    METHODS on_hotspot_click
      FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING
        !e_row_id
        !e_column_id
        !es_row_no
        !sender.
    METHODS on_menu_button
      FOR EVENT menu_button OF cl_gui_alv_grid
      IMPORTING
        !e_object
        !e_ucomm
        !sender.
    METHODS on_model_added
      FOR EVENT ev_entry_added OF if_ish_gui_table_model
      IMPORTING
        !er_entry
        !sender.
    METHODS on_model_changed
      FOR EVENT ev_changed OF if_ish_gui_structure_model
      IMPORTING
        !et_changed_field
        !sender.
    METHODS on_model_removed
      FOR EVENT ev_entry_removed OF if_ish_gui_table_model
      IMPORTING
        !er_entry
        !sender.
    METHODS on_toolbar
      FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        !e_object
        !e_interactive
        !sender.
    METHODS on_user_command
      FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        !e_ucomm
        !sender.
    METHODS _add_fvar_button_to_toolbar
      IMPORTING
        !ir_button TYPE REF TO cl_ish_fvar_button
        !ir_toolbar_set TYPE REF TO cl_alv_event_toolbar_set
      RETURNING
        VALUE(r_added) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _add_fvar_function_to_ctmenu
      IMPORTING
        !ir_ctmenu TYPE REF TO cl_ctmenu
        !ir_function TYPE REF TO cl_ish_fvar_function
      RETURNING
        VALUE(r_added) TYPE abap_bool.
    METHODS _add_row
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !ir_row TYPE REF TO data
        !i_idx TYPE i OPTIONAL
      RETURNING
        VALUE(r_idx) TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _add_row_by_model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_idx TYPE i OPTIONAL
      RETURNING
        VALUE(r_idx) TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _build_ctmenu_fvar
      IMPORTING
        !ir_ctmenu TYPE REF TO cl_ctmenu
        !ir_fvar TYPE REF TO cl_ish_fvar
        !i_fcode TYPE ui_func.
    METHODS _build_ctmenu_own
      IMPORTING
        !ir_ctmenu TYPE REF TO cl_ctmenu
        !i_fcode TYPE ui_func.
    METHODS _build_excluding_functions
      RETURNING
        VALUE(rt_exclfunc) TYPE ui_functions
      RAISING
        cx_ish_static_handler.
    METHODS _build_fcat
      RETURNING
        VALUE(rt_fcat) TYPE lvc_t_fcat
      RAISING
        cx_ish_static_handler.
    METHODS _build_filter
      RETURNING
        VALUE(rt_filter) TYPE lvc_t_filt.
    METHODS _build_layout
      RETURNING
        VALUE(rs_layo) TYPE lvc_s_layo.
    METHODS _build_outtab
      RAISING
        cx_ish_static_handler.
    METHODS _build_sort
      RETURNING
        VALUE(rt_sort) TYPE lvc_t_sort.
    METHODS _build_tbmenu_fvar
      IMPORTING
        !ir_toolbar_set TYPE REF TO cl_alv_event_toolbar_set
        !ir_fvar TYPE REF TO cl_ish_fvar
      RAISING
        cx_ish_static_handler.
    METHODS _build_tbmenu_own
      IMPORTING
        !ir_toolbar_set TYPE REF TO cl_alv_event_toolbar_set
      RAISING
        cx_ish_static_handler.
    METHODS _build_toolbar_menu
      IMPORTING
        !ir_toolbar_set TYPE REF TO cl_alv_event_toolbar_set
      RAISING
        cx_ish_static_handler.
    METHODS _build_variant
      EXPORTING
        !es_variant TYPE disvariant
        !e_save TYPE char01.
    METHODS _change_row_by_model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !it_changed_field TYPE ish_t_fieldname OPTIONAL
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _clear_dral_values
      IMPORTING
        !i_handle TYPE int4.
    METHODS _cmd_on_drag
      IMPORTING
        !ir_grid_event TYPE REF TO cl_ish_gui_grid_event
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_on_drop
      IMPORTING
        !ir_grid_event TYPE REF TO cl_ish_gui_grid_event
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_on_drop_complete
      IMPORTING
        !ir_grid_event TYPE REF TO cl_ish_gui_grid_event
      RAISING
        cx_ish_static_handler.
    METHODS _deregister_eventhandlers.
    METHODS _destroy_dnd.
    METHODS _disable_cell
      IMPORTING
        !ir_row TYPE REF TO data
        !i_fieldname TYPE ish_fieldname
        VALUE(i_disable_f4) TYPE ish_on_off DEFAULT space.
    METHODS _disable_cell_f4
      IMPORTING
        !ir_row TYPE REF TO data
        !i_fieldname TYPE ish_fieldname.
    METHODS _disable_row
      IMPORTING
        !ir_row TYPE REF TO data.
    METHODS _enable_cell
      IMPORTING
        !ir_row TYPE REF TO data
        !i_fieldname TYPE ish_fieldname.
    METHODS _enable_cell_f4
      IMPORTING
        !ir_row TYPE REF TO data
        !i_fieldname TYPE ish_fieldname.
    METHODS _enable_row
      IMPORTING
        !ir_row TYPE REF TO data.
    METHODS _fill_row
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !it_changed_field TYPE ish_t_fieldname OPTIONAL
        !ir_row TYPE REF TO data
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _get_dral_key
      IMPORTING
        !i_handle TYPE int4
        !i_value TYPE char128
      RETURNING
        VALUE(r_key) TYPE char128.
    METHODS _get_dral_value
      IMPORTING
        !i_handle TYPE int4
        !i_key TYPE char128
      RETURNING
        VALUE(r_value) TYPE char128.
    METHODS _get_dral_values
      IMPORTING
        !i_handle TYPE int4
      RETURNING
        VALUE(rt_values) TYPE ish_t_gui_dral_values.
    METHODS _get_fcode_buttontype
      IMPORTING
        !i_fcode TYPE ui_func
      RETURNING
        VALUE(r_buttontype) TYPE tb_btype.
    METHODS _get_idx_4_new_model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(r_idx) TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _get_idx_by_model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(r_idx) TYPE lvc_index.
    METHODS _get_idx_by_row
      IMPORTING
        !ir_row TYPE REF TO data
      RETURNING
        VALUE(r_idx) TYPE lvc_index.
    METHODS _get_main_model
      RETURNING
        VALUE(rr_main_model) TYPE REF TO if_ish_gui_model.
    METHODS _get_model_by_row
      IMPORTING
        !ir_row TYPE REF TO data
      RETURNING
        VALUE(rr_model) TYPE REF TO if_ish_gui_model.
    METHODS _get_rowcol_by_message
      IMPORTING
        !is_message TYPE rn1message
      EXPORTING
        !e_row_idx TYPE lvc_index
        !e_col_fieldname TYPE ish_fieldname.
    METHODS _get_row_by_idx
      IMPORTING
        !i_idx TYPE lvc_index
      RETURNING
        VALUE(rr_row) TYPE REF TO data.
    METHODS _get_row_by_model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(rr_row) TYPE REF TO data.
    METHODS _get_row_models
      RETURNING
        VALUE(rt_row_model) TYPE ish_t_gui_model_objhash
      RAISING
        cx_ish_static_handler.
    METHODS _init_grid_view
      IMPORTING
        !ir_controller TYPE REF TO if_ish_gui_controller
        !ir_parent_view TYPE REF TO if_ish_gui_container_view
        !ir_layout TYPE REF TO cl_ish_gui_grid_layout OPTIONAL
        !i_vcode TYPE tndym-vcode DEFAULT if_ish_gui_view=>co_vcode_display
        !ir_outtab TYPE REF TO data
        !i_fieldname_r_model TYPE ish_fieldname DEFAULT co_def_fieldname_r_model
        !i_fieldname_cellstyle TYPE ish_fieldname DEFAULT co_def_fieldname_cellstyle
      RAISING
        cx_ish_static_handler.
    METHODS _is_fcode_disabled
      IMPORTING
        !i_fcode TYPE ui_func
      RETURNING
        VALUE(r_disabled) TYPE abap_bool.
    METHODS _is_model_valid
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(r_valid) TYPE abap_bool.
    METHODS _load_or_create_layout
      IMPORTING
        !ir_controller TYPE REF TO if_ish_gui_controller
        !ir_parent_view TYPE REF TO if_ish_gui_view
        !i_layout_name TYPE n1gui_layout_name OPTIONAL
        !i_username TYPE username DEFAULT sy-uname
      RETURNING
        VALUE(rr_layout) TYPE REF TO cl_ish_gui_grid_layout.
    METHODS _own_cmd
      IMPORTING
        !ir_grid_event TYPE REF TO cl_ish_gui_grid_event
        !ir_orig_request TYPE REF TO cl_ish_gui_request
      RETURNING
        VALUE(r_cmdresult) TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _prepare_dnd
      RAISING
        cx_ish_static_handler.
    METHODS _refresh_table_display
      IMPORTING
        !i_stable_row TYPE abap_bool DEFAULT abap_true
        !i_stable_col TYPE abap_bool DEFAULT abap_true
        !i_soft_refresh TYPE abap_bool DEFAULT abap_false
        !i_force TYPE abap_bool DEFAULT abap_false.
    METHODS _register_alv_grid_events
      IMPORTING
        !ir_alv_grid TYPE REF TO cl_gui_alv_grid
        !i_activation TYPE abap_bool DEFAULT abap_true
      RAISING
        cx_ish_static_handler.
    METHODS _register_model_eventhandlers
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_activation TYPE abap_bool DEFAULT abap_true.
    METHODS _remove_row_by_model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(r_idx_removed) TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _replace_model
      IMPORTING
        !ir_old_model TYPE REF TO if_ish_gui_model
        !ir_new_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _set_cursor_at_refresh_display
      RETURNING
        VALUE(r_cursor_set) TYPE abap_bool.
    METHODS _set_dral_values
      IMPORTING
        !i_handle TYPE int4
        !it_values TYPE ish_t_gui_dral_values.

    METHODS on_dispatch REDEFINITION.
    METHODS _create_control REDEFINITION.
    METHODS _destroy REDEFINITION.
    METHODS _first_display REDEFINITION.
    METHODS _process_command_request REDEFINITION.
    METHODS _process_event_request REDEFINITION.
    METHODS _refresh_display REDEFINITION.
    METHODS _set_vcode REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_grid_view IMPLEMENTATION.


  METHOD class_constructor.

  ENDMETHOD.


  METHOD constructor.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_alv_grid.
  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_grid_layout.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_model_by_idx.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_outtab_row_models.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_row_by_idx.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_selected_idx.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_selected_idxs.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_selected_model.
  ENDMETHOD.


  METHOD if_ish_gui_grid_view~get_selected_models.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~set_selected_cell.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~set_selected_rows_by_idxs.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~set_selected_row_by_idx.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~set_selected_rows_by_models.

  ENDMETHOD.


  METHOD if_ish_gui_grid_view~set_selected_row_by_model.

  ENDMETHOD.


  METHOD on_after_user_command.

  ENDMETHOD.


  METHOD on_before_user_command.

  ENDMETHOD.


  METHOD on_button_click.

  ENDMETHOD.


  METHOD on_data_changed.

  ENDMETHOD.


  METHOD on_data_changed_finished.

  ENDMETHOD.


  METHOD on_dispatch.

  ENDMETHOD.


  METHOD on_double_click.

  ENDMETHOD.


  METHOD on_drag.

  ENDMETHOD.


  METHOD on_drop.

  ENDMETHOD.


  METHOD on_drop_complete.

  ENDMETHOD.


  METHOD on_hotspot_click.

  ENDMETHOD.


  METHOD on_menu_button.

  ENDMETHOD.


  METHOD on_model_added.

  ENDMETHOD.


  METHOD on_model_changed.

  ENDMETHOD.


  METHOD on_model_removed.

  ENDMETHOD.


  METHOD on_toolbar.

  ENDMETHOD.


  METHOD on_user_command.

  ENDMETHOD.


  METHOD sbuild_default_exclfuncs.

  ENDMETHOD.


  METHOD sbuild_default_fcat.

  ENDMETHOD.


  METHOD _add_fvar_button_to_toolbar.

  ENDMETHOD.


  METHOD _add_fvar_function_to_ctmenu.

  ENDMETHOD.


  METHOD _add_grid_to_flush_buffer.

  ENDMETHOD.


  METHOD _add_row.

  ENDMETHOD.


  METHOD _add_row_by_model.
  ENDMETHOD.


  METHOD _build_ctmenu_fvar.
  ENDMETHOD.


  METHOD _build_ctmenu_own.

  ENDMETHOD.


  METHOD _build_excluding_functions.

  ENDMETHOD.


  METHOD _build_fcat.

  ENDMETHOD.


  METHOD _build_filter.

  ENDMETHOD.


  METHOD _build_layout.

  ENDMETHOD.


  METHOD _build_outtab.

  ENDMETHOD.


  METHOD _build_sort.

  ENDMETHOD.


  METHOD _build_tbmenu_fvar.

  ENDMETHOD.


  METHOD _build_tbmenu_own.

  ENDMETHOD.


  METHOD _build_toolbar_menu.

  ENDMETHOD.


  METHOD _build_variant.

  ENDMETHOD.


  METHOD _change_row_by_model.

  ENDMETHOD.


  METHOD _check_r_outtab.

  ENDMETHOD.


  METHOD _clear_dral_values.

  ENDMETHOD.


  METHOD _cmd_on_drag.
  ENDMETHOD.


  METHOD _cmd_on_drop.
  ENDMETHOD.


  METHOD _cmd_on_drop_complete.

  ENDMETHOD.


  METHOD _create_control.
  ENDMETHOD.


  METHOD _deregister_eventhandlers.

  ENDMETHOD.


  METHOD _destroy.

  ENDMETHOD.


  METHOD _destroy_dnd.
  ENDMETHOD.


  METHOD _disable_cell.

  ENDMETHOD.


  METHOD _disable_cell_f4.

  ENDMETHOD.


  METHOD _disable_row.

  ENDMETHOD.


  METHOD _enable_cell.
  ENDMETHOD.


  METHOD _enable_cell_f4.
  ENDMETHOD.


  METHOD _enable_row.
  ENDMETHOD.


  METHOD _fill_row.
  ENDMETHOD.


  METHOD _first_display.

  ENDMETHOD.


  METHOD _get_dral_key.

  ENDMETHOD.


  METHOD _get_dral_value.

  ENDMETHOD.


  METHOD _get_dral_values.

  ENDMETHOD.


  METHOD _get_fcode_buttontype.

  ENDMETHOD.


  METHOD _get_idx_4_new_model.

  ENDMETHOD.


  METHOD _get_idx_by_model.

  ENDMETHOD.


  METHOD _get_idx_by_row.

  ENDMETHOD.


  METHOD _get_main_model.

  ENDMETHOD.


  METHOD _get_model_by_row.

  ENDMETHOD.


  METHOD _get_rowcol_by_message.

  ENDMETHOD.


  METHOD _get_row_by_idx.

  ENDMETHOD.


  METHOD _get_row_by_model.

  ENDMETHOD.


  METHOD _get_row_models.

  ENDMETHOD.


  METHOD _init_grid_view.

  ENDMETHOD.


  METHOD _is_fcode_disabled.

  ENDMETHOD.


  METHOD _is_model_valid.

  ENDMETHOD.


  METHOD _load_or_create_layout.

  ENDMETHOD.


  METHOD _own_cmd.

  ENDMETHOD.


  METHOD _prepare_dnd.
  ENDMETHOD.


  METHOD _process_command_request.

  ENDMETHOD.


  METHOD _process_event_request.

  ENDMETHOD.


  METHOD _refresh_display.

  ENDMETHOD.


  METHOD _refresh_table_display.

  ENDMETHOD.


  METHOD _register_alv_grid_events.

  ENDMETHOD.


  METHOD _register_model_eventhandlers.

  ENDMETHOD.


  METHOD _remove_row_by_model.
  ENDMETHOD.


  METHOD _replace_model.
  ENDMETHOD.


  METHOD _set_cursor_at_refresh_display.
  ENDMETHOD.


  METHOD _set_dral_values.
  ENDMETHOD.


  METHOD _set_vcode.

  ENDMETHOD.
ENDCLASS.