class CL_ISH_COMP_PATIENT definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

*"* public components of class CL_ISH_COMP_PATIENT
*"* do not include other source files here!!!
public section.

  constants CO_CLASSID type N1COMPCLASSID value 'CL_ISH_COMP_PATIENT'. "#EC NOTEXT
  constants CO_OTYPE_COMP_PATIENT type ISH_OBJECT_TYPE value 8000. "#EC NOTEXT

  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .

  methods IF_ISH_COMPONENT~GET_T_RUN_DATA
    redefinition .
  methods IF_ISH_DOM~MODIFY_DOM_DATA
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_PATIENT
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods TRANS_CORDER_FROM_SCR_PATIENT
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_PATIENT type ref to CL_ISH_SCR_PATIENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_TO_SCR_PATIENT
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_PATIENT type ref to CL_ISH_SCR_PATIENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_FROM_SCR_PATIENT
    importing
      !IR_SCR_PATIENT type ref to CL_ISH_SCR_PATIENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_PATIENT
    importing
      !IR_SCR_PATIENT type ref to CL_ISH_SCR_PATIENT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods GET_CDOC_FOR_RUN_DATA
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
*"* private components of class CL_ISH_COMP_PATIENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_PATIENT IMPLEMENTATION.


METHOD class_constructor .

  DATA: l_cdoc_field  TYPE rn1_cdoc_field,
        l_print_field TYPE rn1_print_field,
        l_fieldname   TYPE string,
        lt_fieldname  TYPE ish_t_string.

  CLEAR: gt_cdoc_field[],
         gt_print_field[].

* Build table for cdoc.

* NPAT
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  = cl_ishmed_none_oo_npat=>co_otype_none_oo_npat.
  l_cdoc_field-tabname     = 'NPAT'.

  l_fieldname              = 'NNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GBNAM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GBDAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GSCHL'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'TELF1'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'TITEL'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'NAMZU'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VORSW'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'PATNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'EXTNR'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.

* NPAP
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  = cl_ishmed_patient_provisional=>co_otype_prov_patient.
  l_cdoc_field-tabname     = 'NPAP'.

  l_fieldname              = 'NNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GBNAM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GBDAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GSCHL'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'TELF1'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'TITEL'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'NAMZU'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VORSW'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'PAPID'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'EXTNR'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.

* NADR
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  = cl_ish_address=>co_otype_address.
  l_cdoc_field-tabname     = 'NADR'.

  l_fieldname              = 'EMAIL'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* NPAT
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ishmed_none_oo_npat=>co_otype_none_oo_npat.
  l_print_field-tabname     = 'NPAT'.

  l_fieldname              = 'NNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GBNAM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GBDAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GSCHL'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'TELF1'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'TITEL'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'NAMZU'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VORSW'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'PATNR'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'EXTNR'.
  APPEND l_fieldname TO lt_fieldname.

  l_print_field-t_fieldname = lt_fieldname.
  APPEND l_print_field TO gt_print_field.

* NPAP
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ishmed_patient_provisional=>co_otype_prov_patient.
  l_print_field-tabname     = 'NPAP'.

  l_fieldname              = 'NNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VNAME'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GBNAM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GBDAT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'GSCHL'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'TELF1'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'TITEL'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'NAMZU'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'VORSW'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'PAPID'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'EXTNR'.
  APPEND l_fieldname TO lt_fieldname.

  l_print_field-t_fieldname = lt_fieldname.
  APPEND l_print_field TO gt_print_field.

* NADR
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ish_address=>co_otype_address.
  l_print_field-tabname     = 'NADR'.

  l_fieldname              = 'EMAIL'.
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


METHOD get_cdoc_for_run_data.

  DATA: ls_n1corder              TYPE n1corder,
        lr_corder                TYPE REF TO cl_ish_corder,
        l_objecttype             TYPE i,
        lt_cdoc                  TYPE ish_t_cdoc,
        lr_pap                   TYPE REF TO
                                 cl_ishmed_patient_provisional,
        l_patnr                  TYPE npat-patnr,
        ls_npat                  TYPE npat,
        ls_npap                  TYPE npap,
        ls_nadr                  TYPE nadr,
        l_rc                     TYPE i,
        l_key_string             TYPE string,
        l_key_string_adr         TYPE string,
        lr_patient_provisional   TYPE REF TO
                                 cl_ish_patient_provisional.

  FIELD-SYMBOLS: <lt_cdoc_field> TYPE ish_t_cdoc_field,
                 <ls_cdoc_field> TYPE rn1_cdoc_field,
                 <ls_cdoc>       TYPE rn1_cdoc.

  CLEAR: et_cdoc[],
         l_objecttype,
         ls_npat,
         ls_nadr,
         l_key_string,
         l_key_string_adr.

  CHECK NOT ir_run_data IS INITIAL.

* Get NPAT from CORDER object.
  IF ir_run_data->is_inherited_from(
       cl_ish_corder=>co_otype_corder ) = on.

    lr_corder ?= ir_run_data.

    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder     = ls_n1corder
        e_rc            = l_rc
*      CHANGING
*        CR_ERRORHANDLER = cr_errorhandler
        .
    CHECK l_rc = 0.
    CHECK NOT ls_n1corder IS INITIAL.
    CHECK ls_n1corder-reftyp = lr_corder->co_reftyp_pat.

    l_objecttype = cl_ishmed_none_oo_npat=>co_otype_none_oo_npat.

*   patnr
    CONCATENATE ls_n1corder-mandt
                ls_n1corder-patnr
           INTO l_key_string.

*   Read from db.
    l_patnr = ls_n1corder-patnr.
    CALL METHOD cl_ish_dbr_pat=>get_pat_data_by_patnr
      EXPORTING
        i_patnr     = l_patnr
        i_with_nadr = on
      IMPORTING
        es_npat     = ls_npat
        es_nadr     = ls_nadr
        e_rc        = l_rc.
    CHECK l_rc = 0.

    IF NOT ls_nadr IS INITIAL.
      CONCATENATE ls_nadr-mandt
                  ls_nadr-adrnr
                  ls_nadr-adrob
             INTO l_key_string_adr.
    ENDIF.
  ENDIF.

* NPAP object.
  IF ir_run_data->is_inherited_from(
        cl_ishmed_patient_provisional=>co_otype_prov_patient ) = on.
    l_objecttype = cl_ishmed_patient_provisional=>co_otype_prov_patient.
  ENDIF.

* NPAP object.
  IF ir_run_data->is_inherited_from(
        cl_ish_address=>co_otype_address ) = on.
    l_objecttype = cl_ish_address=>co_otype_address.
  ENDIF.

  CHECK gr_t_cdoc_field IS BOUND.
  ASSIGN gr_t_cdoc_field->* TO <lt_cdoc_field>.
  CHECK sy-subrc = 0.

  LOOP AT <lt_cdoc_field> ASSIGNING <ls_cdoc_field>.
*   Check data object's type.
    CHECK <ls_cdoc_field>-objecttype = l_objecttype
       OR <ls_cdoc_field>-objecttype =
                           cl_ish_address=>co_otype_address.
*   Get data object's fields with cdoc flag.
    CLEAR lt_cdoc[].
    CALL METHOD cl_ish_utl_xml=>get_cdoc
      EXPORTING
        ir_run_data   = ir_run_data
        is_cdoc_field = <ls_cdoc_field>
      IMPORTING
        et_cdoc       = lt_cdoc.
    CHECK NOT lt_cdoc IS INITIAL.
*   Add tab_key.
    LOOP AT lt_cdoc ASSIGNING <ls_cdoc>.
      CASE <ls_cdoc>-tabname.
        WHEN 'NADR'.
          IF <ls_cdoc>-tab_key IS INITIAL.
            <ls_cdoc>-tab_key = l_key_string_adr.
          ENDIF.
        WHEN 'NPAT'.
          <ls_cdoc>-tab_key    = l_key_string.
*         RW ID 15022 - BEGIN
          <ls_cdoc>-objectclas = 'NPAT'.
          <ls_cdoc>-objectid   = l_key_string+3.
*         RW ID 15022 - END
        WHEN OTHERS.
      ENDCASE.
    ENDLOOP.
*   Append entries to export table.
    APPEND LINES OF lt_cdoc TO et_cdoc.
  ENDLOOP.

ENDMETHOD.


METHOD get_dom_for_run_data.

  DATA: lr_document_fragment TYPE REF TO if_ixml_document_fragment,
        lr_element           TYPE REF TO if_ixml_element,
        lr_text              TYPE REF TO if_ixml_text,
        lr_fragment          TYPE REF TO if_ixml_document_fragment,
        lr_pat_provisional   TYPE REF TO cl_ish_patient_provisional,
        l_objecttype         TYPE i.
  DATA: lt_ddfields          TYPE ddfields,
        ls_cdoc              TYPE rn1_cdoc,
        l_fieldname          TYPE string,
        l_fieldvalue         TYPE string,
        l_get_all_fields     TYPE c,
        l_field_supported    TYPE c,
        ls_field             TYPE rn1_field,
        l_key                TYPE string,
        l_patnr              TYPE npat-patnr,
        lr_corder            TYPE REF TO cl_ish_corder,
        ls_n1corder          TYPE n1corder,
        ls_npat              TYPE npat,
        ls_npap              TYPE npap,
        l_papid              TYPE rnpap_key,
        l_rc                 TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies.
  FIELD-SYMBOLS: <l_field>      TYPE ANY.
  FIELD-SYMBOLS: <lt_print_field> TYPE ish_t_print_field,
                 <ls_print_field> TYPE rn1_print_field.

  DATA: lt_fields          TYPE ish_t_field,
        l_string           TYPE string,
        l_index            TYPE i.

* Init.
  CLEAR: er_document_fragment,
         l_objecttype,
         lr_corder,
         ls_n1corder,
         ls_npat,
         l_papid.

  CHECK NOT ir_document IS INITIAL.
  CHECK NOT ir_run_data IS INITIAL.

* Get NPAT from CORDER object.
  IF ir_run_data->is_inherited_from(
        cl_ish_corder=>co_otype_corder ) = on.

    lr_corder ?= ir_run_data.

    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder     = ls_n1corder
        e_rc            = l_rc
*      CHANGING
*        CR_ERRORHANDLER = cr_errorhandler
        .
    CHECK l_rc = 0.
    CHECK NOT ls_n1corder IS INITIAL.
    CHECK ls_n1corder-reftyp = lr_corder->co_reftyp_pat.

    l_objecttype = cl_ishmed_none_oo_npat=>co_otype_none_oo_npat.

*   Read from db.
    l_patnr = ls_n1corder-patnr.
    CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
      EXPORTING
        i_patnr = l_patnr
      IMPORTING
        es_npat = ls_npat
        e_rc    = l_rc.
    CHECK l_rc = 0.
  ENDIF.

* NPAP object.
  IF ir_run_data->is_inherited_from(
        cl_ishmed_patient_provisional=>co_otype_prov_patient ) = on.
    l_objecttype = cl_ishmed_patient_provisional=>co_otype_prov_patient.
    lr_pat_provisional ?= ir_run_data.
    IF lr_pat_provisional IS BOUND.
      CALL METHOD lr_pat_provisional->get_data
        IMPORTING
          es_key = l_papid
          e_rc   = l_rc.
    ENDIF.
  ENDIF.

* NADR object.
  IF ir_run_data->is_inherited_from(
        cl_ish_address=>co_otype_address ) = on.
    l_objecttype = cl_ish_address=>co_otype_address.
  ENDIF.

  CHECK gr_t_print_field IS BOUND.
  ASSIGN gr_t_print_field->* TO <lt_print_field>.
  CHECK sy-subrc = 0.

* Create document fragment
  lr_document_fragment = ir_document->create_document_fragment( ).

  LOOP AT <lt_print_field> ASSIGNING <ls_print_field>.
*   Check data object's type.
    CHECK <ls_print_field>-objecttype = l_objecttype.
*   Get tab's ddfields.
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
      CLEAR: l_field_supported,
             l_fieldname,
             l_fieldvalue.
      IF l_get_all_fields = 'X'.
        l_fieldname = <ls_ddfield>-fieldname.
      ELSE.
        LOOP AT <ls_print_field>-t_fieldname INTO l_fieldname.
          IF <ls_ddfield>-fieldname = l_fieldname.
            l_field_supported = 'X'.
            EXIT.
          ENDIF.
        ENDLOOP.
        CHECK l_field_supported = 'X'.
      ENDIF.

      IF l_objecttype = cl_ishmed_none_oo_npat=>co_otype_none_oo_npat.
*       Special doings for NPAT because there is no data object.
        ASSIGN COMPONENT l_fieldname
          OF STRUCTURE ls_npat
          TO <l_field>.
        IF sy-subrc = 0.
          l_fieldvalue = <l_field>.
        ENDIF.
      ELSE.
*       Map fieldname.
        CASE l_fieldname.
          WHEN 'GSCHL'.
            l_fieldname = 'GSCHLE'.
          WHEN OTHERS.
        ENDCASE.
*       Get field value.
        CALL METHOD ir_run_data->get_data_field
          EXPORTING
*          I_FILL          = OFF
            i_fieldname     = l_fieldname
          IMPORTING
*          E_RC            =
            e_field         = l_fieldvalue
*          E_FLD_NOT_FOUND =
*        CHANGING
*          C_ERRORHANDLER  =
            .
*       No PAPID field value set in get_data_field.
        CASE l_fieldname.
          WHEN 'PAPID'.
            l_fieldvalue = l_papid.
          WHEN OTHERS.
        ENDCASE.
      ENDIF.
*     Fill field structure and append to field table.
      CLEAR ls_field.
      REFRESH lt_fields.
      ls_field-tabname    = <ls_print_field>-tabname.
      ls_field-fieldname  = <ls_ddfield>-fieldname.
      ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
      ls_field-fieldvalue = l_fieldvalue.
      ls_field-fieldprint = l_fieldvalue.
      ls_field-display    = on.
      APPEND ls_field TO lt_fields.
*     Get component element.
      CLEAR l_string.
      CALL METHOD cl_ish_utl_xml=>get_dom_complex_element
        EXPORTING
          it_field   = lt_fields
          i_display  = on
          i_is_group = off
          i_index    = l_index
          i_compname = l_string
        IMPORTING
          er_element = lr_element.
*     Append component element to component DOM fragment
      l_rc = lr_document_fragment->append_child(
                                          new_child = lr_element ).
    ENDLOOP.
*    EXIT.
  ENDLOOP.

* Modify DOM fragment
  CALL METHOD modify_dom_data
    IMPORTING
      e_rc                 = l_rc
    CHANGING
*      cr_errorhandler      = cr_errorhandler
      cr_document_fragment = lr_document_fragment.

* Export DOM fragment
  er_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD if_ish_component~get_t_run_data .

  DATA: lr_pap      TYPE REF TO cl_ish_patient_provisional,
        lr_address  TYPE REF TO cl_ish_address,
        l_found     TYPE ish_on_off.

* Handle objects of super class.
  CALL METHOD super->if_ish_component~get_t_run_data
    IMPORTING
      et_run_data     = et_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get pap
  CALL METHOD cl_ish_utl_base_patient=>get_pap_for_object
    EXPORTING
      i_object       = gr_main_object
    IMPORTING
      e_pap_obj      = lr_pap
      e_found        = l_found
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK l_found = on.
  CHECK NOT lr_pap IS INITIAL.

* Append pap.
  APPEND lr_pap TO et_run_data.

* Get address.
  lr_address = lr_pap->get_address( ).

* Append address.
  IF NOT lr_address IS INITIAL.
    APPEND lr_address TO et_run_data.
  ENDIF.

ENDMETHOD.


METHOD if_ish_dom~modify_dom_data.

  DATA: lr_document_fragment  TYPE REF TO if_ixml_document_fragment,
        lr_root_node          TYPE REF TO if_ixml_node,
        lr_node_iterator      TYPE REF TO if_ixml_node_iterator,
        lr_node               TYPE REF TO if_ixml_node,
        lr_node_name          TYPE REF TO if_ixml_node,
        lr_attributes         TYPE REF TO if_ixml_named_node_map,
        lr_node_first_child   TYPE REF TO if_ixml_node,
        lr_node_last_child    TYPE REF TO if_ixml_node,
        l_string_compel_name  TYPE string,
        l_string_el_name      TYPE string,
        l_string_el_value     TYPE string,
        l_table_field         TYPE tabfield,
        l_cdat_in             TYPE char10,
        l_cdat_out            TYPE char10.

  e_rc = 0.

* No document => no action.
  CHECK NOT cr_document_fragment IS INITIAL.

* Check/create errorhandler.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Received document to local variable.
  lr_document_fragment = cr_document_fragment.

* Get ROOT NODE.
  CALL METHOD lr_document_fragment->get_root
    RECEIVING
      rval = lr_root_node.

  CHECK NOT lr_root_node IS INITIAL.

* Create NODE ITERATOR.
  CALL METHOD lr_root_node->create_iterator
*  EXPORTING
*    DEPTH  = 0
    RECEIVING
      rval   = lr_node_iterator.

* Get first COMPELEMENT.
  lr_node = lr_node_iterator->get_next( ).

  WHILE NOT lr_node IS INITIAL.
    CLEAR: l_string_el_name,
           l_string_el_value,
           l_string_compel_name.
*----------------------------------------------------
*   The current DOM node should look like this:
*
*   <COMPELEMENT ROWID="1" COLID="1" NAME="email">
*      <ELEMENTTAG>Email</ELEMENTTAG>
*      <ELEMENTVAL>my.email@data.com</ELEMENTVAL>
*   </COMPELEMENT>
*----------------------------------------------------
    IF lr_node->get_name( ) EQ 'COMPELEMENT'.
*     Get COMPELEMENT attributes.
      lr_attributes = lr_node->get_attributes( ).

      IF NOT lr_attributes IS INITIAL.
*       Get NAME attribute.
        lr_node_name  = lr_attributes->get_named_item( 'NAME' ).

        IF NOT lr_node_name IS INITIAL.
*         Get first child of COMPELEMENT => ELEMENTTAG.
          lr_node_first_child = lr_node->get_first_child( ).
          IF NOT lr_node_first_child IS INITIAL.
            l_string_el_name = lr_node_first_child->get_value( ).
          ENDIF.
*         Get last child of COMPELEMENT => ELEMENTVAL.
          lr_node_last_child  = lr_node->get_last_child( ).
          IF NOT lr_node_last_child IS INITIAL.
            l_string_el_value = lr_node_last_child->get_value( ).
          ENDIF.

*         Check/change COMPELEMENT.
          l_string_compel_name = lr_node_name->get_value( ).
          CASE l_string_compel_name.
*           PATNR
            WHEN 'PATNR' OR 'PAPID'.
*             No leading 0.
              SHIFT l_string_el_value LEFT DELETING LEADING '0'.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
*           GBDAT
            WHEN 'GBDAT'.
*             Convert date from intern to extern.
              l_cdat_in = l_string_el_value.
              l_table_field-tabname   = 'SY'.
              l_table_field-fieldname = 'DATUM'.
              IF l_cdat_in = '00000000'.
                l_string_el_value = space.
              ELSE.
                CALL FUNCTION 'RS_DS_CONV_IN_2_EX'
                  EXPORTING
                    input                = l_cdat_in
*                    DESCR                =
                    table_field          = l_table_field
*                    CHECK_INPUT          =
                  IMPORTING
                    output               = l_cdat_out
                  EXCEPTIONS
                    conversion_error     = 1
                    OTHERS               = 2.
                IF sy-subrc <> 0.
*               MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                  WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
                ELSE.
                  l_string_el_value = l_cdat_out.
                ENDIF.
*             Modify element value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
              ENDIF.
*           GSCHL
            WHEN 'GSCHL'.
*             Map domain value.
              CALL METHOD cl_ish_utl_xml=>map_domain_value
                EXPORTING
                  i_domain        = 'GSCHL'
                  i_value         = l_string_el_value
                IMPORTING
                  e_text          = l_string_el_value
                  e_rc            = e_rc
                CHANGING
                  cr_errorhandler = cr_errorhandler.
*             Modify element value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
            WHEN OTHERS.
          ENDCASE.
        ENDIF.  "NAME
      ENDIF.  "attributes
    ENDIF.  "COMPELEMENT

*   Get next COMPELEMENT.
    lr_node = lr_node_iterator->get_next( ).
  ENDWHILE.

* Return modified document.
  cr_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_comp_patient.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_patient.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


method INITIALIZE_METHODS .

* initialize methods

endmethod.


METHOD initialize_screens.

  DATA: lr_scr_patient  TYPE REF TO cl_ish_scr_patient.

* screen admission
  CALL METHOD cl_ish_scr_patient=>create
    IMPORTING
      er_instance     = lr_scr_patient
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Save all used screen object in gt_screen_objects.
  APPEND lr_scr_patient TO gt_screen_objects.

ENDMETHOD.


METHOD prealloc_from_external_int.

* ED, ID 16882 -> BEGIN
  DATA: lt_ddfields       TYPE ddfields,
        l_rc              TYPE ish_method_rc,
        lr_corder         TYPE REF TO cl_ish_corder,
        l_field_supported TYPE c,
        l_value           TYPE nfvvalue,
        lt_con_obj        TYPE ish_objectlist,
        ls_object         TYPE ish_object,
        l_fname           TYPE string,
        l_compid          TYPE n1comp-compid,
        lr_pap            TYPE REF TO cl_ish_patient_provisional,
        ls_key            TYPE rnpap_key,
        l_patnr           TYPE npat-patnr,
        l_reftyp          TYPE n1corder-reftyp,
        ls_data           TYPE rnpap_attrib.

  FIELD-SYMBOLS: <ls_ddfield> TYPE dfies,
                 <ls_mapping> TYPE ishmed_migtyp_l,
                 <fst>        TYPE ANY.

  e_rc = 0.

* get clinical order
  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
  lr_corder ?= gr_main_object.

* fill lt_con_obj with corder
  ls_object-object ?= lr_corder.
  APPEND ls_object TO lt_con_obj.

* get compid
  CALL METHOD me->get_compid
    RECEIVING
      r_compid = l_compid.

  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = 'NPAP'
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* only data which refer to the corder object are relevant *******
  LOOP AT it_mapping ASSIGNING <ls_mapping>
      WHERE instno = 0
        AND compid = l_compid.
*     patnr
    IF <ls_mapping>-fieldname = 'PATNR' AND
       NOT <ls_mapping>-fvalue IS INITIAL.
      l_patnr = <ls_mapping>-fvalue.
      l_reftyp = cl_ish_corder=>co_reftyp_pat.
*     papid
    ELSEIF <ls_mapping>-fieldname = 'PAPID' AND
       NOT <ls_mapping>-fvalue IS INITIAL.
      ls_key-papid = <ls_mapping>-fvalue.
      l_reftyp = cl_ish_corder=>co_reftyp_pap.
*       create instance of patient provisional
      CALL METHOD cl_ish_patient_provisional=>load
        EXPORTING
          i_key                = ls_key
          i_environment        = gr_environment
          it_connected_objects = lt_con_obj
        IMPORTING
          e_instance           = lr_pap
        EXCEPTIONS
          missing_environment  = 1
          not_found            = 2
          OTHERS               = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          CHANGING
            cr_errorhandler = cr_errorhandler.
        EXIT.
      ENDIF.
    ENDIF.
    CHECK e_rc = 0.
  ENDLOOP. "LOOP AT it_mapping ASSIGNING <ls_mapping>
* only go on if no error
  CHECK e_rc = 0.

* no saved patient already set
  IF ls_key-papid IS INITIAL AND l_patnr IS INITIAL.
    LOOP AT it_mapping ASSIGNING <ls_mapping>
        WHERE instno = 0
          AND compid = l_compid.
      LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
        CLEAR: l_field_supported.
        CHECK <ls_mapping>-fieldname = <ls_ddfield>-fieldname.
        l_field_supported = 'X'.
        CHECK l_field_supported = 'X'.
*       fill structure
        CONCATENATE 'LS_DATA-' <ls_mapping>-fieldname INTO l_fname.
        ASSIGN (l_fname) TO <fst>.
*       Michael Manoch, 02.07.2008, MED-32953   START
        CHECK sy-subrc = 0.
*       Michael Manoch, 02.07.2008, MED-32953   END
        <fst> = <ls_mapping>-fvalue.
      ENDLOOP. "LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
    ENDLOOP.
    CHECK NOT ls_data IS INITIAL.
*   create new patient provisional object
    CALL METHOD cl_ish_patient_provisional=>create
      EXPORTING
        is_data             = ls_data
        i_environment       = gr_environment
      IMPORTING
        e_instance          = lr_pap
      EXCEPTIONS
        missing_environment = 1
        no_authority        = 2
        OTHERS              = 3.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.
  CHECK e_rc = 0.

* set patient
  CHECK NOT l_patnr IS INITIAL OR NOT lr_pap IS INITIAL.
  CALL METHOD lr_corder->set_patient
    EXPORTING
      i_reftyp        = l_reftyp
      i_patnr         = l_patnr
      ir_pap          = lr_pap
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ED, ID 16882 -> END

ENDMETHOD.


METHOD transport_from_screen_internal.

  DATA: lr_scr_patient  TYPE REF TO cl_ish_scr_patient.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_patient=>co_otype_scr_patient ) = on.
    lr_scr_patient ?= ir_screen.
    CALL METHOD trans_from_scr_patient
      EXPORTING
        ir_scr_patient  = lr_scr_patient
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD transport_to_screen_internal.

  DATA: lr_scr_patient  TYPE REF TO cl_ish_scr_patient.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_patient=>co_otype_scr_patient ) = on.
    lr_scr_patient ?= ir_screen.
    CALL METHOD trans_to_scr_patient
      EXPORTING
        ir_scr_patient  = lr_scr_patient
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_corder_from_scr_patient .

  DATA: l_patnr        TYPE patnr,
        ls_npat        TYPE npat,
        l_rc           TYPE ish_method_rc,
        lr_pap         TYPE REF TO cl_ish_patient_provisional,
        l_reftyp       TYPE n1corder-reftyp,
        lt_field_val   TYPE ish_t_field_value,
        lt_old_pap     TYPE ish_t_pap,
        lr_old_pap     TYPE REF TO cl_ish_patient_provisional.

*-- begin data-declarations, Grill ID-18007
  DATA: lr_pap_old        TYPE REF TO cl_ish_patient_provisional,
        ls_corder         TYPE rn1_corder_x,
        l_patnr_old       TYPE patnr,
        l_gschl           TYPE npat-gschl,
        ls_pap_data       TYPE rnpap_attrib,
        lr_compdef        TYPE REF TO cl_ish_compdef,
        lr_component      TYPE REF TO if_ish_component,
        lr_cordpos        TYPE REF TO cl_ishmed_cordpos,
        lt_screen_objects TYPE ish_t_screen_objects,
        lr_screen         TYPE REF TO if_ish_screen,
        lt_field_values   TYPE ish_t_field_value,
        ls_field_values   TYPE rnfield_value,
        lr_scr_med_data   TYPE REF TO cl_ish_scr_med_data.
*-- end data-declarations, Grill ID-18007

  FIELD-SYMBOLS: <ls_field_val>  TYPE rnfield_value.

  CHECK NOT ir_corder      IS INITIAL.
  CHECK NOT ir_scr_patient IS INITIAL.


*-- begin insert, Grill ID-18007
  IF g_vcode EQ co_vcode_insert.
    CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
      EXPORTING
        ir_object       = ir_corder
      IMPORTING
        e_patnr         = l_patnr_old
        er_pap          = lr_pap_old
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.
*-- end insert, Grill ID-18007
*
*-- begin deletion, Grill, MED-34325
**-- begin delete, Grill ID-18007
** Michael Manoch, 07.06.2004, ID 14666   START
** No transport if there is already a real patient.
** Michael Manoch, 19.07.2004, ID 14995   START
** In insert mode allow changing the patient.
*  IF g_vcode <> co_vcode_insert.
** Michael Manoch, 19.07.2004, ID 14995   END
*    CALL METHOD cl_ish_utl_base=>get_patient_of_obj
*      EXPORTING
*        ir_object       = ir_corder
*      IMPORTING
*        e_patnr         = l_patnr
*        er_pap          = lr_pap  "Grill, ID-18007
*        e_rc            = e_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    CHECK e_rc = 0.
*    CHECK l_patnr IS INITIAL.
*    CLEAR l_patnr.
** Michael Manoch, 19.07.2004, ID 14995   START
*  ENDIF.
** Michael Manoch, 19.07.2004, ID 14995   END
** Michael Manoch, 07.06.2004, ID 14666   END
**-- end delete, Grill ID-18007
*
* Get PATNR + PAP.
  CALL METHOD ir_scr_patient->get_fields
    IMPORTING
      et_field_values = lt_field_val
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.
  LOOP AT lt_field_val ASSIGNING <ls_field_val>.
    CASE <ls_field_val>-fieldname.
      WHEN cl_ish_scr_patient=>co_fieldname_patnr.
        l_patnr = <ls_field_val>-value.
      WHEN cl_ish_scr_patient=>co_fieldname_pap.
        lr_pap ?= <ls_field_val>-object.
    ENDCASE.
  ENDLOOP.

* Handle reftyp.
  IF l_patnr IS INITIAL.
    l_reftyp = cl_ish_corder=>co_reftyp_pap.
  ELSE.
    l_reftyp = cl_ish_corder=>co_reftyp_pat.
  ENDIF.

*-- begin Grill, MED-34325
**-- begin Grill, ID-18007
*  IF l_patnr NE l_patnr_old AND
*     g_vcode EQ co_vcode_insert.                            "med-29539
*    IF NOT l_patnr IS INITIAL.
*      CALL METHOD cl_ish_dbr_pat=>get_pat_by_patnr
*        EXPORTING
*          i_patnr     = ls_corder-patnr
*          i_read_db   = on
*          i_no_buffer = on
*        IMPORTING
*          e_rc        = l_rc
*          es_npat     = ls_npat.
*      IF l_rc = 0.
*        l_gschl = ls_npat-gschl.
*      ENDIF.
*      IF l_gschl EQ '1'.
*        ls_corder-schwkz = 'N'. "Grill, ID-17243
*        CLEAR ls_corder-schwo.
*        ls_corder-schwo_x = on.
*      ELSE.
*        ls_corder-schwkz =  space.
*      ENDIF.
*      ls_corder-schwkz_x = on.
*    ENDIF.
*  ENDIF.
**-- get provisional patient
*  CLEAR l_gschl.
*  IF lr_pap NE lr_pap_old.
*    CALL METHOD ir_corder->get_patient_provisional
*      IMPORTING
*        es_pap_data     = ls_pap_data
*        e_rc            = e_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    CHECK e_rc = 0.
*    IF NOT ls_pap_data-gschle IS INITIAL.
*      CALL FUNCTION 'ISH_CONVERT_SEX_INPUT'
*        EXPORTING
*          ss_gschle = ls_pap_data-gschle
*        IMPORTING
*          ss_gschl  = l_gschl
*        EXCEPTIONS
*          not_found = 1
*          OTHERS    = 2.
*      e_rc = sy-subrc.
*      IF e_rc <> 0.
*        CLEAR l_gschl.
*      ENDIF.
*    ENDIF.
*    CASE l_gschl.
*      WHEN '1'.
*        ls_corder-schwkz   = 'N'.
*        ls_corder-schwkz_x = on.
*      WHEN '2'.
**        ls_corder-schwkz   = 'space'.     "Grill, MED-34325
*        ls_corder-schwkz   = space.        "Grill, MED-34325
*        ls_corder-schwkz_x = on.
*      WHEN OTHERS.
*        ls_corder-schwkz   = 'U'.
*        ls_corder-schwkz_x = on.
*    ENDCASE.
*  ENDIF.
*
*  IF l_patnr NE l_patnr_old OR
*     lr_pap NE lr_pap_old.
*    IF g_vcode EQ co_vcode_insert.                          "med-29539
**-- get component
*      CALL METHOD cl_ish_compdef=>get_compdef
*        EXPORTING
*          i_obtyp    = cl_ish_cordtyp=>co_obtyp
*          i_compid   = 'SAP_MED_DATA'
*          i_classid  = 'CL_ISH_COMP_MED_DATA'
*        IMPORTING
*          er_compdef = lr_compdef.
*
**-- check if component is existing
*      CALL METHOD ir_corder->get_component
*        EXPORTING
*          ir_compdef      = lr_compdef
*        IMPORTING
*          er_component    = lr_component
*          e_rc            = e_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      CHECK e_rc EQ 0.
**-- get screen
*      IF NOT lr_component IS INITIAL.
*        CALL METHOD lr_component->get_defined_screens
*          RECEIVING
*            rt_screen_objects = lt_screen_objects.
*
*        READ TABLE lt_screen_objects INTO lr_screen INDEX 1.
*        IF sy-subrc = 0.
*          lr_scr_med_data ?= lr_screen.
*          IF NOT lr_screen IS INITIAL.
*            CALL METHOD lr_scr_med_data->get_fields
*              IMPORTING
*                et_field_values = lt_field_values
*                e_rc            = e_rc
*              CHANGING
*                c_errorhandler  = cr_errorhandler.
**-- pregnent
*            READ TABLE lt_field_values INTO ls_field_values
*              WITH KEY fieldname = lr_scr_med_data->g_fieldname_schwkz.
*            ls_field_values-value = ls_corder-schwkz.
*            MODIFY lt_field_values FROM ls_field_values TRANSPORTING value WHERE
*             fieldname = lr_scr_med_data->g_fieldname_schwkz.
**-- pregnentweek
*            READ TABLE lt_field_values INTO ls_field_values
*              WITH KEY fieldname = lr_scr_med_data->g_fieldname_schwo.
*            ls_field_values-value = ls_corder-schwo.
*            MODIFY lt_field_values FROM ls_field_values TRANSPORTING value WHERE
*             fieldname = lr_scr_med_data->g_fieldname_schwo.
**-- set fields
*            CALL METHOD lr_scr_med_data->if_ish_screen~set_fields
*              EXPORTING
*                it_field_values  = lt_field_values
*                i_field_values_x = on
*              IMPORTING
*                e_rc             = e_rc
*              CHANGING
*                c_errorhandler   = cr_errorhandler.
*          ENDIF.
*        ENDIF.
*      ENDIF.
*    ENDIF.                                                  "med-29539
*  ENDIF.
**-- change data
*  CALL METHOD ir_corder->change
*    EXPORTING
*      is_corder_x     = ls_corder
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc EQ 0.
**-- end Grill, ID-18007
*-- end Grill, MED-34325

* Set patient
* Adjustments are made by corder object.
  CALL METHOD ir_corder->set_patient
    EXPORTING
      i_reftyp            = l_reftyp
      i_patnr             = l_patnr
      ir_pap              = lr_pap
      i_adjust_dependents = on
    IMPORTING
      et_old_pap          = lt_old_pap
      e_rc                = e_rc
    CHANGING
      cr_errorhandler     = cr_errorhandler.
  CHECK e_rc = 0.

* Old pap objects are no more needed -> destroy them.
  LOOP AT lt_old_pap INTO lr_old_pap.
    CHECK NOT lr_old_pap IS INITIAL.
    CALL METHOD lr_old_pap->destroy.
  ENDLOOP.

ENDMETHOD.


METHOD trans_corder_to_scr_patient .

  DATA: ls_n1corder           TYPE n1corder,
        lr_pap                TYPE REF TO cl_ish_patient_provisional,
        ls_field_val          TYPE rnfield_value,
        lt_field_val          TYPE ish_t_field_value.

  CHECK NOT ir_corder      IS INITIAL.
  CHECK NOT ir_scr_patient IS INITIAL.

* Get corder data.
  CALL METHOD ir_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get pap.
  CALL METHOD ir_corder->get_patient_provisional
    IMPORTING
      er_patient_provisional = lr_pap
      e_rc                   = e_rc
    CHANGING
      cr_errorhandler        = cr_errorhandler.
  CHECK e_rc = 0.

* Build field values.
  CLEAR: lt_field_val,
         ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_patient=>co_fieldname_patnr.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = ls_n1corder-patnr.
  INSERT ls_field_val INTO TABLE lt_field_val.
  ls_field_val-fieldname = cl_ish_scr_patient=>co_fieldname_pap.
  ls_field_val-type      = co_fvtype_identify.
  ls_field_val-object    = lr_pap.
  INSERT ls_field_val INTO TABLE lt_field_val.

* Set main object in patient screen.
  CALL METHOD ir_scr_patient->set_data
    EXPORTING
      i_main_object   = ir_corder
      i_main_object_x = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Set field values in patient screen.
  CALL METHOD ir_scr_patient->set_fields
    EXPORTING
      it_field_values  = lt_field_val
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_from_scr_patient .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_patient  IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_from_scr_patient
      EXPORTING
        ir_corder       = lr_corder
        ir_scr_patient  = ir_scr_patient
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_to_scr_patient .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object  IS INITIAL.
  CHECK NOT ir_scr_patient  IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_to_scr_patient
      EXPORTING
        ir_corder       = lr_corder
        ir_scr_patient  = ir_scr_patient
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.
ENDCLASS.
