*"* components of interface IF_ISH_CB_SNAPSHOT_RUN_DATA
interface IF_ISH_CB_SNAPSHOT_RUN_DATA
  public .


  methods CB_SNAPSHOT
    importing
      !IR_RUN_DATA type ref to CL_ISH_RUN_DATA
    exporting
      value(E_CREATE_SNAPSHOT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CB_SNAPSHOT_BEFORE_CHANGE
    importing
      !IR_RUN_DATA type ref to CL_ISH_RUN_DATA
    exporting
      value(E_CREATE_SNAPSHOT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
