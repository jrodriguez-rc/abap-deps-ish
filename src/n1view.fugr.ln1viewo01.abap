*----------------------------------------------------------------------*
***INCLUDE LN1VIEWO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  INIT_CUA  OUTPUT
*&---------------------------------------------------------------------*
MODULE init_cua OUTPUT.

  CASE sy-dynnr.
    WHEN '0100'.
*     Titel des 'Sicht pflegen'-Popups
      CLEAR g_title_100.
      CASE g_vcode.
        WHEN g_vcode_insert.
          g_title_100 = 'Sicht anlegen'(001).
        WHEN g_vcode_update.
          g_title_100 = 'Sicht ändern'(002).
        WHEN OTHERS.
          g_title_100 = 'Sicht anzeigen'(003).
      ENDCASE.
      SET TITLEBAR 'VIEW' WITH g_title_100.
      PERFORM fill_excltab.
      SET PF-STATUS 'VIEW' EXCLUDING gt_ex_fct.
  ENDCASE.

ENDMODULE.                 " INIT_CUA  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  INIT_100  OUTPUT
*&---------------------------------------------------------------------*
MODULE init_100 OUTPUT.

  PERFORM init_100.

ENDMODULE.                 " INIT_100  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  PERFORM modify_screen.

ENDMODULE.                 " MODIFY_SCREEN  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  GET_VAR_TEXTS  OUTPUT
*&---------------------------------------------------------------------*
*       Texte der Varianten holen
*----------------------------------------------------------------------*
MODULE get_var_texts OUTPUT.

  PERFORM get_var_texts USING    on on on
                                 rn1_scr_view100-svarid rn1_scr_view100-avarid rn1_scr_view100-fvarid
                                 g_viewvar-reports g_viewvar-reporta
                                 g_viewvar-viewtype
                                 g_viewvar-viewid
                        CHANGING rn1_scr_view100-svar_txt
                                 rn1_scr_view100-avar_txt
                                 rn1_scr_view100-fvar_txt.

ENDMODULE.                 " GET_VAR_TEXTS  OUTPUT
