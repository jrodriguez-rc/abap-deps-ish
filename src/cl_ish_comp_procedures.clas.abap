class CL_ISH_COMP_PROCEDURES definition
  public
  inheriting from CL_ISH_COMPONENT_STD
  create public .

*"* public components of class CL_ISH_COMP_PROCEDURES
*"* do not include other source files here!!!
public section.

  constants CO_CLASSID type N1COMPCLASSID value 'CL_ISH_COMP_PROCEDURES'. "#EC NOTEXT
  constants CO_OTYPE_COMP_PROCEDURES type ISH_OBJECT_TYPE value 8007. "#EC NOTEXT

  methods CONSTRUCTOR .
  class-methods CLASS_CONSTRUCTOR .
  methods GET_CORDER
    returning
      value(RR_CORDER) type ref to CL_ISH_CORDER .
  methods GET_PROCEDURES
    importing
      value(I_CANCELLED_DATAS) type ISH_ON_OFF default OFF
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
    exporting
      value(ET_PROCEDURES) type ISH_T_PREREG_PROCEDURE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_PROCEDURE_MANDATORY
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
*"* protected components of class CL_ISH_COMP_PROCEDURES
*"* do not include other source files here!!!

  class-data GT_CDOC_FIELD type ISH_T_CDOC_FIELD .
  class-data GT_PRINT_FIELD type ISH_T_PRINT_FIELD .

  methods TRANS_CORDER_TO_FV_PROCEDURES
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IT_NPCP type ISH_T_NPCP
      !IT_PROCEDURES type ISH_T_PREREG_PROCEDURE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_FIELD_VAL type ISH_T_FIELD_VALUE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_CORDER_TO_SCR_PROCEDURES
    importing
      !IR_CORDER type ref to CL_ISH_CORDER
      !IR_SCR_PROCEDURES type ref to CL_ISH_SCR_PROCEDURES
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANS_TO_SCR_PROCEDURES
    importing
      !IR_SCR_PROCEDURES type ref to CL_ISH_SCR_PROCEDURES
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
*"* private components of class CL_ISH_COMP_PROCEDURES
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMP_PROCEDURES IMPLEMENTATION.


METHOD check_procedure_mandatory.

  DATA: lt_procedures               TYPE ish_t_prereg_procedure,
        lr_procedure                TYPE REF TO cl_ish_prereg_procedure.
  DATA: lr_cordpos                  TYPE REF TO cl_ishmed_cordpos,
        lr_cordtyp                  TYPE REF TO cl_ishmed_cordtyp,
        l_compid                    TYPE n1compid,
        lr_corder                   TYPE REF TO cl_ish_corder,
        lt_screen                   TYPE ish_t_screen_objects,
        lr_screen                   TYPE REF TO if_ish_screen,
        lr_scr_procedures           TYPE REF TO cl_ish_scr_procedures,
        l_screenid                  TYPE i,
        l_stsma                     TYPE j_stsma,
        l_estat                     TYPE j_estat,
        lt_scrm                     TYPE ishmed_t_scrm,
        lr_scrm                     TYPE REF TO cl_ishmed_scrm,
        l_attrib                    TYPE n1fattr_value-fattr_value_id,
        lt_service                  TYPE ish_objectlist,
        l_posnr                     TYPE n1vkg-posnr,
        l_rc                        TYPE ish_method_rc,
        lt_run_data                 TYPE ish_t_objectbase,
        lr_run_data                 TYPE REF TO if_ish_objectbase,
        lt_procedure                TYPE ish_t_prereg_procedure,
        l_umfeld                    TYPE string,
        lt_cordpos                  TYPE ish_t_cordpos,
        l_new                       TYPE ish_on_off,
        l_cancelled                 TYPE ish_on_off,
        lr_prereg                   TYPE REF TO cl_ishmed_prereg,
        lr_config                   TYPE REF TO cl_ishmed_con_corder,
        lt_cordpos_check_mandatory  TYPE ish_t_cordpos,
        l_cordpos_found             TYPE ish_on_off,
        lr_service                  TYPE REF TO cl_ishmed_service,
        l_type                      TYPE i. "ED, ID 17900

  FIELD-SYMBOLS: <lr_prereg>        TYPE REF TO cl_ishmed_prereg,
                 <ls_fv_srv>        TYPE rnfield_value.

* Get all procedure objects.
  CALL METHOD get_procedures
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_procedures     = lt_procedures
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each procedure object.
  LOOP AT lt_procedures INTO lr_procedure.
    CHECK NOT lr_procedure IS INITIAL.
*   Check procedure object.
    CALL METHOD lr_procedure->check
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.
*-------- BEGIN C.Honeder MED-9409
  CHECK me->is_inherited_from(
     cl_ishmed_corder=>co_otype_corder_med ) = on .

*  CALL METHOD lr_corder->get_type
*    IMPORTING
*      e_object_type = l_type.
*  CHECK l_type = cl_ishmed_corder=>co_otype_corder_med.
*-------- END C.Honeder MED-9409


* get all corder positions
  CALL METHOD lr_corder->get_t_cordpos
    IMPORTING
      et_cordpos      = lt_cordpos
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get selfs compid.
  l_compid = get_compid( ).

* Get the procedure screen.
  lt_screen = get_defined_screens( ).
  LOOP AT lt_screen INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CHECK lr_screen->is_inherited_from(
                cl_ish_scr_procedures=>co_otype_scr_procedures ) = on.
    lr_scr_procedures ?= lr_screen.
    EXIT.
  ENDLOOP.
  CHECK NOT lr_scr_procedures IS INITIAL.

* Get the screenid.
*  CALL METHOD lr_scr_procedures->get_type
*    IMPORTING
*      e_object_type = l_screenid.
    l_screenid = lr_scr_procedures->get_screenid( ).

* Loop cordpos objects.
  CLEAR lr_prereg.
  LOOP AT lt_cordpos INTO lr_prereg.

*   Casting.
    lr_cordpos ?= lr_prereg.

*   Get the cordtyp.
    lr_cordtyp = lr_cordpos->get_cordtyp_med( ).

*   Process only if there is already a cordtyp.
    CHECK NOT lr_cordtyp IS INITIAL.

*   Is there a configuration?
    IF gr_config IS BOUND.
*     Castings.
      IF NOT lr_config IS BOUND.
        lr_config ?= gr_config.
      ENDIF.
      IF lr_config IS BOUND AND lr_prereg IS BOUND.
*       Get config's cordpos table.
        CALL METHOD lr_config->get_cordpos_check_mandatory
          RECEIVING
            rt_cordpos_check_mandatory = lt_cordpos_check_mandatory.
*       Search current cordpos in cordpos table.
        l_cordpos_found = off.
        LOOP AT lt_cordpos_check_mandatory ASSIGNING <lr_prereg>.
          CHECK <lr_prereg> = lr_prereg.
          l_cordpos_found = on.
          EXIT.
        ENDLOOP.
*       Cordpos not found => no mandatory checks.
        CHECK l_cordpos_found = on.
      ENDIF.
    ENDIF.

*   Get the cordpos status.
    CALL METHOD lr_cordpos->get_status
      IMPORTING
        e_stsma         = l_stsma
        e_estat         = l_estat
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    CHECK NOT l_stsma IS INITIAL.
    CHECK NOT l_estat IS INITIAL.

*   Get screen modifications for actual status.
    CALL METHOD lr_cordtyp->get_t_scrm
      EXPORTING
        i_compid        = l_compid
        i_screenid      = l_screenid
        i_stsma         = l_stsma
        i_estat         = l_estat
        i_fattr_type_id = cl_ishmed_fattr_type=>co_display
      IMPORTING
        et_scrm         = lt_scrm.
    CHECK NOT lt_scrm IS INITIAL.

*   Get the display attribute for icpm.
    l_attrib = cl_ishmed_fattr_value=>co_display_can.
    LOOP AT lt_scrm INTO lr_scrm.
      CHECK NOT lr_scrm IS INITIAL.
      CHECK lr_scrm->get_fieldname( ) =
        lr_scr_procedures->g_fieldname_icpm.
      l_attrib = lr_scrm->get_fattr_value_id( ).
      EXIT.
    ENDLOOP.

*   Check mandatory of at least one procedure.
    IF l_attrib = cl_ishmed_fattr_value=>co_display_must.
      CALL METHOD me->get_procedures
        IMPORTING
          et_procedures   = lt_procedure
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      IF lt_procedure IS INITIAL.
        CALL METHOD cr_errorhandler->collect_messages
          EXPORTING
            i_typ    = 'E'
            i_kla    = 'N1BASE'
            i_num    = '062'
            i_object = lr_procedure
            i_mv1    = 'OP-Code (Kopfbaustein Prozeduren)'(002)
            i_par    = 'RNPREGP'
            i_fld    = 'ICPM'
            i_last   = space.
        e_rc = 1.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD class_constructor .

  DATA: l_cdoc_field  TYPE rn1_cdoc_field,
        l_print_field TYPE rn1_print_field,
        l_fieldname   TYPE string,
        lt_fieldname  TYPE ish_t_string.

  CLEAR: gt_cdoc_field[],
         gt_print_field[].


* Build table for cdoc.

* NPCP
  CLEAR: l_cdoc_field,
         lt_fieldname[].
  l_cdoc_field-objecttype  =
cl_ish_prereg_procedure=>co_otype_prereg_procedure.
  l_cdoc_field-tabname     = 'NPCP'.

  l_fieldname              = 'ICPMC'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ICPM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ICPML'.
  APPEND l_fieldname TO lt_fieldname.

  l_cdoc_field-t_fieldname = lt_fieldname.
  APPEND l_cdoc_field TO gt_cdoc_field.


* Build table for print.

* NPCP
  CLEAR: l_print_field,
         lt_fieldname[].
  l_print_field-objecttype  =
  cl_ish_prereg_procedure=>co_otype_prereg_procedure.
  l_print_field-tabname     = 'NPCP'.

  l_fieldname              = 'ICPMC'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ICPM'.
  APPEND l_fieldname TO lt_fieldname.
  l_fieldname              = 'ICPML'.
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

  DATA: lt_run_data       TYPE ish_t_objectbase,
        lr_corder_new     TYPE REF TO cl_ish_corder,
        l_rc              TYPE ish_method_rc,
        lr_object         TYPE REF TO if_ish_objectbase,
        ls_object         TYPE ish_object,
        lt_con_obj        TYPE ish_objectlist,
        lr_proc           TYPE REF TO cl_ish_prereg_procedure,
        lr_proc_new       TYPE REF TO cl_ish_prereg_procedure,
        ls_data           TYPE rnpcp_attrib.

  CHECK i_copy EQ 'C' OR   "Grill, med.20702
        i_copy EQ 'X' OR
        i_copy EQ 'L'.     "IXX-115 Naomi Popa 06.01.2015

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

* get procedures
  LOOP AT lt_run_data INTO lr_object.
    CHECK lr_object->is_inherited_from(
           cl_ish_prereg_procedure=>co_otype_prereg_procedure ) = on.
    lr_proc ?= lr_object.
*   get data from prov
    CALL METHOD lr_proc->get_data
      IMPORTING
        es_data        = ls_data
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
*   don't copy the cancelled procedures!!
    CHECK ls_data-storn = off.
*   clear some fields
    CLEAR: ls_data-vkgid.
*   create a new procedure
    CALL METHOD cl_ish_prereg_procedure=>create
      EXPORTING
        is_data              = ls_data
        i_environment        = gr_environment
        it_connected_objects = lt_con_obj
      IMPORTING
        e_instance           = lr_proc_new
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


METHOD get_dom_for_run_data.

  DATA: lr_document_fragment TYPE REF TO if_ixml_document_fragment,
        lr_element           TYPE REF TO if_ixml_element,
        lr_text              TYPE REF TO if_ixml_text,
        lr_fragment          TYPE REF TO if_ixml_document_fragment,
        l_objecttype         TYPE i.
  DATA: lr_procedure       TYPE REF TO cl_ish_prereg_procedure,
        lt_ddfields        TYPE ddfields,
        ls_cdoc            TYPE rn1_cdoc,
        l_fieldname        TYPE string,
        l_get_all_fields   TYPE c,
        l_field_supported  TYPE c,
        l_field_value      TYPE string,
        ls_field           TYPE rn1_field,
        l_key              TYPE string,
        ls_data            TYPE rnpcp_attrib,
        l_icpmt            TYPE string,
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
  CLEAR: er_document_fragment,
         ls_data,
         l_icpmt.

  CHECK NOT ir_document IS INITIAL.
  CHECK NOT ir_run_data IS INITIAL.

  CHECK ir_run_data->is_inherited_from(
                   cl_ish_prereg_procedure=>co_otype_prereg_procedure ) = on.

  lr_procedure ?= ir_run_data.
  CHECK lr_procedure IS BOUND.

  CALL METHOD lr_procedure->get_data
    IMPORTING
*      ES_KEY         =
      es_data        = ls_data
*      ES_DATA_DB     =
*      E_MODE         =
*      E_RC           =
*    CHANGING
*      C_ERRORHANDLER =
      .

  IF NOT ls_data IS INITIAL.
    SELECT SINGLE ktxt1 FROM ntpt INTO l_icpmt
     WHERE spras = sy-langu                                 "ED 22.2.05
       AND einri = ls_data-einri "ED, 22.2.05
       AND tarif = ls_data-icpmc
       AND talst = ls_data-icpm.
  ENDIF.

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

*     Set procedure text.
      IF <ls_ddfield>-fieldname = 'ICPM'.
        CONCATENATE l_field_value l_icpmt
               INTO l_field_value SEPARATED BY space.
      ENDIF.

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
  l_string = 'Prozeduren'(001).
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


method GET_PROCEDURES .

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        lr_procedure     TYPE REF TO cl_ish_prereg_procedure,
        lt_object        TYPE ish_objectlist,
        l_cancelled      TYPE ish_on_off,
        l_deleted        TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_object>  TYPE ish_object.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get all connected procedures from corder.
  CALL METHOD lr_corder->get_connections
    EXPORTING
      i_type     = CL_ISH_PREREG_PROCEDURE=>co_otype_prereg_procedure
    IMPORTING
      et_objects = lt_object.

* Build et_procedures.
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    lr_procedure ?= <ls_object>-object.
    IF i_cancelled_datas = off.
      CALL METHOD lr_procedure->is_cancelled
        IMPORTING
          e_cancelled = l_cancelled
          e_deleted   = l_deleted.
      CHECK l_cancelled = off.
      CHECK l_deleted   = off.
    ENDIF.
    APPEND lr_procedure TO et_procedures.
  ENDLOOP.

endmethod.


METHOD if_ish_component~cancel.

* Michael Manoch, 05.07.2004, ID 14907   START
* Redefine the method to cancel the procedures.

  DATA: lt_procedures   TYPE ish_t_prereg_procedure,
        lr_procedure    TYPE REF TO cl_ish_prereg_procedure.

* Get all procedure objects.
  CALL METHOD get_procedures
    EXPORTING
      i_cancelled_datas = off
    IMPORTING
      et_procedures     = lt_procedures
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each procedure object.
  LOOP AT lt_procedures INTO lr_procedure.
    CHECK NOT lr_procedure IS INITIAL.
*   Cancel procedure object.
    CALL METHOD lr_procedure->cancel
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

* Michael Manoch, 05.07.2004, ID 14907   END

ENDMETHOD.


METHOD if_ish_component~check .

* ED, ID 18427: new method for checking (CHECK_PROCEDURE_MANDATORY) -> BEGIN COMMENT
*  DATA: lt_procedures               TYPE ish_t_prereg_procedure,
*        lr_procedure                TYPE REF TO cl_ish_prereg_procedure.
** ED, int. M. 0120061532 0001261428 2005 -> BEGIN
*  DATA: lr_cordpos                  TYPE REF TO cl_ishmed_cordpos,
*        lr_cordtyp                  TYPE REF TO cl_ishmed_cordtyp,
*        l_compid                    TYPE n1compid,
*        lr_corder                   TYPE REF TO cl_ish_corder,
*        lt_screen                   TYPE ish_t_screen_objects,
*        lr_screen                   TYPE REF TO if_ish_screen,
*        lr_scr_procedures           TYPE REF TO cl_ish_scr_procedures,
*        l_screenid                  TYPE i,
*        l_stsma                     TYPE j_stsma,
*        l_estat                     TYPE j_estat,
*        lt_scrm                     TYPE ishmed_t_scrm,
*        lr_scrm                     TYPE REF TO cl_ishmed_scrm,
*        l_attrib                    TYPE n1fattr_value-fattr_value_id,
*        lt_service                  TYPE ish_objectlist,
*        l_posnr                     TYPE n1vkg-posnr,
*        l_rc                        TYPE ish_method_rc,
*        lt_run_data                 TYPE ish_t_objectbase,
*        lr_run_data                 TYPE REF TO if_ish_objectbase,
*        lt_procedure                TYPE ish_t_prereg_procedure,
*        l_umfeld                    TYPE string,
*        lt_cordpos                  TYPE ish_t_cordpos,
*        l_new                       TYPE ish_on_off,
*        l_cancelled                 TYPE ish_on_off,
*        lr_prereg                   TYPE REF TO cl_ishmed_prereg,
*        lr_config                   TYPE REF TO cl_ishmed_con_corder,
*        lt_cordpos_check_mandatory  TYPE ish_t_cordpos,
*        l_cordpos_found             TYPE ish_on_off,
*        lr_service                  TYPE REF TO cl_ishmed_service,
*        l_type                      TYPE i. "ED, ID 17900
*
*  FIELD-SYMBOLS: <lr_prereg>        TYPE REF TO cl_ishmed_prereg,
*                 <ls_fv_srv>        TYPE rnfield_value.
** ED, int. M. 0120061532 0001261428 2005 -> END
* ED, ID 18427 -> END COMMENT

* Process super method.
  CALL METHOD super->if_ish_component~check
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* ED, ID 18427: new method for checking (CHECK_PROCEDURE_MANDATORY) -> BEGIN COMMENT
** Get all procedure objects.
*  CALL METHOD get_procedures
*    EXPORTING
*      i_cancelled_datas = on
*    IMPORTING
*      et_procedures     = lt_procedures
*      e_rc              = e_rc
*    CHANGING
*      cr_errorhandler   = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Process each procedure object.
*  LOOP AT lt_procedures INTO lr_procedure.
*    CHECK NOT lr_procedure IS INITIAL.
**   Check procedure object.
*    CALL METHOD lr_procedure->check
*      IMPORTING
*        e_rc           = e_rc
*      CHANGING
*        c_errorhandler = cr_errorhandler.
*    IF e_rc <> 0.
*      EXIT.
*    ENDIF.
*  ENDLOOP.
*  CHECK e_rc = 0.
*
** ED, int. M. 0120061532 0001261428 2005 -> BEGIN
** Get corder object.
*  lr_corder = get_corder( ).
*  CHECK NOT lr_corder IS INITIAL.
*
** ED, ID 17900: check if ishmed -> if not don't check screenmodifications -> BEGIN
*  CALL METHOD lr_corder->get_type
*    IMPORTING
*      e_object_type = l_type.
*  CHECK l_type = co_otype_corder_med.
** ED, ID 17900 -> END
*
** get all corder positions
*  CALL METHOD lr_corder->get_t_cordpos
*    IMPORTING
*      et_cordpos      = lt_cordpos
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.
*
** Get selfs compid.
*  l_compid = get_compid( ).
*
** Get the procedure screen.
*  lt_screen = get_defined_screens( ).
*  LOOP AT lt_screen INTO lr_screen.
*    CHECK NOT lr_screen IS INITIAL.
*    CHECK lr_screen->is_inherited_from(
*                co_otype_scr_procedures ) = on.
*    lr_scr_procedures ?= lr_screen.
*    EXIT.
*  ENDLOOP.
*  CHECK NOT lr_scr_procedures IS INITIAL.
*
** Get the screenid.
*  CALL METHOD lr_scr_procedures->get_type
*    IMPORTING
*      e_object_type = l_screenid.
*
** Loop cordpos objects.
*  CLEAR lr_prereg.
*  LOOP AT lt_cordpos INTO lr_prereg.
*
**   Casting.
*    lr_cordpos ?= lr_prereg.
*
**   Get the cordtyp.
*    lr_cordtyp = lr_cordpos->get_cordtyp_med( ).
*
**   Process only if there is already a cordtyp.
*    CHECK NOT lr_cordtyp IS INITIAL.
*
**   Is there a configuration?
*    IF gr_config IS BOUND.
**     Castings.
*      IF NOT lr_config IS BOUND.
*        lr_config ?= gr_config.
*      ENDIF.
*      IF lr_config IS BOUND AND lr_prereg IS BOUND.
**       Get config's cordpos table.
*        CALL METHOD lr_config->get_cordpos_check_mandatory
*          RECEIVING
*            rt_cordpos_check_mandatory = lt_cordpos_check_mandatory.
**       Search current cordpos in cordpos table.
*        l_cordpos_found = off.
*        LOOP AT lt_cordpos_check_mandatory ASSIGNING <lr_prereg>.
*          CHECK <lr_prereg> = lr_prereg.
*          l_cordpos_found = on.
*          EXIT.
*        ENDLOOP.
**       Cordpos not found => no mandatory checks.
*        CHECK l_cordpos_found = on.
*      ENDIF.
*    ENDIF.
*
**   Get the cordpos status.
*    CALL METHOD lr_cordpos->get_status
*      IMPORTING
*        e_stsma         = l_stsma
*        e_estat         = l_estat
*        e_rc            = l_rc
*      CHANGING
*        cr_errorhandler = cr_errorhandler.
*    IF l_rc <> 0.
*      e_rc = l_rc.
*      EXIT.
*    ENDIF.
*    CHECK NOT l_stsma IS INITIAL.
*    CHECK NOT l_estat IS INITIAL.
*
**   Get screen modifications for actual status.
*    CALL METHOD lr_cordtyp->get_t_scrm
*      EXPORTING
*        i_compid        = l_compid
*        i_screenid      = l_screenid
*        i_stsma         = l_stsma
*        i_estat         = l_estat
*        i_fattr_type_id = cl_ishmed_fattr_type=>co_display
*      IMPORTING
*        et_scrm         = lt_scrm.
*    CHECK NOT lt_scrm IS INITIAL.
*
**   Get the display attribute for icpm.
*    l_attrib = cl_ishmed_fattr_value=>co_display_can.
*    LOOP AT lt_scrm INTO lr_scrm.
*      CHECK NOT lr_scrm IS INITIAL.
*      CHECK lr_scrm->get_fieldname( ) =
*        lr_scr_procedures->g_fieldname_icpm.
*      l_attrib = lr_scrm->get_fattr_value_id( ).
*      EXIT.
*    ENDLOOP.
*
**   Check mandatory of at least one procedure.
*    IF l_attrib = cl_ishmed_fattr_value=>co_display_must.
*      CALL METHOD me->get_procedures
*        IMPORTING
*          et_procedures   = lt_procedure
*          e_rc            = l_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      IF l_rc <> 0.
*        e_rc = l_rc.
*        EXIT.
*      ENDIF.
*      IF lt_procedure IS INITIAL.
*        CALL METHOD cr_errorhandler->collect_messages
*          EXPORTING
*            i_typ    = 'E'
*            i_kla    = 'N1BASE'
*            i_num    = '062'
*            i_object = lr_procedure
*            i_mv1    = 'OP-Code (Kopfbaustein Prozeduren)'(002)
*            i_par    = 'RNPREGP'
*            i_fld    = 'ICPM'
*            i_last   = space.
*        e_rc = 1.
*      ENDIF.
*    ENDIF.
*  ENDLOOP.
** ED, int. M. 0120061532 0001261428 2005 -> END
* ED, ID 18427 -> END COMMENT

* ED, ID 18427: call new method -> BEGIN
  CALL METHOD me->check_procedure_mandatory
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* ED, ID 18427 -> END

ENDMETHOD.


METHOD if_ish_component~check_changes .

  DATA: lt_procedures  TYPE ish_t_prereg_procedure,
        lr_procedure   TYPE REF TO cl_ish_prereg_procedure.

* Get all procedure objects.
  CALL METHOD get_procedures
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_procedures     = lt_procedures
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each procedure object.
  LOOP AT lt_procedures INTO lr_procedure.
    CHECK NOT lr_procedure IS INITIAL.
*   Check radiology object for changes
    e_changed = lr_procedure->is_changed( ).
    IF e_changed = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~get_t_run_data .

  DATA: lt_procedure  TYPE ish_t_prereg_procedure.

* Handle objects of super class.
  CALL METHOD super->if_ish_component~get_t_run_data
    IMPORTING
      et_run_data     = et_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Get procedure objects.
  CALL METHOD get_procedures
    IMPORTING
      et_procedures   = lt_procedure
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Append procedure objects.
  APPEND LINES OF lt_procedure TO et_run_data.

ENDMETHOD.


METHOD if_ish_component~get_t_uid .

  DATA: lr_corder        TYPE REF TO cl_ish_corder,
        lr_obj           TYPE REF TO cl_ish_prereg_procedure,
        lt_object        TYPE ish_objectlist,
        ls_key           TYPE rnpcp_key,
        l_uid            TYPE sysuuid_c.

  FIELD-SYMBOLS: <ls_object>  TYPE ish_object.

* Get corder object.
  lr_corder = get_corder( ).
  CHECK NOT lr_corder IS INITIAL.

* Get all connected procedures from corder.
  CALL METHOD lr_corder->get_connections
    EXPORTING
      i_type     = CL_ISH_PREREG_PROCEDURE=>co_otype_prereg_procedure
    IMPORTING
      et_objects = lt_object.

* For every procedure:
*   - Get its stringified key.
*   - Add the key to et_uid.
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    lr_obj ?= <ls_object>-object.
    CALL METHOD lr_obj->get_data
      IMPORTING
        es_key = ls_key.
    CHECK NOT ls_key-pcpno IS INITIAL.
    l_uid = ls_key-pcpno.
    APPEND l_uid TO rt_uid.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component~save .

  DATA: lt_procedures   TYPE ish_t_prereg_procedure,
        lr_procedure    TYPE REF TO cl_ish_prereg_procedure,
        ls_npcp_key     TYPE rnpcp_key,
        l_uid           TYPE sysuuid_c.

* Get all procedure objects.
  CALL METHOD get_procedures
    EXPORTING
      i_cancelled_datas = on
    IMPORTING
      et_procedures     = lt_procedures
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

* Process each procedure object.
  LOOP AT lt_procedures INTO lr_procedure.
    CHECK NOT lr_procedure IS INITIAL.
*   Save procedure object.
    CALL METHOD lr_procedure->save
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
    CALL METHOD lr_procedure->get_data
      IMPORTING
        es_key = ls_npcp_key.
    l_uid = ls_npcp_key-pcpno.
    APPEND l_uid TO et_uid_save.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component~set_t_uid .

  DATA: lr_obj        TYPE REF TO cl_ish_prereg_procedure,
        lr_corder     TYPE REF TO cl_ish_corder,
        ls_key        TYPE rnpcp_key.

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
    ls_key-pcpno = <l_uid>.
*   Load object.
    CALL METHOD cl_ish_prereg_procedure=>load
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
        l_index                TYPE i,
        l_einri                TYPE tn01-einri,
        l_katid                TYPE tarid,
        l_kattx                TYPE kattx,
        l_dialo                TYPE tn26x-dialo,
        l_dialotext            TYPE tn26x-dialotext.

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

* Get ROOT node.
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
      l_name  = lr_elementval_elem->get_attribute( name = 'NAME' ).
      l_value = lr_elementval_elem->get_value( ).
      CASE l_name.
*       ICPMC
        WHEN 'ICPMC'.
          CLEAR: l_einri, l_katid, l_kattx.
*         Get institution.
          l_einri =
            cl_ish_utl_base=>get_institution_of_obj(
                             gr_main_object ).
          CHECK NOT l_einri IS INITIAL.
*         Get text.
          l_katid = l_value.
          SELECT SINGLE kattx
            FROM tnk01
            INTO l_kattx
           WHERE einri = l_einri
             AND katid = l_katid.
          IF sy-subrc = 0.
            l_value = l_kattx.
          ENDIF.
*             Modify value in DOM node.
          e_rc = lr_elementval_elem->set_value( l_value ).
*       ICPML
        WHEN 'ICPML'.
          CLEAR: l_einri, l_dialo, l_dialotext.
*         Get institution.
          l_einri =
            cl_ish_utl_base=>get_institution_of_obj(
                             gr_main_object ).
          CHECK NOT l_einri IS INITIAL.
*         Get text.
          l_dialo = l_value.
          SELECT SINGLE dialotext
            FROM tn26x
            INTO l_dialotext
           WHERE einri = l_einri
             AND spras = sy-langu
             AND dialo = l_dialo.
          IF sy-subrc = 0.
            l_value = l_dialotext.
          ENDIF.
*         Modify value in DOM node.
          e_rc = lr_elementval_elem->set_value( l_value ).
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

  e_object_type = co_otype_comp_procedures.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  IF i_object_type = co_otype_comp_procedures.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_comp_procedures.
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

  DATA: lr_scr_procedures        TYPE REF TO cl_ish_scr_procedures.

* create screen objects.
* screen procedures
  CALL METHOD cl_ish_scr_procedures=>create
    IMPORTING
      er_instance     = lr_scr_procedures
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Save all used screen object in gt_screen_objects.
  APPEND lr_scr_procedures TO gt_screen_objects.

ENDMETHOD.


METHOD prealloc_from_external_int.

* ED, ID 16882 -> BEGIN
  DATA: lt_ddfields       TYPE ddfields,
        l_rc              TYPE ish_method_rc,
        lr_corder         TYPE REF TO cl_ish_corder,
        ls_corder_x       TYPE rn1_corder_x,
        l_field_supported TYPE c,
        l_value           TYPE nfvvalue,
        ls_data           TYPE rnpcp_attrib,
        lt_con_obj        TYPE ish_objectlist,
        ls_object         TYPE ish_object,
        lr_procedure      TYPE REF TO cl_ish_prereg_procedure,
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
      i_data_name     = 'NPCP'
    IMPORTING
      et_ddfields     = lt_ddfields
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* procedure *************************************
  l_index = 0.
  DO.
    CLEAR: ls_data.
    l_index = l_index + 1.
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
*     create a new procedure
      CALL METHOD cl_ish_prereg_procedure=>create
        EXPORTING
          is_data              = ls_data
          i_environment        = gr_environment
          it_connected_objects = lt_con_obj
        IMPORTING
          e_instance           = lr_procedure
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
* ED, ID 16882 -> END

ENDMETHOD.


METHOD transport_from_screen_internal.

* The procedures screen uses an old subscreen.
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

  DATA: lr_scr_procedures TYPE REF TO cl_ish_scr_procedures.

  CHECK NOT ir_screen IS INITIAL.

* Processing depends on ir_screen's type.
  IF ir_screen->is_inherited_from(
              CL_ISH_SCR_PROCEDURES=>co_otype_scr_procedures ) = on.
    lr_scr_procedures ?= ir_screen.
    CALL METHOD trans_to_scr_procedures
      EXPORTING
        ir_scr_procedures = lr_scr_procedures
      IMPORTING
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD trans_corder_to_fv_procedures.

  DATA: lr_procedure          TYPE REF TO cl_ish_prereg_procedure,
        ls_npcp               TYPE npcp,
        ls_field_val          TYPE rnfield_value.

  LOOP AT it_npcp INTO ls_npcp.
*   ICPM
    CLEAR ls_field_val.
    ls_field_val-fieldname =
                 cl_ish_scr_procedures=>g_fieldname_icpm.
    ls_field_val-type      = co_fvtype_single.
    ls_field_val-value     = ls_npcp-icpm.
    READ TABLE it_procedures INTO lr_procedure INDEX sy-tabix.
    IF sy-subrc = 0.
      ls_field_val-object  = lr_procedure.
    ENDIF.
    INSERT ls_field_val INTO TABLE ct_field_val.
*   ICPML
    CLEAR ls_field_val.
    ls_field_val-fieldname =
                 cl_ish_scr_procedures=>g_fieldname_icpml.
    ls_field_val-type      = co_fvtype_single.
    ls_field_val-value     = ls_npcp-icpml.
    READ TABLE it_procedures INTO lr_procedure INDEX sy-tabix.
    IF sy-subrc = 0.
      ls_field_val-object  = lr_procedure.
    ENDIF.
    INSERT ls_field_val INTO TABLE ct_field_val.
*   ICPMC
    CLEAR ls_field_val.
    ls_field_val-fieldname =
                 cl_ish_scr_procedures=>g_fieldname_icpmc.
    ls_field_val-type      = co_fvtype_single.
    ls_field_val-value     = ls_npcp-icpmc.
    READ TABLE it_procedures INTO lr_procedure INDEX sy-tabix.
    IF sy-subrc = 0.
      ls_field_val-object  = lr_procedure.
    ENDIF.
    INSERT ls_field_val INTO TABLE ct_field_val.
  ENDLOOP.

ENDMETHOD.


METHOD trans_corder_to_scr_procedures.

  DATA: ls_n1corder           TYPE n1corder,
        lt_procedures         TYPE ish_t_prereg_procedure,
        lt_npcp               TYPE ish_t_npcp,
        lt_field_val          TYPE ish_t_field_value.

  CHECK NOT ir_corder           IS INITIAL.
  CHECK NOT ir_scr_procedures   IS INITIAL.

* Get corder data.
  CALL METHOD ir_corder->get_procedures
    EXPORTING
      ir_environment  = gr_environment
    IMPORTING
      e_rc            = e_rc
      et_procedures   = lt_procedures
      et_npcp         = lt_npcp
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Build field values.
  CLEAR lt_field_val.
  CALL METHOD trans_corder_to_fv_procedures
    EXPORTING
      ir_corder       = ir_corder
      it_procedures   = lt_procedures
      it_npcp         = lt_npcp
    IMPORTING
      e_rc            = e_rc
    CHANGING
      ct_field_val    = lt_field_val
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Set main object in procedures screen.
  CALL METHOD ir_scr_procedures->set_data
    EXPORTING
      i_main_object   = ir_corder
      i_main_object_x = on
    IMPORTING
      e_rc            = e_rc
    CHANGING
      c_errorhandler  = cr_errorhandler.
  CHECK e_rc = 0.

* Set field values in procedures screen.
  CALL METHOD ir_scr_procedures->set_fields
    EXPORTING
      it_field_values  = lt_field_val
      i_field_values_x = on
    IMPORTING
      e_rc             = e_rc
    CHANGING
      c_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD trans_to_scr_procedures.

  DATA: lr_corder  TYPE REF TO cl_ish_corder.

  CHECK NOT gr_main_object      IS INITIAL.
  CHECK NOT ir_scr_procedures    IS INITIAL.

* Processing depends on gr_main_object's type.
  IF gr_main_object->is_inherited_from(
              cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD trans_corder_to_scr_procedures
      EXPORTING
        ir_corder         = lr_corder
        ir_scr_procedures = ir_scr_procedures
      IMPORTING
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.
ENDCLASS.
