*"* components of interface IF_ISH_DISPLAY_OBJECT
interface IF_ISH_DISPLAY_OBJECT
  public .


  interfaces IF_ISH_IDENTIFY_OBJECT .

  data GT_OUTTAB type ISHMED_T_DISPLAY_FIELDS .
  data GT_SUBOBJECTS type ISHMED_T_SUBOBJECTS .
  data G_CANCELLED type ISH_ON_OFF .
  data G_CANCELLED_DATA type ISH_ON_OFF .
  class-data G_CONSTRUCT type ISH_ON_OFF .
  data G_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  data G_NODE_OPEN type ISH_ON_OFF .
  data G_OBJECT type N1OBJECTREF .

  class-events AFTER_READ
    exporting
      value(I_OBJECT) type N1OBJECTREF .

  class-methods LOAD
    importing
      !I_OBJECT type N1OBJECTREF optional
      !I_NODE_OPEN type ISH_ON_OFF default 'X'
      value(I_CANCELLED_DATA) type ISH_ON_OFF default SPACE
      value(I_CHECK_ONLY) type ISH_ON_OFF default 'X'
    exporting
      value(E_INSTANCE) type ref to OBJECT
      value(E_CANCELLED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional .
  methods CLOSE_NODE
    importing
      value(I_FIELDNAME) type FIELDNAME optional
      !IT_FIELDCAT type LVC_T_FCAT optional
    exporting
      !ET_OUTTAB type ISHMED_T_DISPLAY_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONVERT_FOR_DISPLAY
    importing
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_SELECTION_CRITERIA) type ISHMED_T_RSPARAMS optional
    exporting
      !ET_OUTTAB type ISHMED_T_DISPLAY_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY .
  methods GET_DATA
    exporting
      value(ET_OBJECT) type ISH_OBJECTLIST .
  methods GET_FIELDCATALOG
    exporting
      !ET_FIELDCAT type LVC_T_FCAT
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_MERGED_VALUES
    exporting
      value(E_OUTTAB) type RN1DISPLAY_FIELDS
      value(ET_NO_MERGE_FIELDS) type ISH_T_FIELDNAME
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_TYPE
    exporting
      value(E_OBJECT_TYPE) type I .
  methods INITIALIZE .
  methods IS_CANCELLED
    exporting
      value(E_CANCELLED) type ISH_ON_OFF .
  methods OPEN_NODE
    importing
      value(I_FIELDNAME) type FIELDNAME optional
      !IT_FIELDCAT type LVC_T_FCAT optional
    exporting
      !ET_OUTTAB type ISHMED_T_DISPLAY_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REMOVE_DATA
    importing
      !IT_OBJECT type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_MAIN_DATA
    importing
      !I_OBJECT type N1OBJECTREF
      !I_CHECK_ONLY type ISH_ON_OFF default SPACE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_NODE
    importing
      value(I_NODE_OPEN) type ISH_ON_OFF .
endinterface.
