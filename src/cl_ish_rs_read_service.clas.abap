class CL_ISH_RS_READ_SERVICE definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_RS_READ_SERVICE
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_CB_STRUCTURE_MODEL .
  interfaces IF_ISH_GUI_CB_TABLE_MODEL .
  interfaces IF_ISH_GUI_CB_XTABLE_MODEL .
  interfaces IF_ISH_RS_READ_SERVICE
      abstract methods GET_ENTITIES
      final methods GET_MGR
                    GET_TYPE .

  aliases CB_ADD_ENTRY
    for IF_ISH_GUI_CB_TABLE_MODEL~CB_ADD_ENTRY .
  aliases CB_APPEND_ENTRY
    for IF_ISH_GUI_CB_XTABLE_MODEL~CB_APPEND_ENTRY .
  aliases CB_PREPEND_ENTRY
    for IF_ISH_GUI_CB_XTABLE_MODEL~CB_PREPEND_ENTRY .
  aliases CB_REMOVE_ENTRY
    for IF_ISH_GUI_CB_TABLE_MODEL~CB_REMOVE_ENTRY .
  aliases CB_SET_FIELD_CONTENT
    for IF_ISH_GUI_CB_STRUCTURE_MODEL~CB_SET_FIELD_CONTENT .
  aliases GET_ENTITIES
    for IF_ISH_RS_READ_SERVICE~GET_ENTITIES .
  aliases GET_MGR
    for IF_ISH_RS_READ_SERVICE~GET_MGR .
  aliases GET_SEARCH_RESULTS
    for IF_ISH_RS_READ_SERVICE~GET_SEARCH_RESULTS .
  aliases GET_TYPE
    for IF_ISH_RS_READ_SERVICE~GET_TYPE .
  aliases NEW_INSTANCE
    for IF_ISH_RS_READ_SERVICE~NEW_INSTANCE .
  aliases REFRESH
    for IF_ISH_RS_READ_SERVICE~REFRESH .
  aliases REFRESH_SEARCH_RESULT
    for IF_ISH_RS_READ_SERVICE~REFRESH_SEARCH_RESULT .

  methods CONSTRUCTOR
    importing
      !IR_MGR type ref to CL_ISH_RS_MGR
      !I_TYPE type N1RS_TYPE
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_RS_READ_SERVICE
*"* do not include other source files here!!!

  data GR_CB_MODEL type ref to IF_ISH_GUI_MODEL .
  data GR_CB_ENTRY type ref to IF_ISH_GUI_MODEL .
  data GR_CB_PREVIOUS_ENTRY type ref to IF_ISH_GUI_MODEL .
  data GR_CB_NEXT_ENTRY type ref to IF_ISH_GUI_MODEL .
  data GT_SEARCH_RESULT type ISH_T_RS_SEARCHRESULT_OBJH .
  data GT_ENTITY_REFRESH type ISH_T_RS_ENTITY_OBJH .

  methods ON_ENTITY_CHANGED_REFRESH
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods ON_MGR_AFTER_DESTROY
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
  methods ON_SR_AFTER_DESTROY
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
  methods _REFRESH_ENTITIES
  abstract
    importing
      !IT_ENTITY type ISH_T_RS_ENTITY_OBJH
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REFRESH_SEARCH_RESULT
  abstract
    importing
      !IR_SEARCH_RESULT type ref to IF_ISH_RS_SEARCH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  methods _REGISTER_SEARCH_RESULT
    importing
      !IR_SEARCH_RESULT type ref to IF_ISH_RS_SEARCH_RESULT .
private section.
*"* private components of class CL_ISH_RS_READ_SERVICE
*"* do not include other source files here!!!

  data GR_MGR type ref to CL_ISH_RS_MGR .
  data G_TYPE type N1RS_TYPE .
ENDCLASS.



CLASS CL_ISH_RS_READ_SERVICE IMPLEMENTATION.


METHOD constructor.

  IF ir_mgr IS NOT BOUND OR
     i_type IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'CONSTRUCTOR'
        i_mv3 = 'CL_ISH_RS_READ_SERVICE' ).
  ENDIF.

  gr_mgr = ir_mgr.
  g_type = i_type.

  SET HANDLER on_mgr_after_destroy FOR ir_mgr ACTIVATION abap_true.

ENDMETHOD.


METHOD if_ish_gui_cb_structure_model~cb_set_field_content.

  IF ir_model <> gr_cb_model.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'CB_SET_FIELD_CONTENT'
        i_mv3 = 'CL_ISH_RS_READ_SERVICE' ).
  ENDIF.

  r_continue = abap_true.

ENDMETHOD.


METHOD if_ish_gui_cb_table_model~cb_add_entry.

  IF ir_model <> gr_cb_model OR
     ir_entry <> gr_cb_entry.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_ADD_ENTRY'
        i_mv3        = 'CL_ISH_RS_READ_SERVICE' ).
  ENDIF.

  r_continue = abap_true.

ENDMETHOD.


METHOD if_ish_gui_cb_table_model~cb_remove_entry.

  IF ir_model <> gr_cb_model OR
     ir_entry <> gr_cb_entry.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_REMOVE_ENTRY'
        i_mv3        = 'CL_ISH_RS_READ_SERVICE' ).
  ENDIF.

  r_continue = abap_true.

ENDMETHOD.


METHOD if_ish_gui_cb_xtable_model~cb_append_entry.

  IF ir_model <> gr_cb_model OR
     ir_previous_entry <> gr_cb_previous_entry OR
     ir_entry <> gr_cb_entry.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_APPEND_ENTRY'
        i_mv3        = 'CL_ISH_RS_READ_SERVICE' ).
  ENDIF.

  r_continue = abap_true.

ENDMETHOD.


METHOD if_ish_gui_cb_xtable_model~cb_prepend_entry.

  IF ir_model <> gr_cb_model OR
     ir_next_entry <> gr_cb_next_entry OR
     ir_entry <> gr_cb_entry.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_PREPEND_ENTRY'
        i_mv3        = 'CL_ISH_RS_READ_SERVICE' ).
  ENDIF.

  r_continue = abap_true.

ENDMETHOD.


METHOD if_ish_rs_read_service~get_mgr.

  rr_mgr = gr_mgr.

ENDMETHOD.


METHOD if_ish_rs_read_service~get_search_results.

  rt_search_result = gt_search_result.

ENDMETHOD.


METHOD if_ish_rs_read_service~get_type.

  r_type = g_type.

ENDMETHOD.


METHOD if_ish_rs_read_service~new_instance.


  DATA: l_clsname TYPE seoclsname,
        lx_static TYPE REF TO cx_ish_static_handler,
        lx_root   TYPE REF TO cx_root.


* The type has to be specified.
  IF i_type IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'NEW_INSTANCE'
        i_mv3 = 'CL_ISH_RS_READ_SERVICE' ).
  ENDIF.

* Get the classname of the read service from the type.
  l_clsname = cl_ish_rs_type=>sget_clsname_read_service( i_type ).
  IF l_clsname IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '2'
        i_mv2 = 'NEW_INSTANCE'
        i_mv3 = 'CL_ISH_RS_READ_SERVICE' ).
  ENDIF.

* Instantiate the read service.
  TRY.
      CREATE OBJECT rr_instance
        TYPE
          (l_clsname)
        EXPORTING
          ir_mgr      = ir_mgr
          i_type      = i_type.
    CATCH cx_ish_static_handler INTO lx_static.
      RAISE EXCEPTION lx_static.
    CATCH cx_root INTO lx_root. "EC CATCH ALL
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_rs_read_service~refresh.

  DATA lr_entity                    TYPE REF TO if_ish_rs_entity.
  DATA lr_search_result             TYPE REF TO if_ish_rs_search_result.

* Get all loaded entity objects.
  gt_entity_refresh = get_entities( ).

* Register the entity event handler.
* On search_result refreshing entity objects may be also refreshed.
* Therefore we use eventhandler on_entity_changed_refresh to remove already refreshed
* entity objects from gt_entity_refresh.
  LOOP AT gt_entity_refresh INTO lr_entity.
    SET HANDLER on_entity_changed_refresh FOR lr_entity ACTIVATION abap_true.
  ENDLOOP.

* Refresh all search_results.
  LOOP AT gt_search_result INTO lr_search_result.
    _refresh_search_result( ir_search_result = lr_search_result ).
  ENDLOOP.

* Further processing only on left entity objects.
  CHECK gt_entity_refresh IS NOT INITIAL.

* Now refresh the left entity objects.
  _refresh_entities( it_entity = gt_entity_refresh ).

* Now deregister the entity event handler.
  LOOP AT gt_entity_refresh INTO lr_entity.
    SET HANDLER on_entity_changed_refresh FOR lr_entity ACTIVATION abap_false.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_rs_read_service~refresh_search_result.

  CHECK ir_search_result IS BOUND.

* The search_result has to belong to self.
  READ TABLE gt_search_result
    WITH TABLE KEY table_line = ir_search_result
    TRANSPORTING NO FIELDS.
  IF sy-subrc <> 0.
    CALL METHOD cl_ish_utl_exception=>raise_static
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '030'
        i_mv1 = '1'
        i_mv2 = 'REFRESH_SEARCH_RESULT'
        i_mv3 = 'CL_ISH_RS_READ_SERVICE'.
  ENDIF.

* Activate the search_result's refresh_buffer.
  ir_search_result->activate_refresh_buffer( ).

* Refresh the search_result.
  TRY.
      _refresh_search_result( ir_search_result = ir_search_result ).
    CLEANUP.
      ir_search_result->deactivate_refresh_buffer( ).
  ENDTRY.

* Deactivate the search_result's refresh_buffer.
  ir_search_result->deactivate_refresh_buffer( ).

ENDMETHOD.


METHOD on_entity_changed_refresh.

  DATA lr_entity                    TYPE REF TO if_ish_rs_entity.

  CHECK sender IS BOUND.

  TRY.
      lr_entity ?= sender.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  SET HANDLER on_entity_changed_refresh FOR lr_entity ACTIVATION abap_false.

ENDMETHOD.


METHOD on_mgr_after_destroy.

  CHECK sender = gr_mgr.

  SET HANDLER on_mgr_after_destroy FOR gr_mgr ACTIVATION abap_false.

  CLEAR gr_cb_entry.
  CLEAR gr_cb_model.
  CLEAR gr_cb_next_entry.
  CLEAR gr_cb_previous_entry.
  CLEAR gt_entity_refresh.
  CLEAR gt_entity_refresh.
  CLEAR gt_search_result.

ENDMETHOD.


METHOD on_sr_after_destroy.

  DATA lr_search_result                   TYPE REF TO if_ish_rs_search_result.

  CHECK sender IS BOUND.

  TRY.
      lr_search_result ?= sender.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

  DELETE TABLE gt_search_result
    WITH TABLE KEY table_line = lr_search_result.

ENDMETHOD.


METHOD _register_search_result.

  CHECK ir_search_result IS BOUND.

  INSERT ir_search_result INTO TABLE gt_search_result.
  CHECK sy-subrc = 0.

  SET HANDLER on_sr_after_destroy FOR ir_search_result ACTIVATION abap_true.

ENDMETHOD.
ENDCLASS.
