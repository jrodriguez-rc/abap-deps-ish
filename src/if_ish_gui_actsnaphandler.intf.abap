*"* components of interface IF_ISH_GUI_ACTSNAPHANDLER
interface IF_ISH_GUI_ACTSNAPHANDLER
  public .


  events EV_ACTSNAP_ADDED
    exporting
      value(E_ACTION_ID) type SYSUUID_C .
  events EV_ACTSNAP_REMOVED
    exporting
      value(E_ACTION_ID) type SYSUUID_C .

  methods CLEAR_ACTION_SNAPSHOT
    importing
      !I_ACTION_ID type SYSUUID_C
    returning
      value(RS_ACTSNAP) type RN1_ACTION_SNAPSHOT
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ACTION_TEXT_BY_ID
    importing
      !I_ACTION_ID type SYSUUID_C
    returning
      value(R_ACTION_TEXT) type N1STRING .
  methods GET_T_ACTION_ID
    returning
      value(RT_ACTION_ID) type ISH_T_SYSUUID_C .
  methods SNAPSHOT_ACTION
    importing
      !I_ACTION_TEXT type N1STRING
      !IR_CONTENTS type ref to CL_ISH_NAMED_CONTENT_LIST optional
    returning
      value(R_ACTION_ID) type SYSUUID_C
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNDO_ACTION
    importing
      !I_ACTION_ID type SYSUUID_C
    returning
      value(RS_ACTSNAP) type RN1_ACTION_SNAPSHOT
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
