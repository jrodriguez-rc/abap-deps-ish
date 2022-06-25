*"* components of interface IF_EX_ISH_GUI_B_TBEVENT
interface IF_EX_ISH_GUI_B_TBEVENT
  public .


  interfaces IF_BADI_INTERFACE .

  type-pools ABAP .
  methods BEFORE_TOOLBAR_EVENT
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_TOOLBAR_EVENT type ref to CL_ISH_GUI_TOOLBAR_EVENT
      !IR_TOOLBAR_VIEW type ref to IF_ISH_GUI_TOOLBAR_VIEW
    changing
      !C_NO_FURTHER_PROCESSING type ABAP_BOOL
      !C_EXIT type ABAP_BOOL
      !CR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
