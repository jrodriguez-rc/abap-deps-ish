*"* components of interface IF_ISH_GUI_STRUCTURE_MODEL
INTERFACE if_ish_gui_structure_model
  PUBLIC.


  INTERFACES if_ish_gui_model.

  EVENTS ev_changed
    EXPORTING
      VALUE(et_changed_field) TYPE ish_t_fieldname OPTIONAL.

  METHODS get_field_content
    IMPORTING
      !i_fieldname TYPE ish_fieldname
    CHANGING
      !c_content TYPE any
    RAISING
      cx_ish_static_handler.
  METHODS get_supported_fields
    RETURNING
      VALUE(rt_supported_fieldname) TYPE ish_t_fieldname.
  METHODS is_field_supported
    IMPORTING
      !i_fieldname TYPE ish_fieldname
    RETURNING
      VALUE(r_supported) TYPE abap_bool.
  METHODS set_field_content
    IMPORTING
      !i_fieldname TYPE ish_fieldname
      !i_content TYPE any
    RETURNING
      VALUE(r_changed) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
ENDINTERFACE.