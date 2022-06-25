class CL_ISH_SUBSCR_FURTHER_DET_CO definition
  public
  final
  create public .

*"* public components of class CL_ISH_SUBSCR_FURTHER_DET_CO
*"* do not include other source files here!!!
public section.

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
  data G_BMCO_CONT type ref to CL_GUI_CUSTOM_CONTAINER .
  data G_BMCO_EDIT type ref to CL_ISHMED_LTE_EDITOR .

  methods SET_CURSOR
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
      !ER_SCREEN type ref to IF_ISH_SCREEN .
  methods OK_CODE_SUBSCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional
      !C_OKCODE type SY-UCOMM .
  methods CLEAR_MESSAGE .
protected section.
*"* protected components of class CL_ISHMED_SUBSCR_PLANING
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SUBSCR_FURTHER_DET_CO
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



CLASS CL_ISH_SUBSCR_FURTHER_DET_CO IMPLEMENTATION.


METHOD clear_message.

  CLEAR g_rn1message.

ENDMETHOD.


METHOD constructor .
* initialize the global field values
  CLEAR g_corder.
  g_first_time = 'X'.
  CLEAR: g_rn1message,
         g_okcode.

* save the parameter in the global fields
  g_caller = i_caller.
  g_einri  = i_einri.
  g_vcode  = i_vcode.
  g_environment = i_environment.
  IF g_vcode <> co_vcode_insert  AND  g_vcode <> co_vcode_update.
    g_vcode = co_vcode_display.
  ENDIF.
  gr_screen = ir_screen.    "RW ID 14654
ENDMETHOD.


METHOD get_data .
  e_corder      = g_corder.
  e_vcode       = g_vcode.
  e_first_time  = g_first_time.
  e_environment = g_environment.
  e_rn1message  = g_rn1message.
  er_screen     = gr_screen.        "RW ID 14654
ENDMETHOD.


method OK_CODE_SUBSCREEN .
  data: l_rc         type ish_method_rc.

*  case c_okcode.
*    when 'DDLB_FALLART'.
**     Fallart-Listbox wurde angeklickt
*      c_okcode = 'TEST'.
*
*    when 'ARRIVAL'.
*      Aufnahme - Button
*      c_okcode = 'TEST'.
*  endcase.
endmethod.


METHOD set_cursor .

  DATA: l_fname(30)   TYPE c,
        l_rc          TYPE ish_method_rc.

* posit with cursor only, if its a field which is in the subscreen
  CLEAR g_rn1message.
  CLEAR l_fname.
  IF NOT c_rn1message-parameter IS INITIAL.
*   MED-32263 - Begin
    IF c_rn1message-parameter = 'FRAME_COMMENT'.
      g_rn1message-parameter = 'N1CORDER'.
      g_rn1message-field     = 'RMCORD'.
    ELSE.
*   MED-32263 - End
      CONCATENATE c_rn1message-parameter '-' c_rn1message-field
                  INTO l_fname.
      g_rn1message = c_rn1message.
      CASE l_fname.
        WHEN 'N1CORDER-RMCORD'  OR  'N1CORDER-RMLTX'.
          g_rn1message-parameter = 'N1CORDER'.
          g_rn1message-field     = 'RMCORD'.

        WHEN OTHERS.
          CLEAR g_rn1message.
      ENDCASE.
    ENDIF.                                                  "MED-32263
  ENDIF.

  IF NOT g_rn1message-field IS INITIAL.
    CLEAR c_rn1message.
  ENDIF.
ENDMETHOD.


METHOD set_data .
  IF NOT i_corder IS INITIAL.
    g_corder = i_corder.
  ENDIF.

  IF i_vcode_x = on.
    g_vcode = i_vcode.
  ENDIF.
ENDMETHOD.


method SET_FIRST_TIME .
  g_first_time = i_first_time.
endmethod.
ENDCLASS.
