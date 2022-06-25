*----------------------------------------------------------------------*
***INCLUDE LN1WPLO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  INIT_CUA  OUTPUT
*&---------------------------------------------------------------------*
*       CUA-Status und Titel setzen
*----------------------------------------------------------------------*
MODULE init_cua OUTPUT.

  CASE sy-dynnr.
    WHEN '0100'.
*     Titel des Dynpro 'Arbeitsumfeld pflegen'
      CLEAR g_title_100.
      CASE g_vcode.
        WHEN g_vcode_insert.
          g_title_100 = 'Arbeitsumfeld anlegen'(001).
        WHEN g_vcode_update.
          g_title_100 = 'Arbeitsumfeld ändern'(002).
        WHEN OTHERS.
          g_title_100 = 'Arbeitsumfeld anzeigen'(003).
      ENDCASE.
      SET TITLEBAR 'PLACE' WITH g_title_100.
      PERFORM fill_excltab.
      SET PF-STATUS 'PLACE' EXCLUDING gt_ex_fct.
    WHEN '0200'.
*     Titel des Popups 'Arbeitsumfeld anlegen'
      CLEAR g_title_200.
      g_title_200 = 'Arbeitsumfeld anlegen'(001).
      SET TITLEBAR 'P200' WITH g_title_200.
      SET PF-STATUS 'P200'.
    WHEN '0300'.
*     Titel des Popups 'Daten der Arbeitsumfeld/Sicht-Zuordnung ändern'
      CLEAR g_title_300.
      g_title_300 = 'Daten der Zuordnung ändern'(035).
      SET TITLEBAR 'P300' WITH g_title_300.
      SET PF-STATUS 'P300'.
      IF rn1_scr_wpl301-viewtxt IS INITIAL.
        SELECT SINGLE txt FROM nwviewt INTO rn1_scr_wpl301-viewtxt
               WHERE  viewtype  = rn1_scr_wpl300-viewtype
               AND    viewid    = rn1_scr_wpl300-viewid
               AND    spras     = sy-langu.
      ENDIF.
  ENDCASE.

ENDMODULE.                 " INIT_CUA  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  INIT_200  OUTPUT
*&---------------------------------------------------------------------*
*       Dynpro 200 (Popup Arbeitsumfeld anlegen) initialisieren
*----------------------------------------------------------------------*
MODULE init_200 OUTPUT.

  PERFORM init_200.

ENDMODULE.                 " INIT_200  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  INIT_100  OUTPUT
*&---------------------------------------------------------------------*
*       Dynpro 100 (Popup Arbeitsumfeld pflegen) initialisieren
*----------------------------------------------------------------------*
MODULE init_100 OUTPUT.

  PERFORM init_100.

ENDMODULE.                 " INIT_100  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  INIT_SUBSCREEN  OUTPUT
*&---------------------------------------------------------------------*
*       Subscreen 'Spezielle Daten des Arbeitsumfelds' initialisieren
*----------------------------------------------------------------------*
MODULE init_subscreen OUTPUT.

  PERFORM init_subscreen.

ENDMODULE.                 " INIT_SUBSCREEN  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  MODIFY_SCREEN  OUTPUT
*&---------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  PERFORM modify_screen.

ENDMODULE.                 " MODIFY_SCREEN  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  SET_LAUNCH_PAD  OUTPUT
*&---------------------------------------------------------------------*
*       Vorschau (Launch Pad) befüllen
*----------------------------------------------------------------------*
MODULE set_launch_pad OUTPUT.

  PERFORM set_launch_pad.

ENDMODULE.                 " SET_LAUNCH_PAD  OUTPUT

*&---------------------------------------------------------------------*
*&      Module  SET_VIEW_TREE  OUTPUT
*&---------------------------------------------------------------------*
*       Vorrat an Sichten (Column Tree in Container) befüllen
*----------------------------------------------------------------------*
MODULE set_view_tree OUTPUT.

  PERFORM set_view_tree.
  SET CURSOR FIELD 'RN1_SCR_WPL100-PLACE_TXT'.

ENDMODULE.                 " SET_VIEW_TREE  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  init_300  OUTPUT
*&---------------------------------------------------------------------*
*       Dynpro 300 (Popup Details der Zuordung pflegen) initialisieren
*----------------------------------------------------------------------*
MODULE init_300 OUTPUT.

  PERFORM init_300.

ENDMODULE.                 " init_300  OUTPUT
