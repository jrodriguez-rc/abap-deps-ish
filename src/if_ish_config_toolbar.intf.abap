*"* components of interface IF_ISH_CONFIG_TOOLBAR
interface IF_ISH_CONFIG_TOOLBAR
  public .


  interfaces IF_ISH_IDENTIFY_OBJECT .

  methods DESTROY
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods MODIFY_TOOLBAR
    importing
      !IR_SCR_TOOLBAR type ref to IF_ISH_SCR_TOOLBAR
    exporting
      !E_MODIFIED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_DDCLICKED
    importing
      !IR_SCR_TOOLBAR type ref to IF_ISH_SCR_TOOLBAR
      !I_FCODE type UI_FUNC
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods PROCESS_FUNCSEL
    importing
      !IR_SCR_TOOLBAR type ref to IF_ISH_SCR_TOOLBAR
      !I_FCODE type UI_FUNC
    exporting
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_DDCLICKED
    importing
      !IR_SCR_TOOLBAR type ref to IF_ISH_SCR_TOOLBAR
      !I_FCODE type UI_FUNC
    exporting
      !E_PROCESS_AS_UCOMM type ISH_ON_OFF
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_SYSEV_FUNCSEL
    importing
      !IR_SCR_TOOLBAR type ref to IF_ISH_SCR_TOOLBAR
      !I_FCODE type UI_FUNC
    exporting
      !E_PROCESS_AS_UCOMM type ISH_ON_OFF
      !E_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CLONE
    returning
      value(RR_CONFIG) type ref to IF_ISH_CONFIG_TOOLBAR .
  methods COPY
    returning
      value(RR_CONFIG) type ref to IF_ISH_CONFIG_TOOLBAR .
endinterface.
