*"* components of interface IF_EX_ISH_GUI_B_UCOMM
interface IF_EX_ISH_GUI_B_UCOMM
  public .


  interfaces IF_BADI_INTERFACE .

  type-pools ABAP .
  methods BEFORE_USER_COMMAND
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
      !IR_COMMAND_REQUEST type ref to CL_ISH_GUI_COMMAND_REQUEST
    changing
      !C_NO_FURTHER_PROCESSING type ABAP_BOOL
      !C_EXIT type ABAP_BOOL
      !CR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
