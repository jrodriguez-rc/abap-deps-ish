class CL_ISH_DBCRIT_SINGLE definition
  public
  inheriting from CL_ISH_DBCRITERION
  create public
  shared memory enabled .

*"* public components of class CL_ISH_DBCRIT_SINGLE
*"* do not include other source files here!!!
public section.

  constants CO_OPERATOR_EQ type STRING value 'EQ'. "#EC NOTEXT
  constants CO_OPERATOR_GE type STRING value 'GE'. "#EC NOTEXT
  constants CO_OPERATOR_GT type STRING value 'GT'. "#EC NOTEXT
  constants CO_OPERATOR_LE type STRING value 'LE'. "#EC NOTEXT
  constants CO_OPERATOR_LT type STRING value 'LT'. "#EC NOTEXT
  constants CO_OPERATOR_NE type STRING value 'NE'. "#EC NOTEXT
  constants CO_OPERATOR_NOT_NULL type STRING value 'NOT_NULL'. "#EC NOTEXT
  constants CO_OPERATOR_NULL type STRING value 'NULL'. "#EC NOTEXT
  constants CO_OTYPE_DBCRIT_SINGLE type ISH_OBJECT_TYPE value 12170. "#EC NOTEXT

  class-methods CREATE_EQ
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY optional
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_SINGLE .
  class-methods CREATE_GE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY optional
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_SINGLE .
  class-methods CREATE_GT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY optional
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_SINGLE .
  class-methods CREATE_LE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY optional
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_SINGLE .
  class-methods CREATE_LT
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY optional
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_SINGLE .
  class-methods CREATE_NE
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY optional
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_SINGLE .
  class-methods CREATE_NOT_NULL
    importing
      !I_FIELDNAME type FIELDNAME
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_SINGLE .
  class-methods CREATE_NULL
    importing
      !I_FIELDNAME type FIELDNAME
    returning
      value(RR_CRIT) type ref to CL_ISH_DBCRIT_SINGLE .
  type-pools CO .
  methods CONSTRUCTOR
    importing
      !I_FIELDNAME type FIELDNAME
      !I_VALUE type ANY optional
      !I_OPERATOR type STRING default CO_OPERATOR_EQ .
  methods GET_FIELDNAME
    returning
      value(R_FIELDNAME) type FIELDNAME .
  methods GET_OPERATOR
    returning
      value(R_OPERATOR) type STRING .
  methods GET_VALUE
    returning
      value(R_VALUE) type STRING .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IS_EMPTY
    redefinition .
protected section.
*"* protected components of class CL_ISH_DBCRIT_SINGLE
*"* do not include other source files here!!!

  constants CO_OPERATOR_CP type STRING value 'LIKE'. "#EC NOTEXT
  constants CO_OPERATOR_NP type STRING value 'NOT LIKE'. "#EC NOTEXT

  methods IS_OPERATOR_VALID
    importing
      !I_OPERATOR type STRING
    returning
      value(R_VALID) type ISH_ON_OFF .

  methods _AS_STRING
    redefinition .
private section.
*"* private components of class CL_ISH_DBCRIT_SINGLE
*"* do not include other source files here!!!

  data G_FIELDNAME type FIELDNAME .
  data G_OPERATOR type STRING .
  data G_VALUE type STRING .
ENDCLASS.



CLASS CL_ISH_DBCRIT_SINGLE IMPLEMENTATION.


METHOD constructor.

  DATA: lr_except  TYPE REF TO cx_root.

* Call the super constructor.
  super->constructor( ).

* Initial checking.
  IF i_fieldname IS INITIAL OR
     is_operator_valid( i_operator ) = off.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Set the fieldname.
  g_fieldname = i_fieldname.

* Set the value.
  IF i_value IS SUPPLIED.
    TRY.
        g_value = i_value.
      CATCH cx_root INTO lr_except.
        RAISE EXCEPTION TYPE cx_ish_no_check_handler
          EXPORTING
            previous = lr_except.
    ENDTRY.
  ENDIF.

* Set the operator.
  g_operator = i_operator.

ENDMETHOD.


METHOD create_eq.

  IF i_value IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_value     = i_value
        i_operator  = co_operator_eq.
  ELSE.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_operator  = co_operator_eq.
  ENDIF.

ENDMETHOD.


METHOD create_ge.

  IF i_value IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_value     = i_value
        i_operator  = co_operator_ge.
  ELSE.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_operator  = co_operator_ge.
  ENDIF.

ENDMETHOD.


METHOD create_gt.

  IF i_value IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_value     = i_value
        i_operator  = co_operator_gt.
  ELSE.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_operator  = co_operator_gt.
  ENDIF.

ENDMETHOD.


METHOD create_le.

  IF i_value IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_value     = i_value
        i_operator  = co_operator_le.
  ELSE.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_operator  = co_operator_le.
  ENDIF.

ENDMETHOD.


METHOD create_lt.

  IF i_value IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_value     = i_value
        i_operator  = co_operator_lt.
  ELSE.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_operator  = co_operator_lt.
  ENDIF.

ENDMETHOD.


METHOD create_ne.

  IF i_value IS SUPPLIED.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_value     = i_value
        i_operator  = co_operator_ne.
  ELSE.
    CREATE OBJECT rr_crit
      EXPORTING
        i_fieldname = i_fieldname
        i_operator  = co_operator_ne.
  ENDIF.

ENDMETHOD.


METHOD create_not_null.

  CREATE OBJECT rr_crit
    EXPORTING
      i_fieldname = i_fieldname
      i_operator  = co_operator_not_null.

ENDMETHOD.


METHOD create_null.

  CREATE OBJECT rr_crit
    EXPORTING
      i_fieldname = i_fieldname
      i_operator  = co_operator_null.

ENDMETHOD.


method GET_FIELDNAME.
endmethod.


METHOD get_operator.

  r_operator = g_operator.

ENDMETHOD.


METHOD get_value.

  r_value = g_value.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dbcrit_single.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dbcrit_single.
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
    WHEN co_operator_eq       OR
         co_operator_ge       OR
         co_operator_gt       OR
         co_operator_le       OR
         co_operator_lt       OR
         co_operator_ne       OR
         co_operator_not_null OR
         co_operator_null.
      r_valid = on.
    WHEN OTHERS.
      r_valid = off.
  ENDCASE.

ENDMETHOD.


METHOD _as_string.

  DATA: l_operator  TYPE string,
        l_value     TYPE string.

* Determine the "real" operator and value (handling LIKE criterion).
  l_operator = g_operator.
  l_value    = g_value.
  IF l_operator = co_operator_eq AND
     g_value CA '*'.
    l_operator = co_operator_cp.
    TRANSLATE l_value USING '*%'.
  ELSEIF l_operator = co_operator_ne AND
     g_value CA '*'.
    l_operator = co_operator_np.
    TRANSLATE l_value USING '*%'.
  ENDIF.

* Stringify the criterion.
  IF l_operator = co_operator_null.
    CONCATENATE g_fieldname
                'IS NULL'
           INTO r_string
      SEPARATED BY space.
  ELSEIF l_operator = co_operator_not_null.
    CONCATENATE g_fieldname
                'IS NOT NULL'
           INTO r_string
      SEPARATED BY space.
  ELSE.
    CONCATENATE ''''
                g_value
                ''''
           INTO r_string.
    CONCATENATE g_fieldname
                l_operator
                r_string
           INTO r_string
      SEPARATED BY space.
  ENDIF.

ENDMETHOD.
ENDCLASS.
