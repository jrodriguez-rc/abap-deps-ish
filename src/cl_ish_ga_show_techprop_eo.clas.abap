class CL_ISH_GA_SHOW_TECHPROP_EO definition
  public
  inheriting from CL_ISH_GA_POPUP
  create protected .

public section.
*"* public components of class CL_ISH_GA_SHOW_TECHPROP_EO
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !IR_ENTRY type ref to CL_ISH_ENTITY_OBJECT
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    raising
      CX_ISH_STATIC_HANDLER .
  interface IF_ISH_GUI_VIEW load .
  class-methods EXECUTE
    importing
      !IR_ENTRY type ref to CL_ISH_ENTITY_OBJECT
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GA_SHOW_TECHPROP_EO
*"* do not include other source files here!!!

  methods _CMD_ENTER
    redefinition .
  methods _DESTROY
    redefinition .
  methods _GET_TITLE_TEXT
    redefinition .
  methods _LOAD_POPUP_VIEW
    redefinition .
  methods _BEFORE_PBO
    redefinition .
private section.
*"* private components of class CL_ISH_GA_SHOW_TECHPROP_EO
*"* do not include other source files here!!!

  data GR_ENTRY type ref to CL_ISH_ENTITY_OBJECT .
ENDCLASS.



CLASS CL_ISH_GA_SHOW_TECHPROP_EO IMPLEMENTATION.


METHOD constructor.

  IF ir_entry IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_GA_SHOW_TECHPROP_EO' ).
  ENDIF.

  super->constructor( i_element_name    = i_element_name
                      ir_cb_destroyable = ir_cb_destroyable ).

  gr_entry = ir_entry.

ENDMETHOD.


METHOD execute.

  DATA lr_application           TYPE REF TO cl_ish_ga_show_techprop_eo.

* Create the object.
  TRY.
      CREATE OBJECT lr_application
        EXPORTING
          ir_entry = ir_entry.
    CATCH cx_root.                                       "#EC CATCH_ALL
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'EXECUTE'
          i_mv3        = 'CL_ISH_GA_SHOW_TECHPROP_EO' ).
  ENDTRY.

  TRY.
      lr_application->_init_ga_popup(
          i_vcode     = i_vcode
          i_start_row = 7
          i_start_col = 70
          i_end_row   = 0
          i_end_col   = 0 ).
      lr_application->run( ).
    CLEANUP.
      lr_application->destroy( ).
  ENDTRY.

  lr_application->destroy( ).

ENDMETHOD.


METHOD _before_pbo.

  rr_response = super->_before_pbo( ir_dynpro_event = ir_dynpro_event ).

  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'RN1_DYNP_TECHPROP_EO-ERUSR' OR
           'RN1_DYNP_TECHPROP_EO-ERDAT' OR
           'RN1_DYNP_TECHPROP_EO-ERTIM'.
        CHECK gr_entry->get_erdat( ) IS INITIAL.
        screen-active = 0.
        MODIFY SCREEN.
      WHEN 'RN1_DYNP_TECHPROP_EO-UPUSR' OR
           'RN1_DYNP_TECHPROP_EO-UPDAT' OR
           'RN1_DYNP_TECHPROP_EO-UPTIM'.
        CHECK gr_entry->get_updat( ) IS INITIAL.
        screen-active = 0.
        MODIFY SCREEN.
      WHEN 'RN1_DYNP_TECHPROP_EO-LOEKZ' OR
           'RN1_DYNP_TECHPROP_EO-LOUSR' OR
           'RN1_DYNP_TECHPROP_EO-LODAT' OR
           'RN1_DYNP_TECHPROP_EO-LOTIM'.
        CHECK gr_entry->get_lodat( ) IS INITIAL.
        screen-active = 0.
        MODIFY SCREEN.
      WHEN 'RN1_DYNP_TECHPROP_EO-STOKZ'   OR
           'RN1_DYNP_TECHPROP_EO-STOUSR'  OR
           'RN1_DYNP_TECHPROP_EO-STODAT'  OR
           'RN1_DYNP_TECHPROP_EO-STOTIM'  OR
           'RN1_DYNP_TECHPROP_EO-STOID'.
        CHECK gr_entry->get_stodat( ) IS INITIAL.
        screen-active = 0.
        MODIFY SCREEN.
    ENDCASE.
  ENDLOOP.

ENDMETHOD.


METHOD _cmd_enter.

  r_exit = abap_true.

ENDMETHOD.


METHOD _destroy.

  super->_destroy( ).

  CLEAR gr_entry.

ENDMETHOD.


METHOD _get_title_text.

  r_title_text = 'Technische Eigenschaften'(001).

ENDMETHOD.


METHOD _load_popup_view.

  DATA lr_old_popup_ctr               TYPE REF TO if_ish_gui_controller.
  DATA lr_main_view                   TYPE REF TO if_ish_gui_mdy_view.
  DATA lr_popup_ctr                   TYPE REF TO cl_ish_gc_simple.
  DATA lr_popup_view                  TYPE REF TO cl_ish_gv_sdy_simple.

  CHECK gr_entry IS BOUND.

* Destroy the "old" popup controller.
  lr_old_popup_ctr = get_popup_ctr( ).
  IF lr_old_popup_ctr IS BOUND.
    lr_old_popup_ctr->destroy( ).
  ENDIF.

* Create and initialize the popup controller + view.
  lr_main_view = get_main_view( ).
  lr_popup_ctr = cl_ish_gc_simple=>create(
      i_element_name = co_ctrname_popup ).
  lr_popup_view = cl_ish_gv_sdy_simple=>create(
      i_element_name = co_viewname_popup ).
  lr_popup_ctr->initialize(
      ir_parent_controller = gr_main_controller
      ir_model             = gr_entry
      ir_view              = lr_popup_view
      i_vcode              = g_vcode ).
  lr_popup_view->initialize(
      ir_controller     = lr_popup_ctr
      ir_parent_view    = lr_main_view
      i_vcode           = g_vcode
      i_repid           = 'SAPLN1_SDY_TECHPROP_EO'
      i_dynnr           = '0100'
      i_dynpstruct_name = 'RN1_DYNP_TECHPROP_EO' ).

ENDMETHOD.
ENDCLASS.
