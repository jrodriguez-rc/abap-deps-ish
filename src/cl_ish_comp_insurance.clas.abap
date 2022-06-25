class CL_ISH_COMP_INSURANCE definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

*"* public components of class CL_ISH_COMP_INSURANCE
*"* do not include other source files here!!!
public section.

  constants CO_CLASSID type N1COMPCLASSID value 'CL_ISH_COMP_INSURANCE'. "#EC NOTEXT
  constants CO_OTYPE_COMP_INSURANCE type ISH_OBJECT_TYPE value 8006. "#EC NOTEXT

  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .
  methods GET_INSURANCES
    importing
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default OFF
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
    exporting
      value(ET_INSURANCES) type ISH_T_INSURANCE_POLICY_PROV
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods IF_ISH_COMPONENT~CANCEL
    redefinition .
  methods IF_ISH_COMPONENT~CHECK
    redefinition .
  methods IF_ISH_COMPONENT~CHECK_CHANGES
    redefinition .
  methods IF_ISH_COMPONENT~GET_T_RUN_DATA
    redefinition .
  methods IF_ISH_COMPONENT~GET_T_UID
    redefinition .
  methods IF_ISH_COMPONENT~SAVE
    redefinition .
  methods IF_ISH_COMPONENT~SET_T_UID
    redefinition .
  methods IF_ISH_DOM~MODIFY_DOM_DATA
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_A
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_INSURANCE
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods TRANS_CORDER_TO_FV_INSURANCE
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IT_NIPP type ISH_T_NIPP
      !IT_POLICIES type ISH_T_INSURANCE_POLICY_PROV
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_FIELD_VAL type ISH_T_FIELD_VALUE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_TO_SCR_INSURANCE
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_INSURANCE type ref to CL_ISH_SCR_INSURANCE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_INSURANCE
    importing
      !IR_SCR_INSURANCE type ref to CL_ISH_SCR_INSURANCE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods COPY_DATA_INTERNAL
    redefinition .
  methods GET_DOM_FOR_RUN_DATA
    redefinition .
  methods INITIALIZE_METHODS
    redefinition .
  methods INITIALIZE_SCREENS
    redefinition .
  methods PREALLOC_FROM_EXTERNAL_INT
    redefinition .
  methods TRANSPORT_FROM_SCREEN_INTERNAL
    redefinition .
  methods TRANSPORT_TO_SCREEN_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_COMP_INSURANCE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_INSURANCE IMPLEMENTATION.


METHOD class_constructor .

  DATA: l_cdoc_field  TYPE rn1_cdoc_field,
        l_print_field TYPE rn1_print_field,
        l_fieldname   TYPE string,
        lt_fieldname  TYPE ish_t_string.

  CLEAR: gt_cdoc_field[],
         gt_print_field[].


* Build table for cdoc.

* NIPP
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype =
         cl_ish_insurance_policy_prov=>co_otype_prov_insurance_policy.
  l_cdoc_field-tabname     = 'NIPP'.

  l_fieldname              = 'IPID'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'KNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VNUMM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'MGART'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VZUZA'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VERBI'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'KVDAT'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* NIPP
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype =
         cl_ish_insurance_policy_prov=>co_otype_prov_insurance_policy.
  l_print_field-tabname     = 'NIPP'.

  l_fieldname              = 'IPID'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'KNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VNUMM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'MGART'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VZUZA'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VERBI'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'KVDAT'.
  APPEND l_fieldname TO lt_fieldname.

  l_print_field-t_fieldname = lt_fieldname.
  APPEND l_print_field TO gt_print_field.

ENDMETHOD.


METHOD constructor .

* Construct super class(es).
  CALL METHOD super->constructor.

* Set gr_t_cdoc_field.
  GET REFERENCE OF gt_cdoc_field INTO gr_t_cdoc_field.

* Set gr_t_print_field.
  GET REFERENCE OF gt_print_field INTO gr_t_print_field.

ENDMETHOD.


METHOD copy_data_internal.

* -------------------------------------------------------------------- *
*** ED, int. M. 0120061532 0001744985 2005: don't copy insurances!! ***
*** Grill, med-20702
* -------------------------------------------------------------------- *
  DATA: lt_run_data       TYPE ish_t_objectbase,
        lr_corder_new     TYPE REF TO cl_ish_corder,
        l_rc              TYPE ish_method_rc,
        lr_object         TYPE REF TO if_ish_objectbase,
        ls_object         TYPE ish_object,
        lt_con_obj        TYPE ish_objectlist,
        lr_insurance      TYPE REF TO cl_ish_insurance_policy_prov,
        lr_insurance_new  TYPE REF TO cl_ish_insurance_policy_prov,
        ls_data           TYPE rnipp_attrib.

  CHECK i_copy EQ on OR     "Grill, med-207023
        i_copy EQ 'L'.      "IXX-115 Naomi Popa 06.01.2015
  e_rc = 0.

* first call get_t_run_data from original component
  CALL METHOD ir_component_from->get_t_run_data
    IMPORTING
      et_run_data     = lt_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* fill lt_con_obj with corder
  lr_corder_new ?= gr_main_object.
  ls_object-object ?= gr_main_object.
  APPEND ls_object TO lt_con_obj.

* get insurances
  LOOP AT lt_run_data INTO lr_object.
    CHECK lr_object->is_inherited_from(
          co_otype_comp_insurance ) = on
.
    lr_insurance ?= lr_object.
*   get data from insurance
    CALL METHOD lr_insurance->get_data
      IMPORTING
        es_data        = ls_data
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   don't copy the cancelled insurances!!
    CHECK ls_data-storn = off.
*   clear some fields
    CLEAR: ls_data-vkgid.
*   create a new insurance
    CALL METHOD cl_ish_insurance_policy_prov=>create
      EXPORTING
        is_data              = ls_data
        i_environment        = gr_environment
        it_connected_objects = lt_con_obj
      IMPORTING
        e_instance           = lr_insurance_new
      EXCEPTIONS
        missing_environment  = 1
        OTHERS               = 2.
    l_rc = sy-subrc.
    IF l_rc <> 0.
      e_rc = l_rc.
*       MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                  WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        EXPORTING
*          I_TYP           =
*          I_PAR           =
          ir_object       = me
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD get_corder .

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.

  rr_corder ?= gr_main_object.

ENDMETHOD.


METHOD get_dom_for_run_data .

  DATA: lr_document_fragment TYPE REF TO if_ixml_document_fragment,
        lr_element           TYPE REF TO if_ixml_element,
        lr_text              TYPE REF TO if_ixml_text,
        lr_fragment          TYPE REF TO if_ixml_document_fragment,
        l_objecttype         TYPE i.
  DATA: lt_ddfields        TYPE ddfields,
        ls_cdoc            TYPE rn1_cdoc,
        l_fieldname        TYPE string,
        l_get_all_fields   TYPE c,
        l_field_supported  TYPE c,
        l_field_value      TYPE string,
        ls_field           TYPE rn1_field,
        l_key              TYPE string,
        l_rc               TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies.

  FIELD-SYMBOLS: <lt_print_field> TYPE ish_t_print_field,
                 <ls_print_field> TYPE rn1_print_field.

  DATA: lt_fields           TYPE ish_t_field.
  DATA: lr_element_body     TYPE REF TO if_ixml_element,
        lr_element_group    TYPE REF TO if_ixml_element,
        l_first_time        TYPE ish_on_off,
        lr_element_last_row TYPE REF TO if_ixml_element,
        l_string            TYPE string,
        lr_node_map         TYPE REF TO if_ixml_named_node_map,
        lr_node_last_row    TYPE REF TO if_ixml_node,
        l_index             TYPE i.

* Init.
  CLEAR er_document_fragment.

  CHECK NOT ir_document IS INITIAL.
  CHECK NOT ir_run_data IS INITIAL.

  CHECK ir_run_data->is_inherited_from(
        cl_ish_insurance_policy_prov=>co_otype_prov_insurance_policy ) = on.

  CHECK gr_t_print_field IS BOUND.
  ASSIGN gr_t_print_field->* TO <lt_print_field>.
  CHECK sy-subrc = 0.

  IF NOT ir_element IS INITIAL.
*   Get element group.
    lr_element_group =
      ir_element->find_from_name_ns( depth = 0
                                     name = 'ELEMENTGROUP'
                                     uri = '' ).
    IF NOT lr_element_group IS INITIAL.
*     Existing element group => get element body.
      lr_element_body =
       lr_element_group->find_from_name_ns( depth = 0
                                            name = 'ELEMENTBODY'
                                            uri = '' ).
      IF NOT lr_element_body IS INITIAL.
*       Existing element body => get last child.
        lr_node_last_row = lr_element_body->get_last_child( ).
        IF NOT lr_node_last_row IS INITIAL.
          lr_element_last_row ?= lr_node_last_row.
*         Get last child's row id.
          l_string =
           lr_element_last_row->get_attribute_ns( name = 'RID' ).
          l_index = l_string.
*         Compute new row id.
          l_index = l_index + 1.
        ENDIF.
      ENDIF.
    ELSE.
*     No element group.
      l_first_time = on.
      l_index = 1.
    ENDIF.
  ENDIF.

  IF l_first_time = on.
*   No element group => create DOM fragment.
    lr_document_fragment = ir_document->create_document_fragment( ).
  ENDIF.

  LOOP AT <lt_print_field> ASSIGNING <ls_print_field>.
*   Check data object's type.
    l_objecttype = <ls_print_field>-objecttype.
    CHECK ir_run_data->is_inherited_from( l_objecttype ) = on.

    CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
      EXPORTING
        i_data_name     = <ls_print_field>-tabname
*      IR_OBJECT       =
      IMPORTING
        et_ddfields     = lt_ddfields
        e_rc            = l_rc
*    CHANGING
*      CR_ERRORHANDLER = cr_errorhandler
     .
    CHECK l_rc = 0.
    CHECK NOT lt_ddfields IS INITIAL.

    IF <ls_print_field>-t_fieldname IS INITIAL.
      l_get_all_fields = 'X'.
    ENDIF.

    LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
      CLEAR: l_field_supported.
      IF NOT l_get_all_fields = 'X'.
        LOOP AT <ls_print_field>-t_fieldname INTO l_fieldname.
          IF <ls_ddfield>-fieldname = l_fieldname.
            l_field_supported = 'X'.
          ENDIF.
        ENDLOOP.
        CHECK l_field_supported = 'X'.
      ENDIF.
*     Get field value.
      CALL METHOD ir_run_data->get_data_field
        EXPORTING
*          I_FILL          = OFF
          i_fieldname     = <ls_ddfield>-fieldname
        IMPORTING
*          E_RC            =
          e_field         = l_field_value
*          E_FLD_NOT_FOUND =
*        CHANGING
*          C_ERRORHANDLER  =
          .

*     Fill field structure and append to field table.
      CLEAR ls_field.
      ls_field-tabname    = <ls_print_field>-tabname.
      ls_field-fieldname  = <ls_ddfield>-fieldname.
      ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
      ls_field-fieldvalue = l_field_value.
      ls_field-fieldprint = l_field_value.
      ls_field-display    = on.
      APPEND ls_field TO lt_fields.
    ENDLOOP.
*    EXIT.
  ENDLOOP.

* Get component element.
  l_string = 'Versicherungen'(001).
  CALL METHOD cl_ish_utl_xml=>get_dom_complex_element
    EXPORTING
      it_field   = lt_fields
      i_display  = on
      i_is_group = on
      i_index    = l_index
      i_compname = l_string
    IMPORTING
      er_element = lr_element.

  IF l_first_time = on.
*   Append component element to component DOM fragment
    l_rc = lr_document_fragment->append_child(
                                        new_child = lr_element ).
  ELSE.
    IF NOT lr_element_body IS INITIAL.
*     Append component element to body element.
      l_rc = lr_element_body->append_child( lr_element ).
    ENDIF.
  ENDIF.

* Modify DOM fragment
  CALL METHOD modify_dom_data
    IMPORTING
      e_rc                 = l_rc
    CHANGING
*      cr_errorhandler      = cr_errorhandler
      cr_document_fragment = lr_document_fragment
      cr_element           = lr_element_body.

* Export DOM fragment
  er_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD get_insurances .

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        lr_insurance     TYPE REF TO cl_ish_insurance_policy_prov,
        lt_object        TYPE ish_objectlist,
        l_cancelled      TYPE ish_on_off,
        l_deleted        TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_object>  TYPE ish_object.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get all connected insurances from corder.
  CALL METHOD lr_corder->get_connections
    EXPORTING
      i_type     = cl_ish_insurance_policy_prov=>co_otype_prov_insurance_policy
    IMPORTING
      et_objects = lt_object.

* Build et_insurances.
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    lr_insurance ?= <ls_object>-object.
    IF i_cancelled_datas = off.
      CALL METHOD lr_insurance->is_cancelled
        IMPORTING
          e_cancelled = l_cancelled
          e_deleted   = l_deleted.
      CHECK l_cancelled = off.
      CHECK l_deleted   = off.
    ENDIF.
    APPEND lr_insurance TO et_insurances.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~cancel.

* Michael Manoch, 05.07.2004, ID 14907
* Redefine the method to cancel the insurances.

  DATA: lt_insurance  TYPE ish_t_insurance_policy_prov,
        lr_insurance  TYPE REF TO cl_ish_insurance_policy_prov.

* Get insurance objects.
  CALL METHOD get_insurances
    IMPORTING
      et_insurances   = lt_insurance
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Process each insurance object.
  LOOP AT lt_insurance INTO lr_insurance.
    CHECK NOT lr_insurance IS INITIAL.
*   Cancel insurance object.
    CALL METHOD lr_insurance->cancel
      EXPORTING
        i_check_only   = i_check_only
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component~check .

  DATA: lt_insurances   TYPE ish_t_insurance_policy_prov,
        lr_insurance    TYPE REF TO cl_ish_insurance_policy_prov.

* ED, int. M. 0120061532 0001261428 2005 -> BEGIN
* Process super method.
  CALL METHOD super->if_ish_component~check
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ED, int. M. 0120061532 0001261428 2005 -> END

* Get all insurance objects.
  CALL METHOD get_insurances
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_insurances     = lt_insurances
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each insurance object.
  LOOP AT lt_insurances INTO lr_insurance.
    CHECK NOT lr_insurance IS INITIAL.
*   Check insurance object.
    CALL METHOD lr_insurance->check
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component~check_changes .

  DATA: lt_insurances   TYPE ish_t_insurance_policy_prov,
        lr_insurance    TYPE REF TO cl_ish_insurance_policy_prov.

* Get all insurance objects.
  CALL METHOD get_insurances
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_insurances     = lt_insurances
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each insurance object.
  LOOP AT lt_insurances INTO lr_insurance.
    CHECK NOT lr_insurance IS INITIAL.
*   Check radiology object for changes
    e_changed = lr_insurance->is_changed( ).
    IF e_changed = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~get_t_run_data .

  DATA: lt_insurance  TYPE ish_t_insurance_policy_prov.

* Handle objects of super class.
  CALL METHOD super->if_ish_component~get_t_run_data
    IMPORTING
      et_run_data     = et_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get insurance objects.
  CALL METHOD get_insurances
    IMPORTING
      et_insurances   = lt_insurance
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Append insurance objects.
  APPEND LINES OF lt_insurance TO et_run_data.

ENDMETHOD.


METHOD if_ish_component~get_t_uid .

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        lr_obj           TYPE REF TO cl_ish_insurance_policy_prov,
        lt_object        TYPE ish_objectlist,
        ls_key           TYPE rnipp_key,
        l_uid            TYPE sysuuid_c.

  FIELD-SYMBOLS: <ls_object>  TYPE ish_object.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get all connected insurances from corder.
  CALL METHOD lr_corder->get_connections
    EXPORTING
      i_type     = cl_ish_insurance_policy_prov=>co_otype_prov_insurance_policy
    IMPORTING
      et_objects = lt_object.

* For every insurance:
*   - Get its stringified key.
*   - Add the key to et_uid.
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    lr_obj ?= <ls_object>-object.
    CALL METHOD lr_obj->get_data
      IMPORTING
        es_key = ls_key.
    CHECK NOT ls_key-ippno IS INITIAL.
    l_uid = ls_key-ippno.
    APPEND l_uid TO rt_uid.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~save .

  DATA: lt_insurances   TYPE ish_t_insurance_policy_prov,
        lr_insurance    TYPE REF TO cl_ish_insurance_policy_prov,
        ls_nipp_key     TYPE rnipp_key,
        l_uid           TYPE sysuuid_c.

* Get all insurance objects.
  CALL METHOD get_insurances
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_insurances     = lt_insurances
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each insurance object.
  LOOP AT lt_insurances INTO lr_insurance.
    CHECK NOT lr_insurance IS INITIAL.
*   Save insurance object.
    CALL METHOD lr_insurance->save
      EXPORTING
        i_testrun           = i_testrun
        i_tcode             = i_tcode
        i_save_conn_objects = off
      IMPORTING
        e_rc                = e_rc
      CHANGING
        c_errorhandler      = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   Handle et_uid_save.
    CALL METHOD lr_insurance->get_data
      IMPORTING
        es_key = ls_nipp_key.
    l_uid = ls_nipp_key-ippno.
    IF l_uid NE '0000000000'.    "Grill, ID-18347
      APPEND l_uid TO et_uid_save.
    ENDIF.                       "Grill, ID-18347
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component~set_t_uid .

  DATA: lr_obj        TYPE REF TO cl_ish_insurance_policy_prov,
        lr_corder     TYPE REF TO cl_ish_corder,
        ls_key        TYPE rnipp_key.

  FIELD-SYMBOLS: <l_uid>  TYPE sysuuid_c.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* For every uid:
*   - Load the corresponding object
*   - Connect it with corder.
  LOOP AT it_uid ASSIGNING <l_uid>.
    CHECK NOT <l_uid> IS INITIAL.
    CLEAR ls_key.
    ls_key-ippno = <l_uid>.
*   Load object.
    CALL METHOD cl_ish_insurance_policy_prov=>load
      EXPORTING
        is_key              = ls_key
        i_environment       = gr_environment
      IMPORTING
        e_instance          = lr_obj
      EXCEPTIONS
        missing_environment = 1
        not_found           = 2
        OTHERS              = 3.
    CHECK sy-subrc = 0.  " Ignore errors
    CHECK NOT lr_obj IS INITIAL.
*   Connect with corder.
    CALL METHOD lr_corder->add_connection
      EXPORTING
        i_object = lr_obj.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_dom~modify_dom_data.

  DATA: lr_changing_node       TYPE REF TO if_ixml_node,
        lr_document_fragment   TYPE REF TO if_ixml_document_fragment,
        lr_root_node           TYPE REF TO if_ixml_node,
        lr_elementrow_filter   TYPE REF TO if_ixml_node_filter,
        lr_elementrow_iterator TYPE REF TO if_ixml_node_iterator,
        lr_element             TYPE REF TO if_ixml_element,
        lr_elementrow_node     TYPE REF TO if_ixml_node,
        lr_elementrow_elem     TYPE REF TO if_ixml_element,
        lr_elementval_nodes    TYPE REF TO if_ixml_node_list,
        lr_elementval_node     TYPE REF TO if_ixml_node,
        lr_elementval_elem     TYPE REF TO if_ixml_element,
        l_name                 TYPE string,
        l_value                TYPE string,
        l_value1               TYPE string,
        l_index                TYPE i,
        l_einri                TYPE tn01-einri,
        l_mgart                TYPE mitart_ver,
        l_mtext                TYPE mitart_txt,
        l_tn16m                TYPE tn16m,
        l_nzzgr                TYPE grkzz,
        l_nzzgt_txt            TYPE grkzt,
        l_tn22a                TYPE tn22a,
        l_table_field          TYPE tabfield,
        l_cdat_in              TYPE char10,
        l_cdat_out             TYPE char10.

  e_rc = 0.

* No document => no action.
  IF cr_document_fragment IS BOUND.
    lr_changing_node ?= cr_document_fragment.
  ELSE.
    lr_changing_node ?= cr_element.
  ENDIF.
  CHECK lr_changing_node IS BOUND.

* Check/create errorhandler.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Get ROOT NODE.
  CALL METHOD lr_changing_node->get_root
    RECEIVING
      rval = lr_root_node.
  CHECK NOT lr_root_node IS INITIAL.

* Create ELEMENTROW filter.
  lr_elementrow_filter =
     lr_root_node->create_filter_name_ns( name = 'ELEMENTROW'
                                          namespace = '' ).
* Create ELEMENTROW iterator.
  lr_elementrow_iterator =
    lr_root_node->create_iterator_filtered(
                                  filter = lr_elementrow_filter ).

* Get first ELEMENTROW node.
  lr_elementrow_node = lr_elementrow_iterator->get_next( ).
* Do while nodes found.
  WHILE NOT lr_elementrow_node IS INITIAL.
*   Cast node to element.
    lr_elementrow_elem ?= lr_elementrow_node.
    CHECK lr_elementrow_elem IS BOUND.
*   Get children .
    lr_elementval_nodes = lr_elementrow_elem->get_children( ).
    l_index = 0.
    WHILE l_index < lr_elementval_nodes->get_length( ).
      lr_elementval_node =
                    lr_elementval_nodes->get_item( l_index ).
      lr_elementval_elem ?= lr_elementval_node.
      l_name   = lr_elementval_elem->get_attribute( name = 'NAME' ).
      l_value1 = lr_elementval_elem->get_attribute( name = 'VALUE' ).
      l_value  = lr_elementval_elem->get_value( ).
      CASE l_name.
*       IPID
        WHEN 'IPID'.
*         No leading 0.
          SHIFT l_value LEFT DELETING LEADING '0'.
*         Modify element value in DOM node
          e_rc = lr_elementval_elem->set_value( l_value ).
*       MGART
        WHEN 'MGART'.
*         Do only if not converted yet.
          IF l_value = l_value1.
*           Get institution.
            l_einri =
            cl_ish_utl_base=>get_institution_of_obj( gr_main_object )
  .
            IF l_einri IS INITIAL.
              EXIT.
            ENDIF.
*           Get text.
            l_mgart = l_value.
            CALL FUNCTION 'ISH_MGART_CHECK'
              EXPORTING
                ss_einri  = l_einri
                ss_mgart  = l_mgart
                ss_langu  = sy-langu
              IMPORTING
                ss_tn16m  = l_tn16m
                ss_mtext  = l_mtext
              EXCEPTIONS
                not_found = 1
                OTHERS    = 2.
            IF sy-subrc = 0.
              l_value = l_mtext.
            ENDIF.
*           Modify element value in DOM node
            e_rc = lr_elementval_elem->set_value( l_value ).
          ENDIF.
*       NZZGR
        WHEN 'NZZGR'.
*         Do only if not converted yet.
          IF l_value = l_value1.
*           Get institution.
            l_einri =
            cl_ish_utl_base=>get_institution_of_obj( gr_main_object )
  .
            IF l_einri IS INITIAL.
              EXIT.
            ENDIF.
*           Get text.
            l_nzzgr = l_value.
            CALL FUNCTION 'ISH_NZZGR_CHECK'
              EXPORTING
                ss_einri     = l_einri
                ss_nzzgr     = l_nzzgr
                ss_langu     = sy-langu
              IMPORTING
                ss_nzzgt_txt = l_nzzgt_txt
                ss_tn22a     = l_tn22a
              EXCEPTIONS
                not_found    = 1
                OTHERS       = 2.
            IF sy-subrc = 0.
              l_value = l_nzzgt_txt.
            ENDIF.
*           Modify element value in DOM node
            e_rc = lr_elementval_elem->set_value( l_value ).
          ENDIF.
*       VERBI, KVDAT
        WHEN 'VERBI' OR 'KVDAT'.
*         Do only if not converted yet.
          IF l_value = l_value1.
*           Convert date from intern to extern.
            l_cdat_in = l_value.
            l_table_field-tabname   = 'SY'.
            l_table_field-fieldname = 'DATUM'.
            IF l_cdat_in = '00000000'.
              l_value = space.
            ELSE.
              CALL FUNCTION 'RS_DS_CONV_IN_2_EX'
                EXPORTING
                  input            = l_cdat_in
                  table_field      = l_table_field
                IMPORTING
                  output           = l_cdat_out
                EXCEPTIONS
                  conversion_error = 1
                  OTHERS           = 2.
              IF sy-subrc = 0.
                l_value = l_cdat_out.
              ENDIF.
            ENDIF.
*           Modify element value in DOM node
            e_rc = lr_elementval_elem->set_value( l_value ).
          ENDIF.
        WHEN OTHERS.
      ENDCASE.
      l_index = l_index + 1.
    ENDWHILE.
*   Get next ELEMENTROW node.
    lr_elementrow_node = lr_elementrow_iterator->get_next( ).
  ENDWHILE.

* Return modified document.
  IF cr_document_fragment IS BOUND.
    cr_document_fragment ?= lr_changing_node.
  ELSE.
    cr_element ?= lr_changing_node.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_insurance.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  IF i_object_type = co_otype_comp_insurance.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_insurance.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize_methods .

* initialize methods

ENDMETHOD.


METHOD initialize_screens.

  DATA: lr_scr_insurance        TYPE REF TO cl_ish_scr_insurance.

* create screen objects.
* screen insurance
  CALL METHOD cl_ish_scr_insurance=>create
    IMPORTING
      er_instance     = lr_scr_insurance
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Save all used screen object in gt_screen_objects.
  APPEND lr_scr_insurance TO gt_screen_objects.

ENDMETHOD.


METHOD prealloc_from_external_int.

* ED, ID 16882 -> BEGIN
  DATA: lt_ddfields       TYPE ddfields,
        l_rc              TYPE ish_method_rc,
        lr_corder         TYPE REF TO cl_ish_corder,
        ls_corder_x       TYPE rn1_corder_x,
        l_field_supported TYPE c,
        l_value           TYPE nfvvalue,
        ls_data_nipp      TYPE rnipp_attrib,
        lt_con_obj        TYPE ish_objectlist,
        ls_object         TYPE ish_object,
        lr_insurance      TYPE REF TO cl_ish_insurance_policy_prov,
        l_fname           TYPE string,
        l_compid          TYPE n1comp-compid,
        l_index           TYPE i.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies,
                 <ls_mapping> TYPE ishmed_migtyp_l,
                 <fst>        TYPE ANY.

  e_rc = 0.

* get clinical order
  CALL METHOD me->get_corder
    RECEIVING
      rr_corder = lr_corder.

* fill lt_con_obj with corder
  ls_object-object ?= lr_corder.
  APPEND ls_object TO lt_con_obj.

* get compid
  CALL METHOD me->get_compid
    RECEIVING
      r_compid = l_compid.

* insurance *************************************
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = 'NIPP'
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  l_index = 0.
  DO.
    l_index = l_index + 1.
    CLEAR: ls_data_nipp.
    LOOP AT it_mapping ASSIGNING <ls_mapping>
        WHERE instno = l_index
          AND compid = l_compid.
      LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
        CLEAR: l_field_supported.
        CHECK <ls_mapping>-fieldname = <ls_ddfield>-fieldname.
        l_field_supported = 'X'.
        CHECK l_field_supported = 'X'.
*       fill changing structure
        CONCATENATE 'LS_DATA_NIPP-' <ls_mapping>-fieldname INTO l_fname.
        ASSIGN (l_fname) TO <fst>.
        <fst> = <ls_mapping>-fvalue.
      ENDLOOP. "LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
    ENDLOOP. "LOOP AT it_mapping ASSIGNING <ls_mapping>
    IF sy-subrc <> 0.
      EXIT.
    ELSE.
*     create a new insurance
      CALL METHOD cl_ish_insurance_policy_prov=>create
        EXPORTING
          is_data              = ls_data_nipp
          i_environment        = gr_environment
          it_connected_objects = lt_con_obj
        IMPORTING
          e_instance           = lr_insurance
        EXCEPTIONS
          missing_environment  = 1
          OTHERS               = 2.
      l_rc = sy-subrc.
*     errorhandling
      IF l_rc <> 0.
        e_rc = l_rc.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
          EXPORTING
            ir_object       = me
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
    ENDIF. "IF sy-subrc <> 0.
  ENDDO.
  CHECK e_rc = 0.
* ED, ID 16882 -> END

ENDMETHOD.


METHOD transport_from_screen_internal.

* The insurance screen uses an old subscreen.
* Therefore refresh the screen's field values at pbo and pai.
  CALL METHOD transport_to_screen_internal
    EXPORTING
      ir_screen       = ir_screen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD transport_to_screen_internal.

  DATA: lr_scr_insurance TYPE REF TO cl_ish_scr_insurance.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_insurance=>co_otype_scr_insurance ) = on.
    lr_scr_insurance ?= ir_screen.
    CALL METHOD trans_to_scr_insurance
      EXPORTING
        ir_scr_insurance = lr_scr_insurance
      IMPORTING
        e_rc             = e_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_corder_to_fv_insurance .

  DATA: lr_policy             TYPE REF TO cl_ish_insurance_policy_prov,
        ls_nipp               TYPE nipp,
        ls_field_val          TYPE rnfield_value,
        lb_do_policy_1        TYPE ish_true_false,
        lb_do_policy_2        TYPE ish_true_false.

  lb_do_policy_1 = true.
  lb_do_policy_2 = true.

*------------------------------------------------------------
* There should only be one NIPP entry with a VZUZA flag.
* It is written to policy 3, which is the first to display.
* Other entries are displayed in order of appearance.
*------------------------------------------------------------

  LOOP AT it_nipp INTO ls_nipp.
    IF ls_nipp-vzuza = 'X'.
*     Do policy 3 now.
*     policy3
      CLEAR ls_field_val.
      ls_field_val-fieldname = 'POLICY3'.
*                   cl_ish_scr_insurance=>g_fieldname_policy_3.
      ls_field_val-type      = co_fvtype_identify.
      READ TABLE it_policies INTO lr_policy INDEX sy-tabix.
      IF sy-subrc = 0.
        ls_field_val-object  = lr_policy.
      ENDIF.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     vzuza
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_vzuza.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-vzuza.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     kname
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_kname.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-kname.
      INSERT ls_field_val INTO TABLE ct_field_val.
    ELSEIF lb_do_policy_1 = true.
*     Do policy 1 now.
*     policy1
      CLEAR ls_field_val.
      ls_field_val-fieldname = 'POLICY1'.
*                   cl_ish_scr_insurance=>g_fieldname_policy_1.
      ls_field_val-type      = co_fvtype_identify.
      READ TABLE it_policies INTO lr_policy INDEX sy-tabix.
      IF sy-subrc = 0.
        ls_field_val-object  = lr_policy.
      ENDIF.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     ipid
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_ipid_1.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-ipid.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     kname
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_kname_1.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-kname.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     kvdat
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_kvdat_1.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-kvdat.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     mgart
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_mgart_1.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-mgart.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     verbi
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_verbi_1.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-verbi.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     vnumm
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_vnumm_1.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-vnumm.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     Set flag policy 1 already done.
      lb_do_policy_1         = false.
    ELSEIF lb_do_policy_2 = true.
*     Do policy 2 now.
*     policy2
      CLEAR ls_field_val.
      ls_field_val-fieldname = 'POLICY2'.
*                   cl_ish_scr_insurance=>g_fieldname_policy_2.
      ls_field_val-type      = co_fvtype_identify.
      READ TABLE it_policies INTO lr_policy INDEX sy-tabix.
      IF sy-subrc = 0.
        ls_field_val-object  = lr_policy.
      ENDIF.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     ipid
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_ipid_2.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-ipid.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     kname
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_kname_2.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-kname.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     kvdat
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_kvdat_2.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-kvdat.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     mgart
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_mgart_2.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-mgart.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     verbi
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_verbi_2.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-verbi.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     vnumm
      CLEAR ls_field_val.
      ls_field_val-fieldname =
                   cl_ish_scr_insurance=>g_fieldname_vnumm_2.
      ls_field_val-type      = co_fvtype_single.
      ls_field_val-value     = ls_nipp-vnumm.
      INSERT ls_field_val INTO TABLE ct_field_val.
*     Set flag policy 2 already done.
      lb_do_policy_2         = false.
    ELSE.
*     No place for additional policy.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD trans_corder_to_scr_insurance .

  DATA: ls_n1corder           TYPE n1corder,
        lt_policies           TYPE ish_t_insurance_policy_prov,
        lt_nipp               TYPE ish_t_nipp,
        lt_field_val          TYPE ish_t_field_value.

  CHECK NOT ir_corder           IS INITIAL.
  CHECK NOT ir_scr_insurance    IS INITIAL.

* Get corder data.
  CALL METHOD ir_corder->get_insur_policies
    EXPORTING
      ir_environment  = gr_environment
    IMPORTING
      e_rc            = e_rc
      et_policies     = lt_policies
      et_nipp         = lt_nipp
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Build field values.
  CLEAR lt_field_val.
  CALL METHOD trans_corder_to_fv_insurance
    EXPORTING
      ir_corder       = ir_corder
      it_policies     = lt_policies
      it_nipp         = lt_nipp
    IMPORTING
      e_rc            = e_rc
    CHANGING
      ct_field_val    = lt_field_val
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Set main object in insurance screen.
  CALL METHOD ir_scr_insurance->set_data
    EXPORTING
      i_main_object   = ir_corder
      i_main_object_x = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Set field values in insurance screen.
  CALL METHOD ir_scr_insurance->set_fields
    EXPORTING
      it_field_values  = lt_field_val
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_to_scr_insurance .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object      IS INITIAL.
  CHECK NOT ir_scr_insurance    IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_to_scr_insurance
      EXPORTING
        ir_corder        = lr_corder
        ir_scr_insurance = ir_scr_insurance
      IMPORTING
        e_rc             = e_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.
ENDCLASS.
