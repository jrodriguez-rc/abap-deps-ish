*"* components of interface IF_ISH_SCREEN_COLLAPSIBLE
interface IF_ISH_SCREEN_COLLAPSIBLE
  public .


  methods SWITCH
    importing
      value(I_VIEW_MODE) type ISH_ON_OFF optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_EMBEDDED_SCREENS
    returning
      value(RT_SCREEN) type ISH_T_SCREEN_OBJECTS .
  methods GET_SCREEN_ACTIVE
    exporting
      !ER_SCREEN_ACTIVE type ref to IF_ISH_SCREEN
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SCR_COLLAPSIBLE
    importing
      value(I_CREATE) type ISH_ON_OFF default SPACE
    exporting
      !ER_SCR_COLLAPSIBLE type ref to CL_ISH_SCR_COLLAPSIBLE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
