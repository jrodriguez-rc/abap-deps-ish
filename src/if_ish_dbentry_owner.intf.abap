*"* components of interface IF_ISH_DBENTRY_OWNER
interface IF_ISH_DBENTRY_OWNER
  public .


  interfaces IF_ISH_CB_DESTROYABLE .
  interfaces IF_ISH_GUI_CB_STRUCTURE_MODEL .

  aliases CB_DESTROY
    for IF_ISH_CB_DESTROYABLE~CB_DESTROY .
  aliases CB_SET_FIELD_CONTENT
    for IF_ISH_GUI_CB_STRUCTURE_MODEL~CB_SET_FIELD_CONTENT .

  methods CB_AFTER_COMMIT
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_AFTER_ROLLBACK
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_BEFORE_SAVE
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_CLEAR_ALL_SNAPSHOTS
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_CLEAR_SNAPSHOT
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_CONSTRUCTION
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_MARK_FOR_DELETION
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_RELOAD
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_RESET
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_SAVE
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_SNAPSHOT
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_TOUCH
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_UNDO
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_UNTOUCH
    importing
      !IR_DBENTRY type ref to CL_ISH_DBENTRY
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ACTIVE_SNAPKEY
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY .
endinterface.
