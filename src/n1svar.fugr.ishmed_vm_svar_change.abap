FUNCTION ishmed_vm_svar_change.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEW) TYPE  NWVIEW
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_MODE) TYPE  N1FLD-N1MODE DEFAULT 'D'
*"     VALUE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'UPD'
*"     VALUE(I_SAVE) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT ' '
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"     VALUE(I_READ_BUFFER) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_BUFFER) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_READ_VIEWVAR) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_SVARIANTID) TYPE  RNSVAR-SVARIANTID DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(E_VIEWVAR) TYPE  RNVIEWVAR
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_messages       TYPE tyt_messages,
        lt_selvar         TYPE tyt_selvars,
        lt_params         TYPE TABLE OF vanz,               " ID 9860
        l_viewvar         LIKE rnviewvar,
        l_viewvar_old     TYPE rnviewvar,
        l_viewvar_chg     TYPE rnviewvar,
        l_viewvar_sav     TYPE rnviewvar,
        l_wa_msg          LIKE bapiret2,
        l_mode_buf(1)     TYPE c,
        l_exec_command    LIKE sy-tcode,
        l_rc              LIKE sy-subrc,
        l_vcode           TYPE ish_vcode,
        l_einri           LIKE tn01-einri.

* Initialisierung + Belegung globaler Variablen
  CLEAR: e_rc, e_viewvar, l_viewvar, l_einri.

  CLEAR:   t_messages, lt_messages, lt_selvar.
  REFRESH: t_messages, lt_messages, lt_selvar.

* Sichttyp ist unbedingt erforderlich
  IF i_view-viewtype IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Nur Verarbeitungscode INS und UPD erlaubt
  l_vcode = i_vcode.
  IF l_vcode <> g_vcode_insert AND l_vcode <> g_vcode_update.
    l_vcode = g_vcode_update.
  ENDIF.

* Lesen des Inhalts der Selektionsvariante ****************************
  IF l_vcode <> g_vcode_insert AND i_read_viewvar = on.
    IF i_read_buffer = on.
      l_mode_buf = 'L'.                             " Load
    ELSE.
      l_mode_buf = 'R'.                             " Refresh
    ENDIF.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
         EXPORTING
              i_viewid      = i_view-viewid
              i_viewtype    = i_view-viewtype
              i_mode        = l_mode_buf
              i_caller      = 'LN1SVARU01'
              i_placeid     = i_place-wplaceid
              i_placetype   = i_place-wplacetype
           IMPORTING
              e_rc          = e_rc
*             E_SELVAR_TXT  =
              e_viewvar     = l_viewvar
           TABLES
              t_selvar      = lt_selvar
              t_messages    = lt_messages.
    APPEND LINES OF lt_messages TO t_messages.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    l_viewvar-viewtype = i_view-viewtype.
    l_viewvar-viewid   = i_view-viewid.
  ENDIF.

  l_viewvar_old = l_viewvar.

* Reportname der Selektionsvariante der Sicht muß befüllt sein
  IF l_viewvar-reports IS INITIAL.
    PERFORM get_report_selvar(sapln1workplace) USING i_view-viewtype
                                                     i_view-viewid
                                            CHANGING l_viewvar-reports.
  ENDIF.

* Falls gewünscht eine andere Selektionsvariante ändern
  IF NOT i_svariantid IS INITIAL.
    l_viewvar-svariantid = i_svariantid.
  ENDIF.

* Je nach Modus -> Definieren oder Sichern ----------------------------
  IF i_mode = 'D'.                 " Define

* Selektionsvariante definieren ***************************************

*   Einrichtung aus dem speziellen Arbeitsumfeld lesen
    CASE i_place-wplacetype.
      WHEN '001'.                            " Workplace
        SELECT SINGLE einri FROM nwplace_001 INTO l_einri
               WHERE  wplacetype  = i_place-wplacetype
               AND    wplaceid    = i_place-wplaceid.
      WHEN OTHERS.
        EXIT. " Vorläufig keine anderen Arbeitsumfelder unterstützt ...
    ENDCASE.

*   ID 9860: Variantenattribute auslesen
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid    = i_view-viewid
        i_viewtype  = i_view-viewtype
        i_mode      = 'L'
        i_caller    = 'LN1SVARU01'
        i_placeid   = i_place-wplaceid
        i_placetype = i_place-wplacetype
      IMPORTING
        e_rc        = e_rc
      TABLES
        t_selparam  = lt_params
        t_messages  = lt_messages.
    APPEND LINES OF lt_messages TO t_messages.
    IF e_rc <> 0.
      EXIT.
    ENDIF.

*   Je Sichttyp wird ein Popup zur Sicht-Definition aufgerufen
*   Der Inhalt der Sel.variante wird dabei geändert zurückgeliefert
    PERFORM call_svar(sapln1workplace) TABLES   lt_selvar
                                                lt_params
                                       USING    i_view-viewtype
                                                l_einri
                                                on
                                       CHANGING l_exec_command.
    IF l_exec_command <> 'ENTR'  AND
       l_exec_command <> 'APPLY' AND
       l_exec_command <> 'SAVE'.
      e_rc = 2.                    " Cancel
      EXIT.
    ENDIF.
    l_mode_buf = 'U'.              " Update

  ELSEIF i_mode = 'S'.             " Save

* Selektionsvariante sichern ******************************************

    l_mode_buf = 'U'.              " Update
*   Mit Hilfe der Standard-Funktionen eine Selektionsvariante sichern
    IF l_viewvar-svariantid IS INITIAL.
*     Neue Variante anlegen
      l_viewvar_sav = l_viewvar.
      l_viewvar_chg = l_viewvar.
      CALL FUNCTION 'RS_VARIANT_SCREEN'
           EXPORTING
              report        = l_viewvar_chg-reports
*             RNAME_VISIBLE = ' '
*             NEW_TITLE     = ' '
              variant       = l_viewvar_chg-svariantid
           IMPORTING
              report        = l_viewvar_chg-reports
              variant       = l_viewvar_chg-svariantid.
*     Wenn die Variante geändert wurde, soll sie in der Sicht gesichert
*     werden (wenn die Variante auch tatsächlich existiert)
      IF l_viewvar-svariantid <> l_viewvar_chg-svariantid.
        l_viewvar = l_viewvar_chg.
        CLEAR l_rc.
        CALL FUNCTION 'RS_VARIANT_EXISTS'
          EXPORTING
            report              = l_viewvar-reports
            variant             = l_viewvar-svariantid
          IMPORTING
            r_c                 = l_rc
          EXCEPTIONS
            not_authorized      = 1
            no_report           = 2
            report_not_existent = 3
            report_not_supplied = 4
            OTHERS              = 5.
        IF sy-subrc = 0 AND l_rc = 0.
*         Sichern (Verbuchen) der Selektionsvariante in die Sicht,
*         falls gewünscht
          IF i_save = on.
            PERFORM verbuchen_nwview_var USING l_viewvar l_viewvar_old
                                                i_update_task.
          ENDIF.
        ELSE.
          l_viewvar = l_viewvar_sav.
          l_mode_buf = ' '.              " Puffer nicht ändern
        ENDIF.
      ENDIF.
    ELSE.
*     Bestehende Variante ändern
      CALL FUNCTION 'RS_VARIANT_CHANGE'
           EXPORTING
                report               = l_viewvar-reports
                variant              = l_viewvar-svariantid
*               VALUE_OR_ATTR        = 'V'
*          IMPORTING
*               VARIANT              =
          EXCEPTIONS
                OTHERS               = 1.
      IF sy-subrc <> 0.
        IF NOT sy-msgid IS INITIAL AND NOT sy-msgno IS INITIAL.
          PERFORM build_bapiret2(sapmn1pa)
                  USING sy-msgty sy-msgid sy-msgno sy-msgv1 sy-msgv2
                        sy-msgv3 sy-msgv4 ' ' ' ' ' '
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO t_messages.
        ENDIF.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDIF.
*   Inhalt dieser Selektionsvariante lesen
    CLEAR:   lt_messages, lt_selvar.
    REFRESH: lt_messages, lt_selvar.
    PERFORM read_selvar USING    l_viewvar  i_place
                        CHANGING lt_selvar  lt_messages  e_rc.
    APPEND LINES OF lt_messages TO t_messages.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
*   Nun die Datenkonvertierung durchführen
    PERFORM convert_selvar(sapln1workplace) TABLES lt_selvar
                                            USING  'X' 'S'
                                                   l_viewvar.

  ELSE.

    EXIT. " keine anderen Modus möglich !

  ENDIF.  " I_MODE

* Commit Work, falls gewünscht
  IF i_commit = on.
    COMMIT WORK AND WAIT.
  ENDIF.

* Schreiben der Daten der Selektionsvariante in den Puffer ************
  IF i_update_buffer = on AND NOT l_mode_buf = ' '.
    CLEAR lt_messages. REFRESH lt_messages.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
         EXPORTING
              i_viewid      = l_viewvar-viewid
              i_viewtype    = l_viewvar-viewtype
              i_mode        = l_mode_buf
              i_caller      = 'LN1SVARU01'
              i_placeid     = i_place-wplaceid
              i_placetype   = i_place-wplacetype
         IMPORTING
              e_rc          = e_rc
*             E_SELVAR_TXT  =
*             E_VIEWVAR     =
         TABLES
              t_selvar      = lt_selvar
              t_messages    = lt_messages.
    APPEND LINES OF lt_messages TO t_messages.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDIF.

* Sicht mit Selektionsvariante zurückliefern
  e_viewvar = l_viewvar.

ENDFUNCTION.
