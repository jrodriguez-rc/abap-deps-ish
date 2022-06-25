*"* components of interface IF_ISH_CB_LOCKABLE
interface IF_ISH_CB_LOCKABLE
  public .


  type-pools ABAP .
  methods CB_LOCK
    importing
      !IR_LOCKABLE type ref to IF_ISH_LOCKABLE
      !I_USE_DEFAULT_LOCKKEY type ABAP_BOOL default ABAP_TRUE
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_UNLOCK
    importing
      !IR_LOCKABLE type ref to IF_ISH_LOCKABLE
      !I_LOCKKEY type N1UUID optional
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
