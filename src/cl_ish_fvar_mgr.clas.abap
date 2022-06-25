class CL_ISH_FVAR_MGR definition
  public
  abstract
  final
  create public .

public section.
*"* public components of class CL_ISH_FVAR_MGR
*"* do not include other source files here!!!

  type-pools ABAP .
  class-methods GET_FVAR
    importing
      !I_VIEWTYPE type NVIEWTYPE
      !I_FVARID type NFVARID
      !I_LOAD type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_FVAR) type ref to CL_ISH_FVAR
    raising
      CX_ISH_FVAR .
protected section.
*"* protected components of class CL_ISH_FVAR_MGR
*"* do not include other source files here!!!

  class-data GT_FVAR type ISH_T_FVAR_OBJ .
private section.
*"* private components of class CL_ISH_FVAR_MGR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_FVAR_MGR IMPLEMENTATION.


METHOD get_fvar.

  DATA: lr_fvar  TYPE REF TO cl_ish_fvar.

* Return already loaded fvar.
  LOOP AT gt_fvar INTO lr_fvar.
    CHECK lr_fvar->get_viewtype( ) = i_viewtype.
    CHECK lr_fvar->get_id( )       = i_fvarid.
    rr_fvar = lr_fvar.
    EXIT.
  ENDLOOP.
  CHECK rr_fvar IS NOT BOUND.

* Load the fvar if specified.
  CHECK i_load = abap_true.
  rr_fvar = cl_ish_fvar=>load( i_viewtype = i_viewtype
                               i_id       = i_fvarid ).
  IF rr_fvar IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_fvar
      EXPORTING
        g_viewtype = i_viewtype
        g_fvarid = i_fvarid.
  ENDIF.

* Register the loaded fvar.
  APPEND rr_fvar TO gt_fvar.

ENDMETHOD.
ENDCLASS.
