*"* components of interface IF_ISH_CONFIG_CANCEL
interface IF_ISH_CONFIG_CANCEL
  public .


  methods ADJUST_MAIN_OBJECTS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !CT_OBJECT type ISH_OBJECTLIST
      !CT_NBEW type ISHMED_T_NBEW .
endinterface.
