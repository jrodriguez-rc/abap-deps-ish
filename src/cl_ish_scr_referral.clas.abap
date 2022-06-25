class CL_ISH_SCR_REFERRAL definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_REFERRAL
*"* do not include other source files here!!!
public section.

  class-data G_PREFIX_FIELDNAME type ISH_FIELDNAME read-only value 'RN1_DYNP_REFERRAL' ##NO_TEXT.
  constants CO_DEFAULT_TABNAME type TABNAME value 'N1VKG' ##NO_TEXT.
  class-data G_FIELDNAME_RFSRC type ISH_FIELDNAME .
  class-data G_FIELDNAME_EXTKH type ISH_FIELDNAME .
  class-data G_FIELDNAME_EARNR type ISH_FIELDNAME .
  class-data G_FIELDNAME_HARNR type ISH_FIELDNAME .
  class-data G_FIELDNAME_UARNR type ISH_FIELDNAME .
  constants CO_OTYPE_SCR_REFERRAL type ISH_OBJECT_TYPE value 7023 ##NO_TEXT.
  data GS_SAVED_RFSRC type VRM_VALUE .             "IXX-239: NPopa 4.11.2014

  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_REFERRAL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods MODIFY_SCREEN_ATT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~CHECK
    redefinition .
  methods IF_ISH_SCREEN~CREATE_ALL_LISTBOXES
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_REFERRAL
*"* do not include other source files here!!!

  class-data G_FIELDNAME_KHANS type ISH_FIELDNAME .
  class-data G_FIELDNAME_HAANS type ISH_FIELDNAME .
  class-data G_FIELDNAME_EAANS type ISH_FIELDNAME .
  class-data G_FIELDNAME_UAANS type ISH_FIELDNAME .

  methods CREATE_LISTBOX_RFSRC
    exporting
      value(ER_LB_OBJECT) type ref to CL_ISH_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_KHANS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CR_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING .
  methods VALUE_REQUEST_EXTKH
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods VALUE_REQUEST_EARNR
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods VALUE_REQUEST_HARNR
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_HAANS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_EAANS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_UAANS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods VALUE_REQUEST_UARNR
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_BEWTY
    exporting
      value(E_BEWTY) type NBEW-BEWTY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CORDPOS
    returning
      value(RR_CORDPOS) type ref to CL_ISHMED_PREREG .

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
*"* private components of class CL_ISH_SCR_REFERRAL
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_REFERRAL IMPLEMENTATION.


METHOD build_message .

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
  ENDCASE.

ENDMETHOD.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_default_tabname.
  GET REFERENCE OF co_default_tabname INTO gr_default_tabname.

* Initialize fieldnames.
  g_fieldname_rfsrc = 'RN1_DYNP_REFERRAL-RFSRC'.
  g_fieldname_extkh = 'RN1_DYNP_REFERRAL-EXTKH'.
  g_fieldname_earnr = 'RN1_DYNP_REFERRAL-EARNR'.
  g_fieldname_harnr = 'RN1_DYNP_REFERRAL-HARNR'.
  g_fieldname_khans = 'RN1_DYNP_REFERRAL-KHANS'.
  g_fieldname_haans = 'RN1_DYNP_REFERRAL-HAANS'.
  g_fieldname_eaans = 'RN1_DYNP_REFERRAL-EAANS'.
  g_fieldname_uaans = 'RN1_DYNP_REFERRAL-UAANS'.
  g_fieldname_uarnr = 'RN1_DYNP_REFERRAL-UARNR'.

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
        i_mv1           = 'CL_ISH_SCR_REFERRAL'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD create_listbox_internal .

* Initializations
  CLEAR: e_rc.

  CASE i_fieldname.
    WHEN g_fieldname_rfsrc.
      CALL METHOD create_listbox_rfsrc
        IMPORTING
          er_lb_object    = er_lb_object
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
  ENDCASE.

ENDMETHOD.


METHOD create_listbox_rfsrc .

* definition
  DATA: l_flag            TYPE ish_on_off,
        l_fieldname_rfsrc TYPE vrm_id,
        l_falar           TYPE fallart,
        l_bewty           TYPE bewty,
        lt_fieldvalues    TYPE ish_t_field_value,
        l_wa_fieldvalue   TYPE rnfield_value,
        l_vrm_value       TYPE vrm_value-key,
        l_vrm_id          TYPE vrm_id,
        l_einri           TYPE einri,
        l_rfsrc           TYPE n1vkg-rfsrc,
*BEGIN IXX-239 Madalina P. 05.11.2014
        lr_prereg         TYPE REF TO cl_ishmed_prereg,
        lt_vrm_values     TYPE vrm_values,
        ls_n1vkg          TYPE n1vkg,
        ls_tn14y          TYPE tn14y.
*END IXX-239

* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

  CLEAR: er_lb_object, e_rc.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.
* -----------------------------------------
* get the bewty
  CALL METHOD me->get_bewty
    IMPORTING
      e_bewty         = l_bewty
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
* -----------------------------------------
* get the fields
  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_fieldvalues
      e_rc            = e_rc.

  READ TABLE lt_fieldvalues INTO l_wa_fieldvalue
     WITH KEY fieldname = g_fieldname_rfsrc.
  l_vrm_value = l_wa_fieldvalue-value.
  l_rfsrc     = l_vrm_value.
* ---------- ---------- ----------
  l_vrm_id = g_fieldname_rfsrc.
  CALL METHOD cl_ish_lb_rfsrc=>fill_listbox
    EXPORTING
      i_fieldname  = l_vrm_id
      i_einri      = l_einri
      i_bewty      = l_bewty
      i_rfsrc      = l_rfsrc
    IMPORTING
      e_rc         = e_rc
      er_lb_object = lr_lb_object.
  CHECK NOT lr_lb_object IS INITIAL.
* ---------- ---------- ----------

*BEGIN OF IXX-239: Madalina P. 05.11.2014

* Get corresponding cordpos.
  lr_prereg = get_cordpos( ).
  CHECK NOT lr_prereg IS INITIAL.

* Read the database value for rfsrc and set it into the buffer structure gs_saved_rfsrc
  IF gs_saved_rfsrc IS INITIAL.
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

*   If the order position has a referral type then set the buffer structure, otherwise it will remain empty.
    IF ls_n1vkg-rfsrc IS NOT INITIAL.
      SELECT SINGLE * FROM tn14y INTO ls_tn14y WHERE spras = sy-langu AND einri = l_einri AND refsrc = ls_n1vkg-rfsrc.
      gs_saved_rfsrc-key = ls_n1vkg-rfsrc.
      gs_saved_rfsrc-text = ls_tn14y-refsrctxt.
    ENDIF.
  ENDIF.

* If there is a SAVED referral type for the order position but it has been customized as an inactive referral type,
* then it won't be in the dropdown table of values and should be added manually to the list
  IF gs_saved_rfsrc IS NOT INITIAL.
    lt_vrm_values = lr_lb_object->get_vrm_values( ).

    READ TABLE lt_vrm_values WITH KEY key = gs_saved_rfsrc-key TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      APPEND gs_saved_rfsrc TO lt_vrm_values.

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
*END OF IXX-239

* Export listbox object
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD FILL_ALL_LABELS .

* Initializations
  CLEAR: e_rc.

* KHANS
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_khans
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* HAANS
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_haans
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* EAANS
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_eaans
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* UAANS
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_uaans
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD fill_label_eaans .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_earnr TYPE rnfield_value,
        l_wa_field_value_eaans TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_gpart TYPE gpartner,
        l_value TYPE text50.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_earnr
     WITH KEY fieldname = g_fieldname_earnr.
  e_rc = sy-subrc.
  CHECK e_rc = 0.
  l_gpart = l_wa_field_value_earnr-value.
  IF NOT l_gpart IS INITIAL. "ED, ID 17974
    CALL METHOD cl_ish_utl_base_descr=>get_descr_khans
      EXPORTING
        i_gpart         = l_gpart
      IMPORTING
        e_khans         = l_value
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
  ENDIF. "ED, ID 17974

  l_wa_field_value_eaans-value = l_value.

  MODIFY lt_field_values FROM l_wa_field_value_eaans
    TRANSPORTING value WHERE fieldname = g_fieldname_eaans.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_haans .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_harnr TYPE rnfield_value,
        l_wa_field_value_haans TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_gpart TYPE gpartner,
        l_value TYPE text50.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_harnr
     WITH KEY fieldname = g_fieldname_harnr.
  e_rc = sy-subrc.
  CHECK e_rc = 0.
  l_gpart = l_wa_field_value_harnr-value.
  IF NOT l_gpart IS INITIAL. "ED, ID 17974
    CALL METHOD cl_ish_utl_base_descr=>get_descr_khans
      EXPORTING
        i_gpart         = l_gpart
      IMPORTING
        e_khans         = l_value
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
  ENDIF. "ED, ID 17974

  l_wa_field_value_haans-value = l_value.

  MODIFY lt_field_values FROM l_wa_field_value_haans
    TRANSPORTING value WHERE fieldname = g_fieldname_haans.

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
* KHANS
    WHEN g_fieldname_khans.
      CALL METHOD fill_label_khans
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
* HAANS
    WHEN g_fieldname_haans.
      CALL METHOD fill_label_haans
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
* EAANS
    WHEN g_fieldname_eaans.
      CALL METHOD fill_label_eaans
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
* UAANS
    WHEN g_fieldname_uaans.
      CALL METHOD fill_label_uaans
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
  ENDCASE.

ENDMETHOD.


METHOD fill_label_khans .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_extkh TYPE rnfield_value,
        l_wa_field_value_khans TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_extkh TYPE extkh,
        l_khans TYPE khadr_50.
* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_extkh
     WITH KEY fieldname = g_fieldname_extkh.
  e_rc = sy-subrc.
  CHECK e_rc = 0.
  l_extkh = l_wa_field_value_extkh-value.
  IF NOT l_extkh IS INITIAL. "ED, ID 17974
    CALL METHOD cl_ish_utl_base_descr=>get_descr_khans
      EXPORTING
        i_gpart         = l_extkh
*    I_ROLLE         = '5'
      IMPORTING
        e_khans         = l_khans
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
  ENDIF. "ED, ID 17974

  l_wa_field_value_khans-value = l_khans.

  MODIFY lt_field_values FROM l_wa_field_value_khans
    TRANSPORTING value WHERE fieldname = g_fieldname_khans.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_uaans .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_uarnr TYPE rnfield_value,
        l_wa_field_value_uaans TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_gpart TYPE gpartner,
        l_value TYPE text50.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_uarnr
     WITH KEY fieldname = g_fieldname_uarnr.
  e_rc = sy-subrc.
  CHECK e_rc = 0.
  l_gpart = l_wa_field_value_uarnr-value.
  IF NOT l_gpart IS INITIAL. "ED, ID 17974
    CALL METHOD cl_ish_utl_base_descr=>get_descr_khans
      EXPORTING
        i_gpart         = l_gpart
      IMPORTING
        e_khans         = l_value
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK l_rc = 0.
  ENDIF. "ED, ID 17974

  l_wa_field_value_uaans-value = l_value.

  MODIFY lt_field_values FROM l_wa_field_value_uaans
    TRANSPORTING value WHERE fieldname = g_fieldname_uaans.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_t_scrm_field .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* rfsrc
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_rfsrc.
  ls_scrm_field-fieldlabel = 'Einweisungsart/Überweisungsart'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

* earnr
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_earnr.
  ls_scrm_field-fieldlabel = 'Einweis. Arzt'(004).
  APPEND ls_scrm_field TO gt_scrm_field.

* uarnr
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_uarnr.
  ls_scrm_field-fieldlabel = 'Überweis. Arzt'(005).
  APPEND ls_scrm_field TO gt_scrm_field.

* harnr
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_harnr.
  ls_scrm_field-fieldlabel = 'Hausarzt'(007).
  APPEND ls_scrm_field TO gt_scrm_field.

* extkh
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_extkh.
  ls_scrm_field-fieldlabel = 'Einweis./Überweis. KH'(010).
  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD get_bewty .

  DATA: lr_cordpos            TYPE REF TO cl_ishmed_prereg.

  CLEAR: e_rc, e_bewty.

* Get cordpos
  lr_cordpos = get_cordpos( ).
  CHECK NOT lr_cordpos IS INITIAL.

* Get bewty
  e_bewty = lr_cordpos->get_bewty( ).
  IF e_bewty IS INITIAL.
*   set as default admission
    e_bewty = '1'.
  ENDIF.

ENDMETHOD.


METHOD get_cordpos .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.

  rr_cordpos ?= gr_main_object.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_scr_referral.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_referral.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off. ID-16230
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~check.

* ED, ID 18427: check with special mandatory preferences -> BEGIN
  DATA: lr_cordpos       TYPE REF TO cl_ishmed_prereg,
        l_fieldname      TYPE ish_fieldname,
        l_parameter      TYPE bapi_param,
        l_field          TYPE bapi_fld,
        lt_msg           TYPE ishmed_t_messages,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_msg>  TYPE rn1message.

  e_rc = 0.

  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Let the super class do the checks.
  CALL METHOD super->if_ish_screen~check
    EXPORTING
      i_check_mandatory_fields = i_check_mandatory_fields
      i_check_field_values     = i_check_field_values
    IMPORTING
      e_rc                     = l_rc
    CHANGING
      cr_errorhandler          = lr_errorhandler.
* Further processing only if there are errors.
  CHECK NOT l_rc = 0.

* Get the cordpos object.
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ishmed_prereg=>co_otype_prereg ) = on.
  lr_cordpos ?= gr_main_object.

* Get the fielname which errors have to be eliminated.
*   - adm_pos have no uarnr,
*   - amb_pos have no earnr.
  IF lr_cordpos->is_adm_pos( ) = on.
    l_fieldname = g_fieldname_uarnr.
  ELSE.
    l_fieldname = g_fieldname_earnr.
  ENDIF.
  SPLIT l_fieldname
    AT   '-'
    INTO l_parameter
         l_field.

* Get the messages from the local errorhandler.
  CALL METHOD lr_errorhandler->get_messages
    IMPORTING
      t_extended_msg = lt_msg.

* Eliminate errors for l_fieldname.
  LOOP AT lt_msg ASSIGNING <ls_msg>.
    CHECK <ls_msg>-parameter = l_parameter.
    CHECK <ls_msg>-field     = l_field.
    DELETE lt_msg.
  ENDLOOP.

* Further processing only if there are any errors left.
  CHECK NOT lt_msg IS INITIAL.

* There are errors -> set e_rc + cr_errorhandler.
  e_rc = 1.
  CALL METHOD cr_errorhandler->collect_messages
    EXPORTING
      t_messages = lt_msg
      i_last     = space.
* ED, ID 18427 -> END

ENDMETHOD.


METHOD if_ish_screen~create_all_listboxes .

* RFSRC
  CALL METHOD create_listbox
    EXPORTING
      i_fieldname     = g_fieldname_rfsrc
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

  DATA: l_rc TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

  CALL FUNCTION 'ISH_SDY_REFERRAL_INIT'
    EXPORTING
      ir_scr_referral = me
    IMPORTING
      es_parent       = gs_parent
      e_rc            = l_rc
    CHANGING
      cr_dynp_data    = gr_scr_data
      cr_errorhandler = lr_errorhandler.

ENDMETHOD.


METHOD INITIALIZE_FIELD_VALUES .
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
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-RFSRC'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-EXTKH'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-EARNR'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-HARNR'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-UARNR'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-KHANS'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-HAANS'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-EAANS'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_REFERRAL-UAANS'.
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

* SET THE GLOBAL FIELD VALUES
  g_fieldname_rfsrc = 'RN1_DYNP_REFERRAL-RFSRC'.
  g_fieldname_extkh = 'RN1_DYNP_REFERRAL-EXTKH'.
  g_fieldname_earnr = 'RN1_DYNP_REFERRAL-EARNR'.
  g_fieldname_harnr = 'RN1_DYNP_REFERRAL-HARNR'.
  g_fieldname_khans = 'RN1_DYNP_REFERRAL-KHANS'.
  g_fieldname_haans = 'RN1_DYNP_REFERRAL-HAANS'.
  g_fieldname_eaans = 'RN1_DYNP_REFERRAL-EAANS'.
  g_fieldname_uaans = 'RN1_DYNP_REFERRAL-UAANS'.
  g_fieldname_uarnr = 'RN1_DYNP_REFERRAL-UARNR'.

ENDMETHOD.


METHOD initialize_parent .

  DATA: l_bewty TYPE nbew-bewty.

  CLEAR: gs_parent, e_rc.

* get the bewty
  CALL METHOD me->get_bewty
    IMPORTING
      e_bewty         = l_bewty
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

* if 1 -> call dynpro 0100 -> elseif 4 -> call 0200
  gs_parent-repid = 'SAPLN1_SDY_REFERRAL'.
  IF l_bewty = '1'.
    gs_parent-dynnr = '0100'.
  ELSEIF l_bewty = '4'.
    gs_parent-dynnr = '0200'.
  ELSE.
    e_rc = 1. "it must not be!!
  ENDIF.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD modify_screen_att .
  "MED-53644,AM

  DATA: l_uarnr_active TYPE char1.
  DATA: l_harnr_active TYPE char1.
  DATA: l_extkh_active TYPE char1.
  DATA: l_earnr_active TYPE char1.

  LOOP AT SCREEN.
    IF screen-name = g_fieldname_extkh.
      l_extkh_active = screen-active.
    ENDIF.
    IF screen-name = g_fieldname_harnr.
      l_harnr_active = screen-active.
    ENDIF.
    IF screen-name = g_fieldname_uarnr.
      l_uarnr_active = screen-active.
    ENDIF.
    IF screen-name = g_fieldname_earnr.
      l_earnr_active = screen-active.
    ENDIF.
  ENDLOOP.

  LOOP AT SCREEN.
    IF g_vcode = co_vcode_display.
      screen-input = false.
      MODIFY SCREEN.
    ELSE.
      IF screen-name = g_fieldname_haans AND l_harnr_active = false.
        screen-active = false.
        MODIFY SCREEN.
      ELSEIF screen-name = g_fieldname_uaans AND l_uarnr_active = false.
        screen-active = false.
        MODIFY SCREEN.
      ELSEIF screen-name = g_fieldname_khans AND l_extkh_active = false.
        screen-active = false.
        MODIFY SCREEN.
      ELSEIF screen-name = g_fieldname_eaans AND l_earnr_active = false.
        screen-active = false.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.
  "END MED-53644,AM

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
*        lt_screen TYPE ishmed_t_screen.
** object references
*  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.
*
*  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
*  IF l_einri IS INITIAL.
*    EXIT.
*  ENDIF.
*
** TNDYN-Modifikationen einlesen
*  CALL METHOD me->get_dynpro
*    IMPORTING
*      e_pgm   = l_repid
*      e_dynnr = l_dynnr.
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
*     WITH KEY fieldname = g_fieldname_falar.
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
*    IF l_screen-name = g_fieldname_bewar.
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


method MODIFY_SCREEN_INTERNAL .

clear: e_rc.

CALL METHOD me->modify_screen_att
  IMPORTING
    E_rc            = e_rc
  CHANGING
    cr_errorhandler = cr_errorhandler.

endmethod.


METHOD value_request_earnr .

  DATA: l_value(60)    TYPE c,
        l_gpart        TYPE gpartner,
        l_selected     TYPE true,
        l_vcode        TYPE ish_vcode.

* Initializations
  e_rc      = 0.
  e_called  = off.
  e_selected = off.

  l_vcode = g_vcode.
  IF g_vcode EQ co_vcode_display.
    CLEAR l_vcode.
  ENDIF.
  CALL FUNCTION 'ISH_SHOW_GPART'
    EXPORTING
      aufruf      = 'Y'
      rolle       = '1'
      row         = 10
      col         = 13
      vcode       = l_vcode
      arzt        = on
    IMPORTING
      ngpa_gpart  = l_gpart
      select_ngpa = l_selected
    EXCEPTIONS
      einri_false = 1
      gschl_false = 2
      ktart_false = 3
      not_found   = 4
      OTHERS      = 5.
  e_rc = sy-subrc.
* Errorhandling
  IF e_rc <> 0.
*   there is no input possible
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'S'
        i_kla           = 'N1'
        i_num           = '503'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.
  IF l_selected = true AND NOT l_gpart IS INITIAL.
    MOVE l_gpart TO l_value.
  ENDIF.
* F4 has been called
  e_called   = on.

* Entry selected.
  IF l_selected = true.
    e_selected = on.
  ENDIF.

* Nothing selected?
  CHECK e_selected = on.

* Export selected value
  e_value = l_value.

ENDMETHOD.


METHOD value_request_extkh .

  DATA: lt_field_values        TYPE ish_t_field_value,
        l_wa_field_value_extkh TYPE rnfield_value,
        l_rc                   TYPE ish_method_rc,
        l_value(60)            TYPE c,
        l_extkh                TYPE gpartner,
        l_gpart                TYPE gpartner,
        l_selected             LIKE true,
        l_vcode                LIKE g_vcode.                " ID 18264

* Initializations
  e_rc      = 0.
  e_called  = off.
  e_selected = off.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_extkh
     WITH KEY fieldname = g_fieldname_extkh.
  e_rc = sy-subrc.
  CHECK e_rc EQ 0.
  l_extkh = l_wa_field_value_extkh-value.
* ID 18264: Begin of INSERT
  IF g_vcode = co_vcode_display.
    l_vcode = co_vcode_display.
  ELSE.
    l_vcode = co_vcode_update.
  ENDIF.
* ID 18264: End of INSERT
  CALL FUNCTION 'ISH_SHOW_GPART'
    EXPORTING
      aufruf      = yes
      rolle       = '5'
      vcode       = l_vcode          " g_vcode " ID 18264
    IMPORTING
      ngpa_gpart  = l_gpart
      select_ngpa = l_selected.
  IF l_selected EQ true AND
     NOT g_vcode IS INITIAL.
    MOVE l_gpart TO l_extkh.
    MOVE l_extkh TO l_value.
  ENDIF.
  e_rc = sy-subrc.
* F4 has been called
  e_called   = on.

* Errorhandling
  IF e_rc <> 0.
*   there is no input possible
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'S'
        i_kla           = 'N1'
        i_num           = '503'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.
* Entry selected.
  IF l_selected = true.
    e_selected = on.
  ENDIF.

* Nothing selected?
  CHECK e_selected = on.

* Export selected value
  e_value = l_value.

ENDMETHOD.


METHOD value_request_harnr .

  CALL METHOD me->value_request_earnr
    IMPORTING
      e_selected      = e_selected
      e_called        = e_called
      e_value         = e_value
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD value_request_internal .

* Initializations.
  CLEAR: e_rc.

  CASE i_fieldname.
* the extern clinic
    WHEN g_fieldname_extkh.
      CALL METHOD value_request_extkh
        IMPORTING
          e_called        = e_called
          e_selected      = e_selected
          e_value         = e_value
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
* the referring physician
    WHEN g_fieldname_earnr.
      CALL METHOD value_request_earnr
        IMPORTING
          e_called        = e_called
          e_selected      = e_selected
          e_value         = e_value
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
* the family physician
    WHEN g_fieldname_harnr.
    call method value_request_harnr
      importing
        e_called        = e_called
        e_selected      = e_selected
        e_value         = e_value
        e_rc            = e_rc
      changing
        cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
* the visit physician
    WHEN g_fieldname_uarnr.
    call method value_request_uarnr
      importing
        e_called        = e_called
        e_selected      = e_selected
        e_value         = e_value
        e_rc            = e_rc
      changing
        cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
  ENDCASE.

ENDMETHOD.


METHOD value_request_uarnr .

  CALL METHOD me->value_request_earnr
    IMPORTING
      e_selected      = e_selected
      e_called        = e_called
      e_value         = e_value
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.
ENDCLASS.
