class CL_ISH_SORTED_ITAB definition
  public
  inheriting from CL_ISH_INDEXED_ITAB
  create protected .

public section.
*"* public components of class CL_ISH_SORTED_ITAB
*"* do not include other source files here!!!

  constants CO_OTYPE_SORTED_ITAB type ISH_OBJECT_TYPE value 13412. "#EC NOTEXT

  type-pools ABAP .
  class-methods CREATE_BY_TABNAME
    importing
      !I_TABNAME type TABNAME
      !I_ALLOW_NULL_ENTRIES type ABAP_BOOL default ABAP_FALSE
      !IR_OWNER type ref to IF_ISH_COLLECTION_OWNER optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_SORTED_ITAB .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_SORTED_ITAB
*"* do not include other source files here!!!

  methods CHECK_INITIALIZATION
    redefinition .
private section.
*"* private components of class CL_ISH_SORTED_ITAB
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SORTED_ITAB IMPLEMENTATION.


METHOD check_initialization.

  DATA: lr_tabledescr  TYPE REF TO cl_abap_tabledescr.

  lr_tabledescr = get_tabledescr( ).
  CHECK lr_tabledescr IS BOUND.

  CHECK lr_tabledescr->table_kind = cl_abap_tabledescr=>tablekind_sorted.

  r_success = abap_true.

ENDMETHOD.


METHOD create_by_tabname.

  DATA: lr_instance  TYPE REF TO cl_ish_sorted_itab,
        lr_table     TYPE REF TO data.

  CHECK i_tabname IS NOT INITIAL.

  CREATE OBJECT lr_instance
    EXPORTING
    i_allow_null_entries = i_allow_null_entries
    ir_owner = ir_owner.

  TRY.
      CREATE DATA lr_table TYPE (i_tabname).
    CATCH cx_root.
      RETURN.
  ENDTRY.

  CHECK lr_instance->initialize( lr_table ) = abap_true.

  rr_instance = lr_instance.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_sorted_itab.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_sorted_itab.
    r_is_inherited_from = abap_true.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
