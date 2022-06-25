*"* components of interface IF_EX_N1_CREATE_COMPCON
interface IF_EX_N1_CREATE_COMPCON
  public .


  methods CREATE_COMPCON
    importing
      !IR_COMPONENT type ref to IF_ISH_COMPONENT_BASE
      value(I_OBJECT_TYPE) type I optional
    exporting
      !ER_COMPCON type ref to IF_ISH_COMPONENT_CONFIG
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
