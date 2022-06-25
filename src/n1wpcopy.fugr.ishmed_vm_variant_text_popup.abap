FUNCTION ishmed_vm_variant_text_popup.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_TEXT) TYPE  CHAR50 DEFAULT SPACE
*"     VALUE(I_TITEL) TYPE  CHAR40 DEFAULT SPACE
*"     VALUE(I_TYPE) TYPE  CHAR1 DEFAULT SPACE
*"     VALUE(I_VCODE) TYPE  TNDYM-VCODE DEFAULT 'UPD'
*"  EXPORTING
*"     VALUE(E_TEXT) TYPE  CHAR50
*"  EXCEPTIONS
*"      CANCEL
*"----------------------------------------------------------------------
  CLEAR: e_text, g_ptitel, g_text_allg, g_pvcode, g_type,
         g_text_svar, g_text_avar, g_text_fvar.

  g_ptitel = i_titel.
  g_pvcode = i_vcode.
  g_type   = i_type.

  CASE g_type.
    WHEN 'S'.
      g_text_svar = i_text.
      IF g_ptitel IS INITIAL.
        g_ptitel = 'Bezeichnung der Selektionsvariante'(001).
      ENDIF.
    WHEN 'A'.
      g_text_avar = i_text.
      IF g_ptitel IS INITIAL.
        g_ptitel = 'Bezeichnung des Layouts'(002).
      ENDIF.
    WHEN 'F'.
      g_text_fvar = i_text.
      IF g_ptitel IS INITIAL.
        g_ptitel = 'Bezeichnung der Funktionsvariante'(003).
      ENDIF.
    WHEN OTHERS.
      g_text_allg = i_text.
      IF g_ptitel IS INITIAL.
        g_ptitel = 'Bezeichnung'(004).
      ENDIF.
  ENDCASE.

  CALL SCREEN 100 STARTING AT  8 6
                  ENDING   AT 74 7.

  IF g_ok_code = 'ENTR'.
    CASE g_type.
      WHEN 'S'.
        e_text = g_text_svar.
      WHEN 'A'.
        e_text = g_text_avar.
      WHEN 'F'.
        e_text = g_text_fvar.
      WHEN OTHERS.
        e_text = g_text_allg.
    ENDCASE.
  ELSE.
    RAISE cancel.
  ENDIF.

ENDFUNCTION.
