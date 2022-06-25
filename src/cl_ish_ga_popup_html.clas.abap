class CL_ISH_GA_POPUP_HTML definition
  public
  inheriting from CL_ISH_GA_POPUP
  create public .

*"* public components of class CL_ISH_GA_POPUP_HTML
*"* do not include other source files here!!!
public section.

  constants CO_CTRNAME_HTML type N1GUI_ELEMENT_NAME value 'HTML_CTR'. "#EC NOTEXT
  constants CO_VIEWNAME_HTML type N1GUI_ELEMENT_NAME value 'HTML_VIEW'. "#EC NOTEXT

  class-methods EXECUTE_BY_URL
    importing
      !I_START_ROW type I optional
      !I_START_COL type I optional
      !I_END_ROW type I optional
      !I_END_COL type I optional
      !I_TITLE_TEXT type STRING
      !I_URL type N1URL_WWW
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods EXECUTE_BY_URL_MODEL
    importing
      !I_START_ROW type I optional
      !I_START_COL type I optional
      !I_END_ROW type I optional
      !I_END_COL type I optional
      !I_TITLE_TEXT type STRING
      !IR_URL_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL
      !I_FIELDNAME_URL type ISH_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods INITIALIZE
    importing
      !I_START_ROW type I optional
      !I_START_COL type I optional
      !I_END_ROW type I optional
      !I_END_COL type I optional
      !I_TITLE_TEXT type STRING
      !I_URL type N1URL_WWW optional
      !IR_URL_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL optional
      !I_FIELDNAME_URL type ISH_FIELDNAME optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GA_POPUP_HTML
*"* do not include other source files here!!!

  data GR_URL_MODEL type ref to IF_ISH_GUI_STRUCTURE_MODEL .
  data G_FIELDNAME_URL type ISH_FIELDNAME .
  data G_TITLE_TEXT type STRING .
  data G_URL type N1URL_WWW .

  methods _CMD_ENTER
    redefinition .
  methods _GET_TITLE_TEXT
    redefinition .
  methods _LOAD_POPUP_VIEW
    redefinition .
  methods _DESTROY
    redefinition .
private section.
*"* private components of class CL_ISH_GA_POPUP_HTML
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GA_POPUP_HTML IMPLEMENTATION.


METHOD execute_by_url.

  DATA lr_application                   TYPE REF TO cl_ish_ga_popup_html.

  CREATE OBJECT lr_application.

  TRY.
      lr_application->initialize(
          i_start_row          = i_start_row
          i_start_col          = i_start_col
          i_end_row            = i_end_row
          i_end_col            = i_end_col
          i_title_text         = i_title_text
          i_url                = i_url ).
      lr_application->run( ).
    CLEANUP.
      lr_application->destroy( ).
  ENDTRY.

  lr_application->destroy( ).

ENDMETHOD.


METHOD execute_by_url_model.

  DATA lr_application                   TYPE REF TO cl_ish_ga_popup_html.

  CREATE OBJECT lr_application.

  TRY.
      lr_application->initialize(
          i_start_row     = i_start_row
          i_start_col     = i_start_col
          i_end_row       = i_end_row
          i_end_col       = i_end_col
          i_title_text    = i_title_text
          ir_url_model    = ir_url_model
          i_fieldname_url = i_fieldname_url ).
      lr_application->run( ).
    CLEANUP.
      lr_application->destroy( ).
  ENDTRY.

  lr_application->destroy( ).

ENDMETHOD.


METHOD initialize.

* Initialize self.
  _init_ga_popup(
      i_default_ucomm      = co_ucomm_enter
      i_start_row          = i_start_row
      i_start_col          = i_start_col
      i_end_row            = i_end_row
      i_end_col            = i_end_col ).

* Initialize attributes.
  g_url           = i_url.
  gr_url_model    = ir_url_model.
  g_fieldname_url = i_fieldname_url.
  g_title_text    = i_title_text.  " MED-51956 M.Rebegea 05.09.2013

ENDMETHOD.


METHOD _cmd_enter.

  r_exit = abap_true.

ENDMETHOD.


METHOD _destroy.

  CLEAR gr_url_model.

  super->_destroy( ).

ENDMETHOD.


METHOD _GET_TITLE_TEXT.

  r_title_text = g_title_text.

ENDMETHOD.


METHOD _load_popup_view.

  DATA lr_main_view                       TYPE REF TO if_ish_gui_mdy_view.

  DATA lr_sdycc_ctr                       TYPE REF TO cl_ish_gc_sdy_custcont.
  DATA lr_cc_ctr                          TYPE REF TO if_ish_gui_controller.
  DATA lr_cc_view                         TYPE REF TO if_ish_gui_custcont_view.

  DATA lr_html_ctr                        TYPE REF TO cl_ish_gc_simple.
  DATA lr_html_view                       TYPE REF TO cl_ish_gui_html_view.

  lr_main_view = get_main_view( ).

  lr_sdycc_ctr = cl_ish_gc_sdy_custcont=>create_and_initialize(
      i_element_name          = co_ctrname_popup
      ir_parent_controller    = gr_main_controller
      ir_model                = gr_url_model
      i_vcode                 = g_vcode
      i_viewname_sdy_custcont = co_viewname_popup ).
  lr_cc_ctr   = lr_sdycc_ctr->get_custcont_ctr( ).
  lr_cc_view  = lr_sdycc_ctr->get_custcont_view( ).

  lr_html_ctr = cl_ish_gc_simple=>create( i_element_name = co_ctrname_html ).
  CREATE OBJECT lr_html_view
    EXPORTING
      i_element_name = co_viewname_html.
  lr_html_ctr->initialize(
      ir_parent_controller  = lr_cc_ctr
      ir_view               = lr_html_view
      i_vcode               = g_vcode
      ir_model              = gr_url_model ).
  lr_html_view->initialize(
      ir_controller   = lr_html_ctr
      ir_parent_view  = lr_cc_view
      i_vcode         = g_vcode
      i_fieldname_url = g_fieldname_url
      i_url           = g_url ).

ENDMETHOD.
ENDCLASS.
