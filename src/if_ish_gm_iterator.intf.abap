*"* components of interface IF_ISH_GM_ITERATOR
interface IF_ISH_GM_ITERATOR
  public .


  type-pools ABAP .
  methods HAS_NEXT
    returning
      value(R_HAS_NEXT) type ABAP_BOOL .
  methods NEXT
    returning
      value(RR_MODEL) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISHMED_ILLEGAL_POSITION .
endinterface.
