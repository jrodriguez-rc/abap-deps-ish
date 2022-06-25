*"* components of interface IF_ISH_SCR_HTML
interface IF_ISH_SCR_HTML
  public .


  interfaces IF_ISH_SCR_CONTROL .

  aliases IS_DRAGDROP_SUPPORTED
    for IF_ISH_SCR_CONTROL~IS_DRAGDROP_SUPPORTED .
  aliases SUPPORT_DRAGDROP
    for IF_ISH_SCR_CONTROL~SUPPORT_DRAGDROP .

  constants CO_UCOMM_LINK_CLICKED type SY-UCOMM value 'LINK_CLICKED'. "#EC NOTEXT

  methods BUILD_UCOMM_LINK_CLICKED
    importing
      !IR_DD_LINK_ELEMENT type ref to CL_DD_LINK_ELEMENT
    changing
      !C_UCOMM type SY-UCOMM .
  methods GET_CONFIG_HTML
    exporting
      !ER_CONFIG_HTML type ref to IF_ISH_CONFIG_HTML
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_UCOMM_KEYSTRING
    importing
      !I_UCOMM type SY-UCOMM
    returning
      value(R_KEYSTRING) type STRING .
  methods GET_DD_DOCUMENT
    importing
      value(I_CREATE) type ISH_ON_OFF default 'X'
    exporting
      !ER_DD_DOCUMENT type ref to CL_DD_DOCUMENT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
