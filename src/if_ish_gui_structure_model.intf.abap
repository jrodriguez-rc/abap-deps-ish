*"* components of interface IF_ISH_GUI_STRUCTURE_MODEL
interface IF_ISH_GUI_STRUCTURE_MODEL
  public .


  interfaces IF_ISH_GUI_MODEL .

  events EV_CHANGED
    exporting
      value(ET_CHANGED_FIELD) type ISH_T_FIELDNAME optional .

  methods GET_FIELD_CONTENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    changing
      !C_CONTENT type ANY
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_SUPPORTED_FIELDS
    returning
      value(RT_SUPPORTED_FIELDNAME) type ISH_T_FIELDNAME .
  type-pools ABAP .
  methods IS_FIELD_SUPPORTED
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_SUPPORTED) type ABAP_BOOL .
  methods SET_FIELD_CONTENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
