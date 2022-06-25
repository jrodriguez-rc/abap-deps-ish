*"* components of interface IF_EX_N1_CREATE_CONFIG
interface IF_EX_N1_CREATE_CONFIG
  public .


  methods CREATE_CONFIG
    importing
      !I_OBJECT_TYPE type I optional
      !I_CLASS_NAME type STRING optional
      !I_FACTORY_NAME type STRING optional
    exporting
      !ER_CONFIG type ref to IF_ISH_CONFIG
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
