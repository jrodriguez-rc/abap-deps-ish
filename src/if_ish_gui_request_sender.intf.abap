*"* components of interface IF_ISH_GUI_REQUEST_SENDER
interface IF_ISH_GUI_REQUEST_SENDER
  public .


  methods GET_OKCODEREQ_BY_CONTROLEV
    importing
      !IR_CONTROL_EVENT type ref to CL_ISH_GUI_CONTROL_EVENT
    returning
      value(RR_OKCODE_REQUEST) type ref to CL_ISH_GUI_OKCODE_REQUEST .
endinterface.
