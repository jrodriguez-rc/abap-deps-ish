class CL_ISH_DBCRIT_ASSEMBLED definition
  public
  inheriting from CL_ISH_DBCRITERION
  final
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBCRIT_ASSEMBLED
*"* do not include other source files here!!!
public section.

  constants CO_OPERATOR_AND type STRING value 'AND'. "#EC NOTEXT
  constants CO_OPERATOR_NOT type STRING value 'NOT'. "#EC NOTEXT
  constants CO_OPERATOR_OR type STRING value 'OR'. "#EC NOTEXT
  constants CO_OTYPE_DBCRIT_ASSEMBLED type ISH_OBJECT_TYPE value 12163. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_CRIT1 type ref to CL_ISH_DBCRITERION
      !IR_CRIT2 type ref to CL_ISH_DBCRITERION
      !I_OPERATOR type STRING .
  methods GET_CRIT1
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRITERION .
  methods GET_CRIT2
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRITERION .
  methods GET_OPERATOR
    returning
      value(R_OPERATOR) type STRING .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IS_EMPTY
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBCRIT_ASSEMBLED
*"* do not include other source files here!!!

  methods IS_OPERATOR_VALID
    importing
      !I_OPERATOR type STRING
    returning
      value(R_VALID) type ISH_ON_OFF .

  methods PREPARE_STRINGIFICATION
    redefinition .
  methods _AS_STRING
    redefinition .
private section.
*"* private components of class CL_ISH_DBCRIT_ASSEMBLED
*"* do not include other source files here!!!

  data GR_CRIT1 type ref to CL_ISH_DBCRITERION .
  data GR_CRIT2 type ref to CL_ISH_DBCRITERION .
  data G_OPERATOR type STRING .
ENDCLASS.



CLASS CL_ISH_DBCRIT_ASSEMBLED IMPLEMENTATION.


METHOD constructor.

* Call the super constructor.
  super->constructor( ).

* Initial checking.
  IF ir_crit1 IS NOT BOUND OR
     ir_crit2 IS NOT BOUND OR
     is_operator_valid( i_operator ) = off.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Initialize self.
  gr_crit1   = ir_crit1.
  gr_crit2   = ir_crit2.
  g_operator = i_operator.

ENDMETHOD.


method GET_CRIT1.
endmethod.


method GET_CRIT2.
endmethod.


method GET_OPERATOR.
endmethod.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbcrit_assembled.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbcrit_assembled.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD is_empty.

  IF gr_crit1->is_empty( ) = off OR
     gr_crit2->is_empty( ) = off.
    r_empty = off.
  ELSE.
    r_empty = on.
  ENDIF.

ENDMETHOD.


METHOD is_operator_valid.

  CASE i_operator.
    WHEN co_operator_and OR
         co_operator_or  OR
         co_operator_not.
      r_valid = on.
    WHEN OTHERS.
      r_valid = off.
  ENDCASE.

ENDMETHOD.


METHOD prepare_stringification.

  super->prepare_stringification( ).

  IF gr_crit1 IS BOUND.
    gr_crit1->prepare_stringification( ).
  ENDIF.

  IF gr_crit2 IS BOUND.
    gr_crit2->prepare_stringification( ).
  ENDIF.

ENDMETHOD.


METHOD _as_string.

  DATA: l_string1  TYPE string,
        l_string2  TYPE string.

* Stringify crit1+2.
  l_string1 = gr_crit1->_as_string( ).
  l_string2 = gr_crit2->_as_string( ).

* Export.
  IF l_string1 IS INITIAL.
    r_string = l_string2.
  ELSEIF l_string2 IS INITIAL.
    r_string = l_string1.
  ELSE.
    CONCATENATE '('
                l_string1
                g_operator
                l_string2
                ')'
           INTO r_string
      SEPARATED BY space.
  ENDIF.

ENDMETHOD.
ENDCLASS.
