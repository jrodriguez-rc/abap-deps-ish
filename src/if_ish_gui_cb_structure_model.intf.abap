*"* components of interface IF_ISH_GUI_CB_STRUCTURE_MODEL
INTERFACE if_ish_gui_cb_structure_model
  PUBLIC.

  METHODS cb_set_field_content
    IMPORTING
      !ir_model TYPE REF TO if_ish_gui_structure_model
      !i_fieldname TYPE ish_fieldname
      !i_content TYPE any
    RETURNING
      VALUE(r_continue) TYPE abap_bool
    RAISING
      cx_ish_static_handler.

ENDINTERFACE.