class CL_ISH_FVAR_BUTTON definition
  public
  create protected

  global friends CL_ISH_FVAR .

public section.
*"* public components of class CL_ISH_FVAR_BUTTON
*"* do not include other source files here!!!
  type-pools CNTB .

  type-pools ABAP .
  methods ADD_TO_TOOLBAR
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR
      !I_DISABLED type ABAP_BOOL default ABAP_FALSE
      !I_BUTTONTYPE type TB_BTYPE default -1
    returning
      value(R_ADDED) type ABAP_BOOL .
  methods ADD_TO_TOOLBAR_SET
    importing
      !IR_TOOLBAR_SET type ref to CL_ALV_EVENT_TOOLBAR_SET
      !I_DISABLED type ABAP_BOOL default ABAP_FALSE
      !I_BUTTONTYPE type TB_BTYPE default -1
    returning
      value(R_ADDED) type ABAP_BOOL .
  methods GET_ALL_FUNCTIONS
    returning
      value(RT_FUNCTION) type ISH_T_FVAR_FUNCTION_OBJ .
  methods GET_BUTTONTYPE
    returning
      value(R_BUTTONTYPE) type TB_BTYPE .
  methods GET_DATA
    returning
      value(RS_DATA) type V_NWBUTTON .
  methods GET_DBCLK
    returning
      value(R_DBCLK) type NDBCLK .
  methods GET_FCODE
    returning
      value(R_FCODE) type FCODE .
  methods GET_FKEY
    returning
      value(R_FKEY) type NFKEY .
  methods GET_FUNCTION_BY_FCODE
    importing
      !I_FCODE type ANY
    returning
      value(RR_FUNCTION) type ref to CL_ISH_FVAR_FUNCTION .
  methods GET_FVAR
    returning
      value(RR_FVAR) type ref to CL_ISH_FVAR .
  methods GET_ICON
    returning
      value(R_ICON) type SCRFICON .
  methods GET_NR_OF_FUNCTIONS
    returning
      value(R_NR_OF_FUNCTIONS) type I .
  methods GET_QUICKINFO
    returning
      value(R_QUICKINFO) type SCRFICON_Q .
  methods GET_TEXT
    returning
      value(R_TEXT) type NBUTTONTXT .
  methods HAS_FUNCTIONS
    returning
      value(R_HAS_FUNCTIONS) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_FVAR_BUTTON
*"* do not include other source files here!!!

  data GR_FVAR type ref to CL_ISH_FVAR .
  data GS_DATA type V_NWBUTTON .
  data GT_FUNCTION type ISH_T_FVAR_FUNCTION_OBJ .
private section.
*"* private components of class CL_ISH_FVAR_BUTTON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_FVAR_BUTTON IMPLEMENTATION.


METHOD add_to_toolbar.

  DATA l_fcode              TYPE ui_func.
  DATA l_buttontype         TYPE tb_btype.

  CHECK ir_toolbar IS BOUND.

  l_fcode = get_fcode( ).

  IF i_buttontype < 0.
    l_buttontype = get_buttontype( ).
  ELSE.
    l_buttontype = i_buttontype.
  ENDIF.

  CALL METHOD ir_toolbar->add_button
    EXPORTING
      fcode       = l_fcode
      icon        = gs_data-icon
      butn_type   = l_buttontype
      text        = gs_data-buttontxt
      quickinfo   = gs_data-icon_q
      is_disabled = i_disabled
    EXCEPTIONS
      OTHERS      = 1.
  CHECK sy-subrc = 0.

  r_added = abap_true.

ENDMETHOD.


METHOD add_to_toolbar_set.

  DATA ls_toolbar           TYPE stb_button.

  CHECK ir_toolbar_set IS BOUND.

  ls_toolbar-function     =  gs_data-fcode.
  ls_toolbar-icon         = gs_data-icon.
  IF i_buttontype < 0.
    ls_toolbar-butn_type  = get_buttontype( ).
  ELSE.
    ls_toolbar-butn_type  = i_buttontype.
  ENDIF.
  ls_toolbar-text         = gs_data-buttontxt.
  ls_toolbar-quickinfo    = gs_data-icon_q.
  ls_toolbar-disabled     = i_disabled.
  APPEND ls_toolbar TO ir_toolbar_set->mt_toolbar.

  r_added = abap_true.

ENDMETHOD.


METHOD get_all_functions.

  rt_function = gt_function.

ENDMETHOD.


METHOD get_buttontype.

  IF gs_data-fcode IS INITIAL.
    r_buttontype = cntb_btype_sep.
  ELSEIF has_functions( ) = abap_true.
    r_buttontype = cntb_btype_dropdown.
  ELSE.
    r_buttontype = cntb_btype_button.
  ENDIF.

ENDMETHOD.


METHOD get_data.

  rs_data = gs_data.

ENDMETHOD.


METHOD get_dbclk.

  r_dbclk = gs_data-dbclk.

ENDMETHOD.


METHOD get_fcode.

  r_fcode = gs_data-fcode.

ENDMETHOD.


METHOD get_fkey.

  r_fkey = gs_data-fkey.

ENDMETHOD.


METHOD get_function_by_fcode.

  DATA: lr_function  TYPE REF TO cl_ish_fvar_function,
        l_fcode      TYPE fcode.

  TRY.
      l_fcode = i_fcode.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  LOOP AT gt_function INTO lr_function.
    CHECK lr_function IS BOUND.
    CHECK lr_function->get_fcode( ) = i_fcode.
    rr_function = lr_function.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD get_fvar.

  rr_fvar = gr_fvar.

ENDMETHOD.


METHOD get_icon.

  r_icon = gs_data-icon.

ENDMETHOD.


METHOD get_nr_of_functions.

  r_nr_of_functions = LINES( gt_function ).

ENDMETHOD.


METHOD get_quickinfo.

  r_quickinfo = gs_data-icon_q.

ENDMETHOD.


METHOD get_text.

  r_text = gs_data-buttontxt.

ENDMETHOD.


METHOD has_functions.

  IF get_nr_of_functions( ) > 0.
    r_has_functions = abap_true.
  ELSE.
    r_has_functions = abap_false.
  ENDIF.

ENDMETHOD.
ENDCLASS.
