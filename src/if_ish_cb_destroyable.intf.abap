*"* components of interface IF_ISH_CB_DESTROYABLE
interface IF_ISH_CB_DESTROYABLE
  public .


  type-pools ABAP .
  methods CB_DESTROY
    importing
      !IR_DESTROYABLE type ref to IF_ISH_DESTROYABLE
    returning
      value(R_CONTINUE) type ABAP_BOOL .
endinterface.
