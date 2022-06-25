*"* components of interface IF_ISH_RS_USER
interface IF_ISH_RS_USER
  public .


  interfaces IF_ISH_CB_DESTROYABLE .

  aliases CB_DESTROY
    for IF_ISH_CB_DESTROYABLE~CB_DESTROY .

  type-pools ABAP .
  methods CB_SET_ACTUAL_MGR
    importing
      !IR_NEW_ACTUAL_MGR type ref to CL_ISH_RS_MGR
    returning
      value(R_CONTINUE) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
