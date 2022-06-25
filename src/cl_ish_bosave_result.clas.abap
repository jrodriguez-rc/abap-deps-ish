class CL_ISH_BOSAVE_RESULT definition
  public
  inheriting from CL_ISH_RESULT
  create public .

*"* public components of class CL_ISH_BOSAVE_RESULT
*"* do not include other source files here!!!
public section.

  methods CONSTRUCTOR
    importing
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional
      !IR_BO type ref to IF_ISH_BUSINESS_OBJECT
      !IT_SAVED_EO type ISH_T_EO_OBJH optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_BUSINESS_OBJECT
  final
    returning
      value(RR_BO) type ref to IF_ISH_BUSINESS_OBJECT .
  methods GET_T_SAVED_EO
  final
    returning
      value(RT_SAVED_EO) type ISH_T_EO_OBJH .
protected section.
*"* protected components of class CL_ISH_BOSAVE_RESULT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_BOSAVE_RESULT
*"* do not include other source files here!!!

  data GR_BO type ref to IF_ISH_BUSINESS_OBJECT .
  data GT_SAVED_EO type ISH_T_EO_OBJH .
ENDCLASS.



CLASS CL_ISH_BOSAVE_RESULT IMPLEMENTATION.


METHOD constructor.

  IF ir_bo IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_BOSAVE_RESULT' ).
  ENDIF.

  super->constructor(
      ir_messages       = ir_messages ).

  gr_bo       = ir_bo.
  gt_saved_eo = it_saved_eo.

ENDMETHOD.


METHOD get_business_object.

  rr_bo = gr_bo.

ENDMETHOD.


METHOD get_t_saved_eo.

  rt_saved_eo = gt_saved_eo.

ENDMETHOD.
ENDCLASS.
