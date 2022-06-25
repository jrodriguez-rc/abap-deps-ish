*"* components of interface IF_ISH_GUI_TABLE_MODEL
interface IF_ISH_GUI_TABLE_MODEL
  public .


  interfaces IF_ISH_GUI_MODEL .

  events EV_ENTRY_ADDED
    exporting
      value(ER_ENTRY) type ref to IF_ISH_GUI_MODEL .
  events EV_ENTRY_REMOVED
    exporting
      value(ER_ENTRY) type ref to IF_ISH_GUI_MODEL .

  type-pools ABAP .
  methods ADD_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_ADDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ENTRIES
    returning
      value(RT_ENTRY) type ISH_T_GUI_MODEL_OBJHASH
    raising
      CX_ISH_STATIC_HANDLER .
  methods REMOVE_ENTRY
    importing
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_REMOVED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
