class CL_ISH_COMPONENT_CONFIG definition
  public
  create protected .

*"* public components of class CL_ISH_COMPONENT_CONFIG
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_COMPONENT_CONFIG .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_POPUP_CALLBACK .

  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases AS_XML_DOCUMENT
    for IF_ISH_COMPONENT_CONFIG~AS_XML_DOCUMENT .
  aliases AS_XML_ELEMENT
    for IF_ISH_COMPONENT_CONFIG~AS_XML_ELEMENT .
  aliases CHECK
    for IF_ISH_COMPONENT_CONFIG~CHECK .
  aliases CHECK_CHANGES
    for IF_ISH_COMPONENT_CONFIG~CHECK_CHANGES .
  aliases DESTROY
    for IF_ISH_COMPONENT_CONFIG~DESTROY .
  aliases GET_COMPONENT
    for IF_ISH_COMPONENT_CONFIG~GET_COMPONENT .
  aliases GET_SCREEN
    for IF_ISH_COMPONENT_CONFIG~GET_SCREEN .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases INITIALIZE
    for IF_ISH_COMPONENT_CONFIG~INITIALIZE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .
  aliases RESET_DATA
    for IF_ISH_COMPONENT_CONFIG~RESET_DATA .
  aliases SET_DATA_BY_XML_DOCUMENT
    for IF_ISH_COMPONENT_CONFIG~SET_DATA_BY_XML_DOCUMENT .
  aliases SET_DATA_BY_XML_ELEMENT
    for IF_ISH_COMPONENT_CONFIG~SET_DATA_BY_XML_ELEMENT .
  aliases SHOW_POPUP
    for IF_ISH_COMPONENT_CONFIG~SHOW_POPUP .

  constants CO_OTYPE_COMPONENT_CONFIG type ISH_OBJECT_TYPE value 3023. "#EC NOTEXT

  class-methods CREATE
    importing
      !IR_COMPONENT type ref to IF_ISH_COMPONENT_BASE
      value(I_OBJECT_TYPE) type I optional
      value(I_CLASS_NAME) type STRING optional
      value(I_USE_BADI) type ISH_ON_OFF default ON
      value(I_REFRESH_BADI_INSTANCE) type ISH_ON_OFF default OFF
      value(I_FORCE_BADI_ERRORS) type ISH_ON_OFF default OFF
      value(I_CREATE_OWN) type ISH_ON_OFF default ON
    exporting
      !ER_COMPCON type ref to IF_ISH_COMPONENT_CONFIG
      value(E_CREATED_BY_BADI) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      value(IR_COMPONENT) type ref to IF_ISH_COMPONENT_BASE .
protected section.
*"* protected components of class CL_ISH_COMPONENT_CONFIG
*"* do not include other source files here!!!

  class-data GR_BADI type ref to IF_EX_N1_CREATE_COMPCON .
  data GR_COMPONENT type ref to IF_ISH_COMPONENT_BASE .
  data GR_SCREEN type ref to IF_ISH_SCREEN .
  data GR_XML_DOCUMENT_ORIG type ref to IF_IXML_DOCUMENT .

  methods CHECK_INITIALIZATION
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CREATE_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_SCREEN
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_COMPONENT_CONFIG
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMPONENT_CONFIG IMPLEMENTATION.


METHOD check_initialization.

  DATA: l_class_name  TYPE string.

* Initialization.
  e_rc = 0.

* gr_component is mandatory.
  IF gr_component IS INITIAL.
    e_rc = 1.
    l_class_name = cl_ish_utl_rtti=>get_class_name( me ).
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '014'
        i_mv1           = l_class_name
        i_mv2           = 'CHECK_INITIALIZATION'
        i_mv3           = 'GR_COMPONENT'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD constructor.

  gr_component = ir_component.

ENDMETHOD.


METHOD create.

  DATA: l_rc  TYPE ish_method_rc.

* Initializations.
  e_rc              = 0.
  e_created_by_badi = off.
  CLEAR er_compcon.

  CHECK NOT ir_component IS INITIAL.

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
          exit_name  = 'N1_CREATE_COMPCON'
        EXCEPTIONS
          not_active = 1
          OTHERS     = 2.
*     If the badi is not active do not process the badi.
      CHECK sy-subrc = 0.
*     Get instance of the BADI.
      CALL METHOD cl_exithandler=>get_instance
        EXPORTING
          exit_name                     = 'N1_CREATE_COMPCON'
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
              i_mv1           = 'N1_CREATE_COMPCON'
              i_mv2           = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
*   Process the badi.
    CHECK NOT gr_badi IS INITIAL.
    CALL METHOD gr_badi->create_compcon
      EXPORTING
        ir_component    = ir_component
        i_object_type   = i_object_type
      IMPORTING
        er_compcon      = er_compcon
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      IF NOT er_compcon IS INITIAL.
        CALL METHOD er_compcon->destroy.
        CLEAR er_compcon.
      ENDIF.
      IF i_force_badi_errors = off.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
    CHECK NOT er_compcon IS INITIAL.
*   Check the created object.
*   It has to inherit from the given object type.
    IF NOT i_object_type IS INITIAL.
      IF er_compcon->is_inherited_from( i_object_type ) = off.
        CALL METHOD er_compcon->destroy.
        IF i_force_badi_errors = off.
          e_rc = 1.
*         BADI &1 lieferte falsches Objekt
          CALL METHOD cl_ish_utl_base=>collect_messages
            EXPORTING
              i_typ           = 'E'
              i_kla           = 'N1BASE'
              i_num           = '064'
              i_mv1           = 'N1_CREATE_COMPCON'
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDDO.
  CHECK e_rc = 0.

* Further processing only if the badi did not create the object.
  IF NOT er_compcon IS INITIAL.
    e_created_by_badi = on.
    EXIT.
  ENDIF.

* Further processing only if specified.
  CHECK i_create_own = on.
  CHECK NOT i_class_name IS INITIAL.

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
                          dyn_call_meth_ref_is_initial   = 16.
    CREATE OBJECT er_compcon TYPE (i_class_name)
      EXPORTING
        ir_component = ir_component.
  ENDCATCH.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    IF NOT er_compcon IS INITIAL.
      CALL METHOD er_compcon->destroy.
      CLEAR er_compcon.
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

ENDMETHOD.


METHOD create_screen.

* No default implementation.

ENDMETHOD.


METHOD if_ish_component_config~as_xml_document.

* The default implementation returns the config_screen
* as xml_document.

* Initializations.
  e_rc = 0.
  CLEAR er_xml_document.

  CHECK NOT gr_screen IS INITIAL.

* Get the config_screen as xml_document.
  CALL METHOD cl_ish_utl_screen=>get_screen_as_xml_document
    EXPORTING
      ir_screen          = gr_screen
      ir_ixml            = ir_ixml
      i_embedded_screens = on
    IMPORTING
      er_xml_document    = er_xml_document
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component_config~as_xml_element.

* The default implementation returns the config_screen
* as xml_element.

* Initializations.
  e_rc = 0.
  CLEAR er_xml_element.

  CHECK NOT gr_screen IS INITIAL.

* Get the config_screen as xml_element.
  CALL METHOD cl_ish_utl_screen=>get_screen_as_xml_element
    EXPORTING
      ir_screen          = gr_screen
      ir_xml_document    = ir_xml_document
      i_embedded_screens = on
    IMPORTING
      er_xml_element     = er_xml_element
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component_config~check.

* No default implementation.

ENDMETHOD.


METHOD if_ish_component_config~check_changes.

* The default implementation compares the original xml_document
* with the actual xml_document.

  DATA: lr_xml_document_act   TYPE REF TO if_ixml_document,
        l_xml_string_orig     TYPE xstring,
        l_xml_string_act      TYPE xstring.

* Initializations.
  e_rc      = 0.
  e_changed = off.

* Get the actual xml_document.
  CALL METHOD as_xml_document
    IMPORTING
      er_xml_document = lr_xml_document_act
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_xml_document_act IS INITIAL.

  IF gr_xml_document_orig IS INITIAL.
    e_changed = on.
    EXIT.
  ENDIF.

* Stringify the original xml_document.
  CALL FUNCTION 'SDIXML_DOM_TO_XML'
    EXPORTING
      document      = gr_xml_document_orig
    IMPORTING
      xml_as_string = l_xml_string_orig
    EXCEPTIONS
      no_document   = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    CLEAR l_xml_string_orig.
  ENDIF.

* Stringify the actual xml_document.
  CALL FUNCTION 'SDIXML_DOM_TO_XML'
    EXPORTING
      document      = lr_xml_document_act
    IMPORTING
      xml_as_string = l_xml_string_act
    EXCEPTIONS
      no_document   = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    CLEAR l_xml_string_act.
  ENDIF.

  IF l_xml_string_orig <> l_xml_string_act.
    e_changed = on.
*   TEST START
*   Switch l_test to 'X' for testing.
    DATA: l_test TYPE ish_on_off.
    IF l_test = on.
      DATA: mt_xml1  TYPE TABLE OF char255,
            mt_xml2  TYPE TABLE OF char255,
            m_xml1   TYPE string,
            m_xml2   TYPE string.
      FIELD-SYMBOLS: <m_xml>  TYPE char255.
      DO 1 TIMES.
        CALL FUNCTION 'SDIXML_DOM_TO_XML'
          EXPORTING
            document     = gr_xml_document_orig
          TABLES
            xml_as_table = mt_xml1
          EXCEPTIONS
            no_document  = 1
            OTHERS       = 2.
        CHECK sy-subrc = 0.
        CALL FUNCTION 'SDIXML_DOM_TO_XML'
          EXPORTING
            document     = lr_xml_document_act
          TABLES
            xml_as_table = mt_xml2
          EXCEPTIONS
            no_document  = 1
            OTHERS       = 2.
        CHECK sy-subrc = 0.
        CLEAR m_xml1.
        LOOP AT mt_xml1 ASSIGNING <m_xml>.
          CONCATENATE m_xml1
                      <m_xml>
                 INTO m_xml1.
        ENDLOOP.
        CLEAR m_xml2.
        LOOP AT mt_xml2 ASSIGNING <m_xml>.
          CONCATENATE m_xml2
                      <m_xml>
                 INTO m_xml2.
        ENDLOOP.
      ENDDO.
    ENDIF.
*   TEST END
  ENDIF.

ENDMETHOD.


METHOD if_ish_component_config~destroy.

  DATA: l_rc  TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Destroy the screen.
  IF NOT gr_screen IS INITIAL.
    CALL METHOD cl_ish_utl_screen=>destroy_screen
      EXPORTING
        ir_screen              = gr_screen
        i_destroy_embedded_scr = on
      IMPORTING
        e_rc                   = l_rc
      CHANGING
        cr_errorhandler        = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDIF.

* Clear own attributes.
  CLEAR: gr_component,
         gr_screen.

ENDMETHOD.


METHOD if_ish_component_config~get_component.

  rr_component = gr_component.

ENDMETHOD.


METHOD if_ish_component_config~get_screen.

  rr_screen = gr_screen.

ENDMETHOD.


METHOD if_ish_component_config~initialize.

  DATA: lr_xml_document  TYPE REF TO if_ixml_document.

* Initializations.
  e_rc = 0.

* Create gr_screen.
  CALL METHOD create_screen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Initialize gr_screen.
  CALL METHOD initialize_screen
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Check initialization.
  CALL METHOD check_initialization
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Set the original xml_document.
  CALL METHOD as_xml_document
    IMPORTING
      er_xml_document = lr_xml_document
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  gr_xml_document_orig = lr_xml_document.

ENDMETHOD.


METHOD if_ish_component_config~reset_data.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK gr_xml_document_orig IS BOUND.

* Just call method set_data_by_xml_document with original xml_doc.
  CALL METHOD set_data_by_xml_document
    EXPORTING
      ir_xml_document = gr_xml_document_orig
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component_config~set_data_by_xml_document.

* The default implementation sets gr_screen's data.

* Initializations.
  CLEAR: e_rc.

* Initial checking.
  CHECK NOT gr_screen        IS INITIAL.
  CHECK NOT ir_xml_document  IS INITIAL.

* Remember the original xml_document.
  gr_xml_document_orig = ir_xml_document.

* Set the screen's fieldvals.
  CALL METHOD cl_ish_utl_screen=>set_fieldvals_by_xml_document
    EXPORTING
      ir_screen       = gr_screen
      ir_xml_document = ir_xml_document
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component_config~set_data_by_xml_element.

* The default implementation sets gr_screen's data.

* Initializations.
  e_rc = 0.

  CHECK NOT gr_screen       IS INITIAL.
  CHECK NOT ir_xml_element  IS INITIAL.

* Remember the original xml_document.
  gr_xml_document_orig = ir_xml_element->get_owner_document( ).

* Set screen data.
  CALL METHOD cl_ish_utl_screen=>set_fieldvals_by_xml_element
    EXPORTING
      ir_screen       = gr_screen
      ir_xml_element  = ir_xml_element
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component_config~show_popup.

  DATA: lr_config             TYPE REF TO if_ish_config,
        lr_xml_document_orig  TYPE REF TO if_ixml_document.

* Michael Manoch, 05.06.2008, MED-32749   START
  DATA lr_xml_document_old    TYPE REF TO if_ixml_document.
  DATA l_rc                   TYPE ish_method_rc.
* Michael Manoch, 05.06.2008, MED-32749   END

* Initializations.
  e_rc        = 0.
  e_cancelled = off.

* No screen -> no popup.
  CHECK NOT gr_screen IS INITIAL.

* Get data from component.
  IF NOT gr_component IS INITIAL.
    lr_config = gr_component->get_config( ).
  ENDIF.

* Remember the original xml_document.
  lr_xml_document_orig = gr_xml_document_orig.

* Michael Manoch, 05.06.2008, MED-32749   START
* Get actual data as xml_document.
  CALL METHOD as_xml_document
    IMPORTING
      er_xml_document = lr_xml_document_old
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Michael Manoch, 05.06.2008, MED-32749   END

* Show popup.
  CALL METHOD cl_ish_prc_popup=>show_popup
    EXPORTING
      ir_screen                 = gr_screen
      i_prc_class_name          = 'CL_ISH_PRC_POPUP'
      i_prc_object_type         = cl_ish_prc_popup=>co_otype_prc_popup
      i_vcode                   = i_vcode
      i_popup_title             = i_popup_title
      ir_config                 = lr_config
      i_startpos_col            = i_startpos_col
      i_startpos_row            = i_startpos_row
      i_endpos_col              = i_endpos_col
      i_endpos_row              = i_endpos_row
      i_check_changes_on_cancel = i_check_changes_on_cancel
      i_check_on_choice         = i_check_on_choice
      i_exit_on_warnings        = i_exit_on_warnings
      ir_callback               = me
    IMPORTING
      e_cancelled               = e_cancelled
      e_rc                      = e_rc
    CHANGING
      cr_errorhandler           = cr_errorhandler.

* On error or cancellation of the popup
* reset the original xml_document.
  IF e_rc <> 0 OR
     e_cancelled = on.
*   Michael Manoch, 05.06.2008, MED-32749   START
*   Reset data by the remembered xml_document.
    CALL METHOD set_data_by_xml_document
      EXPORTING
        ir_xml_document = lr_xml_document_old
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
*   Michael Manoch, 05.06.2008, MED-32749   END
    gr_xml_document_orig = lr_xml_document_orig.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_component_config.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type TYPE i.

  r_is_a = off.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF i_object_type = l_object_type.
    r_is_a = on.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_component_config.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_popup_callback~check.

  e_rc = 0.

  CHECK NOT ir_prc_popup IS INITIAL.
  CHECK NOT ir_screen    IS INITIAL.
  CHECK ir_screen = get_screen( ).

* Just wrap to the check method.
  CALL METHOD check
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_popup_callback~check_changes.

  e_rc      = 0.
  e_changed = off.

  CHECK NOT ir_prc_popup IS INITIAL.
  CHECK NOT ir_prc_popup->get_vcode( ) = co_vcode_display.
  CHECK NOT ir_screen    IS INITIAL.
  CHECK ir_screen = get_screen( ).

* Just wrap to the check_changes method.
  CALL METHOD check_changes
    IMPORTING
      e_changed       = e_changed
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_popup_callback~exit_command.

* No default implementation.

  e_rc = 0.
  e_exit = off.

ENDMETHOD.


METHOD if_ish_popup_callback~transport_from_screen.

* No default implementation.

  e_rc = 0.

ENDMETHOD.


METHOD if_ish_popup_callback~transport_to_screen.

* No default implementation.

  e_rc = 0.

ENDMETHOD.


METHOD if_ish_popup_callback~user_command.

* No default implementation.

  e_rc = 0.
  e_exit = off.

ENDMETHOD.


METHOD initialize_screen.

  DATA: l_vcode         TYPE tndym-vcode,
        l_caller        TYPE sy-repid,
        lr_environment  TYPE REF TO cl_ish_environment,
        lr_lock         TYPE REF TO cl_ishmed_lock,
        lr_config       TYPE REF TO if_ish_config.

  CHECK NOT gr_screen    IS INITIAL.
  CHECK NOT gr_component IS INITIAL.

* Get component data.
  l_vcode        = gr_component->get_vcode( ).
  l_caller       = gr_component->get_caller( ).
  lr_environment = gr_component->get_environment( ).
  lr_lock        = gr_component->get_lock( ).
  lr_config      = gr_component->get_config( ).

* Initialize gr_screen.
  CALL METHOD gr_screen->initialize
    EXPORTING
      i_main_object  = me
      i_vcode        = l_vcode
      i_caller       = l_caller
      i_environment  = lr_environment
      i_lock         = lr_lock
      i_config       = lr_config
    IMPORTING
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.
ENDCLASS.
