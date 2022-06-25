class CL_ISH_SCR_MED_DATA definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

public section.

*"* public components of class CL_ISH_SCR_MED_DATA
*"* do not include other source files here!!!
  class-data G_PREFIX_FIELDNAME type ISH_FIELDNAME read-only value 'RN1_DYNP_MED_DATA' ##NO_TEXT.
  constants CO_DEFAULT_TABNAME type TABNAME value 'N1CORDER' ##NO_TEXT.
  class-data G_FIELDNAME_KANAM type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_SCHWKZ type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_SCHWO type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_IFG type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_DITXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_N1KALTXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_N1DILTXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_FRAGE type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_N1FRLTXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_MORE_DIA type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_RISK_FACTS type ISH_FIELDNAME read-only .
  constants CO_OTYPE_SCR_MED_DATA type ISH_OBJECT_TYPE value 7046 ##NO_TEXT.

  class-methods ICON_CREATE
    importing
      value(I_ICON) type CHAR100
      value(I_TEXT) type CHAR100 optional
      value(I_INFO) type CHAR100 optional
    exporting
      value(E_FIELD) type ISH_LGTX03
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_MED_DATA
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_RISC_FACTS_FOR_PATIENT
    exporting
      value(E_RISC_FACTS) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_A
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~CREATE_ALL_LISTBOXES
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS
    redefinition .
  methods IF_ISH_SCREEN~IS_FIELD_INITIAL
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.

*"* protected components of class CL_ISH_SCR_MED_DATA
*"* do not include other source files here!!!
  data G_ISHMED_AUTH type ISH_ON_OFF .
  data G_FRLTX_BUTTON type RN1_DYNP_MED_DATA-N1FRLTXT .
  data G_DILTX_BUTTON type RN1_DYNP_MED_DATA-N1DILTXT .
  data G_KALTX_BUTTON type RN1_DYNP_MED_DATA-N1KALTXT .
  data G_DILTX_MORE_BUTTON type CHAR40 .

  methods CREATE_LISTBOX_IFG
    exporting
      !ER_LB_OBJECT type ref to CL_ISH_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods VALUE_REQUEST_DITXT
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_N1KALTXT
    importing
      value(I_CONFIG_ACTIVE) type C default TRUE
      value(I_CONFIG_INPUT) type C default TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_N1FRLTXT
    importing
      value(I_CONFIG_ACTIVE) type C default TRUE
      value(I_CONFIG_INPUT) type C default TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_N1DILTXT
    importing
      value(I_CONFIG_ACTIVE) type C default TRUE
      value(I_CONFIG_INPUT) type C default TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_MORE_DIA
    importing
      value(I_CONFIG_ACTIVE) type C default TRUE
      value(I_CONFIG_INPUT) type C default TRUE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

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
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
  methods MODIFY_SCREEN_INTERNAL
    redefinition .
  methods VALUE_REQUEST_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_MED_DATA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_MED_DATA IMPLEMENTATION.


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
    WHEN 'N1CORDER'.
      es_message-parameter = g_prefix_fieldname.
*      CASE es_message-field.
*        WHEN 'SCHWKZ'.
*          l_fieldname = g_fieldname_schwkz.
*      ENDCASE.
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


METHOD check_risc_facts_for_patient .

  DATA: l_einri     TYPE tn01-einri,
        l_patnr     TYPE npat-patnr,
        lr_corder   TYPE REF TO cl_ish_corder,
        ls_n1corder TYPE n1corder,
        l_found     TYPE ish_true_false,
        l_stack     TYPE I. "Grill, ID-16118

  e_rc = 0.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.
  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  l_patnr = ls_n1corder-patnr.
  CHECK NOT l_patnr IS INITIAL.


*-- Begin Grill, ID-16118
CALL FUNCTION 'ISH_MESSAGES_BACKUP'
 IMPORTING
   E_STACK       = l_stack.
*-- End Grill, ID-16118

  CALL FUNCTION 'ISH_CHECK_STORNO_NPAT_RISK'
    EXPORTING
      ss_einri      = l_einri
      ss_patnr      = l_patnr
    IMPORTING
      ss_found_risk = l_found.
  IF l_found = true.
    e_risc_facts = on.
  ENDIF.

*-- Begin Grill, ID-16118
CALL FUNCTION 'ISH_MESSAGES_RESTORE'
 EXPORTING
   I_STACK       =  0.
*-- End Grill, ID-16118
ENDMETHOD.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_default_tabname.
  GET REFERENCE OF co_default_tabname INTO gr_default_tabname.

* Notice if IS-H*MED is active
  g_ishmed_auth = on.
  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXPORTING
      i_msg            = off
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
    g_ishmed_auth = off.
  ENDIF.

ENDMETHOD.


METHOD CREATE .

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
        i_mv1           = 'CL_ISH_SCR_MED_DATA'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD create_listbox_ifg .

* definition
  DATA: l_rc                TYPE ish_method_rc,
        l_einri             TYPE tn01-einri,
        l_flag              TYPE ish_on_off,
        l_fieldname_ifg     TYPE vrm_id,
        lt_fieldvalues      TYPE ish_t_field_value,
        l_wa_fieldvalue     TYPE rnfield_value,
        l_vrm_value         TYPE vrm_value-key,
        l_vrm_id            TYPE vrm_id,
        l_ifg               TYPE n1corder-ifg.

* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

* Get einri
  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

* Get current value
  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_fieldvalues
      e_rc            = l_rc.
  READ TABLE lt_fieldvalues INTO l_wa_fieldvalue
     WITH KEY fieldname = g_fieldname_ifg.
  l_vrm_value = l_wa_fieldvalue-value.
  l_ifg = l_vrm_value.
* ---------- ---------- ----------
  l_vrm_id = g_fieldname_ifg.
  CALL METHOD cl_ish_lb_ifg=>fill_listbox
    EXPORTING
      i_fieldname  = l_vrm_id
      i_einri      = l_einri
      i_ifg        = l_ifg
    IMPORTING
      e_rc         = l_rc
      er_lb_object = lr_lb_object.
* ---------- ---------- ----------
*  l_wa_fieldvalue-value = l_vrm_value.
*  MODIFY lt_fieldvalues FROM l_wa_fieldvalue
*      TRANSPORTING value WHERE fieldname = g_fieldname_wlsta.
*  CALL METHOD me->set_fields
*    EXPORTING
*      it_field_values  = lt_fieldvalues
*      i_field_values_x = 'X'
*    IMPORTING
*      e_rc             = l_rc.

* ---------- ---------- ----------
* Export listbox object
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD create_listbox_internal .

* Initializations
  CLEAR: e_rc.

  CASE i_fieldname.
    WHEN g_fieldname_ifg.
      CALL METHOD create_listbox_ifg
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

* N1KALTXT
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_n1kaltxt
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* N1FRLTXT
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_n1frltxt
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* N1DILTXT
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_n1diltxt
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* MORE DIA
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_more_dia
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD fill_label_internal .

* Initializations
  CLEAR: e_rc.

* ED, ID 14654: set labels in MODIFY_SCREEN_INTERNAL!!
*  CASE i_fieldname.
*    WHEN g_fieldname_n1kaltxt.
*      CALL METHOD fill_label_n1kaltxt
*        IMPORTING
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*    WHEN g_fieldname_n1frltxt.
*      CALL METHOD fill_label_n1frltxt
*        IMPORTING
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*    WHEN g_fieldname_n1diltxt.
*      CALL METHOD fill_label_n1diltxt
*        IMPORTING
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*    WHEN g_fieldname_more_dia.
*      CALL METHOD fill_label_more_dia
*        IMPORTING
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
*  ENDCASE.

ENDMETHOD.


METHOD fill_label_more_dia .

  DATA: lt_field_values         TYPE ish_t_field_value,
        l_wa_field_value_more   TYPE rnfield_value,
        l_rc                    TYPE ish_method_rc,
        ls_n1corder             TYPE n1corder,
        l_more_dia              TYPE rn1_dynp_med_data-more_dia,
        l_vcode                 TYPE vcode,
        l_einri                 TYPE tn01-einri,
        lr_prereg               TYPE REF TO cl_ishmed_prereg,
        l_not_found             TYPE ish_on_off,
        lt_cordpos              TYPE ish_t_cordpos.

  DATA: ls_npat        TYPE npat,
        lt_diagnosis   TYPE ish_objectlist,
        l_icon(35)     TYPE c,
        l_infotext     TYPE icont-quickinfo.

* object references
  DATA: lr_corder               TYPE REF TO cl_ish_corder.

* ED, ID 14654: if configs are space -> set true default -> BEGIN
  IF i_config_active = space.
    i_config_active = true.
  ENDIF.
  IF i_config_input = space.
    i_config_input = true.
  ENDIF.
* ED, ID 14654 -> END

* get the institution
  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

* get main object -> check if clinical order
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK l_rc = 0.

  READ TABLE lt_field_values INTO l_wa_field_value_more
     WITH KEY fieldname = g_fieldname_more_dia.
  CHECK sy-subrc EQ 0.

* get diagnosis for corder
  CLEAR: lt_diagnosis[].
  CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
    EXPORTING
      ir_corder       = lr_corder
      ir_environment  = gr_environment
    IMPORTING
      e_rc            = e_rc
      et_diagnosis    = lt_diagnosis
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK l_rc = 0.

  l_icon     = icon_enter_more.
  l_infotext = 'Weitere Diagnosen'(001).
  IF NOT lt_diagnosis[] IS INITIAL
  AND i_config_active = true. "ED, ID 14654
    l_icon     = icon_display_more.
  ENDIF.
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = l_icon
      info                  = l_infotext
    IMPORTING
      RESULT                = l_more_dia
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.
  e_rc = sy-subrc.
  CHECK e_rc = 0.

* ED, ID 14654: fill global attribut -> BEGIN
  CLEAR: g_diltx_more_button.
  IF i_config_active = true AND
     i_config_input = false.
    g_diltx_more_button = 'anzeigen'.
  ENDIF.
* ED, ID 14654 -> END
  l_wa_field_value_more-value = l_more_dia.
  MODIFY lt_field_values FROM l_wa_field_value_more
    TRANSPORTING value WHERE fieldname = g_fieldname_more_dia.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_n1diltxt .

  DATA: lt_field_values         TYPE ish_t_field_value,
        l_wa_field_value_diltxt TYPE rnfield_value,
        l_rc                    TYPE ish_method_rc,
        l_diltxt                TYPE rn1_dynp_med_data-n1diltxt,
        l_einri                 TYPE tn01-einri,
        lt_diag                 TYPE ish_objectlist,
        ls_object               TYPE ish_object,
        ls_diag                 TYPE rndip_attrib,
        lr_diag                 TYPE REF TO cl_ish_prereg_diagnosis,
        lr_corder               TYPE REF TO cl_ish_corder,
        l_icon                  TYPE char100.

* ED, ID 14654: if configs are space -> set true default -> BEGIN
  IF i_config_active = space.
    i_config_active = true.
  ENDIF.
  IF i_config_input = space.
    i_config_input = true.
  ENDIF.
* ED, ID 14654 -> END

* get the institution
  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

* get main object -> check if clinical order
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

  READ TABLE lt_field_values INTO l_wa_field_value_diltxt
     WITH KEY fieldname = g_fieldname_n1diltxt.
  CHECK sy-subrc EQ 0.

* Get corder's diagnosis objects.
  CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
    EXPORTING
*      I_CANCELLED_DATAS = OFF
      ir_corder         = lr_corder
      ir_environment    = gr_environment
    IMPORTING
      e_rc              = e_rc
      et_diagnosis      = lt_diag
    CHANGING
      cr_errorhandler   = cr_errorhandler.

* Displayed Diagnosis is the one with the order flag
  CLEAR ls_diag.
  LOOP AT lt_diag INTO ls_object.
    lr_diag ?= ls_object-object.
    CHECK NOT lr_diag IS INITIAL.
    CALL METHOD lr_diag->get_data
      IMPORTING
        es_data        = ls_diag
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF ls_diag-diklat = on.
      EXIT.
    ELSE.
      CLEAR ls_diag.
    ENDIF.
  ENDLOOP.

  IF g_vcode = co_vcode_display.
*   if longtext -> display icon
    IF ls_diag-diltx = on
      AND i_config_active = true. "ED, ID 14654
      l_icon = icon_display_text.
      CALL METHOD icon_create
        EXPORTING
          i_icon          = l_icon
          i_text          = space
          i_info          = 'Langtext anzeigen'(008)
        IMPORTING
          e_field         = l_diltxt
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    ELSE.
*     no longtext -> no button
      EXIT.
    ENDIF.
  ELSE.
*   Änderungsmodus
    IF ls_diag-diltx = on.
      IF i_config_input = true. "ED, ID 14654
        l_icon = icon_change_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext ändern'(009)
          IMPORTING
            e_field         = l_diltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
* ED, ID 14654 -> BEGIN
      ELSE.
        l_icon = icon_display_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext anzeigen'(008)
          IMPORTING
            e_field         = l_diltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
      ENDIF.
* ED, ID 14654 -> END
    ELSE.
      IF i_config_input = true. "ED, ID 14654
        l_icon = icon_create_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext anlegen'(010)
          IMPORTING
            e_field         = l_diltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
      ENDIF. "ED, ID 14654
    ENDIF.
  ENDIF.

*  CALL FUNCTION 'ISH_TEXTBUTTON_SET'
*    EXPORTING
*      ss_lgtxt       = ls_diag-diltx
*      ss_button_name = 'RN1_DYNP_MED_DATA-N1DILTXT'
*      ss_text_name   = 'RN1_DYNP_MED_DATA-DITXT'
*      ss_vcode       = g_vcode
*    IMPORTING
*      ss_button      = l_diltxt.

  l_wa_field_value_diltxt-value = l_diltxt.
  g_diltx_button = l_diltxt. "ED, ID 14654
  MODIFY lt_field_values FROM l_wa_field_value_diltxt
    TRANSPORTING value WHERE fieldname = g_fieldname_n1diltxt.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_n1frltxt .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_frage TYPE rnfield_value,
        l_wa_field_value_frltxt TYPE rnfield_value,
        l_kanam TYPE n1corder-kanam,
        l_rc TYPE ish_method_rc,
        lr_corder TYPE REF TO cl_ish_corder,
        ls_n1corder TYPE n1corder,
        l_frltxt TYPE rn1_dynp_med_data-n1frltxt,
        l_icon TYPE char100.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

* ED, ID 14654: if configs are space -> set true default -> BEGIN
  IF i_config_active = space.
    i_config_active = true.
  ENDIF.
  IF i_config_input = space.
    i_config_input = true.
  ENDIF.
* ED, ID 14654 -> END

  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_frltxt
     WITH KEY fieldname = g_fieldname_n1frltxt.
  CHECK sy-subrc EQ 0.

  IF g_vcode = co_vcode_display.
*   if longtext -> display icon
    IF ls_n1corder-frltx = on
      AND i_config_active = true. "ED, ID 14654
      l_icon = icon_display_text.
      CALL METHOD icon_create
        EXPORTING
          i_icon          = l_icon
          i_text          = space
          i_info          = 'Langtext anzeigen'(008)
        IMPORTING
          e_field         = l_frltxt
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    ELSE.
*     no longtext -> no button
      EXIT.
    ENDIF.
  ELSE.
*   Änderungsmodus
    IF ls_n1corder-frltx = on.
      IF i_config_input = true. "ED, ID 14654
        l_icon = icon_change_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext ändern'(009)
          IMPORTING
            e_field         = l_frltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
* ED, ID 14654 -> BEGIN
      ELSE.
        l_icon = icon_display_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext anzeigen'(008)
          IMPORTING
            e_field         = l_frltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
      ENDIF.
* ED, ID 14654 -> END
    ELSE.
      IF i_config_input = true. "ED, ID 14654
        l_icon = icon_create_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext anlegen'(010)
          IMPORTING
            e_field         = l_frltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
      ENDIF. "ED, ID 14654
    ENDIF.
  ENDIF.

*  CALL FUNCTION 'ISH_TEXTBUTTON_SET'
*    EXPORTING
*      ss_lgtxt       = ls_n1corder-frltx
*      ss_button_name = 'RN1_DYNP_MED_DATA-N1FRLTXT'
*      ss_text_name   = 'RN1_DYNP_MED_DATA-FRAGE'
*      ss_vcode       = g_vcode
*    IMPORTING
*      ss_button      = l_frltxt
*    EXCEPTIONS
*      OTHERS         = 1.

  CHECK l_rc = 0.
  l_wa_field_value_frltxt-value = l_frltxt.
  g_frltx_button = l_frltxt. "ED, ID 14654
  MODIFY lt_field_values FROM l_wa_field_value_frltxt
    TRANSPORTING value WHERE fieldname = g_fieldname_n1frltxt.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_n1kaltxt .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_kanam TYPE rnfield_value,
        l_wa_field_value_kaltxt TYPE rnfield_value,
        l_kanam TYPE n1corder-kanam,
        l_rc TYPE ish_method_rc,
        lr_corder TYPE REF TO cl_ish_corder,
        ls_n1corder TYPE n1corder,
        l_kaltxt TYPE rn1_dynp_med_data-n1kaltxt,
        l_icon TYPE char100.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

* ED, ID 14654: if configs are space -> set true default -> BEGIN
  IF i_config_active = space.
    i_config_active = true.
  ENDIF.
  IF i_config_input = space.
    i_config_input = true.
  ENDIF.
* ED, ID 14654 -> END

  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_kaltxt
     WITH KEY fieldname = g_fieldname_n1kaltxt.
  CHECK sy-subrc EQ 0.

  IF g_vcode = co_vcode_display.
*   if longtext -> display icon
    IF ls_n1corder-kaltx = on
      AND i_config_active = true. "ED, ID 14654
      l_icon = icon_display_text.
      CALL METHOD icon_create
        EXPORTING
          i_icon          = l_icon
          i_text          = space
          i_info          = 'Langtext anzeigen'(008)
        IMPORTING
          e_field         = l_kaltxt
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    ELSE.
*     no longtext -> no button
      EXIT.
    ENDIF.
  ELSE.
*   Änderungsmodus
    IF ls_n1corder-kaltx = on.
      IF i_config_input = true. "ED, ID 14654
        l_icon = icon_change_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext ändern'(009)
          IMPORTING
            e_field         = l_kaltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
* ED, ID 14654 -> BEGIN
      ELSE.
        l_icon = icon_display_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext anzeigen'(008)
          IMPORTING
            e_field         = l_kaltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
      ENDIF.
* ED, ID 14654 -> END
    ELSE.
      IF i_config_input = true. "ED, ID 14654
        l_icon = icon_create_text.
        CALL METHOD icon_create
          EXPORTING
            i_icon          = l_icon
            i_text          = space
            i_info          = 'Langtext anlegen'(010)
          IMPORTING
            e_field         = l_kaltxt
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK e_rc = 0.
      ENDIF. "ED, ID 14654
    ENDIF.
  ENDIF.

*  CALL FUNCTION 'ISH_TEXTBUTTON_SET'
*    EXPORTING
*      ss_lgtxt       = ls_n1corder-kaltx
*      ss_button_name = 'RN1_DYNP_MED_DATA-N1KALTXT'
*      ss_text_name   = 'RN1_DYNP_MED_DATA-KANAM'
*      ss_vcode       = g_vcode
*    IMPORTING
*      ss_button      = l_kaltxt
*    EXCEPTIONS
*      OTHERS         = 1.

  CHECK l_rc = 0.
  l_wa_field_value_kaltxt-value = l_kaltxt.
  g_kaltx_button = l_kaltxt. "ED, ID 14654
  MODIFY lt_field_values FROM l_wa_field_value_kaltxt
    TRANSPORTING value WHERE fieldname = g_fieldname_n1kaltxt.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


method FILL_T_SCRM_FIELD .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* kanam
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_kanam.
  ls_scrm_field-fieldlabel = 'Kurzanamnese'(002).
  APPEND ls_scrm_field TO gt_scrm_field.

* schwkz
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_schwkz.
  ls_scrm_field-fieldlabel = 'Schwanger'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

* schwo
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_schwo.
  ls_scrm_field-fieldlabel = 'Woche'(004).
  APPEND ls_scrm_field TO gt_scrm_field.

* ifg
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_ifg.
  ls_scrm_field-fieldlabel = 'Infektionsgrad'(005).
  APPEND ls_scrm_field TO gt_scrm_field.

* ditxt
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_ditxt.
  ls_scrm_field-fieldlabel = 'Diagnose'(006).
  APPEND ls_scrm_field TO gt_scrm_field.

* frage
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_frage.
  ls_scrm_field-fieldlabel = 'Fragestellung'(007).
  APPEND ls_scrm_field TO gt_scrm_field.

* risk_facts                                            "MED-34948
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_risk_facts.
  ls_scrm_field-fieldlabel = 'Risikofaktoren'(011).
  APPEND ls_scrm_field TO gt_scrm_field.

endmethod.


METHOD icon_create .

  e_rc = 0.

  DATA: l_result(100).

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = i_icon
      text                  = i_text
      info                  = i_info
    IMPORTING
      RESULT                = l_result
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.
  e_rc = sy-subrc.
  CHECK sy-subrc EQ 0.
  e_field = l_result.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_med_data.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_A .

  DATA: l_object_type                 TYPE i.

* ---------- ---------- ----------
  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_med_data.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off. ID-16230
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~create_all_listboxes .

  CLEAR: e_rc.

* IFG
  CALL METHOD create_listbox
    EXPORTING
      i_fieldname     = g_fieldname_ifg
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


method IF_ISH_SCREEN~GET_FIELDS.

* workareas
  DATA: ls_field_val               LIKE LINE OF et_field_values.
* definitions
  DATA: l_index                    TYPE sy-tabix.
* ---------- ---------- ----------
  CALL METHOD super->if_ish_screen~get_fields
    EXPORTING
      i_conv_to_extern = i_conv_to_extern
    IMPORTING
      et_field_values  = et_field_values
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = c_errorhandler.
  CHECK e_rc = 0.
* ---------- ---------- ----------
* convert fields if necessary
  IF i_conv_to_extern = on.
*   ----------
*   degree of infection
    READ TABLE et_field_values INTO ls_field_val
         WITH KEY fieldname = g_fieldname_ifg.
    IF sy-subrc = 0.
      l_index = sy-tabix.
*     convert intern to extern value
      IF ls_field_val-value = '00'.
        ls_field_val-value = '  '.
        MODIFY et_field_values FROM ls_field_val INDEX l_index.
      ENDIF.
    ENDIF.
*   ----------
  ENDIF.
* ---------- ---------- ----------

endmethod.


METHOD if_ish_screen~is_field_initial.

  DATA: lt_field_values         TYPE ish_t_field_value,
        l_wa_field_value        TYPE rnfield_value,
        lt_diag                 TYPE ish_objectlist,
        lt_tline                TYPE ish_t_textmodule_tline,
        lr_corder               TYPE REF TO cl_ish_corder.

  r_initial = super->if_ish_screen~is_field_initial(
      i_fieldname = i_fieldname
      i_rownumber = i_rownumber ).

  CHECK r_initial = abap_true.

  CHECK i_fieldname = g_fieldname_kanam OR
        i_fieldname = g_fieldname_ditxt OR
        i_fieldname = g_fieldname_frage.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

  CASE i_fieldname.
    WHEN g_fieldname_kanam.
      CALL METHOD lr_corder->if_ish_use_textmodule~get_text
        EXPORTING
          i_text_id = cl_ish_corder=>co_text_kanam
        IMPORTING
          et_tline  = lt_tline.
    WHEN g_fieldname_frage.
      CALL METHOD lr_corder->if_ish_use_textmodule~get_text
        EXPORTING
          i_text_id = cl_ish_corder=>co_text_frage
        IMPORTING
          et_tline  = lt_tline.
    WHEN g_fieldname_ditxt.
      CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
        EXPORTING
          ir_corder      = lr_corder
          ir_environment = gr_environment
        IMPORTING
          et_diagnosis   = lt_diag.
  ENDCASE.

  IF lt_tline[] IS NOT INITIAL OR lt_diag[] IS NOT INITIAL.
    r_initial = abap_false.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen .

  TYPES: BEGIN OF lty_r_falnr,
           sign(1)   TYPE c,
           option(2) TYPE c,
           low       TYPE nfal-falnr,
           high      TYPE nfal-falnr,
         END OF lty_r_falnr.

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        ls_n1corder      TYPE n1corder,
        l_tc_auth        TYPE ish_on_off,
        ls_npat          TYPE npat,
        lr_prereg        TYPE REF TO cl_ishmed_prereg,
        l_falnr          TYPE nfal-falnr,
        l_not_found      TYPE ish_on_off,
        lt_cordpos       TYPE ish_t_cordpos,
        lt_falnr         TYPE rnrangefalnr_tt,
        l_r_falnr        TYPE lty_r_falnr,
*        l_falnr_dia      TYPE nfal-falnr,
*        l_lfdnr_dia      TYPE ndia-lfdnr,
        lt_diag          TYPE ish_objectlist,
        ls_object        TYPE ish_object,
        lr_diag          TYPE REF TO cl_ish_prereg_diagnosis,
        l_ditxt          TYPE ndia-ditxt,
        ls_nkdi          TYPE nkdi,
        ls_rndip_attrib  TYPE rndip_attrib,
        l_loc            TYPE n2_dialo,                  " ED, ID 14781
        l_diabz          TYPE ish_on_off,                   " ID 14806
        ls_rndipx        TYPE rndipx, "ED, ID 17062
        l_rc             TYPE ish_method_rc, "ED, ID 17062
        l_diklat_set     TYPE ish_on_off. "ED, ID 17062

*-- start Grill, ID-16860
  DATA: lt_ndia TYPE ishmed_t_hndia,
        ls_ndia TYPE rn2hndia.
*-- End Grill, ID-16860

* ED, ID 14654 -> BEGIN
  DATA:   l_diltxt                TYPE rn1_dynp_med_data-n1diltxt,
          l_kaltxt                TYPE rn1_dynp_med_data-n1kaltxt,
          l_frltxt                TYPE rn1_dynp_med_data-n1frltxt,
          l_vcode                 TYPE ish_vcode,
          l_longtext(17)          TYPE c,
          l_diltx_more(40)        TYPE c.
* ED, ID 14654 -> END

  DATA: l_name TYPE thead-tdname.             "Gratzl MED-73984
  DATA: lt_tline TYPE ish_t_textmodule_tline. "Gratzl MED-73984

  DATA: l_created TYPE ish_on_off,                          "ID 18635
        l_result TYPE itcer.                                "ID 18635
  l_created = off.                                          "ID 18635

  DATA: lt_messages TYPE ishmed_t_bapiret2,                 "ID-20053
        ls_messages TYPE bapiret2.                          "ID-20053

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.

* why is g_vcode initial???
  IF g_vcode IS INITIAL.
    g_vcode = co_vcode_update.
  ENDIF.

  l_longtext = 'Langtext anzeigen'(008). "ED, ID 14654

  CASE c_okcode.
    WHEN 'KANAMSEL'. "the longtext from KANAM

* ED, ID 14654: check longtext -> BEGIN
      l_vcode = g_vcode.
      l_kaltxt = g_kaltx_button.
      IF l_kaltxt CS l_longtext.
        l_vcode = co_vcode_display.
      ENDIF.
* ED, ID 14654 -> END

      CALL METHOD lr_corder->edit_text
        EXPORTING
          i_text_id      = lr_corder->co_text_kanam
*         i_vcode        = g_vcode
          i_vcode        = l_vcode "ED, ID 14654
        IMPORTING
          e_rc           = e_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.

    WHEN 'DIAGSEL'. "the longtext from DITXT
      l_created = off.                                      "ID18635
*      CALL METHOD lr_corder->edit_text
*        EXPORTING
*          i_text_id      = lr_corder->co_text_ditxt
*          i_vcode        = g_vcode
*        IMPORTING
*          e_rc           = e_rc
*        CHANGING
*          c_errorhandler = c_errorhandler.
*     Get corder's diagnosis objects.
      CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
        EXPORTING
*         I_CANCELLED_DATAS = OFF
          ir_corder         = lr_corder
          ir_environment    = gr_environment
        IMPORTING
          e_rc              = e_rc
          et_diagnosis      = lt_diag
        CHANGING
          cr_errorhandler   = c_errorhandler.
      IF lt_diag IS INITIAL.
*       If there is not yet a diagnosis -> create one.
        CLEAR: lr_diag, ls_rndip_attrib.
        ls_rndip_attrib-einri  = ls_n1corder-einri.
        ls_rndip_attrib-diklat = on.
        CALL METHOD cl_ish_prereg_diagnosis=>create
          EXPORTING
            is_data             = ls_rndip_attrib
            i_environment       = gr_environment
          IMPORTING
            e_instance          = lr_diag
          EXCEPTIONS
            missing_environment = 1
            OTHERS              = 2.
        IF sy-subrc <> 0.
          CLEAR lr_diag.
        ENDIF.
        l_created = on.                                     "ID 18635
        IF NOT lr_diag IS INITIAL.
*         Connect diagnosis with corder.
          CALL METHOD lr_corder->add_connection
            EXPORTING
              i_object = lr_diag.
*         Add diagnosis to lt_diag (for further processing).
          CLEAR ls_object.
          ls_object-object = lr_diag.
          APPEND ls_object TO lt_diag.
        ENDIF.
      ENDIF.
*     Edit text of diagnosis with order-flag
      LOOP AT lt_diag INTO ls_object.
        lr_diag ?= ls_object-object.
        CHECK NOT lr_diag IS INITIAL.
        CALL METHOD lr_diag->get_data
          IMPORTING
            es_data        = ls_rndip_attrib
            e_rc           = e_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        CHECK e_rc = 0.
        CHECK ls_rndip_attrib-diklat = on.

* ED, ID 14654: check longtext -> BEGIN
        l_vcode = g_vcode.
        l_diltxt = g_diltx_button.
        IF l_diltxt CS l_longtext.
          l_vcode = co_vcode_display.
        ENDIF.
* ED, ID 14654 -> END
        CALL METHOD lr_diag->edit_text
          EXPORTING
            i_text_id      = lr_diag->co_text_diltxt
*           i_vcode        = g_vcode
            i_vcode        = l_vcode "ED, ID 14654
          IMPORTING
            e_result       = l_result                       "18635
            e_rc           = e_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        EXIT.
      ENDLOOP.
      CHECK e_rc = 0.
*-- bgin Grill, ID-18635
      IF l_result-userexit = 'C' AND l_created = on.
        CALL METHOD lr_diag->destroy
          IMPORTING
            e_rc           = l_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        CLEAR lr_diag.
      ENDIF.
*-- end Grill, ID-18634

    WHEN 'MORE_DIA'. "more diagnosis
*     get all cases from this corder
      CALL METHOD lr_corder->get_t_cordpos
        EXPORTING
          ir_environment  = gr_environment
        IMPORTING
          et_cordpos      = lt_cordpos
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
      CHECK e_rc = 0.
      l_r_falnr-option = 'EQ'.
      l_r_falnr-sign = 'I'.
      LOOP AT lt_cordpos INTO lr_prereg.
        CALL METHOD lr_prereg->get_data_field
          EXPORTING
            i_fieldname     = 'FALNR'
          IMPORTING
            e_rc            = e_rc
            e_field         = l_falnr
            e_fld_not_found = l_not_found
          CHANGING
            c_errorhandler  = c_errorhandler.
        CHECK e_rc = 0 AND l_not_found = off.
        IF NOT l_falnr IS INITIAL.
          l_r_falnr-low = l_falnr.
          APPEND l_r_falnr TO lt_falnr.
        ENDIF.
      ENDLOOP.
*     ID 14806: Begin of DELETE
*      IF lt_falnr[] IS INITIAL.
**       call without case
*        CALL FUNCTION 'ISH_PREG_DIAGNOSIS_SCREEN'
*          EXPORTING
*            i_vcode            = g_vcode
*            i_corder_object    = lr_corder
*          IMPORTING
*            e_rc               = e_rc
*          CHANGING
*            c_rd_error_handler = c_errorhandler.
*      ELSE.
*       call with case
*     ID 14806: End of DELETE
*     Käfer, ID: 14806 07072004 - Begin
*     the flag l_diabz must always be set to on, otherwise
*     all diagnoses will be displayed (case specific diagnosis
*     of all cases of the patient will be displayed too
      l_diabz = on.
*     ID 14806: Begin of INSERT
*      IF lt_falnr[] IS INITIAL.
*        l_diabz = on.
*      ELSE.
*        l_diabz = off.
*      ENDIF.
*     ID 14806: End of INSERT
*     Käfer, ID: 14806 07072004 - End
*     Get corder's diagnosis objects.
*-- Begin of delete, Grill ID-16860
*      CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
*        EXPORTING
**          I_CANCELLED_DATAS = OFF
*          ir_corder         = lr_corder
*          ir_environment    = gr_environment
*        IMPORTING
*          e_rc              = e_rc
*          et_diagnosis      = lt_diag
*        CHANGING
*          cr_errorhandler   = c_errorhandler.
*      CHECK e_rc = 0.
**      IF lt_diag[] IS INITIAL. "Grill, ID-16860
*        DATA: lt_ndia TYPE ishmed_t_hndia,
*              ls_ndia TYPE rn2hndia.
*-- End of delete, Grill ID-16860

* ED, ID 14654: check longtext -> BEGIN
      l_vcode = g_vcode.
      l_diltx_more = g_diltx_more_button.
      IF l_diltx_more = 'anzeigen'.
        l_vcode = co_vcode_display.
      ENDIF.
* ED, ID 14654 -> END
      IF NOT l_vcode = co_vcode_display.
        CALL FUNCTION 'ISH_N2_SHOW_VDIAPAT'
          EXPORTING
            ss_einri        = ls_n1corder-einri
            ss_patnr        = ls_n1corder-patnr
            ss_vcode        = 'UPD'
            ss_diabz        = l_diabz                       " ID 14806
            ir_rnrangefalnr = lt_falnr
          IMPORTING
*           e_diagnose      = ls_nkdi
**            e_falnr           = l_falnr_dia
**            e_lfdnr           = l_lfdnr_dia
*           e_dialo         = l_loc                   " ED, ID 14781
*           e_ditxt         = l_ditxt
            et_ndia         = lt_ndia                       "6.00
          EXCEPTIONS
            not_found       = 1
            OTHERS          = 2.
        IF sy-subrc = 0.
*         Schnittstellenänderung 6.00
*-- Begin Grill, ID-16860
*          if lt_ndia[] is not initial.
*           READ TABLE lt_ndia into ls_ndia INDEX 1.
          LOOP AT lt_ndia INTO ls_ndia.
            CHECK NOT ls_ndia IS INITIAL.
            ls_nkdi-dkat = ls_ndia-dkat1.
            ls_nkdi-dkey = ls_ndia-dkey1.
            l_ditxt      = ls_ndia-ditxt.
            l_loc        = ls_ndia-dialo.
*-- End Grill, ID-16860
*         create selected diagnosis and connect with order
            IF NOT ls_nkdi-dkey IS INITIAL OR NOT l_ditxt IS INITIAL.
              CLEAR: lr_diag, ls_rndip_attrib.
              ls_rndip_attrib-einri  = ls_n1corder-einri.
              ls_rndip_attrib-dcat   = ls_nkdi-dkat.
              ls_rndip_attrib-dkey   = ls_nkdi-dkey.
              ls_rndip_attrib-ditxt  = l_ditxt.
              ls_rndip_attrib-diklat = on.
              ls_rndip_attrib-dloc   = l_loc.            " ED, ID 14781
              CALL METHOD cl_ish_prereg_diagnosis=>create
                EXPORTING
                  is_data             = ls_rndip_attrib
                  i_environment       = gr_environment
                IMPORTING
                  e_instance          = lr_diag
                EXCEPTIONS
                  missing_environment = 1
                  OTHERS              = 2.
              IF sy-subrc <> 0.
                CLEAR lr_diag.
              ENDIF.
              IF NOT lr_diag IS INITIAL.
*               begin Gratzl MED-73984
                IF ls_ndia-diltx = 'X'.
                  CONCATENATE ls_ndia-einri ls_ndia-falnr ls_ndia-lfdnr INTO l_name.
                  CALL FUNCTION 'READ_TEXT'
                    EXPORTING
                      client                  = sy-mandt
                      id                      = ls_ndia-einri
                      language                = sy-langu
                      name                    = l_name
                      object                  = 'NDIA'
*                     ARCHIVE_HANDLE          = 0
*                     LOCAL_CAT               = ' '
*                    IMPORTING
*                     HEADER                  =
*                     OLD_LINE_COUNTER        =
                    TABLES
                      lines                   = lt_tline
                    EXCEPTIONS
                      id                      = 1
                      language                = 2
                      name                    = 3
                      not_found               = 4
                      object                  = 5
                      reference_check         = 6
                      wrong_access_to_archive = 7
                      OTHERS                  = 8.
                  IF sy-subrc = 0.
*                   Implement suitable error handling here
                    CALL METHOD lr_diag->if_ish_use_textmodule~change_text
                      EXPORTING
                        i_text_id      = cl_ish_prereg_diagnosis=>co_text_diltxt
                        it_tline       = lt_tline
                        i_tline_x      = 'X'
                      IMPORTING
                        e_rc           = l_rc
                      CHANGING
                        c_errorhandler = c_errorhandler.
                    IF l_rc <> 0.
                      e_rc = l_rc.
                      EXIT.
                    ENDIF.
                  ENDIF.
                ENDIF.
*               end Gratzl MED-73984
                CALL METHOD lr_corder->add_connection
                  EXPORTING
                    i_object = lr_diag.

                lr_diag->set_ndia( is_ndia = ls_ndia ). "MED-48033 Rapa Andreea 13.08.2012
              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.
*      ENDIF. "Grill, ID-16860
*    ENDIF. "Grill, ID-16860


      CALL FUNCTION 'ISH_PREG_DIAGNOSIS_SCREEN'
        EXPORTING
*         i_vcode            = g_vcode
          i_vcode            = l_vcode "ED, ID 14654
          i_corder_object    = lr_corder
        IMPORTING
          e_rc               = e_rc
        CHANGING
          c_rd_error_handler = c_errorhandler.
*-- begin Grill, ID-20053
      IF e_rc NE 0.
        CALL METHOD c_errorhandler->get_messages
          IMPORTING
            t_messages = lt_messages.

        DELETE ADJACENT DUPLICATES FROM lt_messages.

        READ TABLE lt_messages INTO ls_messages
         WITH KEY number = '526'.
        IF sy-subrc EQ 0.
          DO.
            CALL METHOD c_errorhandler->display_messages
              EXPORTING
                i_send_if_one = 'X'
                i_control     = on.
            e_rc = 0.
            CALL FUNCTION 'ISH_PREG_DIAGNOSIS_SCREEN'
              EXPORTING
                i_vcode            = l_vcode "ED, ID 14654
                i_corder_object    = lr_corder
              IMPORTING
                e_rc               = e_rc
              CHANGING
                c_rd_error_handler = c_errorhandler.
            IF e_rc EQ 0.
              EXIT.
            ENDIF.
          ENDDO.
        ENDIF.
      ENDIF.
*-- end Grill, ID-20053

* ED, ID 17062: check if diklat is set -> if not set it
*               in the first diagnosis -> BEGIN
      CLEAR: lr_diag, ls_object, ls_rndip_attrib, lt_diag[].
*     Get corder's diagnosis objects.
      CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
        EXPORTING
*         I_CANCELLED_DATAS = OFF
          ir_corder         = lr_corder
          ir_environment    = gr_environment
        IMPORTING
          e_rc              = e_rc
          et_diagnosis      = lt_diag
        CHANGING
          cr_errorhandler   = c_errorhandler.
      CHECK e_rc = 0.
      l_diklat_set = off.
      LOOP AT lt_diag INTO ls_object.
        lr_diag ?= ls_object-object.
        CHECK lr_diag IS BOUND.
        CALL METHOD lr_diag->get_data
          IMPORTING
            es_data        = ls_rndip_attrib
            e_rc           = l_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
        CHECK ls_rndip_attrib-diklat = on.
        l_diklat_set = on.
        EXIT.
      ENDLOOP.
      CHECK e_rc = 0.
      CHECK l_diklat_set = off.
      CLEAR: lr_diag, ls_object.
      READ TABLE lt_diag INDEX 1
                  INTO ls_object.
      lr_diag ?= ls_object-object.
      CHECK lr_diag IS BOUND.
*     set DIKLAT
      CLEAR ls_rndipx.
      ls_rndipx-diklat   = on.
      ls_rndipx-diklat_x = on.
      CALL METHOD lr_diag->change
        EXPORTING
          is_what_to_change = ls_rndipx
        IMPORTING
          e_rc              = e_rc
        CHANGING
          c_errorhandler    = c_errorhandler.
      CHECK e_rc = 0.
* ED, ID 17062 -> END

*    ENDIF.                                          " REM ID 14806

    WHEN 'FRAGESEL'. "the longtext from FRAGE

* ED, ID 14654: check longtext -> BEGIN
      l_vcode = g_vcode.
      l_frltxt = g_frltx_button.
      IF l_frltxt CS l_longtext.
        l_vcode = co_vcode_display.
      ENDIF.
* ED, ID 14654 -> END
      CALL METHOD lr_corder->edit_text
        EXPORTING
          i_text_id      = lr_corder->co_text_frage
*         i_vcode        = g_vcode
          i_vcode        = l_vcode "ED, ID 14654
        IMPORTING
          e_rc           = e_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      CHECK e_rc = 0.

    WHEN 'RISK_FACTS'. "risk facts -> go to the transaktion
      IF ls_n1corder-patnr IS INITIAL.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'S'
            i_kla           = 'N1CORDMG'
            i_num           = '075'
          CHANGING
            cr_errorhandler = c_errorhandler.
        EXIT.
      ELSE.

* Begin 19129 Söldner Christian 16.02.2006
*        SELECT SINGLE * FROM npat
*                        INTO ls_npat
*                        WHERE patnr = ls_n1corder-patnr.
*        IF sy-subrc <> 0.
        CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
          EXPORTING
            i_patnr         = ls_n1corder-patnr
            i_read_db       = on
            i_no_buffer     = on
          IMPORTING
            es_npat         = ls_npat
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = c_errorhandler.
        IF l_rc <> 0.
* End 19129 Söldner Christian 16.02.2006
          CALL METHOD cl_ish_utl_base=>collect_messages
            EXPORTING
              i_typ           = 'E'
              i_kla           = 'N1'
              i_num           = '014'
              i_mv1           = ls_n1corder-patnr
            CHANGING
              cr_errorhandler = c_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.
*     risc facts,
      SET PARAMETER ID 'EIN' FIELD ls_n1corder-einri.
      SET PARAMETER ID 'PAT' FIELD ls_n1corder-patnr.
      SET PARAMETER ID 'PZP' FIELD ls_npat-pziff.
      SET PARAMETER ID 'FAL' FIELD space.
      SET PARAMETER ID 'PZF' FIELD space.
*     if the patient is already enqueded, then dequeue because the
*     transaction does the enqueue itself
      IF g_vcode <> co_vcode_display.
        DO 1000 TIMES.
          CALL FUNCTION 'ISHMED_DEQUEUE_ENPAT'
            EXPORTING
              patnr    = ls_n1corder-patnr
              i_caller = 'CL_ISH_SCR_MED_DATA'
            IMPORTING
              e_rc     = e_rc.
          CHECK e_rc = 0.
        ENDDO.
      ENDIF.
*-- begin Grill, ID-18801
*      IF g_vcode <> co_vcode_display.
*        PERFORM call_tcode IN PROGRAM sapmnpa0 USING 'NP04'
*           ls_n1corder-einri
*                    on l_tc_auth.
*      ELSE.
*        PERFORM call_tcode IN PROGRAM sapmnpa0 USING 'NP05'
*           ls_n1corder-einri
*                    on l_tc_auth.
*      ENDIF.
      IF g_vcode <> co_vcode_display.
*-- authority-check "N_EINR_TCO -> NP04
        AUTHORITY-CHECK OBJECT 'N_EINR_TCO'
                 ID 'N_EINRI' FIELD ls_n1corder-einri
                 ID 'TCD' FIELD 'NP04'.
        IF sy-subrc EQ 0.
*-- call transaction NP04
          PERFORM call_tcode IN PROGRAM sapmnpa0 USING 'NP04'
             ls_n1corder-einri
                      on l_tc_auth.
        ELSE.
*-- call transaction NP05
          MESSAGE s607(n1) WITH 'NP04' ls_n1corder-einri.
          PERFORM call_tcode IN PROGRAM sapmnpa0 USING 'NP05'
             ls_n1corder-einri
              on l_tc_auth.
        ENDIF.
      ELSE.                                  "g_vcode <> display
        PERFORM call_tcode IN PROGRAM sapmnpa0 USING 'NP05'
           ls_n1corder-einri
                    on l_tc_auth.
      ENDIF.                                 "g_vcode <> display
*-- end Grill, ID-18801
*     enqueue the patient
      IF g_vcode <> co_vcode_display.
*        DO 1000 TIMES.                               "MED-40575
        DO 10000 TIMES.                               "MED-40575
          CALL FUNCTION 'ISHMED_ENQUEUE_ENPAT'
            EXPORTING
              patnr          = ls_n1corder-patnr
              i_caller       = 'CL_ISH_SCR_MED_DATA'
              _scope         = '1'
            EXCEPTIONS
              foreign_lock   = 4
              system_failure = 12.
          e_rc = sy-subrc.
          IF e_rc = 0.
            EXIT.
          ENDIF.
        ENDDO.
      ENDIF.
  ENDCASE.

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

* call the fub for med. data
  CALL FUNCTION 'ISH_SDY_MED_DATA_INIT'
    EXPORTING
      ir_scr_med_data = me
    IMPORTING
      es_parent       = gs_parent
      e_rc            = e_rc
    CHANGING
      cr_dynp_data    = gr_scr_data
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


  METHOD if_ish_screen~transport_to_dy.
*redefined for MED-57037 AGujev
*MED-57037 code of inherited method copied entirely, changes are commented
* local tables
  DATA: lt_field_val             TYPE ish_t_field_value.
* definitions
  DATA: l_rc                     TYPE ish_method_rc.
* field symbols
  FIELD-SYMBOLS:
        <ls_data>                TYPE any.
* object references
  DATA: lr_error                 TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS <ls_field_val> TYPE  rnfield_value.    "MED-57037 AGujev
  DATA:         lt_tline         TYPE ish_t_textmodule_tline,  "MED-57037 AGujev
        l_wa_tline       TYPE tline,       "MED-57037 AGujev
        lt_text      TYPE STANDARD TABLE OF text132,   "MED-57037 AGujev
        ls_text LIKE LINE OF lt_text.    "MED-57037 AGujev
* ---------- ---------- ----------
* first get field values in extern format
  CALL METHOD me->get_fields
    EXPORTING
      i_conv_to_extern = on
    IMPORTING
      et_field_values  = lt_field_val
      e_rc             = l_rc
    CHANGING
      c_errorhandler   = lr_error.
  IF l_rc <> 0.
    EXIT.
  ENDIF.

*-->begin of MED-57037 AGujev
  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
    IF <ls_field_val>-fieldname = g_fieldname_kanam
      or <ls_field_val>-fieldname = g_fieldname_ditxt
      or <ls_field_val>-fieldname = g_fieldname_frage.
    CLEAR: lt_tline[],
           l_wa_tline.
    l_wa_tline-tdline = <ls_field_val>-value.
    APPEND l_wa_tline TO lt_tline.
*-- convert text to external format
    CALL FUNCTION 'CONVERT_ITF_TO_STREAM_TEXT'
      EXPORTING
        language    = sy-langu
      TABLES
        itf_text    = lt_tline
        text_stream = lt_text.
     IF lt_text IS NOT INITIAL.
       READ TABLE lt_text INTO ls_text INDEX 1.
       <ls_field_val>-value = ls_text.
       clear lt_text[].
     ENDIF.
    ENDIF.
  ENDLOOP.
*<--end of MED-57037 AGujev

* ---------- ---------- ----------
  CHECK NOT gr_scr_data IS INITIAL.
  ASSIGN gr_scr_data->* TO <ls_data>.
  CHECK sy-subrc = 0.
* ---------- ---------- ----------
* map field values to screen structure
  CALL METHOD cl_ish_utl_screen=>map_fv_to_str
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cs_data         = <ls_data>
      cr_errorhandler = lr_error.
  IF l_rc <> 0.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
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
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-KANAM'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-SCHWKZ'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-SCHWO'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-IFG'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-DITXT'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-FRAGE'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-N1KALTXT'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-N1DILTXT'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-N1FRLTXT'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_MED_DATA-MORE_DIA'.
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


METHOD initialize_internal .

  g_fieldname_kanam = 'RN1_DYNP_MED_DATA-KANAM'.
  g_fieldname_schwkz = 'RN1_DYNP_MED_DATA-SCHWKZ'.
  g_fieldname_schwo = 'RN1_DYNP_MED_DATA-SCHWO'.
  g_fieldname_ifg = 'RN1_DYNP_MED_DATA-IFG'.
  g_fieldname_ditxt = 'RN1_DYNP_MED_DATA-DITXT'.
  g_fieldname_n1kaltxt = 'RN1_DYNP_MED_DATA-N1KALTXT'.
  g_fieldname_n1diltxt = 'RN1_DYNP_MED_DATA-N1DILTXT'.
  g_fieldname_frage = 'RN1_DYNP_MED_DATA-FRAGE'.
  g_fieldname_n1frltxt = 'RN1_DYNP_MED_DATA-N1FRLTXT'.
  g_fieldname_more_dia = 'RN1_DYNP_MED_DATA-MORE_DIA'.
  g_fieldname_risk_facts = 'RN1_DYNP_MED_DATA-RISK_FACTS'.        "MED-34948

* ED, ID 14654 -> BEGIN
  CLEAR: g_frltx_button,
         g_diltx_button,
         g_kaltx_button,
         g_diltx_more_button.
* ED, ID 14654 -> END

ENDMETHOD.


METHOD INITIALIZE_PARENT .

  CLEAR: gs_parent.

  gs_parent-repid = 'SAPLN1_SDY_MED_DATA'.
  gs_parent-dynnr = '0100'.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD modify_screen_internal .

  DATA: lr_corder               TYPE REF TO cl_ish_corder,
        ls_n1corder             TYPE n1corder,
        l_einri                 TYPE tn01-einri,
        l_diltxt                TYPE rn1_dynp_med_data-n1diltxt,
        l_kaltxt                TYPE rn1_dynp_med_data-n1kaltxt,
        l_frltxt                TYPE rn1_dynp_med_data-n1frltxt,
        lr_prereg               TYPE REF TO cl_ishmed_prereg,
        lt_diagnosis            TYPE ish_objectlist,
        lt_field_values         TYPE ish_t_field_value,
        l_wa_field_value_diltxt TYPE rnfield_value,
        l_wa_field_value_kaltxt TYPE rnfield_value,
        l_wa_field_value_frltxt TYPE rnfield_value,
        l_gschl                 TYPE npat-gschl,
        ls_pap_data             TYPE rnpap_attrib,
        l_rc                    TYPE ish_method_rc,
        l_new                   TYPE ish_on_off,
        ls_modified             TYPE rn1screen.

* RW ID 14654 - BEGIN
  DATA: l_active_kanam          TYPE c,
        l_active_ditxt          TYPE c,
        l_active_frage          TYPE c.
* RW ID 14654 - END
* ED, ID 14654: check input -> BEGIN
  DATA: l_input_kanam           TYPE c,
        l_input_ditxt           TYPE c,
        l_input_frage           TYPE c,
        l_more_diagnosis        TYPE c,
        ls_object               TYPE ish_object,
        ls_diag                 TYPE rndip_attrib,
        lr_diag                 TYPE REF TO cl_ish_prereg_diagnosis.
* ED, ID 14654 -> END

* get the institution
  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

* get main object -> check if clinical order
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
      cl_ish_corder=>co_otype_corder ) = 'X'.
  lr_corder ?= gr_main_object.

  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* longtexts
  READ TABLE lt_field_values INTO l_wa_field_value_diltxt
     WITH KEY fieldname = g_fieldname_n1diltxt.
  CHECK sy-subrc EQ 0.
  l_diltxt = l_wa_field_value_diltxt-value.

* get diagnosis for corder
  CLEAR: lt_diagnosis[].
  CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
    EXPORTING
      ir_corder       = lr_corder
      ir_environment  = gr_environment
    IMPORTING
      e_rc            = e_rc
      et_diagnosis    = lt_diagnosis
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* ED, ID 14654 -> BEGIN
* Displayed Diagnosis is the one with the order flag
  CLEAR ls_diag.
  LOOP AT lt_diagnosis INTO ls_object.
    lr_diag ?= ls_object-object.
    CHECK NOT lr_diag IS INITIAL.
    CALL METHOD lr_diag->get_data
      IMPORTING
        es_data        = ls_diag
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF ls_diag-diklat = on.
      EXIT.
    ELSE.
      CLEAR ls_diag.
    ENDIF.
  ENDLOOP.
  IF lt_diagnosis[] IS INITIAL.
    l_more_diagnosis = off.
  ELSE.
    l_more_diagnosis = on.
  ENDIF.
* ED, ID 14654 -> END

  LOOP AT SCREEN.
*   longtexts
*   display
    IF g_vcode = co_vcode_display.
      IF screen-name = g_fieldname_n1diltxt.
        IF ls_diag-diltx = space. "ID 19023: false field!!
*        IF l_diltxt = space.
          screen-active = false.
        ELSE.
          screen-active = true.
          screen-input = true.
        ENDIF.
      ELSEIF screen-name = g_fieldname_n1kaltxt.
        IF ls_n1corder-kaltx = space.
          screen-active = false.
        ELSE.
          screen-active = true.
          screen-input = true.
        ENDIF.
      ELSEIF screen-name = g_fieldname_n1frltxt.
        IF ls_n1corder-frltx = space.
          screen-active = false.
        ELSE.
          screen-active = true.
          screen-input = true.
        ENDIF.
*-- begin Grill, ID-18801
*      ELSEIF screen-name = 'RISK_FACTS'.             "REM MED-34948
      ELSEIF screen-name = g_fieldname_risk_facts.    "MED-34948
        screen-active = true.
        screen-input  = true.
*-- end Grill, ID-18801
      ENDIF.
      MODIFY SCREEN.
*   no display
    ELSE.
      IF screen-name = g_fieldname_ditxt.
        IF ls_diag-diltx = on. "ED, ID 19023: false field!!
*        IF l_diltxt = '@0Q\QLangtext ändern@'.              "#EC *
          screen-input = false.
        ENDIF.
      ELSEIF screen-name = g_fieldname_frage.
        IF ls_n1corder-frltx = on.
          screen-input = false.
        ENDIF.
      ELSEIF screen-name = g_fieldname_kanam.
        IF ls_n1corder-kaltx = on.
          screen-input = false.
        ENDIF.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
*   more diagnosis
    IF g_vcode = co_vcode_display
       AND screen-name = 'RN1_DYNP_MED_DATA-MORE_DIA'.
      IF lt_diagnosis[] IS INITIAL.
        screen-active = false.
        l_more_diagnosis = off. "ED, ID 14654
      ELSE.
        l_more_diagnosis = on. "ED, ID 14654
        screen-active = true.
        screen-input = true.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
    IF g_ishmed_auth = off.
*      IF screen-name = 'RISK_FACTS' OR     "REM MED-34948
      IF screen-name = 'RN1_DYNP_MED_DATA-RISK_FACTS' OR      "MED-34948
         screen-name = 'RN1_DYNP_MED_DATA-SCHWKZ' OR
         screen-name = 'RN1_DYNP_MED_DATA-SCHWO' OR
         screen-name = 'RN1_DYNP_MED_DATA-IFG'." OR
        screen-active = false.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
    IF screen-name = 'RN1_DYNP_MED_DATA-SCHWKZ' OR
      screen-name = 'RN1_DYNP_MED_DATA-SCHWO'.
*     ED, ID 15282: check also it_modified -> BEGIN
      READ TABLE it_modified INTO ls_modified WITH KEY
          name = g_fieldname_schwkz.
      IF sy-subrc EQ 0.
        screen-input = ls_modified-input.
      ELSE.
*     ED, ID 15282 -> END
        IF NOT ls_n1corder-patnr IS INITIAL.

* Begin 19129 Söldner Christian 16.02.2006
*          SELECT gschl FROM npat INTO l_gschl
*            WHERE patnr = ls_n1corder-patnr.
*          ENDSELECT.
          DATA: ls_npat           TYPE npat.
          CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
            EXPORTING
              i_patnr         = ls_n1corder-patnr
              i_read_db       = on
              i_no_buffer     = on
            IMPORTING
              es_npat         = ls_npat
              e_rc            = l_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          IF l_rc = 0.
            l_gschl = ls_npat-gschl.
          ELSE.
            CLEAR l_gschl.
          ENDIF.
* End 19129 Söldner Christian 16.02.2006
        ELSE.
          CALL METHOD lr_corder->get_patient_provisional
            EXPORTING
              ir_environment  = gr_environment
            IMPORTING
              es_pap_data     = ls_pap_data
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          CHECK e_rc = 0.
          IF NOT ls_pap_data-gschle IS INITIAL.
            CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
              EXPORTING
                ss_gschle = ls_pap_data-gschle
              IMPORTING
                ss_gschl  = l_gschl
              EXCEPTIONS
                not_found = 1
                OTHERS    = 2.
            l_rc = sy-subrc.
            IF l_rc <> 0.
              CLEAR l_gschl.
            ENDIF.
          ELSE. "if no sex in patient provisional
            ls_n1corder-schwkz = 'U'. "unknown
          ENDIF.
        ENDIF.
        IF NOT l_gschl IS INITIAL.
          CASE l_gschl.
            WHEN 1. "male
              screen-input = false.
            WHEN OTHERS.
              IF g_vcode <> co_vcode_display.
                screen-input = true.
              ENDIF.
          ENDCASE.
          MODIFY SCREEN.
        ELSE.
          ls_n1corder-schwkz = 'U'. "unknown
*          MODIFY SCREEN. "ED, ID 15282
        ENDIF.
      ENDIF. "ED, ID 15282
      MODIFY SCREEN. "ED, ID 15282
    ENDIF.
  ENDLOOP.

*-- Begin delete, Grill ID-19023: not needed -> BEGIN COMMENT
*  l_wa_field_value_diltxt-value = l_diltxt.
*  MODIFY lt_field_values FROM l_wa_field_value_diltxt
*    TRANSPORTING value WHERE fieldname = g_fieldname_n1diltxt.
*
*  CALL METHOD me->set_fields
*    EXPORTING
*      it_field_values  = lt_field_values
*      i_field_values_x = 'X'
*    IMPORTING
*      e_rc             = e_rc
*    CHANGING
*      c_errorhandler   = cr_errorhandler.
*-- end Grill,ID-19023 -> END COMMENT

* RW ID 14654 - BEGIN
* Get information if special fields are displayed.
  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'RN1_DYNP_MED_DATA-KANAM'.
*       ED, ID 14654: check also it_modified -> BEGIN
        READ TABLE it_modified INTO ls_modified WITH KEY
            name = g_fieldname_kanam.
        IF sy-subrc EQ 0.
          l_active_kanam = ls_modified-active.
          l_input_kanam  = ls_modified-input.
          screen-active = l_active_kanam.
          screen-input  = l_input_kanam.
        ELSE.
*       ED, ID 14654 -> END
          l_active_kanam = screen-active.
        ENDIF. "ED, ID 14654
      WHEN 'RN1_DYNP_MED_DATA-DITXT'.
*       ED, ID 14654: check also it_modified -> BEGIN
        READ TABLE it_modified INTO ls_modified WITH KEY
            name = g_fieldname_ditxt.
        IF sy-subrc EQ 0.
          l_active_ditxt = ls_modified-active.
          l_input_ditxt  = ls_modified-input.
          screen-active = l_active_ditxt.
          screen-input  = l_input_ditxt.
        ELSE.
*       ED, ID 14654 -> END
          l_active_ditxt = screen-active.
        ENDIF. "ED, ID 14654
      WHEN 'RN1_DYNP_MED_DATA-FRAGE'.
*       ED, ID 14654: check also it_modified -> BEGIN
        READ TABLE it_modified INTO ls_modified WITH KEY
            name = g_fieldname_frage.
        IF sy-subrc EQ 0.
          l_active_frage = ls_modified-active.
          l_input_frage  = ls_modified-input.
          screen-active = l_active_frage.
          screen-input  = l_input_frage.
        ELSE.
*       ED, ID 14654 -> END
          l_active_frage = screen-active.
        ENDIF. "ED, ID 14654
      WHEN OTHERS.
    ENDCASE.
    MODIFY SCREEN. "ED, ID 14654
  ENDLOOP.
* If not displayed, hide assigned longtext buttons as well.
  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'RN1_DYNP_MED_DATA-N1KALTXT'.
        IF screen-active = true AND l_active_kanam = false.
          screen-active = false.
* ED, ID 14654 -> BEGIN
        ELSEIF screen-active = true AND l_active_kanam = true.
          screen-active = true.
* ED, ID 14654 -> END
        ENDIF.
* ED, ID 14654: check input -> BEGIN
*        IF screen-input = true AND l_input_kanam = false.
*          screen-input = false.
*        ELSEIF screen-input = true AND l_input_kanam = true.
*          screen-input = true.
*        ENDIF.
        IF l_input_kanam = false AND ls_n1corder-kaltx = off.
          screen-active = false.
        ENDIF.
*       set also button
        CALL METHOD me->fill_label_n1kaltxt
          EXPORTING
            i_config_active = l_active_kanam
            i_config_input  = l_input_kanam
          IMPORTING
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK l_rc = 0.
* ED, ID 14654 -> END
      WHEN 'RN1_DYNP_MED_DATA-N1DILTXT'.
        IF screen-active = true AND l_active_ditxt = false.
          screen-active = false.
* ED, ID 14654 -> BEGIN
        ELSEIF screen-active = true AND l_active_ditxt = true
          AND ls_diag-diltx = on. "ED, ID 19023: false field!!
*          AND l_diltxt = on.
          screen-active = true.
* ED, ID 14654 -> END
        ENDIF.
* ED, ID 14654: check input -> BEGIN
*        IF screen-input = true AND l_input_ditxt = false.
*          screen-input = false.
*        ELSEIF screen-input = true AND l_input_ditxt = true.
*          screen-input = true.
*        ENDIF.
        IF l_input_ditxt = false AND ls_diag-diltx = off.
          screen-active = false.
        ENDIF.
*       set also button
        CALL METHOD me->fill_label_n1diltxt
          EXPORTING
            i_config_active = l_active_ditxt
            i_config_input  = l_input_ditxt
          IMPORTING
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK l_rc = 0.
* ED, ID 14654 -> END
      WHEN 'RN1_DYNP_MED_DATA-MORE_DIA'.
        IF screen-active = true AND l_active_ditxt = false.
          screen-active = false.
* ED, ID 14654 -> BEGIN
        ELSEIF screen-active = true AND l_active_ditxt = true.
          screen-active = true.
* ED, ID 14654 -> END
        ENDIF.
* ED, ID 14654: check input -> BEGIN
*        IF screen-input = true AND l_input_ditxt = false.
*          screen-input = false.
*        ELSEIF screen-input = true AND l_input_ditxt = true.
*          screen-input = true.
*        ENDIF.
        IF l_input_ditxt = false AND l_more_diagnosis = off.
          screen-active = false.
        ENDIF.
        CALL METHOD me->fill_label_more_dia
          EXPORTING
            i_config_active = l_active_ditxt
            i_config_input  = l_input_ditxt
          IMPORTING
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK l_rc = 0.
* ED, ID 14654 -> END
      WHEN 'RN1_DYNP_MED_DATA-N1FRLTXT'.
        IF screen-active = true AND l_active_frage = false.
          screen-active = false.
* ED, ID 14654 -> BEGIN
        ELSEIF screen-active = true AND l_active_frage = true.
          screen-active = true.
* ED, ID 14654 -> END
        ENDIF.
* ED, ID 14654: check input -> BEGIN
*        IF screen-input = true AND l_input_frage = false.
*          screen-input = false.
*        ELSEIF screen-input = true AND l_input_frage = true.
*          screen-input = true.
*        ENDIF.
        IF l_input_frage = false AND ls_n1corder-frltx = off.
          screen-active = false.
        ENDIF.
*       set also button
        CALL METHOD me->fill_label_n1frltxt
          EXPORTING
            i_config_active = l_active_frage
            i_config_input  = l_input_frage
          IMPORTING
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        CHECK l_rc = 0.
* ED, ID 14654 -> END
      WHEN OTHERS.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.
* RW ID 14654 - END

ENDMETHOD.


METHOD value_request_ditxt .

*  DATA: lt_field_values          TYPE ish_t_field_value,
*        l_wa_field_value_ditxt   TYPE rnfield_value,
*        l_rc                     TYPE ish_method_rc,
*        l_einri                  TYPE einri,
*        l_selected               TYPE ish_on_off,
*        l_nothing_selected       TYPE ish_on_off,
*        l_not_found              TYPE ish_on_off,
*        l_vcode                  TYPE vcode,
*        l_done                   TYPE c,
*        l_patnr                  TYPE npat-patnr,
*        ls_n1corder              TYPE n1corder,
**        ls_nkdi                  TYPE nkdi,
*        l_ditxt                  TYPE ndia-ditxt,
*        lt_cordpos               TYPE ish_t_cordpos,
*        l_wa_cordpos             TYPE REF TO cl_ishmed_prereg,
*        l_falnr                  TYPE rnrangefalnr,
*        lt_falnr                 TYPE rnrangefalnr_tt,
*        l_field                  TYPE nfal-falnr,
*        lt_diag                  TYPE ish_objectlist.
*
** object references
*  DATA: lr_lb_object             TYPE REF TO cl_ish_listbox,
*        lr_corder                TYPE REF TO cl_ish_corder.
*
** get main object -> check if clinical order
*  IF gr_main_object->is_inherited_from(
*      cl_ish_corder=>co_otype_corder ) = 'X'.
*    lr_corder ?= gr_main_object.
*  ENDIF.
*
*  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
*  IF l_einri IS INITIAL.
*    EXIT.
*  ENDIF.
*
** Initializations.
*  e_rc       = 0.
*  e_selected = off.
*  e_called   = off.
*
*  CALL METHOD me->get_fields
*    IMPORTING
*      et_field_values = lt_field_values
*      e_rc            = e_rc
*    CHANGING
*      c_errorhandler  = cr_errorhandler.
*  CHECK e_rc = 0.
*  READ TABLE lt_field_values INTO l_wa_field_value_ditxt
*     WITH KEY fieldname = g_fieldname_ditxt.
*  CHECK sy-subrc EQ 0.
*
** get the patient from main object
*  CHECK NOT lr_corder IS INITIAL.
*  CALL METHOD lr_corder->get_data
*    EXPORTING
*      i_fill          = off
*    IMPORTING
*      es_n1corder     = ls_n1corder
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  l_patnr = ls_n1corder-patnr.
*
** the working code
*  l_vcode = co_vcode_update.
*  IF g_vcode = co_vcode_display.
*    l_vcode = g_vcode.
*  ENDIF.
*
** get all FALNR from the cordpos
*  CALL METHOD lr_corder->get_t_cordpos
*    EXPORTING
*      i_cancelled_datas = off
*      ir_environment    = gr_environment
*    IMPORTING
*      et_cordpos        = lt_cordpos
*      e_rc              = e_rc
*    CHANGING
*      cr_errorhandler   = cr_errorhandler.
*  CHECK e_rc = 0.
*  LOOP AT lt_cordpos INTO l_wa_cordpos.
*    CLEAR: l_falnr, l_field, l_rc.
*    CALL METHOD l_wa_cordpos->get_data_field
*      EXPORTING
*        i_fieldname     = 'FALNR'
*      IMPORTING
*        e_rc            = l_rc
*        e_field         = l_field
*        e_fld_not_found = l_not_found
*      CHANGING
*        c_errorhandler  = cr_errorhandler.
*    IF l_rc <> 0.
*      e_rc = l_rc.
*      EXIT.
*    ENDIF.
*    IF l_not_found = off AND NOT l_field IS INITIAL.
*      l_falnr-low = l_field.
*      l_falnr-sign = 'I'.
*      l_falnr-option = 'EQ'.
*      APPEND l_falnr TO lt_falnr.
*    ENDIF.
*  ENDLOOP.
*
** Get corder's diagnosis objects.
*  CALL METHOD cl_ish_corder=>get_diagnosis_for_corder
*    EXPORTING
*      ir_corder       = lr_corder
*      ir_environment  = gr_environment
*    IMPORTING
*      e_rc            = e_rc
*      et_diagnosis    = lt_diag
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*  CHECK lt_diag[] IS INITIAL.
*
*  CALL FUNCTION 'ISH_N2_SHOW_VDIAPAT'
*    EXPORTING
*      ss_einri          = l_einri
*      ss_patnr          = l_patnr
*      ss_vcode          = l_vcode
*      ir_rnrangefalnr   = lt_falnr
*    IMPORTING
**      e_diagnose        = ls_nkdi
*      e_ditxt           = l_ditxt
*    EXCEPTIONS
*      not_found         = 1
*      OTHERS            = 2.
*  e_rc = sy-subrc.
*  e_called = on.
*  CHECK e_rc = 0.
*
*  IF NOT l_ditxt IS INITIAL.
*    l_selected = on.
*  ENDIF.
*
** Selected?
*  e_selected = l_selected.
*
*  CHECK e_selected = on.
*
** set the value
*  e_value = l_ditxt.

ENDMETHOD.


METHOD value_request_internal .

* Initializations.
  CLEAR: e_rc.

  CASE i_fieldname.
    WHEN g_fieldname_ditxt.
*      CALL METHOD value_request_ditxt
*        IMPORTING
*          e_called        = e_called
*          e_selected      = e_selected
*          e_value         = e_value
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
  ENDCASE.

ENDMETHOD.
ENDCLASS.
