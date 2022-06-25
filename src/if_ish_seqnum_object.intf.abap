*"* components of interface IF_ISH_SEQNUM_OBJECT
interface IF_ISH_SEQNUM_OBJECT
  public .


  methods GET_SEQNUM
    returning
      value(R_SEQNUM) type I .
  type-pools ABAP .
  methods SET_SEQNUM
    importing
      !I_SEQNUM type I
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
