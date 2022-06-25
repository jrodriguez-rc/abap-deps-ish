FUNCTION ishmed_read_n1aufgt.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VORGANG) TYPE  N1VORGANG
*"  EXPORTING
*"     VALUE(E_TXT) TYPE  N1AUFGT-TXT
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"----------------------------------------------------------------------

  STATICS: lt_n1aufgt  TYPE HASHED TABLE OF n1aufgt
                       WITH UNIQUE KEY spras vorgang,
           l_n1aufgt   LIKE LINE OF lt_n1aufgt.

  e_rc = 0.
  CLEAR: e_txt.

  CHECK NOT i_vorgang IS INITIAL.

  READ TABLE lt_n1aufgt INTO l_n1aufgt
                        WITH TABLE KEY spras   = sy-langu
                                       vorgang = i_vorgang.
  IF sy-subrc <> 0.
    SELECT SINGLE * FROM n1aufgt INTO l_n1aufgt
           WHERE  spras    = sy-langu
           AND    vorgang  = i_vorgang.
    IF sy-subrc = 0.
      INSERT l_n1aufgt INTO TABLE lt_n1aufgt.
    ELSE.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.

  e_txt = l_n1aufgt-txt.

ENDFUNCTION.
