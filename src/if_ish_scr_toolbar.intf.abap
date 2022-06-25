*"* components of interface IF_ISH_SCR_TOOLBAR
interface IF_ISH_SCR_TOOLBAR
  public .


  interfaces IF_ISH_SCR_CONTROL .

  methods GET_CONFIG_TOOLBAR
    exporting
      !ER_CONFIG_TOOLBAR type ref to IF_ISH_CONFIG_TOOLBAR
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_FCODE_FROM_UCOMM
    importing
      !I_UCOMM type SY-UCOMM
    returning
      value(R_FCODE) type UI_FUNC .
  methods GET_FVAR
    returning
      value(RR_FVAR) type ref to CL_ISH_FVAR .
  methods GET_TOOLBAR
    importing
      !I_CREATE type ISH_ON_OFF optional
    exporting
      !ER_TOOLBAR type ref to CL_GUI_TOOLBAR
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_FVAR
    importing
      !IR_FVAR type ref to CL_ISH_FVAR
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
