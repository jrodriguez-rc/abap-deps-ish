*"* components of interface IF_ISH_GUI_DROP_PROCESSOR
interface IF_ISH_GUI_DROP_PROCESSOR
  public .


  methods PROCESS
    importing
      !IR_DRAG_OBJECT type ref to CL_ISH_GUI_DRAG_OBJECT
      !IR_DROP_VIEW type ref to IF_ISH_GUI_VIEW
      !IR_DROP_REQUEST type ref to CL_ISH_GUI_REQUEST
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
