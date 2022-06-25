*----------------------------------------------------------------------*
***INCLUDE LN1WPLI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
MODULE exit INPUT.

  IF sy-dynnr = '0300'.
    g_save_ok_code_300 = ok-code.
  ELSE.
    g_save_ok_code = ok-code.
  ENDIF.
  CLEAR ok-code.

  CASE sy-dynnr.
    WHEN '0100'.
      CASE g_save_ok_code.
        WHEN 'ECAN' OR 'END' OR 'BACK'.
          IF g_error = off.
            IF g_vcode                   = g_vcode_insert  OR
               rn1_scr_wpl101           <> g_place_old     OR
               rn1_scr_wpl100-place_txt <> g_place_txt_old OR
               gt_nwpvz[]               <> gt_nwpvz_old[]  OR
               g_subscreen_changed       = on.
              PERFORM popup_to_confirm(sapmnpa0)
                      USING ' ' 'Nicht gespeicherte Änderungen'(007)
                                'gehen verloren. Daten sichern?'(008)
                                'Arbeitsumfeldpflege beenden'(009) g_yn.
              CASE g_yn.
                WHEN 'J'.               " Yes
                  g_save_ok_code = 'SAVE'.
                  PERFORM save_wplace.
                WHEN 'A'.               " Cancel
                  EXIT.                            " am Dynpro bleiben
                WHEN OTHERS.            " No
              ENDCASE.
            ENDIF.
          ENDIF.
          SET SCREEN 0. LEAVE SCREEN.
      ENDCASE.
    WHEN '0200'.
      CASE g_save_ok_code.
        WHEN 'ECAN'.
          SET SCREEN 0. LEAVE SCREEN.
      ENDCASE.
    WHEN '0300'.
      CASE g_save_ok_code_300.
        WHEN 'ECAN'.
          SET SCREEN 0. LEAVE SCREEN.
      ENDCASE.
  ENDCASE.

ENDMODULE.                 " EXIT  INPUT

*&---------------------------------------------------------------------*
*&      Module  OK_CODE  INPUT
*&---------------------------------------------------------------------*
MODULE ok_code INPUT.

  CASE sy-dynnr.
    WHEN '0100'.
      PERFORM ok_code_100.
    WHEN '0200'.
      PERFORM ok_code_200.
    WHEN '0300'.
      PERFORM ok_code_300.
  ENDCASE.

ENDMODULE.                 " OK_CODE  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_WPLACEID  INPUT
*&---------------------------------------------------------------------*
*       Prüfung Arbeitsumfeld-ID
*----------------------------------------------------------------------*
MODULE check_wplaceid INPUT.

  PERFORM check_wplaceid.

ENDMODULE.                 " CHECK_WPLACEID  INPUT

*&---------------------------------------------------------------------*
*&      Module  SET_SUBSCREEN  INPUT
*&---------------------------------------------------------------------*
*       Daten an den Subscreen übergeben
*----------------------------------------------------------------------*
MODULE set_subscreen INPUT.

  PERFORM set_subscreen.

ENDMODULE.                 " SET_SUBSCREEN  INPUT

*&---------------------------------------------------------------------*
*&      Module  GET_SUBSCREEN  INPUT
*&---------------------------------------------------------------------*
*       Daten vom Subscreen holen
*----------------------------------------------------------------------*
MODULE get_subscreen INPUT.

  PERFORM get_subscreen.

ENDMODULE.                 " GET_SUBSCREEN  INPUT

*&---------------------------------------------------------------------*
*&      Module  UPDATE_GT_NWPLACE  INPUT
*&---------------------------------------------------------------------*
*       Globale Arbeitsumfeld Tabelle mit geänderten Daten aktualisieren
*----------------------------------------------------------------------*
MODULE update_gt_nwplace INPUT.

  PERFORM update_gt_nwplace.

ENDMODULE.                 " UPDATE_GT_NWPLACE  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_VDEFAULT  INPUT
*&---------------------------------------------------------------------*
*       Default-Kz prüfen: es darf nur für 1 Sicht gesetzt werden
*----------------------------------------------------------------------*
MODULE check_vdefault INPUT.

  PERFORM check_vdefault.

ENDMODULE.                 " CHECK_VDEFAULT  INPUT

*&---------------------------------------------------------------------*
*&      Module  CHECK_SORTID  INPUT
*&---------------------------------------------------------------------*
*       SORTID prüfen: es sollen nicht doppelte SORTIDs vorkommen
*----------------------------------------------------------------------*
MODULE check_sortid INPUT.

  PERFORM check_sortid.

ENDMODULE.                 " CHECK_SORTID  INPUT
