INTERFACE if_ishmed_api
  PUBLIC.

  INTERFACES if_ishmed_api_descriptor.
  INTERFACES if_ishmed_api_documentation.

  METHODS get_type
    RETURNING
      VALUE(r_value) TYPE n1api_type.
  METHODS get_version
    RETURNING
      VALUE(r_value) TYPE n1api_version.
ENDINTERFACE.