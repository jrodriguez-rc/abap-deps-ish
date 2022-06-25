*"* components of interface IF_ISH_GUI_XSTRUCTURE_MODEL
interface IF_ISH_GUI_XSTRUCTURE_MODEL
  public .


  interfaces IF_ISH_GUI_STRUCTURE_MODEL .

  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

  methods GET_DATA
    changing
      !CS_DATA type DATA
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods IS_FIELD_CHANGEABLE
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_CHANGEABLE) type ABAP_BOOL .
  methods IS_READONLY
    returning
      value(R_READONLY) type ABAP_BOOL .
  methods SET_DATA
    importing
      !IS_DATA type DATA
      !I_SOFT type ABAP_BOOL default ABAP_TRUE
      !IT_FIELD2CHANGE type ISH_T_FIELDNAME optional
      !I_HANDLE_XFIELDS type ABAP_BOOL default ABAP_FALSE
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
