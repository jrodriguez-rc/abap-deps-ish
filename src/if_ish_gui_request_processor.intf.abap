*"* components of interface IF_ISH_GUI_REQUEST_PROCESSOR
interface IF_ISH_GUI_REQUEST_PROCESSOR
  public .


  methods AFTER_REQUEST_PROCESSING
    importing
      !IR_REQUEST type ref to CL_ISH_GUI_REQUEST
      !IR_RESPONSE type ref to CL_ISH_GUI_RESPONSE optional .
  methods PROCESS_REQUEST
    importing
      !IR_REQUEST type ref to CL_ISH_GUI_REQUEST
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
endinterface.
