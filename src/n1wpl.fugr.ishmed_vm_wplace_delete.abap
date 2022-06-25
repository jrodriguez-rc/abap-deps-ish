FUNCTION ishmed_vm_wplace_delete.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_POPUP) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_BUFFER) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_wa_msg            LIKE bapiret2,
        nwpusz_count        TYPE i,
        l_del_zuo_only      LIKE off,
        l_del_user_only     LIKE off,
        l_popup             LIKE off,
        l_place             LIKE nwplace,
        lt_nwplace          LIKE TABLE OF vnwplace,
        lt_o_nwplace        LIKE TABLE OF vnwplace,
        l_nwplace           LIKE vnwplace,
        lt_nwplacet         LIKE TABLE OF vnwplacet,
        lt_o_nwplacet       LIKE TABLE OF vnwplacet,
        l_nwplacet          LIKE vnwplacet,
        lt_nwpusz           LIKE TABLE OF vnwpusz,
        lt_o_nwpusz         LIKE TABLE OF vnwpusz,
        l_nwpusz            LIKE vnwpusz,
        lt_nwpuszt          LIKE TABLE OF vnwpuszt,
        lt_o_nwpuszt        LIKE TABLE OF vnwpuszt,
        l_nwpuszt           LIKE vnwpuszt,
        lt_nwpvz            LIKE TABLE OF vnwpvz,
        lt_o_nwpvz          LIKE TABLE OF vnwpvz,
        l_nwpvz             LIKE vnwpvz,
        lt_nwpvzt           LIKE TABLE OF vnwpvzt,
        lt_o_nwpvzt         LIKE TABLE OF vnwpvzt,
        l_nwpvzt            LIKE vnwpvzt,
        l_nwplace_001       LIKE vnwplace_001,
        lt_nwplace_001      LIKE TABLE OF vnwplace_001,
        lt_o_nwplace_001    LIKE TABLE OF vnwplace_001,
        l_nwplace_p01       LIKE vnwplace_p01,
        lt_nwplace_p01      LIKE TABLE OF vnwplace_p01,
        lt_o_nwplace_p01    LIKE TABLE OF vnwplace_p01,
        l_allowed(1)        TYPE c,
        l_tablekey          LIKE e071k-tabkey,
        l_tablename         LIKE tresc-tabname,
        l_fieldname         LIKE tresc-fieldname,
        l_txt1(70)          TYPE c,
        l_txt2(70)          TYPE c,
        l_text1(70)         TYPE c,
        l_text2(70)         TYPE c,
        l_text3(70)         TYPE c,
        l_text(210)         TYPE c,
        l_txt_but1(10)      TYPE c,
        l_pop_tit(60)       TYPE c,
        l_icon_1            TYPE icon-name,
        l_icon_2            TYPE icon-name,
        l_placetype_txt(30) TYPE c,
        l_answer(1)         TYPE c.
  DATA  l_user              TYPE sy-uname.

  CLEAR:   e_rc, l_place, nwpusz_count.

  CLEAR:   t_messages.
  REFRESH: t_messages,
           lt_nwplace,   lt_nwplacet,   lt_nwpusz,   lt_nwpuszt,
           lt_o_nwplace, lt_o_nwplacet, lt_o_nwpusz, lt_o_nwpuszt,
           lt_nwplace_001, lt_o_nwplace_001,
           lt_nwplace_p01, lt_o_nwplace_p01.

  l_popup = i_popup.

* Arbeitsumfeld lesen
  SELECT SINGLE * FROM nwplace INTO l_place
         WHERE  wplacetype  = i_place-wplacetype
         AND    wplaceid    = i_place-wplaceid.
  IF sy-subrc <> 0.
*   Das Arbeitsumfeld & wurde nicht gefunden
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '366' i_place-wplaceid space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ELSE.
    APPEND l_place TO lt_nwplace.
*   Text zum Arbeitsumfeld lesen (alle Sprachen!)
    SELECT * FROM nwplacet INTO TABLE lt_nwplacet   "#EC CI_NOFIRST
           WHERE  wplacetype  = l_place-wplacetype
           AND    wplaceid    = l_place-wplaceid.
  ENDIF.

* System bestimmen - SAP oder Kunde (und in globale Variable stellen)
  PERFORM read_system.

* Das SAP-Standard-Arbeitsumfeld darf nicht gelöscht werden
  IF l_place-wplaceid = 'SAP_WFIELD'.
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '505' i_place-wplaceid space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ENDIF.

* Prüfung: Es sollten keine SAP-Standard-Arb.umf. gelöscht werden
  IF g_system_sap = off.     " Prüfung nur auf Kundensystemen ID 7947
    l_tablekey  = l_place-wplaceid.
    l_tablename = 'NWPLACE'.
    l_fieldname = 'WPLACEID'.
    CALL FUNCTION 'CHECK_CUSTOMER_NAME_FIELD'
         EXPORTING
*             OBJECTTYPE            = 'TABU'
              tablekey              = l_tablekey
              tablename             = l_tablename
              fieldname             = l_fieldname
        IMPORTING
              keyfield_allowed      = l_allowed
*             SYSTEM_SAP            =
*             TABLE_NOT_FOUND       =
*             RESERVED_IN_TRESC     =
        EXCEPTIONS
             objecttype_not_filled = 1
             tablename_not_filled  = 2
             fieldname_not_filled  = 3
             OTHERS                = 4.                     "#EC *
    IF sy-subrc <> 0.
      l_allowed = off.
    ENDIF.
    IF l_allowed <> on.
      e_rc = 1.            " nur Warnung ausgeben !
*     Wenn Aufruf aus Arbeitsumfeld-Pflege, dann braucht die Meldung
*     nicht nochmals hier ausgegeben zu werden
*      IF i_caller <> 'LN1WPLF01'.
*       Von SAP ausgelieferte Arb.umf. dürfen nicht geändert werden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '369' space space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
*      ENDIF.
      EXIT.
    ENDIF.
  ENDIF.

* Zuordnungen des Arbeitsumfelds zu Benutzern lesen
  SELECT * FROM nwpusz INTO TABLE lt_nwpusz
         WHERE  wplacetype  = l_place-wplacetype
         AND    wplaceid    = l_place-wplaceid.

* Wenn der Aufruf aus dem Baustein 'ISH_WP_MAINTAIN' erfolgt,
* dann darf nicht nur die Zuordnung zum eigenen User, sondern
* auch zu anderen Usern gelöscht werden (Administratorrecht)
  IF i_caller = 'LN_WPF10'.
    l_del_zuo_only  = off.
    l_del_user_only = off.
  ELSE.
*   Prüfen, ob das Arbeitsumfeld auch anderen Benutzern
*   zugeordnet ist
*   Wenn dem so ist, dann soll nur die Zuordnung zum
*   aktuellen Benutzer gelöscht werden, nicht aber das
*   Arbeitsumfeld selbst
*   Wenn das Arbeitsumfeld nur dem aktuellen Benutzer
*   zugeordnet ist, dann soll ein Popup kommen
    l_del_zuo_only  = off.
    l_del_user_only = off.
    DESCRIBE TABLE lt_nwpusz.
    IF sy-tfill = 1.
      READ TABLE lt_nwpusz INTO l_nwpusz INDEX 1.
      l_user = sy-uname.
      IF l_nwpusz-benutzer = l_user. "sy-uname.                      "#EC *
*       nur zum aktuellen Benutzer zugeordnet
        nwpusz_count = 0.
        l_del_user_only = on.
      ELSEIF l_nwpusz-benutzer = '*'.
*       nur via Rollen oder '*' zugeordnet
        nwpusz_count = 0.
      ELSE.
*       auch anderen Benutzern zugeordnet
        nwpusz_count = 1.
      ENDIF.
    ELSE.
*     mehrere Zuordnungen
      nwpusz_count = sy-tfill.
      READ TABLE lt_nwpusz INTO l_nwpusz WITH KEY
                 benutzer = sy-uname.
      IF sy-subrc = 0.
*       Falls eine direkte Zuordnung für den Benutzer
*       dabei ist, nur genau diese Zuordnung löschen
        l_del_user_only = on.
      ELSE.
*       Falls keine direkte Zuordnung für den Benutzer
*       dabei ist, soll das Popup kommen
        nwpusz_count = 0.
        READ TABLE lt_nwpusz INTO l_nwpusz WITH KEY
                   benutzer = '*'.
      ENDIF.
    ENDIF.

    IF nwpusz_count > 0.
*     Falls das Arbeitsumfeld auch von anderen Benutzern verwendet wird
*     dann soll kein Popup kommen, sondern nur die Zuordnung gelöscht w.
      l_popup = off.
      l_del_zuo_only = on.
    ENDIF.
  ENDIF.

* Popup als Sicherheitsabfrage bringen, wenn gewünscht
  IF l_popup = on AND l_del_zuo_only = off.
    CLEAR: l_txt1, l_txt2, l_text1, l_text2, l_text3.
    PERFORM get_domain_value_desc(sapmn1pa) USING 'NWPLACETYPE'
                                                  l_place-wplacetype
                                                  l_placetype_txt.
    READ TABLE lt_nwplacet INTO l_nwplacet WITH KEY spras = sy-langu.
    IF sy-subrc = 0.
      l_txt1 = l_nwplacet-txt.
    ENDIF.
    IF l_place-wplacetype = 'P01'.
      CONCATENATE 'Wollen Sie den Aspekt'(022) l_txt1
                  INTO l_text1 SEPARATED BY space.
    ELSE.
      CONCATENATE 'Wollen Sie das Arbeitsumfeld'(019) l_txt1
                  INTO l_text1 SEPARATED BY space.
    ENDIF.
    CONCATENATE '(' 'Typ'(016) INTO l_txt2.
    CONCATENATE l_txt2 l_placetype_txt INTO l_txt2 SEPARATED BY space.
    CONCATENATE l_txt2 ')' INTO l_txt2.
    CONCATENATE l_txt2 'oder nur die Zuordnung'(020) INTO l_text2
                SEPARATED BY space.
    IF i_caller = 'LN_WPF10'.
      l_text3 = 'zu allen Benutzern löschen?'(027).
    ELSE.
      l_text3 = 'zum Benutzer löschen?'(021).
      IF l_nwpusz-benutzer = '*'.
        CONCATENATE l_text3
                    'Zuordnung zu mehreren Benutzern möglich!'(023)
                    INTO l_text3 SEPARATED BY space.
      ENDIF.
    ENDIF.
    CONCATENATE l_text1 l_text2 l_text3 INTO l_text SEPARATED BY space.
    l_icon_1 = icon_delete.
    l_icon_2 = icon_disconnect.
    IF l_place-wplacetype = 'P01'.
      l_pop_tit  = 'Aspekt löschen'(036).
      l_txt_but1 = 'Aspekt'(037).
    ELSE.
      l_pop_tit = 'Arbeitsumfeld löschen'(004).
      l_txt_but1 = 'A.Umfeld'(005).
    ENDIF.
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar                    = l_pop_tit
*       DIAGNOSE_OBJECT             = ' '
        text_question               = l_text
        text_button_1               = l_txt_but1
        icon_button_1               = l_icon_1
        text_button_2               = 'Zuordnung'(006)
        icon_button_2               = l_icon_2
*       DEFAULT_BUTTON              = '1'
*       DISPLAY_CANCEL_BUTTON       = 'X'
*       POPUP_TYPE                  =
      IMPORTING
        answer                      = l_answer
      EXCEPTIONS
        text_not_found              = 1
        OTHERS                      = 2.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    CASE l_answer.
      WHEN '1'.                        " Arbeitsumfeld
*       OK -> Weiter
      WHEN '2'.                        " Zuordnung
*       Arbeitsumfeld selbst nicht löschen -> nur die Zuordnung zum User
        l_del_zuo_only = on.
      WHEN OTHERS.                     " Cancel
        e_rc = 2.                      " Abbrechen
        EXIT.
    ENDCASE.
  ENDIF.

* Es sollen keine Zuordnungen des Arbeitsumfelds zu anderen
* Benutzern gelöscht werden, außer das Arbeitsumfeld selbst soll
* gelöscht werden oder der Aufruf erfolgte vom ISH_WP_MAINTAIN
  IF l_del_zuo_only = on.
    IF l_del_user_only = on.
      DELETE lt_nwpusz WHERE benutzer <> sy-uname.
    ELSE.
      IF i_caller = 'LN_WPF10'.
*       alle Zuordnungen löschen
      ELSE.
        DELETE lt_nwpusz WHERE benutzer <> sy-uname
                           AND benutzer <> '*'.
*       Falls mehr als 1 '*' Zuordnung übrig bleibt, also mind. 1
*       Rollen-Zuordnung dabei ist, dann soll die 'Nur-*'-Zuordnung
*       (ohne Rolle) nicht gelöscht werden
        DESCRIBE TABLE lt_nwpusz.
        IF sy-tfill > 1.
          DELETE lt_nwpusz WHERE benutzer = '*'
                             AND agr_name = space.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

* Texte zur Arbeitsumfeld-Benutzer-Zuordnung lesen
  DESCRIBE TABLE lt_nwpusz.
  IF sy-tfill > 0.
    SELECT * FROM nwpuszt INTO TABLE lt_nwpuszt           "#EC CI_NOFIRST
           FOR ALL ENTRIES IN lt_nwpusz
           WHERE  wplacetype  = lt_nwpusz-wplacetype
           AND    wplaceid    = lt_nwpusz-wplaceid.
  ENDIF.

* Alte Tabellen füllen
  APPEND LINES OF lt_nwpusz   TO lt_o_nwpusz.
  APPEND LINES OF lt_nwpuszt  TO lt_o_nwpuszt.

* Delete-KZ setzen
  LOOP AT lt_nwpusz INTO l_nwpusz.
    l_nwpusz-kz = 'D'.
    MODIFY lt_nwpusz FROM l_nwpusz.
  ENDLOOP.
  LOOP AT lt_nwpuszt INTO l_nwpuszt.
    l_nwpuszt-kz = 'D'.
    MODIFY lt_nwpuszt FROM l_nwpuszt.
  ENDLOOP.

* Verbuchung Zuordungen Arbeitsumfeld-Benutzer
  CALL FUNCTION 'ISH_VERBUCHER_NWPUSZ'
    EXPORTING
      i_tcode    = sy-tcode
    TABLES
      t_n_nwpusz = lt_nwpusz
      t_o_nwpusz = lt_o_nwpusz.
* Verbuchung Text zu Zuordungen Arbeitsumfeld-Benutzer
  CALL FUNCTION 'ISH_VERBUCHER_NWPUSZT'
    EXPORTING
      i_tcode     = sy-tcode
    TABLES
      t_n_nwpuszt = lt_nwpuszt
      t_o_nwpuszt = lt_o_nwpuszt.

* Nun auch Arbeitsumfeld selbst löschen, wenn es von keinem
* Benutzer mehr verwendet wird und das Popup bestätigt wurde
  IF l_del_zuo_only = off.

*   Zuordnungen von Sichten zum Arbeitsumfeld lesen
    SELECT * FROM nwpvz INTO TABLE lt_nwpvz
           WHERE  wplacetype  = l_place-wplacetype
           AND    wplaceid    = l_place-wplaceid.           "#EC *
    IF sy-subrc = 0.
      SELECT * FROM nwpvzt INTO TABLE lt_nwpvzt           "#EC CI_NOFIRST
             FOR ALL ENTRIES IN lt_nwpvz
             WHERE  wplacetype  = lt_nwpvz-wplacetype
             AND    wplaceid    = lt_nwpvz-wplaceid
             AND    viewtype    = lt_nwpvz-viewtype
             AND    viewid      = lt_nwpvz-viewid.
    ENDIF.

*   Alte Tabellen füllen
    APPEND LINES OF lt_nwplace  TO lt_o_nwplace.
    APPEND LINES OF lt_nwplacet TO lt_o_nwplacet.
    APPEND LINES OF lt_nwpvz    TO lt_o_nwpvz.
    APPEND LINES OF lt_nwpvzt   TO lt_o_nwpvzt.

*   Delete-KZ setzen
    LOOP AT lt_nwplace INTO l_nwplace.
      l_nwplace-kz = 'D'.
      MODIFY lt_nwplace FROM l_nwplace.
    ENDLOOP.
    LOOP AT lt_nwplacet INTO l_nwplacet.
      l_nwplacet-kz = 'D'.
      MODIFY lt_nwplacet FROM l_nwplacet.
    ENDLOOP.
    LOOP AT lt_nwpvz INTO l_nwpvz.
      l_nwpvz-kz = 'D'.
      MODIFY lt_nwpvz FROM l_nwpvz.
    ENDLOOP.
    LOOP AT lt_nwpvzt INTO l_nwpvzt.
      l_nwpvzt-kz = 'D'.
      MODIFY lt_nwpvzt FROM l_nwpvzt.
    ENDLOOP.

*   Spezialisierungstabellen lesen
    CASE l_place-wplacetype.
*     Workplace
      WHEN '001'.
        SELECT SINGLE * FROM nwplace_001 INTO l_nwplace_001
               WHERE  wplacetype  = l_place-wplacetype
               AND    wplaceid    = l_place-wplaceid.
        IF sy-subrc = 0.
          APPEND l_nwplace_001 TO lt_o_nwplace_001.
          l_nwplace_001-kz = 'D'.
          APPEND l_nwplace_001 TO lt_nwplace_001.
        ENDIF.
*     Patient Organizer
      WHEN 'P01'.
        SELECT SINGLE * FROM nwplace_p01 INTO l_nwplace_p01
               WHERE  wplacetype  = l_place-wplacetype
               AND    wplaceid    = l_place-wplaceid.
        IF sy-subrc = 0.
          APPEND l_nwplace_p01 TO lt_o_nwplace_p01.
          l_nwplace_p01-kz = 'D'.
          APPEND l_nwplace_p01 TO lt_nwplace_p01.
        ENDIF.
*     Andere
      WHEN OTHERS.
    ENDCASE.

*   Verbuchung Arbeitsumfeld
    CALL FUNCTION 'ISH_VERBUCHER_NWPLACE'
      EXPORTING
        i_tcode     = sy-tcode
      TABLES
        t_n_nwplace = lt_nwplace
        t_o_nwplace = lt_o_nwplace.
*   Verbuchung Text zum Arbeitsumfeld
    CALL FUNCTION 'ISH_VERBUCHER_NWPLACET'
      EXPORTING
        i_tcode      = sy-tcode
      TABLES
        t_n_nwplacet = lt_nwplacet
        t_o_nwplacet = lt_o_nwplacet.
*   Verbuchung Zuordung Arbeitsumfeld-Sichten
    CALL FUNCTION 'ISH_VERBUCHER_NWPVZ'
      EXPORTING
        i_tcode   = sy-tcode
      TABLES
        t_n_nwpvz = lt_nwpvz
        t_o_nwpvz = lt_o_nwpvz.
*   Verbuchung Text zur Zuordung Arbeitsumfeld-Sichten
    CALL FUNCTION 'ISH_VERBUCHER_NWPVZT'
      EXPORTING
        i_tcode    = sy-tcode
      TABLES
        t_n_nwpvzt = lt_nwpvzt
        t_o_nwpvzt = lt_o_nwpvzt.

*   Verbuchung spezielle Tabellen
    DESCRIBE TABLE lt_nwplace_001.
    IF sy-tfill > 0.
      CALL FUNCTION 'ISH_VERBUCHER_NWPLACE_001'
        EXPORTING
          i_tcode         = sy-tcode
        TABLES
          t_n_nwplace_001 = lt_nwplace_001
          t_o_nwplace_001 = lt_o_nwplace_001.
    ENDIF.
    DESCRIBE TABLE lt_nwplace_p01.
    IF sy-tfill > 0.
      CALL FUNCTION 'ISH_VERBUCHER_NWPLACE_P01'
        EXPORTING
          i_tcode         = sy-tcode
        TABLES
          t_n_nwplace_p01 = lt_nwplace_p01
          t_o_nwplace_p01 = lt_o_nwplace_p01.
    ENDIF.

*   Success-Message zurückliefern -> Arbeitsumfeld & wurde gelöscht
    IF l_place-wplacetype = 'P01'.
      PERFORM build_bapiret2(sapmn1pa)
              USING 'S' 'NWP' '081' l_txt1  space
                    space space space space space
              CHANGING l_wa_msg.
    ELSE.
      PERFORM build_bapiret2(sapmn1pa)
              USING 'S' 'NF1' '386' l_txt1  space
                    space space space space space
              CHANGING l_wa_msg.
    ENDIF.
    APPEND l_wa_msg TO t_messages.

  ENDIF.                               " if l_del_zuo_only = off

  COMMIT WORK AND WAIT.

  IF i_update_buffer = on.
*   Puffer mit den Arbeitsumfeld/Sicht-Daten des Benutzers aktual.
    PERFORM refresh_personal_buffer(sapln1view) USING sy-uname i_place.
  ENDIF.

ENDFUNCTION.
