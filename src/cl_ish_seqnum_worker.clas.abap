class CL_ISH_SEQNUM_WORKER definition
  public
  create public .

public section.
*"* public components of class CL_ISH_SEQNUM_WORKER
*"* do not include other source files here!!!

  methods ADJUST_SEQNUMS
    importing
      !IT_OBJECT type ISH_T_OBJECT_HASHED
    returning
      value(RT_CHANGED_OBJECT) type ISH_T_SEQNUM_OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods ADJUST_SEQNUMS_4_APPEND
    importing
      !IT_OBJECT type ISH_T_OBJECT_HASHED
      !IR_PREV_OBJECT type ref to OBJECT optional
    exporting
      value(ET_CHANGED_OBJECT) type ISH_T_SEQNUM_OBJECT
      value(E_SEQNUM) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods ADJUST_SEQNUMS_4_PREPEND
    importing
      !IT_OBJECT type ISH_T_OBJECT_HASHED
      !IR_NEXT_OBJECT type ref to OBJECT optional
    exporting
      value(ET_CHANGED_OBJECT) type ISH_T_SEQNUM_OBJECT_HASHED
      value(E_SEQNUM) type I
    raising
      CX_ISH_STATIC_HANDLER .
  methods CB_SET_SEQNUM
  final
    importing
      !IR_OBJECT type ref to OBJECT
    raising
      CX_ISH_STATIC_HANDLER .
  methods SORT_OBJECT_TABLE
    importing
      !IT_OBJECT type ISH_T_OBJECT_HASHED
    returning
      value(RT_OBJECT) type ISH_T_SEQNUM_OBJECT_HASHED .
protected section.
*"* protected components of class CL_ISH_SEQNUM_WORKER
*"* do not include other source files here!!!

  type-pools ABAP .
  methods _SET_SEQNUM
  final
    importing
      !IR_OBJECT type ref to IF_ISH_SEQNUM_OBJECT
      !I_SEQNUM type I
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_SEQNUM_WORKER
*"* do not include other source files here!!!

  data GR_OBJ4CB type ref to OBJECT .
ENDCLASS.



CLASS CL_ISH_SEQNUM_WORKER IMPLEMENTATION.


METHOD adjust_seqnums.

  DATA lr_object                  TYPE REF TO object.
  DATA lr_seqnum_object           TYPE REF TO if_ish_seqnum_object.
  DATA l_seqnum                   TYPE i.

  LOOP AT it_object INTO lr_object.
    CHECK lr_object IS BOUND.
    TRY.
        lr_seqnum_object ?= lr_object.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    l_seqnum = l_seqnum + 1.
    CHECK _set_seqnum(
        ir_object = lr_seqnum_object
        i_seqnum  = l_seqnum ) = abap_true.
    INSERT lr_seqnum_object INTO TABLE rt_changed_object.
  ENDLOOP.

ENDMETHOD.


METHOD adjust_seqnums_4_append.

  DATA lr_object            TYPE REF TO object.
  DATA lr_seqnum_object     TYPE REF TO if_ish_seqnum_object.
  DATA l_seqnum             TYPE i.
  DATA l_set_seqnum         TYPE abap_bool.

  CLEAR et_changed_object.
  CLEAR e_seqnum.

  LOOP AT it_object INTO lr_object.
    CHECK lr_object IS BOUND.
    TRY.
        lr_seqnum_object ?= lr_object.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    IF l_set_seqnum = abap_true.
      l_seqnum = l_seqnum + 2.
      e_seqnum = l_seqnum - 1.
    ELSE.
      l_seqnum = l_seqnum + 1.
    ENDIF.
    IF lr_object = ir_prev_object.
      l_set_seqnum = abap_true.
    ENDIF.
    CHECK _set_seqnum(
        ir_object = lr_seqnum_object
        i_seqnum  = l_seqnum ) = abap_true.
    INSERT lr_seqnum_object INTO TABLE et_changed_object.
  ENDLOOP.

  IF e_seqnum IS INITIAL.
    e_seqnum = l_seqnum + 1.
  ENDIF.

ENDMETHOD.


METHOD adjust_seqnums_4_prepend.

  DATA lr_next_seqnum_object      TYPE REF TO if_ish_seqnum_object.
  DATA lr_object                  TYPE REF TO object.
  DATA lr_seqnum_object           TYPE REF TO if_ish_seqnum_object.
  DATA l_seqnum                   TYPE i.

  CLEAR et_changed_object.
  CLEAR e_seqnum.

  TRY.
      lr_next_seqnum_object ?= ir_next_object.
    CATCH cx_sy_move_cast_error.
      CLEAR lr_next_seqnum_object.
  ENDTRY.
  READ TABLE it_object
    WITH TABLE KEY table_line = lr_next_seqnum_object
    TRANSPORTING NO FIELDS.
  IF sy-subrc <> 0.
    e_seqnum = 1.
    l_seqnum = 1.
  ENDIF.

  LOOP AT it_object INTO lr_object.
    CHECK lr_object IS BOUND.
    TRY.
        lr_seqnum_object ?= lr_object.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    IF lr_object = ir_next_object.
      l_seqnum = l_seqnum + 2.
      e_seqnum = l_seqnum - 1.
    ELSE.
      l_seqnum = l_seqnum + 1.
    ENDIF.
    CHECK _set_seqnum(
        ir_object = lr_seqnum_object
        i_seqnum  = l_seqnum ) = abap_true.
    INSERT lr_seqnum_object INTO TABLE et_changed_object.
  ENDLOOP.

ENDMETHOD.


METHOD cb_set_seqnum.

  IF ir_object <> gr_obj4cb.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CB_SET_SEQNUM'
        i_mv3        = 'CL_ISH_SEQNUM_WORKER' ).
  ENDIF.

ENDMETHOD.


METHOD sort_object_table.

  TYPES:
    BEGIN OF lty_sort,
      seqnum        TYPE i,
      r_seqnum_obj  TYPE REF TO if_ish_seqnum_object,
    END OF lty_sort.

  DATA lr_object              TYPE REF TO object.
  DATA lr_seqnum_object       TYPE REF TO if_ish_seqnum_object.
  DATA ls_sort                TYPE lty_sort.
  DATA lt_sort                TYPE TABLE OF lty_sort.

  FIELD-SYMBOLS <ls_sort>     TYPE lty_sort.

  LOOP AT it_object INTO lr_object.
    CHECK lr_object IS BOUND.
    TRY.
        ls_sort-r_seqnum_obj ?= lr_object.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    ls_sort-seqnum = ls_sort-r_seqnum_obj->get_seqnum( ).
    INSERT ls_sort INTO TABLE lt_sort.
  ENDLOOP.

  SORT lt_sort BY seqnum.

  LOOP AT lt_sort ASSIGNING <ls_sort>.
    INSERT <ls_sort>-r_seqnum_obj INTO TABLE rt_object.
  ENDLOOP.

ENDMETHOD.


METHOD _set_seqnum.

  CHECK ir_object IS BOUND.

  gr_obj4cb = ir_object.
  TRY.
      r_changed = ir_object->set_seqnum( i_seqnum = i_seqnum ).
    CLEANUP.
      CLEAR gr_obj4cb.
  ENDTRY.
  CLEAR gr_obj4cb.

ENDMETHOD.
ENDCLASS.
