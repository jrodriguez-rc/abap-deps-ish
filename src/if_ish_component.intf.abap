*"* components of interface IF_ISH_COMPONENT
interface IF_ISH_COMPONENT
  public .


  interfaces IF_ISH_CHANGEDOCUMENT .
  interfaces IF_ISH_COMPONENT_BASE .
  interfaces IF_ISH_DOM .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases CANCEL
    for IF_ISH_COMPONENT_BASE~CANCEL .
  aliases CHECK
    for IF_ISH_COMPONENT_BASE~CHECK .
  aliases CHECK_CHANGES
    for IF_ISH_COMPONENT_BASE~CHECK_CHANGES .
  aliases COPY_DATA
    for IF_ISH_COMPONENT_BASE~COPY_DATA .
  aliases DESTROY
    for IF_ISH_COMPONENT_BASE~DESTROY .
  aliases DESTROY_SCREENS
    for IF_ISH_COMPONENT_BASE~DESTROY_SCREENS .
  aliases GET_CALLER
    for IF_ISH_COMPONENT_BASE~GET_CALLER .
  aliases GET_CHANGEDOCUMENT
    for IF_ISH_CHANGEDOCUMENT~GET_CHANGEDOCUMENT .
  aliases GET_COMPDEF
    for IF_ISH_COMPONENT_BASE~GET_COMPDEF .
  aliases GET_COMPID
    for IF_ISH_COMPONENT_BASE~GET_COMPID .
  aliases GET_COMPNAME
    for IF_ISH_COMPONENT_BASE~GET_COMPNAME .
  aliases GET_COMPONENT_CONFIG
    for IF_ISH_COMPONENT_BASE~GET_COMPONENT_CONFIG .
  aliases GET_CONFIG
    for IF_ISH_COMPONENT_BASE~GET_CONFIG .
  aliases GET_DATA
    for IF_ISH_COMPONENT_BASE~GET_DATA .
  aliases GET_DEFINED_SCREENS
    for IF_ISH_COMPONENT_BASE~GET_DEFINED_SCREENS .
  aliases GET_DOM_DOCUMENT
    for IF_ISH_DOM~GET_DOM_DOCUMENT .
  aliases GET_DOM_FRAGMENT
    for IF_ISH_DOM~GET_DOM_FRAGMENT .
  aliases GET_DOM_NODE
    for IF_ISH_DOM~GET_DOM_NODE .
  aliases GET_ENVIRONMENT
    for IF_ISH_COMPONENT_BASE~GET_ENVIRONMENT .
  aliases GET_LOCK
    for IF_ISH_COMPONENT_BASE~GET_LOCK .
  aliases GET_MAIN_OBJECT
    for IF_ISH_COMPONENT_BASE~GET_MAIN_OBJECT .
  aliases GET_OBTYP
    for IF_ISH_COMPONENT_BASE~GET_OBTYP .
  aliases GET_REFRESHED
    for IF_ISH_COMPONENT_BASE~GET_REFRESHED .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases GET_T_RUN_DATA
    for IF_ISH_COMPONENT_BASE~GET_T_RUN_DATA .
  aliases GET_T_UID
    for IF_ISH_COMPONENT_BASE~GET_T_UID .
  aliases GET_VCODE
    for IF_ISH_COMPONENT_BASE~GET_VCODE .
  aliases INITIALIZE
    for IF_ISH_COMPONENT_BASE~INITIALIZE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_EMPTY
    for IF_ISH_COMPONENT_BASE~IS_EMPTY .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases IS_SCREEN_SUPPORTED
    for IF_ISH_COMPONENT_BASE~IS_SCREEN_SUPPORTED .
  aliases MODIFY_DOM_DATA
    for IF_ISH_DOM~MODIFY_DOM_DATA .
  aliases PREALLOC
    for IF_ISH_COMPONENT_BASE~PREALLOC .
  aliases REFRESH
    for IF_ISH_COMPONENT_BASE~REFRESH .
  aliases SAVE
    for IF_ISH_COMPONENT_BASE~SAVE .
  aliases SET_CALLER
    for IF_ISH_COMPONENT_BASE~SET_CALLER .
  aliases SET_COMPCON_XML_DOCUMENT
    for IF_ISH_COMPONENT_BASE~SET_COMPCON_XML_DOCUMENT .
  aliases SET_COMPCON_XML_ELEMENT
    for IF_ISH_COMPONENT_BASE~SET_COMPCON_XML_ELEMENT .
  aliases SET_CONFIG
    for IF_ISH_COMPONENT_BASE~SET_CONFIG .
  aliases SET_DATA
    for IF_ISH_COMPONENT_BASE~SET_DATA .
  aliases SET_ENVIRONMENT
    for IF_ISH_COMPONENT_BASE~SET_ENVIRONMENT .
  aliases SET_LOCK
    for IF_ISH_COMPONENT_BASE~SET_LOCK .
  aliases SET_MAIN_OBJECT
    for IF_ISH_COMPONENT_BASE~SET_MAIN_OBJECT .
  aliases SET_REFRESHED
    for IF_ISH_COMPONENT_BASE~SET_REFRESHED .
  aliases SET_T_UID
    for IF_ISH_COMPONENT_BASE~SET_T_UID .
  aliases SET_VCODE
    for IF_ISH_COMPONENT_BASE~SET_VCODE .
  aliases TRANSPORT_FROM_SCREEN
    for IF_ISH_COMPONENT_BASE~TRANSPORT_FROM_SCREEN .
  aliases TRANSPORT_TO_SCREEN
    for IF_ISH_COMPONENT_BASE~TRANSPORT_TO_SCREEN .

  constants CO_EVENT_STATUS_CHANGED type I value 10 ##NO_TEXT.
  constants CO_EVENT_BEFORE_SAVE type I value 20 ##NO_TEXT.
  constants CO_EVENT_BEFORE_COMMIT type I value 30 ##NO_TEXT.
  constants CO_EVENT_AFTER_COMMIT type I value 40 ##NO_TEXT.

  class-methods CREATE
    importing
      value(I_CLASSNAME) type STRING
      !IR_MAIN_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
      value(IT_ADDITIONAL_OBJECTS) type ISH_T_IDENTIFY_OBJECT optional
      value(I_VCODE) type TNDYM-VCODE optional
      value(I_CALLER) type SY-REPID default SY-REPID
      value(IR_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT optional
      value(IR_LOCK) type ref to CL_ISHMED_LOCK optional
      value(IR_CONFIG) type ref to IF_ISH_CONFIG optional
      value(IT_UID) type ISH_T_SYSUUID_C optional
    exporting
      value(ER_INSTANCE) type ref to IF_ISH_COMPONENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
    exceptions
      EX_INVALID_CLASSNAME .
  methods DEFINE_ADK_DATA
    importing
      !IR_OBJECT_DEFINITION type ref to IF_ISHMED_ADK_OBJECT_DEF .
  methods READ_ADK_DATA
    importing
      !I_BUSINESS_KEY type N1ADK_BUSINESS_KEY
      !IR_DATA_CONTAINER type ref to IF_ISHMED_ADK_DATA_CONTAINER
      !IR_CLASS_CONTAINER type ref to IF_ISHMED_ADK_CLASS_CONTAINER
    raising
      CX_ISHMED_ADK_READ .
  methods CONFIGURE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_EXTERN_METHODS
    returning
      value(RT_METHODS) type ISH_T_COMP_METHOD .
  methods HAS_CONFIGURATION
    returning
      value(R_HAS_CONFIG) type ISH_ON_OFF .
  methods IS_BEWTY_SUPPORTED
    importing
      value(I_BEWTY) type N1COTBEWTY
    returning
      value(R_SUPPORTED) type ISH_ON_OFF .
  methods IS_OP
    returning
      value(R_IS_OP) type ISH_ON_OFF .
  methods PROCESS_METHOD
    importing
      value(I_METHODNAME) type STRING
      value(I_ACTUAL_EVENT) type I optional
      !IR_MAIN_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
    exporting
      value(E_TRY_AGAIN) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_HIDE
    returning
      value(R_HIDE) type ISH_ON_OFF .
  methods SET_HIDE
    importing
      value(I_HIDE) type ISH_ON_OFF default 'X' .
  methods PREALLOC_FROM_EXTERNAL
    importing
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
      value(IT_MAPPING) type ISHMED_MIGTYP
      value(I_INDEX) type I default 0
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DATA_FROM_EXTERNAL
    importing
      !IT_COMP_DATA type RN1_COMP_EXTERNAL_DATA_T
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
