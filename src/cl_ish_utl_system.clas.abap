class CL_ISH_UTL_SYSTEM definition
  public
  abstract
  create public .

public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .

  class-methods IS_CUSTOMER_SYSTEM
    returning
      value(R_IS_CUSTOMER_SYSTEM) type ISH_ON_OFF .
  class-methods IS_ACM_ACTIVE
    returning
      value(R_IS_ACTIVE) type ISH_ON_OFF .
  class-methods IS_ISHMED_ACTIVE
    returning
      value(R_IS_ACTIVE) type ISH_ON_OFF .
  class-methods IS_SAP_SYSTEM
    returning
      value(R_IS_SAP_SYSTEM) type ISH_ON_OFF .
  class-methods IS_WINDOWS_7
    returning
      value(R_WINDOWS_7) type ISH_ON_OFF .
PROTECTED SECTION.
*"* protected components of class CL_ISH_UTL_SYSTEM
*"* do not include other source files here!!!

ALIASES off
  FOR if_ish_constant_definition~off .
ALIASES on
  FOR if_ish_constant_definition~on .

TYPES: BEGIN OF gty_sys_params,
         systemedit          TYPE tadir-edtflag,
         systemname          TYPE sy-sysid,
         systemtype          TYPE sy-sysid,
         system_client_edit  TYPE t000-cccoractiv,
         sys_cliinddep_edit  TYPE t000-ccnocliind,
         system_client_role  TYPE t000-cccategory,
         ev_sfw_bcset_rec    TYPE t000-ccorigcont,
         ev_c_system         TYPE trpari-s_checked,
       END OF gty_sys_params.

CLASS-DATA gs_sys_params TYPE gty_sys_params .

CLASS-METHODS init_sys_params .
private section.
*"* private components of class CL_ISH_UTL_SYSTEM
*"* do not include other source files here!!!

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
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  class-data G_MED_ACTIVE type ISH_TRUE_FALSE .
  class-data G_ACM_ACTIVE type ISH_TRUE_FALSE .
ENDCLASS.



CLASS CL_ISH_UTL_SYSTEM IMPLEMENTATION.


METHOD init_sys_params.

* Process only if not already read.
  CHECK gs_sys_params IS INITIAL.

* Read the system parameters.
  CALL FUNCTION 'TR_SYS_PARAMS'
    IMPORTING
      systemedit         = gs_sys_params-systemedit
      systemname         = gs_sys_params-systemname
      systemtype         = gs_sys_params-systemtype
      system_client_edit = gs_sys_params-system_client_edit
      sys_cliinddep_edit = gs_sys_params-sys_cliinddep_edit
      system_client_role = gs_sys_params-system_client_role
      ev_sfw_bcset_rec   = gs_sys_params-ev_sfw_bcset_rec
      ev_c_system        = gs_sys_params-ev_c_system
    EXCEPTIONS
      no_systemname      = 1
      no_systemtype      = 2
      OTHERS             = 3.
  IF sy-subrc <> 0.
    CLEAR gs_sys_params.
  ENDIF.

ENDMETHOD.


METHOD is_acm_active.
  DATA:
    l_switch            TYPE sfw_switchpos.

  CLEAR r_is_active.
* check switch ISH_AMBULATORY
  CASE g_acm_active.
    WHEN space.
      CLEAR l_switch.
      l_switch = cl_abap_switch=>get_switch_state(
          p_switch_id           = 'ISH_AMBULATORY'
          p_client              = sy-mandt
          p_username            = sy-uname
          p_only_active_version = abap_true
             ).
      IF l_switch = 'T'.
        g_acm_active = true.
        r_is_active = on.
      ELSE.
        g_acm_active = false.
      ENDIF.
    WHEN true.
      r_is_active = on.
  ENDCASE.

ENDMETHOD.


METHOD is_customer_system.

* Init gs_sys_params.
  init_sys_params( ).

* Export.
  IF gs_sys_params-systemtype = 'CUSTOMER'.
    r_is_customer_system = on.
  ELSE.
    r_is_customer_system = off.
  ENDIF.

ENDMETHOD.


METHOD is_ishmed_active.
  DATA:
    l_switch            TYPE sfw_switchpos.

  CLEAR r_is_active.
* check switch ISHMED
  CASE g_med_active.
    WHEN space.
      CLEAR l_switch.
      l_switch = cl_abap_switch=>get_switch_state(
          p_switch_id           = 'ISHMED_MAIN'
          p_client              = sy-mandt
          p_username            = sy-uname
          p_only_active_version = abap_true
             ).
      IF l_switch = 'T'.
        g_med_active = true.
        r_is_active = on.
      ELSE.
        g_med_active = false.
      ENDIF.
    WHEN true.
      r_is_active = on.
  ENDCASE.

ENDMETHOD.


METHOD is_sap_system.

* Init gs_sys_params.
  init_sys_params( ).

* Export.
  IF gs_sys_params-systemtype = 'SAP'.
    r_is_sap_system = on.
  ELSE.
    r_is_sap_system = off.
  ENDIF.

ENDMETHOD.


METHOD is_windows_7.
* >>> MED-44079 note 1590815
  DATA:
*    l_platform     TYPE i,
    l_reg_value    TYPE string.

** windows?
*  cl_gui_frontend_services=>get_platform(
*    RECEIVING
*      platform             = l_platform
*    EXCEPTIONS
*      OTHERS               = 4
*         ).
*  IF sy-subrc <> 0.
**   --------------------------------------------------> exit
*    RETURN.
*  ENDIF.
*
* windows 7 ?
*  IF l_platform = cl_gui_frontend_services=>platform_windowsxp.
  cl_gui_frontend_services=>registry_get_value(
    EXPORTING
      root      = 2    "HKEY_LOCAL_MACHINE
      key       = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion' ##NO_TEXT
      value     = 'ProductName'
    IMPORTING
      reg_value = l_reg_value
    EXCEPTIONS
      OTHERS    = 5
         ).
  IF sy-subrc <> 0.
*   --------------------------------------------------> exit
    RETURN.
  ENDIF.

  IF l_reg_value CS 'Windows 7'
  OR l_reg_value CP '*Windows*2008*'
  OR l_reg_value CP '*Windows*10*'
  OR l_reg_value CP '*Windows*8*'.
    r_windows_7 = abap_on.
  ENDIF.

*  ENDIF.

* <<< MED-44079 note 1590815
ENDMETHOD.
ENDCLASS.
