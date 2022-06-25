FUNCTION ishmed_tc_switch_off_by_func.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_FCODE) TYPE  SY-UCOMM
*"----------------------------------------------------------------------
  DATA l_check_on TYPE ish_on_off VALUE if_ish_constant_definition=>on.

  CALL FUNCTION 'ISH_TC_SWITCH_OFF_BY_FUNCTION'
    EXPORTING
      i_fcode = i_fcode.

  CALL FUNCTION 'ISH_TC_SWITCH_OFF_CHECK'
    CHANGING
      c_check_tc = l_check_on.

  IF l_check_on = if_ish_constant_definition=>on.
* don't check the treatment contract for certain functions
*    create a new preregistration or appointment
    IF i_fcode = 'N1TC_TEST' OR i_fcode = 'TC_DELEG' or i_fcode = 'GO_PREV' or
       i_fcode = 'GO_NEXT'   or i_fcode = 'ACRE'     or i_fcode = 'PPERIOD' or
       i_fcode = 'NPERIOD'   or i_fcode = 'PLWE'     or i_fcode = 'SNAL' or
       i_fcode = 'SKAL'      or i_fcode = 'ANAL'     or i_fcode = 'CORDI_A_M' or
       i_fcode = 'CALENDAR'  or i_fcode = 'AKAL'     or i_fcode = 'NDAY' or
       i_fcode = 'PDAY'      or i_fcode = 'ANFI'     or i_fcode = 'PAST' or
       i_fcode = 'AAAL'      or i_fcode = 'SAAL'.
*    treatment contract should not be checked for the current function
      EXPORT ish_tc_switched_off = if_ish_constant_definition=>on TO MEMORY ID 'ISH_TC_SWITCHED_OFF'.
    ENDIF.
  ENDIF.

ENDFUNCTION.
