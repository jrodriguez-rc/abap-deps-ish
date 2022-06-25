class CL_ISH_FVAR_FUNCTION definition
  public
  create protected

  global friends CL_ISH_FVAR .

public section.
*"* public components of class CL_ISH_FVAR_FUNCTION
*"* do not include other source files here!!!

  type-pools ABAP .
  methods ADD_TO_CTMENU
    importing
      !IR_CTMENU type ref to CL_CTMENU
      !I_DISABLED type ABAP_BOOL default ABAP_FALSE .
  methods GET_BUTTON
    returning
      value(RR_BUTTON) type ref to CL_ISH_FVAR_BUTTON .
  methods GET_DATA
    returning
      value(RS_DATA) type V_NWFVARP .
  methods GET_DBCLK
    returning
      value(R_DBCLK) type NDBCLK .
  methods GET_FCODE
    returning
      value(R_FCODE) type FCODE .
  methods GET_FKEY
    returning
      value(R_FKEY) type NFKEY .
  methods GET_FVAR
    returning
      value(RR_FVAR) type ref to CL_ISH_FVAR .
  methods GET_TEXT
    returning
      value(R_TEXT) type NFVARPTTXT .
  methods GET_TEXT40
    returning
      value(R_TEXT40) type GUI_TEXT .
protected section.
*"* protected components of class CL_ISH_FVAR_FUNCTION
*"* do not include other source files here!!!

  data GR_BUTTON type ref to CL_ISH_FVAR_BUTTON .
  data GS_DATA type V_NWFVARP .
private section.
*"* private components of class CL_ISH_FVAR_FUNCTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_FVAR_FUNCTION IMPLEMENTATION.


METHOD add_to_ctmenu.

  DATA l_fcode            TYPE ui_func.
  DATA l_text             TYPE gui_text.

  CHECK ir_ctmenu IS BOUND.

  l_fcode = get_fcode( ).
  l_text  = get_text( ).

  ir_ctmenu->add_function(
      fcode     = l_fcode
      text      = l_text
      disabled  = i_disabled ).

ENDMETHOD.


METHOD get_button.

  rr_button = gr_button.

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


METHOD get_fvar.

  CHECK gr_button IS BOUND.

  rr_fvar = gr_button->get_fvar( ).

ENDMETHOD.


METHOD get_text.

  r_text = gs_data-txt.

ENDMETHOD.


METHOD get_text40.

  r_text40 = gs_data-txt.

ENDMETHOD.
ENDCLASS.
