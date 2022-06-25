*"* components of interface IF_ISH_POPUP_CALLBACK
interface IF_ISH_POPUP_CALLBACK
  public .


  methods CHECK
    importing
      value(IR_PRC_POPUP) type ref to IF_ISH_PRC_POPUP
      value(IR_SCREEN) type ref to IF_ISH_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_CHANGES
    importing
      value(IR_PRC_POPUP) type ref to IF_ISH_PRC_POPUP
      value(IR_SCREEN) type ref to IF_ISH_SCREEN
    exporting
      value(E_CHANGED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods EXIT_COMMAND
    importing
      value(IR_PRC_POPUP) type ref to IF_ISH_PRC_POPUP
    exporting
      value(E_EXIT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_FROM_SCREEN
    importing
      value(IR_PRC_POPUP) type ref to IF_ISH_PRC_POPUP
      value(IR_SCREEN) type ref to IF_ISH_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_TO_SCREEN
    importing
      value(IR_PRC_POPUP) type ref to IF_ISH_PRC_POPUP
      value(IR_SCREEN) type ref to IF_ISH_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods USER_COMMAND
    importing
      value(IR_PRC_POPUP) type ref to IF_ISH_PRC_POPUP
    exporting
      value(E_EXIT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_OKCODE) type SY-UCOMM
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
