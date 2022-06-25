class CL_ISH_MSGRC_RESULT definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_MSGRC_RESULT
*"* do not include other source files here!!!
public section.

  class-methods MERGE_MSGRC
    importing
      !IR_RESULT1 type ref to CL_ISH_MSGRC_RESULT
      !IR_RESULT2 type ref to CL_ISH_MSGRC_RESULT
    returning
      value(RR_RESULT) type ref to CL_ISH_MSGRC_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_MSGRC_RESULT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_MSGRC_RESULT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_MSGRC_RESULT IMPLEMENTATION.


METHOD merge_msgrc.

  IF ir_result1 IS BOUND.
*    ir_result1->merge( ir_other_result = ir_result2 ).
    rr_result = ir_result1.
  ELSEIF ir_result2 IS BOUND.
*    ir_result2->merge( ir_other_result = ir_result1 ).
    rr_result = ir_result2.
  ENDIF.

ENDMETHOD.
ENDCLASS.
