CLASS cl_ish_gm_table_simple DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gm_table
  CREATE PROTECTED.

  PUBLIC SECTION.

    CLASS-METHODS create_by_structdescr
      IMPORTING
        !ir_structdescr TYPE REF TO cl_abap_structdescr
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      RETURNING
        VALUE(rr_instance) TYPE REF TO cl_ish_gm_table_simple
      RAISING
        cx_ish_static_handler.
    CLASS-METHODS create_by_structname
      IMPORTING
        !i_structname TYPE tabname
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      RETURNING
        VALUE(rr_instance) TYPE REF TO cl_ish_gm_table_simple
      RAISING
        cx_ish_static_handler.
    CLASS-METHODS create_by_structure
      IMPORTING
        !is_data TYPE data
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      RETURNING
        VALUE(rr_instance) TYPE REF TO cl_ish_gm_table_simple
      RAISING
        cx_ish_static_handler.
    CLASS-METHODS create_by_table
      IMPORTING
        !it_table TYPE table
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      RETURNING
        VALUE(rr_instance) TYPE REF TO cl_ish_gm_table_simple
      RAISING
        cx_ish_static_handler.
    CLASS-METHODS create_by_tabledescr
      IMPORTING
        !ir_tabledescr TYPE REF TO cl_abap_tabledescr
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      RETURNING
        VALUE(rr_instance) TYPE REF TO cl_ish_gm_table_simple
      RAISING
        cx_ish_static_handler.
    CLASS-METHODS create_by_tabname
      IMPORTING
        !i_tabname TYPE tabname
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      RETURNING
        VALUE(rr_instance) TYPE REF TO cl_ish_gm_table_simple
      RAISING
        cx_ish_static_handler.
    METHODS add_entry_by_data
      IMPORTING
        !is_data TYPE data
      RETURNING
        VALUE(rr_entry) TYPE REF TO if_ish_gui_model
      RAISING
        cx_ish_static_handler.
    METHODS constructor
      IMPORTING
        !ir_structdescr TYPE REF TO cl_abap_structdescr
        !ir_cb_tabmdl TYPE REF TO if_ish_gui_cb_table_model OPTIONAL
        !ir_cb_destroyable TYPE REF TO if_ish_cb_destroyable OPTIONAL
        !i_node_text TYPE lvc_value OPTIONAL
        !i_node_icon TYPE tv_image OPTIONAL
      RAISING
        cx_ish_static_handler.
  PROTECTED SECTION.
    METHODS _create_entry_by_data
      IMPORTING
        !is_data TYPE data
      RETURNING
        VALUE(rr_entry) TYPE REF TO if_ish_gui_model
      RAISING
        cx_ish_static_handler.
  PRIVATE SECTION.

ENDCLASS.



CLASS cl_ish_gm_table_simple IMPLEMENTATION.


  METHOD add_entry_by_data.

  ENDMETHOD.


  METHOD constructor.

  ENDMETHOD.


  METHOD create_by_structdescr.

  ENDMETHOD.


  METHOD create_by_structname.

  ENDMETHOD.


  METHOD create_by_structure.

  ENDMETHOD.


  METHOD create_by_table.

  ENDMETHOD.


  METHOD create_by_tabledescr.

  ENDMETHOD.


  METHOD create_by_tabname.

  ENDMETHOD.


  METHOD _create_entry_by_data.

  ENDMETHOD.


ENDCLASS.