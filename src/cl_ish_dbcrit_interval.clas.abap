class CL_ISH_DBCRIT_INTERVAL definition
  public
  inheriting from CL_ISH_DBCRITERION
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBCRIT_INTERVAL
*"* do not include other source files here!!!
public section.

  constants CO_OPERATOR_BT type STRING value 'BETWEEN'. "#EC NOTEXT
  constants CO_OPERATOR_NOT_BT type STRING value 'NOT BETWEEN'. "#EC NOTEXT
  constants CO_OTYPE_DBCRIT_INTERVAL type ISH_OBJECT_TYPE value 12171. "#EC NOTEXT

  class-methods CREATE_BT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE_FROM type ANY optional
      !I_VALUE_TO type ANY optional
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_INTERVAL .
  class-methods CREATE_NOT_BT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE_FROM type ANY optional
      !I_VALUE_TO type ANY optional
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_INTERVAL .
  methods CONSTRUCTOR
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE_FROM type ANY optional
      !I_VALUE_TO type ANY optional
      !I_OPERATOR type STRING default CO_OPERATOR_BT .
  methods GET_OPERATOR
    returning
      value(R_OPERATOR) type STRING .
  methods GET_VALUE_FROM
    returning
      value(R_VALUE) type STRING .
  methods GET_VALUE_TO
    returning
      value(R_VALUE) type STRING .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IS_EMPTY
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBCRIT_INTERVAL
*"* do not include other source files here!!!

  methods IS_OPERATOR_VALID
    importing
      !I_OPERATOR type STRING
    returning
      value(R_VALID) type ISH_ON_OFF .

  methods _AS_STRING
    redefinition .
private section.
*"* private components of class CL_ISH_DBCRIT_INTERVAL
*"* do not include other source files here!!!

  data G_FIELDNAME type FIELDNAME .
  data G_OPERATOR type STRING .
  data G_VALUE_FROM type STRING .
  data G_VALUE_TO type STRING .
ENDCLASS.



CLASS CL_ISH_DBCRIT_INTERVAL IMPLEMENTATION.


METHOD constructor.

  DATA: lr_range   TYPE REF TO cl_ish_range,
        lr_except  TYPE REF TO cx_root.

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

* Set the interval.
  TRY.
      g_value_from = i_value_from.
      g_value_to   = i_value_to.
    CATCH cx_root INTO lr_except.
      RAISE EXCEPTION TYPE cx_ish_no_check_handler
        EXPORTING
          previous = lr_except.
  ENDTRY.

ENDMETHOD.


METHOD create_bt.

  IF i_value_from IS SUPPLIED AND
     i_value_to IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname  = i_fieldname
        i_value_from = i_value_from
        i_value_to   = i_value_to
        i_operator   = co_operator_bt.
  ELSEIF i_value_from IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname  = i_fieldname
        i_value_from = i_value_from
        i_operator   = co_operator_bt.
  ELSEIF i_value_to IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname  = i_fieldname
        i_value_to   = i_value_to
        i_operator   = co_operator_bt.
  ELSE.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname  = i_fieldname
        i_operator   = co_operator_bt.
  ENDIF.

ENDMETHOD.


METHOD create_not_bt.

  IF i_value_from IS SUPPLIED AND
     i_value_to IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname  = i_fieldname
        i_value_from = i_value_from
        i_value_to   = i_value_to
        i_operator   = co_operator_not_bt.
  ELSEIF i_value_from IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname  = i_fieldname
        i_value_from = i_value_from
        i_operator   = co_operator_not_bt.
  ELSEIF i_value_to IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname  = i_fieldname
        i_value_to   = i_value_to
        i_operator   = co_operator_not_bt.
  ELSE.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname  = i_fieldname
        i_operator   = co_operator_not_bt.
  ENDIF.

ENDMETHOD.


METHOD get_operator.

  r_operator = g_operator.

ENDMETHOD.


METHOD get_value_from.

  r_value = g_value_from.

ENDMETHOD.


METHOD get_value_to.

  r_value = g_value_to.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbcrit_interval.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbcrit_interval.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD is_empty.

  r_empty = off.

ENDMETHOD.


METHOD is_operator_valid.

  CASE i_operator.
    WHEN co_operator_bt OR
         co_operator_not_bt.
      r_valid = on.
    WHEN OTHERS.
      r_valid = off.
  ENDCASE.

ENDMETHOD.


METHOD _as_string.

  DATA: l_value_from  TYPE string,
        l_value_to    TYPE string.

  CONCATENATE ''''
              g_value_from
              ''''
         INTO l_value_from.

  CONCATENATE ''''
              g_value_to
              ''''
         INTO l_value_to.

  CONCATENATE g_fieldname
              g_operator
              l_value_from
              'AND'
              l_value_to
         INTO r_string
    SEPARATED BY space.

ENDMETHOD.
ENDCLASS.
