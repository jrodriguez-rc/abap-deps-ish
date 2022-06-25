*"* components of interface IF_EX_N1_CONNECTIVITY
interface IF_EX_N1_CONNECTIVITY
  public .


  methods EXIT_CHECK
    importing
      value(I_CALLER) type N1CALLER
      !IT_OBJECTS type ISH_T_IDENTIFY_OBJECT_DEPEND
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods EXIT_EXPORT
    importing
      value(I_CALLER) type N1CALLER
      !IT_OBJECTS type ISH_T_IDENTIFY_OBJECT_DEPEND
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods EXIT_IMPORT_CORDER
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IS_CORDER_DATA type RN1_CONN_CORDER_DATA
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
