FUNCTION ISHMED_READ_N1ZPI .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_EINRI) TYPE  EINRI
*"     VALUE(I_ZPIE) TYPE  N1ZPI-ZPIE OPTIONAL
*"     VALUE(I_ZPI) TYPE  N1ZPI-ZPI OPTIONAL
*"  EXPORTING
*"     VALUE(E_ZPIE) TYPE  N1ZPI-ZPIE
*"     VALUE(E_ZPI) TYPE  N1ZPI-ZPI
*"     VALUE(E_ZPITXT) TYPE  N1ZPIT-ZPITXT
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"----------------------------------------------------------------------

  STATICS: lt_n1zpi      TYPE HASHED TABLE OF n1zpi
                         WITH UNIQUE KEY einri zpie,
           l_n1zpi       LIKE LINE OF lt_n1zpi,
           lt_n1zpit     TYPE HASHED TABLE OF n1zpit
                         WITH UNIQUE KEY einri zpie,
           l_n1zpit      LIKE LINE OF lt_n1zpit.

  e_rc = 0.
  CLEAR: e_zpie, e_zpi, e_zpitxt.

  READ TABLE lt_n1zpi TRANSPORTING NO FIELDS WITH KEY einri = i_einri.
  IF sy-subrc <> 0.
    SELECT * FROM n1zpi INTO TABLE lt_n1zpi
                WHERE einri = i_einri.
    IF sy-subrc = 0.
      SELECT * FROM n1zpit INTO TABLE lt_n1zpit
             WHERE  spras  = sy-langu
             AND    einri  = i_einri.
    ENDIF.
  ENDIF.

  IF NOT i_zpie IS INITIAL.
    READ TABLE lt_n1zpi INTO l_n1zpi WITH TABLE KEY einri = i_einri
                                                    zpie  = i_zpie.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ELSEIF NOT i_zpi IS INITIAL.
    READ TABLE lt_n1zpi INTO l_n1zpi WITH KEY einri = i_einri
                                              zpi   = i_zpi.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ELSE.
    e_rc = 1.
    EXIT.
  ENDIF.

  e_zpie = l_n1zpi-zpie.
  e_zpi  = l_n1zpi-zpi.

  READ TABLE lt_n1zpit INTO l_n1zpit WITH TABLE KEY einri = i_einri
                                                    zpie  = e_zpie.
  IF sy-subrc = 0.
    e_zpitxt = l_n1zpit-zpitxt.
  ENDIF.

ENDFUNCTION.
