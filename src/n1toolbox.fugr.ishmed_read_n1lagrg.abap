FUNCTION ishmed_read_n1lagrg .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_EINRI) TYPE  EINRI
*"     VALUE(I_LIDE) TYPE  N1LAGRG-LIDE OPTIONAL
*"     VALUE(I_LIDI) TYPE  N1LAGRG-LIDI OPTIONAL
*"  EXPORTING
*"     VALUE(E_LIDE) TYPE  N1LAGRG-LIDE
*"     VALUE(E_LIDI) TYPE  N1LAGRG-LIDI
*"     VALUE(E_LGRBEZ) TYPE  N1LAGRGT-LGRBEZ
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"----------------------------------------------------------------------

  STATICS: lt_n1lagrg    TYPE HASHED TABLE OF n1lagrg
                         WITH UNIQUE KEY einri lide,
           l_n1lagrg     LIKE LINE OF lt_n1lagrg,
           lt_n1lagrgt   TYPE HASHED TABLE OF n1lagrgt
                         WITH UNIQUE KEY einri lide,
           l_n1lagrgt    LIKE LINE OF lt_n1lagrgt.

  DATA:    lt_n1lagrg_help TYPE TABLE OF n1lagrg,       "MED-81978
           ls_n1lagrg TYPE n1lagrg.                     "MED-81978

  e_rc = 0.
  CLEAR: e_lide, e_lidi, e_lgrbez.

  READ TABLE lt_n1lagrg TRANSPORTING NO FIELDS WITH KEY einri = i_einri.
  IF sy-subrc <> 0.
    SELECT * FROM n1lagrg INTO TABLE lt_n1lagrg
                WHERE einri = i_einri.
    IF sy-subrc = 0.
      SELECT * FROM n1lagrgt INTO TABLE lt_n1lagrgt
             WHERE  spras  = sy-langu
             AND    einri  = i_einri.
    ENDIF.
  ENDIF.

  IF NOT i_lide IS INITIAL.
    READ TABLE lt_n1lagrg INTO l_n1lagrg WITH TABLE KEY einri = i_einri
                                                        lide  = i_lide.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ELSEIF NOT i_lidi IS INITIAL.
*   BEGIN MED-81978
*    READ TABLE lt_n1lagrg INTO l_n1lagrg WITH KEY einri = i_einri
*                                                  loekz = ' '        "MED-55666 NedaV
*                                                  lidi  = i_lidi.
*    IF sy-subrc <> 0.
*      e_rc = 1.
*      EXIT.
*    ENDIF.
    CLEAR lt_n1lagrg_help[].
    CLEAR ls_n1lagrg.
    LOOP AT lt_n1lagrg INTO ls_n1lagrg WHERE einri = i_einri AND
                                             lidi  = i_lidi.
      APPEND ls_n1lagrg TO lt_n1lagrg_help.
    ENDLOOP.
    DESCRIBE TABLE lt_n1lagrg_help.
    IF sy-tfill > 1. "if there are more entries, only the value without LOEKZ should be displayed. see def. in MED-33340
      READ TABLE lt_n1lagrg_help INTO l_n1lagrg WITH KEY einri = i_einri
                                                  loekz = ' '
                                                  lidi  = i_lidi.
      IF sy-subrc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ELSEIF sy-tfill = 1. "if there is only one entry, ignore LOEKZ for display. see definition in MED-33340
      READ TABLE lt_n1lagrg_help INTO l_n1lagrg WITH KEY einri = i_einri
                                                  lidi  = i_lidi.
      IF sy-subrc <> 0.
        e_rc = 1.
        EXIT.
      ENDIF.
    ELSE.
      e_rc = 1.
      EXIT.
    ENDIF.
*   END MED-81978
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.

  e_lide = l_n1lagrg-lide.
  e_lidi = l_n1lagrg-lidi.

  READ TABLE lt_n1lagrgt INTO l_n1lagrgt WITH TABLE KEY einri = i_einri
                                                        lide  = e_lide.
  IF sy-subrc = 0.
    e_lgrbez = l_n1lagrgt-lgrbez.
  ENDIF.

ENDFUNCTION.
