class CL_ISH_DBCRIT_TABLE definition
  public
  inheriting from CL_ISH_DBCRITERION
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBCRIT_TABLE
*"* do not include other source files here!!!
public section.

  constants CO_OPERATOR_IN type STRING value 'IN'. "#EC NOTEXT
  constants CO_OPERATOR_NOT_IN type STRING value 'NOT IN'. "#EC NOTEXT
  constants CO_OTYPE_DBCRIT_TABLE type ISH_OBJECT_TYPE value 12179. "#EC NOTEXT

  class-methods CREATE_BY_TABENTRIES
    importing
      !I_FIELDNAME type FIELDNAME
      !IT_TABENTRY type ANY TABLE
      !I_TAB_FIELDNAME type FIELDNAME optional
      !I_OPERATOR type STRING default CO_OPERATOR_IN
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_TABLE .
  methods ADD_VALUE
    importing
      !I_VALUE type ANY .
  methods ADD_VALUES
    importing
      !IT_VALUE type ISH_T_STRING .
  methods ADD_VALUES_BY_TABENTRIES
    importing
      !IT_TABENTRY type ANY TABLE
      !I_TAB_FIELDNAME type FIELDNAME optional .
  methods CONSTRUCTOR
    importing
      !I_FIELDNAME type FIELDNAME
      !IT_VALUE type ISH_T_STRING optional
      !I_OPERATOR type STRING default CO_OPERATOR_IN .
  methods GET_OPERATOR
    returning
      value(R_OPERATOR) type STRING .
  methods GET_VALUES
    returning
      value(RT_VALUE) type ISH_T_STRING .
  methods SET_VALUES
    importing
      !IT_VALUE type ISH_T_STRING .
  methods SET_VALUES_BY_TABENTRIES
    importing
      !IT_TABENTRY type ANY TABLE
      !I_TAB_FIELDNAME type FIELDNAME optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IS_EMPTY
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBCRIT_TABLE
*"* do not include other source files here!!!

  methods IS_OPERATOR_VALID
    importing
      !I_OPERATOR type STRING
    returning
      value(R_VALID) type ISH_ON_OFF .

  methods _AS_STRING
    redefinition .
private section.
*"* private components of class CL_ISH_DBCRIT_TABLE
*"* do not include other source files here!!!

  data GT_VALUE type ISH_T_STRING .
  data G_FIELDNAME type FIELDNAME .
  data G_OPERATOR type STRING .
ENDCLASS.



CLASS CL_ISH_DBCRIT_TABLE IMPLEMENTATION.


METHOD add_value.

  DATA: l_value      TYPE string,
        lr_except    TYPE REF TO cx_root.

  TRY.
      l_value = i_value.
    CATCH cx_root INTO lr_except.
      RAISE EXCEPTION TYPE cx_ish_no_check_handler
        EXPORTING
          previous = lr_except.
  ENDTRY.

  APPEND l_value TO gt_value.

ENDMETHOD.


METHOD add_values.

  APPEND LINES OF it_value TO gt_value.

ENDMETHOD.


METHOD add_values_by_tabentries.

  FIELD-SYMBOLS: <ls_tabentry>  TYPE ANY,
                 <l_value>      TYPE ANY.

  LOOP AT it_tabentry ASSIGNING <ls_tabentry>.
*   Assign the value depending on i_tab_fieldname.
    IF i_tab_fieldname IS INITIAL.
      ASSIGN <ls_tabentry> TO <l_value>.
    ELSE.
      ASSIGN COMPONENT i_tab_fieldname
        OF STRUCTURE <ls_tabentry>
        TO <l_value>.
    ENDIF.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_ish_no_check_handler.
    ENDIF.
*   Add the value.
    add_value( <l_value> ).
  ENDLOOP.

ENDMETHOD.


METHOD constructor.

* Call the super constructor.
  super->constructor( ).

* Initial checking.
  IF i_fieldname IS INITIAL OR
     is_operator_valid( i_operator ) = off.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Set the fieldname.
  g_fieldname = i_fieldname.

* Set the operator.
  g_operator = i_operator.

* Set the values.
  gt_value = it_value.

ENDMETHOD.


METHOD create_by_tabentries.

  CREATE OBJECT rr_crit
    EXPORTING
      i_fieldname = i_fieldname
      i_operator  = i_operator.

  IF i_tab_fieldname IS SUPPLIED.
    rr_crit->set_values_by_tabentries( it_tabentry     = it_tabentry
                                       i_tab_fieldname = i_tab_fieldname ).
  ELSE.
    rr_crit->set_values_by_tabentries( it_tabentry ).
  ENDIF.

ENDMETHOD.


METHOD get_operator.

  r_operator = g_operator.

ENDMETHOD.


METHOD get_values.

  rt_value = gt_value.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbcrit_table.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbcrit_table.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD is_empty.

  IF gt_value IS INITIAL.
    r_empty = on.
  ELSE.
    r_empty = off.
  ENDIF.

ENDMETHOD.


METHOD is_operator_valid.

  CASE i_operator.
    WHEN co_operator_in OR
         co_operator_not_in.
      r_valid = on.
    WHEN OTHERS.
      r_valid = off.
  ENDCASE.

ENDMETHOD.


METHOD set_values.

  gt_value = it_value.

ENDMETHOD.


METHOD set_values_by_tabentries.

  CLEAR: gt_value.

  IF i_tab_fieldname IS SUPPLIED.
    add_values_by_tabentries( it_tabentry     = it_tabentry
                              i_tab_fieldname = i_tab_fieldname ).
  ELSE.
    add_values_by_tabentries( it_tabentry ).
  ENDIF.

ENDMETHOD.


METHOD _as_string.

  DATA: l_value        TYPE string,
        l_first_value  TYPE ish_on_off.

  FIELD-SYMBOLS: <l_value>  LIKE LINE OF gt_value.

* Build the first part: "<fieldname> in | not in ("
  CONCATENATE g_fieldname
              g_operator
              '('
         INTO r_string
    SEPARATED BY space.

* Add each value: '<val1>','<val2>',...
  l_first_value = on.
  LOOP AT gt_value ASSIGNING <l_value>.
    IF l_first_value = off.
      CONCATENATE r_string
                  ','
             INTO r_string.
    ENDIF.
    CONCATENATE r_string
                ''''
                <l_value>
                ''''
           INTO r_string.
    l_first_value = off.
  ENDLOOP.

* Add the closing paranthes.
  CONCATENATE r_string
              ')'
         INTO r_string.

ENDMETHOD.
ENDCLASS.
