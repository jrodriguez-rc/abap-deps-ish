class CL_ISH_GA_COMPCON_SIMPLE definition
  public
  inheriting from CL_ISH_GA_COMPCON
  create public .

public section.
*"* public components of class CL_ISH_GA_COMPCON_SIMPLE
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !IR_GM_COMPCON type ref to CL_ISH_GM_COMPCON .
  methods INITIALIZE
    importing
      !IR_LAYOUT type ref to CL_ISH_GUI_APPL_LAYOUT optional
      !I_VCODE type ISH_VCODE default IF_ISH_GUI_VIEW=>CO_VCODE_DISPLAY
      !I_MDY_REPID type SYREPID optional
      !I_MDY_DYNNR type SYDYNNR optional
      !I_MDY_DYNPSTRUCT_NAME type TABNAME optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GA_COMPCON_SIMPLE
*"* do not include other source files here!!!

  data G_MDY_DYNNR type SYDYNNR .
  data G_MDY_DYNPSTRUCT_NAME type TABNAME .
  data G_MDY_REPID type SYREPID .

  methods _GET_MDY_DYNNR
    redefinition .
  methods _GET_MDY_DYNPSTRUCT_NAME
    redefinition .
  methods _GET_MDY_REPID
    redefinition .
private section.
*"* private components of class CL_ISH_GA_COMPCON_SIMPLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GA_COMPCON_SIMPLE IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable
      ir_gm_compcon     = ir_gm_compcon ).

ENDMETHOD.


METHOD initialize.

  _initialize(
      ir_layout = ir_layout
      i_vcode   = i_vcode ).

  g_mdy_repid           = i_mdy_repid.
  g_mdy_dynnr           = i_mdy_dynnr.
  g_mdy_dynpstruct_name = i_mdy_dynpstruct_name.

ENDMETHOD.


METHOD _get_mdy_dynnr.

  r_dynnr = g_mdy_dynnr.

ENDMETHOD.


METHOD _get_mdy_dynpstruct_name.

  r_dynpstruct_name = g_mdy_dynpstruct_name.

ENDMETHOD.


METHOD _get_mdy_repid.

  r_repid = g_mdy_repid.

ENDMETHOD.
ENDCLASS.
