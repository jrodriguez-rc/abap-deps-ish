*"* components of interface IF_ISH_CHANGEDOCUMENT
interface IF_ISH_CHANGEDOCUMENT
  public .


  methods GET_CHANGEDOCUMENT
    importing
      !IR_CONFIG type ref to IF_ISH_CONFIG optional
    exporting
      value(ET_CDOC) type ISH_T_CDOC
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
