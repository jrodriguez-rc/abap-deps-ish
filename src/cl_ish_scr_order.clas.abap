class CL_ISH_SCR_ORDER definition
  public
  inheriting from CL_ISH_SCREEN_STD
  create protected .

*"* public components of class CL_ISH_SCR_ORDER
*"* do not include other source files here!!!
public section.

  class-data G_PREFIX_FIELDNAME type ISH_FIELDNAME read-only value 'RN1_DYNP_ORDER'. "#EC NOTEXT " .
  constants CO_DEFAULT_TABNAME type TABNAME value 'N1CORDER'. "#EC NOTEXT
  class-data G_FIELDNAME_ETRBY type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ORDPRI type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_WLSTA type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_GPART type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ETROEGP type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ORDDEP type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_VMA_TEXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_ETROEGP_TEXT type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_PRGNR type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_RCKRUF type ISH_FIELDNAME read-only .
  class-data G_FIELDNAME_CORDTITLE type ISH_FIELDNAME read-only .
  constants CO_OTYPE_SCR_ORDER type ISH_OBJECT_TYPE value 7010. "#EC NOTEXT

  methods GET_ETRBY_FROM_FV
    returning
      value(R_ETRBY) type N1CORDER-ETRBY .
  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCR_ORDER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_LISTBOX_ETRBY
    exporting
      !ER_LB_OBJECT type ref to CL_ISH_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_LISTBOX_ORDPRI
    exporting
      !ER_LB_OBJECT type ref to CL_ISH_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_LISTBOX_WLSTA
    exporting
      !ER_LB_OBJECT type ref to CL_ISH_LISTBOX
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .
  methods VALUE_REQUEST_GPART
    exporting
      value(E_SELECTED) type ISH_ON_OFF
      value(E_CALLED) type ISH_ON_OFF
      value(E_VALUE) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_ETROEGP
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILL_LABEL_GPART
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods VALUE_REQUEST_ETROEGP
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
  methods IF_ISH_SCREEN~SET_INSTANCE_FOR_DISPLAY
    redefinition .
  methods IF_ISH_SCREEN~IS_FIELD_INITIAL
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_ORDER
*"* do not include other source files here!!!

  class-data G_N1MAOE type C .

  methods BUILD_INITIAL_FV
    changing
      !CT_FIELD_VAL type ISH_T_FIELD_VALUE .

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
*"* private components of class CL_ISH_SCR_ORDER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_ORDER IMPLEMENTATION.


METHOD build_initial_fv .

  DATA: ls_field_val            TYPE rnfield_value.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_etrby.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_etroegp.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_etroegp_text.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_prgnr.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_ordpri.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_wlsta.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_gpart.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_rckruf.
  LS_FIELD_VAL-TYPE      = CO_FVTYPE_SINGLE.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_cordtitle.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

  CLEAR: ls_field_val.
  ls_field_val-fieldname = g_fieldname_vma_text.
  ls_field_val-type      = co_fvtype_single.
  INSERT ls_field_val INTO TABLE ct_field_val.

ENDMETHOD.


METHOD build_message .

  DATA: l_cursorfield_prefix  TYPE ish_fieldname,
        l_cursorfield         TYPE ish_fieldname,
        l_fieldname           TYPE ish_fieldname,
        lr_corder             TYPE REF TO cl_ish_corder,
        ls_n1corder           TYPE n1corder,
        lr_identify           TYPE REF TO if_ish_identify_object.

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
*   Handle also messages for services.
    lr_identify ?= is_message-object.
    IF lr_identify->is_inherited_from(
                cl_ishmed_service=>co_otype_anchor_srv ) = off AND
       lr_identify->is_inherited_from(
                cl_ishmed_service=>co_otype_med_service ) = off.
      CLEAR: es_message-parameter,
             es_message-field.
      EXIT.
    ENDIF.
  ENDIF.

* Wrap es_message-parameter.
  CASE es_message-parameter.
*   Handle errors on db-table n1corder
    WHEN 'N1CORDER'.
*     Switch the parameter to selfs dynpro structure name.
      es_message-parameter = g_prefix_fieldname.
*     Handle special fields.
      CASE es_message-field.
*       Switch ETROE and ETRGP to ETROEGP or GPART.
        WHEN 'ETROE' OR
             'ETRGP'.
          l_fieldname = g_fieldname_etroegp.
*         ETRGP and VMA have only one field in n1corder -> ETRGP.
*         Therefore if the initiator is ETROE and the error is on ETRGP
*         switch to screen field GPART.
          IF es_message-field = 'ETRGP'.
            lr_corder = get_corder( ).
            IF NOT lr_corder IS INITIAL.
              CALL METHOD lr_corder->get_data
                IMPORTING
                  es_n1corder = ls_n1corder.
              IF ls_n1corder-etrby = cl_ish_corder=>co_etrby_oe.
                l_fieldname = g_fieldname_gpart.
              ENDIF.
            ENDIF.
          ENDIF.
      ENDCASE.
*   Handle errors on db-table n1lsstz
    WHEN 'N1LSSTZ'.
*     Handle errors on vma of services.
      IF es_message-field = 'GPART'.
        es_message-parameter = g_prefix_fieldname.
        l_fieldname = g_fieldname_gpart.
        lr_corder = get_corder( ).
        IF NOT lr_corder IS INITIAL.
          CALL METHOD lr_corder->get_data
            IMPORTING
              es_n1corder = ls_n1corder.
          IF ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
            l_fieldname = g_fieldname_etroegp.
          ENDIF.
        ENDIF.
      ENDIF.
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


METHOD class_constructor .

  g_prefix_fieldname = 'RN1_DYNP_ORDER'.

* Set fieldnames
  g_fieldname_etrby        = 'RN1_DYNP_ORDER-ETRBY'.
  g_fieldname_ordpri       = 'RN1_DYNP_ORDER-ORDPRI'.
  g_fieldname_wlsta        = 'RN1_DYNP_ORDER-WLSTA'.
  g_fieldname_gpart        = 'RN1_DYNP_ORDER-GPART'.
  g_fieldname_etroegp      = 'RN1_DYNP_ORDER-ETROEGP'.
  g_fieldname_vma_text     = 'RN1_DYNP_ORDER-VMA_TEXT'.
  g_fieldname_etroegp_text = 'RN1_DYNP_ORDER-ETROEGP_TEXT'.
  g_fieldname_prgnr        = 'RN1_DYNP_ORDER-PRGNR'.
  g_fieldname_rckruf       = 'RN1_DYNP_ORDER-RCKRUF'.
  g_fieldname_cordtitle    = 'RN1_DYNP_ORDER-CORDTITLE'.

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
        i_mv1           = 'CL_ISH_SCR_ORDER'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD create_listbox_etrby .

* definition
  DATA: l_rc                TYPE ish_method_rc,
        l_einri             TYPE tn01-einri,
        l_flag              TYPE ish_on_off,
        l_fieldname_etrby   TYPE vrm_id,
        lt_fieldvalues      TYPE ish_t_field_value,
        l_wa_fieldvalue     TYPE rnfield_value,
        l_vrm_value         TYPE vrm_value-key,
        l_vrm_id            TYPE vrm_id,
        l_etrby             TYPE n1corder-etrby.

* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_fieldvalues
      e_rc            = l_rc.
  READ TABLE lt_fieldvalues INTO l_wa_fieldvalue
     WITH KEY fieldname = g_fieldname_etrby.
  l_vrm_value = l_wa_fieldvalue-value.
  l_etrby = l_vrm_value.
* ---------- ---------- ----------
  l_vrm_id = g_fieldname_etrby.
  CALL METHOD cl_ish_lb_etrby=>fill_listbox
    EXPORTING
      i_fieldname  = l_vrm_id
      i_einri      = l_einri
      i_etrby      = l_etrby
    IMPORTING
      e_rc         = l_rc
      er_lb_object = lr_lb_object.
* ---------- ---------- ----------
* Export listbox object
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD create_listbox_internal .

* Initializations
  CLEAR: e_rc.

  CASE i_fieldname.
    WHEN g_fieldname_etrby.
      CALL METHOD create_listbox_etrby
        IMPORTING
          er_lb_object    = er_lb_object
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
    WHEN g_fieldname_ordpri.
      CALL METHOD create_listbox_ordpri
        IMPORTING
          er_lb_object    = er_lb_object
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
    WHEN g_fieldname_wlsta.
      CALL METHOD create_listbox_wlsta
        IMPORTING
          er_lb_object    = er_lb_object
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
  ENDCASE.

ENDMETHOD.


METHOD create_listbox_ordpri .

* definition
  DATA: l_rc                TYPE ish_method_rc,
        l_einri             TYPE tn01-einri,
        l_flag              TYPE ish_on_off,
        l_fieldname_etrby   TYPE vrm_id,
        lt_fieldvalues      TYPE ish_t_field_value,
        l_wa_fieldvalue     TYPE rnfield_value,
        l_vrm_value         TYPE vrm_value-key,
        l_vrm_id            TYPE vrm_id,
        lr_cord             TYPE REF TO cl_ish_corder,"MED-48734
        l_isnew_flag        TYPE ish_on_off,"MED-48734
        l_prio              TYPE n1corder-ordpri.

* object references
  DATA: lr_lb_object        TYPE REF TO cl_ish_listbox.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
  IF l_einri IS INITIAL.
    EXIT.
  ENDIF.

*MED-48734,AM,for order listbox
  TRY.
      lr_cord  ?= gr_main_object.
      lr_cord->is_new(
        IMPORTING
          e_new = l_isnew_flag    " Objekt ist neu (ON)
      ).
    CATCH cx_sy_move_cast_error.
  ENDTRY.
*END MED-48734

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_fieldvalues
      e_rc            = l_rc.

  READ TABLE lt_fieldvalues INTO l_wa_fieldvalue
     WITH KEY fieldname = g_fieldname_ordpri.
  l_vrm_value = l_wa_fieldvalue-value.
  l_prio = l_vrm_value.
* ---------- ---------- ----------
  l_vrm_id = g_fieldname_ordpri.
  CALL METHOD cl_ishmed_lb_prio=>fill_listbox
    EXPORTING
      i_fieldname   = l_vrm_id
      i_einri       = l_einri
      i_prio        = l_prio
      i_use_int_key = on
      i_corder_isnew_flag = l_isnew_flag  "MED-48734 Oana Bocarnea
    IMPORTING
      e_rc          = l_rc
      er_lb_object  = lr_lb_object.
* ---------- ---------- ----------
* Export listbox object
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD create_listbox_wlsta .

* definition
  DATA: l_rc                TYPE ish_method_rc,
        l_einri             TYPE tn01-einri,
        l_flag              TYPE ish_on_off,
        l_fieldname_etrby   TYPE vrm_id,
        lt_fieldvalues      TYPE ish_t_field_value,
        l_wa_fieldvalue     TYPE rnfield_value,
        l_vrm_value         TYPE vrm_value-key,
        l_vrm_id            TYPE vrm_id.

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
     WITH KEY fieldname = g_fieldname_wlsta.
  l_vrm_value = l_wa_fieldvalue-value.
* ---------- ---------- ----------
  l_vrm_id = g_fieldname_wlsta.
  CALL METHOD cl_ish_lb_wlsta=>fill_listbox
    EXPORTING
      i_fieldname  = l_vrm_id
      i_einri      = l_einri
    IMPORTING
      e_rc         = l_rc
      er_lb_object = lr_lb_object.
* ---------- ---------- ----------
* Export listbox object
  er_lb_object = lr_lb_object.

ENDMETHOD.


METHOD fill_all_labels .

* Initializations
  CLEAR: e_rc.

* ETROEGP
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_etroegp
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* GPART
  CALL METHOD me->fill_label
    EXPORTING
      i_fieldname     = g_fieldname_gpart
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD fill_label_etroegp .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_etrby TYPE rnfield_value,
        l_wa_field_value_etroegp TYPE rnfield_value,
        l_wa_field_value_etroegp_text TYPE rnfield_value,
        l_pernr TYPE ri_pernr,
        l_etroegp_text(15) TYPE c,
        l_orgid TYPE orgid,
        l_etrby TYPE n1cordetrby,
        l_gpart_text TYPE ish_pnamec,
        l_einri TYPE einri,
        l_norg TYPE norg,
        l_rc TYPE ish_method_rc.
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
  READ TABLE lt_field_values INTO l_wa_field_value_etrby
     WITH KEY fieldname = g_fieldname_etrby.
  CHECK sy-subrc EQ 0.
  READ TABLE lt_field_values INTO l_wa_field_value_etroegp
     WITH KEY fieldname = g_fieldname_etroegp.
  CHECK sy-subrc EQ 0.

  l_etrby = l_wa_field_value_etrby-value.

* OE
  IF l_etrby = '1' .
    l_orgid = l_wa_field_value_etroegp-value.
    CALL METHOD cl_ish_utl_base_conv=>conv_char_to_intern
      EXPORTING
        i_length = 8
      CHANGING
        c_value  = l_orgid.
    CALL METHOD cl_ish_utl_base_descr=>get_descr_orgunit
      EXPORTING
        i_einri         = l_einri
        i_orgid         = l_orgid
      IMPORTING
*        E_ORGKB         =
        e_norg          = l_norg
        e_rc            = l_rc.
    IF l_rc <> 0.
      CLEAR l_norg.
    ENDIF.
    l_wa_field_value_etroegp_text-value = l_norg-orgna.

* ext. GP
  ELSEIF l_etrby = '2'.
    l_pernr = l_wa_field_value_etroegp-value.
    CALL METHOD cl_ish_utl_base_conv=>conv_char_to_intern
      EXPORTING
        i_length = 10
      CHANGING
        c_value  = l_pernr.
*   create the name of the person
    CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
      EXPORTING
        i_gpart = l_pernr
      IMPORTING
        e_pname = l_gpart_text
        e_rc    = l_rc.
    IF l_rc <> 0.
      CLEAR l_gpart_text.
    ENDIF.
    l_wa_field_value_etroegp_text-value = l_gpart_text.

  ENDIF.

  MODIFY lt_field_values FROM l_wa_field_value_etroegp_text
    TRANSPORTING value WHERE fieldname = g_fieldname_etroegp_text.

  CALL METHOD me->set_fields
    EXPORTING
      it_field_values  = lt_field_values
      i_field_values_x = 'X'
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.

ENDMETHOD.


METHOD fill_label_gpart .

  DATA: lt_field_values TYPE ish_t_field_value,
        l_wa_field_value_gpart TYPE rnfield_value,
        l_wa_field_value_vma_text TYPE rnfield_value,
        l_pernr TYPE ri_pernr,
        l_gpart_text TYPE ish_pnamec,
        l_rc TYPE ish_method_rc.

  CALL METHOD me->get_fields
    IMPORTING
      et_field_values = lt_field_values
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

  READ TABLE lt_field_values INTO l_wa_field_value_gpart
     WITH KEY fieldname = g_fieldname_gpart.
  CHECK sy-subrc EQ 0.
  READ TABLE lt_field_values INTO l_wa_field_value_vma_text
     WITH KEY fieldname = g_fieldname_vma_text.
  CHECK sy-subrc EQ 0.

  l_pernr = l_wa_field_value_gpart-value.
  CALL METHOD cl_ish_utl_base_conv=>conv_char_to_intern
    EXPORTING
      i_length = 10
    CHANGING
      c_value  = l_pernr.

* create the name of the person
  CALL METHOD cl_ish_utl_base_gpa=>get_name_gpa
    EXPORTING
      i_gpart = l_pernr
    IMPORTING
      e_pname = l_gpart_text
      e_rc    = l_rc.
  IF l_rc <> 0.
    CLEAR l_gpart_text.
*--  begin Grill,  ID-19897
*   set paramter ID
*  ENDIF.
*-- begin med-29571
*  ELSE.
*    IF NOT l_pernr IS INITIAL.
*      CALL FUNCTION 'ISH_SET_PARAMETER_ID'
*        EXPORTING
*          i_parameter_id    = 'VMA'
*          i_parameter_value = l_pernr.
*  ENDIF.
*-- end med-29571
  ENDIF.

  l_wa_field_value_vma_text-value = l_gpart_text.
  MODIFY lt_field_values FROM l_wa_field_value_vma_text
    TRANSPORTING value WHERE fieldname = g_fieldname_vma_text.

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
    WHEN g_fieldname_etroegp.
      CALL METHOD fill_label_etroegp
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    WHEN g_fieldname_gpart.
      CALL METHOD fill_label_gpart
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

* cordtitle
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_cordtitle.
  ls_scrm_field-fieldlabel = 'Titel'(001).
  APPEND ls_scrm_field TO gt_scrm_field.

* etrby
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_etrby.
  ls_scrm_field-fieldlabel = 'Veranlasst von'(002).
  APPEND ls_scrm_field TO gt_scrm_field.

* etroegp
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_etroegp.
  ls_scrm_field-fieldlabel = 'Veranlasser'(003).
  APPEND ls_scrm_field TO gt_scrm_field.

* gpart
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_gpart.
  ls_scrm_field-fieldlabel = 'Verantw.MA'(004).
  APPEND ls_scrm_field TO gt_scrm_field.

* orddep
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_orddep.
  ls_scrm_field-fieldlabel = 'Veranlassende OE fachl.'(005).
  APPEND ls_scrm_field TO gt_scrm_field.

* ordpri
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_ordpri.
  ls_scrm_field-fieldlabel = 'Priorität'(006).
  APPEND ls_scrm_field TO gt_scrm_field.

* rckruf
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_rckruf.
  ls_scrm_field-fieldlabel = 'Rückrufnummer'(007).
  APPEND ls_scrm_field TO gt_scrm_field.

* wlsta
  CLEAR ls_scrm_field.
  ls_scrm_field-fieldname  = g_fieldname_wlsta.
  ls_scrm_field-fieldlabel = 'Status'(008).
  APPEND ls_scrm_field TO gt_scrm_field.

ENDMETHOD.


METHOD get_corder .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.

  rr_corder ?= gr_main_object.

ENDMETHOD.


METHOD get_etrby_from_fv .

  DATA: ls_field_val   TYPE rnfield_value,
        l_rc           TYPE ish_method_rc.

* Initializations.
  r_etrby = cl_ish_corder=>co_etrby_oe.

  CHECK NOT gr_screen_values IS INITIAL.

* Get fieldvalue for etrby.
  CALL METHOD gr_screen_values->get_data
    EXPORTING
      i_fieldname   = g_fieldname_etrby
      i_type        = co_fvtype_single
    IMPORTING
      e_field_value = ls_field_val
      e_rc          = l_rc.
  CHECK l_rc = 0.
  CHECK NOT ls_field_val-value IS INITIAL.

* Export.
  r_etrby = ls_field_val-value.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_scr_order.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  IF i_object_type = co_otype_scr_order.
    r_is_inherited_from = on.
  ELSE.
*-- ID-16230
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
*--  r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~create_all_listboxes .

  CLEAR: e_rc.

* ETRBY
  CALL METHOD create_listbox
    EXPORTING
      i_fieldname     = g_fieldname_etrby
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* ORDPRI
  CALL METHOD create_listbox
    EXPORTING
      i_fieldname     = g_fieldname_ordpri
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* WLSTA
  CALL METHOD create_listbox
    EXPORTING
      i_fieldname     = g_fieldname_wlsta
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


method IF_ISH_SCREEN~IS_FIELD_INITIAL.

* MED-53409 Cristina Geanta
  DATA: ls_n1apri TYPE n1apri,
        l_einri   TYPE tn01-einri.

  CLEAR: ls_n1apri,
         l_einri.

  l_einri = cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).

* Just wrap to gr_screen_values.
* Initializations:
  r_initial = on.

  CHECK NOT gr_screen_values IS INITIAL.

  CALL METHOD super->if_ish_screen~is_field_initial
      EXPORTING
        I_FIELDNAME = i_fieldname
        I_ROWNUMBER = i_rownumber
      RECEIVING
        R_INITIAL   = r_initial.

* When the priority is set to 'O' and when the field priority
* is initial, the internal value is the same - '000'.
* That's why we need to check in table N1APRI if the field
* priority from the clinical order is initial or if the
* priority '0' was chosen
  IF i_fieldname EQ g_fieldname_ordpri AND r_initial EQ on.
    SELECT SINGLE *
      FROM n1apri
      INTO ls_n1apri
     WHERE einri EQ l_einri
       AND apri  EQ '000'
       AND loekz NE 'X'.

    IF sy-subrc EQ 0.
      r_initial = off.
    ENDIF.
  ENDIF.
* END MED-53409 Cristina Geanta


** MED-52318 Cristina Geanta
*  DATA: lt_values TYPE ish_t_field_value,
*        l_rc      TYPE ish_method_rc.
*
*  FIELD-SYMBOLS: <ls_values>  TYPE rnfield_value.
*
** Just wrap to gr_screen_values.
** Initializations:
*  r_initial = on.
*
*  CHECK NOT gr_screen_values IS INITIAL.
*
*  IF i_fieldname NE G_FIELDNAME_ORDPRI.
*
*    CALL METHOD SUPER->IF_ISH_SCREEN~IS_FIELD_INITIAL
*      EXPORTING
*        I_FIELDNAME = i_fieldname
*        I_ROWNUMBER = i_rownumber
*      RECEIVING
*        R_INITIAL   = r_initial.
*  ELSE.
*
** Fieldname is 'RN1_DYNP_ORDER_MED-ORDPRI'
*    CALL METHOD gr_screen_values->get_data
*      IMPORTING
*        et_field_values = lt_values
*        e_rc            = l_rc.
*
*    READ TABLE lt_values ASSIGNING <ls_values>
*       WITH KEY fieldname = i_fieldname.
*    CHECK sy-subrc = 0.
*
*    IF <ls_values>-value IS NOT INITIAL.
*      r_initial = off.
*    ENDIF.
*
*  ENDIF.
** END MED-52318 Cristina Geanta

endmethod.


METHOD if_ish_screen~set_instance_for_display .

* call the fub for component order
  CALL FUNCTION 'ISH_SDY_ORDER_INIT'
    EXPORTING
      ir_scr_order    = me
    IMPORTING
      es_parent       = gs_parent
      e_rc            = e_rc
    CHANGING
      cr_dynp_data    = gr_scr_data
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD initialize_field_values .
* local tables
  DATA: lt_field_val            TYPE ish_t_field_value.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* initialize every screen field
  CLEAR: lt_field_val.
  CALL METHOD build_initial_fv
    CHANGING
      ct_field_val = lt_field_val.
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

* definitions
  DATA: l_rc             TYPE ish_method_rc,
        l_einri          TYPE einri,
        lr_run_data      TYPE REF TO cl_ish_run_data.

  CHECK NOT gr_main_object IS INITIAL.

* ----------- ----------- ----------
* get parameter N1MAOE
* ---------- ---------- ----------
* check if main object is for run data
* ... then there is a method "get_data_field"
  IF gr_main_object->is_inherited_from(
                  cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
  lr_run_data ?= gr_main_object.
* ---------- ---------- ----------
* get institution of object
  CALL METHOD lr_run_data->get_data_field
    EXPORTING
      i_fill      = off
      i_fieldname = 'EINRI'
    IMPORTING
      e_rc        = l_rc
      e_field     = l_einri.
  IF l_rc    <> 0 OR
     l_einri IS INITIAL.
    EXIT.
  ENDIF.
  CALL FUNCTION 'ISH_TN00R_READ'
    EXPORTING
      ss_einri        = l_einri
      ss_param        = 'N1MAOE'
*   SS_ALPHA        = 'X'
   IMPORTING
     ss_value        = g_n1maoe
   EXCEPTIONS
     not_found       = 1
     OTHERS          = 2.
  IF sy-subrc <> 0.
    CLEAR g_n1maoe.
  ENDIF.

ENDMETHOD.


METHOD initialize_parent .

  CLEAR: gs_parent.

  gs_parent-repid = 'SAPLN1_SDY_ORDER'.
  gs_parent-dynnr = '0100'.
  gs_parent-type = co_scr_parent_type_dynpro.

ENDMETHOD.


METHOD modify_screen_internal .

  DATA: lr_corder      TYPE REF TO cl_ish_corder,
        ls_n1corder    TYPE n1corder,
        l_prgnr_input  TYPE ish_on_off,
        ls_modified    TYPE rn1screen. "ED, ID 15282
* RW ID 14654 - BEGIN
  DATA: l_active_etroegp     TYPE ish_on_off,
        l_active_gpart       TYPE ish_on_off.
* RW ID 14654 - END

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get corder data.
  CALL METHOD lr_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Check for extern prgnr but only in insert mode.
* If not in insert mode disable prgnr everytime.
  IF g_vcode = co_vcode_insert.
*   ED, ID 15282: check also table it_modified -> BEGIN
    READ TABLE it_modified WITH KEY name = g_fieldname_prgnr
        INTO ls_modified.
    IF sy-subrc <> 0.
*   ED, ID 15282 -> END
      CALL METHOD cl_ish_corder=>get_prgnr_properties
        EXPORTING
          ir_corder       = lr_corder
        IMPORTING
          e_input         = l_prgnr_input
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
*   ED, ID 15282: check also table it_modified -> BEGIN
    ELSE.
      l_prgnr_input = ls_modified-input.
    ENDIF. "ED, ID 15282
*   ED, ID 15282 -> END
  ELSE.
    l_prgnr_input = off.
  ENDIF.

* Disable fields.
  LOOP AT SCREEN.
    CASE screen-name.
      WHEN g_fieldname_gpart.
*       Disable gpart depending on etrby.
        IF ls_n1corder-etrby = cl_ish_corder=>co_etrby_gp.
          screen-input = 0.
        ENDIF.
      WHEN g_fieldname_prgnr.
*       Disable prgnr depending on l_prgnr_input.
        IF l_prgnr_input = off.
          screen-input = 0.
*-- Begin Grill, ID-16538
        ELSE.
          screen-input = 1.
*-- End Grill, ID-16538
        ENDIF.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.

* RW ID 14654 - BEGIN
* Check if fields are active or hidden.
  LOOP AT SCREEN.
    CASE screen-name.
      WHEN g_fieldname_etroegp.
        IF screen-active = false.
          l_active_etroegp = off.
        ELSE.
          l_active_etroegp = on.
        ENDIF.
      WHEN g_fieldname_gpart.
        IF screen-active = false.
          l_active_gpart = off.
        ELSE.
          l_active_gpart = on.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
  ENDLOOP.
* Hide text fields?
  LOOP AT SCREEN.
    CASE screen-name.
      WHEN g_fieldname_etroegp_text.
        IF screen-active = true AND l_active_etroegp = off.
          screen-active = false.
        ENDIF.
      WHEN g_fieldname_vma_text.
        IF screen-active = true AND l_active_gpart = off.
          screen-active = false.
        ENDIF.
      WHEN OTHERS.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.
* RW ID 14654 - END

ENDMETHOD.


METHOD value_request_etroegp .

  DATA: l_einri                  TYPE einri,
        l_etrby                  TYPE n1cordetrby,
        ls_norg                  TYPE norg,
        ls_ngpa                  TYPE ngpa,
        l_nothing_selected       TYPE ish_on_off,
        l_vcode                  TYPE vcode,
        l_rc                     TYPE ish_method_rc.

* Initializations.
  e_rc       = 0.
  e_selected = off.
  e_called   = off.

* Get etrby.
  l_etrby = get_etrby_from_fv( ).

* Handle vcode.
* Use only display/update (not insert).
  l_vcode = g_vcode.
  IF l_vcode = co_vcode_insert.
    l_vcode = co_vcode_update.
  ENDIF.

* Show f4 depending on etrby.
  CASE l_etrby.

*   etroe
    WHEN cl_ish_corder=>co_etrby_oe.

*     Get einri.
      l_einri =
        cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
      CHECK NOT  l_einri IS INITIAL.
*     Show f4 for orgid.
      CALL FUNCTION 'ISH_GRAPHIC_ORGID_SELECT'
        EXPORTING
          ambes             = '*'
          anfkz             = '*'
          einri             = l_einri
          erbkz             = '*'
          fazuw             = '*'
          freig             = on
          loekz             = off
          no_bauid          = on
          pfzuw             = '*'
          vcode             = l_vcode
          graph_title       = ' '
        IMPORTING
          selected_orgid    = ls_norg-orgid
          nothing_selected  = l_nothing_selected
        EXCEPTIONS
          bauid_not_in_nbau = 1
          einri_not_in_tn01 = 2
          no_hierarchy      = 3
          orgid_not_in_norg = 4
          OTHERS            = 5.
      e_rc = sy-subrc.
      e_called = on.
      IF e_rc <> 0.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'S'
            i_kla           = 'NF'
            i_num           = '012'
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
*     Export
      IF l_nothing_selected = off.
        e_selected = on.
        e_value    = ls_norg-orgid.
      ENDIF.

*   etrgp
    WHEN cl_ish_corder=>co_etrby_gp.
      CALL FUNCTION 'ISH_SHOW_GPART'
        EXPORTING
          aufruf      = 'Y'
          loe_disp    = ' '
          rolle       = '0'    " Geschäftspartner
          sperr_disp  = ' '
          vcode       = l_vcode
        IMPORTING
          e_ngpa      = ls_ngpa
        EXCEPTIONS
          einri_false = 1
          gschl_false = 2
          ktart_false = 3
          not_found   = 4
          OTHERS      = 5.
      e_rc = sy-subrc.
      e_called = on.
      IF e_rc <> 0.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'S'
            i_kla           = 'NF'
            i_num           = '012'
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
*     Export
      IF NOT ls_ngpa-gpart IS INITIAL.
        e_selected = on.
        e_value    = ls_ngpa-gpart.
      ENDIF.
  ENDCASE.

ENDMETHOD.


METHOD value_request_gpart .

  DATA: ls_ngpa      TYPE ngpa,
        l_etrby      TYPE n1corder-etrby,
        l_vcode      TYPE tndym-vcode,
        l_rc         TYPE ish_method_rc.

* Initializations
  e_rc      = 0.
  e_called  = off.
  e_selected = off.

* Get etrby.
  l_etrby = get_etrby_from_fv( ).

* Handle vcode.
  l_vcode = g_vcode.
* Just use display/update (not insert).
  IF l_vcode = co_vcode_insert.
    l_vcode = co_vcode_update.
  ENDIF.
* Since there is only one field for initiator gpa and vma (etrgp)
* do no allow vma-input for initiator=gpa.
  IF l_vcode = co_vcode_update AND
     l_etrby = cl_ish_corder=>co_etrby_gp.
    l_vcode = co_vcode_display.
  ENDIF.

* Show f4 for vma
  CALL FUNCTION 'ISH_SHOW_GPART'
    EXPORTING
      aufruf      = 'Y'
      rolle       = '1'    " Person
      vcode       = l_vcode
      arzt        = 'X'
      makz        = 'X'
    IMPORTING
      e_ngpa      = ls_ngpa
    EXCEPTIONS
      einri_false = 1
      gschl_false = 2
      ktart_false = 3
      not_found   = 4
      OTHERS      = 5.
  e_rc = sy-subrc.

* F4 has been called
  e_called   = on.

* Errorhandling
  IF e_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'S'
        i_kla           = 'NF'
        i_num           = '012'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* Export
  IF NOT ls_ngpa-gpart IS INITIAL.
    e_selected = on.
    e_value    = ls_ngpa-gpart.
  ENDIF.

ENDMETHOD.


METHOD value_request_internal .

* Initializations.
  CLEAR: e_rc.

  CASE i_fieldname.
    WHEN g_fieldname_gpart.
      CALL METHOD value_request_gpart
        IMPORTING
          e_called        = e_called
          e_selected      = e_selected
          e_value         = e_value
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
    WHEN g_fieldname_etroegp.
      CALL METHOD value_request_etroegp
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
