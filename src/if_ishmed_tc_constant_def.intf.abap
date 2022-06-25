*"* components of interface IF_ISHMED_TC_CONSTANT_DEF
interface IF_ISHMED_TC_CONSTANT_DEF
  public .


  constants CO_COMPONENT_ISH type N1TC_COMPONENT value 'ISH' ##NO_TEXT.
  constants CO_COMPONENT_ISHMED type N1TC_COMPONENT value 'ISHMED' ##NO_TEXT.
  constants CO_RESP_TYPE_CASE type N1TC_OU_RESP_TYPE value 'C' ##NO_TEXT.
  constants CO_RESP_TYPE_PATIENT type N1TC_OU_RESP_TYPE value 'P' ##NO_TEXT.
  constants CO_RESP_TYPE_SPECIAL type N1TC_OU_RESP_TYPE value 'S' ##NO_TEXT.
  constants CO_S_LEVEL_LIVE_GRANT type N1TC_SECURITY_LEVEL value '3' ##NO_TEXT.
  constants CO_S_LEVEL_LIVE_PROHIBITED type N1TC_SECURITY_LEVEL value '4' ##NO_TEXT.
  constants CO_S_LEVEL_OFF type N1TC_SECURITY_LEVEL value '0' ##NO_TEXT.
  constants CO_S_LEVEL_TEST_GRANT type N1TC_SECURITY_LEVEL value '1' ##NO_TEXT.
  constants CO_S_LEVEL_TEST_PROHIBITED type N1TC_SECURITY_LEVEL value '2' ##NO_TEXT.
  constants CO_TC_CLASSIFICATION_DIS type N1TC_CLASSIFICATION value 'F' ##NO_TEXT.
  constants CO_TC_CLASSIFICATION_ORG type N1TC_CLASSIFICATION value 'O' ##NO_TEXT.
  constants CO_TC_DAYS_APPL_MAX type N1TC_DAYS_APPL value 99999 ##NO_TEXT.
  constants CO_TC_DAYS_APPL_MIN type N1TC_DAYS_APPL value 0 ##NO_TEXT.
  constants CO_TC_DAYS_EXT_MAX type N1TC_DAYS_EXT value 99999 ##NO_TEXT.
  constants CO_TC_DAYS_EXT_MIN type N1TC_DAYS_EXT value 0 ##NO_TEXT.
  constants CO_TC_REQ_TYPE_DELEGATION type N1TC_REQ_TYPE value 'D' ##NO_TEXT.
  constants CO_TC_REQ_TYPE_TEMPORARY type N1TC_REQ_TYPE value 'T' ##NO_TEXT.
  constants CO_TC_TYPE_NORMAL type N1TC_TYPE value 'B' ##NO_TEXT.
  constants CO_TC_TYPE_TEMPORARY type N1TC_TYPE value 'T' ##NO_TEXT.
endinterface.
