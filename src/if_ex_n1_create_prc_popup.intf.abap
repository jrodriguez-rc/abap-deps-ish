*"* components of interface IF_EX_N1_CREATE_PRC_POPUP
interface IF_EX_N1_CREATE_PRC_POPUP
  public .


  methods CREATE_PRC_POPUP
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      value(I_PRC_OBJECT_TYPE) type I optional
    exporting
      !ER_PRC_POPUP type ref to IF_ISH_PRC_POPUP
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
