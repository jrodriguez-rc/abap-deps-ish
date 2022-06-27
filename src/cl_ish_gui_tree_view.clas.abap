CLASS cl_ish_gui_tree_view DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_control_view
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_ish_gui_tree_view.

    ALIASES check_model FOR if_ish_gui_tree_view~check_model.
    ALIASES check_models FOR if_ish_gui_tree_view~check_models.
    ALIASES check_nkey FOR if_ish_gui_tree_view~check_nkey.
    ALIASES check_nkeys FOR if_ish_gui_tree_view~check_nkeys.
    ALIASES collapse_all_nodes FOR if_ish_gui_tree_view~collapse_all_nodes.
    ALIASES collapse_node FOR if_ish_gui_tree_view~collapse_node.
    ALIASES collapse_nodes FOR if_ish_gui_tree_view~collapse_nodes.
    ALIASES deselect_all FOR if_ish_gui_tree_view~deselect_all.
    ALIASES expand_all_nodes FOR if_ish_gui_tree_view~expand_all_nodes.
    ALIASES expand_node FOR if_ish_gui_tree_view~expand_node.
    ALIASES expand_nodes FOR if_ish_gui_tree_view~expand_nodes.
    ALIASES get_all_checked_child_models FOR if_ish_gui_tree_view~get_all_checked_child_models.
    ALIASES get_all_checked_child_nkeys FOR if_ish_gui_tree_view~get_all_checked_child_nkeys.
    ALIASES get_all_child_nkeys FOR if_ish_gui_tree_view~get_all_child_nkeys.
    ALIASES get_alv_tree FOR if_ish_gui_tree_view~get_alv_tree.
    ALIASES get_alv_tree_toolbar FOR if_ish_gui_tree_view~get_alv_tree_toolbar.
    ALIASES get_checked_child_models FOR if_ish_gui_tree_view~get_checked_child_models.
    ALIASES get_checked_child_nkeys FOR if_ish_gui_tree_view~get_checked_child_nkeys.
    ALIASES get_checked_models FOR if_ish_gui_tree_view~get_checked_models.
    ALIASES get_checked_nkeys FOR if_ish_gui_tree_view~get_checked_nkeys.
    ALIASES get_checked_parent_model FOR if_ish_gui_tree_view~get_checked_parent_model.
    ALIASES get_checked_parent_nkey FOR if_ish_gui_tree_view~get_checked_parent_nkey.
    ALIASES get_child_nkeys FOR if_ish_gui_tree_view~get_child_nkeys.
    ALIASES get_model_by_nkey FOR if_ish_gui_tree_view~get_model_by_nkey.
    ALIASES get_nkeys_by_model FOR if_ish_gui_tree_view~get_nkeys_by_model.
    ALIASES get_nkey_by_child_model FOR if_ish_gui_tree_view~get_nkey_by_child_model.
    ALIASES get_parent_model_by_nkey FOR if_ish_gui_tree_view~get_parent_model_by_nkey.
    ALIASES get_parent_nkey FOR if_ish_gui_tree_view~get_parent_nkey.
    ALIASES get_parent_nkeys FOR if_ish_gui_tree_view~get_parent_nkeys.
    ALIASES get_root_nkeys FOR if_ish_gui_tree_view~get_root_nkeys.
    ALIASES get_selected_model FOR if_ish_gui_tree_view~get_selected_model.
    ALIASES get_selected_models FOR if_ish_gui_tree_view~get_selected_models.
    ALIASES get_selected_nkey FOR if_ish_gui_tree_view~get_selected_nkey.
    ALIASES get_selected_nkeys FOR if_ish_gui_tree_view~get_selected_nkeys.
    ALIASES get_tree_layout FOR if_ish_gui_tree_view~get_tree_layout.
    ALIASES has_parent_nkey FOR if_ish_gui_tree_view~has_parent_nkey.
    ALIASES is_nkey_checked FOR if_ish_gui_tree_view~is_nkey_checked.
    ALIASES set_selected_model FOR if_ish_gui_tree_view~set_selected_model.
    ALIASES set_selected_models FOR if_ish_gui_tree_view~set_selected_models.
    ALIASES set_selected_nkey FOR if_ish_gui_tree_view~set_selected_nkey.
    ALIASES set_selected_nkeys FOR if_ish_gui_tree_view~set_selected_nkeys.
    ALIASES uncheck_model FOR if_ish_gui_tree_view~uncheck_model.
    ALIASES uncheck_models FOR if_ish_gui_tree_view~uncheck_models.
    ALIASES uncheck_nkey FOR if_ish_gui_tree_view~uncheck_nkey.
    ALIASES uncheck_nkeys FOR if_ish_gui_tree_view~uncheck_nkeys.

    CONSTANTS co_cmdresult_exit TYPE i VALUE '3'. "#EC NOTEXT
    CONSTANTS co_cmdresult_noproc TYPE i VALUE '0'. "#EC NOTEXT
    CONSTANTS co_cmdresult_okcode TYPE i VALUE '2'. "#EC NOTEXT
    CONSTANTS co_cmdresult_processed TYPE i VALUE '1'. "#EC NOTEXT
    CONSTANTS co_fcode_collapse TYPE ui_func VALUE '&COLLAPSE'. "#EC NOTEXT
    CONSTANTS co_fcode_expand TYPE ui_func VALUE '&EXPAND'. "#EC NOTEXT
    CONSTANTS co_fcode_noproc TYPE ui_func VALUE 'NOPROC'. "#EC NOTEXT
    CONSTANTS co_fcode_search TYPE ui_func VALUE '&FIND'. "#EC NOTEXT
    CONSTANTS co_nkey_virtualroot TYPE lvc_nkey VALUE '&VIRTUALROOT'. "#EC NOTEXT

    CLASS-METHODS class_constructor.
    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
      PREFERRED PARAMETER i_element_name.
    METHODS init_tree_view
      IMPORTING
        !ir_controller TYPE REF TO if_ish_gui_controller
        !ir_parent_view TYPE REF TO if_ish_gui_container_view
        !ir_layout TYPE REF TO cl_ish_gui_tree_layout OPTIONAL
        !i_vcode TYPE tndym-vcode DEFAULT if_ish_gui_view=>co_vcode_display
        !i_outtab_structname TYPE tabname
      RAISING
        cx_ish_static_handler.

    METHODS if_ish_gui_view~actualize_layout REDEFINITION.
  PROTECTED SECTION.

    TYPES:
      BEGIN OF gty_nkey,
        nkey            TYPE lvc_nkey,
        parent_nkey     TYPE lvc_nkey,
        r_model         TYPE REF TO if_ish_gui_model,
      END OF gty_nkey.
    TYPES:
      gtyt_nkey  TYPE HASHED TABLE OF gty_nkey WITH UNIQUE KEY nkey.
    TYPES:
      BEGIN OF gty_model,
        r_model  TYPE REF TO if_ish_gui_model,
        t_nkey   TYPE lvc_t_nkey,
      END OF gty_model.
    TYPES:
      gtyt_model  TYPE HASHED TABLE OF gty_model WITH UNIQUE KEY r_model.

    DATA gr_outtab TYPE REF TO data.
    DATA gr_tmp_exphier_move TYPE REF TO cl_ish_gm_structure_simple.
    DATA gr_tmp_model_move TYPE REF TO if_ish_gui_model.
    DATA gt_model TYPE gtyt_model.
    DATA gt_nkey TYPE gtyt_nkey.
    DATA g_on_model_added_deactivated TYPE abap_bool.

    CLASS-METHODS _check_r_outtab
      IMPORTING
        !ir_outtab TYPE REF TO data
      RAISING
        cx_ish_static_handler.
    METHODS on_after_user_command
      FOR EVENT after_user_command OF cl_gui_alv_tree
      IMPORTING
        !ucomm
        !sender.
    METHODS on_before_user_command
      FOR EVENT before_user_command OF cl_gui_alv_tree
      IMPORTING
        !ucomm
        !sender.
    METHODS on_button_click
      FOR EVENT button_click OF cl_gui_alv_tree
      IMPORTING
        !fieldname
        !node_key
        !sender.
    METHODS on_checkbox_change
      FOR EVENT checkbox_change OF cl_gui_alv_tree
      IMPORTING
        !checked
        !fieldname
        !node_key
        !sender.
    METHODS on_drag
      FOR EVENT on_drag OF cl_gui_alv_tree
      IMPORTING
        !drag_drop_object
        !fieldname
        !node_key
        !sender.
    METHODS on_drag_multiple
      FOR EVENT on_drag_multiple OF cl_gui_alv_tree
      IMPORTING
        !drag_drop_object
        !fieldname
        !node_key_table
        !sender.
    METHODS on_drop
      FOR EVENT on_drop OF cl_gui_alv_tree
      IMPORTING
        !drag_drop_object
        !node_key
        !sender.
    METHODS on_dropdown_clicked
      FOR EVENT dropdown_clicked OF cl_gui_toolbar
      IMPORTING
        !fcode
        !posx
        !posy
        !sender.
    METHODS on_expand_nc
      FOR EVENT expand_nc OF cl_gui_alv_tree
      IMPORTING
        !node_key
        !sender.
    METHODS on_function_selected
      FOR EVENT function_selected OF cl_gui_toolbar
      IMPORTING
        !fcode
        !sender.
    METHODS on_hotspot_click
      FOR EVENT link_click OF cl_gui_alv_tree
      IMPORTING
        !fieldname
        !node_key
        !sender.
    METHODS on_item_ctx_request
      FOR EVENT item_context_menu_request OF cl_gui_alv_tree
      IMPORTING
        !fieldname
        !menu
        !node_key
        !sender.
    METHODS on_item_ctx_selected
      FOR EVENT item_context_menu_selected OF cl_gui_alv_tree
      IMPORTING
        !fcode
        !fieldname
        !node_key
        !sender.
    METHODS on_item_double_click
      FOR EVENT item_double_click OF cl_gui_alv_tree
      IMPORTING
        !fieldname
        !node_key
        !sender.
    METHODS on_item_keypress
      FOR EVENT item_keypress OF cl_gui_alv_tree
      IMPORTING
        !fieldname
        !key
        !node_key
        !sender.
    METHODS on_link_click
      FOR EVENT link_click OF cl_gui_alv_tree
      IMPORTING
        !fieldname
        !node_key
        !sender.
    METHODS on_model_added
      FOR EVENT ev_entry_added OF if_ish_gui_table_model
      IMPORTING
        !er_entry
        !sender.
    METHODS on_model_added_adjust
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
    METHODS on_model_removed_adjust
      FOR EVENT ev_entry_removed OF if_ish_gui_table_model
      IMPORTING
        !er_entry
        !sender.
    METHODS on_node_ctx_request
      FOR EVENT node_context_menu_request OF cl_gui_alv_tree
      IMPORTING
        !menu
        !node_key
        !sender.
    METHODS on_node_ctx_selected
      FOR EVENT node_context_menu_selected OF cl_gui_alv_tree
      IMPORTING
        !fcode
        !node_key
        !sender.
    METHODS on_node_double_click
      FOR EVENT node_double_click OF cl_gui_alv_tree
      IMPORTING
        !node_key
        !sender.
    METHODS on_node_keypress
      FOR EVENT node_keypress OF cl_gui_alv_tree
      IMPORTING
        !key
        !node_key
        !sender.
    METHODS _add_fvar_button_to_toolbar
      IMPORTING
        !ir_button TYPE REF TO cl_ish_fvar_button
        !ir_toolbar TYPE REF TO cl_gui_toolbar
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
    METHODS _add_node
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !i_relat_nkey TYPE lvc_nkey OPTIONAL
        !i_relationship TYPE i DEFAULT cl_gui_column_tree=>relat_last_child
        !is_outtab TYPE data
        !is_layn TYPE lvc_s_layn OPTIONAL
        !it_layi TYPE lvc_t_layi OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
      RETURNING
        VALUE(r_nkey) TYPE lvc_nkey
      RAISING
        cx_ish_static_handler.
    METHODS _add_nodes_by_model
      IMPORTING
        !ir_parent_model TYPE REF TO if_ish_gui_model OPTIONAL
        !ir_model TYPE REF TO if_ish_gui_model
        !i_calculate_relationship TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(rt_nkey_added) TYPE lvc_t_nkey
      RAISING
        cx_ish_static_handler.
    METHODS _add_tree_to_flush_buffer
      IMPORTING
        !ir_alv_tree TYPE REF TO cl_gui_alv_tree.
    METHODS _adjust_child_nodes_cbxchg
      IMPORTING
        !i_orig_nkey TYPE lvc_nkey
        !i_nkey TYPE lvc_nkey
        !ir_model TYPE REF TO if_ish_gui_model
        !i_checked TYPE abap_bool
        !i_expand TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _adjust_nodes_to_vcode
      IMPORTING
        !i_old_vcode TYPE ish_vcode
        !i_new_vcode TYPE ish_vcode
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _adjust_parent_node_cbxchg
      IMPORTING
        !i_orig_nkey TYPE lvc_nkey
        !i_nkey TYPE lvc_nkey
        !ir_model TYPE REF TO if_ish_gui_model
        !i_checked TYPE abap_bool
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _build_ctmenu_fvar
      IMPORTING
        !ir_toolbar TYPE REF TO cl_gui_toolbar
        !ir_fvar TYPE REF TO cl_ish_fvar
        !i_fcode TYPE ui_func
      RETURNING
        VALUE(rr_ctmenu) TYPE REF TO cl_ctmenu.
    METHODS _build_ctmenu_own
      IMPORTING
        !ir_toolbar TYPE REF TO cl_gui_toolbar
        !i_fcode TYPE ui_func
      RETURNING
        VALUE(rr_ctmenu) TYPE REF TO cl_ctmenu.
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
    METHODS _build_hierarchy_header
      RETURNING
        VALUE(rs_hierarchy_header) TYPE treev_hhdr
      RAISING
        cx_ish_static_handler.
    METHODS _build_tbmenu_fvar
      IMPORTING
        !ir_toolbar TYPE REF TO cl_gui_toolbar
        !ir_fvar TYPE REF TO cl_ish_fvar
      RAISING
        cx_ish_static_handler.
    METHODS _build_tbmenu_own
      IMPORTING
        !ir_toolbar TYPE REF TO cl_gui_toolbar
      RAISING
        cx_ish_static_handler.
    METHODS _build_toolbar_menu
      IMPORTING
        !ir_toolbar TYPE REF TO cl_gui_toolbar
      RAISING
        cx_ish_static_handler.
    METHODS _build_variant
      EXPORTING
        !es_variant TYPE disvariant
        !e_save TYPE char01.
    METHODS _change_node
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !i_nkey TYPE lvc_nkey
        !is_outtab TYPE data
        !is_lacn TYPE lvc_s_lacn OPTIONAL
        !it_laci TYPE lvc_t_laci OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_text_x TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _change_nodes_by_model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !it_changed_field TYPE ish_t_fieldname OPTIONAL
      RETURNING
        VALUE(rt_nkey_changed) TYPE lvc_t_nkey
      RAISING
        cx_ish_static_handler.
    METHODS _change_node_by_model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_nkey TYPE lvc_nkey
        !it_changed_field TYPE ish_t_fieldname OPTIONAL
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _change_toolbar_menu
      IMPORTING
        !ir_toolbar TYPE REF TO cl_gui_toolbar
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_collapse
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_dropdown_clicked
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
      RETURNING
        VALUE(r_cmdresult) TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_expand
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_node_ctx_request
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
      RETURNING
        VALUE(r_cmdresult) TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_on_drag
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_on_drag_multiple
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
      RAISING
        cx_ish_static_handler.
    METHODS _cmd_on_drop
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
      RAISING
        cx_ish_static_handler.
    METHODS _destroy_dnd.
    METHODS _fill_outtab_line
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !it_changed_field TYPE ish_t_fieldname OPTIONAL
      CHANGING
        !cs_outtab TYPE data
      RAISING
        cx_ish_static_handler.
    METHODS _frontend_update
      IMPORTING
        !i_force TYPE abap_bool DEFAULT abap_false.
    METHODS _get_child_models
      IMPORTING
        !ir_parent_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(rt_child_model) TYPE ish_t_gui_model_objhash
      RAISING
        cx_ish_static_handler.
    METHODS _get_child_nkeys_cbxchg
      IMPORTING
        !i_orig_nkey TYPE lvc_nkey
        !i_nkey TYPE lvc_nkey
        !ir_model TYPE REF TO if_ish_gui_model
        !i_checked TYPE abap_bool
      RETURNING
        VALUE(rt_child_nkey) TYPE lvc_t_nkey
      RAISING
        cx_ish_static_handler.
    METHODS _get_dndid4model
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(r_dndid) TYPE int2
      RAISING
        cx_ish_static_handler.
    METHODS _get_expanded_hierarchy
      IMPORTING
        !i_nkey TYPE lvc_nkey
      RETURNING
        VALUE(rr_hierarchy) TYPE REF TO cl_ish_gm_structure_simple
      RAISING
        cx_ish_static_handler.
    METHODS _get_fcode_buttontype
      IMPORTING
        !i_fcode TYPE ui_func
      RETURNING
        VALUE(r_buttontype) TYPE tb_btype.
    METHODS _get_laci
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !i_nkey TYPE lvc_nkey
        !is_outtab TYPE data
        !it_layi TYPE lvc_t_layi
      RETURNING
        VALUE(rt_laci) TYPE lvc_t_laci
      RAISING
        cx_ish_static_handler.
    METHODS _get_lacn
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !i_nkey TYPE lvc_nkey
        !is_outtab TYPE data
        !is_layn TYPE lvc_s_layn
      RETURNING
        VALUE(rs_lacn) TYPE lvc_s_lacn
      RAISING
        cx_ish_static_handler.
    METHODS _get_layi
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !is_outtab TYPE data
      RETURNING
        VALUE(rt_layi) TYPE lvc_t_layi
      RAISING
        cx_ish_static_handler.
    METHODS _get_layn
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !is_outtab TYPE data
      RETURNING
        VALUE(rs_layn) TYPE lvc_s_layn
      RAISING
        cx_ish_static_handler.
    METHODS _get_main_model
      RETURNING
        VALUE(rr_main_model) TYPE REF TO if_ish_gui_model.
    METHODS _get_model_by_tree_event
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
      RETURNING
        VALUE(rr_model) TYPE REF TO if_ish_gui_model
      RAISING
        cx_ish_static_handler.
    METHODS _get_node_selection_mode
      RETURNING
        VALUE(r_mode) TYPE i.
    METHODS _get_node_text
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model OPTIONAL
        !i_nkey TYPE lvc_nkey OPTIONAL
        !is_outtab TYPE data
      RETURNING
        VALUE(r_node_text) TYPE lvc_value
      RAISING
        cx_ish_static_handler.
    METHODS _get_parent_nkey_cbxchg
      IMPORTING
        !i_orig_nkey TYPE lvc_nkey
        !i_nkey TYPE lvc_nkey
        !ir_model TYPE REF TO if_ish_gui_model
        !i_checked TYPE abap_bool
      RETURNING
        VALUE(r_parent_nkey) TYPE lvc_nkey
      RAISING
        cx_ish_static_handler.
    METHODS _get_relat_4_new_model
      IMPORTING
        !i_parent_nkey TYPE lvc_nkey OPTIONAL
        !ir_model TYPE REF TO if_ish_gui_model
        !i_calculate_relationship TYPE abap_bool DEFAULT abap_true
      EXPORTING
        !e_relat_nkey TYPE lvc_nkey
        !e_relationship TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _get_show_main_model
      RETURNING
        VALUE(r_show_main_model) TYPE abap_bool.
    METHODS _get_startup_expand_level
      RETURNING
        VALUE(r_startup_expand_level) TYPE i.
    METHODS _init_tree_view
      IMPORTING
        !ir_controller TYPE REF TO if_ish_gui_controller
        !ir_parent_view TYPE REF TO if_ish_gui_container_view
        !ir_layout TYPE REF TO cl_ish_gui_tree_layout OPTIONAL
        !i_vcode TYPE tndym-vcode DEFAULT if_ish_gui_view=>co_vcode_display
        !ir_outtab TYPE REF TO data
      RAISING
        cx_ish_static_handler.
    METHODS _is_fcode_disabled
      IMPORTING
        !i_fcode TYPE ui_func
      RETURNING
        VALUE(r_disabled) TYPE abap_bool.
    METHODS _is_fcode_supported
      IMPORTING
        !i_fcode TYPE ui_func
      RETURNING
        VALUE(r_supported) TYPE abap_bool.
    METHODS _is_model_valid
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(r_is_valid) TYPE abap_bool.
    METHODS _load_child_models
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_level_count TYPE i DEFAULT 1
      RETURNING
        VALUE(r_loaded) TYPE abap_bool
      RAISING
        cx_ish_static_handler.
    METHODS _load_or_create_layout
      IMPORTING
        !ir_controller TYPE REF TO if_ish_gui_controller
        !ir_parent_view TYPE REF TO if_ish_gui_view
        !i_layout_name TYPE n1gui_layout_name OPTIONAL
        !i_username TYPE username DEFAULT sy-uname
      RETURNING
        VALUE(rr_layout) TYPE REF TO cl_ish_gui_tree_layout.
    METHODS _on_node_checkbox_change
      IMPORTING
        !i_nkey TYPE lvc_nkey
        !i_fieldname TYPE lvc_fname
        !i_checked TYPE abap_bool
        !i_expand TYPE abap_bool DEFAULT abap_true.
    METHODS _own_cmd
      IMPORTING
        !ir_tree_event TYPE REF TO cl_ish_gui_tree_event
        !ir_orig_request TYPE REF TO cl_ish_gui_request
      RETURNING
        VALUE(r_cmdresult) TYPE i
      RAISING
        cx_ish_static_handler.
    METHODS _prepare_dnd
      RAISING
        cx_ish_static_handler.
    METHODS _register_alv_tree_events
      IMPORTING
        !ir_alv_tree TYPE REF TO cl_gui_alv_tree
      RAISING
        cx_ish_static_handler.
    METHODS _register_model_events
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_activation TYPE abap_bool DEFAULT abap_true.
    METHODS _register_structmdl_events
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_activation TYPE abap_bool DEFAULT abap_true.
    METHODS _register_tabmdl_events
      IMPORTING
        !ir_model TYPE REF TO if_ish_gui_model
        !i_activation TYPE abap_bool DEFAULT abap_true.
    METHODS _register_toolbar_events
      IMPORTING
        !ir_toolbar TYPE REF TO cl_gui_toolbar
      RAISING
        cx_ish_static_handler.
    METHODS _remove_node
      IMPORTING
        !i_nkey TYPE lvc_nkey
      RETURNING
        VALUE(rt_nkey_removed) TYPE lvc_t_nkey
      RAISING
        cx_ish_static_handler.
    METHODS _remove_nodes_by_model
      IMPORTING
        !ir_parent_model TYPE REF TO if_ish_gui_model OPTIONAL
        !ir_model TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(rt_nkey_removed) TYPE lvc_t_nkey
      RAISING
        cx_ish_static_handler.
    METHODS _set_expanded_hierarchy
      IMPORTING
        !i_nkey TYPE lvc_nkey
        !ir_hierarchy TYPE REF TO cl_ish_gm_structure_simple
      RAISING
        cx_ish_static_handler.
    METHODS _set_table_for_first_display
      RAISING
        cx_ish_static_handler.
    METHODS __get_entries
      IMPORTING
        !ir_tabmdl TYPE REF TO if_ish_gui_table_model
      RETURNING
        VALUE(rt_child_model) TYPE ish_t_gui_model_objhash
      RAISING
        cx_ish_static_handler.
    METHODS __on_node_checkbox_change
      IMPORTING
        !i_orig_nkey TYPE lvc_nkey
        !i_nkey TYPE lvc_nkey
        !ir_model TYPE REF TO if_ish_gui_model
        !i_checked TYPE abap_bool
        !i_adjust_parent_node TYPE abap_bool
        !i_adjust_child_nodes TYPE abap_bool
        !i_expand TYPE abap_bool DEFAULT abap_true
        !i_adjust_from_parent TYPE abap_bool DEFAULT abap_false
        !i_adjust_from_child TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.

    METHODS _create_control REDEFINITION.
    METHODS _destroy REDEFINITION.
    METHODS _first_display REDEFINITION.
    METHODS _process_command_request REDEFINITION.
    METHODS _process_event_request REDEFINITION.
    METHODS _refresh_display REDEFINITION.
    METHODS _set_vcode REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_tree_view IMPLEMENTATION.


  METHOD class_constructor.

  ENDMETHOD.


  METHOD constructor.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~check_model.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~check_models.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~check_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~check_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~collapse_all_nodes.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~collapse_node.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~collapse_nodes.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~deselect_all.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~expand_all_nodes.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~expand_node.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~expand_nodes.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_all_checked_child_models.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_all_checked_child_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_all_child_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_alv_tree.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_alv_tree_toolbar.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_checked_child_models.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_checked_child_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_checked_models.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_checked_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_checked_parent_model.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_checked_parent_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_child_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_model_by_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_nkeys_by_model.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_nkey_by_child_model.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_parent_model_by_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_parent_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_parent_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_root_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_selected_model.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_selected_models.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_selected_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_selected_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~get_tree_layout.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~has_parent_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~is_nkey_checked.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~set_selected_model.
  ENDMETHOD.


  METHOD if_ish_gui_tree_view~set_selected_models.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~set_selected_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~set_selected_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~uncheck_model.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~uncheck_models.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~uncheck_nkey.

  ENDMETHOD.


  METHOD if_ish_gui_tree_view~uncheck_nkeys.

  ENDMETHOD.


  METHOD if_ish_gui_view~actualize_layout.

  ENDMETHOD.


  METHOD init_tree_view.

  ENDMETHOD.


  METHOD on_after_user_command.

  ENDMETHOD.


  METHOD on_before_user_command.

  ENDMETHOD.


  METHOD on_button_click.

  ENDMETHOD.


  METHOD on_checkbox_change.

  ENDMETHOD.


  METHOD on_drag.

  ENDMETHOD.


  METHOD on_drag_multiple.

  ENDMETHOD.


  METHOD on_drop.

  ENDMETHOD.


  METHOD on_dropdown_clicked.

  ENDMETHOD.


  METHOD on_expand_nc.

  ENDMETHOD.


  METHOD on_function_selected.

  ENDMETHOD.


  METHOD on_hotspot_click.

  ENDMETHOD.


  METHOD on_item_ctx_request.

  ENDMETHOD.


  METHOD on_item_ctx_selected.

  ENDMETHOD.


  METHOD on_item_double_click.

  ENDMETHOD.


  METHOD on_item_keypress.
  ENDMETHOD.


  METHOD on_link_click.

  ENDMETHOD.


  METHOD on_model_added.

  ENDMETHOD.


  METHOD on_model_added_adjust.

  ENDMETHOD.


  METHOD on_model_changed.

  ENDMETHOD.


  METHOD on_model_removed.

  ENDMETHOD.


  METHOD on_model_removed_adjust.

  ENDMETHOD.


  METHOD on_node_ctx_request.

  ENDMETHOD.


  METHOD on_node_ctx_selected.

  ENDMETHOD.


  METHOD on_node_double_click.

  ENDMETHOD.


  METHOD on_node_keypress.
  ENDMETHOD.


  METHOD _add_fvar_button_to_toolbar.

  ENDMETHOD.


  METHOD _add_fvar_function_to_ctmenu.
  ENDMETHOD.


  METHOD _add_node.

  ENDMETHOD.


  METHOD _add_nodes_by_model.

  ENDMETHOD.


  METHOD _add_tree_to_flush_buffer.

  ENDMETHOD.


  METHOD _adjust_child_nodes_cbxchg.

  ENDMETHOD.


  METHOD _adjust_nodes_to_vcode.

  ENDMETHOD.


  METHOD _adjust_parent_node_cbxchg.

  ENDMETHOD.


  METHOD _build_ctmenu_fvar.

  ENDMETHOD.


  METHOD _build_ctmenu_own.
  ENDMETHOD.


  METHOD _build_excluding_functions.

  ENDMETHOD.


  METHOD _build_fcat.

  ENDMETHOD.


  METHOD _build_hierarchy_header.

  ENDMETHOD.


  METHOD _build_tbmenu_fvar.

  ENDMETHOD.


  METHOD _build_tbmenu_own.

  ENDMETHOD.


  METHOD _build_toolbar_menu.

  ENDMETHOD.


  METHOD _build_variant.

  ENDMETHOD.


  METHOD _change_node.

  ENDMETHOD.


  METHOD _change_nodes_by_model.

  ENDMETHOD.


  METHOD _change_node_by_model.

  ENDMETHOD.


  METHOD _change_toolbar_menu.

  ENDMETHOD.


  METHOD _check_r_outtab.

  ENDMETHOD.


  METHOD _cmd_collapse.

  ENDMETHOD.


  METHOD _cmd_dropdown_clicked.

  ENDMETHOD.


  METHOD _cmd_expand.

  ENDMETHOD.


  METHOD _cmd_node_ctx_request.

  ENDMETHOD.


  METHOD _cmd_on_drag.

  ENDMETHOD.


  METHOD _cmd_on_drag_multiple.

  ENDMETHOD.


  METHOD _cmd_on_drop.

  ENDMETHOD.


  METHOD _create_control.

  ENDMETHOD.


  METHOD _destroy.

  ENDMETHOD.


  METHOD _destroy_dnd.
  ENDMETHOD.


  METHOD _fill_outtab_line.

  ENDMETHOD.


  METHOD _first_display.

  ENDMETHOD.


  METHOD _frontend_update.

  ENDMETHOD.


  METHOD _get_child_models.

  ENDMETHOD.


  METHOD _get_child_nkeys_cbxchg.
  ENDMETHOD.


  METHOD _get_dndid4model.
  ENDMETHOD.


  METHOD _get_expanded_hierarchy.

  ENDMETHOD.


  METHOD _get_fcode_buttontype.

  ENDMETHOD.


  METHOD _get_laci.
  ENDMETHOD.


  METHOD _get_lacn.

  ENDMETHOD.


  METHOD _get_layi.
  ENDMETHOD.


  METHOD _get_layn.

  ENDMETHOD.


  METHOD _get_main_model.

  ENDMETHOD.


  METHOD _get_model_by_tree_event.

  ENDMETHOD.


  METHOD _get_node_selection_mode.

  ENDMETHOD.


  METHOD _get_node_text.

  ENDMETHOD.


  METHOD _get_parent_nkey_cbxchg.

  ENDMETHOD.


  METHOD _get_relat_4_new_model.

  ENDMETHOD.


  METHOD _get_show_main_model.

  ENDMETHOD.


  METHOD _get_startup_expand_level.

  ENDMETHOD.


  METHOD _init_tree_view.

  ENDMETHOD.


  METHOD _is_fcode_disabled.

  ENDMETHOD.


  METHOD _is_fcode_supported.

  ENDMETHOD.


  METHOD _is_model_valid.

  ENDMETHOD.


  METHOD _load_child_models.

  ENDMETHOD.


  METHOD _load_or_create_layout.

  ENDMETHOD.


  METHOD _on_node_checkbox_change.

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


  METHOD _register_alv_tree_events.

  ENDMETHOD.


  METHOD _register_model_events.

  ENDMETHOD.


  METHOD _register_structmdl_events.

  ENDMETHOD.


  METHOD _register_tabmdl_events.

  ENDMETHOD.


  METHOD _register_toolbar_events.

  ENDMETHOD.


  METHOD _remove_node.

  ENDMETHOD.


  METHOD _remove_nodes_by_model.

  ENDMETHOD.


  METHOD _set_expanded_hierarchy.

  ENDMETHOD.


  METHOD _set_table_for_first_display.

  ENDMETHOD.


  METHOD _set_vcode.

  ENDMETHOD.


  METHOD __get_entries.

  ENDMETHOD.


  METHOD __on_node_checkbox_change.

  ENDMETHOD.


ENDCLASS.