*"* components of interface IF_ISH_BUSINESS_OBJECT_OWNER
interface IF_ISH_BUSINESS_OBJECT_OWNER
  public .


  interfaces IF_ISH_CB_DESTROYABLE .

  aliases CB_DESTROY
    for IF_ISH_CB_DESTROYABLE~CB_DESTROY .

  methods CB_AFTER_COMMIT
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_AFTER_ROLLBACK
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_CLEAR_ALL_SNAPSHOTS
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_CLEAR_SNAPSHOT
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_CONSTRUCTION
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_DEREGISTER_OWNER
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_MARK_FOR_DELETION
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods CB_READONLY
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    returning
      value(R_READONLY) type ABAP_BOOL .
  methods CB_REGISTER_OWNER
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_RELOAD
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_RESET
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_SAVE
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_SNAPSHOT
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_TOUCH
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_UNDO
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_UNTOUCH
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
