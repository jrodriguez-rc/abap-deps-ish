*"* components of interface IF_ISH_IS_OP
interface IF_ISH_IS_OP
  public .


  methods IS_OP
    exporting
      value(E_IS_OP) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
