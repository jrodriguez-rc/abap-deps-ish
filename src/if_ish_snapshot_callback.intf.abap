*"* components of interface IF_ISH_SNAPSHOT_CALLBACK
interface IF_ISH_SNAPSHOT_CALLBACK
  public .


  methods CREATE_SNAPSHOT_OBJECT
    exporting
      !ER_SNAPOBJ type ref to CL_ISH_SNAPSHOT
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods UNDO_SNAPSHOT_OBJECT
    importing
      !IR_SNAPOBJ type ref to CL_ISH_SNAPSHOT
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
