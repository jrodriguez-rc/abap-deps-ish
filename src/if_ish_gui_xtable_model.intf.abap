*"* components of interface IF_ISH_GUI_XTABLE_MODEL
interface IF_ISH_GUI_XTABLE_MODEL
  public .


  interfaces IF_ISH_GUI_TABLE_MODEL .

  aliases ADD_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY .
  aliases GET_ENTRIES
    for IF_ISH_GUI_TABLE_MODEL~GET_ENTRIES .
  aliases REMOVE_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~REMOVE_ENTRY .
  aliases EV_ENTRY_ADDED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_ADDED .
  aliases EV_ENTRY_REMOVED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_REMOVED .

  type-pools ABAP .
  methods APPEND_ENTRY
    importing
      !IR_PREVIOUS_ENTRY type ref to IF_ISH_GUI_MODEL optional
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_ADDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_FIRST_ENTRY
    returning
      value(RR_FIRST_ENTRY) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_LAST_ENTRY
    returning
      value(RR_LAST_ENTRY) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_NEXT_ENTRY
    importing
      !IR_PREVIOUS_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(RR_NEXT_ENTRY) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_PREVIOUS_ENTRY
    importing
      !IR_NEXT_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(RR_PREVIOUS_ENTRY) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods PREPEND_ENTRY
    importing
      !IR_NEXT_ENTRY type ref to IF_ISH_GUI_MODEL optional
      !IR_ENTRY type ref to IF_ISH_GUI_MODEL
    returning
      value(R_ADDED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
