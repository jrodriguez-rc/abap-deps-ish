CLASS cl_ish_gui_layout DEFINITION
  PUBLIC
  INHERITING FROM cl_ish_gui_element
  ABSTRACT
  CREATE PUBLIC.

*"* public components of class CL_ISH_GUI_LAYOUT
*"* do not include other source files here!!!
  PUBLIC SECTION.

    INTERFACES if_ish_gui_model.
    INTERFACES if_ish_gui_structure_model.
    INTERFACES if_serializable_object.

    ALIASES get_field_content FOR if_ish_gui_structure_model~get_field_content.
    ALIASES get_supported_fields FOR if_ish_gui_structure_model~get_supported_fields.
    ALIASES is_field_supported FOR if_ish_gui_structure_model~is_field_supported.
    ALIASES set_field_content FOR if_ish_gui_structure_model~set_field_content.
    ALIASES ev_changed FOR if_ish_gui_structure_model~ev_changed.

    CONSTANTS co_clrc_cancelled TYPE n1gui_config_layout_rc VALUE 1. "#EC NOTEXT
    CONSTANTS co_clrc_confirmed TYPE n1gui_config_layout_rc VALUE 2. "#EC NOTEXT
    CONSTANTS co_clrc_noproc TYPE n1gui_config_layout_rc VALUE 0. "#EC NOTEXT
    CONSTANTS co_clrc_saved TYPE n1gui_config_layout_rc VALUE 3. "#EC NOTEXT
    CONSTANTS co_def_config_ctrname TYPE n1gui_element_name VALUE 'LAYOUT_CONFIG_CTR'. "#EC NOTEXT
    CONSTANTS co_fieldname_layout_name TYPE ish_fieldname VALUE 'LAYOUT_NAME'. "#EC NOTEXT
    CONSTANTS co_fieldname_was_loaded TYPE ish_fieldname VALUE 'WAS_LOADED'. "#EC NOTEXT
    CONSTANTS co_layofunc_display TYPE n1gui_layout_function VALUE 1. "#EC NOTEXT
    CONSTANTS co_layofunc_edit TYPE n1gui_layout_function VALUE 2. "#EC NOTEXT
    CONSTANTS co_layofunc_none TYPE n1gui_layout_function VALUE 0. "#EC NOTEXT
    CONSTANTS co_layofunc_save_default TYPE n1gui_layout_function VALUE 8. "#EC NOTEXT
    CONSTANTS co_layofunc_save_userspecific TYPE n1gui_layout_function VALUE 4. "#EC NOTEXT
    CONSTANTS co_relid_layout TYPE indx_relid VALUE 'GL'. "#EC NOTEXT

    CLASS-METHODS load
      IMPORTING
        !i_layout_name TYPE n1gui_layout_name
        !i_username TYPE username DEFAULT sy-uname
        !i_internal_key TYPE n1guilayointkey OPTIONAL
      RETURNING
        VALUE(rr_layout) TYPE REF TO cl_ish_gui_layout
      RAISING
        cx_ish_static_handler.
    METHODS constructor
      IMPORTING
        !i_element_name TYPE n1gui_element_name OPTIONAL
        !i_layout_name TYPE n1gui_layout_name OPTIONAL
      PREFERRED PARAMETER i_element_name.
    METHODS get_copy
      RETURNING
        VALUE(rr_copy) TYPE REF TO cl_ish_gui_layout
      RAISING
        cx_ish_static_handler.
    METHODS get_layout_name
      RETURNING
        VALUE(r_layout_name) TYPE n1gui_layout_name.
    METHODS new_config_ctr
      IMPORTING
        !i_ctrname TYPE n1gui_element_name DEFAULT co_def_config_ctrname
        !i_viewname TYPE n1gui_element_name
        !ir_parent_controller TYPE REF TO if_ish_gui_controller
        !i_vcode TYPE ish_vcode DEFAULT if_ish_gui_view=>co_vcode_display
        !ir_layout TYPE REF TO cl_ish_gui_dynpro_layout OPTIONAL
        !it_layout_vcode TYPE ish_t_gui_dynplay_vcode_h OPTIONAL
      RETURNING
        VALUE(rr_config_ctr) TYPE REF TO if_ish_gui_controller
      RAISING
        cx_ish_static_handler.
    METHODS save
      IMPORTING
        !i_username TYPE username DEFAULT sy-uname
        !i_internal_key TYPE n1guilayointkey OPTIONAL
        !i_erdat TYPE ri_erdat DEFAULT sy-datum
        !i_ertim TYPE ri_ertim DEFAULT sy-uzeit
        !i_erusr TYPE ri_ernam DEFAULT sy-uname
      RAISING
        cx_ish_static_handler.
    METHODS was_loaded
      RETURNING
        VALUE(r_was_loaded) TYPE abap_bool.
    METHODS __get_layout_elemid FINAL
      RETURNING
        VALUE(r_layout_elemid) TYPE n1gui_element_id.
    METHODS __get_layout_elemname FINAL
      RETURNING
        VALUE(r_layout_elemname) TYPE n1gui_element_name.
  PROTECTED SECTION.

    DATA g_was_loaded TYPE abap_bool.

    METHODS _get_cb_structure_model
      RETURNING
        VALUE(rr_cb_structure_model) TYPE REF TO if_ish_gui_cb_structure_model.
    METHODS _get_dataref_by_fieldname
      IMPORTING
        !i_fieldname TYPE ish_fieldname
      RETURNING
        VALUE(rr_data) TYPE REF TO data.
    METHODS _get_relid
      RETURNING
        VALUE(r_relid) TYPE indx_relid.
    METHODS _get_t_dataref
      RETURNING
        VALUE(rt_dataref) TYPE ish_t_dataref.
  PRIVATE SECTION.
ENDCLASS.



CLASS cl_ish_gui_layout IMPLEMENTATION.


  METHOD load.

  ENDMETHOD.

  METHOD constructor.

  ENDMETHOD.


  METHOD get_copy.

  ENDMETHOD.


  METHOD get_layout_name.

  ENDMETHOD.


  METHOD if_ish_gui_structure_model~get_field_content.

  ENDMETHOD.


  METHOD if_ish_gui_structure_model~get_supported_fields.

  ENDMETHOD.


  METHOD if_ish_gui_structure_model~is_field_supported.

  ENDMETHOD.


  METHOD if_ish_gui_structure_model~set_field_content.
  ENDMETHOD.


  METHOD new_config_ctr.

  ENDMETHOD.


  METHOD save.

  ENDMETHOD.


  METHOD was_loaded.

  ENDMETHOD.


  METHOD _get_cb_structure_model.
  ENDMETHOD.


  METHOD _get_dataref_by_fieldname.

  ENDMETHOD.


  METHOD _get_relid.

  ENDMETHOD.


  METHOD _get_t_dataref.
  ENDMETHOD.


  METHOD __get_layout_elemid.

  ENDMETHOD.


  METHOD __get_layout_elemname.

  ENDMETHOD.


ENDCLASS.