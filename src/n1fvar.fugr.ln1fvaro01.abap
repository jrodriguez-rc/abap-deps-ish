*----------------------------------------------------------------------*
***INCLUDE LN1FVARO01 .
*----------------------------------------------------------------------*

*---------------------------------------------------------------------*
*      Module  INIT_CUA  OUTPUT
*---------------------------------------------------------------------*
MODULE init_cua OUTPUT.

  DATA: l_wa_nwfvar  LIKE v_nwfvar.

  CASE sy-dynnr.
*   Pflegedynpro
    WHEN '0100'.
      IF NOT g_title IS INITIAL.
        SET TITLEBAR 'ALL' WITH g_title.
      ELSE.
        IF g_vcode = g_vcode_insert.
          SET TITLEBAR 'D101'.                       " anlegen
        ELSEIF g_vcode = g_vcode_update.
          READ TABLE gt_nwfvar INTO l_wa_nwfvar INDEX 1.
          IF sy-subrc <> 0.
            CLEAR l_wa_nwfvar.
          ENDIF.
          IF l_wa_nwfvar-txt IS INITIAL AND g_translation = on.
            l_wa_nwfvar-txt = 'Übersetzung'(025).
          ELSEIF g_translation = on.
            CONCATENATE l_wa_nwfvar-txt 'Übersetzung'(025)
                   INTO l_wa_nwfvar-txt SEPARATED BY space.
          ENDIF.
          SET TITLEBAR 'D100' WITH l_wa_nwfvar-txt.  " ändern
        ENDIF.
      ENDIF.
      PERFORM fill_excltab.
      SET PF-STATUS 'CHANGE' EXCLUDING gt_ex_fkt.
  ENDCASE.    " CASE SY-DYNNR

ENDMODULE.    " INIT_CUA

*&---------------------------------------------------------------------*
*&      Module  INIT_ALL  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_all OUTPUT.
  PERFORM init_all.
ENDMODULE.                 " INIT_ALL  OUTPUT

*---------------------------------------------------------------------
* MODIFY_SCREEN
* Durchführen einiger Screen-Modifikationen
*---------------------------------------------------------------------
MODULE modify_screen OUTPUT.
  PERFORM modify_screen.
ENDMODULE.   " MODIFY_SCREEN
*&---------------------------------------------------------------------*
*&      Module  STATUS_0200  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0200 OUTPUT.

  SET TITLEBAR 'TIT200'.
  SET PF-STATUS 'D200'.

  PERFORM init_cua_d200.

ENDMODULE.                 " STATUS_0200  OUTPUT
