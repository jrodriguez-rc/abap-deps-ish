class CL_ISH_NODE_COLLECTION definition
  public
  inheriting from CL_ISH_COLLECTION
  abstract
  create public .

public section.
*"* public components of class CL_ISH_NODE_COLLECTION
*"* do not include other source files here!!!

  constants CO_OTYPE_NODE_COLLECTION type ISH_OBJECT_TYPE value 13408. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_NODE_COLLECTION
*"* do not include other source files here!!!

  methods CREATE_NODE
    importing
      !I_CONTENT type ANY
    returning
      value(RR_NODE) type ref to CL_ISH_COLLECTION_NODE .
private section.
*"* private components of class CL_ISH_NODE_COLLECTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_NODE_COLLECTION IMPLEMENTATION.


METHOD constructor.

  super->constructor( ir_owner ).

ENDMETHOD.


METHOD create_node.

  DATA: lr_object      TYPE REF TO object.

  TRY.
      lr_object ?= i_content.
      rr_node = cl_ish_object_collnode=>create( lr_object ).
    CATCH cx_root.
      rr_node = cl_ish_data_collnode=>create( i_content ).
  ENDTRY.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_node_collection.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_node_collection.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
