*"* components of interface IF_ISH_GUI_CB_XTABLE_MODEL
interface IF_ISH_GUI_CB_XTABLE_MODEL
  public .


  type-pools ABAP .
  methods CB_APPEND_ENTRY
    importing
      !IR_MODEL type ref to IF_ISH_GUI_XTABLE_MODEL
      !IR_PREVIOUS_ENTRY type ref to IF_ISH_GUI_MODEL optional
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_CONTINUE) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_PREPEND_ENTRY
    importing
      !IR_MODEL type ref to IF_ISH_GUI_XTABLE_MODEL
      !IR_NEXT_ENTRY type ref to IF_ISH_GUI_MODEL optional
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_CONTINUE) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
