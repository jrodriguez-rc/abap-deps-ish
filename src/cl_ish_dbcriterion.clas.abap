class CL_ISH_DBCRITERION definition
  public
  inheriting from CL_ISH_DBOBJECT
  abstract
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBCRITERION
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_DBCRITERION type ISH_OBJECT_TYPE value 12162. "#EC NOTEXT

  methods AND
    importing
      !IR_CRIT_OTHER type ref to CL_ISH_DBCRITERION
    returning
      value(RR_CRIT_ASSEMBLED) type ref to CL_ISH_DBCRIT_ASSEMBLED .
  methods AS_STRING
  final
    returning
      value(R_STRING) type STRING .
  methods IS_EMPTY
  abstract
    returning
      value(R_EMPTY) type ISH_ON_OFF .
  methods NOT
    importing
      !IR_CRIT_OTHER type ref to CL_ISH_DBCRITERION
    returning
      value(RR_CRIT_ASSEMBLED) type ref to CL_ISH_DBCRIT_ASSEMBLED .
  methods OR
    importing
      !IR_CRIT_OTHER type ref to CL_ISH_DBCRITERION
    returning
      value(RR_CRIT_ASSEMBLED) type ref to CL_ISH_DBCRIT_ASSEMBLED .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBCRITERION
*"* do not include other source files here!!!

  methods PREPARE_STRINGIFICATION .
  methods _AS_STRING
  abstract
    returning
      value(R_STRING) type STRING .
private section.
*"* private components of class CL_ISH_DBCRITERION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DBCRITERION IMPLEMENTATION.


METHOD and.

  CREATE OBJECT rr_crit_assembled
    EXPORTING
      ir_crit1   = me
      ir_crit2   = ir_crit_other
      i_operator = cl_ish_dbcrit_assembled=>co_operator_and.

ENDMETHOD.


METHOD as_string.

  prepare_stringification( ).

  r_string = _as_string( ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbcriterion.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbcriterion.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD not.

  CREATE OBJECT rr_crit_assembled
    EXPORTING
      ir_crit1   = me
      ir_crit2   = ir_crit_other
      i_operator = cl_ish_dbcrit_assembled=>co_operator_not.

ENDMETHOD.


METHOD or.

  CREATE OBJECT rr_crit_assembled
    EXPORTING
      ir_crit1   = me
      ir_crit2   = ir_crit_other
      i_operator = cl_ish_dbcrit_assembled=>co_operator_or.

ENDMETHOD.


METHOD prepare_stringification.
ENDMETHOD.
ENDCLASS.
