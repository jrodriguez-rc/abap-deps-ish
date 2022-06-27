CLASS cl_ish_gm_table DEFINITION
  PUBLIC
  CREATE PROTECTED.

  PUBLIC SECTION.
    INTERFACES if_ish_destroyable.
    INTERFACES if_ish_gui_model.
    INTERFACES if_ish_gui_table_model.
    INTERFACES if_ish_gui_treenode_model.

    ALIASES add_entry FOR if_ish_gui_table_model~add_entry.
    ALIASES destroy FOR if_ish_destroyable~destroy.
    ALIASES get_entries FOR if_ish_gui_table_model~get_entries.
    ALIASES get_node_icon FOR if_ish_gui_treenode_model~get_node_icon.
    ALIASES get_node_text FOR if_ish_gui_treenode_model~get_node_text.
    ALIASES is_destroyed FOR if_ish_destroyable~is_destroyed.
    ALIASES is_in_destroy_mode FOR if_ish_destroyable~is_in_destroy_mode.
    ALIASES remove_entry FOR if_ish_gui_table_model~remove_entry.
    ALIASES ev_after_destroy FOR if_ish_destroyable~ev_after_destroy.
    ALIASES ev_before_destroy FOR if_ish_destroyable~ev_before_destroy.
    ALIASES ev_entry_added FOR if_ish_gui_table_model~ev_entry_added.
    ALIASES ev_entry_removed FOR if_ish_gui_table_model~ev_entry_removed.

    CLASS-METHODS create
      IMPORTING
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !it_entry TYPE ish_t_gui_model_objhash OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      RETURNING
        VALUE(rr_instance) TYPE REF TO cl_ish_gm_table.
    METHODS constructor
      IMPORTING
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !it_entry TYPE ish_t_gui_model_objhash OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      PREFERRED PARAMETER ir_cb_tabmdl.
    METHODS has_entry
      IMPORTING
        !ir_entry TYPE REF TO if_ish_gui_model
      RETURNING
        VALUE(r_has_entry) TYPE abap_bool.
  PROTECTED SECTION.

    DATA gr_cb_destroyable TYPE REF TO if_ish_cb_destroyable.
    DATA gr_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model.
    DATA gt_entry TYPE ish_t_gui_model_objhash.
    DATA g_destroyed TYPE abap_bool.
    DATA g_destroy_mode TYPE abap_bool.
    DATA g_node_icon TYPE tv_image.
    DATA g_node_text TYPE lvc_value.

    METHODS _destroy.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gm_table IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD create.

  ENDMETHOD.


  METHOD has_entry.

  ENDMETHOD.


  METHOD if_ish_destroyable~destroy.

  ENDMETHOD.


  METHOD if_ish_destroyable~is_destroyed.

    r_destroyed = g_destroyed.

  ENDMETHOD.


  METHOD if_ish_destroyable~is_in_destroy_mode.

    r_destroy_mode = g_destroy_mode.

  ENDMETHOD.


  METHOD if_ish_gui_table_model~add_entry.

  ENDMETHOD.


  METHOD if_ish_gui_table_model~get_entries.

  ENDMETHOD.


  METHOD if_ish_gui_table_model~remove_entry.

  ENDMETHOD.


  METHOD if_ish_gui_treenode_model~get_node_icon.

  ENDMETHOD.


  METHOD if_ish_gui_treenode_model~get_node_text.

  ENDMETHOD.


  METHOD _destroy.

  ENDMETHOD.


ENDCLASS.