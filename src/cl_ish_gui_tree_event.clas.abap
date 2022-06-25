class CL_ISH_GUI_TREE_EVENT definition
  public
  inheriting from CL_ISH_GUI_CONTROL_EVENT
  create protected .

public section.
*"* public components of class CL_ISH_GUI_TREE_EVENT
*"* do not include other source files here!!!

  constants CO_FCODE_BUTTON_CLICK type UI_FUNC value 'BUTTON_CLICK'. "#EC NOTEXT
  constants CO_FCODE_DROPDOWN_CLICKED type UI_FUNC value 'DROPDOWN_CLICKED'. "#EC NOTEXT
  constants CO_FCODE_HOTSPOT_CLICK type UI_FUNC value 'HOTSPOT_CLICK'. "#EC NOTEXT
  constants CO_FCODE_ITEM_DOUBLE_CLICK type UI_FUNC value 'ITEM_DOUBLE_CLICK'. "#EC NOTEXT
  constants CO_FCODE_LINK_CLICK type UI_FUNC value 'LINK_CLICK'. "#EC NOTEXT
  constants CO_FCODE_NODE_CTX_REQUEST type UI_FUNC value 'NODE_CTX_REQUEST'. "#EC NOTEXT
  constants CO_FCODE_NODE_DOUBLE_CLICK type UI_FUNC value 'NODE_DOUBLE_CLICK'. "#EC NOTEXT
  constants CO_FCODE_ON_DRAG type UI_FUNC value 'ON_DRAG'. "#EC NOTEXT
  constants CO_FCODE_ON_DRAG_MULTIPLE type UI_FUNC value 'ON_DRAG_MULTIPLE'. "#EC NOTEXT
  constants CO_FCODE_ON_DROP type UI_FUNC value 'ON_DROP'. "#EC NOTEXT

  class-methods CREATE
    importing
      !IR_SENDER type ref to IF_ISH_GUI_TREE_VIEW
      !I_FCODE type UI_FUNC
      !IR_NODE_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_NKEY type LVC_NKEY optional
      !I_COL_FIELDNAME type ISH_FIELDNAME optional
      !IR_DRAGDROPOBJECT type ref to CL_DRAGDROPOBJECT optional
      !IT_NODE_MODEL type ISH_T_GUI_MODEL_OBJ optional
      !IT_NKEY type LVC_T_NKEY optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_TREE_EVENT .
  class-methods CREATE_DROPDOWN_CLICKED
    importing
      !IR_SENDER type ref to IF_ISH_GUI_TREE_VIEW
      !I_FCODE_DDCLICKED type UI_FUNC
      !I_POSX type I
      !I_POSY type I
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_TREE_EVENT .
  class-methods CREATE_NODE_CTX_REQUEST
    importing
      !IR_SENDER type ref to IF_ISH_GUI_TREE_VIEW
      !IR_CTMENU type ref to CL_CTMENU
      !IR_NODE_MODEL type ref to IF_ISH_GUI_MODEL
      !I_NKEY type LVC_NKEY
      !IT_NODE_MODEL type ISH_T_GUI_MODEL_OBJHASH
      !IT_NKEY type LVC_T_NKEY
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GUI_TREE_EVENT .
  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !IR_SENDER type ref to IF_ISH_GUI_TREE_VIEW
      !I_FCODE type UI_FUNC
      !I_STARTUP_ACTION type ABAP_BOOL default ABAP_TRUE
      !IR_NODE_MODEL type ref to IF_ISH_GUI_MODEL optional
      !I_NKEY type LVC_NKEY optional
      !I_COL_FIELDNAME type ISH_FIELDNAME optional
      !IR_DRAGDROPOBJECT type ref to CL_DRAGDROPOBJECT optional
      !IT_NODE_MODEL type ISH_T_GUI_MODEL_OBJ optional
      !IT_NKEY type LVC_T_NKEY optional
      !I_FCODE_DDCLICKED type UI_FUNC optional
      !I_POSX type I optional
      !I_POSY type I optional
      !IR_CTMENU type ref to CL_CTMENU optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_COL_FIELDNAME
    returning
      value(R_COL_FIELDNAME) type ISH_FIELDNAME .
  methods GET_CTMENU
    returning
      value(RR_CTMENU) type ref to CL_CTMENU .
  methods GET_DATA_DDCLICKED
    exporting
      !ER_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !E_FCODE_DDCLICKED type UI_FUNC
      !E_POSX type I
      !E_POSY type I .
  methods GET_DATA_NODE_CTX_REQUEST
    exporting
      !ER_SENDER type ref to IF_ISH_GUI_REQUEST_SENDER
      !ER_CTMENU type ref to CL_CTMENU
      !ER_NODE_MODEL type ref to IF_ISH_GUI_MODEL
      !E_NKEY type LVC_NKEY
      !ET_NODE_MODEL type ISH_T_GUI_MODEL_OBJHASH
      !ET_NKEY type LVC_T_NKEY .
  methods GET_DRAGDROPOBJECT
    returning
      value(RR_DRAGDROPOBJECT) type ref to CL_DRAGDROPOBJECT .
  methods GET_FCODE_DDCLICKED
    returning
      value(R_FCODE_DDCLICKED) type UI_FUNC .
  methods GET_NKEY
    returning
      value(R_NKEY) type LVC_NKEY .
  methods GET_NODE_MODEL
    returning
      value(RR_NODE_MODEL) type ref to IF_ISH_GUI_MODEL .
  methods GET_POSX
    returning
      value(R_POSX) type I .
  methods GET_POSY
    returning
      value(R_POSY) type I .
  methods GET_TREE_VIEW
    returning
      value(RR_TREE_VIEW) type ref to IF_ISH_GUI_TREE_VIEW .
  methods GET_T_NKEY
    returning
      value(RT_NODE_KEY) type LVC_T_NKEY .
  methods GET_T_NODE_MODEL
    returning
      value(RT_NODE_MODEL) type ISH_T_GUI_MODEL_OBJ .
protected section.
*"* protected components of class CL_ISH_GUI_TREE_EVENT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_TREE_EVENT
*"* do not include other source files here!!!

  data GR_CTMENU type ref to CL_CTMENU .
  data GR_DRAGDROPOBJECT type ref to CL_DRAGDROPOBJECT .
  data GR_NODE_MODEL type ref to IF_ISH_GUI_MODEL .
  data GT_NKEY type LVC_T_NKEY .
  data GT_NODE_MODEL type ISH_T_GUI_MODEL_OBJ .
  data G_COL_FIELDNAME type ISH_FIELDNAME .
  data G_FCODE_DDCLICKED type UI_FUNC .
  data G_NKEY type LVC_NKEY .
  data G_POSX type I .
  data G_POSY type I .
ENDCLASS.



CLASS CL_ISH_GUI_TREE_EVENT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      ir_sender         = ir_sender
      i_fcode           = i_fcode
      i_startup_action  = i_startup_action ).

  gr_node_model     = ir_node_model.
  g_nkey            = i_nkey.
  g_col_fieldname   = i_col_fieldname.
  gr_dragdropobject = ir_dragdropobject.
  gt_node_model     = it_node_model.
  gt_nkey           = it_nkey.
  g_fcode_ddclicked = i_fcode_ddclicked.
  g_posx            = i_posx.
  g_posy            = i_posy.
  gr_ctmenu         = ir_ctmenu.

ENDMETHOD.


METHOD create.

  DATA l_startup_action                   TYPE abap_bool.

  CASE i_fcode.
    WHEN co_fcode_on_drop.
      l_startup_action = abap_false.
    WHEN OTHERS.
      l_startup_action = abap_true.
  ENDCASE.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender         = ir_sender
          i_fcode           = i_fcode
          i_startup_action  = l_startup_action
          ir_node_model     = ir_node_model
          i_nkey            = i_nkey
          i_col_fieldname   = i_col_fieldname
          ir_dragdropobject = ir_dragdropobject
          it_node_model     = it_node_model
          it_nkey           = it_nkey.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD CREATE_DROPDOWN_CLICKED.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender         = ir_sender
          i_fcode           = co_fcode_dropdown_clicked
          i_startup_action  = abap_false
          i_fcode_ddclicked = i_fcode_ddclicked
          i_posx            = i_posx
          i_posy            = i_posy.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD create_node_ctx_request.

  DATA lt_node_model            TYPE ish_t_gui_model_obj.

  lt_node_model = it_node_model.

  TRY.
      CREATE OBJECT rr_instance
        EXPORTING
          ir_sender        = ir_sender
          i_fcode          = co_fcode_node_ctx_request
          i_startup_action = abap_false
          ir_node_model    = ir_node_model
          i_nkey           = i_nkey
          it_node_model    = lt_node_model
          it_nkey          = it_nkey
          ir_ctmenu        = ir_ctmenu.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_col_fieldname.

  r_col_fieldname = g_col_fieldname.

ENDMETHOD.


METHOD get_ctmenu.

  rr_ctmenu = gr_ctmenu.

ENDMETHOD.


METHOD get_data_ddclicked.

  er_sender         = get_sender( ).
  e_fcode_ddclicked = g_fcode_ddclicked.
  e_posx            = g_posx.
  e_posy            = g_posy.

ENDMETHOD.


METHOD get_data_node_ctx_request.

  er_sender     = get_sender( ).
  er_ctmenu     = gr_ctmenu.
  er_node_model = gr_node_model.
  e_nkey        = g_nkey.
  et_node_model = gt_node_model.
  et_nkey       = gt_nkey.

ENDMETHOD.


METHOD get_dragdropobject.

  rr_dragdropobject = gr_dragdropobject.

ENDMETHOD.


METHOD get_fcode_ddclicked.

  r_fcode_ddclicked = g_fcode_ddclicked.

ENDMETHOD.


METHOD get_nkey.

  r_nkey = g_nkey.

ENDMETHOD.


METHOD get_node_model.

  rr_node_model = gr_node_model.

ENDMETHOD.


METHOD get_posx.

  r_posx = g_posx.

ENDMETHOD.


METHOD get_posy.

  r_posy = g_posy.

ENDMETHOD.


METHOD get_tree_view.

  TRY.
      rr_tree_view ?= get_control_view( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_t_nkey.

  rt_node_key = gt_nkey.

ENDMETHOD.


METHOD get_t_node_model.

  rt_node_model = gt_node_model.

ENDMETHOD.
ENDCLASS.
