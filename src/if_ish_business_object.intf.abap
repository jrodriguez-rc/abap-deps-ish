*"* components of interface IF_ISH_BUSINESS_OBJECT
interface IF_ISH_BUSINESS_OBJECT
  public .


  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_ENTITY_OBJECT_OWNER .

  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .

  constants CO_SAVESTAT_AFTER_COMMIT type N1BOSAVESTATUS value 60. "#EC NOTEXT
  constants CO_SAVESTAT_AFTER_ROLLBACK type N1BOSAVESTATUS value 70. "#EC NOTEXT
  constants CO_SAVESTAT_BEFORE_SAVE type N1BOSAVESTATUS value 30. "#EC NOTEXT
  constants CO_SAVESTAT_CHECK type N1BOSAVESTATUS value 20. "#EC NOTEXT
  constants CO_SAVESTAT_COLLECT type N1BOSAVESTATUS value 10. "#EC NOTEXT
  constants CO_SAVESTAT_NOSAVE type N1BOSAVESTATUS value 0. "#EC NOTEXT
  constants CO_SAVESTAT_SAVE type N1BOSAVESTATUS value 40. "#EC NOTEXT
  constants CO_SAVESTAT_WAIT type N1BOSAVESTATUS value 50. "#EC NOTEXT

  events EV_INVALIDATED
    exporting
      value(ER_MESSAGES) type ref to CL_ISHMED_ERRORHANDLING optional .

  methods BO4SAVER_AFTER_COMMIT
    raising
      CX_ISH_STATIC_HANDLER .
  methods BO4SAVER_AFTER_ROLLBACK
    raising
      CX_ISH_STATIC_HANDLER .
  methods BO4SAVER_BEFORE_SAVE
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods BO4SAVER_CHECK
    importing
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods BO4SAVER_CLEAR_SAVER
    raising
      CX_ISH_STATIC_HANDLER .
  methods BO4SAVER_COLLECT
    returning
      value(RT_BO) type ISH_T_BO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods BO4SAVER_SAVE
    importing
      !I_USER type SYUNAME default SY-UNAME
      !I_DATE type SYDATUM default SY-DATUM
      !I_TIME type SYUZEIT default SY-UZEIT
      !I_TCODE type SYTCODE default SY-TCODE
      !I_TIMESTAMP type TIMESTAMPL
    returning
      value(RR_SAVE_RESULT) type ref to CL_ISH_BOSAVE_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods BO4SAVER_SET_SAVER
    importing
      !IR_SAVER type ref to CL_ISH_BOSAVER
    raising
      CX_ISH_STATIC_HANDLER .
  methods CHECK
    importing
      !I_CHECK_UNCHANGED_DATA type ABAP_BOOL default ABAP_FALSE
    returning
      value(RR_RESULT) type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CLEAR_ALL_SNAPSHOTS
    raising
      CX_ISH_STATIC_HANDLER .
  methods CLEAR_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods DEREGISTER_OWNER
    importing
      !IR_OWNER type ref to IF_ISH_BUSINESS_OBJECT_OWNER
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ACTIVE_SNAPKEY
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY .
  methods GET_BOID
    returning
      value(R_BOID) type N1BOID .
  methods GET_BOSAVER
    returning
      value(RR_BOSAVER) type ref to CL_ISH_BOSAVER .
  methods GET_INVALID_MESSAGES
    returning
      value(RR_MESSAGES) type ref to CL_ISHMED_ERRORHANDLING .
  methods GET_SAVE_STATUS
    returning
      value(R_SAVE_STATUS) type N1BOSAVESTATUS .
  methods GET_T_CHANGED_EO
    importing
      !I_INCL_TOUCHED_EO type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH .
  methods GET_T_LOADED_EO
    returning
      value(RT_LOADED_EO) type ISH_T_EO_OBJH .
  methods GET_T_OWNER
    returning
      value(RT_OWNER) type ISH_T_BOOWNER_OBJH .
  methods HAS_ENTITY_OBJECT
    importing
      !IR_EO type ref to CL_ISH_ENTITY_OBJECT
    returning
      value(R_HAS_EO) type ABAP_BOOL .
  methods HAS_OWNER
    importing
      !IR_OWNER type ref to IF_ISH_BUSINESS_OBJECT_OWNER
    returning
      value(R_HAS_OWNER) type ABAP_BOOL .
  methods HAS_SNAPSHOT
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    returning
      value(R_HAS_SNAPSHOT) type ABAP_BOOL .
  methods INVALIDATE
    importing
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
  methods IS_CHANGED
    importing
      !I_INCL_TOUCHED_EO type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods IS_DELETED
    returning
      value(R_DELETED) type ABAP_BOOL .
  methods IS_INVALID
    returning
      value(R_INVALID) type ABAP_BOOL .
  methods IS_MARKED_FOR_DELETION
    returning
      value(R_MARKED_FOR_DELETION) type ABAP_BOOL .
  methods IS_NEW
    returning
      value(R_NEW) type ABAP_BOOL .
  methods IS_READONLY
    returning
      value(R_READONLY) type ABAP_BOOL .
  methods IS_TOUCHED
    returning
      value(R_TOUCHED) type ABAP_BOOL .
  methods MARK_FOR_DELETION
    raising
      CX_ISH_STATIC_HANDLER .
  methods REGISTER_OWNER
    importing
      !IR_OWNER type ref to IF_ISH_BUSINESS_OBJECT_OWNER
    raising
      CX_ISH_STATIC_HANDLER .
  methods RELOAD
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods RESET
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods SAVE
    importing
      !I_USER type SYUNAME default SY-UNAME
      !I_DATE type SYDATUM default SY-DATUM
      !I_TIME type SYUZEIT default SY-UZEIT
      !I_TCODE type SYTCODE default SY-TCODE
      !I_TIMESTAMP type TIMESTAMPL optional
    returning
      value(RR_RESULT) type ref to CL_ISH_BOSAVE_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods SNAPSHOT
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods TOUCH
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNDO
    importing
      !I_SNAPKEY type ISH_SNAPKEY
    returning
      value(RT_CHANGED_EO) type ISH_T_EO_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNTOUCH
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
