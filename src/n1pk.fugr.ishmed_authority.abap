FUNCTION ishmed_authority.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_MSG) TYPE  XFELD DEFAULT 'X'
*"  EXCEPTIONS
*"      ISHMED_NOT_ACTIV
*"----------------------------------------------------------------------

  CHECK cl_ishmed_utl_webdynpro=>is_config_editor_running( ) = abap_false.

  SELECT SINGLE * FROM tn00
    WHERE keyfil = '1'.
  IF sy-subrc NE 0 OR tn00-ishmed <> 'X'.
    IF i_msg = 'X'.
      MESSAGE e012(n1base) RAISING ishmed_not_activ.
    ELSE.
*     Koppensteiner, 22.07.2002:
*     korrekter Name der Ausnahme: ishmed_not_activ!!!
*     und nicht ishmed_not_active
      RAISE ishmed_not_activ.
    ENDIF.
  ENDIF.

ENDFUNCTION.
