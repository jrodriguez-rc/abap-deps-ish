*"* components of interface IF_ISH_SNAPSHOT_OBJECT
interface IF_ISH_SNAPSHOT_OBJECT
  public .


  methods SNAPSHOT
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_KEY) type ISH_SNAPKEY .
  methods DESTROY_SNAPSHOT
    importing
      value(I_KEY) type ISH_SNAPKEY
    exporting
      value(E_RC) type ISH_METHOD_RC .
  methods UNDO
    importing
      value(I_KEY) type ISH_SNAPKEY
    exporting
      value(E_RC) type ISH_METHOD_RC .
endinterface.
