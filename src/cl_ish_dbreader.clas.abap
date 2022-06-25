class CL_ISH_DBREADER definition
  public
  inheriting from CL_ISH_DBOBJECT
  abstract
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBREADER
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DBREADER type ISH_OBJECT_TYPE value 12166. "#EC NOTEXT

  class-methods SELECT_COUNT
    importing
      !I_TABNAME type TABNAME
      !IR_CRIT type ref to CL_ISH_DBCRITERION optional
    returning
      value(R_COUNT) type I .
  class-methods SELECT_TABENTRIES
    importing
      !I_TABNAME type TABNAME
      !IR_CRIT type ref to CL_ISH_DBCRITERION optional
      !IR_FILTER type ref to CL_ISH_DBFILTER optional
    changing
      !CT_TABENTRY type ANY TABLE .
  methods DESTROY .
  methods EXECUTE
    importing
      !I_REUSE_RESULT type ISH_ON_OFF default OFF
    returning
      value(RR_RESULT) type ref to CL_ISH_DBREADER_RESULT .
  methods GET_CRIT
    importing
      !I_TABNAME type TABNAME
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRITERION .
  methods GET_FILTER
    importing
      !I_TABNAME type TABNAME
    returning
      value(RR_FILTER) type ref to CL_ISH_DBFILTER .
  methods GET_RESULT
    returning
      value(RR_RESULT) type ref to CL_ISH_DBREADER_RESULT .
  methods REMOVE_CRIT
    importing
      !I_TABNAME type TABNAME
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRITERION .
  methods REMOVE_FILTER
    importing
      !I_TABNAME type TABNAME
    returning
      value(RR_FILTER) type ref to CL_ISH_DBFILTER .
  methods SET_CRIT
    importing
      !I_TABNAME type TABNAME
      !IR_CRIT type ref to CL_ISH_DBCRITERION
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRITERION .
  methods SET_FILTER
    importing
      !I_TABNAME type TABNAME
      !IR_FILTER type ref to CL_ISH_DBFILTER
    returning
      value(RR_FILTER) type ref to CL_ISH_DBFILTER .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBREADER
*"* do not include other source files here!!!

  data GR_RESULT type ref to CL_ISH_DBREADER_RESULT .
  data GT_CRIT type ISH_T_DBR_CRIT .
  data GT_FILTER type ISH_T_DBR_FILTER .

  methods _EXECUTE
  abstract
    returning
      value(RR_RESULT) type ref to CL_ISH_DBREADER_RESULT .
  methods _REEXECUTE
  abstract
    importing
      !IR_RESULT type ref to CL_ISH_DBREADER_RESULT .
private section.
*"* private components of class CL_ISH_DBREADER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBREADER IMPLEMENTATION.


METHOD destroy.

  CLEAR: gr_result,
         gt_crit,
         gt_filter.

ENDMETHOD.


METHOD execute.

  IF i_reuse_result = off.
    CLEAR: gr_result.
  ELSE.
    IF gr_result IS BOUND.
      gr_result->clear( ).
    ENDIF.
  ENDIF.

  IF gr_result IS NOT BOUND.
    gr_result = _execute( ).
  ELSE.
    _reexecute( gr_result ).
  ENDIF.

  rr_result = gr_result.

ENDMETHOD.


METHOD get_crit.

  FIELD-SYMBOLS: <ls_crit>  LIKE LINE OF gt_crit.

  READ TABLE gt_crit
    WITH TABLE KEY tabname = i_tabname
    ASSIGNING <ls_crit>.
  CHECK sy-subrc = 0.

  rr_crit = <ls_crit>-r_crit.

ENDMETHOD.


METHOD get_filter.

  FIELD-SYMBOLS: <ls_filter>  LIKE LINE OF gt_filter.

  READ TABLE gt_filter
    WITH TABLE KEY tabname = i_tabname
    ASSIGNING <ls_filter>.
  CHECK sy-subrc = 0.

  rr_filter = <ls_filter>-r_filter.

ENDMETHOD.


METHOD get_result.

  rr_result = gr_result.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbreader.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbreader.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD remove_crit.

  FIELD-SYMBOLS: <ls_crit>  LIKE LINE OF gt_crit.

  IF i_tabname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

  READ TABLE gt_crit
    WITH TABLE KEY tabname = i_tabname
    ASSIGNING <ls_crit>.
  CHECK sy-subrc = 0.

  rr_crit = <ls_crit>-r_crit.

  DELETE TABLE gt_crit WITH TABLE KEY tabname = i_tabname.

ENDMETHOD.


METHOD remove_filter.

  FIELD-SYMBOLS: <ls_filter>  LIKE LINE OF gt_filter.

  IF i_tabname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

  READ TABLE gt_filter
    WITH TABLE KEY tabname = i_tabname
    ASSIGNING <ls_filter>.
  CHECK sy-subrc = 0.

  rr_filter = <ls_filter>-r_filter.

  DELETE TABLE gt_filter WITH TABLE KEY tabname = i_tabname.

ENDMETHOD.


METHOD select_count.

  DATA: l_where  TYPE string.

* Initial checking.
  IF i_tabname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the where statement.
  IF ir_crit IS BOUND.
    l_where = ir_crit->as_string( ).
  ENDIF.

* Read the tabentries from db.
  IF l_where IS INITIAL.
    SELECT COUNT(*)
      FROM (i_tabname)
      INTO r_count.
  ELSE.
    SELECT COUNT(*)
      FROM (i_tabname)
      INTO r_count
      WHERE (l_where).
  ENDIF.

ENDMETHOD.


METHOD select_tabentries.

  DATA: l_where  TYPE string.

* Initial checking.
  IF i_tabname IS INITIAL.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the where statement.
  IF ir_crit IS BOUND.
    l_where = ir_crit->as_string( ).
  ENDIF.

* Read the tabentries from db.
  IF l_where IS INITIAL.
    SELECT *
      FROM (i_tabname)
      INTO TABLE ct_tabentry.
  ELSE.
    SELECT *
      FROM (i_tabname)
      INTO TABLE ct_tabentry
      WHERE (l_where).
  ENDIF.
  CHECK ct_tabentry IS NOT INITIAL.

* Filter the tabentries.
  IF ir_filter IS BOUND.
    CALL METHOD ir_filter->process_tabentries
      CHANGING
        ct_tabentry = ct_tabentry.
  ENDIF.

ENDMETHOD.


METHOD set_crit.

  DATA: ls_crit  LIKE LINE OF gt_crit.

  FIELD-SYMBOLS: <ls_crit>  LIKE LINE OF gt_crit.

* Initial checking.
  IF i_tabname IS INITIAL OR
     ir_crit IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe existing entry.
  READ TABLE gt_crit
    WITH TABLE KEY tabname = i_tabname
    ASSIGNING <ls_crit>.

* If the entry already exists -> actualize it.
  IF sy-subrc = 0.
    rr_crit = <ls_crit>-r_crit.
    <ls_crit>-r_crit = ir_crit.
* If the entry does not already exist -> create it.
  ELSE.
    CLEAR: ls_crit.
    ls_crit-tabname = i_tabname.
    ls_crit-r_crit  = ir_crit.
    INSERT ls_crit INTO TABLE gt_crit.
  ENDIF.

ENDMETHOD.


METHOD set_filter.

  DATA: ls_filter  LIKE LINE OF gt_filter.

  FIELD-SYMBOLS: <ls_filter>  LIKE LINE OF gt_filter.

* Initial checking.
  IF i_tabname IS INITIAL OR
     ir_filter IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Get the maybe existing entry.
  READ TABLE gt_filter
    WITH TABLE KEY tabname = i_tabname
    ASSIGNING <ls_filter>.

* If the entry already exists -> actualize it.
  IF sy-subrc = 0.
    rr_filter = <ls_filter>-r_filter.
    <ls_filter>-r_filter = ir_filter.
* If the entry does not already exist -> create it.
  ELSE.
    CLEAR: ls_filter.
    ls_filter-tabname  = i_tabname.
    ls_filter-r_filter = ir_filter.
    INSERT ls_filter INTO TABLE gt_filter.
  ENDIF.

ENDMETHOD.
ENDCLASS.
