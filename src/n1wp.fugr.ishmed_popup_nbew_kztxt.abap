FUNCTION ishmed_popup_nbew_kztxt.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_TITEL) TYPE  ANY OPTIONAL
*"     REFERENCE(I_VCODE) TYPE  TNDYM-VCODE DEFAULT 'UPD'
*"     REFERENCE(I_NBEW) TYPE  NBEW
*"  EXPORTING
*"     REFERENCE(E_NBEW) TYPE  NBEW
*"  EXCEPTIONS
*"      CANCEL
*"----------------------------------------------------------------------

  DATA: l_nbew    TYPE nbew.

  CLEAR: nbew, e_nbew, g_titel, g_pvcode, g_pop_ok_code, l_nbew.

  g_pvcode = i_vcode.

  IF i_titel IS INITIAL.
    g_titel = 'Bemerkung der Bewegung ändern'(007).
  ELSE.
    g_titel = i_titel.
  ENDIF.

* Aktuelle Bemerkung der Bewegung einlesen
  SELECT SINGLE * FROM nbew
         WHERE  einri  = i_nbew-einri
         AND    falnr  = i_nbew-falnr
         AND    lfdnr  = i_nbew-lfdnr.
  CHECK sy-subrc = 0.
  l_nbew = nbew.

  CALL SCREEN 100 STARTING AT  8 6
                  ENDING   AT 80 8.

  IF g_pop_ok_code = 'ENTR'.
    IF nbew-kztxt <> l_nbew-kztxt.
*     Bemerkung der Bewegung updaten
      UPDATE nbew SET kztxt = nbew-kztxt WHERE einri = nbew-einri
                                           AND falnr = nbew-falnr
                                           AND lfdnr = nbew-lfdnr.
      COMMIT WORK AND WAIT.
    ENDIF.
    e_nbew = nbew.
  ELSE.
    RAISE cancel.                                         "#EC RAISE_OK
  ENDIF.

ENDFUNCTION.
