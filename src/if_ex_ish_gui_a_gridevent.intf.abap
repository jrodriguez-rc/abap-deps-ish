*"* components of interface IF_EX_ISH_GUI_A_GRIDEVENT
interface IF_EX_ISH_GUI_A_GRIDEVENT
  public .


  interfaces IF_BADI_INTERFACE .

  type-pools ABAP .
  methods AFTER_GRID_EVENT
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_GRID_EVENT type ref to CL_ISH_GUI_GRID_EVENT
      !IR_GRID_VIEW type ref to IF_ISH_GUI_GRID_VIEW
      !IR_RESPONSE type ref to CL_ISH_GUI_RESPONSE optional
    changing
      !C_EXIT type ABAP_BOOL
      !CR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
