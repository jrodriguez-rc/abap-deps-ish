class CL_ISH_OBJECT_COLLNODE definition
  public
  inheriting from CL_ISH_COLLECTION_NODE
  create protected

  global friends CL_ISH_NODE_COLLECTION .

public section.
*"* public components of class CL_ISH_OBJECT_COLLNODE
*"* do not include other source files here!!!

  constants CO_OTYPE_OBJECT_COLLNODE type ISH_OBJECT_TYPE value 13421. "#EC NOTEXT

  methods GET_OBJECT
    importing
      value(IR_OBJECT) type ANY optional
    returning
      value(RR_OBJECT) type ref to OBJECT .
  methods SET_OBJECT
    importing
      !IR_OBJECT type ref to OBJECT .

  methods CLEAR_CONTENT
    redefinition .
  methods GET_CONTENT
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods SET_CONTENT
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_OBJECT_COLLNODE
*"* do not include other source files here!!!

  data GR_OBJECT type ref to OBJECT .

  class-methods CREATE
    importing
      !IR_OBJECT type ref to OBJECT optional
    returning
      value(RR_NODE) type ref to CL_ISH_OBJECT_COLLNODE .
private section.
*"* private components of class CL_ISH_OBJECT_COLLNODE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_OBJECT_COLLNODE IMPLEMENTATION.


METHOD clear_content.

  CLEAR: gr_object.

ENDMETHOD.


METHOD create.

  CREATE OBJECT rr_node.

  IF ir_object IS SUPPLIED.
    rr_node->set_object( ir_object ).
  ENDIF.

ENDMETHOD.


METHOD get_content.

  TRY.
      c_content ?= gr_object.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  e_success = abap_true.

ENDMETHOD.


METHOD get_object.

  CHECK gr_object IS BOUND.

  IF ir_object IS SUPPLIED.
    TRY.
        ir_object ?= gr_object.
      CATCH cx_root.
        RETURN.
    ENDTRY.
  ENDIF.

  rr_object = gr_object.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_object_collnode.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_object_collnode.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD set_content.

  DATA: lr_object  TYPE REF TO object.

  TRY.
      lr_object ?= i_content.
      gr_object = lr_object.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  r_success = abap_true.

ENDMETHOD.


METHOD set_object.

  gr_object = ir_object.

ENDMETHOD.
ENDCLASS.
