class CL_ISH_AS_PARAM_C definition
  public
  inheriting from CL_ISH_AS_PARAM
  create public
  shared memory enabled

  global friends CL_ISH_AS_LOADER .

*"* public components of class CL_ISH_AS_PARAM_C
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_AS_PARAM_C type ISH_OBJECT_TYPE value 12031. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_PARAMID type N1ASPARAMID
      !I_DEFAULT_VALUE type N1ASVALUE default SPACE .
  methods GET_T_VALUE
    returning
      value(RT_VALUE) type ISH_T_ASVALUE_C_HASH .
  methods GET_VALUE
    importing
      !I_MANDT type MANDT default SY-MANDT
    returning
      value(R_VALUE) type N1ASVALUE .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_AS_PARAM_C
*"* do not include other source files here!!!

  data GT_VALUE type ISH_T_ASVALUE_C_HASH .

  methods DESTROY
    redefinition .
  methods INITIALIZE
    redefinition .
  methods CREATE_ASM_PARAM
    redefinition .
private section.
*"* private components of class CL_ISH_AS_PARAM_C
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_AS_PARAM_C IMPLEMENTATION.


METHOD constructor.

* Call the super constructor.
  super->constructor( i_paramid       = i_paramid
                      i_default_value = i_default_value ).

ENDMETHOD.


METHOD create_asm_param.

  CREATE OBJECT rr_asm_param TYPE cl_ish_asm_param_c
    EXPORTING
      ir_param = me.

ENDMETHOD.


METHOD destroy.

  CLEAR: gt_value.

ENDMETHOD.


METHOD get_t_value.

  rt_value = gt_value.

ENDMETHOD.


METHOD get_value.

  FIELD-SYMBOLS: <ls_value>  LIKE LINE OF gt_value.

  READ TABLE gt_value
    WITH TABLE KEY mandt = i_mandt
    ASSIGNING <ls_value>.

  IF sy-subrc = 0.
    r_value = <ls_value>-value.
  ELSE.
    r_value = get_default_value( ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_as_param_c.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_as_param_c.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize.

  DATA: l_paramid        TYPE n1asparamid,
        lt_n1asvaluec    TYPE TABLE OF n1asvaluec,
        ls_value         LIKE LINE OF gt_value.

  FIELD-SYMBOLS: <ls_n1asvaluec>  TYPE n1asvaluec.

* Get self's paramid.
  l_paramid = get_paramid( ).

* Read the corresponding value entries from db.
  SELECT *
    FROM n1asvaluec
    INTO TABLE lt_n1asvaluec
    WHERE paramid = l_paramid
    ORDER BY mandt.
  CHECK sy-subrc = 0.

* For each value entry create a value and add it to self.
  LOOP AT lt_n1asvaluec ASSIGNING <ls_n1asvaluec>.
    CLEAR: ls_value.
    ls_value-mandt = <ls_n1asvaluec>-mandt.
    ls_value-value = <ls_n1asvaluec>-value.
    INSERT ls_value INTO TABLE gt_value.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
