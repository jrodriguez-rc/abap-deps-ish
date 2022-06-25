*"* components of interface IF_EX_N1_CREATE_SCREEN
interface IF_EX_N1_CREATE_SCREEN
  public .


  methods CREATE_SCREEN
    importing
      value(I_CLASS_NAME) type STRING optional
      value(I_FACTORY_NAME) type STRING optional
      value(I_OBJECT_TYPE) type I
    exporting
      !ER_SCREEN type ref to IF_ISH_SCREEN
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
