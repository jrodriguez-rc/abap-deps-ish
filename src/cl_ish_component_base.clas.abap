class CL_ISH_COMPONENT_BASE definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_COMPONENT_BASE
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_COMPONENT_BASE .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_DOM .
  interfaces IF_ISH_FV_CONSTANTS .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_FVTYPE_FV
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_FV .
  aliases CO_FVTYPE_IDENTIFY
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_IDENTIFY .
  aliases CO_FVTYPE_SCREEN
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_SCREEN .
  aliases CO_FVTYPE_SINGLE
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_SINGLE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
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
  aliases ASYNC_TRANSPORT_FROM_SCREEN
    for IF_ISH_COMPONENT_BASE~ASYNC_TRANSPORT_FROM_SCREEN .
  aliases CANCEL
    for IF_ISH_COMPONENT_BASE~CANCEL .
  aliases CHECK
    for IF_ISH_COMPONENT_BASE~CHECK .
  aliases CHECK_CHANGES
    for IF_ISH_COMPONENT_BASE~CHECK_CHANGES .
  aliases COPY_DATA
    for IF_ISH_COMPONENT_BASE~COPY_DATA .
  aliases DESTROY
    for IF_ISH_COMPONENT_BASE~DESTROY .
  aliases DESTROY_SCREENS
    for IF_ISH_COMPONENT_BASE~DESTROY_SCREENS .
  aliases GET_CALLER
    for IF_ISH_COMPONENT_BASE~GET_CALLER .
  aliases GET_COMPDEF
    for IF_ISH_COMPONENT_BASE~GET_COMPDEF .
  aliases GET_COMPID
    for IF_ISH_COMPONENT_BASE~GET_COMPID .
  aliases GET_COMPNAME
    for IF_ISH_COMPONENT_BASE~GET_COMPNAME .
  aliases GET_COMPONENT_CONFIG
    for IF_ISH_COMPONENT_BASE~GET_COMPONENT_CONFIG .
  aliases GET_CONFIG
    for IF_ISH_COMPONENT_BASE~GET_CONFIG .
  aliases GET_DATA
    for IF_ISH_COMPONENT_BASE~GET_DATA .
  aliases GET_DEFINED_SCREENS
    for IF_ISH_COMPONENT_BASE~GET_DEFINED_SCREENS .
  aliases GET_DOM_DOCUMENT
    for IF_ISH_DOM~GET_DOM_DOCUMENT .
  aliases GET_DOM_FRAGMENT
    for IF_ISH_DOM~GET_DOM_FRAGMENT .
  aliases GET_DOM_NODE
    for IF_ISH_DOM~GET_DOM_NODE .
  aliases GET_ENVIRONMENT
    for IF_ISH_COMPONENT_BASE~GET_ENVIRONMENT .
  aliases GET_LOCK
    for IF_ISH_COMPONENT_BASE~GET_LOCK .
  aliases GET_MAIN_OBJECT
    for IF_ISH_COMPONENT_BASE~GET_MAIN_OBJECT .
  aliases GET_OBTYP
    for IF_ISH_COMPONENT_BASE~GET_OBTYP .
  aliases GET_REFRESHED
    for IF_ISH_COMPONENT_BASE~GET_REFRESHED .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases GET_T_RUN_DATA
    for IF_ISH_COMPONENT_BASE~GET_T_RUN_DATA .
  aliases GET_T_UID
    for IF_ISH_COMPONENT_BASE~GET_T_UID .
  aliases GET_VCODE
    for IF_ISH_COMPONENT_BASE~GET_VCODE .
  aliases INITIALIZE
    for IF_ISH_COMPONENT_BASE~INITIALIZE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_EMPTY
    for IF_ISH_COMPONENT_BASE~IS_EMPTY .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases IS_SCREEN_SUPPORTED
    for IF_ISH_COMPONENT_BASE~IS_SCREEN_SUPPORTED .
  aliases MODIFY_DOM_DATA
    for IF_ISH_DOM~MODIFY_DOM_DATA .
  aliases PREALLOC
    for IF_ISH_COMPONENT_BASE~PREALLOC .
  aliases PROCESS_EV_SYSTEM_EVENT
    for IF_ISH_COMPONENT_BASE~PROCESS_EV_SYSTEM_EVENT .
  aliases PROCESS_UCOMM
    for IF_ISH_COMPONENT_BASE~PROCESS_UCOMM .
  aliases REFRESH
    for IF_ISH_COMPONENT_BASE~REFRESH .
  aliases SAVE
    for IF_ISH_COMPONENT_BASE~SAVE .
  aliases SET_CALLER
    for IF_ISH_COMPONENT_BASE~SET_CALLER .
  aliases SET_COMPCON_XML_DOCUMENT
    for IF_ISH_COMPONENT_BASE~SET_COMPCON_XML_DOCUMENT .
  aliases SET_COMPCON_XML_ELEMENT
    for IF_ISH_COMPONENT_BASE~SET_COMPCON_XML_ELEMENT .
  aliases SET_CONFIG
    for IF_ISH_COMPONENT_BASE~SET_CONFIG .
  aliases SET_DATA
    for IF_ISH_COMPONENT_BASE~SET_DATA .
  aliases SET_ENVIRONMENT
    for IF_ISH_COMPONENT_BASE~SET_ENVIRONMENT .
  aliases SET_LOCK
    for IF_ISH_COMPONENT_BASE~SET_LOCK .
  aliases SET_MAIN_OBJECT
    for IF_ISH_COMPONENT_BASE~SET_MAIN_OBJECT .
  aliases SET_REFRESHED
    for IF_ISH_COMPONENT_BASE~SET_REFRESHED .
  aliases SET_T_UID
    for IF_ISH_COMPONENT_BASE~SET_T_UID .
  aliases SET_VCODE
    for IF_ISH_COMPONENT_BASE~SET_VCODE .
  aliases SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .
  aliases TRANSPORT_FROM_SCREEN
    for IF_ISH_COMPONENT_BASE~TRANSPORT_FROM_SCREEN .
  aliases TRANSPORT_TO_SCREEN
    for IF_ISH_COMPONENT_BASE~TRANSPORT_TO_SCREEN .
  aliases UNDO
    for IF_ISH_SNAPSHOT_OBJECT~UNDO .

  class-data G_PLACETYPE type NWPLACETYPE read-only value 'CMP'. "#EC NOTEXT .
  constants CO_OTYPE_COMPONENT_BASE type ISH_OBJECT_TYPE value 3020. "#EC NOTEXT

  class-methods CLASS_CONSTRUCTOR .
  class-methods CREATE_BASE
    importing
      value(I_OBJECT_TYPE) type I optional
      value(I_CLASS_NAME) type STRING optional
      value(I_FACTORY_NAME) type STRING optional
      value(I_USE_BADI) type ISH_ON_OFF default ON
      value(I_REFRESH_BADI_INSTANCE) type ISH_ON_OFF default OFF
      value(I_FORCE_BADI_ERRORS) type ISH_ON_OFF default OFF
      value(I_CREATE_OWN) type ISH_ON_OFF default ON
    exporting
      value(E_CREATED_BY_BADI) type ISH_ON_OFF
      value(ER_COMPONENT_BASE) type ref to IF_ISH_COMPONENT_BASE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_COMPONENT_BASE
*"* do not include other source files here!!!

  data GR_T_PRINT_FIELD type ref to ISH_T_PRINT_FIELD .
  class-data G_ISHMED_AUTH type ISH_ON_OFF .
  class-data GR_BADI type ref to IF_EX_N1_CREATE_COMPONENT .
  data GT_SCREEN_OBJECTS type ISH_T_SCREEN_OBJECTS .
  data GR_MAIN_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT .
  data GT_ADDITIONAL_OBJECTS type ISH_T_IDENTIFY_OBJECT .
  data GR_COMPCON type ref to IF_ISH_COMPONENT_CONFIG .
  data GR_COMPDEF type ref to CL_ISH_COMPDEF .
  data G_VCODE type TNDYM-VCODE .
  data G_CALLER type SY-REPID .
  data GR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  data GR_LOCK type ref to CL_ISHMED_LOCK .
  data GR_CONFIG type ref to IF_ISH_CONFIG .
  data GT_UID type ISH_T_SYSUUID_C .
  data G_INITIALIZE_SCREENS type ISH_ON_OFF value ON. "#EC NOTEXT .
  data G_PREALLOC_DONE type ISH_ON_OFF value OFF. "#EC NOTEXT .
  data G_USE_TNDYM_CURSOR type ISH_ON_OFF .

  methods COPY_DATA_INTERNAL
    importing
      !IR_COMPONENT_FROM type ref to IF_ISH_COMPONENT
      !I_COPY type N1COPYCOMP default 'X'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_COMPCON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY_COMPCON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ALL_SCREENS
    returning
      value(RT_SCREEN) type ISH_T_SCREEN_OBJECTS .
  methods GET_DOM_FOR_RUN_DATA
    importing
      value(IR_DOCUMENT) type ref to IF_IXML_DOCUMENT
      !IR_ELEMENT type ref to IF_IXML_ELEMENT optional
      !IR_RUN_DATA type ref to IF_ISH_OBJECTBASE
    exporting
      !ER_DOCUMENT_FRAGMENT type ref to IF_IXML_DOCUMENT_FRAGMENT .
  methods INITIALIZE_COMPCON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_SCREENS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_FROM_SCREEN_INTERNAL
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods TRANSPORT_TO_SCREEN_INTERNAL
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PREALLOC_INTERNAL
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_COMPONENT_BASE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMPONENT_BASE IMPLEMENTATION.


METHOD CLASS_CONSTRUCTOR .

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

ENDMETHOD.                    "CLASS_CONSTRUCTOR


METHOD COPY_DATA_INTERNAL .

* This method should be implemented in derived classes.

ENDMETHOD.


METHOD create_base .

  DATA: l_rc_factory  TYPE ish_method_rc,
        l_rc          TYPE ish_method_rc.

* Initializations.
  e_rc              = 0.
  e_created_by_badi = off.
  CLEAR er_component_base.

* Let the badi handle the creation.
  DO 1 TIMES.
*   Process the badi only if specified.
    CHECK i_use_badi = on.
*   Handle i_refresh_badi_instance.
    IF i_refresh_badi_instance = on.
      CLEAR gr_badi.
    ENDIF.
*   Load the badi instance if not already done.
    IF gr_badi IS INITIAL.
*     Check if the badi is active.
      CALL FUNCTION 'SXC_EXIT_CHECK_ACTIVE'
        EXPORTING
          exit_name  = 'N1_CREATE_COMPONENT'
        EXCEPTIONS
          not_active = 1
          OTHERS     = 2.
*     If the badi is not active do not process the badi.
      CHECK sy-subrc = 0.
*     Get instance of the BADI.
      CALL METHOD cl_exithandler=>get_instance
        EXPORTING
          exit_name                     = 'N1_CREATE_COMPONENT'
          null_instance_accepted        = on
        CHANGING
          instance                      = gr_badi
        EXCEPTIONS
          no_reference                  = 1
          no_interface_reference        = 2
          no_exit_interface             = 3
          class_not_implement_interface = 4
          single_exit_multiply_active   = 5
          cast_error                    = 6
          exit_not_existing             = 7
          data_incons_in_exit_managem   = 8
          OTHERS                        = 9.
      l_rc = sy-subrc.
      IF l_rc <> 0.
        CLEAR gr_badi.
*       Handle i_force_badi_errors.
        IF i_force_badi_errors = off.
          e_rc = l_rc.
*         BADI & kann nicht instanziert werden (Fehler &)
          CALL METHOD cl_ish_utl_base=>collect_messages
            EXPORTING
              i_typ           = 'E'
              i_kla           = 'N1BASE'
              i_num           = '029'
              i_mv1           = 'N1_CREATE_COMPONENT'
              i_mv2           = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
*   Process the badi.
    CHECK NOT gr_badi IS INITIAL.
    CALL METHOD gr_badi->create_component_base
      EXPORTING
        i_object_type     = i_object_type
        i_class_name      = i_class_name
      IMPORTING
        er_component_base = er_component_base
        e_rc              = l_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    IF l_rc <> 0.
      IF NOT er_component_base IS INITIAL.
        CALL METHOD er_component_base->destroy.
        CLEAR er_component_base.
      ENDIF.
      IF i_force_badi_errors = off.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
    CHECK NOT er_component_base IS INITIAL.
*   Check the created object.
*   It has to inherit from the given object type.
    IF NOT i_object_type IS INITIAL.
      IF er_component_base->is_inherited_from( i_object_type ) = off.
        CALL METHOD er_component_base->destroy.
        IF i_force_badi_errors = off.
          e_rc = 1.
*         BADI &1 lieferte falsches Objekt
          CALL METHOD cl_ish_utl_base=>collect_messages
            EXPORTING
              i_typ           = 'E'
              i_kla           = 'N1BASE'
              i_num           = '064'
              i_mv1           = 'N1_CREATE_COMPONENT'
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDDO.
  CHECK e_rc = 0.

* Further processing only if the badi did not create the object.
  IF NOT er_component_base IS INITIAL.
    e_created_by_badi = on.
    EXIT.
  ENDIF.

* Further processing only if specified.
  CHECK i_create_own = on.
  IF i_class_name   IS INITIAL AND
     i_factory_name IS INITIAL.
    EXIT.
  ENDIF.

* Do own component creation.
  CATCH SYSTEM-EXCEPTIONS dyn_call_meth_excp_not_found   = 1
                          dyn_call_meth_class_not_found  = 2
                          dyn_call_meth_classconstructor = 3
                          dyn_call_meth_constructor      = 4
                          dyn_call_meth_not_found        = 5
                          dyn_call_meth_no_class_method  = 6
                          dyn_call_meth_private          = 7
                          dyn_call_meth_protected        = 8
                          dyn_call_meth_param_kind       = 9
                          dyn_call_meth_param_litl_move  = 10
                          dyn_call_meth_param_tab_type   = 11
                          dyn_call_meth_param_type       = 12
                          dyn_call_meth_param_missing    = 13
                          dyn_call_meth_parref_initial   = 14
                          dyn_call_meth_param_not_found  = 15
                          dyn_call_meth_ref_is_initial   = 16
                          create_object_class_not_found  = 17.
    IF NOT i_factory_name IS INITIAL.
      CALL METHOD (i_factory_name)=>create
        IMPORTING
          er_interface    = er_component_base
          e_rc            = l_rc_factory
        CHANGING
          cr_errorhandler = cr_errorhandler.
    ELSEIF NOT i_class_name IS INITIAL.
        CREATE OBJECT er_component_base TYPE (i_class_name).
    ENDIF.
  ENDCATCH.
  l_rc = sy-subrc.
  IF l_rc = 0.
    l_rc = l_rc_factory.
  ENDIF.
  IF l_rc <> 0.
    IF NOT er_component_base IS INITIAL.
      CALL METHOD er_component_base->destroy.
      CLEAR er_component_base.
    ENDIF.
    e_rc = l_rc.
*   Objekt der Klasse &1 kann nicht instanziert werden (Fehler &2)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '065'
        i_mv1           = i_class_name
        i_mv2           = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.
  CHECK NOT er_component_base IS INITIAL.

ENDMETHOD.


METHOD create_compcon.

* This method can be redefined in derived classes
* to instantiate the component configuration.

  e_rc = 0.

ENDMETHOD.


METHOD destroy_compcon.

  e_rc = 0.

  CHECK NOT gr_compcon IS INITIAL.

  CALL METHOD gr_compcon->destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD get_all_screens.

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        lt_embscr  TYPE ish_t_screen_objects,
        l_rc       TYPE ish_method_rc.

* Get all embedded screens of all defined screens.
  LOOP AT gt_screen_objects INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CALL METHOD cl_ish_utl_screen=>get_screen_instances
      EXPORTING
        i_screen       = lr_screen
        i_embedded_scr = on
      IMPORTING
        et_screens     = lt_embscr
        e_rc           = l_rc.
    CHECK l_rc = 0.
    APPEND LINES OF lt_embscr TO rt_screen.
  ENDLOOP.

* Delete duplicates.
  SORT rt_screen.
  DELETE ADJACENT DUPLICATES FROM rt_screen.

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

  DATA: lt_fields          TYPE ish_t_field,
        l_string           TYPE string,
        l_index            TYPE i.

* Init.
  CLEAR er_document_fragment.

  CHECK NOT ir_document IS INITIAL.
  CHECK NOT ir_run_data IS INITIAL.

  CHECK gr_t_print_field IS BOUND.
  ASSIGN gr_t_print_field->* TO <lt_print_field>.
  CHECK sy-subrc = 0.

* Create document fragment
  lr_document_fragment = ir_document->create_document_fragment( ).

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
      REFRESH lt_fields.
      ls_field-tabname    = <ls_print_field>-tabname.
      ls_field-fieldname  = <ls_ddfield>-fieldname.
      ls_field-fieldlabel = <ls_ddfield>-scrtext_m.
      ls_field-fieldvalue = l_field_value.
      ls_field-fieldprint = l_field_value.
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


METHOD if_ish_component_base~async_transport_from_screen.

  DATA: lt_screen  TYPE ish_t_screen_objects,
        lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Get the defined screens.
  lt_screen = get_defined_screens( ).

* Asynchron pai for the defined screens.
  LOOP AT lt_screen INTO lr_screen.

    CHECK lr_screen IS BOUND.

    CALL METHOD lr_screen->async_pai
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.

  ENDLOOP.

* Transport from screens.
  CALL METHOD transport_from_screen
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~CANCEL.

* This method should be redefined in derived classes.

endmethod.


method IF_ISH_COMPONENT_BASE~CHECK.

  DATA: lt_screen      TYPE ish_t_screen_objects,
        lr_screen      TYPE REF TO if_ish_screen,
        l_rc           TYPE ish_method_rc.

* No checks in display mode.
  CHECK NOT g_vcode = co_vcode_display.

* The first thing to be done is to transport
* data to screens.
* This has to be done because maybe the screen was not
* displayed yet and his field values may be empty.
  CALL METHOD transport_to_screen
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Get the defined screens.
  lt_screen = get_defined_screens( ).
  lt_screen = get_all_screens( ).

* Check self's screens.
  LOOP AT lt_screen INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CALL METHOD lr_screen->check
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

endmethod.


METHOD if_ish_component_base~check_changes.

  DATA: lt_run_data  TYPE ish_t_objectbase,
        lr_run_data  TYPE REF TO if_ish_objectbase.

* Initializations.
  e_changed = off.
  e_rc      = 0.

* Check changes of all run_data objects.
  CALL METHOD get_t_run_data
    EXPORTING
      i_use_only_memory = on
    IMPORTING
      et_run_data       = lt_run_data
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.
  LOOP AT lt_run_data INTO lr_run_data.
    CHECK lr_run_data IS BOUND.
    CHECK lr_run_data <> gr_main_object.
    e_changed = lr_run_data->if_ish_data_object~is_changed( ).
    IF e_changed = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_component_base~copy_data.

  DATA: l_type  TYPE i.

* ir_component_from is mandatory.
  CHECK NOT ir_component_from IS INITIAL.

* Get self's type.
  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

* ir_component_from must be inherited from self.
  CHECK ir_component_from->is_inherited_from( l_type ) = on.

* Wrap to internal method.
  CALL METHOD copy_data_internal
    EXPORTING
      ir_component_from = ir_component_from
      i_copy            = i_copy              "Grill, med-20702
    IMPORTING
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.


ENDMETHOD.


METHOD if_ish_component_base~destroy.

  DATA: lt_run_data      TYPE ish_t_objectbase,
        lr_run_data      TYPE REF TO if_ish_objectbase,
        l_rc             TYPE ish_method_rc.

* Set refreshed flag.
*  g_refreshed = on.

* Destroy data objects.
  IF i_destroy_data_objects = on.
*   Get data objects.
    CALL METHOD get_t_run_data
      EXPORTING
        i_use_only_memory = on
      IMPORTING
        et_run_data       = lt_run_data
        e_rc              = l_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
*   Destroy each data object except gr_main_object.
    LOOP AT lt_run_data INTO lr_run_data.
      CHECK NOT lr_run_data IS INITIAL.
      CHECK NOT lr_run_data = gr_main_object.
      CALL METHOD lr_run_data->if_ish_data_object~destroy
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
      ENDIF.
    ENDLOOP.
  ENDIF.

* Destroy screens.
  IF i_destroy_screens = on.
    CALL METHOD destroy_screens
      EXPORTING
        i_destroy_embedded_scr = i_destroy_embedded_scr
      IMPORTING
        e_rc                   = l_rc
      CHANGING
        cr_errorhandler        = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

* Clear extern methods.
*  REFRESH gt_methods.

* Destroy component configuration.
  CALL METHOD destroy_compcon
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~DESTROY_SCREENS.

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Set g_initialize_screens.
  g_initialize_screens = on.

* Destroy each screen.
  LOOP AT gt_screen_objects INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CALL METHOD cl_ish_utl_screen=>destroy_screen
      EXPORTING
        ir_screen              = lr_screen
        i_destroy_embedded_scr = i_destroy_embedded_scr
      IMPORTING
        e_rc                   = l_rc
      CHANGING
        cr_errorhandler        = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

* Clear gt_screen_objects.
  REFRESH gt_screen_objects.


endmethod.


method IF_ISH_COMPONENT_BASE~GET_CALLER.

  r_caller = g_caller.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_COMPDEF.

  DATA: l_obtyp    TYPE j_obtyp,
        l_classid  TYPE n1compclassid.

* Initializations.
  rr_compdef = gr_compdef.

* Already loaded?
  CHECK gr_compdef IS INITIAL.

* Get the OBTYP of the compdef.
  l_obtyp = get_obtyp( ).

* Get selfs classname.
  l_classid = cl_ish_utl_rtti=>get_class_name( me ).

* Load the compdef object.
  CALL METHOD cl_ish_compdef=>get_compdef
    EXPORTING
      i_obtyp    = l_obtyp
      i_classid  = l_classid
    IMPORTING
      er_compdef = gr_compdef.

* Export compdef object.
  rr_compdef = gr_compdef.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_COMPID.

  DATA: lr_compdef  TYPE REF TO cl_ish_compdef.

* Initializations.
  CLEAR: r_compid.

* Get the corresponding compdef object.
  lr_compdef = get_compdef( ).

* Get the compname.
* If self has a compdef object -> use it.
* If not -> set classname.
  IF NOT lr_compdef IS INITIAL.
    r_compid = lr_compdef->get_compid( ).
  ELSE.
    r_compid = cl_ish_utl_rtti=>get_class_name( me ).
  ENDIF.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_COMPNAME.

  DATA: lr_compdef  TYPE REF TO cl_ish_compdef.

* Initializations.
  CLEAR: r_compname.

* Get the corresponding compdef object.
  lr_compdef = get_compdef( ).

* Get the compname.
* If self has a compdef object -> use it.
* If not -> set classname.
  IF NOT lr_compdef IS INITIAL.
    r_compname = lr_compdef->get_compname( ).
  ELSE.
    r_compname = cl_ish_utl_rtti=>get_class_name( me ).
  ENDIF.

endmethod.


METHOD if_ish_component_base~get_component_config.

  rr_compcon = gr_compcon.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~GET_CONFIG.

  rr_config = gr_config.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_DATA.

  er_main_object        = gr_main_object.
  et_additional_objects = gt_additional_objects.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_DEFINED_SCREENS.

  DATA: lr_screen  TYPE REF TO if_ish_screen.

* Handle g_initialize_screens.
  IF g_initialize_screens = on.
    REFRESH gt_screen_objects.
    CALL METHOD initialize_screens.
    g_initialize_screens = off.
    LOOP AT gt_screen_objects INTO lr_screen.
      CHECK NOT lr_screen IS INITIAL.
      CALL METHOD lr_screen->initialize
        EXPORTING
          i_main_object      = gr_main_object
          i_vcode            = g_vcode
          i_caller           = g_caller
          i_environment      = gr_environment
          i_lock             = gr_lock
          i_config           = gr_config
          i_use_tndym_cursor = g_use_tndym_cursor.
    ENDLOOP.
  ENDIF.

* Export
  IF rt_screen_objects IS SUPPLIED.
    rt_screen_objects = gt_screen_objects.
  ENDIF.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_ENVIRONMENT.

  rr_environment = gr_environment.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_LOCK.

  rr_lock = gr_lock.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_MAIN_OBJECT.

  rr_main_object = gr_main_object.

endmethod.


METHOD if_ish_component_base~get_obtyp.

* Initializations.
  CLEAR: r_obtyp.

* Get OBTYP from main object.
  CHECK NOT gr_main_object IS INITIAL.

  IF gr_main_object->is_inherited_from(
                       cl_ish_corder=>co_otype_corder ) = on OR
     gr_main_object->is_inherited_from(
                       cl_ishmed_prereg=>co_otype_prereg ) = on.
    r_obtyp = cl_ish_cordtyp=>co_obtyp.
  ENDIF.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~GET_REFRESHED.

*  r_refreshed = g_refreshed.

endmethod.


METHOD if_ish_component_base~get_t_run_data.

  DATA: lr_run_data  TYPE REF TO if_ish_objectbase.

* The default implementation returns only the main object.

  CHECK NOT gr_main_object IS INITIAL.
  CHECK gr_main_object->is_inherited_from(
              cl_ish_run_data=>co_otype_run_data ) = on.

  lr_run_data ?= gr_main_object.

  APPEND lr_run_data TO et_run_data.


ENDMETHOD.


method IF_ISH_COMPONENT_BASE~GET_T_UID.

  rt_uid = gt_uid.

endmethod.


method IF_ISH_COMPONENT_BASE~GET_VCODE.

  r_vcode = g_vcode.

endmethod.


METHOD if_ish_component_base~initialize.

  DATA: lr_screen  TYPE REF TO if_ish_screen.

* Set attributes
  gr_main_object        = ir_main_object.
  gt_additional_objects = it_additional_objects.
  g_vcode               = i_vcode.
  g_caller              = i_caller.
  gr_environment        = ir_environment.
  gr_lock               = ir_lock.
  gr_config             = ir_config.
  g_use_tndym_cursor    = i_use_tndym_cursor.
  gt_uid                = it_uid.
*  g_refreshed           = on.

* Component configuration.
  CALL METHOD create_compcon
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CALL METHOD initialize_compcon
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Methods
*  REFRESH gt_methods.
*  CALL METHOD initialize_methods
*    IMPORTING
*      e_rc            = e_rc
*    CHANGING
*      cr_errorhandler = cr_errorhandler.
*  CHECK e_rc = 0.

* Screens
  CALL METHOD destroy_screens
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
*  CALL METHOD get_defined_screens.

ENDMETHOD.


METHOD if_ish_component_base~is_empty.

* Michael Manoch, 13.07.2004, ID 14907
* New method.

* The default implementation just looks for additional data objects.
* If there are any -> r_empty=off.

* This method should be redefined by components which work on
* data of the main object (eg. cl_ish_comp_med_data).

  DATA: lt_run_data  TYPE ish_t_objectbase,
        lr_run_data  TYPE REF TO if_ish_objectbase,
        l_rc         TYPE ish_method_rc.

* Initializations
  r_empty = off.

* Get data objects of self.
  CALL METHOD get_t_run_data
    IMPORTING
      et_run_data = lt_run_data
      e_rc        = l_rc.
* On error self is not empty.
  CHECK l_rc = 0.
* Eliminate the main object.
  LOOP AT lt_run_data INTO lr_run_data.
    IF lr_run_data IS INITIAL OR
       lr_run_data = gr_main_object.
      DELETE lt_run_data.
    ENDIF.
  ENDLOOP.

* If self has any data objects -> self is not empty.
  CHECK lt_run_data IS INITIAL.

* Self has no uid's and no data objects -> self is empty.
  r_empty = on.

ENDMETHOD.


METHOD if_ish_component_base~is_screen_supported.

* Michael Manoch, 17.02.2005, ID 15128
* Redesign the whole method to consider also embedded screens.

  DATA: lt_screen      TYPE ish_t_screen_objects,
        lr_screen      TYPE REF TO if_ish_screen.

  r_is_supported = off.

  lt_screen = get_all_screens( ).

  READ TABLE lt_screen
    FROM ir_screen
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    r_is_supported = on.
    EXIT.
  ENDIF.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~PREALLOC.

* Handle i_force.
  IF i_force = on.
    g_prealloc_done = off.
  ENDIF.

* Process only if not already done.
  CHECK g_prealloc_done = off.

* Prealloc.
  CALL METHOD prealloc_internal
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

endmethod.


METHOD if_ish_component_base~process_ev_system_event.

* The default implementation does nothing.
* Redefine this method if needed.

  e_handled = off.

ENDMETHOD.


METHOD if_ish_component_base~process_ucomm.

* The default implementation does nothing.
* Redefine this method if needed.

  e_handled = off.
  e_rc      = 0.

ENDMETHOD.


METHOD if_ish_component_base~refresh.

  DATA: lt_run_data      TYPE ish_t_objectbase,
        lr_run_data      TYPE REF TO if_ish_objectbase,
        l_rc             TYPE ish_method_rc.

* Get data objects.
  CALL METHOD get_t_run_data
    IMPORTING
      et_run_data     = lt_run_data
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Refresh each data object except gr_main_object.
  LOOP AT lt_run_data INTO lr_run_data.
    CHECK NOT lr_run_data IS INITIAL.
    CHECK NOT lr_run_data = gr_main_object.
    CALL METHOD lr_run_data->if_ish_data_object~refresh
      IMPORTING
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~SAVE.

* This method should be redefined in derived classes.

endmethod.


METHOD if_ish_component_base~set_caller.

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        lt_screen  TYPE ish_t_screen_objects.

* Set own data.
  g_caller = i_caller.

* Adjust screens.
  IF i_adjust_screens = on.
    lt_screen = get_all_screens( ).
    LOOP AT lt_screen INTO lr_screen.
      CHECK NOT lr_screen IS INITIAL.
      CALL METHOD lr_screen->set_caller
        EXPORTING
          i_caller = i_caller.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD if_ish_component_base~set_compcon_xml_document.

  e_rc = 0.

  CHECK NOT gr_compcon IS INITIAL.

  CALL METHOD gr_compcon->set_data_by_xml_document
    EXPORTING
      ir_xml_document = ir_xml_document
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component_base~set_compcon_xml_element.

  e_rc = 0.

  CHECK NOT gr_compcon IS INITIAL.

  CALL METHOD gr_compcon->set_data_by_xml_element
    EXPORTING
      ir_xml_element  = ir_xml_element
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component_base~set_config.

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        lt_screen  TYPE ish_t_screen_objects.

* Set own data.
  gr_config = ir_config.

* Adjust screens.
  IF i_adjust_screens = on.
    lt_screen = get_all_screens( ).
    LOOP AT lt_screen INTO lr_screen.
      CHECK NOT lr_screen IS INITIAL.
      CALL METHOD lr_screen->set_config
        EXPORTING
          ir_config = ir_config.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~SET_DATA.

  gr_main_object        = ir_main_object.
  gt_additional_objects = it_additional_objects.

endmethod.


METHOD if_ish_component_base~set_environment.

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        lt_screen  TYPE ish_t_screen_objects.

* Set own data.
  gr_environment = ir_environment.

* Adjust screens.
  IF i_adjust_screens = on.
    lt_screen = get_all_screens( ).
    LOOP AT lt_screen INTO lr_screen.
      CHECK NOT lr_screen IS INITIAL.
      CALL METHOD lr_screen->set_environment
        EXPORTING
          ir_environment = ir_environment.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD if_ish_component_base~set_lock.

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        lt_screen  TYPE ish_t_screen_objects.

* Set own data.
  gr_lock = ir_lock.

* Adjust screens.
  IF i_adjust_screens = on.
    lt_screen = get_all_screens( ).
    LOOP AT lt_screen INTO lr_screen.
      CHECK NOT lr_screen IS INITIAL.
      CALL METHOD lr_screen->set_lock
        EXPORTING
          ir_lock = ir_lock.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD if_ish_component_base~set_main_object.

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        lt_screen  TYPE ish_t_screen_objects.

* Set own data.
  gr_main_object = ir_main_object.

* Adjust screens.
  IF i_adjust_screens = on.
    lt_screen = get_all_screens( ).
    LOOP AT lt_screen INTO lr_screen.
      CHECK NOT lr_screen IS INITIAL.
      CALL METHOD lr_screen->set_main_object
        EXPORTING
          ir_main_object = ir_main_object.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~SET_REFRESHED.

*  g_refreshed = i_refreshed.

endmethod.


method IF_ISH_COMPONENT_BASE~SET_T_UID.

  gt_uid = it_uid.

endmethod.


METHOD if_ish_component_base~set_vcode.

  DATA: lr_screen  TYPE REF TO if_ish_screen,
        lt_screen  TYPE ish_t_screen_objects,
        l_rc       TYPE ish_method_rc.

* Set vcode in self.
  g_vcode = i_vcode.

* Set vcode in all screens.
  lt_screen = get_all_screens( ).
  LOOP AT lt_screen INTO lr_screen.
    CHECK NOT lr_screen IS INITIAL.
    CALL METHOD lr_screen->set_data
      EXPORTING
        i_vcode        = g_vcode
        i_vcode_x      = on
      IMPORTING
        e_rc           = l_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.
  CHECK e_rc = 0.

ENDMETHOD.


method IF_ISH_COMPONENT_BASE~TRANSPORT_FROM_SCREEN.

  DATA: lt_screen  TYPE ish_t_screen_objects,
        lr_screen  TYPE REF TO if_ish_screen,
        l_rc       TYPE ish_method_rc.

* Build lt_screen depending on ir_screen.
  IF ir_screen IS INITIAL.
    lt_screen = get_defined_screens( ).
  ELSE.
    CHECK is_screen_supported( ir_screen ) = on.
    APPEND ir_screen TO lt_screen.
  ENDIF.

* Handle transport for each screen.
  LOOP AT lt_screen INTO lr_screen.
    CALL METHOD transport_from_screen_internal
      EXPORTING
        ir_screen       = lr_screen
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

endmethod.


method IF_ISH_COMPONENT_BASE~TRANSPORT_TO_SCREEN.

  DATA: lt_screen  TYPE ish_t_screen_objects,
        lr_screen  TYPE REF TO if_ish_screen,
        lr_scr_obj TYPE REF TO cl_ish_screen,
        l_rc       TYPE ish_method_rc.

* Build lt_screen depending on ir_screen.
  IF ir_screen IS INITIAL.
    lt_screen = get_defined_screens( ).
  ELSE.
    CHECK is_screen_supported( ir_screen ) = on.
    APPEND ir_screen TO lt_screen.
  ENDIF.

* Handle transport for each screen.
  LOOP AT lt_screen INTO lr_screen.
*   field values
    CALL METHOD transport_to_screen_internal
      EXPORTING
        ir_screen       = lr_screen
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
*   field labels
*    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
*      lr_scr_obj ?= lr_screen.
*    ENDCATCH.
*    IF sy-subrc <> 0.
*      CLEAR lr_scr_obj.
*    ENDIF.
*    IF NOT lr_scr_obj IS INITIAL.
*      CALL METHOD lr_scr_obj->fill_all_labels
*        IMPORTING
*          e_rc            = l_rc
*        CHANGING
*          cr_errorhandler = cr_errorhandler.
*      IF l_rc <> 0.
*        e_rc = l_rc.
*      ENDIF.
*    ENDIF.
  ENDLOOP.

endmethod.


METHOD IF_ISH_DOM~GET_DOM_DOCUMENT .

* No implementation.

ENDMETHOD.


METHOD IF_ISH_DOM~GET_DOM_FRAGMENT .

  DATA: lr_document_fragment TYPE REF TO if_ixml_document_fragment,
        lr_element           TYPE REF TO if_ixml_element,
        lr_text              TYPE REF TO if_ixml_text,
        lr_fragment          TYPE REF TO if_ixml_document_fragment.
  DATA: l_compname           TYPE ncompname,
        l_compid             type n1compid,          "ID: 16882
        l_string             TYPE string,
        l_string1            TYPE string,
        l_string2            TYPE string,
        lt_screen            TYPE ish_t_screen_objects,
        lr_screen_object     LIKE LINE OF gt_screen_objects,
        l_rc                 TYPE i.
  DATA: lt_run_data   TYPE ish_t_objectbase,
        lr_run_data   TYPE REF TO if_ish_objectbase.

  e_rc = 0.

* Check/create errorhandler
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* No DOM document received => exit
  IF ir_document IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Create new DOM fragment
  lr_document_fragment = ir_document->create_document_fragment( ).

* Create new component element
  lr_element = ir_document->create_element( name = 'COMP' ).
  CALL METHOD me->get_compname
    IMPORTING
      r_compname = l_compname.
  l_string = l_compname.
  l_rc = lr_element->set_attribute( name = 'NAME' value = l_string ).

* Käfer, ID: 16882 - Begin
  CALL METHOD me->get_compid
    receiving
      r_compid = l_compid.
  l_string = l_compid.
  l_rc = lr_element->set_attribute( name = 'VALUE' value = l_string ).
* Käfer, ID: 16882 - End

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

  SORT lt_run_data ."MED-49986,AM,We need to sort the object so that we save them in the right order.

  LOOP AT lt_run_data INTO lr_run_data.
    CHECK NOT lr_run_data IS INITIAL.
*   Get data object's cdoc.
    CALL METHOD get_dom_for_run_data
      EXPORTING
        ir_document          = ir_document
        ir_element           = lr_element            "ID: 16882
        ir_run_data          = lr_run_data
      IMPORTING
        er_document_fragment = lr_fragment.
    CHECK NOT lr_fragment IS INITIAL.
*   Append screen DOM fragment to component element
    l_rc = lr_element->append_child( new_child = lr_fragment ).
  ENDLOOP.

* Append component element to component DOM fragment
  l_rc = lr_document_fragment->append_child( new_child = lr_element ).

* Export component DOM fragment
  er_document_fragment = lr_document_fragment.

ENDMETHOD.


METHOD IF_ISH_DOM~GET_DOM_NODE .

* No implementation.

ENDMETHOD.


METHOD IF_ISH_DOM~MODIFY_DOM_DATA .

* this method has to be implemented in the different component classes

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~GET_TYPE .

  e_object_type = co_otype_component_base.

ENDMETHOD.


METHOD IF_ISH_IDENTIFY_OBJECT~IS_A .

  DATA: l_object_type TYPE i.

  r_is_a = off.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF i_object_type = l_object_type.
    r_is_a = on.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_component_base.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_snapshot_object~destroy_snapshot.
* new since ID 19361 Implement if you needed
ENDMETHOD.


METHOD IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .

* This method should be redefined in derived classes.

ENDMETHOD.


METHOD IF_ISH_SNAPSHOT_OBJECT~UNDO .

* This method should be redefined in derived classes.

ENDMETHOD.


METHOD initialize_compcon.

  e_rc = 0.

  CHECK NOT gr_compcon IS INITIAL.

  CALL METHOD gr_compcon->initialize
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD INITIALIZE_SCREENS .

* Default implementation: no screens.

ENDMETHOD.


METHOD PREALLOC_INTERNAL .

* Redefine in derived classes if needed.

ENDMETHOD.


METHOD TRANSPORT_FROM_SCREEN_INTERNAL .

* This method should be redefined in derived classes.

ENDMETHOD.


METHOD TRANSPORT_TO_SCREEN_INTERNAL .

* This method should be redefined in derived classes.

ENDMETHOD.
ENDCLASS.
