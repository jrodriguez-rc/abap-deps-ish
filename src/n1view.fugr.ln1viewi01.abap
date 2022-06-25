*----------------------------------------------------------------------*
***INCLUDE LN1VIEWI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  OK_CODE  INPUT
*&---------------------------------------------------------------------*
MODULE ok_code INPUT.

  CASE sy-dynnr.
    WHEN '0100'.
      PERFORM ok_code_100.
  ENDCASE.

ENDMODULE.                 " OK_CODE  INPUT

*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
MODULE exit INPUT.

  PERFORM exit.

ENDMODULE.                 " EXIT  INPUT

*&---------------------------------------------------------------------*
*&      Module  HELP_SVAR  INPUT
*&---------------------------------------------------------------------*
*       F4-Auswahl für Selektionsvariante
*----------------------------------------------------------------------*
MODULE help_svar INPUT.

  PERFORM help_svar.

ENDMODULE.                 " HELP_SVAR  INPUT

*&---------------------------------------------------------------------*
*&      Module  HELP_AVAR  INPUT
*&---------------------------------------------------------------------*
*       F4-Auswahl für Anzeigevariante
*----------------------------------------------------------------------*
MODULE help_avar INPUT.

  PERFORM help_avar.

ENDMODULE.                 " HELP_AVAR  INPUT

*&---------------------------------------------------------------------*
*&      Module  HELP_FVAR  INPUT
*&---------------------------------------------------------------------*
*       F4-Auswahl für Funktionsvariante
*----------------------------------------------------------------------*
MODULE help_fvar INPUT.

  PERFORM help_fvar.

ENDMODULE.                 " HELP_FVAR  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_SVAR  INPUT
*&---------------------------------------------------------------------*
*       Prüfen der eingegebenen Selektionsvariante
*----------------------------------------------------------------------*
MODULE check_svar INPUT.

  PERFORM check_svar.

ENDMODULE.                 " CHECK_SVAR  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_AVAR  INPUT
*&---------------------------------------------------------------------*
*       Prüfen der eingegebenen Anzeigevariante
*----------------------------------------------------------------------*
MODULE check_avar INPUT.

  PERFORM check_avar.

ENDMODULE.                 " CHECK_AVAR  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_FVAR  INPUT
*&---------------------------------------------------------------------*
*       Prüfen der eingegebenen Funktionsvariante
*----------------------------------------------------------------------*
MODULE check_fvar INPUT.

  PERFORM check_fvar.

ENDMODULE.                 " CHECK_FVAR  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_VIEWTYPE  INPUT
*&---------------------------------------------------------------------*
*       Prüfen des eingegebenen Sichttyps
*----------------------------------------------------------------------*
MODULE check_viewtype INPUT.

  PERFORM check_viewtype.

ENDMODULE.                 " CHECK_VIEWTYPE  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_VIEWART  INPUT
*&---------------------------------------------------------------------*
*       Prüfen der eingegebenen Sichtart
*----------------------------------------------------------------------*
MODULE check_viewart INPUT.

  PERFORM check_viewart.

ENDMODULE.                 " CHECK_VIEWART  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_VIEWID  INPUT
*&---------------------------------------------------------------------*
*       Prüfen der eingegebenen Sicht-ID
*----------------------------------------------------------------------*
MODULE check_viewid INPUT.

  PERFORM check_viewid.

ENDMODULE.                 " CHECK_VIEWID  INPUT
*&---------------------------------------------------------------------*
*&      Module  check_vdefault  INPUT
*&---------------------------------------------------------------------*
*       Default-Kz prüfen: es darf nur für 1 Sicht gesetzt werden
*----------------------------------------------------------------------*
MODULE check_vdefault INPUT.

  PERFORM check_vdefault.

ENDMODULE.                 " check_vdefault  INPUT
*&---------------------------------------------------------------------*
*&      Module  CHECK_SORTID  INPUT
*&---------------------------------------------------------------------*
*       SORTID prüfen: es sollen nicht doppelte SORTIDs vorkommen
*----------------------------------------------------------------------*
MODULE check_sortid INPUT.

  PERFORM check_sortid.

ENDMODULE.                 " CHECK_SORTID  INPUT
*&---------------------------------------------------------------------*
*&      Module  check_zuo_txt  INPUT
*&---------------------------------------------------------------------*
*       Prüfen der Zuordnungsbezeichnung
*----------------------------------------------------------------------*
MODULE check_zuo_txt INPUT.

  PERFORM check_zuo_txt.

ENDMODULE.                 " check_zuo_txt  INPUT
*&---------------------------------------------------------------------*
*&      Module  check_refresh_interval  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE check_refresh_interval INPUT.

* an interval more than 60000 seconds really makes no sense ...
  IF rn1_scr_view100-rfsh_int > 60000.
    g_error = on.
    SET CURSOR FIELD 'RN1_SCR_VIEW100-RFSH_INT'.
    MESSAGE i023(n4).
    EXIT.
  ENDIF.

  gs_refresh-rfsh          = rn1_scr_view100-rfsh.
  gs_refresh-rfsh_interval = rn1_scr_view100-rfsh_int.

ENDMODULE.                 " check_refresh_interval  INPUT
