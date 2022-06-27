INTERFACE if_ish_gui_element
  PUBLIC.


  METHODS get_element_id
    RETURNING
      VALUE(r_element_id) TYPE n1gui_element_id.
  METHODS get_element_name
    RETURNING
      VALUE(r_element_name) TYPE n1gui_element_name.
ENDINTERFACE.