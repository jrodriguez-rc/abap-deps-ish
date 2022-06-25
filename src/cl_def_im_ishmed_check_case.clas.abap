class CL_DEF_IM_ISHMED_CHECK_CASE definition
  public
  final
  create public .

public section.
*"* public components of class CL_DEF_IM_ISHMED_CHECK_CASE
*"* do not include other source files here!!!

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ISHMED_CHECK_CASE_VALID .
protected section.
*"* protected components of class CL_DEF_IM_ISHMED_CHECK_CASE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_DEF_IM_ISHMED_CHECK_CASE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_DEF_IM_ISHMED_CHECK_CASE IMPLEMENTATION.


METHOD if_ex_ishmed_check_case_valid~check_case_valid.

  DATA: ls_tn00r TYPE tn00r.

  CLEAR: e_err_level_accounted, e_err_level_closed.

  IF i_check_accounted = 'X'.
    CLEAR ls_tn00r.
    PERFORM ren00r IN PROGRAM sapmnpa0 USING i_einri 'N1CHKABR' ls_tn00r-value.
    WRITE ls_tn00r-value(1) TO e_err_level_accounted.
  ENDIF.

  IF i_check_closed = 'X'.

    IF i_closed = 1.            "GT: 05.08.2015, MED-59949
      e_err_level_closed = 'E'. "GT: 05.08.2015, MED-59949
    ELSE.                       "GT: 05.08.2015, MED-59949

      CLEAR ls_tn00r.
      PERFORM ren00r IN PROGRAM sapmnpa0 USING i_einri 'N1ANFNST' ls_tn00r-value.
      WRITE ls_tn00r-value(1) TO e_err_level_closed.

    ENDIF.                      "GT: 05.08.2015, MED-59949

  ENDIF.

ENDMETHOD.
ENDCLASS.
