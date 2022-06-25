interface IF_ISHMED_WP_FUNC
  public .


  methods IS_RIGHT_VIEWTYPE
    importing
      value(I_VIEW_TYPE) type NWVIEW-VIEWTYPE
    returning
      value(R_RESULT) type ABAP_BOOL .
  methods EXECUTE_FUNCTIONS
    importing
      value(I_FCODE) type CUA_CODE
      value(I_VIEW_ID) type NWVIEW-VIEWID
      value(I_VIEW_TYPE) type NWVIEW-VIEWTYPE
      value(I_WPLACEID) type NWPLACEID
      value(I_FIELDNAME) type LVC_FNAME
      !IT_ISH_OBJECTS type ISH_T_DRAG_DROP_DATA
    exporting
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1FLD-REFRESH
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
