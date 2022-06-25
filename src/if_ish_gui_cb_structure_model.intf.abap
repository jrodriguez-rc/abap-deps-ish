*"* components of interface IF_ISH_GUI_CB_STRUCTURE_MODEL
interface IF_ISH_GUI_CB_STRUCTURE_MODEL
  public .


  type-pools ABAP .
  methods CB_SET_FIELD_CONTENT
    importing
      !IR_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
    returning
      value(R_CONTINUE) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
