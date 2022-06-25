class CL_ISH_BOCACHE definition
  public
  create public .

public section.
*"* public components of class CL_ISH_BOCACHE
*"* do not include other source files here!!!

  methods CLEANUP .
  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !IT_BO type ISH_T_BO_OBJH optional
      !I_REGISTER_STRONG type ABAP_BOOL default ABAP_FALSE .
  methods DEREGISTER_ALL_BO .
  methods DEREGISTER_BO
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT .
  methods GET_BO_BY_ID
    importing
      !I_ID type N1BOID
      !I_IGNORE_DESTROYED_BO type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_BO) type ref to IF_ISH_BUSINESS_OBJECT .
  methods GET_T_BO
    importing
      !I_IGNORE_DESTROYED_BO type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_BO) type ISH_T_BO_OBJH .
  methods REGISTER_BO
    importing
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
      !I_STRONG type ABAP_BOOL default ABAP_FALSE .
protected section.
*"* protected components of class CL_ISH_BOCACHE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_BOCACHE
*"* do not include other source files here!!!

  data GT_BO type ISH_T_BO_OBJH .
  data GT_CACHE type ISH_T_BOCACHE_OBJIDH .
ENDCLASS.



CLASS CL_ISH_BOCACHE IMPLEMENTATION.


METHOD cleanup.

  DATA lt_id2delete                   TYPE ish_t_boid_h.

  FIELD-SYMBOLS <ls_cache>            LIKE LINE OF gt_cache.
  FIELD-SYMBOLS <l_id>                TYPE n1boid.

  deregister_all_bo( ).

  cl_abap_memory_utilities=>do_garbage_collection( ).

  LOOP AT gt_cache ASSIGNING <ls_cache>.
    CHECK get_bo_by_id( <ls_cache>-id ) IS NOT BOUND.
    INSERT <ls_cache>-id INTO TABLE lt_id2delete.
  ENDLOOP.

  LOOP AT lt_id2delete ASSIGNING <l_id>.
    DELETE TABLE gt_cache
      WITH TABLE KEY id = <l_id>.
  ENDLOOP.

ENDMETHOD.


METHOD constructor.

  DATA lr_bo              TYPE REF TO if_ish_business_object.

  super->constructor( ).

  LOOP AT it_bo INTO lr_bo.
    register_bo(
        ir_bo     = lr_bo
        i_strong  = i_register_strong ).
  ENDLOOP.

ENDMETHOD.


METHOD deregister_all_bo.

  CLEAR gt_bo.

ENDMETHOD.


METHOD deregister_bo.

  CHECK ir_bo IS BOUND.

  DELETE TABLE gt_bo WITH TABLE KEY table_line = ir_bo.

ENDMETHOD.


METHOD get_bo_by_id.

  FIELD-SYMBOLS <ls_cache>            LIKE LINE OF gt_cache.

  READ TABLE gt_cache
    WITH TABLE KEY id = i_id
    ASSIGNING <ls_cache>.
  CHECK sy-subrc = 0.

  rr_bo ?= <ls_cache>-r_obj->get( ).
  IF rr_bo IS NOT BOUND.
    DELETE TABLE gt_cache
      WITH TABLE KEY id = i_id.
    RETURN.
  ENDIF.

  DO 1 TIMES.
    CHECK i_ignore_destroyed_bo = abap_true.
    CHECK rr_bo->is_destroyed( ) = abap_true.
    DELETE TABLE gt_cache
      WITH TABLE KEY id = i_id.
    DELETE TABLE gt_bo
      WITH TABLE KEY table_line = rr_bo.
    CLEAR rr_bo.
  ENDDO.

ENDMETHOD.


METHOD get_t_bo.

  DATA lr_bo                          TYPE REF TO if_ish_business_object.

  FIELD-SYMBOLS <ls_cache>            LIKE LINE OF gt_cache.

  LOOP AT gt_cache ASSIGNING <ls_cache>.
    lr_bo = get_bo_by_id(
        i_id                  = <ls_cache>-id
        i_ignore_destroyed_bo = i_ignore_destroyed_bo ).
    CHECK lr_bo IS BOUND.
    INSERT lr_bo INTO TABLE rt_bo.
  ENDLOOP.

ENDMETHOD.


METHOD register_bo.

  DATA ls_cache           LIKE LINE OF gt_cache.

  CHECK ir_bo IS BOUND.

* Register weak.
  ls_cache-id = ir_bo->get_boid( ).
  CREATE OBJECT ls_cache-r_obj
    EXPORTING
      oref = ir_bo.
  INSERT ls_cache INTO TABLE gt_cache.

* Register strong.
  IF i_strong = abap_true.
    INSERT ir_bo INTO TABLE gt_bo.
  ENDIF.

ENDMETHOD.
ENDCLASS.
