*"* components of interface IF_ISH_SNAPSHOTABLE
interface IF_ISH_SNAPSHOTABLE
  public .


  methods CLEAR_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods SNAPSHOT
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNDO
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
