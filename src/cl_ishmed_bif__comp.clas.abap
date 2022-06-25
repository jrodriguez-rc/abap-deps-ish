class CL_ISHMED_BIF__COMP definition
  public
  final
  create public .

public section.
*"* public components of class CL_ISHMED_BIF__COMP
*"* do not include other source files here!!!

  interfaces IF_BADI_INTERFACE .
  interfaces IF_BADI_ISHMED_BASEITEMS_EXIT .
protected section.
*"* protected components of class CL_ISHMED_BIF__COMP
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISHMED_BIF__COMP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISHMED_BIF__COMP IMPLEMENTATION.


METHOD if_badi_ishmed_baseitems_exit~call_post_badi.

  DATA lr_badi_context      TYPE REF TO cl_ishmed_baseitem_enh_badictx.
  DATA lr_badi              TYPE REF TO badi_ishmed_bix_component.

  DATA lx_badi              TYPE REF TO cx_badi.

  DATA l_filter             TYPE        n2_exit_flt_component.
*----------------------------------------------------------
* get context
  lr_badi_context = cl_ishmed_baseitem_enh_badictx=>get_context( ).

* get badi
  l_filter = i_filter_value.
  TRY.
      GET BADI lr_badi
        FILTERS
          n2_exit_flt_component = l_filter
        CONTEXT
          lr_badi_context.

    CATCH cx_badi_not_implemented.

    CATCH cx_badi INTO lx_badi.
      RAISE EXCEPTION TYPE cx_ishmed_baseitem_exit
        EXPORTING
          previous = lx_badi.
  ENDTRY.

  CHECK lr_badi IS BOUND.

  IF ir_operation->get_action_type( ) = if_ishmed_baseitems_const=>co_action_first.
    CALL BADI lr_badi->after_exit_at_first
      EXPORTING
        ir_baseitem     = ir_baseitem
        ir_baseitemtype = ir_baseitemtype
        ir_operation    = ir_operation
        ir_context      = ir_context
        i_result        = i_result
        i_commit        = i_commit
        i_testrun       = i_testrun
        flt_val         = l_filter.

  ELSE.
    CALL BADI lr_badi->after_exit_at_again
      EXPORTING
        ir_baseitem     = ir_baseitem
        ir_baseitemtype = ir_baseitemtype
        ir_operation    = ir_operation
        ir_context      = ir_context
        i_result        = i_result
        i_commit        = i_commit
        i_testrun       = i_testrun
        flt_val         = l_filter.

  ENDIF.

ENDMETHOD.


METHOD if_badi_ishmed_baseitems_exit~call_pre_badi.

  DATA lr_badi_context      TYPE REF TO cl_ishmed_baseitem_enh_badictx.
  DATA lr_badi              TYPE REF TO badi_ishmed_bix_component.

  DATA lx_badi              TYPE REF TO cx_badi.

  DATA l_filter             TYPE        n2_exit_flt_component.
*----------------------------------------------------------
* get context
  lr_badi_context = cl_ishmed_baseitem_enh_badictx=>get_context( ).

* get badi
  l_filter = i_filter_value.
  TRY.
      GET BADI lr_badi
        FILTERS
          n2_exit_flt_component = l_filter
        CONTEXT
          lr_badi_context.

    CATCH cx_badi_not_implemented.

    CATCH cx_badi INTO lx_badi.
      RAISE EXCEPTION TYPE cx_ishmed_baseitem_exit
        EXPORTING
          previous = lx_badi.
  ENDTRY.

  CHECK lr_badi IS BOUND.

  IF i_result IS INITIAL.
    CALL BADI lr_badi->before_exit_at_first
      EXPORTING
        ir_baseitem     = ir_baseitem
        ir_baseitemtype = ir_baseitemtype
        ir_operation    = ir_operation
        ir_context      = ir_context
        i_result        = i_result
        i_commit        = i_commit
        i_testrun       = i_testrun
        flt_val         = l_filter.

  ELSE.
    CALL BADI lr_badi->before_exit_at_again
      EXPORTING
        ir_baseitem     = ir_baseitem
        ir_baseitemtype = ir_baseitemtype
        ir_operation    = ir_operation
        ir_context      = ir_context
        i_result        = i_result
        i_commit        = i_commit
        i_testrun       = i_testrun
        flt_val         = l_filter.
  ENDIF.

ENDMETHOD.
ENDCLASS.
