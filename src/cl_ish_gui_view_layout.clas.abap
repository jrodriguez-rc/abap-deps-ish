CLASS cl_ish_gui_view_layout DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_layout
  ABSTRACT
  CREATE PUBLIC.

*"* public components of class CL_ISH_GUI_VIEW_LAYOUT
*"* do not include other source files here!!!
  PUBLIC SECTION.

    CONSTANTS co_fieldname_r_view TYPE ish_fieldname VALUE 'R_VIEW'. "#EC NOTEXT
    CONSTANTS co_relid_view TYPE indx_relid VALUE 'GV'. "#EC NOTEXT

    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !i_layout_name TYPE n1gui_layout_name OPTIONAL
      PREFERRED PARAMETER i_element_name.
    METHODS get_view FINAL
      RETURNING
        VALUE(rr_view) TYPE REF TO if_ish_gui_view.
    METHODS set_view
      IMPORTING
        !ir_view TYPE REF TO if_ish_gui_view
      RETURNING
        VALUE(r_changed) TYPE abap_bool
      RAISING
        cx_ish_static_handler.

    METHODS get_copy REDEFINITION.
    METHODS if_ish_gui_structure_model~get_field_content REDEFINITION.
    METHODS if_ish_gui_structure_model~get_supported_fields REDEFINITION.
    METHODS if_ish_gui_structure_model~set_field_content REDEFINITION.
    METHODS save REDEFINITION.
  PROTECTED SECTION.
    METHODS _get_cb_structure_model REDEFINITION.
    METHODS _get_relid REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_view_layout IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD get_copy.

  ENDMETHOD.


  METHOD get_view.

  ENDMETHOD.


  METHOD if_ish_gui_structure_model~get_field_content.

  ENDMETHOD.


  METHOD if_ish_gui_structure_model~get_supported_fields.

  ENDMETHOD.


  METHOD if_ish_gui_structure_model~set_field_content.

  ENDMETHOD.


  METHOD save.

  ENDMETHOD.


  METHOD set_view.

  ENDMETHOD.


  METHOD _get_cb_structure_model.

  ENDMETHOD.


  METHOD _get_relid.

  ENDMETHOD.
ENDCLASS.