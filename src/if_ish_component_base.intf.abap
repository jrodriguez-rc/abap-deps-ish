*"* components of interface IF_ISH_COMPONENT_BASE
interface IF_ISH_COMPONENT_BASE
  public .


  interfaces IF_ISH_DOM .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases GET_DOM_DOCUMENT
    for IF_ISH_DOM~GET_DOM_DOCUMENT .
  aliases GET_DOM_FRAGMENT
    for IF_ISH_DOM~GET_DOM_FRAGMENT .
  aliases GET_DOM_NODE
    for IF_ISH_DOM~GET_DOM_NODE .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  methods ASYNC_TRANSPORT_FROM_SCREEN
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CANCEL
    importing
      value(I_AUTHORITY_CHECK) type ISH_ON_OFF
      value(I_CHECK_ONLY) type ISH_ON_OFF default SPACE
      value(I_VMA) type N1MITARB optional
      value(I_REASON) type N1STOID optional
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
  methods COPY_DATA
    importing
      !IR_COMPONENT_FROM type ref to IF_ISH_COMPONENT
      !I_COPY type N1COPYCOMP default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY
    importing
      value(I_DESTROY_DATA_OBJECTS) type ISH_ON_OFF default 'X'
      value(I_DESTROY_SCREENS) type ISH_ON_OFF default 'X'
      value(I_DESTROY_EMBEDDED_SCR) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY_SCREENS
    importing
      value(I_DESTROY_EMBEDDED_SCR) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CALLER
    returning
      value(R_CALLER) type SY-REPID .
  methods GET_COMPDEF
    returning
      value(RR_COMPDEF) type ref to CL_ISH_COMPDEF .
  methods GET_COMPID
    returning
      value(R_COMPID) type N1COMPID .
  methods GET_COMPNAME
    exporting
      value(R_COMPNAME) type NCOMPNAME .
  methods GET_COMPONENT_CONFIG
    returning
      value(RR_COMPCON) type ref to IF_ISH_COMPONENT_CONFIG .
  methods GET_CONFIG
    returning
      value(RR_CONFIG) type ref to IF_ISH_CONFIG .
  methods GET_DATA
    exporting
      !ER_MAIN_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      value(ET_ADDITIONAL_OBJECTS) type ISH_T_IDENTIFY_OBJECT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DEFINED_SCREENS
    returning
      value(RT_SCREEN_OBJECTS) type ISH_T_SCREEN_OBJECTS .
  methods GET_ENVIRONMENT
    returning
      value(RR_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT .
  methods GET_LOCK
    returning
      value(RR_LOCK) type ref to CL_ISHMED_LOCK .
  methods GET_MAIN_OBJECT
    returning
      value(RR_MAIN_OBJECT) type ref to IF_ISH_IDENTIFY_OBJECT .
  methods GET_OBTYP
    returning
      value(R_OBTYP) type J_OBTYP .
  methods GET_REFRESHED
    returning
      value(R_REFRESHED) type ISH_ON_OFF .
  methods GET_T_RUN_DATA
    importing
      value(I_USE_ONLY_MEMORY) type ISH_ON_OFF default SPACE
    exporting
      value(ET_RUN_DATA) type ISH_T_OBJECTBASE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_T_UID
    exporting
      value(RT_UID) type ISH_T_SYSUUID_C .
  methods GET_VCODE
    returning
      value(R_VCODE) type TNDYM-VCODE .
  methods INITIALIZE
    importing
      !IR_MAIN_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
      value(IT_ADDITIONAL_OBJECTS) type ISH_T_IDENTIFY_OBJECT optional
      value(I_VCODE) type TNDYM-VCODE optional
      value(I_CALLER) type SY-REPID default SY-REPID
      value(IR_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT optional
      value(IR_LOCK) type ref to CL_ISHMED_LOCK optional
      value(IR_CONFIG) type ref to IF_ISH_CONFIG optional
      value(I_USE_TNDYM_CURSOR) type ISH_ON_OFF default 'X'
      value(IT_UID) type ISH_T_SYSUUID_C optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods IS_EMPTY
    returning
      value(R_EMPTY) type ISH_ON_OFF .
  methods IS_SCREEN_SUPPORTED
    importing
      value(IR_SCREEN) type ref to IF_ISH_SCREEN
    returning
      value(R_IS_SUPPORTED) type ISH_ON_OFF .
  methods PREALLOC
    importing
      value(I_FORCE) type ISH_ON_OFF optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_EV_SYSTEM_EVENT
    importing
      !IR_SCR_CONTROL type ref to IF_ISH_SCR_CONTROL
      !I_UCOMM type SY-UCOMM
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_UCOMM
    importing
      !I_UCOMM type SY-UCOMM
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REFRESH
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SAVE
    importing
      value(I_TESTRUN) type ISH_ON_OFF default SPACE
      value(I_TCODE) type SY-TCODE default SY-TCODE
    exporting
      value(ET_UID_SAVE) type ISH_T_SYSUUID_C
      value(ET_UID_DELETE) type ISH_T_SYSUUID_C
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_CALLER
    importing
      value(I_ADJUST_SCREENS) type ISH_ON_OFF default 'X'
      value(I_CALLER) type SY-REPID .
  methods SET_COMPCON_XML_DOCUMENT
    importing
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_COMPCON_XML_ELEMENT
    importing
      !IR_XML_ELEMENT type ref to IF_IXML_ELEMENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_CONFIG
    importing
      value(I_ADJUST_SCREENS) type ISH_ON_OFF default 'X'
      !IR_CONFIG type ref to IF_ISH_CONFIG .
  methods SET_DATA
    importing
      !IR_MAIN_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      value(IT_ADDITIONAL_OBJECTS) type ISH_T_IDENTIFY_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ENVIRONMENT
    importing
      value(I_ADJUST_SCREENS) type ISH_ON_OFF default 'X'
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  methods SET_LOCK
    importing
      value(I_ADJUST_SCREENS) type ISH_ON_OFF default 'X'
      !IR_LOCK type ref to CL_ISHMED_LOCK .
  methods SET_MAIN_OBJECT
    importing
      value(I_ADJUST_SCREENS) type ISH_ON_OFF default 'X'
      !IR_MAIN_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT .
  methods SET_REFRESHED
    importing
      value(I_REFRESHED) type ISH_ON_OFF .
  methods SET_T_UID
    importing
      value(IT_UID) type ISH_T_SYSUUID_C
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_VCODE
    importing
      value(I_VCODE) type TNDYM-VCODE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_FROM_SCREEN
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_TO_SCREEN
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
