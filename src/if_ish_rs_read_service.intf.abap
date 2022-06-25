*"* components of interface IF_ISH_RS_READ_SERVICE
interface IF_ISH_RS_READ_SERVICE
  public .


  interfaces IF_ISH_GUI_CB_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_CB_TABLE_MODEL .
  interfaces IF_ISH_GUI_CB_XTABLE_MODEL .

  aliases CB_ADD_ENTRY
    for IF_ISH_GUI_CB_TABLE_MODEL~CB_ADD_ENTRY .
  aliases CB_APPEND_ENTRY
    for IF_ISH_GUI_CB_XTABLE_MODEL~CB_APPEND_ENTRY .
  aliases CB_PREPEND_ENTRY
    for IF_ISH_GUI_CB_XTABLE_MODEL~CB_PREPEND_ENTRY .
  aliases CB_REMOVE_ENTRY
    for IF_ISH_GUI_CB_TABLE_MODEL~CB_REMOVE_ENTRY .
  aliases CB_SET_FIELD_CONTENT
    for IF_ISH_GUI_CB_STRUCTURE_MODEL~CB_SET_FIELD_CONTENT .

  class-methods NEW_INSTANCE
    importing
      !IR_MGR type ref to CL_ISH_RS_MGR
      !I_TYPE type N1RS_TYPE
    returning
      value(RR_INSTANCE) type ref to IF_ISH_RS_READ_SERVICE
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_MGR
    returning
      value(RR_MGR) type ref to CL_ISH_RS_MGR .
  methods GET_TYPE
    returning
      value(R_TYPE) type N1RS_TYPE .
  methods GET_SEARCH_RESULTS
    returning
      value(RT_SEARCH_RESULT) type ISH_T_RS_SEARCHRESULT_OBJH .
  methods GET_ENTITIES
    returning
      value(RT_ENTITY) type ISH_T_RS_ENTITY_OBJH .
  methods REFRESH
    raising
      CX_ISH_STATIC_HANDLER .
  methods REFRESH_SEARCH_RESULT
    importing
      !IR_SEARCH_RESULT type ref to IF_ISH_RS_SEARCH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
