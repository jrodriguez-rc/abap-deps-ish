class CL_ISHMED_FUNCTIONS definition
  public
  final
  create public .

public section.

  interfaces IF_ISHMED_PL_USAGE_CONSTANTS .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_PL_USAGE_CONSTANTS .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_USAGE_AC_PROPOSAL
    for IF_ISHMED_PL_USAGE_CONSTANTS~CO_USAGE_AC_PROPOSAL .
  aliases CO_USAGE_FOLLOW_UP_VISIT
    for IF_ISHMED_PL_USAGE_CONSTANTS~CO_USAGE_FOLLOW_UP_VISIT .
  aliases CO_USAGE_GENERAL
    for IF_ISHMED_PL_USAGE_CONSTANTS~CO_USAGE_GENERAL .
  aliases CO_USAGE_INITIAL_VISIT
    for IF_ISHMED_PL_USAGE_CONSTANTS~CO_USAGE_INITIAL_VISIT .
  aliases CO_USAGE_MULTIAPP_SRCH
    for IF_ISHMED_PL_USAGE_CONSTANTS~CO_USAGE_MULTIAPP_SRCH .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  class-methods CALL_ADMISSION
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_APPOINTMENT_CALENDAR
    importing
      value(I_FCODE) type N1FCODE optional
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_APPOINTMENT_PLANNING
    importing
      value(I_FCODE) type N1FCODE optional
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_APP_CHANGEDOC
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_APP_PLAN_SEARCH
    importing
      value(I_FCODE) type N1FCODE optional
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CASE_ASSIGN
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CHAIN_APP
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CLINICAL_ORDER
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CLINICAL_ORDER_CR_APPMOV
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CLINICAL_ORDER_PRINT
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CLINICAL_ORDER_SEARCH
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CLINICAL_ORDPOS_CANCEL
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CLINICAL_ORDPOS_NSTAT
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_CWD
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_DIAGNOSES
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_IFG_SHOW_POPUP
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_LAB_DATA
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_LTXT_SAPSCR
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_MATERIAL_END
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_MATERIAL_PROPOSAL
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_MED_DOCUMENT
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_ME_ADMIN_EVENT_BC
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_ME_ANAMN_ORDER_CREATE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_ME_ORDER_CHANGE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_ME_ORDER_CREATE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_NBOP_CREATE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_OP_BEGONNEN
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_OP_DETAILS
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_OP_DWS
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_OP_MONITOR
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_OP_SIGN_SET
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_OP_STORNO
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PATEIN_SET
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PATIENT_OPEN_POINTS
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PATIENT_ORGANIZER
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_VSA
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_VSE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_VSP
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PLANNING_AUTHORITY_DIALOG
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PLAN_CHANGEDOC
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PLAN_RELEASE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PRINT_FORM
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PTS_INSERT
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_PTS_RWTR
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_REQUEST
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_REQUEST_CREATE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_REQUEST_PRINT
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_RISIKO
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_SERVICE_CYCLE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_SERVICE_QUIT
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_SNSE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_SURG_SEL_WS
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_TEAM_UPDATE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_TIME_STAMPS
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_VIEW
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CALL_VITPAR_DIALOG
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods CHECK_NBR_MARKED_LINES
    importing
      value(I_CHECK_TYPE) type N1NBRLINES_CHECK_TYPE default '1'
      value(I_SEND_MSG) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_NBR_MARKED) type I
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods EXECUTE
    importing
      value(I_FCODE) type N1FCODE
      value(I_EINRI) type EINRI
      value(I_CALLER) type N1CALLER
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
      value(I_ENQUEUE) type ISH_ON_OFF default SPACE
      value(I_DEQUEUE) type ISH_ON_OFF default 'X'
      !IT_OBJECTS type ISH_OBJECTLIST optional
      !IT_PARAMETER type ISHMED_T_PARAMETER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1REFRESH
      !ET_EXPVALUES type ISHMED_T_EXPVALUES
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_LOCK type ref to CL_ISHMED_LOCK optional .
  class-methods GET_APPS_AND_MOVS
    importing
      !IT_OBJECTS type ISH_OBJECTLIST optional
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default SPACE
      value(I_READ_DB) type ISH_ON_OFF default ABAP_TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ET_NTMN type ISHMED_T_NTMN
      !ET_NAPP type ISHMED_T_NAPP
      !ET_APPOINTMENTS type ISHMED_T_APPOINTMENT_OBJECT
      !ET_NBEW type ISHMED_T_NBEW
      !ET_MOVEMENTS type ISHMED_T_MOVEMENT
      !ET_MOVEMENTS_NONE type ISHMED_T_NONE_OO_NBEW
    changing
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_ENVIRONMENT
    importing
      !IT_OBJECTS type ISH_OBJECTLIST optional
      value(I_CALLER) type N1CALLER optional
      value(I_ENV_CREATE) type ISH_ON_OFF default ON
      value(I_NPOL_SET) type ISH_ON_OFF default OFF
    exporting
      value(E_ENV_CREATED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_ERBOES
    importing
      !IT_OBJECTS type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ET_ERBOE type ISHMED_T_ORGID
      !ET_PFLOE type ISHMED_T_ORGID
      !ET_FACHOE type ISHMED_T_ORGID
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_ORDERS
    importing
      !IT_OBJECTS type ISH_OBJECTLIST optional
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default SPACE
      value(I_READ_DB) type ISH_ON_OFF default ABAP_TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ET_CORDERS type ISHMED_T_CORDER_OBJECT
      !ET_N1CORDER type ISH_T_N1CORDER
    changing
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_PATIENTS_AND_CASES
    importing
      !IT_OBJECTS type ISH_OBJECTLIST optional
      value(I_READ_DB) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ET_NFAL type ISHMED_T_NFAL
      !ET_NPAT type ISHMED_T_NPAT
      !ET_NPAP type ISHMED_T_NPAP
      !ET_CASES type ISHMED_T_NONE_OO_NFAL
      !ET_PATIENTS type ISHMED_T_NONE_OO_NPAT
      !ET_PROVPAT type RNPAP_T_SEARCHLIST
    changing
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_PREREGISTRATIONS
    importing
      !IT_OBJECTS type ISH_OBJECTLIST optional
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default SPACE
      value(I_EXCLUDE_CORDER) type ISH_ON_OFF default SPACE
      value(I_READ_DB) type ISH_ON_OFF default ABAP_TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ET_PREREGS type ISHMED_T_PREREG_OBJECT
      !ET_N1VKG type ISHMED_T_N1VKG
    changing
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_REQUESTS
    importing
      !IT_OBJECTS type ISH_OBJECTLIST optional
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default SPACE
      value(I_READ_DB) type ISH_ON_OFF default ABAP_TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ET_REQUESTS type ISHMED_T_REQUEST_OBJECT
      !ET_N1ANF type ISHMED_T_N1ANF
    changing
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_SERVICES
    importing
      !IT_OBJECTS type ISH_OBJECTLIST optional
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default SPACE
      value(I_CONN_SRV) type ISH_ON_OFF default SPACE
      value(I_ONLY_MAIN_ANCHOR) type ISH_ON_OFF default 'X'
      value(I_NO_SORT_CHANGE) type ISH_ON_OFF default SPACE
      value(I_READ_DB) type ISH_ON_OFF default ABAP_TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
      !ET_SERVICES type ISHMED_T_SERVICE_OBJECT
      !ET_NLEI type ISHMED_T_NLEI
      !ET_NLEM type ISHMED_T_NLEM
      !ET_ANCHOR_SERVICES type ISHMED_T_SERVICE_OBJECT
      !ET_ANCHOR_NLEI type ISHMED_T_NLEI
      !ET_ANCHOR_NLEM type ISHMED_T_NLEM
    changing
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods SWITCH_AND_DELETE_NPAP
    importing
      value(I_EINRI) type EINRI
      value(I_PROVPAT) type ref to CL_ISH_PATIENT_PROVISIONAL optional
      value(I_PAPID) type NPAP-PAPID optional
      value(I_SAVE) type ISH_ON_OFF default 'X'
      value(I_COMMIT) type ISH_ON_OFF default 'X'
    exporting
      value(E_PATNR) type NPAT-PATNR
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !C_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional .
  class-methods WAITING_FOR_UPDATE
    importing
      !IT_OBJECTS type ISH_OBJECTLIST
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.

  class-methods NPOL_REFRESH
    importing
      value(I_EINRI) type EINRI
      !IT_OBJECTS type ISH_OBJECTLIST
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISHMED_FUNCTIONS
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISHMED_FUNCTIONS IMPLEMENTATION.


METHOD call_admission.

  DATA: l_nbr_marked           TYPE i,
        l_tcode                TYPE sy-tcode,
        l_caller               TYPE ish_fcode_dtm,
        l_call_adm             TYPE rn1call_admission,
        l_check_type           TYPE n1nbrlines_check_type,
        l_connect_app_to_mvmt  TYPE ish_on_off,
        l_oe_from_nbo          TYPE ish_on_off,             " ID 14602
        l_skip                 TYPE ish_on_off,
        l_skip_caselist        TYPE ish_on_off,
        lt_npat                TYPE ishmed_t_npat,
        l_npat                 LIKE LINE OF lt_npat,
        lt_npap                TYPE ishmed_t_npap,
        l_npap                 LIKE LINE OF lt_npap,
        lt_nfal                TYPE ishmed_t_nfal,
        l_nfal                 LIKE LINE OF lt_nfal,
        lt_ntmn                TYPE ishmed_t_ntmn,
        l_ntmn                 LIKE LINE OF lt_ntmn,
        lt_nbew                TYPE ishmed_t_nbew,
        l_nbew                 LIKE LINE OF lt_nbew,
        lt_erboe               TYPE ishmed_t_orgid,
        l_erboe                LIKE LINE OF lt_erboe,
        lt_a_nlei              TYPE ishmed_t_nlei,
        lt_nlei                TYPE ishmed_t_nlei,
        l_nlei                 LIKE LINE OF lt_nlei,
        lt_n1vkg               TYPE ishmed_t_n1vkg,
        l_n1vkg                LIKE LINE OF lt_n1vkg,
        l_name(50)             TYPE c,
        l_rnmem                TYPE rnmem,
        l_rnadp                TYPE rnadp.

* Initialisierungen
  CLEAR: e_rc, l_nbr_marked, l_connect_app_to_mvmt, l_rnadp,
         l_skip, l_skip_caselist, l_tcode, l_check_type,
         l_npap, l_npat, l_nfal, l_ntmn, l_erboe, l_n1vkg,
         l_call_adm, l_rnmem, l_nlei, l_caller, l_oe_from_nbo.

  e_refresh   = 0.
  e_func_done = true.

  l_caller = i_caller.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Prüfen wieviele Einträge markiert werden dürfen
  IF   i_fcode EQ 'AAAL' OR i_fcode EQ 'SAAL' OR
       i_fcode EQ 'AKAL' OR i_fcode EQ 'SKAL' OR
       i_fcode EQ 'ANAL' OR i_fcode EQ 'SNAL'.
*   Anlegen
*   '0'... keine oder 1 Zeile darf markiert werden (0 oder 1 erlaubt)
    l_check_type = '0'.
  ELSE.
*   Anzeigen/Ändern
*   '1'... nur genau 1 Zeile darf markiert werden (nur 1 erlaubt)
    l_check_type = '1'.
  ENDIF.

  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = l_check_type
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

  IF l_nbr_marked > 0.

*   diverse Tabelleneinträge für den Patienten lesen
    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_nfal        = lt_nfal
        et_npat        = lt_npat
        et_npap        = lt_npap
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.

    CHECK e_rc = 0.
    READ TABLE lt_npat INTO l_npat INDEX 1.
    READ TABLE lt_npap INTO l_npap INDEX 1.
    READ TABLE lt_nfal INTO l_nfal INDEX 1.

    CALL METHOD cl_ishmed_functions=>get_apps_and_movs
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_ntmn        = lt_ntmn
        et_nbew        = lt_nbew
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.

    CHECK e_rc = 0.
    READ TABLE lt_ntmn INTO l_ntmn INDEX 1.

    CALL METHOD cl_ishmed_functions=>get_erboes
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_erboe       = lt_erboe
      CHANGING
        c_errorhandler = c_errorhandler.

    CHECK e_rc = 0.
    READ TABLE lt_erboe INTO l_erboe INDEX 1.

    CALL METHOD cl_ishmed_functions=>get_services
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_nlei        = lt_nlei
        et_anchor_nlei = lt_a_nlei
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.

    CHECK e_rc = 0.
    IF l_caller = 'NWP011'.
      READ TABLE lt_a_nlei INTO l_nlei INDEX 1.
    ELSE.
      READ TABLE lt_nlei INTO l_nlei INDEX 1.
    ENDIF.

    CALL METHOD cl_ishmed_functions=>get_preregistrations
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_n1vkg       = lt_n1vkg
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.

    CHECK e_rc = 0.
    READ TABLE lt_n1vkg INTO l_n1vkg INDEX 1.

*   Patient + Fall übergeben
    l_call_adm-patnr = l_npat-patnr.
    l_call_adm-pziff = l_npat-pziff.
    l_call_adm-falnr = l_nfal-falnr.
    l_call_adm-fziff = l_nfal-fziff.

*   Prüfen, ob Patient oder Vorläufiger Patient markiert ist
    IF   i_fcode EQ 'AAAL' OR i_fcode EQ 'SAAL' OR
         i_fcode EQ 'AKAL' OR i_fcode EQ 'SKAL' OR
         i_fcode EQ 'ANAL' OR i_fcode EQ 'SNAL'.
*     Anlegen
      IF l_npat-patnr IS INITIAL.
        l_skip = off.
*      ELSE.                    " REMARK: EB soll immer kommen!
*        l_skip = on.
      ENDIF.
    ELSE.
*     Anzeigen/Ändern
      IF l_npat-patnr IS INITIAL AND l_nfal-falnr IS INITIAL.
*       Patient noch nicht aufgenommen - Funktion nicht möglich
        CLEAR l_name.
        PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                      l_npap-vorsw
                                                      l_npap-nname
                                                      l_npap-vname
                                                      l_name.
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '617'
            i_mv1  = l_name
            i_mv2  = 'Funktion'(006)
            i_last = space.
        e_rc      = 1.
        e_refresh = 0.
        EXIT.
      ENDIF.
      IF l_npat-patnr IS INITIAL.
        l_skip = off.
      ELSE.
        l_skip = on.
*       Übergebene Bewegung ändern oder anzeigen
        IF NOT lt_nbew[] IS INITIAL.
          l_skip_caselist = on.
          READ TABLE lt_nbew INTO l_nbew INDEX 1.
          l_call_adm-lfdnr = l_nbew-lfdnr.
        ENDIF.
      ENDIF.
    ENDIF.

  ELSE.

    l_skip = off.

  ENDIF.

* Setzen des Transaktionscode
*-----------------------------
  CASE i_fcode.
*----------------
    WHEN 'AAAL'.
*----------------
      IF l_nbr_marked = 0.
        l_tcode = 'NV41'.
      ELSE.
        IF l_npat-patnr IS INITIAL.
          l_tcode = 'NV41'.
        ELSE.
          l_tcode = 'NV42'.
        ENDIF.
      ENDIF.
*----------------
    WHEN 'AAAE'.
*----------------
      IF l_npat-patnr IS INITIAL.
        l_tcode = 'NV41'.
      ELSE.
        l_tcode = 'NV42'.
      ENDIF.
*----------------
    WHEN 'AAAZ'.
*----------------
      l_tcode = 'NV43'.
*----------------
    WHEN 'SAAL'.
*----------------
      IF l_nbr_marked = 0.
        l_tcode = 'NV01'.
      ELSE.
        IF l_npat-patnr IS INITIAL.
          l_tcode = 'NV01'.
        ELSE.
          l_tcode = 'NV02'.
        ENDIF.
      ENDIF.
*----------------
    WHEN 'SAAE'.
*----------------
      IF l_npat-patnr IS INITIAL.
        l_tcode = 'NV01'.
      ELSE.
        l_tcode = 'NV02'.
      ENDIF.
*----------------
    WHEN 'SAAZ'.
*----------------
      l_tcode = 'NV03'.
*----------------
    WHEN 'AKAL'.
*----------------
      IF l_nbr_marked = 0.
        l_tcode = 'NV44'.
      ELSE.
        IF l_npat-patnr IS INITIAL.
          l_tcode = 'NV44'.
        ELSE.
          l_tcode = 'NV45'.
        ENDIF.
      ENDIF.
*----------------
    WHEN 'AKAE'.
*----------------
      IF l_npat-patnr IS INITIAL.
        l_tcode = 'NV44'.
      ELSE.
        l_tcode = 'NV45'.
      ENDIF.
*----------------
    WHEN 'AKAZ'.
*----------------
      l_tcode = 'NV46'.
*----------------
    WHEN 'SKAL'.
*----------------
      IF l_nbr_marked = 0.
        l_tcode = 'NV04'.
      ELSE.
        IF l_npat-patnr IS INITIAL.
          l_tcode = 'NV04'.
        ELSE.
          l_tcode = 'NV05'.
        ENDIF.
      ENDIF.
*----------------
    WHEN 'SKAE'.
*----------------
      IF l_npat-patnr IS INITIAL.
        l_tcode = 'NV04'.
      ELSE.
        l_tcode = 'NV05'.
      ENDIF.
*----------------
    WHEN 'SKAZ'.
*----------------
      l_tcode = 'NV06'.
*----------------
    WHEN 'ANAL'.
*----------------
      IF l_nbr_marked = 0.
        l_tcode = 'NV47'.
      ELSE.
        IF l_npat-patnr IS INITIAL.
          l_tcode = 'NV47'.
        ELSE.
          l_tcode = 'NV48'.
        ENDIF.
      ENDIF.
*----------------
    WHEN 'ANAE'.
*----------------
      IF l_npat-patnr IS INITIAL.
        l_tcode = 'NV47'.
      ELSE.
        l_tcode = 'NV48'.
      ENDIF.
*----------------
    WHEN 'ANAZ'.
*----------------
      l_tcode = 'NV49'.
*----------------
    WHEN 'SNAL'.
*----------------
      IF l_nbr_marked = 0.
        l_tcode = 'NV07'.
      ELSE.
        IF l_npat-patnr IS INITIAL.
          l_tcode = 'NV07'.
        ELSE.
          l_tcode = 'NV05'.
        ENDIF.
      ENDIF.
*----------------
    WHEN 'SNAE'.
*----------------
      IF l_npat-patnr IS INITIAL.
        l_tcode = 'NV07'.
      ELSE.
        l_tcode = 'NV08'.
      ENDIF.
*----------------
    WHEN 'SNAZ'.
*----------------
      l_tcode = 'NV09'.
  ENDCASE.

* Termin mit ambulanter Aufnahmebewegung verbinden?
* Aber nur dann, wenn etwas markiert worden ist
* und wenn das markierte Objekt (z.B eine Leistung) mit einem
* Termin verbunden oder selbst ein Termin ist
* (nicht für Sichttyp OP!)
  IF     i_fcode(1)    = 'A'                         AND
     NOT l_ntmn-tmnid IS INITIAL                     AND
         l_ntmn-tmnlb IS INITIAL                     AND
         l_nbr_marked  = 1                           AND
         l_caller     <> 'NWP011'.
    l_connect_app_to_mvmt = on.
  ELSE.
    l_connect_app_to_mvmt = off.
  ENDIF.

* ID 14602: preallocate movement type from set/get-parameter NBO/NPO?
*           (only for viewtype OP!)
  IF i_fcode        = 'AAAL'    AND
     l_erboe-orgid IS INITIAL   AND
     l_caller       = 'NWP011'.
    l_oe_from_nbo = on.
  ELSE.
    l_oe_from_nbo = off.
  ENDIF.

* Vorbelegungfunktionsbaustein
  CALL FUNCTION 'ISHMED_PREPARE_ADMISSION'
    EXPORTING
      i_einri              = i_einri
      i_falnr              = l_nfal-falnr
      i_erboe              = l_erboe-orgid
      i_connect_app_to_mvt = l_connect_app_to_mvmt
      i_oe_from_nbo        = l_oe_from_nbo                  " ID 14602
      i_caller             = i_caller
      i_tmnid              = l_ntmn-tmnid
      i_vcode              = i_fcode
      i_tcode              = l_tcode
    IMPORTING
      e_rnadp              = l_rnadp.

* Aufnahme aufrufen
  CALL FUNCTION 'ISHMED_CALL_ADMISSION'
    EXPORTING
      i_tcode         = l_tcode
      i_fcode         = l_caller
      i_search        = on
      i_n1vkg         = l_n1vkg
      i_ntmn          = l_ntmn
      i_nlei          = l_nlei
      i_npap          = l_npap
      i_einri         = i_einri
      i_other_data    = l_call_adm
      i_skip          = l_skip
      i_skip_caselist = l_skip_caselist
      i_rnadp         = l_rnadp
      i_environment   = c_environment
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = c_errorhandler.

  CASE e_rc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
      IF   i_fcode EQ 'AAAL' OR i_fcode EQ 'SAAL' OR
           i_fcode EQ 'AKAL' OR i_fcode EQ 'SKAL' OR
           i_fcode EQ 'ANAL' OR i_fcode EQ 'SNAL'.
*       Nach Anlegen alles aktualisieren
        e_refresh = 2.
      ELSEIF i_fcode EQ 'AAAE' OR i_fcode EQ 'SAAE' OR
             i_fcode EQ 'AKAE' OR i_fcode EQ 'SKAE' OR
             i_fcode EQ 'ANAE' OR i_fcode EQ 'SNAE'.
*       Nach Ändern nur die Zeile aktualisieren
        e_refresh = 1.
      ELSE.
*       Nach Anzeigen nichts aktualisieren
        e_refresh = 0.
      ENDIF.
    WHEN OTHERS.
*     Error occured
      e_rc      = 1.
      e_refresh = 0.
  ENDCASE.

  CLEAR l_rnmem.
  EXPORT ish_call_aufn_memory FROM l_rnmem
         TO MEMORY ID 'ISH_CALL_AUFN_MEMORY'.
  CLEAR l_rnadp.
  EXPORT ish_amb_dispo FROM l_rnadp
         TO MEMORY ID 'ISH_AMB_DISPO'.

ENDMETHOD.


METHOD call_appointment_calendar .

  DATA: lt_rn1po_call      TYPE TABLE OF rn1po_call,
        l_rn1po_call       LIKE LINE OF lt_rn1po_call,
        lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_nbew            TYPE ishmed_t_nbew,
        l_nbew             LIKE LINE OF lt_nbew,
        l_plnoe            TYPE orgid,
        ls_parameter       TYPE rn1parameter.

* Initialisierungen
  CLEAR e_rc.
*  e_refresh = 0.                      "REM ID 17398
*   recognize changes in patient screen
  e_refresh = 1.                       "ID 17398
  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Egal was markiert ist
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = ' '                                  " 0 - n
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierte (vorläufige) Patienten und Fälle ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Markierte Bewegungen ermitteln
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nbew        = lt_nbew
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Patienten in Übergabetabelle stellen
  LOOP AT lt_npat INTO l_npat.
    READ TABLE lt_nfal INTO l_nfal WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR l_nfal.
    ELSE.
      READ TABLE lt_nbew INTO l_nbew WITH KEY falnr = l_nfal-falnr.
      IF sy-subrc <> 0.
        CLEAR l_nbew.
      ENDIF.
    ENDIF.
    READ TABLE lt_rn1po_call INTO l_rn1po_call
         WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR: l_rn1po_call.
      l_rn1po_call-patnr = l_npat-patnr.
      l_rn1po_call-pziff = l_npat-pziff.
      l_rn1po_call-einri = i_einri.
      l_rn1po_call-falnr = l_nfal-falnr.
      l_rn1po_call-fziff = l_nfal-fziff.
      l_rn1po_call-falar = ' '.
      l_rn1po_call-lfdbew = l_nbew-lfdnr.
      l_rn1po_call-lfddia = ' '.
      l_rn1po_call-orgpf  = ' '.
      l_rn1po_call-orgfa  = ' '.
      l_rn1po_call-uname  = sy-uname.
      l_rn1po_call-orgid  = ' '.
      l_rn1po_call-repid  = sy-repid.
      l_rn1po_call-viewid = ' '.
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

* vorläufige Patienten in Übergabetabelle stellen
  LOOP AT lt_npap INTO l_npap.
    READ TABLE lt_rn1po_call INTO l_rn1po_call
      WITH KEY papid = l_npap-papid.
    IF sy-subrc <> 0.
      CLEAR: l_rn1po_call.
      l_rn1po_call-papid = l_npap-papid.
      l_rn1po_call-einri = i_einri.
      l_rn1po_call-falar = ' '.
      l_rn1po_call-lfddia = ' '.
      l_rn1po_call-orgpf  = ' '.
      l_rn1po_call-orgfa  = ' '.
      l_rn1po_call-uname  = sy-uname.
      l_rn1po_call-orgid  = ' '.
      l_rn1po_call-repid  = sy-repid.
      l_rn1po_call-viewid = ' '.
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

* get planning ou from parameter table
  CLEAR l_plnoe.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
  IF sy-subrc = 0.
    l_plnoe = ls_parameter-value.
  ENDIF.

* FBS zum Vorbereiten des Patientenorganizers aufrufen
  CALL FUNCTION 'ISHMED_DISPLAY_APPCAL'
    EXPORTING
      i_einri       = i_einri
      i_popup       = 'X'
      i_plnoe       = l_plnoe
    TABLES
      it_rn1po_call = lt_rn1po_call.

ENDMETHOD.


METHOD call_appointment_planning .

  DATA: l_rc               TYPE ish_method_rc,
        l_count            TYPE i,
        l_cancel           TYPE ish_on_off,
        l_planoe           TYPE orgid,
        l_usage            TYPE n1plusage,
        ls_object          LIKE LINE OF it_objects,
        ls_parameter       LIKE LINE OF it_parameter,
        lt_obj             TYPE ish_objectlist,
        lt_none_oo         TYPE ish_objectlist,
        lt_workpool        TYPE ishmed_t_pg_workpool,
        ls_workpool        LIKE LINE OF lt_workpool,
        lr_planning_grid   TYPE REF TO cl_ishmed_planning_grid,
        lr_app_offer       TYPE REF TO cl_ish_app_offer_handling.

* initialization
  CLEAR e_rc.
  e_refresh = 0.
  e_func_done = true.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* no matter what is marked ...
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = ' '                                  " 0 - n
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* get planning ou from parameter table
  CLEAR l_planoe.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
  IF sy-subrc = 0.
    l_planoe = ls_parameter-value.
  ENDIF.

* get type of planning from parameter table
  CLEAR l_usage.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '009'.
  IF sy-subrc = 0.
    l_usage = ls_parameter-value.
  ELSE.
    l_usage = co_usage_general.
  ENDIF.

* set objects for planning
  CLEAR: l_count, lt_workpool[], lt_obj[], lt_none_oo[].
  CALL FUNCTION 'ISHMED_DIVIDE_OBJECT'
    EXPORTING
      it_object         = it_objects
    IMPORTING
      e_rc              = l_rc
      et_object_oo      = lt_obj
      et_object_none_oo = lt_none_oo
    CHANGING
      c_errorhandler    = c_errorhandler.
  IF l_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.
  LOOP AT lt_obj INTO ls_object.
    CLEAR ls_workpool.
    ls_workpool-object ?= ls_object-object.
    ADD 1 TO l_count.
    ls_workpool-sort = l_count.
    APPEND ls_workpool TO lt_workpool.
  ENDLOOP.
  LOOP AT lt_none_oo INTO ls_object.
    CLEAR ls_workpool.
    ls_workpool-none_oo_data ?= ls_object-object.
    ADD 1 TO l_count.
    ls_workpool-sort = l_count.
    APPEND ls_workpool TO lt_workpool.
  ENDLOOP.

* create appointment offer instance
  CALL METHOD cl_ish_fac_app_offer_handling=>create
    IMPORTING
      er_instance     = lr_app_offer
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* create planning grid instance
  CALL METHOD cl_ishmed_planning_grid=>create
    EXPORTING
      i_einri        = i_einri
    IMPORTING
      e_instance     = lr_planning_grid
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* call planning grid
  CALL METHOD lr_planning_grid->call_planning_grid
    EXPORTING
      i_planoe        = l_planoe
      ir_env          = c_environment
      ir_app_srch     = lr_app_offer
      i_usage         = l_usage
      it_workpool     = lt_workpool
    IMPORTING
      e_cancel        = l_cancel
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = c_errorhandler
      cr_lock         = c_lock.
  IF l_rc = 0.
    IF l_cancel = on.
      e_rc = 2.
      e_refresh = 0.
    ELSE.
      e_rc = 0.
      e_refresh = 2.
    ENDIF.
  ELSE.
    e_rc = 1.
    e_refresh = 0.
  ENDIF.

ENDMETHOD.


METHOD call_app_changedoc .

  DATA: lt_apps             TYPE ishmed_t_appointment_object.

* START MED-33294
  DATA: l_lines  TYPE I.
  DATA: lr_app   TYPE REF TO cl_ish_appointment,
        lx_static TYPE REF TO cx_ish_static_handler.
* END MED-33294

* initialization
  CLEAR: e_rc.

  e_refresh   = 0.
  e_func_done = true.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* check number of marked lines
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " >= 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get appointments
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects      = it_objects
    IMPORTING
      e_rc            = e_rc
      et_appointments = lt_apps
    CHANGING
      c_environment   = c_environment
      c_errorhandler  = c_errorhandler.
  CHECK e_rc = 0.

  IF lt_apps[] IS INITIAL.
*   Bitte wählen Sie einen gültigen Termin aus.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1APMG_MED'
        i_num  = '015'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.

* START MED-33294 HP 2008/10/29
  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
    DESCRIBE TABLE lt_apps[] LINES l_lines.
    IF l_lines = 1.
      TRY.
        READ TABLE lt_apps[] INTO lr_app INDEX 1.
        IF sy-subrc = 0.
          CALL METHOD cl_ish_cdo_ga_apps=>execute
          EXPORTING
            ir_app = lr_app.
        ENDIF.
      CATCH cx_ish_static_handler INTO lx_static.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lx_static
        CHANGING
          cr_errorhandler = c_errorhandler.
        e_rc = 1.
      ENDTRY.
      RETURN.
    ENDIF.
  ENDIF.
* END MED-33294

* call popup to display change documents
  CALL METHOD cl_ish_utl_apmg=>show_changedoc_app
    EXPORTING
      it_apps         = lt_apps
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.

  CASE e_rc.
    WHEN 0.
*     Everything OK
      e_refresh = 0.
    WHEN OTHERS.
*     Error occured
      e_rc      = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_app_plan_search .

  DATA: l_rc               TYPE ish_method_rc,
        l_count            TYPE i,
        l_check_type       TYPE n1nbrlines_check_type,
        l_cancel           TYPE ish_on_off,
        l_planoe           TYPE orgid,
        l_erboe            TYPE orgid,
        l_usage            TYPE n1plusage,
        l_exit_code        TYPE sy-tcode,
        l_retmaxtyp        TYPE ish_bapiretmaxty,
        l_patnr            TYPE patnr,
        l_papid            TYPE ish_papid,
        lt_npat            TYPE ishmed_t_npat,
        ls_npat            LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        ls_npap            LIKE LINE OF lt_npap,
        lt_srch_prof       TYPE TABLE OF rnapp9h,
        ls_srch_prof       TYPE rnapp9h,
        lt_srch_prof_pos   TYPE TABLE OF rnapp9p,
        ls_srch_prof_pos   TYPE rnapp9p,
        lt_msg             TYPE ishmed_t_bapiret2,
        ls_msg             LIKE LINE OF lt_msg,
        ls_n1apcn          TYPE n1apcn,
        ls_object          LIKE LINE OF it_objects,
        ls_parameter       LIKE LINE OF it_parameter,
        lt_erboe           TYPE ishmed_t_orgid,
        ls_erboe           LIKE LINE OF lt_erboe,
        lt_obj             TYPE ish_objectlist,
        lt_none_oo         TYPE ish_objectlist,
        lt_workpool        TYPE ishmed_t_pg_workpool,
        ls_workpool        LIKE LINE OF lt_workpool,
        lr_plan_func       TYPE REF TO cl_ishmed_prc_planning_func,
        lr_plan            TYPE REF TO cl_ish_prc_planning_func,
        lr_app_constr      TYPE REF TO cl_ish_app_constraint.

* initialization
  CLEAR e_rc.
  e_refresh = 0.
  e_func_done = true.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* check number of marked entries
  IF i_fcode = 'OUTP_SCHED'.
    l_check_type = '0'.                                     " 0 or 1
  ELSE.      " (APP_SEARCH)
    CLEAR l_check_type.            " no matter what is marked ...
  ENDIF.
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = l_check_type
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* get treating ou from parameter table or given objects
  CLEAR l_erboe.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '016'.
  IF sy-subrc = 0.
    l_erboe = ls_parameter-value.
  ENDIF.
  IF l_erboe IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_erboes
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_erboe       = lt_erboe
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_erboe INTO ls_erboe INDEX 1.
    IF sy-subrc = 0.
      l_erboe = ls_erboe-orgid.
    ENDIF.
  ENDIF.

  IF i_fcode = 'OUTP_SCHED'.

    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_npat        = lt_npat
        et_npap        = lt_npap
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.

    READ TABLE lt_npat INTO ls_npat INDEX 1.
    IF sy-subrc = 0.
      l_patnr = ls_npat-patnr.
    ENDIF.
    READ TABLE lt_npap INTO ls_npap INDEX 1.
    IF sy-subrc = 0.
      l_papid = ls_npap-papid.
    ENDIF.

    CLEAR ls_srch_prof.
    ls_srch_prof-einri = i_einri.
    ls_srch_prof-srchd = sy-datum.
    APPEND ls_srch_prof TO lt_srch_prof.

    CLEAR ls_srch_prof_pos.
    ls_srch_prof_pos-attou = l_erboe.
*    ls_srch_prof_pos-attfa = l_dept_ou.
*    ls_srch_prof_pos-pernr = l_pernr.
*    ls_srch_prof_pos-room  = l_room.
    APPEND ls_srch_prof_pos TO lt_srch_prof_pos.

    CALL FUNCTION 'ISH_OUTPATIENT_SCHEDULER'
      EXPORTING
        si_institution            = i_einri
        si_patnr                  = l_patnr
        si_papid                  = l_papid
        si_environment            = c_environment
        si_lock                   = c_lock
      IMPORTING
        se_exit_code              = l_exit_code
        se_retmaxtype             = l_retmaxtyp
      TABLES
        si_profile_treatm_unit    = lt_srch_prof
        si_profile_treatm_unitpos = lt_srch_prof_pos
        se_return_tab             = lt_msg.

    IF l_exit_code = 'CAN'.
      e_rc = 2.                   " cancel
      e_refresh = 0.
    ELSE.
      IF l_retmaxtyp IS INITIAL.
        e_rc = 0.
        e_refresh = 2.
      ELSE.
        IF l_retmaxtyp = 'A' OR
           l_retmaxtyp = 'E' OR
           l_retmaxtyp = 'W'.
          e_rc = 1.
          e_refresh = 0.
        ELSE.
          e_rc = 0.
          e_refresh = 2.
        ENDIF.
        LOOP AT lt_msg INTO ls_msg.
          CALL METHOD cl_ish_utl_base=>collect_messages_by_bapiret
            EXPORTING
              i_bapiret       = ls_msg
            CHANGING
              cr_errorhandler = c_errorhandler.
        ENDLOOP.
      ENDIF.
    ENDIF.

  ELSE.      " (APP_SEARCH)

*   get planning ou from parameter table
    CLEAR l_planoe.
    READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
    IF sy-subrc = 0.
      l_planoe = ls_parameter-value.
    ENDIF.

*   get type of planning from parameter table
    CLEAR l_usage.
    READ TABLE it_parameter INTO ls_parameter WITH KEY type = '009'.
    IF sy-subrc = 0.
      l_usage = ls_parameter-value.
    ELSE.
      l_usage = co_usage_general.
    ENDIF.

*   set objects for planning
    CLEAR: l_count, lt_workpool[], lt_obj[], lt_none_oo[].
    CALL FUNCTION 'ISHMED_DIVIDE_OBJECT'
      EXPORTING
        it_object         = it_objects
      IMPORTING
        e_rc              = l_rc
        et_object_oo      = lt_obj
        et_object_none_oo = lt_none_oo
      CHANGING
        c_errorhandler    = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    LOOP AT lt_obj INTO ls_object.
      CLEAR ls_workpool.
      ls_workpool-object ?= ls_object-object.
      ADD 1 TO l_count.
      ls_workpool-sort = l_count.
      APPEND ls_workpool TO lt_workpool.
    ENDLOOP.
    LOOP AT lt_none_oo INTO ls_object.
      CLEAR ls_workpool.
      ls_workpool-none_oo_data ?= ls_object-object.
      ADD 1 TO l_count.
      ls_workpool-sort = l_count.
      APPEND ls_workpool TO lt_workpool.
    ENDLOOP.

    CASE l_usage.
      WHEN co_usage_general OR
           co_usage_initial_visit.
*       create appointment constraint with treatment OU
        IF l_erboe IS NOT INITIAL.
          CLEAR ls_n1apcn.
          ls_n1apcn-mandt = sy-mandt.
          ls_n1apcn-einri = i_einri.
          ls_n1apcn-trtoe = l_erboe.
          CALL METHOD cl_ish_app_constraint=>create
            EXPORTING
              is_n1apcn       = ls_n1apcn
              ir_environment  = c_environment
            IMPORTING
              er_instance     = lr_app_constr
              e_rc            = l_rc
            CHANGING
              cr_errorhandler = c_errorhandler.
          IF l_rc <> 0.
            e_rc = 1.
            EXIT.
          ENDIF.
        ENDIF.
      WHEN OTHERS.
*       follow-up-visit, ...
        CLEAR lr_app_constr.
    ENDCASE.

*   create planning function instance
    CALL METHOD cl_ish_fac_prc_planning_func=>create
      IMPORTING
        er_instance     = lr_plan
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    IF lr_plan IS BOUND.
      CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
        lr_plan_func ?= lr_plan.
      ENDCATCH.
    ENDIF.

*   set planning OU
    IF l_planoe IS NOT INITIAL.
      CALL METHOD lr_plan_func->set_planning_ou
        EXPORTING
          i_planoe = l_planoe.
    ENDIF.

*   call planning with search
    CALL METHOD lr_plan_func->planning_with_search
      EXPORTING
        i_with_dialog   = on
        i_einri         = i_einri
        i_caller        = i_caller
        i_usage         = l_usage
        i_save          = i_save
        it_workpool     = lt_workpool
        ir_environment  = c_environment
      IMPORTING
        e_rc            = l_rc
        e_cancel        = l_cancel
      CHANGING
        cr_app_constr   = lr_app_constr
        cr_errorhandler = c_errorhandler
        cr_lock         = c_lock.

    IF l_rc = 0.
      IF l_cancel = on.
        e_rc = 2.
        e_refresh = 0.
      ELSE.
        e_rc = 0.
        e_refresh = 2.
      ENDIF.
    ELSE.
      e_rc = 1.
      e_refresh = 0.
    ENDIF.

  ENDIF.

ENDMETHOD.


METHOD call_case_assign .

  DATA: l_name(50)         TYPE c,
        l_falnr_assigned   TYPE falnr,
        lt_lnrls           TYPE TABLE OF rn1lnrls,
        ls_lnrls           LIKE LINE OF lt_lnrls,
        ls_exp_value       LIKE LINE OF et_expvalues,
        lt_n1anf           TYPE ishmed_t_n1anf,
        lt_n1vkg           TYPE ishmed_t_n1vkg,
        lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap.

* Begin Siegl MED-67096
  DATA: lr_object      TYPE ish_object,
        lr_identify    TYPE REF TO if_ish_identify_object,
        lr_appointment TYPE REF TO cl_ish_appointment,
        ls_ntmn        TYPE ntmn,
        lt_ntmn        TYPE TABLE OF ntmn.
* End Siegl MED-67096

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_nfal, l_npat, l_npap, l_falnr_assigned.

  REFRESH: lt_nfal, lt_npat, lt_npap, lt_n1anf, lt_n1vkg, lt_lnrls.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierte (vorläufige) Patienten und Fälle ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
      i_read_db      = on
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_npat INTO l_npat INDEX 1.
  READ TABLE lt_npap INTO l_npap INDEX 1.
  READ TABLE lt_nfal INTO l_nfal INDEX 1.

* Name des Patienten ermitteln
  CLEAR l_name.
  CALL METHOD cl_ish_utl_base_patient=>get_name_patient
    EXPORTING
      i_patnr = l_npat-patnr
      i_papid = l_npap-papid
      is_npat = l_npat
      is_npap = l_npap
    IMPORTING
      e_pname = l_name.

* Objekt bereits mit Fall verbunden?
  IF NOT l_nfal-falnr IS INITIAL.
    CASE i_caller.
      WHEN 'NWP011'.
*       Operation für & hat bereits einen Fall
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '142'
            i_mv1  = l_name
            i_last = space.
      WHEN OTHERS.
*       Funktion nur für fallfreie Leistungen und Termine möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '669'
            i_last = space.
    ENDCASE.
    e_rc      = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Vorläufigen Patienten in echten Patienten 'umwandeln'
  IF l_npat-patnr IS INITIAL AND NOT l_npap-papid IS INITIAL.
    CALL METHOD cl_ishmed_functions=>switch_and_delete_npap
      EXPORTING
        i_einri        = i_einri
*       I_PROVPAT      =
        i_papid        = l_npap-papid
        i_save         = i_save
*       i_commit       = i_commit          " REM MED-34033
        i_commit       = off                    " MED-34033
      IMPORTING
        e_patnr        = l_npat-patnr
        e_rc           = e_rc
      CHANGING
        c_errorhandler = c_errorhandler
        c_environment  = c_environment.
    CHECK e_rc = 0.
  ENDIF.

* Anforderung ermitteln
  CALL METHOD cl_ishmed_functions=>get_requests
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_n1anf       = lt_n1anf
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Klin. Auftragsposition ermitteln
  CALL METHOD cl_ishmed_functions=>get_preregistrations
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_n1vkg       = lt_n1vkg
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
* Begin Siegl MED-67096
* get appointments
  CLEAR lt_ntmn.
  LOOP AT it_objects INTO lr_object.
    lr_identify ?= lr_object-object.
    IF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
      lr_appointment ?= lr_object-object.
      CALL METHOD lr_appointment->get_data
        IMPORTING
          es_ntmn        = ls_ntmn
          e_rc           = e_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
      APPEND ls_ntmn TO lt_ntmn.
    ENDIF.
  ENDLOOP.
* End Siegl MED-67096
* Fallbezug herstellen
  CALL FUNCTION 'ISHMED_MAKE_FALLBEZUG'
    EXPORTING
      i_einri          = i_einri
*     I_NFAL           =
      i_npat           = l_npat
*     I_NBEW           =
            i_popup       = 'B'
            i_mode        = 'U'
            i_savetab     = i_save
            i_check_lock_pat  = 'X'           "MED-42937
            i_check_case  = 'X'
            i_commit      = i_commit
            i_papid       = l_npap-papid
*           Fichte, MED-42206: Get Environment from NPOL. If we would
*           not do so, we would save the NPAP a second time, which
*           would cause a dump!
            i_npol        = on
*           Fichte, MED-42206 - End
       IMPORTING
            e_falnr       = l_falnr_assigned
       TABLES
            t_n1anf       = lt_n1anf
            t_n1vkg       = lt_n1vkg
      t_ntmn           = lt_ntmn    "MED-67096
      to_lnrls         = lt_lnrls
       EXCEPTIONS
            fal_not_fnd   = 1
            no_anf_vkg    = 2
            fal_not_valid = 3
            cancel        = 4
            OTHERS        = 5.
  CASE sy-subrc.
    WHEN 0.                                                 " OK
      e_rc = 0.
*      e_refresh = 1.                                   " REM ID 20731
      e_refresh = 2.                                        " ID 20731
*     fill export values
      CLEAR ls_exp_value.
      ls_exp_value-type  = '003'.
      ls_exp_value-value = l_falnr_assigned.
      APPEND ls_exp_value TO et_expvalues.
      LOOP AT lt_lnrls INTO ls_lnrls.
        CLEAR ls_exp_value.
        ls_exp_value-type  = '004'.
        ls_exp_value-value = ls_lnrls.                      "#EC ENHOK
        APPEND ls_exp_value TO et_expvalues.
      ENDLOOP.
      SHIFT l_falnr_assigned LEFT DELETING LEADING '0'.
*     &: Zuordnung zu Fall Nr. & erfolgreich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'S'
          i_kla  = 'NF1'
          i_num  = '133'
          i_mv1  = l_name
          i_mv2  = l_falnr_assigned
          i_last = space.
    WHEN 4.                                                 " Cancel
      e_rc = 2.
*      e_refresh = 0.           "MED-59988   AGujev
*MED-59988 AGujev - when the dialog is canceled the depending objects must be refreshed
*otherwise it can happen that the selected patient remains linked with the order position/service
      e_refresh = 1.            "MED-59988   AGujev
*   when the dialog was cancelled, the NPAP should not be cleared.
*   in this case a rollback work is useful.
        ROLLBACK WORK.                                      "MED-34033
    WHEN 2.                                                 " no Error
    WHEN OTHERS.                                            " Error
      e_rc = 1.
      e_refresh = 0.
      IF NOT sy-msgid IS INITIAL AND NOT sy-msgno IS INITIAL.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          CHANGING
            cr_errorhandler = c_errorhandler.
      ELSE.
*       Es konnte kein gültiger Fall für diesen Patienten gef. werden
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '140'
            i_mv1  = l_name
            i_last = space.
      ENDIF.
  ENDCASE.

ENDMETHOD.


METHOD call_chain_app .

  DATA: lt_objects       TYPE ish_objectlist,
        ls_object        TYPE ish_object,
        lt_apps          TYPE ishmed_t_appointment_object,
        lr_app           TYPE REF TO cl_ish_appointment,
        lt_nbew          TYPE ishmed_t_nbew,
        l_parameter      LIKE LINE OF it_parameter,
        lr_plan_list     TYPE REF TO cl_ish_planning_list,
        lr_plan_list_med TYPE REF TO cl_ishmed_planning_list,
        lr_fct_planning  TYPE REF TO cl_ish_fct_planning,
        l_is_inh         TYPE ish_on_off,
        l_vcode          TYPE ish_vcode,
        l_usage          TYPE n1plusage,
        l_rc             TYPE ish_method_rc,
        l_cancelled      TYPE ish_on_off,
        l_plan_oe        TYPE norg-orgid,
        l_orgid          TYPE norg-orgid,
        l_no_cancel      TYPE ish_on_off,
        lr_con_cancel_med TYPE REF TO cl_ishmed_con_cancel, "18553
        lr_con_cancel     TYPE REF TO cl_ish_con_cancel.    "18553

* initializations
  e_rc        = 0.
  e_refresh   = 0.
  e_func_done = true.

* create errorhandler if not provided
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
    CHECK NOT c_environment IS INITIAL.
  ENDIF.

* check number of marked rows
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                 " only just 1 entry allowed
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get marked appointments
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects        = it_objects
      i_cancelled_datas = on
    IMPORTING
      e_rc              = e_rc
      et_appointments   = lt_apps
    CHANGING
      c_environment     = c_environment
      c_errorhandler    = c_errorhandler.
  CHECK e_rc = 0.

* check if appointments have been marked
  IF lt_apps[] IS INITIAL.
*   Bitte wählen Sie genau einen Serientermin
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1APMG'
        i_num  = '037'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.

* check if appointment is a chain appointment
  LOOP AT lt_apps INTO lr_app.
    IF lr_app->is_part_of_chain( ) = off.
*     Der gewählte Termin ist kein Serientermin
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1APMG_MED'
          i_num  = '092'
          i_last = space.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

* get planning OU
  LOOP AT it_parameter INTO l_parameter WHERE type = '005'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_plan_oe = l_parameter-value.
    EXIT.
  ENDLOOP.

* call requested function now
  CASE i_fcode.
    WHEN 'CHAIN_DIS' OR 'CHAIN_UPD'.
*     - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*     display/update chain appointment (Serie anzeigen/ändern)
*     - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      READ TABLE lt_apps INTO lr_app INDEX 1.
      CHECK sy-subrc = 0.
      CASE i_fcode.
        WHEN 'CHAIN_DIS'.
          l_vcode = co_vcode_display.
        WHEN 'CHAIN_UPD'.
          l_vcode = co_vcode_update.
        WHEN OTHERS.
          EXIT.
      ENDCASE.
      CLEAR: lr_plan_list, lr_plan_list_med.
      CALL METHOD cl_ish_fac_planning_list=>create
        EXPORTING
          i_einri         = i_einri
        IMPORTING
          er_instance     = lr_plan_list
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      CHECK e_rc = 0 AND lr_plan_list IS BOUND.
      IF lr_plan_list->is_a(
            cl_ishmed_planning_list=>co_otype_planning_list_med ) = on.
        lr_plan_list_med ?= lr_plan_list.
        CALL METHOD lr_plan_list_med->set_planning_ou
          EXPORTING
            i_planoe = l_plan_oe.
      ENDIF.
*     get instance of planning function
      CLEAR lr_fct_planning.
      LOOP AT it_parameter INTO l_parameter WHERE type = '000'.
        CHECK NOT l_parameter-object IS INITIAL.
        CALL METHOD l_parameter-object->('IS_INHERITED_FROM')
          EXPORTING
            i_object_type       = cl_ishmed_fct_planning=>co_otype_fct_planning
          RECEIVING
            r_is_inherited_from = l_is_inh.
        IF l_is_inh = on.
          lr_fct_planning ?= l_parameter-object.
        ENDIF.
      ENDLOOP.
      l_usage = if_ishmed_pl_usage_constants=>co_usage_general.
*     call function to display/change chain appointment
      CALL METHOD lr_plan_list->call_planning_list
        EXPORTING
          ir_app          = lr_app
          i_save          = i_save
          i_commit        = i_commit
          ir_fct_planning = lr_fct_planning
          ir_env          = c_environment
          i_usage         = l_usage
          i_vcode         = l_vcode
        IMPORTING
          e_rc            = l_rc
          e_cancel        = l_no_cancel
        CHANGING
          cr_lock         = c_lock
          cr_errorhandler = c_errorhandler.
      IF l_no_cancel = on.
*       cancel (Abbrechen)
        e_rc = 2.
        e_refresh = 0.
        EXIT.
      ENDIF.
      CASE l_rc.
        WHEN 0.
*         everything OK
          e_rc = 0.
          IF l_vcode <> co_vcode_display.
*           refresh whole list
            e_refresh = 2.
          ENDIF.
        WHEN OTHERS.
*         error (Fehler)
          e_rc = 1.
          e_refresh = 0.
      ENDCASE.
    WHEN 'CHAIN_CANC'.
*     - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*     cancel chain appointment (Serie stornieren)
*     - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
*     check if appointment is already cancelled
      LOOP AT lt_apps INTO lr_app.
        CALL METHOD lr_app->is_cancelled
          IMPORTING
            e_cancelled = l_cancelled.
        IF l_cancelled = on.
*         Der Termin ist bereits storniert
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1APMG'
              i_num  = '010'
              i_last = space.
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDLOOP.
      CHECK e_rc = 0.
*     get OU of appointment for cancel
      READ TABLE lt_apps INTO lr_app INDEX 1.
      CALL METHOD lr_app->if_ish_objectbase~get_data_field
        EXPORTING
          i_fieldname    = 'TMNOE'
        IMPORTING
          e_rc           = l_rc
          e_field        = l_orgid
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
*     set appointments to cancel
      REFRESH lt_objects.
      LOOP AT lt_apps INTO lr_app.
        CLEAR ls_object.
        ls_object-object = lr_app.
        APPEND ls_object TO lt_objects.
      ENDLOOP.
      CHECK e_rc = 0.
*     get movements for all appointments
      CALL METHOD cl_ishmed_functions=>get_apps_and_movs
        EXPORTING
          it_objects        = lt_objects
          i_cancelled_datas = off
        IMPORTING
          e_rc              = e_rc
          et_nbew           = lt_nbew
        CHANGING
          c_environment     = c_environment
          c_errorhandler    = c_errorhandler.
      CHECK e_rc = 0.

*     ------- ------ ------
*     ID 18553 - begin
*     get ref con cancel to cancel apps
      CALL METHOD cl_ish_utl_apmg=>get_ref_con_cancel
        EXPORTING
          i_cancel_chain_apps        = on
          i_check_planning_completed = on
        IMPORTING
          er_con_cancel              = lr_con_cancel
          e_rc                       = e_rc
        CHANGING
          cr_errorhandler            = c_errorhandler.
      CHECK e_rc = 0.
*     ------- ------ ------
      IF lr_con_cancel->is_inherited_from(
                cl_ishmed_con_cancel=>co_otype_con_cancel_med ) = on.
        lr_con_cancel_med ?= lr_con_cancel.
*       -------- --------
        CALL METHOD lr_con_cancel_med->set_planning_ou
          EXPORTING
            i_planning_ou = l_plan_oe.
*       -------- --------
        CALL METHOD lr_con_cancel_med->set_check_emergency_op
          EXPORTING
            i_check_emergency_op = on.
      ENDIF.
*     ID 18553 - end
*     -------- -------- --------
*     call cancel function
*     CM, 08.03.2013, MED-41948, Begin
*      CALL METHOD cl_ish_environment=>cancel_objects
*        EXPORTING
*          it_objects            = lt_objects
*          it_nbew               = lt_nbew
*          i_popup               = on
*          i_authority_check     = on
*          i_orgid               = l_orgid
*          i_caller              = i_caller
*          i_last_srv_cancel     = on
*          i_app_cancel          = on
*          i_srv_cancel          = off
*          i_vkg_cancel          = off
*          i_req_cancel          = off
*          i_corder_cancel       = off
*          i_pap_cancel          = off
*          i_srv_with_app_cancel = off
*          i_movement_cancel     = on
*          i_save                = i_save
*          i_enqueue             = i_enqueue
*          i_commit              = i_commit
*          ir_con_cancel         = lr_con_cancel             "ID 18553
*        IMPORTING
*          e_rc                  = l_rc
*          e_no_cancel           = l_no_cancel
*        CHANGING
*          c_errorhandler        = c_errorhandler
*          c_lock                = c_lock.
      CALL METHOD cl_ish_environment=>cancel_objects
        EXPORTING
          it_objects            = lt_objects
          it_nbew               = lt_nbew
          i_popup               = on
          i_authority_check     = on
          i_orgid               = l_orgid
          i_caller              = i_caller
          i_last_srv_cancel     = on
          i_app_cancel          = on
          i_srv_cancel          = on
          i_vkg_cancel          = '*'
          i_req_cancel          = on
          i_corder_cancel       = on
          i_pap_cancel          = on
          i_srv_with_app_cancel = '*'
          i_movement_cancel     = '*'
          i_save                = i_save
          i_enqueue             = i_enqueue
          i_commit              = i_commit
          ir_con_cancel         = lr_con_cancel             "ID 18553
        IMPORTING
          e_rc                  = l_rc
          e_no_cancel           = l_no_cancel
        CHANGING
          c_errorhandler        = c_errorhandler
          c_lock                = c_lock.
*     CM, 08.03.2013, MED-41948, End

*     ------- ------ ------
*     ID 18553 - begin
      CALL METHOD lr_con_cancel->destroy.
      CLEAR: lr_con_cancel, lr_con_cancel_med.
*     ID 18553 - end
*     ------- ------ ------
      IF l_no_cancel = on.
*       cancel (Abbrechen)
        e_rc = 2.
        e_refresh = 0.
        EXIT.
      ENDIF.
      CASE l_rc.
        WHEN 0.
*         everything OK -> chain appointment cancelled
          e_rc = 0.
*         refresh whole list, because maybe more appointments
*         (connected with chain) have been cancelled
          e_refresh = 2.
        WHEN OTHERS.
*         error (Fehler)
          e_rc = 1.
          e_refresh = 0.
      ENDCASE.
  ENDCASE.

ENDMETHOD.


METHOD call_clinical_order .

  DATA: lr_config            TYPE REF TO cl_ish_con_corder,
        lr_config_med        TYPE REF TO cl_ishmed_con_corder,
        lr_config_aggreg     TYPE REF TO cl_ishmed_con_corder_aggreg,
        lr_process           TYPE REF TO cl_ish_prc_corder,
        lr_process_aggreg    TYPE REF TO cl_ishmed_prc_corder_aggreg,
        lr_corder            TYPE REF TO cl_ish_corder,
        lt_npat              TYPE ishmed_t_npat,
        ls_npat              LIKE LINE OF lt_npat,
        lt_npap              TYPE ishmed_t_npap,
        ls_npap              LIKE LINE OF lt_npap,
        lt_nfal              TYPE ishmed_t_nfal,
        ls_nfal              LIKE LINE OF lt_nfal,
        l_falnr              TYPE falnr,
        lt_npat_loop         TYPE ishmed_t_npat,
        lt_nfal_loop         TYPE ishmed_t_nfal,
        lt_npap_loop         TYPE ishmed_t_npap,
        lt_npat_without_case TYPE ishmed_t_npat,
        lt_patnr_falnr       TYPE ishmed_t_corder_aggreg,
        ls_patnr_falnr       LIKE LINE OF lt_patnr_falnr,
        lt_erboe             TYPE ishmed_t_orgid,
        ls_erboe             LIKE LINE OF lt_erboe,
        lt_fachoe            TYPE ishmed_t_orgid,
        ls_fachoe            LIKE LINE OF lt_fachoe,
        ls_parameter         LIKE LINE OF it_parameter,
        ls_expvalue          LIKE LINE OF et_expvalues,
        lt_object            TYPE ish_objectlist,
        ls_object            LIKE LINE OF it_objects,
        lt_requests          TYPE ishmed_t_request_object,
        lt_corders           TYPE ishmed_t_corder_object,
        lt_cordpos           TYPE ishmed_t_prereg_object,
        lr_cordpos           LIKE LINE OF lt_cordpos,
        ls_n1corder          TYPE n1corder,
        lt_nlei              TYPE ishmed_t_nlei,
        lt_nlei_anchor       TYPE ishmed_t_nlei,
        lt_a_srv             TYPE ishmed_t_service_object,  " ID 20123
        lr_a_srv             LIKE LINE OF lt_a_srv,         " ID 20123
        l_zotyp              TYPE nllz-zotyp,               " ID 20123
        ls_nlei              TYPE nlei,
        l_vcode              TYPE tndym-vcode,
        l_rc                 TYPE ish_method_rc,
        l_ucomm              TYPE sy-ucomm,
        l_plan_oe            TYPE norg-orgid,
*        l_object_type        TYPE i,                     "REM MED-9409
        l_nbr_marked         TYPE i,
        l_fcode              TYPE n1fcode,
        l_check_type         TYPE n1nbrlines_check_type,
        l_saved              TYPE ish_on_off,
        l_new                TYPE ish_on_off,
        l_is_inh             TYPE ish_on_off,
        l_aggregation        TYPE ish_on_off,
        l_other_changes      TYPE ish_on_off,
        l_ishmed_active      TYPE ish_on_off,
        l_storn              TYPE ish_on_off,
        l_refresh            TYPE ish_on_off,               " MED-34863
        ls_nshift_id         TYPE nshift_id,                "#EC NEEDED
        l_show_hitlist(3)    TYPE c,
        l_erboe              TYPE rn1orgid,
        l_ne_erboe           TYPE ish_on_off,
        l_ne_fachoe          TYPE ish_on_off,
        l_fachoe             TYPE rn1orgid,
        lr_identify          TYPE REF TO if_ish_identify_object, "MED-9409
        l_wa_wplaceid        TYPE nwplace-wplaceid,
        l_pflegoe            TYPE nwpflegoe,
        l_fachloe            TYPE nwfachloe,
        l_orgid              TYPE orgid,
        ls_norg              TYPE norg.
  DATA  l_compid             TYPE n1compid.                 "MED-34863
  DATA: lr_corder_expand TYPE REF TO cl_ishmed_corder.      "MED-42439
  DATA: lt_corder            TYPE ish_t_corder.             "MED-62351 Siegl

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_falnr, l_zotyp, lt_patnr_falnr[], lt_a_srv[].

  CLEAR: lr_corder, lr_config, lr_config_aggreg, lr_cordpos,
         lr_process, lr_process_aggreg, lr_a_srv.

* create instance for errorhandling if not provided
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* notice if IS-H*MED is active
  l_ishmed_active = on.
  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXPORTING
      i_msg            = off
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
    l_ishmed_active = off.
  ENDIF.

* Fichte, MED-46010: First clear NPOL-buffer
  CALL METHOD cl_ishmed_functions=>npol_refresh
    EXPORTING
      i_einri         = i_einri
      it_objects      = it_objects
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
* Fichte, MED-46010 - End

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* instance for configuration in parameters table?
  LOOP AT it_parameter INTO ls_parameter WHERE type = '000'.
    CHECK NOT ls_parameter-object IS INITIAL.
    CALL METHOD ls_parameter-object->('IS_INHERITED_FROM')
      EXPORTING
        i_object_type       = cl_ishmed_con_corder=>co_otype_con_corder
      RECEIVING
        r_is_inherited_from = l_is_inh.
    IF l_is_inh = on.
      lr_config ?= ls_parameter-object.
      EXIT.
    ENDIF.
  ENDLOOP.

* get planning OU out of parameters
  CLEAR: l_plan_oe.
  LOOP AT it_parameter INTO ls_parameter WHERE type = '005'.
    CHECK NOT ls_parameter-value IS INITIAL.
*-- begin Grill, med-33626
    l_orgid = ls_parameter-value.
    CALL METHOD cl_ish_dbr_org=>get_org_by_orgid
      EXPORTING
        i_orgid = l_orgid
      IMPORTING
        es_norg = ls_norg.
    CHECK ls_norg-einri = i_einri.
*-- end Grill, med-33626
    l_plan_oe = ls_parameter-value.
    EXIT.
  ENDLOOP.

* MED-34863: get data refresh info out of parameters
  l_refresh = on.                       " default = REFRESH = ON
  LOOP AT it_parameter INTO ls_parameter WHERE type = '036'.
    l_refresh = ls_parameter-value.
    EXIT.
  ENDLOOP.

* set mode for clinical order dialog
  CASE i_fcode.
    WHEN 'CORDI' OR 'PREI'.
      l_vcode = 'INS'.                " insert
    WHEN 'CORDU' OR 'PREU'.
      l_vcode = 'UPD'.                " update
    WHEN 'CORDD' OR 'PRED'.
      l_vcode = 'DIS'.                " display
    WHEN OTHERS.
      l_vcode = 'DIS'.                " display
  ENDCASE.

  IF l_vcode = 'INS'.
    IF l_ishmed_active = off.
*     IS-H => INSERT: nothing or just 1 entry can be marked
      l_check_type = '0'.                                   " 0 oder 1
    ELSE.
*     IS-H*MED => INSERT: no matter what is marked
      l_check_type = ' '.                                   " 0 to n
    ENDIF.
    CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
      EXPORTING
        i_check_type   = l_check_type
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        e_nbr_marked   = l_nbr_marked
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
*   there can be 2 ways of preallocation:
*   ... 1. use given order object for preallocation
    READ TABLE it_objects INTO ls_object INDEX 1.
    IF sy-subrc = 0.
      TRY.
          lr_identify ?= ls_object-object.
          IF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder )        = on OR
             lr_identify->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on.
            CALL METHOD ls_object-object->('IS_NEW')
              IMPORTING
                e_new = l_new.
            IF l_new = on.
              lr_corder ?= ls_object-object.
            ENDIF.
          ENDIF.
        CATCH cx_sy_move_cast_error.       "#EC NO_HANDLER    "MED-9409
      ENDTRY.                                               "MED-9409
    ENDIF.
    IF lr_corder IS INITIAL.
      l_storn = off.
      REFRESH: lt_npat, lt_npap, lt_nfal.
*     ... 2. use given patient for preallocation
*            [get patient/case for each object (ID 18134)]
      LOOP AT it_objects INTO ls_object.
        REFRESH: lt_npat_loop, lt_npap_loop, lt_nfal_loop, lt_object.
        APPEND ls_object TO lt_object.
        CALL METHOD cl_ishmed_functions=>get_patients_and_cases
          EXPORTING
            it_objects     = lt_object
            i_read_db      = on
          IMPORTING
            e_rc           = l_rc
            et_npat        = lt_npat_loop
            et_npap        = lt_npap_loop
            et_nfal        = lt_nfal_loop
          CHANGING
            c_environment  = c_environment
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
        CLEAR: ls_npat, ls_npap, ls_nfal.
        READ TABLE lt_nfal_loop INTO ls_nfal INDEX 1.
        IF sy-subrc = 0 AND ls_nfal IS NOT INITIAL.
          IF ls_nfal-storn = on.
            CLEAR ls_nfal.
          ELSE.
            APPEND ls_nfal TO lt_nfal.
          ENDIF.
        ENDIF.
        READ TABLE lt_npat_loop INTO ls_npat INDEX 1.
        IF sy-subrc = 0 AND ls_npat IS NOT INITIAL.
          IF ls_npat-storn = on.
            l_storn = on.
            CLEAR ls_npat.
          ELSE.
            APPEND ls_npat TO lt_npat.
            IF ls_nfal IS INITIAL.
              APPEND ls_npat TO lt_npat_without_case.
            ENDIF.
          ENDIF.
        ENDIF.
        READ TABLE lt_npap_loop INTO ls_npap INDEX 1.
        IF sy-subrc = 0 AND ls_npap IS NOT INITIAL.
          IF ls_npap-storn = on.
            l_storn = on.
            CLEAR ls_npap.
          ELSE.
            APPEND ls_npap TO lt_npap.
          ENDIF.
        ENDIF.
      ENDLOOP.
      CHECK e_rc = 0.
*     leave if all patients are cancelled (ID 17904)
*     (message should always be shown if one patient is cancelled)
      IF l_storn = on.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'S'
            i_kla           = 'N1CORDMG'
            i_num           = '141'
          CHANGING
            cr_errorhandler = c_errorhandler.
        IF lt_npat[] IS INITIAL AND lt_npap[] IS INITIAL.
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDIF.
*     preallocate order data now
      CLEAR ls_n1corder.
      ls_n1corder-einri = i_einri.
      IF l_nbr_marked <= 1.
*       only 0 or 1 entries marked
        READ TABLE lt_npat INTO ls_npat INDEX 1.
        IF sy-subrc = 0 AND ls_npat-storn = off.
*         patient given
          ls_n1corder-patnr  = ls_npat-patnr.
          ls_n1corder-reftyp = cl_ish_corder=>co_reftyp_pat.
*         if case for patient given -> use for preallocation
          READ TABLE lt_nfal INTO ls_nfal
               WITH KEY patnr = ls_npat-patnr.
          IF sy-subrc = 0 AND ls_nfal-storn = off.
            l_falnr = ls_nfal-falnr.
          ENDIF.
        ELSE.
          READ TABLE lt_npap INTO ls_npap INDEX 1.
          IF sy-subrc = 0 AND ls_npap-storn = off.
*           provisional patient given
            ls_n1corder-papid  = ls_npap-papid.
            ls_n1corder-reftyp = cl_ish_corder=>co_reftyp_pap.
          ELSE.
            READ TABLE lt_nfal INTO ls_nfal INDEX 1.
            IF sy-subrc = 0.
*             only case given -> get patient from case
              ls_n1corder-patnr  = ls_nfal-patnr.
              ls_n1corder-reftyp = cl_ish_corder=>co_reftyp_pat.
              IF ls_nfal-storn = off.
                l_falnr = ls_nfal-falnr.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.    " IF l_nbr_marked <= 1.
*     preallocate ETROE and ORDDEP from ...
      ls_n1corder-etrby = cl_ish_corder=>co_etrby_oe.
*     ID 18314: do not use OUs from clin. order primarily!
*     ... marked clinical order OR ...
*      IF l_nbr_marked > 0.
*        CALL METHOD cl_ishmed_functions=>get_orders
*          EXPORTING
*            it_objects     = it_objects
*          IMPORTING
*            e_rc           = e_rc
*            et_corders     = lt_corders
*          CHANGING
*            c_environment  = c_environment
*            c_errorhandler = c_errorhandler.
*        CHECK e_rc = 0.
*        READ TABLE lt_corders INTO lr_corder INDEX 1.
*        IF sy-subrc = 0 AND NOT lr_corder IS INITIAL.
*          CALL METHOD lr_corder->if_ish_objectbase~get_data_field
*            EXPORTING
*              i_fieldname    = 'ETROE'
*            IMPORTING
*              e_rc           = e_rc
*              e_field        = ls_n1corder-etroe
*            CHANGING
*              c_errorhandler = c_errorhandler.
*          CALL METHOD lr_corder->if_ish_objectbase~get_data_field
*            EXPORTING
*              i_fieldname    = 'ORDDEP'
*            IMPORTING
*              e_rc           = e_rc
*              e_field        = ls_n1corder-orddep
*            CHANGING
*              c_errorhandler = c_errorhandler.
*          CLEAR lr_corder.
*        ENDIF.
*      ENDIF.         " IF l_nbr_marked > 0.
*     ... marked entry ERBOE OR ...
      IF ls_n1corder-etroe  IS INITIAL OR
         ls_n1corder-orddep IS INITIAL.
        CALL METHOD cl_ishmed_functions=>get_erboes
          EXPORTING
            it_objects     = it_objects
          IMPORTING
            e_rc           = e_rc
            et_erboe       = lt_erboe
            et_fachoe      = lt_fachoe
          CHANGING
            c_errorhandler = c_errorhandler.
        CHECK e_rc = 0.
        IF l_nbr_marked <= 1.
          IF ls_n1corder-etroe IS INITIAL.
            READ TABLE lt_erboe INTO ls_erboe INDEX 1.
            IF sy-subrc = 0 AND NOT ls_erboe IS INITIAL.
              ls_n1corder-etroe = ls_erboe.
            ENDIF.
          ENDIF.
          IF ls_n1corder-orddep IS INITIAL.
            READ TABLE lt_fachoe INTO ls_fachoe INDEX 1.
            IF sy-subrc = 0 AND NOT ls_fachoe IS INITIAL.
              ls_n1corder-orddep = ls_fachoe.
            ENDIF.
          ENDIF.
        ELSE.
*         MED-29026: if more than one entry marked -> aggregation
          l_aggregation = on.
*         get param N1VKGTPA (show hitlist)
          GET PARAMETER ID 'N1VKGTPA' FIELD l_show_hitlist.
          IF l_show_hitlist EQ ' '.
            CALL FUNCTION 'ISH_TN00R_READ'
              EXPORTING
                ss_einri = i_einri
                ss_param = 'N1VKGTPA'
              IMPORTING
                ss_value = l_show_hitlist.
            IF l_show_hitlist NE 'X'.
              CLEAR l_show_hitlist.
            ENDIF.
          ELSEIF l_show_hitlist EQ 'OFF'.
            CLEAR l_show_hitlist.
          ENDIF.
          LOOP AT lt_erboe INTO ls_erboe.
            CHECK ls_erboe NE l_erboe.
            IF NOT l_erboe IS INITIAL.
              l_ne_erboe = on.
              EXIT.
            ENDIF.
            l_erboe = ls_erboe.
          ENDLOOP.
*         set etroe
          IF l_ne_erboe EQ off.
            ls_n1corder-etroe = ls_erboe.
          ENDIF.
          IF l_ne_erboe EQ on AND
             l_show_hitlist EQ off.
            CLEAR ls_n1corder-etroe.
          ENDIF.
*         set orddep
          LOOP AT lt_fachoe INTO ls_fachoe.
            CHECK ls_fachoe  NE l_fachoe.
            IF NOT l_fachoe IS INITIAL.
              l_ne_fachoe = on.
              EXIT.
            ENDIF.
            l_fachoe = ls_fachoe.
          ENDLOOP.
          IF l_ne_fachoe = on.
            IF l_show_hitlist EQ off.
              CLEAR: ls_n1corder-orddep.
            ENDIF.
          ELSE.
            ls_n1corder-orddep = ls_fachoe.
          ENDIF.
*-- begin Grill, MED-42721
*          IF ( l_show_hitlist EQ 'ON' OR
*               l_show_hitlist EQ on ) AND
*             ( l_ne_erboe      = on   OR
*               l_ne_fachoe     = on ).
*            CALL METHOD c_errorhandler->collect_messages
*              EXPORTING
*                i_typ = 'E'
*                i_kla = 'N1CORDMG_MED'
*                i_num = '027'.
*            e_rc = '1'.
*            EXIT.
*          ENDIF.
*-- end Grill, MED-42721
        ENDIF.
      ENDIF.
*     ... planning OU
      IF l_aggregation EQ off.                              "MED-29026
        IF ls_n1corder-etroe IS INITIAL AND l_plan_oe IS NOT INITIAL.
          ls_n1corder-etroe = l_plan_oe.
        ENDIF.
* - - - MED-33174 C. Honeder BEGIN.
        IF ls_n1corder-etroe IS INITIAL OR
           ls_n1corder-orddep IS INITIAL.
*         Get the active workplace
          READ TABLE it_parameter INTO ls_parameter WITH KEY type = '004'.
          IF sy-subrc = 0 AND ls_parameter-value = '001'.
            READ TABLE it_parameter INTO ls_parameter WITH KEY type = '003'.
            IF sy-subrc = 0 AND NOT ls_parameter-value IS INITIAL.
              l_wa_wplaceid = ls_parameter-value.
            ENDIF.
*-->begin of MED-71052 AGujev
*MED-71052: following change needs to be refactored, as orddep must not be overwritten in all situations
*          ELSE.                                         " MED-68606 Cosmina Crisan 15.02.2019      "--MED-71052
*            ls_n1corder-orddep = ls_parameter-value.    " MED-68606 Cosmina Crisan 15.02.2019      "--MED-71052
           ELSE.
             IF sy-subrc = 0 AND ls_n1corder-orddep IS INITIAL.
        "we only fill it here if it was empty and we found a parameter with type '004'
               ls_n1corder-orddep = ls_parameter-value.
             ENDIF.
*<--end of MED-71052 AGujev
          ENDIF.
*         If we have still no etroe - try to get the pfleg oe instead of the plan oe
          IF ls_n1corder-etroe IS INITIAL AND
             l_wa_wplaceid IS NOT INITIAL.
            SELECT SINGLE pflegoe FROM nwplace_001 INTO l_pflegoe
                   WHERE  wplacetype  = '001'
                   AND    wplaceid    = l_wa_wplaceid.
            IF sy-subrc = 0 AND l_pflegoe IS NOT INITIAL.
              ls_n1corder-etroe = l_pflegoe.
            ENDIF.
          ENDIF.
*         If we haven't found an etroe clear the flag.
          IF ls_n1corder-etroe IS INITIAL.
            CLEAR ls_n1corder-etrby.
          ENDIF.
*         If we have no orddep - get it from the active workplace
          IF ls_n1corder-orddep IS INITIAL AND
             l_wa_wplaceid IS NOT INITIAL.
            SELECT SINGLE fachloe FROM nwplace_001 INTO l_fachloe
                   WHERE  wplacetype  = '001'
                   AND    wplaceid    = l_wa_wplaceid.
            IF sy-subrc = 0 AND l_fachloe IS NOT INITIAL.
              ls_n1corder-orddep = l_fachloe.
            ENDIF.
          ENDIF.
        ENDIF.
*        IF ls_n1corder-etroe IS INITIAL.                    " ID 19532
*          CLEAR ls_n1corder-etrby.                          " ID 19532
*        ENDIF.                                              " ID 19532
* - - - MED-33174 C. Honeder END.
      ENDIF.                                                "MED-29026
*     create new preallocated order object now
      CALL METHOD cl_ish_fac_corder=>create
        EXPORTING
          is_n1corder     = ls_n1corder
          ir_environment  = c_environment
        IMPORTING
          er_instance     = lr_corder
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        e_rc = 1.
        e_refresh = 0.
        EXIT.
      ENDIF.
*     ID 20123: Begin of INSERT
*     connect new order with OP anchor service if requested
*      START MED-42399
      READ TABLE it_parameter TRANSPORTING NO FIELDS
         WITH KEY type = '034'.
*      IF l_nbr_marked = 1.
      IF sy-subrc = 0 AND l_nbr_marked = 1.
*      END MED-42399
        CALL METHOD cl_ishmed_functions=>get_services
          EXPORTING
            it_objects         = it_objects
          IMPORTING
            e_rc               = e_rc
            et_anchor_services = lt_a_srv
          CHANGING
            c_environment      = c_environment
            c_errorhandler     = c_errorhandler.
        IF e_rc <> 0.
          e_rc = 1.
          e_refresh = 0.
          EXIT.
        ENDIF.
        DESCRIBE TABLE lt_a_srv.
        IF sy-tfill = 1.
          READ TABLE lt_a_srv INTO lr_a_srv INDEX 1.
          IF sy-subrc = 0 AND lr_a_srv IS BOUND.
*           get connection type out of parameters
            LOOP AT it_parameter INTO ls_parameter WHERE type = '034'.
              CHECK NOT ls_parameter-value IS INITIAL.
              l_zotyp = ls_parameter-value.
              EXIT.
            ENDLOOP.
          ENDIF.
        ENDIF.
      ENDIF.
*     ID 20123: End of INSERT
    ENDIF.
  ELSE.
*   UPDATE/DISPLAY: only just 1 entry can be marked
    CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
      EXPORTING
        i_check_type   = '1'                                " just 1
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
*       e_nbr_marked   = l_nbr_marked
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
*   get marked clinical order
    CALL METHOD cl_ishmed_functions=>get_orders
      EXPORTING
        it_objects        = it_objects
        i_cancelled_datas = on
      IMPORTING
        e_rc              = e_rc
        et_corders        = lt_corders
      CHANGING
        c_environment     = c_environment
        c_errorhandler    = c_errorhandler.
    CHECK e_rc = 0.
*   a clinical order has to be marked
    READ TABLE lt_corders INTO lr_corder INDEX 1.
    IF sy-subrc <> 0 OR lr_corder IS INITIAL.
*     check if a request has been marked
      CALL METHOD cl_ishmed_functions=>get_requests
        EXPORTING
          it_objects        = it_objects
          i_cancelled_datas = on
        IMPORTING
          e_rc              = e_rc
          et_requests       = lt_requests
        CHANGING
          c_environment     = c_environment
          c_errorhandler    = c_errorhandler.
      IF e_rc = 0 AND NOT lt_requests[] IS INITIAL.
*       a request has been marked -> call request update/display
        CLEAR l_fcode.
        CASE l_vcode.
          WHEN 'UPD'.
            l_fcode = 'REQU'.
          WHEN 'DIS'.
            l_fcode = 'REQD'.
        ENDCASE.
        CALL METHOD cl_ishmed_functions=>call_request
          EXPORTING
            i_fcode        = l_fcode
            i_einri        = i_einri
            i_caller       = i_caller
            i_save         = i_save
            i_commit       = i_commit
            i_enqueue      = i_enqueue
            i_dequeue      = i_dequeue
            it_objects     = it_objects
            it_parameter   = it_parameter
          IMPORTING
            e_rc           = e_rc
            e_func_done    = e_func_done
            e_refresh      = e_refresh
          CHANGING
            c_errorhandler = c_errorhandler
            c_environment  = c_environment
            c_lock         = c_lock.
        EXIT.
      ELSE.
*       ID 19224 - Begin of INSERT (check for CASE_REVISION!)
        CALL METHOD cl_ishmed_functions=>get_services
          EXPORTING
            it_objects        = it_objects
            i_cancelled_datas = on
          IMPORTING
            e_rc              = e_rc
            et_nlei           = lt_nlei
            et_anchor_nlei    = lt_nlei_anchor
          CHANGING
            c_environment     = c_environment
            c_errorhandler    = c_errorhandler.
        CHECK e_rc = 0.
        APPEND LINES OF lt_nlei_anchor TO lt_nlei.
        LOOP AT lt_nlei INTO ls_nlei WHERE storn = on.
*         if the service is already cancelled
*         then look if there is an entry in table NSHIFT_ID
*         if yes => CASE_REVISION was called in another session
          SELECT * FROM nshift_id INTO ls_nshift_id UP TO 1 ROWS
            WHERE einri        = ls_nlei-einri
              AND source_falnr = ls_nlei-falnr
              AND fieldname    = 'LNRLS'
              AND fieldvalue   = ls_nlei-lnrls.
            EXIT.
          ENDSELECT.
          CHECK sy-subrc = 0.
*         and so the user has to refresh the list manually!
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'N1BASE'
              i_num  = '091'
              i_last = space.
          e_rc = 1.
          e_refresh = 0.
          EXIT.
        ENDLOOP.
        CHECK e_rc = 0.
*       ID 19224 - End of INSERT
*       message: please mark a clinical order
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'N1CORDMG'
            i_num  = '031'
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
        EXIT.
      ENDIF.
    ELSE.
*     get marked clinical order position (MED-33247)
      CALL METHOD cl_ishmed_functions=>get_preregistrations
        EXPORTING
          it_objects        = it_objects
          i_cancelled_datas = on
        IMPORTING
          e_rc              = e_rc
          et_preregs        = lt_cordpos
        CHANGING
          c_environment     = c_environment
          c_errorhandler    = c_errorhandler.
      CHECK e_rc = 0.
*     get given case for preallocation of new order positions
      CALL METHOD cl_ishmed_functions=>get_patients_and_cases
        EXPORTING
          it_objects     = it_objects
          i_read_db      = on
        IMPORTING
          e_rc           = e_rc
          et_nfal        = lt_nfal
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
      READ TABLE lt_nfal INTO ls_nfal INDEX 1.
      IF sy-subrc = 0 AND ls_nfal-storn = off.
        l_falnr = ls_nfal-falnr.
      ENDIF.
    ENDIF.
  ENDIF.

* single clinical order dialog or aggregation functionality?
  IF l_vcode = 'INS' AND l_ishmed_active = on AND l_nbr_marked > 1.
    l_aggregation = on.
  ELSE.
    l_aggregation = off.
  ENDIF.

* create instance for configuration
  IF lr_config IS INITIAL.
    IF l_aggregation = off.
      CALL METHOD cl_ish_fac_con_corder=>create
        IMPORTING
          er_instance     = lr_config
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
    ELSE.
      CALL METHOD cl_ish_fac_con_corder=>create_aggreg
        IMPORTING
          er_instance     = lr_config_aggreg
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      lr_config = lr_config_aggreg.
    ENDIF.
    IF e_rc <> 0.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* fill configuration instance
  IF lr_config IS NOT INITIAL.
*   set configuration flags
    CALL METHOD lr_config->set_commit
      EXPORTING
        i_commit = i_commit.
    CALL METHOD lr_config->set_save
      EXPORTING
        i_save = i_save.
    CALL METHOD lr_config->set_call_service_list
      EXPORTING
        i_call_service_list = on.
    CALL METHOD lr_config->set_call_admission
      EXPORTING
        i_call_admission = on.
*   set planning OU in configuration instance
    IF l_plan_oe IS NOT INITIAL.
      IF lr_config->is_inherited_from(
        cl_ishmed_con_corder=>co_otype_con_corder_med ) = on.
        lr_config_med ?= lr_config.
        CALL METHOD lr_config_med->set_planning_ou
          EXPORTING
            i_planning_ou = l_plan_oe.
      ENDIF.
    ENDIF.
*   ID 20123: Begin of INSERT
    IF lr_a_srv IS BOUND AND l_zotyp IS NOT INITIAL.
      IF lr_config->is_inherited_from(
        cl_ishmed_con_corder=>co_otype_con_corder_med ) = on.
        lr_config_med ?= lr_config.
        CALL METHOD lr_config_med->set_surgery_service
          EXPORTING
            ir_surgery_service = lr_a_srv.
        CALL METHOD lr_config_med->set_zotyp
          EXPORTING
            i_zotyp = l_zotyp.
      ENDIF.
    ENDIF.
*   ID 20123: End of Insert
*   MED-33247: Begin of Insert
*-- begin Grill, MED-42439
    READ TABLE it_objects INTO ls_object INDEX 1.
    IF sy-subrc EQ 0.
      TRY.
          lr_identify ?= ls_object-object.
          IF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder )        = on OR
             lr_identify->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on.
            lr_corder_expand ?= ls_object-object.
          ENDIF.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
      IF  NOT lr_corder_expand IS BOUND.
*-- end Grill, MED-42439
        READ TABLE lt_cordpos INTO lr_cordpos INDEX 1.
        IF sy-subrc = 0 AND lr_cordpos IS BOUND.
          IF lr_config->get_t_expand_cordpos( ) IS INITIAL.
            lr_config->set_expand_cordpos( lr_cordpos ).
*       START MED-34863
*       set component id to open/to set visible
            READ TABLE it_parameter INTO ls_parameter WITH KEY type = '037'.
            IF sy-subrc = 0 AND ls_parameter-value IS NOT INITIAL.
              l_compid = ls_parameter-value.
              CALL METHOD lr_config->set_vis_compid_at_expand_pos
                EXPORTING
                  i_compid = l_compid.
            ENDIF.
*       END MED-34863
          ENDIF.
        ENDIF.
      ENDIF.                                                "MED-42439
    ENDIF.                                                  "MED-42439
*   MED-33247: End of Insert
    IF l_aggregation = off.
      CALL METHOD lr_config->set_enqueue
        EXPORTING
          i_enqueue = i_enqueue.
      CALL METHOD lr_config->set_dequeue
        EXPORTING
          i_dequeue = i_dequeue.
    ENDIF.
  ENDIF.

  IF l_aggregation = on.

*   PROCESS FOR MORE THAN 1 CLINICAL ORDERS (AGGREGATION) - - - - - -

*   set aggregation flag
    IF NOT lr_corder IS INITIAL.
      CALL METHOD lr_corder->set_aggregation
        EXPORTING
          i_aggregation = on.
    ENDIF.

*   patient/case preallocation for aggregation clinical order
    LOOP AT lt_nfal INTO ls_nfal WHERE storn = off.
      CLEAR ls_patnr_falnr.
      ls_patnr_falnr-falnr  = ls_nfal-falnr.
      ls_patnr_falnr-patnr  = ls_nfal-patnr.
      ls_patnr_falnr-reftyp = cl_ish_corder=>co_reftyp_pat.
      APPEND ls_patnr_falnr TO lt_patnr_falnr.
    ENDLOOP.
    LOOP AT lt_npat_without_case INTO ls_npat WHERE storn = off.
      CLEAR ls_patnr_falnr.
      ls_patnr_falnr-patnr  = ls_npat-patnr.
      ls_patnr_falnr-reftyp = cl_ish_corder=>co_reftyp_pat.
      APPEND ls_patnr_falnr TO lt_patnr_falnr.
    ENDLOOP.
    LOOP AT lt_npap INTO ls_npap WHERE storn = off.
      CLEAR ls_patnr_falnr.
      ls_patnr_falnr-papid  = ls_npap-papid.
      ls_patnr_falnr-reftyp = cl_ish_corder=>co_reftyp_pap.
      APPEND ls_patnr_falnr TO lt_patnr_falnr.
    ENDLOOP.
    IF lt_patnr_falnr[] IS NOT INITIAL AND
       lr_config_aggreg IS NOT INITIAL.
      CALL METHOD lr_config_aggreg->set_gt_patnr_falnr
        EXPORTING
          it_patnr_falnr = lt_patnr_falnr.
    ENDIF.

*   create instance of process class for aggregation corder dialog
    CALL METHOD cl_ish_fac_prc_corder=>create_aggregated
      EXPORTING
        ir_corder       = lr_corder
        ir_environment  = c_environment
        ir_config       = lr_config_aggreg
        ir_lock         = c_lock
        i_vcode         = l_vcode
      IMPORTING
        er_instance     = lr_process_aggreg
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.

*   run process for create aggregation clinical order
    CALL METHOD lr_process_aggreg->run
      EXPORTING
*       CDuerr, MED-33865 - Begin
*        i_refresh       = on                    "Grill, med-33668
        i_refresh       = off
*       CDuerr, MED-33865 - End
      IMPORTING
        e_rc            = l_rc
        e_saved         = l_saved
        e_ucomm         = l_ucomm
      CHANGING
        cr_errorhandler = c_errorhandler.

  ELSE.

*   PROCESS FOR 1 CLINICAL ORDER - - - - - - - - - - - - - - - - - - -

*   case preallocation
    IF l_falnr IS NOT INITIAL AND lr_config IS NOT INITIAL.
      CALL METHOD lr_config->set_falnr
        EXPORTING
          i_falnr = l_falnr.
    ENDIF.

*   create instance of process class for clinical order dialog
    CALL METHOD cl_ish_fac_prc_corder=>create
      EXPORTING
        ir_corder       = lr_corder
        ir_environment  = c_environment
        ir_config       = lr_config
        ir_lock         = c_lock
        i_vcode         = l_vcode
      IMPORTING
        er_instance     = lr_process
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.

*   run process for create/change/display clinical order
    CALL METHOD lr_process->run
      EXPORTING
*       i_refresh       = on "Grill, med-33668 " MED-34863 REM
        i_refresh       = l_refresh                         " MED-34863
      IMPORTING
        e_rc            = l_rc
        e_saved         = l_saved
        e_ucomm         = l_ucomm
      CHANGING
        cr_errorhandler = c_errorhandler.

  ENDIF.

  IF l_rc <> 0.
    e_rc      = 1.
    e_refresh = 0.
  ELSE.
    e_rc      = 0.
    IF l_saved = on.
*     refresh all data because in clinical order dialog many objects
*     could have been changed; appointments or by context for example
      e_refresh = 2.
      CALL METHOD cl_ishmed_functions=>waiting_for_update
        EXPORTING
          it_objects     = it_objects
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = 1.
      ENDIF.
*     export value (instance of clinical order)
      CLEAR ls_expvalue.
      ls_expvalue-type   = '000'.
* Siegl(MED-62351): If there is a aggregated order we have to get the corders from the lr_process_aggreg
*get the correct instance of the corder.          "MED-54378 Madalina P.
      IF lr_process IS BOUND.                     "MED-54378 Madalina P.
        lr_corder = lr_process->get_corder( ).    "MED-54378 Madalina P.
        ls_expvalue-object = lr_corder.           "MED-62351 Siegl
        APPEND ls_expvalue TO et_expvalues.       "MED-62351 Siegl
      elseif lr_process_aggreg IS BOUND.                "MED-62351 Siegl
        lt_corder = lr_process_aggreg->get_t_corder( ). "MED-62351 Siegl
        loop at lt_corder into lr_corder.            "MED-62351 Siegl
           ls_expvalue-object = lr_corder.           "MED-62351 Siegl
           APPEND ls_expvalue TO et_expvalues.       "MED-62351 Siegl
        endloop.                                     "MED-62351 Siegl
      ENDIF.                                      "MED-54378 Madalina P.
*       ls_expvalue-object = lr_corder.           "REM MED-62351 Siegl
*       APPEND ls_expvalue TO et_expvalues.       "REM MED-62351 Siegl
    ELSE.
      IF l_ucomm = cl_ish_prc_corder=>co_okcode_cancel.
        IF lr_process IS BOUND.
          l_other_changes = lr_process->get_other_changes( ).
        ENDIF.
        IF lr_process_aggreg IS BOUND.
          l_other_changes = lr_process_aggreg->get_other_changes( ).
        ENDIF.
        IF l_other_changes = on.
          e_refresh = 2.                       " refresh all
        ELSE.
          e_rc = 2.                            " cancel
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  IF lr_process IS BOUND.
    CALL METHOD lr_process->destroy
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
    ENDIF.
  ENDIF.
  IF lr_process_aggreg IS BOUND.
    CALL METHOD lr_process_aggreg->destroy
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD call_clinical_order_cr_appmov .

  DATA: l_plan_oe            TYPE norg-orgid,
        l_is_inh             TYPE ish_on_off,
        l_rc                 TYPE ish_method_rc,
        l_created            TYPE ish_on_off.

  DATA: lr_app               TYPE REF TO cl_ish_appointment,
        lr_move              TYPE REF TO cl_ishmed_movement,
        lr_planning          TYPE REF TO cl_ish_prc_planning,
        lr_planning_med      TYPE REF TO cl_ishmed_prc_planning,
        lr_prc_plann_func    TYPE REF TO cl_ish_prc_planning_func,
        lr_prc_planning_func TYPE REF TO cl_ishmed_prc_planning_func,
        lr_config            TYPE REF TO cl_ishmed_con_corder,
        lr_corder            TYPE REF TO cl_ish_corder,
        lr_nbew              TYPE REF TO cl_ishmed_none_oo_nbew.

  DATA: lt_apps              TYPE ishmed_t_appointment_object,
        lt_move              TYPE ishmed_t_movement.

  DATA: ls_expvalue          LIKE LINE OF et_expvalues,
        ls_nbew              TYPE nbew.

  FIELD-SYMBOLS: <ls_parameter> LIKE LINE OF it_parameter,
                 <ls_object>    LIKE LINE OF it_objects.
* ----- ----- -----
* initialization
  CLEAR e_rc.
  e_refresh = 0.
  e_func_done = true.
  CLEAR: lr_corder, lr_config, lr_app, lr_move, lr_planning, lr_planning_med, lr_prc_planning_func,
         lr_prc_plann_func, lt_apps, lt_move.
* ----- ----- -----
* notice if IS-H*MED is active
  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXPORTING
      i_msg            = off
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  CHECK sy-subrc = 0.
* ----- ----- -----
* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* set mode for clinical order dialog
  IF i_fcode <> 'CORDI_A_M'.
    RETURN.
  ENDIF.

* ----- ----- -----
* instance for environment in parameters table?
  LOOP AT it_parameter ASSIGNING <ls_parameter>
      WHERE type = '000'
        AND object IS NOT INITIAL.
    CALL METHOD <ls_parameter>-object->('IS_INHERITED_FROM')
      EXPORTING
        i_object_type       = cl_ishmed_con_corder=>co_otype_con_corder
      RECEIVING
        r_is_inherited_from = l_is_inh.
    IF l_is_inh = on.
      lr_config ?= <ls_parameter>-object.
      EXIT.
    ENDIF.
  ENDLOOP.
* get planning OU out of parameters
  CLEAR: l_plan_oe.
  LOOP AT it_parameter ASSIGNING <ls_parameter>
     WHERE type = '005'
       AND value IS NOT INITIAL.
    l_plan_oe = <ls_parameter>-value.
    EXIT.
  ENDLOOP.
* ----- ----- -----
* get appointment / movement for corder create
  LOOP AT it_objects ASSIGNING <ls_object>.
    TRY.
        lr_app ?= <ls_object>-object.
        APPEND lr_app TO lt_apps.
      CATCH cx_sy_move_cast_error.
        TRY.
            lr_move ?= <ls_object>-object.
            APPEND lr_move TO lt_move.
          CATCH cx_sy_move_cast_error.
            TRY.
                lr_nbew ?= <ls_object>-object.
                CALL METHOD lr_nbew->get_data
                  IMPORTING
                    e_rc           = l_rc
                    e_nbew         = ls_nbew
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF l_rc <> 0.
                  e_rc = l_rc.
                  CONTINUE.
                ENDIF.
                CALL METHOD cl_ish_fac_movement=>load
                  EXPORTING
                    i_mandt        = ls_nbew-mandt
                    i_einri        = ls_nbew-einri
                    i_falnr        = ls_nbew-falnr
                    i_lfdnr        = ls_nbew-lfdnr
                    i_environment  = c_environment
                  IMPORTING
                    e_instance     = lr_move
                    e_rc           = l_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF l_rc <> 0.
                  e_rc = l_rc.
                  CONTINUE.
                ENDIF.
                APPEND lr_move TO lt_move.
              CATCH cx_sy_move_cast_error.
                CONTINUE.
            ENDTRY.
        ENDTRY.
    ENDTRY.
  ENDLOOP.
  IF e_rc <> 0.
    RETURN.
  ENDIF.
* ----- ----- -----
  IF lt_move IS INITIAL AND lt_apps IS INITIAL.
*   Wählen sie eine(n) Termin oder Bewegung für diese Funktion
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1APMG_MED'
        i_num           = '145'
      CHANGING
        cr_errorhandler = c_errorhandler.
    RETURN.
  ENDIF.
* ----- ----- -----
* get Instance of prc Planning
  CALL METHOD cl_ish_fac_prc_planning=>create
    IMPORTING
      er_instance     = lr_planning
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF e_rc <> 0.
    RETURN.
  ENDIF.

* set general process data
  CALL METHOD lr_planning->set_prc_data
    EXPORTING
      i_institution                  = i_einri
      i_app_preallocate              = on
      i_app_preallocate_changed      = on
      i_save                         = i_save
      i_save_changed                 = on
      i_check                        = on
      i_check_changed                = on
      i_check_chain                  = on
      i_check_chain_changed          = on
      i_caller                       = i_caller
      i_caller_changed               = on
      i_enqueue                      = i_enqueue
      i_enqueue_changed              = on
      i_enqueue_planobjects          = i_enqueue
      i_enqueue_planobjects_changed  = on
      i_dequeue                      = i_dequeue
      i_dequeue_changed              = on
      i_dequeue_planobjects          = i_dequeue
      i_dequeue_planobjects_changed  = on
      i_check_avail_timeslot         = on
      i_check_avail_timeslot_changed = on
      ir_environment                 = c_environment
    CHANGING
      cr_errorhandler                = c_errorhandler
      cr_lock                        = c_lock.

* get prc planning func instanze
  CALL METHOD cl_ish_fac_prc_planning_func=>create
    IMPORTING
      er_instance = lr_prc_plann_func.
  lr_prc_planning_func ?= lr_prc_plann_func.

* set planning ou
  CALL METHOD lr_prc_planning_func->set_planning_ou
    EXPORTING
      i_planoe = l_plan_oe.

  lr_planning_med ?= lr_planning.
* create corder for appointment/movement
  CALL METHOD lr_prc_planning_func->create_corder_for_apps
    EXPORTING
*     ir_prc_corder   =
      ir_con_corder   = lr_config
      ir_prc_planning = lr_planning_med
      it_apps         = lt_apps
      it_movs         = lt_move
      ir_lock         = c_lock
    IMPORTING
      e_created       = l_created
      er_corder       = lr_corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
* ---------- ---------- ----------
* destroy instance planning process
  IF lr_planning IS NOT INITIAL.
    CALL METHOD lr_planning->destroy.
  ENDIF.

* destroy instance planning process function
  IF lr_prc_planning_func IS NOT INITIAL.
    CALL METHOD lr_prc_planning_func->destroy.
  ENDIF.
  IF e_rc <> 0.
    RETURN.
  ENDIF.
  IF l_created = abap_true.
    e_refresh = 2.                       " refresh all
  ENDIF.
* ----- ----- -----
* export value (instance of clinical order)
  CLEAR ls_expvalue.
  ls_expvalue-type   = '000'.
  ls_expvalue-object = lr_corder.
  APPEND ls_expvalue TO et_expvalues.
* ----- ----- -----
ENDMETHOD.


METHOD call_clinical_order_print .

  DATA: l_parameter     LIKE LINE OF it_parameter,
        l_vcode         TYPE tndym-vcode,
        l_rc            TYPE ish_method_rc,
        l_is_inh        TYPE ish_on_off,
        l_printtype     TYPE sy-ucomm,
        lr_config       TYPE REF TO cl_ish_con_corder,
        lr_process      TYPE REF TO cl_ish_prc_corder,
        lt_corders      TYPE ishmed_t_corder_object,
        lr_corder       TYPE REF TO cl_ish_corder,
        lt_prereg       TYPE ishmed_t_prereg_object,
        lt_cordpos      TYPE ish_t_cordpos,
        lr_cordpos      TYPE REF TO cl_ishmed_prereg,
        l_cord_corderid TYPE n1cordid,
        l_cpos_corderid TYPE n1cordid,
        lt_print_form   TYPE ish_t_rnfor,
        l_no_dialog     TYPE ish_on_off.

  DATA: ls_objects     LIKE LINE OF it_objects,             "MED-39493
        lt_corders_tmp LIKE lt_corders,                     "MED-39493
        lt_objects_tmp LIKE it_objects.                     "MED-39493

  DATA: lv_print_dialog TYPE ish_on_off. "MED-57303 Cristina Geanta

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_printtype,
         lt_print_form.

  CLEAR: lr_corder, lr_config.

* create instance for errorhandling if not provided
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* set mode for print of clinical order
  l_vcode = 'PRT'.

* set print type
  CASE i_fcode.
    WHEN 'CORDP_STD'.                 " print standard SSF
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_std.
    WHEN 'CORDP_USER'.                " print customer SSF
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_user.
    WHEN 'CORDP_PROT'.                " print protokoll SSF
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_prot.
    WHEN 'CORDP_CORD'.                " print order detail std SSF
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_cord.
    WHEN 'CORDP_CPOS'.                " print position detail std SSF
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_cpos.
    WHEN 'CORDP_CORA'.                " print order detail user SSF
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_cora.
    WHEN 'CORDP_CPOA'.                " print position detail user SSF
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_cpoa.
    WHEN 'CORDP_CORD_XML'.            " print order detail XML
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_cord_xml.
    WHEN 'CORDP_CPOS_XML'.            " print position detail XML
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_cpos_xml.
    WHEN OTHERS.
      l_printtype = cl_ish_prc_corder=>co_okcode_prt_std.
  ENDCASE.

* at lease 1 entry has to be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                             " at least 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get marked clinical order(s)
* MED-39493: BEGIN OF DELETE
*  CALL METHOD cl_ishmed_functions=>get_orders
*    EXPORTING
*      it_objects     = it_objects
*    IMPORTING
*      e_rc           = e_rc
*      et_corders     = lt_corders
*    CHANGING
*      c_environment  = c_environment
*      c_errorhandler = c_errorhandler.
* MED-39493: END OF DELETE
* MED-39493: BEGIN OF INSERT
  LOOP AT it_objects INTO ls_objects.
    REFRESH: lt_objects_tmp, lt_corders_tmp.
    APPEND ls_objects TO lt_objects_tmp.
    CALL METHOD cl_ishmed_functions=>get_orders
      EXPORTING
        it_objects     = lt_objects_tmp
      IMPORTING
        e_rc           = e_rc
        et_corders     = lt_corders_tmp
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ELSE.
      APPEND LINES OF lt_corders_tmp TO lt_corders.
    ENDIF.
  ENDLOOP.
* MED-39493: END OF INSERT

  CHECK e_rc = 0.

* clinical order(s) found?
  IF lt_corders[] IS INITIAL.
*   message: please mark a clinical order
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1CORDMG'
        i_num  = '031'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Get marked cordpos objects (preregistrations).
  CALL METHOD cl_ishmed_functions=>get_preregistrations
    EXPORTING
      it_objects        = it_objects
      i_cancelled_datas = on
      i_exclude_corder  = on
    IMPORTING
      e_rc              = e_rc
      et_preregs        = lt_prereg
    CHANGING
      c_environment     = c_environment
      c_errorhandler    = c_errorhandler.
  CHECK e_rc = 0.

* instance for configuration in parameters table?
  LOOP AT it_parameter INTO l_parameter WHERE type = '000'.
    CHECK NOT l_parameter-object IS INITIAL.
    CALL METHOD l_parameter-object->('IS_INHERITED_FROM')
      EXPORTING
        i_object_type       = cl_ishmed_con_corder=>co_otype_con_corder
      RECEIVING
        r_is_inherited_from = l_is_inh.
    IF l_is_inh = on.
      lr_config ?= l_parameter-object.
      EXIT.
    ENDIF.
  ENDLOOP.

* create instance for configuration
  IF lr_config IS INITIAL.
    CALL METHOD cl_ish_fac_con_corder=>create
      IMPORTING
        er_instance     = lr_config
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* fill configuration instance
  IF NOT lr_config IS INITIAL.
*   set configuration flags
    CALL METHOD lr_config->set_commit
      EXPORTING
        i_commit = i_commit.
    CALL METHOD lr_config->set_save
      EXPORTING
        i_save = i_save.
    CALL METHOD lr_config->set_enqueue
      EXPORTING
        i_enqueue = i_enqueue.
    CALL METHOD lr_config->set_dequeue
      EXPORTING
        i_dequeue = i_dequeue.
*   Set flag to use print forms of config object.
*   If no forms available => select print forms in popup.
    CALL METHOD lr_config->set_use_print_form
      EXPORTING
        i_use_print_form = on.
*   Init print forms in config object (passing empty lt_print_form).
*   Popup will be presented when printing the first corder.
    CALL METHOD lr_config->set_t_print_form
      EXPORTING
        it_print_form = lt_print_form.
  ENDIF.

* create instance of process class for clinical order print
* (with first order)
  READ TABLE lt_corders INTO lr_corder INDEX 1.
  CHECK sy-subrc = 0 AND NOT lr_corder IS INITIAL.
  CALL METHOD cl_ish_fac_prc_corder=>create
    EXPORTING
      ir_corder       = lr_corder
      ir_environment  = c_environment
      ir_config       = lr_config
      ir_lock         = c_lock
      i_vcode         = l_vcode
    IMPORTING
      er_instance     = lr_process
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF e_rc <> 0.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* begin MED-57303 Cristina Geanta
  CALL FUNCTION 'ISH_GET_PARAMETER_ID'
    EXPORTING
      i_parameter_id    = 'N1CORD_PRINT_DIALOG'
    IMPORTING
      e_parameter_value = lv_print_dialog
      e_rc              = l_rc.
  IF l_rc NE 0.
    e_rc =  l_rc.
    EXIT.
  ENDIF.
* end MED-57303 Cristina Geanta

* Loop over marked clinical orders.
  LOOP AT lt_corders INTO lr_corder.
*MED-52454, show print dialog for all prints
*   First corder => show print dialog.
*    IF sy-tabix = 1.
*      l_no_dialog = off.
*    ELSE.
*      l_no_dialog = on.
*    ENDIF.
*    l_no_dialog = off. "MED-57303 Cristina Geanta
*END MED-52454.

* begin MED-57303 Cristina Geanta
    IF lv_print_dialog EQ on.
* Show print dialog only for the first clinical order
      IF sy-tabix = 1.
        l_no_dialog = off.
      ELSE.
        l_no_dialog = on.
      ENDIF.

    ELSE.
* Show print dialog for each clinical order
      l_no_dialog = off.
    ENDIF.
* end MED-57303 Cristina Geanta

    CLEAR: lt_cordpos[].
    IF i_fcode = 'CORDP_CPOS'.
*     Print only corder's marked cordpos objects.
      CALL METHOD lr_corder->get_corderid
        RECEIVING
          r_corderid = l_cord_corderid.
      LOOP AT lt_prereg INTO lr_cordpos.
        CALL METHOD lr_cordpos->get_corderid
          RECEIVING
            r_corderid = l_cpos_corderid.
        CHECK l_cord_corderid = l_cpos_corderid.
        APPEND lr_cordpos TO lt_cordpos.
      ENDLOOP.
    ENDIF.
*   Print clinical order.
    CALL METHOD lr_process->print
      EXPORTING
        ir_corder       = lr_corder
        it_cordpos      = lt_cordpos
        i_printtype     = l_printtype
        ir_environment  = c_environment
        ir_config       = lr_config
        i_no_dialog     = l_no_dialog
        i_fcode         = i_fcode         "CDuerr, MED-79815
        i_caller        = i_caller        "CDuerr, MED-79815
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.

    IF l_rc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.

  IF l_rc <> 0.
    e_rc      = 1.
    e_refresh = 0.
  ELSE.
    e_rc      = 0.
    e_refresh = 0.
  ENDIF.

ENDMETHOD.


METHOD call_clinical_order_search .

  DATA: lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_wp_views        TYPE TABLE OF v_nwpvz,
        ls_wp_view         TYPE v_nwpvz,
        l_parameter        LIKE LINE OF it_parameter,
        l_nwview_check     TYPE nwview,                     "#EC NEEDED
        l_viewid_call      TYPE nviewid,
        l_viewtype_call    TYPE nviewtype,
        l_viewid           TYPE nviewid,
        l_viewtype         TYPE nviewtype,
        l_placeid          TYPE nwplaceid,
*        l_placetype        TYPE nwplacetype,
        l_sortid           TYPE nwpvz-sortid,
        l_rc               TYPE ish_method_rc,
        lt_messages        TYPE bapiret2_t,
        ls_message         TYPE bapiret2.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* create instance for errorhandling if not provided
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* nothing or only 1 single entry should be selected
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '0'                 " nothing or just 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get marked patients
  CLEAR: l_npat, l_npap.
  REFRESH: lt_npat, lt_npap.
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_npat INTO l_npat INDEX 1.
  IF sy-subrc <> 0.
    READ TABLE lt_npap INTO l_npap INDEX 1.
  ENDIF.

* get calling viewid and viewtype
  CLEAR: l_viewtype, l_viewid.
  LOOP AT it_parameter INTO l_parameter WHERE type = '001'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_viewid = l_parameter-value.
    EXIT.
  ENDLOOP.
  LOOP AT it_parameter INTO l_parameter WHERE type = '002'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_viewtype = l_parameter-value.
    EXIT.
  ENDLOOP.

* get calling workplaceid and workplacetype
  CLEAR: l_placeid.
  LOOP AT it_parameter INTO l_parameter WHERE type = '003'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_placeid = l_parameter-value.
    EXIT.
  ENDLOOP.
*  CLEAR: l_placetype.
*  LOOP AT it_parameter INTO l_parameter WHERE type = '004'.
*    CHECK NOT l_parameter-value IS INITIAL.
*    l_placetype = l_parameter-value.
*    EXIT.
*  ENDLOOP.

* ID 14689: get place/view-info directly if not given
  IF l_placeid  IS INITIAL OR
     l_viewid   IS INITIAL OR
     l_viewtype IS INITIAL.
    CALL FUNCTION 'ISH_WP_ACTIVE_VIEWS_TRANSFER'
      IMPORTING
        e_wplace_id = l_placeid
        e_view_id   = l_viewid
        e_view_type = l_viewtype.
  ENDIF.

* get viewtype and viewid to call
  CLEAR: l_viewtype_call, l_viewid_call.
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '008'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_viewtype_call = l_parameter-value.
  ENDIF.
  IF NOT l_viewtype_call IS INITIAL.
    READ TABLE it_parameter INTO l_parameter WITH KEY type = '021'.
    IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
      l_viewid_call = l_parameter-value.
*     auf Korrektheit prüfen
      SELECT SINGLE * FROM nwview INTO l_nwview_check
             WHERE  viewtype  = l_viewtype_call
             AND    viewid    = l_viewid_call.
      IF sy-subrc <> 0.
*       Die Sicht & (Sichttyp &) wurde nicht gefunden
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '228'
            i_mv1  = l_viewid_call
            i_mv2  = l_viewtype_call
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

  IF l_viewtype_call IS INITIAL OR
     l_viewid_call   IS INITIAL.                            " ID 17796
    IF i_fcode = 'CORDS'.
      IF l_viewtype = '004'.
        l_viewtype_call = l_viewtype.
        l_viewid_call   = l_viewid.
      ELSE.
        l_viewtype_call = '004'.
      ENDIF.
    ELSE.
      IF l_viewtype = '010'.
        l_viewtype_call = l_viewtype.
        l_viewid_call   = l_viewid.
      ELSE.
        l_viewtype_call = '010'.
      ENDIF.
    ENDIF.
  ENDIF.

* get viewid if not given
  IF l_viewid_call IS INITIAL.
*   read all active views for the user
    CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
      EXPORTING
        i_uname  = sy-uname
        i_caller = i_caller
      TABLES
        t_nwpvz  = lt_wp_views.
    SORT lt_wp_views BY wplacetype wplaceid viewtype sortid.
*   get sortid of active view
    READ TABLE lt_wp_views INTO ls_wp_view
                           WITH KEY wplaceid = l_placeid
                                    viewid   = l_viewid.
    IF sy-subrc = 0.
      l_sortid = ls_wp_view-sortid.
    ENDIF.
*   get next view with requested viewtype
*   ... try if there is such a view after the active view
    LOOP AT lt_wp_views INTO ls_wp_view
                        WHERE wplaceid = l_placeid
                        AND   viewtype = l_viewtype_call
                        AND   sortid   > l_sortid.
      l_viewid_call = ls_wp_view-viewid.
      EXIT.
    ENDLOOP.
*   ... if there is no view after the active -> get the first
    IF sy-subrc <> 0.
      LOOP AT lt_wp_views INTO ls_wp_view
                          WHERE wplaceid = l_placeid
                          AND   viewtype = l_viewtype_call.
        l_viewid_call = ls_wp_view-viewid.
        EXIT.
      ENDLOOP.
    ENDIF.
    IF sy-subrc <> 0.
*     get sap-standard-view
      CALL FUNCTION 'ISHMED_VM_VIEW_SAP_STD_GET'
        EXPORTING
          i_viewtype = l_viewtype_call
        IMPORTING
          e_viewid   = l_viewid_call.
    ENDIF.
  ENDIF.        " IF l_viewid_call IS INITIAL

  CHECK NOT l_viewid_call IS INITIAL.

* call function to search clinical orders ...
  IF i_fcode = 'CORDS'.
*   ... all orders
    CALL FUNCTION 'ISHMED_CLINICAL_ORDER_SEARCH'
      EXPORTING
        i_institution           = i_einri
        i_wplace_id             = l_placeid
        i_view_id               = l_viewid_call
        i_view_type             = l_viewtype_call
        i_patnr                 = l_npat-patnr
        i_papid                 = l_npap-papid
*       I_SHOW_POPUP_LIST       = OFF
        ir_environment          = c_environment
      IMPORTING
        e_rc                    = l_rc
      CHANGING
        cr_errorhandler         = c_errorhandler
        cr_lock                 = c_lock.
  ELSEIF i_fcode = 'PRES'.
*   ... only orders of type 'preregistration'
    CALL FUNCTION 'ISH_PREREGISTRATION_SEARCH'
      EXPORTING
        i_institution           = i_einri
        i_user_id               = sy-uname
        i_wplace_id             = l_placeid
        i_view_id               = l_viewid_call
        i_view_type             = l_viewtype_call
        i_patnr                 = l_npat-patnr
        i_papid                 = l_npap-papid
*       I_SHOW_POPUP_LIST       = ' '
      IMPORTING
        e_rc                    = l_rc
      TABLES
        et_return               = lt_messages.
    IF l_rc <> 0.
      LOOP AT lt_messages INTO ls_message.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_bapiret
          EXPORTING
            i_bapiret       = ls_message
          CHANGING
            cr_errorhandler = c_errorhandler.
      ENDLOOP.
    ENDIF.
  ELSE.
    EXIT.
  ENDIF.

  CASE l_rc.
    WHEN 0.                              " OK
      e_rc      = 0.
      e_refresh = 0.
    WHEN 2.                              " cancel
      e_rc      = 1.
      e_refresh = 0.
    WHEN OTHERS.                         " error
      e_rc      = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_clinical_ordpos_cancel.

  DATA: lt_objects      TYPE ish_objectlist,
        ls_object       TYPE ish_object,
        lt_prereg       TYPE ishmed_t_prereg_object,
        lr_cordpos      TYPE REF TO cl_ishmed_prereg,
        l_rc            TYPE ish_method_rc,
        l_no_cancel     TYPE ish_on_off,
        l_cancelled     TYPE ish_on_off,
        l_pnamec        TYPE ish_pnamec,
        ls_n1vkg        TYPE n1vkg,
        l_orgid         TYPE norg-orgid,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,
        lt_messages     TYPE ishmed_t_messages.

* initializations
  e_rc        = 0.
  e_refresh   = 0.                                 " no refresh
  e_func_done = true.

* create errorhandler if not provided
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
    CHECK NOT c_environment IS INITIAL.
  ENDIF.

* check number of marked rows
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                  " at least one row marked
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get marked clinical order positions
  CALL METHOD cl_ishmed_functions=>get_preregistrations
    EXPORTING
      it_objects        = it_objects
      i_cancelled_datas = on
    IMPORTING
      e_rc              = e_rc
      et_preregs        = lt_prereg
    CHANGING
      c_environment     = c_environment
      c_errorhandler    = c_errorhandler.
  CHECK e_rc = 0.

* check clinical order positions
  IF lt_prereg[] IS INITIAL.
*   no positions marked => create message and exit
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1CORDMG'
        i_num  = '117'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.

* loop over order positions
  l_rc = 0.
  LOOP AT lt_prereg INTO lr_cordpos.
*   is the marked position cancelled?
    CALL METHOD lr_cordpos->is_cancelled
      IMPORTING
        e_cancelled = l_cancelled.
    IF l_cancelled = on.
*     get patient's name
      CALL METHOD cl_ish_utl_base_patient=>get_patname_for_object
        EXPORTING
          i_object       = lr_cordpos
        IMPORTING
          e_pnamec       = l_pnamec
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        CLEAR l_pnamec.
      ENDIF.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1CORDMG'
          i_num  = '030'
          i_mv1  = l_pnamec
          i_last = space.
      l_rc = 1.
    ELSE.
*     save for cancel
      ls_object-object = lr_cordpos.
      APPEND ls_object TO lt_objects.
*     get OU for cancel
      CALL METHOD lr_cordpos->get_data
        EXPORTING
          i_fill_prereg = off
        IMPORTING
          e_rc          = l_rc
          e_n1vkg       = ls_n1vkg.
      IF l_rc = 0.
        l_orgid = ls_n1vkg-trtoe.
      ENDIF.
    ENDIF.
  ENDLOOP.
* no objects => no further processing
  IF lt_objects[] IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* call cancel function
  CALL METHOD cl_ish_environment=>cancel_objects
    EXPORTING
      it_objects        = lt_objects
      i_orgid           = l_orgid
      i_caller          = i_caller
      i_last_srv_cancel = on
      i_vkg_cancel      = '*'
      i_movement_cancel = '*'
      i_save            = i_save
      i_enqueue         = i_enqueue
      i_commit          = i_commit
    IMPORTING
      e_rc              = l_rc
      e_no_cancel       = l_no_cancel
    CHANGING
      c_errorhandler    = lr_errorhandler
      c_lock            = c_lock.

* get messages from function CANCEL and set to global errorhandler
  CALL METHOD lr_errorhandler->get_messages
    IMPORTING
      t_extended_msg = lt_messages.
  IF NOT lt_messages[] IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        t_messages = lt_messages.
  ENDIF.

  IF l_no_cancel = on.
*   cancel (Abbrechen)
    e_rc = 2.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Handle error case.
  IF l_rc <> 0.
    e_rc = 1.
    EXIT.
  ELSE.
    e_refresh = 1.                       " refresh marked line(s)
  ENDIF.

ENDMETHOD.


METHOD call_clinical_ordpos_nstat.

  DATA: lt_prereg         TYPE ishmed_t_prereg_object,
        lt_prereg2        TYPE ishmed_t_prereg_object,
        lr_cordpos        TYPE REF TO cl_ishmed_prereg,
        l_rc              TYPE ish_method_rc,
        l_rc2             TYPE ish_method_rc,
        l_estat_changed   TYPE ish_on_off,
        l_cancelled       TYPE ish_on_off,
        l_pnamec          TYPE ish_pnamec.
  DATA: lr_err            TYPE REF TO cl_ishmed_errorhandling,  "CDuerr, MED-33240
        l_mv1             TYPE sy-msgv1,                        "CDuerr, MED-33240
        ls_n1vkg          TYPE n1vkg,                           "CDuerr, MED-33240
        lr_corder         TYPE REF TO cl_ish_corder,            "CDuerr, MED-33240
        ls_n1corder       TYPE n1corder,                        "CDuerr, MED-33240
        l_planoe          TYPE norg-orgid,                      "Grill, MED-38853
        ls_parameter      LIKE LINE OF it_parameter.            "Grill, MED-38853

* Initializations.
  e_rc        = 0.
  e_refresh   = 0.      "no refresh
  e_func_done = true.

* Create errorhandler if not provided.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Check fcode.
  CHECK i_fcode = 'CPOS_NSTAT'.

* Get environment.
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
    CHECK NOT c_environment IS INITIAL.
  ENDIF.

* Check number of marked rows.
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'         "at least one row marked
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Get marked cordpos objects (preregistrations).
  CALL METHOD cl_ishmed_functions=>get_preregistrations
    EXPORTING
      it_objects        = it_objects
      i_cancelled_datas = on
    IMPORTING
      e_rc              = e_rc
      et_preregs        = lt_prereg
    CHANGING
      c_environment     = c_environment
      c_errorhandler    = c_errorhandler.
  CHECK e_rc = 0.

* Check cordpos objects.
  IF lt_prereg[] IS INITIAL.
*   No cordpos marked => create message and exit.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1CORDMG'
        i_num  = '117'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.
*-- begin Grill, MED-38853
*-- get planning OU from parameter table
  CLEAR l_planoe.
  READ TABLE it_parameter INTO ls_parameter
   WITH KEY type = '005'.
  IF sy-subrc EQ 0.
    l_planoe = ls_parameter-value.
  ENDIF.
*-- end Grill, MED-38853

* Loop cordpos objects.
  LOOP AT lt_prereg INTO lr_cordpos.
    l_rc = 0.
*   Is the marked cordpos cancelled?
    CALL METHOD lr_cordpos->is_cancelled
      IMPORTING
        e_cancelled = l_cancelled.
    IF l_cancelled = off.
      APPEND lr_cordpos TO lt_prereg2.
    ELSE.
*     Get patient's name.
      CALL METHOD cl_ish_utl_base_patient=>get_patname_for_object
        EXPORTING
          i_object       = lr_cordpos
        IMPORTING
          e_pnamec       = l_pnamec
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        CLEAR l_pnamec.
      ENDIF.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1CORDMG'
          i_num  = '030'
          i_mv1  = l_pnamec
          i_last = space.
      l_rc2 = 1.
    ENDIF.
  ENDLOOP.

* No more cordpos => no further processing.
  IF lt_prereg2[] IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* New initialization.
* If one or more objects are saved => refresh marked line(s).
  e_refresh   = 1.       "refresh marked line

* Loop cordpos objects.
  LOOP AT lt_prereg2 INTO lr_cordpos.
*   Change state.
    CALL METHOD cl_ish_utl_cord=>change_state
      EXPORTING
        ir_cordpos       = lr_cordpos
        i_popup_allowed  = on                               " ID 17691
*       I_VKGID          =
*       I_TARGET_STATE   =
        i_set_next_state = on
        ir_environment   = c_environment
        i_planoe         = l_planoe                 "Grill, MED-38853
      IMPORTING
        e_rc             = l_rc
      CHANGING
*       cr_errorhandler  = c_errorhandler.          "CDuerr, MED-33240
        cr_errorhandler  = lr_err.                   "CDuerr, MED-33240
    IF l_rc <> 0.
*     Error occurred => no more processing.
      l_rc2 = 1.
*     CDuerr, MED-33240 - Begin
      CALL METHOD lr_cordpos->get_corder
        IMPORTING
          er_corder       = lr_corder
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF NOT lr_corder IS INITIAL.
        CALL METHOD lr_corder->get_data
          IMPORTING
            es_n1corder     = ls_n1corder
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = c_errorhandler.
      ENDIF.
      CALL METHOD lr_cordpos->get_data
        IMPORTING
          e_rc           = l_rc
          e_n1vkg        = ls_n1vkg
        CHANGING
          c_errorhandler = c_errorhandler.
      IF ls_n1corder-prgnr IS INITIAL.
        CONCATENATE ls_n1corder-cordtitle '/' ls_n1vkg-posnr INTO l_mv1.
      ELSE.
        CONCATENATE ls_n1corder-prgnr '/' ls_n1vkg-posnr INTO l_mv1.
      ENDIF.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1CORDMG'
          i_num  = '153'
          i_mv1  = l_mv1
          i_last = ' '.
*     CDuerr, MED-33240 - End
      CONTINUE.
    ENDIF.
*   Remember that at least one ESTAT was changed successfully.
    l_estat_changed = 'X'.
  ENDLOOP.
* Handle error case.
  IF l_rc2 <> 0 AND l_estat_changed = space.
    e_rc = 1.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD call_cwd .

  DATA: lt_srv                  TYPE ishmed_t_service_object,
        lr_srv                  LIKE LINE OF lt_srv,
        lt_nfal                 TYPE ishmed_t_nfal,
        ls_nfal                 LIKE LINE OF lt_nfal,
        lt_npat                 TYPE ishmed_t_npat,
        ls_npat                 LIKE LINE OF lt_npat,
        lt_npap                 TYPE ishmed_t_npap,
        ls_npap                 LIKE LINE OF lt_npap.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  REFRESH: lt_srv, lt_npat, lt_npap, lt_nfal.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* just 1 entry has to be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                                  " genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierten (Vorläufigen) Patienten (und Fall) ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
      i_read_db      = abap_true
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Funktion für vorläufige Patienten oder ohne Patient/Fall nicht möglich
  CLEAR: ls_npat, ls_npap, ls_nfal.
  READ TABLE lt_npat INTO ls_npat INDEX 1.
  READ TABLE lt_npap INTO ls_npap INDEX 1.
  READ TABLE lt_nfal INTO ls_nfal INDEX 1.
  IF ls_npat-patnr IS INITIAL AND ls_npap-papid IS NOT INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '763'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
  IF ls_npat-patnr IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '131'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
  IF ls_nfal-falnr IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1SRVDO_MED'
        i_num  = '018'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* check if a service has been marked
* if no service has been marked, the function will be called for the patient only
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_services    = lt_srv
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  IF lt_srv[] IS NOT INITIAL.
    READ TABLE lt_srv INTO lr_srv INDEX 1.
    CHECK sy-subrc = 0.
  ENDIF.

* call CWD application now
  CALL METHOD cl_ishmed_tpi_cwd_execute=>cwd_start_exe
    EXPORTING
      i_fcode         = i_fcode
      is_npat         = ls_npat
      is_nfal         = ls_nfal
      ir_service      = lr_srv
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.

  IF e_rc <> 0.
    e_rc = 1.
    e_refresh = 0.
*   ELSE.
*     e_refresh = 1.
  ENDIF.

ENDMETHOD.


METHOD call_diagnoses .

  DATA: lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Fall ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_nfal INTO l_nfal INDEX 1.
  IF sy-subrc <> 0.
*   Aufruf Diagnosenübersicht ohne Fall nicht möglich
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '559'
        i_last = space.
    e_rc      = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Diagnosen aufrufen
  CALL FUNCTION 'ISHMED_DIAGNOSEN'
    EXPORTING
      ss_list            = off
      ss_lock            = i_enqueue
      ss_nfal            = l_nfal
      ss_tcode           = 'N222'
    EXCEPTIONS
      ss_enq_error       = 1
      ss_nfal_not_found  = 2
      ss_tcode_not_valid = 3.

  CASE sy-subrc.
    WHEN 0.
      e_rc = 0.
      e_refresh = 1.
    WHEN 1.
*     Fehler beim Sperren des Falls &
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '081'
          i_mv1  = l_nfal-falnr
          i_last = space.
      e_rc      = 1.
      e_refresh = 0.
    WHEN OTHERS.
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_ifg_show_popup .

  DATA: lt_nlem            TYPE ishmed_t_nlem,
        lt_a_nlem          TYPE ishmed_t_nlem,
        l_nlem             TYPE nlem.
*        l_nbr_marked       TYPE i.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR:   l_nlem.
  REFRESH: lt_nlem, lt_a_nlem.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Markierte Leistung ermitteln
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nlem        = lt_nlem
      et_anchor_nlem = lt_a_nlem
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Ankerleistung ...
  CLEAR: l_nlem.
  READ TABLE lt_a_nlem INTO l_nlem WITH KEY ankls = 'X'.
  IF sy-subrc <> 0.
*   ... oder Einzelleistung
    READ TABLE lt_nlem INTO l_nlem INDEX 1.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ENDIF.

* display only if value exists
  CHECK NOT l_nlem-ifg IS INITIAL.

* display the popup
  CALL FUNCTION 'ISHMED_POPUP_SHOW_IFG'
    EXPORTING
      i_einri       = i_einri
      i_ifg         = l_nlem-ifg
    EXCEPTIONS
      ifg_not_found = 1
      OTHERS        = 2.
  CASE sy-subrc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
      e_refresh = 0.
      EXIT.
    WHEN 1.
*     Level of IFG does not exist
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '249'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    WHEN OTHERS.
*     Error during program execution
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '139'
          i_mv1  = sy-subrc
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
  ENDCASE.

ENDMETHOD.


METHOD call_lab_data .

  DATA: l_nbr_marked       TYPE i,
        l_name(50)         TYPE c,
        l_aufruf           TYPE sy-repid,
        l_own_orgid        TYPE norg-orgid,
        ls_parameter       LIKE LINE OF it_parameter,
        lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_display_mode(1)  TYPE c,
        l_npap             LIKE LINE OF lt_npap.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_nbr_marked, l_npat, l_npap, l_nfal, l_own_orgid.

  REFRESH: lt_nfal, lt_npat, lt_npap.

  l_aufruf = i_caller.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur kein oder genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '0'                                  " 0 oder 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

  IF l_nbr_marked = 1.
*   Markierte (vorläufige) Patienten und Fälle ermitteln
    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_nfal        = lt_nfal
        et_npat        = lt_npat
        et_npap        = lt_npap
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_npat INTO l_npat INDEX 1.
    READ TABLE lt_nfal INTO l_nfal INDEX 1.
*   Vorläufige Patienten markiert?
    DESCRIBE TABLE lt_npap.
    IF sy-tfill > 0.
*     Funktionen für voläufige Patienten nicht möglich
      LOOP AT lt_npap INTO l_npap.
        CLEAR l_name.
        PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                      l_npap-vorsw
                                                      l_npap-nname
                                                      l_npap-vname
                                                      l_name.
*       Patient noch nicht aufgenommen - Funktion nicht möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '617'
            i_mv1  = l_name
            i_mv2  = 'Funktion'(006)
            i_last = space.
      ENDLOOP.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* get org.unit out of parameter
  LOOP AT it_parameter INTO ls_parameter WHERE type = '016'.
    CHECK NOT ls_parameter-value IS INITIAL.
    l_own_orgid = ls_parameter-value.
    EXIT.
  ENDLOOP.

* get own org.unit if still empty
  IF l_own_orgid IS INITIAL.
    CALL FUNCTION 'ISHMED_GET_OWN_ORGID'
      EXPORTING
        i_einri  = i_einri
        i_datum  = sy-datum
        i_titel  = 'Suche der Pfleg.OE'(010)
        i_aufruf = l_aufruf
      IMPORTING
        e_orgid  = l_own_orgid
      EXCEPTIONS
        cancel   = 1
        OTHERS   = 2.
    CASE sy-subrc.
      WHEN 0.
*       OK
      WHEN 1.
*       Cancel
        e_rc = 2.
        e_refresh = 0.
        EXIT.
      WHEN OTHERS.
*       Error
        e_rc = 1.
        e_refresh = 0.
        EXIT.
    ENDCASE.
  ENDIF.

* Laborkumulativbefund aufrufen
  CALL FUNCTION 'ISH_N2_DISPLAY_LAB_DATA'
    EXPORTING
      ss_einri          = i_einri
      ss_patnr          = l_npat-patnr
      ss_falnr          = l_nfal-falnr
      ss_oe             = l_own_orgid
    IMPORTING
      e_display_mode    = l_display_mode
    EXCEPTIONS
      err_nodata        = 1
      err_system_failed = 2
      err_cust          = 3
      OTHERS            = 4.
  CASE sy-subrc.
    WHEN 0.
      e_rc = 0.
      IF l_display_mode = '1'. " see OSS 513015 2009/note 1353714
        e_refresh = 2.
      ELSE.
        e_refresh = 0.
      ENDIF.
    WHEN OTHERS.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = sy-msgty
          i_kla  = sy-msgid
          i_num  = sy-msgno
          i_mv1  = sy-msgv1
          i_mv2  = sy-msgv2
          i_mv3  = sy-msgv3
          i_mv4  = sy-msgv4
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_ltxt_sapscr .

  DATA: lt_corder          TYPE ishmed_t_corder_object,
        l_corder           LIKE LINE OF lt_corder,
        lt_request         TYPE ishmed_t_request_object,
        l_request          LIKE LINE OF lt_request,
        lt_srv             TYPE ishmed_t_service_object,
        l_srv              LIKE LINE OF lt_srv,
        lr_cpos_question   TYPE REF TO cl_ishmed_cpos_question,
        l_txt_typ(1)       TYPE c,
        l_text_id          TYPE ishmed_textid,
        l_parameter        LIKE LINE OF it_parameter,
        lr_object          TYPE n1objectref,
        lt_diagnosis       TYPE ish_objectlist,
        ls_object          LIKE LINE OF lt_diagnosis,
        lr_diag            TYPE REF TO cl_ish_prereg_diagnosis,
        ls_data_diag       TYPE rndip_attrib,
*        l_nbr_marked       TYPE i,
        l_vcode            TYPE vcode.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_txt_typ, l_vcode, l_parameter, l_text_id, lr_object.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Art des Langtextfelds für Sapscript-Editor bestimmen
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '006'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_txt_typ = l_parameter-value(1).
  ELSE.
    EXIT.
  ENDIF.

* Objekt für den Langtext bestimmen
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '000'.
  IF sy-subrc = 0 AND NOT l_parameter-object IS INITIAL.
    lr_object = l_parameter-object.
  ENDIF.

  l_vcode = 'DIS'.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

  CASE l_txt_typ.
*   zur Anforderung oder zum Klinischen Auftrag:
*   Kurzanamnese oder Fragestellung oder Bemerkung oder Diagnose
    WHEN 'A' OR 'F' OR 'B' OR 'D'.
*     Markierte Anforderung ermitteln
      CALL METHOD cl_ishmed_functions=>get_requests
        EXPORTING
          it_objects     = it_objects
        IMPORTING
          e_rc           = e_rc
          et_requests    = lt_request
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
      READ TABLE lt_request INTO l_request INDEX 1.
      IF sy-subrc = 0.
        CASE l_txt_typ.
          WHEN 'A'.
            l_text_id = cl_ishmed_request=>co_text_kanam.
          WHEN 'F'.
            l_text_id = cl_ishmed_request=>co_text_frage.
          WHEN 'B'.
            l_text_id = cl_ishmed_request=>co_text_bhanf.
          WHEN 'D'.
            l_text_id = cl_ishmed_request=>co_text_ditxt.
        ENDCASE.
        CALL METHOD l_request->edit_text
          EXPORTING
            i_text_id      = l_text_id
            i_vcode        = l_vcode
          IMPORTING
            e_rc           = e_rc
          CHANGING
            c_errorhandler = c_errorhandler.
      ELSE.
*       Falls keine Anforderung markiert ist,
*       den markierten Klinischen Auftrag ermitteln
        CALL METHOD cl_ishmed_functions=>get_orders
          EXPORTING
            it_objects     = it_objects
          IMPORTING
            e_rc           = e_rc
            et_corders     = lt_corder
          CHANGING
            c_environment  = c_environment
            c_errorhandler = c_errorhandler.
        CHECK e_rc = 0.
        READ TABLE lt_corder INTO l_corder INDEX 1.
        IF sy-subrc = 0.
          CASE l_txt_typ.
            WHEN 'A'.
              l_text_id = cl_ish_corder=>co_text_kanam.
            WHEN 'F'.
              l_text_id = cl_ish_corder=>co_text_frage.
            WHEN 'B'.
              l_text_id = cl_ish_corder=>co_text_rmcord.
            WHEN 'D'.
              l_text_id = cl_ish_prereg_diagnosis=>co_text_diltxt.
          ENDCASE.
          IF l_txt_typ <> 'D'.
            CALL METHOD l_corder->edit_text
              EXPORTING
                i_text_id      = l_text_id
                i_vcode        = l_vcode
              IMPORTING
                e_rc           = e_rc
              CHANGING
                c_errorhandler = c_errorhandler.
          ELSE.
*           diagnosis of clinical order
            CLEAR lr_diag.
            IF NOT lr_object IS INITIAL.
              TRY.
                  lr_diag ?= lr_object.
                CATCH cx_sy_move_cast_error.
                  CLEAR lr_diag.
              ENDTRY.
            ENDIF.
            IF lr_diag IS INITIAL.
*             if no certain diagnosis was given, get it from order
              REFRESH: lt_diagnosis.
              CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
                EXPORTING
                  ir_corder       = l_corder
                  ir_environment  = c_environment
                IMPORTING
                  e_rc            = e_rc
                  et_diagnosis    = lt_diagnosis
                CHANGING
                  cr_errorhandler = c_errorhandler.
              CHECK e_rc = 0.
              LOOP AT lt_diagnosis INTO ls_object.
                lr_diag ?= ls_object-object.
                CALL METHOD lr_diag->get_data
                  IMPORTING
                    es_data        = ls_data_diag
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                CHECK e_rc = 0.
                IF ls_data_diag-diklat = on.
                  EXIT.
                ENDIF.
              ENDLOOP.
            ENDIF.
            IF NOT lr_diag IS INITIAL AND e_rc = 0.
              CALL METHOD lr_diag->edit_text
                EXPORTING
                  i_text_id      = l_text_id
                  i_vcode        = l_vcode
                IMPORTING
                  e_rc           = e_rc
                CHANGING
                  c_errorhandler = c_errorhandler.
            ENDIF.
          ENDIF.
        ELSE.
*         Falls weder eine Anforderung noch ein Auftrag markiert
*         ist, dann kann kein Langtext dieser Art angezeigt werden
          EXIT.
        ENDIF.
      ENDIF.
*   Leistung (Leistungstext oder Ergänzender Text zur Leistung)
    WHEN 'L' OR 'E'.
      CALL METHOD cl_ishmed_functions=>get_services
        EXPORTING
          it_objects     = it_objects
        IMPORTING
          e_rc           = e_rc
          et_services    = lt_srv
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
      READ TABLE lt_srv INTO l_srv INDEX 1.
      CHECK sy-subrc = 0.
      CASE l_txt_typ.
        WHEN 'L'.
          l_text_id = cl_ishmed_service=>co_text_leitx.
        WHEN 'E'.
          l_text_id = cl_ishmed_service=>co_text_ergtx.
      ENDCASE.
      CALL METHOD l_srv->edit_text
        EXPORTING
          i_text_id      = l_text_id
          i_vcode        = l_vcode
        IMPORTING
          e_rc           = e_rc
        CHANGING
          c_errorhandler = c_errorhandler.
*   Fragestellung der Auftragsposition (MED-34502)
    WHEN 'P'.
      l_text_id = cl_ishmed_cpos_question=>co_text_cpos_question.
      CLEAR lr_cpos_question.
      IF lr_object IS NOT INITIAL.
        TRY.
            lr_cpos_question ?= lr_object.
          CATCH cx_sy_move_cast_error.
            CLEAR lr_cpos_question.
        ENDTRY.
      ENDIF.
      IF lr_cpos_question IS NOT INITIAL.
        CALL METHOD lr_cpos_question->edit_text
          EXPORTING
            i_text_id      = l_text_id
            i_vcode        = l_vcode
          IMPORTING
            e_rc           = e_rc
          CHANGING
            c_errorhandler = c_errorhandler.
      ENDIF.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

  e_refresh = 0.

ENDMETHOD.


METHOD call_material_end .

  DATA: lt_obj                LIKE it_objects,
        l_obj                 LIKE LINE OF lt_obj,
        l_object              LIKE LINE OF it_objects,
        l_rc                  TYPE ish_method_rc,
        ls_nlei               TYPE nlei,
        lr_srv                TYPE REF TO cl_ishmed_service,
        lr_identify           TYPE REF TO if_ish_identify_object.

* Initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es muß mind. 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

** Environment ermitteln
*  IF c_environment IS INITIAL.
*    CALL METHOD cl_ishmed_functions=>get_environment
*      EXPORTING
*        it_objects    = it_objects
*      CHANGING
*        c_environment = c_environment.
*  ENDIF.

* only services can be marked
  REFRESH lt_obj.
  LOOP AT it_objects INTO l_object.
    TRY.
        lr_identify ?= l_object-object.
        IF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on OR
           lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = on.
          l_obj-object = l_object-object.
          APPEND l_obj TO lt_obj.
        ENDIF.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
  ENDLOOP.
  IF lt_obj[] IS INITIAL.
*   Bitte nur Leistungen markieren
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '754'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.

  LOOP AT lt_obj INTO l_obj.
    lr_srv ?= l_obj-object.
    CALL METHOD lr_srv->get_data
      IMPORTING
        e_rc           = l_rc
        e_nlei         = ls_nlei
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    CALL FUNCTION 'ISHMED_MATVERBRAUCH_BEENDEN'
      EXPORTING
        i_einri           = i_einri
        i_lnrls           = ls_nlei-lnrls
        i_chk_auth        = on
        i_sperren         = on
      EXCEPTIONS
        service_not_found = 1
        no_mat_found      = 2
        no_auth           = 3
        no_update         = 4
        already_closed    = 5
        no_op_beg         = 6
        mat_service_error = 7
        lock_error        = 8
        OTHERS            = 9.
    CASE sy-subrc.
      WHEN 0.
*       Materialverbrauchsdokumentation & wurde abgeschlossen
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '595'
            i_mv1  = ls_nlei-erboe
            i_last = space.
      WHEN 1.
*       Leistung & & ist ungültig
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '178'
            i_last = space.
        e_rc = 1.
        EXIT.
      WHEN 2.
*       Es wurden noch keine Materialien zur Operation & erfaßt
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '594'
            i_mv1  = ls_nlei-erboe
            i_last = space.
        e_rc = 1.
        EXIT.
      WHEN 3.
*       Keine Berechtigung für Funktion &
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '238'
            i_mv1  = 'Materialerfassung beenden'(027)
            i_last = space.
        e_rc = 1.
        EXIT.
      WHEN 4.
*       &: Es wurde keine Verbuchung durchgeführt
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '830'
            i_mv1  = 'Materialerfassung beenden'(027)
            i_last = space.
        e_rc = 1.
        EXIT.
      WHEN 5.
*       Materialverbrauchsdokumentation & wurde bereits abgeschlossen
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '599'
            i_mv1  = ls_nlei-erboe
            i_last = space.
        e_rc = 1.
        EXIT.
      WHEN 6.
*       OP hat noch nicht begonnen
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '444'
            i_last = space.
        e_rc = 1.
        EXIT.
      WHEN 7.
*       Fehler beim Verbuchen der Material-Leistung -> keine Meldung
*       mehr ausgeben, wird bereits in ISHMED_MATVERBR_NLLZ ausgegeben
        e_rc = 1.
        EXIT.
      WHEN 8.
*       Fall ist bereits gesperrt-> keine Meldung mehr ausgeben, wird
*       bereits in ISHMED_MATVERBRAUCH_BEENDEN ausgegeben
        e_rc = 1.
        EXIT.
      WHEN OTHERS.
*       Es ist ein Fehler bei Verarbeitung aufgetreten (SY-SUBRC = &)
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '139'
            i_mv1  = sy-subrc
            i_last = space.
        e_rc = 1.
        EXIT.
    ENDCASE.
  ENDLOOP.

  e_refresh = 1.

ENDMETHOD.


METHOD call_material_proposal .

  DATA: l_op_beg           TYPE ish_on_off,
        lt_nlei            TYPE ishmed_t_nlei,
        l_nlei             LIKE LINE OF lt_nlei,
*        lt_nlem            TYPE ishmed_t_nlem,
        lt_a_nlei          TYPE ishmed_t_nlei,
        l_a_nlei           LIKE LINE OF lt_a_nlei,
        lt_a_nlem          TYPE ishmed_t_nlem,
        l_a_nlem           LIKE LINE OF lt_a_nlem,
        l_ntpt             TYPE ntpt,
        l_pop_tit(50)      TYPE c,
        l_sel_key          TYPE rn1f4-key,
        lt_help_tab        TYPE STANDARD TABLE OF rn1f4,
        l_help_tab         LIKE LINE OF lt_help_tab,
        l_headline         TYPE rn1f4.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Leistungen ermitteln
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects     = it_objects
      i_conn_srv     = on
    IMPORTING
      e_rc           = e_rc
      et_nlei        = lt_nlei
*      et_nlem        = lt_nlem
      et_anchor_nlei = lt_a_nlei
      et_anchor_nlem = lt_a_nlem
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.

* Funktion für bereits begonnene OPs nicht mehr möglich
  DESCRIBE TABLE lt_a_nlei.
  IF sy-tfill > 0.
    READ TABLE lt_a_nlei INTO l_a_nlei INDEX 1.
    READ TABLE lt_a_nlem INTO l_a_nlem INDEX 1.
    CALL FUNCTION 'ISHMED_CHECK_OP_BEGONNEN'
      EXPORTING
        i_einri  = i_einri
        i_anklei = l_a_nlei-lnrls
        i_nlei   = l_a_nlei
        i_nlem   = l_a_nlem
      IMPORTING
        e_op_beg = l_op_beg.
    IF l_op_beg = on.
*     Behandlung hat bereits begonnen - Mat.vorschlag nicht mehr mögl.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '731'
          i_last = space.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* Wieviel Leistungen?
  DESCRIBE TABLE lt_nlei.
  CASE sy-tfill.
    WHEN 0.
*     Materialvorschlag ohne Leistungen nicht möglich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '800'
          i_last = space.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    WHEN 1.
*     Nur 1 Leistung
      READ TABLE lt_nlei INTO l_nlei INDEX 1.
    WHEN OTHERS.
*     Popup zur Auswahl einer Leistung
      CLEAR: l_sel_key, l_headline, l_help_tab, l_pop_tit.
      REFRESH lt_help_tab.
      l_pop_tit = 'Selektion: Materialvorschlag'(007).
*     Überschrift erzeugen
      l_headline-code     = 'Leistung'(008).
      l_headline-text(16) = 'Bezeichnung'(009).
      LOOP AT lt_nlei INTO l_nlei.
        l_help_tab-key    = l_nlei-lnrls.
        l_help_tab-code   = l_nlei-leist.
        CALL FUNCTION 'ISH_READ_NTPT'
          EXPORTING
            einri     = i_einri
            talst     = l_nlei-leist
            tarif     = l_nlei-haust
          IMPORTING
            e_ntpt    = l_ntpt
          EXCEPTIONS
            not_found = 1
            OTHERS    = 2.
        IF sy-subrc = 0.
          l_help_tab-text   = l_ntpt-ktxt1.
        ELSE.
          CLEAR l_help_tab-text.
        ENDIF.
        APPEND l_help_tab TO lt_help_tab.
      ENDLOOP.
*     F4-Popup
      CALL FUNCTION 'ISHMED_F4_ALLG'
           EXPORTING
*                I_DISP_OTHER = ' '
                i_headline   = l_headline
                i_height     = 6
                i_len_code   = 10
                i_len_other  = 10
                i_len_text   = 40
                i_sort       = 'C'
                i_title      = l_pop_tit
                i_vcode      = 'UPD'
*                I_MFSEL      = ' '
                i_enter_key  = 'X'
           IMPORTING
                e_key        = l_sel_key
           TABLES
                t_f4tab      = lt_help_tab
           EXCEPTIONS
                OTHERS       = 1.
      IF sy-subrc = 0 AND NOT l_sel_key IS INITIAL.
        l_nlei-lnrls = l_sel_key.
        READ TABLE lt_nlei INTO l_nlei WITH KEY lnrls = l_nlei-lnrls.
      ELSE.
*       Cancel
        e_rc = 2.
        e_refresh = 0.
        EXIT.
      ENDIF.
  ENDCASE.

  REFRESH lt_nlei.                                      " MED-29512
  APPEND l_nlei TO lt_nlei.                             " MED-29512

* FBS aufrufen
  CALL FUNCTION 'ISHMED_MATERIALVORSCHLAG'
       EXPORTING
            einri    = i_einri
            orgid    = l_nlei-erboe
*           REPID    =
            lnrls    = l_nlei-lnrls
*           SAVKZ    = ' '
*           SELKZ    = ' '
*           VARKZ    = ' '
*           DKLKZ    = ' '
*           LEVKZ    = 0
            dymkz    = 'X'
*           PFTKZ    = ' '
*           MANRL    = 8
*           WERKL    = 4
*           MATXL    = 20
*           MSPEK    = ' '
*           MHITL    = ' '
*           BGLIN    = 1
*           ENLIN    = 22
*           BGCOL    = 5
*           ENCOL    = 70
*           ASYNC    =
*           COMIT    =
*      IMPORTING
*           REFLS    =
*           FCODE    =
       TABLES
            inlei    = lt_nlei
*           EMATV    =
*           IMAKL    =
       EXCEPTIONS
            no_op_oe = 1
            no_input = 2
            no_found = 3
            OTHERS   = 4.

  CASE sy-subrc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
      e_refresh = 0.
    WHEN OTHERS.
*     Error occured
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '086'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_med_document .

  DATA: l_name(50)         TYPE c,
        l_trans            LIKE sy-tcode,
*        l_okcode           TYPE sy-tcode,
        l_vma              TYPE ndoc-mitarb,
        lt_erboe           TYPE ishmed_t_orgid,
        l_erboe            LIKE LINE OF lt_erboe,
        l_oe               TYPE orgid,
        lt_ndoc            TYPE ishmed_t_ndoc,
        l_ndoc             LIKE LINE OF lt_ndoc,
        lt_nbew            TYPE ishmed_t_nbew,
        l_nbew             LIKE LINE OF lt_nbew,
        lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_nlei            TYPE ishmed_t_nlei,
        l_nlei             LIKE LINE OF lt_nlei,
        lt_anchor_nlei     TYPE ishmed_t_nlei,
        l_anchor_nlei      LIKE LINE OF lt_anchor_nlei, " MED-57771: MVoicu 28.10.2014
        l_tc_auth(1)       TYPE c,
        l_save_pat         TYPE npat-patnr,
        l_save_pzp         TYPE npat-pziff,
        l_save_fal         TYPE nfal-falnr,
        l_save_pzf         TYPE nfal-fziff,
        l_parameter        LIKE LINE OF it_parameter.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_trans, l_vma, l_erboe,
         l_ndoc, l_npat, l_npap, l_nfal, l_nbew, l_nlei, l_parameter.

  REFRESH: lt_ndoc, lt_nbew, lt_nfal, lt_npat, lt_npap, lt_erboe,
           lt_nlei, lt_anchor_nlei.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur kein oder genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '0'                                  " 0 oder 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierte (vorläufige) Patienten und Fälle ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_npat INTO l_npat INDEX 1.
  READ TABLE lt_nfal INTO l_nfal INDEX 1.

* Markierte Bewegungen ermitteln
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nbew        = lt_nbew
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_nbew INTO l_nbew INDEX 1.

* Vorläufige Patienten markiert?
  DESCRIBE TABLE lt_npap.
  IF sy-tfill > 0.
*   Dokumentfunktionen für voläufige Patienten nicht möglich
    LOOP AT lt_npap INTO l_npap.
      CLEAR l_name.
      PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                    l_npap-vorsw
                                                    l_npap-nname
                                                    l_npap-vname
                                                    l_name.
*     Patient noch nicht aufgenommen - Funktion nicht möglich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '617'
          i_mv1  = l_name
          i_mv2  = 'Funktion'(006)
          i_last = space.
    ENDLOOP.
    e_rc      = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Erbringende OE ermitteln
  CALL METHOD cl_ishmed_functions=>get_erboes
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_erboe       = lt_erboe
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_erboe INTO l_erboe INDEX 1.

* markierte Leistungen ermitteln (nur beim Anlegen)
  IF i_fcode = 'DOCI'.
    CALL METHOD cl_ishmed_functions=>get_services
      EXPORTING
        it_objects     = it_objects
*        i_conn_srv     = off
      IMPORTING
        e_rc           = e_rc
        et_nlei        = lt_nlei
        et_anchor_nlei = lt_anchor_nlei
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
*   keine stornierten Leistungen beachten
    DELETE lt_nlei        WHERE storn = on.
    DELETE lt_anchor_nlei WHERE storn = on.
*   nur wenn genau 1 Leistung markiert ist, das Dokument dazu anlegen
    DESCRIBE TABLE lt_nlei.
    IF sy-tfill = 1.
      DESCRIBE TABLE lt_anchor_nlei.
      IF sy-tfill = 0.
        READ TABLE lt_nlei INTO l_nlei INDEX 1.
      ENDIF.
    ENDIF.
*   Begin of MED-57771: MVoicu 28.10.2014
*   In case of anchor service, the document will contain no service.
*   This behavior is wrong, so the system will also verify if there is an anchor service.
    DESCRIBE TABLE lt_anchor_nlei.
    IF sy-tfill = 1.
      DESCRIBE TABLE lt_nlei.
      IF sy-tfill = 0.
        READ TABLE lt_anchor_nlei into l_anchor_nlei INDEX 1.
      ENDIF.
    ENDIF.
*   End of MED-57771: MVoicu 28.10.2014
  ENDIF.

* Transaktionscode für Dokumentaufruf festlegen
  CASE i_fcode.
    WHEN 'DOCI'.
      l_trans = 'N201'.  " Dokument anlegen
    WHEN OTHERS.
      IF i_fcode = 'DOCU' OR i_fcode = 'DOCD'.
*       falls ein bestimmtes Dokument übergeben wurde, genau dieses
*       Ändern oder Anzeigen (NDOC-Key aus Parametern übernehmen)
        LOOP AT it_parameter INTO l_parameter WHERE type = '022'.
          CHECK NOT l_parameter-value IS INITIAL.
          l_ndoc-mandt  = l_parameter-value(3).             "#EC ENHOK
          l_ndoc-dokar  = l_parameter-value+3(3).           "#EC ENHOK
          l_ndoc-doknr  = l_parameter-value+6(25).          "#EC ENHOK
          l_ndoc-dokvr  = l_parameter-value+31(2).          "#EC ENHOK
          l_ndoc-doktl  = l_parameter-value+33(3).          "#EC ENHOK
          l_ndoc-lfddok = l_parameter-value+36(10).         "#EC ENHOK
          EXIT.
        ENDLOOP.
      ENDIF.
      IF l_ndoc IS INITIAL.
        l_trans = 'N204'.  " allgemeines Einstiegsbild für Selektion
      ELSE.
        IF i_fcode = 'DOCU'.
          l_trans = 'N202'.  " Dokument ändern
        ELSEIF i_fcode = 'DOCD'.
          l_trans = 'N203'.  " Dokument anzeigen
        ENDIF.
      ENDIF.
  ENDCASE.

* Das Anlegen von technischen Dokumenten soll NICHT möglich sein
* (detto die Dokumentenübersicht)
* Anmerkung: die Dokumentenart 'MED' darf nicht hardcoded mitgegeben
*            werden, da dies ein variabler Wert aus dem Customizing ist
  IF l_ndoc IS INITIAL.
    l_ndoc-medok = 'X'.
    l_ndoc-mandt = sy-mandt.
    l_ndoc-einri = i_einri.
    l_ndoc-patnr = l_npat-patnr.
*   PATIENTENBEZOGENE Übersicht => ohne Fallnummer
    IF i_fcode NE 'DOLP'.
      l_ndoc-falnr = l_nfal-falnr.
    ENDIF.
    IF l_trans = 'N201'.
      l_ndoc-orgle  = l_erboe.
      l_ndoc-orgfa  = l_nbew-orgfa.
      l_ndoc-orgpf  = l_nbew-orgpf.
      l_ndoc-lfdbew = l_nbew-lfdnr.
      GET PARAMETER ID 'VMA' FIELD l_vma.
      l_ndoc-mitarb = l_vma.
*     Begin of MED-57771: MVoicu 28.10.2014
*     In case of anchor service, the document will contain no service.
*     This behavior is wrong, so the system will also verify if there is an anchor service.
*     l_ndoc-lnrls  = l_nlei-lnrls.
      IF l_nlei-lnrls IS NOT INITIAL.
        l_ndoc-lnrls = l_nlei-lnrls.
      ELSE. " In case of anchor service, the document will display the number of the corresponding service.
        l_ndoc-lnrls = l_anchor_nlei-lnrls.
      ENDIF.
*     End of MED-57771: MVoicu 28.10.2014
    ELSE.
*     PATIENTENBEZ. und FALLBEZ. Übersicht => ohne Lfd.Nr. der Bew.
      IF i_fcode NE 'DOLP' AND i_fcode NE 'DOLF'.
        l_ndoc-lfdbew = l_nbew-lfdnr.
      ENDIF.
    ENDIF.
  ENDIF.
  APPEND l_ndoc TO lt_ndoc.

* ID 13574: preallocate set/get-parameter DTY (document type)
  IF l_trans = 'N201'.
    l_oe = l_erboe.
    CALL FUNCTION 'ISHMED_SET_GET_DTY'
      EXPORTING
        i_institution = i_einri
        i_date        = sy-datum
        i_orgid       = l_oe.
  ENDIF.

* Dokumentfunktion aufrufen
  IF l_trans = 'N204'     AND
     lt_nfal[] IS INITIAL AND
     lt_npat[] IS INITIAL AND
     lt_nbew[] IS INITIAL.

*   Keine Markierung: Einstiegsbild der Dokumentenübersicht
    l_ndoc-medok = 'X'.
    EXPORT ndoc-medok FROM l_ndoc-medok TO MEMORY ID 'NDOC-MEDOK'.
    GET PARAMETER ID 'PAT' FIELD l_save_pat.
    GET PARAMETER ID 'PZP' FIELD l_save_pzp.
    GET PARAMETER ID 'FAL' FIELD l_save_fal.
    GET PARAMETER ID 'PZF' FIELD l_save_pzf.
    SET PARAMETER ID 'PAT' FIELD space.
    SET PARAMETER ID 'PZP' FIELD space.
    SET PARAMETER ID 'FAL' FIELD space.
    SET PARAMETER ID 'PZF' FIELD space.
    PERFORM call_tcode IN PROGRAM sapmnpa0
            USING 'N204' i_einri off l_tc_auth.
    SET PARAMETER ID 'PAT' FIELD l_save_pat.
    SET PARAMETER ID 'PZP' FIELD l_save_pzp.
    SET PARAMETER ID 'FAL' FIELD l_save_fal.
    SET PARAMETER ID 'PZF' FIELD l_save_pzf.

  ELSE.

*   Da beim Aufruf von Dokument anlegen auf der Dokumentenliste von
*   der GSD nicht der übergebene Key, sondern SET/GET-Parameter
*   verwendet wird, muß dieser hier noch gesetzt werden, da sonst ein
*   Dokument zu einem ganz anderen Patienten angelegt wird
    SET PARAMETER ID 'PAT' FIELD l_npat-patnr.
    SET PARAMETER ID 'PZP' FIELD l_npat-pziff.
    IF i_fcode EQ 'DOLP'.
      SET PARAMETER ID 'FAL' FIELD space.
      SET PARAMETER ID 'PZF' FIELD space.
    ELSE.
      SET PARAMETER ID 'FAL' FIELD l_nfal-falnr.
      SET PARAMETER ID 'PZF' FIELD l_nfal-fziff.
    ENDIF.

*   Aufruf des FBS zur Dokumentenverwaltung
    CALL FUNCTION 'ISH_N2_MEDICAL_DOCUMENT'
      EXPORTING
        ss_einri    = i_einri
        ss_tcode    = l_trans
*      IMPORTING
*        ss_okcode   = l_okcode
      TABLES
        ss_ndoc     = lt_ndoc
      EXCEPTIONS
        no_document = 1
        no_insert   = 2
        OTHERS      = 3.
    CASE sy-subrc.
      WHEN 0.
        e_rc = 0.
        e_refresh = 1.
*       Additional update for medical event documents (ID 17787)
        IF i_caller = 'WPV013'.
          CALL METHOD cl_ishmed_me_utl=>assign_meevent_docs
            EXPORTING
              it_objects      = it_objects
              it_ndoc         = lt_ndoc
            IMPORTING
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = c_errorhandler.
          IF e_rc <> 0.
            e_refresh = 0.
          ENDIF.
        ENDIF.
      WHEN 1.
*       Fehler bei der Verarbeitung (Nr. &)
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '139'
            i_mv1  = sy-subrc
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 2 OR 3.                     " Abbruch, kein Dokument
        e_rc = 2.
        e_refresh = 0.
    ENDCASE.

  ENDIF.

ENDMETHOD.


METHOD call_me_admin_event_bc.

  DATA: l_nbr_marked       TYPE i,
        l_name(50)         TYPE c,
        l_cancel           TYPE ish_on_off,
        l_caller           TYPE sy-cprog,
        l_orgpf            TYPE n1meorder-orgpf,
        l_orgfa            TYPE n1meorder-orgfa,
        ls_nwplace_001     TYPE nwplace_001,
        l_wplace_id        TYPE nwplace-wplaceid,
        l_parameter        LIKE LINE OF it_parameter,
        lt_nfal            TYPE ishmed_t_nfal,
        ls_nfal            LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        ls_npat            LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        ls_npap            LIKE LINE OF lt_npap.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_nbr_marked, ls_npat, ls_npap, ls_nfal, l_cancel,
         l_orgpf, l_orgfa, ls_nwplace_001, l_wplace_id.

  REFRESH: lt_nfal, lt_npat, lt_npap.

  l_caller = i_caller.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* only nothing or just one entry can be marked
* (Es kann nur kein oder genau 1 Eintrag markiert sein)
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '0'                                  " 0 oder 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

  IF l_nbr_marked = 1.
*   get marked (provisional) patients and cases
    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_nfal        = lt_nfal
        et_npat        = lt_npat
        et_npap        = lt_npap
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_npat INTO ls_npat INDEX 1.
    READ TABLE lt_nfal INTO ls_nfal INDEX 1.
*   provisional patients marked?
    DESCRIBE TABLE lt_npap.
    IF sy-tfill > 0.
*     funktion not possible for provisional patients
      LOOP AT lt_npap INTO ls_npap.
        CLEAR l_name.
        PERFORM concat_name IN PROGRAM sapmnpa0 USING ls_npap-titel
                                                      ls_npap-vorsw
                                                      ls_npap-nname
                                                      ls_npap-vname
                                                      l_name.
*       Patient noch nicht aufgenommen - Funktion nicht möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '617'
            i_mv1  = l_name
            i_mv2  = 'Funktion'(006)
            i_last = space.
      ENDLOOP.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

  CALL METHOD cl_ishmed_prc_me_admin_event=>call_admin_event_bc
    EXPORTING
      i_einri         = i_einri
      i_patnr         = ls_npat-patnr
    IMPORTING
      e_cancelled     = l_cancel
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.

  IF l_cancel = on.
    e_rc = 2.              " cancel
    e_refresh = 0.
  ELSE.
    CASE e_rc.
      WHEN 0.
        e_rc = 0.
        e_refresh = 1.
      WHEN OTHERS.
        e_rc = 1.
        e_refresh = 0.
    ENDCASE.
  ENDIF.

ENDMETHOD.


METHOD call_me_anamn_order_create.

  DATA: l_nbr_marked       TYPE i,
        l_name(50)         TYPE c,
        l_cancel           TYPE ish_on_off,
        l_caller           TYPE sy-cprog,
        l_orgpf            TYPE n1meorder-orgpf,
        l_orgfa            TYPE n1meorder-orgfa,
        ls_nwplace_001     TYPE nwplace_001,
        l_wplace_id        TYPE nwplace-wplaceid,
        l_parameter        LIKE LINE OF it_parameter,
        lt_nfal            TYPE ishmed_t_nfal,
        ls_nfal            LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        ls_npat            LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        ls_npap            LIKE LINE OF lt_npap.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_nbr_marked, ls_npat, ls_npap, ls_nfal, l_cancel,
         l_orgpf, l_orgfa, ls_nwplace_001, l_wplace_id.

  REFRESH: lt_nfal, lt_npat, lt_npap.

  l_caller = i_caller.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* only nothing or just one entry can be marked
* (Es kann nur kein oder genau 1 Eintrag markiert sein)
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '0'                                  " 0 oder 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

  IF l_nbr_marked = 1.
*   get marked (provisional) patients and cases
    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_nfal        = lt_nfal
        et_npat        = lt_npat
        et_npap        = lt_npap
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_npat INTO ls_npat INDEX 1.
    READ TABLE lt_nfal INTO ls_nfal INDEX 1.
*   provisional patients marked?
    DESCRIBE TABLE lt_npap.
    IF sy-tfill > 0.
*     funktion not possible for provisional patients
      LOOP AT lt_npap INTO ls_npap.
        CLEAR l_name.
        PERFORM concat_name IN PROGRAM sapmnpa0 USING ls_npap-titel
                                                      ls_npap-vorsw
                                                      ls_npap-nname
                                                      ls_npap-vname
                                                      l_name.
*       Patient noch nicht aufgenommen - Funktion nicht möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '617'
            i_mv1  = l_name
            i_mv2  = 'Funktion'(006)
            i_last = space.
      ENDLOOP.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* get OUs from workplace if possible
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '004'.
  IF sy-subrc = 0 AND l_parameter-value = '001'.
    READ TABLE it_parameter INTO l_parameter WITH KEY type = '003'.
    IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
      l_wplace_id = l_parameter-value.
      SELECT SINGLE * FROM nwplace_001 INTO ls_nwplace_001
             WHERE  wplacetype  = '001'
             AND    wplaceid    = l_wplace_id.
      IF sy-subrc = 0.
        l_orgpf = ls_nwplace_001-pflegoe.
        l_orgfa = ls_nwplace_001-fachloe.
      ENDIF.
    ENDIF.
  ENDIF.

* call function to create anamnestic order
  CALL FUNCTION 'ISHMED_ME_CREATE_ORDER'
    EXPORTING
      i_caller           = l_caller
      i_einri            = i_einri
      i_patnr            = ls_npat-patnr
      i_falnr            = ls_nfal-falnr
      i_orgpf            = l_orgpf
      i_orgfa            = l_orgfa
      i_create_anamnesis = on
      i_enqueue          = i_enqueue
      i_save             = i_save
      i_commit           = i_commit
      ir_environment     = c_environment
    IMPORTING
      e_rc               = e_rc
      e_cancelled        = l_cancel
    CHANGING
      cr_errorhandler    = c_errorhandler.

  IF l_cancel = on.
    e_rc = 2.              " cancel
    e_refresh = 0.
  ELSE.
    CASE e_rc.
      WHEN 0.
        e_rc = 0.
        e_refresh = 1.
      WHEN OTHERS.
        e_rc = 1.
        e_refresh = 0.
    ENDCASE.
  ENDIF.

ENDMETHOD.


METHOD call_me_order_change.

  DATA: l_nbr_marked   TYPE i,
        l_name(50)     TYPE c,
        l_orgpf        TYPE n1meorder-orgpf,
        l_orgfa        TYPE n1meorder-orgfa,
        ls_nwplace_001 TYPE nwplace_001,
        l_wplace_id    TYPE nwplace-wplaceid,
        l_parameter    LIKE LINE OF it_parameter,
        lt_nfal        TYPE ishmed_t_nfal,
        ls_nfal        LIKE LINE OF lt_nfal,
        lt_npat        TYPE ishmed_t_npat,
        ls_npat        LIKE LINE OF lt_npat,
        lt_npap        TYPE ishmed_t_npap,
        ls_npap        LIKE LINE OF lt_npap.

* vm med-58257 begin +
  DATA: lt_pfloe  TYPE ishmed_t_orgid,
        lt_fachoe TYPE ishmed_t_orgid,
        ls_pfloe  TYPE rn1orgid,
        ls_fachoe TYPE rn1orgid.
* vm med-58257 end +

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_nbr_marked, ls_npat, ls_npap, ls_nfal,
         l_orgpf, l_orgfa, ls_nwplace_001, l_wplace_id.

  REFRESH: lt_nfal, lt_npat, lt_npap.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* only nothing or just one entry can be marked
* (Es kann nur kein oder genau 1 Eintrag markiert sein)
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '0'                                  " 0 oder 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

  IF l_nbr_marked = 1.
*   get marked (provisional) patients and cases
    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_nfal        = lt_nfal
        et_npat        = lt_npat
        et_npap        = lt_npap
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_npat INTO ls_npat INDEX 1.
    READ TABLE lt_nfal INTO ls_nfal INDEX 1.
*   provisional patients marked?
    DESCRIBE TABLE lt_npap.
    IF sy-tfill > 0.
*     funktion not possible for provisional patients
      LOOP AT lt_npap INTO ls_npap.
        CLEAR l_name.
        PERFORM concat_name IN PROGRAM sapmnpa0 USING ls_npap-titel
                                                      ls_npap-vorsw
                                                      ls_npap-nname
                                                      ls_npap-vname
                                                      l_name.
*       Patient noch nicht aufgenommen - Funktion nicht möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '617'
            i_mv1  = l_name
            i_mv2  = 'Funktion'(006)
            i_last = space.
      ENDLOOP.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

  " vm med-58257 begin
  cl_ishmed_functions=>get_erboes(
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      et_erboe       =     " Erbringende OEs
      et_pfloe       = lt_pfloe
      et_fachoe      = lt_fachoe
    CHANGING
      c_errorhandler = c_errorhandler
  ).

  CASE e_rc.
    WHEN 0.
      e_rc = 0.
      e_refresh = 1.
    WHEN OTHERS.
      e_rc = 1.
      e_refresh = 0.
      RETURN.
  ENDCASE.

  READ TABLE lt_pfloe INDEX 1 INTO ls_pfloe.
  IF ls_pfloe IS NOT INITIAL.
    l_orgpf = ls_pfloe-orgid.
  ENDIF.

  READ TABLE lt_fachoe INDEX 1 INTO ls_fachoe.
  IF ls_fachoe IS NOT INITIAL.
    l_orgfa = ls_fachoe-orgid.
  ENDIF.

  IF l_orgpf IS INITIAL OR l_orgfa IS INITIAL.
    " vm med-58257 end

* get OUs from workplace if possible
    READ TABLE it_parameter INTO l_parameter WITH KEY type = '004'.
    IF sy-subrc = 0 AND l_parameter-value = '001'.
      READ TABLE it_parameter INTO l_parameter WITH KEY type = '003'.
      IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
        l_wplace_id = l_parameter-value.
        SELECT SINGLE * FROM nwplace_001 INTO ls_nwplace_001
               WHERE  wplacetype  = '001'
               AND    wplaceid    = l_wplace_id.
        IF sy-subrc = 0.
          l_orgpf = ls_nwplace_001-pflegoe.
          l_orgfa = ls_nwplace_001-fachloe.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDIF. "vm med-58257

  CALL METHOD cl_ishmed_dws_me_order=>call_dws_change
    EXPORTING
      i_einri         = i_einri
      i_patnr         = ls_npat-patnr
      i_falnr         = ls_nfal-falnr
      ir_environment  = c_environment
      i_orgpf         = l_orgpf
      i_orgfa         = l_orgfa
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.

  CASE e_rc.
    WHEN 0.
      e_rc = 0.
      e_refresh = 1.
    WHEN OTHERS.
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_me_order_create .

  DATA: l_nbr_marked   TYPE i,
        l_name(50)     TYPE c,
        l_cancel       TYPE ish_on_off,
        l_caller       TYPE sy-cprog,
        l_orgpf        TYPE n1meorder-orgpf,
        l_orgfa        TYPE n1meorder-orgfa,
        ls_nwplace_001 TYPE nwplace_001,
        l_wplace_id    TYPE nwplace-wplaceid,
        l_parameter    LIKE LINE OF it_parameter,
        lt_nfal        TYPE ishmed_t_nfal,
        ls_nfal        LIKE LINE OF lt_nfal,
        lt_npat        TYPE ishmed_t_npat,
        ls_npat        LIKE LINE OF lt_npat,
        lt_npap        TYPE ishmed_t_npap,
        ls_npap        LIKE LINE OF lt_npap.

* vm med-58257 begin +
  DATA: lt_pfloe  TYPE ishmed_t_orgid,
        lt_fachoe TYPE ishmed_t_orgid,
        ls_pfloe  TYPE rn1orgid,
        ls_fachoe TYPE rn1orgid.
* vm med-58257 end +

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_nbr_marked, ls_npat, ls_npap, ls_nfal, l_cancel,
         l_orgpf, l_orgfa, ls_nwplace_001, l_wplace_id.

  REFRESH: lt_nfal, lt_npat, lt_npap.

  l_caller = i_caller.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

*START MED-55285 Madalina P.
*First clear NPOL-buffer
  CALL METHOD cl_ishmed_functions=>npol_refresh
    EXPORTING
      i_einri         = i_einri
      it_objects      = it_objects
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
*END MED-55285 Madalina P.

* only nothing or just one entry can be marked
* (Es kann nur kein oder genau 1 Eintrag markiert sein)
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '0'                                  " 0 oder 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

  IF l_nbr_marked = 1.
*   get marked (provisional) patients and cases
    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_nfal        = lt_nfal
        et_npat        = lt_npat
        et_npap        = lt_npap
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_npat INTO ls_npat INDEX 1.
    READ TABLE lt_nfal INTO ls_nfal INDEX 1.
*   provisional patients marked?
    DESCRIBE TABLE lt_npap.
    IF sy-tfill > 0.
*     funktion not possible for provisional patients
      LOOP AT lt_npap INTO ls_npap.
        CLEAR l_name.
        PERFORM concat_name IN PROGRAM sapmnpa0 USING ls_npap-titel
                                                      ls_npap-vorsw
                                                      ls_npap-nname
                                                      ls_npap-vname
                                                      l_name.
*       Patient noch nicht aufgenommen - Funktion nicht möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '617'
            i_mv1  = l_name
            i_mv2  = 'Funktion'(006)
            i_last = space.
      ENDLOOP.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

  " vm med-58257 begin
  cl_ishmed_functions=>get_erboes(
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      et_erboe       =     " Erbringende OEs
      et_pfloe       = lt_pfloe
      et_fachoe      = lt_fachoe
    CHANGING
      c_errorhandler = c_errorhandler
  ).

  CASE e_rc.
    WHEN 0.
      e_rc = 0.
      e_refresh = 1.
    WHEN OTHERS.
      e_rc = 1.
      e_refresh = 0.
      RETURN.
  ENDCASE.

  READ TABLE lt_pfloe INDEX 1 INTO ls_pfloe.
  IF ls_pfloe IS NOT INITIAL.
    l_orgpf = ls_pfloe-orgid.
  ENDIF.

  READ TABLE lt_fachoe INDEX 1 INTO ls_fachoe.
  IF ls_fachoe IS NOT INITIAL.
    l_orgfa = ls_fachoe-orgid.
  ENDIF.

  IF l_orgpf IS INITIAL OR l_orgfa IS INITIAL.
    " vm med-58257 end

* get OUs from workplace if possible
    READ TABLE it_parameter INTO l_parameter WITH KEY type = '004'.
    IF sy-subrc = 0 AND l_parameter-value = '001'.
      READ TABLE it_parameter INTO l_parameter WITH KEY type = '003'.
      IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
        l_wplace_id = l_parameter-value.
        SELECT SINGLE * FROM nwplace_001 INTO ls_nwplace_001
               WHERE  wplacetype  = '001'
               AND    wplaceid    = l_wplace_id.
        IF sy-subrc = 0.
          l_orgpf = ls_nwplace_001-pflegoe.
          l_orgfa = ls_nwplace_001-fachloe.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDIF. "vm med-58257

* call function to create medication order
  CALL FUNCTION 'ISHMED_ME_CREATE_ORDER'
    EXPORTING
      i_caller        = l_caller
      i_einri         = i_einri
      i_patnr         = ls_npat-patnr
      i_falnr         = ls_nfal-falnr
      i_orgpf         = l_orgpf
      i_orgfa         = l_orgfa
*     I_CALL_TEMPLATE = OFF
*     IR_TEMPLATE     =
      i_enqueue       = i_enqueue
      i_save          = i_save
      i_commit        = i_commit
      ir_environment  = c_environment
    IMPORTING
      e_rc            = e_rc
      e_cancelled     = l_cancel
    CHANGING
*     Fichte, MED-30748: CR_LOCK does no longer exist since
*     medication now does no longer lock case or patient
*     cr_lock         = c_lock
*     Fichte, MED-30748 - End
      cr_errorhandler = c_errorhandler.

  IF l_cancel = on.
    e_rc = 2.              " cancel
    e_refresh = 0.
  ELSE.
    CASE e_rc.
      WHEN 0.
        e_rc = 0.
        e_refresh = 1.
      WHEN OTHERS.
        e_rc = 1.
        e_refresh = 0.
    ENDCASE.
  ENDIF.

ENDMETHOD.


METHOD call_nbop_create .

  DATA: l_rc               TYPE ish_method_rc,
        l_cancel           TYPE ish_on_off,
        lt_a_nlem          TYPE ishmed_t_nlem,
        ls_expvalue        LIKE LINE OF et_expvalues,
        lt_a_srv           TYPE ishmed_t_service_object,
        lr_a_srv           TYPE REF TO cl_ishmed_service,
        lr_nb_srv          TYPE REF TO cl_ishmed_service.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* only 1 entry can be marked
* (Es kann nur genau 1 Eintrag markiert sein)
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* get marked anchor service
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects         = it_objects
      i_conn_srv         = on
    IMPORTING
      e_rc               = e_rc
      et_anchor_services = lt_a_srv
      et_anchor_nlem     = lt_a_nlem
    CHANGING
      c_environment      = c_environment
      c_errorhandler     = c_errorhandler.
  CHECK e_rc = 0.

* main-op-anchor-service has to exist
* (Haupt-OP-Ankerleistung muß vorhanden sein)
  CLEAR: lr_a_srv.
  READ TABLE lt_a_nlem WITH KEY ankls = 'X' TRANSPORTING NO FIELDS.
  IF sy-subrc <> 0.
*   Funktion nur für Operationen verfügbar
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '790'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
  READ TABLE lt_a_srv INTO lr_a_srv INDEX 1.
  CHECK sy-subrc = 0.

* create op-anchor-service for secondary surgery now
  CALL FUNCTION 'ISHMED_NBOP_CREATE'
    EXPORTING
      ir_srv          = lr_a_srv
      i_enqueue       = i_enqueue
    IMPORTING
      e_rc            = l_rc
      e_cancel        = l_cancel
      er_srv          = lr_nb_srv
    CHANGING
      cr_errorhandler = c_errorhandler.

  IF l_rc = 0.
    IF l_cancel = on.
*     Cancel
      e_rc = 2.
      e_refresh = 0.
      EXIT.
    ELSE.
*     Everything OK
      e_rc = 0.
      e_refresh = 2.
*     return created anchor service
      IF lr_nb_srv IS BOUND.
        CLEAR ls_expvalue.
        ls_expvalue-type   = '000'.
        ls_expvalue-object = lr_nb_srv.
        APPEND ls_expvalue TO et_expvalues.
      ENDIF.
    ENDIF.
  ELSE.
    e_rc = 1.
    e_refresh = 0.
  ENDIF.

ENDMETHOD.


METHOD call_op_begonnen .

  DATA: l_ok               TYPE ish_on_off,
        l_op_beg           TYPE ish_on_off,
        l_cancel           TYPE ish_on_off,
        l_optag            TYPE nbew-bwidt,
        l_opzeit           TYPE nbew-bwizt,
        l_opraum           TYPE nbew-zimmr,
        l_n1arerdt(1)      TYPE c,
        l_planoe           TYPE orgid,
        ls_parameter       LIKE LINE OF it_parameter,
        l_ndoc             TYPE ndoc,                       "#EC NEEDED
        ls_nlei_tmp        TYPE nlei,                       "MED-32722
        lt_a_nlei          TYPE ishmed_t_nlei,
        l_a_nlei           LIKE LINE OF lt_a_nlei,
        lt_a_nlem          TYPE ishmed_t_nlem,
        l_a_nlem           LIKE LINE OF lt_a_nlem,
        lt_ntmn            TYPE ishmed_t_ntmn,
        lt_napp            TYPE ishmed_t_napp,
        l_napp             LIKE LINE OF lt_napp,
        lt_nbew            TYPE ishmed_t_nbew,
        l_nbew             LIKE LINE OF lt_nbew,
        lt_zeiten          TYPE STANDARD TABLE OF rn2zeiten,
        lt_doctypes        TYPE STANDARD TABLE OF rn2n2do,
        l_doctypes         LIKE LINE OF lt_doctypes,
        lt_n1orgpar        TYPE STANDARD TABLE OF n1orgpar,
        l_n1orgpar         LIKE LINE OF lt_n1orgpar,
        lr_zuoop           TYPE RANGE OF rn2n2do-zuooption,
        l_zuoop            LIKE LINE OF lr_zuoop,
        lr_zpber           TYPE RANGE OF n2ztpdef-zpber,
        l_zpber            LIKE LINE OF lr_zpber,
        lr_medok           TYPE RANGE OF ndoc-medok,
        l_medok            LIKE LINE OF lr_medok.

  DATA l_string_message TYPE string.    "MED-52726 AGujev
  DATA l_length TYPE i.                 "MED-52726 AGujev

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* get planning ou from parameter table (MED-41209)
  CLEAR l_planoe.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
  IF sy-subrc = 0.
    l_planoe = ls_parameter-value.
  ENDIF.

* Markierte Ankerleistung ermitteln
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects     = it_objects
      i_conn_srv     = on
    IMPORTING
      e_rc           = e_rc
      et_anchor_nlei = lt_a_nlei
      et_anchor_nlem = lt_a_nlem
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Haupt-OP-Ankerleistung muß vorhanden sein
  CLEAR: l_a_nlem, l_a_nlei.
  READ TABLE lt_a_nlem INTO l_a_nlem WITH KEY ankls = 'X'.
  IF sy-subrc <> 0.
*   Funktion nur für Operationen verfügbar
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '790'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
  READ TABLE lt_a_nlei INTO l_a_nlei WITH KEY lnrls = l_a_nlem-lnrls.
  CHECK sy-subrc = 0.

* Termin und Bewegung lesen
  REFRESH: lt_nbew, lt_ntmn, lt_napp.
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_ntmn        = lt_ntmn
      et_napp        = lt_napp
      et_nbew        = lt_nbew
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Einige Rangetabs für die Prüfungen befüllen
  REFRESH: lr_zpber, lr_zuoop, lr_medok.
  CLEAR:   l_zpber, l_zuoop, l_medok.
* Rangetab mit Zeitmarken für Haupt-OP-Bereich befüllen
  l_zpber-sign   = 'I'.
  l_zpber-option = 'EQ'.
  l_zpber-low    = 'O'.
  APPEND l_zpber TO lr_zpber.
  l_zpber-low    = 'P'.
  APPEND l_zpber TO lr_zpber.
  l_zpber-low    = 'A'.
  APPEND l_zpber TO lr_zpber.
  l_zpber-low    = 'B'.
  APPEND l_zpber TO lr_zpber.
* Range-Tab mit Dok.profil-Einträgen befüllen, die erst angelegt
* werden dürfen, wenn die OP begonnen wurde
  l_zuoop-sign   = 'I'.
  l_zuoop-option = 'EQ'.
  l_zuoop-low    = 'OP'.            " Knoten OP-Dokumentation
  APPEND l_zuoop TO lr_zuoop.
  l_zuoop-low    = 'AN'.            " Knoten AN-Dokumentation
  APPEND l_zuoop TO lr_zuoop.
* Range-Tab für Med. Dokumente füllen
  l_medok-sign   = 'I'.
  l_medok-option = 'EQ'.
  l_medok-low    = 'X'.                "Med. Dokumente
  APPEND l_medok TO lr_medok.

* Wert des OE-Parameters N1ARERDT ermitteln
  CLEAR l_n1orgpar. REFRESH lt_n1orgpar.
  CLEAR l_n1arerdt.
  PERFORM read_n1orgpar IN PROGRAM sapl0n1s
                        TABLES lt_n1orgpar
                        USING  i_einri l_a_nlei-erboe
                               'N1ARERDT' sy-datum.
  DESCRIBE TABLE lt_n1orgpar.
  IF sy-tfill > 0.
    READ TABLE lt_n1orgpar INTO l_n1orgpar INDEX 1.
    l_n1arerdt = l_n1orgpar-n1parwert.
  ENDIF.

* Kennzeichen, ob die OP begonnen werden darf, erstmal auf ON setzen
  l_ok = on.

* Prüfen, ob die OP begonnen ist
  CALL FUNCTION 'ISHMED_CHECK_OP_BEGONNEN'
    EXPORTING
      i_anklei = l_a_nlei-lnrls
    IMPORTING
      e_op_beg = l_op_beg.
  IF l_op_beg = on.
*   wenn die OP noch nicht begonnen ist,
*   kann die Funktion nur solange aufgerufen werden, solange ...
*   - und keine OP-Zeiten erfaßt wurden
*   - kein aktives Dokument aus dem Dok.profil existiert
    REFRESH: lt_zeiten, lt_doctypes.
    CLEAR:   l_doctypes.
*   Gesetzte Zeitmarken zur Ankerleistung lesen
    CALL FUNCTION 'ISH_N2_READ_OPZEITEN'
      EXPORTING
        ss_ankerleistung      = l_a_nlei-lnrls
      TABLES
        ss_zeiten             = lt_zeiten
      EXCEPTIONS
        no_ankerleistung      = 1
        no_zeitpunkt          = 2
        zeitpunkt_not_defined = 3
        OTHERS                = 4.
    IF sy-subrc = 0.
      DELETE lt_zeiten WHERE datum     IS INITIAL
                          OR uhrzeit   IS INITIAL
                          OR storno    =  on
                          OR NOT zpber IN lr_zpber
                          OR zpbew_erf = on.                " ID 14818
      IF NOT lt_zeiten[] IS INITIAL.
*       es gibt bereits Zeitmarken -> OP begonnen nicht möglich!
        l_ok = off.
      ENDIF.
    ENDIF.
    IF l_ok = on.
*     Dokumente des Dok.profils lesen
      CALL FUNCTION 'ISH_N2_OP_DOKTYPES_2'
        EXPORTING
          ll_einri          = i_einri
          ll_orgid          = l_a_nlei-erboe
          ll_dozuo          = '1'             " Haupt-OP
          ll_datum          = l_a_nlei-ibgdt
          ll_hierch         = off
          ll_platzh         = on
        TABLES
          doctypes          = lt_doctypes
        EXCEPTIONS
          profile_not_found = 1
          OTHERS            = 2.
      IF sy-subrc = 0.
        IF NOT l_a_nlem-patnr IS INITIAL.
          LOOP AT lt_doctypes INTO l_doctypes
                  WHERE zuooption  IN lr_zuoop
                     OR zuooption2 IN lr_zuoop
                     OR zuooption3 IN lr_zuoop.
            SELECT * FROM ndoc INTO l_ndoc
                   WHERE  einri  = i_einri
                   AND    patnr  = l_a_nlem-patnr
                   AND    falnr  = l_a_nlei-falnr
                   AND    lnrls  = l_a_nlei-lnrls
                   AND    dtid   = l_doctypes-dtid
                   AND    dtvers = l_doctypes-dtvers
                   AND    loekz  = off
                   AND    storn  = off
                   AND    medok IN lr_medok.
              EXIT.
            ENDSELECT.
            IF sy-subrc = 0.                 "Dok vorhanden
*             es gibt bereits Dokumente -> OP begonnen nicht möglich!
              l_ok = off.
              EXIT.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDIF.
    IF l_ok = off.
*     OP-begonnen ist nur möglich, solange keine Doku. existiert
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '470'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ELSE.
*   wenn die OP noch nicht begonnen ist,
*   kann die Funktion nur aufgerufen werden, wenn ein Termin existiert
    IF lt_ntmn[] IS INITIAL.
*     'OP begonnen' ist erst nach Terminvergabe möglich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '419'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

  CHECK l_ok = on.

  READ TABLE lt_nbew INTO l_nbew INDEX 1.
  IF sy-subrc = 0.
*   Bewegung existiert bereits
    IF NOT l_nbew-planb IS INITIAL.   " Nur beim 1. Aufruf vorbelegen
      IF l_n1arerdt = 'L'.
        l_optag    = l_a_nlei-pbgdt.     " Plandatum
        l_opzeit   = l_a_nlei-pbzt.      " Planzeit
      ELSE.
        l_optag    = sy-datum.           " mit Systemdatum
        l_opzeit   = sy-uzeit.           " und Systemzeit
      ENDIF.
    ELSE.
      l_optag    = l_nbew-bwidt.
      l_opzeit   = l_nbew-bwizt.
    ENDIF.
    l_opraum     = l_nbew-zimmr.
  ELSE.
*   Es existiert nur ein Termin
    IF l_n1arerdt = 'L'.
      l_optag    = l_a_nlei-pbgdt.       " Plandatum
      l_opzeit   = l_a_nlei-pbzt.        " Planzeit
    ELSE.
      l_optag    = sy-datum.             " mit Systemdatum
      l_opzeit   = sy-uzeit.             " und Systemzeit
    ENDIF.
    LOOP AT lt_napp INTO l_napp WHERE NOT zimmr IS INITIAL.
      l_opraum   = l_napp-zimmr.
    ENDLOOP.
  ENDIF.

* CDuerr, MED-32781 - Begin
  IF NOT l_a_nlei-einri IS INITIAL AND
     NOT l_a_nlei-falnr IS INITIAL.
    CALL FUNCTION 'ISH_CASE_POOL_REFRESH'
      EXPORTING
        ss_falnr = l_a_nlei-falnr
        ss_einri = l_a_nlei-einri.
    CALL FUNCTION 'ISH_POOL_REFRESH_FALNR'
      EXPORTING
        ss_falnr = l_a_nlei-falnr
        ss_einri = l_a_nlei-einri.
  ENDIF.
* CDuerr, MED-32781 - End

* OP-beginnen-Funktion nun aufrufen
  CALL FUNCTION 'ISHMED_SET_OP_BEGONNEN'
    EXPORTING
      pp_anklei         = l_a_nlei
      pp_popup          = on
      pp_lockfal        = on
      pp_environment    = c_environment
      pp_planoe         = l_planoe                          " MED-41209
    IMPORTING
      pp_cancel         = l_cancel
      pp_newanklei      = ls_nlei_tmp                       "MED-32722
    CHANGING
      pp_date           = l_optag
      pp_time           = l_opzeit
      pp_raum           = l_opraum
    EXCEPTIONS
      op_not_fnd        = 1
      op_beg_not_poss   = 2
      no_tmn_fnd        = 3
      no_fal_fnd        = 4
      no_auth           = 5
      op_bew_failed     = 6
      case_closed       = 7
      case_accounted    = 8
      case_discharged   = 9
      case_not_existent = 10
      case_locked       = 11
      error_sy_msgid    = 12                                " ID 17040
      OTHERS            = 13.

  IF sy-subrc = 0 AND l_cancel = on.
*   Cancel
    e_rc = 2.
    e_refresh = 0.
* - - - - - - MED-32722 C. Honeder BEGIN
*   If case assignement has been done we have to refresh
    IF ls_nlei_tmp-falnr <> l_a_nlei-falnr.
      e_refresh = 2.
    ENDIF.
* - - - - - - MED-32722 C. Honeder END
    EXIT.
  ELSE.
    CASE sy-subrc.
      WHEN 0.
*       Everything OK
        e_rc = 0.
*       Alles (ganze Liste) aktualisieren, da ja u.U. die OP nun
*       z.b. vom Arbeitsvorrat in den Planungsbereich verschoben
*       wurde ...
        e_refresh = 2.
      WHEN 2.
*       OP beginnen nicht möglich ...
*       Keine Meldung notwendig - Wird bereits im FBS ausgegeben
*        e_rc = 1.              "REM MED-33557
        e_rc = 2.                                           "MED-33557
*        e_refresh = 0.         "REM MED-33557
        e_refresh = 2.                                      "MED-33557
      WHEN 3.
*       'OP begonnen' ist erst nach Terminvergabe möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '419'
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 4.
*       Es konnte kein gültiger Fall für diesen Patienten gef. werden
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '140'
            i_mv1  = ''
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 5.
*       Keine Berechtigung um die Operation zu beginnen
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '553'
            i_mv1  = ''
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 6.
*       Fehler beim Speichern der Bewegung (ID 17261)
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '050'
            i_mv1  = ''
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 7.
**** Start: MED-49596 M.Rebegea 30.01.2013
* We need to pass the casenumber
        IF l_a_nlei-falnr IS INITIAL.
          l_a_nlei-falnr = sy-msgv1.
        ENDIF.
**** End: MED-49596 M.Rebegea 30.01.2013
*       Fall bereits abgeschlossen
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'N1'
            i_num  = '722'
            i_mv1  = l_a_nlei-falnr
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 8.
*       Fall bereits abgerechnet
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '728'
            i_mv1  = l_a_nlei-falnr
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 9.
*       Fall bereits entlassen
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '047'
            i_mv1  = l_optag
            i_mv2  = l_a_nlei-falnr
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 10.
*       Fall noch nicht existent
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '624'
            i_mv1  = l_a_nlei-falnr
            i_mv2  = l_optag
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
      WHEN 11.
*       Fall bereits gesperrt (Meldung bereits ausgegeben!)
        e_rc = 1.
        e_refresh = 0.
*-->begin of MED-52726 AGujev
        l_string_message = sy-msgv4.
        l_length = strlen( l_string_message ) - 2.
        IF l_length >= 0.
          l_string_message = l_string_message+l_length(2).
        ENDIF.
        IF l_string_message = '37'.
          l_string_message = sy-msgv4.
          l_length = strlen( l_string_message ) - 2.
          l_string_message = l_string_message(l_length).
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = sy-msgty
              i_kla  = sy-msgid
              i_num  = sy-msgno
              i_mv1  = sy-msgv1
              i_mv2  = sy-msgv2
              i_mv3  = sy-msgv3
              i_mv4  = l_string_message
              i_last = space.
        ENDIF.
*<--end of MED-52726 AGujev
      WHEN 12.                                              " ID 17040
*       Meldung wird beim RAISE im FuB erstellt - hier ausgeben!
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          CHANGING
            cr_errorhandler = c_errorhandler.
        e_rc = 1.
        e_refresh = 0.
      WHEN OTHERS.
*       Daten sind inkonsistent - Aktion kann nicht durchgef. werden
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '088'
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
    ENDCASE.
  ENDIF.

ENDMETHOD.


METHOD call_op_details .

  DATA: ls_object           LIKE LINE OF it_objects,
        lt_obj              TYPE ish_objectlist,
        lt_service          TYPE TABLE OF rn1display_fields,
        ls_service          LIKE LINE OF lt_service,
        lt_outtab           TYPE TABLE OF rn1list132,
        ls_outtab           LIKE LINE OF lt_outtab,
        lt_nrsf             TYPE TABLE OF nrsf,
        lt_tn39t            TYPE TABLE OF tn39t,
        ls_tn39t            LIKE LINE OF lt_tn39t,
        lt_npat             TYPE ishmed_t_npat,
        ls_npat             LIKE LINE OF lt_npat,
        lt_a_srv            TYPE ishmed_t_service_object,
        lr_anchor           TYPE REF TO cl_ishmed_service,
        lt_srv              TYPE ishmed_t_service_object,
        lr_srv              TYPE REF TO cl_ishmed_service,
        lr_dspobj           TYPE REF TO cl_ishmed_dspobj_operation,
        lr_obj              TYPE REF TO object,
        l_srv_lgrbez        TYPE ish_on_off,
        l_title             TYPE text30,
        l_cnt               TYPE i,
        l_cancelled         TYPE ish_on_off.

* initializing
  CLEAR e_rc.
  e_refresh = 0.
  REFRESH: lt_obj, lt_service, lt_outtab, lt_npat, lt_nrsf,
           lt_a_srv, lt_srv.

  e_func_done = true.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* only just 1 entry can be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* get instance of display object operation
* (to get data for surgery and to check if it is a surgery!)
  READ TABLE it_objects INTO ls_object INDEX 1.
  CHECK sy-subrc = 0.
  CALL METHOD cl_ishmed_dspobj_operation=>if_ish_display_object~load
    EXPORTING
      i_object         = ls_object-object
*      I_NODE_OPEN      = 'X'
*      I_CANCELLED_DATA = SPACE
    IMPORTING
      e_instance       = lr_obj
      e_cancelled      = l_cancelled
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = c_errorhandler
      c_environment    = c_environment.
  IF e_rc <> 0.
*   Funktion nur für Operationen verfügbar
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '790'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
  CHECK lr_obj IS BOUND.
  lr_dspobj ?= lr_obj.
  CALL METHOD lr_dspobj->if_ish_display_object~set_main_data
    EXPORTING
      i_object       = ls_object-object
      i_check_only   = off
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler
      c_environment  = c_environment.
  CHECK e_rc = 0.
  CALL METHOD lr_dspobj->if_ish_display_object~get_data
    IMPORTING
      et_object = lt_obj.

* get services
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects         = lt_obj
      i_cancelled_datas  = l_cancelled
    IMPORTING
      e_rc               = e_rc
      et_services        = lt_srv
      et_anchor_services = lt_a_srv
    CHANGING
      c_environment      = c_environment
      c_errorhandler     = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_a_srv INTO lr_anchor INDEX 1.

* get patient
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = lt_obj
    IMPORTING
      e_rc           = e_rc
      et_npat        = lt_npat
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_npat INTO ls_npat INDEX 1.

* build output table for popup
  CLEAR l_cnt.
  LOOP AT lt_srv INTO lr_srv.
    l_cnt = l_cnt + 1.
    CLEAR ls_service.
    ls_service-einri = i_einri.
    ls_service-seqno = l_cnt.
    CALL METHOD cl_ish_display_tools=>fill_service_data
      EXPORTING
        i_service      = lr_srv
        i_node_closed  = off
*        I_PLACE_HOLDER = '-'
        i_anchor       = lr_anchor
        it_services    = lt_srv
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_outtab_line  = ls_service
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    APPEND ls_service TO lt_service.
  ENDLOOP.
  CHECK e_rc = 0.
  DESCRIBE TABLE lt_service.
  IF sy-tfill > 0.
*   Leistungsbezeichnung + Lagerungsart
    l_srv_lgrbez = off.
    LOOP AT lt_service INTO ls_service WHERE srv_lgrbez IS NOT INITIAL.
      l_srv_lgrbez = on.
      EXIT.
    ENDLOOP.
*   header service
    CLEAR ls_outtab.
    ls_outtab-color = 4.
    ls_outtab-text  = 'Leistungen'(018).
    IF l_srv_lgrbez = on.
      CONCATENATE ls_outtab-text '(' 'Lagerungen'(020) ')'
             INTO ls_outtab-text SEPARATED BY space.
    ENDIF.
    APPEND ls_outtab TO lt_outtab.
*   detail service
    LOOP AT lt_service INTO ls_service.
      CLEAR ls_outtab.
      IF ls_service-srv_bez IS INITIAL.
        ls_service-srv_bez = '-'.
      ENDIF.
      ls_outtab-text = ls_service-srv_bez.
      IF l_srv_lgrbez = on.
        IF ls_service-srv_lgrbez IS INITIAL.
          ls_service-srv_lgrbez = '-'.
        ENDIF.
        CONCATENATE ls_outtab-text '(' ls_service-srv_lgrbez ')'
               INTO ls_outtab-text SEPARATED BY space.
      ENDIF.
      APPEND ls_outtab TO lt_outtab.
    ENDLOOP.
  ENDIF.
* Infektionsgrad
  LOOP AT lt_service INTO ls_service WHERE ifgr_txt IS NOT INITIAL.
*   header infection
    IF sy-tabix = 1.
      CLEAR ls_outtab.
      ls_outtab-text  = 'Infektionsgrad'(019).
      ls_outtab-color = 4.
      APPEND ls_outtab TO lt_outtab.
    ENDIF.
*   detail infection
    CLEAR ls_outtab.
    ls_outtab-text = ls_service-ifgr_txt.
    APPEND ls_outtab TO lt_outtab.
  ENDLOOP.
* Risikofaktoren
  IF ls_npat-patnr IS NOT INITIAL.
    SELECT * FROM nrsf INTO TABLE lt_nrsf
           WHERE  patnr  = ls_npat-patnr
           AND    loekz  = off.
    IF sy-subrc = 0.
      SELECT * FROM tn39t INTO TABLE lt_tn39t
             FOR ALL ENTRIES IN lt_nrsf
             WHERE  spras  = sy-langu
             AND    rsfnr  = lt_nrsf-rsfnr.
      IF sy-subrc = 0.
*       header risk factors
        CLEAR ls_outtab.
        ls_outtab-color = 4.
        ls_outtab-text  = 'Risikofaktoren'(021).
        APPEND ls_outtab TO lt_outtab.
*       detail risk factors
        LOOP AT lt_tn39t INTO ls_tn39t.
          CLEAR ls_outtab.
          ls_outtab-text = ls_tn39t-rsfna.
          APPEND ls_outtab TO lt_outtab.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDIF.

  l_title = 'OP Details'(017).

* call BAdI (to change data to be displayed in popup)
  CALL FUNCTION 'ISHMED_WP_VIEW_011_BADI_DETAIL'
    EXPORTING
      ir_anchor_srv = lr_anchor
      it_objects    = lt_obj
    CHANGING
      c_title       = l_title
      ct_outtab     = lt_outtab.

  IF lt_outtab[] IS INITIAL.
*   Keine OP Details vorhanden
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NFCL'
        i_num  = '296'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* call list popup
  CALL FUNCTION 'ISHMED_LIST_POPUP'
    EXPORTING
      i_title           = l_title
*     I_ENTER_KEY       = 'X'
*     I_PRINT_KEY       = 'X'
*     I_MODAL           = ' '
*   IMPORTING
*     F_CODE            =
    TABLES
      t_outtab          = lt_outtab.
*     T_BUTTON          =

  e_rc = 0.
  e_refresh = 0.

ENDMETHOD.


METHOD call_op_dws .

  DATA: lt_a_srv     TYPE ishmed_t_service_object.
  DATA: l_planoe     TYPE orgid.
  DATA: ls_parameter LIKE LINE OF it_parameter.

* Initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* At least 1 entry has to be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Get anchor service(s)
  REFRESH: lt_a_srv.
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects         = it_objects
      i_conn_srv         = on
      i_only_main_anchor = on
*     i_no_sort_change   = off
    IMPORTING
      e_rc               = e_rc
      et_anchor_services = lt_a_srv
    CHANGING
      c_environment      = c_environment
      c_errorhandler     = c_errorhandler.
  CHECK e_rc = 0.

  IF lt_a_srv[] IS INITIAL.
*   Funktion ist nicht möglich; markieren Sie zumindest eine Operation
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '188'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.

* get planning ou from parameter table (MED-41209)
  CLEAR l_planoe.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
  IF sy-subrc = 0.
    l_planoe = ls_parameter-value.
  ENDIF.

  CALL METHOD cl_ishmed_utl_op=>call_surgery
    EXPORTING
      it_service      = lt_a_srv
      i_planoe        = l_planoe                            " MED-41209
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.

  CASE e_rc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
*     e_refresh = 2.                             "MED-57529 note 2068964
*     e_refresh = 1.
      e_refresh = 2.
      READ TABLE it_parameter INTO ls_parameter WITH KEY type = '002'.
      IF sy-subrc = 0.
        IF ls_parameter-value = '008'.           "viewtype MCO
          e_refresh = 1.
        ENDIF.
      ENDIF.
    WHEN OTHERS.
*     Error occured
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_op_monitor .

  DATA: lt_n1anf           TYPE ishmed_t_n1anf,
        l_n1anf            LIKE LINE OF lt_n1anf,
        lt_n1vkg           TYPE ishmed_t_n1vkg,
        l_n1vkg            LIKE LINE OF lt_n1vkg,
        lt_nbew            TYPE ishmed_t_nbew,
        l_nbew             LIKE LINE OF lt_nbew,
        l_planoe           TYPE orgid,
        ls_parameter       LIKE LINE OF it_parameter,
        l_orgid            TYPE norg-orgid,
        l_open_what        TYPE string,
        l_flag(1)          TYPE c,
        l_wa_display       TYPE tnt0,
        lt_display         TYPE TABLE OF tnt0,
        ls_rnadp           TYPE rnadp.
*        l_nbr_marked       TYPE i.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_orgid, l_n1anf, l_n1vkg.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierte Anforderung ermitteln
  CALL METHOD cl_ishmed_functions=>get_requests
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     ET_REQUESTS    =
      et_n1anf       = lt_n1anf
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_n1anf INTO l_n1anf INDEX 1.
  IF sy-subrc = 0.
    l_orgid = l_n1anf-orgid.
  ENDIF.

* Falls keine Anforderung markiert ist,
* die markierte Klin. Auftragsposition ermitteln
  IF l_n1anf IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_preregistrations
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
*       ET_PREREGS     =
        et_n1vkg       = lt_n1vkg
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_n1vkg INTO l_n1vkg INDEX 1.
    IF sy-subrc = 0.
      l_orgid = l_n1vkg-trtoe.                    " l_n1vkg-orgid.
    ENDIF.
  ENDIF.

* Falls weder eine Anforderung noch eine Vormerkung markiert ist,
* dann die markierte Bewegung (Not-OP) ermitteln
  IF l_n1anf IS INITIAL AND l_n1vkg IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_apps_and_movs
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_nbew        = lt_nbew
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_nbew INTO l_nbew INDEX 1.
    IF sy-subrc = 0.
      l_orgid = l_nbew-orgpf.
    ELSE.
*     OP-Monitor steht nur für OP-Anford./Vormerkungen zur Verfügung
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '386'
          i_last = space.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* get planning ou from parameter table (MED-41209)
  CLEAR l_planoe.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
  IF sy-subrc = 0.
    l_planoe = ls_parameter-value.
  ENDIF.

* Geöffnete Knoten festlegen
  l_open_what = 'XXXXXX'.
* l_open_what: open nodes in surgery monitor:
*     1.digit = ON/OFF: pre-surgery services
*     2.digit = ON/OFF: post-surgery services
*     3.digit = ON/OFF: intra-surgery services
*     4.digit = ON/OFF: documents
*     5.digit = ON/OFF: diagnosis

  REFRESH lt_display.
  CLEAR l_wa_display.
  l_wa_display-einri = i_einri.
  DO 6 TIMES.
    CASE sy-index.
      WHEN 1.
        l_wa_display-zotyp = 'LSV'.    " Präop.
      WHEN 2.
        l_wa_display-zotyp = 'LSN'.    " Postop.
      WHEN 3.
        l_wa_display-zotyp = 'LSI'.    " Intraop.
      WHEN 4.
        l_wa_display-zotyp = 'DOK'.    " Dokumente
      WHEN 5.
        l_wa_display-zotyp = 'DIA'.    " Diagnosen
      WHEN 6.
        l_wa_display-zotyp = 'RIS'.    " Risikofaktoren
    ENDCASE.
*   The function ishmed_op_monitor has the reverse logix
*   'X'...means closed
    l_flag = l_open_what(1).
    IF l_flag = 'X'.
      l_wa_display-pflkz = space.
    ELSE.
      l_wa_display-pflkz = 'X'.
    ENDIF.
    APPEND l_wa_display TO lt_display.
    SHIFT l_open_what LEFT BY 1 PLACES.
  ENDDO.

* OP-Monitor aufrufen
  CALL FUNCTION 'ISHMED_OP_MONITOR'
    EXPORTING
      i_orgid            = l_orgid
      i_n1anf            = l_n1anf
      i_n1vkg            = l_n1vkg
      i_nbew             = l_nbew
      i_msg_errorhandler = on
      ir_environment     = c_environment
      i_planoe           = l_planoe                         " MED-41209
    IMPORTING
      e_rc               = e_rc
    TABLES
      display            = lt_display
    CHANGING
      c_errorhandler     = c_errorhandler.

* ID 18308:
  EXPORT rnadp FROM ls_rnadp TO MEMORY ID 'ISH_AMB_DISPO'.
  FREE MEMORY ID 'ISH_AMB_DISPO'.

  CASE e_rc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
*      e_refresh = 1.    "REM MED-38629
      e_refresh = 2.                                        "MED-38629
    WHEN OTHERS.
*     Error occured (Message via Errorhandler!)
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_op_sign_set .

  DATA: l_sign(1)          TYPE c,
        l_op_beg           TYPE ish_on_off,
        l_plan_oe          TYPE norg-orgid,
        l_plan_auth        TYPE ish_on_off,
        l_parameter        LIKE LINE OF it_parameter,
        l_medsrv           TYPE rn1med_service,
        lt_a_srv           TYPE ishmed_t_service_object,
        l_a_srv            LIKE LINE OF lt_a_srv,
        lt_a_nlei          TYPE ishmed_t_nlei,
        l_a_nlei           LIKE LINE OF lt_a_nlei,
        lt_a_nlem          TYPE ishmed_t_nlem,
        l_a_nlem           LIKE LINE OF lt_a_nlem,
        lt_app             TYPE ishmed_t_appointment_object,
        l_app              LIKE LINE OF lt_app.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_sign, l_op_beg, l_plan_oe.

  REFRESH: lt_a_srv, lt_a_nlei, lt_a_nlem, lt_app.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Welches OP-Kennzeichen soll geändert werden?
*'F' = Fixkennzeichen
*'O' = Freigabe Operateur
*'P' = Prämedikation vollständig
  CASE i_fcode.
    WHEN 'OPSIGN_F'.
      l_sign = 'F'.
    WHEN 'OPSIGN_O'.
      l_sign = 'O'.
    WHEN 'OPSIGN_P'.
      l_sign = 'P'.
  ENDCASE.

* Planende OE übergeben?
  LOOP AT it_parameter INTO l_parameter WHERE type = '005'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_plan_oe = l_parameter-value.
    EXIT.
  ENDLOOP.

* Markierte Ankerleistung ermitteln
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects         = it_objects
      i_conn_srv         = on
    IMPORTING
      e_rc               = e_rc
      et_anchor_services = lt_a_srv
      et_anchor_nlei     = lt_a_nlei
      et_anchor_nlem     = lt_a_nlem
    CHANGING
      c_environment      = c_environment
      c_errorhandler     = c_errorhandler.
  CHECK e_rc = 0.

* Haupt-OP-Ankerleistung muß vorhanden sein
  CLEAR: l_a_nlem, l_a_nlei.
  READ TABLE lt_a_nlem INTO l_a_nlem WITH KEY ankls = 'X'.
  IF sy-subrc <> 0.
*   Funktion nur für Operationen verfügbar
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '790'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
  READ TABLE lt_a_nlei INTO l_a_nlei WITH KEY lnrls = l_a_nlem-lnrls.
  CHECK sy-subrc = 0.

* Wenn das Fixkennzeichen umgesetzt werden soll und falls eine planende
* OE übergeben wurde und die OP auch bereits einen Termin hat,
* dann auch die Planungsauthorität für diese OP prüfen
  IF NOT l_plan_oe IS INITIAL AND l_sign = 'F'.
*   Termin ermitteln
    CALL METHOD cl_ishmed_functions=>get_apps_and_movs
      EXPORTING
        it_objects      = it_objects
      IMPORTING
        e_rc            = e_rc
        et_appointments = lt_app
      CHANGING
        c_environment   = c_environment
        c_errorhandler  = c_errorhandler.
    CHECK e_rc = 0.
    DESCRIBE TABLE lt_app.
    IF sy-tfill > 0.
      LOOP AT lt_app INTO l_app.
*       Führer ID. 12430 16.7.03
*       cl_ishmed_planning ersetzt durch cl_ishmed_utl_apmg
        CALL METHOD cl_ishmed_utl_apmg=>check_planning_authority_app
          EXPORTING
            i_plnoe          = l_plan_oe
            ir_appointment   = l_app
            i_refresh_buffer = 'X'
          IMPORTING
            e_plan_auth      = l_plan_auth
          CHANGING
            cr_errorhandler  = c_errorhandler.
        IF l_plan_auth = off.
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDLOOP.
      CHECK e_rc = 0.
    ENDIF.               " Termine vorhanden?
  ENDIF.

* Prüfen, ob die OP begonnen ist
  CALL FUNCTION 'ISHMED_CHECK_OP_BEGONNEN'
    EXPORTING
      i_anklei = l_a_nlei-lnrls
    IMPORTING
      e_op_beg = l_op_beg.
  IF l_op_beg = on.
*   OP bereits begonnen
    IF l_sign = 'F'. " Fixkennzeichen kann nicht mehr geändert werden
*     Operation nicht mehr planbar, da Behandlung bereits begonnen
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '782'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* Kennzeichen nun umswitchen
  READ TABLE lt_a_srv INTO l_a_srv INDEX 1.
  CHECK sy-subrc = 0.
  CLEAR l_medsrv.
  CASE l_sign.
*   Fixkennzeichen
    WHEN 'F'.
      IF l_a_nlem-pzman = on.
        l_medsrv-pzman = off.
      ELSE.
        l_medsrv-pzman = on.
      ENDIF.
      l_medsrv-pzman_x = on.
*   Freigabe Operateur
    WHEN 'O'.
      IF l_a_nlem-pmedfg = on.
        l_medsrv-pmedfg = off.
      ELSE.
        l_medsrv-pmedfg = on.
      ENDIF.
      l_medsrv-pmedfg_x = on.
*   Prämedikation vollständig
    WHEN 'P'.
      IF l_a_nlem-pmedvs = on.
        l_medsrv-pmedvs = off.
      ELSE.
        l_medsrv-pmedvs = on.
      ENDIF.
      l_medsrv-pmedvs_x = on.
    WHEN OTHERS.
      EXIT.
  ENDCASE.
* Änderung in der Instanz der Leistung durchführen
  CALL METHOD l_a_srv->change
    EXPORTING
      i_service      = l_medsrv
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.
* Änderung sichern
  IF e_rc = 0 AND i_save = on.
    CALL METHOD l_a_srv->save
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = c_errorhandler.
  ENDIF.
  CASE e_rc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
      e_refresh = 1.
      IF i_commit = on.
        COMMIT WORK AND WAIT.
      ENDIF.
    WHEN OTHERS.
*     Error occured
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_op_storno .

  DATA: l_flag                TYPE ish_on_off,
        l_rc                  TYPE ish_method_rc,
        l_title(50)           TYPE c,
*        l_planoe              TYPE orgid,
        l_help_time           TYPE n2oz-abruf,
        l_save_time           TYPE n2oz-abruf,
        l_type                TYPE rsscr-type,
        ls_n2oz               TYPE n2oz,
        lt_nbew               TYPE ishmed_t_nbew,
        lt_erboe              TYPE ishmed_t_orgid,
        l_erboe               LIKE LINE OF lt_erboe,
        lt_objects            LIKE it_objects,
        lt_obj                LIKE it_objects,
        l_object              LIKE LINE OF lt_objects,
        l_obj                 LIKE LINE OF lt_obj,
        ls_parameter          LIKE LINE OF it_parameter,
        lt_app                TYPE ishmed_t_appointment_object,
        l_app                 LIKE LINE OF lt_app,
        lt_a_nlei             TYPE ishmed_t_nlei,
        ls_a_nlei             LIKE LINE OF lt_a_nlei,
        lt_a_nlem             TYPE ishmed_t_nlem,
        ls_a_nlem             LIKE LINE OF lt_a_nlem,
        lt_nllz_temp          TYPE TABLE OF nllz,
        lt_nlei_temp          TYPE TABLE OF nlei,
        ls_ndoc               TYPE ndoc,                    "#EC NEEDED
        ls_n1lsteam           TYPE n1lsteam,                "#EC NEEDED
        l_app_cancel          TYPE ish_on_off,
        l_srv_cancel          TYPE ish_on_off,
        l_vkg_cancel          TYPE ish_on_off,
        l_pap_cancel          TYPE ish_on_off,
        l_req_cancel          TYPE ish_on_off,
        l_ord_cancel          TYPE ish_on_off,
        l_movement_cancel     TYPE ish_on_off,
        l_srv_with_app_cancel TYPE ish_on_off,
        l_cancel              TYPE REF TO cl_ish_cancel,
        lr_service            TYPE REF TO cl_ishmed_service,
        lr_con_cancel         TYPE REF TO cl_ish_con_cancel,
        lr_con_cancel_med     TYPE REF TO cl_ishmed_con_cancel,
        l_idx                 TYPE sy-tabix,                              "CDuerr, MED-32135
        lr_identify           TYPE REF TO if_ish_identify_object.         "CDuerr, MED-32135

  FIELD-SYMBOLS: <l_sign>     TYPE any.

* Initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_erboe, l_cancel, l_flag, l_rc, l_title.
  REFRESH: lt_erboe, lt_nbew, lt_app, lt_a_nlei, lt_a_nlem.

  lt_objects[] = it_objects[].

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es muß mind. 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = lt_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Es dürfen nur OPs einer erbringenden OE markiert sein!
* (ausgenommen beim Neben-OP-Storno)
  IF i_fcode = 'OPSTORNO' OR i_fcode = 'OPAB'.
    CALL METHOD cl_ishmed_functions=>get_erboes
      EXPORTING
        it_objects     = lt_objects
      IMPORTING
        e_rc           = e_rc
        et_erboe       = lt_erboe
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    DESCRIBE TABLE lt_erboe.
    IF sy-tfill > 1.
*     Bitte nur OPs der gleichen operierenden Fachabt. markieren
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '794'
          i_last = space.
      e_rc = 1.
      EXIT.
    ELSE.
      READ TABLE lt_erboe INTO l_erboe INDEX 1.
    ENDIF.
  ENDIF.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = lt_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

** get planning OU
*  CLEAR l_planoe.
*  LOOP AT it_parameter INTO ls_parameter WHERE type = '005'.
*    CHECK NOT ls_parameter-value IS INITIAL.
*    l_planoe = ls_parameter-value.
*    EXIT.
*  ENDLOOP.

  CASE i_fcode.
*   **-----------------------------------------------------------------
    WHEN 'OPSTORNO'.
*     OP stornieren (cancel surgery)
*     -----------------------------------------------------------------
*     gesamte OP stornieren, daher Bewegungen suchen
      CALL METHOD cl_ishmed_functions=>get_apps_and_movs
        EXPORTING
          it_objects      = lt_objects
        IMPORTING
          e_rc            = e_rc
          et_nbew         = lt_nbew
*         et_appointments = lt_app  " REM Int. Meldung 247953 (2004)
        CHANGING
          c_environment   = c_environment                   " ID 16119
          c_errorhandler  = c_errorhandler.
      CHECK e_rc = 0.
      l_app_cancel = on.
      l_srv_cancel = on.
      l_vkg_cancel = '*'.                                   " ID 13178
      l_pap_cancel = on.
      l_req_cancel = on.
      l_ord_cancel = on.
      l_srv_with_app_cancel = on.
*     the storno of the movement is mandatory, when
*     the whole OP shall be cancelled
      l_movement_cancel = on.                               " ID 13995
*   **-----------------------------------------------------------------
    WHEN 'OPAB'.
*     OP absetzen (cancel appointment of surgery)
*     -----------------------------------------------------------------
*     Nur Termin stornieren
*     daher statt den Ankerleistungen die Termine übergeben
      CALL METHOD cl_ishmed_functions=>get_apps_and_movs
        EXPORTING
          it_objects      = lt_objects
        IMPORTING
          e_rc            = e_rc
          et_appointments = lt_app
        CHANGING
          c_environment   = c_environment                   " ID 16119
          c_errorhandler  = c_errorhandler.
      CHECK e_rc = 0.
      REFRESH lt_objects.
      LOOP AT lt_app INTO l_app.
*       cancel check if emergency surgery - appointment
**       ID 17791: emergency surgery - appointment cancel not allowed!
*        CALL FUNCTION 'ISHMED_CHECK_IS_EMERGENCY_OP'
*          EXPORTING
*            i_appointment  = l_app
*          IMPORTING
*            e_emergency_op = l_emerg_op
*            e_rc           = e_rc
*          CHANGING
*            c_errorhandler = c_errorhandler.
*        CHECK e_rc = 0.
*        IF l_emerg_op = on.
*          EXIT.
*        ENDIF.
        CLEAR l_object.
        l_object-object = l_app.
        APPEND l_object TO lt_objects.
      ENDLOOP.
*      IF l_emerg_op = on.
*        e_rc = 1.
*        MESSAGE s295(nfcl).
**       Der Termin einer Not-Operation kann nicht storniert werden
*        CALL METHOD c_errorhandler->collect_messages
*          EXPORTING
*            i_typ  = 'E'
*            i_kla  = 'NFCL'
*            i_num  = '295'
*            i_last = space.
*        EXIT.
*      ENDIF.
      l_app_cancel = on.
      l_srv_cancel = off.
      l_vkg_cancel = off.
*      l_pap_cancel = off.                            MED-33470
      l_pap_cancel = '*'.     "if last pap cancel pap MED-33470
      l_req_cancel = off.
      l_ord_cancel = off.
      l_srv_with_app_cancel = off.
*     if only the appointment should be cancelled, the flag
*     for cancelling the movement must be set to on.
*     The storno checks whether the op is connected to a movement
*     which is allready active.
      l_movement_cancel = on.                               " ID 13995
*   **-----------------------------------------------------------------
    WHEN 'NBSTORNO'.
*     Neben OP stornieren (cancel secondary surgery)
*     -----------------------------------------------------------------
*     Neben-OP-Ankerleistung(en) ermitteln
      REFRESH lt_obj.
      LOOP AT lt_objects INTO l_object.
        TRY.
            lr_service ?= l_object-object.
            CALL METHOD lr_service->get_data
              IMPORTING
                e_rc           = l_rc
                e_nlei         = ls_a_nlei
                e_nlem         = ls_a_nlem
              CHANGING
                c_errorhandler = c_errorhandler.
            IF l_rc = 0.
              IF ls_a_nlem-ankls = 'N'.
                APPEND ls_a_nlei TO lt_a_nlei.
                APPEND ls_a_nlem TO lt_a_nlem.
                l_obj-object = lr_service.
                APPEND l_obj TO lt_obj.
              ENDIF.
            ELSE.
              CONTINUE.
            ENDIF.
          CATCH cx_sy_move_cast_error.                  "#EC NO_HANDLER
        ENDTRY.
      ENDLOOP.
      IF lt_obj[] IS INITIAL.
*       Bitte wählen Sie nur Neben-OPs
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'N1SRVDO_MED'
            i_num  = '035'
            i_last = space.
        e_rc = 1.
        EXIT.
      ENDIF.
*     - - - - -
*     PRÜFUNGEN, ob die Ankerleistung (Neben-OP) storniert werden darf
*     CHECKS, if secondary surgery(s) are allowed to be cancelled
*     - - - - -
      LOOP AT lt_a_nlei INTO ls_a_nlei.
        READ TABLE lt_a_nlem INTO ls_a_nlem
             WITH KEY lnrls = ls_a_nlei-lnrls.
        CHECK sy-subrc = 0.
*       - - - - -
*       Es dürfen keine aktiven Dokumente an der Ankerleistung hängen
*       - - - - -
        SELECT * FROM ndoc INTO ls_ndoc UP TO 1 ROWS
               WHERE  einri  = i_einri
               AND    patnr  = ls_a_nlem-patnr
               AND    falnr  = ls_a_nlei-falnr
               AND    lnrls  = ls_a_nlei-lnrls
               AND    storn  = off
               AND    loekz  = off.
          EXIT.
        ENDSELECT.
        IF sy-subrc = 0.
*         Storno der Neben-OP für & nicht möglich: &
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NF'
              i_num  = '528'
              i_mv1  = ls_a_nlei-erboe
              i_mv2  = 'Aktive Dokumente vorhanden'(022)
              i_last = space.
          e_rc = 1.
          EXIT.
        ENDIF.
*       - - - - -
*       Es dürfen keine Leistungen unter der Neben-OP hängen (ID 4764)
*       - - - - -
        REFRESH: lt_nllz_temp, lt_nlei_temp.
        SELECT * FROM nllz INTO TABLE lt_nllz_temp
               WHERE  einri   = i_einri
               AND    lnrls1  = ls_a_nlei-lnrls.
        IF lt_nllz_temp[] IS NOT INITIAL.
          SELECT * FROM nlei INTO TABLE lt_nlei_temp
                 FOR ALL ENTRIES IN lt_nllz_temp
                 WHERE  lnrls  = lt_nllz_temp-lnrls2
                 AND    storn  = off.
          IF lt_nlei_temp[] IS NOT INITIAL.
*           Storno der Neben-OP für & nicht möglich: &
            CALL METHOD c_errorhandler->collect_messages
              EXPORTING
                i_typ  = 'E'
                i_kla  = 'NF'
                i_num  = '528'
                i_mv1  = ls_a_nlei-erboe
                i_mv2  = 'Leistungen für Erb.OE vorhanden'(023)
                i_last = space.
            e_rc = 1.
            EXIT.
          ENDIF.
        ENDIF.
*       - - - - -
*       Es dürfen keine freigegeb. Zeiten für Neben-OP-Ankerl. exist.
*       - - - - -
        CLEAR: l_help_time, l_save_time, ls_n2oz.
        SELECT SINGLE * FROM n2oz INTO ls_n2oz
               WHERE  einri       = i_einri
               AND    ankerleist  = ls_a_nlei-lnrls
               AND    opfreigabe  = on.
        IF sy-subrc = 0.
          DO 92 TIMES.   " so oft durchlaufen, wie Tabelle Felder hat
            ASSIGN COMPONENT sy-index OF STRUCTURE ls_n2oz TO <l_sign>.
            CHECK sy-subrc = 0.
            DESCRIBE FIELD <l_sign> TYPE l_type.
            CHECK l_type = 'T'.
            l_help_time = <l_sign>.
            IF l_help_time > l_save_time.            " find last time
              l_save_time = l_help_time.
            ENDIF.
          ENDDO.
          IF l_save_time IS NOT INITIAL.
*           Storno der Neben-OP für & nicht möglich: &
            CALL METHOD c_errorhandler->collect_messages
              EXPORTING
                i_typ  = 'E'
                i_kla  = 'NF'
                i_num  = '528'
                i_mv1  = ls_a_nlei-erboe
                i_mv2  = 'Freigegebene Zeiten vorhanden'(024)
                i_last = space.
            e_rc = 1.
            EXIT.
          ENDIF.
        ENDIF.
*       - - - - -
*       Es darf kein freigegeb. Team für Neben-OP-Ankerl. exist.
*       - - - - -
        SELECT * FROM n1lsteam INTO ls_n1lsteam UP TO 1 ROWS
               WHERE  lnrls       = ls_a_nlei-lnrls
               AND    status      = 'F'
               AND    storn       = off.
          EXIT.
        ENDSELECT.
        IF sy-subrc = 0.
*         Storno der Neben-OP für & nicht möglich: &
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NF'
              i_num  = '528'
              i_mv1  = ls_a_nlei-erboe
              i_mv2  = 'Freigegebenes Team vorhanden'(025)
              i_last = space.
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDLOOP.
      CHECK e_rc = 0.
*     set secondary surgery(s) to be cancelled
      REFRESH lt_objects.
      lt_objects[] = lt_obj[].
      l_app_cancel = off.
      l_srv_cancel = off.
      l_vkg_cancel = off.
      l_pap_cancel = off.
      l_req_cancel = off.
      l_ord_cancel = off.
      l_movement_cancel = off.
      l_srv_with_app_cancel = '*'.
      l_title = 'Neben-OP stornieren'(026).
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* Nur OPs/Termine stornierbar, wo die Planungsautorität gegeben ist
* REMOVED: Int. Meldung 247953 (2004)
*  LOOP AT lt_app INTO l_app.
*    CALL METHOD cl_ishmed_utl_apmg=>check_planning_authority
*      EXPORTING
*        i_plnoe          = l_planoe
*        i_appointment    = l_app
*        i_refresh_buffer = 'X'
*      IMPORTING
*        e_plan_auth      = l_plan_auth
*      CHANGING
*        c_errorhandler   = c_errorhandler.
*    IF l_plan_auth = off.
*      e_rc = 1.
*      EXIT.
*    ENDIF.
*  ENDLOOP.
*  CHECK e_rc = 0.

* ID 18553: set configuration for cancel-function
* instance for configuration in parameters table?
  LOOP AT it_parameter INTO ls_parameter WHERE type = '000'.
    CHECK ls_parameter-object IS NOT INITIAL.
    TRY.
        lr_con_cancel ?= ls_parameter-object.
      CATCH cx_sy_ref_is_initial
            cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
    IF lr_con_cancel IS BOUND.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF lr_con_cancel IS INITIAL.
    CALL METHOD cl_ish_utl_apmg=>get_ref_con_cancel
      EXPORTING
        i_cancel_chain_apps        = off
        i_check_planning_completed = on
      IMPORTING
        er_con_cancel              = lr_con_cancel
        e_rc                       = e_rc
      CHANGING
        cr_errorhandler            = c_errorhandler.
    CHECK e_rc = 0.
  ENDIF.
  IF lr_con_cancel->is_inherited_from(
            cl_ishmed_con_cancel=>co_otype_con_cancel_med ) = on.
    lr_con_cancel_med ?= lr_con_cancel.
    CALL METHOD lr_con_cancel_med->set_check_emergency_op
      EXPORTING
        i_check_emergency_op = on.
  ENDIF.
* ID 18553 - end

* CDuerr, MED-32135 - Begin
  LOOP AT lt_objects INTO l_object.
    l_idx = sy-tabix.
    TRY.
        lr_identify ?= l_object-object.
        IF lr_identify->is_inherited_from( cl_ishmed_none_oo_freeline_p=>co_otype_none_oo_freeline_plan ) = on.
          DELETE lt_objects INDEX l_idx.
        ENDIF.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
  ENDLOOP.
  IF lt_objects[] IS INITIAL.
    EXIT.
  ENDIF.
* CDuerr, MED-32135 - End

* call cancel function now
  CALL METHOD cl_ish_environment=>cancel_objects
    EXPORTING
      it_objects            = lt_objects
      it_nbew               = lt_nbew
      i_popup               = on
      i_popup_title         = l_title
      i_orgid               = l_erboe-orgid
      i_authority_check     = on
      i_app_cancel          = l_app_cancel
      i_srv_cancel          = l_srv_cancel
      i_vkg_cancel          = l_vkg_cancel
      i_pap_cancel          = l_pap_cancel
      i_req_cancel          = l_req_cancel
      i_corder_cancel       = l_ord_cancel
      i_movement_cancel     = l_movement_cancel             " ID 13995
      i_srv_with_app_cancel = l_srv_with_app_cancel
      i_save                = i_save
      i_caller              = i_caller
      i_last_srv_cancel     = on
      i_enqueue             = i_enqueue
      i_commit              = i_commit
      ir_con_cancel         = lr_con_cancel                 " ID 18553
    IMPORTING
      e_rc                  = l_rc
      e_no_cancel           = l_flag
    CHANGING
      c_errorhandler        = c_errorhandler
      c_lock                = c_lock
      c_cancel              = l_cancel.

  IF l_flag = on.
*   cancel (Abbrechen)
    e_rc = 2.
    e_refresh = 0.
    EXIT.
  ENDIF.

  CASE l_rc.
    WHEN 0.
*     Everything OK -> OP(s) bzw. Termin(e) wurde(n) storniert
      e_rc = 0.
      IF i_fcode = 'OPSTORNO' OR i_fcode = 'NBSTORNO'.
*       Beim OP-Storno reicht das Zeilenrefresh
        e_refresh = 1.
      ELSE.
*       Beim Terminstorno muß die ganze Liste refreshed werden,
*       weil die OP dann ev. im Arbeitsvorrat (z.B. Sichttyp OP)
*       aufscheinen muß!
        e_refresh = 2.
      ENDIF.
    WHEN OTHERS.
*     Error (Fehler)
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_patein_set .

  DATA: lt_srv             TYPE ishmed_t_service_object,
        lt_a_srv           TYPE ishmed_t_service_object,
        lr_srv             LIKE LINE OF lt_srv,
        l_cancel           TYPE ish_on_off,
        l_rc               TYPE ish_method_rc.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR l_cancel.

  REFRESH: lt_srv, lt_a_srv.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* at lease 1 entry has to be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* check if services have been marked
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects         = it_objects
    IMPORTING
      e_rc               = e_rc
      et_services        = lt_srv
      et_anchor_services = lt_a_srv
    CHANGING
      c_environment      = c_environment
      c_errorhandler     = c_errorhandler.
  CHECK e_rc = 0.
  IF lt_srv[] IS INITIAL AND lt_a_srv[] IS INITIAL.
*   Funktion & ist nur für Leistungen verfügbar.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '167'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

  APPEND LINES OF lt_srv TO lt_a_srv.

* call function now
  LOOP AT lt_a_srv INTO lr_srv.
    CALL FUNCTION 'ISHMED_PATEIN_SET'
      EXPORTING
        ir_srv          = lr_srv
        i_enqueue       = i_enqueue
      IMPORTING
        e_rc            = l_rc
        e_cancel        = l_cancel
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF l_rc = 0.
      IF l_cancel = on.
        e_rc = 2.                          " cancel
        e_refresh = 0.
        EXIT.
      ELSE.
        e_refresh = 1.
      ENDIF.
    ELSE.
      e_rc = 1.
      e_refresh = 0.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD call_patient_open_points .

*  DATA: l_nbr_marked       TYPE i.
  DATA: lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal,
        lt_erboe           TYPE ishmed_t_orgid,
        l_erboe            TYPE norg-orgid,
        l_rc               TYPE ish_method_rc,
        l_not_found        TYPE ish_on_off,
        l_edate            TYPE sy-datum,
        l_parval           TYPE n1orgpar-n1parwert,
        l_n1ofpdat         TYPE i,      " Tage +/- sy-datum = Entl.dat.
        l_n1ofppop         TYPE ish_on_off, " Popup 'Entl.dat.' bringen
        l_name(50)         TYPE c.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* get instance of errorhandler if requested
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* only just one entry can be marked for this function
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierten (Vorläufigen) Patienten und Fall ermitteln
* get selected (provisional) patient (and case)
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
      i_read_db      = on
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* function not allowed for provisional patients
  CLEAR: l_npat, l_npap, l_nfal.
  READ TABLE lt_npat INTO l_npat INDEX 1.
  READ TABLE lt_npap INTO l_npap INDEX 1.
  READ TABLE lt_nfal INTO l_nfal INDEX 1.
  IF l_npat-patnr IS INITIAL AND NOT l_npap-papid IS INITIAL.
    CLEAR l_name.
    PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                  l_npap-vorsw
                                                  l_npap-nname
                                                  l_npap-vname
                                                  l_name.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '617'
        i_mv1  = l_name
        i_mv2  = 'Funktion'(006)
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* get ERBOE
  CALL METHOD cl_ishmed_functions=>get_erboes
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_erboe       = lt_erboe
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_erboe INTO l_erboe INDEX 1.
  IF l_erboe IS INITIAL.
    l_erboe = '*'.
  ENDIF.

* Vorbelegung 'Entlassungsdatum'
  CLEAR: l_parval, l_n1ofpdat.
  CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
    EXPORTING
      i_einri         = i_einri
      i_ou            = l_erboe
      i_par_name      = 'N1OFPDAT'
*      I_DATE          = SY-DATUM
    IMPORTING
      e_par_value     = l_parval
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF l_rc = 0 AND NOT l_parval IS INITIAL.
    l_n1ofpdat = l_parval.
    l_edate = sy-datum + l_n1ofpdat.
  ELSE.
    l_edate = sy-datum.
  ENDIF.

* Popup 'Entlassungsdatum' bringen
  CLEAR: l_parval, l_n1ofppop.
  CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
    EXPORTING
      i_einri         = i_einri
      i_ou            = l_erboe
      i_par_name      = 'N1OFPPOP'
*      I_DATE          = SY-DATUM
    IMPORTING
      e_par_value     = l_parval
      e_not_found     = l_not_found
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF l_rc = 0 AND l_not_found = off.
    l_n1ofppop = l_parval.
  ELSE.
    l_n1ofppop = on.
  ENDIF.

* call function now
  CALL FUNCTION 'ISHMED_PATIENT_OFFENE_PUNKTE'
    EXPORTING
      i_einri         = i_einri
      i_patnr         = l_npat-patnr
      i_falnr         = l_nfal-falnr
      i_popup         = l_n1ofppop
      i_entdt         = l_edate
      ir_environment  = c_environment
    EXCEPTIONS
      cancel          = 1
      patnr_not_valid = 2
      falnr_not_valid = 3
      fall_pat_error  = 4
      OTHERS          = 5.
  CASE sy-subrc.
    WHEN 0.
*     NO error
      e_rc      = 0.
      e_refresh = 1.
    WHEN 1.
*     cancel
      e_rc      = 2.
      e_refresh = 0.
    WHEN 2.
*     patient not valid
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '387'
          i_mv1  = l_npat-patnr
          i_last = space.
      e_rc      = 1.
      e_refresh = 0.
    WHEN 3.
*     case not valid
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '051'
          i_mv1  = l_nfal-falnr
          i_last = space.
      e_rc      = 1.
      e_refresh = 0.
    WHEN 4 OR 5.
*     other error
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '139'
          i_mv1  = sy-subrc
          i_last = space.
      e_rc      = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_patient_organizer .

  DATA: l_name(50)         TYPE c,
        lt_rn1po_call      TYPE TABLE OF rn1po_call,
        l_rn1po_call       LIKE LINE OF lt_rn1po_call,
        lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_nbew            TYPE ishmed_t_nbew,
        l_nbew             LIKE LINE OF lt_nbew,
        l_timeline         TYPE ish_on_off,
        l_outpmap          TYPE ish_on_off,
        l_plnoe            TYPE orgid,
        ls_parameter       LIKE LINE OF it_parameter.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_timeline, l_outpmap.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es muß mind. 1 Eintrag markiert sein
* MED-30568: even no mark is allowed!
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
*     i_check_type   = '2'                                  " mind. 1
      i_check_type   = ' '                                  " MED-30568
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Ambulanzkarte oder Vitalparameteranzeige aufrufen?
  CASE i_fcode.
    WHEN 'PORG'.
    WHEN 'AMPO'.
      l_outpmap  = on.
    WHEN 'VPPO'.
      l_timeline = on.
  ENDCASE.

* Markierte (vorläufige) Patienten und Fälle ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Markierte Bewegungen ermitteln
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nbew        = lt_nbew
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Vorläufige Patienten markiert?
  DESCRIBE TABLE lt_npap.
  IF sy-tfill > 0.
*   Ambulanzkarte und Vitalparameteranzeige für vorläufige
*   Patienten nicht möglich!
    IF i_fcode = 'AMPO' OR i_fcode = 'VPPO'.
      LOOP AT lt_npap INTO l_npap.
        CLEAR l_name.
        PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                      l_npap-vorsw
                                                      l_npap-nname
                                                      l_npap-vname
                                                      l_name.
*       Patient noch nicht aufgenommen - Funktion nicht möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '617'
            i_mv1  = l_name
            i_mv2  = 'Funktion'(006)
            i_last = space.
      ENDLOOP.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* Patienten in Übergabetabelle stellen
  LOOP AT lt_npat INTO l_npat.
    READ TABLE lt_nfal INTO l_nfal WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR l_nfal.
    ELSE.
      READ TABLE lt_nbew INTO l_nbew WITH KEY falnr = l_nfal-falnr.
      IF sy-subrc <> 0.
        CLEAR l_nbew.
      ENDIF.
    ENDIF.
    READ TABLE lt_rn1po_call INTO l_rn1po_call
               WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR: l_rn1po_call.
      l_rn1po_call-patnr = l_npat-patnr.
      l_rn1po_call-pziff = l_npat-pziff.
      l_rn1po_call-einri = i_einri.
      l_rn1po_call-falnr = l_nfal-falnr.
      l_rn1po_call-fziff = l_nfal-fziff.
      l_rn1po_call-falar = ' '.
      l_rn1po_call-lfdbew = l_nbew-lfdnr.
      l_rn1po_call-lfddia = ' '.
      l_rn1po_call-orgpf  = ' '.
      l_rn1po_call-orgfa  = ' '.
      l_rn1po_call-uname  = sy-uname.
      l_rn1po_call-orgid  = ' '.
      l_rn1po_call-repid  = sy-repid.
      l_rn1po_call-viewid = ' '.
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

* Vorläufige Patienten in Übergabetabelle stellen
  LOOP AT lt_npap INTO l_npap.
    READ TABLE lt_rn1po_call INTO l_rn1po_call
         WITH KEY papid = l_npap-papid.
    IF sy-subrc <> 0.
      CLEAR: l_rn1po_call.
      l_rn1po_call-papid = l_npap-papid.
      l_rn1po_call-einri = i_einri.
      l_rn1po_call-falar = ' '.
      l_rn1po_call-lfddia = ' '.
      l_rn1po_call-orgpf  = ' '.
      l_rn1po_call-orgfa  = ' '.
      l_rn1po_call-uname  = sy-uname.
      l_rn1po_call-orgid  = ' '.
      l_rn1po_call-repid  = sy-repid.
      l_rn1po_call-viewid = ' '.
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

* Reihenfolge beibehalten - keine Sortierung (REM: ID 13826)
** Tabelle nach Patient sortieren und doppelte rauslöschen
*  SORT lt_rn1po_call BY mandt einri patnr.
*  DELETE ADJACENT DUPLICATES FROM lt_rn1po_call
*                             COMPARING mandt einri patnr.

  CLEAR l_plnoe.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
  IF sy-subrc = 0.
    l_plnoe = ls_parameter-value.
  ENDIF.

*  IF NOT lt_rn1po_call[] IS INITIAL.           " REM MED-30568
* FBS zum Vorbereiten des Patientenorganizers aufrufen
  CALL FUNCTION 'ISHMED_DISPLAY_PATDATA'
    EXPORTING
      i_timeline     = l_timeline
      i_outpmap      = l_outpmap
      i_plnoe        = l_plnoe
    TABLES
      t_rn1po_call   = lt_rn1po_call
    CHANGING
      cr_environment = c_environment.
*  ENDIF.                                       " REM MED-30568

  e_refresh = 1.

ENDMETHOD.


METHOD call_planning_authority_dialog .

  DATA: l_rc               TYPE ish_method_rc,
        l_exitcode         TYPE sy-ucomm,
        l_date_from        TYPE sy-datum,
        l_date_to          TYPE sy-datum,
        l_no_chg_dplauth   TYPE char1,
        l_no_chg_termang   TYPE char1,
        lt_pobnr           TYPE ishmed_t_pobnr,
        l_pobnr            LIKE LINE OF lt_pobnr,
        l_pob_nr           TYPE ish_pobnr,
        lt_natm            TYPE ishmed_term_natm,
        ls_natm            LIKE LINE OF lt_natm,
        l_parameter        LIKE LINE OF it_parameter,
        ls_expvalue        LIKE LINE OF et_expvalues,
        lt_ploe_data       TYPE ishmed_dplauth_ploe_data,
        l_ploe_data        LIKE LINE OF lt_ploe_data,
        lt_calendar_data   TYPE ishmed_dplauth_calendar_data,
        l_calendar_data    LIKE LINE OF lt_calendar_data,
*        l_nbr_marked       TYPE i,
        lx_static          TYPE REF TO cx_ish_static_handler.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_date_from, l_date_to, l_pobnr, l_pob_nr.
  REFRESH: lt_ploe_data, lt_calendar_data, lt_pobnr, lt_natm.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  IF i_fcode = 'COMMENTS'.
    CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
      EXPORTING
        i_check_type   = '1'                                " genau 1
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
*        e_nbr_marked   = l_nbr_marked
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
*   Environment ermitteln
    IF c_environment IS INITIAL.
      CALL METHOD cl_ishmed_functions=>get_environment
        EXPORTING
          it_objects    = it_objects
        CHANGING
          c_environment = c_environment.
    ENDIF.
*  ELSE.
* egal was markiert wurde!
*  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
*    EXPORTING
*      i_check_type   = ' '                               " egal
*      it_objects     = it_objects
*    IMPORTING
*      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
*    CHANGING
*      c_errorhandler = c_errorhandler.
*  CHECK e_rc = 0.
  ENDIF.

* Zeitbereich (Datum von-bis)
  LOOP AT it_parameter INTO l_parameter WHERE type = '014'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_date_from = l_parameter-value.
  ENDLOOP.
  LOOP AT it_parameter INTO l_parameter WHERE type = '015'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_date_to = l_parameter-value.
  ENDLOOP.
  IF l_date_from IS INITIAL.
    l_date_from = sy-datum.
  ENDIF.
  IF l_date_to IS INITIAL OR l_date_to < l_date_from.
    l_date_to = l_date_from.
  ENDIF.
  CLEAR l_calendar_data.
  l_calendar_data-sign = 'I'.
  l_calendar_data-opt  = 'BT'.
  l_calendar_data-low  = l_date_from.
  l_calendar_data-high = l_date_to.
  APPEND l_calendar_data TO lt_calendar_data.

* Beplante Org.Einheiten
  LOOP AT it_parameter INTO l_parameter WHERE type = '016'.
    CHECK NOT l_parameter-value IS INITIAL.
    CLEAR l_ploe_data.
    l_ploe_data-zuo   = on.
    l_ploe_data-orgid = l_parameter-value(8).
    APPEND l_ploe_data TO lt_ploe_data.
  ENDLOOP.

* Planobjektnummern
  LOOP AT it_parameter INTO l_parameter WHERE type = '020'.
    CHECK NOT l_parameter-value IS INITIAL.
    CLEAR l_pobnr.
    l_pobnr = l_parameter-value(10).
    APPEND l_pobnr TO lt_pobnr.
  ENDLOOP.

* Tageskommentar, wenn nur 1 Planobjekt betroffen ist
  DESCRIBE TABLE lt_pobnr.
  IF sy-tfill = 1.
    READ TABLE lt_pobnr INTO l_pobnr INDEX 1.
    CLEAR ls_natm.
    ls_natm-mandt    = sy-mandt.
    ls_natm-einri    = i_einri.
    ls_natm-pobnr    = l_pobnr.
    ls_natm-datefrom = l_date_from.
    ls_natm-dateto   = l_date_to.
    LOOP AT it_parameter INTO l_parameter WHERE type = '028'.
      CHECK NOT l_parameter-value IS INITIAL.
      ls_natm-commnt = l_parameter-value.
      EXIT.
    ENDLOOP.
    APPEND ls_natm TO lt_natm.
  ENDIF.

  IF i_fcode = 'COMMENTS'.
*   Tageskommentare anzeigen (MED-34045)
    CLEAR l_pobnr.
    READ TABLE lt_pobnr INTO l_pobnr INDEX 1.
    l_pob_nr = l_pobnr-pobnr.
    TRY.
        CALL METHOD cl_ishmed_pdc_ga_pobdc_list=>execute
          EXPORTING
            i_pobnr        = l_pob_nr
            i_date         = l_date_from
            ir_environment = c_environment
            i_vcode        = if_ish_gui_view=>co_vcode_update.
      CATCH cx_ish_static_handler INTO lx_static.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          EXPORTING
            i_exceptions    = lx_static
          CHANGING
            cr_errorhandler = c_errorhandler.
        e_rc = 1.
    ENDTRY.
    IF e_rc = 0.
      e_refresh = 2.
    ENDIF.
  ELSE.
*   Dialog zur Pflege der Planungsautoritäten aufrufen
    CALL FUNCTION 'ISHMED_DPLAUTH_DIALOG'
      EXPORTING
        i_einri                   = i_einri
        it_ploe_data              = lt_ploe_data
        it_calendar_data          = lt_calendar_data
        it_pobnr                  = lt_pobnr
        it_sel_natm               = lt_natm
      IMPORTING
        e_rc                      = l_rc
        e_exitcode                = l_exitcode
*       ET_DPLAUTH_DATA           =
        e_nothing_changed_dplauth = l_no_chg_dplauth
        e_nothing_changed_termang = l_no_chg_termang
      CHANGING
        c_errorhandler            = c_errorhandler.
    CASE l_rc.
      WHEN 0.
        IF l_exitcode = 'CANCEL'.
          e_rc = 2.
          e_refresh = 0.
        ELSE.
          e_rc = 0.
          e_refresh = 2.
          CALL METHOD cl_ishmed_dataprovider=>refresh_buffer
*            EXPORTING
*              I_ALL           = 'X'
*              I_OBJECT_TYPE   =
*              IT_OBJECT_TYPES =
             IMPORTING
               e_rc            = e_rc
             CHANGING
               c_errorhandler  = c_errorhandler.
        ENDIF.
      WHEN OTHERS.
        e_rc = 1.
        e_refresh = 0.
    ENDCASE.
*   export values
    CLEAR ls_expvalue.
    ls_expvalue-type  = '001'.
    ls_expvalue-value = l_no_chg_dplauth.
    APPEND ls_expvalue TO et_expvalues.
    CLEAR ls_expvalue.
    ls_expvalue-type  = '002'.
    ls_expvalue-value = l_no_chg_termang.
    APPEND ls_expvalue TO et_expvalues.
  ENDIF.

ENDMETHOD.


METHOD call_plan_changedoc .

  DATA: lt_applan           TYPE ishmed_t_applan_object,
        lr_applan           TYPE REF TO cl_ishmed_applan,
        lt_apps             TYPE ishmed_t_appointment_object,
        lr_app              LIKE LINE OF lt_apps,
        l_object            LIKE LINE OF it_objects.

* initialization
  CLEAR: e_rc.

  e_refresh   = 0.
  e_func_done = true.

  REFRESH: lt_applan[], lt_apps[].

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* check number of marked lines
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                                  " = 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get plans
  LOOP AT it_objects INTO l_object.
*   get type of object
    TRY.
        lr_applan ?= l_object-object.
        APPEND lr_applan TO lt_applan.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
  ENDLOOP.

  IF lt_applan[] IS INITIAL.

*   get appointments
    CALL METHOD cl_ishmed_functions=>get_apps_and_movs
      EXPORTING
        it_objects      = it_objects
      IMPORTING
        e_rc            = e_rc
        et_appointments = lt_apps
      CHANGING
        c_environment   = c_environment
        c_errorhandler  = c_errorhandler.
    CHECK e_rc = 0.

    IF lt_apps[] IS INITIAL.
*     Bitte wählen Sie einen gültigen Plan aus
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1APMG_MED'
          i_num  = '049'
          i_last = space.
      e_rc = 1.
      EXIT.
    ENDIF.

*   get plan for appointments
    LOOP AT lt_apps INTO lr_app.
      CLEAR lr_applan.
      CALL METHOD cl_ish_appointment=>get_plan_for_appmnt
        EXPORTING
          ir_appmnt       = lr_app
        IMPORTING
          er_applan       = lr_applan
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      IF NOT lr_applan IS INITIAL.
        APPEND lr_applan TO lt_applan.
      ENDIF.
    ENDLOOP.
    CHECK e_rc = 0.

  ENDIF.     " IF lt_applan[] IS INITIAL.

  SORT lt_applan.
  DELETE ADJACENT DUPLICATES FROM lt_applan.
  DESCRIBE TABLE lt_applan.
  CASE sy-tfill.
    WHEN 0.
*     Bitte wählen Sie einen gültigen Plan aus
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1APMG_MED'
          i_num  = '049'
          i_last = space.
      e_rc = 1.
      EXIT.
    WHEN 1.
      READ TABLE lt_applan INTO lr_applan INDEX 1.
      CHECK sy-subrc = 0.
    WHEN OTHERS.
*     Bitte markieren Sie nur einen Plan
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1APMG_MED'
          i_num  = '050'
          i_last = space.
      e_rc = 1.
      EXIT.
  ENDCASE.

* call popup to display change documents
  CALL METHOD cl_ishmed_utl_apmg=>show_changedoc_plan
    EXPORTING
      ir_applan       = lr_applan
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.

  CASE e_rc.
    WHEN 0.
*     Everything OK
      e_refresh = 0.
    WHEN OTHERS.
*     Error occured
      e_rc      = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_plan_release .

  DATA: l_rc                 TYPE ish_method_rc,
        l_vcode              TYPE ish_vcode,
        l_cancel             TYPE ish_on_off,
        l_dialog             TYPE ish_on_off,
        l_planoe             TYPE orgid,
        l_plan_auth          TYPE ish_on_off,
        l_n1rlspdia          TYPE n1orgpar-n1parwert,
        l_date_from          TYPE sy-datum,
        l_date_to            TYPE sy-datum,
        l_time_from          TYPE sy-uzeit,
        l_time_to            TYPE sy-uzeit,
        l_dauer              TYPE ish_dzeit,
        l_dat                TYPE sy-datum,
        ls_parameter         LIKE LINE OF it_parameter,
        l_object             LIKE LINE OF it_objects,
*        l_object_type        TYPE i,                               "REM MED-9409
        lt_applan            TYPE ishmed_t_applan_object,
        lr_applan            TYPE REF TO cl_ishmed_applan,
        lt_plans             TYPE ishmed_t_applans,
        ls_plans             LIKE LINE OF lt_plans,
        lt_apps              TYPE ishmed_t_appointment_object,
        lt_res               TYPE ishmed_t_resource_datetime_dur,
        ls_res               LIKE LINE OF lt_res,
        lt_poboe             TYPE ishmed_t_n1pobnrorgid,
        ls_poboe             LIKE LINE OF lt_poboe,
        lt_date              TYPE ishmed_t_date,
        l_date               LIKE LINE OF lt_date,
        lr_prc_applan        TYPE REF TO cl_ishmed_prc_applan,
        lr_prc_applan_dialog TYPE REF TO cl_ishmed_prc_applan_dialog.

*-->begin of MED-55056 AGujev
  TYPES: BEGIN OF t_pob_info,
          pobnr  TYPE ish_pobnr,
          planoe TYPE orgid,
          datefrom TYPE sy-datum,
          dateto TYPE sy-datum,
          timefrom TYPE sy-uzeit,
          timeto TYPE sy-uzeit,
          dauer TYPE ish_dzeit,
       END OF t_pob_info.
  DATA:  lt_pob_info TYPE STANDARD TABLE OF t_pob_info,
         ls_pob_info LIKE LINE OF lt_pob_info.
  FIELD-SYMBOLS <fs_pob_info> TYPE t_pob_info.
  DATA:  l_count TYPE i.
*<--end of MED-55056 AGujev

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_vcode, l_cancel, l_dialog, l_date_from, l_date_to, l_planoe,
         lt_applan, lt_plans, lt_apps, lt_res, lt_poboe, lt_date,
         lr_prc_applan.

* create instance of errorhandler if requested
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* no matter what's marked at this time ...
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = ' '                                  " egal
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* set mode
  l_vcode = 'UPD'.                " update

* get planning OU
  LOOP AT it_parameter INTO ls_parameter WHERE type = '005'.
    CHECK NOT ls_parameter-value IS INITIAL.
    l_planoe = ls_parameter-value.
    EXIT.
  ENDLOOP.

* get plans
  LOOP AT it_objects INTO l_object.
*   get type of object
    TRY.
        lr_applan ?= l_object-object.
        APPEND lr_applan TO lt_applan.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
  ENDLOOP.
  IF NOT lt_applan[] IS INITIAL.
    LOOP AT lt_applan INTO lr_applan.
      CLEAR ls_plans.
      ls_plans-obj = lr_applan.
      APPEND ls_plans TO lt_plans.
    ENDLOOP.
  ENDIF.

* get appointments
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects      = it_objects
    IMPORTING
      e_rc            = e_rc
      et_appointments = lt_apps
    CHANGING
      c_environment   = c_environment
      c_errorhandler  = c_errorhandler.
  CHECK e_rc = 0.

* get resources
* date from-to
  LOOP AT it_parameter INTO ls_parameter WHERE type = '014'.
    CHECK NOT ls_parameter-value IS INITIAL.
    IF l_date_from IS INITIAL OR ls_parameter-value < l_date_from.
      l_date_from = ls_parameter-value.
    ENDIF.
  ENDLOOP.
  LOOP AT it_parameter INTO ls_parameter WHERE type = '015'.
    CHECK NOT ls_parameter-value IS INITIAL.
    IF l_date_to IS INITIAL OR ls_parameter-value > l_date_to.
      l_date_to = ls_parameter-value.
    ENDIF.
  ENDLOOP.
  IF l_date_from IS INITIAL.
    l_date_from = sy-datum.
  ENDIF.
  IF l_date_to IS INITIAL OR l_date_to < l_date_from.
    l_date_to = l_date_from.
  ENDIF.
* build a table with all dates
  l_dat = l_date_from.
  DO.
    IF l_date_to < l_dat.
      EXIT.
    ENDIF.
    l_date = l_dat.
    APPEND l_date TO lt_date.
    l_dat = l_dat + 1.
  ENDDO.
* time from-to
  LOOP AT it_parameter INTO ls_parameter WHERE type = '032'.
    CHECK NOT ls_parameter-value IS INITIAL.
    IF l_time_from IS INITIAL OR ls_parameter-value < l_time_from.
      l_time_from = ls_parameter-value.
    ENDIF.
  ENDLOOP.
  LOOP AT it_parameter INTO ls_parameter WHERE type = '033'.
    CHECK NOT ls_parameter-value IS INITIAL.
    IF l_time_to IS INITIAL OR ls_parameter-value > l_time_to.
      l_time_to = ls_parameter-value.
    ENDIF.
  ENDLOOP.
  IF l_time_from IS NOT INITIAL AND
     l_time_to   IS INITIAL     OR
     l_time_to    < l_time_from.
    l_time_to = l_time_from.
  ENDIF.
  CLEAR l_dauer.
  IF l_time_to <> l_time_from.
    l_dauer = ( l_time_to - l_time_from ) / 60.
  ENDIF.
* planning objects + org.units
  LOOP AT it_parameter INTO ls_parameter WHERE type = '031'.
    CHECK NOT ls_parameter-value IS INITIAL.
    CLEAR ls_poboe.
    ls_poboe-pobnr = ls_parameter-value(10).                "#EC ENHOK
    ls_poboe-orgid = ls_parameter-value+10(8).              "#EC ENHOK
    CHECK NOT ls_poboe-pobnr IS INITIAL AND
          NOT ls_poboe-orgid IS INITIAL.
    APPEND ls_poboe TO lt_poboe.
  ENDLOOP.
*-->begin of MED-55056 AGujev
*we have to calculate time and duration for each planning object, not just max/min for all planning objects!
*previous logic only worked in case of single objects , otherwise it took same time and duration for all!
  LOOP AT it_parameter INTO ls_parameter.
    IF ls_parameter-type = '014' OR ls_parameter-type = '015'
        OR ls_parameter-type = '032' OR ls_parameter-type = '033'
           OR ls_parameter-type = '031'.
      IF l_count = 5.
        l_count = 0.
        CLEAR ls_pob_info.
      ENDIF.
      l_count = l_count + 1.
      CASE ls_parameter-type.
        WHEN '031'.
          ls_pob_info-pobnr = ls_parameter-value(10).
          ls_pob_info-planoe = ls_parameter-value+10(8).
        WHEN '032'.
          ls_pob_info-timefrom = ls_parameter-value.
        WHEN '033'.
          ls_pob_info-timeto = ls_parameter-value.
        WHEN '014'.
          ls_pob_info-datefrom = ls_parameter-value.
        WHEN '015'.
          ls_pob_info-dateto = ls_parameter-value.
      ENDCASE.
      IF l_count = 5.
        APPEND ls_pob_info TO lt_pob_info.
      ENDIF.
    ENDIF.
  ENDLOOP.
  LOOP AT lt_pob_info ASSIGNING <fs_pob_info>.
    IF <fs_pob_info>-pobnr IS INITIAL OR <fs_pob_info>-planoe IS INITIAL
*    OR <fs_pob_info>-timefrom IS INITIAL  - this can be initial! - 00:00:00
          OR <fs_pob_info>-timeto IS INITIAL
          OR <fs_pob_info>-datefrom IS INITIAL OR <fs_pob_info>-dateto IS INITIAL.
      DELETE lt_pob_info.
    ELSE.
      <fs_pob_info>-dauer = ( <fs_pob_info>-timeto - <fs_pob_info>-timefrom ) / 60.
    ENDIF.
  ENDLOOP.
  SORT lt_pob_info BY pobnr planoe.
  SORT lt_poboe BY pobnr orgid.
  DELETE ADJACENT DUPLICATES FROM lt_poboe COMPARING pobnr orgid.
*if there are more entries for the same planning object, these will be in lt_pob_info table already
*<--end of MED-55056 AGujev
  clear l_count.                                   "MED-57690 AGujev
  describe table lt_pob_info lines l_count.        "MED-57690 AGujev
*MED-57690 AGujev if no lines were generated with new logic , use default values!
*MED-57690 AGujev otherwise when no lines are selected the plan release popup will not be shown!
* build a table with resources for dates
  IF NOT lt_poboe IS INITIAL.
    LOOP AT lt_date INTO l_date.
      LOOP AT lt_poboe INTO ls_poboe.
        CLEAR ls_res.
        if l_count > 0 .     "MED-57690 AGujev
*-->begin of MED-55056 AGujev
*search in the table for each planning object
*if nothing is found don't use generic values anymore!
        LOOP AT lt_pob_info INTO ls_pob_info WHERE pobnr = ls_poboe-pobnr AND planoe = ls_poboe-orgid.
          ls_res-time = ls_pob_info-timefrom.
          ls_res-dauer = ls_pob_info-dauer.
          IF ls_res-dauer <= 0.
            ls_res-dauer = l_dauer.
          ENDIF.
        ls_res-date  = l_date.
        ls_res-pobnr = ls_poboe-pobnr.
        ls_res-orgid = ls_poboe-orgid.
          IF ls_pob_info-datefrom = l_date.
            APPEND ls_res TO lt_res.
            CONTINUE. "there could be more lines for same date/planning object with different time and duration!
            "these have to be added to the resource table too
          ENDIF.
        ENDLOOP.
*<--end of MED-55056 AGujev
               else.    "MED-57690 AGujev
*-->begin of MED-57690 AGujev
*old logic has to be used in case no line were generated for planning object info, otherwise we'll have no resource data
          IF l_time_from IS NOT INITIAL.
            ls_res-time  = l_time_from.
          ENDIF.
          ls_res-dauer = l_dauer.
          ls_res-date  = l_date.
          ls_res-pobnr = ls_poboe-pobnr.
          ls_res-orgid = ls_poboe-orgid.
          APPEND ls_res TO lt_res.
*<--end of MED-57690 AGujev
*MED-55056 AGujev - below 9 lines have been commented, we don't need the generic values anymore
*          IF l_time_from IS NOT INITIAL.                                   "MED-55056 AGujev
*            ls_res-time  = l_time_from.                                "MED-55056 AGujev
**          ls_res-dauer = l_dauer.      "MED-48953, Cristina Jitareanu 09.11.2012   "MED-55056 AGujev
*          ENDIF.                                            "MED-55056 AGujev
*          ls_res-dauer = l_dauer.      "MED-48953, Cristina Jitareanu 09.11.2012    "MED-55056 AGujev
*          ls_res-date  = l_date.     "MED-55056 AGujev
*          ls_res-pobnr = ls_poboe-pobnr.     "MED-55056 AGujev
*          ls_res-orgid = ls_poboe-orgid.     "MED-55056 AGujev
*          APPEND ls_res TO lt_res.      "MED-55056 AGujev
         endif.           "MED-57690 AGujev
      ENDLOOP.
    ENDLOOP.
  ENDIF.
* check resources with planning authority
  IF NOT l_planoe IS INITIAL.
    LOOP AT lt_res INTO ls_res.
      CALL METHOD cl_ishmed_utl_apmg=>check_planning_authority
        EXPORTING
          i_plnoe          = l_planoe
          i_einri          = i_einri
          i_date           = ls_res-date
          i_pobnr          = ls_res-pobnr
          i_orgid          = ls_res-orgid "MED-42508
          i_chk_time       = ' '
          i_refresh_buffer = ' '
          i_plan_auth_msg  = ' '
        IMPORTING
          e_plan_auth      = l_plan_auth.
      IF l_plan_auth = off.
        DELETE lt_res.
      ENDIF.
    ENDLOOP.
  ENDIF.

* necessary data given?
  IF lt_plans[] IS INITIAL AND
     lt_apps[]  IS INITIAL AND
     lt_res[]   IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1APMG_MED'
        i_num  = '064'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.

* with or without dialog?
  LOOP AT it_parameter INTO ls_parameter WHERE type = '030'.
    l_dialog = ls_parameter-value.
    EXIT.
  ENDLOOP.
  IF sy-subrc <> 0.
    IF NOT l_planoe IS INITIAL.
      CALL METHOD cl_ishmed_utl_base=>get_ou_parameter
        EXPORTING
          i_einri     = i_einri
          i_ou        = l_planoe
          i_par_name  = 'N1RLSPDIA'
*         I_DATE      = SY-DATUM
        IMPORTING
          e_par_value = l_n1rlspdia.
      l_dialog = l_n1rlspdia.
    ENDIF.
  ENDIF.

  IF l_dialog = off.
*   create instance for plan release process (without dialog)
    CALL METHOD cl_ishmed_prc_applan=>create
      IMPORTING
        er_instance     = lr_prc_applan
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
  ELSE.
*   create instance for plan release process (with dialog)
    CALL METHOD cl_ishmed_prc_applan_dialog=>create_dialog
      IMPORTING
        er_instance     = lr_prc_applan_dialog
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
  ENDIF.
  IF l_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* set data for process
  IF l_dialog = off.
    CALL METHOD lr_prc_applan->set_process_data
      EXPORTING
        i_institution   = i_einri
        i_vcode         = l_vcode
        i_prc_embedded  = off
        i_save          = i_save
        i_commit        = i_commit
        i_caller        = i_caller
        i_enqueue       = i_enqueue
        i_dequeue       = i_dequeue
        ir_environment  = c_environment
        it_plans        = lt_plans
        it_appointments = lt_apps
        it_resources    = lt_res
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler
        cr_lock         = c_lock.
*        cr_cancel       =
  ELSE.
    CALL METHOD lr_prc_applan_dialog->set_process_data
      EXPORTING
        i_institution   = i_einri
        i_vcode         = l_vcode
        i_prc_embedded  = off
        i_save          = i_save
        i_commit        = i_commit
        i_caller        = i_caller
        i_enqueue       = i_enqueue
        i_dequeue       = i_dequeue
        ir_environment  = c_environment
        it_plans        = lt_plans
        it_appointments = lt_apps
        it_resources    = lt_res
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler
        cr_lock         = c_lock.
*        cr_cancel       =
  ENDIF.
  IF l_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* run plan release process
* without dialog if possible or requested, otherwise with dialog
  IF l_dialog = off.
    CALL METHOD cl_ishmed_utl_app_rls=>release_use_dialog_if_needed
      EXPORTING
        ir_prc_applan   = lr_prc_applan
      IMPORTING
        e_rc            = e_rc
        e_cancel        = l_cancel
      CHANGING
        cr_errorhandler = c_errorhandler.
  ELSE.
    CALL METHOD cl_ishmed_utl_app_rls=>release_use_dialog_if_needed
      EXPORTING
        ir_prc_applan   = lr_prc_applan_dialog
      IMPORTING
        e_rc            = e_rc
        e_cancel        = l_cancel
      CHANGING
        cr_errorhandler = c_errorhandler.
  ENDIF.
  CASE e_rc.
    WHEN 0.
      IF l_cancel = off.
*       Everything OK
        e_rc = 0.
        IF l_vcode = 'UPD'.
          e_refresh = 1.
        ENDIF.
      ELSE.
*       Cancel
        e_rc = 2.
        e_refresh = 0.
      ENDIF.
    WHEN OTHERS.
*     Error occured
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

* destroy instance of process
  IF l_dialog = off.
    CALL METHOD lr_prc_applan->destroy.
  ELSE.
    CALL METHOD lr_prc_applan_dialog->destroy.
  ENDIF.

ENDMETHOD.


METHOD call_print_form .

  DATA: l_rc               TYPE sy-subrc,
        l_name(50)         TYPE c,
        l_parameter        LIKE LINE OF it_parameter,
        lt_messages        TYPE STANDARD TABLE OF bapiret2,
        l_message          LIKE LINE OF lt_messages,
        lt_nbew            TYPE ishmed_t_nbew,
        l_nbew             LIKE LINE OF lt_nbew,
        lt_ntmn            TYPE ishmed_t_ntmn,
        l_ntmn             LIKE LINE OF lt_ntmn,
        lt_napp            TYPE ishmed_t_napp,
        l_napp             LIKE LINE OF lt_napp,
        lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        l_n_vnapp          TYPE n_vnapp.

  DATA: lt_events          TYPE ish_t_event,
        l_event            LIKE LINE OF lt_events.
  DATA: l_print_error      TYPE sy-subrc.
* Flag für Standard-Formulardruck
  DATA: l_std_print(1)     TYPE c VALUE ' '.
* Ereignis für den Formulardruck
  DATA: l_std_event        TYPE rnevt-event.
  DATA: l_ue_event         TYPE tne00-event.
  DATA: l_user_exit        TYPE tne00-fbnam.

  DATA: lt_nbew_all        TYPE ishmed_t_nbew.              "CDuerr, MED-86166

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierten (Vorläufigen) Patienten und Fall ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Funktion für vorläufige Patienten nicht möglich
  CLEAR: l_npat, l_npap, l_nfal.
  READ TABLE lt_npat INTO l_npat INDEX 1.
  READ TABLE lt_npap INTO l_npap INDEX 1.
  READ TABLE lt_nfal INTO l_nfal INDEX 1.
  IF l_npat-patnr IS INITIAL AND l_nfal-falnr IS INITIAL.
    IF NOT l_npap-papid IS INITIAL.
      CLEAR l_name.
      PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                    l_npap-vorsw
                                                    l_npap-nname
                                                    l_npap-vname
                                                    l_name.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '617'
          i_mv1  = l_name
          i_mv2  = 'Funktion'(006)
          i_last = space.
    ELSE.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '078'
          i_last = space.
    ENDIF.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Formular-Druck-Events ermitteln
  LOOP AT it_parameter INTO l_parameter WHERE type = '012'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_std_event = l_parameter-value.
  ENDLOOP.
  LOOP AT it_parameter INTO l_parameter WHERE type = '013'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_ue_event = l_parameter-value.
  ENDLOOP.

* Ermittlung eines möglichen USER-EXITS
  IF NOT l_ue_event IS INITIAL.
    CALL FUNCTION 'ISH_USER_EXIT_GET'
      EXPORTING
        ss_event     = l_ue_event
      IMPORTING
        ss_fbname    = l_user_exit
      EXCEPTIONS
        no_user_exit = 01.
    IF sy-subrc NE 0.
      CLEAR l_user_exit.
    ENDIF.
  ELSE.
    CLEAR l_user_exit.
  ENDIF.

* Bewegung und/oder Termin ermitteln
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_ntmn        = lt_ntmn
      et_napp        = lt_napp
      et_nbew        = lt_nbew
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Welche Formulardruck-Funktion soll aufgerufen werden?
  IF i_fcode = 'FPRO'.

*   Formular-Protokoll - - - - - - - - - - - - - - - - - - - - - - - -

    IF l_nfal-falnr IS INITIAL OR l_npat-patnr IS INITIAL.
      EXIT.
    ENDIF.

    CALL FUNCTION 'ISH_FORM_PROTOCOL_LIST'
      EXPORTING
        einri     = i_einri
        falnr     = l_nfal-falnr
        patnr     = l_npat-patnr
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.

    CASE sy-subrc.
      WHEN 0.
        e_rc = 0.
      WHEN OTHERS.
        e_rc = 1.
    ENDCASE.
    e_refresh = 0.
*   Kein EXIT ... Message unten zurückgeben

  ELSE.

*   Formular-Druck - - - - - - - - - - - - - - - - - - - - - - - - - -

*   Standard-Druck je nach Fcode
    CASE i_fcode.
      WHEN 'FORM'.
*       Parameter 'Standard-/Auswahlformulardruck für Drucktaste'
        PERFORM ren00r IN PROGRAM sapmnpa0 USING i_einri
                                                 'STD_PRI'
                                                 l_std_print.
      WHEN 'FORS'.
        l_std_print = on.
      WHEN 'FORA'.
        l_std_print = off.
    ENDCASE.

*   Was wurde markiert (Bewegung oder Termin)?
    CLEAR: l_nbew, l_ntmn.
    READ TABLE lt_nbew INTO l_nbew INDEX 1.
    IF i_caller <> 'NWP011'.  " Kein Druck für Termin im Sichttyp OP
      READ TABLE lt_ntmn INTO l_ntmn INDEX 1.
    ENDIF.

    IF l_nbew IS INITIAL AND l_ntmn IS INITIAL.
*     CDuerr, MED-86166 - begin
*      SELECT * FROM nbew INTO TABLE lt_nbew
*                        WHERE einri EQ i_einri
*                        AND   falnr EQ l_nfal-falnr
*                        AND   lfdnr EQ l_nfal-bewlf.
*      IF sy-subrc = 0.
*        READ TABLE lt_nbew INTO l_nbew INDEX 1.
*      ELSE.
**       Formulardruck erst mit Bewegung möglich
*        CALL METHOD c_errorhandler->collect_messages
*          EXPORTING
*            i_typ  = 'E'
*            i_kla  = 'NF1'
*            i_num  = '111'
*            i_last = space.
*        e_rc      = 1.
*        e_refresh = 0.
*        EXIT.
*      ENDIF.

      REFRESH lt_nbew_all.
      SELECT * FROM nbew INTO TABLE lt_nbew_all
        WHERE einri = i_einri
          AND falnr = l_nfal-falnr.
      IF sy-subrc = 0.
        DELETE lt_nbew_all WHERE storn = on.
        SORT lt_nbew_all BY lfdnr DESCENDING.
        CASE l_nfal-falar.
          WHEN '2'.
            LOOP AT lt_nbew_all INTO l_nbew.
              IF l_nbew-bewty = '4'.
                APPEND l_nbew TO lt_nbew.
                EXIT.
              ENDIF.
            ENDLOOP.
          WHEN OTHERS.
            LOOP AT lt_nbew_all INTO l_nbew.
              IF l_nbew-bewty = '1' OR
                 l_nbew-bewty = '3'.
                APPEND l_nbew TO lt_nbew.
                EXIT.
              ENDIF.
            ENDLOOP.
        ENDCASE.
      ENDIF.
      IF lt_nbew[] IS INITIAL.
*       Formulardruck erst mit Bewegung möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '111'
            i_last = space.
        e_rc      = 1.
        e_refresh = 0.
        EXIT.
      ENDIF.
*     CDuerr, MED-86166 - end

    ENDIF.

*   Formulardruck für Bewegung oder Termin?
    IF NOT l_nbew IS INITIAL.

*     Formulardruck für Bewegung * * * * * * * * * * * * * * * * * * *
      IF NOT l_user_exit IS INITIAL.
        CALL FUNCTION l_user_exit
          EXPORTING
            applk       = 'N'
            event       = l_std_event
            st_print    = l_std_print
            einri       = i_einri
            falnr       = l_nfal-falnr
            lfdbew      = l_nbew-lfdnr
          IMPORTING
            print_error = l_print_error
          EXCEPTIONS
            OTHERS      = 1.
*       Fehler oder erfolgreich gedruckt ?
        IF l_print_error <> 0 OR sy-subrc <> 0.
          e_rc = 1.
        ELSE.
          e_rc = 0.
        ENDIF.
*       Kein EXIT ... Message unten zurückgeben
      ELSE.
        PERFORM call_ish_form_select IN PROGRAM sapln1wp
                          TABLES   lt_nbew
                                   lt_nfal
                                   lt_messages
                          USING    i_einri
                                   l_std_print
                                   l_std_event
                          CHANGING l_rc.
        IF l_rc <> 0.
          e_rc = 1.
          e_refresh = 0.
          LOOP AT lt_messages INTO l_message.
            CALL METHOD c_errorhandler->collect_messages
              EXPORTING
                i_typ  = l_message-type
                i_kla  = l_message-id
                i_num  = l_message-number
                i_mv1  = l_message-message_v1
                i_mv2  = l_message-message_v2
                i_mv3  = l_message-message_v3
                i_mv4  = l_message-message_v4
                i_last = space.
          ENDLOOP.
          IF sy-subrc = 0.
            EXIT.
          ELSE.                                            "#EC NEEDED
*           Kein EXIT ... Message unten zurückgeben
          ENDIF.
        ELSE.
          e_rc = 0.
          e_refresh = 0.
*         Kein EXIT ... Message unten zurückgeben
        ENDIF.
      ENDIF.

    ELSEIF NOT l_ntmn IS INITIAL.

*     Formulardruck für Termin * * * * * * * * * * * * * * * * * * * *
      CLEAR l_n_vnapp.
      READ TABLE lt_napp INTO l_napp INDEX 1.
      CHECK sy-subrc = 0.
      MOVE-CORRESPONDING l_napp TO l_n_vnapp.        "#EC ENHOK
      MOVE-CORRESPONDING l_ntmn TO l_n_vnapp.        "#EC ENHOK
*     Event
      MOVE 'N' TO l_event-applk.
      l_event-event = l_std_event.
      APPEND l_event TO lt_events.
      PERFORM print_forms IN PROGRAM sapln1lstamb
            TABLES lt_events
            USING  l_std_print
                   l_n_vnapp.
      EXIT.  " Messages wurden bereits in dem FORM ausgegeben
    ENDIF.
  ENDIF.

  IF e_rc <> 0.
*   Fehler beim Drucken
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1'
        i_num  = '562'
        i_last = space.
*  ELSE.                                           " REM MED-43620
**   Druckauftrag ausgeführt                       " REM MED-43620
*    CALL METHOD c_errorhandler->collect_messages
*      EXPORTING
*        i_typ  = 'S'
*        i_kla  = 'N1'
*        i_num  = '561'
*        i_last = space.
  ENDIF.

ENDMETHOD.


METHOD call_pts_insert .

  DATA: l_check_type       TYPE n1nbrlines_check_type,
*        l_name(50)         TYPE c,
        l_parameter        LIKE LINE OF it_parameter,
        l_tptyp            TYPE n1fat-tptyp,
        l_orgag            TYPE n1fat-orgag,
        l_bauag            TYPE n1fat-bauag,
        l_n1fat            TYPE n1fat,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_msg             TYPE STANDARD TABLE OF rn1chkret,
        l_msg              LIKE LINE OF lt_msg.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_check_type, l_n1fat, l_npat, l_npap,
         l_tptyp, l_orgag, l_bauag.

  REFRESH: lt_npat, lt_npap, lt_msg.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Wieviele Einträge müssen markiert sein?
  CASE i_fcode.
    WHEN 'PTS_INS'.
      l_check_type = '1'.                               " nur genau 1
    WHEN 'PTS_INSO'.
      l_check_type = ' '.                               " egal
    WHEN OTHERS.
      EXIT.
  ENDCASE.

  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = l_check_type
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierte (vorläufige) Patienten ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_npat INTO l_npat INDEX 1.
  IF sy-subrc <> 0.
    READ TABLE lt_npap INTO l_npap INDEX 1.
  ENDIF.

** Vorläufige Patienten markiert? (ab 7.00 möglich!)
*  DESCRIBE TABLE lt_npap.
*  IF sy-tfill > 0 AND i_fcode = 'PTS_INS'.
**   Fahrauftrag mit Patient für voläufige Patienten nicht möglich
*    LOOP AT lt_npap INTO l_npap.
*      CLEAR l_name.
*      PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
*                                                    l_npap-vorsw
*                                                    l_npap-nname
*                                                    l_npap-vname
*                                                    l_name.
**     Patient noch nicht aufgenommen - Funktion nicht möglich
*      CALL METHOD c_errorhandler->collect_messages
*        EXPORTING
*          i_typ  = 'E'
*          i_kla  = 'NF1'
*          i_num  = '617'
*          i_mv1  = l_name
*          i_mv2  = 'Funktion'(006)
*          i_last = space.
*    ENDLOOP.
*    e_rc      = 1.
*    e_refresh = 0.
*    EXIT.
*  ENDIF.

* Transporttyp (als Vorbelegung) übergeben?
  LOOP AT it_parameter INTO l_parameter WHERE type = '018'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_tptyp = l_parameter-value.
    EXIT.
  ENDLOOP.
  IF l_tptyp IS INITIAL.
    l_tptyp = '1'.                    " Hintransport
  ENDIF.

* Ausgangs-OE (als Vorbelegung) übergeben?
  LOOP AT it_parameter INTO l_parameter WHERE type = '016'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_orgag = l_parameter-value.
    EXIT.
  ENDLOOP.

* Ausgangs-Raum (als Vorbelegung) übergeben?
  LOOP AT it_parameter INTO l_parameter WHERE type = '019'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_bauag = l_parameter-value.
    EXIT.
  ENDLOOP.

  CASE i_fcode.
    WHEN 'PTS_INS'.
*     Fahrauftrag MIT Patient anlegen
      l_n1fat-einri = i_einri.
      l_n1fat-patnr = l_npat-patnr.
      l_n1fat-papid = l_npap-papid.
      l_n1fat-bauag = l_bauag.
      l_n1fat-orgag = l_orgag.
      l_n1fat-tptyp = l_tptyp.
    WHEN 'PTS_INSO'.
*     Fahrauftrag OHNE Patient anlegen
      l_n1fat-einri = i_einri.
      l_n1fat-orgag = l_orgag.
      l_n1fat-tptyp = l_tptyp.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* Fahrauftrag anlegen
  CALL FUNCTION 'ISHMED_PTS_ORDER_UPDATE'
       EXPORTING
           i_n1fat             = l_n1fat
           i_vcode             = 'INS'
           i_dialog            = 'X'
           i_event             = 'FATINS'
           i_orgid             = l_orgag
*           I_VORB_UPD          = ' '
*           I_NTMN              =
*           I_NTMN_OLD          =
           i_save              = i_save
           i_commit            = i_commit
*           I_UPDATE_TASK       = ' '
           i_messages          = off
       IMPORTING
           e_rc                = e_rc
       TABLES
           t_messages          = lt_msg.

  CASE e_rc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
      CASE i_caller.
        WHEN 'NWP011'.
          e_refresh = 0.  " in der OP-Sicht keine Fahrauftragsdaten!
        WHEN OTHERS.
          e_refresh = 1.
      ENDCASE.
    WHEN 2.
*     Cancel
      e_rc = 2.
      e_refresh = 0.
    WHEN OTHERS.
*     Error occured
      e_rc = 1.
      e_refresh = 0.
      LOOP AT lt_msg INTO l_msg.
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = l_msg-type
            i_kla  = l_msg-id
            i_num  = l_msg-number
            i_mv1  = l_msg-message_v1
            i_mv2  = l_msg-message_v2
            i_mv3  = l_msg-message_v3
            i_mv4  = l_msg-message_v4
            i_last = space.
      ENDLOOP.
  ENDCASE.

ENDMETHOD.


METHOD call_pts_rwtr .

  DATA: l_name(50)         TYPE c,
        l_parameter        LIKE LINE OF it_parameter,       "#EC *
*        lt_npat            TYPE ishmed_t_npat,
*        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_ntmn            TYPE ishmed_t_ntmn,
        l_ntmn             LIKE LINE OF lt_ntmn,
        lt_msg             TYPE STANDARD TABLE OF rn1chkret,
        l_msg              LIKE LINE OF lt_msg.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_npap, l_ntmn.

  REFRESH: lt_npap, lt_ntmn, lt_msg.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es darf nur genau 1 Eintrag markiert sein?
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                    " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierte (vorläufige) Patienten ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
*  READ TABLE lt_npat INTO l_npat INDEX 1.

* Vorläufige Patienten markiert?
  DESCRIBE TABLE lt_npap.
  IF sy-tfill > 0.
*   Rück-/Weitertransport für voläufige Patienten nicht möglich
    LOOP AT lt_npap INTO l_npap.
      CLEAR l_name.
      PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                    l_npap-vorsw
                                                    l_npap-nname
                                                    l_npap-vname
                                                    l_name.
*     Patient noch nicht aufgenommen - Funktion nicht möglich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '617'
          i_mv1  = l_name
          i_mv2  = 'Funktion'(006)
          i_last = space.
    ENDLOOP.
    e_rc      = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Termin markiert?
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_ntmn        = lt_ntmn
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.

* Wenn kein Termin vorhanden ist, dann Fahrauftrag anlegen,
* sonst Rück- oder Weitertransport anlegen/ändern
  DESCRIBE TABLE lt_ntmn.
  IF sy-tfill = 0.
    CALL METHOD cl_ishmed_functions=>call_pts_insert
      EXPORTING
        i_fcode        = 'PTS_INS'
        i_einri        = i_einri
        i_caller       = i_caller
        i_save         = i_save
        i_commit       = i_commit
        i_enqueue      = i_enqueue
        it_objects     = it_objects
        it_parameter   = it_parameter
      IMPORTING
        e_rc           = e_rc
        e_func_done    = e_func_done
        e_refresh      = e_refresh
      CHANGING
        c_errorhandler = c_errorhandler
        c_environment  = c_environment
        c_lock         = c_lock.
  ELSE.
    READ TABLE lt_ntmn INTO l_ntmn INDEX 1.
    CHECK sy-subrc = 0.
    CALL FUNCTION 'ISHMED_PTS_ORDER_FOR_NTMN_UPD'
      EXPORTING
        i_ntmn        = l_ntmn
        i_tptyp_event = '23'
        i_orgid       = l_ntmn-tmnoe
      IMPORTING
        e_rc          = e_rc
      TABLES
        t_messages    = lt_msg.
    CASE e_rc.
      WHEN 0.
*       Everything OK
        e_rc = 0.
        CASE i_caller.
          WHEN 'NWP011'.
            e_refresh = 0.  " in der OP-Sicht keine Fahrauftragsdaten!
          WHEN OTHERS.
            e_refresh = 1.
        ENDCASE.
      WHEN 2.
*       Cancel
        e_rc = 2.
        e_refresh = 0.
      WHEN OTHERS.
*       Error occured
        e_rc = 1.
        e_refresh = 0.
        LOOP AT lt_msg INTO l_msg.
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = l_msg-type
              i_kla  = l_msg-id
              i_num  = l_msg-number
              i_mv1  = l_msg-message_v1
              i_mv2  = l_msg-message_v2
              i_mv3  = l_msg-message_v3
              i_mv4  = l_msg-message_v4
              i_last = space.
        ENDLOOP.
    ENDCASE.
  ENDIF.

ENDMETHOD.


METHOD call_request .

  DATA: lt_n1anf           TYPE ishmed_t_n1anf,
        l_n1anf            LIKE LINE OF lt_n1anf,
        l_tcode            TYPE sy-tcode.
*        l_nbr_marked       TYPE i.

  DATA: l_rolle TYPE c.     "Grill, med-32344

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

*  CLEAR l_nbr_marked.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
     IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierte Anforderung ermitteln
  CALL METHOD cl_ishmed_functions=>get_requests
    EXPORTING
      it_objects     = it_objects
      i_cancelled_datas = on
    IMPORTING
      e_rc           = e_rc
*      ET_REQUESTS    =
      et_n1anf       = lt_n1anf
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Es muß eine Anforderung markiert sein
  READ TABLE lt_n1anf INTO l_n1anf INDEX 1.
  IF sy-subrc <> 0 OR l_n1anf-anfid IS INITIAL.
*   Bitte markieren Sie eine Anforderung
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '296'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Anforderung ändern oder anzeigen?
  CASE i_fcode.
    WHEN 'REQD'.
      l_tcode = 'N1BC'.                " display
    WHEN 'REQU'.
      l_tcode = 'N1BB'.                " update
    WHEN OTHERS.
      l_tcode = 'N1BC'.                " display
  ENDCASE.

  IF l_n1anf-storn = on.
    l_tcode = 'N1BC'.
  ENDIF.

*-- begin Grill, med-32344
  IF i_caller EQ 'WPV004'.
    l_rolle = 'A'.
  ELSEIF i_caller EQ 'NWP007' OR
         i_caller EQ 'NWP011'.      "Grill, med-32646
    l_rolle = 'E'.
  ENDIF.
*-- end Grill, med-32344

* Anforderung ändern/anzeigen
  CALL FUNCTION 'ISHMED_CALL_ANFO_NEU'
    EXPORTING
      i_n1anf      = l_n1anf
*      i_rolle      = 'A'        "REM MED-29972
*     i_rolle      = 'E'         "MED-32344
      i_rolle      = l_rolle     "MED-32344
      i_sperren    = 'X'
      i_tcode      = l_tcode
    EXCEPTIONS
      parm_invalid = 1
      not_found    = 2
      OTHERS       = 3.

  IF sy-subrc <> 0.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '138'
        i_last = space.
    e_rc      = 1.
    e_refresh = 0.
  ELSE.
    e_rc      = 0.
    e_refresh = 1.
  ENDIF.

ENDMETHOD.


METHOD call_request_create .

  DATA: lt_nfal            TYPE ishmed_t_nfal,
        l_nfal             LIKE LINE OF lt_nfal,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_provpat         TYPE rnpap_t_searchlist,
        l_provpat          LIKE LINE OF lt_provpat,
        lt_erboe           TYPE ishmed_t_orgid,
        l_erboe            LIKE LINE OF lt_erboe,
        l_anpoe            TYPE n1anf-anpoe,
        l_anfoe            TYPE n1anf-anfoe,        "MED-29986
        l_function(40)     TYPE c,
        l_pname(50)        TYPE c,
        l_n1anf            TYPE n1anf,
        l_aufrf            TYPE sy-tcode,
        l_parameter        LIKE LINE OF it_parameter,
        l_caseless         TYPE rnt40-mark,
        lt_rn1ls           TYPE ishmed_t_rn1ls,
        lr_cont            TYPE REF TO cl_ishmed_srv_choice_list_cont,
        l_is_inh           TYPE ish_on_off,
        l_srv_choice_list  TYPE ish_on_off,
        l_nbr_marked       TYPE i,
        l_vorl_pat         TYPE ish_on_off,
        l_falob            TYPE ish_on_off,
        l_answer(1)        TYPE c,
        ls_nfal            TYPE nfal,
        ls_services        TYPE rn1ls,
        l_zotyp            TYPE nllz-zotyp,
        lr_surgery_service TYPE REF TO cl_ishmed_service,
        ls_nlei            TYPE nlei.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR l_nbr_marked.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur entweder kein oder 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '0'                                  " 0 oder 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Aufruf von 'Anforderung anlegen' je nach Anzahl Markierungen
* bzw. immer bei der Funktion 'Eingelangte Anforderungen erfassen'
  IF l_nbr_marked = 0 OR i_fcode = 'REQ_ELAF'.

    IF i_fcode = 'REQ_ELAF'.
*     Eingelangte Anforderungen erfassen
      l_aufrf = 'ELAF'.
*     Erbringende Org.Einheit aus markiertem Eintrag ermitteln
      CALL METHOD cl_ishmed_functions=>get_erboes
        EXPORTING
          it_objects     = it_objects
        IMPORTING
          e_rc           = e_rc
          et_erboe       = lt_erboe
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
      READ TABLE lt_erboe INTO l_erboe INDEX 1.
*     Patient + Fall aus markiertem Eintrag ermitteln
      CALL METHOD cl_ishmed_functions=>get_patients_and_cases
        EXPORTING
          it_objects     = it_objects
          i_read_db      = on
        IMPORTING
          e_rc           = e_rc
          et_nfal        = lt_nfal
          et_npat        = lt_npat
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
      CLEAR: l_npat, l_nfal.
      READ TABLE lt_npat INTO l_npat INDEX 1.
      READ TABLE lt_nfal INTO l_nfal INDEX 1.
      SET PARAMETER ID 'EIN' FIELD i_einri.
      SET PARAMETER ID 'PAT' FIELD l_npat-patnr.
      SET PARAMETER ID 'PZP' FIELD l_npat-pziff.
      SET PARAMETER ID 'FAL' FIELD l_nfal-falnr.
      SET PARAMETER ID 'PZF' FIELD l_nfal-fziff.
      CLEAR l_n1anf.
      l_n1anf-einri = i_einri.
      l_n1anf-orgid = l_erboe.
      l_n1anf-falnr = l_nfal-falnr.
    ELSE.
*     Kein Eintrag markiert - - - - - - - - - - - - - - - - - - - - - -
      CLEAR l_aufrf.
      CLEAR l_n1anf.
      l_n1anf-einri = i_einri.
      SET PARAMETER ID 'EIN' FIELD i_einri.
      SET PARAMETER ID 'FAL' FIELD space.
      SET PARAMETER ID 'PZF' FIELD space.
      SET PARAMETER ID 'PAT' FIELD space.
      SET PARAMETER ID 'PZP' FIELD space.
      SET PARAMETER ID 'OEA' FIELD space.
      SET PARAMETER ID 'ATP' FIELD space.
    ENDIF.

    CALL FUNCTION 'ISHMED_CALL_ANFO_NEU'
      EXPORTING
        i_n1anf      = l_n1anf
        i_aufrf      = l_aufrf
        i_rolle      = 'A'
        i_sperren    = on
        i_tcode      = 'N1BA'
        i_skip_first = off
      EXCEPTIONS
        parm_invalid = 1
        not_found    = 2
        OTHERS       = 3.
    CASE sy-subrc.
      WHEN 0.
*       Alles OK
        e_rc = 0.
        e_refresh = 2.
      WHEN 1 OR 2 OR 3.
*       Fehler bei der Verarbeitung (Fehler beim Sichern)
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF'
            i_num  = '437'
            i_last = space.
        e_rc = 1.
        e_refresh = 0.
    ENDCASE.
    SET PARAMETER ID 'FAL' FIELD space.
    SET PARAMETER ID 'PZF' FIELD space.
    SET PARAMETER ID 'PAT' FIELD space.
    SET PARAMETER ID 'PZP' FIELD space.
    EXIT.

  ELSE.

*   1 Eintrag markiert  - - - - - - - - - - - - - - - - - - - - - - -

*   (Vorläufigen) Patient + Fall aus markiertem Eintrag ermitteln
    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = it_objects
        i_read_db      = on
      IMPORTING
        e_rc           = e_rc
        et_nfal        = lt_nfal
        et_npat        = lt_npat
        et_npap        = lt_npap
        et_provpat     = lt_provpat
      CHANGING
        c_environment  = c_environment
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.

*   Vorläufigen Patienten nötigenfalls in 'echten' Patienten umwandeln
    CLEAR: l_npat, l_provpat.
    READ TABLE lt_npat    INTO l_npat INDEX 1.
    READ TABLE lt_provpat INTO l_provpat INDEX 1.
    IF l_npat-patnr IS INITIAL AND NOT l_provpat IS INITIAL.
      READ TABLE lt_npap INTO l_npap INDEX 1.
      IF sy-subrc = 0.
        CALL METHOD cl_ish_utl_base_patient=>get_name_patient
          EXPORTING
            i_papid = l_npap-papid
            is_npap = l_npap
          IMPORTING
            e_pname = l_pname.
      ELSE.
        l_pname = 'Patient'(005).
      ENDIF.
      l_function = 'Anforderung anlegen'(001).
      MESSAGE i618(nf1) WITH l_function l_pname.
      CALL METHOD cl_ishmed_functions=>switch_and_delete_npap
        EXPORTING
          i_einri        = i_einri
          i_provpat      = l_provpat
*          I_PAPID        =
          i_save         = i_save
          i_commit       = i_commit
        IMPORTING
          e_patnr        = l_npat-patnr
          e_rc           = e_rc
        CHANGING
          c_errorhandler = c_errorhandler
          c_environment  = c_environment.
      CHECK e_rc = 0.
      l_vorl_pat = on.                                      " ID 17387
    ENDIF.

*   Erbringende Org.Einheit aus markiertem Eintrag ermitteln
    CALL METHOD cl_ishmed_functions=>get_erboes
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_erboe       = lt_erboe
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_erboe INTO l_erboe INDEX 1.
    l_anpoe = l_erboe.

*   get org.unit out of parameter if still empty
    IF l_anpoe IS INITIAL.
      LOOP AT it_parameter INTO l_parameter WHERE type = '016'.
        CHECK NOT l_parameter-value IS INITIAL.
        l_anpoe = l_parameter-value.
        EXIT.
      ENDLOOP.
    ENDIF.

*   BEGIN BM MED-29986
*   get initiating department
    LOOP AT it_parameter INTO l_parameter WHERE type = '035'.
      CHECK NOT l_parameter-value IS INITIAL.
      l_anfoe = l_parameter-value.
      EXIT.
    ENDLOOP.
*   END BM MED-29986

*   get parameter to decide if service choice list has to be presented
    l_srv_choice_list = on.
    CLEAR: l_caseless, lt_rn1ls, lr_cont.
    LOOP AT it_parameter INTO l_parameter WHERE type = '000'.
      CHECK NOT l_parameter-object IS INITIAL.
      CALL METHOD l_parameter-object->('IS_INHERITED_FROM')
        EXPORTING
          i_object_type       = cl_ishmed_srv_choice_list_cont=>co_otype_srv_choice_list_cont
        RECEIVING
          r_is_inherited_from = l_is_inh.
      IF l_is_inh = on.
        lr_cont ?= l_parameter-object.
        lt_rn1ls[] = lr_cont->gt_srv_list[].
        l_caseless = lr_cont->g_caseless.
        IF NOT lt_rn1ls[] IS INITIAL.
          l_srv_choice_list = off.
        ENDIF.
      ENDIF.
    ENDLOOP.

*   ID 17387: Begin of INSERT (create request with or without case)
    IF l_vorl_pat = on.
      LOOP AT lt_rn1ls INTO ls_services WHERE NOT anfty IS INITIAL.
        SELECT SINGLE falob FROM n1anftyp INTO l_falob
               WHERE anfty = ls_services-anfty.
        IF l_falob = on.
          EXIT.
        ENDIF.
      ENDLOOP.
      IF l_falob = on.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            titlebar              = text-013
            text_question         = text-016
            text_button_1         = text-014
            text_button_2         = text-015
            display_cancel_button = off
          IMPORTING
            answer                = l_answer
          EXCEPTIONS
            text_not_found        = 1
            OTHERS                = 2.
*       create case
        IF l_answer = '1' AND sy-subrc = 0.
          CALL FUNCTION 'ISH_NV2000_CALL'
            EXPORTING
              i_einri             = i_einri
              i_patnr             = l_npat-patnr
              i_vcode             = 'UPD'
              i_falar_insert      = space
              i_skip_entry        = 'X'
            IMPORTING
              e_falnr             = ls_nfal-falnr
            EXCEPTIONS
              no_authority        = 1
              enqueue_missing     = 2
              admission_not_saved = 3
              error               = 4
              OTHERS              = 5.
          IF sy-subrc <> 0.
            e_rc = 1.
            EXIT.
          ELSE.
            APPEND ls_nfal TO lt_nfal.
            l_caseless = off.
          ENDIF.
        ELSE.
          e_rc = 2.                                          " Cancel
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
*   ID 17387: End of INSERT

*   ID 20123: Begin of INSERT
*   get zotyp
    READ TABLE it_parameter INTO l_parameter WITH KEY type = '034'.
    IF sy-subrc = 0.
      l_zotyp = l_parameter-value.
    ENDIF.
*   get surgery service
    LOOP AT it_parameter INTO l_parameter WHERE type = '000'.
      CLEAR l_is_inh.
      CHECK l_parameter-object IS NOT INITIAL.
      CALL METHOD l_parameter-object->('IS_INHERITED_FROM')
        EXPORTING
          i_object_type       = cl_ishmed_service=>co_otype_anchor_srv
        RECEIVING
          r_is_inherited_from = l_is_inh.
      IF l_is_inh = on.
        lr_surgery_service ?= l_parameter-object.
      ENDIF.
    ENDLOOP.
    IF lr_surgery_service IS BOUND.
      CALL METHOD lr_surgery_service->get_data
        IMPORTING
          e_rc           = e_rc
          e_nlei         = ls_nlei
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
    ENDIF.
*   ID 20123: End of INSERT

*   Anforderung nun für den Patienten anlegen
    CALL FUNCTION 'ISHMED_GENERATE_ANFO'
         EXPORTING
            i_einri           = i_einri
            i_anpoe           = l_anpoe
            i_anfoe           = l_anfoe                     " MED-29986
            i_datum           = sy-datum
            i_lock_tab        = i_enqueue
*           I_NBEW            = SPACE
            i_ankerlei        = ls_nlei                     " ID 20123
            i_zotyp           = l_zotyp                     " ID 20123
            i_patnr           = l_npat-patnr
            i_caseless        = l_caseless
            it_services       = lt_rn1ls
            i_srv_choice_list = l_srv_choice_list
         TABLES
            t_nfal            = lt_nfal
         EXCEPTIONS
            read_error        = 1
            save_error        = 2
            no_input          = 3
            fall_locked       = 4                           " ID 17387
            sys_error         = 5
            OTHERS            = 6.
    IF sy-subrc = 0.
      e_rc = 0.
      e_refresh = 2.
    ELSEIF sy-subrc = 2.
*     Mit der pflegerischen OE & kann keine Anforderung angelegt werden
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '543'
          i_mv1  = l_erboe
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
    ELSEIF sy-subrc = 3.
      e_rc = 2.                                             " Cancel
      e_refresh = 0.
    ELSEIF sy-subrc = 4.                                    " ID 17387
      e_rc = 1.
      e_refresh = 0.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = c_errorhandler.
    ELSE.
*     Fehlermeldung bei diesen Exceptions gibt der FBS selbst aus
*      MESSAGE s658(nf) WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      e_rc = 1.
      e_refresh = 0.
    ENDIF.

  ENDIF.                               " wieviele Einträge markiert ?

ENDMETHOD.


METHOD call_request_print .

  DATA: l_tn01             TYPE tn01,
        lt_n1anf           TYPE ishmed_t_n1anf,
        l_n1anf            LIKE LINE OF lt_n1anf,
        lt_condition_tab   TYPE TABLE OF rncond,
        lt_erboe           TYPE ishmed_t_orgid,
        l_std_print        TYPE ish_on_off,
        l_uex_n1dr         TYPE tne00-fbnam,
        l_abbruch          TYPE tn02s-dbrem,
        l_cancel           TYPE rnfpr-abbruch,
        l_prt_cnt          TYPE i,
        l_print_error      TYPE sy-subrc.
  DATA: l_read_nbew        TYPE c,
        l_read_nfal        TYPE c,
        l_read_ndia        TYPE c,
        l_nfal             TYPE nfal.

* Daten für die Ereignisse
  DATA: l_evt_applk        TYPE tn02e-applk VALUE 'N',
        l_evt_request      TYPE tn02e-event VALUE 'ANF001'.
* Daten für Formulardruck
  DATA: lt_event_tab TYPE TABLE OF rnevt,
        l_event_tab  LIKE LINE OF lt_event_tab.
* Formulartabelle
  DATA: lt_print_tab TYPE TABLE OF rnfor,
        l_print_tab  LIKE LINE OF lt_print_tab.

  DATA: ls_objects LIKE LINE OF it_objects,                   "MED-39493
        lt_request_tmp  LIKE lt_n1anf,                        "MED-39493
        lt_objects_tmp LIKE it_objects.                       "MED-39493

  DATA  ls_event_data TYPE rn1_request_event_data.            "MED-79070

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_abbruch, l_prt_cnt, l_print_error.

  REFRESH: lt_n1anf, lt_condition_tab.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Standard Druck
  IF i_fcode = 'REQ_PRT_S'.
    l_std_print = on.
  ELSE.
    l_std_print = off.
  ENDIF.

* Es muß mind. 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierte Anforderung(en) holen
* MED-39493: BEGIN OF DELETE
*  CALL METHOD cl_ishmed_functions=>get_requests
*    EXPORTING
*      it_objects     = it_objects
*    IMPORTING
*      e_rc           = e_rc
*      et_n1anf       = lt_n1anf
*    CHANGING
*      c_environment  = c_environment
*      c_errorhandler = c_errorhandler.
* MED-39493: END OF DELETE
* MED-39493: BEGIN OF INSERT
  LOOP AT it_objects INTO ls_objects.
    REFRESH: lt_objects_tmp, lt_request_tmp.
    APPEND ls_objects TO lt_objects_tmp.
    CALL METHOD cl_ishmed_functions=>get_requests
      EXPORTING
        it_objects = lt_objects_tmp
      IMPORTING
        e_rc = e_rc
        et_n1anf       = lt_request_tmp
      CHANGING
        c_environment = c_environment
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ELSE.
      APPEND LINES OF lt_request_tmp TO lt_n1anf.
    ENDIF.
  ENDLOOP.
* MED-39493: END OF INSERT
  CHECK e_rc = 0.
  DESCRIBE TABLE lt_n1anf.
  IF sy-tfill = 0.
*   Bitte eine Anforderung markieren
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '430'
        i_last = space.
    e_rc      = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Erbringende Org.Einheit aus den markierten Einträgen ermitteln
  REFRESH lt_erboe.
  CALL METHOD cl_ishmed_functions=>get_erboes
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_erboe       = lt_erboe
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  DESCRIBE TABLE lt_erboe[].
  IF sy-tfill > 1.
*   Druck ist nur für Einträge mit gleicher OE möglich
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1BASE'
        i_num  = '046'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.

  SELECT SINGLE * FROM tn01 INTO l_tn01 WHERE einri EQ i_einri.

* Suchen User-Exit N1DR (ISHMED-DRUCKE)
  CALL FUNCTION 'ISH_USER_EXIT_GET'
    EXPORTING
      ss_event     = 'N1DR'
    IMPORTING
      ss_fbname    = l_uex_n1dr
    EXCEPTIONS
      no_user_exit = 01.
  IF sy-subrc NE 0.
    CLEAR l_uex_n1dr.
  ENDIF.

* Anforderungen abarbeiten ...
  LOOP AT lt_n1anf INTO l_n1anf.
    IF NOT l_uex_n1dr IS INITIAL.             "User-Exit N1DR
      l_prt_cnt = l_prt_cnt + 1.
      CALL FUNCTION l_uex_n1dr
        EXPORTING
          applk         = 'N'
          event         = 'ANF001'
          st_print      = l_std_print
          orgid         = l_n1anf-orgid
          einri         = l_n1anf-einri
          anfid         = l_n1anf-anfid
        IMPORTING
          l_print_error = l_print_error
        EXCEPTIONS
          OTHERS        = 1.
*     Fehler oder erfolgreich gedruckt ?
      IF l_print_error <> 0 OR sy-subrc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ELSE.
*     Ereignis ermitteln
      REFRESH lt_event_tab.
      CLEAR l_event_tab.
      l_event_tab-applk = l_evt_applk.
      l_event_tab-event = l_evt_request.
      APPEND l_event_tab TO lt_event_tab.
      l_prt_cnt = l_prt_cnt + 1.
      IF l_prt_cnt = 1.
*       Formularauswahl
        CALL FUNCTION 'ISH_FIND_FORMS'
          EXPORTING
            einri        = i_einri
            orgid        = l_n1anf-orgid
            st_print     = l_std_print
          IMPORTING
            abnormal_end = l_abbruch
          TABLES
            conditions   = lt_condition_tab
            events       = lt_event_tab
            forms        = lt_print_tab
          EXCEPTIONS
            OTHERS       = 4.
        IF sy-subrc <> 0.
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'S'
              i_kla  = sy-msgid
              i_num  = sy-msgno
              i_mv1  = sy-msgv1
              i_mv2  = sy-msgv2
              i_mv3  = sy-msgv3
              i_mv4  = sy-msgv4
              i_last = space.
          e_rc = 1.
          EXIT.
        ENDIF.
*       Abgebrochen
        IF l_abbruch <> off.
          e_rc = 2.
          EXIT.
        ENDIF.
      ENDIF.
*     Auswertung der Orgmittelarten
      LOOP AT lt_print_tab INTO l_print_tab.
        l_cancel = off.
        IF l_n1anf-falnr IS INITIAL.
*         Bei Anfo ohne Fall die Bewegungen nicht lesen
*         (da es keine gibt!)
          l_read_nbew = 'N'.
*         Auch keine Diagnosen und Falldaten lesen
          l_read_nfal = 'N'.
          l_read_ndia = 'J'.
*         Nur die PATNR der NFAL befüllen, da diese zum Lesen der
*         Patientendaten benötigt wird
          CLEAR l_nfal.
          l_nfal-falnr = '?x?x'.
          l_nfal-patnr = l_n1anf-patnr.
        ELSE.
*         Fallnummer der Anfo schon befüllt => Fall lesen
          SELECT SINGLE * FROM nfal INTO l_nfal
                          WHERE einri = l_n1anf-einri
                          AND   falnr = l_n1anf-falnr.
          l_read_nbew = 'J'.
          l_read_nfal = 'J'.
          l_read_ndia = 'J'.
        ENDIF.
        CALL FUNCTION 'ISHMED_PRINT_ANFO_EXPORT'
             EXPORTING
                  einri         = l_n1anf-einri
                  anfid         = l_n1anf-anfid
                  read_npat     = on         " Risikofaktoren
                  read_nbew     = l_read_nbew
*                  read_n1anf    = 'N'
                  read_nfal     = l_read_nfal
*                  read_text     = 'N'
*                  read_nlei     = 'N'
                  read_ndia     = l_read_ndia
*                  read_n1lsteam = 'N'
*                  read_n1bezy   = 'N'
                  i_nfal        = l_nfal
             IMPORTING
                  abbruch       = l_cancel.
        IF l_cancel = off.
*         Formulardruck
          CALL FUNCTION l_print_tab-fbform
            EXPORTING
              i_tn01      = l_tn01
              print_rnfor = l_print_tab
            IMPORTING
              abbruch     = l_cancel
              print_error = l_print_error.
        ENDIF.
*       Abbrechen?
        IF l_cancel = on.
          e_rc = 2.
          EXIT.
*       BEGIN MED-79070
        ELSE.
          MOVE-CORRESPONDING l_n1anf TO ls_event_data-n1anf.
          cl_ishmed_event_request=>raise_by_data( is_request_ev_data  = ls_event_data
                                                  i_evdefid           = cl_ishmed_evappl_request=>co_evdefid_printed
                                                  i_repid      = sy-repid ).
*       END BEGIN MED-79070
        ENDIF.
*       Fehler?
        IF l_print_error <> 0.
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.     " User-Exit Print
    CHECK e_rc = 0.
  ENDLOOP.   " LOOP AT LT_N1ANF INTO L_N1ANF

* Fehler oder erfolgreich gedruckt ?
  CASE e_rc.
    WHEN 0.
*     Druckauftrag ausgeführt
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'S'
          i_kla  = 'N1'
          i_num  = '561'
          i_last = space.
    WHEN 1.
*     Fehler beim Drucken
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1'
          i_num  = '562'
          i_last = space.
    WHEN 2.
*     Cancel
  ENDCASE.

ENDMETHOD.


METHOD call_risiko .

*  DATA: l_nbr_marked       TYPE i,
*        lt_nfal            TYPE ishmed_t_nfal,
*        l_nfal             LIKE LINE OF lt_nfal,
  DATA: lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        l_tcode            TYPE sy-tcode,
        l_einri_backup     TYPE tn01-einri,
        l_patnr_backup     TYPE npat-patnr,
        l_pziff_backup     TYPE npat-rfzif,
        l_fal_backup       TYPE nfal-falnr,
        l_pzfal_backup     TYPE nfal-fziff,
        l_tc_auth          TYPE c,
        l_name(50)         TYPE c.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* get instance of errorhandler if requested
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* only just one entry can be marked for this function
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierten (Vorläufigen) Patienten und Fall ermitteln
* get selected (provisional) patient (and case)
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* function not allowed for provisional patients
  CLEAR: l_npat, l_npap.
  READ TABLE lt_npat INTO l_npat INDEX 1.
  READ TABLE lt_npap INTO l_npap INDEX 1.
  IF l_npat-patnr IS INITIAL AND NOT l_npap-papid IS INITIAL.
    CLEAR l_name.
    PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                  l_npap-vorsw
                                                  l_npap-nname
                                                  l_npap-vname
                                                  l_name.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '617'
        i_mv1  = l_name
        i_mv2  = 'Funktion'(006)
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* set transaction code (display or edit)
  CASE i_fcode.
    WHEN 'RISU'.
      l_tcode = 'NP04'.         "Transactioncode for riskfactor edit
    WHEN 'RISD'.
      l_tcode = 'NP05'.         "Transactioncode for riskfactor display
    WHEN OTHERS.
      l_tcode = 'NP05'.         "Transactioncode for riskfactor display
  ENDCASE.

* preparation for calling the risk factor list
* using patient check digit
* first backup data in memory
  GET PARAMETER ID 'EIN' FIELD l_einri_backup.
  GET PARAMETER ID 'PAT' FIELD l_patnr_backup.
  GET PARAMETER ID 'PZP' FIELD l_pziff_backup.
  GET PARAMETER ID 'FAL' FIELD l_fal_backup.
  GET PARAMETER ID 'PZF' FIELD l_pzfal_backup.

* set data in memory
  SET PARAMETER ID 'EIN' FIELD i_einri.
  SET PARAMETER ID 'PAT' FIELD l_npat-patnr.
  SET PARAMETER ID 'PZP' FIELD l_npat-pziff.
* case is not used
  SET PARAMETER ID 'FAL' FIELD space.
  SET PARAMETER ID 'PZF' FIELD space.

* check authority for transaction code
  IF l_tcode = 'NP04'.
    PERFORM check_tcode_authority IN PROGRAM sapmnpa0
            USING 'NP04' i_einri l_tc_auth.
    IF l_tc_auth EQ false.
      l_tcode = 'NP05'.
    ENDIF.
  ENDIF.

* call transaction 'NP04'/'NP05' and skip first screen.
  PERFORM call_tcode IN PROGRAM sapmnpa0
          USING l_tcode i_einri on l_tc_auth.

* restore memory
  SET PARAMETER ID 'EIN' FIELD l_einri_backup.
  SET PARAMETER ID 'PAT' FIELD l_patnr_backup.
  SET PARAMETER ID 'PZP' FIELD l_pziff_backup.
  SET PARAMETER ID 'FAL' FIELD l_fal_backup.
  SET PARAMETER ID 'PZF' FIELD l_pzfal_backup.

* check authority
  IF l_tc_auth EQ false.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '238'
        i_last = space.
    e_rc      = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* no error messages, refresh line
  e_rc = 0.
  IF i_fcode = 'RISU'.
    e_refresh = 1.
  ELSE.
    e_refresh = 0.
  ENDIF.

ENDMETHOD.


METHOD call_service_cycle .

  DATA: lt_srv             TYPE ishmed_t_service_object,
        lr_srv             LIKE LINE OF lt_srv,
        lt_lnrls           TYPE TABLE OF rn1lnrls,
        ls_lnrls           LIKE LINE OF lt_lnrls,
        lt_n1bezy          TYPE TABLE OF n1bezy,
        ls_n1bezy          LIKE LINE OF lt_n1bezy,
        lt_vnlei           TYPE TABLE OF vnlei,
        ls_vnlei           LIKE LINE OF lt_vnlei,
        lt_nlei            TYPE TABLE OF nlei,
        ls_nlei            LIKE LINE OF lt_nlei,
        ls_nlei_new        TYPE nlei,
        lt_nlem            TYPE TABLE OF nlem,
        ls_nlem            LIKE LINE OF lt_nlem,
*        lt_npat            TYPE ishmed_t_npat,
*        ls_npat            LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        ls_npap            LIKE LINE OF lt_npap,
        lt_nfal            TYPE ishmed_t_nfal,
        ls_nfal            LIKE LINE OF lt_nfal,
        lt_expvalues       LIKE et_expvalues,
        ls_expvalues       LIKE LINE OF lt_expvalues,
        l_parameter        LIKE LINE OF it_parameter,
        lt_erboe           TYPE ishmed_t_orgid,
        l_erboe            LIKE LINE OF lt_erboe,
        l_orgid            TYPE norg-orgid,
        l_name(50)         TYPE c,
        l_function(40)     TYPE c,
        l_kz_med(1)        TYPE c,
        l_kz_pfl(1)        TYPE c,
        l_zyklus_end       TYPE rnt61-mark,
        l_vcode            TYPE tndym-vcode.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_vcode, l_parameter, l_function, ls_npap, ls_nfal, " ls_npat,
         l_kz_med, l_kz_pfl, l_zyklus_end.

  REFRESH: lt_vnlei, lt_nlei, lt_nlem, lt_srv, lt_erboe,
           lt_nfal, lt_npap, lt_lnrls, lt_expvalues.         " lt_npat.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* at lease 1 entry has to be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                                  " genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* set vcode
  CASE i_fcode.
    WHEN 'CYCINS'.
      l_vcode    = 'INS'.
      l_function = 'Zyklus anlegen'(002).
    WHEN 'CYCDIS'.
      l_vcode    = 'DIS'.
      l_function = 'Zyklus anzeigen'(003).
    WHEN 'CYCUPD'.
      l_vcode    = 'UPD'.
      l_function = 'Zyklus ändern'(004).
    WHEN 'CYCEND'.
      l_vcode    = 'END'.
      l_function = 'Zyklus beenden'(011).
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* get org.unit
  CLEAR l_orgid.
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '016'.
  IF sy-subrc = 0.
    l_orgid = l_parameter-value(8).
  ENDIF.

* get org.unit
  IF l_orgid IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_erboes
      EXPORTING
        it_objects     = it_objects
      IMPORTING
        e_rc           = e_rc
        et_erboe       = lt_erboe
      CHANGING
        c_errorhandler = c_errorhandler.
    CHECK e_rc = 0.
    READ TABLE lt_erboe INTO l_erboe INDEX 1.
    IF sy-subrc = 0.
      l_orgid = l_erboe.
    ENDIF.
  ENDIF.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* check if services have been marked
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_services    = lt_srv
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  IF lt_srv[] IS INITIAL.
*   Funktion & ist nur für Leistungen verfügbar.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '167'
        i_mv1  = l_function
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* get marked (provisional) patients and cases
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
*      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
*  READ TABLE lt_npat INTO ls_npat INDEX 1.
  READ TABLE lt_nfal INTO ls_nfal INDEX 1.
* Vorläufige Patienten markiert?
  DESCRIBE TABLE lt_npap.
  IF sy-tfill > 0.
*   Funktionen für voläufige Patienten nicht möglich
    LOOP AT lt_npap INTO ls_npap.
      CLEAR l_name.
      PERFORM concat_name IN PROGRAM sapmnpa0 USING ls_npap-titel
                                                    ls_npap-vorsw
                                                    ls_npap-nname
                                                    ls_npap-vname
                                                    l_name.
*     Patient noch nicht aufgenommen - Funktion nicht möglich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '617'
          i_mv1  = l_name
          i_mv2  = l_function
          i_last = space.
    ENDLOOP.
    e_rc      = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* get service data for function call
  LOOP AT lt_srv INTO lr_srv.
    CLEAR: ls_nlem, ls_nlei, ls_vnlei.
    CALL METHOD lr_srv->get_data
      IMPORTING
        e_rc           = e_rc
        e_nlei         = ls_nlei
        e_nlem         = ls_nlem
      CHANGING
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    ls_vnlei = ls_nlei.
    APPEND ls_vnlei TO lt_vnlei.
    APPEND ls_nlei  TO lt_nlei.
    APPEND ls_nlem  TO lt_nlem.
  ENDLOOP.
  CHECK e_rc = 0.

* get flags for cycles
  READ TABLE lt_nlem INTO ls_nlem WITH KEY n1medlei = 'X'.
  IF sy-subrc = 0.
    l_kz_med = 'X'.
  ENDIF.
  READ TABLE lt_nlem INTO ls_nlem WITH KEY n1pfllei = 'X'.
  IF sy-subrc = 0.
    l_kz_pfl = 'X'.
  ENDIF.
*
* cycles not allowed for services of clinical orders (ID 14200)
  LOOP AT lt_nlem INTO ls_nlem WHERE NOT vkgid IS INITIAL.
*   Funktion nur für angeforderte Leistungen möglich
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NFCL'
        i_num  = '285'
        i_last = space.
    e_rc      = 1.
    e_refresh = 0.
    EXIT.
  ENDLOOP.
  CHECK e_rc = 0.

* only 1 service can be marked
  READ TABLE lt_nlei INTO ls_nlei INDEX 1.
  CHECK sy-subrc = 0.

* Falls kein Fall vorhanden ist -> Fallbezug herstellen
  IF ls_nlei-falnr IS INITIAL.
    CALL METHOD cl_ishmed_functions=>call_case_assign
      EXPORTING
        i_fcode        = 'CASE_ASS'
        i_einri        = i_einri
        i_caller       = i_caller
*        I_SAVE         = 'X'
*        I_COMMIT       = 'X'
        i_enqueue      = i_enqueue
*        I_DEQUEUE      = 'X'
        it_objects     = it_objects
*        IT_PARAMETER   =
      IMPORTING
        e_rc           = e_rc
        et_expvalues   = lt_expvalues
      CHANGING
        c_errorhandler = c_errorhandler
        c_environment  = c_environment
        c_lock         = c_lock.
    CHECK e_rc = 0.
*   get new service data!
    LOOP AT lt_expvalues INTO ls_expvalues WHERE type = '004'.
      ls_lnrls = ls_expvalues-value.                        "#EC ENHOK
      APPEND ls_lnrls TO lt_lnrls.
    ENDLOOP.
    LOOP AT lt_nlei INTO ls_nlei.
      READ TABLE lt_lnrls INTO ls_lnrls
                          WITH KEY lnrls1 = ls_nlei-lnrls.
      CHECK sy-subrc = 0.
      SELECT SINGLE * FROM nlei INTO ls_nlei_new
                                WHERE lnrls = ls_lnrls-lnrls2. "#EC *
      CHECK sy-subrc = 0.
      DELETE lt_vnlei WHERE lnrls = ls_nlei-lnrls.
      ls_vnlei = ls_nlei_new.
      APPEND ls_vnlei TO lt_vnlei.
      DELETE lt_nlei.
      APPEND ls_nlei_new TO lt_nlei.
    ENDLOOP.
  ENDIF.

* set cycle data
  LOOP AT lt_nlei INTO ls_nlei.
    MOVE-CORRESPONDING ls_nlei TO ls_n1bezy.                 "#EC ENHOK
    ls_n1bezy-n1begdt = ls_nlei-ibgdt.
    ls_n1bezy-n1begzt = ls_nlei-ibzt.
    ls_n1bezy-n1enddt = ls_nlei-iendt.
    ls_n1bezy-n1endzt = ls_nlei-iezt.
    ls_n1bezy-n1menge = ls_nlei-imeng.
    APPEND ls_n1bezy TO lt_n1bezy.
  ENDLOOP.

* only 1 service can be marked
  READ TABLE lt_nlei INTO ls_nlei INDEX 1.
  CHECK sy-subrc = 0.

* call function now
  CASE l_vcode.

    WHEN 'INS' OR 'DIS' OR 'UPD'.     " cycle insert/display/change

      IF l_vcode = 'UPD'.
        IF ls_nlei-storn = on.
*         In dem Fall das der Zyklus storniert ist, soll er
*         angezeigt werden, aber nicht geändert werden können.
          l_vcode = 'DIS'.
        ENDIF.
      ENDIF.

      CALL FUNCTION 'ISHMED_ZYKLUS_PFLEGE'
        EXPORTING
          i_zyklus         = 'L'           "Zyklus mit NLEI-Bezug
          i_skip_first     = on
          i_vcode          = l_vcode
          i_kzmed          = l_kz_med
          i_kzpfl          = l_kz_pfl
          i_orgid          = l_orgid
        TABLES
          t_n1bezy         = lt_n1bezy
          t_nlei           = lt_nlei
        EXCEPTIONS
          invalid_i_zyklus = 1
          found            = 2
          not_found        = 3
          data_notfound    = 4
          state_ins        = 5
          OTHERS           = 6.
      CASE sy-subrc.
        WHEN 0.
*         NO error
          e_rc      = 0.
          e_refresh = 1.
        WHEN 2.
*         Zyklus bereits vorhanden (cycle already found)
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NF'
              i_num  = '515'
              i_last = space.
          e_rc = 1.
          e_refresh = 0.
        WHEN 5.
          CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
            CHANGING
              cr_errorhandler = c_errorhandler.
          e_rc = 1.
          e_refresh = 0.
        WHEN OTHERS.
*         Zyklus nicht vorhanden (cycle not found)
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NF'
              i_num  = '516'
              i_last = space.
          e_rc = 1.
          e_refresh = 0.
      ENDCASE.

    WHEN 'END'.                        " cycle close

*     COMMIT erfolgt bereits im Funktionsbaustein, da dies eine
*     in sich geschlossene Aktion darstellt
      CALL FUNCTION 'ISHMED_ZYKLUS_BEENDEN'
        EXPORTING
          ss_einri          = i_einri
          ss_erboe          = l_orgid
          ss_gtarif         = ls_nlei-haust
          ss_n1zotyp        = ls_nlei-zotyp
          ss_nfal           = ls_nfal
          ss_quit_close_bew = 'X'
        IMPORTING
          e_zyklus_end      = l_zyklus_end
        TABLES
          t_vnlei           = lt_vnlei
        EXCEPTIONS
          ishmed_not_activ  = 1
          no_zyklus_found   = 2
          popup_canceled    = 3
          zyklus_canceled   = 4
          OTHERS            = 5.
      CASE sy-subrc.
        WHEN 0.
*         NO error (Leistungen quittiert bzw. storniert)
          CASE l_zyklus_end.
            WHEN true.   " Zyklus konnte auch beendet werden
              e_rc      = 0.
              e_refresh = 1.
            WHEN OTHERS. " Zyklus konnte nicht beendet werden
*             Der Zyklus zu den markierten Lst. konnte nicht & werden.
              CALL METHOD c_errorhandler->collect_messages
                EXPORTING
                  i_typ  = 'E'
                  i_kla  = 'NF'
                  i_num  = '523'
                  i_mv1  = 'beendet'(012)
                  i_last = space.
              e_rc = 1.
              e_refresh = 0.
          ENDCASE.
        WHEN 1.
*         no authority for IS-H*MED
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NF'
              i_num  = '100'
              i_last = space.
          e_rc = 1.
          e_refresh = 0.
        WHEN 2.
*         no cycle found
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NF'
              i_num  = '100'
              i_last = space.
          e_rc = 1.
          e_refresh = 0.
        WHEN 3.
*         Cancel
*         Leistungen quittiert bzw. storniert => allerdings Popup
*         abgebrochen => somit kein COMMIT, wodurch Quittierung bzw.
*         Stornierung wieder zurückgesetzt wird
          e_rc = 2.
          e_refresh = 0.
        WHEN 4.
*         cycle already closed
*         Funktion "Zyklus beenden" ist für beendete Zyklen
*         nicht mehr ausführbar
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NF1'
              i_num  = '855'
              i_last = space.
          e_rc = 1.
          e_refresh = 0.
        WHEN OTHERS.
*         Der Zyklus zu den markierten Lst. konnte nicht & werden.
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ  = 'E'
              i_kla  = 'NF'
              i_num  = '523'
              i_mv1  = 'beendet'(012)
              i_last = space.
          e_rc = 1.
          e_refresh = 0.
      ENDCASE.

    WHEN OTHERS.
      EXIT.

  ENDCASE.

ENDMETHOD.


METHOD call_service_quit .

  DATA: lt_srv             TYPE ishmed_t_service_object,
        lr_srv             LIKE LINE OF lt_srv,
        lt_error           TYPE ishmed_t_bapiret2,
        ls_error           LIKE LINE OF lt_error,
        lt_vnlei           TYPE TABLE OF vnlei,
        ls_vnlei           LIKE LINE OF lt_vnlei,
        ls_nlei            TYPE nlei,
        l_parameter        LIKE LINE OF it_parameter,
        l_close_bew        TYPE ish_on_off,
        l_popup            TYPE ish_on_off,
        l_no_popup         TYPE ish_on_off,
        l_ret_fcode(4)     TYPE c,
        l_action(1)        TYPE c.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_action, l_parameter, l_close_bew, l_ret_fcode.

  REFRESH: lt_error, lt_vnlei, lt_srv.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* at lease 1 entry has to be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* ERBR or QUIT
  IF i_fcode = 'SERV_ERBR'.
    l_action = 'E'.                                    " Erbringen
  ELSE.                   " (i_fcode = 'SERV_QUIT')
    l_action = 'F'.                                    " Freigeben
  ENDIF.

* close movement? (DEFAULT = on)
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '029'.
  IF sy-subrc = 0.
    l_close_bew = l_parameter-value(1).
  ELSE.
    l_close_bew = on.
  ENDIF.

* show popup? (DEFAULT = on)
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '030'.
  IF sy-subrc = 0.
    l_popup = l_parameter-value(1).
  ELSE.
    l_popup = on.
  ENDIF.
  IF l_popup = on.
    l_no_popup = off.
  ELSEIF l_popup = off.
    l_no_popup = on.
  ELSE.
    l_no_popup = l_popup.     " = 'Z'
  ENDIF.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* check if services have been marked
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_services    = lt_srv
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
  IF lt_srv[] IS INITIAL.
*   Funktion & ist nur für Leistungen verfügbar.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '167'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* collect services for function call
  LOOP AT lt_srv INTO lr_srv.
    CLEAR: ls_nlei, ls_vnlei.
    CALL METHOD lr_srv->get_data
      IMPORTING
        e_rc           = e_rc
        e_nlei         = ls_nlei
      CHANGING
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    ls_vnlei = ls_nlei.
    APPEND ls_vnlei TO lt_vnlei.
*   BEGIN BM MED-32632
    IF NOT ls_nlei-falnr IS INITIAL.
      CALL FUNCTION 'ISH_CASE_POOL_REFRESH'
        EXPORTING
          ss_falnr = ls_nlei-falnr
          ss_einri = i_einri.

      CALL FUNCTION 'ISH_POOL_REFRESH_FALNR'
        EXPORTING
          ss_falnr = ls_nlei-falnr
          ss_einri = i_einri.
    ENDIF.
*   END BM MED-32632
  ENDLOOP.
  CHECK e_rc = 0.

* call function now
  CALL FUNCTION 'ISHMED_CALL_QUIT_SERVICE'
    EXPORTING
      i_action       = l_action
      i_einri        = i_einri
*     I_GDATUM       = SY-DATUM
*     I_ORGID        = ' '
*     I_TITLE        = ' '
      i_close_bew    = l_close_bew
*     I_STAT_ANFO    = 'X'
*     I_GPART        = ' '
      i_no_popup     = l_no_popup
      i_lock_tab     = i_enqueue
      i_error        = on
      ir_environment = c_environment
    IMPORTING
      e_fcode        = l_ret_fcode
      e_error        = lt_error
    TABLES
      t_nlei         = lt_vnlei
    EXCEPTIONS
      fall_locked    = 1
      other_error    = 2
      read_error     = 3
      save_error     = 4
      sys_error      = 5
      OTHERS         = 6.

  CASE sy-subrc.
    WHEN 0.
*     NO error
      IF l_ret_fcode = 'CAN' OR l_ret_fcode = 'END'.
        e_rc = 2.                          " cancel
        e_refresh = 0.
      ELSE.
        e_rc = 0.
        e_refresh = 1.
      ENDIF.
    WHEN 1.
*     case is locked
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '658'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
    WHEN OTHERS.
*     other error
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '139'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

  IF NOT lt_error[] IS INITIAL.
    LOOP AT lt_error INTO ls_error.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_bapiret
        EXPORTING
          i_bapiret       = ls_error
        CHANGING
          cr_errorhandler = c_errorhandler.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD call_snse .
  CONSTANTS co_snse1      TYPE n1fcode VALUE 'N1SNSE1'. "Netzakte
  CONSTANTS co_snse2      TYPE n1fcode VALUE 'N1SNSE2'. "Zustimmungserklärung
  CONSTANTS co_snse3      TYPE n1fcode VALUE 'N1SNSE3'. "Teilnahmeerklärung
  CONSTANTS co_consumer   TYPE n1snse_application VALUE 'CONSUMER'. "Netzakte
  CONSTANTS co_consent    TYPE n1snse_application VALUE 'CONSENT'. "Zust.
  CONSTANTS co_participat	TYPE n1snse_application VALUE 'PARTICIPAT'. "Teiln.

  DATA:
    lt_nfal TYPE         ishmed_t_nfal,
    ls_nfal LIKE LINE OF lt_nfal,
    lt_npat TYPE         ishmed_t_npat,
    ls_npat LIKE LINE OF lt_npat,
    lt_npap TYPE         ishmed_t_npap,
    ls_npap LIKE LINE OF lt_npap.
  DATA l_appl  TYPE n1snse_application.
  DATA lx_message TYPE REF TO cx_ishmed_snse.
  DATA lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

* initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  REFRESH: lt_npat, lt_npap, lt_nfal.

* errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* just 1 entry has to be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                                  " genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierten (Vorläufigen) Patienten (und Fall) ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
      i_read_db      = abap_true
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Funktion für vorläufige Patienten oder ohne Patient/Fall nicht möglich
  CLEAR: ls_npat, ls_npap, ls_nfal.
  READ TABLE lt_npat INTO ls_npat INDEX 1.
  READ TABLE lt_npap INTO ls_npap INDEX 1.
  READ TABLE lt_nfal INTO ls_nfal INDEX 1.
  IF ls_npat-patnr IS INITIAL AND ls_npap-papid IS NOT INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '763'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
  IF ls_npat-patnr IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '131'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
  IF ls_nfal-falnr IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1SRVDO_MED'
        i_num  = '018'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.
* Now start application
  CASE i_fcode.
    WHEN co_snse1.
      l_appl  = co_consumer.
    WHEN co_snse2.
      l_appl = co_consent.
    WHEN co_snse3.
      l_appl = co_participat.
  ENDCASE.

  TRY.
      CALL FUNCTION 'ISHMED_SNSE_APPL_START'
        EXPORTING
          i_institution = i_einri
          i_patient_id  = ls_npat-patnr
          i_case_id     = ls_nfal-falnr
          i_application = l_appl.

    CATCH cx_ishmed_snse_appl INTO lx_message.
      e_rc = 1.
      e_refresh = 0.
      lx_message->get_errorhandler(
         IMPORTING
           er_errorhandler  = c_errorhandler
             ).
  ENDTRY.

ENDMETHOD.


METHOD call_surg_sel_ws .

* Hoebarth MED-38433 method created

  DATA: lt_a_srv           TYPE ishmed_t_service_object,
        lt_nbew            TYPE ishmed_t_nbew,
        ls_nbew            TYPE nbew,
        lt_nfal            TYPE ishmed_t_nfal,
        ls_nfal            TYPE nfal,
        lt_npat            TYPE ishmed_t_npat,
        ls_npat            TYPE npat,
        ls_patient_id      TYPE rn2dwswl_ws_assign_patient,
        lt_patient_id      TYPE ishmed_t_n2dwswl_ws_assign_pat,
        l_planoe           TYPE orgid,
        ls_parameter       TYPE rn1parameter,
*        l_orgpf            TYPE orgid,
*        l_orgfa            TYPE orgid,
*        ls_norg            TYPE norg,
        l_rc               TYPE ish_method_rc.

* Initialization
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* check switch
  CHECK cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.

* Errorhandling
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* At least 1 entry has to be marked
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Get environment
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Get anchor service(s)
  REFRESH: lt_a_srv.
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects         = it_objects
      i_conn_srv         = on
      i_only_main_anchor = on
*     i_no_sort_change   = off
    IMPORTING
      e_rc               = e_rc
      et_anchor_services = lt_a_srv
    CHANGING
      c_environment      = c_environment
      c_errorhandler     = c_errorhandler.
  CHECK e_rc = 0.

  IF lt_a_srv[] IS INITIAL.
*   Funktion ist nicht möglich; markieren Sie zumindest eine Operation
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '188'
        i_last = space.
    e_rc = 1.
    EXIT.
  ENDIF.

  CALL METHOD get_apps_and_movs
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      et_nbew        = lt_nbew
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

  CALL METHOD get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      et_npat        = lt_npat
      et_nfal        = lt_nfal
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* get planning ou from parameter table (MED-41209)
  CLEAR l_planoe.
  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
  IF sy-subrc = 0.
    l_planoe = ls_parameter-value.
  ENDIF.

  LOOP AT lt_nbew INTO ls_nbew.
    READ TABLE lt_nfal INTO ls_nfal WITH KEY falnr = ls_nbew-falnr.
    CHECK sy-subrc = 0.
    CLEAR ls_patient_id.
    ls_patient_id-patient_id = ls_nfal-patnr.
    ls_patient_id-case_id    = ls_nfal-falnr.
    ls_patient_id-lfdbw      = ls_nbew-lfdnr.
    INSERT ls_patient_id INTO TABLE lt_patient_id.
  ENDLOOP.

  LOOP AT lt_nfal INTO ls_nfal.
    CLEAR ls_patient_id.
    READ TABLE lt_patient_id WITH KEY patient_id = ls_nfal-patnr case_id = ls_nfal-falnr TRANSPORTING NO FIELDS.
    CHECK sy-subrc <> 0.
    ls_patient_id-patient_id = ls_nfal-patnr.
    ls_patient_id-case_id    = ls_nfal-falnr.
    INSERT ls_patient_id INTO TABLE lt_patient_id.
  ENDLOOP.

  LOOP AT lt_npat INTO ls_npat.
    CLEAR ls_patient_id.
    READ TABLE lt_patient_id WITH KEY patient_id = ls_npat-patnr TRANSPORTING NO FIELDS.
    CHECK sy-subrc <> 0.
    ls_patient_id-patient_id  = ls_npat-patnr.
    INSERT ls_patient_id INTO TABLE lt_patient_id.
  ENDLOOP.

* get OUs
*  READ TABLE it_parameter INTO ls_parameter WITH KEY type = '005'.
*  l_orgpf = ls_parameter-value.
*  CALL FUNCTION 'ISHMED_READ_ORGFA'
*    EXPORTING
*      i_einri     = i_einri
*      i_orgid     = l_orgpf
*    IMPORTING
*      e_orgfa     = ls_norg.
*  l_orgfa = ls_norg-orgid.

  CALL METHOD cl_ishmed_utl_op=>call_surg_sel_ws
    EXPORTING
      i_einri         = i_einri
      it_patient_id   = lt_patient_id
      it_service      = lt_a_srv
      i_planoe        = l_planoe                         " MED-41209
*     i_orgfa         = l_orgfa
*     i_orgpf         = l_orgpf
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

  e_refresh = 2.   "MED-53970 Madalina P.

ENDMETHOD.


METHOD call_team_update .

  DATA: l_parameter        LIKE LINE OF it_parameter,
        l_team_stat        TYPE ish_on_off,
        l_vcode            TYPE ish_vcode,
        l_title            TYPE sy-title,
        l_ablh             TYPE ish_on_off,
        l_involv_ma        TYPE ish_on_off,
        l_pre_alloc        TYPE ish_on_off,
        l_not_for_op       TYPE ish_on_off,
        l_cancel           TYPE ish_on_off,
        l_state_int        TYPE n1lssta_d,
        l_state_ext        TYPE n1lsstae,
        l_date             TYPE sy-datum,
        l_n1qutime         TYPE tn00q-value,
        l_canc_team_dsp    TYPE ish_on_off,
        ls_n1lsstt         TYPE n1lsstt,
        ls_nlei            TYPE nlei,
        lt_n1lsstz         TYPE ishmed_t_vn1lsstz,
        ls_n1lsstz         LIKE LINE OF lt_n1lsstz,
        lt_process         TYPE ishmed_t_vorgang,
        l_process          LIKE LINE OF lt_process,
        lt_services        TYPE ishmed_t_service_object,
        lt_srv             TYPE ishmed_t_service_object,
        lr_srv             LIKE LINE OF lt_srv,
        lt_anchor_srv      TYPE ishmed_t_service_object,
        l_anchor_srv       LIKE LINE OF lt_anchor_srv,
        l_anchor_srv_temp  LIKE LINE OF lt_anchor_srv,
        lr_prc_team        TYPE REF TO cl_ishmed_prc_team.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_team_stat, l_vcode, l_cancel, l_canc_team_dsp.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es muß mind. 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Standardwerte für die Berücksichtigung der OE-Beteiligung bzw.
* Ablauforganisatorischen Hierarchie bei der Mitarbeiterauswahl
* und der Vorbelegung der Aufgabenzuordnung sowie dem Kennzeichen,
* ob die Teamerfassung nur für OP-Ankerleistungen oder nur für
* 'normale Leistungen' aufrufbar sein soll
  l_involv_ma  = on.
  l_ablh       = '*'.
  l_pre_alloc  = on.
  l_not_for_op = off.

* Titel ermitteln
  CLEAR l_title.
  LOOP AT it_parameter INTO l_parameter WHERE type = '007'.
    l_title = l_parameter-value.
    EXIT.
  ENDLOOP.

* Aufgaben ermitteln
  REFRESH: lt_process.
  LOOP AT it_parameter INTO l_parameter WHERE type = '010'.
    CHECK NOT l_parameter-value IS INITIAL.
    l_process = l_parameter-value.
    APPEND l_process TO lt_process.
  ENDLOOP.

* OE-Beteiligung bei Mitarbeiterauswahl berücksichtigen?
  LOOP AT it_parameter INTO l_parameter WHERE type = '024'.
    l_involv_ma = l_parameter-value.
    EXIT.
  ENDLOOP.

* Ablauforganisat. Hierarchie bei Mitarbeiterauswahl berücksichtigen?
  LOOP AT it_parameter INTO l_parameter WHERE type = '025'.
    l_ablh = l_parameter-value.
    EXIT.
  ENDLOOP.

* Team mit Aufgabenvorschlag vorbelegen
  LOOP AT it_parameter INTO l_parameter WHERE type = '026'.
    l_pre_alloc = l_parameter-value.
    EXIT.
  ENDLOOP.

* Kennzeichen, ob die Teamerfassung nur für OP-Ankerleistungen
* oder nur für 'normale Leistungen' aufrufbar sein soll
  LOOP AT it_parameter INTO l_parameter WHERE type = '027'.
    l_not_for_op = l_parameter-value.
    EXIT.
  ENDLOOP.

  REFRESH: lt_anchor_srv, lt_srv, lt_services.

* Teamerfassung für den OP-Bereich oder für normale Leistungen
  IF l_not_for_op = off.
*   Markierte Ankerleistung(en) ermitteln
    CALL METHOD cl_ishmed_functions=>get_services
      EXPORTING
        it_objects         = it_objects
        i_conn_srv         = on
        i_no_sort_change   = on           " do not change sorting!
      IMPORTING
        e_rc               = e_rc
        et_anchor_services = lt_anchor_srv
      CHANGING
        c_environment      = c_environment
        c_errorhandler     = c_errorhandler.
    CHECK e_rc = 0.
*   Haupt-OP-Ankerleistung bzw. Leistung muß vorhanden sein
    CLEAR: l_anchor_srv.
    READ TABLE lt_anchor_srv INTO l_anchor_srv INDEX 1.
    IF sy-subrc <> 0.
*     Funktion nur für Operationen verfügbar
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '790'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
*   Prüfen, ob die OP begonnen ist, um den 'Team-Status' zu bestimmen
*   (OP-Team soll im Status der OP gesichert werden)
    IF cl_ishmed_utl_op=>check_is_op_beg( l_anchor_srv ) = on.
      l_team_stat = off.                " status IST
    ELSE.
      l_team_stat = on.                 " status PLAN
    ENDIF.
*   Alle Ankerleistungen übergeben
    lt_services[] = lt_anchor_srv[].
  ELSEIF l_not_for_op = on.
*   Markierte Leistung(en) ermitteln
    CALL METHOD cl_ishmed_functions=>get_services
      EXPORTING
        it_objects       = it_objects
        i_conn_srv       = on
        i_no_sort_change = on           " do not change sorting!
      IMPORTING
        e_rc             = e_rc
        et_services      = lt_srv
      CHANGING
        c_environment    = c_environment
        c_errorhandler   = c_errorhandler.
    CHECK e_rc = 0.
    IF lt_srv[] IS INITIAL.
*     Funktion nur für Leistungen möglich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1BASE_MED'
          i_num  = '025'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
*   Team-Status festlegen
    l_team_stat = off.                " status IST
*   Alle Leistungen übergeben
    lt_services[] = lt_srv[].
  ELSE.
*   Markierte Ankerleistung(en) und Leistung(en) ermitteln
    CALL METHOD cl_ishmed_functions=>get_services
      EXPORTING
        it_objects         = it_objects
        i_conn_srv         = on
        i_no_sort_change   = on           " do not change sorting!
      IMPORTING
        e_rc               = e_rc
        et_anchor_services = lt_anchor_srv
        et_services        = lt_srv
      CHANGING
        c_environment      = c_environment
        c_errorhandler     = c_errorhandler.
    CHECK e_rc = 0.
*   Haupt-OP-Ankerleistung bzw. Leistung muß vorhanden sein
    IF lt_anchor_srv[] IS INITIAL AND lt_srv[] IS INITIAL.
*     Funktion nur für Leistungen möglich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1BASE_MED'
          i_num  = '025'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
*   Prüfen, ob die OP begonnen ist, um den 'Team-Status' zu bestimmen
*   (OP-Team soll im Status der OP gesichert werden)
    CLEAR: l_anchor_srv.
    READ TABLE lt_anchor_srv INTO l_anchor_srv INDEX 1.
    IF sy-subrc = 0.
      IF cl_ishmed_utl_op=>check_is_op_beg( l_anchor_srv ) = on.
        l_team_stat = off.                " status IST
      ELSE.
        l_team_stat = on.                 " status PLAN
      ENDIF.
    ELSE.
      l_team_stat = off.                  " status IST
    ENDIF.
    APPEND LINES OF lt_anchor_srv TO lt_services.
*   Alle (OP-Anker-)Leistungen übergeben (aber keine OP-Leistungen)
    LOOP AT lt_srv INTO lr_srv.
*     Haupt-OP-Ankerleistung zur Leistung suchen
      CLEAR: l_anchor_srv.
      CALL METHOD cl_ishmed_service=>get_op_main_anchor_srv
        EXPORTING
          i_service        = lr_srv
          i_environment    = c_environment
        IMPORTING
          e_rc             = e_rc
          e_anchor_service = l_anchor_srv
        CHANGING
          c_errorhandler   = c_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      CHECK l_anchor_srv IS BOUND.
      DELETE lt_srv.
      LOOP AT lt_services INTO l_anchor_srv_temp.
        CHECK l_anchor_srv_temp = l_anchor_srv.
        CLEAR l_anchor_srv.
        EXIT.
      ENDLOOP.
      CHECK l_anchor_srv IS BOUND.
      APPEND l_anchor_srv TO lt_services.
    ENDLOOP.
    APPEND LINES OF lt_srv TO lt_services.
    IF e_rc <> 0.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* Verarbeitungsmodus
  CASE i_fcode.
    WHEN 'TEAM'.
      l_vcode = 'UPD'.                " update
    WHEN 'TEAM_DIS'.
      l_vcode = 'DIS'.                " display
    WHEN OTHERS.
      l_vcode = 'DIS'.                " display
  ENDCASE.

* ID 19454: check released services (if update is allowed)
  IF l_vcode <> 'DIS'.
    LOOP AT lt_services INTO lr_srv.
      CALL METHOD lr_srv->get_service_state
        IMPORTING
          e_rc           = e_rc
          e_state_intern = l_state_int
          e_state_extern = l_state_ext
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
      IF l_state_int = 'QU'.
        CALL FUNCTION 'ISH_TN00R_READ'
          EXPORTING
            ss_einri  = i_einri
            ss_param  = 'N1QUTIME'
          IMPORTING
            ss_value  = l_n1qutime
          EXCEPTIONS
            not_found = 1
            OTHERS    = 2.
        IF sy-subrc <> 0 OR NOT l_n1qutime CO '0123456789'.
          l_n1qutime = 0.
        ENDIF.
        IF l_n1qutime = 0.
          l_vcode = 'DIS'.
          SELECT SINGLE * FROM n1lsstt INTO ls_n1lsstt
                 WHERE  spras   = sy-langu
                 AND    einri   = i_einri
                 AND    lsstae  = l_state_ext.
          IF sy-subrc <> 0.
            ls_n1lsstt-lssttxt = l_state_ext.
          ENDIF.
          MESSAGE s033(n1srvdo_med) WITH ls_n1lsstt-lssttxt.
*         Leist. im Status & können mit dieser Fkt. nicht bearb. w.
          EXIT.
        ENDIF.
        CALL METHOD lr_srv->get_data
          IMPORTING
            e_rc           = e_rc
            et_n1lsstz     = lt_n1lsstz
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
        DELETE lt_n1lsstz WHERE lsstae <> l_state_ext.
        SORT lt_n1lsstz DESCENDING BY erdat ertim.
        READ TABLE lt_n1lsstz INTO ls_n1lsstz INDEX 1.
        CHECK sy-subrc = 0.
        l_date = ls_n1lsstz-erdat + l_n1qutime - 1.
        IF l_date < sy-datum.
          l_vcode = 'DIS'.
          SELECT SINGLE * FROM n1lsstt INTO ls_n1lsstt
                 WHERE  spras   = sy-langu
                 AND    einri   = i_einri
                 AND    lsstae  = l_state_ext.
          IF sy-subrc <> 0.
            ls_n1lsstt-lssttxt = l_state_ext.
          ENDIF.
          MESSAGE s033(n1srvdo_med) WITH ls_n1lsstt-lssttxt.
*         Leist. im Status & können mit dieser Fkt. nicht bearb. w.
          EXIT.
        ENDIF.
      ELSEIF l_state_int = 'ST'.
        CALL METHOD lr_srv->get_data
          IMPORTING
            e_rc           = e_rc
            e_nlei         = ls_nlei
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc <> 0.
          EXIT.
        ENDIF.
        l_vcode = 'DIS'.
        l_canc_team_dsp = on.
        MESSAGE s673(nf1) WITH ls_nlei-leist.
*       Leistung & ist bereits storniert
        EXIT.
      ENDIF.
    ENDLOOP.
    CHECK e_rc = 0.
  ENDIF.

* Teamplanung aufrufen
  CALL METHOD cl_ishmed_prc_team=>create
    IMPORTING
      er_instance     = lr_prc_team
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

  CALL METHOD lr_prc_team->plan_team
    EXPORTING
      i_dialog_mode           = 'P'
      it_services             = lt_services
      it_tasks_restr          = lt_process
      ir_environment          = c_environment
      i_institution           = i_einri
      i_vcode                 = l_vcode
*     I_SHOW_PARTNER          = ON
*     I_SHOW_TASK             = ON
      i_show_canc_team_in_dsp = l_canc_team_dsp             " ID 19454
      i_team_status           = l_team_stat
      i_pre_alloc             = l_pre_alloc
      i_title                 = l_title
      i_involv_ma             = l_involv_ma
      i_ablh                  = l_ablh
      i_save                  = i_save
      i_commit                = i_commit
      i_caller                = i_caller
      i_enqueue               = i_enqueue
      i_dequeue               = i_dequeue
    IMPORTING
      e_rc                    = e_rc
      e_cancel                = l_cancel
    CHANGING
      cr_errorhandler         = c_errorhandler
      cr_lock                 = c_lock.
*      CR_CANCEL               =

  CASE e_rc.
    WHEN 0.
      IF l_cancel = off.
*       Everything OK
        e_rc = 0.
        IF l_vcode = 'UPD'.
          e_refresh = 1.
        ENDIF.
      ELSE.
*       Cancel
        e_rc = 2.
*        e_refresh = 0.  "MED-55854 NedaV
         e_refresh = 1.  "MED-55854 NedaV - refresh should be done even when cancelling the pop-up.
      ENDIF.
    WHEN OTHERS.
*     Error occured
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

ENDMETHOD.


METHOD call_time_stamps .

  DATA: l_work_station     TYPE n1arpl,
        l_planoe           TYPE orgid,
        l_parameter        LIKE LINE OF it_parameter,
        lt_a_nlei          TYPE ishmed_t_nlei,
        l_a_nlei           LIKE LINE OF lt_a_nlei,
        lt_a_nlem          TYPE ishmed_t_nlem,
        l_a_nlem           LIKE LINE OF lt_a_nlem,
        lt_nfal            TYPE ishmed_t_nfal,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'                               " nur genau 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Markierten (Vorläufigen) Patienten und Fall ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Funktion für vorläufige Patienten nicht möglich
  CLEAR: l_npat, l_npap.
  READ TABLE lt_npat INTO l_npat INDEX 1.
  READ TABLE lt_npap INTO l_npap INDEX 1.
  IF l_npat-patnr IS INITIAL AND NOT l_npap-papid IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '763'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Patient ist noch nicht aufgenommen, Dokumentation der OP nicht mögl.
  IF lt_nfal[] IS INITIAL.
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '763'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Markierte Ankerleistung ermitteln
  CALL METHOD cl_ishmed_functions=>get_services
    EXPORTING
      it_objects         = it_objects
      i_conn_srv         = on
      i_only_main_anchor = off
    IMPORTING
      e_rc               = e_rc
      et_anchor_nlei     = lt_a_nlei
      et_anchor_nlem     = lt_a_nlem
    CHANGING
      c_environment      = c_environment
      c_errorhandler     = c_errorhandler.
  CHECK e_rc = 0.

* Haupt-OP-Ankerleistung muß vorhanden sein
  CLEAR: l_a_nlem, l_a_nlei.
  READ TABLE lt_a_nlem INTO l_a_nlem WITH KEY ankls = 'X'.
  IF sy-subrc <> 0.
*   Falls direkt eine Neben-OP-Ankerleistung übergeben wird,
*   dann soll diese verwendet werden
    READ TABLE lt_a_nlem INTO l_a_nlem WITH KEY ankls = 'N'.
    IF sy-subrc <> 0.
*     Zeitenerfassung ist nur für geplante OP-Anforderungen möglich
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '752'
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.
  READ TABLE lt_a_nlei INTO l_a_nlei WITH KEY lnrls = l_a_nlem-lnrls.
  CHECK sy-subrc = 0.

* Bewegung und/oder Termin muß vorhanden sein
  IF l_a_nlei-lfdbew IS INITIAL AND l_a_nlem-tmnid IS INITIAL.
*   Zeitenerfassung ist erst nach Terminvergabe möglich
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF'
        i_num  = '567'
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

* Ev. Arbeitsplatz ermitteln (ID 12393)
  CLEAR l_work_station.
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '023'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_work_station = l_parameter-value.
  ENDIF.

* get planning OU (MED-41209)
  CLEAR l_planoe.
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '005'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_planoe = l_parameter-value.
  ENDIF.

* Zeitenreport aufrufen
  CALL FUNCTION 'ISH_N2_ZEITENREPORT'
    EXPORTING
      ss_ankerleist = l_a_nlem-lnrls
      ss_arbeitspl  = l_work_station
      ss_defdatum   = l_a_nlei-ibgdt
      ss_vcode      = 'UPD'
      ss_opdatum    = l_a_nlei-ibgdt
      ss_planoe     = l_planoe                              " MED-41209
    EXCEPTIONS
      OTHERS        = 1.

  CASE sy-subrc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
      e_refresh = 1.
    WHEN OTHERS.
*     Error during program execution
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF'
          i_num  = '139'
          i_mv1  = sy-subrc
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

  CLEAR: cl_ishmed_srgtimes=>gt_rn2zeiten.  "PN/MED-40483

ENDMETHOD.


METHOD call_view .

  DATA: l_parameter        LIKE LINE OF it_parameter,
*        l_nbr_marked       TYPE i,
        l_wplace_id_from   TYPE nwplace-wplaceid,
        l_view_type_from   TYPE nwview-viewtype,
        l_view_id_from     TYPE nwview-viewid,
        l_view_id          TYPE nwview-viewid,
        lt_wp_views        TYPE TABLE OF v_nwpvz,
        ls_wp_view         TYPE v_nwpvz,
        l_viewtype_call    TYPE nwview-viewtype,
        l_nwview_check     TYPE nwview,                     "#EC NEEDED
        l_sortid           TYPE nwpvz-sortid,
        lt_sel_obj         TYPE ish_t_sel_object,
        l_sel_obj          LIKE LINE OF lt_sel_obj,
        l_object           LIKE LINE OF it_objects,
        lt_ish_objects     TYPE ish_t_drag_drop_data,
        l_rc               TYPE ish_method_rc,
        lt_selvar          TYPE TABLE OF rsparams,
        ls_selvar          LIKE LINE OF lt_selvar.

  INTERFACE if_ish_list_display LOAD.

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_parameter, l_sortid, l_viewtype_call,
         l_wplace_id_from, l_view_id_from, l_view_type_from,
         l_view_id.

  REFRESH: lt_sel_obj, lt_ish_objects, lt_wp_views.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es kann nur genau 1 Eintrag markiert sein --> EGAL!
*  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
*    EXPORTING
*      i_check_type   = '1'                               " nur genau 1
*      it_objects     = it_objects
*    IMPORTING
*      e_rc           = e_rc
*      e_nbr_marked   = l_nbr_marked
*    CHANGING
*      c_errorhandler = c_errorhandler.
*  CHECK e_rc = 0.

* AUSGANGSDATEN:

* aufrufende Sicht bestimmen
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '001'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_view_id_from = l_parameter-value.
*  ELSE.
*    EXIT.
  ENDIF.

* aufrufenden Sichttyp bestimmen
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '002'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_view_type_from = l_parameter-value.
*  ELSE.
*    EXIT.
  ENDIF.

* ZIELDATEN:

* aufrufendes Arbeitsumfeld-ID bestimmen
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '003'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_wplace_id_from = l_parameter-value.
  ELSE.
    EXIT.
  ENDIF.

* aufzurufenden Sichttyp bestimmen
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '008'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_viewtype_call = l_parameter-value.
  ELSE.
    EXIT.
  ENDIF.

* ev. aufzurufendes Sicht-ID bestimmen
  READ TABLE it_parameter INTO l_parameter WITH KEY type = '021'.
  IF sy-subrc = 0 AND NOT l_parameter-value IS INITIAL.
    l_view_id = l_parameter-value.
*   auf Korrektheit prüfen
    SELECT SINGLE * FROM nwview INTO l_nwview_check
           WHERE  viewtype  = l_viewtype_call
           AND    viewid    = l_view_id.
    IF sy-subrc <> 0.
*     Die Sicht & (Sichttyp &) wurde nicht gefunden
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'NF1'
          i_num  = '228'
          i_mv1  = l_view_id
          i_mv2  = l_viewtype_call
          i_last = space.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ENDIF.

* Übergabestruktur für Workplace bilden
  LOOP AT it_objects INTO l_object.
    CLEAR l_sel_obj.
    l_sel_obj-subobject = l_object-object.
    l_sel_obj-attribute = if_ish_list_display=>co_sel_object.
    APPEND l_sel_obj TO lt_sel_obj.
  ENDLOOP.
  CALL METHOD cl_ish_display_tools=>get_wp_ish_object
    EXPORTING
      i_sel_attribute     = '*'
      i_set_extern_values = on
      i_institution       = i_einri
      i_view_id           = l_view_id_from
      i_view_type         = l_view_type_from
      it_object           = lt_sel_obj
    IMPORTING
      e_rc                = e_rc
      et_ish_object       = lt_ish_objects
    CHANGING
      c_errorhandler      = c_errorhandler.
  CHECK e_rc = 0.

* Falls keine bestimmte aufzurufende Sicht übergeben wurde,
* dann suchen ...
  IF l_view_id IS INITIAL.

*   read all active views for the user
    CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
      EXPORTING
        i_uname  = sy-uname
        i_caller = i_caller
      TABLES
        t_nwpvz  = lt_wp_views.

    SORT lt_wp_views BY wplacetype wplaceid viewtype sortid.

*   get sortid of active view
    READ TABLE lt_wp_views INTO ls_wp_view
                           WITH KEY wplaceid = l_wplace_id_from
                                    viewtype = l_view_type_from
                                    viewid   = l_view_id_from.
    IF sy-subrc = 0.
      l_sortid = ls_wp_view-sortid.
    ENDIF.

*   get next view with requested viewtype
*   ... try if there is such a view after the active view
    LOOP AT lt_wp_views INTO ls_wp_view
                        WHERE wplaceid = l_wplace_id_from
                        AND   viewtype = l_viewtype_call
                        AND   sortid   > l_sortid.
      l_view_id = ls_wp_view-viewid.
      EXIT.
    ENDLOOP.
*   ... if there is no view after the active -> get the first
    IF sy-subrc <> 0.
      LOOP AT lt_wp_views INTO ls_wp_view
                          WHERE wplaceid = l_wplace_id_from
                          AND   viewtype = l_viewtype_call.
        l_view_id = ls_wp_view-viewid.
        EXIT.
      ENDLOOP.
    ENDIF.
    IF sy-subrc <> 0.
*     get sap-standard-view
      CALL FUNCTION 'ISHMED_VM_VIEW_SAP_STD_GET'
        EXPORTING
          i_viewtype = l_viewtype_call
        IMPORTING
          e_viewid   = l_view_id.
*     change selection criteria -> show popup to insert sel. criteria
      IF NOT l_view_id IS INITIAL.
        CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
          EXPORTING
            i_viewid   = l_view_id
            i_viewtype = l_viewtype_call
            i_caller   = i_caller
            i_placeid  = l_wplace_id_from
          IMPORTING
            e_rc       = l_rc
          TABLES
            t_selvar   = lt_selvar.
        IF l_rc = 0 AND NOT lt_selvar[] IS INITIAL.
          LOOP AT lt_selvar INTO ls_selvar WHERE selname = 'G_SELAKT'.
            IF ls_selvar-low IS INITIAL.
              ls_selvar-low = 'X'.
              MODIFY lt_selvar FROM ls_selvar.
              CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
                EXPORTING
                  i_viewid   = l_view_id
                  i_viewtype = l_viewtype_call
                  i_mode     = 'U'
                  i_caller   = i_caller
                  i_placeid  = l_wplace_id_from
                IMPORTING
                  e_rc       = l_rc
                TABLES
                  t_selvar   = lt_selvar.
              EXIT.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.

    ENDIF.

  ENDIF.        " IF l_view_id IS INITIAL

  IF NOT l_view_id IS INITIAL.
*   Aufruf Sichtenprogramm
    CALL FUNCTION 'ISH_WP_VIEW_PROGRAM_CALL'
      EXPORTING
        i_institution_id      = i_einri
        i_wplace_id           = l_wplace_id_from
        i_user_id             = sy-uname
        i_view_id             = l_view_id
        i_view_type           = l_viewtype_call
      TABLES
        i_ish_objects         = lt_ish_objects
      EXCEPTIONS
        no_view_program_exist = 1
        OTHERS                = 2.
    IF sy-subrc <> 0.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = c_errorhandler.
      e_rc = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
  ELSE.
*   Keine Sicht dieses Sichttypen im aktuellen Arbeitsumfeld vorhanden
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NF1'
        i_num  = '613'
        i_mv1  = sy-subrc
        i_last = space.
    e_rc = 1.
    e_refresh = 0.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD call_vitpar_dialog .

  DATA: l_name(50)         TYPE c,
        l_sort_count       TYPE i,
        l_mode             TYPE char1,
        l_old_data_mode    TYPE n1vpmode,
        l_fld_chg          TYPE rn1vpfldchg,
        l_tn10h            TYPE tn10h,
        lt_erboe           TYPE ishmed_t_orgid,
        l_erboe            LIKE LINE OF lt_erboe,
        lt_fachoe          TYPE ishmed_t_orgid,
        l_fachoe           LIKE LINE OF lt_fachoe,
        lt_npat            TYPE ishmed_t_npat,
        l_npat             LIKE LINE OF lt_npat,
        lt_npap            TYPE ishmed_t_npap,
        l_npap             LIKE LINE OF lt_npap,
        lt_patients        TYPE ishmed_t_vppat,
        l_patient          LIKE LINE OF lt_patients,
        lt_objects         LIKE it_objects,
        l_object           LIKE LINE OF it_objects,
        lt_tn10h           TYPE ishmed_t_tn10h,
        l_environment      TYPE REF TO cl_ish_environment.
  DATA: l_own_env          TYPE ish_on_off,                 " Nr 12007
        l_rc               TYPE ish_method_rc.              " Nr 12007

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

  CLEAR: l_sort_count, l_mode, l_old_data_mode,
         l_fld_chg, l_npat, l_npap, l_environment.

  REFRESH: lt_patients.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

*START MED-55285 Madalina P.
*First clear NPOL-buffer
  CALL METHOD cl_ishmed_functions=>npol_refresh
    EXPORTING
      i_einri         = i_einri
      it_objects      = it_objects
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
*END MED-55285 Madalina P.

* mindestens 1 Eintrag muß markiert werden
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '2'                                  " mind. 1
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.

* Für bestimmte Aufrufer soll nur ein lokales Environment verwendet
* werden, da diese Verwender ohnehin keine Vitalwerte anzeigen und
* sonst deren eigenes Environment unnötig 'vollgestopft' würde, was
* u.U. zu Performanceeinbußen kommen könnte ...
  l_own_env = off.
  IF i_caller = 'NWP011'.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        i_caller       = 'CL_ISHMED_FUNCTIONS'
        i_env_create   = on
      IMPORTING
        e_env_created  = l_own_env
        e_rc           = l_rc
      CHANGING
        c_environment  = l_environment
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ELSE.
    l_environment = c_environment.
  ENDIF.

* Patienten mit Erbringender OE in eine Tabelle stellen:
* daher die Übergabetabelle mit den Objekten einzeln abarbeiten,
* um die einzelnen Patienten samt dazugehöriger ERBOE zu erhalten
  LOOP AT it_objects INTO l_object.
    REFRESH: lt_objects, lt_npat, lt_npap, lt_erboe, lt_fachoe.
    APPEND l_object TO lt_objects.
*   Markierten (vorläufigen) Patienten ermitteln
    CALL METHOD cl_ishmed_functions=>get_patients_and_cases
      EXPORTING
        it_objects     = lt_objects
      IMPORTING
        e_rc           = e_rc
        et_npat        = lt_npat
        et_npap        = lt_npap
      CHANGING
        c_environment  = l_environment
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    READ TABLE lt_npat INTO l_npat INDEX 1.
    IF sy-subrc <> 0.
      CLEAR l_npat.
    ENDIF.
*   Funktion für vorläufige Patienten nicht möglich
    DESCRIBE TABLE lt_npap.
    IF sy-tfill > 0.
      LOOP AT lt_npap INTO l_npap.
        CLEAR l_name.
        PERFORM concat_name IN PROGRAM sapmnpa0 USING l_npap-titel
                                                      l_npap-vorsw
                                                      l_npap-nname
                                                      l_npap-vname
                                                      l_name.
*       Patient noch nicht aufgenommen - Funktion nicht möglich
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '617'
            i_mv1  = l_name
            i_mv2  = 'Funktion'(006)
            i_last = space.
      ENDLOOP.
      e_rc      = 1.
      e_refresh = 0.
      EXIT.
    ENDIF.
*   Erbringende OE ermitteln
    CALL METHOD cl_ishmed_functions=>get_erboes
      EXPORTING
        it_objects     = lt_objects
      IMPORTING
        e_rc           = e_rc
        et_erboe       = lt_erboe
        et_fachoe      = lt_fachoe                          " MED-34277
      CHANGING
        c_errorhandler = c_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    READ TABLE lt_erboe INTO l_erboe INDEX 1.
    IF sy-subrc <> 0.
      CLEAR l_erboe.
    ENDIF.
    READ TABLE lt_fachoe INTO l_fachoe INDEX 1.             " MED-34277
    IF sy-subrc <> 0.                                       " MED-34277
      CLEAR l_fachoe.                                       " MED-34277
    ENDIF.                                                  " MED-34277
*   Patient in Übergabetabelle stellen
    CLEAR l_patient.
    l_patient-patnr = l_npat-patnr.
    l_patient-erfoe = l_erboe.
    l_patient-fachoe = l_fachoe.                            " MED-34277
*   als fachl. OE die aufbauorg. übergeordnete OE der ERBOE suchen
    IF l_patient-fachoe IS INITIAL.                         " MED-34277
*    CLEAR l_tn10h.
*    SELECT * FROM tn10h INTO l_tn10h UP TO 1 ROWS
*           WHERE  untor  = l_patient-erfoe
*           AND    enddt GE sy-datum
*           AND    begdt LE sy-datum.
*      EXIT.
*    ENDSELECT.
      CALL METHOD cl_ish_dbr_org_hier=>get_t_org_hier
        EXPORTING
          i_below  = off
          i_above  = on
          i_orgid  = l_patient-erfoe
        IMPORTING
          et_tn10h = lt_tn10h
          e_rc     = l_rc.
      IF l_rc = 0 AND lt_tn10h[] IS NOT INITIAL.
        READ TABLE lt_tn10h INTO l_tn10h INDEX 1.
        l_patient-fachoe = l_tn10h-uebor.
      ENDIF.
    ENDIF.
    l_sort_count = l_sort_count + 1.
    l_patient-sort   = l_sort_count.
    APPEND l_patient TO lt_patients.
  ENDLOOP.
  IF e_rc <> 0.
*   Destroy the local env, because now it isn"t
*   used any more (and it will be removed from ISH_MANAGER)
    IF l_own_env = on.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = l_environment.
    ENDIF.
    EXIT.
  ENDIF.

* Einzel- oder Sammelerfassung
  IF i_fcode = 'VPEF'.
    l_mode = 'E'.                     " single patient mode
    l_old_data_mode = 'DIS'.          " display history
  ELSE.
    l_mode = 'S'.                     " all patients mode
    l_old_data_mode = 'NOT'.          " no history
  ENDIF.

* Alle Header-Felder eingabebereit
  l_fld_chg = 'XXXX'.

* Vitalparameter Dialog aufrufen
  CALL FUNCTION 'ISHMED_VITPAR_DIALOG'
    EXPORTING
      i_popup             = on
*     I_TITLE             =
      i_einri             = i_einri
*     I_ERFOE             =
*     I_FACHOE            =
      i_patients          = lt_patients
*     I_VPPIDS            =
      i_mode              = l_mode
      i_new_data_input    = on
      i_old_data_mode     = l_old_data_mode
      i_old_data_sort     = 'A'
      i_nbr_lines_input   = '002'
      i_disp_header       = on
      i_date              = sy-datum
      i_time              = sy-uzeit
      i_fields_changeable = l_fld_chg
*     I_SEL_DATETIME      =
*     I_VPPID_POS         =
*     Fichte, MED-45110: always start new LUW here
      i_new_luw                 = 'X'
*     but then we cannot pass the environment, but
*     this is also not necessary
*      ir_environment            = l_environment
*     Fichte, MED_45110 - End
    IMPORTING
      e_rc                = e_rc
    CHANGING
      c_errorhandler      = c_errorhandler.
*     C_OTHER_DATA              =

  CASE e_rc.
    WHEN 0.
*     Everything OK
      e_rc = 0.
*     die meisten Anwendungen werden keine Vitalwerte anzeigen,
*     daher ist hier vorerst kein Refresh nötig
      e_refresh = 0.
    WHEN 2.
*     Cancel
      e_rc = 2.
      e_refresh = 0.
    WHEN OTHERS.
*     Error occured
      e_rc = 1.
      e_refresh = 0.
  ENDCASE.

* Destroy the local env, because now it isn"t
* used any more (and it will be removed from ISH_MANAGER)
  IF l_own_env = on.
    CALL METHOD cl_ish_utl_base=>destroy_env
      CHANGING
        cr_environment = l_environment.
  ENDIF.

ENDMETHOD.


METHOD CALL_VSA .

  DATA:
        lt_rn1po_call TYPE TABLE OF rn1po_call,
        l_rn1po_call  LIKE LINE OF lt_rn1po_call,
        lt_nfal       TYPE ishmed_t_nfal,
        l_nfal        LIKE LINE OF lt_nfal,
        lt_npat       TYPE ishmed_t_npat,
        l_npat        LIKE LINE OF lt_npat,
        lt_npap       TYPE ishmed_t_npap,
        l_npap        LIKE LINE OF lt_npap,
        lt_nbew       TYPE ishmed_t_nbew,
        l_nbew        LIKE LINE OF lt_nbew,

        lt_vs_patient TYPE ishmed_t_n2clim_vs_patient,
*        lr_exception  TYPE REF TO cx_ishmed_clim,
        lt_erboe      TYPE ishmed_t_orgid,
        lt_pfloe      TYPE ishmed_t_orgid,
        lt_fachoe     TYPE ishmed_t_orgid,
        l_erboe       LIKE LINE OF lt_fachoe,
        l_pfloe       LIKE LINE OF lt_fachoe,
        l_fachoe      LIKE LINE OF lt_fachoe.



* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es muß genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.


* Markierte (vorläufige) Patienten und Fälle ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* OE's
CALL METHOD cl_ishmed_functions=>get_erboes
  EXPORTING
    it_objects     = it_objects
  IMPORTING
    e_rc           = e_rc
    et_erboe       = lt_erboe
    et_pfloe       = lt_pfloe
    et_fachoe      = lt_fachoe
  CHANGING
    c_errorhandler = c_errorhandler
  .

READ TABLE lt_erboe INTO l_erboe INDEX 1.
READ TABLE lt_pfloe INTO l_pfloe INDEX 1.
READ TABLE lt_fachoe INTO l_fachoe INDEX 1.

* Patienten in Übergabetabelle stellen
  LOOP AT lt_npat INTO l_npat.
    READ TABLE lt_nfal INTO l_nfal WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR l_nfal.
    ELSE.
      READ TABLE lt_nbew INTO l_nbew WITH KEY falnr = l_nfal-falnr.
      IF sy-subrc <> 0.
        CLEAR l_nbew.
      ENDIF.
    ENDIF.
    READ TABLE lt_rn1po_call INTO l_rn1po_call
               WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR: l_rn1po_call.
      l_rn1po_call-patnr = l_npat-patnr.
      l_rn1po_call-pziff = l_npat-pziff.
      l_rn1po_call-einri = i_einri.
      l_rn1po_call-falnr = l_nfal-falnr.
      l_rn1po_call-fziff = l_nfal-fziff.
      l_rn1po_call-falar = ' '.
      l_rn1po_call-lfdbew = l_nbew-lfdnr.
      l_rn1po_call-lfddia = ' '.
      l_rn1po_call-orgpf  = l_pfloe.
      l_rn1po_call-orgfa  = l_fachoe.
      l_rn1po_call-uname  = sy-uname.
      l_rn1po_call-orgid  = l_erboe.
      l_rn1po_call-repid  = sy-repid.
      l_rn1po_call-viewid = ' '.
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

  MOVE-CORRESPONDING lt_rn1po_call TO lt_vs_patient.

  TRY.
      CALL METHOD cl_ishmed_clim_vs_wp=>display
        EXPORTING
          it_sel_crit = lt_vs_patient.
    CATCH cx_ishmed_clim.
  ENDTRY.

  e_refresh = 1.

ENDMETHOD.


METHOD call_vse .

  DATA:
        lt_rn1po_call TYPE TABLE OF rn1po_call,
        l_rn1po_call  LIKE LINE OF lt_rn1po_call,
        lt_nfal       TYPE ishmed_t_nfal,
        l_nfal        LIKE LINE OF lt_nfal,
        lt_npat       TYPE ishmed_t_npat,
        l_npat        LIKE LINE OF lt_npat,
        lt_npap       TYPE ishmed_t_npap,
        l_npap        LIKE LINE OF lt_npap,
        lt_nbew       TYPE ishmed_t_nbew,
        l_nbew        LIKE LINE OF lt_nbew,

        lt_vs_patient TYPE ishmed_t_n2clim_vs_patient,
*        lr_exception  TYPE REF TO cx_ishmed_clim,
        lt_erboe      TYPE ishmed_t_orgid,
        lt_pfloe      TYPE ishmed_t_orgid,
        lt_fachoe     TYPE ishmed_t_orgid,
        l_erboe       LIKE LINE OF lt_fachoe,
        l_pfloe       LIKE LINE OF lt_fachoe,
        l_fachoe      LIKE LINE OF lt_fachoe.

  DATA:   ls_vs_patient LIKE LINE OF lt_vs_patient.         "CDuerr, MED-72207

* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es muß genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.


* Markierte (vorläufige) Patienten und Fälle ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* CDuerr, MED-72207 - begin
* get the marked movement ...
  CALL METHOD cl_ishmed_functions=>get_apps_and_movs
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nbew        = lt_nbew
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
* CDuerr, MED-72207 - end

* OE's
CALL METHOD cl_ishmed_functions=>get_erboes
  EXPORTING
    it_objects     = it_objects
  IMPORTING
    e_rc           = e_rc
    et_erboe       = lt_erboe
    et_pfloe       = lt_pfloe
    et_fachoe      = lt_fachoe
  CHANGING
    c_errorhandler = c_errorhandler
  .

READ TABLE lt_erboe INTO l_erboe INDEX 1.
READ TABLE lt_pfloe INTO l_pfloe INDEX 1.
READ TABLE lt_fachoe INTO l_fachoe INDEX 1.

* Patienten in Übergabetabelle stellen
  LOOP AT lt_npat INTO l_npat.
    READ TABLE lt_nfal INTO l_nfal WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR l_nfal.
    ELSE.
      READ TABLE lt_nbew INTO l_nbew WITH KEY falnr = l_nfal-falnr.
      IF sy-subrc <> 0.
        CLEAR l_nbew.
      ENDIF.
    ENDIF.
    READ TABLE lt_rn1po_call INTO l_rn1po_call
               WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR: l_rn1po_call.
      l_rn1po_call-patnr = l_npat-patnr.
      l_rn1po_call-pziff = l_npat-pziff.
      l_rn1po_call-einri = i_einri.
      l_rn1po_call-falnr = l_nfal-falnr.
      l_rn1po_call-fziff = l_nfal-fziff.
      l_rn1po_call-falar = ' '.
      l_rn1po_call-lfdbew = l_nbew-lfdnr.
      l_rn1po_call-lfddia = ' '.
      l_rn1po_call-orgpf  = l_pfloe.
      l_rn1po_call-orgfa  = l_fachoe.
      l_rn1po_call-uname  = sy-uname.
      l_rn1po_call-orgid  = l_erboe.
      l_rn1po_call-repid  = sy-repid.
      l_rn1po_call-viewid = ' '.
*     CDuerr, MED-72207 - begin
      IF l_rn1po_call-lfdbew IS INITIAL.
        CLEAR l_rn1po_call-falnr.
      ENDIF.
*     CDuerr, MED-72207 - end
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
*     CDuerr, MED-72207 - begin
      MOVE-CORRESPONDING l_rn1po_call TO ls_vs_patient.
      IF NOT l_nbew-lfdnr IS INITIAL.
        ls_vs_patient-lfdnr = l_nbew-lfdnr.
      ENDIF.
      INSERT ls_vs_patient INTO TABLE lt_vs_patient.
*     CDuerr, MED-72207 - end
    ENDIF.
  ENDLOOP.

*  MOVE-CORRESPONDING lt_rn1po_call TO lt_vs_patient.      "CDuerr, MED-72207

  TRY.
      CALL METHOD cl_ishmed_clim_vs_wp=>maintain
        EXPORTING
          it_sel_crit = lt_vs_patient.
    CATCH cx_ishmed_clim.
  ENDTRY.

  e_refresh = 1.

ENDMETHOD.


METHOD CALL_VSP .

  DATA:
        lt_rn1po_call TYPE TABLE OF rn1po_call,
        l_rn1po_call  LIKE LINE OF lt_rn1po_call,
        lt_nfal       TYPE ishmed_t_nfal,
        l_nfal        LIKE LINE OF lt_nfal,
        lt_npat       TYPE ishmed_t_npat,
        l_npat        LIKE LINE OF lt_npat,
        lt_npap       TYPE ishmed_t_npap,
        l_npap        LIKE LINE OF lt_npap,
        lt_nbew       TYPE ishmed_t_nbew,
        l_nbew        LIKE LINE OF lt_nbew,

        lt_vs_patient TYPE ishmed_t_n2clim_vs_patient,
*        lr_exception  TYPE REF TO cx_ishmed_clim,
        lt_erboe      TYPE ishmed_t_orgid,
        lt_pfloe      TYPE ishmed_t_orgid,
        lt_fachoe     TYPE ishmed_t_orgid,
        l_erboe       LIKE LINE OF lt_fachoe,
        l_pfloe       LIKE LINE OF lt_fachoe,
        l_fachoe      LIKE LINE OF lt_fachoe.



* Initialisierungen
  CLEAR e_rc.
  e_refresh = 0.

  e_func_done = true.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Es muß genau 1 Eintrag markiert sein
  CALL METHOD cl_ishmed_functions=>check_nbr_marked_lines
    EXPORTING
      i_check_type   = '1'
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
*     e_nbr_marked   = l_nbr_marked
    CHANGING
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* Environment ermitteln
  IF c_environment IS INITIAL.
    CALL METHOD cl_ishmed_functions=>get_environment
      EXPORTING
        it_objects    = it_objects
      CHANGING
        c_environment = c_environment.
  ENDIF.


* Markierte (vorläufige) Patienten und Fälle ermitteln
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* OE's
CALL METHOD cl_ishmed_functions=>get_erboes
  EXPORTING
    it_objects     = it_objects
  IMPORTING
    e_rc           = e_rc
    et_erboe       = lt_erboe
    et_pfloe       = lt_pfloe
    et_fachoe      = lt_fachoe
  CHANGING
    c_errorhandler = c_errorhandler
  .

READ TABLE lt_erboe INTO l_erboe INDEX 1.
READ TABLE lt_pfloe INTO l_pfloe INDEX 1.
READ TABLE lt_fachoe INTO l_fachoe INDEX 1.

* Patienten in Übergabetabelle stellen
  LOOP AT lt_npat INTO l_npat.
    READ TABLE lt_nfal INTO l_nfal WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR l_nfal.
    ELSE.
      READ TABLE lt_nbew INTO l_nbew WITH KEY falnr = l_nfal-falnr.
      IF sy-subrc <> 0.
        CLEAR l_nbew.
      ENDIF.
    ENDIF.
    READ TABLE lt_rn1po_call INTO l_rn1po_call
               WITH KEY patnr = l_npat-patnr.
    IF sy-subrc <> 0.
      CLEAR: l_rn1po_call.
      l_rn1po_call-patnr = l_npat-patnr.
      l_rn1po_call-pziff = l_npat-pziff.
      l_rn1po_call-einri = i_einri.
      l_rn1po_call-falnr = l_nfal-falnr.
      l_rn1po_call-fziff = l_nfal-fziff.
      l_rn1po_call-falar = ' '.
      l_rn1po_call-lfdbew = l_nbew-lfdnr.
      l_rn1po_call-lfddia = ' '.
      l_rn1po_call-orgpf  = l_pfloe.
      l_rn1po_call-orgfa  = l_fachoe.
      l_rn1po_call-uname  = sy-uname.
      l_rn1po_call-orgid  = l_erboe.
      l_rn1po_call-repid  = sy-repid.
      l_rn1po_call-viewid = ' '.
      INSERT l_rn1po_call INTO TABLE lt_rn1po_call.
    ENDIF.
  ENDLOOP.

  MOVE-CORRESPONDING lt_rn1po_call TO lt_vs_patient.

  TRY.
      CALL METHOD cl_ishmed_clim_vs_wp=>schedule
        EXPORTING
          it_sel_crit = lt_vs_patient.
    CATCH cx_ishmed_clim.
  ENDTRY.

  e_refresh = 1.

ENDMETHOD.


METHOD check_nbr_marked_lines .

*********************************************************************
* Werte von I_CHECK_TYPE (Prüfungslogik)
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* ' ' ... Anzahl markierter Zeilen ist egal (0-n erlaubt)
* '-'	... keine Zeile darf markiert werden (0 erlaubt)
* '0'	... keine oder 1 Zeile darf markiert werden (0 oder 1 erlaubt)
* '1'	... nur genau 1 Zeile darf markiert werden (1 erlaubt)
* '2'	... mindestens 1 Zeile muß markiert werden (1-n erlaubt)
*********************************************************************

  DATA: l_nbr_marked         TYPE i.

  CLEAR e_rc.
  CLEAR e_nbr_marked.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Anzahl markierter Zeilen ermitteln
  CLEAR: l_nbr_marked.
  DESCRIBE TABLE it_objects LINES l_nbr_marked.
  e_nbr_marked = l_nbr_marked.

  CASE i_check_type.
    WHEN space.
*     Anzahl markierter Zeilen ist egal (0-n erlaubt)
      EXIT.
    WHEN '-'.
*     keine Zeile darf markiert werden (0 erlaubt)
      IF l_nbr_marked <> 0.
*       Bitte keinen Eintrag markieren
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '778'
            i_last = space.
        e_rc = 1.
        EXIT.
      ENDIF.
    WHEN '0'.
*     keine oder 1 Zeile darf markiert werden (0 oder 1 erlaubt)
      IF l_nbr_marked > 1.
*       Bitte nur 1 Eintrag markieren
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '450'
            i_last = space.
        e_rc = 1.
        EXIT.
      ENDIF.
    WHEN '1'.
*     nur genau 1 Zeile darf markiert werden (1 erlaubt)
      IF l_nbr_marked <> 1.
*       Bitte genau einen Eintrag markieren
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '508'
            i_last = space.
        e_rc = 1.
        EXIT.
      ENDIF.
    WHEN '2'.
*     mindestens 1 Zeile muß markiert werden (1-n erlaubt)
      IF l_nbr_marked < 1.
*       Bitte mindestens 1 Eintrag markieren
        CALL METHOD c_errorhandler->collect_messages
          EXPORTING
            i_typ  = 'E'
            i_kla  = 'NF1'
            i_num  = '413'
            i_last = space.
        e_rc = 1.
        EXIT.
      ENDIF.
    WHEN OTHERS.
*     egal
      EXIT.
  ENDCASE.

ENDMETHOD.


METHOD execute .

  DATA: l_meth(60)       TYPE c,
        l_cr_own_env     TYPE ish_on_off.

* initialize return parameters
  e_rc        = 0.
  e_refresh   = 0.
  e_func_done = true.

  REFRESH et_expvalues.

  CLEAR: l_meth, l_cr_own_env.

* create instance of errorhandler object if necessary
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* get environment
  CALL METHOD cl_ishmed_functions=>get_environment
    EXPORTING
      it_objects     = it_objects
      i_caller       = 'CL_ISHMED_FUNCTIONS'
    IMPORTING
      e_env_created  = l_cr_own_env
      e_rc           = e_rc
    CHANGING
      c_environment  = c_environment
      c_errorhandler = c_errorhandler.
  IF e_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* get SET/GET-parameter if institution is initial,
* but do not check if empty,
* because maybe the institution is not necessary for each function
* if it is obligatory for a function it should be checked in the
* special function method
  IF i_einri IS INITIAL.
    GET PARAMETER ID 'EIN' FIELD i_einri.
  ENDIF.

* call functions
  CASE i_fcode.
*   Formulardruck (FORM, Standard FORS, Auswahl FORA, Protokoll FPRO)
    WHEN 'FORM' OR 'FORS' OR 'FORA' OR 'FPRO'.
      l_meth = 'CALL_PRINT_FORM'.
*   Anforderung anlegen (REQI), Eingelangte Anford. erfassen (REQ_ELAF)
    WHEN 'REQI' OR 'REQ_ELAF'.
      l_meth = 'CALL_REQUEST_CREATE'.
*   Anforderung ändern/anzeigen (REQU/REQD)
    WHEN 'REQU' OR 'REQD'.
      l_meth = 'CALL_REQUEST'.
*   Anforderungsdruck (Standard REQ_PRT_S, Auswahl REQ_PRT_A)
    WHEN 'REQ_PRT_S' OR 'REQ_PRT_A'.
      l_meth = 'CALL_REQUEST_PRINT'.
*   Klinischen Auftrag anlegen/ändern/anzeigen
*   (PREI/PREU/PRED) oder (CORDI/CORDU/CORDD)
    WHEN 'PREI'       OR 'PREU'       OR 'PRED'       OR
         'CORDI'      OR 'CORDU'      OR 'CORDD'.
      l_meth = 'CALL_CLINICAL_ORDER'.
*   Klinische Aufträge drucken
*   (CORDP_STD/CORDP_USER/CORDP_PROT/CORDP_CORD/CORDP_CPOS/
*    CORDP_CORA/CORDP_CPOA/CORDP_CORD_XML/CORDP_CPOS_XML)
    WHEN 'CORDP_STD'      OR 'CORDP_USER'     OR 'CORDP_PROT' OR
         'CORDP_CORD'     OR 'CORDP_CPOS'     OR
         'CORDP_CORA'     OR 'CORDP_CPOA'     OR
         'CORDP_CORD_XML' OR 'CORDP_CPOS_XML'.
      l_meth = 'CALL_CLINICAL_ORDER_PRINT'.
*   Klinischen Auftrag suchen (CORDS), Vormerkung suchen (PRES)
    WHEN 'CORDS' OR 'PRES'.
      l_meth = 'CALL_CLINICAL_ORDER_SEARCH'.
*   Clinical order position - set next state (CPOS_NSTAT)
    WHEN 'CPOS_NSTAT'.
      l_meth = 'CALL_CLINICAL_ORDPOS_NSTAT'.
*   Clinical order postition - cancel (CPOS_CANCEL)
    WHEN 'CPOS_CAN'.
      l_meth = 'CALL_CLINICAL_ORDPOS_CANCEL'.
*   Neben-OP anlegen (NBOP)
    WHEN 'NBOP'.
      l_meth = 'CALL_NBOP_CREATE'.
*   OP stornieren (OPSTORNO) / OP absetzen (OPAB)
*   Neben-OP stornieren (NBSTORNO)
    WHEN 'OPSTORNO' OR 'OPAB' OR 'NBSTORNO'.
      l_meth = 'CALL_OP_STORNO'.
*   OP-Monitor (OPMO)
    WHEN 'OPMO'.
      l_meth = 'CALL_OP_MONITOR'.
*   OP-Arbeitsplatz im DWS (OPDWS)
    WHEN 'OPDWS'.
      l_meth = 'CALL_OP_DWS'.
*   OP begonnen (OPBEGON)
    WHEN 'OPBEGON'.
      l_meth = 'CALL_OP_BEGONNEN'.
*   OP Daten Details (OPDETAILS)
    WHEN 'OPDETAILS'.
      l_meth = 'CALL_OP_DETAILS'.
*   OP Kennzeichen setzen (OPSIGN_*)
    WHEN 'OPSIGN_F' OR 'OPSIGN_O' OR 'OPSIGN_P'.
      l_meth = 'CALL_OP_SIGN_SET'.
*   Team ändern/anzeigen (TEAM/TEAM_DIS)
    WHEN 'TEAM' OR 'TEAM_DIS'.
      l_meth = 'CALL_TEAM_UPDATE'.
*   Zeitenreport (SZTMK)
    WHEN 'SZTMK'.
      l_meth = 'CALL_TIME_STAMPS'.
*   Sapscript-Langtexte (LTXT_SCR)
    WHEN 'LTXT_SCR'.
      l_meth = 'CALL_LTXT_SAPSCR'.
*   Popup Infektionsgrad (IFG_POP)
    WHEN 'IFG_POP'.
      l_meth = 'CALL_IFG_SHOW_POPUP'.
*   Risikofaktoren anzeigen/ändern
    WHEN 'RISD' OR 'RISU'.
      l_meth = 'CALL_RISIKO'.
*   Diagnosenübersicht (DIAG)
    WHEN 'DIAG'.
      l_meth = 'CALL_DIAGNOSES'.
*   Sicht im Klinischen Arbeitsplatz aufrufen (VIEW)
    WHEN 'VIEW'.
      l_meth = 'CALL_VIEW'.
*   Dialog Planungsautorität (PAUTH)
*   Tageskommentare anzeigen (COMMENTS)
    WHEN 'PAUTH' OR 'COMMENTS'
      OR 'PAUTH_1'     "MED-47046 code for new context menu command has to be handled
      .
      l_meth = 'CALL_PLANNING_AUTHORITY_DIALOG'.
*   Materialerfassung beenden (MATE)
    WHEN 'MATE'.
      l_meth = 'CALL_MATERIAL_END'.
*   Materialvorschlag (MAVS)
    WHEN 'MAVS'.
      l_meth = 'CALL_MATERIAL_PROPOSAL'.
*   Fahrauftrag anlegen (PTS_INS, ohne Patient PTS_INSO)
    WHEN 'PTS_INS' OR 'PTS_INSO'.
      l_meth = 'CALL_PTS_INSERT'.
*   Rück-/Weitertransport anlegen (PTS_RWTR)
    WHEN 'PTS_RWTR'.
      l_meth = 'CALL_PTS_RWTR'.
*   Patientenorganizer (PORG),
*   Ambulanzkarte (AMPO), Vitalparameter anzeigen (VPPO)
    WHEN 'PORG' OR 'AMPO' OR 'VPPO'.
      l_meth = 'CALL_PATIENT_ORGANIZER'.
*   Termin suchen (OUTP_SCHED), Termin suchen MED (APP_SEARCH)
    WHEN 'OUTP_SCHED' OR 'APP_SEARCH'.
      l_meth = 'CALL_APP_PLAN_SEARCH'.
*   Terminkalender Patient
    WHEN 'TMNL'.
      l_meth = 'CALL_APPOINTMENT_CALENDAR'.
*   Termin planen
    WHEN 'PLAN'.
      l_meth = 'CALL_APPOINTMENT_PLANNING'.
*   Patient Offene Punkte
    WHEN 'PAT_OPEN'.
      l_meth = 'CALL_PATIENT_OPEN_POINTS'.
*   Einwilligung Patient umsetzen
    WHEN 'PATEIN'.
      l_meth = 'CALL_PATEIN_SET'.
*   Änderungsbelege für Termin(e)
    WHEN 'APP_CHGDOC'.
      l_meth = 'CALL_APP_CHANGEDOC'.
*   Änderungsbelege für Plan
    WHEN 'PLANCHGDOC'.
      l_meth = 'CALL_PLAN_CHANGEDOC'.
*   Planfreigabe
    WHEN 'PLAN_REL'.
      l_meth = 'CALL_PLAN_RELEASE'.
*   Vitalwerte erfassen (VPEF), Vitalwerte Sammelerfassung (VPSF)
    WHEN 'VPEF' OR 'VPSF'.
      l_meth = 'CALL_VITPAR_DIALOG'.
*   Fall zuordnen (CASE_ASS)
    WHEN 'CASE_ASS'.
      l_meth = 'CALL_CASE_ASSIGN'.
*   Laborkummulativbefund (LAB_DATA)
    WHEN 'LAB_DATA'.
      l_meth = 'CALL_LAB_DATA'.
*   Medikation: Verordnung anlegen (MEORDI)
    WHEN 'MEORDI'.
      l_meth = 'CALL_ME_ORDER_CREATE'.
*   Amb. Aufnahme (anlegen AAAL, ändern AAAE, anzeigen AAAZ)
*   Stat. Aufnahme (anlegen SAAL, ändern SAAE, anzeigen SAAZ)
*   Amb. Kurzaufnahme (anlegen AKAL, ändern AKAE, anzeigen AKAZ)
*   Stat. Kurzaufnahme (anlegen SKAL, ändern SKAE, anzeigen SKAZ)
*   Amb. Notaufnahme (anlegen ANAL, ändern ANAE, anzeigen ANAZ)
*   Stat. Notaufnahme (anlegen SNAL, ändern SNAE, anzeigen SNAZ)
    WHEN 'AAAL' OR 'AAAE' OR 'AAAZ' OR 'SAAL' OR 'SAAE' OR 'SAAZ' OR
         'AKAL' OR 'AKAE' OR 'AKAZ' OR 'SKAL' OR 'SKAE' OR 'SKAZ' OR
         'ANAL' OR 'ANAE' OR 'ANAZ' OR 'SNAL' OR 'SNAE' OR 'SNAZ'.
      l_meth = 'CALL_ADMISSION'.
*   Dokumentliste (DOLS, Fallbezogen DOLF, Patientbezogen DOLP)
*   Dokument (anlegen DOCI, ändern DOCU, anzeigen DOCD)
    WHEN 'DOLS' OR 'DOLF' OR 'DOLP' OR 'DOCI' OR 'DOCU' OR 'DOCD'.
      l_meth = 'CALL_MED_DOCUMENT'.
*   Leistung erbringen (SERV_ERBR), Leistung freigeben (SERV_QUIT)
    WHEN 'SERV_ERBR' OR 'SERV_QUIT'.
      l_meth = 'CALL_SERVICE_QUIT'.
*   Zyklus zu Leistung anlegen (CYCINS), anzeigen (CYCDIS),
*                      ändern  (CYCUPD), beenden  (CYCEND)
    WHEN 'CYCINS' OR 'CYCDIS' OR 'CYCUPD' OR 'CYCEND'.
      l_meth = 'CALL_SERVICE_CYCLE'.
*   Serie anzeigen/ändern/stornieren (CHAIN_DIS/CHAIN_UPD/CHAIN_CANC)
    WHEN 'CHAIN_DIS' OR 'CHAIN_UPD' OR 'CHAIN_CANC'.
      l_meth = 'CALL_CHAIN_APP'.
*   Create clinical order for appointment/movement (CORDI_A_M) MED-33294
    WHEN 'CORDI_A_M'.
      IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
        l_meth = 'CALL_CLINICAL_ORDER_CR_APPMOV'.
      ELSE.
*       function was not executed here
        e_func_done = false.
      ENDIF.
*   change order (MEORDU)                                      MED-30727
    WHEN 'MEORDU'.
      l_meth = 'CALL_ME_ORDER_CHANGE'.
*   create anamnestic order (CR_ANAMN)                         MED-30727
    WHEN 'CR_ANAMN'.
      l_meth = 'CALL_ME_ANAMN_ORDER_CREATE'.
*   call dynmaic situations for OP DWS                        Hoebarth, MED-38433
    WHEN 'SURGSELWS'.
      IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
        l_meth = 'CALL_SURG_SEL_WS'.
      ELSE.
*       function was not executed here
        e_func_done = false.
      ENDIF.
    WHEN 'CWD_UPD' OR 'CWD_DIS'.                            " MED-46655
      l_meth = 'CALL_CWD'.
    WHEN 'N1SNSE1'    OR 'N1SNSE2'    OR 'N1SNSE3'.         " MED-50882  SENSE
      l_meth = 'CALL_SNSE'.
*   barcode event administration                              KG, MED-40981
    WHEN  'MEADMINBC'.
      l_meth = 'CALL_ME_ADMIN_EVENT_BC'.

    WHEN 'N2VS1'.                                            "MED-61721  note 2301576
      l_meth = 'CALL_VSE'.

    WHEN 'N2VS3'.                                            "MED-61721  note 2301576
      l_meth = 'CALL_VSA'.

    WHEN 'N2VS2'.                                            "MED-61721  note 2301576
      l_meth = 'CALL_VSP'.

    WHEN OTHERS.
*     function was not executed here
      e_func_done = false.
  ENDCASE.

* call function method dynamic
  IF NOT l_meth IS INITIAL.
    CALL METHOD cl_ishmed_functions=>(l_meth)
      EXPORTING
        i_fcode        = i_fcode
        i_einri        = i_einri
        i_caller       = i_caller
        i_save         = i_save
        i_commit       = i_commit
        i_enqueue      = i_enqueue
        i_dequeue      = i_dequeue
        it_objects     = it_objects
        it_parameter   = it_parameter
      IMPORTING
        e_rc           = e_rc
        e_func_done    = e_func_done
        e_refresh      = e_refresh
        et_expvalues   = et_expvalues
      CHANGING
        c_errorhandler = c_errorhandler
        c_environment  = c_environment
        c_lock         = c_lock.
  ELSE.
*   function was not executed here
    e_func_done = false.
  ENDIF.

* destroy local environment
  IF NOT c_environment IS INITIAL AND l_cr_own_env = on.
    CALL METHOD cl_ish_utl_base=>destroy_env
      CHANGING
        cr_environment = c_environment.
  ENDIF.

ENDMETHOD.


METHOD get_apps_and_movs .

  DATA: l_object           LIKE LINE OF it_objects,
        l_cr_own_env       TYPE ish_on_off,
        l_nlei             TYPE nlei,
        l_ntmn             TYPE ntmn,
        l_napp             TYPE napp,
        l_nbew             TYPE nbew,
        lt_napp            TYPE ish_t_napp,
        lt_appmnt          TYPE ish_objectlist,
        l_appmnt           LIKE LINE OF lt_appmnt,
        lt_vntmn           TYPE ishmed_t_vntmn,
        l_vntmn            LIKE LINE OF lt_vntmn,
        lt_vnapp           TYPE ishmed_t_vnapp,
        l_vnapp            LIKE LINE OF lt_vnapp,
        lt_apps            TYPE ishmed_t_appointment_object,
        lt_cordpos         TYPE ish_t_cordpos,
        l_movement         TYPE REF TO cl_ishmed_movement,
        l_nbew_obj         TYPE REF TO cl_ishmed_none_oo_nbew,
        l_request          TYPE REF TO cl_ishmed_request,
        l_corder           TYPE REF TO cl_ish_corder,
        l_prereg           TYPE REF TO cl_ishmed_prereg,
        l_appointment      TYPE REF TO cl_ish_appointment,
        l_app_constr       TYPE REF TO cl_ish_app_constraint,
        l_service          TYPE REF TO cl_ishmed_service,
        lr_identify        TYPE REF TO if_ish_identify_object.

* Initialisierungen
  REFRESH: et_ntmn, et_napp, et_nbew, et_appointments,
           et_movements, et_movements_none.
  CLEAR: l_cr_own_env.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Termine/Bewegungen aus Einträgen der Objekttabelle ermitteln
  DESCRIBE TABLE it_objects.
  IF sy-tfill > 0.
    IF c_environment IS INITIAL.
      CALL METHOD cl_ishmed_functions=>get_environment
        EXPORTING
          it_objects     = it_objects
          i_caller       = 'CL_ISHMED_FUNCTIONS'
        IMPORTING
          e_env_created  = l_cr_own_env
          e_rc           = e_rc
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDIF.
    LOOP AT it_objects INTO l_object.
*     Typ des Objekts ermitteln
      TRY.
          lr_identify ?= l_object-object.
*         Klinischer Auftrag
          IF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder )        = on OR
             lr_identify->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on.
            l_corder ?= l_object-object.
*           get order positions for clinical order
            REFRESH lt_cordpos.
            CALL METHOD l_corder->get_t_cordpos
              EXPORTING
                i_cancelled_datas = i_cancelled_datas
                ir_environment    = c_environment
              IMPORTING
                et_cordpos        = lt_cordpos
                e_rc              = e_rc
              CHANGING
                cr_errorhandler   = c_errorhandler.
            IF e_rc = 0.
              LOOP AT lt_cordpos INTO l_prereg.
*               get appointment constraint for order position
                CALL METHOD l_prereg->get_app_constraint
                  EXPORTING
                    i_cancelled_datas = i_cancelled_datas
                    ir_environment    = c_environment
                  IMPORTING
                    er_app_constraint = l_app_constr
                    e_rc              = e_rc
                  CHANGING
                    cr_errorhandler   = c_errorhandler.
                IF e_rc = 0.
                  IF NOT l_app_constr IS INITIAL.
*                   get appointments for appointment constraint
                    REFRESH lt_apps.
                    CALL METHOD l_app_constr->get_t_app
                      EXPORTING
                        i_cancelled_datas = i_cancelled_datas
                        ir_environment    = c_environment
                        i_read_db         = i_read_db       "MED-40483
                      IMPORTING
                        et_apps           = lt_apps
                        e_rc              = e_rc
                      CHANGING
                        cr_errorhandler   = c_errorhandler.
                    IF e_rc = 0.
                      APPEND LINES OF lt_apps TO et_appointments.
                      IF et_ntmn IS REQUESTED OR et_napp IS REQUESTED.
                        LOOP AT lt_apps INTO l_appointment.
                          CALL METHOD l_appointment->get_data
                            EXPORTING
                              i_fill_appointment = off
                            IMPORTING
                              es_ntmn            = l_ntmn
                              et_napp            = lt_napp
                              e_rc               = e_rc
                            CHANGING
                              c_errorhandler     = c_errorhandler.
                          IF e_rc = 0.
                            APPEND l_ntmn TO et_ntmn.
                            APPEND LINES OF lt_napp TO et_napp.
                          ELSE.
                            e_rc = 1.
                            EXIT.
                          ENDIF.
                        ENDLOOP.
                      ENDIF.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDLOOP.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Auftragsposition (Vormerkung)
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg )       = on OR
                 lr_identify->is_inherited_from( cl_ishmed_cordpos=>co_otype_cordpos_med ) = on.
            l_prereg ?= l_object-object.
*           get appointment constraint for order position
            CALL METHOD l_prereg->get_app_constraint
              EXPORTING
                i_cancelled_datas = i_cancelled_datas
                ir_environment    = c_environment
              IMPORTING
                er_app_constraint = l_app_constr
                e_rc              = e_rc
              CHANGING
                cr_errorhandler   = c_errorhandler.
            IF e_rc = 0.
              IF NOT l_app_constr IS INITIAL.
*               get appointments for appointment constraint
                REFRESH lt_apps.
                CALL METHOD l_app_constr->get_t_app
                  EXPORTING
                    i_cancelled_datas = i_cancelled_datas
                    ir_environment    = c_environment
                    i_read_db         = i_read_db           "MED-40483
                  IMPORTING
                    et_apps           = lt_apps
                    e_rc              = e_rc
                  CHANGING
                    cr_errorhandler   = c_errorhandler.
                IF e_rc = 0.
                  APPEND LINES OF lt_apps TO et_appointments.
                  IF et_ntmn IS REQUESTED OR et_napp IS REQUESTED.
                    LOOP AT lt_apps INTO l_appointment.
                      CALL METHOD l_appointment->get_data
                        EXPORTING
                          i_fill_appointment = off
                        IMPORTING
                          es_ntmn            = l_ntmn
                          et_napp            = lt_napp
                          e_rc               = e_rc
                        CHANGING
                          c_errorhandler     = c_errorhandler.
                      IF e_rc = 0.
                        APPEND l_ntmn TO et_ntmn.
                        APPEND LINES OF lt_napp TO et_napp.
                      ELSE.
                        e_rc = 1.
                        EXIT.
                      ENDIF.
                    ENDLOOP.
                  ENDIF.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Anforderung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_request=>co_otype_request ) = on.
            REFRESH: lt_appmnt, lt_vntmn, lt_vnapp.
            l_request ?= l_object-object.
            CALL METHOD cl_ishmed_request=>get_services_for_request
              EXPORTING
                i_request         = l_request
                i_environment     = c_environment
                i_cancelled_datas = i_cancelled_datas
                i_read_db         = i_read_db               "MED-40483
              IMPORTING
                e_rc              = e_rc
                et_appmnt         = lt_appmnt
                et_ntmn           = lt_vntmn
                et_napp           = lt_vnapp
              CHANGING
                c_errorhandler    = c_errorhandler.
            IF e_rc = 0.
              LOOP AT lt_appmnt INTO l_appmnt.
                l_appointment ?= l_appmnt-object.
                APPEND l_appointment TO et_appointments.
              ENDLOOP.
              LOOP AT lt_vntmn INTO l_vntmn.
                l_ntmn = l_vntmn.
                APPEND l_ntmn TO et_ntmn.
              ENDLOOP.
              LOOP AT lt_vnapp INTO l_vnapp.
                l_napp = l_vnapp.
                APPEND l_napp TO et_napp.
              ENDLOOP.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Termin
          ELSEIF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
            l_appointment ?= l_object-object.
            APPEND l_appointment TO et_appointments.
            IF et_ntmn IS REQUESTED OR et_napp IS REQUESTED.
              CALL METHOD l_appointment->get_data
                EXPORTING
                  i_fill_appointment = off
                IMPORTING
                  es_ntmn            = l_ntmn
                  et_napp            = lt_napp
                  e_rc               = e_rc
                CHANGING
                  c_errorhandler     = c_errorhandler.
              IF e_rc = 0.
                APPEND l_ntmn TO et_ntmn.
                APPEND LINES OF lt_napp TO et_napp.
              ELSE.
                e_rc = 1.
                EXIT.
              ENDIF.
            ENDIF.
*         Leistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv )  = on.
            l_service ?= l_object-object.
            CALL METHOD cl_ishmed_service=>get_appmnt_for_service
              EXPORTING
                i_service         = l_service
                i_environment     = c_environment
                i_cancelled_datas = i_cancelled_datas
              IMPORTING
                e_ntmn            = l_vntmn
                et_napp           = lt_vnapp
                e_appointment     = l_appointment
                e_rc              = e_rc
              CHANGING
                c_errorhandler    = c_errorhandler.
            IF e_rc = 0.
              IF NOT l_appointment IS INITIAL.
                APPEND l_appointment TO et_appointments.
                CLEAR l_ntmn.
                l_ntmn = l_vntmn.
                APPEND l_ntmn TO et_ntmn.
                LOOP AT lt_vnapp INTO l_vnapp.
                  l_napp = l_vnapp.
                  APPEND l_napp TO et_napp.
                ENDLOOP.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
            IF et_nbew IS REQUESTED OR et_movements_none IS REQUESTED OR
                                       et_movements      IS REQUESTED.
              CALL METHOD l_service->get_data
                IMPORTING
                  e_rc           = e_rc
                  e_nlei         = l_nlei
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc = 0.
                IF NOT l_nlei-falnr  IS INITIAL AND
                   NOT l_nlei-lfdbew IS INITIAL.
                  IF l_vntmn       IS INITIAL       OR
                     l_vntmn-tmnlb IS INITIAL       OR
                     l_nlei-falnr  <> l_vntmn-falnr OR
                     l_nlei-lfdbew <> l_vntmn-tmnlb.
                    CALL FUNCTION 'ISHMED_READ_NBEW'
                      EXPORTING
                        i_einri        = l_nlei-einri
                        i_falnr        = l_nlei-falnr
                        i_lfdnr        = l_nlei-lfdbew
                      IMPORTING
                        e_rc           = e_rc
                        e_nbew         = l_nbew
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_nbew TO et_nbew.
                      IF et_movements_none IS REQUESTED.
                        CALL METHOD cl_ishmed_none_oo_nbew=>load
                          EXPORTING
                            i_einri        = l_nbew-einri
                            i_falnr        = l_nbew-falnr
                            i_lfdnr        = l_nbew-lfdnr
                          IMPORTING
                            e_instance     = l_nbew_obj
                            e_rc           = e_rc
                          CHANGING
                            c_errorhandler = c_errorhandler.
                        IF e_rc = 0.
                          APPEND l_nbew_obj TO et_movements_none.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDIF.
                      IF et_movements IS REQUESTED.
                        CALL METHOD cl_ish_fac_movement=>load
                          EXPORTING
                            i_einri        = l_nbew-einri
                            i_falnr        = l_nbew-falnr
                            i_lfdnr        = l_nbew-lfdnr
                            i_environment  = c_environment
                          IMPORTING
                            e_instance     = l_movement
                            e_rc           = e_rc
                          CHANGING
                            c_errorhandler = c_errorhandler.
                        IF e_rc = 0.
                          APPEND l_movement TO et_movements.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDIF.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ELSE.
                e_rc = 1.
                EXIT.
              ENDIF.
            ENDIF.
*         Bewegung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew )   = on OR
                 lr_identify->is_inherited_from( cl_ishmed_outpat_visit=>co_otype_outpat_visit )   = on OR
                 lr_identify->is_inherited_from( cl_ishmed_inpat_admis_med=>co_otype_inpat_admis ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_movement=>co_otype_movement )           = on.
            IF lr_identify->is_inherited_from( cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew ) = on.
              l_nbew_obj ?= l_object-object.
              APPEND l_nbew_obj TO et_movements_none.
            ELSE.
              l_movement ?= l_object-object.
              APPEND l_movement TO et_movements.
            ENDIF.
            IF et_nbew IS REQUESTED OR et_appointments IS REQUESTED OR
               et_ntmn IS REQUESTED OR et_napp IS REQUESTED.
              CALL METHOD l_object-object->('GET_DATA')
                IMPORTING
                  e_rc           = e_rc
                  e_nbew         = l_nbew
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc = 0.
                APPEND l_nbew TO et_nbew.
              ELSE.
                e_rc = 1.
                EXIT.
              ENDIF.
            ENDIF.
            IF et_ntmn IS REQUESTED OR et_napp IS REQUESTED OR
               et_appointments IS REQUESTED.
              IF NOT l_nbew-falnr IS INITIAL AND
                 NOT l_nbew-lfdnr IS INITIAL.
                SELECT * FROM ntmn INTO l_ntmn UP TO 1 ROWS
                       WHERE  einri  = l_nbew-einri
                       AND    falnr  = l_nbew-falnr
                       AND    tmnlb  = l_nbew-lfdnr
                       AND    bewty  = '4'
                       AND    storn  = off.
                  EXIT.
                ENDSELECT.
                IF sy-subrc = 0 AND NOT l_ntmn-tmnid IS INITIAL.
                  APPEND l_ntmn TO et_ntmn.
                  IF et_napp         IS REQUESTED OR
                     et_appointments IS REQUESTED.
                    CALL METHOD cl_ish_appointment=>load
                      EXPORTING
                        i_tmnid        = l_ntmn-tmnid
                        i_environment  = c_environment
                      IMPORTING
                        e_rc           = e_rc
                        e_instance     = l_appointment
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_appointment TO et_appointments.
                      IF et_napp IS REQUESTED.
                        CALL METHOD l_appointment->get_data
                          EXPORTING
                            i_fill_appointment = off
                          IMPORTING
                            es_ntmn            = l_ntmn
                            et_napp            = lt_napp
                            e_rc               = e_rc
                          CHANGING
                            c_errorhandler     = c_errorhandler.
                        IF e_rc = 0.
                          APPEND LINES OF lt_napp TO et_napp.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDIF.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
*          ELSE.
*           anhand dieser Daten kann kein Termin/Bewegung ermittelt werden
          ENDIF.
        CATCH cx_sy_move_cast_error.
          CONTINUE.
      ENDTRY.
    ENDLOOP.
*   destroy local environment
    IF l_cr_own_env = on.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = c_environment.
    ENDIF.
  ENDIF.

  CHECK e_rc = 0.

* Bewegungen gesucht?
  IF et_nbew IS REQUESTED OR et_movements_none IS REQUESTED OR
                             et_movements      IS REQUESTED.
    LOOP AT et_appointments INTO l_appointment.
      CLEAR l_movement.
      CLEAR l_nbew_obj.
      IF et_movements_none IS REQUESTED AND
         NOT et_movements IS REQUESTED.
        CALL FUNCTION 'ISHMED_GET_MOVEMNT_FOR_APPMNT'
          EXPORTING
            i_appointment  = l_appointment
            it_object      = it_objects
          IMPORTING
            e_object       = l_nbew_obj
            e_rc           = e_rc
          CHANGING
            c_errorhandler = c_errorhandler.
      ELSEIF et_movements IS REQUESTED AND
             NOT et_movements_none IS REQUESTED.
        CALL FUNCTION 'ISHMED_GET_MOVEMNT_FOR_APPMNT'
          EXPORTING
            i_appointment  = l_appointment
            it_object      = it_objects
          IMPORTING
            e_movement     = l_movement
            e_rc           = e_rc
          CHANGING
            c_errorhandler = c_errorhandler.
      ELSE.
        CALL FUNCTION 'ISHMED_GET_MOVEMNT_FOR_APPMNT'
          EXPORTING
            i_appointment  = l_appointment
            it_object      = it_objects
          IMPORTING
            e_movement     = l_movement
            e_object       = l_nbew_obj
            e_rc           = e_rc
          CHANGING
            c_errorhandler = c_errorhandler.
      ENDIF.
      IF e_rc = 0.
        IF NOT l_movement IS INITIAL.
          APPEND l_movement TO et_movements.
        ENDIF.
        IF NOT l_nbew_obj IS INITIAL.
          APPEND l_nbew_obj TO et_movements_none.
        ENDIF.
      ELSE.
        EXIT.
      ENDIF.
    ENDLOOP.
    IF e_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.
  IF et_nbew IS REQUESTED OR et_movements_none IS REQUESTED.
    IF NOT et_movements_none IS INITIAL.
      LOOP AT et_movements_none INTO l_nbew_obj.
        CALL METHOD l_nbew_obj->get_data
          IMPORTING
            e_rc           = e_rc
            e_nbew         = l_nbew
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc = 0.
          APPEND l_nbew TO et_nbew.
        ELSE.
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDLOOP.
    ELSEIF NOT et_movements IS INITIAL.
      LOOP AT et_movements INTO l_movement.
        CALL METHOD l_movement->get_data
          IMPORTING
            e_rc           = e_rc
            e_nbew         = l_nbew
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc = 0.
          APPEND l_nbew TO et_nbew.
        ELSE.
          e_rc = 1.
          EXIT.
        ENDIF.
        CALL METHOD cl_ishmed_none_oo_nbew=>load
          EXPORTING
            i_nbew         = l_nbew
            i_read_db      = off
          IMPORTING
            e_instance     = l_nbew_obj
            e_rc           = e_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        IF e_rc = 0.
          APPEND l_nbew_obj TO et_movements_none.
        ELSE.
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDIF.

* Doppelte Termin/Bewegungs-Einträge rauslöschen
  SORT et_movements.
  DELETE ADJACENT DUPLICATES FROM et_movements.
  SORT et_movements_none.
  DELETE ADJACENT DUPLICATES FROM et_movements_none.
  SORT et_nbew BY einri falnr lfdnr.
  DELETE ADJACENT DUPLICATES FROM et_nbew COMPARING einri falnr lfdnr.
  SORT et_appointments.
  DELETE ADJACENT DUPLICATES FROM et_appointments.
  SORT et_ntmn BY tmnid.
  DELETE ADJACENT DUPLICATES FROM et_ntmn COMPARING tmnid.
  SORT et_napp BY lnrapp.
  DELETE ADJACENT DUPLICATES FROM et_napp COMPARING lnrapp.

ENDMETHOD.


METHOD get_environment .

  DATA: l_object         LIKE LINE OF it_objects,
        l_rc             TYPE ish_method_rc,
        l_caller         TYPE sy-cprog,
        lt_objects       TYPE ish_objectlist,
        lr_environment   TYPE REF TO cl_ish_environment.

* initialization
  e_env_created = off.
  e_rc = 0.

  CLEAR lr_environment.

* errorhandler
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* calling program
  l_caller = i_caller.
  IF l_caller IS INITIAL.
    l_caller = 'CL_ISHMED_FUNCTIONS'.
  ENDIF.

* get environment of objects if possible;
* if not possible use given environment
  DESCRIBE TABLE it_objects.
  IF sy-tfill <> 0.
*   environment only available for OO data objects
    CALL FUNCTION 'ISHMED_DIVIDE_OBJECT'
      EXPORTING
        it_object      = it_objects
      IMPORTING
        e_rc           = l_rc
        et_object_oo   = lt_objects
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc = 0.
      LOOP AT lt_objects INTO l_object.
        CALL METHOD l_object-object->('GET_ENVIRONMENT')
          IMPORTING
            e_environment = lr_environment.
        IF NOT lr_environment IS INITIAL.
          c_environment = lr_environment.
          EXIT.
        ENDIF.
      ENDLOOP.
    ELSE.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.

** get environment from NPOL if necessary
*  IF c_environment IS INITIAL.
*    CALL FUNCTION 'ISH_ENVIRONMENT_POOL_GET'
*      IMPORTING
*        ss_environment  = c_environment
*      EXCEPTIONS
*        no_data_in_pool = 1
*        OTHERS          = 2.
*    IF sy-subrc <> 0.
**     do nothing, no error!
*    ENDIF.
*  ENDIF.

* create environment if necessary
  IF c_environment IS INITIAL.
    IF i_env_create = on.
      CALL METHOD cl_ish_fac_environment=>create
        EXPORTING
          i_program_name = l_caller
        IMPORTING
          e_instance     = c_environment
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ELSE.
        e_env_created = on.
      ENDIF.
    ELSE.
      EXIT.
    ENDIF.
  ENDIF.

* set NPOL-environment
  IF i_npol_set = on.
    CALL FUNCTION 'ISH_ENVIRONMENT_POOL_SET'
      EXPORTING
        ss_environment = c_environment.
  ENDIF.

ENDMETHOD.


METHOD get_erboes .

  DATA: l_object           LIKE LINE OF it_objects,
        ls_n1corder        TYPE n1corder,
        l_n1anf            TYPE n1anf,
        l_n1vkg            TYPE n1vkg,
        l_nlei             TYPE nlei,
        l_ntmn             TYPE ntmn,
        l_n1meorder        TYPE n1meorder,
        l_n1meevent        TYPE n1meevent,
        l_nbew             TYPE nbew,
        l_erboe            LIKE LINE OF et_erboe,
        l_pfloe            LIKE LINE OF et_pfloe,           " ID 16623
        l_fachoe           LIKE LINE OF et_fachoe,          " ID 16623
        lt_napp            TYPE ish_t_napp,
        ls_napp            LIKE LINE OF lt_napp,
        lr_corder          TYPE REF TO cl_ish_corder,
        l_request          TYPE REF TO cl_ishmed_request,
        l_prereg           TYPE REF TO cl_ishmed_prereg,
        l_appointment      TYPE REF TO cl_ish_appointment,
        l_service          TYPE REF TO cl_ishmed_service,
        l_srv              TYPE REF TO cl_ishmed_srv_service,
        l_meorder          TYPE REF TO cl_ishmed_me_order,
        l_meevent          TYPE REF TO cl_ishmed_me_event,
        lr_identify        TYPE REF TO if_ish_identify_object.

* Initialisierungen
  REFRESH: et_erboe, et_pfloe, et_fachoe.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* ERBOEs aus Einträgen der Objekttabelle ermitteln
  DESCRIBE TABLE it_objects.
  IF sy-tfill > 0.
    LOOP AT it_objects INTO l_object.
*     Typ des Objekts ermitteln
      TRY.
          lr_identify ?= l_object-object.
          IF lr_identify->is_inherited_from( cl_ishmed_request=>co_otype_request ) = on.
            l_request ?= l_object-object.
            CALL METHOD l_request->get_data
              IMPORTING
                e_rc           = e_rc
                e_n1anf        = l_n1anf
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc = 0.
              l_erboe = l_n1anf-orgid.
              APPEND l_erboe TO et_erboe.
              l_pfloe = l_n1anf-anpoe.
              APPEND l_pfloe TO et_pfloe.
              l_fachoe = l_n1anf-anfoe.
              APPEND l_fachoe TO et_fachoe.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Klinischer Auftrag
          ELSEIF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on.
            lr_corder ?= l_object-object.
            CALL METHOD lr_corder->get_data
              IMPORTING
                es_n1corder     = ls_n1corder
                e_rc            = e_rc
              CHANGING
                cr_errorhandler = c_errorhandler.
            IF e_rc = 0.
              l_erboe = ls_n1corder-etroe.
              APPEND l_erboe TO et_erboe.
              l_pfloe = ls_n1corder-etroe.
              APPEND l_pfloe TO et_pfloe.
              l_fachoe = ls_n1corder-orddep.
              APPEND l_fachoe TO et_fachoe.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Auftragsposition (Vormerkung)
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_cordpos=>co_otype_cordpos_med ) = on.
            l_prereg ?= l_object-object.
            CALL METHOD l_prereg->get_data
              IMPORTING
                e_rc           = e_rc
                e_n1vkg        = l_n1vkg
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc = 0.
              l_erboe = l_n1vkg-trtoe.
              IF l_erboe IS INITIAL.
                l_erboe = l_n1vkg-orgid.
              ENDIF.
              APPEND l_erboe TO et_erboe.
              l_pfloe = l_erboe.
              APPEND l_pfloe TO et_pfloe.
              l_fachoe = l_n1vkg-orgfa.
              APPEND l_fachoe TO et_fachoe.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Termin
          ELSEIF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
            l_appointment ?= l_object-object.
            CALL METHOD l_appointment->get_data
              EXPORTING
                i_fill_appointment = off
              IMPORTING
                es_ntmn            = l_ntmn
                et_napp            = lt_napp
                e_rc               = e_rc
              CHANGING
                c_errorhandler     = c_errorhandler.
            IF e_rc = 0.
              l_erboe = l_ntmn-tmnoe.
              APPEND l_erboe TO et_erboe.
              READ TABLE lt_napp INTO ls_napp INDEX 1.
              IF sy-subrc = 0.
                l_pfloe = ls_napp-orgpf.
                APPEND l_pfloe TO et_pfloe.
                l_fachoe = ls_napp-orgfa.
                APPEND l_fachoe TO et_fachoe.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Leistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = on.
            l_service ?= l_object-object.
            CALL METHOD l_service->get_data
              IMPORTING
                e_rc           = e_rc
                e_nlei         = l_nlei
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc = 0.
              l_erboe = l_nlei-erboe.
              APPEND l_erboe TO et_erboe.
              l_pfloe = l_nlei-anpoe.
              APPEND l_pfloe TO et_pfloe.
              l_fachoe = l_nlei-anfoe.
              APPEND l_fachoe TO et_fachoe.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Arzneimittelverordnung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_me_order=>co_otype_me_order ) = on.
            l_meorder ?= l_object-object.
            CALL METHOD l_meorder->get_data
              IMPORTING
                e_rc            = e_rc
                es_n1meorder    = l_n1meorder
              CHANGING
                cr_errorhandler = c_errorhandler.
            IF e_rc = 0.
              l_erboe = l_n1meorder-orgpf.
              APPEND l_erboe TO et_erboe.
              l_pfloe = l_n1meorder-orgpf.
              APPEND l_pfloe TO et_pfloe.
              l_fachoe = l_n1meorder-orgfa.
              APPEND l_fachoe TO et_fachoe.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Arzneimittelereignis
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_me_event=>co_otype_me_event ) = on.
            l_meevent ?= l_object-object.
            CALL METHOD l_meevent->get_data
              IMPORTING
                e_rc            = e_rc
                es_n1meevent    = l_n1meevent
              CHANGING
                cr_errorhandler = c_errorhandler.
            IF e_rc = 0.
              l_erboe = l_n1meevent-medocou.
              APPEND l_erboe TO et_erboe.
              l_pfloe = l_n1meevent-medocou.
              APPEND l_pfloe TO et_pfloe.
              l_fachoe = l_n1meevent-medocdou.
              APPEND l_fachoe TO et_fachoe.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Bewegung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_outpat_visit=>co_otype_outpat_visit ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_inpat_admis_med=>co_otype_inpat_admis ) = on.
            CALL METHOD l_object-object->('GET_DATA')
              IMPORTING
                e_rc           = e_rc
                e_nbew         = l_nbew
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc = 0.
              l_erboe = l_nbew-orgpf.
              APPEND l_erboe TO et_erboe.
              l_pfloe = l_nbew-orgpf.
              APPEND l_pfloe TO et_pfloe.
              l_fachoe = l_nbew-orgfa.
              APPEND l_fachoe TO et_fachoe.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Pflegeleistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_srv_service=>co_otype_srv_service ) = on.
            l_srv ?= l_object-object.
            l_erboe  = l_srv->get_orgpf( ).
            l_pfloe  = l_srv->get_orgpf( ).
            l_fachoe = l_srv->get_orgfa( ).
            IF l_erboe IS NOT INITIAL.
              APPEND l_erboe TO et_erboe.
            ENDIF.
            IF l_pfloe IS NOT INITIAL.
              APPEND l_pfloe TO et_pfloe.
            ENDIF.
            IF l_fachoe IS NOT INITIAL.
              APPEND l_fachoe TO et_fachoe.
            ENDIF.
*          ELSE.
*           anhand dieses Objekts kann keine ERBOE ermittelt werden
          ENDIF.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
    ENDLOOP.
    CHECK e_rc = 0.
  ENDIF.

  CHECK e_rc = 0.

* Doppelte OE-Einträge rauslöschen
  SORT et_erboe.
  DELETE ADJACENT DUPLICATES FROM et_erboe.
  SORT et_pfloe.
  DELETE ADJACENT DUPLICATES FROM et_pfloe.
  SORT et_fachoe.
  DELETE ADJACENT DUPLICATES FROM et_fachoe.

ENDMETHOD.


METHOD get_orders .

  DATA: l_object           LIKE LINE OF it_objects,
        l_cr_own_env       TYPE ish_on_off,
        l_n1corder         LIKE LINE OF et_n1corder,
        l_nbew             TYPE nbew,
        l_ntmn             TYPE ntmn,
        lt_cordpos         TYPE ish_t_cordpos,
        l_cordpos          LIKE LINE OF lt_cordpos,
        l_srv              TYPE REF TO cl_ishmed_service,
        l_corder           TYPE REF TO cl_ish_corder,
        l_prereg           TYPE REF TO cl_ishmed_prereg,
        l_request          TYPE REF TO cl_ishmed_request,
        l_appointment      TYPE REF TO cl_ish_appointment,
        l_app_constr       TYPE REF TO cl_ish_app_constraint,
        l_service          TYPE REF TO cl_ishmed_service,
        lr_identify        TYPE REF TO if_ish_identify_object.

* Initialisierungen
  REFRESH: et_corders, et_n1corder.
  CLEAR: l_cr_own_env.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Klinische Aufträge aus Einträgen der Objekttabelle ermitteln
  DESCRIBE TABLE it_objects.
  IF sy-tfill > 0.
    IF c_environment IS INITIAL.
      CALL METHOD cl_ishmed_functions=>get_environment
        EXPORTING
          it_objects     = it_objects
          i_caller       = 'CL_ISHMED_FUNCTIONS'
        IMPORTING
          e_env_created  = l_cr_own_env
          e_rc           = e_rc
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDIF.
    LOOP AT it_objects INTO l_object.
*     Typ des Objekts ermitteln
      TRY.
          lr_identify ?= l_object-object.
          IF lr_identify->is_inherited_from( cl_ishmed_request=>co_otype_request )       = on.
*           keine Aufträge zurückliefern, da es eine Anforderung ist!
*         Klinischer Auftrag
          ELSEIF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder )        = on OR
                 lr_identify->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on.
            l_corder ?= l_object-object.
            APPEND l_corder TO et_corders.
*         Auftragsposition (Vormerkung)
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg )       = on OR
                 lr_identify->is_inherited_from( cl_ishmed_cordpos=>co_otype_cordpos_med ) = on.
            l_prereg ?= l_object-object.
            CALL METHOD l_prereg->get_corder
              IMPORTING
                er_corder       = l_corder
                e_rc            = e_rc
              CHANGING
                cr_errorhandler = c_errorhandler.
            IF e_rc = 0.
              APPEND l_corder TO et_corders.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Termin
          ELSEIF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
            l_appointment ?= l_object-object.
*           get appointment constraint for appointment
            CALL METHOD l_appointment->get_app_constraint
              EXPORTING
                i_cancelled_datas = i_cancelled_datas
                ir_environment    = c_environment
              IMPORTING
                e_rc              = e_rc
                er_app_constraint = l_app_constr
              CHANGING
                cr_errorhandler   = c_errorhandler.
            IF e_rc = 0.
              IF NOT l_app_constr IS INITIAL.
                REFRESH lt_cordpos.
*               get order positions for appointment constraint
                CALL METHOD l_app_constr->get_t_cordpos
                  EXPORTING
                    i_cancelled_datas = i_cancelled_datas
                    ir_environment    = c_environment
                    i_read_db         = i_read_db           "MED-40483
                  IMPORTING
                    et_cordpos        = lt_cordpos
                    e_rc              = e_rc
                  CHANGING
                    cr_errorhandler   = c_errorhandler.
                IF e_rc = 0.
*                 get clinical order (header) for position
                  READ TABLE lt_cordpos INTO l_cordpos INDEX 1.
                  IF sy-subrc = 0.
                    CALL METHOD l_cordpos->get_corder
                      EXPORTING
                        ir_environment  = c_environment
                      IMPORTING
                        er_corder       = l_corder
                        e_rc            = e_rc
                      CHANGING
                        cr_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_corder TO et_corders.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Leistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = on.
            l_service ?= l_object-object.
            IF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = on.
              CALL METHOD cl_ishmed_service=>get_op_main_anchor_srv
                EXPORTING
                  i_service        = l_service
                  i_environment    = c_environment
                IMPORTING
                  e_rc             = e_rc
                  e_anchor_service = l_srv
                CHANGING
                  c_errorhandler   = c_errorhandler.
              IF e_rc = 0.
                IF l_srv IS BOUND.
                  l_service = l_srv.
                ENDIF.
              ELSE.
                e_rc = 1.
                EXIT.
              ENDIF.
            ENDIF.
            CALL METHOD cl_ishmed_service=>get_serv_for_anfo_vkg
              EXPORTING
                i_service         = l_service
                i_environment     = c_environment
                i_cancelled_datas = i_cancelled_datas
              IMPORTING
                e_rc              = e_rc
                e_request         = l_request
                e_prereg          = l_prereg
              CHANGING
                c_errorhandler    = c_errorhandler.
            IF e_rc = 0.
              IF l_request IS INITIAL AND NOT l_prereg IS INITIAL.
                CALL METHOD l_prereg->get_corder
                  IMPORTING
                    er_corder       = l_corder
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc = 0.
                  APPEND l_corder TO et_corders.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Bewegung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_outpat_visit=>co_otype_outpat_visit ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_inpat_admis_med=>co_otype_inpat_admis ) = on.
            CALL METHOD l_object-object->('GET_DATA')
              IMPORTING
                e_rc           = e_rc
                e_nbew         = l_nbew
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc = 0.
*             Termin zur Bewegung suchen
              IF NOT l_nbew-falnr IS INITIAL AND
                 NOT l_nbew-lfdnr IS INITIAL.
                SELECT * FROM ntmn INTO l_ntmn UP TO 1 ROWS
                       WHERE  einri  = l_nbew-einri
                       AND    falnr  = l_nbew-falnr
                       AND    tmnlb  = l_nbew-lfdnr
                       AND    bewty  = '4'
                       AND    storn  = off.
                  EXIT.
                ENDSELECT.
                IF sy-subrc = 0 AND NOT l_ntmn-tmnid IS INITIAL.
                  CALL METHOD cl_ish_appointment=>load
                    EXPORTING
                      i_tmnid        = l_ntmn-tmnid
                      i_environment  = c_environment
                    IMPORTING
                      e_rc           = e_rc
                      e_instance     = l_appointment
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc = 0.
*                   get appointment constraint for appointment
                    CALL METHOD l_appointment->get_app_constraint
                      EXPORTING
                        i_cancelled_datas = i_cancelled_datas
                        ir_environment    = c_environment
                      IMPORTING
                        e_rc              = e_rc
                        er_app_constraint = l_app_constr
                      CHANGING
                        cr_errorhandler   = c_errorhandler.
                    IF e_rc = 0.
                      IF NOT l_app_constr IS INITIAL.
                        REFRESH lt_cordpos.
*                       get order positions for appointment constraint
                        CALL METHOD l_app_constr->get_t_cordpos
                          EXPORTING
                            i_cancelled_datas = i_cancelled_datas
                            ir_environment    = c_environment
                            i_read_db         = i_read_db   "MED-40483
                          IMPORTING
                            et_cordpos        = lt_cordpos
                            e_rc              = e_rc
                          CHANGING
                            cr_errorhandler   = c_errorhandler.
                        IF e_rc = 0.
*                         get clinical order (header) for position
                          READ TABLE lt_cordpos INTO l_cordpos INDEX 1.
                          IF sy-subrc = 0.
                            CALL METHOD l_cordpos->get_corder
                              EXPORTING
                                ir_environment  = c_environment
                              IMPORTING
                                er_corder       = l_corder
                                e_rc            = e_rc
                              CHANGING
                                cr_errorhandler = c_errorhandler.
                            IF e_rc = 0.
                              APPEND l_corder TO et_corders.
                            ELSE.
                              e_rc = 1.
                              EXIT.
                            ENDIF.
                          ENDIF.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDIF.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ELSE.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
*        ELSE.
*         anhand dieses Objekts kann kein Auftrag ermittelt werden
          ENDIF.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
    ENDLOOP.
*   destroy local environment
    IF l_cr_own_env = on.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = c_environment.
    ENDIF.
  ENDIF.

  CHECK e_rc = 0.

* Auch als Auftragsdatensätze zurückliefern (falls gewünscht)
  IF et_n1corder IS REQUESTED.
    SORT et_corders.
    DELETE ADJACENT DUPLICATES FROM et_corders.
    LOOP AT et_corders INTO l_corder.
      CALL METHOD l_corder->get_data
        IMPORTING
          es_n1corder     = l_n1corder
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      IF e_rc = 0.
        APPEND l_n1corder TO et_n1corder.
      ELSE.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Doppelte Auftragseinträge rauslöschen
  SORT et_corders.
  DELETE ADJACENT DUPLICATES FROM et_corders.
  SORT et_n1corder BY corderid.
  DELETE ADJACENT DUPLICATES FROM et_n1corder COMPARING corderid.

ENDMETHOD.


METHOD get_patients_and_cases .

  DATA: l_object           LIKE LINE OF it_objects,
        l_pap_key          TYPE rnpap_key,
        l_pap_data         TYPE rnpap_attrib,
        l_npap             TYPE npap,
        l_npat             TYPE npat,
        l_nfal             TYPE nfal,
        l_nlei             TYPE nlei,
        l_nlem             TYPE nlem,
        l_ntmn             TYPE ntmn,
        l_nbew             TYPE nbew,
        l_n1anf            TYPE n1anf,
        l_n1vkg            TYPE n1vkg,
        l_n1corder         TYPE n1corder,
        l_einri            TYPE einri,
        l_patnr            TYPE patnr,
        l_falnr            TYPE falnr,
        l_cr_own_env       TYPE ish_on_off,
        lt_cordpos         TYPE ish_t_cordpos,              "ID 17977
        l_npat_obj         TYPE REF TO cl_ishmed_none_oo_npat,
        l_nfal_obj         TYPE REF TO cl_ishmed_none_oo_nfal,
        l_provpat          TYPE REF TO cl_ish_patient_provisional,
        l_corder           TYPE REF TO cl_ish_corder,
        l_prereg           TYPE REF TO cl_ishmed_prereg,
        l_request          TYPE REF TO cl_ishmed_request,
        l_app_constraint   TYPE REF TO cl_ish_app_constraint,
        l_appointment      TYPE REF TO cl_ish_appointment,
        l_service          TYPE REF TO cl_ishmed_service,
        l_srv              TYPE REF TO cl_ishmed_srv_service,
        l_me_event         TYPE REF TO cl_ishmed_me_event,
        l_me_order         TYPE REF TO cl_ishmed_me_order,
        lr_identify        TYPE REF TO if_ish_identify_object.
  DATA: lr_move            TYPE REF TO cl_ishmed_movement.
  DATA: lr_non_oo_move     TYPE REF TO cl_ishmed_none_oo_nbew.

* Initialisierungen
  REFRESH: et_npat, et_npap, et_nfal,
           et_patients, et_provpat, et_cases.
  CLEAR: l_cr_own_env, l_nfal, l_npat, l_npap.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Patienten/Fälle aus Einträgen der Objekttabelle ermitteln
  DESCRIBE TABLE it_objects.
  IF sy-tfill > 0.
    IF c_environment IS INITIAL.
      CALL METHOD cl_ishmed_functions=>get_environment
        EXPORTING
          it_objects     = it_objects
          i_caller       = 'CL_ISHMED_FUNCTIONS'
        IMPORTING
          e_env_created  = l_cr_own_env
          e_rc           = e_rc
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDIF.

    LOOP AT it_objects INTO l_object.
*     Typ des Objekts ermitteln
      TRY.
          lr_identify ?= l_object-object.
          IF lr_identify->is_inherited_from( cl_ishmed_none_oo_npat=>co_otype_none_oo_npat ) = on.
            l_npat_obj ?= l_object-object.
            APPEND l_npat_obj TO et_patients.
            IF et_npat IS REQUESTED.
              CALL METHOD l_npat_obj->get_data
                IMPORTING
                  e_npat         = l_npat
                  e_rc           = e_rc
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                RETURN.
              ENDIF.
              APPEND l_npat TO et_npat.
            ENDIF.
*         Vorläufiger Patient
          ELSEIF lr_identify->is_inherited_from( cl_ish_patient_provisional=>co_otype_prov_patient ) = on.
            l_provpat ?= l_object-object.
            APPEND l_provpat TO et_provpat.
            IF et_npap IS REQUESTED.
              CALL METHOD l_provpat->get_data
                IMPORTING
                  es_key         = l_pap_key
                  es_data        = l_pap_data
                  e_rc           = e_rc
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              CLEAR l_npap.
              MOVE-CORRESPONDING l_pap_key  TO l_npap.      "#EC ENHOK
              MOVE-CORRESPONDING l_pap_data TO l_npap.      "#EC ENHOK
              APPEND l_npap TO et_npap.
            ENDIF.
*         Fall
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_none_oo_nfal=>co_otype_none_oo_nfal ) = on.
            l_nfal_obj ?= l_object-object.
            APPEND l_nfal_obj TO et_cases.
            IF et_nfal IS REQUESTED OR
               et_npat IS REQUESTED OR et_patients IS REQUESTED.
              CALL METHOD l_nfal_obj->get_data
                IMPORTING
                  e_nfal         = l_nfal
                  e_rc           = e_rc
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc = 0.
                APPEND l_nfal TO et_nfal.
              ELSE.
                e_rc = 1.
                EXIT.
              ENDIF.
            ENDIF.
            IF l_nfal-patnr IS NOT INITIAL
              AND ( et_npat IS REQUESTED OR et_patients IS REQUESTED ).
              CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                EXPORTING
                  i_patnr         = l_nfal-patnr
                  i_read_db       = i_read_db
                IMPORTING
                  es_npat         = l_npat
                  e_rc            = e_rc
                CHANGING
                  cr_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              APPEND l_npat TO et_npat.
              IF et_patients IS REQUESTED.
                CALL METHOD cl_ishmed_none_oo_npat=>load
                  EXPORTING
                    i_einri        = l_npat-einri
                    i_patnr        = l_npat-patnr
                    i_npat         = l_npat
                    i_read_db      = off
                  IMPORTING
                    e_instance     = l_npat_obj
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                APPEND l_npat_obj TO et_patients.
              ENDIF.
            ENDIF.
*         Anforderung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_request=>co_otype_request ) = on.
            l_request ?= l_object-object.
            IF et_npap IS REQUESTED OR et_provpat IS REQUESTED.
*             START MED-40483 2010/06/17
              IF et_npap IS NOT REQUESTED.
                CALL METHOD cl_ishmed_request=>get_patient_provi
                  EXPORTING
                    i_request      = l_request
                    i_environment  = c_environment
                  IMPORTING
                    e_pat_provi    = l_provpat
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                ENDIF.
              ELSE.
*             END MED-40483
                CALL METHOD cl_ishmed_request=>get_patient_provi
                  EXPORTING
                    i_request      = l_request
                    i_environment  = c_environment
                  IMPORTING
                    e_pap_key      = l_pap_key
                    e_pap_data     = l_pap_data
                    e_pat_provi    = l_provpat
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                  CLEAR l_npap.
                  MOVE-CORRESPONDING l_pap_key  TO l_npap.  "#EC ENHOK
                  MOVE-CORRESPONDING l_pap_data TO l_npap.  "#EC ENHOK
                  APPEND l_npap TO et_npap.
                ENDIF.
              ENDIF.                                        "MED-40483
            ENDIF.
            IF et_npat     IS REQUESTED OR et_nfal  IS REQUESTED OR
               et_patients IS REQUESTED OR et_cases IS REQUESTED.
              CALL METHOD l_request->get_data
                IMPORTING
                  e_rc           = e_rc
                  e_n1anf        = l_n1anf
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              IF NOT l_n1anf-falnr IS INITIAL
                AND ( et_nfal  IS REQUESTED OR et_cases IS REQUESTED ). "MED-40483
                CALL FUNCTION 'ISH_READ_NFAL'
                  EXPORTING
                    ss_einri           = l_n1anf-einri
                    ss_falnr           = l_n1anf-falnr
                    ss_read_db         = i_read_db
                    ss_message_no_auth = off                            " BA 2011
                  IMPORTING
                    ss_nfal            = l_nfal
                  EXCEPTIONS
                    not_found          = 1
                    not_found_archived = 2
                    no_authority       = 3
                    OTHERS             = 4.
                IF sy-subrc = 0.
                  APPEND l_nfal TO et_nfal.
                  IF et_cases IS REQUESTED.
                    CALL METHOD cl_ishmed_none_oo_nfal=>load
                      EXPORTING
                        i_einri        = l_nfal-einri
                        i_falnr        = l_nfal-falnr
                        i_nfal         = l_nfal
                        i_read_db      = off
                      IMPORTING
                        e_instance     = l_nfal_obj
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc <> 0.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                    APPEND l_nfal_obj TO et_cases.
                  ENDIF.
                ENDIF.
              ENDIF.
              IF NOT l_n1anf-patnr IS INITIAL
                AND ( et_patients IS REQUESTED OR et_npat IS REQUESTED ). "MED-40483
                CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                  EXPORTING
                    i_patnr         = l_n1anf-patnr
                    i_read_db       = i_read_db
                  IMPORTING
                    es_npat         = l_npat
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                APPEND l_npat TO et_npat.
                IF et_patients IS REQUESTED.
                  CALL METHOD cl_ishmed_none_oo_npat=>load
                    EXPORTING
                      i_einri        = l_npat-einri
                      i_patnr        = l_npat-patnr
                      i_npat         = l_npat
                      i_read_db      = off
                    IMPORTING
                      e_instance     = l_npat_obj
                      e_rc           = e_rc
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc <> 0.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                  APPEND l_npat_obj TO et_patients.
                ENDIF.     " IF et_patients IS REQUESTED.
              ENDIF.     " IF NOT l_n1anf-patnr IS INITIAL
            ENDIF.     " IF et_npat IS REQUESTED OR et_nfal IS REQUESTED
*         Klinischer Auftrag
          ELSEIF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder ) = on .
            l_corder ?= l_object-object.
            IF et_npap IS REQUESTED OR et_provpat IS REQUESTED.
*             START MED-40483 2010/06/17
              IF et_npap IS NOT REQUESTED.
                CALL METHOD l_corder->get_patient_provisional
                  EXPORTING
                    ir_environment         = c_environment
                  IMPORTING
                    er_patient_provisional = l_provpat
                    e_rc                   = e_rc
                  CHANGING
                    cr_errorhandler        = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                ENDIF.
              ELSE.
*             END MED-40483
                CALL METHOD l_corder->get_patient_provisional
                  EXPORTING
                    ir_environment         = c_environment
                  IMPORTING
                    er_patient_provisional = l_provpat
                    es_pap_key             = l_pap_key
                    es_pap_data            = l_pap_data
                    e_rc                   = e_rc
                  CHANGING
                    cr_errorhandler        = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                  CLEAR l_npap.
                  MOVE-CORRESPONDING l_pap_key  TO l_npap.  "#EC ENHOK
                  MOVE-CORRESPONDING l_pap_data TO l_npap.  "#EC ENHOK
                  APPEND l_npap TO et_npap.
                ENDIF.
              ENDIF. " IF et_npap IS NOT REQUESTED.        "MED-40483
            ENDIF.
            IF et_npat     IS REQUESTED OR et_nfal  IS REQUESTED OR
               et_patients IS REQUESTED OR et_cases IS REQUESTED.
              CALL METHOD l_corder->get_data
                IMPORTING
                  es_n1corder     = l_n1corder
                  e_rc            = e_rc
                CHANGING
                  cr_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              IF NOT l_n1corder-patnr IS INITIAL
                AND ( et_patients IS REQUESTED OR et_npat IS REQUESTED ). "MED-40483
                CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                  EXPORTING
                    i_patnr         = l_n1corder-patnr
                    i_read_db       = i_read_db
                  IMPORTING
                    es_npat         = l_npat
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                APPEND l_npat TO et_npat.
                IF et_patients IS REQUESTED.
                  CALL METHOD cl_ishmed_none_oo_npat=>load
                    EXPORTING
                      i_einri        = l_npat-einri
                      i_patnr        = l_npat-patnr
                      i_npat         = l_npat
                      i_read_db      = off
                    IMPORTING
                      e_instance     = l_npat_obj
                      e_rc           = e_rc
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc <> 0.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                  APPEND l_npat_obj TO et_patients.
                ENDIF.    " IF et_patients IS REQUESTED
              ENDIF.    " IF NOT l_n1corder-patnr IS INITIAL
            ENDIF.    " IF et_npat IS REQUESTED OR et_nfal IS REQUESTED
            IF et_nfal IS REQUESTED OR et_cases IS REQUESTED. "ID 17977
              CALL METHOD l_corder->get_t_cordpos
                EXPORTING
                  ir_environment  = c_environment
                IMPORTING
                  et_cordpos      = lt_cordpos
                  e_rc            = e_rc
                CHANGING
                  cr_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              LOOP AT lt_cordpos INTO l_prereg.
                CALL METHOD l_prereg->get_data
                  IMPORTING
                    e_rc           = e_rc
                    e_n1vkg        = l_n1vkg
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_n1vkg-falnr IS INITIAL.
                  CALL FUNCTION 'ISH_READ_NFAL'
                    EXPORTING
                      ss_einri           = l_n1vkg-einri
                      ss_falnr           = l_n1vkg-falnr
                      ss_read_db         = i_read_db
                      ss_message_no_auth = off             " BA 2011
                    IMPORTING
                      ss_nfal            = l_nfal
                    EXCEPTIONS
                      not_found          = 1
                      not_found_archived = 2
                      no_authority       = 3
                      OTHERS             = 4.
                  IF sy-subrc = 0.
                    APPEND l_nfal TO et_nfal.
                    IF et_cases IS REQUESTED.
                      CALL METHOD cl_ishmed_none_oo_nfal=>load
                        EXPORTING
                          i_einri        = l_nfal-einri
                          i_falnr        = l_nfal-falnr
                          i_nfal         = l_nfal
                          i_read_db      = off
                        IMPORTING
                          e_instance     = l_nfal_obj
                          e_rc           = e_rc
                        CHANGING
                          c_errorhandler = c_errorhandler.
                      IF e_rc <> 0.
                        e_rc = 1.
                        EXIT.
                      ENDIF.
                      APPEND l_nfal_obj TO et_cases.
                    ENDIF. "IF et_cases IS REQUESTED
                  ENDIF."IF sy-subrc = 0.
                ENDIF. "IF NOT l_n1vkg-falnr IS INITIAL.
              ENDLOOP.
              IF e_rc <> 0.
                EXIT.
              ENDIF.
            ENDIF.   " IF et_nfal IS REQUESTED OR et_cases IS REQUESTED.
*         Auftragsposition (Vormerkung) + Terminvorgabe
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg ) = on OR
*                 lr_identify->is_inherited_from( cl_ishmed_cordpos=>co_otype_cordpos_med ) = on OR MED-40483 NOT NESSASARY
                 lr_identify->is_inherited_from( cl_ish_app_constraint=>co_otype_app_constraint ) = on.
            TRY.
                l_app_constraint ?= l_object-object.
                CALL METHOD l_app_constraint->get_t_cordpos
                  EXPORTING
                    ir_environment  = c_environment
                    i_read_db       = i_read_db             "MED-40483
                  IMPORTING
                    et_cordpos      = lt_cordpos
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                READ TABLE lt_cordpos INTO l_prereg INDEX 1.
                IF sy-subrc <> 0 OR l_prereg IS INITIAL.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              CATCH cx_sy_move_cast_error.
                l_prereg ?= l_object-object.
            ENDTRY.
            IF et_npap IS REQUESTED OR et_provpat IS REQUESTED.
*             START MED-40483
              IF et_npap IS NOT REQUESTED.
                CALL METHOD cl_ishmed_prereg=>get_patient_provi
                  EXPORTING
                    i_prereg       = l_prereg
                    i_environment  = c_environment
                  IMPORTING
                    e_pat_provi    = l_provpat
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                ENDIF."IF NOT l_provpat IS INITIAL.
              ELSE.
*               END MED-40483
                CALL METHOD cl_ishmed_prereg=>get_patient_provi
                  EXPORTING
                    i_prereg       = l_prereg
                    i_environment  = c_environment
                  IMPORTING
                    e_pap_key      = l_pap_key
                    e_pap_data     = l_pap_data
                    e_pat_provi    = l_provpat
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                  CLEAR l_npap.
                  MOVE-CORRESPONDING l_pap_key  TO l_npap.  "#EC ENHOK
                  MOVE-CORRESPONDING l_pap_data TO l_npap.  "#EC ENHOK
                  APPEND l_npap TO et_npap.
                ENDIF.    " IF NOT l_provpat IS INITIAL.
              ENDIF.    " IF et_npap is not requested.
            ENDIF.    " IF et_npap IS REQUESTED OR et_provpat IS REQUESTED.
            IF et_npat     IS REQUESTED OR et_nfal  IS REQUESTED OR
               et_patients IS REQUESTED OR et_cases IS REQUESTED.
              CALL METHOD l_prereg->get_data
                IMPORTING
                  e_rc           = e_rc
                  e_n1vkg        = l_n1vkg
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              IF NOT l_n1vkg-falnr IS INITIAL
                AND ( et_nfal  IS REQUESTED OR et_cases IS REQUESTED ). "MED-40483
                CALL FUNCTION 'ISH_READ_NFAL'
                  EXPORTING
                    ss_einri           = l_n1vkg-einri
                    ss_falnr           = l_n1vkg-falnr
                    ss_read_db         = i_read_db
                    ss_message_no_auth = off               " BA 2011
                  IMPORTING
                    ss_nfal            = l_nfal
                  EXCEPTIONS
                    not_found          = 1
                    not_found_archived = 2
                    no_authority       = 3
                    OTHERS             = 4.
                IF sy-subrc = 0.
                  APPEND l_nfal TO et_nfal.
                  IF et_cases IS REQUESTED.
                    CALL METHOD cl_ishmed_none_oo_nfal=>load
                      EXPORTING
                        i_einri        = l_nfal-einri
                        i_falnr        = l_nfal-falnr
                        i_nfal         = l_nfal
                        i_read_db      = off
                      IMPORTING
                        e_instance     = l_nfal_obj
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc <> 0.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                    APPEND l_nfal_obj TO et_cases.
                  ENDIF.   " IF et_cases IS REQUESTED.
                ENDIF.   " IF sy-subrc = 0.
              ENDIF.   " IF NOT l_n1vkg-falnr IS INITIAL.
              IF NOT l_n1vkg-patnr IS INITIAL
                 AND ( et_patients IS REQUESTED OR et_npat IS REQUESTED ). "MED-40483
                CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                  EXPORTING
                    i_patnr         = l_n1vkg-patnr
                    i_read_db       = i_read_db
                  IMPORTING
                    es_npat         = l_npat
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                APPEND l_npat TO et_npat.
                IF et_patients IS REQUESTED.
                  CALL METHOD cl_ishmed_none_oo_npat=>load
                    EXPORTING
                      i_einri        = l_npat-einri
                      i_patnr        = l_npat-patnr
                      i_npat         = l_npat
                      i_read_db      = off
                    IMPORTING
                      e_instance     = l_npat_obj
                      e_rc           = e_rc
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc <> 0.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                  APPEND l_npat_obj TO et_patients.
                ENDIF.   " IF et_patients IS REQUESTED
              ENDIF.   " IF NOT l_n1vkg-patnr IS INITIAL
            ENDIF.   " IF et_npat IS REQUESTED OR et_nfal IS REQUESTED
*         Termin
          ELSEIF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
            l_appointment ?= l_object-object.
            IF et_npap IS REQUESTED OR et_provpat IS REQUESTED.
*             START MED-40483
              IF et_npap IS NOT REQUESTED.
                CALL METHOD cl_ish_appointment=>get_patient_provi
                  EXPORTING
                    i_appmnt       = l_appointment
                    i_environment  = c_environment
                  IMPORTING
                    e_pap_key      = l_pap_key
                    e_pap_data     = l_pap_data
                    e_pat_provi    = l_provpat
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                ENDIF.
              ELSE.
*               END MED-40483
                CALL METHOD cl_ish_appointment=>get_patient_provi
                  EXPORTING
                    i_appmnt       = l_appointment
                    i_environment  = c_environment
                  IMPORTING
                    e_pap_key      = l_pap_key
                    e_pap_data     = l_pap_data
                    e_pat_provi    = l_provpat
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                  CLEAR l_npap.
                  MOVE-CORRESPONDING l_pap_key  TO l_npap.  "#EC ENHOK
                  MOVE-CORRESPONDING l_pap_data TO l_npap.  "#EC ENHOK
                  APPEND l_npap TO et_npap.
                ENDIF.
              ENDIF.   " IF et_npap IS NOT REQUESTED.
            ENDIF.
            IF et_npat     IS REQUESTED OR et_nfal  IS REQUESTED OR
               et_patients IS REQUESTED OR et_cases IS REQUESTED.
              CALL METHOD l_appointment->get_data
                EXPORTING
                  i_fill_appointment = off
                IMPORTING
                  es_ntmn            = l_ntmn
                  e_rc               = e_rc
                CHANGING
                  c_errorhandler     = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              IF NOT l_ntmn-falnr IS INITIAL
                AND ( et_nfal  IS REQUESTED OR et_cases IS REQUESTED ). "MED-40483
                CALL FUNCTION 'ISH_READ_NFAL'
                  EXPORTING
                    ss_einri           = l_ntmn-einri
                    ss_falnr           = l_ntmn-falnr
                    ss_read_db         = i_read_db
                    ss_message_no_auth = off               " BA 2011
                  IMPORTING
                    ss_nfal            = l_nfal
                  EXCEPTIONS
                    not_found          = 1
                    not_found_archived = 2
                    no_authority       = 3
                    OTHERS             = 4.
                IF sy-subrc = 0.
                  APPEND l_nfal TO et_nfal.
                  IF et_cases IS REQUESTED.
                    CALL METHOD cl_ishmed_none_oo_nfal=>load
                      EXPORTING
                        i_einri        = l_nfal-einri
                        i_falnr        = l_nfal-falnr
                        i_nfal         = l_nfal
                        i_read_db      = off
                      IMPORTING
                        e_instance     = l_nfal_obj
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc <> 0.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                    APPEND l_nfal_obj TO et_cases.
                  ENDIF.    " IF et_cases IS REQUESTED.
                ENDIF.    " IF sy-subrc = 0.
              ENDIF.    " IF NOT l_ntmn-falnr IS INITIAL.
              IF NOT l_ntmn-patnr IS INITIAL
                 AND ( et_patients IS REQUESTED OR et_npat IS REQUESTED ). "MED-40483.
                CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                  EXPORTING
                    i_patnr         = l_ntmn-patnr
                    i_read_db       = i_read_db
                  IMPORTING
                    es_npat         = l_npat
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                APPEND l_npat TO et_npat.
                IF et_patients IS REQUESTED.
                  CALL METHOD cl_ishmed_none_oo_npat=>load
                    EXPORTING
                      i_einri        = l_npat-einri
                      i_patnr        = l_npat-patnr
                      i_npat         = l_npat
                      i_read_db      = off
                    IMPORTING
                      e_instance     = l_npat_obj
                      e_rc           = e_rc
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc <> 0.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                  APPEND l_npat_obj TO et_patients.
                ENDIF.     " IF et_patients IS REQUESTED
              ENDIF.     " IF NOT l_ntmn-patnr IS INITIAL
            ENDIF.     " IF et_npat IS REQUESTED OR et_nfal IS REQUESTED
*         Leistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = on.
            l_service ?= l_object-object.
            IF et_npap IS REQUESTED OR et_provpat IS REQUESTED.
*             START MED-40483
              IF et_npap IS NOT REQUESTED.
                CALL METHOD cl_ishmed_service=>get_patient_provi
                  EXPORTING
                    i_service      = l_service
                    i_environment  = c_environment
                  IMPORTING
                    e_pat_provi    = l_provpat
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                ENDIF.
              ELSE.
*             END MED-40483
                CALL METHOD cl_ishmed_service=>get_patient_provi
                  EXPORTING
                    i_service      = l_service
                    i_environment  = c_environment
                  IMPORTING
                    e_pap_key      = l_pap_key
                    e_pap_data     = l_pap_data
                    e_pat_provi    = l_provpat
                    e_rc           = e_rc
                  CHANGING
                    c_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                IF NOT l_provpat IS INITIAL.
                  APPEND l_provpat TO et_provpat.
                  CLEAR l_npap.
                  MOVE-CORRESPONDING l_pap_key  TO l_npap.  "#EC ENHOK
                  MOVE-CORRESPONDING l_pap_data TO l_npap.  "#EC ENHOK
                  APPEND l_npap TO et_npap.
                ENDIF.    " IF NOT l_provpat IS INITIAL.
              ENDIF.    " IF et_npap IS NOT REQUESTED.
            ENDIF.
            IF et_npat     IS REQUESTED OR et_nfal  IS REQUESTED OR
               et_patients IS REQUESTED OR et_cases IS REQUESTED.
              CALL METHOD l_service->get_data
                IMPORTING
                  e_rc           = e_rc
                  e_nlei         = l_nlei
                  e_nlem         = l_nlem
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              IF NOT l_nlei-falnr IS INITIAL
                AND ( et_nfal  IS REQUESTED OR et_cases IS REQUESTED ). "MED-40483
                CALL FUNCTION 'ISH_READ_NFAL'
                  EXPORTING
                    ss_einri           = l_nlei-einri
                    ss_falnr           = l_nlei-falnr
                    ss_read_db         = i_read_db
                    ss_message_no_auth = off               " BA 2011
                  IMPORTING
                    ss_nfal            = l_nfal
                  EXCEPTIONS
                    not_found          = 1
                    not_found_archived = 2
                    no_authority       = 3
                    OTHERS             = 4.
                IF sy-subrc = 0.
                  APPEND l_nfal TO et_nfal.
                  IF et_cases IS REQUESTED.
                    CALL METHOD cl_ishmed_none_oo_nfal=>load
                      EXPORTING
                        i_einri        = l_nfal-einri
                        i_falnr        = l_nfal-falnr
                        i_nfal         = l_nfal
                        i_read_db      = off
                      IMPORTING
                        e_instance     = l_nfal_obj
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc <> 0.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                    APPEND l_nfal_obj TO et_cases.
                  ENDIF.    " IF et_cases IS REQUESTED.
                ENDIF.    " IF sy-subrc = 0.
              ENDIF.    " IF NOT l_nlei-falnr IS INITIAL
              IF NOT l_nlem-patnr IS INITIAL
                AND ( et_npat     IS REQUESTED OR et_patients IS REQUESTED ). "MED-40483
                CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                  EXPORTING
                    i_patnr         = l_nlem-patnr
                    i_read_db       = i_read_db
                  IMPORTING
                    es_npat         = l_npat
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                APPEND l_npat TO et_npat.
                IF et_patients IS REQUESTED.
                  CALL METHOD cl_ishmed_none_oo_npat=>load
                    EXPORTING
                      i_einri        = l_npat-einri
                      i_patnr        = l_npat-patnr
                      i_npat         = l_npat
                      i_read_db      = off
                    IMPORTING
                      e_instance     = l_npat_obj
                      e_rc           = e_rc
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc <> 0.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                  APPEND l_npat_obj TO et_patients.
                ENDIF.      " IF et_patients IS REQUESTED
              ENDIF.      " IF NOT l_nlem-patnr IS INITIAL
            ENDIF.      " IF et_npat IS REQUESTED OR et_nfal IS REQUESTED
*         Bewegung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew ) = on OR
*           START MED-40483
                 lr_identify->is_inherited_from( cl_ishmed_movement=>co_otype_movement ) = abap_true.
*                  lr_identify->is_inherited_from( cl_ishmed_outpat_visit=>co_otype_outpat_visit ) = on OR
*                  lr_identify->is_inherited_from( cl_ishmed_inpat_admis_med=>co_otype_inpat_admis ) = on.
*                  CALL METHOD l_object-object->('GET_DATA')
*                    IMPORTING
*                      e_rc           = e_rc
*                      e_nbew         = l_nbew
*                    CHANGING
*                      c_errorhandler = c_errorhandler.
            TRY .
                lr_move ?= l_object-object.
                CALL METHOD lr_move->get_data
                  EXPORTING
                    i_fill_mvmt    = space
                  IMPORTING
                    e_rc           = e_rc
                    e_nbew         = l_nbew
                  CHANGING
                    c_errorhandler = c_errorhandler.
              CATCH cx_sy_move_cast_error.
                TRY .
                    lr_non_oo_move ?= l_object-object.
                    CALL METHOD lr_non_oo_move->get_data
                      IMPORTING
                        e_rc           = e_rc
                        e_nbew         = l_nbew
                      CHANGING
                        c_errorhandler = c_errorhandler.
                  CATCH cx_sy_move_cast_error.
                    CONTINUE.
                ENDTRY.
            ENDTRY.
            IF e_rc <> 0.
              e_rc = 1.
              EXIT.
            ENDIF.
*           END MED-40483
            IF et_npat     IS REQUESTED OR et_nfal  IS REQUESTED OR
               et_patients IS REQUESTED OR et_cases IS REQUESTED.
              IF NOT l_nbew-falnr IS INITIAL.
                CALL FUNCTION 'ISH_READ_NFAL'
                  EXPORTING
                    ss_einri           = l_nbew-einri
                    ss_falnr           = l_nbew-falnr
                    ss_read_db         = i_read_db
                    ss_message_no_auth = off               " BA 2011
                  IMPORTING
                    ss_nfal            = l_nfal
                  EXCEPTIONS
                    not_found          = 1
                    not_found_archived = 2
                    no_authority       = 3
                    OTHERS             = 4.
                IF sy-subrc = 0.
                  APPEND l_nfal TO et_nfal.
                  IF et_cases IS REQUESTED.
                    CALL METHOD cl_ishmed_none_oo_nfal=>load
                      EXPORTING
                        i_einri        = l_nfal-einri
                        i_falnr        = l_nfal-falnr
                        i_nfal         = l_nfal
                        i_read_db      = off
                      IMPORTING
                        e_instance     = l_nfal_obj
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc <> 0.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                    APPEND l_nfal_obj TO et_cases.
                  ENDIF.    " IF et_cases IS REQUESTED.
                ENDIF.    " IF sy-subrc = 0.
              ENDIF.    " IF NOT l_nbew-falnr IS INITIAL.
              IF NOT l_nfal-patnr IS INITIAL
                AND ( et_npat     IS REQUESTED OR et_patients IS REQUESTED ). "MED-40483
                CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                  EXPORTING
                    i_patnr         = l_nfal-patnr
                    i_read_db       = i_read_db
                  IMPORTING
                    es_npat         = l_npat
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                APPEND l_npat TO et_npat.
                IF et_patients IS REQUESTED.
                  CALL METHOD cl_ishmed_none_oo_npat=>load
                    EXPORTING
                      i_einri        = l_npat-einri
                      i_patnr        = l_npat-patnr
                      i_npat         = l_npat
                      i_read_db      = off
                    IMPORTING
                      e_instance     = l_npat_obj
                      e_rc           = e_rc
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc <> 0.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                  APPEND l_npat_obj TO et_patients.
                ENDIF.     " IF et_patients IS REQUESTED
              ENDIF.     " IF NOT l_nfal-patnr IS INITIAL
            ENDIF.     " IF et_npat IS REQUESTED OR et_nfal IS REQUESTED
*         Medical Event
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_me_event=>co_otype_me_event ) = on.
            l_me_event ?= l_object-object.
            IF et_npat     IS REQUESTED OR et_nfal  IS REQUESTED OR
               et_patients IS REQUESTED OR et_cases IS REQUESTED.
              CLEAR: l_einri, l_falnr.
              CALL METHOD l_me_event->if_ish_objectbase~get_data_field
                EXPORTING
                  i_fieldname    = 'EINRI'
                IMPORTING
                  e_rc           = e_rc
                  e_field        = l_einri
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              CALL METHOD l_me_event->if_ish_objectbase~get_data_field
                EXPORTING
                  i_fieldname    = 'FALNR'
                IMPORTING
                  e_rc           = e_rc
                  e_field        = l_falnr
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
              IF NOT l_einri IS INITIAL AND NOT l_falnr IS INITIAL.
                CALL FUNCTION 'ISH_READ_NFAL'
                  EXPORTING
                    ss_einri           = l_einri
                    ss_falnr           = l_falnr
                    ss_read_db         = i_read_db
                    ss_message_no_auth = off               " BA 2011
                  IMPORTING
                    ss_nfal            = l_nfal
                  EXCEPTIONS
                    not_found          = 1
                    not_found_archived = 2
                    no_authority       = 3
                    OTHERS             = 4.
                IF sy-subrc = 0.
                  APPEND l_nfal TO et_nfal.
                  IF et_cases IS REQUESTED.
                    CALL METHOD cl_ishmed_none_oo_nfal=>load
                      EXPORTING
                        i_einri        = l_nfal-einri
                        i_falnr        = l_nfal-falnr
                        i_nfal         = l_nfal
                        i_read_db      = off
                      IMPORTING
                        e_instance     = l_nfal_obj
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_nfal_obj TO et_cases.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.
                  IF NOT l_nfal-patnr IS INITIAL
                    AND ( et_npat     IS REQUESTED OR et_patients IS REQUESTED ). "MED-40483
                    CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                      EXPORTING
                        i_patnr         = l_nfal-patnr
                        i_read_db       = i_read_db
                      IMPORTING
                        es_npat         = l_npat
                        e_rc            = e_rc
                      CHANGING
                        cr_errorhandler = c_errorhandler.
                    IF e_rc <> 0.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                    APPEND l_npat TO et_npat.
                    IF et_patients IS REQUESTED.
                      CALL METHOD cl_ishmed_none_oo_npat=>load
                        EXPORTING
                          i_einri        = l_npat-einri
                          i_patnr        = l_npat-patnr
                          i_npat         = l_npat
                          i_read_db      = off
                        IMPORTING
                          e_instance     = l_npat_obj
                          e_rc           = e_rc
                        CHANGING
                          c_errorhandler = c_errorhandler.
                      IF e_rc <> 0.
                        e_rc = 1.
                        EXIT.
                      ENDIF.
                      APPEND l_npat_obj TO et_patients.
                    ENDIF.   " IF et_patients IS REQUESTED
                  ENDIF.   " IF NOT l_nfal-patnr IS INITIAL
                ENDIF.   " IF sy-subrc = 0
              ENDIF.   " IF NOT l_einri+l_falnr IS INITIAL
            ENDIF.   " IF et_npat IS REQUESTED OR et_nfal IS REQUESTED
*         Medical Order
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_me_order=>co_otype_me_order ) = on.
            l_me_order ?= l_object-object.
            CLEAR: l_einri, l_falnr, l_patnr.
            CALL METHOD l_me_order->if_ish_objectbase~get_data_field
              EXPORTING
                i_fieldname    = 'EINRI'
              IMPORTING
                e_rc           = e_rc
                e_field        = l_einri
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc <> 0.
              e_rc = 1.
              EXIT.
            ENDIF.
            CALL METHOD l_me_order->if_ish_objectbase~get_data_field
              EXPORTING
                i_fieldname    = 'PATNR'
              IMPORTING
                e_rc           = e_rc
                e_field        = l_patnr
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc <> 0.
              e_rc = 1.
              EXIT.
            ENDIF.
            CALL METHOD l_me_order->if_ish_objectbase~get_data_field
              EXPORTING
                i_fieldname    = 'FALNR'
              IMPORTING
                e_rc           = e_rc
                e_field        = l_falnr
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc <> 0.
              e_rc = 1.
              EXIT.
            ENDIF.

            IF NOT l_einri IS INITIAL.
              IF NOT l_patnr IS INITIAL
                AND ( et_npat     IS REQUESTED OR et_patients IS REQUESTED ). "MED-40483
                CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                  EXPORTING
                    i_patnr         = l_patnr
                    i_read_db       = i_read_db
                  IMPORTING
                    es_npat         = l_npat
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
                APPEND l_npat TO et_npat.
                IF et_patients IS REQUESTED.
                  CALL METHOD cl_ishmed_none_oo_npat=>load
                    EXPORTING
                      i_einri        = l_npat-einri
                      i_patnr        = l_npat-patnr
                      i_npat         = l_npat
                      i_read_db      = off
                    IMPORTING
                      e_instance     = l_npat_obj
                      e_rc           = e_rc
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc <> 0.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                  APPEND l_npat_obj TO et_patients.
                ENDIF.    " IF et_patients IS REQUESTED.
              ENDIF.    " IF NOT l_patnr IS INITIAL.
              IF NOT l_falnr IS INITIAL
                AND ( et_nfal  IS REQUESTED OR et_cases IS REQUESTED ). "MED-40483.
                CALL FUNCTION 'ISH_READ_NFAL'
                  EXPORTING
                    ss_einri           = l_einri
                    ss_falnr           = l_falnr
                    ss_read_db         = i_read_db
                    ss_message_no_auth = off               " BA 2011
                  IMPORTING
                    ss_nfal            = l_nfal
                  EXCEPTIONS
                    not_found          = 1
                    not_found_archived = 2
                    no_authority       = 3
                    OTHERS             = 4.
                IF sy-subrc = 0.
                  APPEND l_nfal TO et_nfal.
                  IF et_cases IS REQUESTED.
                    CALL METHOD cl_ishmed_none_oo_nfal=>load
                      EXPORTING
                        i_einri        = l_nfal-einri
                        i_falnr        = l_nfal-falnr
                        i_nfal         = l_nfal
                        i_read_db      = off
                      IMPORTING
                        e_instance     = l_nfal_obj
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_nfal_obj TO et_cases.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.         " IF et_cases IS REQUESTED.
                ENDIF.         " IF sy-subrc = 0.
              ENDIF.         " IF NOT l_falnr IS INITIAL.
            ENDIF.         " IF NOT l_einri IS INITIAL.
*         Pflegeleistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_srv_service=>co_otype_srv_service ) = on.
            IF et_npat IS NOT REQUESTED AND et_patients IS NOT REQUESTED . "MED-40483
              CONTINUE.                                     "MED-40483
            ENDIF.                                          "MED-40483
            l_srv ?= l_object-object.
            CLEAR: l_einri, l_patnr.
            l_einri = l_srv->get_einri( ).
            l_patnr = l_srv->get_patnr( ).
            IF NOT l_einri IS INITIAL.
              IF NOT l_patnr IS INITIAL.
                CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
                  EXPORTING
                    i_patnr         = l_patnr
                    i_read_db       = i_read_db
                  IMPORTING
                    es_npat         = l_npat
                    e_rc            = e_rc
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc = 0.
                  APPEND l_npat TO et_npat.
                  IF et_patients IS REQUESTED.
                    CALL METHOD cl_ishmed_none_oo_npat=>load
                      EXPORTING
                        i_einri        = l_npat-einri
                        i_patnr        = l_npat-patnr
                        i_npat         = l_npat
                        i_read_db      = off
                      IMPORTING
                        e_instance     = l_npat_obj
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_npat_obj TO et_patients.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.     " IF et_patients IS REQUESTED.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDIF.                 " IF NOT l_patnr IS INITIAL.
            ENDIF.         " IF NOT l_einri IS INITIAL.
*          ELSE.
*           ... anhand dieses Objekts keine Daten ermittelbar
          ENDIF.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
    ENDLOOP.

*   destroy local environment
    IF l_cr_own_env = on.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = c_environment.
    ENDIF.
  ENDIF.

  CHECK e_rc = 0.

* Doppelte Patienten/Fall-Einträge rauslöschen
  SORT et_cases.
  DELETE ADJACENT DUPLICATES FROM et_cases.
  SORT et_patients.
  DELETE ADJACENT DUPLICATES FROM et_patients.
  SORT et_provpat.
  DELETE ADJACENT DUPLICATES FROM et_provpat.
  SORT et_npat BY patnr.
  DELETE ADJACENT DUPLICATES FROM et_npat COMPARING patnr.
  SORT et_npap BY papid.
  DELETE ADJACENT DUPLICATES FROM et_npap COMPARING papid.
  SORT et_nfal BY falnr.
  DELETE ADJACENT DUPLICATES FROM et_nfal COMPARING falnr.

ENDMETHOD.


METHOD get_preregistrations .

  DATA: l_object           LIKE LINE OF it_objects,
        l_cr_own_env       TYPE ish_on_off,
        l_n1vkg            LIKE LINE OF et_n1vkg,
        l_nbew             TYPE nbew,
        l_ntmn             TYPE ntmn,
        lt_cordpos         TYPE ish_t_cordpos,
*        lt_services        TYPE ish_objectlist,
*        l_serv_obj         LIKE LINE OF lt_services,
        l_corder           TYPE REF TO cl_ish_corder,
        l_prereg           TYPE REF TO cl_ishmed_prereg,
        l_request          TYPE REF TO cl_ishmed_request,
        l_appointment      TYPE REF TO cl_ish_appointment,
        l_app_constr       TYPE REF TO cl_ish_app_constraint,
        l_service          TYPE REF TO cl_ishmed_service,
        lr_identify        TYPE REF TO if_ish_identify_object.

* Initialisierungen
  REFRESH: et_preregs, et_n1vkg.
  CLEAR: l_cr_own_env.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Auftragspositionen aus Einträgen der Objekttabelle ermitteln
  DESCRIBE TABLE it_objects.
  IF sy-tfill > 0.
    IF c_environment IS INITIAL.
      CALL METHOD cl_ishmed_functions=>get_environment
        EXPORTING
          it_objects     = it_objects
          i_caller       = 'CL_ISHMED_FUNCTIONS'
        IMPORTING
          e_env_created  = l_cr_own_env
          e_rc           = e_rc
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDIF.
    LOOP AT it_objects INTO l_object.
*     Typ des Objekts ermitteln
      TRY.
          lr_identify ?= l_object-object.

          IF lr_identify->is_inherited_from( cl_ishmed_request=>co_otype_request ) = on.
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_cordpos=>co_otype_cordpos_med ) = on.
            l_prereg ?= l_object-object.
            APPEND l_prereg TO et_preregs.
*         Klinischer Auftrag
          ELSEIF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on.
*         Exclude is necessary for printing single positions of a marked
*         clinical order. The positions are selected later on in an
*         dialog (see also => method call_clinical_order_print).
            IF i_exclude_corder = space.
              l_corder ?= l_object-object.
              CALL METHOD l_corder->get_t_cordpos
                IMPORTING
                  et_cordpos      = et_preregs
                  e_rc            = e_rc
                CHANGING
                  cr_errorhandler = c_errorhandler.
              IF e_rc <> 0.
                e_rc = 1.
                EXIT.
              ENDIF.
            ENDIF.
*         Termin
          ELSEIF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
            l_appointment ?= l_object-object.
*           get appointment constraint for appointment
            CALL METHOD l_appointment->get_app_constraint
              EXPORTING
                i_cancelled_datas = i_cancelled_datas
                ir_environment    = c_environment
              IMPORTING
                e_rc              = e_rc
                er_app_constraint = l_app_constr
              CHANGING
                cr_errorhandler   = c_errorhandler.
            IF e_rc = 0.
              IF NOT l_app_constr IS INITIAL.
                REFRESH lt_cordpos.
*               get order positions for appointment constraint
                CALL METHOD l_app_constr->get_t_cordpos
                  EXPORTING
                    i_cancelled_datas = i_cancelled_datas
                    ir_environment    = c_environment
                    i_read_db         = i_read_db           "MED-40483
                  IMPORTING
                    et_cordpos        = lt_cordpos
                    e_rc              = e_rc
                  CHANGING
                    cr_errorhandler   = c_errorhandler.
                IF e_rc = 0.
                  APPEND LINES OF lt_cordpos TO et_preregs.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Leistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = on.
            l_service ?= l_object-object.
*          not necessary to get service out of op anchor service,
*          because clinical order position can be found for the
*          main op anchor service now!
*          IF l_object_type =
*             cl_ishmed_service=>co_otype_anchor_srv.
*            CALL METHOD cl_ishmed_service=>get_serv_for_op
*              EXPORTING
*                i_service         = l_service
*                i_environment     = c_environment
*                i_cancelled_datas = i_cancelled_datas
*              IMPORTING
*                e_rc              = e_rc
*                et_services       = lt_services
*              CHANGING
*                c_errorhandler    = c_errorhandler.
*            IF e_rc = 0.
*              READ TABLE lt_services INTO l_serv_obj INDEX 1.
*              IF sy-subrc = 0.
*                l_service ?= l_serv_obj-object.
*              ENDIF.
*            ELSE.
*              e_rc = 1.
*              EXIT.
*            ENDIF.
*          ENDIF.
            CALL METHOD cl_ishmed_service=>get_serv_for_anfo_vkg
              EXPORTING
                i_service         = l_service
                i_environment     = c_environment
                i_cancelled_datas = i_cancelled_datas
              IMPORTING
                e_rc              = e_rc
                e_request         = l_request
                e_prereg          = l_prereg
              CHANGING
                c_errorhandler    = c_errorhandler.
            IF e_rc = 0.
              IF l_request IS INITIAL AND NOT l_prereg IS INITIAL.
                APPEND l_prereg TO et_preregs.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*           Bewegung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_outpat_visit=>co_otype_outpat_visit ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_inpat_admis_med=>co_otype_inpat_admis ) = on.
            CALL METHOD l_object-object->('GET_DATA')
              IMPORTING
                e_rc           = e_rc
                e_nbew         = l_nbew
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc = 0.
*             Termin zur Bewegung suchen
              IF NOT l_nbew-falnr IS INITIAL AND
                 NOT l_nbew-lfdnr IS INITIAL.
                SELECT * FROM ntmn INTO l_ntmn UP TO 1 ROWS
                       WHERE  einri  = l_nbew-einri
                       AND    falnr  = l_nbew-falnr
                       AND    tmnlb  = l_nbew-lfdnr
                       AND    bewty  = '4'
                       AND    storn  = off.
                  EXIT.
                ENDSELECT.
                IF sy-subrc = 0 AND NOT l_ntmn-tmnid IS INITIAL.
                  CALL METHOD cl_ish_appointment=>load
                    EXPORTING
                      i_tmnid        = l_ntmn-tmnid
                      i_environment  = c_environment
                    IMPORTING
                      e_rc           = e_rc
                      e_instance     = l_appointment
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc = 0.
*                   get appointment constraint for appointment
                    CALL METHOD l_appointment->get_app_constraint
                      EXPORTING
                        i_cancelled_datas = i_cancelled_datas
                        ir_environment    = c_environment
                      IMPORTING
                        e_rc              = e_rc
                        er_app_constraint = l_app_constr
                      CHANGING
                        cr_errorhandler   = c_errorhandler.
                    IF e_rc = 0.
                      IF NOT l_app_constr IS INITIAL.
                        REFRESH lt_cordpos.
*                       get order positions for appointment constraint
                        CALL METHOD l_app_constr->get_t_cordpos
                          EXPORTING
                            i_cancelled_datas = i_cancelled_datas
                            ir_environment    = c_environment
                            i_read_db         = i_read_db   "MED-40483
                          IMPORTING
                            et_cordpos        = lt_cordpos
                            e_rc              = e_rc
                          CHANGING
                            cr_errorhandler   = c_errorhandler.
                        IF e_rc = 0.
                          APPEND LINES OF lt_cordpos TO et_preregs.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDIF.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ELSE.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
*          ELSE.
*           anhand dieses Objekts keine Auftragsposition ermittelbar
          ENDIF.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
    ENDLOOP.
*   destroy local environment
    IF l_cr_own_env = on.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = c_environment.
    ENDIF.
  ENDIF.

  CHECK e_rc = 0.

* Auch als Auftragspositionsdatensätze zurückliefern (falls gewünscht)
  IF et_n1vkg IS REQUESTED.
    SORT et_preregs.
    DELETE ADJACENT DUPLICATES FROM et_preregs.
    LOOP AT et_preregs INTO l_prereg.
      CALL METHOD l_prereg->get_data
        IMPORTING
          e_rc           = e_rc
          e_n1vkg        = l_n1vkg
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc = 0.
        APPEND l_n1vkg TO et_n1vkg.
      ELSE.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Doppelte Auftragspositionseinträge rauslöschen
  SORT et_preregs.
  DELETE ADJACENT DUPLICATES FROM et_preregs.
  SORT et_n1vkg BY vkgid.
  DELETE ADJACENT DUPLICATES FROM et_n1vkg COMPARING vkgid.

ENDMETHOD.


METHOD get_requests .

  DATA: l_object           LIKE LINE OF it_objects,
        l_n1anf            LIKE LINE OF et_n1anf,
        l_nbew             TYPE nbew,
        l_ntmn             TYPE ntmn,
        l_cr_own_env       TYPE ish_on_off,
        lt_services        TYPE ish_objectlist,
        l_serv_obj         LIKE LINE OF lt_services,
        l_request          TYPE REF TO cl_ishmed_request,
        l_appointment      TYPE REF TO cl_ish_appointment,
        l_service          TYPE REF TO cl_ishmed_service.
  DATA: lr_identify        TYPE REF TO if_ish_identify_object.

* Initialisierungen
  REFRESH: et_requests, et_n1anf.
  CLEAR: l_cr_own_env.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Anforderungen aus Einträgen der Objekttabelle ermitteln
  DESCRIBE TABLE it_objects.
  IF sy-tfill > 0.
    IF c_environment IS INITIAL.
      CALL METHOD cl_ishmed_functions=>get_environment
        EXPORTING
          it_objects     = it_objects
          i_caller       = 'CL_ISHMED_FUNCTIONS'
        IMPORTING
          e_env_created  = l_cr_own_env
          e_rc           = e_rc
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDIF.
    LOOP AT it_objects INTO l_object.
*     Typ des Objekts ermitteln
      TRY.
          lr_identify ?= l_object-object.
          IF lr_identify->is_inherited_from( cl_ishmed_request=>co_otype_request ) = on.
            l_request ?= l_object-object.
            APPEND l_request TO et_requests.
*         Klinischer Auftrag
          ELSEIF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on.
*           keine Anforderung zurückliefern, da es ein Klin. Auftrag ist!
*         Auftragsposition (Vormerkung)
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_cordpos=>co_otype_cordpos_med ) = on.
*           keine Anforderung zurückliefern, da es eine Auftragspos. ist!
*         Termin
          ELSEIF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
            l_appointment ?= l_object-object.
            REFRESH lt_services.
            CALL METHOD cl_ish_appointment=>get_services_for_appmnt
              EXPORTING
                i_appointment     = l_appointment
                i_environment     = c_environment
                i_cancelled_datas = i_cancelled_datas
                i_read_db         = i_read_db               "MED-40483
              IMPORTING
                e_rc              = e_rc
                et_services       = lt_services
              CHANGING
                c_errorhandler    = c_errorhandler.
            IF e_rc = 0.
              LOOP AT lt_services INTO l_serv_obj.
                CLEAR l_request.
                l_service ?= l_serv_obj-object.
                CALL METHOD cl_ishmed_service=>get_serv_for_anfo_vkg
                  EXPORTING
                    i_service         = l_service
                    i_environment     = c_environment
                    i_cancelled_datas = i_cancelled_datas
                  IMPORTING
                    e_rc              = e_rc
                    e_request         = l_request
                  CHANGING
                    c_errorhandler    = c_errorhandler.
                IF e_rc = 0.
                  IF NOT l_request IS INITIAL.
                    APPEND l_request TO et_requests.
                    CONTINUE.                          " request found!
                  ENDIF.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDLOOP.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Leistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = on.
            l_service ?= l_object-object.
            IF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv ) = on.
              CALL METHOD cl_ishmed_service=>get_serv_for_op
                EXPORTING
                  i_service         = l_service
                  i_environment     = c_environment
                  i_cancelled_datas = i_cancelled_datas
                  i_read_db         = i_read_db             "MED-40483
                IMPORTING
                  e_rc              = e_rc
                  et_services       = lt_services
                CHANGING
                  c_errorhandler    = c_errorhandler.
              IF e_rc = 0.
                READ TABLE lt_services INTO l_serv_obj INDEX 1.
                IF sy-subrc = 0.
                  l_service ?= l_serv_obj-object.
                ELSE.
                  CONTINUE.   " no services found for searching request
                ENDIF.
              ELSE.
                e_rc = 1.
                EXIT.
              ENDIF.
            ENDIF.
            CALL METHOD cl_ishmed_service=>get_serv_for_anfo_vkg
              EXPORTING
                i_service         = l_service
                i_environment     = c_environment
                i_cancelled_datas = i_cancelled_datas
              IMPORTING
                e_rc              = e_rc
                e_request         = l_request
              CHANGING
                c_errorhandler    = c_errorhandler.
            IF e_rc = 0.
              IF NOT l_request IS INITIAL.
                APPEND l_request TO et_requests.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Bewegung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew  )  = on OR
                 lr_identify->is_inherited_from( cl_ishmed_outpat_visit=>co_otype_outpat_visit )   = on OR
                 lr_identify->is_inherited_from( cl_ishmed_inpat_admis_med=>co_otype_inpat_admis ) = on.
            CALL METHOD l_object-object->('GET_DATA')
              IMPORTING
                e_rc           = e_rc
                e_nbew         = l_nbew
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc = 0.
*             Termin zur Bewegung suchen
              IF NOT l_nbew-falnr IS INITIAL AND
                 NOT l_nbew-lfdnr IS INITIAL.
                SELECT * FROM ntmn INTO l_ntmn UP TO 1 ROWS
                       WHERE  einri  = l_nbew-einri
                       AND    falnr  = l_nbew-falnr
                       AND    tmnlb  = l_nbew-lfdnr
                       AND    bewty  = '4'
                       AND    storn  = off.
                  EXIT.
                ENDSELECT.
                IF sy-subrc = 0 AND NOT l_ntmn-tmnid IS INITIAL.
                  CALL METHOD cl_ish_appointment=>load
                    EXPORTING
                      i_tmnid        = l_ntmn-tmnid
                      i_environment  = c_environment
                    IMPORTING
                      e_rc           = e_rc
                      e_instance     = l_appointment
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc = 0.
                    REFRESH lt_services.
                    CALL METHOD cl_ish_appointment=>get_services_for_appmnt
                      EXPORTING
                        i_appointment     = l_appointment
                        i_environment     = c_environment
                        i_cancelled_datas = i_cancelled_datas
                        i_read_db         = i_read_db       "MED-40483
                      IMPORTING
                        e_rc              = e_rc
                        et_services       = lt_services
                      CHANGING
                        c_errorhandler    = c_errorhandler.
                    IF e_rc = 0.
                      LOOP AT lt_services INTO l_serv_obj.
                        CLEAR l_request.
                        l_service ?= l_serv_obj-object.
                        CALL METHOD cl_ishmed_service=>get_serv_for_anfo_vkg
                          EXPORTING
                            i_service         = l_service
                            i_environment     = c_environment
                            i_cancelled_datas = i_cancelled_datas
                          IMPORTING
                            e_rc              = e_rc
                            e_request         = l_request
                          CHANGING
                            c_errorhandler    = c_errorhandler.
                        IF e_rc = 0.
                          IF NOT l_request IS INITIAL.
                            APPEND l_request TO et_requests.
                            EXIT.         " request found!
                          ENDIF.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDLOOP.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ELSE.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*          ELSE.
*           anhand dieses Objekts kann keine Anforderung ermittelt werden
          ENDIF.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
    ENDLOOP.
*   destroy local environment
    IF l_cr_own_env = on.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = c_environment.
    ENDIF.
  ENDIF.

  CHECK e_rc = 0.

* Auch als Anforderungsdatensätze zurückliefern (falls gewünscht)
  IF et_n1anf IS REQUESTED.
    SORT et_requests.
    DELETE ADJACENT DUPLICATES FROM et_requests.
    LOOP AT et_requests INTO l_request.
      CALL METHOD l_request->get_data
        IMPORTING
          e_rc           = e_rc
          e_n1anf        = l_n1anf
        CHANGING
          c_errorhandler = c_errorhandler.
      IF e_rc = 0.
        APPEND l_n1anf TO et_n1anf.
      ELSE.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Doppelte Anforderungseinträge rauslöschen
  SORT et_requests.
  DELETE ADJACENT DUPLICATES FROM et_requests.
  SORT et_n1anf BY anfid.
  DELETE ADJACENT DUPLICATES FROM et_n1anf COMPARING anfid.

ENDMETHOD.


METHOD get_services .

  DATA: l_object           LIKE LINE OF it_objects,
        l_cr_own_env       TYPE ish_on_off,
        l_nbew             TYPE nbew,
        lt_srv             TYPE ish_objectlist,
        l_srv              LIKE LINE OF lt_srv,
        lt_nlei            TYPE ishmed_t_nlei,
        l_nlei             LIKE LINE OF lt_nlei,
        lt_nlem            TYPE ishmed_t_nlem,
        l_nlem             LIKE LINE OF lt_nlem,
        lt_v_nlem          TYPE TABLE OF v_nlem,
        l_v_nlem           LIKE LINE OF lt_v_nlem,
        l_request          TYPE REF TO cl_ishmed_request,
        l_prereg           TYPE REF TO cl_ishmed_prereg,
        l_corder           TYPE REF TO cl_ish_corder,
        l_appointment      TYPE REF TO cl_ish_appointment,
        l_app_constr       TYPE REF TO cl_ish_app_constraint,
        l_service          TYPE REF TO cl_ishmed_service,
        l_service_tmp      TYPE REF TO cl_ishmed_service,
        l_service_an       TYPE REF TO cl_ishmed_service.

  DATA: lt_services_sort        LIKE et_services,
        lt_anchor_services_sort LIKE et_anchor_services,
        l_service_sort          TYPE REF TO cl_ishmed_service,
        lt_cordpos              TYPE ish_t_cordpos,
        lt_nlei_sort            LIKE et_nlei,
        lt_nlem_sort            LIKE et_nlem.
  DATA: lr_identify       TYPE REF TO if_ish_identify_object.

* Initialisierungen
  REFRESH: et_nlei, et_nlem, et_services,
           et_anchor_nlei, et_anchor_nlem, et_anchor_services.
  CLEAR: l_cr_own_env.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Leistungen aus Einträgen der Objekttabelle ermitteln
  DESCRIBE TABLE it_objects.
  IF sy-tfill > 0.
    IF c_environment IS INITIAL.
      CALL METHOD cl_ishmed_functions=>get_environment
        EXPORTING
          it_objects     = it_objects
          i_caller       = 'CL_ISHMED_FUNCTIONS'
        IMPORTING
          e_env_created  = l_cr_own_env
          e_rc           = e_rc
        CHANGING
          c_environment  = c_environment
          c_errorhandler = c_errorhandler.
      IF e_rc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDIF.
    LOOP AT it_objects INTO l_object.
*     Typ des Objekts ermitteln
      TRY.
          lr_identify ?= l_object-object.
          IF lr_identify->is_inherited_from( cl_ish_corder=>co_otype_corder ) = on OR
             lr_identify->is_inherited_from( cl_ishmed_corder=>co_otype_corder_med ) = on.
*           Leistungen hängen unter den Auftragspositionen
            l_corder ?= l_object-object.
            REFRESH lt_cordpos.
            CALL METHOD l_corder->get_t_cordpos
              EXPORTING
                i_cancelled_datas = i_cancelled_datas
                ir_environment    = c_environment
              IMPORTING
                et_cordpos        = lt_cordpos
                e_rc              = e_rc
              CHANGING
                cr_errorhandler   = c_errorhandler.
            IF e_rc = 0.
              LOOP AT lt_cordpos INTO l_prereg.
                REFRESH: lt_srv.
                CALL METHOD cl_ishmed_prereg=>get_services_for_prereg
                  EXPORTING
                    i_prereg          = l_prereg
                    i_environment     = c_environment
                    i_cancelled_datas = i_cancelled_datas
                    i_read_db         = i_read_db           "MED-40483
                  IMPORTING
                    e_rc              = e_rc
                    et_services       = lt_srv
                  CHANGING
                    c_errorhandler    = c_errorhandler.
                IF e_rc = 0.
*                 Leistungen zurückliefern
                  LOOP AT lt_srv INTO l_srv.
                    l_service ?= l_srv-object.
                    APPEND l_service TO et_services.
                    IF et_nlei IS REQUESTED OR et_nlem IS REQUESTED.
                      CALL METHOD l_service->get_data
                        IMPORTING
                          e_rc           = e_rc
                          e_nlei         = l_nlei
                          e_nlem         = l_nlem
                        CHANGING
                          c_errorhandler = c_errorhandler.
                      IF e_rc = 0.
                        APPEND l_nlei TO et_nlei.
                        APPEND l_nlem TO et_nlem.
                      ELSE.
                        e_rc = 1.
                        EXIT.
                      ENDIF.
                    ENDIF.
                  ENDLOOP.
                  IF e_rc <> 0.
                    EXIT.
                  ENDIF.
*                 Haupt-OP-Ankerleistung zur Auftragsposition
                  CALL METHOD l_prereg->get_op_main_anchor_srv
                    EXPORTING
                      i_cancelled_datas = i_cancelled_datas
                      ir_environment    = c_environment
                    IMPORTING
                      er_anchor_service = l_service_tmp
                      e_rc              = e_rc
                    CHANGING
                      cr_errorhandler   = c_errorhandler.
                  IF e_rc                = 0   AND
                     i_only_main_anchor  = off AND
                     l_service_tmp      IS NOT INITIAL.
*                   AN-Ankerleistung zur Haupt-OP-Ankerleistung suchen
                    CALL METHOD cl_ishmed_service=>get_serv_for_op
                      EXPORTING
                        i_service         = l_service_tmp
                        i_environment     = c_environment
                        i_cancelled_datas = i_cancelled_datas
                        i_read_db         = i_read_db       "MED-40483
                      IMPORTING
                        e_rc              = e_rc
                        e_an_anchor_srv   = l_service_an
                      CHANGING
                        c_errorhandler    = c_errorhandler.
                  ENDIF.
                  IF e_rc <> 0.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
*                 OP-Ankerleistung zurückliefern
                  IF l_service_tmp IS NOT INITIAL.
                    APPEND l_service_tmp TO et_anchor_services.
                    IF et_anchor_nlei IS REQUESTED OR
                       et_anchor_nlem IS REQUESTED.
                      CALL METHOD l_service_tmp->get_data
                        IMPORTING
                          e_rc           = e_rc
                          e_nlei         = l_nlei
                          e_nlem         = l_nlem
                        CHANGING
                          c_errorhandler = c_errorhandler.
                      IF e_rc = 0.
                        APPEND l_nlei TO et_anchor_nlei.
                        APPEND l_nlem TO et_anchor_nlem.
                      ELSE.
                        e_rc = 1.
                        EXIT.
                      ENDIF.
                    ENDIF.
                  ENDIF.
*                 AN-Ankerleistung zurückliefern
                  IF l_service_an IS NOT INITIAL.
                    APPEND l_service_an TO et_anchor_services.
                    IF et_anchor_nlei IS REQUESTED OR
                       et_anchor_nlem IS REQUESTED.
                      CALL METHOD l_service_an->get_data
                        IMPORTING
                          e_rc           = e_rc
                          e_nlei         = l_nlei
                          e_nlem         = l_nlem
                        CHANGING
                          c_errorhandler = c_errorhandler.
                      IF e_rc = 0.
                        APPEND l_nlei TO et_anchor_nlei.
                        APPEND l_nlem TO et_anchor_nlem.
                      ELSE.
                        e_rc = 1.
                        EXIT.
                      ENDIF.
                    ENDIF.
                  ENDIF.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDLOOP.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Anforderung oder Auftragsposition (Vormerkung)
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_request=>co_otype_request ) = on  OR
             lr_identify->is_inherited_from( cl_ishmed_prereg=>co_otype_prereg )       = on  OR
             lr_identify->is_inherited_from( cl_ishmed_cordpos=>co_otype_cordpos_med ) = on.
            REFRESH: lt_srv, lt_nlei, lt_nlem.
            IF lr_identify->is_inherited_from( cl_ishmed_request=>co_otype_request ) = on.
              l_request ?= l_object-object.
              CALL METHOD cl_ishmed_request=>get_services_for_request
                EXPORTING
                  i_request         = l_request
                  i_environment     = c_environment
                  i_cancelled_datas = i_cancelled_datas
                  i_read_db         = i_read_db             "MED-40483
                IMPORTING
                  e_rc              = e_rc
                  et_services       = lt_srv
                CHANGING
                  c_errorhandler    = c_errorhandler.
            ELSE.
              l_prereg ?= l_object-object.
              CALL METHOD cl_ishmed_prereg=>get_services_for_prereg
                EXPORTING
                  i_prereg          = l_prereg
                  i_environment     = c_environment
                  i_cancelled_datas = i_cancelled_datas
                  i_read_db         = i_read_db             "MED-40483
                IMPORTING
                  e_rc              = e_rc
                  et_services       = lt_srv
                CHANGING
                  c_errorhandler    = c_errorhandler.
            ENDIF.
            IF e_rc = 0.
*             Leistungen zurückliefern
              LOOP AT lt_srv INTO l_srv.
                l_service ?= l_srv-object.
                APPEND l_service TO et_services.
                IF et_nlei IS REQUESTED OR et_nlem IS REQUESTED.
                  CALL METHOD l_service->get_data
                    IMPORTING
                      e_rc           = e_rc
                      e_nlei         = l_nlei
                      e_nlem         = l_nlem
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc = 0.
                    APPEND l_nlei TO et_nlei.
                    APPEND l_nlem TO et_nlem.
                  ELSE.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDLOOP.
              IF e_rc <> 0.
                EXIT.
              ENDIF.
              IF NOT l_prereg IS INITIAL.
*               Haupt-OP-Ankerleistung zur Auftragsposition
                CALL METHOD l_prereg->get_op_main_anchor_srv
                  EXPORTING
                    i_cancelled_datas = i_cancelled_datas
*                   I_CREATE          = ON
                    ir_environment    = c_environment
                  IMPORTING
                    er_anchor_service = l_service_tmp
                    e_rc              = e_rc
                  CHANGING
                    cr_errorhandler   = c_errorhandler.
                IF e_rc = 0 AND i_only_main_anchor = off AND
                   NOT l_service_tmp IS INITIAL.
*                 AN-Ankerleistung zur Haupt-OP-Ankerleistung suchen
                  CALL METHOD cl_ishmed_service=>get_serv_for_op
                    EXPORTING
                      i_service         = l_service_tmp
                      i_environment     = c_environment
                      i_cancelled_datas = i_cancelled_datas
                      i_read_db         = i_read_db         "MED-40483
                    IMPORTING
                      e_rc              = e_rc
                      e_an_anchor_srv   = l_service_an
                    CHANGING
                      c_errorhandler    = c_errorhandler.
                ENDIF.
                IF e_rc <> 0.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDIF.
*             Ankerleistungen aus der 1. Leistung ermitteln
              IF l_prereg IS INITIAL OR l_service_tmp IS INITIAL.
                CLEAR: l_service_tmp, l_service_an.
                READ TABLE lt_srv INTO l_srv INDEX 1.
                IF sy-subrc = 0.
                  l_service ?= l_srv-object.
                  IF i_only_main_anchor = on.
*                   Haupt-OP-Ankerleistung zur Leistung
                    CALL METHOD cl_ishmed_service=>get_op_main_anchor_srv
                      EXPORTING
                        i_service        = l_service
                        i_environment    = c_environment
                      IMPORTING
                        e_rc             = e_rc
                        e_anchor_service = l_service_tmp
                      CHANGING
                        c_errorhandler   = c_errorhandler.
                  ELSE.
*                   Haupt-OP- und AN-Ankerleistung zur Leistung
                    CALL METHOD cl_ishmed_service=>get_serv_for_op
                      EXPORTING
                        i_service         = l_service
                        i_environment     = c_environment
                        i_cancelled_datas = i_cancelled_datas
                        i_read_db         = i_read_db       "MED-40483
                      IMPORTING
                        e_rc              = e_rc
                        e_anchor_service  = l_service_tmp
                        e_an_anchor_srv   = l_service_an
                      CHANGING
                        c_errorhandler    = c_errorhandler.
                  ENDIF.
                ENDIF.    " IF sy-subrc = 0.
              ENDIF.
              IF e_rc = 0.
*               OP-Ankerleistung zurückliefern
                IF NOT l_service_tmp IS INITIAL.
                  APPEND l_service_tmp TO et_anchor_services.
                  IF et_anchor_nlei IS REQUESTED OR
                     et_anchor_nlem IS REQUESTED.
                    CALL METHOD l_service_tmp->get_data
                      IMPORTING
                        e_rc           = e_rc
                        e_nlei         = l_nlei
                        e_nlem         = l_nlem
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_nlei TO et_anchor_nlei.
                      APPEND l_nlem TO et_anchor_nlem.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ENDIF.
*               AN-Ankerleistung zurückliefern
                IF NOT l_service_an IS INITIAL.
                  APPEND l_service_an TO et_anchor_services.
                  IF et_anchor_nlei IS REQUESTED OR
                     et_anchor_nlem IS REQUESTED.
                    CALL METHOD l_service_an->get_data
                      IMPORTING
                        e_rc           = e_rc
                        e_nlei         = l_nlei
                        e_nlem         = l_nlem
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_nlei TO et_anchor_nlei.
                      APPEND l_nlem TO et_anchor_nlem.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ENDIF.
              ELSE.
                e_rc = 1.
                EXIT.
              ENDIF.    " IF e_rc = 0.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Termin + Terminvorgabe
          ELSEIF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment )       = on OR
                 lr_identify->is_inherited_from( cl_ish_app_constraint=>co_otype_app_constraint ) = on.
            REFRESH: lt_srv, lt_nlei, lt_nlem.
            IF lr_identify->is_inherited_from( cl_ish_appointment=>co_otype_appointment ) = on.
              l_appointment ?= l_object-object.
*             START MED-40483 2010/07/05
              IF i_only_main_anchor = abap_true AND
                 i_conn_srv = abap_false.
                CLEAR l_service.
                CALL METHOD l_appointment->get_op_main_anchor_srv
                  IMPORTING
                    e_rc            = e_rc
                    er_service      = l_service
                  CHANGING
                    cr_errorhandler = c_errorhandler.
                IF e_rc <> 0.
                  EXIT.
                ENDIF.
                IF l_service IS BOUND.
                  CLEAR l_srv.
                  l_srv-object = l_service.
                  APPEND l_srv TO lt_srv.
                ENDIF.
              ELSE.
                CALL METHOD cl_ish_appointment=>get_services_for_appmnt
                  EXPORTING
                    i_appointment     = l_appointment
                    i_environment     = c_environment
                    i_cancelled_datas = i_cancelled_datas
                    i_read_db         = i_read_db           "MED-40483
                  IMPORTING
                    e_rc              = e_rc
                    et_services       = lt_srv
                  CHANGING
                    c_errorhandler    = c_errorhandler.
              ENDIF.
*             END MED-40483
            ELSE.
              l_app_constr ?= l_object-object.
            ENDIF.
            IF e_rc = 0.
              IF NOT lt_srv[] IS INITIAL.
                LOOP AT lt_srv INTO l_srv.
                  l_service ?= l_srv-object.
                  CALL METHOD l_service->get_data
                    IMPORTING
                      e_rc           = e_rc
                      e_nlei         = l_nlei
                      e_nlem         = l_nlem
                    CHANGING
                      c_errorhandler = c_errorhandler.
                  IF e_rc = 0.
                    APPEND l_nlei TO lt_nlei.
                    APPEND l_nlem TO lt_nlem.
                    IF l_nlem-ankls IS INITIAL.
                      APPEND l_service TO et_services.
                    ELSE.
                      IF i_only_main_anchor = on AND l_nlem-ankls <> 'X'.
                        CONTINUE.
                      ENDIF.
                      APPEND l_service TO et_anchor_services.
                    ENDIF.
                  ELSE.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                ENDLOOP.
              ELSE.
*               if appointment is connected with a clinical order
*               position, get anchor services for order position
*               get appointment constraint for appointment first
                IF l_app_constr IS NOT BOUND.
                  CALL METHOD l_appointment->get_app_constraint
                    EXPORTING
                      i_cancelled_datas = i_cancelled_datas
                      ir_environment    = c_environment
                    IMPORTING
                      e_rc              = e_rc
                      er_app_constraint = l_app_constr
                    CHANGING
                      cr_errorhandler   = c_errorhandler.
                ENDIF.
                IF e_rc = 0.
                  IF NOT l_app_constr IS INITIAL.
                    REFRESH lt_cordpos.
*                   get order positions for appointment constraint
                    CALL METHOD l_app_constr->get_t_cordpos
                      EXPORTING
                        i_cancelled_datas = i_cancelled_datas
                        ir_environment    = c_environment
                        i_read_db         = i_read_db       "MED-40483
                      IMPORTING
                        et_cordpos        = lt_cordpos
                        e_rc              = e_rc
                      CHANGING
                        cr_errorhandler   = c_errorhandler.
                    IF e_rc = 0.
*                     get main anchor service for order positions
                      LOOP AT lt_cordpos INTO l_prereg.
                        CALL METHOD l_prereg->get_op_main_anchor_srv
                          EXPORTING
                            i_cancelled_datas = i_cancelled_datas
*                           I_CREATE          = ON
                            ir_environment    = c_environment
                          IMPORTING
                            er_anchor_service = l_service_tmp
                            e_rc              = e_rc
                          CHANGING
                            cr_errorhandler   = c_errorhandler.
                        IF e_rc = 0.
                          IF NOT l_service_tmp IS INITIAL.
                            APPEND l_service_tmp TO et_anchor_services.
                            IF et_anchor_nlei IS REQUESTED OR
                               et_anchor_nlem IS REQUESTED.
                              CALL METHOD l_service_tmp->get_data
                                IMPORTING
                                  e_rc           = e_rc
                                  e_nlei         = l_nlei
                                  e_nlem         = l_nlem
                                CHANGING
                                  c_errorhandler = c_errorhandler.
                              IF e_rc = 0.
                                APPEND l_nlei TO et_anchor_nlei.
                                APPEND l_nlem TO et_anchor_nlem.
                              ELSE.
                                e_rc = 1.
                                EXIT.
                              ENDIF.
                            ENDIF.
                            IF i_only_main_anchor = off.
*                             get AN-anchor-service
                              CALL METHOD cl_ishmed_service=>get_serv_for_op
                                EXPORTING
                                  i_service         = l_service_tmp
                                  i_environment     = c_environment
                                  i_cancelled_datas = i_cancelled_datas
                                  i_read_db         = i_read_db "MED-40483
                                IMPORTING
                                  e_rc              = e_rc
                                  e_an_anchor_srv   = l_service_an
                                CHANGING
                                  c_errorhandler    = c_errorhandler.
                              IF e_rc = 0.
                                IF NOT l_service_an IS INITIAL.
                                  APPEND l_service_an TO
                                         et_anchor_services.
                                  IF et_anchor_nlei IS REQUESTED OR
                                     et_anchor_nlem IS REQUESTED.
                                    CALL METHOD l_service_an->get_data
                                      IMPORTING
                                        e_rc           = e_rc
                                        e_nlei         = l_nlei
                                        e_nlem         = l_nlem
                                      CHANGING
                                        c_errorhandler = c_errorhandler.
                                    IF e_rc = 0.
                                      APPEND l_nlei TO et_anchor_nlei.
                                      APPEND l_nlem TO et_anchor_nlem.
                                    ELSE.
                                      e_rc = 1.
                                      EXIT.
                                    ENDIF.
                                  ENDIF.
                                ENDIF.
                              ELSE.
                                e_rc = 1.
                                EXIT.
                              ENDIF.
                            ENDIF.
                          ENDIF.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDLOOP.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ELSE.
                  e_rc = 1.
                  EXIT.
                ENDIF.
              ENDIF.
              IF e_rc <> 0.
                EXIT.
              ENDIF.
              IF et_nlei IS REQUESTED OR et_nlem IS REQUESTED.
                LOOP AT lt_nlem INTO l_nlem
                                WHERE ankls IS INITIAL.
                  READ TABLE lt_nlei INTO l_nlei
                             WITH KEY lnrls = l_nlem-lnrls.
                  CHECK sy-subrc = 0.
                  APPEND l_nlei TO et_nlei.
                  APPEND l_nlem TO et_nlem.
                ENDLOOP.
              ENDIF.
              IF et_anchor_nlei IS REQUESTED OR
                 et_anchor_nlem IS REQUESTED.
                LOOP AT lt_nlem INTO l_nlem
                                WHERE NOT ankls IS INITIAL.
                  IF i_only_main_anchor = on AND l_nlem-ankls <> 'X'.
                    CONTINUE.
                  ENDIF.
                  READ TABLE lt_nlei INTO l_nlei
                             WITH KEY lnrls = l_nlem-lnrls.
                  CHECK sy-subrc = 0.
                  APPEND l_nlei TO et_anchor_nlei.
                  APPEND l_nlem TO et_anchor_nlem.
                ENDLOOP.
              ENDIF.
            ELSE.
              e_rc = 1.
              EXIT.
            ENDIF.
*         Leistung oder Ankerleistung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on OR
                 lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_anchor_srv )  = on.
            l_service ?= l_object-object.
            IF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on.
              APPEND l_service TO et_services.
            ELSE.
              APPEND l_service TO et_anchor_services.
            ENDIF.
            IF et_nlei        IS REQUESTED OR
               et_nlem        IS REQUESTED OR
               et_anchor_nlei IS REQUESTED OR
               et_anchor_nlem IS REQUESTED.
              CALL METHOD l_service->get_data
                IMPORTING
                  e_rc           = e_rc
                  e_nlei         = l_nlei
                  e_nlem         = l_nlem
                CHANGING
                  c_errorhandler = c_errorhandler.
              IF e_rc = 0.
                IF l_nlem-ankls IS INITIAL.
                  APPEND l_nlei TO et_nlei.
                  APPEND l_nlem TO et_nlem.
                ELSE.
                  IF ( i_only_main_anchor = on AND l_nlem-ankls = 'X' )
                    OR i_only_main_anchor = off.
                    APPEND l_nlei TO et_anchor_nlei.
                    APPEND l_nlem TO et_anchor_nlem.
                  ENDIF.
                ENDIF.
              ELSE.
                e_rc = 1.
                EXIT.
              ENDIF.
            ENDIF.
*           Von der Leistung abhängige Leistungen lesen ...
            IF i_conn_srv = on.
              IF lr_identify->is_inherited_from( cl_ishmed_service=>co_otype_med_service ) = on.
                IF et_anchor_nlei     IS REQUESTED OR
                   et_anchor_nlem     IS REQUESTED OR
                   et_anchor_services IS REQUESTED.
*                 ... Ankerleistung zur Leistung
                  CALL METHOD cl_ishmed_service=>get_op_main_anchor_srv
                    EXPORTING
                      i_service        = l_service
                      i_environment    = c_environment
                    IMPORTING
                      e_rc             = e_rc
                      e_anchor_service = l_service_tmp
                    CHANGING
                      c_errorhandler   = c_errorhandler.
                  IF e_rc = 0.
                    IF NOT l_service_tmp IS INITIAL.
                      APPEND l_service_tmp TO et_anchor_services.
                      IF et_anchor_nlei IS REQUESTED OR
                         et_anchor_nlem IS REQUESTED.
                        CALL METHOD l_service_tmp->get_data
                          IMPORTING
                            e_rc           = e_rc
                            e_nlei         = l_nlei
                            e_nlem         = l_nlem
                          CHANGING
                            c_errorhandler = c_errorhandler.
                        IF e_rc = 0.
                          APPEND l_nlei TO et_anchor_nlei.
                          APPEND l_nlem TO et_anchor_nlem.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDIF.
                    ENDIF.
                  ELSE.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                ENDIF.
              ELSE.
                IF et_nlei IS REQUESTED OR et_nlem IS REQUESTED OR
                   et_services IS REQUESTED.
*                 ... Leistungen zur Ankerleistung
                  REFRESH lt_srv.
                  CALL METHOD cl_ishmed_service=>get_serv_for_op
                    EXPORTING
*                     I_ZOTYP           = 'F'
                      i_service         = l_service
                      i_environment     = c_environment
                      i_cancelled_datas = i_cancelled_datas
                      i_read_db         = i_read_db         "MED-40483
                    IMPORTING
                      e_rc              = e_rc
                      et_services       = lt_srv
                    CHANGING
                      c_errorhandler    = c_errorhandler.
                  IF e_rc = 0.
                    IF et_services IS REQUESTED.
                      LOOP AT lt_srv INTO l_srv.
                        l_service_tmp ?= l_srv-object.
                        APPEND l_service_tmp TO et_services.
                      ENDLOOP.
                    ENDIF.
                    IF et_nlei IS REQUESTED OR et_nlem IS REQUESTED.
                      LOOP AT lt_srv INTO l_srv.
                        l_service_tmp ?= l_srv-object.
                        CALL METHOD l_service_tmp->get_data
                          IMPORTING
                            e_rc           = e_rc
                            e_nlei         = l_nlei
                            e_nlem         = l_nlem
                          CHANGING
                            c_errorhandler = c_errorhandler.
                        IF e_rc = 0.
                          APPEND l_nlei TO et_nlei.
                          APPEND l_nlem TO et_nlem.
                        ELSE.
                          e_rc = 1.
                          EXIT.
                        ENDIF.
                      ENDLOOP.
                    ENDIF.
                  ELSE.
                    e_rc = 1.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
*         Bewegung
          ELSEIF lr_identify->is_inherited_from( cl_ishmed_none_oo_nbew=>co_otype_none_oo_nbew )   = on OR
                 lr_identify->is_inherited_from( cl_ishmed_outpat_visit=>co_otype_outpat_visit )   = on OR
                 lr_identify->is_inherited_from( cl_ishmed_inpat_admis_med=>co_otype_inpat_admis ) = on.
            CALL METHOD l_object-object->('GET_DATA')
              IMPORTING
                e_rc           = e_rc
                e_nbew         = l_nbew
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc = 0.
              REFRESH: lt_v_nlem, lt_nlei, lt_nlem.
              IF i_cancelled_datas = off.
                SELECT * FROM nlei INTO TABLE lt_nlei
                         WHERE einri   = l_nbew-einri
                           AND falnr   = l_nbew-falnr
                           AND lfdbew  = l_nbew-lfdnr
                           AND storn   = off.
              ELSE.
                SELECT * FROM nlei INTO TABLE lt_nlei
                         WHERE einri   = l_nbew-einri
                           AND falnr   = l_nbew-falnr
                           AND lfdbew  = l_nbew-lfdnr.
              ENDIF.
              IF sy-subrc = 0.
                SELECT * FROM nlem INTO TABLE lt_nlem
                       FOR ALL ENTRIES IN lt_nlei
                       WHERE  lnrls  = lt_nlei-lnrls.
                SORT lt_nlem BY lnrls.
                LOOP AT lt_nlei INTO l_nlei.
                  READ TABLE lt_nlem INTO l_nlem WITH KEY lnrls = l_nlei-lnrls
                             BINARY SEARCH.
                  CHECK sy-subrc = 0.
                  CLEAR l_v_nlem.
                  MOVE-CORRESPONDING l_nlei TO l_v_nlem.    "#EC ENHOK
                  MOVE-CORRESPONDING l_nlem TO l_v_nlem.    "#EC ENHOK
                  APPEND l_v_nlem TO lt_v_nlem.
                  IF l_v_nlem-ankls IS INITIAL.
                    APPEND l_nlei TO et_nlei.
                    APPEND l_nlem TO et_nlem.
                  ELSE.
                    IF i_only_main_anchor = on AND l_v_nlem-ankls <> 'X'.
                      CONTINUE.
                    ENDIF.
                    APPEND l_nlei TO et_anchor_nlei.
                    APPEND l_nlem TO et_anchor_nlem.
                  ENDIF.
                ENDLOOP.
                IF et_services IS REQUESTED.
                  LOOP AT lt_v_nlem INTO l_v_nlem WHERE ankls IS INITIAL.
                    CALL METHOD cl_ishmed_service=>load
                      EXPORTING
                        i_lnrls        = l_v_nlem-lnrls
                        i_environment  = c_environment
                      IMPORTING
                        e_instance     = l_service
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_service TO et_services.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDLOOP.
                  IF e_rc <> 0.
                    EXIT.
                  ENDIF.
                ENDIF.
                IF et_anchor_services IS REQUESTED.
                  LOOP AT lt_v_nlem INTO l_v_nlem
                          WHERE NOT ankls IS INITIAL.
                    IF i_only_main_anchor = on AND l_v_nlem-ankls <> 'X'.
                      CONTINUE.
                    ENDIF.
                    CALL METHOD cl_ishmed_service=>load
                      EXPORTING
                        i_lnrls        = l_v_nlem-lnrls
                        i_environment  = c_environment
                      IMPORTING
                        e_instance     = l_service
                        e_rc           = e_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF e_rc = 0.
                      APPEND l_service TO et_anchor_services.
                    ELSE.
                      e_rc = 1.
                      EXIT.
                    ENDIF.
                  ENDLOOP.
                  IF e_rc <> 0.
                    EXIT.
                  ENDIF.
                ENDIF.
              ENDIF.
            ENDIF.
*          ELSE.
*           anhand dieser Daten kann keine Leistung ermittelt werden
          ENDIF.

        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
    ENDLOOP.
*   destroy local environment
    IF l_cr_own_env = on.
      CALL METHOD cl_ish_utl_base=>destroy_env
        CHANGING
          cr_environment = c_environment.
    ENDIF.
  ENDIF.

  CHECK e_rc = 0.

* Doppelte Leistungs-Einträge rauslöschen
  IF i_no_sort_change = off.
    SORT et_services.
    DELETE ADJACENT DUPLICATES FROM et_services.
    SORT et_nlei BY lnrls.
    DELETE ADJACENT DUPLICATES FROM et_nlei COMPARING lnrls.
    SORT et_nlem BY lnrls.
    DELETE ADJACENT DUPLICATES FROM et_nlem COMPARING lnrls.
    SORT et_anchor_services.
    DELETE ADJACENT DUPLICATES FROM et_anchor_services.
    SORT et_anchor_nlei BY lnrls.
    DELETE ADJACENT DUPLICATES FROM et_anchor_nlei COMPARING lnrls.
    SORT et_anchor_nlem BY lnrls.
    DELETE ADJACENT DUPLICATES FROM et_anchor_nlem COMPARING lnrls.
  ELSE.
*   delete duplicates from service objects
    IF NOT et_services[] IS INITIAL.
      DESCRIBE TABLE et_services.
      IF sy-tfill > 1.
        REFRESH: lt_services_sort.
        lt_services_sort[] = et_services[].
        SORT lt_services_sort.
        DELETE ADJACENT DUPLICATES FROM lt_services_sort.
        LOOP AT et_services INTO l_service.
          CLEAR l_service_sort.
          READ TABLE lt_services_sort FROM l_service
                                      INTO l_service_sort
                                      COMPARING ALL FIELDS.
          IF sy-subrc = 4 OR l_service <> l_service_sort.
            DELETE et_services.
          ELSE.
            DELETE lt_services_sort INDEX sy-tabix.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
*   delete duplicates from services
    IF NOT et_nlei[] IS INITIAL.
      DESCRIBE TABLE et_nlei.
      IF sy-tfill > 1.
        REFRESH: lt_nlei_sort.
        lt_nlei_sort[] = et_nlei[].
        SORT lt_nlei_sort BY lnrls.
        DELETE ADJACENT DUPLICATES FROM lt_nlei_sort COMPARING lnrls.
        LOOP AT et_nlei INTO l_nlei.
          READ TABLE lt_nlei_sort WITH KEY lnrls = l_nlei-lnrls
                                  TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.
            DELETE et_nlei.
          ELSE.
            DELETE lt_nlei_sort INDEX sy-tabix.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
*   delete duplicates from services medical
    IF NOT et_nlem[] IS INITIAL.
      DESCRIBE TABLE et_nlem.
      IF sy-tfill > 1.
        REFRESH: lt_nlem_sort.
        lt_nlem_sort[] = et_nlem[].
        SORT lt_nlem_sort BY lnrls.
        DELETE ADJACENT DUPLICATES FROM lt_nlem_sort COMPARING lnrls.
        LOOP AT et_nlem INTO l_nlem.
          READ TABLE lt_nlem_sort WITH KEY lnrls = l_nlem-lnrls
                                  TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.
            DELETE et_nlem.
          ELSE.
            DELETE lt_nlem_sort INDEX sy-tabix.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
*   delete duplicates from anchor service objects
    IF NOT et_anchor_services[] IS INITIAL.
      DESCRIBE TABLE et_anchor_services.
      IF sy-tfill > 1.
        REFRESH: lt_anchor_services_sort.
        lt_anchor_services_sort[] = et_anchor_services[].
        SORT lt_anchor_services_sort.
        DELETE ADJACENT DUPLICATES FROM lt_anchor_services_sort.
        LOOP AT et_anchor_services INTO l_service.
          CLEAR l_service_sort.
          READ TABLE lt_anchor_services_sort FROM l_service
                                             INTO l_service_sort
                                             COMPARING ALL FIELDS.
          IF sy-subrc = 4 OR l_service <> l_service_sort.
            DELETE et_anchor_services.
          ELSE.
            DELETE lt_anchor_services_sort INDEX sy-tabix.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
*   delete duplicates from anchor services
    IF NOT et_anchor_nlei[] IS INITIAL.
      DESCRIBE TABLE et_anchor_nlei.
      IF sy-tfill > 1.
        REFRESH: lt_nlei_sort.
        lt_nlei_sort[] = et_anchor_nlei[].
        SORT lt_nlei_sort BY lnrls.
        DELETE ADJACENT DUPLICATES FROM lt_nlei_sort COMPARING lnrls.
        LOOP AT et_anchor_nlei INTO l_nlei.
          READ TABLE lt_nlei_sort WITH KEY lnrls = l_nlei-lnrls
                                  TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.
            DELETE et_anchor_nlei.
          ELSE.
            DELETE lt_nlei_sort INDEX sy-tabix.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
*   delete duplicates from anchor services medical
    IF NOT et_anchor_nlem[] IS INITIAL.
      DESCRIBE TABLE et_anchor_nlem.
      IF sy-tfill > 1.
        REFRESH: lt_nlem_sort.
        lt_nlem_sort[] = et_anchor_nlem[].
        SORT lt_nlem_sort BY lnrls.
        DELETE ADJACENT DUPLICATES FROM lt_nlem_sort COMPARING lnrls.
        LOOP AT et_anchor_nlem INTO l_nlem.
          READ TABLE lt_nlem_sort WITH KEY lnrls = l_nlem-lnrls
                                  TRANSPORTING NO FIELDS.
          IF sy-subrc <> 0.
            DELETE et_anchor_nlem.
          ELSE.
            DELETE lt_nlem_sort INDEX sy-tabix.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD npol_refresh.
* Fichte, MED-46010: Method created
  DATA: lt_nfal   TYPE ishmed_t_nfal,
        lt_npat   TYPE ishmed_t_npat.
  FIELD-SYMBOLS:
        <ls_nfal> TYPE nfal,
        <ls_npat> TYPE npat.

* Initialization
  e_rc = 0.
  CHECK it_objects[] IS NOT INITIAL.

  CLEAR: lt_nfal[],
         lt_npat[].
  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
      i_read_db      = on
    IMPORTING
      e_rc           = e_rc
      et_nfal        = lt_nfal
      et_npat	       = lt_npat
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  LOOP AT lt_nfal ASSIGNING <ls_nfal>.
    IF <ls_nfal>-falnr IS NOT INITIAL.
      CALL FUNCTION 'ISH_CASE_POOL_REFRESH'
        EXPORTING
          ss_falnr                  = <ls_nfal>-falnr
          ss_einri                  = i_einri.
    ENDIF.

    IF <ls_nfal>-patnr IS NOT INITIAL.
      CALL FUNCTION 'ISH_PATIENT_POOL_REFRESH'
        EXPORTING
          ss_patnr       = <ls_nfal>-patnr.
    ENDIF.
  ENDLOOP.

  LOOP AT lt_npat ASSIGNING <ls_npat>.
    IF <ls_npat>-patnr IS NOT INITIAL.
      CALL FUNCTION 'ISH_PATIENT_POOL_REFRESH'
        EXPORTING
          ss_patnr       = <ls_npat>-patnr.
    ENDIF.
  ENDLOOP.
ENDMETHOD.


METHOD switch_and_delete_npap .

  DATA: l_pap                TYPE REF TO cl_ish_patient_provisional,
        l_pap_key            TYPE rnpap_key,
        l_pap_data           TYPE rnpap_attrib,
        l_patnr              TYPE patnr,
        l_npap               TYPE npap,
        l_npat               TYPE npat,
        l_cr_own_env         TYPE ish_on_off,
        l_rc                 TYPE ish_method_rc,
        l_can                TYPE xfeld.

  CLEAR: e_rc, l_cr_own_env.

* Vorläufiger Patient muß übergeben werden
  IF i_provpat IS INITIAL AND i_papid IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Wenn nötig Objekt zur Fehlerbehandlung instanzieren
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

  CLEAR: l_npat, l_npap, l_can, l_patnr, l_pap_key, l_pap.

  IF NOT i_provpat IS INITIAL.
    l_pap = i_provpat.
    CALL METHOD l_pap->get_data
      IMPORTING
        es_key         = l_pap_key
        es_data        = l_pap_data
        e_rc           = l_rc
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc = 0.
      MOVE-CORRESPONDING l_pap_key  TO l_npap.              "#EC ENHOK
      MOVE-CORRESPONDING l_pap_data TO l_npap.              "#EC ENHOK
    ELSE.
      e_rc = 1.
      EXIT.
    ENDIF.
  ELSE.
    CALL METHOD cl_ish_dbr_pap=>get_pap_by_papid
      EXPORTING
        i_papid         = i_papid
        i_read_db       = on
      IMPORTING
        es_npap         = l_npap
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.

* Aufruf der Patientenidentifikation
  CALL FUNCTION 'ISHMED_PAT_IDENTIFICATION'
    EXPORTING
      i_einri          = i_einri
      i_npap           = l_npap
      i_create_patient = 'X'           " neuen Patient anlegen
    IMPORTING
      e_selected_npat  = l_npat
      e_can            = l_can.
  IF l_can <> 'X'.
    IF NOT l_npat-patnr IS INITIAL.
      l_patnr = l_npat-patnr.
    ELSE.
*     Es ist ein Fehler bei Verarbeitung aufgetreten (SY-SUBRC = &)
"--> MED-59990.
*      CALL METHOD c_errorhandler->collect_messages
*        EXPORTING
*          i_typ  = 'E'
*          i_kla  = 'NF'
*          i_num  = '139'
*          i_mv1  = sy-subrc
*          i_last = space.
CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1'
          i_num  = '830'.
"<--MED-59990.
      e_rc = 1.
      EXIT.
    ENDIF.
*   Prov. Pat. instanzieren
    IF l_pap IS INITIAL.
      IF c_environment IS INITIAL.
        CALL METHOD cl_ishmed_functions=>get_environment
          EXPORTING
            i_caller       = 'CL_ISHMED_FUNCTIONS'
          IMPORTING
            e_env_created  = l_cr_own_env
            e_rc           = e_rc
          CHANGING
            c_environment  = c_environment
            c_errorhandler = c_errorhandler.
        IF e_rc <> 0.
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDIF.
      l_pap_key-papid = i_papid.
      CALL METHOD cl_ish_patient_provisional=>load
        EXPORTING
          i_key               = l_pap_key
          i_environment       = c_environment
        IMPORTING
          e_instance          = l_pap
        EXCEPTIONS
          missing_environment = 1
          not_found           = 2
          OTHERS              = 3.
      IF sy-subrc <> 0.
        e_rc = 1.
*       destroy local environment
        IF l_cr_own_env = on.
          CALL METHOD cl_ish_utl_base=>destroy_env
            CHANGING
              cr_environment = c_environment.
        ENDIF.
        EXIT.
      ENDIF.
    ENDIF.
  ELSE.
    e_rc = 2.
    EXIT.
  ENDIF.

* Objekte des prov. Pat. auf neuen realen Pat. umhängen
  CALL METHOD l_pap->switch_and_delete
    EXPORTING
      i_patnr             = l_patnr
      i_save              = i_save
*     ED, ID 11241: nicht nötig, hier die connected objects
*     extra zu sichern, da die Methode SWICH_AND_DELETE sowieso
*     dafür sorgen muss, dass die angehängten Objekte des Patienten
*     geändert und gesichert werden müssen
      i_save_conn_objects = space
*      i_save_conn_objects = i_save
    IMPORTING
      e_rc                = l_rc
    CHANGING
      c_errorhandler      = c_errorhandler.
  IF l_rc = 0.
    IF l_patnr IS NOT INITIAL.
      e_patnr = l_patnr.
    ENDIF.
    IF i_commit = on.
      COMMIT WORK AND WAIT.
      IF NOT l_patnr IS INITIAL.
        l_rc = 4.
        DO 30000 TIMES.
          CALL METHOD cl_ishmed_lock=>enqueue_real_patient
            EXPORTING
              i_patnr  = l_patnr
              i_caller = 'CL_ISHMED_FUNCTIONS'
              i_msg    = off
            IMPORTING
              e_rc     = l_rc.
          IF l_rc = 0.
            EXIT.
          ENDIF.
        ENDDO.
*       Patient konnte nicht gesperrt werden, wohl weil die
*       Aufnahmetransaktion so lange braucht um den Patienten
*       freizugeben => Ein letztes Mal versuchen den Patienten zu
*       sperren, jetzt aber mit Fehlermeldung
        IF l_rc <> 0.
          CALL METHOD cl_ishmed_lock=>enqueue_real_patient
            EXPORTING
              i_patnr        = l_patnr
              i_caller       = 'CL_ISHMED_FUNCTIONS'
              i_msg          = on
            IMPORTING
              e_rc           = l_rc
            CHANGING
              c_errorhandler = c_errorhandler.
          IF l_rc <> 0.
            e_rc = 1.
*           destroy local environment
            IF l_cr_own_env = on.
              CALL METHOD cl_ish_utl_base=>destroy_env
                CHANGING
                  cr_environment = c_environment.
            ENDIF.
            EXIT.
          ELSE.
            CALL METHOD cl_ishmed_lock=>dequeue_real_patient
              EXPORTING
                i_patnr  = l_patnr
                i_caller = 'CL_ISHMED_FUNCTIONS'.
          ENDIF.
        ELSE.
          CALL METHOD cl_ishmed_lock=>dequeue_real_patient
            EXPORTING
              i_patnr  = l_patnr
              i_caller = 'CL_ISHMED_FUNCTIONS'.
        ENDIF.
      ENDIF.
    ENDIF.
  ELSE.
    e_rc = 1.
    ROLLBACK WORK.                                     "#EC CI_ROLLBACK
  ENDIF.

* destroy local environment
  IF l_cr_own_env = on.
    CALL METHOD cl_ish_utl_base=>destroy_env
      CHANGING
        cr_environment = c_environment.
  ENDIF.

ENDMETHOD.


METHOD waiting_for_update .

  DATA: lt_nfal                 TYPE ishmed_t_nfal,
        ls_nfal                 LIKE LINE OF lt_nfal,
        lt_npat                 TYPE ishmed_t_npat,
        ls_npat                 LIKE LINE OF lt_npat,
        lt_npap                 TYPE ishmed_t_npap,
        ls_npap                 LIKE LINE OF lt_npap.

  CLEAR e_rc.

  CALL METHOD cl_ishmed_functions=>get_patients_and_cases
    EXPORTING
      it_objects     = it_objects
    IMPORTING
      et_nfal        = lt_nfal
      et_npat        = lt_npat
      et_npap        = lt_npap.

  LOOP AT lt_nfal INTO ls_nfal.
    CALL FUNCTION 'ENQUEUE_ENFAL'
      EXPORTING
        falnr          = ls_nfal-falnr
        _scope         = 3
        _wait          = on  " default 5 sec
      EXCEPTIONS
        foreign_lock   = 4
        system_failure = 12.
    IF sy-subrc = 0.
      CALL FUNCTION 'DEQUEUE_ENFAL'
        EXPORTING
          falnr = ls_nfal-falnr.
    ENDIF.
  ENDLOOP.

  LOOP AT lt_npat INTO ls_npat.
    CALL FUNCTION 'ENQUEUE_ENPAT'
      EXPORTING
        patnr          = ls_npat-patnr
        _scope         = 3
        _wait          = on  " default 5 sec
      EXCEPTIONS
        foreign_lock   = 4
        system_failure = 12.
    IF sy-subrc = 0.
      CALL FUNCTION 'DEQUEUE_ENPAT'
        EXPORTING
          patnr = ls_npat-patnr.
    ENDIF.
  ENDLOOP.

  LOOP AT lt_npap INTO ls_npap.
    CALL FUNCTION 'ENQUEUE_ENPAP'
      EXPORTING
        papid          = ls_npap-papid
        _scope         = 3
        _wait          = on  " default 5 sec
      EXCEPTIONS
        foreign_lock   = 4
        system_failure = 12.
    IF sy-subrc = 0.
      CALL FUNCTION 'DEQUEUE_ENPAP'
        EXPORTING
          papid = ls_npap-papid.
    ENDIF.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
