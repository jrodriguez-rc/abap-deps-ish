class CL_ISH_FVAR definition
  public
  create protected

  global friends CL_ISH_FVAR_MGR .

public section.
*"* public components of class CL_ISH_FVAR
*"* do not include other source files here!!!

  methods ADD_TO_TOOLBAR
    importing
      !IR_TOOLBAR type ref to CL_GUI_TOOLBAR .
  methods GET_ALL_BUTTONS
    returning
      value(RT_BUTTON) type ISH_T_FVAR_BUTTON_OBJ .
  methods GET_BUTTON_BY_FCODE
    importing
      !I_FCODE type ANY
    returning
      value(RR_BUTTON) type ref to CL_ISH_FVAR_BUTTON .
  methods GET_ID
    returning
      value(R_ID) type NFVARID .
  methods GET_T_FCODE
    returning
      value(RT_FCODE) type ISH_T_FCODE_HASH .
  methods GET_VIEWTYPE
    returning
      value(R_VIEWTYPE) type NVIEWTYPE .
  type-pools ABAP .
  methods HAS_FCODE
    importing
      !I_FCODE type UI_FUNC
    returning
      value(R_HAS_FCODE) type ABAP_BOOL .
  methods RELOAD
    raising
      CX_ISH_FVAR .
protected section.
*"* protected components of class CL_ISH_FVAR
*"* do not include other source files here!!!

  data GT_BUTTON type ISH_T_FVAR_BUTTON_OBJ .
  data GT_FCODE type ISH_T_FCODE_HASH .
  data G_ID type NFVARID .
  data G_VIEWTYPE type NVIEWTYPE .

  class-methods LOAD
    importing
      !I_VIEWTYPE type NVIEWTYPE
      !I_ID type NFVARID
    returning
      value(RR_FVAR) type ref to CL_ISH_FVAR
    raising
      CX_ISH_FVAR .
  methods _LOAD_ALL_BUTTONS
    raising
      CX_ISH_FVAR .
  methods _LOAD_ALL_FCODES .
private section.
*"* private components of class CL_ISH_FVAR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_FVAR IMPLEMENTATION.


METHOD add_to_toolbar.

  DATA lr_button            TYPE REF TO cl_ish_fvar_button.
  DATA ls_stb_button        TYPE stb_button.

  CHECK ir_toolbar IS BOUND.

  LOOP AT gt_button INTO lr_button.
    CHECK lr_button IS BOUND.
    lr_button->add_to_toolbar( ir_toolbar = ir_toolbar ).
  ENDLOOP.

ENDMETHOD.


METHOD get_all_buttons.

  rt_button = gt_button.

ENDMETHOD.


METHOD get_button_by_fcode.

  DATA: lr_button  TYPE REF TO cl_ish_fvar_button,
        l_fcode    TYPE fcode.

  TRY.
      l_fcode = i_fcode.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  LOOP AT gt_button INTO lr_button.
    CHECK lr_button IS BOUND.
    CHECK lr_button->get_fcode( ) = i_fcode.
    rr_button = lr_button.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD get_id.

  r_id = g_id.

ENDMETHOD.


METHOD get_t_fcode.

  IF gt_fcode IS INITIAL.
    _load_all_fcodes( ).
  ENDIF.

  rt_fcode = gt_fcode.

ENDMETHOD.


METHOD get_viewtype.

  r_viewtype = g_viewtype.

ENDMETHOD.


METHOD has_fcode.

  _load_all_fcodes( ).

  READ TABLE gt_fcode WITH TABLE KEY table_line = i_fcode TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_fcode = abap_true.

ENDMETHOD.


METHOD load.

* Instantiate the fvar object.
  CREATE OBJECT rr_fvar.
  rr_fvar->g_viewtype = i_viewtype.
  rr_fvar->g_id       = i_id.

* Load the buttons.
  rr_fvar->_load_all_buttons( ).

ENDMETHOD.


METHOD reload.

  DATA lt_button            LIKE gt_button.

* Remind the actual buttons.
* In case of errors we have to reset the buttons.
  lt_button = gt_button.

* Load the buttons.
  TRY.
      _load_all_buttons( ).
    CLEANUP.
      gt_button = lt_button.
  ENDTRY.

* Clear the fcodes.
* The fcodes will be reloaded on demand.
  CLEAR gt_fcode.

ENDMETHOD.


METHOD _load_all_buttons.

  DATA: lt_fvar          TYPE TABLE OF v_nwfvar,
        lt_fvarp         TYPE ish_t_v_nwfvarp,
        lt_button        TYPE ish_t_v_nwbutton,
        lt_bapiret2      TYPE TABLE OF bapiret2,
        lr_button        TYPE REF TO cl_ish_fvar_button,
        lr_function      TYPE REF TO cl_ish_fvar_function,
        l_rc             TYPE ish_method_rc,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS: <ls_bapiret2>  LIKE LINE OF lt_bapiret2,
                 <ls_button>    LIKE LINE OF lt_button,
                 <ls_fvarp>     LIKE LINE OF lt_fvarp.

* Clear the buttons.
  CLEAR gt_button.

* Get fvar data.
  CALL FUNCTION 'ISHMED_VM_FVAR_GET'
    EXPORTING
      i_viewtype   = g_viewtype
      i_fvariantid = g_id
    IMPORTING
      e_rc         = l_rc
    TABLES
      t_fvar       = lt_fvar
      t_fvarp      = lt_fvarp
      t_button     = lt_button
      t_messages   = lt_bapiret2.
  IF l_rc <> 0.
    LOOP AT lt_bapiret2 ASSIGNING <ls_bapiret2>.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_bapiret
        EXPORTING
          i_bapiret       = <ls_bapiret2>
        CHANGING
          cr_errorhandler = lr_errorhandler.
    ENDLOOP.
    RAISE EXCEPTION TYPE cx_ish_fvar
      EXPORTING
        gr_errorhandler = lr_errorhandler
        g_viewtype      = g_viewtype
        g_fvarid        = g_id.
  ENDIF.

* Instantiate and register the button and function objects.
  LOOP AT lt_button ASSIGNING <ls_button>.
*   Instantiate and initialize the button.
    CREATE OBJECT lr_button.
    lr_button->gr_fvar = me.
    lr_button->gs_data = <ls_button>.
*   Register the button.
    APPEND lr_button TO gt_button.
*   Process the functions for the button.
    LOOP AT lt_fvarp ASSIGNING <ls_fvarp>.
      CHECK <ls_fvarp>-buttonnr = <ls_button>-buttonnr.
*     Instantiate and initialize the function.
      CREATE OBJECT lr_function.
      lr_function->gr_button = lr_button.
      lr_function->gs_data   = <ls_fvarp>.
*     Register the function at the button.
      APPEND lr_function TO lr_button->gt_function.
      DELETE lt_fvarp.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD _load_all_fcodes.

  DATA l_fcode              TYPE ui_func.
  DATA lr_button            TYPE REF TO cl_ish_fvar_button.
  DATA lt_function          TYPE ish_t_fvar_function_obj.
  DATA lr_function          TYPE REF TO cl_ish_fvar_function.

  CHECK gt_fcode IS INITIAL.

  LOOP AT gt_button INTO lr_button.
    CHECK lr_button IS BOUND.
    l_fcode = lr_button->get_fcode( ).
    CHECK l_fcode IS NOT INITIAL.
    INSERT l_fcode INTO TABLE gt_fcode.
    lt_function = lr_button->get_all_functions( ).
    LOOP AT lt_function INTO lr_function.
      CHECK lr_function IS BOUND.
      l_fcode = lr_function->get_fcode( ).
      CHECK l_fcode IS NOT INITIAL.
      INSERT l_fcode INTO TABLE gt_fcode.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
