class CL_ISHMED_TC_TOOLS definition
  public
  final
  create public .

public section.

  class-methods SHOW_MATRIX_FO_USER
    importing
      !I_INSTITUTION_ID type EINRI
      !I_UNAME type XUBNAME .
protected section.
private section.
ENDCLASS.



CLASS CL_ISHMED_TC_TOOLS IMPLEMENTATION.


METHOD show_matrix_fo_user.
*----------------------------------------------------------
  DATA lr_badi              TYPE REF TO ishmed_tc_build_matrix.
  DATA lt_tc_matrix         TYPE rn1tc_matrix_t.
*----------------------------------------------------------

*get Matrix only once
  TRY.
      GET BADI lr_badi.
    CATCH cx_badi_not_implemented.
  ENDTRY.

  CHECK lr_badi IS BOUND.

  TRY.
      CALL BADI lr_badi->build_matrix_for_user
        EXPORTING
          i_institution_id = i_institution_id
          i_uname          = i_uname
        IMPORTING
          et_tc_matrix     = lt_tc_matrix.
    CATCH cx_ishmed_tc_cust.
      RETURN.
    CATCH cx_ishmed_tc.
      RETURN.
  ENDTRY.

  CALL FUNCTION 'ISHMED_TC_SHOW_MATRIX'
    EXPORTING
      i_institution_id = i_institution_id
      it_matrix        = lt_tc_matrix.

ENDMETHOD.
ENDCLASS.
