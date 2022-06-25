class CL_ISH_DATA_COLLNODE definition
  public
  inheriting from CL_ISH_COLLECTION_NODE
  create protected

  global friends CL_ISH_NODE_COLLECTION .

public section.
*"* public components of class CL_ISH_DATA_COLLNODE
*"* do not include other source files here!!!

  constants CO_OTYPE_DATA_COLLNODE type ISH_OBJECT_TYPE value 13420. "#EC NOTEXT

  methods GET_DATA
    changing
      !C_DATA type DATA .
  type-pools ABAP .
  methods GET_DATAREF
    importing
      !I_COPY type ABAP_BOOL default ABAP_FALSE
      value(IR_DATA) type ANY optional
    returning
      value(RR_DATA) type ref to DATA .
  methods SET_DATA
    importing
      !I_DATA type DATA .

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
*"* protected components of class CL_ISH_DATA_COLLNODE
*"* do not include other source files here!!!

  data GR_DATA type ref to DATA .

  class-methods CREATE
    importing
      !I_DATA type DATA optional
    returning
      value(RR_NODE) type ref to CL_ISH_DATA_COLLNODE .
private section.
*"* private components of class CL_ISH_DATA_COLLNODE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DATA_COLLNODE IMPLEMENTATION.


METHOD clear_content.

  CLEAR: gr_data.

ENDMETHOD.


METHOD create.

  CREATE OBJECT rr_node.

  IF i_data IS SUPPLIED.
    rr_node->set_data( i_data ).
  ENDIF.

ENDMETHOD.


METHOD get_content.

  DATA: lr_datadescr  TYPE REF TO cl_abap_datadescr.

  FIELD-SYMBOLS: <l_data>  TYPE data.

  CHECK gr_data IS BOUND.

  TRY.
      lr_datadescr ?= cl_abap_typedescr=>describe_by_data_ref( gr_data ).
      CHECK lr_datadescr->applies_to_data( c_content ) = abap_true.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  ASSIGN gr_data->* TO <l_data>.
  c_content = <l_data>.

  e_success = abap_true.

ENDMETHOD.


METHOD get_data.

  DATA: lr_datadescr  TYPE REF TO cl_abap_datadescr.

  FIELD-SYMBOLS: <l_data>  TYPE data.

  CLEAR: c_data.

  CHECK gr_data IS BOUND.

  TRY.
      lr_datadescr ?= cl_abap_typedescr=>describe_by_data_ref( gr_data ).
      CHECK lr_datadescr->applies_to_data( c_data ) = abap_true.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  ASSIGN gr_data->* TO <l_data>.

  c_data = <l_data>.

ENDMETHOD.


METHOD get_dataref.

  FIELD-SYMBOLS: <l_data>  TYPE data,
                 <l_clone> TYPE data.

  CHECK gr_data IS BOUND.

  IF ir_data IS SUPPLIED.
    TRY.
        ir_data ?= gr_data.
      CATCH cx_root.
        RETURN.
    ENDTRY.
  ENDIF.

  IF i_copy = abap_false.
    rr_data = gr_data.
  ELSE.
    ASSIGN gr_data->* TO <l_data>.
    TRY.
        CREATE DATA rr_data LIKE <l_data>.
        ASSIGN rr_data->* TO <l_clone>.
        <l_clone> = <l_data>.
      CATCH cx_root.
        RETURN.
    ENDTRY.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_data_collnode.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_data_collnode.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD set_content.

  FIELD-SYMBOLS: <l_data>  TYPE data.

  TRY.
      CREATE DATA gr_data LIKE i_content.
      ASSIGN gr_data->* TO <l_data>.
      <l_data> = i_content.
    CATCH cx_root.
      RETURN.
  ENDTRY.

  r_success = abap_true.

ENDMETHOD.


METHOD set_data.

  set_content( i_data ).

ENDMETHOD.
ENDCLASS.
