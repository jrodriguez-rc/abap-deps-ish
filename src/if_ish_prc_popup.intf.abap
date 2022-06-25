*"* components of interface IF_ISH_PRC_POPUP
interface IF_ISH_PRC_POPUP
  public .


  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  methods AFTER_PAI
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods AFTER_PBO
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BEFORE_PAI_SUBSCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BEFORE_PBO_SUBSCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_CHANGES
    exporting
      value(E_CHANGED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods COLLECT_MESSAGES
    importing
      !IR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods DESTROY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods EXIT_COMMAND
    exporting
      value(E_EXIT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CALLBACK
    returning
      value(RR_CALLBACK) type ref to IF_ISH_POPUP_CALLBACK .
  methods GET_CHECK_CHANGES_ON_CANCEL
    returning
      value(R_CHECK_CHANGES) type ISH_ON_OFF .
  methods GET_CHECK_ON_CHOICE
    returning
      value(R_CHECK) type ISH_ON_OFF .
  methods GET_CONFIG
    returning
      value(RR_CONFIG) type ref to IF_ISH_CONFIG .
  methods GET_EXIT_ON_WARNINGS
    returning
      value(R_EXIT) type ISH_ON_OFF .
  methods GET_POPUP_TITLE
    returning
      value(R_POPUP_TITLE) type CHAR70 .
  methods GET_SCREEN
    returning
      value(RR_SCREEN) type ref to IF_ISH_SCREEN .
  methods GET_VCODE
    returning
      value(R_VCODE) type TNDYM-VCODE .
  methods GET_POPUP_POSITION
    exporting
      value(E_STARTPOS_COL) type I
      value(E_STARTPOS_ROW) type I
      value(E_ENDPOS_COL) type I
      value(E_ENDPOS_ROW) type I .
  methods INITIALIZE
    importing
      value(I_POPUP_TITLE) type CHAR70 optional
      value(I_CHECK_CHANGES_ON_CANCEL) type ISH_ON_OFF default 'X'
      value(I_CHECK_ON_CHOICE) type ISH_ON_OFF default 'X'
      value(I_EXIT_ON_WARNINGS) type ISH_ON_OFF default SPACE
      !IR_CONFIG type ref to IF_ISH_CONFIG optional
      value(I_STARTPOS_COL) type I default 0
      value(I_STARTPOS_ROW) type I default 0
      value(I_ENDPOS_COL) type I default 0
      value(I_ENDPOS_ROW) type I default 0
      value(I_VCODE) type TNDYM-VCODE optional
      value(IR_CALLBACK) type ref to IF_ISH_POPUP_CALLBACK optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PAI
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PBO
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods RUN
    exporting
      value(E_CANCELLED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods USER_COMMAND
    exporting
      value(E_EXIT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
