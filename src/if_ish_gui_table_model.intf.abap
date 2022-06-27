INTERFACE if_ish_gui_table_model
  PUBLIC.


  INTERFACES if_ish_gui_model.

  EVENTS ev_entry_added
    EXPORTING
      VALUE(er_entry) TYPE REF TO if_ish_gui_model.
  EVENTS ev_entry_removed
    EXPORTING
      VALUE(er_entry) TYPE REF TO if_ish_gui_model.

  METHODS add_entry
    IMPORTING
      !ir_entry TYPE REF TO if_ish_gui_model
    RETURNING
      VALUE(r_added) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
  METHODS get_entries
    RETURNING
      VALUE(rt_entry) TYPE ish_t_gui_model_objhash
    RAISING
      cx_ish_static_handler.
  METHODS remove_entry
    IMPORTING
      !ir_entry TYPE REF TO if_ish_gui_model
    RETURNING
      VALUE(r_removed) TYPE abap_bool
    RAISING
      cx_ish_static_handler.
ENDINTERFACE.