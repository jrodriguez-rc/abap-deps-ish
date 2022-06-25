*"* components of interface IF_ISH_GUI_CB_TABLE_MODEL
interface IF_ISH_GUI_CB_TABLE_MODEL
  public .


  type-pools ABAP .
  methods CB_ADD_ENTRY
    importing
      !IR_MODEL type ref to IF_ISH_GUI_TABLE_MODEL
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_CONTINUE) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_REMOVE_ENTRY
    importing
      !IR_MODEL type ref to IF_ISH_GUI_TABLE_MODEL
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_CONTINUE) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
