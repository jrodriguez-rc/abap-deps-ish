*"* components of interface IF_ISH_COMPONENT_CONFIG
interface IF_ISH_COMPONENT_CONFIG
  public .


  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_POPUP_CALLBACK .

  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  methods AS_XML_DOCUMENT
    importing
      !IR_IXML type ref to IF_IXML optional
    exporting
      !ER_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods AS_XML_ELEMENT
    importing
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT optional
    exporting
      !ER_XML_ELEMENT type ref to IF_IXML_ELEMENT
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
  methods DESTROY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COMPONENT
    returning
      value(RR_COMPONENT) type ref to IF_ISH_COMPONENT_BASE .
  methods GET_SCREEN
    returning
      value(RR_SCREEN) type ref to IF_ISH_SCREEN .
  methods INITIALIZE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods RESET_DATA
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DATA_BY_XML_DOCUMENT
    importing
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DATA_BY_XML_ELEMENT
    importing
      !IR_XML_ELEMENT type ref to IF_IXML_ELEMENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SHOW_POPUP
    importing
      value(I_VCODE) type TNDYM-VCODE default 'DIS'
      value(I_POPUP_TITLE) type CHAR70 optional
      value(I_STARTPOS_COL) type I optional
      value(I_STARTPOS_ROW) type I optional
      value(I_ENDPOS_COL) type I optional
      value(I_ENDPOS_ROW) type I optional
      value(I_CHECK_CHANGES_ON_CANCEL) type ISH_ON_OFF default SPACE
      value(I_CHECK_ON_CHOICE) type ISH_ON_OFF default 'X'
      value(I_EXIT_ON_WARNINGS) type ISH_ON_OFF default SPACE
    exporting
      value(E_CANCELLED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
