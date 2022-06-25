FUNCTION ISH_SET_PARAMETER_ID .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PARAMETER_ID) TYPE  ANY
*"     VALUE(I_PARAMETER_VALUE) TYPE  ANY OPTIONAL
*"     VALUE(I_SAVE_VALUE) TYPE  ISH_ON_OFF DEFAULT ' '
*"----------------------------------------------------------------------
  DATA: l_parameter TYPE usr05-parid,
        l_value     TYPE usr05-parva.

  CHECK NOT i_parameter_id IS INITIAL.

  SET PARAMETER ID i_parameter_id FIELD i_parameter_value.

  IF i_save_value = 'X'.
    l_parameter = i_parameter_id.
    l_value     = i_parameter_value.
    CALL FUNCTION 'ISH_USR05_SET'
      EXPORTING
        ss_bname         = sy-uname
        ss_parid         = l_parameter
        ss_value         = l_value
      EXCEPTIONS
        bname_is_initial = 1
        parid_is_initial = 2
        OTHERS           = 3.
  ENDIF.
ENDFUNCTION.
