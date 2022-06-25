class CL_ISH_DBFILTER definition
  public
  inheriting from CL_ISH_DBOBJECT
  final
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBFILTER
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DBFILTER type ISH_OBJECT_TYPE value 12165. "#EC NOTEXT

  methods CLEAR .
  methods EXCL_BT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_LOW type ANY
      !I_HIGH type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods EXCL_EQ
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods EXCL_GE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods EXCL_GT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods EXCL_LE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods EXCL_LT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods EXCL_NE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods GET_RANGE
    importing
      !I_FIELDNAME type FIELDNAME
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods INCL_BT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_LOW type ANY
      !I_HIGH type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods INCL_EQ
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods INCL_GE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods INCL_GT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods INCL_LE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods INCL_LT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods INCL_NE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods IS_EMPTY
    returning
      value(R_EMPTY) type ISH_ON_OFF .
  methods IS_TABENTRY_IN_FILTER
    importing
      !IS_TABENTRY type ANY
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods PROCESS_TABENTRIES
    changing
      !CT_TABENTRY type ANY TABLE .
  methods REMOVE_RANGE
    importing
      !I_FIELDNAME type FIELDNAME
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .
  methods SET_RANGE
    importing
      !I_FIELDNAME type FIELDNAME
      !IR_RANGE type ref to CL_ISH_RANGE
    returning
      value(RR_RANGE) type ref to CL_ISH_RANGE .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBFILTER
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DBFILTER
*"* do not include other source files here!!!

  data GT_RANGE type ISH_T_DBFILTER_RANGE .
ENDCLASS.



CLASS CL_ISH_DBFILTER IMPLEMENTATION.


METHOD clear.

  CLEAR: gt_range.

ENDMETHOD.


METHOD excl_bt.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->excl_bt( i_low  = i_low
                       i_high = i_high ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->excl_bt( i_low  = i_low
                       i_high = i_high ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD excl_eq.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->excl_eq( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->excl_eq( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD excl_ge.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->excl_ge( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->excl_ge( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD excl_gt.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->excl_gt( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->excl_gt( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD excl_le.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->excl_le( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->excl_le( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD excl_lt.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->excl_lt( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->excl_lt( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD excl_ne.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->excl_ne( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->excl_ne( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD get_range.

  FIELD-SYMBOLS: <ls_range>  LIKE LINE OF gt_range.

  READ TABLE gt_range
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_range>.
  CHECK sy-subrc = 0.

  rr_range = <ls_range>-r_range.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbfilter.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbfilter.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD incl_bt.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->incl_bt( i_low  = i_low
                       i_high = i_high ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->incl_bt( i_low  = i_low
                       i_high = i_high ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD incl_eq.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->incl_eq( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->incl_eq( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD incl_ge.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->incl_ge( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->incl_ge( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD incl_gt.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->incl_gt( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->incl_gt( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD incl_le.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->incl_le( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->incl_le( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD incl_lt.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->incl_lt( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->incl_lt( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD incl_ne.

  DATA: ls_range  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe already existing range.
  rr_range = get_range( i_fieldname ).

* If we have already the range -> actualize it.
  IF rr_range IS BOUND.
    rr_range->incl_ne( i_value ).
* If we do not have already the range -> create it.
  ELSE.
    CREATE OBJECT rr_range.
    rr_range->incl_ne( i_value ).
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = rr_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.


METHOD is_empty.

  FIELD-SYMBOLS: <ls_range>  LIKE LINE OF gt_range.

  r_empty = on.

  LOOP AT gt_range ASSIGNING <ls_range>.
    r_empty = <ls_range>-r_range->is_empty( ).
    IF r_empty = off.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD is_tabentry_in_filter.

  FIELD-SYMBOLS: <ls_range>  LIKE LINE OF gt_range,
                 <l_value>   TYPE ANY.

  r_success = on.

  LOOP AT gt_range ASSIGNING <ls_range>.
    ASSIGN COMPONENT <ls_range>-fieldname
      OF STRUCTURE is_tabentry
      TO <l_value>.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_ish_no_check_handler.
    ENDIF.
    r_success = <ls_range>-r_range->is_value_in_range( <l_value> ).
    IF r_success = off.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD process_tabentries.

  DATA: lr_tabledescr  TYPE REF TO cl_abap_tabledescr,
        lr_t_tabentry  TYPE REF TO data.

  FIELD-SYMBOLS: <lt_tabentry>         TYPE ANY TABLE,
                 <lt_tabentry_std>     TYPE STANDARD TABLE,
                 <lt_tabentry_sorted>  TYPE SORTED TABLE,
                 <ls_tabentry>         TYPE ANY.

* Initial checking.
  CHECK ct_tabentry IS NOT INITIAL.

* Determine the table type.
  lr_tabledescr ?= cl_abap_typedescr=>describe_by_data( ct_tabentry ).

* Make assignments.
  CASE lr_tabledescr->table_kind.
*   On standard tables we can directly work with ct_tabentry.
    WHEN cl_abap_tabledescr=>tablekind_std.
      ASSIGN ct_tabentry TO <lt_tabentry>.
      ASSIGN ct_tabentry TO <lt_tabentry_std>.
*   On sorted tables we can directly work with ct_tabentry.
    WHEN cl_abap_tabledescr=>tablekind_sorted.
      ASSIGN ct_tabentry TO <lt_tabentry>.
      ASSIGN ct_tabentry TO <lt_tabentry_sorted>.
*   For all other types of tables we have to copy the matching entries.
*   Therefore create a temporary working table which contains the given data.
*   Matching entries will be copied to ct_tabentry later.
    WHEN OTHERS.
      CREATE DATA lr_t_tabentry TYPE HANDLE lr_tabledescr.
      ASSIGN lr_t_tabentry->* TO <lt_tabentry>.
      <lt_tabentry> = ct_tabentry.
      CLEAR: ct_tabentry.
  ENDCASE.

* Process the tabentries.
  LOOP AT <lt_tabentry> ASSIGNING <ls_tabentry>.
    CASE lr_tabledescr->table_kind.
*     On standard tables just delete non-matching entries.
      WHEN cl_abap_tabledescr=>tablekind_std.
        CHECK is_tabentry_in_filter( <ls_tabentry> ) = off.
        DELETE <lt_tabentry_std>.
*     On sorted tables just delete non-matching entries.
      WHEN cl_abap_tabledescr=>tablekind_sorted.
        CHECK is_tabentry_in_filter( <ls_tabentry> ) = off.
        DELETE <lt_tabentry_sorted>.
*     For all other types of tables insert matching entries.
      WHEN OTHERS.
        CHECK is_tabentry_in_filter( <ls_tabentry> ) = on.
        INSERT <ls_tabentry> INTO TABLE ct_tabentry.
    ENDCASE.
  ENDLOOP.

ENDMETHOD.


METHOD remove_range.

  FIELD-SYMBOLS: <ls_range>  LIKE LINE OF gt_range.

  IF i_fieldname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

  READ TABLE gt_range
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_range>.
  CHECK sy-subrc = 0.

  rr_range = <ls_range>-r_range.

  DELETE TABLE gt_range WITH TABLE KEY fieldname = i_fieldname.

ENDMETHOD.


METHOD set_range.

  DATA: ls_range  LIKE LINE OF gt_range.

  FIELD-SYMBOLS: <ls_range>  LIKE LINE OF gt_range.

* Initial checking.
  IF i_fieldname IS INITIAL OR
     ir_range IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe existing entry.
  READ TABLE gt_range
    WITH TABLE KEY fieldname = i_fieldname
    ASSIGNING <ls_range>.

* If the entry already exists -> actualize it.
  IF sy-subrc = 0.
*   Export the old range.
    rr_range = <ls_range>-r_range.
    <ls_range>-r_range = ir_range.
* If the entry does not already exist -> create it.
  ELSE.
    CLEAR: ls_range.
    ls_range-fieldname = i_fieldname.
    ls_range-r_range   = ir_range.
    INSERT ls_range INTO TABLE gt_range.
  ENDIF.

ENDMETHOD.
ENDCLASS.
