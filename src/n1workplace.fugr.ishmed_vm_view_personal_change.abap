FUNCTION ishmed_vm_view_personal_change.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEW) TYPE  NWVIEW
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'UPD'
*"     VALUE(I_MODE) TYPE  CHAR3 DEFAULT 'SAF'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT ' '
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"     VALUE(I_SAVE_TYPE) TYPE  ISH_ON_OFF DEFAULT 'U'
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_nwview_pers         TYPE nwview_pers,
        l_nwview_pers_new     TYPE vnwview_pers,
        lt_nwview_pers        TYPE TABLE OF nwview_pers,
        lt_nwview_pers_new    TYPE TABLE OF vnwview_pers,
        lt_nwview_pers_old    TYPE TABLE OF vnwview_pers,
        lt_messages           TYPE TABLE OF bapiret2,
        l_message             LIKE LINE OF lt_messages,
        lt_selvar             TYPE TABLE OF rsparams,       " ID 7531
        lt_fvar               TYPE TABLE OF v_nwfvar,       " ID 10418
        lt_dispvar            TYPE lvc_t_fcat,
        lt_dispsort           TYPE lvc_t_sort,
        lt_dispfilter         TYPE lvc_t_filt,
        l_layout              TYPE lvc_s_layo,
        l_viewvar             TYPE rnviewvar,
        ls_refresh            TYPE rnrefresh,
        l_refresh_interval    TYPE n_refresh_interval,
        l_usr_param_value     TYPE usr05-parva,
        l_open_nodes          TYPE n_open_nodes,
        l_changed             TYPE ish_on_off,
        l_rc                  TYPE sy-subrc,
        l_rfsh_changed        TYPE ish_on_off,
        l_grid_changed        TYPE ish_on_off,
        l_tree_changed        TYPE ish_on_off,
        l_svar_changed        TYPE ish_on_off,
        l_avar_changed        TYPE ish_on_off,
        l_fvar_changed        TYPE ish_on_off.

  CLEAR: e_rc, l_nwview_pers, l_nwview_pers_new, l_viewvar, l_rc,
         l_svar_changed, l_avar_changed, l_fvar_changed,
         l_grid_changed, l_tree_changed, l_rfsh_changed,
         l_open_nodes, l_layout.

  REFRESH: t_messages, lt_nwview_pers_new, lt_nwview_pers_old,
           lt_nwview_pers, lt_dispvar, lt_dispsort, lt_dispfilter,
           lt_selvar, lt_fvar.


  IF i_vcode = 'DEL' AND i_mode = 'XXX'.

*   Alle Pers.infos zur Sicht für alle Benutzer löschen
    SELECT * FROM nwview_pers INTO TABLE lt_nwview_pers
           WHERE  viewtype  = i_view-viewtype
           AND    viewid    = i_view-viewid.                "#EC *
    CHECK sy-subrc = 0.
    LOOP AT lt_nwview_pers INTO l_nwview_pers.
*     Persönl. Selektionsvariante löschen, wenn vorhanden
      IF NOT l_nwview_pers-reports    IS INITIAL AND
         NOT l_nwview_pers-svariantid IS INITIAL.           "#EC NEEDED
*       --> dzt. nicht implementiert
      ENDIF.
*     Persönl. Layout löschen, wenn vorhanden
      IF NOT l_nwview_pers-reporta    IS INITIAL AND
         NOT l_nwview_pers-username   IS INITIAL AND
         NOT l_nwview_pers-avariantid IS INITIAL.
        PERFORM delete_avar USING l_nwview_pers.
      ENDIF.
*     Persönl. Funktionsvariante löschen, wenn vorhanden
      IF NOT l_nwview_pers-fvariantid IS INITIAL.           "#EC NEEDED
*       --> dzt. nicht implementiert
      ENDIF.
*     Personalisierungseintrag löschen
      l_nwview_pers_new = l_nwview_pers.
      l_nwview_pers_new-kz = 'D'.
      APPEND l_nwview_pers_new TO lt_nwview_pers_new.
    ENDLOOP.
*   ID 10519: beim Löschen (Grundeinstellungen wiederherstellen)
*   soll im Anschluß der Puffer immer refreshed werden, da auch
*   die temporäre Selektion gelöscht werden soll!
    l_svar_changed = on.                                    " ID 10418
    l_avar_changed = on.                                    " ID 10418
    l_fvar_changed = on.                                    " ID 10418

  ELSE.

*   Personalisierungsinformation des aktuellen Benutzers pflegen
    SELECT SINGLE * FROM nwview_pers INTO l_nwview_pers
           WHERE  benutzer  = sy-uname
           AND    viewtype  = i_view-viewtype
           AND    viewid    = i_view-viewid.
    IF sy-subrc = 0.
*     Personalisierungsinformation ändern bzw. löschen
      l_nwview_pers_new = l_nwview_pers.
*     Alte Daten
      APPEND l_nwview_pers TO lt_nwview_pers_old.
    ELSE.
*     Personalisierungsinformation anlegen
      CLEAR: l_nwview_pers, l_nwview_pers_new.
      l_nwview_pers_new-mandt           = sy-mandt.
      l_nwview_pers_new-benutzer        = sy-uname.
      l_nwview_pers_new-viewtype        = i_view-viewtype.
      l_nwview_pers_new-viewid          = i_view-viewid.
      l_nwview_pers_new-grid_row_marker = '*'.
      l_nwview_pers_new-tree_open_nodes = '*'.
    ENDIF.

*   Je nach Verarbeitungscode die Personalisierungsinformation
*   der Sicht verarbeiten
    CASE i_vcode.
      WHEN 'DEL'.                        " Löschen
*       Nur notwendig, wenn Personalisierungsinformationen existieren
        IF NOT l_nwview_pers IS INITIAL.
*         Persönl. Selektionsvariante löschen, wenn vorhanden
          IF NOT l_nwview_pers-reports    IS INITIAL AND
             NOT l_nwview_pers-svariantid IS INITIAL.       "#EC NEEDED
*           --> dzt. nicht implementiert
          ENDIF.
*         Persönl. Layout löschen, wenn vorhanden
          IF NOT l_nwview_pers-reporta    IS INITIAL AND
             NOT l_nwview_pers-username   IS INITIAL AND
             NOT l_nwview_pers-avariantid IS INITIAL.
            CALL FUNCTION 'ISHMED_VM_AVAR_USER_SPEC'
              EXPORTING
                i_view        = i_view
                i_place       = i_place
                i_vcode       = i_vcode                " 'DEL'
                i_update_task = i_update_task
                i_commit      = i_commit
                i_caller      = i_caller
              IMPORTING
                e_rc          = l_rc
                e_changed     = l_changed
              TABLES
                t_messages    = t_messages.
*           IF l_rc = 0 AND l_changed = on.
*           ENDIF.
            IF l_rc = 2.   "cancel!
              l_rc = 0.
            ENDIF.
          ENDIF.
*         Persönl. Funktionsvariante löschen, wenn vorhanden
          IF NOT l_nwview_pers-fvariantid IS INITIAL.       "#EC NEEDED
*           --> dzt. nicht implementiert
          ENDIF.
*         Den kompletten Personalisierungseintrag für diese Sicht
*         löschen (automatisch werden damit auch die Werte für die
*         Grid/Tree-KZ gelöscht)
          l_nwview_pers_new-kz = 'D'.
        ENDIF.   " Personalisierungsinformationen vorhanden?
*       ID 10519: beim Löschen (Grundeinstellungen wiederherstellen)
*       soll im Anschluß der Puffer immer refreshed werden, da auch
*       die temporäre Selektion gelöscht werden soll!
        l_svar_changed = on.                                " ID 10418
        l_avar_changed = on.                                " ID 10418
        l_fvar_changed = on.                                " ID 10418

      WHEN 'UPD'.    " Ändern oder Anlegen (wenn noch keine existiert)
*       Welche Information soll gepflegt werden?
        IF i_mode = 'R'.
*         Aktualisierungsintervall in Sekunden (für Autorefresh) pflegen
          IF l_nwview_pers IS INITIAL.
*           new personal record - use autorefresh interval of view
            CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
              EXPORTING
                i_viewid   = i_view-viewid
                i_viewtype = i_view-viewtype
                i_caller   = 'LN1WORKPLACEU04'
                i_placeid  = i_place-wplaceid
              IMPORTING
                e_refresh  = ls_refresh.
            l_refresh_interval = ls_refresh-rfsh_interval.
          ELSE.
*           existing personal record - use personal autorefresh interval
            l_refresh_interval = l_nwview_pers_new-rfsh_interval.
          ENDIF.
          CALL FUNCTION 'ISHMED_POPUP_ENTER_VALUES'
            EXPORTING
              i_field              = 'REFRESH_INTERVAL'
              i_table              = 'RNTOOLS'
              i_title_of_popup     = 'Automatische Aktualisierung'(009)
              i_numeric_only       = on
              i_external_check     = on
              i_keyword            = 'Intervall in Sekunden'(010)
              i_check_program_name = 'SAPLN1WORKPLACE'
              i_check_form_name    = 'CHECK_AUTORFSH_INTERVAL'
              i_f1fieldname        = 'N_REFRESH_INTERVAL'
            CHANGING
              c_value              = l_refresh_interval
            EXCEPTIONS
              cancelled            = 1
              input_error          = 2
              OTHERS               = 3.
          CASE sy-subrc.
            WHEN 0.                                       " ok
              IF l_refresh_interval = 0.
                l_refresh_interval = 300.    " default 5 minutes
              ENDIF.
            WHEN 1.                                       " cancel
              e_rc = 2.
              EXIT.
            WHEN OTHERS.                                  " error
              e_rc = 1.
              CLEAR l_message.
              l_message-type       = 'S'.
              l_message-id         = sy-msgid.
              l_message-number     = sy-msgno.
              l_message-message_v1 = sy-msgv1.
              l_message-message_v2 = sy-msgv2.
              l_message-message_v3 = sy-msgv3.
              l_message-message_v4 = sy-msgv4.
              APPEND l_message TO t_messages.
              EXIT.
          ENDCASE.
          l_nwview_pers_new-rfsh_interval = l_refresh_interval.
          l_rfsh_changed = on.
        ELSEIF i_mode = 'RD'.
*         Aktualisierungsintervall (für Autorefresh) initialisieren
          CLEAR l_nwview_pers_new-rfsh_interval.
          l_rfsh_changed = on.
        ELSEIF i_mode = 'G'.
*         Grid Row Marker - Zeilenmarkierungstaste umswitchen
          IF i_view-viewtype <> '004'.
            IF l_nwview_pers_new-grid_row_marker = on.
              l_nwview_pers_new-grid_row_marker = off.
            ELSEIF l_nwview_pers_new-grid_row_marker = off.
              l_nwview_pers_new-grid_row_marker = on.
            ELSEIF l_nwview_pers_new-grid_row_marker = '*'.
*             Persönlicher Wert noch nicht gepflegt, daher
*             SET/GET-Parameter lesen und dann umswitchen
              CALL FUNCTION 'ISH_USR05_GET'
                EXPORTING
                  ss_bname         = sy-uname
                  ss_parid         = 'WP_ALV_MRKBUTTON'
                IMPORTING
                  ss_value         = l_usr_param_value
                EXCEPTIONS
                  parid_not_found  = 1
                  bname_is_initial = 2
                  parid_is_initial = 3
                  OTHERS           = 4.
              IF sy-subrc = 0.
                IF l_usr_param_value = off.
                  l_nwview_pers_new-grid_row_marker = on.
                ELSE.
                  l_nwview_pers_new-grid_row_marker = off.
                ENDIF.
              ELSE.
                l_nwview_pers_new-grid_row_marker = on.
              ENDIF.
            ENDIF.
            l_grid_changed = on.
          ELSE.
            EXIT.    " not possible for trees!
          ENDIF.
        ELSEIF i_mode = 'T'.
*         Tree Open Nodes - Initial geöffnete Knoten festlegen
          IF i_view-viewtype = '004'.
            IF l_nwview_pers_new-tree_open_nodes = '*'.
*             Persönlicher Wert noch nicht gepflegt, daher
*             SET/GET-Parameter je Sicht lesen
              CASE i_view-viewtype.
                WHEN '004'.
                  GET PARAMETER ID 'N1WP_004_EXP'
                                FIELD l_nwview_pers_new-tree_open_nodes.
                WHEN OTHERS.
                  CLEAR l_nwview_pers_new-tree_open_nodes.
              ENDCASE.
            ENDIF.
            CALL FUNCTION 'ISHMED_VM_TREE_OPEN_NODES'
              EXPORTING
                i_view       = i_view
                i_place      = i_place
                i_open_nodes = l_nwview_pers_new-tree_open_nodes
              IMPORTING
                e_rc         = l_rc
                e_open_nodes = l_open_nodes.
            CASE l_rc.
              WHEN 0.          " OK
                l_nwview_pers_new-tree_open_nodes = l_open_nodes.
                l_tree_changed = on.
              WHEN 1.          " Error
                e_rc = 1.
              WHEN 2.          " Cancel
                e_rc = 2.
            ENDCASE.
          ELSE.
            EXIT.  " not possible for grids!
          ENDIF.
        ELSE.
*         Persönl. Selektionsvariante sichern
          IF i_mode CA 'S'.
*           --> dzt. nicht implementiert
            l_svar_changed = off.
*           l_nwview_pers_new-reports    = l_viewvar-reports.
*           l_nwview_pers_new-svariantid = l_viewvar-svariantid.
*           l_nwview_pers_new-flag1      = l_viewvar-flag1
*           l_nwview_pers_new-flag2      = l_viewvar-flag2.
          ENDIF.
*         Persönl. Layout sichern
          IF i_mode CA 'A'.
            CALL FUNCTION 'ISHMED_VM_AVAR_USER_SPEC'
              EXPORTING
                i_view        = i_view
                i_place       = i_place
                i_vcode       = i_vcode  " 'UPD'
                i_update_task = i_update_task
                i_commit      = i_commit
                i_caller      = i_caller
                i_save_type   = i_save_type                 " ID 8514
              IMPORTING
                e_rc          = e_rc
                e_viewvar     = l_viewvar
                e_changed     = l_changed
              TABLES
                t_messages    = t_messages.
            IF e_rc = 0 AND l_changed = on.
*             Persönl. Layout wurde geändert und gesichert
*             --> Personal.info. ändern/anlegen
              l_avar_changed = on.
              l_nwview_pers_new-reporta    = l_viewvar-reporta.
              l_nwview_pers_new-handle     = l_viewvar-handle.
              l_nwview_pers_new-log_group  = l_viewvar-log_group.
              l_nwview_pers_new-username   = l_viewvar-username.
              l_nwview_pers_new-avariantid = l_viewvar-avariantid.
              l_nwview_pers_new-type       = l_viewvar-type.
            ENDIF.
            IF e_rc = 2.   "cancel!
              e_rc = 0.
            ENDIF.
          ENDIF.
*         Persönl. Funktionsvariante sichern
          IF i_mode CA 'F'.
*           --> dzt. nicht implementiert
            l_fvar_changed = off.
*           l_nwview_pers_new-fvariantid = l_viewvar-fvariantid.
          ENDIF.
        ENDIF.
*       Änderungen an Kennzeichen oder Varianten festgestellt?
        IF l_rfsh_changed = on OR
           l_grid_changed = on OR
           l_tree_changed = on OR
           l_svar_changed = on OR
           l_avar_changed = on OR
           l_fvar_changed = on.
*         Anlegen oder Ändern?
          IF l_nwview_pers IS INITIAL.
            l_nwview_pers_new-kz = 'I'.
          ELSE.
            l_nwview_pers_new-kz = 'U'.
          ENDIF.
        ENDIF.

      WHEN OTHERS.
        EXIT.
    ENDCASE.

*   Verbuchung durchführen?
    IF NOT l_nwview_pers_new-kz IS INITIAL.
      APPEND l_nwview_pers_new TO lt_nwview_pers_new.
*    ELSE.                                             " ID 7531 REM
*      exit.                                           " ID 7531 REM
    ENDIF.

  ENDIF.      " alle Pers.infos für ALLE Benutzer löschen?

* Verbuchung
  DESCRIBE TABLE lt_nwview_pers_new.
  IF sy-tfill > 0.
    IF i_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWVIEW_PERS' IN UPDATE TASK
         EXPORTING
*          I_DATE                = SY-DATUM
           i_tcode               = sy-tcode
*          I_UNAME               = SY-UNAME
*          I_UTIME               = SY-UZEIT
         TABLES
           t_n_nwview_pers       = lt_nwview_pers_new
           t_o_nwview_pers       = lt_nwview_pers_old.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWVIEW_PERS'
         EXPORTING
*          I_DATE                = SY-DATUM
           i_tcode               = sy-tcode
*          I_UNAME               = SY-UNAME
*          I_UTIME               = SY-UZEIT
         TABLES
           t_n_nwview_pers       = lt_nwview_pers_new
           t_o_nwview_pers       = lt_nwview_pers_old.
    ENDIF.
    IF i_commit = on.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDIF.

* Puffer refreshen (auch beim Löschen - ID 7531) --> ID 10418 REMARK
*  IF l_avar_changed = on OR i_vcode = 'DEL'.
*    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
*         EXPORTING
*              i_viewid     = i_view-viewid
*              i_viewtype   = i_view-viewtype
*              i_mode       = 'R'
*              i_caller     = 'LN1WORKPLACEU04'
*              i_placeid    = i_place-wplaceid
*              i_placetype  = i_place-wplacetype
*         IMPORTING
*              e_rc         = l_rc
*         TABLES
*              t_selvar     = lt_selvar                     " ID 7531
*              t_messages   = lt_messages
*         CHANGING
*              c_dispvar    = lt_dispvar
*              c_dispsort   = lt_dispsort
*              c_dispfilter = lt_dispfilter
*              c_layout     = l_layout.
*  ENDIF.

* ID 10418: Nur die jeweiligen Puffer von Selektionsvarianten,
*           Layouts oder Funktionvarianten refreshen, wenn auch
*           tatsächlich Änderungen (oder Löschung) stattgefunden
*           haben!
  IF l_svar_changed = on.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid    = i_view-viewid
        i_viewtype  = i_view-viewtype
        i_mode      = 'R'
        i_caller    = 'LN1WORKPLACEU04'
        i_placeid   = i_place-wplaceid
        i_placetype = i_place-wplacetype
      IMPORTING
        e_rc        = l_rc
      TABLES
        t_selvar    = lt_selvar
        t_messages  = lt_messages.
  ENDIF.
  IF l_avar_changed = on.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid     = i_view-viewid
        i_viewtype   = i_view-viewtype
        i_mode       = 'R'
        i_caller     = 'LN1WORKPLACEU04'
        i_placeid    = i_place-wplaceid
        i_placetype  = i_place-wplacetype
      IMPORTING
        e_rc         = l_rc
      TABLES
        t_messages   = lt_messages
      CHANGING
        c_dispvar    = lt_dispvar
        c_dispsort   = lt_dispsort
        c_dispfilter = lt_dispfilter
        c_layout     = l_layout.
  ENDIF.
  IF l_fvar_changed = on.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid    = i_view-viewid
        i_viewtype  = i_view-viewtype
        i_mode      = 'R'
        i_caller    = 'LN1WORKPLACEU04'
        i_placeid   = i_place-wplaceid
        i_placetype = i_place-wplacetype
      IMPORTING
        e_rc        = l_rc
      TABLES
        t_fvar      = lt_fvar
        t_messages  = lt_messages.
  ENDIF.

ENDFUNCTION.
