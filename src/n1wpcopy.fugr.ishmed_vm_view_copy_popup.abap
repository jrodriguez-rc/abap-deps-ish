FUNCTION ishmed_vm_view_copy_popup.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_TEXT) TYPE  NVIEWSTXT DEFAULT SPACE
*"     VALUE(I_TITEL) TYPE  CHAR40 DEFAULT SPACE
*"     VALUE(I_CHECK_TEXT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"  EXPORTING
*"     VALUE(E_TEXT) TYPE  NVIEWSTXT
*"     VALUE(E_VARIANTS_COPY) TYPE  CHAR1
*"  EXCEPTIONS
*"      CANCEL
*"----------------------------------------------------------------------
  CLEAR: e_text, g_ptitel, g_text_view, g_rb_v, g_rb_vv,
         e_variants_copy.

  g_text_view    = i_text.
  g_text_view_sv = i_text.                                  " ID 11478
  g_check_text   = i_check_text.                            " ID 11478
  g_ptitel       = i_titel.
  IF g_ptitel IS INITIAL.
    g_ptitel = 'Sicht kopieren'(009).
  ENDIF.

  g_rb_v = on.

  CALL SCREEN 300 STARTING AT 16 8
                  ENDING   AT 84 12.

  IF g_ok_code = 'ENTR'.
    e_text = g_text_view.
    IF g_rb_v = on.
*     Nur Sicht kopieren, Varianten belassen
      e_variants_copy = 'Z'.
    ELSE.
*     Sicht und Varianten kopieren
      e_variants_copy = 'C'.
    ENDIF.
  ELSE.
    RAISE cancel.
  ENDIF.

ENDFUNCTION.
