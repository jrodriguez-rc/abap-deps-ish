class CL_ISH_SUBSCR_WAITINGLIST_CORD definition
  public
  final
  create public .

public section.
*"* public components of class CL_ISH_SUBSCR_WAITINGLIST_CORD
*"* do not include other source files here!!!

  interfaces IF_ISH_CONSTANT_DEFINITION .

  constants CO_VCODE_INSERT type TNDYM-VCODE value 'INS'. "#EC NOTEXT
  constants CO_VCODE_UPDATE type TNDYM-VCODE value 'UPD'. "#EC NOTEXT
  constants CO_VCODE_DISPLAY type TNDYM-VCODE value 'DIS'. "#EC NOTEXT
  constants CO_OKCODE_TEST type SY-UCOMM value 'TEST'. "#EC NOTEXT
  data G_CALLER type SY-REPID .
  data G_EINRI type TN01-EINRI .
  data G_VCODE type TNDYM-VCODE .
  data G_CORDER type ref to CL_ISH_CORDER .
  data G_OKCODE type SY-UCOMM .
  data G_ABS_CONTAINER type ref to CL_GUI_CUSTOM_CONTAINER .
  data G_ABSENCE_EDITOR type ref to CL_ISH_ABSENCE_EDITOR_CORD .

  methods SET_CURSOR
    exporting
      value(E_CURSOR_SET) type ISH_ON_OFF
    changing
      value(C_RN1MESSAGE) type RN1MESSAGE optional .
  methods SET_FIRST_TIME
    importing
      value(I_FIRST_TIME) type ISH_ON_OFF .
  methods CONSTRUCTOR
    importing
      value(I_CALLER) type SY-REPID
      value(I_EINRI) type TN01-EINRI
      value(I_VCODE) type TNDYM-VCODE optional
      value(I_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT
      !IR_SCREEN type ref to IF_ISH_SCREEN optional .
  methods SET_DATA
    importing
      value(I_CORDER) type ref to CL_ISH_CORDER optional
      value(I_VCODE) type TNDYM-VCODE optional
      value(I_VCODE_X) type ISH_ON_OFF default SPACE .
  methods GET_DATA
    exporting
      value(E_CORDER) type ref to CL_ISH_CORDER
      value(E_VCODE) type TNDYM-VCODE
      value(E_FIRST_TIME) type ISH_ON_OFF
      value(E_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT
      value(E_RN1MESSAGE) type RN1MESSAGE
      !ER_SCREEN type ref to IF_ISH_SCREEN
      !E_CONTROL type ref to CL_ISH_ABSENCE_EDITOR_CORD .
  methods OK_CODE_SUBSCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional
      !C_OKCODE type SY-UCOMM .
  methods DESTROY .
protected section.
*"* protected components of class CL_ISHMED_SUBSCR_PLANING
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SUBSCR_WAITINGLIST_CORD
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
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  data G_FIRST_TIME type ISH_ON_OFF .
  data G_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  data G_RN1MESSAGE type RN1MESSAGE .
  data GR_SCREEN type ref to IF_ISH_SCREEN .
ENDCLASS.



CLASS CL_ISH_SUBSCR_WAITINGLIST_CORD IMPLEMENTATION.


method CONSTRUCTOR .
* INITIALIZE
  clear g_corder.
  g_first_time = 'X'.
  clear g_rn1message.

  g_okcode = co_okcode_test.
* global fields
  g_caller = i_caller.
  g_einri  = i_einri.
  g_vcode  = i_vcode.
  g_environment = i_environment.
  if g_vcode <> co_vcode_insert  and  g_vcode <> co_vcode_update.
    g_vcode = co_vcode_display.
  endif.
  gr_screen = ir_screen.    "RW ID 14654
endmethod.


METHOD destroy .

  IF NOT g_abs_container IS INITIAL.
    CALL METHOD g_abs_container->free.
    CLEAR: g_abs_container.
  ENDIF.

ENDMETHOD.


METHOD get_data .
  e_corder      = g_corder.
  e_vcode       = g_vcode.
  e_first_time  = g_first_time.
  e_environment = g_environment.
  e_rn1message  = g_rn1message.
  er_screen     = gr_screen.        "RW ID 14654
  e_control     = g_absence_editor. "ED, ID 14654
ENDMETHOD.


METHOD ok_code_subscreen .

* Hilfsfelder und -strukturen
  DATA:  l_okcode               TYPE sy-ucomm,
         l_rc                   TYPE ish_method_rc,
         l_rn1_corder_x         TYPE rn1_corder_x,
         l_rn1msg               TYPE rn1message.
* --------- ---------- ----------
  l_okcode = c_okcode.
* --------- ---------- ----------
  CASE l_okcode.
    WHEN 'DDLB_WLTYP'.
*     waitinglist typ listbox
      CLEAR l_rn1msg.
      l_rn1msg-parameter = 'RN1_DYNP_WAITING_LIST'.
      l_rn1msg-field     = 'WLTYP'.
*     ---------
*     change the typ then change the date
      CLEAR: l_rn1_corder_x.
      l_rn1_corder_x-wladt_x  =  on.
*      CALL METHOD g_corder->preallocation
*        EXPORTING
*          i_what_to_preallocate = l_rn1_corder_x
*        IMPORTING
*          e_rc                  = l_rc
*        CHANGING
*          c_errorhandler        = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*     ---------
      CALL METHOD me->set_cursor
        CHANGING
          c_rn1message = l_rn1msg.
      c_okcode = 'TEST'.

* ED, ID 19471 -> BEGIN
* new function code for distance from waiting list
    WHEN 'DDLB_DIST'.
      CLEAR l_rn1msg.
      l_rn1msg-parameter = 'RN1_DYNP_WAITING_LIST'.
      l_rn1msg-field     = 'WLRRN'.
**     ---------
**     change the typ then change the date
*      CLEAR: l_rn1_corder_x.
*      l_rn1_corder_x-wladt_x  =  on.
**      CALL METHOD g_corder->preallocation
**        EXPORTING
**          i_what_to_preallocate = l_rn1_corder_x
**        IMPORTING
**          e_rc                  = l_rc
**        CHANGING
**          c_errorhandler        = c_errorhandler.
*      IF l_rc <> 0.
*        e_rc = l_rc.
*        EXIT.
*      ENDIF.
*     ---------
      CALL METHOD me->set_cursor
        CHANGING
          c_rn1message = l_rn1msg.
      c_okcode = 'TEST'.
* ED, ID 19471 -> END

  ENDCASE.
* --------- ---------- ----------

ENDMETHOD.


METHOD set_cursor .
  DATA: l_fname(30)   TYPE c,
        l_rc          TYPE ish_method_rc.

* Message-Leiste für Cursorpositionierung nur übernehmen, wenn
* ein Feld enthalten ist, das im Subscreen existiert
  CLEAR g_rn1message.
  CLEAR l_fname.
  IF NOT c_rn1message-parameter IS INITIAL.
    CONCATENATE c_rn1message-parameter '-' c_rn1message-field
                INTO l_fname.
    g_rn1message = c_rn1message.
    CASE l_fname.

      WHEN 'RN1_DYNP_WAITING_LIST-WLPRI'.
        g_rn1message-parameter = 'RN1_DYNP_WAITING_LIST'.
        g_rn1message-field     = 'WLPRI'.

      WHEN 'RN1_DYNP_WAITING_LIST-WLTYP'.
        g_rn1message-parameter = 'RN1_DYNP_WAITING_LIST'.
        g_rn1message-field     = 'WLTYP'.

      WHEN 'RN1_DYNP_WAITING_LIST-WLADT'.
        g_rn1message-parameter = 'RN1_DYNP_WAITING_LIST'.
        g_rn1message-field     = 'WLADT'.

      WHEN 'RN1_DYNP_WAITING_LIST-WLRRN'.
        g_rn1message-parameter = 'RN1_DYNP_WAITING_LIST'.
        g_rn1message-field     = 'WLRRN'.

      WHEN 'RN1_DYNP_WAITING_LIST-WLRDT'.
        g_rn1message-parameter = 'RN1_DYNP_WAITING_LIST'.
        g_rn1message-field     = 'WLRDT'.

      WHEN 'RN1_DYNP_WAITING_LIST-WLHSP'.
        g_rn1message-parameter = 'RN1_DYNP_WAITING_LIST'.
        g_rn1message-field     = 'WLHSP'.

      WHEN 'NWLM-ABSBDT'.
        g_rn1message  =  c_rn1message.

      WHEN 'NWLM-ABSEDT'.
        g_rn1message  =  c_rn1message.

      WHEN 'NWLM-ABSRSNTX'.
        g_rn1message  =  c_rn1message.
      WHEN OTHERS.
        CLEAR g_rn1message.
    ENDCASE.
  ENDIF.

  IF NOT g_rn1message-field IS INITIAL.
    CLEAR c_rn1message.
  ENDIF.
ENDMETHOD.


method SET_DATA .
  if not i_corder is initial.
    g_corder      = i_corder.
  endif.
  IF i_vcode_x = on.
    g_vcode = i_vcode.
  ENDIF.
endmethod.


method SET_FIRST_TIME .
  g_first_time = i_first_time.
endmethod.
ENDCLASS.
