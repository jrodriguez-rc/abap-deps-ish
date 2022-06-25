*"* components of interface IF_ISH_DATA_OBJECT
interface IF_ISH_DATA_OBJECT
  public .


  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_MODE_INSERT type ISH_MODUS value 'I'. "#EC NOTEXT
  constants CO_MODE_UPDATE type ISH_MODUS value 'U'. "#EC NOTEXT
  constants CO_MODE_DELETE type ISH_MODUS value 'D'. "#EC NOTEXT
  constants CO_MODE_UNCHANGED type ISH_MODUS value SPACE. "#EC NOTEXT
  constants CO_MODE_ERROR type ISH_MODUS value 'E'. "#EC NOTEXT
  constants ON type ISH_ON_OFF value 'X'. "#EC NOTEXT
  constants OFF type ISH_ON_OFF value SPACE. "#EC NOTEXT
  constants TRUE type ISH_TRUE_FALSE value '1'. "#EC NOTEXT
  constants FALSE type ISH_TRUE_FALSE value '0'. "#EC NOTEXT
  constants CO_MAX_SNAPSHOTS type I value 100. "#EC NOTEXT
  constants CO_BUFFER_USE type N1BUFREFR value ' '. "#EC NOTEXT
  constants CO_BUFFER_REFRESH type N1BUFREFR value 'R'. "#EC NOTEXT
  constants CO_BUFFER_CLEAR type N1BUFREFR value 'C'. "#EC NOTEXT
  constants CO_KEYSTRING_WITH_MANDT type N1KEYSTRING value 'X'. "#EC NOTEXT
  constants CO_KEYSTRING_WITHOUT_MANDT type N1KEYSTRING value ' '. "#EC NOTEXT
  constants CO_KEYSTRING_DEFAULT type N1KEYSTRING value '*'. "#EC NOTEXT
  data G_MODE type ISH_MODUS .
  data G_ACTIVE type ISH_ON_OFF .

  events EV_DESTROYED .
  events EV_REFRESHED .

  methods CHECK_CHANGES
    exporting
      value(E_CHANGED_FIELDS) type ANY
      value(E_MODE) type ISH_MODUS
      value(E_RC) type I
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods IS_ACTIVE
    exporting
      value(E_ACTIVE) type ISH_ON_OFF .
  methods IS_CANCELLED
    exporting
      value(E_CANCELLED) type ISH_ON_OFF
      value(E_DELETED) type ISH_ON_OFF .
  methods IS_CHANGED
    returning
      value(R_IS_CHANGED) type ISH_ON_OFF .
  methods IS_NEW
    exporting
      value(E_NEW) type ISH_ON_OFF .
  methods DESTROY
    importing
      value(I_FINAL) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CDOC_OBJECT
    importing
      value(I_TABNAME) type STRING default SPACE
    exporting
      value(E_OBJECTCLAS) type CDOBJECTCL
      value(E_OBJECTID) type CDOBJECTV .
  methods GET_CHECKING_DATE
    importing
      value(I_VALUES_EQUAL) type ISH_ON_OFF default ' '
    returning
      value(R_CHECKING_DATE) type SY-DATUM .
  methods GET_KEY_STRING
    importing
      value(I_WITH_MANDT) type N1KEYSTRING default '*'
    exporting
      value(E_KEY) type STRING .
  methods REFRESH
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
