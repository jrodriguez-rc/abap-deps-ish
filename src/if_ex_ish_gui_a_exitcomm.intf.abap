*"* components of interface IF_EX_ISH_GUI_A_EXITCOMM
interface IF_EX_ISH_GUI_A_EXITCOMM
  public .


  interfaces IF_BADI_INTERFACE .

  type-pools ABAP .
  methods AFTER_EXIT_COMMAND
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_MDY_EVENT type ref to CL_ISH_GUI_MDY_EVENT
      !IR_RESPONSE type ref to CL_ISH_GUI_RESPONSE
    changing
      !C_EXIT type ABAP_BOOL
      !CR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
