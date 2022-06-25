FUNCTION ishmed_vm_personal_data_read.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_UNAME) LIKE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(I_PLACETYPE) LIKE  NWPLACE-WPLACETYPE DEFAULT '001'
*"     VALUE(I_MODE) TYPE  C DEFAULT 'L'
*"     VALUE(I_CALLER) LIKE  SY-REPID
*"     VALUE(I_WORKFLOW) TYPE  C DEFAULT 'X'
*"     VALUE(I_FAVORITES) TYPE  C DEFAULT 'X'
*"     VALUE(I_PLACEID) LIKE  NWPLACE-WPLACEID OPTIONAL
*"     VALUE(I_REPLACE_SUBSTITUTE) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_ONLY_WPLACEID) TYPE  NWPLACEID DEFAULT SPACE
*"     VALUE(I_ONLY_VIEWTYPE) TYPE  NVIEWTYPE DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"     VALUE(E_DEFAULT_VIEW) LIKE  V_NWVIEW STRUCTURE  V_NWVIEW
*"     VALUE(E_DEFAULT_WPLACE) TYPE  V_NWPLACE
*"  TABLES
*"      T_WORKPLACES STRUCTURE  V_NWPLACE OPTIONAL
*"      T_VIEWS STRUCTURE  V_NWVIEW OPTIONAL
*"      T_USER_MENUS STRUCTURE  BXMNODES1 OPTIONAL
*"      T_USER_FAVORITES STRUCTURE  BXMNODES OPTIONAL
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"      T_NWPVZ STRUCTURE  V_NWPVZ OPTIONAL
*"      T_NWPVZ_USZ STRUCTURE  NWPVZ_USZ OPTIONAL
*"      T_NWPUSZ STRUCTURE  V_NWPUSZ OPTIONAL
*"      T_WORKPLACES_001 STRUCTURE  NWPLACE_001 OPTIONAL
*"----------------------------------------------------------------------
  DATA: lt_nwpusz        TYPE TABLE OF v_nwpusz,
        lt_nwpvz         TYPE TABLE OF v_nwpvz,
        lt_nwview        TYPE TABLE OF v_nwview,
        lt_rollen        TYPE ustyp_t_agr,
        l_wa_nwpusz      TYPE v_nwpusz,
        l_wa_nwpvz       TYPE v_nwpvz,
        l_wa_nwview      TYPE v_nwview,
        l_wa_nwplace     TYPE nwplace,
        l_wa_nwplace_001 TYPE nwplace_001,
        l_wa_nwplace_v   TYPE v_nwplace,
        l_wa_nwplacet    TYPE nwplacet,
        l_wa_msg         TYPE bapiret2,
        l_wplacetype     TYPE nwplacetype,
        l_wplaceid       TYPE nwplaceid,
        l_wplacetype_tmp TYPE nwplacetype,
        l_wplaceid_tmp   TYPE nwplaceid,
        lt_selvar        TYPE TABLE OF rsparams,            "#EC NEEDED
        lt_list          TYPE vrm_values,
        ls_list          LIKE LINE OF lt_list,
        lr_range         TYPE RANGE OF nviewtype,
        ls_range         LIKE LINE OF lr_range,
        l_rc             TYPE sy-subrc,
        l_nlei_flag      TYPE true VALUE false,
        l_nlei_used      TYPE true VALUE false,
        l_user_adr       TYPE addr3_val,
        l_user_mt_flag   TYPE smensapnew-customized,
        l_user_m_avail   TYPE smensaplng-customized,
        l_refuser        TYPE us_refus,                     "MED-66357
        l_n1wp_usermenu  TYPE ish_on_off.                   "MED-44016

  RANGES: r_rolle        FOR nwpusz-agr_name.

  FIELD-SYMBOLS: <ls_rolle>  TYPE ustyp_agr.

* Initialisierung
  CLEAR: e_default_view, e_default_wplace.
  CLEAR: t_messages.         REFRESH t_messages.
  CLEAR: t_user_menus.       REFRESH t_user_menus.
  CLEAR: t_user_favorites.   REFRESH t_user_favorites.

  e_rc = 0.

* Soll der FBS die Daten zurückliefern (entweder aus dem Puffer,
* oder von der Datenbank), müssen die Aufruftabellen gelöscht werden
  IF i_mode = 'L'  OR  i_mode = 'R'  OR i_mode = 'C'.
    CLEAR: t_workplaces.       REFRESH t_workplaces.
    CLEAR: t_views.            REFRESH t_views.
    CLEAR: t_nwpvz.            REFRESH t_nwpvz.
    CLEAR: t_nwpvz_usz.        REFRESH t_nwpvz_usz.
    CLEAR: t_nwpusz.           REFRESH t_nwpusz.
    CLEAR: t_workplaces_001.   REFRESH t_workplaces_001.
  ENDIF.

* Ist vom Aufrufer ein Refresh der Puffer gewünscht?
* Refresh: D.h. die Daten zu dieser Einrichtung und Sicht sollen
* erneut von der DB gelesen werden. Dazu hier die Daten aus den
* globalen Tabellen entfernen. Weiter unten werden sie dann
* frisch aus der DB gelesen
* Bei Modus = 'U' (d.h. Update) werden hier auch die alten Werte
* gelöscht, um "saubere" Puffertabellen zu erhalten
  IF i_mode = 'R' OR i_mode = 'U' OR i_mode = 'C'.
    CLEAR: gt_user_menus.       REFRESH gt_user_menus.
    CLEAR: gt_user_favorites.   REFRESH gt_user_favorites.
    CLEAR: gt_nwplace.          REFRESH gt_nwplace.
    CLEAR: gt_nwpvz.            REFRESH gt_nwpvz.
    CLEAR: gt_nwpvz_usz.        REFRESH gt_nwpvz_usz.
    CLEAR: gt_nwview.           REFRESH gt_nwview.
    CLEAR: gt_nwpusz.           REFRESH gt_nwpusz.
    CLEAR: gt_nwplace_001.      REFRESH gt_nwplace_001.
  ENDIF.

* Falls nur alle Puffer gelöscht werden sollen, hier abbrechen
  CHECK i_mode <> 'C'.

* Gleich zu Beginn die User-Menüs und Favorites einlesen
  IF ( i_favorites = 'X'  OR  i_favorites = 'M' )  AND
     t_user_menus IS REQUESTED.
*   get parameter N1WP_USERMENU
    GET PARAMETER ID 'N1WP_USERMENU' FIELD l_n1wp_usermenu.   "MED-44016
*   Sind die Tabellen im Puffer - dann nicht neu lesen
    READ TABLE gt_user_menus TRANSPORTING NO FIELDS INDEX 1.
    IF sy-subrc = 0.
      t_user_menus[] = gt_user_menus[].
    ELSE.
      IF l_n1wp_usermenu EQ off.                               "MED-44016
        CALL FUNCTION 'NAVIGATION_GET_ACTIVE_MENU'            " MED-43510
          EXPORTING
            uname               = i_uname
          IMPORTING
            user_menu_type_flag = l_user_mt_flag.
        IF l_user_mt_flag <> 'S'.
          CALL FUNCTION 'NAVIGATION_CHECK_AVAILABILITY'       " MED-43510
            EXPORTING
              us_name   = i_uname
            IMPORTING
              user_menu = l_user_m_avail.
          IF l_user_m_avail = abap_true.
            CALL FUNCTION 'BX_READ_USER_MENU'
              EXPORTING
                user_name  = i_uname
                sort_nodes = 'X'
              TABLES
                node_tab   = gt_user_menus.
            t_user_menus[] = gt_user_menus[].
          ENDIF.
        ENDIF.
      ELSE.                                                 "MED-44016
        CALL FUNCTION 'BX_READ_USER_MENU'
          EXPORTING
            user_name  = i_uname
            sort_nodes = 'X'
          TABLES
            node_tab   = gt_user_menus.
        t_user_menus[] = gt_user_menus[].
      ENDIF.                                                "MED-44016
    ENDIF.
  ENDIF.

  IF ( i_favorites = 'X'  OR  i_favorites = 'F' )  AND
     t_user_favorites IS REQUESTED.
    READ TABLE gt_user_favorites TRANSPORTING NO FIELDS INDEX 1.
    IF sy-subrc = 0.
      t_user_favorites[] = gt_user_favorites[].
    ELSE.
      CALL FUNCTION 'BX_FAVOS_READ_ALL_NODES'
        EXPORTING
          user_name              = i_uname
          sort_nodes             = 'X'
        TABLES
          output_nodes_and_texts = t_user_favorites.
      gt_user_favorites[] = t_user_favorites[].
    ENDIF.
  ENDIF.

  IF i_mode = 'L'  OR  i_mode = 'R'.
*   -------------------------------------------------------------------
*   LESEMODUS + REFRESH, d.h. der FBS liefert die Daten dem Aufrufer

    REFRESH: lt_rollen, r_rolle.

*   BEGIN MED-66357 roles for user and refuser
**   Aktivitätsgruppen (Rollen) des Benutzers lesen (gepuffert)
*    CALL FUNCTION 'SUSR_USER_AGR_ACTIVITYGR_GET'
*      EXPORTING
*        user_name           = i_uname
*      TABLES
*        user_activitygroups = lt_rollen.
**   ID 7755: Auch Datum prüfen
*    DELETE lt_rollen WHERE from_dat > sy-datum
*                        OR to_dat   < sy-datum.
    CALL FUNCTION 'ISHMED_VM_GET_ROLES_FOR_USER'
      EXPORTING
        i_uname  = i_uname
        i_placetype = i_placetype
      IMPORTING
        e_refuser = l_refuser
        et_roles = lt_rollen.
*   END MED-66357

    LOOP AT lt_rollen ASSIGNING <ls_rolle>.
      r_rolle-sign   = 'I'.
      r_rolle-option = 'EQ'.
      r_rolle-low    = <ls_rolle>-agr_name.
      APPEND r_rolle.
    ENDLOOP.

    l_wplacetype = i_placetype.
    l_wplaceid   = i_placeid.

*   check if viewtype services should be handled
    l_nlei_flag = false.
    l_nlei_used = false.
    IF i_placetype = 'L04'.
      CALL FUNCTION 'ISH_SERVICE_VIEW_TREE_ENV_GET'
        IMPORTING
          ss_flag = l_nlei_flag.
      IF l_nlei_flag = true.
        CALL FUNCTION 'ISH_WPLACE_INFO_POOL_GET'
          IMPORTING
            e_wplaceid   = l_wplaceid_tmp
            e_wplacetype = l_wplacetype_tmp.
        IF l_wplacetype_tmp = 'AD1'.
          l_wplacetype = l_wplacetype_tmp.
          l_wplaceid   = l_wplaceid_tmp.
          l_nlei_used  = true.
        ENDIF.
      ENDIF.
    ENDIF.

*   Zuerst die zum User vorhandenen Arbeitsumfelder lesen
    REFRESH: lt_nwpusz.
    LOOP AT gt_nwpusz INTO l_wa_nwpusz
                      WHERE wplacetype = l_wplacetype
                      AND   benutzer   = i_uname.
      APPEND l_wa_nwpusz TO lt_nwpusz.
    ENDLOOP.
*   BEGIN MED-66357
    IF NOT l_refuser IS INITIAL.
      LOOP AT gt_nwpusz INTO l_wa_nwpusz
                        WHERE wplacetype = l_wplacetype
                        AND   benutzer   = l_refuser.
        APPEND l_wa_nwpusz TO lt_nwpusz.
      ENDLOOP.
    ENDIF.
*   END MED-66357
*   Dann auch die Arbeitsumf. zu einer der Rollen des Benutzers lesen
    DESCRIBE TABLE lt_rollen.
    IF sy-tfill > 0.
      LOOP AT gt_nwpusz INTO l_wa_nwpusz
                        WHERE wplacetype =  l_wplacetype
                        AND   benutzer   =  '*'
                        AND   agr_name   IN r_rolle.
        APPEND l_wa_nwpusz TO lt_nwpusz.
      ENDLOOP.
    ENDIF.
    DESCRIBE TABLE lt_nwpusz.
    IF sy-tfill = 0.
      LOOP AT gt_nwpusz INTO l_wa_nwpusz
                        WHERE wplacetype =  l_wplacetype
                        AND   benutzer   =  '*'
                        AND   agr_name   =  space.
        APPEND l_wa_nwpusz TO lt_nwpusz.
      ENDLOOP.
      DESCRIBE TABLE lt_nwpusz.
      IF sy-tfill = 0.
        SELECT * FROM nwpusz INTO TABLE lt_nwpusz
                 WHERE wplacetype =  l_wplacetype
                 AND   benutzer   =  i_uname.               "#EC *
*       BEGIN MED-66357
        IF NOT l_refuser IS INITIAL.
          SELECT * FROM nwpusz APPENDING TABLE lt_nwpusz
                   WHERE wplacetype =  l_wplacetype
                   AND   benutzer   =  l_refuser.           "#EC *
          SORT lt_nwpusz BY wplaceid.
          DELETE ADJACENT DUPLICATES FROM lt_nwpusz COMPARING wplaceid.
        ENDIF.
*       END MED-66357
        DESCRIBE TABLE lt_rollen.
        IF sy-tfill > 0.
          SELECT * FROM nwpusz APPENDING TABLE lt_nwpusz
                   WHERE wplacetype =  l_wplacetype
                   AND   benutzer   =  '*'
                   AND   agr_name   IN r_rolle.             "#EC *
        ENDIF.
        DESCRIBE TABLE lt_nwpusz.
        IF sy-tfill = 0.
          SELECT * FROM nwpusz INTO TABLE lt_nwpusz
                   WHERE wplacetype =  l_wplacetype
                   AND   benutzer   =  '*'
                   AND   agr_name   =  space.               "#EC *
          DESCRIBE TABLE lt_nwpusz.
          IF sy-tfill > 1.
            DELETE lt_nwpusz WHERE wplaceid = co_sap_wfield.
          ENDIF.
        ENDIF.
        LOOP AT lt_nwpusz INTO l_wa_nwpusz.
          SELECT SINGLE spras txt FROM nwpuszt
                 INTO (l_wa_nwpusz-spras, l_wa_nwpusz-txt)
                 WHERE spras      = sy-langu
                 AND   wplacetype = l_wa_nwpusz-wplacetype
                 AND   wplaceid   = l_wa_nwpusz-wplaceid
                 AND   agr_name   = l_wa_nwpusz-agr_name
                 AND   benutzer   = l_wa_nwpusz-benutzer.
          IF sy-subrc = 0.
*           Platzhalter im Text mit dem Benutzernamen befüllen
            IF l_wa_nwpusz-txt CA '&'.
              CALL FUNCTION 'SUSR_USER_ADDRESS_READ'
                EXPORTING
                  user_name              = i_uname
                IMPORTING
                  user_address           = l_user_adr
                EXCEPTIONS
                  user_address_not_found = 1
                  OTHERS                 = 2.
              IF sy-subrc = 0.
                REPLACE '&' IN l_wa_nwpusz-txt
                            WITH l_user_adr-name_text.
              ELSE.
                REPLACE '&' IN l_wa_nwpusz-txt WITH space.
              ENDIF.
            ENDIF.
            MODIFY lt_nwpusz FROM l_wa_nwpusz.
          ENDIF.
        ENDLOOP.
        DESCRIBE TABLE lt_nwpusz.
        IF sy-tfill = 0.
*         Wenn keines gepflegt ist, ausgeliefertes SAP-Standard-
*         Arbeitsumfeld lesen
          SELECT SINGLE * FROM nwplace INTO l_wa_nwplace
                 WHERE  wplacetype  = l_wplacetype
                 AND    wplaceid    = co_sap_wfield.
          IF sy-subrc = 0.
            SELECT SINGLE * FROM nwplacet INTO l_wa_nwplacet
                   WHERE  wplacetype  = l_wplacetype
                   AND    wplaceid    = l_wa_nwplace-wplaceid
                   AND    spras       = sy-langu.
            CLEAR l_wa_nwpusz.
            l_wa_nwpusz-wplacetype = l_wplacetype.
            l_wa_nwpusz-wplaceid   = l_wa_nwplace-wplaceid.
            l_wa_nwpusz-benutzer   = i_uname.
            l_wa_nwpusz-txt        = l_wa_nwplacet-txt.
            APPEND l_wa_nwpusz TO lt_nwpusz.
          ELSE.
*           Keine passenden Arb.umfelder für User & gefunden
            PERFORM build_bapiret2(sapmn1pa)
                    USING 'E' 'NF1' '227' i_uname space space space
                          'I_UNAME' space space
                    CHANGING l_wa_msg.
            APPEND l_wa_msg TO t_messages.
            e_rc = 1.
            EXIT.
          ENDIF.
        ELSE.
          SORT lt_nwpusz BY wplacetype wplaceid ASCENDING
                                           prio DESCENDING. "ID 14966
          DELETE ADJACENT DUPLICATES FROM lt_nwpusz
                 COMPARING  wplacetype wplaceid.
        ENDIF.
        SORT lt_nwpusz BY prio DESCENDING.                  " ID 9757
        gt_nwpusz[] = lt_nwpusz[].
      ENDIF.
    ENDIF.    " IF SY-TFILL = 0   (Lesen aus gt_nwpusz)

*   Falls nur ein bestimmtes Arbeitsumfeld retourniert werden soll,
*   dann nur dieses zurückliefern, im Puffer aber alle Arbeitsumfelder
*   des Benutzers belassen!!!
    IF NOT l_wplaceid IS INITIAL.
      DELETE lt_nwpusz WHERE wplaceid <> l_wplaceid.
      DESCRIBE TABLE lt_nwpusz.
      IF sy-tfill = 0.
*       Arbeitsumfeld & nicht gefunden
*        PERFORM build_bapiret2(sapmn1pa)
*                USING 'E' 'NF1' '366' l_wplaceid space space space
*                      'I_PLACEID' space space
*                CHANGING l_wa_msg.
*        append l_wa_msg to t_messages.
*        e_rc = 1.
*        Keine Meldung ausgeben, keinen Returncode zurückliefern
*        EXIT.                                          " REM ID 10496
*       ID 10496: Falls ein bestimmtes Arbeitsumfeld gesucht wird,
*       dann soll dieses auch unabhängig vom übergebenen Benutzer
*       gefunden werden!
        CLEAR l_wa_nwpusz.
        l_wa_nwpusz-wplacetype = l_wplacetype.
        l_wa_nwpusz-wplaceid   = l_wplaceid.
        APPEND l_wa_nwpusz TO lt_nwpusz.
      ENDIF.
    ENDIF.

    t_nwpusz[]  = lt_nwpusz[].

*   Auslesen der Arbeitsumfelder
*   Begin MED66621 Optimization of access to nwplace table/view
*   LOOP AT lt_nwpusz INTO l_wa_nwpusz.
*      READ TABLE gt_nwplace INTO t_workplaces
*                 WITH KEY wplacetype = l_wa_nwpusz-wplacetype
*                          wplaceid   = l_wa_nwpusz-wplaceid.
*      IF sy-subrc = 0.
*        APPEND t_workplaces.
*      ENDIF.
*    ENDLOOP.
*
*    DESCRIBE TABLE t_workplaces.
*    IF sy-tfill = 0.
*
*      SELECT * FROM nwplace INTO TABLE t_workplaces
*               FOR ALL ENTRIES IN lt_nwpusz
*               WHERE wplacetype = lt_nwpusz-wplacetype
*               AND   wplaceid   = lt_nwpusz-wplaceid.       "#EC ENHOK
*      IF sy-subrc = 0.
*        LOOP AT t_workplaces.
*          SELECT SINGLE spras txt FROM nwplacet
*                 INTO (t_workplaces-spras, t_workplaces-txt)
*                 WHERE spras      = sy-langu
*                 AND   wplacetype = t_workplaces-wplacetype
*                 AND   wplaceid   = t_workplaces-wplaceid.
*          IF sy-subrc = 0.
*            MODIFY t_workplaces.
*          ENDIF.
*          APPEND t_workplaces TO gt_nwplace.
*        ENDLOOP.
*
*      ELSE.
**       Keine passenden Arb.umfelder für User & gefunden
*        PERFORM build_bapiret2(sapmn1pa)
*                USING 'E' 'NF1' '227' i_uname space space space
*                      'I_UNAME' space space
*                CHANGING l_wa_msg.
*        APPEND l_wa_msg TO t_messages.
*        e_rc = 1.
*        EXIT.
*      ENDIF.
*    ENDIF.

    CALL FUNCTION 'ISHMED_VM_SELECT_WORKPLACES'
      EXPORTING
        it_v_nwpusz  = lt_nwpusz
      IMPORTING
        et_v_nwplace = t_workplaces[]
      EXCEPTIONS
        no_nwplace   = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
*     Keine passenden Arb.umfelder für User & gefunden
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF1' '227' i_uname space space space
                      'I_UNAME' space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO t_messages.
        e_rc = 1.
        EXIT.
    ENDIF.
*  ---- END MED66621 ----------------------------------------------------------------------


*   additionally read data for service views if requested
    IF l_nlei_used = true.
      PERFORM get_wplace_services TABLES t_nwpvz_usz
                                         t_workplaces
                                         r_rolle
                                         t_messages
                                   USING i_placeid
                                         i_placetype
                                         'SAP_SRVC'
                                         'A01'
                                         i_uname
                                         e_rc.
      CHECK e_rc = 0.
    ENDIF.

*   Falls zur Arb.umf.-User-Zuordnung kein Text gepflegt ist,
*   dann aus dem Arbeitsumfeld nehmen (ID 12339)
    LOOP AT t_nwpusz INTO l_wa_nwpusz WHERE txt IS INITIAL.
      READ TABLE gt_nwplace INTO l_wa_nwplace_v
                 WITH KEY wplacetype = l_wa_nwpusz-wplacetype
                          wplaceid   = l_wa_nwpusz-wplaceid.
      CHECK sy-subrc = 0 AND NOT l_wa_nwplace_v-txt IS INITIAL.
      l_wa_nwpusz-txt = l_wa_nwplace_v-txt.
      MODIFY t_nwpusz FROM l_wa_nwpusz.
    ENDLOOP.

*   Für diese Arbeitsumfelder nun die Sichten bestimmen,
*   aber nur wenn dies der Aufrufer wünscht
    IF t_views IS REQUESTED OR e_default_view   IS REQUESTED  OR
       t_nwpvz IS REQUESTED OR e_default_wplace IS REQUESTED.

      REFRESH lt_nwpvz.
**************************** Begin MED66621 (Optimization) *****************
*      LOOP AT t_workplaces.
*        LOOP AT gt_nwpvz INTO l_wa_nwpvz
*                         WHERE wplacetype = t_workplaces-wplacetype
*                           AND wplaceid   = t_workplaces-wplaceid.
*          APPEND l_wa_nwpvz TO lt_nwpvz.
*        ENDLOOP.
*      ENDLOOP.
*      DESCRIBE TABLE lt_nwpvz.
*      IF sy-tfill = 0.
*        SELECT * FROM nwpvz INTO TABLE lt_nwpvz
*                 FOR ALL ENTRIES IN t_workplaces
*                 WHERE wplacetype =  t_workplaces-wplacetype
*                 AND   wplaceid   =  t_workplaces-wplaceid. "#EC *
*        IF sy-subrc <> 0.
**          e_rc = 1.          " auch OK, wenn noch keine Sicht
*          EXIT.                        " vorhanden ist ...
*        ELSE.
*          LOOP AT lt_nwpvz INTO l_wa_nwpvz.
*            SELECT SINGLE spras txt FROM nwpvzt
*                   INTO (l_wa_nwpvz-spras, l_wa_nwpvz-txt)
*                   WHERE  wplacetype  = l_wa_nwpvz-wplacetype
*                   AND    wplaceid    = l_wa_nwpvz-wplaceid
*                   AND    viewtype    = l_wa_nwpvz-viewtype
*                   AND    viewid      = l_wa_nwpvz-viewid
*                   AND    spras       = sy-langu.
*            IF sy-subrc = 0.
*              MODIFY lt_nwpvz FROM l_wa_nwpvz.
*            ENDIF.
*          ENDLOOP.
*          gt_nwpvz[] = lt_nwpvz[].
*        ENDIF.
*      ENDIF.

*     MED66621 Optimized Access

      CALL FUNCTION 'ISHMED_VM_SELECT_VIEWS_FOR_WPS'
        EXPORTING
          it_workplaces = t_workplaces[]
        IMPORTING
          et_v_nwpvz    = lt_nwpvz[]
        EXCEPTIONS
          no_nwpvz      = 1
          OTHERS        = 2.
      IF sy-subrc <> 0.
        e_rc = 1.          " auch OK, wenn noch keine Sicht
        EXIT.                        " vorhanden ist ...
      ENDIF.
*
**************************** End MED66621 (Optimization)  *****************

      t_nwpvz[]  = lt_nwpvz[].
*
      IF t_views          IS REQUESTED  OR
         e_default_view   IS REQUESTED  OR
         e_default_wplace IS REQUESTED.

        DESCRIBE TABLE lt_nwpvz.
        IF sy-tfill > 0.
          REFRESH lt_nwview.

*         MED66621 Try to get from global buffer if not empty
          IF gt_nwview IS NOT INITIAL.                      "MED66621
            LOOP AT lt_nwpvz INTO l_wa_nwpvz.
            READ TABLE gt_nwview INTO l_wa_nwview
                       WITH KEY viewtype = l_wa_nwpvz-viewtype
                                viewid   = l_wa_nwpvz-viewid.
            IF sy-subrc = 0.
              APPEND l_wa_nwview TO lt_nwview.
            ENDIF.
          ENDLOOP.
          ENDIF.                                            "MED66621

          DESCRIBE TABLE lt_nwview.
          IF sy-tfill = 0.
*           MED66621 Optimization: Take LEFT OUTER JOIN instead of VIEW or single SELECT on View Texts
*           SELECT * FROM nwview INTO TABLE lt_nwview
*            SELECT * FROM v_nwview INTO TABLE t_views[]     "MED66621
*                     FOR ALL ENTRIES IN lt_nwpvz
*                     WHERE viewtype = lt_nwpvz-viewtype
*                     AND   viewid   = lt_nwpvz-viewid       "#EC ENHOK
*                     AND  spras    = sy-langu.              "MED66621
            SELECT
               nv~mandt
               nv~viewtype
               nv~viewid
               nv~owner
               nvt~spras
               nvt~txt
             INTO TABLE t_views
             FROM nwview AS nv
             LEFT OUTER JOIN nwviewt AS nvt                  "#EC CI_BUFFJOIN
                ON   nv~viewtype EQ nvt~viewtype
                AND nv~viewid   EQ nvt~viewid
                AND nvt~spras      = sy-langu
             FOR ALL ENTRIES IN lt_nwpvz
                WHERE nv~viewtype EQ lt_nwpvz-viewtype
                AND   nv~viewid   EQ lt_nwpvz-viewid.
            IF sy-subrc <> 0.
*              e_rc = 1.        " auch OK, wenn noch keine Sicht
              EXIT.                    " vorhanden ist
            ELSE.
              gt_nwview[] = t_views[].
            ENDIF.

*            LOOP AT lt_nwview INTO l_wa_nwview.
*              t_views = l_wa_nwview.
*              SELECT SINGLE spras txt FROM nwviewt
*                            INTO (t_views-spras, t_views-txt)
*                            WHERE spras    = sy-langu
*                            AND   viewtype = t_views-viewtype
*                            AND   viewid   = t_views-viewid.
*              APPEND t_views.
*            ENDLOOP.
*           End MED66621 Optimization
          ELSE.
            SORT lt_nwview BY viewtype viewid.
            DELETE ADJACENT DUPLICATES FROM lt_nwview
                                       COMPARING viewtype viewid.
            t_views[] = lt_nwview[].
          ENDIF.

*         Default-Sicht ermitteln
          IF e_default_view   IS REQUESTED  OR
             e_default_wplace IS REQUESTED.
            SORT lt_nwpvz BY wplacetype wplaceid sortid.
*            loop at lt_nwpusz into l_wa_nwpusz where prio is initial.
*              l_wa_nwpusz-prio = 999.
*              modify lt_nwpusz from l_wa_nwpusz.
*            endloop.
            SORT lt_nwpusz BY prio DESCENDING.
            LOOP AT lt_nwpusz INTO l_wa_nwpusz.
              READ TABLE lt_nwpvz INTO l_wa_nwpvz
                         WITH KEY wplacetype = l_wa_nwpusz-wplacetype
                                  wplaceid   = l_wa_nwpusz-wplaceid
                                  vdefault   = on.
              IF sy-subrc = 0.
                READ TABLE t_views INTO e_default_view
                              WITH KEY viewtype = l_wa_nwpvz-viewtype
                                       viewid   = l_wa_nwpvz-viewid.
                READ TABLE t_workplaces
                           INTO e_default_wplace
                           WITH KEY wplacetype = l_wa_nwpvz-wplacetype
                                    wplaceid   = l_wa_nwpvz-wplaceid.
                EXIT.
              ENDIF.
            ENDLOOP.
          ENDIF.
        ENDIF.   " describe table lt_nwpvz -> if sy-tfill > 0

      ENDIF.                           " IF T_VIEWS IS REQUESTED

*     Falls zur Arb.umf.-Sicht-Zuordnung kein Text gepflegt ist,
*     dann aus der Sicht nehmen
      LOOP AT t_nwpvz INTO l_wa_nwpvz WHERE txt IS INITIAL.
        READ TABLE gt_nwview INTO l_wa_nwview
                   WITH KEY viewtype = l_wa_nwpvz-viewtype
                            viewid   = l_wa_nwpvz-viewid.
        CHECK sy-subrc = 0 AND NOT l_wa_nwview-txt IS INITIAL.
        l_wa_nwpvz-txt = l_wa_nwview-txt.
        MODIFY t_nwpvz FROM l_wa_nwpvz.
      ENDLOOP.

*     Spezielle Daten für Arbeitsumfeldtypen 001 lesen und puffern
      IF l_wplacetype = '001'.
        LOOP AT t_nwpvz WHERE txt CA '&'.
          READ TABLE gt_nwplace_001
                     INTO l_wa_nwplace_001 WITH KEY
                     wplacetype = t_nwpvz-wplacetype
                     wplaceid   = t_nwpvz-wplaceid.
          IF sy-subrc <> 0.
            SELECT SINGLE * FROM nwplace_001 INTO l_wa_nwplace_001
                   WHERE  wplacetype  = t_nwpvz-wplacetype
                   AND    wplaceid    = t_nwpvz-wplaceid.
            IF sy-subrc = 0.
              APPEND l_wa_nwplace_001 TO gt_nwplace_001.
            ENDIF.
          ENDIF.
        ENDLOOP.
        t_workplaces_001[] = gt_nwplace_001[].
      ENDIF.

*     Platzhalter für OEs im Text füllen (nicht im Puffer befüllen,
*     da sonst die Platzhalter nicht aktualisiert werden können)
      IF i_replace_substitute = on AND t_nwpvz IS REQUESTED.
        LOOP AT t_nwpvz INTO l_wa_nwpvz WHERE txt CA '&'.

*         MED63199 Read Data only for needed placeids and viewtypes CKi
          IF ( i_only_wplaceid <> space AND
              l_wa_nwpvz-wplaceid NE i_only_wplaceid ) OR
             ( i_only_viewtype <> space AND
              l_wa_nwpvz-viewtype <> i_only_viewtype ).
            CONTINUE.
          ENDIF.
*         otherwise Read data and change txt  " End of MED63199

          CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
            EXPORTING
              i_viewid    = l_wa_nwpvz-viewid
              i_viewtype  = l_wa_nwpvz-viewtype
              i_caller    = 'LN1WORKPLACEU01'
              i_placeid   = l_wa_nwpvz-wplaceid
              i_placetype = l_wa_nwpvz-wplacetype
            IMPORTING
              e_rc        = l_rc
              e_view      = l_wa_nwview
            TABLES
              t_selvar    = lt_selvar.
          IF l_rc = 0.
            l_wa_nwpvz-txt = l_wa_nwview-txt.
          ELSE.
*           Aus der Spezialisierungstabelle (bzw. Puffer) lesen
            IF l_wa_nwpvz-wplacetype = '001'.
              READ TABLE gt_nwplace_001 INTO l_wa_nwplace_001 WITH KEY
                         wplacetype = l_wa_nwpvz-wplacetype
                         wplaceid   = l_wa_nwpvz-wplaceid.
              IF sy-subrc <> 0.
                CLEAR l_wa_nwplace_001.
              ENDIF.
            ELSE.
              CLEAR l_wa_nwplace_001.
            ENDIF.
            PERFORM fill_oe_in_text USING    l_wa_nwpvz-wplacetype
                                             l_wa_nwpvz-wplaceid
                                             l_wa_nwplace_001
                                    CHANGING l_wa_nwpvz-txt.
          ENDIF.

          MODIFY t_nwpvz FROM l_wa_nwpvz.
        ENDLOOP.
      ENDIF.                           " i_replace_substitute = on.

*     MED-39774: BEGIN OF INSERT (only show the right viewtypes)
      IF l_wplacetype = '001'.
        PERFORM get_viewtype_texts(sapln1workplace) USING    l_wplacetype
                                                             on
                                                    CHANGING lt_list.
        REFRESH lr_range.
        LOOP AT lt_list INTO ls_list.
          ls_range-sign   = 'I'.
          ls_range-option = 'EQ'.
          ls_range-low    = ls_list-key.
          APPEND ls_range TO lr_range.
        ENDLOOP.
        DELETE t_nwpvz WHERE viewtype NOT IN lr_range.
        DELETE t_views WHERE viewtype NOT IN lr_range.
      ENDIF.
*     MED-39774: END OF INSERT

    ENDIF.   " IF T_VIEWS IS REQUESTED OR T_NWPUSZ IS REQUESTED

  ELSEIF i_mode = 'U'.
*   UPDATE, d.h. dem FBS werden Daten mitgegeben, die er in seinen
*   Puffer stellen muss ...
    APPEND LINES OF t_workplaces TO gt_nwplace.
    APPEND LINES OF t_nwpusz     TO gt_nwpusz.
    APPEND LINES OF t_nwpvz      TO gt_nwpvz.
    APPEND LINES OF t_nwpvz_usz  TO gt_nwpvz_usz.
    APPEND LINES OF t_views      TO gt_nwview.
    IF l_wplacetype = '001'.
      APPEND LINES OF t_workplaces_001 TO gt_nwplace_001.
    ENDIF.

  ENDIF.   " else if i_mode = 'L' or i_mode = 'R'  ELSEIF i_mode = 'U'.

ENDFUNCTION.
