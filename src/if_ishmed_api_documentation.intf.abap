INTERFACE if_ishmed_api_documentation
  PUBLIC.

  METHODS get
    EXPORTING
      !e_id TYPE doku_id
      !e_object TYPE doku_obj.
  METHODS get_description
    RETURNING
      VALUE(r_value) TYPE n1api_description.
  METHODS get_program
    EXPORTING
      !et_value TYPE programt.
ENDINTERFACE.