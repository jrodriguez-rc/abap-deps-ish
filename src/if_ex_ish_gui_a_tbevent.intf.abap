*"* components of interface IF_EX_ISH_GUI_A_TBEVENT
interface IF_EX_ISH_GUI_A_TBEVENT
  public .


  interfaces IF_BADI_INTERFACE .

  type-pools ABAP .
  methods AFTER_TOOLBAR_EVENT
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_TOOLBAR_EVENT type ref to CL_ISH_GUI_TOOLBAR_EVENT
      !IR_TOOLBAR_VIEW type ref to IF_ISH_GUI_TOOLBAR_VIEW
      !IR_RESPONSE type ref to CL_ISH_GUI_RESPONSE optional
    changing
      !C_EXIT type ABAP_BOOL
      !CR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
