*"* components of interface IF_ISHMED_NONE_OO_DATA
interface IF_ISHMED_NONE_OO_DATA
  public .


  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .
  aliases UNDO
    for IF_ISH_SNAPSHOT_OBJECT~UNDO .

  constants CO_MAX_SNAPSHOTS type I value 10. "#EC NOTEXT

  methods BUILD_LINE_KEY
    exporting
      value(E_LINE_KEY) type ANY .
  methods INITIALIZE .
  methods REFRESH
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DATA_FIELD
    importing
      value(I_FILL) type ISH_ON_OFF default SPACE
      value(I_FIELDNAME) type ANY
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FIELD) type ANY
      value(E_FLD_NOT_FOUND) type ISH_ON_OFF
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
