FUNCTION ishmed_nwicons_get.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  TABLES
*"      T_NWICONS STRUCTURE  NWICONS
*"----------------------------------------------------------------------

  DATA: lt_nwicons  TYPE SORTED TABLE OF nwicons
                    WITH NON-UNIQUE KEY einri col_indicator.
  DATA: l_nwicons TYPE nwicons,
        l_dom_val TYPE dd07v-domvalue_l,
        l_dom_txt TYPE dd07v-ddtext.

* START MED-40483 2010/06/16
  TYPES: BEGIN OF ty_itext,
           value1 LIKE dd07v-domvalue_l,
           text   LIKE dd07v-ddtext,
         END OF ty_itext,
         tyt_itext TYPE HASHED TABLE OF ty_itext WITH UNIQUE KEY value1.
  STATICS: lt_text TYPE tyt_itext.
  DATA ls_text    LIKE LINE OF lt_text.
  DATA lt_domvalue TYPE TABLE OF dd07v.
  FIELD-SYMBOLS <ls_domvalue> TYPE dd07v.
* END MED-40483

  CLEAR lt_nwicons. REFRESH lt_nwicons.

  DESCRIBE TABLE t_nwicons.
  CHECK sy-tfill > 0.

  IF sy-tfill = 1.
    READ TABLE t_nwicons INDEX 1.
    IF t_nwicons-col_indicator IS INITIAL.
*     Select all icons for institution
      SELECT * FROM nwicons INTO TABLE lt_nwicons
             WHERE  einri = t_nwicons-einri.
      SELECT * FROM nwicons APPENDING TABLE lt_nwicons
             WHERE  einri = '*'.
      REFRESH t_nwicons.
      t_nwicons[] = lt_nwicons[].
    ELSE.
*     Select the one requested icon
      SELECT SINGLE * FROM nwicons INTO l_nwicons
             WHERE  einri          = t_nwicons-einri
             AND    col_indicator  = t_nwicons-col_indicator.
      IF sy-subrc <> 0.
        SELECT SINGLE * FROM nwicons INTO l_nwicons
               WHERE  einri          = '*'
               AND    col_indicator  = t_nwicons-col_indicator.
      ENDIF.
      IF sy-subrc = 0.
        INSERT l_nwicons INTO TABLE lt_nwicons.
      ENDIF.
    ENDIF.
  ELSE.
*   Select all requested icons
    SELECT * FROM nwicons INTO TABLE lt_nwicons
           FOR ALL ENTRIES IN t_nwicons
           WHERE  einri          = t_nwicons-einri
           AND    col_indicator  = t_nwicons-col_indicator.
    SELECT * FROM nwicons APPENDING TABLE lt_nwicons
           FOR ALL ENTRIES IN t_nwicons
           WHERE  einri          = '*'
           AND    col_indicator  = t_nwicons-col_indicator.
  ENDIF.

  LOOP AT t_nwicons.
    READ TABLE lt_nwicons INTO l_nwicons
         WITH TABLE KEY einri          = t_nwicons-einri
                        col_indicator  = t_nwicons-col_indicator.
    IF sy-subrc <> 0.
      READ TABLE lt_nwicons INTO l_nwicons
           WITH TABLE KEY einri          = '*'
                          col_indicator  = t_nwicons-col_indicator.
    ENDIF.
    IF sy-subrc = 0.
      IF NOT l_nwicons-icon IS INITIAL.
*       User-defined Icon
        t_nwicons-icon = l_nwicons-icon.
      ELSEIF NOT l_nwicons-letter IS INITIAL.
*       User-defined Letter
        t_nwicons-icon(3)   = '+++'.
        t_nwicons-icon+3(1) = l_nwicons-letter.
        t_nwicons-letter    = l_nwicons-letter.
      ENDIF.
    ENDIF.
*
    IF t_nwicons-icon IS INITIAL.
*     Standard Icons
      CASE t_nwicons-col_indicator.
        WHEN '006'.                    " Risikoinformationen vorhanden
          t_nwicons-icon = icon_warning.
        WHEN '007'.                    " Pflegeleistungen vorhanden
          t_nwicons-icon = icon_okay.
        WHEN '008'.           " Pflegeplan vorhanden und bereits fertig
          t_nwicons-icon = icon_led_green.
        WHEN '009'.           " Pflegeplan vorhanden aber nicht fertig
          t_nwicons-icon = icon_led_red.
        WHEN '013'.                    " Termin vorhanden
          t_nwicons-icon = icon_date.
        WHEN '014'.                    " Patient nüchtern
          t_nwicons-icon = icon_positive.
        WHEN '015'.                    " Patient Einwilligung (alle)
          t_nwicons-icon = icon_green_light.
        WHEN '016'.           " Patient Einwilligung (teilweise)
          t_nwicons-icon = icon_yellow_light.
        WHEN '017'.                    " Patient Einwilligung (keine)
          t_nwicons-icon = icon_red_light.
        WHEN '022'.                    " Patient ist Privatpatient
          t_nwicons-icon = icon_okay.
        WHEN '024'.                    " Gruppenleistungs-Kennzeichen
          t_nwicons-icon = icon_tree.
        WHEN '025'.                    " document released
          t_nwicons-icon = icon_release.
        WHEN '026'.                    " document with versions
          t_nwicons-icon = icon_history.
        WHEN '027'.                    " document with movements
          t_nwicons-icon = icon_sub_bodily_injury_treat.
        WHEN '028'.                    " document with services
          t_nwicons-icon = icon_sub_bodily_injury_treat.
        WHEN '029'.                    " Kurzaufnahme
          t_nwicons-icon = icon_okay.
        WHEN '030'.                    " Notaufnahme
          t_nwicons-icon = icon_okay.
        WHEN '031'.                    " Diagnose vorhanden
          t_nwicons-icon = icon_okay.
        WHEN '032'.                    " Terminvertretung
          t_nwicons-icon = icon_okay.
        WHEN '033'.                    " vorläufiger Patient
          t_nwicons-icon = icon_okay.
        WHEN '034'.                    " Satzart Leistung an KLAU
          t_nwicons-icon = icon_short_message.
        WHEN '035'.                    " Satzart Leistung
          t_nwicons-icon = icon_tools.
        WHEN '036'.                    " Lstg vorhanden, nicht freigeg.
          t_nwicons-icon = icon_led_red.
        WHEN '037'.                    " Lstg. vorhanden und freigeg.
          t_nwicons-icon = icon_led_green.
        WHEN '038'.                    " Diagnose verschlüsselt
          t_nwicons-icon = icon_okay.
        WHEN '039'.                    " Satzart Besuch
          t_nwicons-icon = icon_visit.
        WHEN '040'.                    " Satzart Termin
          t_nwicons-icon = icon_date.
        WHEN '041'.                    " Dokument im Initialstatus
          t_nwicons-icon = icon_led_red.
        WHEN '042'.                    " Pflegeplan vorh., aber beendet
          t_nwicons-icon = icon_led_yellow.
        WHEN '043'.                    " Behandlungsschein fehlt
          t_nwicons-icon = icon_led_red.
        WHEN '044' OR '045' OR '046' OR '047' OR '048' OR '049' OR
             '050'.                    " Sichttyp 008
          t_nwicons-icon = icon_led_red.
        WHEN '051'.                    " Fallproz fehlt
          t_nwicons-icon = icon_led_red.
        WHEN '052'.                    " Zusatzinfo zur Anford. vorh.
          t_nwicons-icon = icon_rating_positive.
        WHEN '053'.                    " Patient nicht nüchtern
          t_nwicons-icon = icon_negative.
        WHEN '054' OR '055' OR '056' OR '057' OR '058' OR '059' OR
             '060' OR '061' OR '062' OR '063' OR '064' OR '065' OR
             '066' OR '067' OR '068' OR '069' OR '070' OR '074' OR
             '080' OR '081' OR '082' OR '092' OR '093' OR '094' OR
             '095' OR '096' OR '097' OR '098' OR '100' OR '101'.
          t_nwicons-icon = icon_led_red. " Sichttyp 008
        WHEN '071'.                    " document not released
          t_nwicons-icon = icon_space.
        WHEN '072'.                    " document locked
          t_nwicons-icon = icon_locked.
        WHEN '073'.                    " document unlocked
          t_nwicons-icon = icon_unlocked.
        WHEN '075'.                    " Anästhesist erforderlich
          t_nwicons-icon = icon_checked.
        WHEN '076'.                    " Freigabe Operateur nicht vorh.
          t_nwicons-icon = icon_incomplete.
        WHEN '077'.                    " Freigabe Operateur vorh.
          t_nwicons-icon = icon_checked.
        WHEN '084'.                    " Planzeit manuell fixiert
          t_nwicons-icon = icon_checkbox.
        WHEN '085'.                    " OP nicht begonnen
          t_nwicons-icon = icon_incomplete.
        WHEN '086'.                    " OP begonnen
          t_nwicons-icon = icon_checked.
        WHEN '087'.                    " Prämedikation nicht vollständig
          t_nwicons-icon = icon_incomplete.
        WHEN '088'.                    " Prämedikation vollständig
          t_nwicons-icon = icon_checked.
        WHEN '089'.                    " document archived
          t_nwicons-icon = icon_viewer_optical_archive.
        WHEN '090'.                    " patient dead
          t_nwicons-icon = icon_header.
        WHEN '091'.                    " DRG complication suspicion
          t_nwicons-icon = icon_led_red.
        WHEN '099'.                    " attachments for case
          t_nwicons-icon = icon_attachment.
        WHEN '102'.                    " Patientpfad erledigt
          t_nwicons-icon = icon_led_green.
        WHEN '103'.                    " Patientpfad teilweise erledigt
          t_nwicons-icon = icon_led_yellow.
        WHEN '104'.                    " Patientpfad überfällig
          t_nwicons-icon = icon_led_red.
        WHEN '105'.                    " Temp. Behandlungsauftrag vorh.
          t_nwicons-icon = icon_bookmark.
        WHEN '106'.                    " Langtext existiert
          t_nwicons-icon = icon_display_text.
        WHEN '107'.                    " Ext. verabreichte Medikation
          t_nwicons-icon = icon_show_external_jobs.
        WHEN '108'. " Ext. verabr. Medikation relevant für Klin. Prüf.
          t_nwicons-icon = icon_dangerous_good_check.
        WHEN '109'.                    " Bedarfsmedikation
          t_nwicons-icon = icon_biw_scheduler.
        WHEN '110'.                    " Ein-/Ausschleichende Dosierung
          t_nwicons-icon = icon_period.
        WHEN '111'.                    " Änderungen an Verordnung vorh.
          t_nwicons-icon = icon_defect.
        WHEN '112'.                    " Verabreichungsbeding. prüfen
          t_nwicons-icon = icon_biw_monitor.
        WHEN '113'.                    " Verabreichung an amb. Patienten
          t_nwicons-icon = icon_outgoing_employee.
        WHEN '114'.                    " Neue Durchflußrate zur Prüfung
          t_nwicons-icon = icon_adjust_configuration.
        WHEN '115'.                    " Mehrere Durchflußraten defin.
          t_nwicons-icon = icon_ranking.
        WHEN '116'.                    " Medikationsereignisse exist.
          t_nwicons-icon = icon_status_partly_booked.
        WHEN '117'.       " Verabreichte Medikationsereignisse exist.
          t_nwicons-icon = icon_status_booked.
        WHEN '118'.         " Stornierte Medikationsereignisse exist.
          t_nwicons-icon = icon_status_reverse.
        WHEN '119'.                    " Substitution erlaubt
          t_nwicons-icon = icon_replace.
        WHEN '120'.                    " Betäubungsmittel
          t_nwicons-icon = '+++N'.
          t_nwicons-letter = 'N'.
        WHEN '121'.                    " Psychopharmakum
          t_nwicons-icon = '+++P'.
          t_nwicons-letter = 'P'.
        WHEN '122'.           " Verschreibungspflichtiges Arzneimittel
          t_nwicons-icon = '+++X'.
          t_nwicons-letter = 'X'.
        WHEN '123'.                    " Notfall
          t_nwicons-icon = icon_message_error_small.
        WHEN '124'.                    " Verabreicht von Betreuer
          t_nwicons-icon = icon_physical_sample.
        WHEN '125'.                    " PRN Masterevent
          t_nwicons-icon = icon_biw_scheduler.
        WHEN '126'.                    " Medikament nicht verabreicht
          t_nwicons-icon = icon_incomplete.
        WHEN '127'.                    " Storno
          t_nwicons-icon = icon_system_cancel.
        WHEN '128'.           " In Packungsgröße liefern (Apotheke)
          t_nwicons-icon = icon_package_standard.
        WHEN '129'.           " In Packungsgröße verabreichen (Patient)
          t_nwicons-icon = icon_package_application.
        WHEN '130'.                    " Kühlung erforderlich
          t_nwicons-icon = icon_wf_reserve_workitem.
        WHEN '131'.                    " Zeitkritisches Arzneimittel
          t_nwicons-icon = icon_time.
        WHEN '132'.                    " Arzneimittel teilbar
          t_nwicons-icon = icon_wf_unlink.
        WHEN '133'.                    " DBC vorhanden
          t_nwicons-icon = icon_led_green.
        WHEN '134'.                    " DBC fehlt
          t_nwicons-icon = icon_led_red.
        WHEN '135'.                    " Kunde
          t_nwicons-icon = icon_customer.
        WHEN '136' OR '137'.           " Sichttyp 008
          t_nwicons-icon = icon_led_red.
        WHEN '138'.                    " Kettentermin
          t_nwicons-icon = icon_ben_offer_open.
        WHEN '139'.                    " Freigabe
          t_nwicons-icon = icon_set_state.
        WHEN '140'.                    " Satzart Arzneimittelereignis
          t_nwicons-icon = icon_oo_event.
        WHEN '141'.                    " Satzart Pflegeleistung
          t_nwicons-icon = icon_tools.
        WHEN '142'.                    " Inpatient
          t_nwicons-icon = icon_incoming_employee.
        WHEN '143'.                    " Outpatient
          t_nwicons-icon = icon_outgoing_employee.
        WHEN '144'.                    " Daypatient
          t_nwicons-icon = icon_obsolete_position.
        WHEN '145'.                    " Preparation existiert
          t_nwicons-icon = icon_batch.
        WHEN '146'.                    " Prescription
          t_nwicons-icon = icon_print.
        WHEN '147'.                    " To dispense
          t_nwicons-icon = icon_physical_sample.
        WHEN '148'.                    " To administer
          t_nwicons-icon = icon_sickness.
        WHEN '149'.                    " Document exists for medication
          t_nwicons-icon = icon_display_text.
        WHEN '150'.                    " admission appointment
          t_nwicons-icon = icon_short_message.
        WHEN '151'.                    " open work situation
          t_nwicons-icon = icon_ppe_cvnode.
        WHEN '152' OR '153'.           " chain appointment exists
          t_nwicons-icon = icon_ben_offer_open.
        WHEN '154'.                    " open task
          t_nwicons-icon = icon_task.
        WHEN '155'.                    " treatment break
          t_nwicons-icon = icon_breakpoint.
        WHEN '159'.                    " Document exists for event
          t_nwicons-icon = icon_display_text.
        WHEN '160'.                    " Transportmittel steht bereit
          t_nwicons-icon = icon_okay.
        WHEN '161'.                    " case can be transmitted
          t_nwicons-icon = icon_led_green.
        WHEN '162'.              " case can be transmitted with warnings
          t_nwicons-icon = icon_led_yellow.
        WHEN '163'.                    " case cannot be transmitted
          t_nwicons-icon = icon_led_red.
        WHEN '164'.                    " initial document
          t_nwicons-icon = icon_document.
        WHEN '165'.                    " renewed document
          t_nwicons-icon = icon_workflow_doc_create.
        WHEN '166'.                    " final document
          t_nwicons-icon = icon_final_date.
        WHEN '167'.                    " independent document
          t_nwicons-icon = icon_document_revision.
        WHEN '168'.                    " pathway proposal
          t_nwicons-icon = icon_compare.
        WHEN '169'.                    " nursing services released
          t_nwicons-icon = icon_led_green.
        WHEN '170'.                    " nursing services not released
          t_nwicons-icon = icon_led_red.
*       --- begin of dictation area ---
        WHEN '171'.                    " Dokument
          t_nwicons-icon = icon_otf_document.
        WHEN '172'.                    " Patient
          t_nwicons-icon = icon_position_hr.
        WHEN '173'.                    " Verantw. MA
          t_nwicons-icon = icon_employee.
        WHEN '174'.                    " Aufzeichnung wurde angelegt
          t_nwicons-icon = icon_voice_input.
        WHEN '175'.                    " Aufzeichnung wurde unterbrochen
          t_nwicons-icon = icon_voice_input.
        WHEN '176'.            " Aufzeichnung steht zur Abschrift bereit
          t_nwicons-icon = icon_change.
        WHEN '177'.                    " Abschrift wurde unterbrochen
          t_nwicons-icon = icon_change.
        WHEN '178'.                    " Abschrift in Arbeit
          t_nwicons-icon = icon_change.
        WHEN '179'.                   " Aufzeichnung wurde abgeschrieben
          t_nwicons-icon = icon_checked.
        WHEN '180'.            " Aufzeichnung zur Spracherkennung bereit
          t_nwicons-icon = icon_activity.
        WHEN '181'.                    " Spracherkennung abgeschlossen
          t_nwicons-icon = icon_activity.
        WHEN '182'.                    " Spracherkennung in Arbeit
          t_nwicons-icon = icon_activity.
        WHEN '183'.                    " Abschrift zur Korrektur
          t_nwicons-icon = icon_change_text.
        WHEN '184'.                    " Korrektur in Arbeit
          t_nwicons-icon = icon_change_text.
        WHEN '185'.                    " Abschrift wurde korrigiert
          t_nwicons-icon = icon_checked.
        WHEN '186'.                    " Aufzeichnung in Arbeit
          t_nwicons-icon = icon_voice_input.
        WHEN '187'.                    " Aufzeichnung
          t_nwicons-icon = icon_create.
        WHEN '188'.                    " Korrekturaufzeichnung
          t_nwicons-icon = icon_create_text.
        WHEN '189'.                    " Anweisung
          t_nwicons-icon = icon_display_text.
        WHEN '190'.                    " Information
          t_nwicons-icon = icon_hint.
        WHEN '191'.                    " Allgemein
          t_nwicons-icon = icon_refresh.
        WHEN '192'.                    " Dokument gelöscht
          t_nwicons-icon = icon_led_red.
        WHEN '193'.                    " Patient gelöscht
          t_nwicons-icon = icon_led_yellow.
        WHEN '194'.                    " Verantw. MA gelöscht
          t_nwicons-icon = icon_led_green.
        WHEN '195'.                    " Erkannter Text wurde übertragen
          t_nwicons-icon = icon_transfer.
        WHEN '196'.                    " Archiviert
          t_nwicons-icon = icon_viewer_optical_archive.
        WHEN '197'.                    " Worddokument
          t_nwicons-icon = icon_doc.
        WHEN '198'.                    " Diktat
          t_nwicons-icon = icon_closed_folder.
        WHEN '199'.                    " Diktat angelegt
          t_nwicons-icon = icon_create.
        WHEN '200'.                    " Diktat in Bearbeitung
          t_nwicons-icon = icon_change.
        WHEN '201'.                    " Diktat abgeschlossen
          t_nwicons-icon = icon_close.
*       --- end of dictation area ---
        WHEN '202'.                    " Sonderanforderung
          t_nwicons-icon = icon_led_yellow.
        WHEN '203'.                    " Abgabe
          t_nwicons-icon = icon_proshare.
        WHEN '204'.                    " Selbstverwaltung
          t_nwicons-icon = icon_oo_connection.
        WHEN '205'.                    " keine Verordnungsaktivität
          t_nwicons-icon = icon_space.
        WHEN '206'.                    " Beenden
          t_nwicons-icon = icon_message_critical_small.
        WHEN '207'.                    " Aussetzen
          t_nwicons-icon = icon_deactivate.
        WHEN '208'.                    " Fortsetzen
          t_nwicons-icon = icon_activate.
        WHEN '209'.                    " Fehlerhaft
          t_nwicons-icon = icon_incomplete.
        WHEN '210'.                    " Veränderter Standardzyklus
          t_nwicons-icon = icon_dummy.
        WHEN '211'.                    " Kein Zyklus zugewiesen
          t_nwicons-icon = icon_enter_more.
        WHEN '212'.                    " Individueller Zyklus
          t_nwicons-icon = icon_display_more.
        WHEN '213'.                    " Bestätigt
          t_nwicons-icon = icon_checked.
        WHEN '214'.                    " Nicht Bestätigt
          t_nwicons-icon = icon_incomplete.
        WHEN '215'.                    " Allergien dokumentiert
          t_nwicons-icon = icon_alert.
        WHEN '216'.                    " Erhebung nicht möglich
          t_nwicons-icon = icon_question.
        WHEN '217'.                    " Keine Allergien bekannt
          t_nwicons-icon = icon_booking_ok.
        WHEN '218'.                    " Allergieddkumentation fehlt
          t_nwicons-icon = icon_led_inactive.
        WHEN '219'.                    " Freigabe erforderlich
          t_nwicons-icon = icon_led_red.
        WHEN '220'.                    " Stat. Verlaufsbericht vorhanden
          t_nwicons-icon = icon_order.
        WHEN '221'.                    " Vitalzeichen Planung überfällig
          t_nwicons-icon = icon_led_red.
        WHEN '222'.                    " Vitalzeichen Planung fällig
          t_nwicons-icon = icon_led_yellow.
        WHEN '223'.                    " Pflegeverlaufsbericht vorhanden
          t_nwicons-icon = icon_order.
        WHEN '224'.                    " Pflegenotiz vorhanden
          t_nwicons-icon = icon_order.
        WHEN '225'.                    " Tageskommentar vorhanden
          t_nwicons-icon = icon_led_green.
        WHEN '226'.                    " keine offenen Evaluierungen vorhanden
          t_nwicons-icon = icon_led_green.
        WHEN '227'.                    " offene Evaluierungen vorhanden
          t_nwicons-icon = icon_led_yellow.
        WHEN '228'.                    " überfällige Evaluierungen vorhanden
          t_nwicons-icon = icon_led_red.
        WHEN '229'.                    " Pflegeplan zu übernehmen
          t_nwicons-icon = icon_led_yellow.
        WHEN '230'.                    " Pflegeplan bereits übernommen
          t_nwicons-icon = icon_led_yellow.
        WHEN '231'.                    " Behandlungsschein fehlt MED-38586
          t_nwicons-icon = icon_led_yellow.
        WHEN '232'.                    " treatment contract doesn't exist "HCBL-167
          t_nwicons-icon = icon_booking_stop.                             "HCBL-167
        WHEN '233'.                    " Leistungseigenschaften vorhanden "MED-44263
          t_nwicons-icon = icon_led_green.                  "MED-44263
        WHEN '234'.                    " Bildstudie ohne Bilder
          t_nwicons-icon = icon_led_red.
        WHEN '235'.                    " Bildstudie vorhanden; Einzelbilder zugeordnet
          t_nwicons-icon = icon_led_yellow.
        WHEN '236'.                    " Bildstudie freigegeben
          t_nwicons-icon = icon_led_green.
        WHEN '237'.                    " Verlaufsdokumentation vorhanden
          t_nwicons-icon = icon_order.
        WHEN '238'.                    " Verweisungsdaten registriert
          t_nwicons-icon = icon_led_green.
        WHEN '239'.                    " Keine Verweisungsdaten erforderlich
          t_nwicons-icon = icon_led_green.
        WHEN '240'.                    " Verweisungsdaten fehlt
          t_nwicons-icon = icon_led_red.
        WHEN '241'.                    " Verlaufseintrag erfassen
          t_nwicons-icon = icon_create_text.
        WHEN '242'.                    " Verlaufsbericht anzeigen
          t_nwicons-icon = icon_display.
        WHEN '243'.                    " Verweisungsdaten nicht notwendig
          t_nwicons-icon = icon_led_green.
        WHEN '244'.                    " Offene Anordnungen vorhanden MED-52511
          t_nwicons-icon = icon_led_yellow.
        WHEN '245'.                    " Alle Anordnungen abgeschlossen MED-52511
          t_nwicons-icon = icon_led_green.
        WHEN '246'.                    " Anordnung anlegen MED-52511
          t_nwicons-icon = icon_space.
        WHEN '247'.                    " Pflegeleistungen in der Zukunft geplant
          t_nwicons-icon = icon_led_green.
*-->begin of MED-59011 AGujev  #RISK#
        WHEN '248'.                    " Patient bereits entlassen
          t_nwicons-icon = icon_message_warning_small.
*<--end of MED-59011 AGujev  #RISK#
        WHEN '249'.                    " ICD-10 Diagnose vorhanden
          t_nwicons-icon = icon_led_green.
        WHEN '250'.                    " ICD-10 Diagnose fehlt
          t_nwicons-icon = icon_led_red.
        WHEN '251'.                    " DBC Diagnose fehlt
          t_nwicons-icon = icon_location.
        WHEN '252'.                    " Offene Anordnungen vorhanden
          t_nwicons-icon = icon_led_red.
        WHEN '253'.                    " Freizugebende Anordnungen vorhanden
          t_nwicons-icon = icon_led_yellow.
* <<< MED-62218 Note 2334045 Bi
        WHEN '254'.                    " Erstverordnung
          t_nwicons-icon = ICON_CREATE.

        WHEN '255'.                    " Folgeverordnung
          t_nwicons-icon = ICON_INCOMING_OBJECT.

        WHEN '256'.                    " Extraverordnung außerhalb des Regelfalls
          t_nwicons-icon = ICON_OUTGOING_OBJECT.

        WHEN '257'.                    " Erstverordnung besonderer Verordnungsbed.
          t_nwicons-icon = ICON_DRAW_RECTANGLE.

        WHEN '258'.                    " Folgeverordnung besonderer Verordnungsbed.
          t_nwicons-icon = ICON_INCOMING_ORG_UNIT.

        WHEN '259'.                    " Besonderer Verordnungsbedarf ADR
          t_nwicons-icon = ICON_OUTGOING_ORG_UNIT.

        WHEN '260'.                    " Langfristige Heilmittelverordnung
          t_nwicons-icon = ICON_ALLOW.

        WHEN '261'.                   " Substitution not allowed - MED-65958 Cosmina Crisan 28.11.2017
          t_nwicons-icon = ICON_REMOVE_ROW.                       "MED-65958 Cosmina Crisan 28.11.2017
* >>> MED-62218 Note 2334045 Bi
* --------------------------------------------------------------------
*          BEGIN OF IXX-14007 IXX-14013 IXX-14019 IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 24/05/2018
        WHEN '262'.                   "   Quick administration allowed
          t_nwicons-icon = icon_account_assignment.
        WHEN '263'.                   "   Change flow rate at date-time
          t_nwicons-icon = icon_selection_period.
        WHEN '264'.                   "   Change bag at date - time
          t_nwicons-icon = icon_workflow_cont_operation.
        WHEN '265'.                   "   Remove infusion at date - time
          t_nwicons-icon = icon_unlink.
        WHEN '266'.                   "   Bolus at date - time
          t_nwicons-icon = icon_ps_network_header.
        WHEN '267'.                   "   Interruption at date - time
          t_nwicons-icon = icon_terminated_org_unit.
        WHEN '268'.                   "   In process
          t_nwicons-icon = icon_oo_overwrite.
        WHEN '269'.                   "   Order changed
          t_nwicons-icon = icon_action_fault.
        WHEN '270'.                   "   Administered
          t_nwicons-icon = icon_okay.
        WHEN '271'.                   "   Not given
          t_nwicons-icon = icon_status_overview.
        WHEN '272'.                   "   Overdue
          t_nwicons-icon = icon_time_control.
        WHEN '273'.                   "   Completed
          t_nwicons-icon = icon_complete.
        WHEN '274'.                   "   Cancelled
          t_nwicons-icon = icon_system_cancel .
        WHEN '276'.                   "   Not applicable
          t_nwicons-icon = icon_space.
        WHEN '277'.                   "   All planned eMAR activity within [Calculated minutes]
          t_nwicons-icon = icon_green_light.
        WHEN '278'.                   "   Pending planned eMAR activity within [calculate minutes]
          t_nwicons-icon = icon_yellow_light.
        WHEN '279'.                   "   There are overdue planned eMAR activities
          t_nwicons-icon = icon_red_light.
        WHEN '280'.                   "   Pending administration
          t_nwicons-icon = icon_time.
        WHEN '281'.                   "   Status Interrupted
          t_nwicons-icon = icon_terminated_org_unit.
        WHEN '282'.                   "   Event chg. after processing
          t_nwicons-icon = icon_oo_overwrite.
        WHEN '283'.                   "   Event & order chg. after processing
          t_nwicons-icon = icon_ppe_modnode.
        WHEN '284'.                   "   Event chg. after processing/order chg. before
          t_nwicons-icon = icon_submit.
        WHEN '285'.                   "   Event chg. before processing
          t_nwicons-icon = icon_oo_class_method.

*          END OF IXX-14007 IXX-14013 IXX-14019 IXX-13935 eMAR - Ignacio Segovia ( C5252655 ) 24/05/2018
*     Fichte, MED-74742: #RISK#
        WHEN '286'.
          t_nwicons-icon = icon_complete.
*         Fichte, MED-74742 - End #RISK#
        WHEN '287'.                   " Delegation möglich, kein Behandlungsauftrag erteilt / note 2907566
          t_nwicons-icon = icon_businav_value_chain.                                        " note 2907566
*       Fichte, MED-72078: New Icon for column DISCHARGE_ICON (event view)
        WHEN '288'.
          t_nwicons-icon = icon_visit.
*         Fichte, MED-72078 - End
        WHEN '289'.
          t_nwicons-icon = icon_led_red.
        WHEN '290'.
          t_nwicons-icon = icon_led_green.
*       Fichte, IXX-20381: Icons for eAU: 291 - 308
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_kk_todo_sign.
          t_nwicons-icon = icon_allow.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_kk_todo_send.
          t_nwicons-icon = icon_short_message.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_kk_wait_conf.
          t_nwicons-icon = icon_initial.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_kk_wait_check.
          t_nwicons-icon = icon_release.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_kk_status_error.
          t_nwicons-icon = icon_message_error_small.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_kk_complete.
          t_nwicons-icon = icon_complete.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_kk_correction.
          t_nwicons-icon = icon_change_text.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_kk_cancelled.
          t_nwicons-icon = icon_defect.

        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_st_todo_sign.
          t_nwicons-icon = icon_allow.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_st_todo_send.
          t_nwicons-icon = icon_short_message.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_st_wait_conf.
          t_nwicons-icon = icon_initial.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_st_wait_check.
          t_nwicons-icon = icon_release.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_st_status_error.
          t_nwicons-icon = icon_message_error_small.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_st_complete.
          t_nwicons-icon = icon_complete.

        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_sktpkv_all_todo_print.
          t_nwicons-icon = icon_print.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_sktpkv_all_complete.
          t_nwicons-icon = icon_complete.

        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_ag_v_todo_print.   " 307
          t_nwicons-icon = icon_print.
        WHEN cl_ishmed_ti_fill_doc_fields=>co_icon_gkv_ag_v_complete.     " 308
          t_nwicons-icon = icon_complete.
*         Fichte, IXX-20381 - End
        WHEN OTHERS.
          t_nwicons-icon = icon_expand_all.
      ENDCASE.
    ENDIF.
*   Set quick info text for icons only
    IF t_nwicons-icon(3) <> '+++'.
      l_dom_val = t_nwicons-col_indicator.
*     START MED-40483 2010/06/16
*        CALL FUNCTION 'ISH_DOMAIN_VALUE_TEXTS'
*          EXPORTING
*            domname  = 'NWCOLUMN_ICONS'
*            domvalue = l_dom_val
*          IMPORTING
*            ddtext   = l_dom_txt.
      IF lt_text IS INITIAL.
        CALL FUNCTION 'ISH_N2_READ_DOMAIN_VALUES'
          EXPORTING
            ss_domain    = 'NWCOLUMN_ICONS'
          TABLES
            ss_dd07v_tab = lt_domvalue
          EXCEPTIONS
            not_found    = 1
            OTHERS       = 2.
        IF sy-subrc = 0.
          LOOP AT lt_domvalue ASSIGNING <ls_domvalue>.
            CLEAR ls_text.
            ls_text-value1 = <ls_domvalue>-domvalue_l.
            ls_text-text = <ls_domvalue>-ddtext.
            INSERT ls_text INTO TABLE lt_text.
          ENDLOOP.
        ENDIF.
      ENDIF.
      READ TABLE lt_text INTO ls_text
           WITH TABLE KEY value1 = l_dom_val.
      IF sy-subrc = 0.
        l_dom_txt = ls_text-text.
      ELSE.                 "MED-59011 AGujev  #RISK#
        CLEAR l_dom_txt.    "MED-59011 AGujev  #RISK#
      ENDIF.
*     END MED-40483
      CONCATENATE t_nwicons-icon(3) '\Q' l_dom_txt(44) '@'
                  INTO t_nwicons-icon.
    ENDIF.
    MODIFY t_nwicons.
  ENDLOOP.

ENDFUNCTION.
