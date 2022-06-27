*"* components of interface IF_ISH_GUI_REQUEST_SENDER
INTERFACE if_ish_gui_request_sender
  PUBLIC.


  METHODS get_okcodereq_by_controlev
    IMPORTING
      !ir_control_event TYPE REF TO cl_ish_gui_control_event
    RETURNING
      VALUE(rr_okcode_request) TYPE REF TO cl_ish_gui_okcode_request.
ENDINTERFACE.