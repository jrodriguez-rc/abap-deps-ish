*"* components of interface IF_EX_ISH_GUI_B_DRWEVENT
interface IF_EX_ISH_GUI_B_DRWEVENT
  public .


  interfaces IF_BADI_INTERFACE .

  type-pools ABAP .
  methods BEFORE_DRAWERS_EVENT
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_DRAWERS_EVENT type ref to CL_ISH_GUI_DRAWERS_EVENT
      !IR_DRAWERS_VIEW type ref to IF_ISH_GUI_DRAWERS_VIEW
    changing
      !C_NO_FURTHER_PROCESSING type ABAP_BOOL
      !C_EXIT type ABAP_BOOL
      !CR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
