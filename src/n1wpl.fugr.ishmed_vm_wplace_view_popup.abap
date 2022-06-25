FUNCTION ishmed_vm_wplace_view_popup.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_V_NWPVZ) TYPE  V_NWPVZ
*"----------------------------------------------------------------------
  DATA: l_wa_nwpvz   LIKE v_nwpvz,
        l_v_nwpvz    LIKE v_nwpvz,
        l_wa_nwview  LIKE v_nwview,
        l_idx        LIKE sy-tabix.

* Initialisierung
  l_v_nwpvz = i_v_nwpvz.
  IF l_v_nwpvz-spras IS INITIAL.
    l_v_nwpvz-spras = sy-langu.
  ENDIF.

* Die Zuordnung Arbeitsumfeld/Sicht muß bereits im Puffer vorhanden sein
  READ TABLE gt_nwpvz INTO l_wa_nwpvz with key
                      wplacetype = l_v_nwpvz-wplacetype
                      wplaceid   = l_v_nwpvz-wplaceid
                      viewtype   = l_v_nwpvz-viewtype
                      viewid     = l_v_nwpvz-viewid.
  IF sy-subrc = 0.
    l_idx = sy-tabix.
    rn1_scr_wpl300 = l_wa_nwpvz.
    CLEAR rn1_scr_wpl301-viewtxt.
    g_first_time_300 = on.
    CALL SCREEN 300 STARTING AT 33 3 ENDING AT 93 6.
    IF g_save_ok_code_300 = 'ENTR'.
*     Geänderte Attribute im Puffer ändern
      l_wa_nwpvz-sortid   = rn1_scr_wpl300-sortid.
      l_wa_nwpvz-vdefault = rn1_scr_wpl300-vdefault.
      l_wa_nwpvz-txt      = rn1_scr_wpl300-txt.
      MODIFY gt_nwpvz FROM l_wa_nwpvz INDEX l_idx
                      TRANSPORTING sortid vdefault txt.
      LOOP AT gt_nwview INTO l_wa_nwview
                      WHERE viewtype = l_wa_nwpvz-viewtype
                        AND viewid   = l_wa_nwpvz-viewid.
        l_wa_nwview-txt = l_wa_nwpvz-txt.
        MODIFY gt_nwview FROM l_wa_nwview TRANSPORTING txt.
      ENDLOOP.
    ENDIF.
  ENDIF.

ENDFUNCTION.
