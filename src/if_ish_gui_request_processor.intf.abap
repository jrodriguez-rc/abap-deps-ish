INTERFACE if_ish_gui_request_processor
  PUBLIC.


  METHODS after_request_processing
    IMPORTING
      !ir_request TYPE REF TO cl_ish_gui_request
      !ir_response TYPE REF TO cl_ish_gui_response OPTIONAL.
  METHODS process_request
    IMPORTING
      !ir_request TYPE REF TO cl_ish_gui_request
    RETURNING
      VALUE(rr_response) TYPE REF TO cl_ish_gui_response.
ENDINTERFACE.