class CL_ISH_SCR_INSURANCE definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_INSURANCE
*"* do not include other source files here!!!
public section.

  class-data G_PREFIX_FIELDNAME type ISH_FIELDNAME read-only value 'RNIPP3_ATTRIB' .
  class-data G_PREFIX_FIELDNAME_1 type ISH_FIELDNAME read-only value 'RNIPP_ATTRIB' .
  class-data G_PREFIX_FIELDNAME_2 type ISH_FIELDNAME read-only value 'RNIPP2_ATTRIB' .
  constants CO_DEFAULT_TABNAME type TABNAME value 'NIPP'. "#EC NOTEXT
  class-data G_FIELDNAME_IPID_1 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_IPID_2 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_KNAME type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_KNAME_1 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_KNAME_2 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_KVDAT_1 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_KVDAT_2 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_MGART_1 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_MGART_2 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_VERBI_1 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_VERBI_2 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_VNUMM_1 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_VNUMM_2 type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_VZUZA type ISH_FIELDNAME read-only .
  data GR_INSURANCE_SUBSCREEN type ref to CL_ISH_SUB_INSURANCE_POLICY_CO .
  data GR_CANCEL type ref to CL_ISH_CANCEL .
  data GR_POLICY1 type ref to CL_ISH_INSURANCE_POLICY_PROV .
  data GR_POLICY2 type ref to CL_ISH_INSURANCE_POLICY_PROV .
  data GR_POLICY3 type ref to CL_ISH_INSURANCE_POLICY_PROV .
  constants CO_OTYPE_SCR_INSURANCE type ISH_OBJECT_TYPE value 7040. "#EC NOTEXT

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_INSURANCE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DYNPRO_INSURANCE
    exporting
      value(E_PGM_INSURANCE) type SY-REPID
      value(E_DYNNR_INSURANCE) type SY-DYNNR .
  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_A
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_DEFINITION
    redefinition .
  methods IF_ISH_SCREEN~GET_FIELDS_VALUE
    redefinition .
  methods IF_ISH_SCREEN~IS_FIELD_INITIAL
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_FROM_DY
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_INSURANCE
*"* do not include other source files here!!!

  data G_PGM_INSURANCE type SY-REPID .
  data G_DYNNR_INSURANCE type SY-DYNNR .

  methods BUILD_MESSAGE
    redefinition .
  methods FILL_T_SCRM_FIELD
    redefinition .
  methods GET_CDOC_TABKEY
    redefinition .
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_INSURANCE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_INSURANCE IMPLEMENTATION.


METHOD build_message .

* Call super method.
  CALL METHOD super->build_message
    EXPORTING
      is_message    = is_message
      i_cursorfield = i_cursorfield
    IMPORTING
      es_message    = es_message.

* Wrap es_message-parameter.
  CASE es_message-parameter.
    WHEN 'NIPP'.
      CASE es_message-object.
        WHEN gr_policy1.
          es_message-parameter = g_prefix_fieldname_1.
        WHEN gr_policy2.
          es_message-parameter = g_prefix_fieldname_2.
        WHEN gr_policy3.
          es_message-parameter = g_prefix_fieldname.
        WHEN OTHERS.
          CLEAR: es_message-parameter,
                 es_message-field.
      ENDCASE.
  ENDCASE.

* set cursor
  CALL METHOD gr_insurance_subscreen->set_cursor
    CHANGING
      C_RN1MESSAGE = is_message.

ENDMETHOD.


METHOD class_constructor .

* Set fieldnames
  g_fieldname_vzuza   = 'RNIPP3_ATTRIB-VZUZA'.
  g_fieldname_kname   = 'RNIPP3_ATTRIB-KNAME'.

  g_fieldname_ipid_1  = 'RNIPP_ATTRIB-IPID'.
  g_fieldname_kname_1 = 'RNIPP_ATTRIB-KNAME'.
  g_fieldname_kvdat_1 = 'RNIPP_ATTRIB-KVDAT'.
  g_fieldname_mgart_1 = 'RNIPP_ATTRIB-MGART'.
  g_fieldname_verbi_1 = 'RNIPP_ATTRIB-VERBI'.
  g_fieldname_vnumm_1 = 'RNIPP_ATTRIB-VNUMM'.

  g_fieldname_ipid_2  = 'RNIPP2_ATTRIB-IPID'.
  g_fieldname_kname_2 = 'RNIPP2_ATTRIB-KNAME'.
  g_fieldname_kvdat_2 = 'RNIPP2_ATTRIB-KVDAT'.
  g_fieldname_mgart_2 = 'RNIPP2_ATTRIB-MGART'.
  g_fieldname_verbi_2 = 'RNIPP2_ATTRIB-VERBI'.
  g_fieldname_vnumm_2 = 'RNIPP2_ATTRIB-VNUMM'.

ENDMETHOD.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_default_tabname.
  GET REFERENCE OF co_default_tabname INTO gr_default_tabname.

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
        i_mv1           = 'CL_ISH_SCR_INSURANCE'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD fill_t_scrm_field .

  DATA: ls_scrm_field  TYPE rn1_scrm_field.

  REFRESH gt_scrm_field.

* vzuza
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_vzuza.
  ls_scrm_field-fieldlabel = 'Selbst-/Zuz.'(001).
  APPEND ls_scrm_field TO gt_scrm_field.

* ipid_1
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_ipid_1.
  ls_scrm_field-fieldlabel = 'Krankenkasse'(002).
  APPEND ls_scrm_field TO gt_scrm_field.

* kname_1
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_kname_1.
  ls_scrm_field-fieldlabel = 'Krankenkasse (Name)'(006).
  APPEND ls_scrm_field TO gt_scrm_field.

* mgart_1
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_mgart_1.
  ls_scrm_field-fieldlabel = 'Mitgliedsart'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

* vnumm_1
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_vnumm_1.
  ls_scrm_field-fieldlabel = 'VersNummer'(004).
  APPEND ls_scrm_field TO gt_scrm_field.

* verbi_1
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_verbi_1.
  ls_scrm_field-fieldlabel = 'Vers.bis'(005).
  APPEND ls_scrm_field TO gt_scrm_field.

* ipid_2
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_ipid_2.
  ls_scrm_field-fieldlabel = 'Krankenkasse'(002).
  APPEND ls_scrm_field TO gt_scrm_field.

* kname_2
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_kname_2.
  ls_scrm_field-fieldlabel = 'Krankenkasse (Name)'(006).
  APPEND ls_scrm_field TO gt_scrm_field.

* mgart_2
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_mgart_2.
  ls_scrm_field-fieldlabel = 'Mitgliedsart'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

* vnumm_2
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_vnumm_2.
  ls_scrm_field-fieldlabel = 'VersNummer'(004).
  APPEND ls_scrm_field TO gt_scrm_field.

* verbi_2
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_verbi_2.
  ls_scrm_field-fieldlabel = 'Vers.bis'(005).
  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD get_cdoc_tabkey .

  DATA: lr_policy      TYPE REF TO cl_ish_insurance_policy_prov,
        l_key          TYPE string,
        l_fnam_prefix  TYPE string,
        l_rest         TYPE string.

* Initializations.
  CLEAR r_tabkey.

  CHECK NOT i_fnam_screen IS INITIAL.

* Which policy object to use depends on the fieldname prefix.
  SPLIT i_fnam_screen
    AT '-'
    INTO l_fnam_prefix
         l_rest.
  CLEAR lr_policy.
  CASE l_fnam_prefix.
    WHEN 'RNIPP_ATTRIB'.
      lr_policy = gr_policy1.
    WHEN 'RNIPP2_ATTRIB'.
      lr_policy = gr_policy2.
    WHEN 'RNIPP3_ATTRIB'.
      lr_policy = gr_policy3.
  ENDCASE.

  CHECK NOT lr_policy IS INITIAL.

* Get key.
  CALL METHOD lr_policy->get_key_string
    IMPORTING
      e_key = l_key.

* Export.
  r_tabkey = l_key.

ENDMETHOD.


METHOD get_corder .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.

  rr_corder ?= gr_main_object.

ENDMETHOD.


METHOD get_dynpro_insurance .

  e_pgm_insurance = g_pgm_insurance.
  e_dynnr_insurance = g_dynnr_insurance.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_scr_insurance.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

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
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_scr_insurance.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off. ID-16230
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~get_fields_definition .

  DATA: ls_parent  TYPE rnscr_parent.

* Use the old subscreen's dynpro.
  ls_parent = gs_parent.
  gs_parent-repid = g_pgm_insurance.
  gs_parent-dynnr = g_dynnr_insurance.

* Call super method.
  CALL METHOD super->if_ish_screen~get_fields_definition
    IMPORTING
      et_fields_definition = et_fields_definition
      e_rc                 = e_rc
    CHANGING
      c_errorhandler       = c_errorhandler.

* Reset gs_parent.
  gs_parent = ls_parent.

ENDMETHOD.


METHOD if_ish_screen~get_fields_value.

** ED, int. M. 0120061532 0001261428 2005 -> BEGIN
*  DATA:          lt_fielddef          TYPE dyfatc_tab,
*                 lt_field_values      TYPE ish_t_field_value,
*                 lt_fields_value      TYPE ish_t_screen_fields,
*                 ls_fields_value      LIKE LINE OF lt_fields_value,
*                 l_rc                 TYPE ish_method_rc.
*
*  FIELD-SYMBOLS: <ls_fielddef>        TYPE rpy_dyfatc,
*                 <ls_field_values>    TYPE rnfield_value,
*                 <ls_fields_value>    TYPE rn1_screen_fields.
*
** Init
*  e_rc = 0.
*
** Check/create errorhandler
*  IF cr_errorhandler IS INITIAL.
*    CREATE OBJECT cr_errorhandler.
*  ENDIF.
*
** Get field values
*  CALL METHOD me->get_fields
**  EXPORTING
**    I_CONV_TO_EXTERN = SPACE
*    IMPORTING
*      et_field_values  = lt_field_values
*      e_rc             = e_rc
*   CHANGING
*    c_errorhandler     = cr_errorhandler.
*
** Loop field values
*  LOOP AT lt_field_values ASSIGNING <ls_field_values>.
*    CLEAR ls_fields_value.
**    CASE <ls_field_values>-fieldname.
**      WHEN xxx.
**    ENDCASE.
*  ENDLOOP.
** ED, int. M. 0120061532 0001261428 2005 -> END

ENDMETHOD.


METHOD if_ish_screen~is_field_initial.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
  DATA: lt_fields_value TYPE ish_t_screen_fields,
        ls_fields_value LIKE LINE OF lt_fields_value,
        l_rc            TYPE ish_method_rc.

* first check normal fields
  CALL METHOD super->if_ish_screen~is_field_initial
    EXPORTING
      i_fieldname = i_fieldname
      i_rownumber = i_rownumber
    RECEIVING
      r_initial   = r_initial.

  CHECK r_initial = on.
* now check subscreen fields
  CALL METHOD me->get_fields_value
*    EXPORTING
*      I_CONV_TO_EXTERN = SPACE
    IMPORTING
      et_fields_value  = lt_fields_value
      e_rc             = l_rc.
  CHECK l_rc = 0.
  READ TABLE lt_fields_value INTO ls_fields_value
        WITH KEY value_name = i_fieldname.
  CHECK sy-subrc EQ 0.
* Check if value is initial.
  CHECK NOT ls_fields_value-value_text IS INITIAL.
* if value is not initial -> set return parameter!!
  r_initial = off.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen .

  CALL METHOD gr_insurance_subscreen->ok_code_subscreen
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = c_errorhandler
      c_okcode       = c_okcode.


ENDMETHOD.


METHOD if_ish_screen~set_instance_for_display .

  DATA: l_rc TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling.

  CALL FUNCTION 'ISH_SDY_INSURANCE_INIT'
    EXPORTING
      ir_scr_insurance = me
    IMPORTING
      es_parent        = gs_parent
      e_rc             = l_rc
    CHANGING
      cr_dynp_data     = gr_scr_data
      cr_errorhandler  = lr_errorhandler.

ENDMETHOD.


METHOD if_ish_screen~transport_from_dy .
*
*  DATA: l_rc            TYPE ish_method_rc,
*        lr_corder       TYPE REF TO cl_ish_corder,
*        lt_field_val    TYPE ish_t_field_value,
*        ls_field_val    TYPE rnfield_value,
*        lt_policies     TYPE ish_objectlist,
*        l_wa_object     TYPE ish_object.
*
* Transport super class(es).
*  CALL METHOD super->if_ish_screen~transport_from_dy
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
* Get subscreen data
*  CLEAR: lr_corder.
*  CALL METHOD gr_insurance_subscreen->get_data
*    IMPORTING
*      e_corder      = lr_corder
*      e_vcode       = g_vcode
*    E_FIRST_TIME  =
*      e_environment = gr_environment
*    E_RN1MESSAGE  =
*      .
*  CHECK e_rc = 0.
*
*  CALL METHOD cl_ish_corder=>get_insur_policies_for_corder
*    EXPORTING
*      ir_corder       = lr_corder
*      ir_environment  = gr_environment
*    IMPORTING
*      e_rc            = e_rc
*      et_policies     = lt_policies
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
*  LOOP AT lt_policies INTO l_wa_object.
*    IF gr_policy1 IS INITIAL.
*      gr_policy1 ?= l_wa_object-object.
*    ELSEIF gr_policy2 IS INITIAL.
*      gr_policy2 ?= l_wa_object-object.
*    ELSE.
*      gr_policy3 ?= l_wa_object-object.
*    ENDIF.
*  ENDLOOP.
*
* Set screen values
*  CLEAR: ls_field_val.
*  ls_field_val-fieldname = 'POLICY1'.
*  ls_field_val-type      = co_fvtype_identify.
*  ls_field_val-object    = gr_policy1.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  CLEAR: ls_field_val.
*  ls_field_val-fieldname = 'POLICY2'.
*  ls_field_val-type      = co_fvtype_identify.
*  ls_field_val-object    = gr_policy2.
*  INSERT ls_field_val INTO TABLE lt_field_val.
*  CLEAR: ls_field_val.
*  ls_field_val-fieldname = 'POLICY3'.
*  ls_field_val-type      = co_fvtype_identify.
*  ls_field_val-object    = gr_policy3.
*  INSERT ls_field_val INTO TABLE lt_field_val.
* ----------
* set values
*  CALL METHOD gr_screen_values->set_data
*    EXPORTING
*      it_field_values = lt_field_val
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      c_errorhandler  = cr_errorhandler.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy .

  DATA: lr_corder       TYPE REF TO cl_ish_corder,
        lr_policy1      TYPE REF TO cl_ish_insurance_policy_prov,
        lr_policy2      TYPE REF TO cl_ish_insurance_policy_prov,
        lr_policy3      TYPE REF TO cl_ish_insurance_policy_prov,
        lt_field_val    TYPE ish_t_field_value,
* ED, int. M. 0120061532 0001744985 2005: new values
        l_aggregation   TYPE ish_on_off,
        l_is_base_item  TYPE ish_on_off,
        lr_corder_med   TYPE REF TO cl_ishmed_corder.

  FIELD-SYMBOLS: <ls_field_val>    TYPE rnfield_value.
* ---------- ----------
* initialize
  e_rc = 0.

  CHECK NOT gr_insurance_subscreen IS INITIAL.
  CHECK NOT gr_screen_values       IS INITIAL.

* ----------
* get values
  CALL METHOD gr_screen_values->get_data
    IMPORTING
      et_field_values = lt_field_val
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
* ---------- ---------- ----------
  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
    CASE <ls_field_val>-fieldname.
      WHEN 'POLICY1'.
        gr_policy1 ?= <ls_field_val>-object.
      WHEN 'POLICY2'.
        gr_policy2 ?= <ls_field_val>-object.
      WHEN 'POLICY3'.
        gr_policy3 ?= <ls_field_val>-object.
    ENDCASE.
  ENDLOOP.

* ED, int. M. 0120061532 0001744985 2005: if corder
* aggregation or corder in base item -> only display -> BEGIN
  IF gr_main_object->is_inherited_from(
            cl_ishmed_corder=>co_otype_corder_med ) = on.
    lr_corder_med ?= gr_main_object.
    CHECK NOT lr_corder_med IS INITIAL.
    l_aggregation = lr_corder_med->is_aggregation_object( ).
    l_is_base_item   =
                  lr_corder_med->is_base_item_object( ).
    IF l_aggregation = on OR
       l_is_base_item = on.
      g_vcode = co_vcode_display.
    ENDIF.
  ENDIF.
* ED, int. M. 0120061532 0001744985 2005 -> END

* ---------- ----------
  lr_corder = get_corder( ).
* give the subscreen the actual clinical order
  CALL METHOD gr_insurance_subscreen->set_data
    EXPORTING
      i_corder  = lr_corder
      i_policy1 = gr_policy1
      i_policy2 = gr_policy2
      i_policy3 = gr_policy3
      i_vcode   = g_vcode
      i_vcode_x = 'X'.

* give the fub in de subscreen the reference of the screenclass
  CALL FUNCTION 'ISH_SET_SUBSC_INS_POLICY_CORD'
    EXPORTING
      i_policy_sub = gr_insurance_subscreen.

ENDMETHOD.


METHOD initialize_field_values .

* local tables
  DATA: lt_field_val            TYPE ish_t_field_value.
* workareas
  DATA: ls_field_val            TYPE rnfield_value.

* initialize
  e_rc = 0.

  CLEAR: lt_field_val,
         ls_field_val.

* initialize every screen field
  ls_field_val-fieldname = 'POLICY1'.
  ls_field_val-type      = co_fvtype_identify.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'POLICY2'.
  ls_field_val-type      = co_fvtype_identify.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'POLICY3'.
  ls_field_val-type      = co_fvtype_identify.
  INSERT ls_field_val INTO TABLE lt_field_val.

  ls_field_val-fieldname = g_fieldname_vzuza.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_kname.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

  ls_field_val-fieldname = g_fieldname_ipid_1.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_kname_1.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_kvdat_1.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_mgart_1.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_verbi_1.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_vnumm_1.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

  ls_field_val-fieldname = g_fieldname_ipid_2.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_kname_2.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_kvdat_2.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_mgart_2.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_verbi_2.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = g_fieldname_vnumm_2.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.

* set values
  CALL METHOD gr_screen_values->set_data
    EXPORTING
      it_field_values = lt_field_val
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

ENDMETHOD.


METHOD initialize_internal .

  DATA: l_einri         TYPE tn01-einri,
* ED, int. M. 0120061532 0001744985 2005: new values
        lr_corder_med   TYPE REF TO cl_ishmed_corder,
        l_aggregation   TYPE ish_on_off,
        l_is_base_item  TYPE ish_on_off.

* initialize
  e_rc = 0.

* set subscreen
  g_pgm_insurance   = 'SAPLNCORD'.
  g_dynnr_insurance = '0300'.

* Set gr_waiting_list_subscreen.
  IF gr_insurance_subscreen IS INITIAL.

* ED, int. M. 0120061532 0001744985 2005: corder aggregation
* and corder in base item-> set vcode DISPLAY -> BEGIN
* get KZ AGGREGATION
    IF NOT gr_main_object IS INITIAL.
      IF gr_main_object->is_inherited_from(
                cl_ishmed_corder=>co_otype_corder_med ) = on.
        lr_corder_med ?= gr_main_object.
        CHECK NOT lr_corder_med IS INITIAL.
        l_aggregation = lr_corder_med->is_aggregation_object( ).
        l_is_base_item   =
                      lr_corder_med->is_base_item_object( ).
        IF l_aggregation = on OR
           l_is_base_item = on.
          g_vcode = co_vcode_display.
        ENDIF.
      ENDIF.
    ENDIF.
* ED, int. M. 0120061532 0001744985 2005 -> END

*   Get einri.
    l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
    CHECK NOT l_einri IS INITIAL.
*   initialize the screenclass
    CREATE OBJECT gr_insurance_subscreen
      EXPORTING
        i_caller      = 'CL_ISH_SCR_INSURANCE'
        i_einri       = l_einri
        i_vcode       = g_vcode
        i_environment = gr_environment
        i_cancel      = gr_cancel
        ir_screen     = me.                "RW ID 14654
    e_rc = sy-subrc.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD initialize_parent .

  DATA: l_bewty TYPE nbew-bewty.

  CLEAR: gs_parent, e_rc.

  gs_parent-repid = 'SAPLN1_SDY_INSURANCE'.
  gs_parent-dynnr = '0100'.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.
ENDCLASS.
