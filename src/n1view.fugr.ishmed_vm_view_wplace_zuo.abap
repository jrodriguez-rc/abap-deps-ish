FUNCTION ishmed_vm_view_wplace_zuo.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_PLACE) LIKE  NWPLACE STRUCTURE  NWPLACE
*"     REFERENCE(I_VIEW) LIKE  NWVIEW STRUCTURE  NWVIEW
*"     REFERENCE(I_VIEW_TXT) LIKE  NWVIEWT-TXT
*"     VALUE(I_VDEFAULT) LIKE  NWPVZ-VDEFAULT DEFAULT ' '
*"     VALUE(I_SORTID) LIKE  NWPVZ-SORTID DEFAULT '   '
*"     REFERENCE(I_REPLACE) TYPE  ISH_ON_OFF DEFAULT ' '
*"     REFERENCE(I_CALLER) LIKE  SY-REPID
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT ' '
*"     VALUE(I_SAVE) TYPE  ISH_ON_OFF DEFAULT 'X'
*"  EXPORTING
*"     REFERENCE(E_ALREADY) TYPE  ISH_ON_OFF
*"     REFERENCE(E_NWPVZ) LIKE  VNWPVZ STRUCTURE  VNWPVZ
*"     REFERENCE(E_NWPVZT) LIKE  VNWPVZT STRUCTURE  VNWPVZT
*"----------------------------------------------------------------------

  DATA: l_wa_nwpvz   LIKE nwpvz,
        l_wa_nwpvzt  LIKE nwpvzt,
        l_nwpvz      LIKE vnwpvz,
        l_nwpvzt     LIKE vnwpvzt,
        lt_all_nwpvz LIKE TABLE OF nwpvz,
        l_all_nwpvz  LIKE nwpvz,
        l_sortid     LIKE nwpvz-sortid,
        lt_n_nwpvz   LIKE TABLE OF vnwpvz,
        lt_o_nwpvz   LIKE TABLE OF vnwpvz,
        lt_n_nwpvzt  LIKE TABLE OF vnwpvzt,
        lt_o_nwpvzt  LIKE TABLE OF vnwpvzt.

  CLEAR: e_nwpvz, e_nwpvzt.

  SELECT SINGLE * FROM nwpvz INTO l_wa_nwpvz
         WHERE  wplacetype  = i_place-wplacetype
         AND    wplaceid    = i_place-wplaceid
         AND    viewtype    = i_view-viewtype
         AND    viewid      = i_view-viewid.

  if sy-subrc = 0.
    e_already = on.
  else.
    e_already = off.
  endif.

* Wenn noch keine Zuordnung besteht, oder
* wenn eine Zuordnung besteht und diese ersetzt werden soll,
* dann zuordnen
  IF e_already = off or
     e_already = on  and i_replace = on.
*   Falls eine Priorität übergeben wurde, diese verwenden; wenn nicht,
*   an letzter Stelle (höchstes SORTID) zum Arbeitsumfeld hinzufügen
    if i_sortid is initial or i_sortid = '   '.
      SELECT * FROM nwpvz INTO TABLE lt_all_nwpvz
             WHERE  wplacetype  = i_place-wplacetype
             AND    wplaceid    = i_place-wplaceid.            "#EC *
      IF sy-subrc <> 0.
        l_sortid = 1.
      ELSE.
        SORT lt_all_nwpvz BY sortid DESCENDING.
        READ TABLE lt_all_nwpvz INTO l_all_nwpvz INDEX 1.
        IF l_all_nwpvz-sortid = 999.
          l_sortid = 999.
        ELSE.
          l_sortid = l_all_nwpvz-sortid + 1.
        ENDIF.
      ENDIF.
    ELSE.
      l_sortid = i_sortid.
    ENDIF.
*   Zuordnung verbuchen
    CLEAR:   lt_n_nwpvz, lt_o_nwpvz, lt_n_nwpvzt, lt_o_nwpvzt.
    REFRESH: lt_n_nwpvz, lt_o_nwpvz, lt_n_nwpvzt, lt_o_nwpvzt.
    CLEAR: l_nwpvz, l_nwpvzt.
    if e_already = off.
*     Anlegen
      MOVE-CORRESPONDING i_place TO l_nwpvz.           "#EC ENHOK
      MOVE-CORRESPONDING i_view  TO l_nwpvz.           "#EC ENHOK
      MOVE-CORRESPONDING l_nwpvz TO l_nwpvzt.          "#EC ENHOK
      l_nwpvzt-spras = sy-langu.
      l_nwpvz-kz     = 'I'.
      l_nwpvzt-kz    = 'I'.
    else.
*     Ändern
      l_nwpvz = l_wa_nwpvz.
      SELECT SINGLE * FROM nwpvzt INTO l_wa_nwpvzt
             WHERE  wplacetype  = i_place-wplacetype
             AND    wplaceid    = i_place-wplaceid
             AND    viewtype    = i_view-viewtype
             AND    viewid      = i_view-viewid
             AND    spras       = sy-langu.
      IF sy-subrc = 0.
        l_nwpvzt = l_wa_nwpvzt.
        l_nwpvzt-kz = 'U'.
      else.
        MOVE-CORRESPONDING l_nwpvz TO l_nwpvzt.        "#EC ENHOK
        l_nwpvzt-spras = sy-langu.
        l_nwpvzt-kz    = 'I'.
      ENDIF.
      l_nwpvz-kz     = 'U'.
    endif.
*   Priorität, Default-KZ und Bezeichnung vergeben
    l_nwpvz-vdefault = i_vdefault.
    l_nwpvz-sortid   = l_sortid.
    l_nwpvzt-txt     = i_view_txt.
    APPEND l_nwpvz  TO lt_n_nwpvz.
    APPEND l_nwpvzt TO lt_n_nwpvzt.
    e_nwpvz  = l_nwpvz.
    e_nwpvzt = l_nwpvzt.
    IF i_save = on.
      IF i_update_task = off.
        CALL FUNCTION 'ISH_VERBUCHER_NWPVZ'
           EXPORTING
*             I_DATE    = SY-DATUM
              i_tcode   = sy-tcode
*             I_UNAME   = SY-UNAME
*             I_UTIME   = SY-UZEIT
           TABLES
              t_n_nwpvz = lt_n_nwpvz
              t_o_nwpvz = lt_o_nwpvz.
        CALL FUNCTION 'ISH_VERBUCHER_NWPVZT'
           EXPORTING
*             I_DATE     = SY-DATUM
              i_tcode    = sy-tcode
*             I_UNAME    = SY-UNAME
*             I_UTIME    = SY-UZEIT
           TABLES
              t_n_nwpvzt = lt_n_nwpvzt
              t_o_nwpvzt = lt_o_nwpvzt.
      ELSE.
        CALL FUNCTION 'ISH_VERBUCHER_NWPVZ' IN UPDATE TASK
           EXPORTING
*             I_DATE    = SY-DATUM
              i_tcode   = sy-tcode
*             I_UNAME   = SY-UNAME
*             I_UTIME   = SY-UZEIT
           TABLES
              t_n_nwpvz = lt_n_nwpvz
              t_o_nwpvz = lt_o_nwpvz.
        CALL FUNCTION 'ISH_VERBUCHER_NWPVZT' IN UPDATE TASK
           EXPORTING
*             I_DATE     = SY-DATUM
              i_tcode    = sy-tcode
*             I_UNAME    = SY-UNAME
*             I_UTIME    = SY-UZEIT
           TABLES
              t_n_nwpvzt = lt_n_nwpvzt
              t_o_nwpvzt = lt_o_nwpvzt.
      ENDIF.
      IF i_commit = on.
        COMMIT WORK AND WAIT.
      ENDIF.
*     Puffer mit den Arbeitsumfeld/Sicht-Daten des Benutzers aktual.
      perform refresh_personal_buffer using sy-uname i_place.
    ENDIF.
  ELSE.
*   Zuordnung besteht bereits und soll nicht ersetzt werden
    e_nwpvz   = l_wa_nwpvz.
    if e_nwpvzt is requested.
      SELECT SINGLE * FROM nwpvzt INTO l_wa_nwpvzt
             WHERE  wplacetype  = i_place-wplacetype
             AND    wplaceid    = i_place-wplaceid
             AND    viewtype    = i_view-viewtype
             AND    viewid      = i_view-viewid
             AND    spras       = sy-langu.
      IF sy-subrc = 0.
        e_nwpvzt = l_wa_nwpvzt.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFUNCTION.
