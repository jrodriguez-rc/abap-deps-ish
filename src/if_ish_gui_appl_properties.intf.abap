*"* components of interface IF_ISH_GUI_APPL_PROPERTIES
interface IF_ISH_GUI_APPL_PROPERTIES
  public .


  constants CO_PROPTYPE_BOOLEAN type N1GUI_APPLPROP_TYPE value 'B'. "#EC NOTEXT
  constants CO_PROPTYPE_INTEGER type N1GUI_APPLPROP_TYPE value 'I'. "#EC NOTEXT
  constants CO_PROPTYPE_STRING type N1GUI_APPLPROP_TYPE value 'S'. "#EC NOTEXT

  type-pools ABAP .
  methods ADD_BOOLEAN
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
      !I_VALUE type ABAP_BOOL
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods ADD_INTEGER
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
      !I_VALUE type INT4
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods ADD_STRING
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
      !I_VALUE type STRING
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods GET_BOOLEAN
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
    returning
      value(R_VALUE) type ABAP_BOOL .
  methods GET_INTEGER
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
    returning
      value(R_VALUE) type INT4 .
  methods GET_PROPERTIES
    returning
      value(RT_PROPERTIES) type ISH_T_GUI_APPLPROP_HASH .
  methods GET_PROPERTY_TYPE
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
    returning
      value(R_PROPERTY_TYPE) type N1GUI_APPLPROP_TYPE .
  methods GET_STRING
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
    returning
      value(R_VALUE) type STRING .
  methods HAS_PROPERTY
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
    returning
      value(R_HAS_PROPERTY) type ABAP_BOOL .
  methods SET_BOOLEAN
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
      !I_VALUE type ABAP_BOOL
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods SET_INTEGER
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
      !I_VALUE type INT4
    returning
      value(R_SUCCESS) type ABAP_BOOL .
  methods SET_STRING
    importing
      !I_NAME type N1GUI_APPLPROP_NAME
      !I_VALUE type STRING
    returning
      value(R_SUCCESS) type ABAP_BOOL .
endinterface.
