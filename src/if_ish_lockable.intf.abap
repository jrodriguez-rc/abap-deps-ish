*"* components of interface IF_ISH_LOCKABLE
interface IF_ISH_LOCKABLE
  public .


  events EV_LOCKED .
  events EV_UNLOCKED .

  type-pools ABAP .
  methods IS_LOCKED
    importing
      !I_LOCKKEY type N1UUID optional
    returning
      value(R_LOCKED) type ABAP_BOOL .
  methods LOCK
    importing
      !I_USE_DEFAULT_LOCKKEY type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_LOCKKEY) type N1UUID
    raising
      CX_ISH_FOREIGN_LOCK
      CX_ISH_LOCK_ACTUALITY
      CX_ISH_LOCK
      CX_ISH_STATIC_HANDLER .
  methods UNLOCK
    importing
      !I_LOCKKEY type N1UUID optional
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
