class CL_ISH_COMPCON_GA definition
  public
  inheriting from CL_ISH_COMPONENT_CONFIG
  create public .

public section.
*"* public components of class CL_ISH_COMPCON_GA
*"* do not include other source files here!!!

  constants CO_OTYPE_COMPCON_GA type ISH_OBJECT_TYPE value 13707. "#EC NOTEXT

  methods GET_COMPONENT_GA
    returning
      value(RR_COMPONENT_GA) type ref to CL_ISH_COMP_GA .
  type-pools ABAP .
  methods GET_GM_COMPCON
    importing
      !I_LOAD type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_GM_COMPCON) type ref to CL_ISH_GM_COMPCON
    raising
      CX_ISH_STATIC_HANDLER .

  methods IF_ISH_COMPONENT_CONFIG~AS_XML_DOCUMENT
    redefinition .
  methods IF_ISH_COMPONENT_CONFIG~AS_XML_ELEMENT
    redefinition .
  methods IF_ISH_COMPONENT_CONFIG~CHECK
    redefinition .
  methods IF_ISH_COMPONENT_CONFIG~CHECK_CHANGES
    redefinition .
  methods IF_ISH_COMPONENT_CONFIG~DESTROY
    redefinition .
  methods IF_ISH_COMPONENT_CONFIG~RESET_DATA
    redefinition .
  methods IF_ISH_COMPONENT_CONFIG~SET_DATA_BY_XML_DOCUMENT
    redefinition .
  methods IF_ISH_COMPONENT_CONFIG~SET_DATA_BY_XML_ELEMENT
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_COMPCON_GA
*"* do not include other source files here!!!

  data GR_GM_COMPCON_ORIG type ref to CL_ISH_GM_COMPCON .
  data GR_GM_COMPCON type ref to CL_ISH_GM_COMPCON .

  methods CREATE_SCREEN
    redefinition .
private section.
*"* private components of class CL_ISH_COMPCON_GA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COMPCON_GA IMPLEMENTATION.


METHOD create_screen.

  DATA lr_comp_ga           TYPE REF TO cl_ish_comp_ga.
  DATA lr_application       TYPE REF TO if_ish_gui_application.
  DATA lr_screen            TYPE REF TO cl_ish_scr_ga_dynpro.
  DATA lx_static            TYPE REF TO cx_ish_static_handler.

  e_rc = 0.

  lr_comp_ga = get_component_ga( ).
  CHECK lr_comp_ga IS BOUND.

  TRY.
      lr_application = lr_comp_ga->load_compcon_application( ).
    CATCH cx_ish_static_handler INTO lx_static.
      e_rc = 1.
      IF lx_static->gr_errorhandler IS BOUND.
        CALL METHOD cl_ish_utl_base=>copy_messages
          EXPORTING
            i_copy_from     = lx_static->gr_errorhandler
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
      RETURN.
  ENDTRY.
  CHECK lr_application IS BOUND.

  CREATE OBJECT lr_screen.
  lr_screen->set_application( ir_application = lr_application ).

  gr_screen = lr_screen.

ENDMETHOD.


METHOD get_component_ga.

  TRY.
      rr_component_ga ?= gr_component.
    CATCH cx_sy_move_cast_error.
      CLEAR rr_component_ga.
  ENDTRY.

ENDMETHOD.


METHOD get_gm_compcon.

  DATA lr_component           TYPE REF TO cl_ish_comp_ga.

  IF gr_gm_compcon IS NOT BOUND AND
     i_load = abap_true.
    lr_component = get_component_ga( ).
    CHECK lr_component IS BOUND.
    gr_gm_compcon = lr_component->create_gm_compcon( ).
  ENDIF.

  rr_gm_compcon = gr_gm_compcon.

ENDMETHOD.


METHOD if_ish_component_config~as_xml_document.

  DATA lr_ixml                  TYPE REF TO if_ixml.
  DATA lx_static                TYPE REF TO cx_ish_static_handler.

  e_rc = 0.
  CLEAR er_xml_document.

  TRY.
      get_gm_compcon( ).
      IF gr_gm_compcon IS BOUND.
        er_xml_document = gr_gm_compcon->as_xmldoc( ).
      ELSE.
        lr_ixml = ir_ixml.
        IF lr_ixml IS INITIAL.
          CLASS cl_ixml DEFINITION LOAD.
          lr_ixml = cl_ixml=>create( ).
        ENDIF.
        er_xml_document = lr_ixml->create_document( ).
      ENDIF.
    CATCH cx_ish_static_handler INTO lx_static.
      e_rc = 0.
      IF lx_static->gr_errorhandler IS BOUND.
        CALL METHOD cl_ish_utl_base=>copy_messages
          EXPORTING
            i_copy_from     = lx_static->gr_errorhandler
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
  ENDTRY.

ENDMETHOD.


METHOD IF_ISH_COMPONENT_CONFIG~AS_XML_ELEMENT.

* Not supported.

ENDMETHOD.


METHOD if_ish_component_config~check.

  CLEAR e_rc.

  CHECK gr_gm_compcon IS BOUND.

  CALL METHOD gr_gm_compcon->check
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_component_config~check_changes.

  e_changed = abap_false.
  e_rc = 0.

  CHECK gr_gm_compcon_orig IS BOUND.
  CHECK gr_gm_compcon IS BOUND.

  CHECK gr_gm_compcon->is_equal( gr_gm_compcon_orig ) = abap_false.

  e_changed = abap_true.

ENDMETHOD.


METHOD if_ish_component_config~destroy.

  CALL METHOD super->if_ish_component_config~destroy
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

  CLEAR gr_gm_compcon.
  CLEAR gr_gm_compcon_orig.

ENDMETHOD.


METHOD if_ish_component_config~reset_data.

  DATA lx_static            TYPE REF TO cx_ish_static_handler.

  e_rc = 0.

  CHECK gr_gm_compcon_orig IS BOUND.
  CHECK gr_gm_compcon IS BOUND.

  TRY.
      gr_gm_compcon->set_data_by_other( ir_other = gr_gm_compcon_orig ).
    CATCH cx_ish_static_handler INTO lx_static.
      e_rc = 1.
      IF lx_static->gr_errorhandler IS BOUND.
        CALL METHOD cl_ish_utl_base=>copy_messages
          EXPORTING
            i_copy_from     = lx_static->gr_errorhandler
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
  ENDTRY.

  CLEAR gr_gm_compcon_orig.

ENDMETHOD.


METHOD if_ish_component_config~set_data_by_xml_document.

  DATA lr_component             TYPE REF TO cl_ish_comp_ga.
  DATA lx_root                  TYPE REF TO cx_root.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_xml_document IS BOUND.

* Get the component.
  lr_component = get_component_ga( ).
  CHECK lr_component IS BOUND.

* Remember the original model.
  IF gr_gm_compcon_orig IS NOT BOUND.
    gr_gm_compcon_orig = gr_gm_compcon.
  ENDIF.

* Create the new model.
  TRY.
      get_gm_compcon( ).
      CHECK gr_gm_compcon IS BOUND.
      gr_gm_compcon->set_data_by_xmldoc( ir_xml_document = ir_xml_document ).
    CATCH cx_ish_static_handler INTO lx_root.
      e_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lx_root
        CHANGING
          cr_errorhandler = cr_errorhandler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_component_config~set_data_by_xml_element.

  DATA lr_xml_document            TYPE REF TO if_ixml_document.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK ir_xml_element IS BOUND.

* Get the xml document.
  lr_xml_document = ir_xml_element->get_owner_document( ).

* Wrap.
  CALL METHOD set_data_by_xml_document
    EXPORTING
      ir_xml_document = lr_xml_document
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_compcon_ga.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_compcon_ga.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
