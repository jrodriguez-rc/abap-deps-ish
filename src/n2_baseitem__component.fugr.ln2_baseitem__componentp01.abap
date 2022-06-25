*----------------------------------------------------------------------*
***INCLUDE LN2_BASEITEM__COMPONENTP01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&       Class (Implementation)  LCL_COMPONENT_SCREEN
*&---------------------------------------------------------------------*
*        Text
*----------------------------------------------------------------------*
CLASS lcl_component_screen IMPLEMENTATION.

  METHOD create.
**  -> i_itemtype     type n2_baseitem_type
**  -> i_baseitem_id  type n2_baseitem_id
** >-> cr_instance type ref to lcl_component_screen

** check instance
    IF cr_instance IS BOUND.
      IF i_baseitem_id = cr_instance->g_baseitem
      AND cr_instance->gr_comp_base IS BOUND.
        RETURN.
      ELSE.
        cr_instance->finalize( ).
        FREE cr_instance.
      ENDIF.
    ENDIF.

    CREATE OBJECT cr_instance
      EXPORTING
        i_itemtype    = i_itemtype
        i_baseitem_id = i_baseitem_id.

  ENDMETHOD.                    "create
***--------------------------------------------------------

  METHOD constructor.

    DATA l_compid      TYPE        n1compid.
    DATA l_rc          TYPE        ish_method_rc.

    DATA lr_error      TYPE REF TO cl_ishmed_errorhandling.

    DATA lx_baseitems  TYPE REF TO cx_ishmed_baseitems.
**-------

    CASE i_itemtype.
* medical services
      WHEN 'SERVICEMED'.
        l_compid = cl_ishmed_comp_dws_medsrv=>co_compid_dws.
* team
      WHEN 'SRVTEAM'.
        l_compid = cl_ishmed_comp_srvteam=>co_compid.
* material
      WHEN 'MATERIAL'.
        l_compid = cl_ishmed_comp_material=>co_compid.
* surgery order
      WHEN 'SURGORDER'.
        l_compid = cl_ishmed_comp_surgorder=>co_compid.
* medication order
      WHEN 'MEORDER'.
        l_compid = cl_ishmed_comp_dws_meorder=>co_compid_dws.
* nursing services
      WHEN 'SERVICENRS'.
        l_compid = cl_ishmed_comp_dws_nrssrv=>co_compid_dws.
* nursing plan
      WHEN 'NRSPLAN'.
        l_compid = cl_ishmed_nrs_comp_plan_dws_bi=>co_compid_dws_bi.
* medication event administration
      WHEN 'MEADMINEVT'.
        l_compid = cl_ishmed_comp_dws_admevt=>co_compid_dws.
    ENDCASE.

* get component definition
    cl_ish_compdef=>get_compdef(
       EXPORTING
         i_obtyp    = 'N1D'
         i_compid   = l_compid
       IMPORTING
         er_compdef =  me->gr_comp_def ).

    CHECK gr_comp_def IS BOUND.

* create environment
    cl_ish_fac_environment=>create(
      EXPORTING
        i_program_name = 'SAPLN2_BASEITEM__COMPONENT'
        i_use_one_env  = abap_off
      IMPORTING
        e_instance     = me->gr_environment
        e_rc           = l_rc
      CHANGING
        c_errorhandler = lr_error ).

    IF l_rc > 0.
      RAISE EXCEPTION TYPE cx_ishmed_baseitem_screen
        EXPORTING
          gr_errorhandler = lr_error.
    ENDIF.

* get component
    me->gr_comp_def->get_component_base(
      EXPORTING
        i_refresh       = abap_on
        i_vcode         = if_ish_constant_definition=>co_vcode_display
        i_caller        = 'SAPLN2_BASEITEM__COMPONENT'
        ir_environment  = me->gr_environment
      IMPORTING
        er_component    = me->gr_comp_base
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_error ).

    IF g_rc > 0.
      RAISE EXCEPTION TYPE cx_ishmed_baseitem_screen
        EXPORTING
          gr_errorhandler = lr_error.
    ENDIF.

* get component config
    me->gr_comp_config = gr_comp_base->get_component_config( ).
    CHECK me->gr_comp_config IS BOUND.

* get screen
    me->gr_screen = me->gr_comp_config->get_screen( ).
    CHECK gr_screen IS BOUND.

* get parent
    me->gr_screen->get_parent(
      IMPORTING
        es_parent = me->gs_parent ).

** register handler for finalize
    me->gr_manager = cl_ishmed_baseitems_manager=>get_instance( ).
    SET HANDLER me->handle_finalize FOR me->gr_manager.

** set baseitem id
    me->g_baseitem = i_baseitem_id.

** xml document
    CREATE OBJECT me->gr_xmldoc.

** register callback for check
    TRY.
        me->gr_manager->register_check_callback( ir_callback = me  ).

      CATCH cx_ishmed_baseitems INTO lx_baseitems.
        RAISE EXCEPTION TYPE cx_ishmed_baseitem_screen
          EXPORTING
            previous = lx_baseitems.
    ENDTRY.


  ENDMETHOD.                    "constructor
***--------------------------------------------------------

  METHOD finalize.

** disable event handler
    IF me->gr_manager IS BOUND.
      SET HANDLER me->handle_finalize FOR me->gr_manager
        ACTIVATION abap_off.
    ENDIF.

    IF me->gr_comp_base IS BOUND.
      me->gr_comp_base->destroy( ).
      FREE me->gr_comp_base.
    ENDIF.

*    CLEAR me->gs_parent.
*    CLEAR me->g_baseitem.
*
*    IF me->gr_screen IS BOUND.
*      me->gr_screen->destroy( ).
*      FREE me->gr_screen.
*    ENDIF.
*
*    IF me->gr_comp_config IS BOUND.
*      me->gr_comp_config->destroy( ).
*      FREE me->gr_comp_config.
*    ENDIF.
*
*    IF me->gr_environment IS BOUND.
*      me->gr_environment->if_ish_data_object~destroy( ).
*      FREE me->gr_environment.
*    ENDIF.
*
*    FREE me->gr_comp_def.

    FREE me->gr_manager.


  ENDMETHOD.                    "finalize
***--------------------------------------------------------
  METHOD handle_finalize.

    TRY.
        me->finalize( ).
      CATCH cx_ishmed_baseitems.
    ENDTRY.

  ENDMETHOD.                    "handle_finalize
***--------------------------------------------------------
  METHOD set_ok_code.

*   6.05: replace l_rc by e_rc and lr_error by cr_errorhandler!

    DATA lt_screen   TYPE        ish_t_screen_objects.

    DATA lr_screen   TYPE REF TO if_ish_screen.
*    DATA lr_error    TYPE REF TO cl_ishmed_errorhandling.

    DATA l_okcode    TYPE        syucomm.
*    DATA l_rc        TYPE        ish_method_rc.
***
    l_okcode = i_okcode.

    cl_ish_utl_screen=>get_screen_instances(
      EXPORTING
        i_screen       = me->gr_screen
        i_embedded_scr = abap_on
      IMPORTING
        et_screens     = lt_screen
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler ).

    CHECK e_rc = 0.

    LOOP AT lt_screen INTO lr_screen.
      CHECK lr_screen IS BOUND.

      lr_screen->ok_code_screen(
        IMPORTING
          e_rc           = e_rc
        CHANGING
          c_errorhandler = cr_errorhandler
          c_okcode       = l_okcode ).

      IF e_rc <> 0 OR
         l_okcode IS INITIAL.
        EXIT.
      ENDIF.

    ENDLOOP.

    CHECK e_rc = 0.

  ENDMETHOD.                    "set_ok_code
***--------------------------------------------------------
  METHOD set_mode.

    DATA lt_screen   TYPE        ish_t_screen_objects.

    DATA lr_screen   TYPE REF TO if_ish_screen.
    DATA lr_error    TYPE REF TO cl_ishmed_errorhandling.

    DATA l_new_vcode TYPE        ish_vcode.
    DATA l_rc        TYPE        ish_method_rc.
***
    cl_ish_utl_screen=>get_screen_instances(
        EXPORTING
          i_screen       = me->gr_screen
          i_embedded_scr = abap_on
        IMPORTING
          et_screens     = lt_screen
          e_rc           = l_rc
        CHANGING
          c_errorhandler = lr_error ).

    CHECK l_rc = 0.

    CASE i_readonly.
      WHEN abap_off.
        l_new_vcode = if_ish_constant_definition=>co_vcode_update.
      WHEN abap_on.
        l_new_vcode = if_ish_constant_definition=>co_vcode_display.
    ENDCASE.

    LOOP AT lt_screen INTO lr_screen.
      CHECK lr_screen IS BOUND.

      lr_screen->set_data(
          i_vcode   = l_new_vcode
          i_vcode_x = abap_on ).

    ENDLOOP.

  ENDMETHOD.                    "set_mode
***--------------------------------------------------------
  METHOD get_screen.

    e_dynnr   = me->gs_parent-dynnr.
    e_program = me->gs_parent-repid.

  ENDMETHOD.                    "get_screen
***--------------------------------------------------------
  METHOD set_data.

    DATA lr_error    TYPE REF TO cl_ishmed_errorhandling.

    DATA l_rc        TYPE        ish_method_rc.
*****

    CHECK i_xmldoc IS NOT INITIAL.

    me->gr_xmldoc->parse_string( stream = i_xmldoc ).

    me->gr_comp_config->set_data_by_xml_document(
      EXPORTING
        ir_xml_document = me->gr_xmldoc->m_document
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_error ).

    IF l_rc > 0.
      RAISE EXCEPTION TYPE cx_ishmed_baseitem_screen
        EXPORTING
          gr_errorhandler = lr_error.
    ENDIF.

  ENDMETHOD.                    "set_data
***--------------------------------------------------------
  METHOD get_data.

    DATA lr_error      TYPE REF TO cl_ishmed_errorhandling.
    DATA lr_ixml_doc   TYPE REF TO if_ixml_document.
    DATA lr_ixml_node  TYPE REF TO if_ixml_node.

    DATA l_rc          TYPE        ish_method_rc.
*****

    me->gr_comp_config->as_xml_document(
      IMPORTING
        er_xml_document = lr_ixml_doc
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_error ).
    CHECK lr_ixml_doc IS BOUND.

    me->gr_xmldoc->create_with_dom( document = lr_ixml_doc ).

    lr_ixml_node = me->gr_xmldoc->get_first_node( ).
    CHECK lr_ixml_node IS BOUND.

    me->gr_xmldoc->render_fragment_2_string(
      EXPORTING
        node         = lr_ixml_node
        pretty_print = abap_off
      IMPORTING
        stream       = e_xmldoc ).

  ENDMETHOD.                    "get_data

***--------------------------------------------------------
  METHOD if_ishmed_baseitem_check_cb~check_callback.
*** callback method for check component
    me->gr_comp_config->check(
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler ).

  ENDMETHOD.                    "IF_ISHMED_BASEITEM_CHECK_CB~check_callback

ENDCLASS.               "LCL_COMPONENT_SCREEN
