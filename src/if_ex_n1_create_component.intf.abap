*"* components of interface IF_EX_N1_CREATE_COMPONENT
interface IF_EX_N1_CREATE_COMPONENT
  public .


  methods CREATE_COMPONENT_BASE
    importing
      value(I_OBJECT_TYPE) type I optional
      value(I_CLASS_NAME) type STRING optional
    exporting
      value(ER_COMPONENT_BASE) type ref to IF_ISH_COMPONENT_BASE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
