class CL_ISH_SCR_ADMISSION definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

public section.

  constants CO_DEFAULT_TABNAME type TABNAME value 'N1VKG' ##NO_TEXT.
  class-data G_FIELDNAME_BEKAT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_BEWAR_TXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_BKTXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_BOX_TXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_PVPAT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_SC_LB_BEWAR type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_SC_LB_FALAR type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_SC_LB_FATYP type ISH_FIELDNAME read-only .
  class-data G_PREFIX_FIELDNAME type ISH_FIELDNAME read-only value 'RN1_DYNP_ADMISSION' ##NO_TEXT.
  constants CO_OTYPE_SCR_ADMISSION type ISH_OBJECT_TYPE value 7007 ##NO_TEXT.
  data G_FIELDNAME_FALAR type ISH_FIELDNAME read-only value 'RN1_DYNP_ADMISSION-FALAR' ##NO_TEXT.
  data G_FIELDNAME_FATYP type ISH_FIELDNAME read-only value 'RN1_DYNP_ADMISSION-FATYP' ##NO_TEXT.
  data G_FIELDNAME_BEWAR type ISH_FIELDNAME read-only value 'RN1_DYNP_ADMISSION-BEWAR' ##NO_TEXT.
  data G_FIELDNAME2_FALAR type ISH_FIELDNAME read-only .
  data G_FIELDNAME2_FATYP type ISH_FIELDNAME read-only .
  data G_FIELDNAME2_BEWAR type ISH_FIELDNAME read-only .
  constants CO_FIELDNAME_FALAR type ISH_FIELDNAME value 'RN1_DYNP_ADMISSION-FALAR' ##NO_TEXT.
  constants CO_FIELDNAME_FATYP type ISH_FIELDNAME value 'RN1_DYNP_ADMISSION-FATYP' ##NO_TEXT.
  constants CO_FIELDNAME_BEWAR type ISH_FIELDNAME value 'RN1_DYNP_ADMISSION-BEWAR' ##NO_TEXT.
  data GS_SAVED_FATYP type VRM_VALUE .  "IXX-204 NPopa 04.11.2014

  methods CHECK_BEKAT_FOR_PVPAT
    importing
      value(I_EINRI) type EINRI
      value(I_BEKAT) type BEKAT
    exporting
      value(E_PVPAT) type N1PVPAT .
  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_ADMISSION
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CORDPOS
    returning
      value(RR_CORDPOS) type ref to CL_ISHMED_PREREG .
  methods GET_SCR_LB_BEWAR
    importing
      value(I_CREATE) type ISH_ON_OFF default OFF
    exporting
      !ER_SCR_LB_BEWAR type ref to CL_ISH_SCR_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SCR_LB_FALAR
    importing
      value(I_CREATE) type ISH_ON_OFF default OFF
    exporting
      !ER_SCR_LB_FALAR type ref to CL_ISH_SCR_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SCR_LB_FATYP
    importing
      value(I_CREATE) type ISH_ON_OFF default OFF
    exporting
      !ER_SCR_LB_FATYP type ref to CL_ISH_SCR_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods MODIFY_SCREEN_ATT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  methods PAI_LB_BEWAR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PAI_LB_FALAR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PAI_LB_FATYP
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PBO_LB_BEWAR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PBO_LB_FALAR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PBO_LB_FATYP
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods VALUE_REQUEST_BEKAT
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~CREATE_ALL_LISTBOXES
    redefinition .
  methods IF_ISH_SCREEN~DESTROY
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_DEFINITION
    redefinition .
  methods IF_ISH_SCREEN~MODIFY_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~SET_CURSOR
    redefinition .
  methods IF_ISH_SCREEN~SET_DATA_FROM_FIELDVAL
    redefinition .
  methods IF_ISH_SCREEN~SET_FIELDVAL_FROM_DATA
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_FROM_DY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.

  data GR_DYNNR_LB_BEWAR type ref to DATA .
  data GR_DYNNR_LB_FALAR type ref to DATA .
  data GR_DYNNR_LB_FATYP type ref to DATA .
  data GR_DYNPG_LB_BEWAR type ref to DATA .
  data GR_DYNPG_LB_FALAR type ref to DATA .
  data GR_DYNPG_LB_FATYP type ref to DATA .
  constants CO_REPID type SYREPID value 'SAPLN1_SDY_ADMISSION'. "#EC NOTEXT
  constants CO_DYNNR_FROM type SYDYNNR value '0100'. "#EC NOTEXT
  constants CO_DYNNR_TO type SYDYNNR value '0140'. "#EC NOTEXT

  methods ADJUST_FIELD_WITH_SCREENTAB
    importing
      value(I_NAME) type NC30
      value(IT_SCREENTAB) type ISHMED_T_SCREEN
    changing
      value(C_SCREEN) type RN1SCREEN .
  methods CREATE_LISTBOX_BEWAR
    exporting
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_LISTBOX_FALAR
    exporting
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_LISTBOX_FATYP
    exporting
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_BEWAR_TXT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_BKTXT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING .
  methods FILL_LABEL_BOX_TXT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SCR_LB_FOR_LBNAME
    importing
      value(I_LBNAME) type STRING
    returning
      value(RR_SCR_LB) type ref to CL_ISH_SCR_LISTBOX .
  methods HANDLE_EV_USER_COMMAND
    for event EV_USER_COMMAND of IF_ISH_SCREEN
    importing
      !IR_SCREEN
      !IR_OBJECT
      !IS_COL_ID
      !IS_ROW_NO
      !I_UCOMM .
  methods SET_CURSOR_LB_BEWAR
    importing
      value(IS_MESSAGE) type RN1MESSAGE optional
      value(I_CURSORFIELD) type ISH_FIELDNAME optional
      value(I_SET_CURSOR) type ISH_ON_OFF default OFF
    exporting
      value(E_CURSOR_SET) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_CURSOR_LB_FALAR
    importing
      value(IS_MESSAGE) type RN1MESSAGE optional
      value(I_CURSORFIELD) type ISH_FIELDNAME optional
      value(I_SET_CURSOR) type ISH_ON_OFF default OFF
    exporting
      value(E_CURSOR_SET) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_CURSOR_LB_FATYP
    importing
      value(IS_MESSAGE) type RN1MESSAGE optional
      value(I_CURSORFIELD) type ISH_FIELDNAME optional
      value(I_SET_CURSOR) type ISH_ON_OFF default OFF
    exporting
      value(E_CURSOR_SET) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_LISTBOX_FIELDNAMES .
  methods GET_FALART_BY_FALNR_FROM_DB
    importing
      !I_FALNR type FALNR
    returning
      value(R_FALART) type FALAR_ALL .

  methods BUILD_MESSAGE
    redefinition .
  methods CREATE_LISTBOX_INTERNAL
    redefinition .
  methods FILL_ALL_LABELS
    redefinition .
  methods FILL_LABEL_INTERNAL
    redefinition .
  methods FILL_T_SCRM_FIELD
    redefinition .
  methods GET_T_SCRMOD_STD
    redefinition .
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
  methods MODIFY_SCREEN_INTERNAL
    redefinition .
  methods MODIFY_SCREEN_STD
    redefinition .
  methods SET_CURSOR_INTERNAL
    redefinition .
  methods VALUE_REQUEST_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_ADMISSION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_ADMISSION IMPLEMENTATION.


METHOD adjust_field_with_screentab .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

** adjust a field which the table noticed after the MODIFY_SCREEN ->
** if it only display after modification then it should remain display
*
*  DATA: l_screen TYPE rn1screen.
*
*  READ TABLE it_screentab INTO l_screen
*                          WITH KEY name = i_name.
*  CHECK sy-subrc = 0.
*
*  CHECK i_name(4) <> 'G_TAB'.
*
*  IF c_screen-input <> false.
*    c_screen-input  = l_screen-input.
*  ENDIF.
*  IF c_screen-active <> false.
*    c_screen-active = l_screen-active.
*  ENDIF.
** Get also the REQUIRED-attribute
*  c_screen-required = l_screen-required.

ENDMETHOD.


METHOD build_message .

  DATA: l_cursorfield_prefix  TYPE ish_fieldname,
        l_cursorfield         TYPE ish_fieldname,
        l_fieldname           TYPE ish_fieldname.

* Call super method.
  CALL METHOD super->build_message
    EXPORTING
      is_message    = is_message
      i_cursorfield = i_cursorfield
    IMPORTING
      es_message    = es_message.

* Handle only errors on selfs main object.
  IF NOT is_message-object IS INITIAL AND
     NOT is_message-object = gr_main_object.
    CLEAR: es_message-parameter,
           es_message-field.
    EXIT.
  ENDIF.

* Wrap es_message-parameter.
  CASE es_message-parameter.
    WHEN 'N1VKG'.
      es_message-parameter = g_prefix_fieldname.
      CASE es_message-field.
        WHEN 'BEKAT'.
          l_fieldname = g_fieldname_bekat.
        WHEN 'PVPAT'.
          l_fieldname = g_fieldname_pvpat.
*       Michael Manoch, 11.02.2010, MED-38637   START
        WHEN 'FALAR'.
          l_fieldname = g_fieldname_falar.
        WHEN 'FATYP'.
          l_fieldname = g_fieldname_fatyp.
        WHEN 'BEWAR'.
          l_fieldname = g_fieldname_bewar.
*       Michael Manoch, 11.02.2010, MED-38637   START
      ENDCASE.
*-- begin Grill, MED-45019
    WHEN 'RN1_DYNP_ADMISSION'.
      CASE es_message-field.
        WHEN g_fieldname2_fatyp.
          l_fieldname = co_fieldname_fatyp.
        WHEN g_fieldname2_falar.
          l_fieldname = co_fieldname_falar.
        WHEN g_fieldname2_bewar.
          l_fieldname = co_fieldname_bewar.
      ENDCASE.
*-- end Grill, MED-45019
  ENDCASE.

* Set es_message-parameter/field.
  IF NOT l_fieldname IS INITIAL.
    SPLIT l_fieldname
      AT '-'
      INTO l_cursorfield_prefix
           l_cursorfield.
    es_message-field = l_cursorfield.
  ENDIF.

ENDMETHOD.


METHOD check_bekat_for_pvpat .

  DATA: lt_tn24f   TYPE STANDARD TABLE OF tn24f,
        l_cvers    TYPE tn00-cvers,
        lr_klfart  TYPE RANGE OF nfkl-klfart,
        lr_klftyp  TYPE RANGE OF nfkl-klftyp.

  e_pvpat = off.

* read KLFTYP and KLFARTen (they title the private patient)
  CALL FUNCTION 'ISH_COUNTRY_VERSION_GET'
    IMPORTING
      ss_cvers = l_cvers.
  REFRESH lr_klfart.
  CALL FUNCTION 'ISH_KLTYP_KLART_PRIVATPAT'
    EXPORTING
      i_cvers     = l_cvers
    TABLES
      rtab_klftyp = lr_klftyp
      rtab_klfart = lr_klfart.
  REFRESH lt_tn24f.
  SELECT * FROM tn24f INTO TABLE lt_tn24f
           WHERE einri  =  i_einri
           AND   bekat  =  i_bekat
           AND   klftyp IN lr_klftyp
           AND   klfart IN lr_klfart.
  IF sy-subrc = 0.
    e_pvpat = on.
  ENDIF.

ENDMETHOD.


METHOD class_constructor .

* SET THE GLOBAL FIELD VALUES
  g_fieldname_sc_lb_falar     = 'SC_LB_FALAR'.
  g_fieldname_sc_lb_fatyp     = 'SC_LB_FATYP'.
  g_fieldname_sc_lb_bewar     = 'SC_LB_BEWAR'.
  g_fieldname_bekat           = 'RN1_DYNP_ADMISSION-BEKAT'.
  g_fieldname_bktxt           = 'RN1_DYNP_ADMISSION-BKTXT'.
  g_fieldname_pvpat           = 'RN1_DYNP_ADMISSION-PVPAT'.
  g_fieldname_bewar_txt       = 'RN1_DYNP_ADMISSION-BEWAR_TXT'.
  g_fieldname_box_txt         = 'RN1_DYNP_ADMISSION-BOX_TXT'.
*-- begin Grill, MED-45019
** Michael Manoch, 11.02.2010, MED-38637   START
*  g_fieldname_falar           = 'RN1_DYNP_ADMISSION-FALAR'.
*  g_fieldname_fatyp           = 'RN1_DYNP_ADMISSION-FATYP'.
*  g_fieldname_bewar           = 'RN1_DYNP_ADMISSION-BEWAR'.
** Michael Manoch, 11.02.2010, MED-38637   END
*-- end Grill, MED-45019

ENDMETHOD.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_default_tabname.
  GET REFERENCE OF co_default_tabname INTO gr_default_tabname.

ENDMETHOD.


METHOD create .

* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* create instance
  CREATE OBJECT er_instance
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    e_rc = 1.
*   the instance couldn't be created
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '003'
        i_mv1           = 'CL_ISH_SCR_ADMISSION'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD create_listbox_bewar .

* definition
  DATA: l_einri               TYPE tn01-einri,
        l_bewty               TYPE bewty,
        l_bwidt               TYPE sy-datum,
        l_vrm_id              TYPE vrm_id,
        lr_prereg             TYPE REF TO cl_ishmed_prereg,
*        lr_scr_lb_bewar       TYPE REF TO cl_ish_scr_listbox,  "MED-38637
        lr_cordtyp            TYPE REF TO cl_ish_cordtyp,
*        ls_help_info          TYPE help_info,  "MED-38637
        lr_lb_object          TYPE REF TO cl_ish_listbox,
        l_is_op               TYPE ish_on_off.            "ID: 14675

* Michael Manoch, 11.02.2010, MED-38637   START
** Get the bewar listbox screen.
*  CALL METHOD get_scr_lb_bewar
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb_bewar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
* Michael Manoch, 11.02.2010, MED-38637   END

* Get corresponding cordpos.
  lr_prereg = get_cordpos( ).
  CHECK NOT lr_prereg IS INITIAL.

* Get einri.
  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  CHECK NOT l_einri IS INITIAL.

* Get parameters for listbox object.
  lr_cordtyp = lr_prereg->get_cordtyp( ).
  CHECK NOT lr_cordtyp IS INITIAL.
  l_bewty = lr_cordtyp->get_bewty( ).
  IF l_bewty IS INITIAL.
*   set as default admission
    l_bewty = '1'.
  ENDIF.
  l_bwidt = sy-datum.

* Käfer, ID: 14675 - Begin
* is the current orderposition an op-position,
* so another listbox will be used.
  CALL METHOD lr_prereg->is_op
    IMPORTING
      e_is_op = l_is_op.

* Käfer, ID: 14675 - End

* Build listbox
* Michael Manoch, 11.02.2010, MED-38637   START
*  l_vrm_id = lr_scr_lb_bewar->get_lbname( ).
  l_vrm_id = g_fieldname_bewar.
* Michael Manoch, 11.02.2010, MED-38637   END
* Käfer, ID: 14675 - Begin
  IF l_bewty = '4' AND l_is_op = on.
    CALL METHOD cl_ishmed_lb_bwart_op=>fill_listbox
      EXPORTING
        i_fieldname  = l_vrm_id
        i_einri      = l_einri
        i_bewty      = l_bewty
        i_bwidt      = l_bwidt
      IMPORTING
        e_rc         = e_rc
        er_lb_object = lr_lb_object.

  ELSE.
* Käfer, ID: 14675 - End
    CALL METHOD cl_ish_lb_bwart=>fill_listbox
      EXPORTING
        i_fieldname  = l_vrm_id
        i_einri      = l_einri
        i_bewty      = l_bewty
        i_bwidt      = l_bwidt
      IMPORTING
        e_rc         = e_rc
        er_lb_object = lr_lb_object.

  ENDIF.                                "Käfer, ID:14675
  CHECK e_rc = 0.
  CHECK NOT lr_lb_object IS INITIAL.

* Michael Manoch, 11.02.2010, MED-38637   START
** set help infos for listbox
*  CLEAR ls_help_info.
*  ls_help_info-call      = 'D'.              "show doku
*  ls_help_info-object    = 'F'.
*  ls_help_info-spras     = sy-langu.
*  ls_help_info-title     = sy-title.
*  ls_help_info-tcode     = sy-tcode.
*  ls_help_info-docuid    = 'NA'.
*  ls_help_info-menufunct = '-DOK'.
*  ls_help_info-docuid    = 'FE'.
*  ls_help_info-tabname   = 'N1VKG'.
*  ls_help_info-fieldname = 'BEWAR'.
*  CALL METHOD lr_scr_lb_bewar->set_help_info
*    EXPORTING
*      is_help_info = ls_help_info.
*
** Set listbox object in listbox screen.
*  CALL METHOD lr_scr_lb_bewar->set_listbox
*    EXPORTING
*      ir_listbox = lr_lb_object.
* Michael Manoch, 11.02.2010, MED-38637   END

* Export listbox object
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD create_listbox_falar .

* definition
  DATA: l_vrm_id            TYPE vrm_id,
        lr_prereg           TYPE REF TO cl_ishmed_prereg,
        l_falar             TYPE nfal-falar,
        lr_cordtyp          TYPE REF TO cl_ish_cordtyp,
*        ls_help_info        TYPE help_info,  "MED-38637
*        lr_scr_lb_falar     TYPE REF TO cl_ish_scr_listbox,  "MED-38637
        lr_lb_object        TYPE REF TO cl_ish_listbox,
        l_bewty             type bewty.                    "ID: 14675

* Michael Manoch, 11.02.2010, MED-38637   START
** Get the falar listbox screen.
*  CALL METHOD get_scr_lb_falar
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_falar = lr_scr_lb_falar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
* Michael Manoch, 11.02.2010, MED-38637   END
  CHECK e_rc = 0.

* Get corresponding cordpos.
  lr_prereg = get_cordpos( ).
  CHECK NOT lr_prereg IS INITIAL.


* Get parameters for listbox object.
  lr_cordtyp = lr_prereg->get_cordtyp( ).
  CHECK NOT lr_cordtyp IS INITIAL.
  l_falar = lr_cordtyp->get_falar( ).
  IF l_falar IS INITIAL.
*   set as default admission
    l_falar = '1'.
  ENDIF.

* Käfer, ID: 14675 - Begin
  l_bewty = lr_cordtyp->get_bewty( ).
* Käfer, ID: 14675 - End

* Build listbox
* Michael Manoch, 11.02.2010, MED-38637   START
*  l_vrm_id = lr_scr_lb_falar->get_lbname( ).
  l_vrm_id = g_fieldname_falar.
* Michael Manoch, 11.02.2010, MED-38637   END
  CALL METHOD cl_ish_lb_falar=>fill_listbox
    EXPORTING
      i_fieldname  = l_vrm_id
      i_falar      = l_falar
      i_bewty      = l_bewty                  "ID: 14675
    IMPORTING
      e_rc         = e_rc
      er_lb_object = lr_lb_object.

* Michael Manoch, 11.02.2010, MED-38637   START
** set help infos for listbox
*  CLEAR ls_help_info.
*  ls_help_info-call      = 'D'.              "show doku
*  ls_help_info-object    = 'F'.
*  ls_help_info-spras     = sy-langu.
*  ls_help_info-title     = sy-title.
*  ls_help_info-tcode     = sy-tcode.
*  ls_help_info-docuid    = 'NA'.
*  ls_help_info-menufunct = '-DOK'.
*  ls_help_info-docuid    = 'FE'.
*  ls_help_info-tabname   = 'N1VKG'.
*  ls_help_info-fieldname = 'FALAR'.
*  CALL METHOD lr_scr_lb_falar->set_help_info
*    EXPORTING
*      is_help_info = ls_help_info.
*
** Set listbox object in listbox screen.
*  CALL METHOD lr_scr_lb_falar->set_listbox
*    EXPORTING
*      ir_listbox = lr_lb_object.
* Michael Manoch, 11.02.2010, MED-38637   END


* Export listbox object
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD create_listbox_fatyp .

* definition
  DATA: l_vrm_id      TYPE vrm_id,
        lr_prereg     TYPE REF TO cl_ishmed_prereg,
        l_fatyp       TYPE ish_casetype,
        lr_cordtyp    TYPE REF TO cl_ish_cordtyp,
*        ls_help_info        TYPE help_info,  "MED-38637
*        lr_scr_lb_fatyp     TYPE REF TO cl_ish_scr_listbox,  "MED-38637
        lr_lb_object  TYPE REF TO cl_ish_listbox,
        l_einri       TYPE tn01-einri,
*BEGIN IXX-204 NPopa 04.11.2014
        lt_vrm_values TYPE vrm_values,
        ls_n1vkg      TYPE n1vkg,
        ls_tn15s      TYPE tn15s.
*END IXX-204

* Michael Manoch, 11.02.2010, MED-38637   START
** Get the fatyp listbox screen.
*  CALL METHOD get_scr_lb_fatyp
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_fatyp = lr_scr_lb_fatyp
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
* Michael Manoch, 11.02.2010, MED-38637   END

* Get corresponding cordpos.
  lr_prereg = get_cordpos( ).
  CHECK NOT lr_prereg IS INITIAL.

* Get einri.
  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  CHECK NOT l_einri IS INITIAL.

* Get parameters for listbox object.
  lr_cordtyp = lr_prereg->get_cordtyp( ).
  CHECK NOT lr_cordtyp IS INITIAL.
*  l_fatyp = lr_cordtyp->get_fatyp( ).
*  IF l_fatyp IS INITIAL.
**    set default
*    l_fatyp = ?.
*  ENDIF.

* Build listbox
* Michael Manoch, 11.02.2010, MED-38637   START
*  l_vrm_id = lr_scr_lb_fatyp->get_lbname( ).
  l_vrm_id = g_fieldname_fatyp.
* Michael Manoch, 11.02.2010, MED-38637   END
  CALL METHOD cl_ish_lb_fatyp=>fill_listbox
    EXPORTING
      i_fieldname  = l_vrm_id
      i_fatyp      = l_fatyp
      i_einri      = l_einri
    IMPORTING
      e_rc         = e_rc
      er_lb_object = lr_lb_object.

*BEGIN IXX-204 NPopa 03.11.2014
* Read the database value for fatyp and set it into the buffer structure gs_saved_fatyp
  IF gs_saved_fatyp IS INITIAL.
    lr_prereg->get_data(
      EXPORTING
        i_fill_prereg  = off    " ALLE Felder der Vormerkung befüllen ON/OFF
      IMPORTING
        e_rc           = e_rc    " Returncode
        "e_n1vkg        =     " Daten der Vormerkung
        e_old_n1vkg    = ls_n1vkg    " "Alte" N1VKG, d.h. Stand von der Datenbank
      CHANGING
        c_errorhandler = cr_errorhandler    " IS-H*MED: Klasse zur Fehlerabarbeitung
    ).

*   If the order position has a case type then set the buffer structure, otherwise it will remain empty.
    IF ls_n1vkg-fatyp IS NOT INITIAL.
      SELECT SINGLE * FROM tn15s INTO ls_tn15s WHERE spras = sy-langu AND einri = l_einri AND casety = ls_n1vkg-fatyp.
      gs_saved_fatyp-key = ls_n1vkg-fatyp.
      gs_saved_fatyp-text = ls_tn15s-casetx.
    ENDIF.
  ENDIF.

* If there is a SAVED case type for the order position but it has been customized as an inactive case type,
* then it won't be in the dropdown table of values and should be added manually to the list
  IF gs_saved_fatyp IS NOT INITIAL.
    lt_vrm_values = lr_lb_object->get_vrm_values( ).

    READ TABLE lt_vrm_values WITH KEY key = gs_saved_fatyp-key TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      APPEND gs_saved_fatyp TO lt_vrm_values.

      CALL FUNCTION 'VRM_SET_VALUES'
        EXPORTING
          id              = l_vrm_id
          values          = lt_vrm_values
        EXCEPTIONS
          id_illegal_name = 1
          OTHERS          = 2.
      e_rc = sy-subrc.
    ENDIF.
  ENDIF.
*END IXX-204

* Michael Manoch, 11.02.2010, MED-38637   START
** set help infos for listbox
*  CLEAR ls_help_info.
*  ls_help_info-call      = 'D'.              "show doku
*  ls_help_info-object    = 'F'.
*  ls_help_info-spras     = sy-langu.
*  ls_help_info-title     = sy-title.
*  ls_help_info-tcode     = sy-tcode.
*  ls_help_info-docuid    = 'NA'.
*  ls_help_info-menufunct = '-DOK'.
*  ls_help_info-docuid    = 'FE'.
*  ls_help_info-tabname   = 'N1VKG'.
*  ls_help_info-fieldname = 'FATYP'.
*  CALL METHOD lr_scr_lb_fatyp->set_help_info
*    EXPORTING
*      is_help_info = ls_help_info.
*
** Set listbox object in listbox screen.
*  CALL METHOD lr_scr_lb_fatyp->set_listbox
*    EXPORTING
*      ir_listbox = lr_lb_object.
* Michael Manoch, 11.02.2010, MED-38637   END

* Export listbox object
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD create_listbox_internal .

* Initializations
  CLEAR: e_rc.

  CASE i_fieldname.
*   Michael Manoch, 11.02.2010, MED-38637   START
*    WHEN g_fieldname_sc_lb_falar.
    WHEN g_fieldname_falar.
*   Michael Manoch, 11.02.2010, MED-38637   END
      CALL METHOD create_listbox_falar
        IMPORTING
          er_lb_object    = er_lb_object
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
*   Michael Manoch, 11.02.2010, MED-38637   START
*    WHEN g_fieldname_sc_lb_fatyp.
    WHEN g_fieldname_fatyp.
*   Michael Manoch, 11.02.2010, MED-38637   END
      CALL METHOD create_listbox_fatyp
        IMPORTING
          er_lb_object    = er_lb_object
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
*   Michael Manoch, 11.02.2010, MED-38637   START
*    WHEN g_fieldname_sc_lb_bewar.
    WHEN g_fieldname_bewar.
*   Michael Manoch, 11.02.2010, MED-38637   END
      CALL METHOD create_listbox_bewar
        IMPORTING
          er_lb_object    = er_lb_object
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
  ENDCASE.

ENDMETHOD.


METHOD fill_all_labels .

* Initializations
  CLEAR: e_rc.

* BKTXT
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_bktxt
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* BEWAR_TXT
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_bewar_txt
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* BOX_TXT
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_box_txt
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD fill_label_bewar_txt .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_bewar_txt TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_bewty TYPE nbew-bewty,
        l_bewar_txt(14) TYPE c,
        l_einri TYPE einri,
        lr_prereg TYPE REF TO cl_ishmed_prereg,
        lr_cordtyp TYPE REF TO cl_ish_cordtyp,
        ls_n1cordtyp TYPE n1cordtyp,
        l_wa_tn14t TYPE tn14t.
* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

* get main object -> check if prereg
  IF gr_main_object->is_inherited_from(
      cl_ishmed_prereg=>co_otype_prereg ) = 'X'.
    lr_prereg ?= gr_main_object.
  ENDIF.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

  CHECK e_rc = 0.
*  READ TABLE lt_field_values INTO l_wa_field_value_bewar_txt
*     WITH KEY fieldname = g_fieldname_bewar_txt.
*  CHECK sy-subrc EQ 0.

* if main object is prereg then get the cordtyp
  IF NOT lr_prereg IS INITIAL.
    CALL METHOD lr_prereg->get_cordtyp
      RECEIVING
        rr_cordtyp = lr_cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.
    CALL METHOD lr_cordtyp->get_data
      IMPORTING
        es_n1cordtyp = ls_n1cordtyp.
    CHECK NOT ls_n1cordtyp IS INITIAL.
    l_bewty = ls_n1cordtyp-bewty.
    CHECK sy-subrc EQ 0.
  ELSE.
*   set as default admission
    l_bewty = '1'.
  ENDIF.

  IF l_bewty = '1'.
    l_bewar_txt = 'Aufnahmeart'(001).
  ELSE.
    l_bewar_txt = 'Bewegungsart'(002).
  ENDIF.

*  CALL FUNCTION 'ISH_READ_TNTEXT_TABLES'
*    EXPORTING
*      einri        = l_einri
*      read_db      = 'X'
*      read_tn14t   = 'X'
*      tn14tu_bewty = l_bewty
*    IMPORTING
*      o_tn14t      = l_wa_tn14t.
*
*  l_bewar_txt = l_wa_tn14t-bewtx.

  l_wa_field_value_bewar_txt-value = l_bewar_txt.

  MODIFY lt_field_values FROM l_wa_field_value_bewar_txt
    TRANSPORTING value WHERE fieldname = g_fieldname_bewar_txt.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_bktxt .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_bekat TYPE rnfield_value,
        l_wa_field_value_bktxt TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_bekat TYPE bekat,
        l_bktxt TYPE bk_bktxt,
        l_einri TYPE einri.
* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_bekat
     WITH KEY fieldname = g_fieldname_bekat.
  CHECK sy-subrc EQ 0.
  READ TABLE lt_field_values INTO l_wa_field_value_bktxt
     WITH KEY fieldname = g_fieldname_bktxt.
  CHECK sy-subrc EQ 0.

  l_bekat = l_wa_field_value_bekat-value.

  CLEAR: l_bktxt.
* get the text from tn24t
  CALL METHOD cl_ish_utl_base_descr=>get_descr_bekat
    EXPORTING
      i_einri         = l_einri
      i_bekat         = l_bekat
    IMPORTING
      e_rc            = l_rc
      e_bktxt         = l_bktxt
    CHANGING
      cr_errorhandler = cr_errorhandler.
*  RW ID 16977 - BEGIN
*  Do not exit on invalid BEKAT =>
*  BKTXT of previous BEKAT will not be deleted in field values.
*  CHECK l_rc = 0.
*  RW ID 16977 - END

  l_wa_field_value_bktxt-value = l_bktxt.

  MODIFY lt_field_values FROM l_wa_field_value_bktxt
    TRANSPORTING value WHERE fieldname = g_fieldname_bktxt.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_box_txt .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_box_txt TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_bewty TYPE nbew-bewty,
        l_box_txt(15) TYPE c,
        l_einri TYPE einri,
        lr_prereg TYPE REF TO cl_ishmed_prereg,
        lr_cordtyp TYPE REF TO cl_ish_cordtyp,
        ls_n1cordtyp TYPE n1cordtyp,
        l_wa_tn14t TYPE tn14t.
* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

* get main object -> check if prereg
  IF gr_main_object->is_inherited_from(
      cl_ishmed_prereg=>co_otype_prereg ) = 'X'.
    lr_prereg ?= gr_main_object.
  ENDIF.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

  CHECK e_rc = 0.
*  READ TABLE lt_field_values INTO l_wa_field_value_bewar_txt
*     WITH KEY fieldname = g_fieldname_bewar_txt.
*  CHECK sy-subrc EQ 0.

* if main object is prereg then get the cordtyp
  IF NOT lr_prereg IS INITIAL.
    CALL METHOD lr_prereg->get_cordtyp
      RECEIVING
        rr_cordtyp = lr_cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.
    CALL METHOD lr_cordtyp->get_data
      IMPORTING
        es_n1cordtyp = ls_n1cordtyp.
    CHECK NOT ls_n1cordtyp IS INITIAL.
    l_bewty = ls_n1cordtyp-bewty.
    CHECK sy-subrc EQ 0.
  ELSE.
*   set as default admission
    l_bewty = '1'.
  ENDIF.

  CALL FUNCTION 'ISH_READ_TNTEXT_TABLES'
    EXPORTING
      einri        = l_einri
      read_db      = 'X'
      read_tn14t   = 'X'
      tn14tu_bewty = l_bewty
    IMPORTING
      o_tn14t      = l_wa_tn14t.

  l_box_txt = l_wa_tn14t-bewtx.

  l_wa_field_value_box_txt-value = l_box_txt.

  MODIFY lt_field_values FROM l_wa_field_value_box_txt
    TRANSPORTING value WHERE fieldname = g_fieldname_box_txt.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_internal .

* Initializations
  CLEAR: e_rc.

  CASE i_fieldname.
    WHEN g_fieldname_bktxt.
      CALL METHOD fill_label_bktxt
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    WHEN g_fieldname_bewar_txt.
      CALL METHOD fill_label_bewar_txt
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    WHEN g_fieldname_box_txt.
      CALL METHOD fill_label_box_txt
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
  ENDCASE.

ENDMETHOD.


METHOD fill_t_scrm_field .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* falar
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_sc_lb_falar.
  ls_scrm_field-fieldlabel = 'Fallart'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

* fatyp
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_sc_lb_fatyp.
  ls_scrm_field-fieldlabel = 'Falltyp'(005).
  APPEND ls_scrm_field TO gt_scrm_field.

* bewar
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_sc_lb_bewar.
  ls_scrm_field-fieldlabel = 'Aufnahmeart'(001).
  APPEND ls_scrm_field TO gt_scrm_field.

* bekat
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_bekat.
  ls_scrm_field-fieldlabel = 'BehKategorie'(004).
  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD get_cordpos.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.

  rr_cordpos ?= gr_main_object.

ENDMETHOD.


method GET_FALART_BY_FALNR_FROM_DB.
* Created By Alex Maiereanu,14.05.2012
* Created For Isis : MED-47523
* Details:
* We need to get the falart, that will be used for later preallocation

* MED-55847 Cristina Geanta 26.05.2014
*  CHECK i_falnr IS NOT INITIAL.
*
*  SELECT SINGLE falar FROM nfal INTO r_falart WHERE falnr = i_falnr.

  DATA: lv_einri TYPE tn01-einri,
        ls_nfal  TYPE nfal.

  CLEAR: lv_einri, ls_nfal.
  CHECK i_falnr IS NOT INITIAL.

  IF gr_main_object IS NOT INITIAL.
    lv_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  ENDIF.
  CHECK lv_einri IS NOT INITIAL.

  CALL FUNCTION 'ISH_READ_NFAL'
    EXPORTING
      ss_einri              = lv_einri
      ss_falnr              = i_falnr
    IMPORTING
      ss_nfal               = ls_nfal
    EXCEPTIONS
      not_found             = 1
      not_found_archived    = 2
      no_authority          = 3
      no_treatment_contract = 4
      OTHERS                = 5.

  IF sy-subrc EQ 0.
    r_falart = ls_nfal-falar.
  ENDIF.
* END MED-55847 Cristina Geanta 26.05.2014


endmethod.


METHOD get_scr_lb_bewar.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: ls_field_val      TYPE rnfield_value,
*        lr_scr_lb_bewar   TYPE REF TO cl_ish_scr_listbox.
*
*  CHECK NOT gr_screen_values IS INITIAL.
*
** Get screen from field values.
*  CALL METHOD gr_screen_values->get_data
*    EXPORTING
*      i_fieldname    = g_fieldname_sc_lb_bewar
*      i_type         = co_fvtype_screen
*    IMPORTING
*      e_field_value  = ls_field_val
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Set er_scr_lb_cot.
*  er_scr_lb_bewar ?= ls_field_val-object.
*  CHECK er_scr_lb_bewar IS INITIAL.
*
** Further processing depends on i_create.
*  CHECK i_create = on.
*
** Checkout a listbox screen.
*  CALL METHOD cl_ish_scr_listbox=>checkout
*    EXPORTING
*      i_lbtype        = cl_ish_scr_listbox=>co_lbtype_lb15
*    IMPORTING
*      er_scr_listbox  = lr_scr_lb_bewar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Initialize the listbox screen.
*  CALL METHOD lr_scr_lb_bewar->initialize
*    EXPORTING
*      i_main_object  = gr_main_object
*      i_vcode        = g_vcode
*      i_caller       = g_caller
*      i_environment  = gr_environment
*      i_lock         = gr_lock
*      i_config       = gr_config
*    IMPORTING
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Register event handlers.
**  SET HANDLER handle_ev_user_command FOR lr_scr_lb_bewar.
*
** Export.
*  er_scr_lb_bewar = lr_scr_lb_bewar.

ENDMETHOD.


METHOD get_scr_lb_falar.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: ls_field_val      TYPE rnfield_value,
*        lr_scr_lb_falar   TYPE REF TO cl_ish_scr_listbox.
*
*  CHECK NOT gr_screen_values IS INITIAL.
*
** Get screen from field values.
*  CALL METHOD gr_screen_values->get_data
*    EXPORTING
*      i_fieldname    = g_fieldname_sc_lb_falar
*      i_type         = co_fvtype_screen
*    IMPORTING
*      e_field_value  = ls_field_val
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Set er_scr_lb_falar.
*  er_scr_lb_falar ?= ls_field_val-object.
*  CHECK er_scr_lb_falar IS INITIAL.
*
** Further processing depends on i_create.
*  CHECK i_create = on.
*
** Checkout a listbox screen.
*  CALL METHOD cl_ish_scr_listbox=>checkout
*    EXPORTING
*      i_lbtype        = cl_ish_scr_listbox=>co_lbtype_lb15f
*    IMPORTING
*      er_scr_listbox  = lr_scr_lb_falar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Initialize the listbox screen.
*  CALL METHOD lr_scr_lb_falar->initialize
*    EXPORTING
*      i_main_object  = gr_main_object
*      i_vcode        = g_vcode
*      i_caller       = g_caller
*      i_environment  = gr_environment
*      i_lock         = gr_lock
*      i_config       = gr_config
*    IMPORTING
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Register event handlers.
**  SET HANDLER handle_ev_user_command FOR lr_scr_lb_falar.
*
** Export.
*  er_scr_lb_falar = lr_scr_lb_falar.

ENDMETHOD.


METHOD get_scr_lb_fatyp .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: ls_field_val      TYPE rnfield_value,
*        lr_scr_lb_fatyp   TYPE REF TO cl_ish_scr_listbox.
*
*  CHECK NOT gr_screen_values IS INITIAL.
*
** Get screen from field values.
*  CALL METHOD gr_screen_values->get_data
*    EXPORTING
*      i_fieldname    = g_fieldname_sc_lb_fatyp
*      i_type         = co_fvtype_screen
*    IMPORTING
*      e_field_value  = ls_field_val
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Set er_scr_lb_fatyp.
*  er_scr_lb_fatyp ?= ls_field_val-object.
*  CHECK er_scr_lb_fatyp IS INITIAL.
*
** Further processing depends on i_create.
*  CHECK i_create = on.
*
** Checkout a listbox screen.
*  CALL METHOD cl_ish_scr_listbox=>checkout
*    EXPORTING
*      i_lbtype        = cl_ish_scr_listbox=>co_lbtype_lb15f
*    IMPORTING
*      er_scr_listbox  = lr_scr_lb_fatyp
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Initialize the listbox screen.
*  CALL METHOD lr_scr_lb_fatyp->initialize
*    EXPORTING
*      i_main_object  = gr_main_object
*      i_vcode        = g_vcode
*      i_caller       = g_caller
*      i_environment  = gr_environment
*      i_lock         = gr_lock
*      i_config       = gr_config
*    IMPORTING
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Register event handlers.
**  SET HANDLER handle_ev_user_command FOR lr_scr_lb_fatyp.
*
** Export.
*  er_scr_lb_fatyp = lr_scr_lb_fatyp.

ENDMETHOD.


METHOD get_scr_lb_for_lbname.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb  TYPE REF TO cl_ish_scr_listbox,
*        l_rc       TYPE ish_method_rc.
*
*  CLEAR rr_scr_lb.
*
*  CHECK NOT i_lbname IS INITIAL.
*
** scr_lb_falar
*  CALL METHOD get_scr_lb_falar
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_falar = lr_scr_lb
*      e_rc            = l_rc.
*  IF l_rc = 0.
*    IF i_lbname = lr_scr_lb->get_lbname( ).
*      rr_scr_lb = lr_scr_lb.
*      EXIT.
*    ENDIF.
*  ENDIF.
*
** sc_lb_bewar
*  CALL METHOD get_scr_lb_bewar
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb
*      e_rc            = l_rc.
*  IF l_rc = 0.
*    IF i_lbname = lr_scr_lb->get_lbname( ).
*      rr_scr_lb = lr_scr_lb.
*      EXIT.
*    ENDIF.
*  ENDIF.

ENDMETHOD.


METHOD get_t_scrmod_std.

* Michael Manoch, 11.02.2010, MED-38637
* Method redefined.

* For is-h screenmodifications we always use dynpro 0100.

  DATA l_tmp_dynnr            TYPE sydynnr.

  l_tmp_dynnr = gs_parent-dynnr.
  gs_parent-dynnr = co_dynnr_from.

  CALL METHOD super->get_t_scrmod_std
    IMPORTING
      et_scrmod       = et_scrmod
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  gs_parent-dynnr = l_tmp_dynnr.

ENDMETHOD.


METHOD handle_ev_user_command.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: l_lbname        TYPE string,
*        l_ucomm_prefix  TYPE sy-ucomm,
*        l_done          TYPE ish_on_off,
*        lr_scr_lb       TYPE REF TO cl_ish_scr_listbox,
*        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,
*        l_rc            TYPE ish_method_rc.
*
** Initializations.
*  l_done = off.
*
** Check i_ucomm.
*  SPLIT i_ucomm
*      AT '-'
*    INTO l_ucomm_prefix
*         l_lbname.
*  CHECK l_ucomm_prefix = if_ish_screen=>co_ucomm_scr_help_request.
*
** Get the listbox screen for l_lbname.
*  lr_scr_lb = get_scr_lb_for_lbname( l_lbname ).
*
** Process help request.
*  l_done = off.
*  IF NOT lr_scr_lb IS INITIAL.
*    CALL METHOD lr_scr_lb->help_request
*      IMPORTING
*        e_rc            = l_rc
*      CHANGING
*        cr_errorhandler = lr_errorhandler.
*    l_done = on.
*  ENDIF.
*
** Set event result.
*  CALL METHOD ir_screen->set_ev_user_command_result
*    EXPORTING
*      i_done          = l_done
*      i_supported     = on
*      i_rc            = l_rc
*      ir_errorhandler = lr_errorhandler.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_admission.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_admission.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off. ID-16230
  ENDIF.

ENDMETHOD.


method IF_ISH_SCREEN~CREATE_ALL_LISTBOXES .

* FALAR
  CALL METHOD create_listbox
    EXPORTING
*     Michael Manoch, 11.02.2010, MED-38637   START
*      i_fieldname     = g_fieldname_sc_lb_falar
      i_fieldname     = g_fieldname_falar
*     Michael Manoch, 11.02.2010, MED-38637   END
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* FATYP
  CALL METHOD create_listbox
    EXPORTING
*     Michael Manoch, 11.02.2010, MED-38637   START
*      i_fieldname     = g_fieldname_sc_lb_fatyp
      i_fieldname     = g_fieldname_fatyp
*     Michael Manoch, 11.02.2010, MED-38637   END
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* BEWAR
  CALL METHOD create_listbox
    EXPORTING
*     Michael Manoch, 11.02.2010, MED-38637   START
*      i_fieldname     = g_fieldname_sc_lb_bewar
      i_fieldname     = g_fieldname_bewar
*     Michael Manoch, 11.02.2010, MED-38637   END
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

endmethod.


METHOD if_ish_screen~destroy.

* Michael Manoch, 11.02.2010, MED-38637
* Whole method redesigned.

* Deregister from dynproconnector.
  cl_ish_dynpconn_mgr=>disconnect_screen( ir_screen = me ). "MED-44521

  CALL METHOD super->if_ish_screen~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.


*  DATA: l_rc                  TYPE ish_method_rc,
*        lr_scr_lb_falar       TYPE REF TO cl_ish_scr_listbox,
*        lr_scr_lb_bewar       TYPE REF TO cl_ish_scr_listbox.
*
** Destroy super class(es).
*  CALL METHOD super->if_ish_screen~destroy
*    IMPORTING
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*  ENDIF.
*
** Deregister event handlers
*  SET HANDLER handle_ev_user_command
*    FOR ALL INSTANCES
*    ACTIVATION space.
*
** Destroy listboxes.
*
** LB_FALAR
*  CALL METHOD get_scr_lb_falar
*    IMPORTING
*      er_scr_lb_falar = lr_scr_lb_falar
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*  ENDIF.
*  IF NOT lr_scr_lb_falar IS INITIAL.
*    CALL METHOD lr_scr_lb_falar->destroy
*      IMPORTING
*        e_rc            = l_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    IF l_rc <> 0.
*      e_rc = l_rc.
*    ENDIF.
***   Deregister event handlers
**    SET HANDLER handle_ev_user_command
**      FOR lr_scr_lb_falar
**      ACTIVATION space.
*  ENDIF.
*
** LB_BEWAR
*  CALL METHOD get_scr_lb_bewar
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb_bewar
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*  ENDIF.
*  IF NOT lr_scr_lb_bewar IS INITIAL.
*    CALL METHOD lr_scr_lb_bewar->destroy
*      IMPORTING
*        e_rc            = l_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    IF l_rc <> 0.
*      e_rc = l_rc.
*    ENDIF.
***   Deregister event handlers
**    SET HANDLER handle_ev_user_command
**      FOR lr_scr_lb_bewar
**      ACTIVATION space.
*  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~get_fields_definition.

  FIELD-SYMBOLS: <ls_def>  LIKE LINE OF et_fields_definition.

* First call the super method.
  CALL METHOD super->if_ish_screen~get_fields_definition
    IMPORTING
      et_fields_definition = et_fields_definition
      e_rc                 = e_rc
    CHANGING
      c_errorhandler       = c_errorhandler.

* Wrap the fieldname for listbox fields.
  LOOP AT et_fields_definition ASSIGNING <ls_def>.
    CASE <ls_def>-name.
      WHEN g_fieldname_falar.
        <ls_def>-name = co_fieldname_falar.
      WHEN g_fieldname_fatyp.
        <ls_def>-name = co_fieldname_fatyp.
      WHEN g_fieldname_bewar.
        <ls_def>-name = co_fieldname_bewar.
    ENDCASE.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_screen~modify_screen.

  FIELD-SYMBOLS: <ls_scrmod>  LIKE LINE OF gt_scrmod.

  CALL METHOD super->if_ish_screen~modify_screen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

* Now wrap the listbox fieldnames.
  LOOP AT gt_scrmod ASSIGNING <ls_scrmod>.
    CASE <ls_scrmod>-name.
      WHEN g_fieldname_falar.
        <ls_scrmod>-name = co_fieldname_falar.
      WHEN g_fieldname_fatyp.
        <ls_scrmod>-name = co_fieldname_fatyp.
      WHEN g_fieldname_bewar.
        <ls_scrmod>-name = co_fieldname_bewar.
    ENDCASE.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_screen~set_cursor .

* Michael Manoch, 11.02.2010, MED-38637
* Whole method redesigned.

  CALL METHOD super->if_ish_screen~set_cursor
    EXPORTING
      i_rn1message   = i_rn1message
      i_cursorfield  = i_cursorfield
      i_set_cursor   = i_set_cursor
    IMPORTING
      e_cursor_set   = e_cursor_set
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler.


*  DATA: l_rc             TYPE ish_method_rc.
*
** Initializations.
*  IF c_errorhandler IS INITIAL.
*    CREATE OBJECT c_errorhandler.
*  ENDIF.
*
** Set cursor in self with super method.
*  CALL METHOD super->if_ish_screen~set_cursor
*    EXPORTING
*      i_rn1message   = i_rn1message
*      i_cursorfield  = i_cursorfield
*      i_set_cursor   = i_set_cursor
*    IMPORTING
*      e_cursor_set   = e_cursor_set
*      e_rc           = l_rc
*    CHANGING
*      c_errorhandler = c_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*    e_cursor_set = off.
*  ENDIF.
*
** Further processing only if cursor not already set.
**  CHECK e_cursor_set = off.    "Grill, med-34086
*   CHECK i_rn1message-parameter+0(3) NE 'RN1'.
*
** Handle embedded listbox screens.
*
** lb_falar
*  CALL METHOD set_cursor_lb_falar
*    EXPORTING
*      is_message      = i_rn1message
*      i_cursorfield   = i_cursorfield
*      i_set_cursor    = i_set_cursor
*    IMPORTING
*      e_cursor_set    = e_cursor_set
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = c_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*    e_cursor_set = off.
*  ENDIF.
*
*  CHECK e_cursor_set = off.   "Grill, med-34086
*
** lb_fatyp
*  CALL METHOD set_cursor_lb_fatyp
*    EXPORTING
*      is_message      = i_rn1message
*      i_cursorfield   = i_cursorfield
*      i_set_cursor    = i_set_cursor
*    IMPORTING
*      e_cursor_set    = e_cursor_set
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = c_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*    e_cursor_set = off.
*  ENDIF.
*
*  CHECK e_cursor_set = off.   "Grill, med-34086
*
** lb_bewar
*  CALL METHOD set_cursor_lb_bewar
*    EXPORTING
*      is_message      = i_rn1message
*      i_cursorfield   = i_cursorfield
*      i_set_cursor    = i_set_cursor
*    IMPORTING
*      e_cursor_set    = e_cursor_set
*      e_rc            = l_rc
*    CHANGING
*      cr_errorhandler = c_errorhandler.
*  IF l_rc <> 0.
*    e_rc = l_rc.
*    e_cursor_set = off.
*  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~set_data_from_fieldval.

* Michael Manoch, 11.02.2010, MED-38637
* Method redefined.

  DATA lr_cordpos           TYPE REF TO cl_ishmed_prereg.
  DATA ls_n1vkg             TYPE n1vkg.
  DATA ls_prereg            TYPE rn1med_prereg.
  DATA l_pvpat              TYPE n1pvpat.

  FIELD-SYMBOLS <ls_fv>     TYPE rnfield_value.

* No processing in display mode.
  CHECK g_vcode <> co_vcode_display.

* Get the cordpos.
  lr_cordpos = get_cordpos( ).
  CHECK lr_cordpos IS BOUND.

* Get cordpos data.
  CALL METHOD lr_cordpos->get_data
    IMPORTING
      e_rc           = e_rc
      e_n1vkg        = ls_n1vkg
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Build ls_prereg.
  LOOP AT it_field_values ASSIGNING <ls_fv>.
    CASE <ls_fv>-fieldname.
*      WHEN g_fieldname_falar.  "MED-45019
      WHEN co_fieldname_falar.                              "MED-45019
        CHECK <ls_fv>-value <> ls_n1vkg-falar.
        ls_prereg-falar   = <ls_fv>-value.
        ls_prereg-falar_x = on.
*      WHEN g_fieldname_fatyp.     "MED-45019
      WHEN co_fieldname_fatyp.                              "MED-45019
        CHECK <ls_fv>-value <> ls_n1vkg-fatyp.
        ls_prereg-fatyp   = <ls_fv>-value.
        ls_prereg-fatyp_x = on.
*      WHEN g_fieldname_bewar. "MED-45019
      WHEN co_fieldname_bewar.                              "MED-45019
        CHECK <ls_fv>-value <> ls_n1vkg-bewar.
        ls_prereg-bewar   = <ls_fv>-value.
        ls_prereg-bewar_x = on.
      WHEN g_fieldname_bekat.
        CHECK <ls_fv>-value <> ls_n1vkg-bekat.
        ls_prereg-bekat   = <ls_fv>-value.
        ls_prereg-bekat_x = on.
    ENDCASE.
  ENDLOOP.

* Handle pvpat.
  DO 1 TIMES.
    CHECK ls_prereg-bekat_x = abap_true.
    IF ls_prereg-bekat IS NOT INITIAL.
      CALL METHOD check_bekat_for_pvpat
        EXPORTING
          i_einri = ls_n1vkg-einri
          i_bekat = ls_prereg-bekat
        IMPORTING
          e_pvpat = l_pvpat.
    ENDIF.
    CHECK ls_n1vkg-pvpat <> l_pvpat.
    ls_prereg-pvpat   = l_pvpat.
    ls_prereg-pvpat_x = on.
  ENDDO.

* Process only on changes.
  CHECK ls_prereg IS NOT INITIAL.

* Change cordpos data.
  CALL METHOD lr_cordpos->change
    EXPORTING
      i_prereg       = ls_prereg
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_screen~set_fieldval_from_data.

* Michael Manoch, 11.02.2010, MED-38637
* Method redefined.

  DATA lr_cordpos               TYPE REF TO cl_ishmed_prereg.
  DATA ls_n1vkg                 TYPE n1vkg.

  FIELD-SYMBOLS <ls_fv>         TYPE rnfield_value.

* Get the cordpos.
  lr_cordpos = get_cordpos( ).
  CHECK lr_cordpos IS BOUND.

* Get cordpos data.
  CALL METHOD lr_cordpos->get_data
    IMPORTING
      e_rc           = e_rc
      e_n1vkg        = ls_n1vkg
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Handle pvpat.
  READ TABLE ct_field_values
    WITH KEY fieldname = g_fieldname_bekat
    ASSIGNING <ls_fv>.
  CHECK sy-subrc EQ 0.
  IF <ls_fv>-value <> ls_n1vkg-bekat.
    CALL METHOD check_bekat_for_pvpat
      EXPORTING
        i_einri = ls_n1vkg-einri
        i_bekat = ls_n1vkg-bekat
      IMPORTING
        e_pvpat = ls_n1vkg-pvpat.
  ENDIF.

* Build screen values.
  LOOP AT ct_field_values ASSIGNING <ls_fv>.
    CASE <ls_fv>-fieldname.
      WHEN g_fieldname_bekat.
        <ls_fv>-type      = co_fvtype_single.
        <ls_fv>-value     = ls_n1vkg-bekat.
      WHEN g_fieldname_pvpat.
        <ls_fv>-type      = co_fvtype_single.
        <ls_fv>-value     = ls_n1vkg-pvpat.
*      WHEN g_fieldname_falar.                "MED-45019
      WHEN co_fieldname_falar.                "MED-45019
        <ls_fv>-type      = co_fvtype_single.
        <ls_fv>-value     = ls_n1vkg-falar.
*      WHEN g_fieldname_fatyp.                "MED-45019
      WHEN co_fieldname_fatyp.                "MED-45019
        <ls_fv>-type      = co_fvtype_single.
        <ls_fv>-value     = ls_n1vkg-fatyp.
*      WHEN g_fieldname_bewar.                "MED-45019
      WHEN co_fieldname_bewar.                "MED-45019
        <ls_fv>-type      = co_fvtype_single.
        <ls_fv>-value     = ls_n1vkg-bewar.
    ENDCASE.
  ENDLOOP.

* Set screen values.
  CALL METHOD set_fields
    EXPORTING
      it_field_values  = ct_field_values
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

* Michael Manoch, 11.02.2010, MED-38637
* Whole method redesigned.

  CALL FUNCTION 'ISH_SDY_ADMISSION_INIT'
    CHANGING
      cr_dynp_data = gr_scr_data.

*  DATA: l_rc            TYPE ish_method_rc,
*        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.
*
*  CALL FUNCTION 'ISH_SDY_ADMISSION_INIT'
*    EXPORTING
*      ir_scr_admission  = me
*    IMPORTING
*      e_rc              = l_rc
*      es_parent         = gs_parent
*      er_dynpg_lb_falar = gr_dynpg_lb_falar
*      er_dynnr_lb_falar = gr_dynnr_lb_falar
*      er_dynpg_lb_bewar = gr_dynpg_lb_bewar
*      er_dynnr_lb_bewar = gr_dynnr_lb_bewar
*      er_dynpg_lb_fatyp = gr_dynpg_lb_fatyp
*      er_dynnr_lb_fatyp = gr_dynnr_lb_fatyp
*    CHANGING
*      cr_errorhandler   = lr_errorhandler
*      cr_dynp_data      = gr_scr_data.

ENDMETHOD.


METHOD if_ish_screen~transport_from_dy.

  DATA: lr_dynp         TYPE REF TO rn1_dynp_admission.

  FIELD-SYMBOLS: <l_falar>  TYPE any,
                 <l_fatyp>  TYPE any,
                 <l_bewar>  TYPE any.

  DATA: l_display_falar_disabled TYPE ish_on_off,
        l_display_fatyp_disabled TYPE ish_on_off,
        l_display_bewar_disabled TYPE ish_on_off.

* Determine the disabled fields.
  l_display_falar_disabled = on.
  l_display_fatyp_disabled = on.
  l_display_bewar_disabled = on.

  LOOP AT SCREEN.
    CHECK  screen-active = 1 AND screen-input = 1.
    CASE screen-name.
      WHEN g_fieldname_falar.
        l_display_falar_disabled = off.
      WHEN g_fieldname_bewar.
        l_display_bewar_disabled = off.
      WHEN g_fieldname_fatyp.
        l_display_fatyp_disabled = off.
    ENDCASE.
  ENDLOOP.

  TRY.
*     Cast the dynpro structure.
      lr_dynp ?= gr_scr_data.
*     Assign the listbox fields.
      ASSIGN COMPONENT g_fieldname2_falar
        OF STRUCTURE lr_dynp->*
        TO <l_falar>.
      CHECK sy-subrc = 0.
      IF l_display_falar_disabled = on.
        lr_dynp->falar = get_fieldval_single( co_fieldname_falar ).
      ELSE.
        lr_dynp->falar = <l_falar>.
      ENDIF.

      ASSIGN COMPONENT g_fieldname2_fatyp
        OF STRUCTURE lr_dynp->*
        TO <l_fatyp>.
      CHECK sy-subrc = 0.
      IF l_display_fatyp_disabled EQ on.
        lr_dynp->fatyp = get_fieldval_single( co_fieldname_fatyp ).
      ELSE.
        lr_dynp->fatyp = <l_fatyp>.
      ENDIF.

      ASSIGN COMPONENT g_fieldname2_bewar
        OF STRUCTURE lr_dynp->*
        TO <l_bewar>.
      CHECK sy-subrc = 0.
      IF l_display_bewar_disabled EQ on.
        lr_dynp->bewar = get_fieldval_single( co_fieldname_bewar ).
      ELSE.
        lr_dynp->bewar = <l_bewar>.
      ENDIF.

    CATCH cx_root.
  ENDTRY.

  CALL METHOD super->if_ish_screen~transport_from_dy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy.

  DATA: lr_dynp  TYPE REF TO rn1_dynp_admission.

  FIELD-SYMBOLS: <l_falar>  TYPE any,
                 <l_fatyp>  TYPE any,
                 <l_bewar>  TYPE any.

  CALL METHOD super->if_ish_screen~transport_to_dy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  TRY.
      lr_dynp ?= gr_scr_data.
*     Assign the listbox fields.
      ASSIGN COMPONENT g_fieldname2_falar
        OF STRUCTURE lr_dynp->*
        TO <l_falar>.
      CHECK sy-subrc = 0.
*     Transports falar
      <l_falar> = lr_dynp->falar.

      ASSIGN COMPONENT g_fieldname2_fatyp
        OF STRUCTURE lr_dynp->*
        TO <l_fatyp>.
      CHECK sy-subrc = 0.
      <l_fatyp> = lr_dynp->fatyp.

      ASSIGN COMPONENT g_fieldname2_bewar
        OF STRUCTURE lr_dynp->*
        TO <l_bewar>.
      CHECK sy-subrc = 0.
      <l_bewar> = lr_dynp->bewar.
    CATCH cx_root.                                      "#EC NO_HANDLER
  ENDTRY.


ENDMETHOD.


METHOD initialize_field_values .
* local tables
  DATA: lt_field_val            TYPE ish_t_field_value.
* workareas
  DATA: ls_field_val            TYPE rnfield_value.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
  CLEAR: lt_field_val.
* ----------
* initialize every screen field
  CLEAR: ls_field_val.
* Michael Manoch, 11.02.2010, MED-38637   START
*  ls_field_val-fieldname = g_fieldname_sc_lb_falar.
*  ls_field_val-type      = co_fvtype_screen.
*  ls_field_val-fieldname = g_fieldname_falar.  "MED-45019
  ls_field_val-fieldname = co_fieldname_falar.  "MED-45019
  ls_field_val-type      = co_fvtype_single.
* Michael Manoch, 11.02.2010, MED-38637   END
  INSERT ls_field_val INTO TABLE lt_field_val.
* Michael Manoch, 11.02.2010, MED-38637   START
*  ls_field_val-fieldname = g_fieldname_sc_lb_fatyp.
*  ls_field_val-type      = co_fvtype_screen.
*  ls_field_val-fieldname = g_fieldname_fatyp.  "MED-45019
  ls_field_val-fieldname = co_fieldname_fatyp.  "MED-45019
  ls_field_val-type      = co_fvtype_single.
* Michael Manoch, 11.02.2010, MED-38637   END
  INSERT ls_field_val INTO TABLE lt_field_val.
* Michael Manoch, 11.02.2010, MED-38637   START
*  ls_field_val-fieldname = g_fieldname_sc_lb_bewar.
*  ls_field_val-type      = co_fvtype_screen.
*  ls_field_val-fieldname = g_fieldname_bewar.  "MED-45019
  ls_field_val-fieldname = co_fieldname_bewar.  "MED-45019
  ls_field_val-type      = co_fvtype_single.
* Michael Manoch, 11.02.2010, MED-38637   END
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_bekat.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_bktxt.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_pvpat.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_bewar_txt.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_box_txt.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
* ----------
* set values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
* ---------- ---------- ----------
ENDMETHOD.


METHOD initialize_internal.

* Michael Manoch, 11.02.2010, MED-38637
* No more use of listbox screens.

*  DATA: lt_field_val          TYPE ish_t_field_value,
*        ls_field_val          TYPE rnfield_value,
*        lr_scr_lb_falar       TYPE REF TO cl_ish_scr_listbox,
*        lr_scr_lb_fatyp       TYPE REF TO cl_ish_scr_listbox,
*        lr_scr_lb_bewar       TYPE REF TO cl_ish_scr_listbox.
*
** Initialize all subscreens
*
** SC_LB_FALAR
*  CALL METHOD get_scr_lb_falar
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_falar = lr_scr_lb_falar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*
*  CHECK e_rc = 0.
*  CLEAR ls_field_val.
*  ls_field_val-fieldname = g_fieldname_sc_lb_falar.
*  ls_field_val-type      = co_fvtype_screen.
*  ls_field_val-object    = lr_scr_lb_falar.
*  APPEND ls_field_val TO lt_field_val.
*
** SC_LB_FATYP
*  CALL METHOD get_scr_lb_fatyp
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_fatyp = lr_scr_lb_fatyp
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*
*  CHECK e_rc = 0.
*  CLEAR ls_field_val.
*  ls_field_val-fieldname = g_fieldname_sc_lb_fatyp.
*  ls_field_val-type      = co_fvtype_screen.
*  ls_field_val-object    = lr_scr_lb_fatyp.
*  APPEND ls_field_val TO lt_field_val.
*
** SC_LB_BEWAR
*  CALL METHOD me->get_scr_lb_bewar
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb_bewar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*
*  CHECK e_rc = 0.
*  CLEAR ls_field_val.
*  ls_field_val-fieldname = g_fieldname_sc_lb_bewar.
*  ls_field_val-type      = co_fvtype_screen.
*  ls_field_val-object    = lr_scr_lb_bewar.
*  APPEND ls_field_val TO lt_field_val.
*
*
** Set field values
*  CALL METHOD set_fields
*    EXPORTING
*      it_field_values  = lt_field_val
*      i_field_values_x = on.
*
** Register for F1 events of listbox screens.
*  SET HANDLER handle_ev_user_command FOR all instances.

ENDMETHOD.


METHOD initialize_listbox_fieldnames.

  DATA: l_part1  TYPE string.

*-- Falar
  CONCATENATE co_fieldname_falar
              gs_parent-dynnr
         INTO g_fieldname_falar
    SEPARATED BY '_'.
  SPLIT g_fieldname_falar
    AT '-'
    INTO l_part1
         g_fieldname2_falar.

*-- fatyp
  CONCATENATE co_fieldname_fatyp
              gs_parent-dynnr
          INTO g_fieldname_fatyp
     SEPARATED BY '_'.
  SPLIT g_fieldname_fatyp
    AT '-'
    INTO l_part1
         g_fieldname2_fatyp.

*-- bewar
  CONCATENATE co_fieldname_bewar
              gs_parent-dynnr
          INTO g_fieldname_bewar
     SEPARATED BY '_'.
  SPLIT g_fieldname_bewar
    AT '-'
    INTO l_part1
         g_fieldname2_bewar.

ENDMETHOD.


METHOD initialize_parent .

* Michael Manoch, 11.02.2010, MED-38637
* Use dynpro connector to connect to the next free dynpro.

  CALL METHOD cl_ish_dynpconn_mgr=>connect_screen_free
    EXPORTING
      ir_screen       = me
      i_repid         = co_repid
      i_dynnr_from    = co_dynnr_from
      i_dynnr_to      = co_dynnr_to
    IMPORTING
      es_parent       = gs_parent
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

*  CLEAR: gs_parent.
*
*  gs_parent-repid = 'SAPLN1_SDY_ADMISSION'.
*  gs_parent-dynnr = '0100'.
*  gs_parent-type = co_scr_parent_type_dynpro.

* Set listbox fieldnames.               "MED-45019
  initialize_listbox_fieldnames( ).     "MED-45019

ENDMETHOD.


METHOD modify_screen_att .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

** definition
*  DATA: l_rc                TYPE ish_method_rc,
*        l_einri             TYPE tn01-einri,
*        l_flag              TYPE ish_on_off,
*        l_repid             TYPE tndym-pname,
*        l_dynnr             TYPE tndym-dynnr,
*        lt_field_values TYPE ish_t_field_value,
*        l_wa_field_value_falar TYPE rnfield_value,
*        l_wa_field_value_bekat TYPE rnfield_value,
*        l_wa_field_value_pvpat TYPE rnfield_value,
*        l_bekat TYPE bekat,
*        l_pvpat TYPE n1pvpat,
*        l_falar TYPE fallart,
*        l_screen TYPE rn1screen,
*        lt_screen TYPE ishmed_t_screen,
*        ls_parent TYPE rnscr_parent.
** object references
*  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.
*
*  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
*  IF l_einri IS INITIAL.
*    EXIT.
*  ENDIF.
*
** TNDYN-Modifikationen einlesen
*  CALL METHOD me->get_parent
*    IMPORTING
*      es_parent = ls_parent.
*  l_repid = ls_parent-repid.
*  l_dynnr = ls_parent-dynnr.
*
*  IF NOT l_dynnr IS INITIAL  AND  NOT l_repid IS INITIAL.
*    CALL FUNCTION 'ISH_MODIFY_SCREEN'
*      EXPORTING
*        dynnr = l_dynnr
*        einri = l_einri
*        fcode = 'AS '
*        pname = l_repid
*        vcode = g_vcode.
*  ENDIF.
*
*  CALL METHOD me->get_fields
**  EXPORTING
**    I_CONV_TO_EXTERN = SPACE
*    IMPORTING
*      et_field_values  = lt_field_values
*      e_rc             = e_rc
*    CHANGING
*      c_errorhandler   = cr_errorhandler.
*  CHECK l_rc = 0.
*  READ TABLE lt_field_values INTO l_wa_field_value_falar
*     WITH KEY fieldname = g_fieldname_sc_lb_falar.
*  READ TABLE lt_field_values INTO l_wa_field_value_bekat
*     WITH KEY fieldname = g_fieldname_bekat.
*  READ TABLE lt_field_values INTO l_wa_field_value_pvpat
*       WITH KEY fieldname = g_fieldname_pvpat.
*  l_pvpat = l_wa_field_value_pvpat-value.
*  l_falar = l_wa_field_value_falar-value.
*  l_bekat = l_wa_field_value_bekat-value.
*
*  LOOP AT SCREEN.
*    MOVE-CORRESPONDING screen TO l_screen.
*    APPEND l_screen TO lt_screen.
*  ENDLOOP.
*
** Screenmodifikationen
*  LOOP AT lt_screen INTO l_screen.
*
*    IF g_vcode = co_vcode_display.
*      l_screen-input = 0.
*    ENDIF.
*
**   Behandlungskategorie ist nur sichtbar, wenn:
**   -) Fallart ist nicht leer
*    IF l_screen-name = g_fieldname_bekat.
*      IF NOT l_falar IS INITIAL.
*        CALL METHOD me->adjust_field_with_screentab
*          EXPORTING
*            i_name       = l_screen-name
*            it_screentab = lt_screen
*          CHANGING
*            c_screen     = l_screen.
*      ELSE.
*        l_screen-active = false.
*      ENDIF.
*    ENDIF.
*
**   Besuchsart ist nur sichtbar wenn die Fallart nicht leer ist
*    IF l_screen-name = g_fieldname_sc_lb_bewar.
*      IF l_falar IS INITIAL.
*        l_screen-active = false.
*      ELSE.
*        CALL METHOD me->adjust_field_with_screentab
*          EXPORTING
*            i_name       = l_screen-name
*            it_screentab = lt_screen
*          CHANGING
*            c_screen     = l_screen.
*      ENDIF.
*    ENDIF.
*
**   Privatpatient
**   Inaktivieren wenn Fallbezug schon vorhanden
**   Inaktivieren, wenn es nicht angekreuzt ist, und wenn
**   die Behandlungskat. befüllt
*    IF l_screen-name = g_fieldname_pvpat.
*      IF l_falar IS INITIAL  AND
*         l_pvpat = off.
**       Feld ausblenden, wenn Fallart leer und wenn das Feld nicht
**       angekreuzt ist (das ist wegen den mit der "alten" Vkg
**       angelegten Daten...)
*        l_screen-active = false.
*      ELSE.
*        CALL METHOD me->adjust_field_with_screentab
*          EXPORTING
*            i_name       = l_screen-name
*            it_screentab = lt_screen
*          CHANGING
*            c_screen     = l_screen.
** HABE DERWEIL NOCH KEINE FALNR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
**        IF l_pvpat = off           OR
**           NOT l_falnr IS INITIAL  OR
**           NOT l_bekat IS INITIAL.
**          screen-input = false.
**        ELSE.
**CALL METHOD me->adjust_field_with_screentab
**  EXPORTING
**    i_name       = l_screen-name
**    it_screentab = ct_screen
**  changing
**    c_screen     = l_screen.
**        ENDIF.
*      ENDIF.
*    ENDIF.
*  ENDLOOP.
*
** Feldattribute nun übernehmen
*  LOOP AT SCREEN.
*    READ TABLE lt_screen INTO l_screen
*               WITH KEY name = screen-name.
*    CHECK sy-subrc = 0.
*    screen-active = l_screen-active.
*    screen-input  = l_screen-input.
*    screen-required = l_screen-required.
*    MODIFY SCREEN.
*  ENDLOOP.

ENDMETHOD.


METHOD modify_screen_internal .

* Michael Manoch, 11.02.2010, MED-38637
* Whole method redesigned.

  DATA lr_cordpos           TYPE REF TO cl_ishmed_prereg.
  DATA ls_n1vkg             TYPE n1vkg.
  DATA l_bekat_active       TYPE c.
  DATA l_bewar_active       TYPE c.
  DATA l_falart             TYPE falar_all.                 "MED-47523

* Get the cordpos.
  lr_cordpos = get_cordpos( ).
  CHECK lr_cordpos IS BOUND.

* Get cordpos data (n1vkg).
  CALL METHOD lr_cordpos->get_data
    IMPORTING
      e_rc           = e_rc
      e_n1vkg        = ls_n1vkg
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Handle active properties for main fields.
  LOOP AT SCREEN.
    CASE screen-name.
*     bekat: Inactive if no falar.
      WHEN g_fieldname_bekat.
        l_bekat_active = screen-active.
        CHECK l_bekat_active = true.
        CHECK ls_n1vkg-falar IS INITIAL.
        screen-active = false.
        l_bekat_active = screen-active.
*     Remember the bewar active property.
      WHEN g_fieldname_bewar.
        l_bewar_active = screen-active.
        CONTINUE.
      WHEN g_fieldname_falar. " MED-47523,AM,if falart select is disabled then select falart from patient if existent, else leave default
        CHECK screen-active = false.
        l_falart = get_falart_by_falnr_from_db( i_falnr = lr_cordpos->get_falnr( ) ).
        IF l_falart IS NOT INITIAL.
          set_fieldval_single( i_fieldname = co_fieldname_falar i_value = l_falart ).
        ENDIF.
*END MED-47523
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.

* Handle active properties for text fields and pvpat.
  LOOP AT SCREEN.
    CASE screen-name.
*     bktxt: Inactive if bekat is inactive.
      WHEN g_fieldname_bktxt.
        CHECK screen-active = true.
        CHECK l_bekat_active = false.
        screen-active = false.
*     pvpat: Inactive if no falar and no pvpat or bekat is inactive.
      WHEN g_fieldname_pvpat.
        CHECK screen-active = true.
        CHECK ( ls_n1vkg-falar IS INITIAL AND
                ls_n1vkg-pvpat = off ) OR
              l_bekat_active = false.
        screen-active = false.
*     bewar_txt: Inactive if bewar is inactive.
      WHEN g_fieldname_bewar_txt.
        CHECK screen-active = true.
        CHECK l_bewar_active = false.
        screen-active = false.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.


**  CALL METHOD me->modify_screen_att
**    IMPORTING
**      e_rc            = e_rc
**    CHANGING
**      cr_errorhandler = cr_errorhandler.
**
**  e_rc = 0.
*
*  DATA: lr_cordpos            TYPE REF TO cl_ishmed_prereg,
*        ls_n1vkg              TYPE n1vkg,
*        l_active              TYPE ish_on_off,
*        l_input               TYPE ish_on_off,
*        lr_scr_lb_falar       TYPE REF TO cl_ish_scr_listbox,
*        lr_scr_lb_fatyp       TYPE REF TO cl_ish_scr_listbox,
*        lr_scr_lb_bewar       TYPE REF TO cl_ish_scr_listbox.
*  DATA: ls_modified           TYPE rn1screen.
** RW ID 16977 - BEGIN
*  DATA: l_active_falar        TYPE ish_on_off,
*        l_active_fatyp        TYPE ish_on_off,
*        l_active_bewar        TYPE ish_on_off,
*        l_active_bekat        TYPE ish_on_off.
** RW ID 16977 - END
*
** Get the corresponding cordpos object.
*  lr_cordpos = get_cordpos( ).
*  CHECK NOT lr_cordpos IS INITIAL.
*
** Get falar, bekat, pvpat from cordpos.
*  CALL METHOD lr_cordpos->get_data
*    IMPORTING
*      e_rc           = e_rc
*      e_n1vkg        = ls_n1vkg
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
*  LOOP AT SCREEN.
*
**   Handle display mode.
*    IF g_vcode = co_vcode_display.
*      screen-input = 0.
*    ENDIF.
*
**   Handle active properties.
*    CASE screen-name.
*      WHEN g_fieldname_bekat.
**       bekat is only visible if falar is specified.
*        IF ls_n1vkg-falar IS INITIAL.
*          screen-active = false.
*        ENDIF.
**       RW ID 16977 - BEGIN
*        IF screen-active = false.
*          l_active_bekat = off.
*        ELSE.
*          l_active_bekat = on.
*        ENDIF.
**       RW ID 16977 - END
*      WHEN g_fieldname_pvpat.
**       pvpat is not visible if falar is not specified and
**       it is not a pvpat.
*        IF ls_n1vkg-falar IS INITIAL AND
*           ls_n1vkg-pvpat = off.
*          screen-active = false.
*        ENDIF.
*    ENDCASE.
*
*    MODIFY SCREEN.
*
*  ENDLOOP.
*
** Handle embedded listbox screens.
*
** sc_lb_falar.
*  CALL METHOD get_scr_lb_falar
*    IMPORTING
*      er_scr_lb_falar = lr_scr_lb_falar.
*  IF NOT lr_scr_lb_falar IS INITIAL.
**   Set default properties.
*    l_input  = on.
*    l_active = on.
**   Field already modified (scrm in config)?
*    READ TABLE it_modified INTO ls_modified WITH KEY
*        name = g_fieldname_sc_lb_falar.
*    IF sy-subrc EQ 0.
**     Protect field?
*      IF ls_modified-input = '0'.
*        l_input = off.
*      ENDIF.
**     Hide field?
*      IF ls_modified-active = '0'.
*        l_active = off.
*      ENDIF.
*    ENDIF.
**   Check vcode (if display mode => protect field).
*    IF g_vcode = co_vcode_display.
*      l_input = off.
*    ENDIF.
**   Set input property.
*    CALL METHOD lr_scr_lb_falar->set_input
*      EXPORTING
*        i_input = l_input.
**   Set active property.
**   RW ID 16977 - BEGIN
*    l_active_falar = l_active.
**   RW ID 16977 - END
*    CALL METHOD lr_scr_lb_falar->set_active
*      EXPORTING
*        i_active = l_active.
*  ENDIF.
*
** sc_lb_fatyp.
*  CALL METHOD get_scr_lb_fatyp
*    IMPORTING
*      er_scr_lb_fatyp = lr_scr_lb_fatyp.
*  IF NOT lr_scr_lb_fatyp IS INITIAL.
**   Set default properties.
*    l_input  = on.
*    l_active = on.
**   Check falar (if no falar => hide field).
*    IF ls_n1vkg-falar IS INITIAL.
*      l_active = off.
*    ENDIF.
**   Field already modified (scrm in config)?
*    READ TABLE it_modified INTO ls_modified WITH KEY
*        name = g_fieldname_sc_lb_fatyp.
*    IF sy-subrc EQ 0.
**     Protect field?
*      IF ls_modified-input = '0'.
*        l_input = off.
*      ENDIF.
**     Hide field?
*      IF ls_modified-active = '0'.
*        l_active = off.
*      ENDIF.
*    ENDIF.
**   Check vcode (if display mode => protect field).
*    IF g_vcode = co_vcode_display.
*      l_input = off.
*    ENDIF.
**   Set input property.
*    CALL METHOD lr_scr_lb_fatyp->set_input
*      EXPORTING
*        i_input = l_input.
**   Set active property.
**   RW ID 16977 - BEGIN
*    l_active_fatyp = l_active.
**   RW ID 16977 - END
*    CALL METHOD lr_scr_lb_fatyp->set_active
*      EXPORTING
*        i_active = l_active.
*  ENDIF.
*
** sc_lb_bewar.
*  CALL METHOD get_scr_lb_bewar
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb_bewar.
*  IF NOT lr_scr_lb_bewar IS INITIAL.
**   Set default properties.
*    l_input  = on.
*    l_active = on.
**   Check falar (if no falar => hide field).
*    IF ls_n1vkg-falar IS INITIAL.
*      l_active = off.
*    ENDIF.
**   Field already modified (scrm in config)?
*    READ TABLE it_modified INTO ls_modified WITH KEY
*        name = g_fieldname_sc_lb_bewar.
*    IF sy-subrc EQ 0.
**     Protect field?
*      IF ls_modified-input = '0'.
*        l_input = off.
*      ENDIF.
**     Hide field?
*      IF ls_modified-active = '0'.
*        l_active = off.
*      ENDIF.
*    ENDIF.
**   Check vcode (if display mode => protect field).
*    IF g_vcode = co_vcode_display.
*      l_input = off.
*    ENDIF.
**   Set input property.
*    CALL METHOD lr_scr_lb_bewar->set_input
*      EXPORTING
*        i_input = l_input.
**   Set active property.
**   RW ID 16977 - BEGIN
*    l_active_bewar = l_active.
**   RW ID 16977 - END
*    CALL METHOD lr_scr_lb_bewar->set_active
*      EXPORTING
*        i_active = l_active.
*  ENDIF.
*
** RW ID 16977 - BEGIN
*  LOOP AT SCREEN.
*    CASE screen-name.
*      WHEN 'RN1_DYNP_ADMISSION-FALAR'.
*        IF screen-active = true AND l_active_falar = off.
*          screen-active = false.
*        ENDIF.
*      WHEN 'RN1_DYNP_ADMISSION-FATYP'.
*        IF screen-active = true AND l_active_fatyp = off.
*          screen-active = false.
*        ENDIF.
*      WHEN 'RN1_DYNP_ADMISSION-BEWAR_TXT'.
*        IF screen-active = true AND l_active_bewar = off.
*          screen-active = false.
*        ENDIF.
*      WHEN 'RN1_DYNP_ADMISSION-BKTXT'.
*        IF screen-active = true AND l_active_bekat = off.
*          screen-active = false.
*        ENDIF.
*      WHEN 'RN1_DYNP_ADMISSION-PVPAT'.
*        IF screen-active = true AND l_active_bekat = off.
*          screen-active = false.
*        ENDIF.
*      WHEN OTHERS.
*    ENDCASE.
*    MODIFY SCREEN.
*  ENDLOOP.
** RW ID 16977 - END
ENDMETHOD.


METHOD modify_screen_std.

* Michael Manoch, 11.02.2010, MED-38637
* Method redefined.

* For is-h screenmodifications we always use dynpro 0100.

  DATA l_tmp_dynnr            TYPE sydynnr.

  l_tmp_dynnr = gs_parent-dynnr.
  gs_parent-dynnr = co_dynnr_from.

  CALL METHOD super->modify_screen_std
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  gs_parent-dynnr = l_tmp_dynnr.

ENDMETHOD.


METHOD pai_lb_bewar.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_bewar     TYPE REF TO cl_ish_scr_listbox.
*
** Initializations.
*  e_rc = 0.
*
** Get the screen object.
*  CALL METHOD get_scr_lb_bewar
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb_bewar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_bewar IS INITIAL.
*
** Before Call Subscreen.
*  CALL METHOD lr_scr_lb_bewar->before_call_subscreen
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.

ENDMETHOD.


METHOD pai_lb_falar.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_falar     TYPE REF TO cl_ish_scr_listbox.
*
** Initializations.
*  e_rc = 0.
*
** Get the screen object.
*  CALL METHOD get_scr_lb_falar
*    IMPORTING
*      er_scr_lb_falar = lr_scr_lb_falar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_falar IS INITIAL.
*
** Before Call Subscreen.
*  CALL METHOD lr_scr_lb_falar->before_call_subscreen
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.

ENDMETHOD.


METHOD pai_lb_fatyp .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_fatyp     TYPE REF TO cl_ish_scr_listbox.
*
** Initializations.
*  e_rc = 0.
*
** Get the screen object.
*  CALL METHOD get_scr_lb_fatyp
*    IMPORTING
*      er_scr_lb_fatyp = lr_scr_lb_fatyp
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_fatyp IS INITIAL.
*
** Before Call Subscreen.
*  CALL METHOD lr_scr_lb_fatyp->before_call_subscreen
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.

ENDMETHOD.


METHOD pbo_lb_bewar.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_bewar  TYPE REF TO cl_ish_scr_listbox,
*        ls_parent        TYPE rnscr_parent.
*
*  FIELD-SYMBOLS: <l_repid>  TYPE sy-repid,
*                 <l_dynnr>  TYPE sy-dynnr.
*
** Initializations.
*  e_rc = 0.
*  IF gr_dynpg_lb_bewar IS BOUND AND
*     gr_dynnr_lb_bewar IS BOUND.
*    ASSIGN gr_dynpg_lb_bewar->* TO <l_repid>.
*    ASSIGN gr_dynnr_lb_bewar->* TO <l_dynnr>.
*    <l_repid> = 'SAPLN1SC'.
*    <l_dynnr> = '0001'.
*  ENDIF.
*
** Get the screen object.
*  CALL METHOD get_scr_lb_bewar
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb_bewar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_bewar IS INITIAL.
*
** Before Call Subscreen.
*  CALL METHOD lr_scr_lb_bewar->before_call_subscreen
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Set dynpg + dynnr.
*  IF gr_dynpg_lb_bewar IS BOUND AND
*     gr_dynnr_lb_bewar IS BOUND.
*    ASSIGN gr_dynpg_lb_bewar->* TO <l_repid>.
*    ASSIGN gr_dynnr_lb_bewar->* TO <l_dynnr>.
*    CALL METHOD lr_scr_lb_bewar->get_parent
*      IMPORTING
*        es_parent = ls_parent.
*    <l_repid> = ls_parent-repid.
*    <l_dynnr> = ls_parent-dynnr.
*  ENDIF.

ENDMETHOD.


METHOD pbo_lb_falar.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_falar  TYPE REF TO cl_ish_scr_listbox,
*        ls_parent        TYPE rnscr_parent.
*
*  FIELD-SYMBOLS: <l_repid>  TYPE sy-repid,
*                 <l_dynnr>  TYPE sy-dynnr.
*
** Initializations.
*  e_rc = 0.
*  IF gr_dynpg_lb_falar IS BOUND AND
*     gr_dynnr_lb_falar IS BOUND.
*    ASSIGN gr_dynpg_lb_falar->* TO <l_repid>.
*    ASSIGN gr_dynnr_lb_falar->* TO <l_dynnr>.
*    <l_repid> = 'SAPLN1SC'.
*    <l_dynnr> = '0001'.
*  ENDIF.
*
** Get the screen object.
*  CALL METHOD get_scr_lb_falar
*    IMPORTING
*      er_scr_lb_falar   = lr_scr_lb_falar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_falar IS INITIAL.
*
** Before Call Subscreen.
*  CALL METHOD lr_scr_lb_falar->before_call_subscreen
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Set dynpg + dynnr.
*  IF gr_dynpg_lb_falar IS BOUND AND
*     gr_dynnr_lb_falar IS BOUND.
*    ASSIGN gr_dynpg_lb_falar->* TO <l_repid>.
*    ASSIGN gr_dynnr_lb_falar->* TO <l_dynnr>.
*    CALL METHOD lr_scr_lb_falar->get_parent
*      IMPORTING
*        es_parent = ls_parent.
*    <l_repid> = ls_parent-repid.
*    <l_dynnr> = ls_parent-dynnr.
*  ENDIF.

ENDMETHOD.


METHOD pbo_lb_fatyp .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_fatyp     TYPE REF TO cl_ish_scr_listbox,
*        ls_parent           TYPE rnscr_parent.
*
*  FIELD-SYMBOLS: <l_repid>  TYPE sy-repid,
*                 <l_dynnr>  TYPE sy-dynnr.
*
** Initializations.
*  e_rc = 0.
*  IF gr_dynpg_lb_fatyp IS BOUND AND
*     gr_dynnr_lb_fatyp IS BOUND.
*    ASSIGN gr_dynpg_lb_fatyp->* TO <l_repid>.
*    ASSIGN gr_dynnr_lb_fatyp->* TO <l_dynnr>.
*    <l_repid> = 'SAPLN1SC'.
*    <l_dynnr> = '0001'.
*  ENDIF.
*
** Get the screen object.
*  CALL METHOD get_scr_lb_fatyp
*    IMPORTING
*      er_scr_lb_fatyp = lr_scr_lb_fatyp
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_fatyp IS INITIAL.
*
** Before Call Subscreen.
*  CALL METHOD lr_scr_lb_fatyp->before_call_subscreen
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Set dynpg + dynnr.
*  IF gr_dynpg_lb_fatyp IS BOUND AND
*     gr_dynnr_lb_fatyp IS BOUND.
*    ASSIGN gr_dynpg_lb_fatyp->* TO <l_repid>.
*    ASSIGN gr_dynnr_lb_fatyp->* TO <l_dynnr>.
*    CALL METHOD lr_scr_lb_fatyp->get_parent
*      IMPORTING
*        es_parent = ls_parent.
*    <l_repid> = ls_parent-repid.
*    <l_dynnr> = ls_parent-dynnr.
*  ENDIF.

ENDMETHOD.


METHOD set_cursor_internal.

  DATA: l_cursorfield  TYPE ish_fieldname.

* Determine cursorfield.
  IF is_message_handled( gs_message ) = on.
    IF gs_message-parameter IS INITIAL.
      l_cursorfield = gs_message-field.
    ELSEIF gs_message-field IS INITIAL.
      l_cursorfield = gs_message-parameter.
    ELSE.
      CONCATENATE gs_message-parameter
                  gs_message-field
             INTO l_cursorfield
        SEPARATED BY '-'.
    ENDIF.
  ELSE.
    l_cursorfield = g_scr_cursorfield.
  ENDIF.
  CHECK NOT l_cursorfield IS INITIAL.

* special coding for listbox falar, fatyp and bewar
  CASE l_cursorfield.
    WHEN co_fieldname_falar.
      l_cursorfield = g_fieldname_falar.
    WHEN co_fieldname_fatyp.
      l_cursorfield = g_fieldname_fatyp.
    WHEN co_fieldname_bewar.
      l_cursorfield = g_fieldname_bewar.
  ENDCASE.

  SET CURSOR FIELD l_cursorfield.

ENDMETHOD.


METHOD set_cursor_lb_bewar.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_bewar   TYPE REF TO cl_ish_scr_listbox,
*        l_belongs         TYPE ish_on_off,
*        l_lbname          TYPE ish_fieldname,
*        ls_message        TYPE rn1message,
*        l_cursorfield     TYPE ish_fieldname,
*        l_rc              TYPE ish_method_rc.
*
** Initializations.
*  e_cursor_set = off.
*  e_rc         = 0.
*
** Process only to remind cursor position.
*  CHECK i_set_cursor = off.
*
** Get the cot listbox screen.
*  CALL METHOD get_scr_lb_bewar
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_bewar = lr_scr_lb_bewar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_bewar IS INITIAL.
*
** Get the listbox fieldname.
*  l_lbname = lr_scr_lb_bewar->get_lbname( ).
*
** Does the message/cursorfield belong to cot?
*  l_belongs = off.
*  IF is_message IS INITIAL.
*    IF i_cursorfield = l_lbname.
*      l_belongs = on.
*    ENDIF.
*  ELSE.
*    IF is_message-object = gr_main_object.
*      CASE is_message-parameter.
*        WHEN 'N1VKG'.
*          IF is_message-field = 'BEWAR'.
*            l_belongs = on.
*          ENDIF.
**-- begin Grill, med-34086
*        WHEN g_fieldname_sc_lb_bewar.
*            l_belongs = on.
**-- end Grill, med-34086
*      ENDCASE.
*    ENDIF.
*  ENDIF.
*
** If no -> no further processing.
*  CHECK l_belongs = on.
*
** Build message/cursorfield for lb_cot screen.
*  ls_message    = is_message.
*  l_cursorfield = i_cursorfield.
*  IF ls_message IS INITIAL.
*    l_cursorfield = l_lbname.
*  ELSE.
*    SPLIT l_lbname
*      AT '-'
*      INTO ls_message-parameter
*           ls_message-field.
*  ENDIF.
*
** Set cursor in lb_cot screen.
*  CALL METHOD lr_scr_lb_bewar->set_cursor
*    EXPORTING
*      i_rn1message   = ls_message
*      i_cursorfield  = l_cursorfield
*      i_set_cursor   = space
*    IMPORTING
*      e_cursor_set   = e_cursor_set
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  IF e_rc <> 0.
*    e_cursor_set = off.
*  ENDIF.

ENDMETHOD.


METHOD set_cursor_lb_falar.

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_falar   TYPE REF TO cl_ish_scr_listbox,
*        l_belongs         TYPE ish_on_off,
*        l_lbname          TYPE ish_fieldname,
*        ls_message        TYPE rn1message,
*        l_cursorfield     TYPE ish_fieldname,
*        l_rc              TYPE ish_method_rc.
*
** Initializations.
*  e_cursor_set = off.
*  e_rc         = 0.
*
** Process only to remind cursor position.
*  CHECK i_set_cursor = off.
*
** Get the cot listbox screen.
*  CALL METHOD get_scr_lb_falar
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_falar   = lr_scr_lb_falar
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_falar IS INITIAL.
*
** Get the listbox fieldname.
*  l_lbname = lr_scr_lb_falar->get_lbname( ).
*
** Does the message/cursorfield belong to cot?
*  l_belongs = off.
*  IF is_message IS INITIAL.
*    IF i_cursorfield = l_lbname.
*      l_belongs = on.
*    ENDIF.
*  ELSE.
*    IF is_message-object = gr_main_object.
*      CASE is_message-parameter.
*        WHEN 'N1VKG'.
*          IF is_message-field = 'FALAR'.
*            l_belongs = on.
*          ENDIF.
**-- begin Grill, med-34086
*        WHEN g_fieldname_sc_lb_falar.
*            l_belongs = on.
**-- end Grill, med-34086
*      ENDCASE.
*    ENDIF.
*  ENDIF.
*
** If no -> no further processing.
*  CHECK l_belongs = on.
*
** Build message/cursorfield for lb_cot screen.
*  ls_message    = is_message.
*  l_cursorfield = i_cursorfield.
*  IF ls_message IS INITIAL.
*    l_cursorfield = l_lbname.
*  ELSE.
*    SPLIT l_lbname
*      AT '-'
*      INTO ls_message-parameter
*           ls_message-field.
*  ENDIF.
*
** Set cursor in lb_cot screen.
*  CALL METHOD lr_scr_lb_falar->set_cursor
*    EXPORTING
*      i_rn1message   = ls_message
*      i_cursorfield  = l_cursorfield
*      i_set_cursor   = space
*    IMPORTING
*      e_cursor_set   = e_cursor_set
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  IF e_rc <> 0.
*    e_cursor_set = off.
*  ENDIF.

ENDMETHOD.


METHOD set_cursor_lb_fatyp .

* Michael Manoch, 11.02.2010, MED-38637
* Obsolet.

*  DATA: lr_scr_lb_fatyp   TYPE REF TO cl_ish_scr_listbox,
*        l_belongs         TYPE ish_on_off,
*        l_lbname          TYPE ish_fieldname,
*        ls_message        TYPE rn1message,
*        l_cursorfield     TYPE ish_fieldname,
*        l_rc              TYPE ish_method_rc.
*
** Initializations.
*  e_cursor_set = off.
*  e_rc         = 0.
*
** Process only to remind cursor position.
*  CHECK i_set_cursor = off.
*
** Get the cot listbox screen.
*  CALL METHOD get_scr_lb_fatyp
*    EXPORTING
*      i_create        = on
*    IMPORTING
*      er_scr_lb_fatyp = lr_scr_lb_fatyp
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK NOT lr_scr_lb_fatyp IS INITIAL.
*
** Get the listbox fieldname.
*  l_lbname = lr_scr_lb_fatyp->get_lbname( ).
*
** Does the message/cursorfield belong to cot?
*  l_belongs = off.
*  IF is_message IS INITIAL.
*    IF i_cursorfield = l_lbname.
*      l_belongs = on.
*    ENDIF.
*  ELSE.
*    IF is_message-object = gr_main_object.
*      CASE is_message-parameter.
*        WHEN 'N1VKG'.
*          IF is_message-field = 'FATYP'.
*            l_belongs = on.
*          ENDIF.
**-- begin Grill, med-34086
*        WHEN g_fieldname_sc_lb_fatyp.
*            l_belongs = on.
**-- end Grill, med-34086
*      ENDCASE.
*    ENDIF.
*  ENDIF.
*
** If no -> no further processing.
*  CHECK l_belongs = on.
*
** Build message/cursorfield for lb_cot screen.
*  ls_message    = is_message.
*  l_cursorfield = i_cursorfield.
*  IF ls_message IS INITIAL.
*    l_cursorfield = l_lbname.
*  ELSE.
*    SPLIT l_lbname
*      AT '-'
*      INTO ls_message-parameter
*           ls_message-field.
*  ENDIF.
*
** Set cursor in lb_cot screen.
*  CALL METHOD lr_scr_lb_fatyp->set_cursor
*    EXPORTING
*      i_rn1message   = ls_message
*      i_cursorfield  = l_cursorfield
*      i_set_cursor   = space
*    IMPORTING
*      e_cursor_set   = e_cursor_set
*      e_rc           = e_rc
*    CHANGING
*      c_errorhandler = cr_errorhandler.
*  IF e_rc <> 0.
*    e_cursor_set = off.
*  ENDIF.

ENDMETHOD.


METHOD value_request_bekat .

* Michael Manoch, 11.02.2010, MED-38637   START

  DATA l_einri            TYPE einri.
  DATA l_select(60)       TYPE c.
  DATA l_falar            TYPE fallart.
  DATA l_value(60)        TYPE c.
  DATA l_selected         TYPE ish_on_off.

*  DATA: lt_field_values TYPE ish_t_field_value,
*        l_wa_field_value_falar TYPE rnfield_value,
*        l_wa_field_value_bekat TYPE rnfield_value,
*        l_wa_field_value_pvpat TYPE rnfield_value,
*        l_rc TYPE ish_method_rc,
*        l_einri TYPE einri,
*        l_select(60)   TYPE c,
*        l_value(60)    TYPE c,
*        l_bekat TYPE bekat,
*        l_pvpat TYPE n1pvpat,
*        l_falar TYPE fallart,
*        l_bktxt TYPE bk_bktxt,
*        l_selected TYPE ish_on_off.
** RW ID 14866 - BEGIN
*  DATA:          lr_scr_lb_falar TYPE REF TO cl_ish_scr_listbox.
*  FIELD-SYMBOLS: <ls_field_val>  TYPE rnfield_value.
** RW ID 14866 - END
*
** object references
*  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

* Michael Manoch, 11.02.2010, MED-38637   END

* Initializations
  e_rc      = 0.
  e_called  = off.
  e_selected = off.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

* Michael Manoch, 11.02.2010, MED-38637   START

* l_falar = get_fieldval_single( i_fieldname = g_fieldname_falar ).     "MED-45019
  l_falar = get_fieldval_single( i_fieldname = co_fieldname_falar ).     "MED-45019

*  CALL METHOD me->get_fields
*    IMPORTING
*      et_field_values = lt_field_values
*      e_rc            = e_rc
*    CHANGING
*      c_errorhandler  = cr_errorhandler.
*  CHECK e_rc = 0.
*
** RW ID 14866 - BEGIN
**  READ TABLE lt_field_values INTO l_wa_field_value_falar
**     WITH KEY fieldname = g_fieldname_sc_lb_falar.
**  READ TABLE lt_field_values INTO l_wa_field_value_bekat
**     WITH KEY fieldname = g_fieldname_bekat.
**  l_falar = l_wa_field_value_falar-value.
**  READ TABLE lt_field_values INTO l_wa_field_value_pvpat
**       WITH KEY fieldname = g_fieldname_pvpat.
**  l_pvpat = l_wa_field_value_pvpat-value.
**
**  CHECK sy-subrc EQ 0.
*  LOOP AT lt_field_values ASSIGNING <ls_field_val>.
*    CASE <ls_field_val>-fieldname.
*      WHEN g_fieldname_sc_lb_falar.
*        CHECK NOT <ls_field_val>-object IS INITIAL.
*        CHECK <ls_field_val>-object->is_inherited_from(
*                    cl_ish_scr_listbox=>co_otype_scr_listbox ) = on.
*        lr_scr_lb_falar ?= <ls_field_val>-object.
*        l_falar   = lr_scr_lb_falar->get_value( ).
*    ENDCASE.
*  ENDLOOP.
** RW ID 14866 - END

* Michael Manoch, 11.02.2010, MED-38637   END


  l_select    = l_einri.
  l_select+4  = sy-datum.
  l_select+12 = l_falar.
  CALL FUNCTION 'ISH_VALUE_REQUEST'
    EXPORTING
      ss_field  = 'RN1_DYNP_ADMISSION-BEKAT'
      ss_select = l_select
      ss_table  = 'TN24'
      ss_vcode  = g_vcode
    IMPORTING
      ss_value  = l_value
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  e_rc = sy-subrc.
* F4 has been called
  e_called   = on.

* Errorhandling
  IF e_rc <> 0.
*   there is no input possible
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ   = 'S'
        i_kla   = 'N1'
        i_num   = '503'
        i_last  = ' '
        i_einri = l_einri.
    EXIT.
  ENDIF.
  IF NOT l_value IS INITIAL.
    l_selected = on.
  ENDIF.

* Entry selected.
  e_selected = l_selected.

* Nothing selected?
  CHECK l_selected = on.

* Export selected value
  e_value = l_value.

ENDMETHOD.


METHOD value_request_internal .

* Initializations.
  CLEAR: e_rc.

  CASE i_fieldname.
    WHEN g_fieldname_bekat.
      CALL METHOD value_request_bekat
        IMPORTING
          e_called        = e_called
          e_selected      = e_selected
          e_value         = e_value
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
  ENDCASE.

ENDMETHOD.
ENDCLASS.
