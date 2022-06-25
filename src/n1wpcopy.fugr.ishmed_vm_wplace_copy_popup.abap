FUNCTION ishmed_vm_wplace_copy_popup.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_TEXT) TYPE  NWPLACETXT DEFAULT SPACE
*"     VALUE(I_TITEL) TYPE  CHAR40 DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_TEXT) TYPE  NWPLACETXT
*"     VALUE(E_VIEWS_COPY) TYPE  CHAR1
*"     VALUE(E_VARIANTS_COPY) TYPE  CHAR1
*"  EXCEPTIONS
*"      CANCEL
*"----------------------------------------------------------------------
  CLEAR: e_text, g_ptitel, g_text_place, g_rb_p, g_rb_pv, g_rb_pvv,
         e_views_copy, e_variants_copy.

  g_text_place = i_text.
  g_ptitel     = i_titel.
  IF g_ptitel IS INITIAL.
    g_ptitel = 'Arbeitsumfeld kopieren'(008).
  ENDIF.

  g_rb_p = on.

  CALL SCREEN 200 STARTING AT 16 8
                  ENDING   AT 84 13.

  IF g_ok_code = 'ENTR'.
    e_text = g_text_place.
    IF g_rb_p = on.
*     Nur Arbeitsumfeld kopieren, Sichten und Varianten belassen
      e_views_copy    = 'Z'.
      e_variants_copy = 'Z'.
    ELSEIF g_rb_pv = on.
*     Nur Arbeitsumfeld und Sichten kopieren, Varianten belassen
      e_views_copy    = 'C'.
      e_variants_copy = 'Z'.
    ELSE.
*     Arbeitsumfeld, Sichten und Varianten kopieren
      e_views_copy    = 'C'.
      e_variants_copy = 'C'.
    ENDIF.
  ELSE.
    RAISE cancel.
  ENDIF.

ENDFUNCTION.
