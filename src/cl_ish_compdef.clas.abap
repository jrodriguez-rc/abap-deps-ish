class CL_ISH_COMPDEF definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_COMPDEF
*"* do not include other source files here!!!

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_CORDT_ELEM .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases GET_ASS_TYPE
    for IF_ISH_CORDT_ELEM~GET_ASS_TYPE .
  aliases GET_ELEM_NAME
    for IF_ISH_CORDT_ELEM~GET_ELEM_NAME .
  aliases GET_ELEM_TYPE
    for IF_ISH_CORDT_ELEM~GET_ELEM_TYPE .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_COMPDEF type ISH_OBJECT_TYPE value 12019. "#EC NOTEXT

  class-methods CLASS_CONSTRUCTOR .
  class-methods GET_COMPDEF
    importing
      value(I_OBTYP) type J_OBTYP
      value(I_COMPID) type N1COMP-COMPID optional
      value(I_CLASSID) type N1COMPCLASSID optional
      value(I_COMPNAME) type NCOMPNAME optional
    exporting
      value(ER_COMPDEF) type ref to CL_ISH_COMPDEF .
  class-methods GET_T_COMPDEF
    importing
      value(I_OBTYP) type J_OBTYP
      value(I_REFRESH) type ISH_ON_OFF default ''
    exporting
      value(ET_COMPDEF) type ISH_T_COMPDEF .
  class-methods LOAD
    importing
      value(IS_N1COMP) type N1COMP
      value(IS_N1COMPT) type N1COMPT
      value(I_READ_FROM_DB) type ISH_ON_OFF default 'X'
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_COMPDEF .
  class CL_ISH_CORDTYP definition load .
  class-methods SGET_LOADED_COMPONENTS
    importing
      !I_OBTYP type J_OBTYP default CL_ISH_CORDTYP=>CO_OBTYP
      !IR_OBJECT type ref to IF_ISH_DATA_OBJECT optional
    returning
      value(RT_COMPONENT) type ISH_T_COMPONENT .
  methods CONSTRUCTOR
    importing
      value(IS_N1COMP) type N1COMP
      value(IS_N1COMPT) type N1COMPT .
  methods GET_CLASSID
    returning
      value(R_CLASSID) type N1COMP-CLASSID .
  methods GET_COMPID
    returning
      value(R_COMPID) type N1COMP-COMPID .
  methods GET_COMPNAME
    returning
      value(R_COMPNAME) type N1COMPT-COMPNAME .
  methods GET_COMPONENT
    importing
      !IR_OBJECT type ref to IF_ISH_DATA_OBJECT optional
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_VCODE) type TNDYM-VCODE optional
      value(I_CALLER) type SY-REPID default SY-REPID
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !IR_LOCK type ref to CL_ISHMED_LOCK optional
      !IR_CONFIG type ref to IF_ISH_CONFIG optional
    exporting
      value(ER_COMPONENT) type ref to IF_ISH_COMPONENT
      value(E_CREATED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_COMPONENT_BASE
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_VCODE) type TNDYM-VCODE optional
      value(I_CALLER) type SY-REPID default SY-REPID
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      !IR_LOCK type ref to CL_ISHMED_LOCK optional
      !IR_CONFIG type ref to IF_ISH_CONFIG optional
    exporting
      value(ER_COMPONENT) type ref to IF_ISH_COMPONENT_BASE
      value(E_CREATED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DATA
    exporting
      value(ES_N1COMP) type N1COMP
      value(ES_N1COMPT) type N1COMPT .
  methods IS_HEADER
    returning
      value(R_IS_HEADER) type ISH_ON_OFF .
  methods IS_STD
    returning
      value(R_IS_STD) type ISH_ON_OFF .
  methods REMOVE_COMPONENT
    importing
      !IR_OBJECT type ref to IF_ISH_DATA_OBJECT
      !IR_COMPONENT type ref to IF_ISH_COMPONENT optional .
protected section.

*"* protected components of class CL_ISH_COMPDEF
*"* do not include other source files here!!!
  data GR_COMPONENT type ref to IF_ISH_COMPONENT .
  data GR_COMPONENT_BASE type ref to IF_ISH_COMPONENT_BASE .
  data GS_N1COMP type N1COMP .
  data GS_N1COMPT type N1COMPT .
  class-data GT_COMPDEFA type ISH_T_COMPDEFA .
  data GT_COMP_ASS type ISH_T_COMP_ASS .
  data GT_COMP_BASE_ASS type ISH_T_COMP_BASE_ASS .
  class-data G_ISHMED_AUTH type ISH_ON_OFF .

  methods DESTROY_COMPONENTS
    importing
      value(I_DESTROY_COMPONENTS) type ISH_ON_OFF default 'X'
      value(I_DESTROY_MODULES) type ISH_ON_OFF default 'X'
      value(I_DESTROY_COMP_ASSIGN) type ISH_ON_OFF default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_EV_DESTROYED
    for event EV_DESTROYED of IF_ISH_DATA_OBJECT
    importing
      !SENDER .
  methods HANDLE_EV_REFRESHED
    for event EV_REFRESHED of IF_ISH_DATA_OBJECT
    importing
      !SENDER .
  methods READ_FROM_DB
    importing
      value(I_COMPID) type N1COMP-COMPID .
  class-methods CHECK_NAMESPACE
    importing
      !I_CLS type STRING
    returning
      value(R_RESULT) type ISH_TRUE_FALSE .
private section.
*"* private components of class CL_ISH_COMPDEF
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMPDEF IMPLEMENTATION.


  METHOD check_namespace.
    DATA: l_name_space      TYPE trnspace-namespace,
          l_clsid_1         TYPE string,
          l_clsid_2         TYPE string,
          es_namespace_info TYPE trnsp_namespace.

    SPLIT i_cls
      AT   '/'
      INTO l_name_space
           l_clsid_1
           l_clsid_2.

    CONCATENATE '/'
                l_clsid_1
                '/'
                INTO l_name_space.

    CALL FUNCTION 'TRINT_READ_NAMESPACE'
      EXPORTING
        iv_namespace           = l_name_space
*       IV_CHECK_LICENSE       = ' '
      IMPORTING
        es_namespace_info      = es_namespace_info
      EXCEPTIONS
        namespace_not_existing = 1
        OTHERS                 = 2.

    IF sy-subrc EQ 0 AND es_namespace_info-sapflag = 'X'.
      r_result = true.
    ELSE.
      r_result = false.
    ENDIF.

  ENDMETHOD.


METHOD class_constructor .

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


METHOD constructor .

  gs_n1comp  = is_n1comp.
  gs_n1compt = is_n1compt.

ENDMETHOD.


METHOD destroy_components.
*new method for MED-62089

  DATA lr_component_base TYPE REF TO cl_ish_component_base.
  DATA ls_comp_assignment TYPE rn1_comp_ass.
  DATA ls_comp_base_assignment TYPE rn1_comp_base_ass.

  IF i_destroy_components = on.
    TRY.
        lr_component_base ?= gr_component.
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    IF lr_component_base IS BOUND.
      CALL METHOD lr_component_base->if_ish_component_base~destroy
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CLEAR lr_component_base.
    ENDIF.
    CLEAR gr_component.
    TRY.
        lr_component_base ?= gr_component_base.
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    IF lr_component_base IS BOUND.
      CALL METHOD lr_component_base->if_ish_component_base~destroy
        IMPORTING
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ENDIF.
    CLEAR gr_component_base.
  ENDIF.

  IF i_destroy_modules = on.
    CLEAR gs_n1comp.
    CLEAR gs_n1compt.
  ENDIF.

  IF i_destroy_comp_assign = on.
    LOOP AT gt_comp_ass INTO ls_comp_assignment.
      CLEAR lr_component_base.
      TRY.
          lr_component_base ?= ls_comp_assignment-r_component.
        CATCH cx_sy_move_cast_error.
          CONTINUE.
      ENDTRY.
      IF lr_component_base IS BOUND.
        CALL METHOD lr_component_base->if_ish_component_base~destroy
          IMPORTING
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
    ENDLOOP.
    CLEAR gt_comp_ass[].
    LOOP AT gt_comp_base_ass INTO ls_comp_base_assignment.
      CLEAR lr_component_base.
      TRY.
          lr_component_base ?= ls_comp_base_assignment-r_component.
        CATCH cx_sy_move_cast_error.
          CONTINUE.
      ENDTRY.
      IF lr_component_base IS BOUND.
        CALL METHOD lr_component_base->if_ish_component_base~destroy
          IMPORTING
            e_rc            = e_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
    ENDLOOP.
    CLEAR gt_comp_base_ass[].
  ENDIF.
ENDMETHOD.


METHOD get_classid .

  r_classid = gs_n1comp-classid.

ENDMETHOD.


METHOD get_compdef .

  DATA: lt_compdef TYPE ish_t_compdef.

* Initializations
  CLEAR: er_compdef.

* Check importing parameters.
  IF i_compid   IS INITIAL AND
     i_classid  IS INITIAL AND
     i_compname IS INITIAL.
    EXIT.
  ENDIF.

* Get compdefs for i_obtyp
  CALL METHOD get_t_compdef
    EXPORTING
      i_obtyp    = i_obtyp
    IMPORTING
      et_compdef = lt_compdef.

* Get the specified compdef.
  LOOP AT lt_compdef INTO er_compdef.
    IF NOT i_compid IS INITIAL.
      IF er_compdef->get_compid( ) = i_compid.
        EXIT.
      ENDIF.
    ELSEIF NOT i_classid IS INITIAL.
      IF er_compdef->get_classid( ) = i_classid.
        EXIT.
      ENDIF.
    ELSEIF NOT i_compname IS INITIAL.
      IF er_compdef->get_compname( ) = i_compname.
        EXIT.
      ENDIF.
    ENDIF.
    CLEAR er_compdef.
  ENDLOOP.

ENDMETHOD.


METHOD get_compid .

  r_compid = gs_n1comp-compid.

ENDMETHOD.


METHOD get_compname .

  r_compname = gs_n1compt-compname.

ENDMETHOD.


METHOD get_component .

  DATA: l_classname  TYPE string,
        lr_component  TYPE REF TO if_ish_component,
        ls_comp_ass   TYPE rn1_comp_ass.

  FIELD-SYMBOLS: <ls_comp_ass>  TYPE rn1_comp_ass.

* Initializations.
  CLEAR er_component.
  e_created = off.

* Get the already loaded component.
  IF ir_object IS INITIAL.
*   Refresh?
    IF i_refresh = on.
      CLEAR gr_component.
    ENDIF.
*   Set lr_component.
    lr_component = gr_component.
  ELSE.
    LOOP AT gt_comp_ass ASSIGNING <ls_comp_ass>.
      IF <ls_comp_ass>-r_object = ir_object.
*       Refresh?
        IF i_refresh = on.
          DELETE TABLE gt_comp_ass FROM <ls_comp_ass>.
        ELSE.
*         Set lr_component.
          lr_component = <ls_comp_ass>-r_component.
        ENDIF.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Component already loaded?
  er_component = lr_component.
  CHECK lr_component IS INITIAL.

* Get the component.
  l_classname = gs_n1comp-classid.
  CALL METHOD cl_ish_component=>create
    EXPORTING
      i_classname          = l_classname
      ir_main_object       = ir_object
      i_vcode              = i_vcode
      i_caller             = i_caller
      ir_environment       = ir_environment
      ir_lock              = ir_lock
      ir_config            = ir_config
    IMPORTING
      er_instance          = lr_component
      e_rc                 = e_rc             "MED-49526 Oana B
    CHANGING
      cr_errorhandler      = cr_errorhandler  "MED-49526 Oana B
    EXCEPTIONS
      ex_invalid_classname = 1
      OTHERS               = 2.

  CHECK e_rc = 0.   "MED-49526 Oana B
  IF sy-subrc <> 0.
* ED, ID 20562 -> BEGIN
*   set exporting parameter E_RC and add message to errorhandler -> BEGIN
    e_rc = sy-subrc.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '003'
        i_mv1           = 'CL_ISH_COMPONENT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
* ED, ID 20562 -> END
    CLEAR lr_component.
  ENDIF.
  CHECK NOT lr_component IS INITIAL.

* Remember the component.
  IF ir_object IS INITIAL.
    gr_component = lr_component.
  ELSE.
    CLEAR ls_comp_ass.
    ls_comp_ass-r_object    = ir_object.
    ls_comp_ass-r_component = lr_component.
    APPEND ls_comp_ass TO gt_comp_ass.
*   Handle destroy on ir_object.
    SET HANDLER handle_ev_destroyed FOR ir_object.
*   Handle refresh on ir_object.
    SET HANDLER handle_ev_refreshed FOR ir_object.
  ENDIF.

* Export.
  er_component = lr_component.
  e_created    = on.

ENDMETHOD.


METHOD get_component_base .

  DATA: lr_component             TYPE REF TO if_ish_component_base,
        ls_comp_ass              TYPE rn1_comp_base_ass,
        l_object_type            TYPE i,
        l_class_name             TYPE string,
        l_factory_name           TYPE string,
        l_use_badi               TYPE ish_on_off,
        l_refresh_badi_instance  TYPE ish_on_off,
        l_force_badi_errors      TYPE ish_on_off,
        l_create_own             TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_comp_ass>  TYPE rn1_comp_base_ass.

* Initializations.
  CLEAR er_component.
  e_created = off.

* Get the already loaded component.
  IF ir_object IS INITIAL.
*   Refresh?
    IF i_refresh = on.
      CLEAR gr_component_base.
    ENDIF.
*   Set lr_component.
    lr_component = gr_component_base.
  ELSE.
    LOOP AT gt_comp_base_ass ASSIGNING <ls_comp_ass>.
      IF <ls_comp_ass>-r_object = ir_object.
*       Refresh?
        IF i_refresh = on.
          DELETE TABLE gt_comp_base_ass FROM <ls_comp_ass>.
        ELSE.
*         Set lr_component.
          lr_component = <ls_comp_ass>-r_component.
        ENDIF.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Component already loaded?
  er_component = lr_component.
  CHECK lr_component IS INITIAL.

* Create the component.
  l_object_type           = 0.                  "missing in gs_n1comp
  l_class_name            = gs_n1comp-classid.
  l_factory_name          = space.              "missing in gs_n1comp
  l_use_badi              = on.                 "missing in gs_n1comp
  l_refresh_badi_instance = off.                "missing in gs_n1comp
  l_force_badi_errors     = off.                "missing in gs_n1comp
  l_create_own            = on.                 "missing in gs_n1comp
  CALL METHOD cl_ish_component_base=>create_base
    EXPORTING
      i_object_type           = l_object_type
      i_class_name            = l_class_name
      i_factory_name          = l_factory_name
      i_use_badi              = l_use_badi
      i_refresh_badi_instance = l_refresh_badi_instance
      i_force_badi_errors     = l_force_badi_errors
      i_create_own            = l_create_own
    IMPORTING
      er_component_base       = lr_component
      e_rc                    = e_rc
    CHANGING
      cr_errorhandler         = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_component IS INITIAL.

* Initialize the component.
  CALL METHOD lr_component->initialize
    EXPORTING
      ir_main_object        = ir_object
      i_vcode               = i_vcode
      i_caller              = i_caller
      ir_environment        = ir_environment
      ir_lock               = ir_lock
      ir_config             = ir_config
    IMPORTING
      e_rc                  = e_rc
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  CHECK e_rc = 0.

* Remember the component.
  IF ir_object IS INITIAL.
    gr_component_base = lr_component.
  ELSE.
    CLEAR ls_comp_ass.
    ls_comp_ass-r_object    = ir_object.
    ls_comp_ass-r_component = lr_component.
    APPEND ls_comp_ass TO gt_comp_base_ass.
  ENDIF.

* Export.
  er_component = lr_component.
  e_created    = on.

ENDMETHOD.


METHOD get_data .

  es_n1comp  = gs_n1comp.
  es_n1compt = gs_n1compt.

ENDMETHOD.


METHOD get_t_compdef .

  TYPES: BEGIN OF ty_join,
           ls_n1comp     TYPE n1comp,
           ls_n1compt    TYPE n1compt,
           ls_n1compdefa TYPE n1compdefa,
         END OF ty_join.
  DATA: lt_join            TYPE TABLE OF ty_join,
        lr_compdef         TYPE REF TO cl_ish_compdef,
        ls_compdefa        TYPE rn1_compdefa,
        l_clsid_1          TYPE string,
        l_clsid_2          TYPE string,
        l_clsid_rest       TYPE string,
        l_class_name       TYPE abap_abstypename,
        l_class_1          TYPE string,
        l_class_2          TYPE string,
        lr_descr_ref       TYPE REF TO cl_abap_typedescr,
        lr_class_descr     TYPE REF TO cl_abap_classdescr,
        l_super_class_name TYPE abap_abstypename,
        l_one_use          TYPE ish_on_off,
        l_sap              TYPE ish_on_off.

  DATA l_rc TYPE ish_method_rc.          "MED-62089 AGujev
  DATA l_index LIKE syst-tabix.          "MED-62089 AGujev

  FIELD-SYMBOLS: <ls_join>     TYPE ty_join,
                 <ls_compdefa> TYPE rn1_compdefa.

* Determine if the specified compdefs were already read.
  READ TABLE gt_compdefa ASSIGNING <ls_compdefa>
      WITH KEY obtyp = i_obtyp.
  IF sy-subrc = 0.
    IF i_refresh = on.
*     On refresh delete the entry and read again.
*-->begin of MED-62089 AGujev
*it is not enough to just delete the line from the table
*we need to destroy also the component objects, otherwise memory will fill quickly if we don't leave the transaction
      l_index = sy-tabix.     "first save the index so that is not overwritten below
      LOOP AT <ls_compdefa>-compdefs INTO lr_compdef.
        IF lr_compdef IS BOUND.
          CALL METHOD lr_compdef->destroy_components
                   IMPORTING e_rc = l_rc.  "no error handling for the moment
          CLEAR lr_compdef.
        ENDIF.
      ENDLOOP.
      DELETE gt_compdefa INDEX l_index.   "use the saved index from the read instruction
*<--end of MED-62089 AGujev
*      DELETE gt_compdefa INDEX sy-tabix.     "--MED-62089 AGujev
    ELSE.
      IF et_compdef IS SUPPLIED.
        et_compdef = <ls_compdefa>-compdefs.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

* Create a new entry in gt_compdefa.
  ls_compdefa-obtyp = i_obtyp.

* Read all compdefs with i_obtyp into lt_join.
* lt_join will contain 1-n entries for each compdef
* (one for each language)
  SELECT *
      INTO TABLE lt_join
      FROM ( n1comp AS a
             LEFT OUTER JOIN n1compt AS b
             ON a~compid = b~compid )
        INNER JOIN n1compdefa AS c
        ON a~compid = c~compid
      WHERE c~obtyp = i_obtyp
      ORDER BY a~header   DESCENDING
               b~compname ASCENDING.

* Create a compdef object for each relevant compdef
* (depending on sy-langu).
  LOOP AT lt_join ASSIGNING <ls_join>.
    IF <ls_join>-ls_n1compt-spras <> sy-langu.
*     This compdef entry is not for the current language.
*     Is there a compdef for the current language?
      READ TABLE lt_join
        WITH KEY ls_n1comp-compid = <ls_join>-ls_n1comp-compid
                 ls_n1compt-spras = sy-langu
        TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
*       There is a compdef for the current language.
*       So ignore this entry.
        CONTINUE.
      ELSE.
*       There is no compdef for the current language.
*       So create a compdef object with empty text data.
        CLEAR <ls_join>-ls_n1compt.
        <ls_join>-ls_n1compt-spras = sy-langu.
      ENDIF.
    ENDIF.
*   If ISHMED is not active, only CL_ISH_* components are allowed.
    IF g_ishmed_auth = off.
*     Quick and dirty solution for service component.
      CHECK NOT <ls_join>-ls_n1comp-classid = 'CL_ISH_COMP_SERVICES'.
      SPLIT <ls_join>-ls_n1comp-classid
        AT   '_'
        INTO l_clsid_1
             l_clsid_2
             l_clsid_rest.
*      CHECK l_clsid_1 = 'CL'.  "Grill, ID-19994
      IF l_clsid_1 = 'CL'.      "Grill, ID-19994
        CHECK l_clsid_2 = 'ISH'.
*-- begin Grill, MED-39034
*       MED-52872
      ELSEIF check_Namespace( l_clsid_1 ) = true.
* SAP enthancment for pre req.
        l_sap = on.
*       MED-52872
      ELSE.
        l_class_1 = '\CLASS='.
        l_class_2 = <ls_join>-ls_n1comp-classid.
        CONCATENATE l_class_1 l_class_2 INTO l_class_name.
* Michael Manoch, 21.04.2011, MED-44386   START
*        CALL METHOD cl_abap_typedescr=>describe_by_name
*          EXPORTING
*            p_name      = l_class_name
*          RECEIVING
*            p_descr_ref = lr_descr_ref.
*        lr_class_descr ?= lr_descr_ref.
        CALL METHOD cl_abap_typedescr=>describe_by_name
          EXPORTING
            p_name      = l_class_name
          RECEIVING
            p_descr_ref = lr_descr_ref
          EXCEPTIONS
            OTHERS      = 1.
        CHECK sy-subrc = 0.
        TRY.
            lr_class_descr ?= lr_descr_ref.
          CATCH cx_sy_move_cast_error.
            CONTINUE.
        ENDTRY.
* Michael Manoch, 21.04.2011, MED-44386   END
*-- check the superclass
        l_super_class_name = lr_class_descr->get_super_class_type( )->absolute_name.
        IF <ls_join>-ls_n1comp-classid <> '/MED/CL_HOC_COMP_OCC_DATA'.        "CDuerr, MED-41425
          CHECK l_super_class_name EQ '\CLASS=CL_ISH_COMP_CORDER_USER'.
          CHECK l_one_use EQ off.
          l_one_use = on.
        ENDIF.                                                                "CDuerr, MED-41425
*-- end Grill, MED-39034
      ENDIF.                    "Grill, ID-19994
    ENDIF.
*   Instantiate a new compdef object.
    CALL METHOD cl_ish_compdef=>load
      EXPORTING
        is_n1comp      = <ls_join>-ls_n1comp
        is_n1compt     = <ls_join>-ls_n1compt
        i_read_from_db = off
      IMPORTING
        er_instance    = lr_compdef.

*   Append the compdef object to ls_compdefa.
    IF NOT lr_compdef IS INITIAL.
      APPEND lr_compdef TO ls_compdefa-compdefs.
    ENDIF.
  ENDLOOP.

* Save the new entry.
  APPEND ls_compdefa TO gt_compdefa.

  CHECK et_compdef IS SUPPLIED.

  et_compdef = ls_compdefa-compdefs.

ENDMETHOD.


METHOD handle_ev_destroyed .

  FIELD-SYMBOLS: <ls_comp_ass>  TYPE rn1_comp_ass.

* On destroy of a data object:
*   - Destroy the corresponding component.
*   - Remove the corresponding gt_comp_ass entry.

  LOOP AT gt_comp_ass ASSIGNING <ls_comp_ass>.
    CHECK <ls_comp_ass>-r_object = sender.
*   Destroy the corresponding component.
    CALL METHOD <ls_comp_ass>-r_component->destroy.
*   Remove the corresponding gt_comp_ass entry.
    DELETE gt_comp_ass.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD handle_ev_refreshed .

  FIELD-SYMBOLS: <ls_comp_ass>  TYPE rn1_comp_ass.

* On refresh of a data object:
*   - Refresh the corresponding component.

  LOOP AT gt_comp_ass ASSIGNING <ls_comp_ass>.
    CHECK <ls_comp_ass>-r_object = sender.
*   Refresh the corresponding component.
    CALL METHOD <ls_comp_ass>-r_component->refresh.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_cordt_elem~get_ass_type .

  IF is_std( ) = on.
    r_type = cl_ish_cordtypa=>co_composap.
  ELSE.
    r_type = cl_ish_cordtypa=>co_compocst.
  ENDIF.

ENDMETHOD.


METHOD if_ish_cordt_elem~get_elem_name .

  r_name = gs_n1compt-compname.

ENDMETHOD.


METHOD if_ish_cordt_elem~get_elem_type .

  IF gs_n1comp-header = on.
    r_type = 'Kopfbaustein'(001).
  ELSE.
    r_type = 'Baustein'(002).
  ENDIF.

  IF is_std( ) = on.
    CONCATENATE r_type
                'SAP'(003)
           INTO r_type
      SEPARATED BY space.
  ELSE.
    CONCATENATE r_type
                'Kd.'(004)
           INTO r_type
      SEPARATED BY space.
  ENDIF.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = cl_ish_desel=>co_otype_desel.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_A .

  DATA: l_object_type TYPE i.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF i_object_type = l_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  IF i_object_type = cl_ish_desel=>co_otype_desel.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD is_header .

  r_is_header = gs_n1comp-header.

ENDMETHOD.


METHOD is_std .

  DATA: l_pre1 TYPE string,
        l_pre2 TYPE string,
        l_rest TYPE string.

  r_is_std = off.

  SPLIT gs_n1comp-classid
      AT '_'
    INTO l_pre1
         l_pre2
         l_rest.

  CHECK l_pre1 = 'CL'.
  CHECK l_pre2 = 'ISH' OR l_pre2 = 'ISHMED'.

  r_is_std = on.

ENDMETHOD.


METHOD load .

  DATA: lr_instance TYPE REF TO cl_ish_compdef,
        l_rc        TYPE ish_method_rc.

* Initializations
* Create self
  CREATE OBJECT lr_instance
    EXPORTING
      is_n1comp  = is_n1comp
      is_n1compt = is_n1compt.

* Read self from db
  IF i_read_from_db = on.
    CALL METHOD lr_instance->read_from_db
      EXPORTING
        i_compid = is_n1comp-compid.
  ENDIF.

* Export e_instance
  er_instance = lr_instance.

ENDMETHOD.


METHOD read_from_db .

  DATA: ls_n1comp  TYPE n1comp,
        ls_n1compt TYPE n1compt.

* Read n1comp
  SELECT SINGLE *
    FROM n1comp
    INTO ls_n1comp
    WHERE compid = i_compid.
  IF sy-subrc <> 0.
    ls_n1comp = gs_n1comp.
  ENDIF.

* n1compt
  SELECT SINGLE *
    FROM n1compt
    INTO ls_n1compt
    WHERE compid = i_compid
      AND spras     = sy-langu.
  IF sy-subrc <> 0.
    ls_n1compt = gs_n1compt.
  ENDIF.

* Initialize self with the read data.
  gs_n1comp       = ls_n1comp.
  gs_n1compt      = ls_n1compt.

ENDMETHOD.


METHOD remove_component.

  FIELD-SYMBOLS: <ls_comp_ass>  TYPE rn1_comp_ass.

  LOOP AT gt_comp_ass ASSIGNING <ls_comp_ass>.
    CHECK <ls_comp_ass>-r_object = ir_object.
    IF ir_component IS BOUND.
      CHECK <ls_comp_ass>-r_component = ir_component.
      DELETE gt_comp_ass.
    ELSE.
      DELETE gt_comp_ass.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD sget_loaded_components.

* Michael Manoch, 19.07.2010   method created

  DATA lr_compdef                         TYPE REF TO cl_ish_compdef.

  FIELD-SYMBOLS <ls_compdefa>             TYPE rn1_compdefa.
  FIELD-SYMBOLS <ls_comp_ass>             TYPE rn1_comp_ass.

  LOOP AT gt_compdefa ASSIGNING <ls_compdefa>.
    CHECK <ls_compdefa>-obtyp = i_obtyp.
  ENDLOOP.

  READ TABLE gt_compdefa ASSIGNING <ls_compdefa> WITH KEY obtyp = i_obtyp.
  CHECK sy-subrc = 0.

  LOOP AT <ls_compdefa>-compdefs INTO lr_compdef.
    IF ir_object IS BOUND.
      LOOP AT lr_compdef->gt_comp_ass ASSIGNING <ls_comp_ass>.
        CHECK <ls_comp_ass>-r_object = ir_object.
        CHECK <ls_comp_ass>-r_component IS BOUND.
        INSERT <ls_comp_ass>-r_component INTO TABLE rt_component.
      ENDLOOP.
    ELSE.
      CHECK lr_compdef->gr_component IS BOUND.
      INSERT lr_compdef->gr_component INTO TABLE rt_component.
    ENDIF.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
