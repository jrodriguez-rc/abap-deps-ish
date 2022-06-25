class CL_ISH_BOFUNCSNAPHANDLER definition
  public
  final
  create private .

public section.
*"* public components of class CL_ISH_BOFUNCSNAPHANDLER
*"* do not include other source files here!!!

  class-methods NEW_INSTANCE
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    returning
      value(RR_INSTANCE) type ref to CL_ISH_BOFUNCSNAPHANDLER
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods END
    importing
      !I_SUCCESS type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ACTUAL_FCODE
    returning
      value(R_FCODE) type UI_FUNC .
  methods GET_BO
    returning
      value(RR_BO) type ref to IF_ISH_BUSINESS_OBJECT .
  methods GET_FIRST_FCODE
    returning
      value(R_FCODE) type UI_FUNC .
  methods IS_PENDING
    returning
      value(R_PENDING) type ABAP_BOOL .
  methods START
    importing
      !I_FCODE type UI_FUNC
      !I_FORCE_SNAPSHOT type ABAP_BOOL default ABAP_FALSE
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_BOFUNCSNAPHANDLER
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_BOFUNCSNAPHANDLER
*"* do not include other source files here!!!

  data GR_BO type ref to IF_ISH_BUSINESS_OBJECT .
  data GT_FCODE_SNAPKEY type ISH_T_FCODE_SNAPKEY .

  methods ON_BO_DESTROYED
    for event EV_AFTER_DESTROY of IF_ISH_DESTROYABLE
    importing
      !SENDER .
  methods _CHECK_DESTROYED
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY .
ENDCLASS.



CLASS CL_ISH_BOFUNCSNAPHANDLER IMPLEMENTATION.


METHOD constructor.

  IF ir_bo IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_BOFUNCSNAPHANDLER' ).
  ENDIF.

  gr_bo = ir_bo.

  SET HANDLER on_bo_destroyed FOR gr_bo ACTIVATION abap_true.

ENDMETHOD.


METHOD end.

  DATA l_idx                            TYPE i.
  DATA ls_fcode_snapkey                 LIKE LINE OF gt_fcode_snapkey.
  DATA lx_static                        TYPE REF TO cx_ish_static_handler.

  _check_destroyed( ).

  READ TABLE gt_fcode_snapkey INDEX 1 INTO ls_fcode_snapkey.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'END'
        i_mv3        = 'CL_ISH_BOFUNCSNAPHANDLER' ).
  ENDIF.

  DELETE gt_fcode_snapkey TO 1.

  IF ls_fcode_snapkey-snapkey IS NOT INITIAL.
    IF i_success = abap_true.
      gr_bo->clear_snapshot( ls_fcode_snapkey-snapkey ).
    ELSE.
      TRY.
          gr_bo->undo( ls_fcode_snapkey-snapkey ).
        CATCH cx_ish_static_handler INTO lx_static.
          gr_bo->invalidate( ir_messages = lx_static->gr_errorhandler ).
          RAISE EXCEPTION lx_static.
      ENDTRY.
    ENDIF.
  ENDIF.

  r_snapkey = ls_fcode_snapkey-snapkey.

ENDMETHOD.


METHOD get_actual_fcode.

  FIELD-SYMBOLS <ls_fcode_snapkey>          LIKE LINE OF gt_fcode_snapkey.

  READ TABLE gt_fcode_snapkey INDEX 1 ASSIGNING <ls_fcode_snapkey>.
  CHECK sy-subrc = 0.

  r_fcode = <ls_fcode_snapkey>-fcode.

ENDMETHOD.


METHOD get_bo.

  rr_bo = gr_bo.

ENDMETHOD.


METHOD get_first_fcode.

  DATA l_idx                            TYPE i.

  FIELD-SYMBOLS <ls_fcode_snapkey>      LIKE LINE OF gt_fcode_snapkey.

  l_idx = lines( gt_fcode_snapkey ).
  CHECK l_idx > 0.

  READ TABLE gt_fcode_snapkey INDEX l_idx ASSIGNING <ls_fcode_snapkey>.
  CHECK sy-subrc = 0.

  r_fcode = <ls_fcode_snapkey>.

ENDMETHOD.


METHOD is_pending.

  IF gt_fcode_snapkey IS NOT INITIAL.
    r_pending = abap_true.
  ENDIF.

ENDMETHOD.


METHOD new_instance.

  CREATE OBJECT rr_instance
    EXPORTING
      ir_bo = ir_bo.

ENDMETHOD.


METHOD on_bo_destroyed.

  CHECK sender IS BOUND.
  CHECK sender = gr_bo.

  _destroy( ).

ENDMETHOD.


METHOD start.

  DATA ls_fcode_snapkey         LIKE LINE OF gt_fcode_snapkey.

  _check_destroyed( ).

  IF i_fcode IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'START'
        i_mv3        = 'CL_ISH_BOFUNCSNAPHANDLER' ).
  ENDIF.

  ls_fcode_snapkey-fcode = i_fcode.
  IF i_force_snapshot = abap_true OR
     is_pending( ) = abap_false.
    ls_fcode_snapkey-snapkey = gr_bo->snapshot( ).
  ENDIF.

  INSERT ls_fcode_snapkey INTO gt_fcode_snapkey INDEX 1.

  r_snapkey = ls_fcode_snapkey-snapkey.

ENDMETHOD.


METHOD _check_destroyed.

  IF gr_bo IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CHECK_DESTROYED'
        i_mv3        = 'CL_ISH_BOFUNCSNAPHANDLER' ).
  ENDIF.

ENDMETHOD.


METHOD _destroy.

  CLEAR gt_fcode_snapkey.

  IF gr_bo IS BOUND.
    SET HANDLER on_bo_destroyed FOR gr_bo ACTIVATION abap_false.
    CLEAR gr_bo.
  ENDIF.

ENDMETHOD.
ENDCLASS.
