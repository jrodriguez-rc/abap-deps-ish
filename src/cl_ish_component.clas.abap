class CL_ISH_COMPONENT definition
  public
  inheriting from CL_ISH_COMPONENT_BASE
  abstract
  create public .

public section.

*"* public components of class CL_ISH_COMPONENT
*"* do not include other source files here!!!
  interfaces IF_ISH_CHANGEDOCUMENT .
  interfaces IF_ISH_COMPONENT .
  interfaces IF_ISH_OBJECT_TYPES .

  aliases CO_EVENT_AFTER_COMMIT
    for IF_ISH_COMPONENT~CO_EVENT_AFTER_COMMIT .
  aliases CO_EVENT_BEFORE_COMMIT
    for IF_ISH_COMPONENT~CO_EVENT_BEFORE_COMMIT .
  aliases CO_EVENT_BEFORE_SAVE
    for IF_ISH_COMPONENT~CO_EVENT_BEFORE_SAVE .
  aliases CO_EVENT_STATUS_CHANGED
    for IF_ISH_COMPONENT~CO_EVENT_STATUS_CHANGED .
  aliases CONFIGURE
    for IF_ISH_COMPONENT~CONFIGURE .
  aliases CREATE
    for IF_ISH_COMPONENT~CREATE .
  aliases DEFINE_ADK_DATA
    for IF_ISH_COMPONENT~DEFINE_ADK_DATA .
  aliases GET_CHANGEDOCUMENT
    for IF_ISH_CHANGEDOCUMENT~GET_CHANGEDOCUMENT .
  aliases GET_EXTERN_METHODS
    for IF_ISH_COMPONENT~GET_EXTERN_METHODS .
  aliases GET_HIDE
    for IF_ISH_COMPONENT~GET_HIDE .
  aliases HAS_CONFIGURATION
    for IF_ISH_COMPONENT~HAS_CONFIGURATION .
  aliases IS_BEWTY_SUPPORTED
    for IF_ISH_COMPONENT~IS_BEWTY_SUPPORTED .
  aliases IS_OP
    for IF_ISH_COMPONENT~IS_OP .
  aliases PROCESS_METHOD
    for IF_ISH_COMPONENT~PROCESS_METHOD .
  aliases READ_ADK_DATA
    for IF_ISH_COMPONENT~READ_ADK_DATA .
  aliases SET_HIDE
    for IF_ISH_COMPONENT~SET_HIDE .

  constants CO_OTYPE_COMPONENT type ISH_OBJECT_TYPE value 3009. "#EC NOTEXT

  methods IF_ISH_COMPONENT_BASE~GET_OBTYP
    redefinition .
  methods IF_ISH_COMPONENT_BASE~GET_REFRESHED
    redefinition .
  methods IF_ISH_COMPONENT_BASE~INITIALIZE
    redefinition .
  methods IF_ISH_COMPONENT_BASE~REFRESH
    redefinition .
  methods IF_ISH_COMPONENT_BASE~SET_REFRESHED
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMPONENT
*"* do not include other source files here!!!

  data G_REFRESHED type ISH_ON_OFF value on. "#EC NOTEXT .
  data GT_METHODS type ISH_T_COMP_METHOD .
  data GR_T_CDOC_FIELD type ref to ISH_T_CDOC_FIELD .
  data G_HIDE type ISH_ON_OFF value OFF. "#EC NOTEXT .

  methods GET_CDOC_FOR_RUN_DATA
    importing
      !IR_RUN_DATA type ref to IF_ISH_OBJECTBASE
    returning
      value(ET_CDOC) type ISH_T_CDOC .
  methods INITIALIZE_METHODS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PREALLOC_FROM_EXTERNAL_INT
    importing
      !IR_XML_DOCUMENT type ref to IF_IXML_DOCUMENT
      value(IT_MAPPING) type ISHMED_MIGTYP
      value(I_INDEX) type I
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods INITIALIZE_COMPCON
    redefinition .
private section.
*"* private components of class CL_ISH_COMPONENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMPONENT IMPLEMENTATION.


METHOD GET_CDOC_FOR_RUN_DATA .

  DATA: l_objecttype  TYPE i,
        lt_cdoc       TYPE ish_t_cdoc.

  FIELD-SYMBOLS: <lt_cdoc_field> TYPE ish_t_cdoc_field,
                 <ls_cdoc_field> TYPE rn1_cdoc_field.

  CLEAR et_cdoc[].

  CHECK NOT ir_run_data IS INITIAL.

  CHECK gr_t_cdoc_field IS BOUND.
  ASSIGN gr_t_cdoc_field->* TO <lt_cdoc_field>.
  CHECK sy-subrc = 0.

  LOOP AT <lt_cdoc_field> ASSIGNING <ls_cdoc_field>.
*   Check data object's type.
    l_objecttype = <ls_cdoc_field>-objecttype.
    CHECK ir_run_data->is_inherited_from( l_objecttype ) = on.
*   Get data object's fields with cdoc flag.
    CLEAR lt_cdoc[].
    CALL METHOD cl_ish_utl_xml=>get_cdoc
      EXPORTING
        ir_run_data   = ir_run_data
        is_cdoc_field = <ls_cdoc_field>
      IMPORTING
        et_cdoc       = lt_cdoc.
    CHECK NOT lt_cdoc IS INITIAL.
    APPEND LINES OF lt_cdoc TO et_cdoc.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_changedocument~get_changedocument .

  DATA: lt_run_data   TYPE ish_t_objectbase,
        lr_run_data   TYPE REF TO if_ish_objectbase,
        lt_cdoc       TYPE ish_t_cdoc.

  CLEAR: et_cdoc[],
         e_rc.

* Get component's data objects (including main object).
  CALL METHOD me->get_t_run_data
    IMPORTING
      et_run_data     = lt_run_data
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lt_run_data IS INITIAL.

* For each data object.
  LOOP AT lt_run_data INTO lr_run_data.
    CHECK NOT lr_run_data IS INITIAL.
*   Get data object's cdoc.
    CALL METHOD get_cdoc_for_run_data
      EXPORTING
        ir_run_data = lr_run_data
      RECEIVING
        et_cdoc     = lt_cdoc.
    CHECK NOT lt_cdoc IS INITIAL.
    APPEND LINES OF lt_cdoc TO et_cdoc.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component_base~get_obtyp.
* Michael Manoch, 02.05.2005, COMPCON   method redefined.

  r_obtyp = cl_ish_cordtyp=>co_obtyp.

ENDMETHOD.


METHOD if_ish_component_base~get_refreshed.

* first call super-method
  CALL METHOD super->if_ish_component_base~get_refreshed
    RECEIVING
      r_refreshed = r_refreshed.

  CHECK r_refreshed IS INITIAL.
  r_refreshed = g_refreshed.

ENDMETHOD.


METHOD if_ish_component_base~initialize.

* First call super method.
  CALL METHOD super->if_ish_component_base~initialize
    EXPORTING
      ir_main_object        = ir_main_object
      it_additional_objects = it_additional_objects
      i_vcode               = i_vcode
      i_caller              = i_caller
      ir_environment        = ir_environment
      ir_lock               = ir_lock
      ir_config             = ir_config
      i_use_tndym_cursor    = i_use_tndym_cursor
      it_uid                = it_uid
    IMPORTING
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Handle g_refreshed.
  g_refreshed = on.

* Methods
  REFRESH gt_methods.
  CALL METHOD initialize_methods
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD if_ish_component_base~refresh.

* first call super-mehtod
  CALL METHOD super->if_ish_component_base~refresh
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

  g_refreshed = on.

ENDMETHOD.


METHOD if_ish_component_base~set_refreshed.

  g_refreshed = i_refreshed.

ENDMETHOD.


METHOD if_ish_component~configure .
* Michael Manoch, 02.05.2005, COMPCON   method implemented

  CLEAR e_rc.

  CHECK gr_compcon IS BOUND.

  CALL METHOD gr_compcon->show_popup
    EXPORTING
      i_vcode         = g_vcode
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component~create .

  DATA: lr_instance      TYPE REF TO if_ish_component,
* ED, ID 15282: new local fields -> BEGIN
        lr_corder_med    TYPE REF TO cl_ishmed_corder,
        l_is_aggregation TYPE ish_on_off,
* ED, ID 15282 -> END
        l_is_base_item   TYPE ish_on_off. "ED, ID 16882
* Michael Manoch, 30.11.2006, MED-29464   START
  DATA: lr_component_base  TYPE REF TO if_ish_component_base.
  DATA: l_classid          TYPE n1compclassid.
  DATA: lr_component       TYPE REF TO cl_ish_component.
* Michael Manoch, 30.11.2006, MED-29464   END

* Special handling for ish/ishmed
  IF g_ishmed_auth = on.
    CASE i_classname.
*     Nicolae Codleanu, 08.06.2011, MED-40659   START
      WHEN 'CL_ISH_COMP_COMMENT'.
        i_classname = 'CL_ISHMED_COMP_COMMENT'.
      WHEN 'CL_ISH_COMP_MED_DATA'.
        i_classname = 'CL_ISHMED_COMP_MED_DATA'.
*     Nicolae Codleanu, 09.06.2011, MED-40659   END
      WHEN 'CL_ISH_COMP_ORDER'.
        i_classname = 'CL_ISHMED_COMP_ORDER'.
      WHEN 'CL_ISH_COMP_CPOS_SHORT'.
        i_classname = 'CL_ISHMED_COMP_CPOS_SHORT'.
* ED, ID 15282: special handling for aggregation corder -> BEGIN
      WHEN 'CL_ISH_COMP_PATIENT'.
*       check if main object is corder (med)
        IF NOT ir_main_object IS INITIAL AND
           ir_main_object->is_inherited_from(
      cl_ishmed_corder=>co_otype_corder_med ) = 'X'.
          lr_corder_med ?= ir_main_object.
          l_is_aggregation = lr_corder_med->is_aggregation_object( ).
          l_is_base_item   =
                  lr_corder_med->is_base_item_object( ). "ED, ID 16882
*         check if clinical order is aggregation corder
          IF l_is_aggregation = on.
*           set classname for patient component aggregation
            i_classname = 'CL_ISHMED_COMP_PATIENT_AGGREG'.
          ENDIF.
*         ED, ID 16882: check if clinical order is base item -> BEGIN
          IF l_is_base_item = on.
            i_classname = 'CL_ISHMED_COMP_PATIENT_BASE'.
          ENDIF.
*         ED, ID 16882 -> END
        ENDIF.
* ED, ID 15282 -> END
    ENDCASE.
  ENDIF.

* Michael Manoch, 30.11.2006, MED-29464   START
* Instantiation of the component by using badi.

  CASE i_classname.

* Some components can not be created by badi.
    WHEN 'CL_ISH_COMP_ORDER' OR
         'CL_ISH_COMP_PATIENT'.

*     Instantiate the component
      TRY.
          CREATE OBJECT lr_instance TYPE (i_classname).
        CATCH cx_root.                                  "#EC NO_HANDLER
      ENDTRY.
      IF lr_instance IS NOT BOUND.
        RAISE ex_invalid_classname.
      ENDIF.

*   All other components can be created by badi.
    WHEN OTHERS.

*     Instantiate the component
      CALL METHOD create_base
        EXPORTING
          i_object_type     = co_otype_component
          i_class_name      = i_classname
        IMPORTING
          er_component_base = lr_component_base
          e_rc              = e_rc
        CHANGING
          cr_errorhandler   = cr_errorhandler.
      CHECK e_rc = 0.
      TRY.
          lr_instance ?= lr_component_base.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.
      IF lr_instance IS NOT BOUND.
        RAISE ex_invalid_classname.
      ENDIF.

*     Now set the components compdef.
      TRY.
          lr_component ?= lr_instance.
          l_classid = i_classname.
          CALL METHOD cl_ish_compdef=>get_compdef
            EXPORTING
              i_obtyp    = cl_ish_cordtyp=>co_obtyp
              i_classid  = l_classid
            IMPORTING
              er_compdef = lr_component->gr_compdef.
        CATCH cx_sy_move_cast_error.                   "#EC NO_HANDLER.
      ENDTRY.

  ENDCASE.

* Michael Manoch, 30.11.2006, MED-29464   END

* Initialize the component
  CALL METHOD lr_instance->initialize
    EXPORTING
      ir_main_object        = ir_main_object
      it_additional_objects = it_additional_objects
      i_vcode               = i_vcode
      i_caller              = i_caller
      ir_environment        = ir_environment
      ir_lock               = ir_lock
      ir_config             = ir_config
      it_uid                = it_uid
    IMPORTING
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Export
  er_instance = lr_instance.

ENDMETHOD.


METHOD if_ish_component~define_adk_data.

* This method should be redefined in derived classes for components that need to participate in the archiving.

ENDMETHOD.


METHOD if_ish_component~get_extern_methods .

** Dummy implementation   START
*  DATA: ls_method TYPE rn1_comp_method.
*  IF gt_methods IS INITIAL.
*    ls_method-tech_name   = 'Testmethod1'.
*    ls_method-description = 'Testdescription1'.
*    APPEND ls_method TO gt_methods.
*    ls_method-tech_name   = 'Testmethod2'.
*    ls_method-description = 'Testdescription2'.
*    APPEND ls_method TO gt_methods.
*    ls_method-tech_name   = 'Testmethod3'.
*    ls_method-description = 'Testdescription3'.
*    APPEND ls_method TO gt_methods.
*  ENDIF.
** Dummy implementation   END

* aber noch keine externen Methoden in PMD_BEISPIEL implementiert,
* also Rückgabe von "INITIAL"

  rt_methods = gt_methods.

ENDMETHOD.


METHOD if_ish_component~get_hide.

  r_hide = g_hide.

ENDMETHOD.


METHOD if_ish_component~has_configuration.

* Default: No configuration.
  r_has_config = off.

* Michael Manoch, 02.05.2005, COMPCON   START
  CHECK gr_compcon IS BOUND.
  CHECK gr_compcon->get_screen( ) IS BOUND.
  r_has_config = on.
* Michael Manoch, 02.05.2005, COMPCON   END

ENDMETHOD.


METHOD if_ish_component~is_bewty_supported .

* Default implementation.
  r_supported = on.

ENDMETHOD.


METHOD if_ish_component~is_op .

* Default implementation.
  r_is_op = off.

ENDMETHOD.


METHOD if_ish_component~prealloc_from_external.

* ED, ID 16882 -> BEGIN

  e_rc = 0.

* first call prealloc_from_external_int
  CALL METHOD me->prealloc_from_external_int
    EXPORTING
      ir_xml_document = ir_xml_document
      it_mapping      = it_mapping
      i_index         = i_index
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* now call prealloc_internal
  CALL METHOD me->prealloc_internal
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* ED, ID 16882 -> END
ENDMETHOD.


METHOD if_ish_component~process_method .

* This method should be redefined in derived classes.

ENDMETHOD.


METHOD if_ish_component~read_adk_data.

* This method should be redefined in derived classes for components that need to participate in the archiving.

ENDMETHOD.


  METHOD if_ish_component~set_data_from_external.
*    Implementation is done in specific component classesghg

  ENDMETHOD.


METHOD if_ish_component~set_hide.

  g_hide = i_hide.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_component.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_component.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize_compcon.
* Michael Manoch, 02.05.2005, COMPCON   method redefined

  DATA: lr_cordpos        TYPE REF TO cl_ishmed_prereg,
        lt_cordpos        TYPE ish_t_cordpos,
        lr_corder         TYPE REF TO cl_ish_corder,
        lr_cordtyp        TYPE REF TO cl_ish_cordtyp,
        lt_cordtyp        TYPE ish_t_cordtyp,
        lr_cordtypa       TYPE REF TO cl_ish_cordtypa,
        lt_cordtypa       TYPE ish_t_cordtypa,
        lr_own_compdef    TYPE REF TO cl_ish_compdef,
        lr_compdef        TYPE REF TO cl_ish_compdef,
        l_ordassid        TYPE n1cordtypa-ordassid,
        ls_n1compcon      TYPE n1compcon,
        lr_xml_document   TYPE REF TO if_ixml_document.

  FIELD-SYMBOLS: <lr_cordtyp>  TYPE REF TO cl_ish_cordtyp.

* First call the super method.
  CALL METHOD super->initialize_compcon
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Further processing only if we have a compcon.
  CHECK gr_compcon IS BOUND.

* Get own compdef.
  lr_own_compdef = get_compdef( ).
  CHECK lr_own_compdef IS BOUND.

* Get the cordtyps.
  CHECK gr_main_object IS BOUND.
  IF gr_main_object->is_inherited_from(
           cl_ish_cordtypa=>co_otype_cordtypa ) = on.
    lr_cordtypa ?= gr_main_object.
    lr_cordtyp = lr_cordtypa->get_cordtyp( ).
    APPEND lr_cordtyp TO lt_cordtyp.
  ELSEIF gr_main_object->is_inherited_from(
           cl_ishmed_prereg=>co_otype_prereg ) = on.
    lr_cordpos ?= gr_main_object.
    lr_cordtyp = lr_cordpos->get_cordtyp( ).
    APPEND lr_cordtyp TO lt_cordtyp.
  ELSEIF gr_main_object->is_inherited_from(
           cl_ish_corder=>co_otype_corder ) = on.
    lr_corder ?= gr_main_object.
    CALL METHOD lr_corder->get_t_cordpos
      IMPORTING
        et_cordpos      = lt_cordpos
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK NOT lt_cordpos IS INITIAL.
    LOOP AT lt_cordpos INTO lr_cordpos.
      CHECK lr_cordpos IS BOUND.
      lr_cordtyp = lr_cordpos->get_cordtyp( ).
      APPEND lr_cordtyp TO lt_cordtyp.
    ENDLOOP.
  ENDIF.

* Get the ordassid.
  LOOP AT lt_cordtyp INTO lr_cordtyp.
    CHECK lr_cordtyp IS BOUND.
    lt_cordtypa = lr_cordtyp->get_t_cordtypa( ).
    LOOP AT lt_cordtypa INTO lr_cordtypa.
      CHECK lr_cordtypa IS BOUND.
      lr_compdef = lr_cordtypa->get_compdef( ).
      CHECK lr_compdef = lr_own_compdef.
      l_ordassid = lr_cordtypa->get_ordassid( ).
      EXIT.
    ENDLOOP.
    IF NOT l_ordassid IS INITIAL.
      EXIT.
    ENDIF.
  ENDLOOP.
  CHECK NOT l_ordassid IS INITIAL.

* Get compcon data.
  SELECT SINGLE *
    FROM n1compcon
    INTO ls_n1compcon
    WHERE compconid = l_ordassid.
  CHECK sy-subrc = 0.
  CHECK NOT ls_n1compcon-xml_data IS INITIAL.

* Create the xml_document.
  CLEAR lr_xml_document.
  CALL FUNCTION 'SDIXML_XML_TO_DOM'
    EXPORTING
      xml           = ls_n1compcon-xml_data
    IMPORTING
      document      = lr_xml_document
    EXCEPTIONS
      invalid_input = 1
      OTHERS        = 2.
  CHECK sy-subrc = 0.
  CHECK lr_xml_document IS BOUND.

* Set the compcon's xml_document.
  CALL METHOD gr_compcon->set_data_by_xml_document
    EXPORTING
      ir_xml_document = lr_xml_document.

ENDMETHOD.


METHOD initialize_methods .

* Default implementation: no extern methods.

ENDMETHOD.


METHOD prealloc_from_external_int.

* to be redefined in implemented component class

ENDMETHOD.
ENDCLASS.
