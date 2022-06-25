class CL_ISH_SCR_SERVICE_DETAIL definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create public .

*"* public components of class CL_ISH_SCR_SERVICE_DETAIL
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_SCR_SERVICE_DETAIL type ISH_OBJECT_TYPE value 7022. "#EC NOTEXT

  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_SERVICE_DETAIL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_A
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_SERVICE_DETAIL
*"* do not include other source files here!!!

  class-data G_FIELDNAME_LEIST type ISH_FIELDNAME .
  class-data G_FIELDNAME_LEITX type ISH_FIELDNAME .
  class-data G_FIELDNAME_ANPOE type ISH_FIELDNAME .
  class-data G_FIELDNAME_ANPOENA type ISH_FIELDNAME .
  class-data G_FIELDNAME_ANFOE type ISH_FIELDNAME .
  class-data G_FIELDNAME_ANFOENA type ISH_FIELDNAME .
  class-data G_FIELDNAME_ERBOE type ISH_FIELDNAME .
  class-data G_FIELDNAME_ERBOENA type ISH_FIELDNAME .

  methods VALUE_REQUEST_ANFOE
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods VALUE_REQUEST_ANPOE
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_ANFOENA
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_ANPOENA
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_ERBOENA
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_LEITX
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods FILL_ALL_LABELS
    redefinition .
  methods FILL_LABEL_INTERNAL
    redefinition .
  methods INITIALIZE_FIELD_VALUES
    redefinition .
  methods INITIALIZE_INTERNAL
    redefinition .
  methods INITIALIZE_PARENT
    redefinition .
  methods VALUE_REQUEST_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_SERVICE_DETAIL
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_SERVICE_DETAIL IMPLEMENTATION.


method CONSTRUCTOR .

  CALL METHOD super->constructor.

endmethod.


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
        i_mv1           = 'CL_ISH_SCR_SERVICE_DETAIL'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


method FILL_ALL_LABELS .

* Initializations
  CLEAR: e_rc.

* LEITX
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_leitx
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ANPOENA
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_anpoena
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ANFOENA
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_anfoena
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ERBOENA
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_erboena
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

endmethod.


METHOD fill_label_anfoena .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_anfoe TYPE rnfield_value,
        l_wa_field_value_anfoena TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_anfoena TYPE orgna,
        l_anfoe TYPE anfoe,
        l_einri TYPE einri,
        l_norg TYPE norg.
* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  CLEAR: e_rc.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_anfoe
     WITH KEY fieldname = g_fieldname_anfoe.
  CHECK sy-subrc EQ 0.

  l_anfoe = l_wa_field_value_anfoe-value.

  CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit
    EXPORTING
      i_einri         = l_einri
      i_orgid         = l_anfoe
    IMPORTING
*    E_ORGKB         =
      e_norg          = l_norg
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK l_rc = 0.

  l_wa_field_value_anfoena-value = l_norg-orgna.

  MODIFY lt_field_values FROM l_wa_field_value_anfoena
    TRANSPORTING value WHERE fieldname = g_fieldname_anfoena.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_anpoena .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_anpoe TYPE rnfield_value,
        l_wa_field_value_anpoena TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_anpoena TYPE orgna,
        l_anpoe TYPE anpoe,
        l_einri TYPE einri,
        l_norg TYPE norg.
* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  CLEAR: e_rc.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_anpoe
     WITH KEY fieldname = g_fieldname_anpoe.
  CHECK sy-subrc EQ 0.

  l_anpoe = l_wa_field_value_anpoe-value.

  CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit
    EXPORTING
      i_einri         = l_einri
      i_orgid         = l_anpoe
    IMPORTING
*    E_ORGKB         =
      e_norg          = l_norg
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK l_rc = 0.

  l_wa_field_value_anpoena-value = l_norg-orgna.

  MODIFY lt_field_values FROM l_wa_field_value_anpoena
    TRANSPORTING value WHERE fieldname = g_fieldname_anpoena.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_erboena .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_erboe TYPE rnfield_value,
        l_wa_field_value_erboena TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_erboena TYPE orgna,
        l_erboe TYPE erboe,
        l_einri TYPE einri,
        l_norg TYPE norg.
* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  CLEAR: e_rc.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.

  CHECK e_rc = 0.
  READ TABLE lt_field_values INTO l_wa_field_value_erboe
    WITH KEY fieldname = g_fieldname_erboe.
  CHECK sy-subrc EQ 0.

  l_erboe = l_wa_field_value_erboe-value.

  CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit
    EXPORTING
      i_einri         = l_einri
      i_orgid         = l_erboe
    IMPORTING
*    E_ORGKB         =
      e_norg          = l_norg
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK l_rc = 0.

  l_wa_field_value_erboena-value = l_norg-orgna.

  MODIFY lt_field_values FROM l_wa_field_value_erboena
    TRANSPORTING value WHERE fieldname = g_fieldname_erboena.

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
    WHEN g_fieldname_leitx.
      CALL METHOD fill_label_leitx
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    WHEN g_fieldname_anpoena.
      CALL METHOD fill_label_anpoena
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    WHEN g_fieldname_anfoena.
      CALL METHOD fill_label_anfoena
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    WHEN g_fieldname_erboena.
      CALL METHOD fill_label_erboena
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
  ENDCASE.
ENDMETHOD.


method FILL_LABEL_LEITX .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_leist TYPE rnfield_value,
        l_wa_field_value_leitx TYPE rnfield_value,
        l_rc TYPE ish_method_rc,
        l_leist TYPE tarls,
        l_leitx TYPE text_lei,
        l_einri TYPE einri,
        l_nlei  TYPE nlei.
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
  READ TABLE lt_field_values INTO l_wa_field_value_leist
     WITH KEY fieldname = g_fieldname_leist.
  CHECK sy-subrc EQ 0.

  l_leist = l_wa_field_value_leist-value.
*
  CLEAR: l_leitx.
* get the text for the service
  l_nlei-einri = l_einri.
  l_nlei-leist = l_leist.
  CALL METHOD cl_ishmed_service=>build_service_text
    EXPORTING
      i_nlei = l_nlei
    IMPORTING
      e_text = l_leitx.
  CHECK l_leitx <> space.

  l_wa_field_value_leitx-value = l_leitx.

  MODIFY lt_field_values FROM l_wa_field_value_leitx
    TRANSPORTING value WHERE fieldname = g_fieldname_leitx.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

endmethod.


method IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_scr_service_detail.

endmethod.


method IF_ISH_IDENTIFY_OBJECT~IS_A .

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

endmethod.


method IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  IF i_object_type = co_otype_scr_service_detail.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off. ID-16230
  ENDIF.

endmethod.


method INITIALIZE_FIELD_VALUES .

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
  ls_field_val-fieldname = 'RN1_DYNP_SERVICES-LEIST'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_SERVICES-LEITX'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_SERVICES-ANPOE'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_SERVICES-ANPOENA'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_SERVICES-ANFOE'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_SERVICES-ANFOENA'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_SERVICES-ERBOE'.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = 'RN1_DYNP_SERVICES-ERBOENA'.
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

endmethod.


METHOD initialize_internal .

* SET THE GLOBAL FIELD VALUES
  g_fieldname_leist = 'RN1_DYNP_SERVICES-LEIST'.
  g_fieldname_anpoe = 'RN1DYNP_SERVICES-ANPOE'.
  g_fieldname_anpoena = 'RN1DYNP_SERVICES-ANPOENA'.
  g_fieldname_anfoe = 'RN1DYNP_SERVICES-ANFOE'.
  g_fieldname_anfoena = 'RN1DYNP_SERVICES-ANFOENA'.
  g_fieldname_erboe = 'RN1DYNP_SERVICES-ERBOE'.
  g_fieldname_erboena = 'RN1DYNP_SERVICES-ERBOENA'.
  g_fieldname_leitx = 'RN1DYNP_SERVICES-LEITX'.

ENDMETHOD.


METHOD initialize_parent .

  CLEAR: gs_parent.

  gs_parent-repid = 'SAPLN1_SDY_SERVICES'.
  gs_parent-dynnr = '0200'.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.


method VALUE_REQUEST_ANFOE .
endmethod.


method VALUE_REQUEST_ANPOE .
endmethod.


method VALUE_REQUEST_INTERNAL .

* Initializations.
  CLEAR: e_rc.

  CASE i_fieldname.
* requested ou
    WHEN g_fieldname_anpoe.
      CALL METHOD value_request_anpoe
        IMPORTING
          e_called        = e_called
          e_selected      = e_selected
          e_value         = e_value
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
* requested ou departmental
    WHEN g_fieldname_anfoe.
      CALL METHOD value_request_anfoe
        IMPORTING
          e_called        = e_called
          e_selected      = e_selected
          e_value         = e_value
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
  ENDCASE.

endmethod.
ENDCLASS.
