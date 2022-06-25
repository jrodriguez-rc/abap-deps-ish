*"* components of interface IF_ISHMED_LOCK_SPECIAL
interface IF_ISHMED_LOCK_SPECIAL
  public .


  class-methods LOCK_GET_DATA
    importing
      value(IR_OBJECT) type ref to IF_ISH_IDENTIFY_OBJECT optional
      value(IS_DATA) type ANY optional
    exporting
      value(E_LOCK_STRING) type STRING
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods LOCK_ENQUEUE
    importing
      value(I_LOCKDATA) type STRING
      value(I_LOCK_OBJECT) type ANY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods LOCK_DEQUEUE
    importing
      value(I_LOCKDATA) type STRING
      value(I_LOCK_OBJECT) type ANY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
