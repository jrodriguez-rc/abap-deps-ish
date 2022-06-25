*"* components of interface IF_ISH_PROCESS
interface IF_ISH_PROCESS
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

  methods INITIALIZE
    exporting
      value(E_PGM) type SY-REPID
      value(E_DYNNR) type SY-DYNNR
      value(E_CURSOR) type ISH_CURSOR
      value(E_CURSOR_PGM) type SY-REPID
      value(E_CURSOR_DYNNR) type SY-DYNNR
      value(E_CURSOR_LIN) type SY-STEPL
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_CHANGES
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_CHANGED) type ISH_ON_OFF
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_CURSOR
    importing
      value(I_RN1MESSAGE) type RN1MESSAGE optional
      value(I_CURSORFIELD) type ISH_FIELDNAME optional
    exporting
      value(E_CURSOR_SET) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CALL_OK_CODE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      value(C_OKCODE) type SY-UCOMM .
  methods SAVE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
