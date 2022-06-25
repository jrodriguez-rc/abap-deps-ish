class CL_ISH_COMP_WAITING_LIST definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

*"* public components of class CL_ISH_COMP_WAITING_LIST
*"* do not include other source files here!!!
public section.

  constants CO_CLASSID type N1COMPCLASSID value 'CL_ISH_COMP_WAITING_LIST'. "#EC NOTEXT
  constants CO_OTYPE_COMP_WAITING_LIST type ISH_OBJECT_TYPE value 8004. "#EC NOTEXT

  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
  methods GET_ABSENCES
    importing
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default OFF
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
    exporting
      value(ET_ABSENCES) type ISH_T_WAITING_LIST_ABSENCES
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .
  methods PREALLOC_INTERNAL_SAV
    exporting
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
  methods IF_ISH_COMPONENT~IS_EMPTY
    redefinition .
  methods IF_ISH_COMPONENT~SAVE
    redefinition .
  methods IF_ISH_COMPONENT~SET_T_UID
    redefinition .
  methods IF_ISH_DOM~MODIFY_DOM_DATA
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMP_WAITING_LIST
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods TRANS_CORDER_TO_FV_WL
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IS_N1CORDER type N1CORDER
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_FIELD_VAL type ISH_T_FIELD_VALUE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_TO_SCR_WL
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_WAITING_LIST type ref to CL_ISH_SCR_WAITING_LIST
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_WAITING_LIST
    importing
      !IR_SCR_WAITING_LIST type ref to CL_ISH_SCR_WAITING_LIST
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
  methods PREALLOC_INTERNAL
    redefinition .
  methods TRANSPORT_FROM_SCREEN_INTERNAL
    redefinition .
  methods TRANSPORT_TO_SCREEN_INTERNAL
    redefinition .
private section.
*"* private components of class CL_ISH_COMP_WAITING_LIST
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_WAITING_LIST IMPLEMENTATION.


METHOD class_constructor .

  DATA: l_cdoc_field  TYPE rn1_cdoc_field,
        l_print_field TYPE rn1_print_field,
        l_fieldname   TYPE string,
        lt_fieldname  TYPE ish_t_string.

  CLEAR: gt_cdoc_field[],
         gt_print_field[].


* Build table for cdoc.

* N1CORDER
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  = cl_ish_corder=>co_otype_corder.
  l_cdoc_field-tabname     = 'N1CORDER'.

  l_fieldname              = 'WLTYP'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLADT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLPRI'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLRRN'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLRDT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLHSP'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WUZPI'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WUMNT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WUJHR'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.

* NWLM
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  = cl_ish_waiting_list_absence=>co_otype_wl_absence.
  l_cdoc_field-tabname     = 'NWLM'.

  l_fieldname              = 'ABSBDT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ABSEDT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ABSRSN'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* N1CORDER
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ish_corder=>co_otype_corder.
  l_print_field-tabname     = 'N1CORDER'.

  l_fieldname              = 'WLTYP'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLADT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLPRI'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLRRN'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLRDT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WLHSP'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WUZPI'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WUMNT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'WUJHR'.
  APPEND l_fieldname TO lt_fieldname.

  l_print_field-t_fieldname = lt_fieldname.
  APPEND l_print_field TO gt_print_field.

* NWLM
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  = cl_ish_waiting_list_absence=>co_otype_wl_absence.
  l_print_field-tabname     = 'NWLM'.

  l_fieldname              = 'ABSBDT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ABSEDT'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ABSRSN'.
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

* don't copy longtexts here -> it is done in clinical order itself!!
  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        ls_n1corder      TYPE n1corder,
        lt_run_data      TYPE ish_t_objectbase,
        lr_absence       TYPE REF TO cl_ish_waiting_list_absence,
        lt_con_obj       TYPE ish_objectlist,
        ls_object        TYPE ish_object,
        lr_object        TYPE REF TO if_ish_objectbase,
        l_rc             TYPE ish_method_rc,
        ls_data          TYPE rnwlm_attrib,
        lr_absence_new   TYPE REF TO cl_ish_waiting_list_absence.

  CHECK i_copy EQ 'C' OR    "Grill, med-20702
        i_copy EQ 'X' OR
        i_copy EQ 'L'.      "IXX-115 Naomi Popa 06.01.2015

  e_rc = 0.

  CALL METHOD me->get_corder
    RECEIVING
      rr_corder = lr_corder.

* fill lt_con_obj with corder
  ls_object-object ?= lr_corder.
  APPEND ls_object TO lt_con_obj.

* first call get_t_run_data from original component
  CALL METHOD ir_component_from->get_t_run_data
    IMPORTING
      et_run_data     = lt_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  LOOP AT lt_run_data INTO lr_object.

*   absence
    CHECK lr_object->is_inherited_from(
                cl_ish_waiting_list_absence=>co_otype_wl_absence ) = on
.
    lr_absence ?= lr_object.
*   get data from absence
    CALL METHOD lr_absence->get_data
      IMPORTING
        es_data        = ls_data
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   copy only not cancelled absences!!
    CHECK ls_data-storn = off.
*   initialize some fields.
    CLEAR: ls_data-vkgid.
*   build new absence
    CALL METHOD cl_ish_waiting_list_absence=>create
      EXPORTING
        is_data              = ls_data
        i_environment        = gr_environment
        it_connected_objects = lt_con_obj
      IMPORTING
        e_instance           = lr_absence_new
      EXCEPTIONS
        missing_environment  = 1
        OTHERS               = 2.
    l_rc = sy-subrc.
*   errorhandling
    IF l_rc <> 0.
      e_rc = l_rc.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        EXPORTING
*            I_TYP           =
*            I_PAR           =
*            I_ROW           =
*            I_FIELD         =
          ir_object       = me
*            I_LINE_KEY      =
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD get_absences .

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        lr_absence       TYPE REF TO cl_ish_waiting_list_absence,
        lt_object        TYPE ish_objectlist,
        l_cancelled      TYPE ish_on_off,
        l_deleted        TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_object>  TYPE ish_object.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get all connected absences from corder.
  CALL METHOD lr_corder->get_connections
    EXPORTING
      i_type     = CL_ISH_WAITING_LIST_ABSENCE=>co_otype_wl_absence
    IMPORTING
      et_objects = lt_object.

* Build et_absences.
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    lr_absence ?= <ls_object>-object.
    IF i_cancelled_datas = off.
      CALL METHOD lr_absence->is_cancelled
        IMPORTING
          e_cancelled = l_cancelled
          e_deleted   = l_deleted.
      CHECK l_cancelled = off.
      CHECK l_deleted   = off.
    ENDIF.
    APPEND lr_absence TO et_absences.
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
        lr_node_map         TYPE REF TO if_ixml_named_node_map,
        lr_node_last_row    TYPE REF TO if_ixml_node,
        lr_node_parent      TYPE REF TO if_ixml_node,
        lr_element_parent   TYPE REF TO if_ixml_element,
        l_name              TYPE string,
        l_string            TYPE string,
        l_index             TYPE i,
        l_dia_group         TYPE ish_on_off,
        lr_elementgroup_filter   TYPE REF TO if_ixml_node_filter,
        lr_elementgroup_iterator TYPE REF TO if_ixml_node_iterator,
        lr_elementgroup_node     TYPE REF TO if_ixml_node.

* Init.
  CLEAR er_document_fragment.

  CHECK NOT ir_document IS INITIAL.
  CHECK NOT ir_run_data IS INITIAL.

*----------------------------------------------------------------
* This method is called with following run data objects
*   - CO_OTYPE_CORDER              (once)
*   - CO_OTYPE_WL_ABSENCE          (n times)
* If run data object is CORDER  => Handle N1CORDER(1)
* If run data object is ABSENCE => Handle NWLM(1)
*----------------------------------------------------------------

  CHECK gr_t_print_field IS BOUND.
  ASSIGN gr_t_print_field->* TO <lt_print_field>.
  CHECK sy-subrc = 0.

* CORDER.
  IF ir_run_data->is_inherited_from(
                   cl_ish_corder=>co_otype_corder ) = on.
    l_first_time = on.
  ENDIF.

* ABSENCE.
  IF ir_run_data->is_inherited_from(
                   cl_ish_waiting_list_absence=>co_otype_wl_absence ) = on.
    IF NOT ir_element IS INITIAL.
*     Get element group.
      lr_element_group =
        ir_element->find_from_name_ns( depth = 0
                                       name = 'ELEMENTGROUP'
                                       uri = '' ).
      IF NOT lr_element_group IS INITIAL.
*       Existing element group => get element body.
        lr_element_body =
         lr_element_group->find_from_name_ns( depth = 0
                                              name = 'ELEMENTBODY'
                                              uri = '' ).
        IF NOT lr_element_body IS INITIAL.
*         Existing element body => get last child.
          lr_node_last_row = lr_element_body->get_last_child( ).
          IF NOT lr_node_last_row IS INITIAL.
            lr_element_last_row ?= lr_node_last_row.
*           Get last child's row id.
            l_string =
             lr_element_last_row->get_attribute_ns( name = 'RID' ).
            l_index = l_string.
*           Compute new row id.
            l_index = l_index + 1.
          ENDIF.
        ENDIF.
      ELSE.
*       No element group.
        l_first_time = on.
        l_index = 1.
      ENDIF.  "element_group
    ENDIF.  "ir_element
  ENDIF.  "absence

  IF l_first_time = on.
*   No element group => create DOM fragment.
    lr_document_fragment = ir_document->create_document_fragment( ).
  ENDIF.

* Loop print fields.
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

*     Get field as DOM element.
      CLEAR ls_field.
      ls_field-tabname    = <ls_print_field>-tabname.
      ls_field-fieldname  = <ls_ddfield>-fieldname.
      ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
      ls_field-fieldvalue = l_field_value.
      ls_field-fieldprint = l_field_value.
      ls_field-display    = on.

*     CORDER.
      IF ir_run_data->is_inherited_from(
                       cl_ish_corder=>co_otype_corder ) = on.
        CALL METHOD cl_ish_utl_xml=>get_dom_element
          EXPORTING
            is_field   = ls_field
          IMPORTING
            er_element = lr_element.
*       Append component element to component DOM fragment
        l_rc = lr_document_fragment->append_child(
                                            new_child = lr_element ).
      ENDIF.

*     Absence.
      IF ir_run_data->is_inherited_from(
                    cl_ish_waiting_list_absence=>co_otype_wl_absence ) = on.
        APPEND ls_field TO lt_fields.
      ENDIF.
    ENDLOOP.
*   CORDER => EXIT.
    IF ir_run_data->is_inherited_from(
                     cl_ish_corder=>co_otype_corder ) = on.
      EXIT.
    ENDIF.
  ENDLOOP.

* Absence.
  IF ir_run_data->is_inherited_from(
                   cl_ish_waiting_list_absence=>co_otype_wl_absence ) = on.
*   Get component element.
    l_string = 'Abwesenheiten'(001).
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
*     Append component element to component DOM fragment
      l_rc = lr_document_fragment->append_child(
                                          new_child = lr_element ).
    ELSE.
      IF NOT lr_element_body IS INITIAL.
*       Append component element to body element.
        l_rc = lr_element_body->append_child( lr_element ).
      ENDIF.
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


METHOD if_ish_component~cancel.

* Michael Manoch, 05.07.2004, ID 14907
* Redefine the method to cancel the absences.

  DATA: lt_absence    TYPE ish_t_waiting_list_absences,
        lr_absence    TYPE REF TO cl_ish_waiting_list_absence,
        lr_corder     TYPE REF TO cl_ish_corder,
        ls_n1corder_x TYPE rn1_corder_x,
        l_cancelled   TYPE ish_on_off,
        l_rc          TYPE ish_method_rc.

* Get absence objects.
  CALL METHOD get_absences
    IMPORTING
      et_absences     = lt_absence
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Process each absence object.
  LOOP AT lt_absence INTO lr_absence.
    CHECK NOT lr_absence IS INITIAL.
*   Cancel absence object.
    CALL METHOD lr_absence->cancel
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

* No further processing in check-only mode.
  CHECK i_check_only = off.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* No further processing for cancelled corder objects.
  CALL METHOD lr_corder->is_cancelled
    IMPORTING
      e_cancelled = l_cancelled.
  CHECK l_cancelled = off.

* Clear the component's data from the corder.

* Build the changing structure.
  CLEAR ls_n1corder_x.
  ls_n1corder_x-wlrrn_x  = on.
  ls_n1corder_x-wltyp_x  = on.
  ls_n1corder_x-wlpri_x  = on.
  ls_n1corder_x-wladt_x  = on.
  ls_n1corder_x-wlrdt_x  = on.
  ls_n1corder_x-wlhsp_x  = on.

* Change corder data.
  CALL METHOD lr_corder->change
    EXPORTING
      is_corder_x     = ls_n1corder_x
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD if_ish_component~check .

  DATA: lt_absences   TYPE ish_t_waiting_list_absences,
        lr_absence    TYPE REF TO cl_ish_waiting_list_absence,
        lr_corder     TYPE REF TO cl_ish_corder,
        ls_n1corder   TYPE n1corder.
* Michael Manoch, 10.08.2004, ID 15151   START
  DATA: l_mv1(30)  TYPE c.
* Michael Manoch, 10.08.2004, ID 15151   END

* Initializations
  CLEAR: e_rc.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Process super method.
  CALL METHOD super->if_ish_component~check
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get corder object.
  lr_corder = get_corder( ).

* Get corder data.
  IF NOT lr_corder IS INITIAL.
    CALL METHOD lr_corder->get_data
      IMPORTING
        es_n1corder     = ls_n1corder
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* WLTYP is mandatory if WLADT/WLSTA is specified.
  IF NOT lr_corder IS INITIAL.
    IF ls_n1corder-wltyp IS INITIAL AND
*      Michael Manoch, 10.08.2004, ID 15151   START
*      WLTYP is mandatory if WLADT is specified.
*       ( NOT ls_n1corder-wladt IS INITIAL OR
*         NOT ls_n1corder-wlsta IS INITIAL ).
       NOT ls_n1corder-wladt IS INITIAL.
*      Michael Manoch, 10.08.2004, ID 15151   END
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ    = 'E'
          i_kla    = 'NFCL'
          i_num    = '179'
          i_par    = 'N1CORDER'
          i_fld    = 'WLTYP'
          i_last   = space
          i_object = lr_corder.
      e_rc = 1.
    ENDIF.
*   Michael Manoch, 10.08.2004, ID 15151   START
*   WLSTA is mandatory if any waiting list data is specified.
    IF ls_n1corder-wlsta IS INITIAL AND
       ( NOT ls_n1corder-wltyp IS INITIAL OR
         NOT ls_n1corder-wladt IS INITIAL ).
*     Bitte pflegen Sie einen Auftragsstatus.
      l_mv1 = lr_corder->get_text_cordstat( ).
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ    = 'E'
          i_kla    = 'N1CORDMG'
          i_num    = '123'
          i_par    = 'N1CORDER'
          i_fld    = 'WLSTA'
          i_mv1    = l_mv1
          i_last   = space
          i_object = lr_corder.
      e_rc = 1.
    ENDIF.
*   Michael Manoch, 10.08.2004, ID 15151   END
  ENDIF.

* Get all absence objects.
  CALL METHOD get_absences
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_absences       = lt_absences
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each absence object.
  LOOP AT lt_absences INTO lr_absence.
    CHECK NOT lr_absence IS INITIAL.
*   Check absence object.
    CALL METHOD lr_absence->check
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

  DATA: lt_absences  TYPE ish_t_waiting_list_absences,
        lr_absence   TYPE REF TO cl_ish_waiting_list_absence.

* Get all absence objects.
  CALL METHOD get_absences
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_absences       = lt_absences
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each absence object.
  LOOP AT lt_absences INTO lr_absence.
    CHECK NOT lr_absence IS INITIAL.
*   Check radiology object for changes
    e_changed = lr_absence->is_changed( ).
    IF e_changed = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~get_t_run_data .

  DATA: lt_absence  TYPE ish_t_waiting_list_absences.

* Handle objects of super class.
  CALL METHOD super->if_ish_component~get_t_run_data
    IMPORTING
      et_run_data     = et_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get absence objects.
  CALL METHOD get_absences
    IMPORTING
      et_absences     = lt_absence
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Append absence objects.
  APPEND LINES OF lt_absence TO et_run_data.

ENDMETHOD.


METHOD if_ish_component~get_t_uid .

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        lr_absence       TYPE REF TO cl_ish_waiting_list_absence,
        lt_object        TYPE ish_objectlist,
        ls_nwlm_key      TYPE rnwlm_key,
        l_uid            TYPE sysuuid_c.

  FIELD-SYMBOLS: <ls_object>  TYPE ish_object.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get all connected absences from corder.
  CALL METHOD lr_corder->get_connections
    EXPORTING
      i_type     = cl_ish_waiting_list_absence=>co_otype_wl_absence
    IMPORTING
      et_objects = lt_object.

* For every absence:
*   - Get its stringified key.
*   - Add the key to et_uid.
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    lr_absence ?= <ls_object>-object.
    CALL METHOD lr_absence->get_data
      IMPORTING
        es_key = ls_nwlm_key.
    CHECK NOT ls_nwlm_key-absno IS INITIAL.
    l_uid = ls_nwlm_key-absno.
    APPEND l_uid TO rt_uid.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~is_empty.

* Michael Manoch, 13.07.2004, ID 14907
* New method.

  DATA: lr_corder   TYPE REF TO cl_ish_corder,
        ls_n1corder TYPE n1corder,
        l_rc        TYPE ish_method_rc.

* Call super method.
  r_empty = super->if_ish_component~is_empty( ).

* Further processing only if super method returns ON.
  CHECK r_empty = on.

* Check the corder fields.
  r_empty = off.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get corder data.
  CALL METHOD lr_corder->get_data
    IMPORTING
      e_rc        = l_rc
      es_n1corder = ls_n1corder.
* On error -> self is not empty.
  CHECK l_rc = 0.

* If one of the component fields is not empty -> self is not empty.
  CHECK ls_n1corder-wlrrn  IS INITIAL.
  CHECK ls_n1corder-wltyp  IS INITIAL.
  CHECK ls_n1corder-wlpri  IS INITIAL.
  CHECK ls_n1corder-wladt  IS INITIAL.
  CHECK ls_n1corder-wlrdt  IS INITIAL.
  CHECK ls_n1corder-wlhsp  IS INITIAL.

* Self is empty.
  r_empty = on.

ENDMETHOD.


METHOD if_ish_component~save .

  DATA: lt_absences   TYPE ish_t_waiting_list_absences,
        lr_absence    TYPE REF TO cl_ish_waiting_list_absence,
        ls_nwlm_key   TYPE rnwlm_key,
        l_uid         TYPE sysuuid_c.

* Get all absence objects.
  CALL METHOD get_absences
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_absences       = lt_absences
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each absence object.
  LOOP AT lt_absences INTO lr_absence.
    CHECK NOT lr_absence IS INITIAL.
*   Save absence object.
    CALL METHOD lr_absence->save
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
    CALL METHOD lr_absence->get_data
      IMPORTING
        es_key = ls_nwlm_key.
    l_uid = ls_nwlm_key-absno.
    APPEND l_uid TO et_uid_save.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component~set_t_uid .

  DATA: lr_absence    TYPE REF TO cl_ish_waiting_list_absence,
        lr_corder     TYPE REF TO cl_ish_corder,
        ls_nwlm_key   TYPE rnwlm_key.

  FIELD-SYMBOLS: <l_uid>  TYPE sysuuid_c.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* For every uid:
*   - Load the corresponding object
*   - Connect it with corder.
  LOOP AT it_uid ASSIGNING <l_uid>.
    CHECK NOT <l_uid> IS INITIAL.
    CLEAR ls_nwlm_key.
    ls_nwlm_key-absno = <l_uid>.
*   Load object.
    CALL METHOD cl_ish_waiting_list_absence=>load
      EXPORTING
        is_key              = ls_nwlm_key
        i_environment       = gr_environment
      IMPORTING
        e_instance          = lr_absence
      EXCEPTIONS
        missing_environment = 1
        not_found           = 2
        OTHERS              = 3.
    CHECK sy-subrc = 0.  " Ignore errors
    CHECK NOT lr_absence IS INITIAL.
*   Connect with corder.
    CALL METHOD lr_corder->add_connection
      EXPORTING
        i_object = lr_absence.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_dom~modify_dom_data.

  DATA: lr_changing_node      TYPE REF TO if_ixml_node,
        lr_document_fragment  TYPE REF TO if_ixml_document_fragment,
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
        l_einri               TYPE tn01-einri,
        l_prtxt               TYPE ish_pritxt,
        l_wlpri               TYPE wlpri,
        l_tn14p               TYPE tn14p,
        l_wltyp               TYPE ish_wltype,
        l_wlttx               TYPE ish_wltypetx,
        l_tn42a               TYPE tn42a,
        l_wlrrn               TYPE ish_wlrrsn,
        l_wlrtx               TYPE ish_wlrrsntx,
        l_tn42b               TYPE tn42b,
        l_zpi                 TYPE n1zpi-zpi,
        l_zpie                TYPE n1zpi-zpie,
        l_cdat_in             TYPE char10,
        l_cdat_out            TYPE char10,
        l_gpart               TYPE gpartner,
        l_khans               TYPE text50,
        l_rc                  TYPE i.
  DATA:   lr_elementrow_filter   TYPE REF TO if_ixml_node_filter,
          lr_elementrow_iterator TYPE REF TO if_ixml_node_iterator,
          lr_element             TYPE REF TO if_ixml_element,
          lr_elementrow_node     TYPE REF TO if_ixml_node,
          lr_elementrow_elem     TYPE REF TO if_ixml_element,
          lr_elementval_nodes    TYPE REF TO if_ixml_node_list,
          lr_elementval_node     TYPE REF TO if_ixml_node,
          lr_elementval_elem     TYPE REF TO if_ixml_element,
          lr_elem_last_child     TYPE REF TO if_ixml_element,
          l_name                 TYPE string,
          l_value                TYPE string,
          l_value1               TYPE string,
          l_index                TYPE i,
          l_absrsn               TYPE ish_absrsn,
          l_absrst               TYPE ish_absrsntx.

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
           l_value1,
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
*       Get attribute NAME.
        lr_node_name  = lr_attributes->get_named_item( 'NAME' ).

        IF NOT lr_node_name IS INITIAL.
*         Get first child of COMPELEMENT => ELEMENTTAG.
          lr_node_first_child = lr_node->get_first_child( ).
          IF NOT lr_node_first_child IS INITIAL.
            l_string_el_name = lr_node_first_child->get_value( ).
          ENDIF.
*         Get last  child of COMPELEMENT => ELEMENTVAL.
          lr_node_last_child  = lr_node->get_last_child( ).
          IF NOT lr_node_last_child IS INITIAL.
            lr_elem_last_child ?= lr_node_last_child.
            IF lr_elem_last_child IS BOUND.
              l_value1 =
                lr_elem_last_child->get_attribute( name = 'VALUE' ).
            ENDIF.
            l_string_el_value = lr_node_last_child->get_value( ).
          ENDIF.

*         Check/change COMPELEMENT.
          l_string_compel_name = lr_node_name->get_value( ).
          CASE l_string_compel_name.
*           WLTYP
            WHEN 'WLTYP'.
              IF l_value1 = l_string_el_value.
*               Get institution.
                l_einri =
            cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
                IF l_einri IS INITIAL.
                  EXIT.
                ENDIF.
*               Get text.
                l_wltyp = l_string_el_value.
                CALL FUNCTION 'ISH_WLTYP_CHECK'
                  EXPORTING
                    ss_einri  = l_einri
                    ss_wltyp  = l_wltyp
                  IMPORTING
                    ss_wlttx  = l_wlttx
                    ss_tn42a  = l_tn42a
                  EXCEPTIONS
                    not_found = 1
                    OTHERS    = 2.
                IF sy-subrc = 0.
                  l_string_el_value = l_wlttx.
                ENDIF.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
              ENDIF.
*           WLPRI
            WHEN 'WLPRI'.
              IF l_value1 = l_string_el_value.
*               Get institution.
                l_einri =
            cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
                IF l_einri IS INITIAL.
                  EXIT.
                ENDIF.
*               Get text.
                l_wlpri = l_string_el_value.
                CALL FUNCTION 'ISH_WLPRI_CHECK'
                  EXPORTING
                    ss_einri  = l_einri
                    ss_wlpri  = l_wlpri
                  IMPORTING
                    ss_prtxt  = l_prtxt
                    ss_tn14p  = l_tn14p
                  EXCEPTIONS
                    not_found = 1
                    OTHERS    = 2.
                IF sy-subrc = 0.
                  l_string_el_value = l_prtxt.
                ENDIF.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
              ENDIF.
*           WLRRN
            WHEN 'WLRRN'.
              IF l_value1 = l_string_el_value.
*               Get institution.
                l_einri =
            cl_ish_utl_base=>get_institution_of_obj( gr_main_object ).
                IF l_einri IS INITIAL.
                  EXIT.
                ENDIF.
*               Get text.
                l_wlrrn = l_string_el_value.
                CALL FUNCTION 'ISH_WLRRN_CHECK'
                  EXPORTING
                    ss_einri  = l_einri
                    ss_wlrrn  = l_wlrrn
                  IMPORTING
                    ss_wlrtx  = l_wlrtx
                    ss_tn42b  = l_tn42b
                  EXCEPTIONS
                    not_found = 1
                    OTHERS    = 2.
                IF sy-subrc = 0.
                  l_string_el_value = l_wlrtx.
                ENDIF.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
              ENDIF.
*           WLHSP
            WHEN 'WLHSP'.
              IF l_value1 = l_string_el_value AND l_string_el_value IS NOT INITIAL.
                CLEAR: l_gpart, l_khans, l_rc.
                l_gpart = l_string_el_value.
                CALL METHOD cl_ish_utl_base_descr=>get_descr_khans
                  EXPORTING
                    i_gpart         = l_gpart
                  IMPORTING
                    e_khans         = l_khans
                    e_rc            = l_rc
*                CHANGING
*                  CR_ERRORHANDLER =
                    .
                IF l_rc = 0.
                  CONCATENATE l_gpart
                              l_khans
                         INTO l_string_el_value
                    SEPARATED BY space.
                ENDIF.
*             Modify element value in DOM node
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
              ENDIF.
*           WLADT, WLRDT
            WHEN 'WLADT' OR 'WLRDT'.
              IF l_value1 = l_string_el_value.
*               Convert date from intern to extern.
                l_cdat_in = l_string_el_value.
                l_table_field-tabname   = 'SY'.
                l_table_field-fieldname = 'DATUM'.
                IF l_cdat_in = '00000000'.
                  l_string_el_value = space.
                ELSE.
                  CALL FUNCTION 'RS_DS_CONV_IN_2_EX'
                    EXPORTING
                      input                  = l_cdat_in
*                      DESCR                  =
                      table_field            = l_table_field
*                     CHECK_INPUT            =
                    IMPORTING
                      output                 = l_cdat_out
                    EXCEPTIONS
                      conversion_error       = 1
                      OTHERS                 = 2.
                  IF sy-subrc = 0.
                    l_string_el_value = l_cdat_out.
                  ENDIF.
                ENDIF.
*             Modify value in DOM node.
              e_rc = lr_node_last_child->set_value( l_string_el_value ).
              ENDIF.
            WHEN OTHERS.
          ENDCASE.
        ENDIF.  "NAME
      ENDIF.  "attributes
    ENDIF.  "COMPELEMENT

*   Get next COMPELEMENT.
    lr_node = lr_node_iterator->get_next( ).
  ENDWHILE.

*  NEW - BEGIN

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
*       ABSBDT, ABSEDT
        WHEN 'ABSBDT' OR 'ABSEDT'.
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
                  input                  = l_cdat_in
*                  DESCR                  =
                  table_field            = l_table_field
*                  CHECK_INPUT            =
                IMPORTING
                  output                 = l_cdat_out
                EXCEPTIONS
                  conversion_error       = 1
                  OTHERS                 = 2.
              IF sy-subrc = 0.
                l_value = l_cdat_out.
              ENDIF.
            ENDIF.
*           Modify element value in DOM node
            e_rc = lr_elementval_elem->set_value( l_value ).
          ENDIF.
*       ABSRSN
        WHEN 'ABSRSN'.
          IF l_value = l_value1.
*           Get institution.
            l_einri =
              cl_ish_utl_base=>get_institution_of_obj(
                                            gr_main_object ).
            IF l_einri IS INITIAL.
              EXIT.
            ENDIF.
            l_absrsn = l_value.
            CALL FUNCTION 'ISH_ABSRSN_CHECK'
              EXPORTING
                ss_einri    = l_einri
                ss_absrsn   = l_absrsn
              IMPORTING
                ss_absrsntx = l_absrst
              EXCEPTIONS
                not_found   = 1
                OTHERS      = 2.
            IF sy-subrc = 0.
              l_value = l_absrst.
            ELSE.
              e_rc = sy-subrc.
              CALL METHOD
                cl_ish_utl_base=>collect_messages_by_exception
                CHANGING
                  cr_errorhandler = cr_errorhandler.
              EXIT.
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

  e_object_type = co_otype_comp_waiting_list.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_waiting_list.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize_methods .

* initialize methods.

ENDMETHOD.


METHOD initialize_screens.

  DATA: lr_scr_waiting_list  TYPE REF TO cl_ish_scr_waiting_list.

* create screen objects.
  CALL METHOD cl_ish_scr_waiting_list=>create
    IMPORTING
      er_instance     = lr_scr_waiting_list
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Save all used screen object in gt_screen_objects.
  APPEND lr_scr_waiting_list TO gt_screen_objects.

ENDMETHOD.


METHOD prealloc_from_external_int.

* ED, ID 16882 -> BEGIN
  DATA: lt_ddfields       TYPE ddfields,
        l_rc              TYPE ish_method_rc,
        lr_corder         TYPE REF TO cl_ish_corder,
        ls_corder_x       TYPE rn1_corder_x,
        l_field_supported TYPE c,
        l_value           TYPE nfvvalue,
        ls_data           TYPE rnwlm_attrib,
        lt_con_obj        TYPE ish_objectlist,
        ls_object         TYPE ish_object,
        lr_absence        TYPE REF TO cl_ish_waiting_list_absence,
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

  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = 'RN1_CORDER_X'
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
    LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
      CLEAR: l_field_supported.
      CHECK <ls_mapping>-fieldname = <ls_ddfield>-fieldname.
      l_field_supported = 'X'.
      CHECK l_field_supported = 'X'.
*     fill changing structure
      CONCATENATE 'LS_CORDER_X-' <ls_mapping>-fieldname INTO l_fname.
      ASSIGN (l_fname) TO <fst>.
      <fst> = <ls_mapping>-fvalue.
*     fill X-Flag too
      CONCATENATE 'LS_CORDER_X-' <ls_mapping>-fieldname
      '_x' INTO l_fname.
      ASSIGN (l_fname) TO <fst>.
      <fst> = on.
    ENDLOOP. "LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
    CHECK e_rc = 0.
  ENDLOOP. "LOOP AT it_mapping ASSIGNING <ls_mapping>
* Change corder data.
  IF NOT ls_corder_x IS INITIAL.
    CALL METHOD lr_corder->change
      EXPORTING
        is_corder_x     = ls_corder_x
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* absence *************************************
  CLEAR: lt_ddfields[].
  CALL METHOD cl_ish_utl_rtti=>get_ddfields_by_struct_name
    EXPORTING
      i_data_name     = 'NWLM'
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  l_index = 0.
  DO.
    l_index = l_index + 1.
    CLEAR: ls_data.
    LOOP AT it_mapping ASSIGNING <ls_mapping>
        WHERE instno = l_index
          AND compid = l_compid.
      LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
        CLEAR: l_field_supported.
        CHECK <ls_mapping>-fieldname = <ls_ddfield>-fieldname.
        l_field_supported = 'X'.
        CHECK l_field_supported = 'X'.
*       fill changing structure
        CONCATENATE 'LS_DATA-' <ls_mapping>-fieldname INTO l_fname.
        ASSIGN (l_fname) TO <fst>.
        <fst> = <ls_mapping>-fvalue.
      ENDLOOP. "LOOP AT lt_ddfields ASSIGNING <ls_ddfield>.
    ENDLOOP. "LOOP AT it_mapping ASSIGNING <ls_mapping>
    IF sy-subrc <> 0.
      EXIT.
    ELSE.
*     create a new absence
      CALL METHOD cl_ish_waiting_list_absence=>create
        EXPORTING
          is_data              = ls_data
          i_environment        = gr_environment
          it_connected_objects = lt_con_obj
        IMPORTING
          e_instance           = lr_absence
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
    ENDIF.
  ENDDO.
* ED, ID 16882 -> END

ENDMETHOD.


METHOD prealloc_internal.

  DATA: lt_cordpos        TYPE ish_t_cordpos,
        lr_cordpos        TYPE REF TO cl_ishmed_prereg,
        lr_compdef        TYPE REF TO cl_ish_compdef,
        lr_cordtyp        TYPE REF TO cl_ish_cordtyp,
        ls_n1cordtyp      TYPE n1cordtyp,
        ls_field_val      TYPE rnfield_value,
        lr_scr_wt         TYPE REF TO cl_ish_scr_waiting_list,
        lr_screen_obj     TYPE REF TO if_ish_screen,
        lr_corder         TYPE REF TO cl_ish_corder,
        l_has_ass_compdef TYPE ish_on_off,
        lr_cordtyp_save   TYPE REF TO cl_ish_cordtyp,
        lt_field_val      TYPE ish_t_field_value,
        ls_corder_x       TYPE rn1_corder_x,
        l_new             TYPE ish_on_off.

  CLEAR e_rc.

* only go on if the global variable for preallocate is off ->
* it means that no preallocation was done already
  CHECK g_prealloc_done = off.

*-- begin delete, MED-38889
*  READ TABLE gt_screen_objects INDEX 1 INTO lr_screen_obj.
*  CHECK NOT lr_screen_obj IS INITIAL.
*  lr_scr_wt ?= lr_screen_obj.
*  CHECK NOT lr_scr_wt IS INITIAL.
*-- end delete, MED-38889

  CALL METHOD cl_ish_compdef=>get_compdef
    EXPORTING
      i_obtyp    = cl_ish_cordtyp=>co_obtyp
      i_classid  = cl_ish_comp_waiting_list=>co_classid
    IMPORTING
      er_compdef = lr_compdef.
  CHECK NOT lr_compdef IS INITIAL.

* first get all corder positions to main object -> corder
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Prealloc only on new corder object.
  CALL METHOD lr_corder->is_new
    IMPORTING
      e_new = l_new.
  IF l_new = off.
    g_prealloc_done = on.
    EXIT.
  ENDIF.

** Get corder data.
*  CALL METHOD lr_corder->get_data
*    IMPORTING
*      es_n1corder     = ls_n1corder
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.

  CALL METHOD lr_corder->get_t_cordpos
    EXPORTING
      ir_environment  = gr_environment
    IMPORTING
      et_cordpos      = lt_cordpos
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lt_cordpos[] IS INITIAL.
  LOOP AT lt_cordpos INTO lr_cordpos.
    CALL METHOD lr_cordpos->get_cordtyp
      RECEIVING
        rr_cordtyp = lr_cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.
    CALL METHOD lr_cordtyp->has_ass_compdef
      EXPORTING
        ir_compdef        = lr_compdef
      RECEIVING
        r_has_ass_compdef = l_has_ass_compdef.
    IF l_has_ass_compdef = on.
      lr_cordtyp_save = lr_cordtyp.
      EXIT.
    ENDIF.
  ENDLOOP.

* a cordtyp has a waiting list comp def
  IF NOT lr_cordtyp_save IS INITIAL.
*-- begin delete, MED-38889
*    CALL METHOD lr_scr_wt->get_fields
*      IMPORTING
*        et_field_values = lt_field_val
*        e_rc            = e_rc
*      CHANGING
*        c_errorhandler  = cr_errorhandler.
*    CHECK e_rc = 0.
*-- end delete, MED-38889

*   get the preallocation
    CALL METHOD lr_cordtyp->get_data
      IMPORTING
        es_n1cordtyp = ls_n1cordtyp.
    IF NOT ls_n1cordtyp-wltyp IS INITIAL.
*     wltyp
*-- begin delete, MED-38889
*      CLEAR ls_field_val.
*      LOOP AT lt_field_val INTO ls_field_val
*        WHERE fieldname =
*               cl_ish_scr_waiting_list=>g_fieldname_wltyp.
*        IF ls_field_val-value IS INITIAL OR
*           ls_field_val-value = space.
*-- end delete, MED-38889
          ls_corder_x-wltyp      = ls_n1cordtyp-wltyp.
          ls_corder_x-wltyp_x    = on.
*-- begin delete, MED-38889
*          ls_field_val-value     = ls_n1cordtyp-wltyp.
*        ENDIF.
*        MODIFY lt_field_val FROM ls_field_val.
*      ENDLOOP.
**     Warteliste - Aufnahmedatum
*      CLEAR ls_field_val.
*      LOOP AT lt_field_val INTO ls_field_val
*        WHERE fieldname =
*               cl_ish_scr_waiting_list=>g_fieldname_wladt.
*        IF ls_field_val-value IS INITIAL.
*-- end delete, MED-38889
          ls_corder_x-wladt      = sy-datum.
          ls_corder_x-wladt_x    = on.
*-- begin delete, MED-38889
*          ls_field_val-value  =  sy-datum.
*        ENDIF.
*        MODIFY lt_field_val FROM ls_field_val.
*      ENDLOOP.
*-- end delete, MED-38889
    ENDIF.

*-- begin delete, MED-38889
* Set field values in waiting list screen.
*    CALL METHOD lr_scr_wt->set_fields
*      EXPORTING
*        it_field_values  = lt_field_val
*        i_field_values_x = on
*      IMPORTING
*        e_rc             = e_rc
*      CHANGING
*        c_errorhandler   = cr_errorhandler.
*    CHECK e_rc = 0.
*-- end delete, MED-38889

*   change the corder object
    CALL METHOD lr_corder->change
      EXPORTING
        is_corder_x     = ls_corder_x
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.

    g_prealloc_done = on.


  ENDIF.

ENDMETHOD.


METHOD PREALLOC_INTERNAL_SAV .

  DATA: lt_cordpos        TYPE ish_t_cordpos,
        lr_cordpos        TYPE REF TO cl_ishmed_prereg,
        lr_compdef        TYPE REF TO cl_ish_compdef,
        lr_cordtyp        TYPE REF TO cl_ish_cordtyp,
        ls_n1cordtyp      TYPE n1cordtyp,
        ls_field_val      TYPE rnfield_value,
        lr_scr_wt         TYPE REF TO cl_ish_scr_waiting_list,
        lr_screen_obj     TYPE REF TO if_ish_screen,
        lr_corder         TYPE REF TO cl_ish_corder,
        l_has_ass_compdef TYPE ish_on_off,
        lr_cordtyp_save   TYPE REF TO cl_ish_cordtyp,
        lt_field_val      TYPE ish_t_field_value,
        ls_corder_x       TYPE rn1_corder_x,
        l_new             TYPE ish_on_off.

  CLEAR e_rc.

* only go on if the global variable for preallocate is off ->
* it means that no preallocation was done already
  CHECK g_prealloc_done = off.

  READ TABLE gt_screen_objects INDEX 1 INTO lr_screen_obj.
  CHECK NOT lr_screen_obj IS INITIAL.
  lr_scr_wt ?= lr_screen_obj.
  CHECK NOT lr_scr_wt IS INITIAL.

  CALL METHOD cl_ish_compdef=>get_compdef
    EXPORTING
      i_obtyp    = cl_ish_cordtyp=>co_obtyp
      i_classid  = cl_ish_comp_waiting_list=>co_classid
    IMPORTING
      er_compdef = lr_compdef.
  CHECK NOT lr_compdef IS INITIAL.

* first get all corder positions to main object -> corder
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Prealloc only on new corder object.
  CALL METHOD lr_corder->is_new
    IMPORTING
      e_new = l_new.
  IF l_new = off.
    g_prealloc_done = on.
    EXIT.
  ENDIF.

** Get corder data.
*  CALL METHOD lr_corder->get_data
*    IMPORTING
*      es_n1corder     = ls_n1corder
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.

  CALL METHOD lr_corder->get_t_cordpos
    EXPORTING
      ir_environment  = gr_environment
    IMPORTING
      et_cordpos      = lt_cordpos
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lt_cordpos[] IS INITIAL.
  LOOP AT lt_cordpos INTO lr_cordpos.
    CALL METHOD lr_cordpos->get_cordtyp
      RECEIVING
        rr_cordtyp = lr_cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.
    CALL METHOD lr_cordtyp->has_ass_compdef
      EXPORTING
        ir_compdef        = lr_compdef
      RECEIVING
        r_has_ass_compdef = l_has_ass_compdef.
    IF l_has_ass_compdef = on.
      lr_cordtyp_save = lr_cordtyp.
      EXIT.
    ENDIF.
  ENDLOOP.

* a cordtyp has a waiting list comp def
  IF NOT lr_cordtyp_save IS INITIAL.

    CALL METHOD lr_scr_wt->get_fields
      IMPORTING
        et_field_values = lt_field_val
        e_rc            = e_rc
      CHANGING
        c_errorhandler  = cr_errorhandler.
    CHECK e_rc = 0.

*   get the preallocation
    CALL METHOD lr_cordtyp->get_data
      IMPORTING
        es_n1cordtyp = ls_n1cordtyp.
    IF NOT ls_n1cordtyp-wltyp IS INITIAL.
*     wltyp
      CLEAR ls_field_val.
      LOOP AT lt_field_val INTO ls_field_val
        WHERE fieldname =
               cl_ish_scr_waiting_list=>g_fieldname_wltyp.
        IF ls_field_val-value IS INITIAL OR
           ls_field_val-value = space.
          ls_corder_x-wltyp      = ls_n1cordtyp-wltyp.
          ls_corder_x-wltyp_x    = on.
          ls_field_val-value     = ls_n1cordtyp-wltyp.
        ENDIF.
        MODIFY lt_field_val FROM ls_field_val.
      ENDLOOP.
*     Warteliste - Aufnahmedatum
      CLEAR ls_field_val.
      LOOP AT lt_field_val INTO ls_field_val
        WHERE fieldname =
               cl_ish_scr_waiting_list=>g_fieldname_wladt.
        IF ls_field_val-value IS INITIAL.
          ls_corder_x-wladt      = sy-datum.
          ls_corder_x-wladt_x    = on.
          ls_field_val-value  =  sy-datum.
        ENDIF.
        MODIFY lt_field_val FROM ls_field_val.
      ENDLOOP.
    ENDIF.

* Set field values in waiting list screen.
    CALL METHOD lr_scr_wt->set_fields
      EXPORTING
        it_field_values  = lt_field_val
        i_field_values_x = on
      IMPORTING
        e_rc             = e_rc
      CHANGING
        c_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.
*   change the corder object
    CALL METHOD lr_corder->change
      EXPORTING
        is_corder_x     = ls_corder_x
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.

    g_prealloc_done = on.


  ENDIF.


ENDMETHOD.


METHOD transport_from_screen_internal.

* The waiting list screen uses an old subscreen.
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

  DATA: lr_scr_waiting_list TYPE REF TO cl_ish_scr_waiting_list.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              cl_ish_scr_waiting_list=>co_otype_scr_waiting_list ) = on.
    lr_scr_waiting_list ?= ir_screen.
    CALL METHOD trans_to_scr_waiting_list
      EXPORTING
        ir_scr_waiting_list = lr_scr_waiting_list
      IMPORTING
        e_rc                = e_rc
      CHANGING
        cr_errorhandler     = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_corder_to_fv_wl .

  DATA: ls_field_val          TYPE rnfield_value.

* wlrrn
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_waiting_list=>g_fieldname_wlrrn.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = is_n1corder-wlrrn.
  INSERT ls_field_val INTO TABLE ct_field_val.

* wltyp
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_waiting_list=>g_fieldname_wltyp.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = is_n1corder-wltyp.
  INSERT ls_field_val INTO TABLE ct_field_val.

* wlpri
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_waiting_list=>g_fieldname_wlpri.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = is_n1corder-wlpri.
  INSERT ls_field_val INTO TABLE ct_field_val.

* wladt
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_waiting_list=>g_fieldname_wladt.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = is_n1corder-wladt.
  INSERT ls_field_val INTO TABLE ct_field_val.

* wlrdt
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_waiting_list=>g_fieldname_wlrdt.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = is_n1corder-wlrdt.
  INSERT ls_field_val INTO TABLE ct_field_val.

* wlhsp
  CLEAR ls_field_val.
  ls_field_val-fieldname = cl_ish_scr_waiting_list=>g_fieldname_wlhsp.
  ls_field_val-type      = co_fvtype_single.
  ls_field_val-value     = is_n1corder-wlhsp.
  INSERT ls_field_val INTO TABLE ct_field_val.

ENDMETHOD.


METHOD trans_corder_to_scr_wl .

  DATA: ls_n1corder           TYPE n1corder,
        lt_field_val          TYPE ish_t_field_value.

  CHECK NOT ir_corder           IS INITIAL.
  CHECK NOT ir_scr_waiting_list IS INITIAL.

* Get corder data.
  CALL METHOD ir_corder->get_data
    IMPORTING
      es_n1corder     = ls_n1corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Build field values.
  CLEAR lt_field_val.
  CALL METHOD trans_corder_to_fv_wl
    EXPORTING
      ir_corder       = ir_corder
      is_n1corder     = ls_n1corder
    IMPORTING
      e_rc            = e_rc
    CHANGING
      ct_field_val    = lt_field_val
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Set main object in waiting list screen.
  CALL METHOD ir_scr_waiting_list->set_data
    EXPORTING
      i_main_object   = ir_corder
      i_main_object_x = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Set field values in waiting list screen.
  CALL METHOD ir_scr_waiting_list->set_fields
    EXPORTING
      it_field_values  = lt_field_val
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_to_scr_waiting_list .

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object      IS INITIAL.
  CHECK NOT ir_scr_waiting_list IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_to_scr_wl
      EXPORTING
        ir_corder           = lr_corder
        ir_scr_waiting_list = ir_scr_waiting_list
      IMPORTING
        e_rc                = e_rc
      CHANGING
        cr_errorhandler     = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.
ENDCLASS.
