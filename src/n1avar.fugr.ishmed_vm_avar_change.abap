FUNCTION ishmed_vm_avar_change.
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
*"     VALUE(I_AVARIANTID) TYPE  RNAVAR-AVARIANTID DEFAULT SPACE
*"     VALUE(I_USER_SPECIFIC) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_SCREEN) TYPE  ISH_ON_OFF DEFAULT 'X'
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(E_VIEWVAR) TYPE  RNVIEWVAR
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_messages        TYPE tyt_messages,
        l_viewvar          TYPE rnviewvar,
        l_viewvar_old      TYPE rnviewvar,
        l_viewvar_chk      TYPE rnviewvar,
        l_dispvar          TYPE lvc_s_fcat,
        dummy_dispvar      TYPE lvc_t_fcat,
        lt_dispvar         TYPE lvc_t_fcat,
        lt_dispsort        TYPE lvc_t_sort,
        lt_dispfilter      TYPE lvc_t_filt,
        l_variant          LIKE disvariant,
*        ls_control_kkblo   TYPE kkblo_control,              "#EC NEEDED
        lt_fieldgrp        TYPE lvc_t_sgrp,
        l_wa_msg           LIKE bapiret2,
        l_save             LIKE on,
        l_vcode            TYPE ish_vcode,
        l_mode_buf(1)      TYPE c,
        l_answer(1)        TYPE c,
        l_exit(1)          TYPE c,
        l_user_specif(1)   TYPE c,
        l_usr_sp           TYPE ish_on_off,
        l_key              LIKE rnwp_gen_key-nwkey,
        l_viewtype_txt(60) TYPE c,
        l_refresh_dummy    TYPE rnrefresh,
        l_ishmed_used      LIKE true,
        l_podesign         TYPE n1podesign,
        l_p01_grid         TYPE ish_on_off,
        l_rc               LIKE sy-subrc.
  DATA: ls_tabstrip        TYPE dtc_s_ts,
        ls_dtc_layout      TYPE dtc_s_layo,
        ls_lvc_layout      TYPE lvc_s_layo.
  DATA: ls_viewvar         TYPE nwviewvar.
  DATA: lr_outtab          TYPE REF TO data.
  DATA: lr_table           TYPE REF TO data.
  DATA: lt_data            TYPE lvc_t_filt.            " Dummy
  DATA: lt_data_001        TYPE ish_t_occupancy_list.  " Sichttyp 001
  DATA: lt_data_002        TYPE ish_t_arrival_list.    " Sichttyp 002
  DATA: lt_data_003        TYPE ish_t_departure_list.  " Sichttyp 003
  DATA: lt_data_004        TYPE ishmed_t_request_list. " Sichttyp 004
  DATA: lt_data_005        TYPE ishmed_t_pts_list.     " Sichttyp 005
  DATA: lt_data_006        TYPE ish_n2_document_list.  " Sichttyp 006
  DATA: lt_data_007        TYPE ish_t_lststelle_list.  " Sichttyp 007
  DATA: lt_data_008        TYPE ish_t_medcontrol_list. " Sichttyp 008
  DATA: lt_data_009        TYPE ish_t_occplanning_list." Sichttyp 009
  DATA: lt_data_010        TYPE ish_t_prereg_list.     " Sichttyp 010
  DATA: lt_data_011        TYPE ishmed_t_op_list.      " Sichttyp 011
  DATA: lt_data_012        TYPE ishmed_t_meorder_list. " Sichttyp 012
  DATA: lt_data_013        TYPE ishmed_t_meevent_list. " Sichttyp 013
*  DATA: lt_data_014        TYPE ishmed_t_meorder_list. " Sichttyp 014
  DATA: lt_data_016        TYPE ishmed_t_dictation_list. "Sichttyp 016
  DATA: lt_data_p01_tree   TYPE rn1po_t_process_representation. " P01
  DATA: lt_data_p01_grid   TYPE rn1po_t_grid.               " P01
  DATA: lt_data_c01        TYPE ishmed_t_dynp_medsrv_work.  " Comp C01
  DATA: lt_data_c02        TYPE ishmed_t_dynp_medsrv_work.  " Comp C02
  DATA: lt_data_c03        TYPE ishmed_t_me_outtab_order_grid. "COMP C03 - Med-30727
* Michael Manoch, 15.04.2009, MED-33282   START
  DATA: lt_data_c07        TYPE ishmed_t_nrs_ot_planhierarchy.
* Michael Manoch, 15.04.2009, MED-33282   END
* WK, 26.5.2011, ISHFR-270   Beginn
  DATA: lt_data_fr1        TYPE ish_t_occupancy_list.  " Sichttyp FR1
* WK, 26.5.2011, ISHFR-270   Ende

  FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE.

* Initialisierung + Belegung lokaler Variablen
  CLEAR: e_rc, e_viewvar, l_save, l_podesign,
         l_viewvar, l_variant, l_exit, l_answer, l_vcode, ls_lvc_layout.

  CLEAR:   t_messages, lt_messages, lt_dispvar,
           lt_dispvar, lt_fieldgrp, lt_dispfilter, lt_dispsort.
  REFRESH: t_messages, lt_messages, lt_dispvar,
           lt_dispvar, lt_fieldgrp, lt_dispfilter, lt_dispsort.

  REFRESH: lt_data, lt_data_001, lt_data_002, lt_data_004, lt_data_004,
                    lt_data_005, lt_data_006, lt_data_007, lt_data_008,
                    lt_data_009, lt_data_010, lt_data_011, lt_data_012,
                    lt_data_013, lt_data_016,
                    lt_data_p01_grid,
                    lt_data_p01_tree,
                    lt_data_c01, lt_data_c02,
                    lt_data_fr1.

* Sichttyp ist unbedingt erforderlich
  IF i_view-viewtype IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* viewtype 014 does not use layout variants
  IF i_view-viewtype = '014'.
    e_rc = 1.
*   Layouts werden für diesen Sichttyp nicht unterstützt
    PERFORM build_bapiret2(sapmn1pa)
            USING 'I' 'N1BASE' '038' space space space
                                     space space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    EXIT.
  ENDIF.

* patient organizer: get info if list is a tree or a grid (ID 16583)
  IF i_view-viewtype = 'P01'.
    SELECT SINGLE podesign FROM nwplace_p01 INTO l_podesign
           WHERE  wplacetype  = i_place-wplacetype
           AND    wplaceid    = i_place-wplaceid.
    IF sy-subrc <> 0 OR l_podesign IS INITIAL OR l_podesign = '000'.
      l_p01_grid = off.
    ELSE.
      l_p01_grid = on.
    ENDIF.
  ENDIF.

* Nur Verarbeitungscode INS und UPD erlaubt
  l_vcode = i_vcode.
  IF l_vcode <> g_vcode_insert AND l_vcode <> g_vcode_update.
    l_vcode = g_vcode_update.
  ENDIF.

* Je nach Modus -> Definieren oder Sichern ----------------------------
  IF i_mode = 'D'.                                          " Define
*   Anzeigevariante nur definieren
  ELSEIF i_mode = 'S'.                                      " Save
*   Anzeigevariante auch sichern
*   ls_control_kkblo-save = on.
  ELSE.
    EXIT.                              " keine anderen Modus möglich !
  ENDIF.

* Je Sichttyp die Struktur der Ausgabetabelle unterschiedlich übergeben
* (für Filterkriterien)
  CASE i_view-viewtype.
*   views for clinical workplace
    WHEN '001'.
      ASSIGN lt_data_001[] TO <lt_data>.
    WHEN '002'.
      ASSIGN lt_data_002[] TO <lt_data>.
    WHEN '003'.
      ASSIGN lt_data_003[] TO <lt_data>.
    WHEN '004'.
      ASSIGN lt_data_004[] TO <lt_data>.
    WHEN '005'.
      ASSIGN lt_data_005[] TO <lt_data>.
    WHEN '006'.
      ASSIGN lt_data_006[] TO <lt_data>.
    WHEN '007'.
      ASSIGN lt_data_007[] TO <lt_data>.
    WHEN '008'.
      ASSIGN lt_data_008[] TO <lt_data>.
    WHEN '009'.
      ASSIGN lt_data_009[] TO <lt_data>.
    WHEN '010'.
      ASSIGN lt_data_010[] TO <lt_data>.
    WHEN '011'.
      ASSIGN lt_data_011[] TO <lt_data>.
    WHEN '012'.
      ASSIGN lt_data_012[] TO <lt_data>.
    WHEN '013'.
      ASSIGN lt_data_013[] TO <lt_data>.
*    WHEN '014'.
*      ASSIGN lt_data_014[] TO <lt_data>.
*   (views) workplace for patient organizer
    WHEN '016'.
      ASSIGN lt_data_016[] TO <lt_data>.
    WHEN 'P01'.
      IF l_p01_grid = off.
        ASSIGN lt_data_p01_tree[] TO <lt_data>.
      ELSE.
        ASSIGN lt_data_p01_grid[] TO <lt_data>.
      ENDIF.
*   views for components
    WHEN 'C01'.
      ASSIGN lt_data_c01[] TO <lt_data>.
    WHEN 'C02'.
      ASSIGN lt_data_c02[] TO <lt_data>.
*   KG, MED-30727 - Begin
    WHEN 'C03'.
      ASSIGN lt_data_c03[] TO <lt_data>.
*   KG, MED_30727 - End
*   Michael Manoch, 15.04.2009, MED-33282   START
    WHEN 'C07' OR 'C08' OR 'C09'.
      ASSIGN lt_data_c07[] TO <lt_data>.
*   Michael Manoch, 15.04.2009, MED-33282   END
*   START ISHFR-270 - EHPAD
    WHEN 'FR1'.
      IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
        ASSIGN lt_data_fr1[] TO <lt_data>.
      endif.
*   END ISHFR-270 - EHPAD
    WHEN OTHERS.
      CLEAR ls_viewvar.
      IF i_view-viewtype BETWEEN '001' AND '099'.
*       other standard viewtypes (ID 18129)
        PERFORM get_data_table IN PROGRAM sapln1workplace
                               USING      i_view-viewtype
                                          ls_viewvar-fieldcat_tabtyp
                               CHANGING   lr_table.
      ENDIF.
      IF lr_table IS NOT BOUND.
*       customer specific or add-on viewtypes (ID 18129)
        PERFORM get_viewvar_data IN PROGRAM sapln1workplace
                                 USING      i_view-viewtype
                                 CHANGING   ls_viewvar.
        IF ls_viewvar-fieldcat_tabtyp IS NOT INITIAL.
          PERFORM get_data_table IN PROGRAM sapln1workplace
                                 USING      i_view-viewtype
                                            ls_viewvar-fieldcat_tabtyp
                                 CHANGING   lr_table.
        ENDIF.
      ENDIF.
      IF lr_table IS BOUND.
        ASSIGN lr_table->* TO <lt_data>.
      ELSE.
        ASSIGN lt_data     TO <lt_data>.
      ENDIF.
  ENDCASE.

  GET REFERENCE OF <lt_data> INTO lr_outtab.

* Lesen des Inhalts der Anzeigevariante *******************************
* Wenn noch keine Variante zur Sicht vorhanden ist
* kann hier trotzdem im Puffer ein Inhalt gefunden werden
  IF l_vcode <> g_vcode_insert AND i_read_viewvar = on.
    IF i_read_buffer = on.
      l_mode_buf = 'L'.                                     " Load
    ELSE.
      l_mode_buf = 'R'.                                     " Refresh
    ENDIF.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid     = i_view-viewid
        i_viewtype   = i_view-viewtype
        i_mode       = l_mode_buf
        i_caller     = 'LN1AVARU01'
        i_placeid    = i_place-wplaceid
        i_placetype  = i_place-wplacetype
      IMPORTING
        e_rc         = e_rc
        e_viewvar    = l_viewvar
      TABLES
        t_messages   = lt_messages
      CHANGING
        c_dispvar    = lt_dispvar
        c_dispsort   = lt_dispsort
        c_dispfilter = lt_dispfilter
        c_layout     = ls_lvc_layout.
    APPEND LINES OF lt_messages TO t_messages.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    l_viewvar-viewtype = i_view-viewtype.
    l_viewvar-viewid   = i_view-viewid.
  ENDIF.

* Soll eine benutzerspezifische (persönliche) Anzeigevariante gesichert
* werden, dann müssen die ursprünglichen Attribute (z.B. aus der Sicht)
* hier gecleart werden
  IF i_user_specific = on AND l_viewvar-username IS INITIAL.
    CLEAR: l_viewvar-reporta, l_viewvar-handle, l_viewvar-log_group,
           l_viewvar-username, l_viewvar-avariantid.
  ENDIF.

* Soll eine allgemeine Anzeigevariante zur Sicht gesichert werden,
* dann müssen die ursprünglichen Attribute aus der Sicht gelesen werden,
  IF         i_user_specific    =  off
     AND     i_save             =  on.
    CLEAR l_viewvar_chk.
    PERFORM get_viewvar(sapln1workplace)
            USING    i_view-viewtype  i_view-viewid
            CHANGING l_viewvar_chk    l_refresh_dummy l_rc.
    IF l_rc <> 0.
      l_viewvar-viewid   = i_view-viewid.
      l_viewvar-viewtype = i_view-viewtype.
      CLEAR: l_viewvar-reporta, l_viewvar-handle, l_viewvar-log_group,
             l_viewvar-username, l_viewvar-avariantid.
    ELSE.
      IF NOT l_viewvar-username IS INITIAL.
*       Falls eine persönliche Anzeigevariante existiert, hier immer die
*       Anzeigevariante aus der Sicht ändern
        l_viewvar = l_viewvar_chk.
      ELSE.
*       Falls zur Sicht noch keine Anzeigevariante gepflegt ist, dann
*       soll jetzt eine neue angelegt werden
        IF l_viewvar_chk-avariantid IS INITIAL.
          l_viewvar = l_viewvar_chk.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.

  IF NOT l_viewvar-username IS INITIAL OR i_user_specific = on.
    l_user_specif = 'U'.
  ELSE.
    l_user_specif = ' '.
  ENDIF.

  l_viewvar_old = l_viewvar.

* Feldgruppen bestimmen
  CALL FUNCTION 'ISH_WP_ALV_FIELD_GROUPS_SET'
    EXPORTING
      i_view_type    = i_view-viewtype
    IMPORTING
      t_field_groups = lt_fieldgrp.

* Reportname der Anzeigevariante der Sicht muß befüllt sein
  IF l_viewvar-reporta IS INITIAL.
    PERFORM get_report_anzvar(sapln1workplace) USING i_view-viewtype
                                            CHANGING l_viewvar-reporta.
  ENDIF.

* Wurde ein Inhalt einer Anzeigevariante gefunden ?
  DESCRIBE TABLE lt_dispvar.
  IF sy-tfill = 0.
*   Feldkatalog zusammenstellen
    PERFORM create_fieldcat(sapln1workplace) USING    i_place
                                                      l_viewvar
                                                      on
                                                      off
                                             CHANGING lt_dispvar
                                                      lt_messages
                                                      e_rc.
    APPEND LINES OF lt_messages TO t_messages.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDIF.

* patient organizer: set info if list is a tree or a grid (ID 16583)
  IF i_view-viewtype = 'P01'.
    IF l_p01_grid = off.
      l_viewvar-handle = 'TREE'.
    ELSE.
      l_viewvar-handle = 'GRID'.
    ENDIF.
  ENDIF.

* Michael Manoch, 15.04.2009, MED-33282   START
* Set field handle for nursing plan hierarchy.
  CASE i_view-viewtype.
    WHEN 'C07' OR 'C08' OR 'C09'.
      l_viewvar-handle = 'TREE'.
  ENDCASE.
* Michael Manoch, 15.04.2009, MED-33282   END

* KG, MED-40981 - Begin
* set field handle for medication event administration
  IF i_view-viewtype =  'C10'.
    l_viewvar-handle = 'GRID'.
  ENDIF.
* KG, MED-40981 - end

* Falls gewünscht eine andere Anzeigevariante ändern oder anlegen
  IF NOT i_avariantid IS INITIAL.
    CLEAR l_variant.
    l_variant-report   = l_viewvar-reporta.
    l_variant-handle   = l_viewvar-handle.
    l_variant-variant  = i_avariantid.
*   Anzeigevariante lesen
    CALL FUNCTION 'LVC_VARIANT_SELECT'
      EXPORTING
        i_dialog            = ' '
        i_user_specific     = 'U'  " user-specific possible
        it_default_fieldcat = lt_dispvar
      IMPORTING
        et_fieldcat         = lt_dispvar
        et_sort             = lt_dispsort
        et_filter           = lt_dispfilter
        es_layout           = ls_lvc_layout
      TABLES
        it_data             = <lt_data>
      CHANGING
        cs_variant          = l_variant
      EXCEPTIONS
        wrong_input         = 1
        fc_not_complete     = 2
        not_found           = 3
        program_error       = 4
        OTHERS              = 5.                            "#EC *
    IF l_vcode = g_vcode_update.
      IF sy-subrc = 0.
        l_viewvar-reporta    = l_variant-report.
        l_viewvar-handle     = l_variant-handle.
        l_viewvar-log_group  = l_variant-log_group.
        l_viewvar-username   = l_variant-username.
        l_viewvar-avariantid = l_variant-variant.
      ELSE.
        e_rc = 1.
*       Anz.variante & für Report & konnte nicht gef. werden (Fehler &)
        PERFORM build_bapiret2(sapmn1pa)
                USING 'I' 'NF1' '230' i_avariantid   l_viewvar-reporta
                                      sy-subrc space space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO t_messages.
        EXIT.
      ENDIF.
    ELSEIF l_vcode = g_vcode_insert.
      IF sy-subrc <> 0.
        l_viewvar-avariantid = i_avariantid.
      ELSE.
        e_rc = 1.
*       Layout & existiert bereits
        PERFORM build_bapiret2(sapmn1pa)
                USING 'I' 'NF1' '474' i_avariantid space space
                                      space space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO t_messages.
        EXIT.
      ENDIF.
    ENDIF.
    IF i_place-wplacetype = '001'.
      PERFORM create_fieldcat(sapln1workplace) USING    i_place
                                                        l_viewvar
                                                        off
                                                        off
                                               CHANGING lt_dispvar
                                                        lt_messages
                                                        e_rc.
      APPEND LINES OF lt_messages TO t_messages.
      IF e_rc <> 0.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

* ID 7257: Neue Variante anlegen -> SAP-Standard als Vorlage nutzen
  IF l_viewvar-avariantid IS INITIAL AND l_vcode = g_vcode_insert.
    CLEAR l_variant.
    l_variant-report     = l_viewvar-reporta.
    IF i_view-viewtype = 'P01'.
      l_variant-variant = '0SAPSTANDARD'.
      l_variant-handle  = l_viewvar-handle.
    ELSE.
*     Michael Manoch, 15.04.2009, MED-33282   START
*     Set field handle for nursing plan hierarchy.
      CASE i_view-viewtype.
        WHEN 'C07' OR 'C08' OR 'C09'.
          l_variant-handle = 'TREE'.
      ENDCASE.
*     Michael Manoch, 15.04.2009, MED-33282   END
      PERFORM check_ishmed(sapln1workplace) CHANGING l_ishmed_used.
      IF l_ishmed_used = true.
        l_variant-variant = '1SAP_MED'.
      ELSE.
        l_variant-variant = '1SAP_ISH'.
      ENDIF.
    ENDIF.
*   Anzeigevariante lesen
    CALL FUNCTION 'LVC_VARIANT_SELECT'
      EXPORTING
        i_dialog            = ' '
        i_user_specific     = ' '
        it_default_fieldcat = lt_dispvar
      IMPORTING
        et_fieldcat         = lt_dispvar
        et_sort             = lt_dispsort
        et_filter           = lt_dispfilter
        es_layout           = ls_lvc_layout
      TABLES
        it_data             = <lt_data>
      CHANGING
        cs_variant          = l_variant
      EXCEPTIONS
        wrong_input         = 1
        fc_not_complete     = 2
        not_found           = 3
        program_error       = 4
        OTHERS              = 5.                            "#EC *
    IF sy-subrc <> 0. ENDIF.                                "#EC NEEDED
  ENDIF.

  IF l_variant IS INITIAL.
    l_variant-report     = l_viewvar-reporta.
    l_variant-handle     = l_viewvar-handle.
    l_variant-log_group  = l_viewvar-log_group.
    l_variant-username   = l_viewvar-username.
    l_variant-variant    = l_viewvar-avariantid.
  ENDIF.

* Soll das Bild zur Änderung der Anzeigevariante kommen ?
  IF i_screen = on.
    CLEAR: ls_tabstrip, ls_dtc_layout.
    IF i_view-viewtype = '004' OR       " Klin.Aufträge/Anforderungen
       ( i_view-viewtype = 'P01' AND l_variant-handle = 'TREE' ) OR
       i_view-viewtype = 'C07' OR     "Michael Manoch, 15.04.2009, MED-33282
       i_view-viewtype = 'C08' OR     "Michael Manoch, 15.04.2009, MED-33282
       i_view-viewtype = 'C09'.       "Michael Manoch, 15.04.2009, MED-33282
*     Anzeigevariante für ALV-Tree definieren
      CREATE OBJECT g_variant
        EXPORTING
          it_outtab             = lr_outtab
          it_fieldcatalog       = lt_dispvar
          it_sort               = lt_dispsort
          it_filter             = lt_dispfilter
*         it_grouplevels_filter = lt_grouplevels_filter
          is_variant            = l_variant
*         i_variant_save        = m_variant_save
*         is_total_options      = ls_total_options
          is_layout             = ls_lvc_layout.
*     Tabstrips definieren
      ls_tabstrip-ts_default = 'X'.
      ls_tabstrip-ts_ucomm   = 'ALV_M_R1'.
      ls_tabstrip-ts_header  = 'Spaltenauswahl'(002).
      ls_tabstrip-ts_order   = 1.
      ls_tabstrip-grid1style = 1.
      ls_tabstrip-grid2style = 0.
      CLEAR ls_tabstrip-grid2notem.
      ls_tabstrip-grid1notem = 'X'.
      APPEND ls_tabstrip TO ls_dtc_layout-t_tabstrip.
*     Michael Manoch, 15.04.2009, MED-33282
*     No fieldgrp for nrsplan
      CASE i_view-viewtype.
        WHEN 'C07' OR 'C08' OR 'C09'.
        WHEN OTHERS.
          ls_dtc_layout-t_group1 = lt_fieldgrp.
      ENDCASE.
    ELSE.
*     Anzeigevariante für ALV-Grid definieren
      CREATE OBJECT g_variant
        EXPORTING
          it_outtab       = lr_outtab
          it_fieldcatalog = lt_dispvar
          it_sort         = lt_dispsort
          it_filter       = lt_dispfilter
          is_variant      = l_variant
          is_layout       = ls_lvc_layout.
*     Tabstrips definieren
      ls_tabstrip-ts_default = 'X'.
      ls_tabstrip-ts_ucomm   = 'ALV_M_R1'.
      ls_tabstrip-ts_header  = 'Spaltenauswahl'(002).
      ls_tabstrip-ts_order   = 1.
      ls_tabstrip-grid1style = 1.
      ls_tabstrip-grid2style = 0.
      CLEAR ls_tabstrip-grid2notem.
      ls_tabstrip-grid1notem = 'X'.
      APPEND ls_tabstrip TO ls_dtc_layout-t_tabstrip.
*
*     beim Sichttyp OP darf die Sortierung nicht geändert werden
      IF NOT i_view-viewtype = '011'.
        ls_tabstrip-ts_ucomm   = 'ALV_M_R2'.
        ls_tabstrip-ts_header  = 'Sortierung'(003).
        ls_tabstrip-ts_order   = 2.
        ls_tabstrip-grid1style = 1.
        ls_tabstrip-grid2style = 0.
        CLEAR ls_tabstrip-grid2notem.
        ls_tabstrip-grid1notem = 'X'.
        APPEND ls_tabstrip TO ls_dtc_layout-t_tabstrip.
      ENDIF.
*
      ls_tabstrip-ts_ucomm   = 'ALV_M_R5'.
      ls_tabstrip-ts_header  = 'Darstellung'(006).
      ls_tabstrip-ts_order   = 5.
      ls_tabstrip-grid1style = 1.
      ls_tabstrip-grid2style = 0.
      CLEAR ls_tabstrip-grid2notem.
      ls_tabstrip-grid1notem = 'X'.
      APPEND ls_tabstrip TO ls_dtc_layout-t_tabstrip.
*
*     Herbert Hoebarth, 24.06.2009, MED-33282
*     No fieldgrp for nrsservices
      CASE i_view-viewtype.
        WHEN 'C05' OR 'C06'.
        WHEN OTHERS.
          ls_dtc_layout-t_group1 = lt_fieldgrp.
      ENDCASE.
    ENDIF.
*   Jetzt anzeigen
    CALL METHOD g_variant->lvc_variant
         EXPORTING
                is_dtc_layout    = ls_dtc_layout
*         IMPORTING
*                e_saved          = l_save
         EXCEPTIONS
                no_change        = 1
                restore_old_view = 2
                no_filt_change   = 3
                OTHERS           = 4.
*   Cancel
    IF sy-subrc = 1.
      e_viewvar = l_viewvar.
      e_rc = 2.
      EXIT.
    ENDIF.
*   Geänderte Werte holen
    CALL METHOD g_variant->get_values
      IMPORTING
        et_fieldcatalog = lt_dispvar
        et_sort         = lt_dispsort
        et_filter       = lt_dispfilter
        es_layout       = ls_lvc_layout
        es_variant      = l_variant.
*   Zusatzabfrage braucht nicht zu kommen (ID 6203)
    l_save = on.
  ELSE.
    l_save = on.  " Layout ohne Zusatzabfrage autom. sichern
  ENDIF.

* Im Modus Sichern eine Zusatzabfrage bringen,
* ob gesichert werden soll
  IF i_mode = 'S' AND l_save = off.
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar              = 'Layout sichern'(001)
        text_question         = 'Wollen Sie das Layout sichern?'(004)
        text_button_1         = 'Ja'(005)
        text_button_2         = 'Nein'(011)
        default_button        = '1'
        display_cancel_button = 'X'
      IMPORTING
        answer                = l_answer
      EXCEPTIONS
        text_not_found        = 1
        OTHERS                = 2.
    IF sy-subrc = 0 AND l_answer = '1'.
      l_save = on.
    ELSEIF l_answer = 'A'.
      e_rc = 2.
    ENDIF.
  ENDIF.

* Soll gesichert werden ?
  IF i_mode = 'S' AND l_save = on.                          " Sichern
*   Anzeigevariante sichern
    CLEAR l_variant.
    l_variant-report     = l_viewvar-reporta.
    l_variant-handle     = l_viewvar-handle.
    l_variant-log_group  = l_viewvar-log_group.
    IF l_user_specif = 'U'.
      IF l_viewvar-username IS INITIAL.
        l_variant-username = sy-uname.
      ELSE.
        l_variant-username = l_viewvar-username.
      ENDIF.
    ENDIF.
    l_variant-variant    = l_viewvar-avariantid.
    IF NOT l_viewvar-avariantid IS INITIAL.
*     Text der Anzeigevariante lesen
      CALL FUNCTION 'LVC_VARIANT_SELECT'
        EXPORTING
          i_dialog            = ' '
          i_user_specific     = 'U'  " user-specific possible
          it_default_fieldcat = dummy_dispvar
        CHANGING
          cs_variant          = l_variant
        EXCEPTIONS
          wrong_input         = 1
          fc_not_complete     = 2
          not_found           = 3
          program_error       = 4
          OTHERS              = 5.                          "#EC *
      IF sy-subrc <> 0. ENDIF.                              "#EC NEEDED
    ELSE.
*     ID 5683: Schlüssel (Name der Anzeigevariante) generieren
      IF l_user_specif = 'U'.
        l_usr_sp = on.
      ELSE.
        l_usr_sp = off.
      ENDIF.
      CALL FUNCTION 'ISHMED_VM_GENERATE_KEY'
        EXPORTING
          i_key_type      = 'A'  " Anzeigevariante
          i_user_specific = l_usr_sp  " Benutzerspezifisch?
          i_placetype     = i_place-wplacetype
          i_viewtype      = i_view-viewtype
        IMPORTING
          e_key           = l_key
          e_rc            = e_rc
        TABLES
          t_messages      = lt_messages.
      APPEND LINES OF lt_messages TO t_messages.
      IF e_rc <> 0.
*       Fehler beim Generieren des Schlüssels
        EXIT.
      ELSE.
        l_variant-variant = l_key.
      ENDIF.
    ENDIF.
*   Bezeichnung der Anzeigevariante ermitteln
    IF l_user_specif = 'U'.
*     Bezeichnung für persönliche Anzeigevarianten generieren
      PERFORM get_domain_value_desc(sapmn1pa)
                               USING 'NVIEWTYPE' l_viewvar-viewtype
                                                 l_viewtype_txt.
      CONCATENATE sy-uname l_viewtype_txt i_view-viewid
                  INTO l_variant-text SEPARATED BY space.
    ELSEIF i_screen = off AND NOT l_variant-text IS INITIAL.
*     Auch hier kein Popup bringen, falls Bezeichnung bereits vorhanden
    ELSE.
*     Bezeichnung für allgemeine Anzeigevarianten -> Popup bringen
      g_avar_key  = l_variant-variant.
      g_avar_text = l_variant-text.
      CALL SCREEN 100 STARTING AT 13 6 ENDING AT 67 8.
      IF g_save_ok_code = 'ECAN'.
        e_rc = 2.                                           " Cancel
        EXIT.
      ELSE.
        l_variant-text = g_avar_text.
      ENDIF.
    ENDIF.
*   Sonderfall: Alter/Geschlecht im Sichtenprogramm 'Anforderungen'
    IF i_view-viewtype = '004' AND i_place-wplacetype = '001'
                               AND i_user_specific    = off.
      LOOP AT lt_dispvar INTO l_dispvar
              WHERE fieldname = 'GSCHLE'
                 OR fieldname = 'AGEPAT'.
        IF l_dispvar-fieldname = 'GSCHLE' AND l_dispvar-outputlen = 1.
          l_dispvar-outputlen = 3.
        ENDIF.
        IF l_dispvar-fieldname = 'AGEPAT' AND l_dispvar-outputlen = 3.
          l_dispvar-outputlen = 6.
        ENDIF.
        MODIFY lt_dispvar FROM l_dispvar.
      ENDLOOP.
    ENDIF.
*   Anzeigevariante sichern
    IF g_variant IS NOT INITIAL AND 1 = 2.
*     does not work because of error in ALV-basis ...
      CALL METHOD g_variant->save_variant_dark
        EXPORTING
          is_variant = l_variant
          i_active   = 'X'.
      CALL METHOD g_variant->save_variant
        EXPORTING
          i_bypassing_buffer = off
          i_buffer_active    = on
          i_dialog           = off
        IMPORTING
          e_exit             = l_exit.
    ELSE.
      CALL FUNCTION 'LVC_VARIANT_SAVE'
        EXPORTING
          it_fieldcat     = lt_dispvar
          it_sort         = lt_dispsort
          it_filter       = lt_dispfilter
          is_layout       = ls_lvc_layout
          i_dialog        = ' '  " kein Dialog ID 5683
          i_overwrite     = 'X'
          i_user_specific = l_user_specif
        IMPORTING
          e_exit          = l_exit
        TABLES
          it_data         = <lt_data>
        CHANGING
          cs_variant      = l_variant
        EXCEPTIONS
          wrong_input     = 1
          fc_not_complete = 2
          foreign_lock    = 3
          variant_exists  = 4
          name_reserved   = 5
          program_error   = 6
          OTHERS          = 7.
      IF sy-subrc <> 0.
        e_rc = 1.
        IF NOT sy-msgid IS INITIAL AND NOT sy-msgno IS INITIAL.
          PERFORM build_bapiret2(sapmn1pa)
                  USING sy-msgty sy-msgid sy-msgno sy-msgv1 sy-msgv2
                        sy-msgv3 sy-msgv4 ' ' ' ' ' '
                  CHANGING l_wa_msg.
          APPEND l_wa_msg TO t_messages.
        ENDIF.
        EXIT.
      ENDIF.
    ENDIF.
*   Wenn die Variante geändert wurde, soll sie in der Sicht gesichert
*   werden (wenn die Variante auch tatsächlich existiert)
    IF l_exit IS INITIAL AND l_variant-variant <> l_viewvar-avariantid.
      CALL FUNCTION 'LVC_VARIANT_EXISTENCE_CHECK'
        EXPORTING
          i_save        = 'U'  " user-specific possible
        CHANGING
          cs_variant    = l_variant
        EXCEPTIONS
          wrong_input   = 1
          not_found     = 2
          program_error = 3
          OTHERS        = 4.
      IF sy-subrc = 0.
        l_viewvar-reporta    = l_variant-report.
        l_viewvar-avariantid = l_variant-variant.
        l_viewvar-handle     = l_variant-handle.
        l_viewvar-log_group  = l_variant-log_group.
        l_viewvar-username   = l_variant-username.
        l_viewvar-type       = 'F'.                         " ID 7074
*        CLEAR: l_viewvar-type.                          " ID 7074 rem
*       Sichern (Verbuchen) der Anzeigevariante in die Sicht,
*       falls gewünscht
        IF i_save = on AND l_user_specif IS INITIAL.
          PERFORM verbuchen_nwview_var(sapln1svar)
                  USING l_viewvar l_viewvar_old i_update_task.
        ENDIF.
      ENDIF.                           " existiert diese Variante ?
    ENDIF.                             " andere Variante ?
  ENDIF.                               " Variante sichern ?

* Commit Work, falls gewünscht
  IF i_commit = on.
    COMMIT WORK AND WAIT.
  ENDIF.

* Schreiben der Daten der Anzeigevariante in den Puffer ************
  IF i_update_buffer = on.
    CLEAR lt_messages. REFRESH lt_messages.
    IF i_user_specific = on.
*     Refresh bei benutzerspezifischen, damit der Name der neuen
*     persönl. Anzeigevariante korrekt in den Puffer geschrieben wird
      l_mode_buf = 'R'.                                     " Refresh
    ELSE.
*     Update um die geänderte Anzeigevariante in den Puffer zu stellen
      l_mode_buf = 'U'.                                     " Update
    ENDIF.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid     = i_view-viewid
        i_viewtype   = i_view-viewtype
        i_mode       = l_mode_buf
        i_caller     = 'LN1AVARU01'
        i_placeid    = i_place-wplaceid
        i_placetype  = i_place-wplacetype
      IMPORTING
        e_rc         = e_rc
      TABLES
        t_messages   = lt_messages
      CHANGING
        c_dispvar    = lt_dispvar
        c_dispsort   = lt_dispsort
        c_dispfilter = lt_dispfilter
        c_layout     = ls_lvc_layout.
    APPEND LINES OF lt_messages TO t_messages.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ENDIF.

* Sicht mit Anzeigevariante zurückliefern
  e_viewvar = l_viewvar.

ENDFUNCTION.
