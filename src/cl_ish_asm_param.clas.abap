class CL_ISH_ASM_PARAM definition
  public
  abstract
  create public

  global friends CL_ISH_AS_MASTER .

*"* public components of class CL_ISH_ASM_PARAM
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_ASM_PARAM type ISH_OBJECT_TYPE value 12027. "#EC NOTEXT

  methods CHECK
  abstract
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      !IR_PARAM type ref to CL_ISH_AS_PARAM
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DEFAULT_VALUE
    returning
      value(R_VALUE) type N1ASVALUE .
  methods GET_PARAM
    returning
      value(RR_PARAM) type ref to CL_ISH_AS_PARAM .
  methods GET_PARAMID
    returning
      value(R_PARAMID) type N1ASPARAMID .
  methods IS_CHANGED
  abstract
    returning
      value(R_CHANGED) type ISH_ON_OFF .
  methods IS_LOCKED
  final
    returning
      value(R_LOCKED) type ISH_ON_OFF .
  methods LOCK
  final
    raising
      CX_ISH_STATIC_HANDLER .
  methods UNLOCK
  final .
protected section.
*"* protected components of class CL_ISH_ASM_PARAM
*"* do not include other source files here!!!

  methods DESTROY
  final .
  methods INITIALIZE
  abstract .
  methods SAVE
  abstract
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DESTROY
  abstract .
  methods _LOCK
  abstract
    raising
      CX_ISH_STATIC_HANDLER .
  methods _UNLOCK
  abstract .
private section.
*"* private components of class CL_ISH_ASM_PARAM
*"* do not include other source files here!!!

  data GR_PARAM type ref to CL_ISH_AS_PARAM .
  data G_LOCKED type ISH_ON_OFF .
ENDCLASS.



CLASS CL_ISH_ASM_PARAM IMPLEMENTATION.


METHOD constructor.

  DATA: l_my_clsname     TYPE seoclsname,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

* Checking.
  IF ir_param IS NOT BOUND.
    l_my_clsname = cl_ish_utl_rtti=>get_class_name( me ).
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '003'
        i_mv1           = l_my_clsname
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

* Set gr_param.
  gr_param = ir_param.

ENDMETHOD.


METHOD destroy.

  _destroy( ).

  CLEAR: gr_param,
         g_locked.

ENDMETHOD.


METHOD get_default_value.

  r_value = gr_param->get_default_value( ).

ENDMETHOD.


METHOD get_param.

  rr_param = gr_param.

ENDMETHOD.


METHOD get_paramid.

  r_paramid = gr_param->get_paramid( ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_asm_param.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type  TYPE ish_object_type.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

  IF i_object_type = l_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_asm_param.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD is_locked.

  r_locked = g_locked.

ENDMETHOD.


METHOD lock.

  CHECK g_locked = off.

  _lock( ).

  g_locked = on.

ENDMETHOD.


METHOD unlock.

  CHECK g_locked = on.

  _unlock( ).

  g_locked = off.

ENDMETHOD.
ENDCLASS.
