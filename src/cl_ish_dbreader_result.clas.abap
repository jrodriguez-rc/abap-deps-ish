class CL_ISH_DBREADER_RESULT definition
  public
  inheriting from CL_ISH_DBOBJECT
  abstract
  create public
  shared memory enabled

  global friends CL_ISH_DBREADER .

*"* public components of class CL_ISH_DBREADER_RESULT
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DBREADER_RESULT type ISH_OBJECT_TYPE value 12167. "#EC NOTEXT

  methods GET_ACTUAL_SORTORDER
    returning
      value(RT_SORTORDER) type ABAP_SORTORDER_TAB .
  methods GET_EMBEDDED_RESULT
    importing
      !I_OBJECT_TYPE type ISH_OBJECT_TYPE
    returning
      value(RR_EMBEDDED_RESULT) type ref to CL_ISH_DBREADER_RESULT .
  methods GET_EMBEDDED_RESULTS
    returning
      value(RT_EMBEDDED_RESULT) type ISH_T_DBREADER_RESULT .
  methods GET_NR_OF_ENTRIES
  abstract
    returning
      value(R_COUNT) type I .
  methods REMOVE_EMBEDDED_RESULT
    importing
      !IR_RESULT type ref to CL_ISH_DBREADER_RESULT
    returning
      value(R_REMOVED) type ISH_ON_OFF .
  methods REMOVE_EMBEDDED_RESULTS
    returning
      value(RT_REMOVED_RESULT) type ISH_T_DBREADER_RESULT .
  methods REMOVE_EMBEDDED_RESULT_BY_TYPE
    importing
      !I_OBJECT_TYPE type ISH_OBJECT_TYPE
    returning
      value(RR_REMOVED_RESULT) type ref to CL_ISH_DBREADER_RESULT .
  methods SORT
  abstract
    importing
      !IT_SORTORDER type ABAP_SORTORDER_TAB .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBREADER_RESULT
*"* do not include other source files here!!!

  data GT_EMBEDDED_RESULT type ISH_T_DBREADER_RESULT .
  data GT_SORTORDER type ABAP_SORTORDER_TAB .

  methods ADD_EMBEDDED_RESULT
    importing
      !IR_RESULT type ref to CL_ISH_DBREADER_RESULT
      !I_REPLACE type ISH_ON_OFF default ON
    returning
      value(RR_REMOVED_RESULT) type ref to CL_ISH_DBREADER_RESULT .
  methods CLEAR .
  methods _SORT
    importing
      !IT_SORTORDER type ABAP_SORTORDER_TAB
    changing
      !CT_ENTRY type ANY TABLE .
private section.
*"* private components of class CL_ISH_DBREADER_RESULT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBREADER_RESULT IMPLEMENTATION.


METHOD add_embedded_result.

  FIELD-SYMBOLS: <lr_existing_result>  TYPE REF TO cl_ish_dbreader_result.

* Initial checking.
  CHECK ir_result IS BOUND.

* Get the maybe existing entry.
  READ TABLE gt_embedded_result
    FROM ir_result
    ASSIGNING <lr_existing_result>.

* Add the embedded result.
  IF sy-subrc = 0.
    CHECK i_replace = on.
    rr_removed_result = <lr_existing_result>.
    <lr_existing_result> = ir_result.
  ELSE.
    INSERT ir_result INTO TABLE gt_embedded_result.
  ENDIF.

ENDMETHOD.


METHOD clear.

  CLEAR: gt_embedded_result,
         gt_sortorder.

ENDMETHOD.


METHOD get_actual_sortorder.

  rt_sortorder = gt_sortorder.

ENDMETHOD.


METHOD get_embedded_result.

  DATA: lr_result  TYPE REF TO cl_ish_dbreader_result.

  LOOP AT gt_embedded_result INTO lr_result.
    CHECK lr_result IS BOUND.
    CHECK lr_result->is_inherited_from( i_object_type ) = on.
    rr_embedded_result = lr_result.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD get_embedded_results.

  rt_embedded_result = gt_embedded_result.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbreader_result.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbreader_result.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD remove_embedded_result.

  r_removed = off.

  CHECK ir_result IS BOUND.

##INDEX_NUM  DELETE gt_embedded_result FROM ir_result.
  CHECK sy-subrc = 0.

  r_removed = on.

ENDMETHOD.


METHOD remove_embedded_results.

  rt_removed_result = gt_embedded_result.

  CLEAR: gt_embedded_result.

ENDMETHOD.


METHOD remove_embedded_result_by_type.

  rr_removed_result = get_embedded_result( i_object_type ).
  CHECK rr_removed_result IS BOUND.

##INDEX_NUM  DELETE gt_embedded_result FROM rr_removed_result.

ENDMETHOD.


METHOD _sort.

  DATA: lr_cx_root  TYPE REF TO cx_root.

* Initial checking.
  CHECK it_sortorder IS NOT INITIAL.
  CHECK ct_entry     IS NOT INITIAL.

* Process only if the sortorder changed.
  CHECK it_sortorder <> gt_sortorder.

* Sort.
  TRY.
      SORT ct_entry BY (it_sortorder).
    CATCH cx_root INTO lr_cx_root.
      RAISE EXCEPTION TYPE cx_ish_no_check_handler
        EXPORTING
          previous = lr_cx_root.
  ENDTRY.

* Set the actual sortorder.
  gt_sortorder = it_sortorder.

ENDMETHOD.
ENDCLASS.
