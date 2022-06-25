FUNCTION ishmed_find_group_4_ntpk.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_EINRI) LIKE  TN01-EINRI
*"     VALUE(I_ZOTYP) LIKE  NTPZ-ZOTYP
*"     VALUE(I_DATUM) LIKE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_FORCE_GRP) DEFAULT ' '
*"     VALUE(I_NTPT_DEF) LIKE  NTPT STRUCTURE  NTPT OPTIONAL
*"     VALUE(I_STEPS) DEFAULT -1
*"  TABLES
*"      TI_NTPK STRUCTURE  NTPK
*"      TE_NTPT STRUCTURE  NTPT
*"      TE_NTPZ STRUCTURE  NTPZ OPTIONAL
*"  EXCEPTIONS
*"      NO_GROUP
*"----------------------------------------------------------------------
  DATA: xntpk LIKE ntpk OCCURS 10 WITH HEADER LINE,
        yntpk LIKE ntpk OCCURS 10 WITH HEADER LINE,
        yntpz LIKE ntpz OCCURS 10 WITH HEADER LINE,
        i     TYPE i.
  DATA: lt_ntpz     TYPE TABLE OF ntpz,
        l_ntpz      TYPE ntpz,
        l_ntpt      TYPE ntpt.
  STATICS: lt_ntpt  TYPE SORTED TABLE OF ntpt
                         WITH NON-UNIQUE KEY einri tarif talst.
* Kopie von ti_ntpk erstellen
  xntpk[] = ti_ntpk[].
  CLEAR: te_ntpt[], te_ntpz[].
* Leere Menge von Leistungen? -> keine Gruppen vorhanden
  DESCRIBE TABLE xntpk.
  IF sy-tfill = 0. RAISE no_group. ENDIF.

* Leistungstabelle um Duplikate reduzieren
  SORT xntpk BY tarif talst.
  DELETE ADJACENT DUPLICATES FROM xntpk COMPARING tarif talst.

*----------------------------------------------------------------------
* Suche in Gruppenstruktur nach übergeordneten Leistungen
* Es werden i_steps Gruppenebenen von unten nach oben durchsucht.
  yntpk[] = xntpk[].
  i = 0.
* Suche nach Gruppen mit eigener Suchtabelle yntpk
  DO.
    SELECT * FROM ntpz INTO TABLE yntpz
    FOR ALL ENTRIES IN yntpk
      WHERE zutar  = yntpk-tarif
        AND zulst  = yntpk-talst
        AND zotyp  = i_zotyp
        AND einri  = i_einri
        AND begdt <= i_datum
        AND enddt >= i_datum
        AND loekz  = off.
*   Übergeordnete Gruppen gefunden?  --> weitermachen
    IF sy-subrc <> 0. EXIT. ENDIF.
*   Gefundene Gruppen in te_ntpz merken
    APPEND LINES OF yntpz TO te_ntpz.
*   Eine Hierarchiestufe erledigt: Zähler ++
    i = i + 1.
    IF i_steps <> -1  AND i >= i_steps.     " max. Step erreicht
      EXIT.
    ENDIF.
*   Suchtabelle yntpk für nächsthöhere Gruppenebene erstellen
    CLEAR yntpk[].
    LOOP AT yntpz.
      yntpk-tarif = yntpz-tarif.
      yntpk-talst = yntpz-talst.
      APPEND yntpk.
    ENDLOOP.
  ENDDO.
* Gruppentabelle (ntpz) für alle Ebenen fertig

*----------------------------------------------------------------------
* Texte zu gefundenen Gruppen aus NTPT holen
  SORT te_ntpz BY tarif talst zotyp zutar zulst.
  DELETE ADJACENT DUPLICATES FROM te_ntpz
         COMPARING tarif talst zotyp zutar zulst.
  CLEAR te_ntpt[].
  DESCRIBE TABLE te_ntpz.
  IF sy-tfill > 0.
*   ID 9404: Pufferung eingebaut (Performancetuning) ------------ BEGIN
    REFRESH lt_ntpz.
    lt_ntpz[] = te_ntpz[].
    LOOP AT lt_ntpz INTO l_ntpz.
      READ TABLE lt_ntpt INTO l_ntpt
                 WITH TABLE KEY einri = i_einri
                                tarif = l_ntpz-tarif
                                talst = l_ntpz-talst.
      IF sy-subrc = 0.
        INSERT l_ntpt INTO TABLE te_ntpt.
        DELETE lt_ntpz.
      ENDIF.
    ENDLOOP.
    DESCRIBE TABLE lt_ntpz.
    IF sy-tfill > 0.
      SELECT * FROM ntpt APPENDING TABLE te_ntpt   "#EC CI_SGLSELECT "#EC CI_GENBUFF
        FOR ALL ENTRIES IN lt_ntpz
          WHERE spras = sy-langu
            AND einri = i_einri
            AND tarif = lt_ntpz-tarif
            AND talst = lt_ntpz-talst.
      INSERT LINES OF te_ntpt INTO TABLE lt_ntpt.
    ENDIF.
    SORT te_ntpt BY tarif talst."MED-50004,AM
*    SELECT DISTINCT * FROM NTPT INTO TABLE TE_NTPT
*      FOR ALL ENTRIES IN TE_NTPZ
*        WHERE SPRAS = SY-LANGU
*          AND EINRI = I_EINRI
*          AND TARIF = TE_NTPZ-TARIF
*          AND TALST = TE_NTPZ-TALST.
*   ID 9404: Pufferung eingebaut (Performancetuning) ------------ END
  ENDIF.


*----------------------------------------------------------------------
* Gruppenstruktur zu nicht gefundenen Gruppen erzwingen?
  IF i_force_grp <> off.
*   Gibt es Leistungen, die in keinen Gruppen vorkommen?
    LOOP AT te_ntpz.
      DELETE xntpk WHERE tarif = te_ntpz-zutar
                     AND talst = te_ntpz-zulst.
    ENDLOOP.
    DESCRIBE TABLE xntpk.
    CHECK sy-tfill > 0.
*
    CLEAR te_ntpz.
    te_ntpz-mandt = sy-mandt.
    te_ntpz-einri = i_einri.
    te_ntpz-zotyp = i_zotyp.
*
    CASE i_force_grp.
      WHEN 'D'.
*       Default-Gruppe erstellen und alle Leistungen einhängen
        CLEAR te_ntpt.
        te_ntpt = i_ntpt_def.
        APPEND te_ntpt.
        te_ntpz-tarif = i_ntpt_def-tarif.
        te_ntpz-talst = i_ntpt_def-talst.
        LOOP AT xntpk.
          te_ntpz-zutar = xntpk-tarif.
          te_ntpz-zulst = xntpk-talst.
          APPEND te_ntpz.
        ENDLOOP.
*
      WHEN 'L'.
*       Jede Leistung als eigene Gruppe -> Leistung in Gruppe einhängen
        SELECT * FROM ntpt APPENDING TABLE te_ntpt "#EC CI_SGLSELECT "#EC CI_GENBUFF
          FOR ALL ENTRIES IN xntpk
            WHERE spras = sy-langu
              AND einri = i_einri
              AND tarif = xntpk-tarif
              AND talst = xntpk-talst.
        SORT te_ntpt BY tarif talst.
        DELETE ADJACENT DUPLICATES FROM te_ntpt
               COMPARING tarif talst.
        LOOP AT xntpk.
          te_ntpz-tarif = xntpk-tarif.
          te_ntpz-talst = xntpk-talst.
          te_ntpz-zutar = xntpk-tarif.
          te_ntpz-zulst = xntpk-talst.
          APPEND te_ntpz.
        ENDLOOP.
    ENDCASE.
  ENDIF.

*----------------------------------------------------------------------
* te_ntpz enthält mehrere Bäume -> Alle Wurzelknoten ermitteln

ENDFUNCTION.
