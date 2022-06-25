*----------------------------------------------------------------------*
***INCLUDE LN1WORKPLACEF01 .
*----------------------------------------------------------------------*

*----------------------------------------------------------------------*
* FETCH_SELVAR
* Auslesen der Selektionsvariante einer angegebenen Sicht aus den
* internen Puffertabellen, oder (wenn dort nicht vorhanden) aus der
* Datenbank.
* Wird von der Datenbank gelesen, werden die gelesenen Daten
* sofort in die internen Puffertabellen aufgenommen
*----------------------------------------------------------------------*
FORM fetch_selvar USING    VALUE(p_view)        TYPE rnviewvar
                           VALUE(p_placetype)   LIKE nwplace-wplacetype
                           VALUE(p_placeid)     LIKE nwplace-wplaceid
                           VALUE(p_conv_func)   TYPE c
                           VALUE(p_dattim_get)  TYPE ish_on_off
                           VALUE(p_selpar_get)  TYPE ish_on_off
                  CHANGING pt_selvar            TYPE tyt_selvars
                           pt_selparam          TYPE rsti_t_van
                           pt_message           TYPE tyt_messages
                           p_rc                 LIKE sy-subrc
                           p_rnsvar             TYPE rnsvar.

  DATA: l_wa_msg           TYPE ty_message,
        l_wa_place_001     LIKE nwplace_001,
        l_einri            TYPE einri,
        l_rc               LIKE sy-subrc,
        l_exec_command     TYPE sy-tcode,       " dummy
        l_wa_buffer        TYPE ty_selvarbuf,
        ls_selvar          TYPE ty_selvar,
        l_rnsvar           TYPE rnsvar,
        l_view             TYPE rnviewvar.
  DATA: lt_rsparams        TYPE tyt_selvars,
        lt_vanz            TYPE TABLE OF vanz.

  FIELD-SYMBOLS: <ls_buffer>    TYPE ty_selvarbuf,
                 <ls_selvar>    TYPE ty_selvar.

  l_view = p_view.

  p_rc = 0.

  CLEAR: l_rnsvar, l_einri.

  REFRESH: pt_selvar, pt_selparam, lt_vanz.

* Arbeitsumfelddaten einlesen
  CLEAR l_wa_place_001.
  IF p_placetype = '001'.          " Klin. Arbeitsplatz
    SELECT SINGLE * FROM nwplace_001 INTO l_wa_place_001
           WHERE  wplacetype  = p_placetype
           AND    wplaceid    = p_placeid.
*   ID 12249: additional check if institution is filled
    IF sy-subrc <> 0 OR l_wa_place_001-einri IS INITIAL.
      CALL FUNCTION 'ISH_GET_PARAMETER_ID'
        EXPORTING
          i_parameter_id    = 'EIN'
        IMPORTING
          e_parameter_value = l_einri.
    ELSE.
      l_einri = l_wa_place_001-einri.
    ENDIF.
  ENDIF.

* Zuerst versuchen die Daten aus dem Puffer zu lesen
  LOOP AT gt_selvar ASSIGNING <ls_buffer>
                    WHERE wplacetype = p_placetype
                    AND   wplaceid   = p_placeid
                    AND   viewid     = l_view-viewid
                    AND   viewtype   = l_view-viewtype.
    MOVE-CORRESPONDING <ls_buffer> TO ls_selvar.            "#EC ENHOK
    APPEND ls_selvar TO pt_selvar.
    IF l_rnsvar IS INITIAL.
      MOVE-CORRESPONDING <ls_buffer> TO l_rnsvar.           "#EC ENHOK
    ENDIF.
  ENDLOOP.

  DESCRIBE TABLE pt_selvar.
  IF sy-tfill = 0.
*   Es gibt noch nichts im Puffer => Aus der Datenbank lesen
    IF l_view-reports    IS INITIAL OR
       l_view-svariantid IS INITIAL.
*     Falls zur Sicht noch keine Variante gespeichert ist,
*     die SAP-Standard-Variante verwenden
*     ... es wird doch keine SAP-Std-Variante ausgeliefert!
*      PERFORM get_report_selvar USING    l_view-viewtype
*                                CHANGING l_view-reports.
*      l_view-svariantid = 'SAP&STANDARD'.
*     exit.
      PERFORM call_svar TABLES   lt_rsparams
                                 lt_vanz
                        USING    l_view-viewtype
                                 l_einri
                                 off
                        CHANGING l_exec_command.
    ELSE.
      CALL FUNCTION 'RS_VARIANT_EXISTS'
        EXPORTING
          report              = l_view-reports
          variant             = l_view-svariantid
        IMPORTING
          r_c                 = l_rc
        EXCEPTIONS
          not_authorized      = 1
          no_report           = 2
          report_not_existent = 3
          report_not_supplied = 4
          OTHERS              = 5.
      IF sy-subrc <> 0 OR l_rc <> 0.
        p_rc = 1.
*       Selektionsvariante & für Report & konnte nicht gefunden werden
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF1' '229' l_view-svariantid
                      l_view-reports space space
                      space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO pt_message.
        EXIT.
      ENDIF.

*     nur Selektionsvariante oder auch Selektionsattribute lesen?
      IF p_selpar_get = off.
        CALL FUNCTION 'RS_VARIANT_CONTENTS'
          EXPORTING
            report               = l_view-reports
            variant              = l_view-svariantid
*           MOVE_OR_WRITE        = 'W'
*           NO_IMPORT            = ' '
*         IMPORTING
*           SP                   =
          TABLES
            valutab              = lt_rsparams
          EXCEPTIONS
            variant_non_existent = 1
            variant_obsolete     = 2
            OTHERS               = 3.
        CHECK sy-subrc = 0.
      ELSE.
        PERFORM get_sel_var_and_par USING    l_view
                                    CHANGING lt_rsparams
                                             pt_selparam
                                             l_rc. "MED-46958,AM
*MED-46958,AM
        IF l_rc <> 0.

          DATA: l_msgcls LIKE sy-msgid. "Message class
          DATA: l_msgno LIKE sy-msgno . "Message number
          DATA: l_msgty LIKE sy-msgty . "Message Type , ex. E,I

          l_msgty = 'I'.

          CASE l_rc.
            WHEN 1. " Selection Variant non existent
              l_msgcls = 'NF1'.
              l_msgno = '229'.
            WHEN 2. " Selection Variant obsolete
              l_msgcls = 'N1BASE_MED'.
              l_msgno = '090'.
            WHEN 3. "Other
              "Don't know what error could be catched here, and what message should be showed
          ENDCASE.

          MESSAGE ID l_msgcls TYPE l_msgty NUMBER l_msgno.

          p_rc = l_rc.

          EXIT.

        ENDIF.
*END MED-46958,AM
      ENDIF.

*     Nun die Datenkonvertierung durchführen (wenn gewünscht)
      PERFORM convert_selvar TABLES lt_rsparams
                             USING  p_conv_func 'S'
                                    l_view.

    ENDIF.

    APPEND LINES OF lt_rsparams TO pt_selvar.

*   Sind die OEs des Arbeitsumfeldes befüllt, aber die der
*   Selektionsvariante leer, sollen sie aus dem A.Umfeld befüllt werden
    PERFORM fill_oe_from_wplace USING    p_view-viewtype
                                         p_placetype  p_placeid
                                         l_wa_place_001
                                CHANGING pt_selvar.

*   ID 7531: Datums- und Zeitfelder - Fix-KZ setzen
    PERFORM datetime_fields_set USING    l_view
                                CHANGING pt_selvar.

*   Die gelesenen Daten auch in den internen Puffer einfügen
    LOOP AT pt_selvar ASSIGNING <ls_selvar>.
      MOVE-CORRESPONDING <ls_selvar> TO l_wa_buffer.        "#EC ENHOK
      MOVE-CORRESPONDING l_view      TO l_wa_buffer.        "#EC ENHOK
      l_wa_buffer-wplacetype = p_placetype.
      l_wa_buffer-wplaceid   = p_placeid.
      APPEND l_wa_buffer TO gt_selvar.
    ENDLOOP.
  ELSE.
    IF l_view-svariantid IS INITIAL.
      MOVE-CORRESPONDING l_rnsvar TO l_view.                "#EC ENHOK
    ENDIF.
*   ID 11731: sind die OEs des Arbeitsumfeldes befüllt, aber die der
*   Selektionsvariante leer, sollen sie aus dem A.Umfeld befüllt werden;
*   aber nur im Sichttyp 'Anforderungen/KlinischeAufträge', denn dort
*   gibt es die Checkboxen 'OE d. Arb.umfelds', die auch beim Holen der
*   Selektionsvariante aus dem Puffer die OEs des Arbeitsumfelds u.U.
*   verwenden.
*   Die übrigen Sichttypen nehmen die OEs des Arbeitsumfelds nur
*   beim Erstaufruf und hier nicht mehr (sonst wäre es nicht möglich,
*   eine OE manuell aus den Selektionskriterien zu entfernen!)
    IF p_view-viewtype = '004' OR
       p_view-viewtype = '012' OR
       p_view-viewtype = '013'.
      PERFORM fill_oe_from_wplace USING    p_view-viewtype
                                           p_placetype  p_placeid
                                           l_wa_place_001
                                  CHANGING pt_selvar.
    ENDIF.
*   ID 7531: Datums- und Zeitfelder nicht aus dem Puffer nehmen,
*            wenn das Fix-KZ auf OFF gesetzt ist!
    IF p_dattim_get = on OR p_selpar_get = on.
      PERFORM datetime_fields_get USING    l_view
                                           p_conv_func
                                           p_selpar_get
                                  CHANGING pt_selvar
                                           pt_selparam.
    ENDIF.
  ENDIF.                               " Daten im Puffer gefunden ?

  MOVE-CORRESPONDING l_view TO p_rnsvar.                    "#EC ENHOK

ENDFORM.                               " FETCH_SELVAR

*----------------------------------------------------------------------*
* FETCH_DISPVAR
* Auslesen der Anzeigevariante einer angegebenen Sicht aus den
* internen Puffertabellen, oder (wenn dort nicht vorhanden) aus der
* Datenbank.
* Wird von der Datenbank gelesen, werden die gelesenen Daten
* sofort in die internen Puffertabellen aufgenommen
*----------------------------------------------------------------------*
FORM fetch_dispvar USING    VALUE(p_view)    TYPE rnviewvar
                            VALUE(p_wplace)  TYPE nwplace
                   CHANGING pt_dispvar       TYPE lvc_t_fcat
                            pt_dispsort      TYPE lvc_t_sort
                            pt_dispfilt      TYPE lvc_t_filt
                            p_layout         TYPE lvc_s_layo
                            pt_message       TYPE tyt_messages
                            p_rc             LIKE sy-subrc
                            p_rnavar         TYPE rnavar.

  DATA: l_wa_buffer         TYPE ty_dispvarbuf,
        l_wa_buffer_sort    TYPE ty_dispsortbuf,
        l_wa_buffer_filt    TYPE ty_dispfiltbuf,
        l_wa_buffer_layout  TYPE ty_layoutbuf,
        l_wa_dispvar        TYPE lvc_s_fcat,
        l_wa_dispsort       TYPE lvc_s_sort,
        l_wa_dispfilt       TYPE lvc_s_filt,
        l_wa_msg            TYPE ty_message,
        l_dont_use_buf      TYPE ish_on_off,
        l_use_buffer        TYPE ish_on_off,
        l_rc                TYPE ish_method_rc,
        l_view              TYPE rnviewvar,
        l_rnavar            TYPE rnavar.
*  DATA: l_text(1)           TYPE c.
*  DATA: l_subrc             LIKE sy-subrc.
  DATA: ls_lvc_layout       TYPE lvc_s_layo.
  DATA: l_variant           LIKE disvariant,
*        lt_variants         LIKE TABLE OF ltvariant WITH HEADER LINE,
        lt_dispvar          TYPE lvc_t_fcat,
        lt_dispsort         TYPE lvc_t_sort,
        lt_dispfilt         TYPE lvc_t_filt,
        lt_def_fieldcat     TYPE lvc_t_fcat.
  DATA: ls_viewvar          TYPE nwviewvar.
  DATA: lt_data             TYPE lvc_t_filt.            " Dummy
  DATA: lr_table            TYPE REF TO data.
  DATA: lt_data_001         TYPE ish_t_occupancy_list.  " Sichttyp 001
  DATA: lt_data_002         TYPE ish_t_arrival_list.    " Sichttyp 002
  DATA: lt_data_003         TYPE ish_t_departure_list.  " Sichttyp 003
  DATA: lt_data_004         TYPE ishmed_t_request_list. " Sichttyp 004
  DATA: lt_data_005         TYPE ishmed_t_pts_list.     " Sichttyp 005
  DATA: lt_data_006         TYPE ish_n2_document_list.  " Sichttyp 006
  DATA: lt_data_007         TYPE ish_t_lststelle_list.  " Sichttyp 007
  DATA: lt_data_008         TYPE ish_t_medcontrol_list. " Sichttyp 008
  DATA: lt_data_009         TYPE ish_t_occplanning_list." Sichttyp 009
  DATA: lt_data_010         TYPE ish_t_prereg_list.     " Sichttyp 010
  DATA: lt_data_011         TYPE ishmed_t_op_list.      " Sichttyp 011
  DATA: lt_data_012         TYPE ishmed_t_meorder_list. " Sichttyp 012
  DATA: lt_data_013         TYPE ishmed_t_meevent_list. " Sichttyp 013
*  DATA: lt_data_014         TYPE ISHMED_T_???_LIST.     " Sichttyp 014
  DATA: lt_data_016         TYPE ishmed_t_dictation_list. " Sichttyp 016
  DATA: lt_data_c01         TYPE ishmed_t_dynp_medsrv_work. " comp C01
  DATA: lt_data_c02         TYPE ishmed_t_dynp_medsrv_work. " comp C02

* Michael Manoch, 15.04.2009, MED-33282   START
  DATA: lt_data_c07         TYPE ishmed_t_nrs_ot_planhierarchy.
* Michael Manoch, 15.04.2009, MED-33282   END
* WK, 26.5.2011, ISHFR-270   Beginn
  DATA: lt_data_fr1        TYPE ish_t_occupancy_list.  " Sichttyp FR1
* WK, 26.5.2011, ISHFR-270   Ende

  FIELD-SYMBOLS: <lt_data>       TYPE STANDARD TABLE,
                 <ls_buffer>     TYPE ty_dispvarbuf,
                 <ls_dispvar>    TYPE lvc_s_fcat.

  l_view = p_view.

  p_rc = 0.

  CLEAR: l_rnavar, ls_lvc_layout, p_layout.

  REFRESH: pt_dispvar, pt_dispsort, pt_dispfilt.
*  REFRESH: lt_variants.

* Zuerst versuchen die Daten aus dem Puffer zu lesen
  LOOP AT gt_dispvar ASSIGNING <ls_buffer>
                     WHERE viewid   = l_view-viewid
                     AND   viewtype = l_view-viewtype.
    MOVE-CORRESPONDING <ls_buffer> TO l_wa_dispvar.         "#EC ENHOK
    APPEND l_wa_dispvar TO pt_dispvar.
    IF l_rnavar IS INITIAL.
      MOVE-CORRESPONDING <ls_buffer> TO l_rnavar.           "#EC ENHOK
    ENDIF.
  ENDLOOP.

  DESCRIBE TABLE pt_dispvar.
  IF sy-tfill = 0.
*   Es gibt noch nichts im Puffer => Aus der Datenbank lesen

*   Je Sichttyp die Struktur der Ausgabetabelle unterschiedlich
*   übergeben (für Filterkriterien)
    CASE l_view-viewtype.
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
      WHEN '014'.
*        ASSIGN lt_data_014[] TO <lt_data>.
        EXIT.   " layout variants not used in viewtype 014!
      WHEN '016'.
        ASSIGN lt_data_016[] TO <lt_data>.
      WHEN '018'.
        EXIT.   " layout variants not used in viewtype 018!
      WHEN 'C01'.
        ASSIGN lt_data_c01[] TO <lt_data>.
      WHEN 'C02'.
        ASSIGN lt_data_c02[] TO <lt_data>.
*     Michael Manoch, 15.04.2009, MED-33282   START
      WHEN 'C07' OR 'C08' OR 'C09'.
        ASSIGN lt_data_c07[] TO <lt_data>.
*     Michael Manoch, 15.04.2009, MED-33282   END
*   START ISHFR-270 - EHPAD
      WHEN 'FR1'.
        IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
          ASSIGN lt_data_fr1[] TO <lt_data>.
        ENDIF.
*   END ISHFR-270 - EHPAD
      WHEN OTHERS.
        CLEAR ls_viewvar.
        IF l_view-viewtype BETWEEN '001' AND '099'.
*         other standard viewtypes (ID 18129)
          PERFORM get_data_table IN PROGRAM sapln1workplace
                                 USING      l_view-viewtype
                                            ls_viewvar-fieldcat_tabtyp
                                 CHANGING   lr_table.
        ENDIF.
        IF lr_table IS NOT BOUND.
*         customer specific or add-on viewtypes (ID 18129)
          PERFORM get_viewvar_data USING    l_view-viewtype
                                   CHANGING ls_viewvar.
          IF ls_viewvar-fieldcat_tabtyp IS NOT INITIAL.
            PERFORM get_data_table IN PROGRAM sapln1workplace
                             USING l_view-viewtype
                                   ls_viewvar-fieldcat_tabtyp
                          CHANGING lr_table.
          ENDIF.
        ENDIF.
        IF lr_table IS BOUND.
          ASSIGN lr_table->* TO <lt_data>.
        ELSE.
          ASSIGN lt_data     TO <lt_data>.
        ENDIF.
    ENDCASE.
*
    CLEAR l_variant.
*   ID 5683: Personalisierte Anzeigevariante des Sichttyps für
*            diesen Benutzer zuerst lesen -> entfällt (ID 6486)
*    perform get_report_anzvar using    l_view-viewtype
*                              changing l_variant-report.
*    l_variant-username = sy-uname.
*    perform variants_read tables lt_variants
*                          using  'LT'
*                                 l_variant
*                                 'U'
*                                 l_text
*                                 l_subrc.
*    describe table lt_variants.
*    if l_subrc <> 0 or sy-tfill = 0.
*      clear l_variant.
*    else.
*      read table lt_variants index 1.
*      move-corresponding lt_variants to l_variant.
*    endif.
*   Falls zum Sichttyp/Benutzer noch keine Variante vorhanden ist, dann
*   Variante zur Sicht lesen
*   if l_variant is initial.
*   Variante zur Sicht lesen (falls vorhanden) - ev. Persönliche!
    IF NOT l_view-reporta    IS INITIAL AND
       NOT l_view-avariantid IS INITIAL.
      CLEAR l_variant.
      l_variant-report    = l_view-reporta.
      l_variant-handle    = l_view-handle.
      l_variant-log_group = l_view-log_group.
      l_variant-username  = l_view-username.
      l_variant-variant   = l_view-avariantid.
*     Prüfen, ob diese Variante tatsächlich existiert
      CALL FUNCTION 'LVC_VARIANT_EXISTENCE_CHECK'
        EXPORTING
          i_save        = 'U'  " user-specific possible!
        CHANGING
          cs_variant    = l_variant
        EXCEPTIONS
          wrong_input   = 1
          not_found     = 2
          program_error = 3
          OTHERS        = 4.
      IF sy-subrc <> 0.
        CLEAR l_variant.
      ENDIF.
    ENDIF.
*   endif.
*   Falls zur Sicht noch keine Variante gespeichert ist, dann
*   die Kunden-Standard-Variante (/STANDARD) lesen
    IF l_variant IS INITIAL.
      CLEAR l_variant.
      l_variant-variant = '/STANDARD'.
      PERFORM get_report_anzvar USING    l_view-viewtype
                                CHANGING l_variant-report.
*     Prüfen, ob diese Variante tatsächlich existiert
      CALL FUNCTION 'LVC_VARIANT_EXISTENCE_CHECK'
        EXPORTING
          i_save        = ' '  " no user-sp. variants!
        CHANGING
          cs_variant    = l_variant
        EXCEPTIONS
          wrong_input   = 1
          not_found     = 2
          program_error = 3
          OTHERS        = 4.
      IF sy-subrc <> 0.
        CLEAR l_variant.
      ENDIF.
    ENDIF.
*   Falls keine Kunden-Standard-Variante existiert, dann
*   die SAP-Standard-Variante lesen (wird ausgeliefert)
    IF l_variant IS INITIAL.
      CLEAR l_variant.
      IF g_ishmed_used = true.
        l_variant-variant = '1SAP_MED'.
      ELSE.
        l_variant-variant = '1SAP_ISH'.
      ENDIF.
      PERFORM get_report_anzvar USING    l_view-viewtype
                                CHANGING l_variant-report.
    ENDIF.
*   should layout buffer be used?
    CALL FUNCTION 'ISH_GET_PARAMETER_ID'
      EXPORTING
        i_parameter_id    = 'N1WP_BUFFER_LAYOUT'
      IMPORTING
        e_parameter_value = l_dont_use_buf
        e_rc              = l_rc.
    IF l_rc = 0.
      IF l_dont_use_buf = on.
        l_use_buffer = off.
      ELSE.
        l_use_buffer = on.
      ENDIF.
    ELSE.
      l_use_buffer = on.
    ENDIF.
*   Feldkatalog zusammenstellen
    REFRESH: lt_def_fieldcat, lt_dispvar, lt_dispsort, lt_dispfilt.
    PERFORM create_fieldcat USING    p_wplace
                                     l_view
                                     on
                                     l_use_buffer
                            CHANGING lt_def_fieldcat
                                     pt_message
                                     p_rc.
    IF p_rc <> 0.
      MOVE-CORRESPONDING l_view TO p_rnavar.                "#EC ENHOK
      EXIT.
    ENDIF.
*   Anzeigevariante lesen
    CALL FUNCTION 'LVC_VARIANT_SELECT'
      EXPORTING
        i_dialog            = ' '
        i_user_specific     = 'U'  " user-specific possible !
        it_default_fieldcat = lt_def_fieldcat
      IMPORTING
        et_fieldcat         = lt_dispvar
        et_sort             = lt_dispsort
        et_filter           = lt_dispfilt
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
        OTHERS              = 5.
    IF sy-subrc = 0.
      PERFORM create_fieldcat USING    p_wplace
                                       l_view
                                       off
                                       l_use_buffer
                              CHANGING lt_dispvar
                                       pt_message
                                       p_rc.
      IF p_rc <> 0.
        MOVE-CORRESPONDING l_view TO p_rnavar.              "#EC ENHOK
        EXIT.
      ENDIF.
*     BEGIN OF INSERT MED-31600
      DELETE gt_dispvar    WHERE viewtype   = l_view-viewtype
                           AND   viewid     = l_view-viewid.
      DELETE gt_dispsort   WHERE viewid     = l_view-viewid
                           AND   viewtype   = l_view-viewtype.
      DELETE gt_dispfilter WHERE viewid     = l_view-viewid
                           AND   viewtype   = l_view-viewtype.
      DELETE gt_lvc_layout WHERE viewid     = l_view-viewid
                           AND   viewtype   = l_view-viewtype.
*     END OF INSERT MED-31600
      pt_dispvar[]      = lt_dispvar[].
      pt_dispsort[]     = lt_dispsort[].
      pt_dispfilt[]     = lt_dispfilt[].
      ls_lvc_layout-no_keyfix = 'X'.                        " ID 6421
      p_layout          = ls_lvc_layout.
      l_view-reporta    = l_variant-report.
      l_view-handle     = l_variant-handle.
      l_view-log_group  = l_variant-log_group.
      l_view-username   = l_variant-username.
      l_view-avariantid = l_variant-variant.
    ELSE.
      PERFORM build_bapiret2(sapmn1pa)
             USING 'E' 'NF1' '230' l_variant-variant l_variant-report
                    sy-subrc space
                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_message.
      pt_dispvar[] = lt_def_fieldcat[].
    ENDIF.                             " Anzeigevariante gefunden ?
*   In den Puffer stellen
    LOOP AT pt_dispvar ASSIGNING <ls_dispvar>.
      MOVE-CORRESPONDING <ls_dispvar> TO l_wa_buffer.       "#EC ENHOK
      MOVE-CORRESPONDING l_view       TO l_wa_buffer.       "#EC ENHOK
      APPEND l_wa_buffer TO gt_dispvar.
    ENDLOOP.
    LOOP AT pt_dispsort INTO l_wa_dispsort.
      MOVE-CORRESPONDING l_wa_dispsort TO l_wa_buffer_sort.
      l_wa_buffer_sort-viewid   = l_view-viewid.
      l_wa_buffer_sort-viewtype = l_view-viewtype.
      APPEND l_wa_buffer_sort TO gt_dispsort.
    ENDLOOP.
    LOOP AT pt_dispfilt INTO l_wa_dispfilt.
      MOVE-CORRESPONDING l_wa_dispfilt TO l_wa_buffer_filt.
      l_wa_buffer_filt-viewid   = l_view-viewid.
      l_wa_buffer_filt-viewtype = l_view-viewtype.
      APPEND l_wa_buffer_filt TO gt_dispfilter.
    ENDLOOP.
    MOVE-CORRESPONDING p_layout TO l_wa_buffer_layout.
    l_wa_buffer_layout-viewid   = l_view-viewid.
    l_wa_buffer_layout-viewtype = l_view-viewtype.
    APPEND l_wa_buffer_layout TO gt_lvc_layout.
  ELSE.
*   Es gibt schon etwas im Puffer => Aus dem Puffer übernehmen
    LOOP AT gt_dispsort INTO l_wa_buffer_sort
                       WHERE viewid   = l_view-viewid
                       AND   viewtype = l_view-viewtype.
      MOVE-CORRESPONDING l_wa_buffer_sort TO l_wa_dispsort.
      APPEND l_wa_dispsort TO pt_dispsort.
    ENDLOOP.
    LOOP AT gt_dispfilter INTO l_wa_buffer_filt
                       WHERE viewid   = l_view-viewid
                       AND   viewtype = l_view-viewtype.
      MOVE-CORRESPONDING l_wa_buffer_filt TO l_wa_dispfilt.
      APPEND l_wa_dispfilt TO pt_dispfilt.
    ENDLOOP.
    LOOP AT gt_lvc_layout INTO l_wa_buffer_layout
                       WHERE viewid   = l_view-viewid
                       AND   viewtype = l_view-viewtype.
      MOVE-CORRESPONDING l_wa_buffer_layout TO p_layout.
    ENDLOOP.
*   if l_view-avariantid is initial.  " raus wegen ID 5683
    MOVE-CORRESPONDING l_rnavar TO l_view.                  "#EC ENHOK
*   endif.
  ENDIF.                               " Daten im Puffer gefunden ?

  MOVE-CORRESPONDING l_view TO p_rnavar.                    "#EC ENHOK

ENDFORM.                               " FETCH_DISPVAR

*----------------------------------------------------------------------*
* FETCH_FUNCVAR
* Auslesen der Funktionsvariante einer angegebenen Sicht aus den
* internen Puffertabellen, oder (wenn dort nicht vorhanden) aus der
* Datenbank.
* Wird von der Datenbank gelesen, werden die gelesenen Daten
* sofort in die internen Puffertabellen aufgenommen
*----------------------------------------------------------------------*
FORM fetch_funcvar USING    VALUE(p_view) TYPE rnviewvar
                   CHANGING pt_fvar       TYPE tyt_fvar
                            pt_fvarp      TYPE tyt_fvarp
                            pt_button     TYPE tyt_button
                            pt_message    TYPE tyt_messages
                            p_rc          LIKE sy-subrc
                            p_rnfvar      TYPE rnfvar.

  DATA: l_wa_fvarbuf   TYPE ty_fvarbuf,
        l_wa_fvarpbuf  TYPE ty_fvarpbuf,
        l_wa_buttonbuf TYPE ty_buttonbuf,
        l_wa_fvar      TYPE ty_fvar,
        l_wa_fvarp     TYPE ty_fvarp,
        l_wa_button    TYPE ty_button,
        l_rnfvar       TYPE rnfvar,
        l_view         TYPE rnviewvar.

  FIELD-SYMBOLS: <ls_fvarbuf>    TYPE ty_fvarbuf,
                 <ls_fvarpbuf>   TYPE ty_fvarpbuf,
                 <ls_buttonbuf>  TYPE ty_buttonbuf,
                 <ls_fvar>       TYPE ty_fvar,
                 <ls_fvarp>      TYPE ty_fvarp,
                 <ls_button>     TYPE ty_button.

  l_view = p_view.

  p_rc = 0.

  CLEAR l_rnfvar.

  REFRESH: pt_fvar, pt_fvarp, pt_button.

* Lesen der Funktionsvariante
  LOOP AT gt_fvar ASSIGNING <ls_fvarbuf>
                  WHERE viewid   = l_view-viewid
                  AND   viewtype = l_view-viewtype.
    MOVE-CORRESPONDING <ls_fvarbuf> TO l_wa_fvar.           "#EC ENHOK
    APPEND l_wa_fvar TO pt_fvar.
    IF l_rnfvar IS INITIAL.
      MOVE-CORRESPONDING <ls_fvarbuf> TO l_rnfvar.          "#EC ENHOK
    ENDIF.
  ENDLOOP.

  DESCRIBE TABLE pt_fvar.
  IF sy-tfill = 0.
*   Es gibt noch nichts im Puffer => Aus der Datenbank lesen
    IF l_view-fvariantid IS INITIAL.
*     SAP-Standard-Variante lesen, wenn keine zur Sicht vorhanden
      IF g_ishmed_used = true.
        l_view-fvariantid = 'SAP&STANDARDMED'.
      ELSE.
        l_view-fvariantid = 'SAP&STANDARD'.
      ENDIF.
    ENDIF.
*   Variante zur Sicht lesen (falls vorhanden)
    CALL FUNCTION 'ISHMED_VM_FVAR_GET'
      EXPORTING
        i_viewtype       = l_view-viewtype
        i_fvariantid     = l_view-fvariantid
        i_fill_txt_langu = on
      IMPORTING
        e_rc             = p_rc
      TABLES
        t_fvar           = pt_fvar
        t_fvarp          = pt_fvarp
        t_button         = pt_button
        t_messages       = pt_message.
    IF p_rc <> 0.
      EXIT.
    ENDIF.
*   Die gelesenen Daten auch in den internen Puffer einfügen
    LOOP AT pt_fvar ASSIGNING <ls_fvar>.
      MOVE-CORRESPONDING <ls_fvar> TO l_wa_fvarbuf.         "#EC ENHOK
      MOVE-CORRESPONDING l_view    TO l_wa_fvarbuf.         "#EC ENHOK
      APPEND l_wa_fvarbuf TO gt_fvar.
    ENDLOOP.
    LOOP AT pt_fvarp ASSIGNING <ls_fvarp>.
      MOVE-CORRESPONDING <ls_fvarp> TO l_wa_fvarpbuf.       "#EC ENHOK
      l_wa_fvarpbuf-viewid   = l_view-viewid.
      l_wa_fvarpbuf-viewtype = l_view-viewtype.
      APPEND l_wa_fvarpbuf TO gt_fvarp.
    ENDLOOP.
    LOOP AT pt_button ASSIGNING <ls_button>.
      MOVE-CORRESPONDING <ls_button> TO l_wa_buttonbuf.     "#EC ENHOK
      l_wa_buttonbuf-viewid   = l_view-viewid.
      l_wa_buttonbuf-viewtype = l_view-viewtype.
      APPEND l_wa_buttonbuf TO gt_button.
    ENDLOOP.
  ELSE.
*   Es gibt schon etwas im Puffer => Aus dem Puffer übernehmen
    LOOP AT gt_fvarp ASSIGNING <ls_fvarpbuf>
                     WHERE viewid   = l_view-viewid
                     AND   viewtype = l_view-viewtype.
      MOVE-CORRESPONDING <ls_fvarpbuf> TO l_wa_fvarp.       "#EC ENHOK
      APPEND l_wa_fvarp TO pt_fvarp.
    ENDLOOP.
    LOOP AT gt_button ASSIGNING <ls_buttonbuf>
                      WHERE viewid   = l_view-viewid
                      AND   viewtype = l_view-viewtype.
      MOVE-CORRESPONDING <ls_buttonbuf> TO l_wa_button.     "#EC ENHOK
      APPEND l_wa_button TO pt_button.
    ENDLOOP.
    IF l_view-fvariantid IS INITIAL.
      MOVE-CORRESPONDING l_rnfvar TO l_view.                "#EC ENHOK
    ENDIF.
  ENDIF.                               " IF SY-TFILL = 0

  MOVE-CORRESPONDING l_view TO p_rnfvar.                    "#EC ENHOK

ENDFORM.                               " FETCH_FUNCVAR

*---------------------------------------------------------------------*
* Form  CONVERT_SELVAR
* Datenkonvertierung der Selektionsvariante durchführen
*----------------------------------------------------------------------*
FORM convert_selvar TABLES pt_selvar          STRUCTURE rsparams
                    USING  VALUE(p_conv_func) TYPE c
                           VALUE(p_direction) TYPE c
                           VALUE(p_view)      TYPE rnviewvar.

  DATA: l_func_name     TYPE ish_fbname,
        l_function(35)  TYPE c,
        ls_viewvar      TYPE nwviewvar.

  IF p_conv_func = 'X'.
    CLEAR: l_function.
*   Standardkonvertierung aufrufen (ID 18129)
    IF p_view-viewtype BETWEEN '001' AND '099' OR
       p_view-viewtype EQ 'P01'.
*     all standard-viewtypes
      DO 3 TIMES.
*       Build the name of the function module to call
        IF l_function IS INITIAL.
          l_function = 'ISH_VP_CONVERT_SVAR_'.
        ELSEIF l_function(6) = 'ISH_VP'.
          l_function = 'ISHMED_VP_CONVERT_SVAR_'.
        ELSEIF l_function(9) = 'ISHMED_VP'.
          l_function = 'ISH_N2_VP_CONVERT_SVAR_'.
        ELSE.
          EXIT.
        ENDIF.
        CONCATENATE l_function p_view-viewtype INTO l_function.
        IF strlen( l_function ) > 30.
          l_function = l_function(30).
        ENDIF.
        l_func_name = l_function.
        TRY.
            CALL FUNCTION l_func_name
              EXPORTING
                i_direction = p_direction
              TABLES
                t_selvar    = pt_selvar.
            EXIT.   " leave the DO-loop
          CATCH cx_root.                                    "#EC *
*           If the function does not exist, this should not raise
*           an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
        ENDTRY.
      ENDDO.
    ENDIF.
*   START ISHFR-270 - EHPAD
*   Standardkonvertierung für Sicht FR1 aufrufen (ISHFR-270 - EHPAD)
    IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true AND      "ISHFR-270 - EHPAD
       p_view-viewtype EQ 'FR1'.                              "ISHFR-270 - EHPAD.
      IF l_function IS INITIAL.
        l_function = 'ISH_FR_VP_CONVERT_SVAR_'.
      ELSE.
        EXIT.
      ENDIF.
      CONCATENATE l_function p_view-viewtype INTO l_function.
      IF strlen( l_function ) > 30.
        l_function = l_function(30).
      ENDIF.
      l_func_name = l_function.
      TRY.
          CALL FUNCTION l_func_name
            EXPORTING
              i_direction = p_direction
            TABLES
              t_selvar    = pt_selvar.
          EXIT.   " leave the DO-loop
        CATCH cx_root.                                      "#EC *
*           If the function does not exist, this should not raise
*           an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDIF.
*   END ISHFR-270 - EHPAD
    IF l_function IS INITIAL.
*     Get the name of the function module to call for
*     customer specific or add-on viewtypes
      PERFORM get_viewvar_data USING    p_view-viewtype
                               CHANGING ls_viewvar.
      IF ls_viewvar-vp_convert_svar IS NOT INITIAL.
        l_function = ls_viewvar-vp_convert_svar.
        IF strlen( l_function ) > 30.
          l_function = l_function(30).
        ENDIF.
        l_func_name = l_function.
        TRY.
            CALL FUNCTION l_func_name
              EXPORTING
                i_direction = p_direction
              TABLES
                t_selvar    = pt_selvar.
          CATCH cx_root.                                    "#EC *
*           If the function does not exist, this should not raise
*           an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
        ENDTRY.
      ENDIF.
    ENDIF.
  ELSEIF NOT p_conv_func IS INITIAL.
*   Angegebenen Konvertierungs-FBS aufrufen
    CALL FUNCTION p_conv_func
      EXPORTING
        i_direction = p_direction
      TABLES
        t_selvar    = pt_selvar.
  ENDIF.

ENDFORM.                               " CONVERT_SELVAR

*&---------------------------------------------------------------------*
*&      Form  FILL_OE_FROM_WPLACE
*&---------------------------------------------------------------------*
*       Sind die OEs des Arbeitsumfeldes befüllt, aber die der
*       Selektionsvariante leer, sollen sie aus dem A.Umfeld befüllt
*       werden (aus übergebenen Daten oder von Datenbank lesen)
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE  Sichttyp
*      --> P_PLACETYPE Arbeitsumfeld Typ
*      --> P_PLACEID   Arbeitsumfeld-ID
*      --> P_PLACE_001 Spezielle Daten des Arb.umfelds 001
*      <-- PT_SELVAR   Selektionsvariante (Inhalt)
*----------------------------------------------------------------------*
FORM fill_oe_from_wplace
                    USING    VALUE(p_viewtype)   LIKE nwview-viewtype
                             VALUE(p_placetype)  LIKE nwplace-wplacetype
                             VALUE(p_placeid)    LIKE nwplace-wplaceid
                             VALUE(p_place_001)  LIKE nwplace_001
                    CHANGING pt_selvar           TYPE tyt_selvars.

  DATA: lt_selvar    TYPE tyt_selvars,                      " ID 11731
        l_selvar     LIKE LINE OF lt_selvar,                " ID 11731
        l_npob       TYPE npob,
        l_oe         TYPE orgid.

  FIELD-SYMBOLS:     <ls_selvar>  TYPE ty_selvar.

  lt_selvar[] = pt_selvar[].                                " ID 11731

  LOOP AT pt_selvar ASSIGNING <ls_selvar>.
    CASE p_placetype.
      WHEN '001'.                      " Klin. Arbeitsplatz
        CASE p_viewtype.
          WHEN '001' OR '002' OR '003'.
*           Belegung/Zugänge/Abgänge
            CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU' OR
                  <ls_selvar>-selname = 'SE_EINRI'.
          WHEN '004'.
*           Anforderungen / Klinische Aufträge
            CHECK <ls_selvar>-selname = 'GR_ANPOE' OR
                  <ls_selvar>-selname = 'GR_ANFOE' OR
                  <ls_selvar>-selname = 'GR_ERBOE' OR
                  <ls_selvar>-selname = 'GR_ETR'   OR
                  <ls_selvar>-selname = 'GR_TRT'   OR
                  <ls_selvar>-selname = 'GR_DEP'   OR
                  <ls_selvar>-selname = 'G_EINRI'.
          WHEN '005'.
*           Fahraufträge
            CHECK <ls_selvar>-selname = 'G_EINRI'.
*                 <ls_selvar>-selname = 'GR_ORGAG' or
*                 <ls_selvar>-selname = 'GR_ORGZL'.
          WHEN '006'.
*           Dokumente: WE-Daten im FuB ISH_N2_WP_VIEW_006 auswerten
            EXIT.
          WHEN '007'.
*           Leistungsstelle/Ambulanz
            CHECK <ls_selvar>-selname = 'SE_EINRI' OR
                  <ls_selvar>-selname = 'SE_LEIST'.
          WHEN '008'.
*           Medizincontrolling
            CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU' OR
                  <ls_selvar>-selname = 'SE_EINRI'.
          WHEN '009'.
*           Fachrichtungsbezogene Belegungen
            CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU' OR
                  <ls_selvar>-selname = 'SE_EINRI'.
          WHEN '010'.
*           Vormerkungen
            CHECK <ls_selvar>-selname = 'R_WARDOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU' OR
                  <ls_selvar>-selname = 'SE_EINRI'.
          WHEN '011'.
*           Operationen
            CHECK <ls_selvar>-selname = 'R_POBNR'  OR
                  <ls_selvar>-selname = 'R_OPOE'   OR
                  <ls_selvar>-selname = 'SE_EINRI'.
          WHEN '012'.
*           Arzneimittelverordnungen
            CHECK <ls_selvar>-selname = 'SE_EINRI' OR
                  <ls_selvar>-selname = 'R_ORGFA'  OR
                  <ls_selvar>-selname = 'R_ORGPF'.
          WHEN '013'.
*           Arzneimittelereignisse
            CHECK <ls_selvar>-selname = 'SE_EINRI' OR
                  <ls_selvar>-selname = 'R_ORGFA'  OR
                  <ls_selvar>-selname = 'R_ORGPF'  OR
                  <ls_selvar>-selname = 'R_DOCOU'  OR
                  <ls_selvar>-selname = 'R_DOCDOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU' OR
                  <ls_selvar>-selname = 'R_CAREOU'.
          WHEN '014'.
*           Terminplanung
            CHECK <ls_selvar>-selname = 'R_OPOE'   OR
                  <ls_selvar>-selname = 'SE_EINRI'.
          WHEN '016'.
*           Diktate
            CHECK <ls_selvar>-selname = 'SE_EINRI'.
          WHEN '018'.
*           OP-Disposition
            CHECK <ls_selvar>-selname = 'R_OPOE'   OR
                  <ls_selvar>-selname = 'SE_EINRI'.
*         START ISHFR-270 - EHPAD
          WHEN 'FR1'.
            IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
*             Abwesenheiten
              CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                    <ls_selvar>-selname = 'R_DEPTOU' OR
                    <ls_selvar>-selname = 'SE_EINRI'.
            ENDIF.
*         END ISHFR-270 - EHPAD
          WHEN OTHERS.
*           other viewtypes (ID 18129)
            CHECK <ls_selvar>-selname    = 'SE_EINRI' OR
                  <ls_selvar>-selname(5) = 'R_OEP'    OR
                  <ls_selvar>-selname(5) = 'R_OEF'    OR
                  <ls_selvar>-selname(5) = 'R_OEE'.
        ENDCASE.
        CHECK <ls_selvar>-low IS INITIAL.
        CHECK <ls_selvar>-option <> 'EQ'.                   " MED-34205
        CASE <ls_selvar>-selname.
*         Pfleg. OE
          WHEN 'R_WARDOU' OR 'R_TREAOU' OR 'GR_ANPOE' OR
               'GR_ETR'   OR 'R_CAREOU' OR 'R_ORGPF'.
*           ID 11731: Sichttyp 004 - OE nur wenn gewünscht holen
            IF p_viewtype = '004'.
              IF <ls_selvar>-selname = 'GR_ANPOE'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'G_ANPWPL'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSEIF <ls_selvar>-selname = 'GR_ETR'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'G_ETRWPL'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
*               OE nur befüllen, wenn der Veranlasser eine OE (=1)
*               und kein GPART (=2) ist!
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'G_ETRBY'.
                IF sy-subrc = 0 AND l_selvar-low <> '1'.
                  CONTINUE.
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.
*           Sichttyp 012/013 - OE ebenfalls nur wenn gewünscht holen
            ELSEIF p_viewtype = '012' OR p_viewtype = '013'.
              IF <ls_selvar>-selname = 'R_ORGPF'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'P_PF'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSEIF <ls_selvar>-selname = 'R_CAREOU'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'P_CAREOU'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.
            ENDIF.
            IF p_place_001 IS INITIAL.
              SELECT SINGLE pflegoe FROM nwplace_001
                     INTO <ls_selvar>-low
                     WHERE  wplacetype  = p_placetype
                     AND    wplaceid    = p_placeid.
            ELSE.
              <ls_selvar>-low = p_place_001-pflegoe.
            ENDIF.
*         Fachl. OE
          WHEN 'R_DEPTOU' OR 'GR_ANFOE' OR 'GR_DEP' OR
               'R_DOCDOU' OR 'R_ORGFA'.
*           ID 11731: Sichttyp 004 - OE nur wenn gewünscht holen
            IF p_viewtype = '004'.
              IF <ls_selvar>-selname = 'GR_ANFOE'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'G_ANFWPL'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSEIF <ls_selvar>-selname = 'GR_DEP'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'G_DEPWPL'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.
*           Sichttyp 012/013 - OE ebenfalls nur wenn gewünscht holen
            ELSEIF p_viewtype = '012' OR p_viewtype = '013'.
              IF <ls_selvar>-selname = 'R_ORGFA'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'P_FA'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSEIF <ls_selvar>-selname = 'R_DEPTOU'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'P_DEPTOU'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSEIF <ls_selvar>-selname = 'R_DOCDOU'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'P_DDOU'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.
            ENDIF.
            IF p_place_001 IS INITIAL.
              SELECT SINGLE fachloe FROM nwplace_001
                     INTO <ls_selvar>-low
                     WHERE  wplacetype  = p_placetype
                     AND    wplaceid    = p_placeid.
            ELSE.
              <ls_selvar>-low = p_place_001-fachloe.
            ENDIF.
*         Erbringende OE
          WHEN 'GR_ERBOE' OR 'SE_LEIST' OR 'R_DOCOU' OR
               'R_POBNR'  OR 'R_OPOE'   OR 'GR_TRT'.
*           ID 11731: Sichttyp 004 - OE nur wenn gewünscht holen
            IF p_viewtype = '004'.
              IF <ls_selvar>-selname = 'GR_ERBOE'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'G_ERBWPL'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSEIF <ls_selvar>-selname = 'GR_TRT'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'G_TRTWPL'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
*               OE nur befüllen, wenn der Adressat eine OE (=1)
*               und kein GPART (=2) ist!
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'G_TRTBY'.
                IF sy-subrc = 0 AND l_selvar-low <> '1'.
                  CONTINUE.
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.
*           Sichttyp 013 - OE ebenfalls nur wenn gewünscht holen
            ELSEIF p_viewtype = '013'.
              IF <ls_selvar>-selname = 'R_DOCOU'.
                READ TABLE lt_selvar INTO l_selvar
                           WITH KEY selname = 'P_DOU'.
                IF sy-subrc = 0 AND l_selvar-low IS INITIAL.
                  CONTINUE.
                ENDIF.
              ELSE.
                CONTINUE.
              ENDIF.
            ENDIF.
            IF p_place_001 IS INITIAL.
              SELECT SINGLE erboe FROM nwplace_001
                     INTO <ls_selvar>-low
                     WHERE  wplacetype  = p_placetype
                     AND    wplaceid    = p_placeid.
            ELSE.
              <ls_selvar>-low = p_place_001-erboe.
            ENDIF.
            IF <ls_selvar>-selname = 'R_POBNR' AND
               NOT <ls_selvar>-low IS INITIAL.
              l_oe = <ls_selvar>-low.
              CLEAR <ls_selvar>-low.
              SELECT * FROM npob INTO l_npob UP TO 1 ROWS
                     WHERE  orgid  = l_oe
                     AND    bauid  = space
                     AND    pernr  = space.
                EXIT.
              ENDSELECT.
              IF sy-subrc = 0.
                <ls_selvar>-low(10)   = l_npob-pobnr.
                <ls_selvar>-low+10(8) = l_oe.
              ENDIF.
            ENDIF.
          WHEN 'SE_EINRI' OR 'G_EINRI' OR 'R_EINRI'.     " Einrichtung
            IF p_place_001 IS INITIAL.
              SELECT SINGLE einri FROM nwplace_001
                     INTO <ls_selvar>-low
                     WHERE  wplacetype  = p_placetype
                     AND    wplaceid    = p_placeid.
*             ID 12249: additional check if institution is filled
              IF sy-subrc <> 0 OR <ls_selvar>-low IS INITIAL.
                CALL FUNCTION 'ISH_GET_PARAMETER_ID'
                  EXPORTING
                    i_parameter_id    = 'EIN'
                  IMPORTING
                    e_parameter_value = <ls_selvar>-low.
              ENDIF.
            ELSE.
              <ls_selvar>-low = p_place_001-einri.
            ENDIF.
        ENDCASE.
*       use standard OU-fields of other viewtypes (ID 18129)
        CASE <ls_selvar>-selname(5).
*         Pfleg. OE
          WHEN 'R_OEP'.
            IF p_place_001 IS INITIAL.
              SELECT SINGLE pflegoe FROM nwplace_001
                     INTO <ls_selvar>-low
                     WHERE  wplacetype  = p_placetype
                     AND    wplaceid    = p_placeid.
            ELSE.
              <ls_selvar>-low = p_place_001-pflegoe.
            ENDIF.
*         Fachl. OE
          WHEN 'R_OEF'.
            IF p_place_001 IS INITIAL.
              SELECT SINGLE fachloe FROM nwplace_001
                     INTO <ls_selvar>-low
                     WHERE  wplacetype  = p_placetype
                     AND    wplaceid    = p_placeid.
            ELSE.
              <ls_selvar>-low = p_place_001-fachloe.
            ENDIF.
*         Erbringende OE
          WHEN 'R_OEE'.
            IF p_place_001 IS INITIAL.
              SELECT SINGLE erboe FROM nwplace_001
                     INTO <ls_selvar>-low
                     WHERE  wplacetype  = p_placetype
                     AND    wplaceid    = p_placeid.
            ELSE.
              <ls_selvar>-low = p_place_001-erboe.
            ENDIF.
        ENDCASE.
        CHECK NOT <ls_selvar>-low IS INITIAL.
        CLEAR <ls_selvar>-high.
        IF <ls_selvar>-low <> 'SE_EINRI' AND
           <ls_selvar>-low <> 'G_EINRI'.
          <ls_selvar>-sign   = 'I'.
          <ls_selvar>-option = 'EQ'.
        ENDIF.
      WHEN OTHERS.
*       Vorläufig kein anderer Arbeitsumfeldtyp unterstützt ...
        EXIT.
    ENDCASE.
*    MODIFY pt_selvar FROM <ls_selvar>.
  ENDLOOP.

ENDFORM.                               " FILL_OE_FROM_WPLACE

*&---------------------------------------------------------------------*
*&      Form  CREATE_FIELDCAT
*&---------------------------------------------------------------------*
*       Feldkatalog für einen Sichttyp zusammenstellen
*----------------------------------------------------------------------*
*      --> P_WPLACE     Arbeitsumfeld
*      --> P_VIEW       Sicht
*      --> P_MERGE      Feldkatalog aufgrund Strukurname zusammenstellen
*      --> P_USE_BUFFER Buffer benutzen (ON/OFF)
*      <-- PT_FIELDCAT  Feldkatalog
*      <-- PT_MESSAGES  Meldungen
*      <-- P_RC         Returncode
*----------------------------------------------------------------------*
FORM create_fieldcat USING    VALUE(p_wplace)     TYPE nwplace
                              VALUE(p_view)       LIKE rnviewvar
                              VALUE(p_merge)      TYPE ish_on_off
                              VALUE(p_use_buffer) TYPE ish_on_off
                     CHANGING pt_fieldcat         TYPE lvc_t_fcat
                              pt_messages         TYPE tyt_messages
                              p_rc                LIKE sy-subrc.

  DATA: l_wa_msg        TYPE ty_message,
        l_tabname       LIKE dd02l-tabname,
        l_func_name     TYPE ish_fbname,
        l_function(35)  TYPE c,
        ls_dd02l        TYPE dd02l,
        ls_viewvar      TYPE nwviewvar,
        l_nwplace       TYPE nwplace,                       " ID 12249
        l_nwview        TYPE nwview,                        " ID 12249
        l_podesign      TYPE nwplace_p01-podesign,
        l_buffer_active TYPE char01,
        l_bypass_buffer TYPE char01.

* Michael Manoch, 15.04.2009, MED-33282   START
  FIELD-SYMBOLS <ls_fcat>     TYPE lvc_s_fcat.
* Michael Manoch, 15.04.2009, MED-33282   END

  CLEAR: l_tabname, l_function.
  CLEAR: l_nwplace, l_nwview.                               " ID 12249

  l_nwplace         = p_wplace.                             " ID 12249
  l_nwview-mandt    = sy-mandt.                             " ID 12249
  l_nwview-viewtype = p_view-viewtype.                      " ID 12249
  l_nwview-viewid   = p_view-viewid.                        " ID 12249

  IF p_merge = on.
*   Je nach Sichttyp den entsprechenden Strukturnamen verwenden,
*   um den Feldkatalog zusammenzustellen
    CASE p_view-viewtype.
*     views of clinical workplace
      WHEN '001'.
*       Belegung
        l_tabname = 'RNWP_OCCUPANCY_LIST'.
      WHEN '002'.
*       Zugänge
        l_tabname = 'RNWP_ARRIVAL_LIST'.
      WHEN '003'.
*       Abgänge
        l_tabname = 'RNWP_DEPARTURE_LIST'.
      WHEN '004'.
*       Anforderungen / Klinische Aufträge
        l_tabname = 'RN1WP_REQUEST_LIST'.
      WHEN '005'.
*       Fahraufträge
        l_tabname = 'RN1WP_PTS_LIST'.
      WHEN '006'.
*       Dokumente
        l_tabname = 'RN2WP_DOCUMENT_LIST'.
      WHEN '007'.
*       Leistungsstelle/Ambulanz
        l_tabname = 'RN1WPV007_FIELDCAT'.
      WHEN '008'.
*       Medizincontrolling
        l_tabname = 'RNWP_MEDCONTROL_LIST'.
      WHEN '009'.
*       Fachrichtungsbezogene Belegungen
        l_tabname = 'RNWP_OCCPLANNING_LIST'.
      WHEN '010'.
*       Vormerkungen
        l_tabname = 'RNWP_PREREG_LIST'.
      WHEN '011'.
*       Operationen
        l_tabname = 'RN1WP_OP_LIST'.
      WHEN '012'.
*       Arzneimittelverordnungen
        l_tabname = 'RN1WP_MEORDER_LIST'.
      WHEN '013'.
*       Arzneimittelverordnungen
        l_tabname = 'RN1WP_MEEVENT_LIST'.
      WHEN '014'.
*       Terminplanung
*        l_tabname = 'RN1WP_???_LIST'.
        EXIT.   " layout variants are not used in viewtype 014!
*     (views) workplace for patient organizer
      WHEN '016'.
*       Diktate
        l_tabname = 'RN2WP_DICTATION_LIST'.
      WHEN 'P01'.
*       get info if list is a tree or a grid
        SELECT SINGLE podesign FROM nwplace_p01 INTO l_podesign
               WHERE  wplacetype  = l_nwplace-wplacetype
               AND    wplaceid    = l_nwplace-wplaceid.
        IF sy-subrc <> 0 OR l_podesign IS INITIAL OR l_podesign = '000'.
          l_tabname = 'RN1PO_PROCESS_REPRESENTATION'.  " Tree
        ELSE.
          l_tabname = 'RN1PO_GRID'.                    " Grid
        ENDIF.
*     views for components
      WHEN 'C01' OR 'C02'.
        l_tabname = 'RN1_DYNP_MEDSRV_WORK'.
*     KG, MED-30727 - Begin
      WHEN 'C03'.
        l_tabname = 'RN1_GRID_ME_ORDER'.
*     KG, MED-30727 - End
      WHEN 'C05' OR 'C06'.
        l_tabname = 'RN1_NRS_OT_SERVICES'.
*     Michael Manoch, 15.04.2009, MED-33282   START
      WHEN 'C07' OR 'C08' OR 'C09'.
        l_tabname = 'RN1_NRS_OT_PLANHIERARCHY'.
*     KG, MED-40981 - Begin
      WHEN 'C10'.
        l_tabname = 'RN1_GRID_ME_EVENT_LIST'.
*     KG, MED-40981 - end
*     Michael Manoch, 15.04.2009, MED-33282   END
*   START ISHFR-270 - EHPAD
      WHEN 'FR1' .
        IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
*       Abwesenheiten
          l_tabname = 'RNWP_ABSENCE_LIST'.
        ENDIF.
*   END ISHFR-270 - EHPAD
      WHEN OTHERS.
        IF p_view-viewtype BETWEEN '001' AND '099'.
*         other standard-viewtypes (ID 18129)
          DO 3 TIMES.
            IF l_tabname IS INITIAL.
              CLEAR l_tabname.
              CONCATENATE 'RNWP_' p_view-viewtype '_LIST'
                     INTO l_tabname.
            ELSEIF l_tabname(5) = 'RNWP_'.
              CLEAR l_tabname.
              CONCATENATE 'RN1WP_' p_view-viewtype '_LIST'
                     INTO l_tabname.
            ELSEIF l_tabname(6) = 'RN1WP_'.
              CLEAR l_tabname.
              CONCATENATE 'RN2WP_' p_view-viewtype '_LIST'
                     INTO l_tabname.
            ELSE.
              EXIT.
            ENDIF.
            SELECT SINGLE * FROM dd02l INTO ls_dd02l
                   WHERE  tabname   = l_tabname
                   AND    as4local  = 'A'
                   AND    as4vers   = '0000'
                   AND    tabclass  = 'INTTAB'.
            IF sy-subrc = 0.
              EXIT.
            ELSE.
              IF sy-index = 3.
                CLEAR l_tabname.
              ENDIF.
            ENDIF.
          ENDDO.
        ENDIF.
        IF l_tabname IS INITIAL.
*         customer specific or add-on viewtypes (ID 18129)
          PERFORM get_viewvar_data USING    p_view-viewtype
                                   CHANGING ls_viewvar.
          IF ls_viewvar-fieldcat_struct IS NOT INITIAL.
            l_tabname = ls_viewvar-fieldcat_struct.
            SELECT SINGLE * FROM dd02l INTO ls_dd02l
                   WHERE  tabname   = l_tabname
                   AND    as4local  = 'A'
                   AND    as4vers   = '0000'
                   AND    tabclass  = 'INTTAB'.
            IF sy-subrc <> 0.
              CLEAR l_tabname.
            ENDIF.
          ENDIF.
        ENDIF.
    ENDCASE.

    CHECK NOT l_tabname IS INITIAL.

*   Buffer benutzen oder umgehen?
    IF p_use_buffer = on.
      l_buffer_active = on.
      l_bypass_buffer = off.
    ELSE.
      l_buffer_active = off.
      l_bypass_buffer = on.
    ENDIF.

*   Neue Variante anlegen, dazu den Feldkatalog zur Struktur einlesen
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_buffer_active        = l_buffer_active
        i_structure_name       = l_tabname
*       I_CLIENT_NEVER_DISPLAY = 'X'
        i_bypassing_buffer     = l_bypass_buffer
      CHANGING
        ct_fieldcat            = pt_fieldcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.
    IF sy-subrc <> 0.
      p_rc = 1.
*     Fehler & bei Aufbau des Feldkat für Anzeigevar & (Sicht &)
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '234' sy-subrc p_view-avariantid
                    p_view-viewid space space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO pt_messages.
      EXIT.
    ENDIF.
  ENDIF.

* Je nach Sichttyp den entsprechenden FBS aufrufen,
* um den Feldkatalog zu überarbeiten
  CASE p_view-viewtype.
*   viewtypes for clinical workplace
    WHEN '006'.
*     Dokumente
      CALL FUNCTION 'ISH_N2_VP_AVAR_006'
        IMPORTING
          e_rc       = p_rc
        TABLES
          t_messages = pt_messages
        CHANGING
          c_dispvar  = pt_fieldcat.
    WHEN '014'.
*     Terminplanung (layouts not used in viewtype 014!)
      EXIT.
*   (viewtypes) workplace for patient organizer
    WHEN 'P01'.
      IF l_tabname = 'RN1PO_GRID'.                    " Grid
        CALL METHOD cl_ishmed_patorg=>rework_fieldcat_grid
          CHANGING
            ct_fieldcat = pt_fieldcat.
      ELSE.                                           " Tree
        CALL METHOD cl_ishmed_patorg=>rework_fieldcat
          CHANGING
            ct_fieldcat = pt_fieldcat.
      ENDIF.
*   viewtypes for components
    WHEN 'C01'.
*     component medical services
      CALL FUNCTION 'ISHMED_MEDSRV_WORK_FIELDCAT'
        CHANGING
          ct_fieldcat = pt_fieldcat.
    WHEN 'C02'.
*     component DWS medical services
      CALL FUNCTION 'ISHMED_DWS_MEDSRV_WORK_FCAT'
*       EXPORTING
*         I_EINRI           =
        CHANGING
          ct_fieldcat = pt_fieldcat.
*   KG, MED-30727 - Begin
    WHEN 'C03'.
      CALL FUNCTION 'ISHMED_DWS_ME_FIELDCAT'
*       EXPORTING
*         I_EINRI           =
        CHANGING
          ct_fieldcat = pt_fieldcat.
*   KG, MED-30727 - End
    WHEN 'C05' OR 'C06'.
      CALL FUNCTION 'ISHMED_DWS_NRSSRV_FIELDCAT'
*       EXPORTING
*         I_EINRI           =
        CHANGING
          ct_fieldcat = pt_fieldcat.
*   Michael Manoch, 15.04.2009, MED-33282   START
    WHEN 'C07' OR 'C08' OR 'C09'.
      LOOP AT pt_fieldcat ASSIGNING <ls_fcat>.
        <ls_fcat>-seltext = <ls_fcat>-scrtext_l.
      ENDLOOP.
*   Michael Manoch, 15.04.2009, MED-33282   END
*   KG, MED-40981 - Begin
    WHEN 'C10'.
      CALL FUNCTION 'ISHMED_DWS_ME_ADMEVT_FIELDCAT'
        CHANGING
          ct_fieldcat = pt_fieldcat.
*   KG, MED-40981 - End
*   START ISHFR-270 - EHPAD
    WHEN 'FR1' .
      IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
        CALL FUNCTION 'ISH_FR_VP_AVAR_FR1'
          EXPORTING
            i_nwplace  = l_nwplace
            i_nwview   = l_nwview
          IMPORTING
            e_rc       = p_rc
          TABLES
            t_messages = pt_messages
          CHANGING
            c_dispvar  = pt_fieldcat.
      ENDIF.
*   END ISHFR-270 - EHPAD
    WHEN OTHERS.
      CLEAR: l_function.
      IF p_view-viewtype BETWEEN '001' AND '099'.
*       other standard-viewtypes (ID 18129)
        DO 3 TIMES.
*         Build the name of the function module to call
          IF l_function IS INITIAL.
            l_function = 'ISH_VP_AVAR_'.
          ELSEIF l_function(6) = 'ISH_VP'.
            l_function = 'ISHMED_VP_AVAR_'.
          ELSEIF l_function(9) = 'ISHMED_VP'.
            l_function = 'ISH_N2_VP_AVAR_'.
          ELSE.
            EXIT.
          ENDIF.
          CONCATENATE l_function p_view-viewtype INTO l_function.
          IF strlen( l_function ) > 30.
            l_function = l_function(30).
          ENDIF.
          l_func_name = l_function.
          TRY.
              CALL FUNCTION l_func_name
                EXPORTING
                  i_nwplace  = l_nwplace
                  i_nwview   = l_nwview
                IMPORTING
                  e_rc       = p_rc
                TABLES
                  t_messages = pt_messages
                CHANGING
                  c_dispvar  = pt_fieldcat.
              EXIT.   " leave the DO-loop
            CATCH cx_root.                                  "#EC *
*             If the function does not exist, this should not raise
*             an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
          ENDTRY.
        ENDDO.
      ENDIF.
      IF l_function IS INITIAL.
*       customer specific or add-on viewtypes (ID 18129)
        PERFORM get_viewvar_data USING    p_view-viewtype
                                 CHANGING ls_viewvar.
        IF ls_viewvar-vp_avar IS NOT INITIAL.
          l_function = ls_viewvar-vp_avar.
          IF strlen( l_function ) > 30.
            l_function = l_function(30).
          ENDIF.
          l_func_name = l_function.
          TRY.
              CALL FUNCTION l_func_name
                EXPORTING
                  i_nwplace  = l_nwplace
                  i_nwview   = l_nwview
                IMPORTING
                  e_rc       = p_rc
                TABLES
                  t_messages = pt_messages
                CHANGING
                  c_dispvar  = pt_fieldcat.
            CATCH cx_root.                                  "#EC *
*             If the function does not exist, this should not raise
*             an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
          ENDTRY.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.                               " CREATE_FIELDCAT

*&---------------------------------------------------------------------*
*&      Form  FILL_OE_IN_TEXT
*&---------------------------------------------------------------------*
*       Platzhalter für OEs im Text der Sicht befüllen
*       (aus übergebenen Daten oder von der Datenbank lesen)
*----------------------------------------------------------------------*
*      --> P_WPLACETYPE Typ des Arbeitsumfelds
*      --> P_WPLACEID   Identifikation des Arbeitsumfelds
*      --> P_WPLACE_001 Spezielle Daten für Arbeitsumfeldtyp 001
*      <-> P_TXT        Text der Sicht
*----------------------------------------------------------------------*
FORM fill_oe_in_text USING VALUE(p_wplacetype) LIKE nwplace-wplacetype
                           VALUE(p_wplaceid)   LIKE nwplace-wplaceid
                           VALUE(p_wplace_001) LIKE nwplace_001
                     CHANGING p_txt            LIKE nwviewt-txt.

  DATA: l_orgid      LIKE norg-orgid.

  CASE p_wplacetype.
    WHEN '001'.                        " Klin. Arbeitspl.
*     Fachl. OE
      IF p_txt CS '&f'.
        IF p_wplace_001 IS INITIAL.
          SELECT SINGLE fachloe FROM nwplace_001 INTO l_orgid
                 WHERE  wplacetype  = p_wplacetype
                 AND    wplaceid    = p_wplaceid.
          CHECK sy-subrc = 0.
        ELSE.
          l_orgid = p_wplace_001-fachloe.
        ENDIF.
        IF l_orgid IS INITIAL.
          REPLACE '&f' IN p_txt WITH space.
        ELSE.
          PERFORM del_lead_zero(sapmn1pa) USING l_orgid.
          REPLACE '&f' IN p_txt WITH l_orgid.
        ENDIF.
      ENDIF.
*     Pfleg. OE
      IF p_txt CS '&p'.
        IF p_wplace_001 IS INITIAL.
          SELECT SINGLE pflegoe FROM nwplace_001 INTO l_orgid
                 WHERE  wplacetype  = p_wplacetype
                 AND    wplaceid    = p_wplaceid.
          CHECK sy-subrc = 0.
        ELSE.
          l_orgid = p_wplace_001-pflegoe.
        ENDIF.
        IF l_orgid IS INITIAL.
          REPLACE '&p' IN p_txt WITH space.
        ELSE.
          PERFORM del_lead_zero(sapmn1pa) USING l_orgid.
          REPLACE '&p' IN p_txt WITH l_orgid.
        ENDIF.
      ENDIF.
*     Erbr. OE
      IF p_txt CS '&e'.
        IF p_wplace_001 IS INITIAL.
          SELECT SINGLE erboe FROM nwplace_001 INTO l_orgid
                 WHERE  wplacetype  = p_wplacetype
                 AND    wplaceid    = p_wplaceid.
          CHECK sy-subrc = 0.
        ELSE.
          l_orgid = p_wplace_001-erboe.
        ENDIF.
        IF l_orgid IS INITIAL.
          REPLACE '&e' IN p_txt WITH space.
        ELSE.
          PERFORM del_lead_zero(sapmn1pa) USING l_orgid.
          REPLACE '&e' IN p_txt WITH l_orgid.
        ENDIF.
      ENDIF.
      CONDENSE p_txt.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.                               " FILL_OE_IN_TEXT

*&---------------------------------------------------------------------*
*&      Form  REFRESH_OE_IN_TEXT
*&---------------------------------------------------------------------*
*       Platzhalter für OEs im Text der Sicht befüllen
*       (von der übergebenen Selektionsvariante aktualisieren)
*----------------------------------------------------------------------*
*      --> P_PLACETYPE  Arbeitsumfeldtyp
*      --> P_PLACEID    Arbeitsumfeld-ID
*      --> P_VIEWTYPE   Sichttyp
*      --> P_VIEWID     Sicht-ID
*      --> P_WPLACE_001 Spezielle Daten für Arbeitsumfeldtyp 001
*      <-> P_VIEW_TX    Sichttext
*----------------------------------------------------------------------*
FORM refresh_oe_in_text
             TABLES   pt_selvar            STRUCTURE rsparams
             USING    VALUE(p_placetype)   LIKE nwplace-wplacetype
                      VALUE(p_placeid)     LIKE nwplace-wplaceid
                      VALUE(p_viewtype)    LIKE nwview-viewtype
                      VALUE(p_viewid)      LIKE nwview-viewid "#EC *
                      VALUE(p_wplace_001)  LIKE nwplace_001
             CHANGING p_view_txt           TYPE any.

  DATA: "l_orgid             LIKE norg-orgid,
        l_orgid(10)         TYPE c,  "WJ Spezialfall mit () um ORGID
        l_view_txt(120)     TYPE c,
        l_replace(20)       TYPE c,
        l_replace_p(1)      TYPE c,
        l_replace_f(1)      TYPE c,
        l_replace_e(1)      TYPE c,
        l_use_order_fields  TYPE ish_on_off,
        l_etrby             TYPE n1cordetrby,
        l_trtby             TYPE n1cordtrtby,
        l_n1corder(1)       TYPE c,
        lt_selvar           TYPE TABLE OF rsparams.

  FIELD-SYMBOLS: <ls_selvar>     LIKE rsparams.

  lt_selvar[] = pt_selvar[].
  SORT lt_selvar BY selname low.

* viewtype 004:
* get parameter if request and/or clinical orders are active
  IF p_viewtype = '004'.
    CLEAR: l_use_order_fields, l_n1corder, l_etrby, l_trtby.
    PERFORM oe_in_text_004_specific TABLES   lt_selvar
                                    CHANGING l_use_order_fields
                                             l_etrby
                                             l_trtby
                                             l_n1corder.
  ENDIF.

  l_replace_p = '1'.
  l_replace_f = '1'.
  l_replace_e = '1'.

  LOOP AT lt_selvar ASSIGNING <ls_selvar>.
    CASE p_placetype.
      WHEN '001'.                      " Klin. Arbeitsplatz
        CASE p_viewtype.
          WHEN '001' OR '002' OR '003'.
*           Belegung/Zugänge/Abgänge
            CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU'.
          WHEN '004'.
*           Anforderungen / Klinische Aufträge
            CASE l_n1corder.
              WHEN 'R'.                   " requests
                CHECK <ls_selvar>-selname = 'GR_ANPOE' OR
                      <ls_selvar>-selname = 'GR_ANFOE' OR
                      <ls_selvar>-selname = 'GR_ERBOE'.

              WHEN 'O'.                   " clinical orders
                CHECK l_use_order_fields = on.
                CHECK <ls_selvar>-selname = 'GR_ETR'   OR
                      <ls_selvar>-selname = 'GR_TRT'   OR
                      <ls_selvar>-selname = 'GR_DEP'.
              WHEN OTHERS.                " requests + clinical orders
                IF l_use_order_fields = on.
                  CHECK <ls_selvar>-selname = 'GR_ETR'   OR
                        <ls_selvar>-selname = 'GR_TRT'   OR
                        <ls_selvar>-selname = 'GR_DEP'.
                ELSE.
                  CHECK <ls_selvar>-selname = 'GR_ANPOE' OR
                        <ls_selvar>-selname = 'GR_ANFOE' OR
                        <ls_selvar>-selname = 'GR_ERBOE'.
                ENDIF.
            ENDCASE.
            IF <ls_selvar>-selname = 'GR_ETR' AND l_etrby <> '1'.
              CONTINUE.
            ENDIF.
            IF <ls_selvar>-selname = 'GR_TRT' AND l_trtby <> '1'.
              CONTINUE.
            ENDIF.
          WHEN '005'.
*           Fahraufträge (immer aus Arbeitsumfeld)
            PERFORM fill_oe_in_text USING    p_placetype
                                             p_placeid
                                             p_wplace_001
                                    CHANGING p_view_txt.
            EXIT.
          WHEN '006'.
*           Dokumente
            IF <ls_selvar>-selname = 'R_DEPTOU'.
              <ls_selvar>-selname = 'R_ORGFA'.
              IF <ls_selvar>-low IS NOT INITIAL.
                CONCATENATE '(' <ls_selvar>-low ')' INTO <ls_selvar>-low.
                CONDENSE <ls_selvar>-low.
              ENDIF.
            ENDIF.
            IF <ls_selvar>-selname = 'R_TREAOU'.
              <ls_selvar>-selname = 'R_ORGPF'.
              IF <ls_selvar>-low IS NOT INITIAL.
                CONCATENATE '(' <ls_selvar>-low ')' INTO <ls_selvar>-low.
                CONDENSE <ls_selvar>-low.
              ENDIF.
            ENDIF.
            CHECK <ls_selvar>-selname = 'R_ORGFA' OR
                  <ls_selvar>-selname = 'R_ORGPF' OR
                  <ls_selvar>-selname = 'R_ORGLE'.
            l_replace_p = 1.
            l_replace_e = 1.
            l_replace_f = 1.
          WHEN '007'.
*           Leistungsstelle/Ambulanz
            CHECK <ls_selvar>-selname = 'SE_LEIST' OR
                  <ls_selvar>-selname = 'SE_AOEFA' OR
                  <ls_selvar>-selname = 'SE_AOEPF'.
          WHEN '008'.
*           Medizincontrolling
            CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU'.
          WHEN '009'.
*           Fachrichtungsbezogene Belegungen
            CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU'.
          WHEN '010'.
*           Vormerkungen
            CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                  <ls_selvar>-selname = 'R_DEPTOU'.
          WHEN '011'.
*           Operationen
            CHECK <ls_selvar>-selname = 'R_OPOE'.
          WHEN '012'.
*           Arzneimittelverordnungen
            CHECK <ls_selvar>-selname = 'R_ORGFA' OR
                  <ls_selvar>-selname = 'R_ORGPF'.
          WHEN '013'.
*           Arzneimittelereignisse
            CHECK <ls_selvar>-selname = 'R_ORGFA' OR
                  <ls_selvar>-selname = 'R_ORGPF' OR
                  <ls_selvar>-selname = 'R_CAREOU'.
          WHEN '014'.
*           Terminplanung
            CHECK <ls_selvar>-selname = 'R_OPOE'.
*         WHEN '016'.
*           Diktate
          WHEN '018'.
*           OP-Disposition
            CHECK <ls_selvar>-selname = 'R_OPOE'.
*         START ISHFR-270 - EHPAD
          WHEN 'FR1'.
            IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
*             Abwesenheiten
              CHECK <ls_selvar>-selname = 'R_TREAOU' OR
                    <ls_selvar>-selname = 'R_DEPTOU'.
            ENDIF.
*         END ISHFR-270 - EHPAD
          WHEN OTHERS.
*           other viewtypes (ID 18129)
            CHECK <ls_selvar>-selname(5) = 'R_OEP' OR
                  <ls_selvar>-selname(5) = 'R_OEF' OR
                  <ls_selvar>-selname(5) = 'R_OEE'.
        ENDCASE.
        l_orgid = <ls_selvar>-low.
        PERFORM del_lead_zero(sapmn1pa) USING l_orgid.
        CASE <ls_selvar>-selname.
          WHEN 'R_TREAOU' OR 'GR_ANPOE' OR 'SE_AOEPF' OR    " Pfleg. OE
               'GR_ETR'   OR 'R_ORGPF'.
            IF p_view_txt CS '&p'.
              CLEAR l_view_txt.
              l_view_txt = p_view_txt.           "wg der Länge
              CLEAR l_replace.
              IF l_orgid CA '('.
                CONCATENATE '&p' l_orgid INTO l_replace.
              ELSE.
                CONCATENATE l_orgid '&p' INTO l_replace.
              ENDIF.
              CASE l_replace_p.
                WHEN '1'.
                  REPLACE '&p' IN l_view_txt WITH l_replace.
                  CONDENSE l_view_txt.
                  l_replace_p = '2'.
                WHEN '2'.
                  REPLACE '&p' IN l_view_txt WITH ',...'.
                  CONDENSE l_view_txt.
                  l_replace_p = '3'.
                WHEN OTHERS.
              ENDCASE.
              p_view_txt = l_view_txt.
            ENDIF.
          WHEN 'R_DEPTOU' OR 'GR_ANFOE' OR 'SE_AOEFA' OR    " Fachl. OE
               'GR_DEP'   OR 'R_ORGFA'.
            IF p_view_txt CS '&f'.
              CLEAR l_view_txt.
              l_view_txt = p_view_txt.           "wg der Länge
              CLEAR l_replace.
              IF l_orgid CA '('.
                CONCATENATE '&f' l_orgid INTO l_replace.
              ELSE.
                CONCATENATE l_orgid '&f' INTO l_replace.
              ENDIF.
              CASE l_replace_f.
                WHEN '1'.
                  REPLACE '&f' IN l_view_txt WITH l_replace.
                  CONDENSE l_view_txt.
                  l_replace_f = '2'.
                WHEN '2'.
                  REPLACE '&f' IN l_view_txt WITH ',...'.
                  CONDENSE l_view_txt.
                  l_replace_f = '3'.
                WHEN OTHERS.
              ENDCASE.
              p_view_txt = l_view_txt.
            ENDIF.
          WHEN 'GR_ERBOE' OR 'SE_LEIST' OR 'R_OPOE' OR      " Erbr. OE
               'GR_TRT'   OR 'R_ORGLE'  OR 'R_CAREOU'.
            IF p_view_txt CS '&e'.
              CLEAR l_view_txt.
              l_view_txt = p_view_txt.           "wg der Länge
              CLEAR l_replace.
              IF l_orgid CA '('.
                CONCATENATE '&e' l_orgid INTO l_replace.
              ELSE.
                CONCATENATE l_orgid '&e' INTO l_replace.
              ENDIF.
              CASE l_replace_e.
                WHEN '1'.
                  REPLACE '&e' IN l_view_txt WITH l_replace.
                  CONDENSE l_view_txt.
                  l_replace_e = '2'.
                WHEN '2'.
                  REPLACE '&e' IN l_view_txt WITH ',...'.
                  CONDENSE l_view_txt.
                  l_replace_e = '3'.
                WHEN OTHERS.
              ENDCASE.
              p_view_txt = l_view_txt.
            ENDIF.
        ENDCASE.
*       use standard OU-fields of other viewtypes (ID 18129)
        CASE <ls_selvar>-selname(5).
          WHEN 'R_OEP'.                                     " Pfleg. OE
            IF p_view_txt CS '&p'.
              CLEAR l_view_txt.
              l_view_txt = p_view_txt.           "wg der Länge
              CLEAR l_replace.
              CONCATENATE l_orgid '&p' INTO l_replace.
              CASE l_replace_p.
                WHEN '1'.
                  REPLACE '&p' IN l_view_txt WITH l_replace.
                  CONDENSE l_view_txt.
                  l_replace_p = '2'.
                WHEN '2'.
                  REPLACE '&p' IN l_view_txt WITH ',...'.
                  CONDENSE l_view_txt.
                  l_replace_p = '3'.
                WHEN OTHERS.
              ENDCASE.
              p_view_txt = l_view_txt.
            ENDIF.
          WHEN 'R_OEF'.                                     " Fachl. OE
            IF p_view_txt CS '&f'.
              CLEAR l_view_txt.
              l_view_txt = p_view_txt.           "wg der Länge
              CLEAR l_replace.
              CONCATENATE l_orgid '&f' INTO l_replace.
              CASE l_replace_f.
                WHEN '1'.
                  REPLACE '&f' IN l_view_txt WITH l_replace.
                  CONDENSE l_view_txt.
                  l_replace_f = '2'.
                WHEN '2'.
                  REPLACE '&f' IN l_view_txt WITH ',...'.
                  CONDENSE l_view_txt.
                  l_replace_f = '3'.
                WHEN OTHERS.
              ENDCASE.
              p_view_txt = l_view_txt.
            ENDIF.
          WHEN 'R_OEE'.                                     " Erbr. OE
            IF p_view_txt CS '&e'.
              CLEAR l_view_txt.
              l_view_txt = p_view_txt.           "wg der Länge
              CLEAR l_replace.
              CONCATENATE l_orgid '&e' INTO l_replace.
              CASE l_replace_e.
                WHEN '1'.
                  REPLACE '&e' IN l_view_txt WITH l_replace.
                  CONDENSE l_view_txt.
                  l_replace_e = '2'.
                WHEN '2'.
                  REPLACE '&e' IN l_view_txt WITH ',...'.
                  CONDENSE l_view_txt.
                  l_replace_e = '3'.
                WHEN OTHERS.
              ENDCASE.
              p_view_txt = l_view_txt.
            ENDIF.
        ENDCASE.
      WHEN OTHERS.
        EXIT.
    ENDCASE.
  ENDLOOP.
* Alle nicht gefundenen OEs mit blank füllen
  REPLACE '&p' IN p_view_txt WITH space.
  REPLACE '&f' IN p_view_txt WITH space.
  REPLACE '&e' IN p_view_txt WITH space.
  CONDENSE p_view_txt.

ENDFORM.                               " REFRESH_OE_IN_TEXT

*&---------------------------------------------------------------------*
*&      Form  GET_REPORT_SELVAR
*&---------------------------------------------------------------------*
*       Je Sichttyp den Reportnamen der Selektionsvariante ermitteln
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE  Sichttyp
*      --> P_VIEWID    Sicht-ID
*      <-- P_REPORTS   Reportname der Selektionsvariante
*----------------------------------------------------------------------*
FORM get_report_selvar USING    VALUE(p_viewtype)  TYPE nwview-viewtype
                                VALUE(p_viewid)    TYPE nwview-viewid
                       CHANGING p_reports       TYPE rnviewvar-reports.

  DATA: l_objecttype   TYPE nwview_p01-objecttype,  " only for pat.org.
        l_progname     TYPE progdir-name,
        l_cvers      TYPE ish_country,                    "note 2753930
        ls_progdir     TYPE progdir,
        ls_viewvar     TYPE nwviewvar.

  call function 'ISH_COUNTRY_VERSION_GET'                 "note 2753930
    importing
      ss_cvers = l_cvers.

  CASE p_viewtype.
*   viewtypes of clinical workplace
    WHEN '001'.                        " Belegungen
      p_reports = 'RNWPVIEW001'.
    WHEN '002'.                        " Zugänge
      p_reports = 'RNWPVIEW002'.
    WHEN '003'.                        " Abgänge
      p_reports = 'RNWPVIEW003'.
    WHEN '004'.                        " Anforderungen / Kl. Aufträge
      p_reports = 'RN1START_DYNPRO_N1AU'.
    WHEN '005'.                        " Fahraufträge
      p_reports = 'RN1START_DYNPRO_N1_WP_PTS'.
    WHEN '006'.                        " Dokumente
      p_reports = 'RN2WPVIEW006'.
    WHEN '007'.                        " Leistungsstelle/Ambulanz
      p_reports = 'RN1WPVIEW007'.
    WHEN '008'.                        " Medizincontrolling
      p_reports = 'RNWPVIEW008'.
      if l_cvers = cv_austria.                        "note 2753930 beg
        p_reports = 'RNWATWPVIEW008'.
      endif.                                          "note 2753930 end
    WHEN '009'.                        " Fachrichtungsbez. Belegungen
      p_reports = 'RNWPVIEW009'.
    WHEN '010'.                        " Vormerkungen
      p_reports = 'RNWPVIEW010'.
    WHEN '011'.                        " Operationen
      p_reports = 'RN1WPVIEW011'.
    WHEN '012'.                        " Arzneimittelverordnungen
      p_reports = 'RN1WPVIEW012'.
    WHEN '013'.                        " Arzneimittelereignisse
      p_reports = 'RN1WPVIEW013'.
    WHEN '014'.                        " Terminplanung
      p_reports = 'RN1WPVIEW014'.
    WHEN '016'.                        " Diktate
      p_reports = 'RN2WPVIEW016'.
*   KG, MED-30727 - Begin
    WHEN 'C03'.
      p_reports = 'RN1MESELDWS'.
*   KG, MED-30727 - End
    WHEN 'C05' OR 'C06'.
      p_reports = 'RN1NRSSRVSELDWS'.
*   KG, MED-40981 - Begin
    WHEN 'C10'.
      p_reports = 'RN1MEADMINEVTSELDWS'.
*   KG, MED-40981 - End
*   START ISHFR-270 - EHPAD
    WHEN 'FR1'.
      IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
        p_reports = 'RNWPVIEWFR1'.
      ENDIF.
*   END ISHFR-270 - EHPAD
    WHEN OTHERS.
      IF p_viewtype >= 'D01' AND p_viewtype <= 'D99'.
*       viewtypes of document workstation
        p_reports      = 'RN2DWSWL_'.
        p_reports+9(3) = p_viewtype.
      ELSEIF p_viewtype = 'P01'.
*       viewtypes of patient organizer
        IF NOT p_viewid IS INITIAL.
          SELECT SINGLE objecttype FROM nwview_p01 INTO l_objecttype
                 WHERE  viewtype  = p_viewtype
                 AND    viewid    = p_viewid.
          IF sy-subrc = 0.
            p_reports = 'RN1PATORG_'.
            CASE l_objecttype.
              WHEN 'MEORDER'.
                p_reports+10 = 'ME'.                        "#EC NOTEXT
              WHEN 'PR_DIAGNOS'.
                p_reports+10 = 'PR_DIA'.                    "#EC NOTEXT
              WHEN 'PR_DOCUMNT'.
                p_reports+10 = 'PR_DOC'.                    "#EC NOTEXT
              WHEN 'PR_MOVEMNT'.
                p_reports+10 = 'PR_MOV'.                    "#EC NOTEXT
              WHEN 'PR_REQUEST'.
                p_reports+10 = 'PR_REQ'.                    "#EC NOTEXT
              WHEN 'PR_SERVICE'.
                p_reports+10 = 'PR_SVC'.                    "#EC NOTEXT
              WHEN OTHERS.
*               Begin of MED-57726: MVoicu 22.10.2014
*               In this case, the system will create the name of the corresponding report.
*               p_reports+10 = l_objecttype.
                p_reports = l_objecttype.
                REPLACE REGEX '(/[^/]+/|Z|Y)?(.*)' IN p_reports WITH '$1RN1PATORG_$2'.
*               End of MED-57726: MVoicu 22.10.2014
            ENDCASE.
          ENDIF.
        ENDIF.
      ELSE.
        IF p_viewtype BETWEEN '001' AND '099'.
*         other standard-viewtypes (ID 18129)
          DO 3 TIMES.
            IF l_progname IS INITIAL.
              CLEAR l_progname.
              CONCATENATE 'RNWPVIEW' p_viewtype  INTO l_progname.
            ELSEIF l_progname(4) = 'RNWP'.
              CLEAR l_progname.
              CONCATENATE 'RN1WPVIEW' p_viewtype INTO l_progname.
            ELSEIF l_progname(5) = 'RN1WP'.
              CLEAR l_progname.
              CONCATENATE 'RN2WPVIEW' p_viewtype INTO l_progname.
            ELSE.
              EXIT.
            ENDIF.
            SELECT SINGLE * FROM progdir INTO ls_progdir
                   WHERE name  = l_progname
                     AND state = 'A'.
            IF sy-subrc = 0.
              p_reports = l_progname.
              EXIT.
            ENDIF.
          ENDDO.
        ENDIF.
        IF p_reports IS INITIAL.
*         customer specific or add-on viewtypes (ID 18129)
          PERFORM get_viewvar_data USING    p_viewtype
                                   CHANGING ls_viewvar.
          IF ls_viewvar-report IS NOT INITIAL.
            l_progname = ls_viewvar-report.
            SELECT SINGLE * FROM progdir INTO ls_progdir
                   WHERE name  = l_progname
                     AND state = 'A'.
            IF sy-subrc = 0.
              p_reports = l_progname.
              EXIT.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.                               " GET_REPORT_SELVAR

*&---------------------------------------------------------------------*
*&      Form  GET_REPORT_ANZVAR
*&---------------------------------------------------------------------*
*       Je Sichttyp den Reportnamen der Anzeigevariante ermitteln
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE  Sichttyp
*      <-- P_REPORTA   Reportname der Anzeigevariante
*----------------------------------------------------------------------*
FORM get_report_anzvar USING    VALUE(p_viewtype)  TYPE nwview-viewtype
                       CHANGING p_reporta       TYPE rnviewvar-reporta.

  DATA: l_progname     TYPE progdir-name,
        ls_progdir     TYPE progdir,
        ls_viewvar     TYPE nwviewvar.

  CASE p_viewtype.
*   viewtypes of clinical workplace
    WHEN '001'.                        " Belegungen
      p_reporta = 'RNWPVIEW001'.
    WHEN '002'.                        " Zugänge
      p_reporta = 'RNWPVIEW002'.
    WHEN '003'.                        " Abgänge
      p_reporta = 'RNWPVIEW003'.
    WHEN '004'.                        " Anforderungen / Kl. Aufträge
      p_reporta = 'RN1START_DYNPRO_N1AU'.
    WHEN '005'.                        " Fahraufträge
      p_reporta = 'RN1START_DYNPRO_N1_WP_PTS'.
    WHEN '006'.                        " Dokumente
      p_reporta = 'RN2WPVIEW006'.
    WHEN '007'.                        " Leistungsstelle/Ambulanz
      p_reporta = 'RN1WPVIEW007'.
    WHEN '008'.                        " Medizincontrolling
      p_reporta = 'RNWPVIEW008'.
    WHEN '009'.                        " Fachrichtungsbez. Belegungen
      p_reporta = 'RNWPVIEW009'.
    WHEN '010'.                        " Vormerkungen
      p_reporta = 'RNWPVIEW010'.
    WHEN '011'.                        " Operationen
      p_reporta = 'RN1WPVIEW011'.
    WHEN '012'.                        " Arzneimittelverordnungen
      p_reporta = 'RN1WPVIEW012'.
    WHEN '013'.                        " Arzneimittelereignisse
      p_reporta = 'RN1WPVIEW013'.
    WHEN '014'.                        " Terminplanung
      p_reporta = 'RN1WPVIEW014'.
    WHEN '016'.                        " Diktate
      p_reporta = 'RN2WPVIEW016'.
*   views for patient organizer (saved in table NWPLACE_P01!)
    WHEN 'P01'.
      p_reporta = 'CL_ISHMED_PATORG'.  " patient organizer
*   views for components
    WHEN 'C01'.
      p_reporta = 'CL_ISHMED_SCR_MEDSRV_WORK'. " comp. med. services
    WHEN 'C02'.
      p_reporta = 'CL_ISHMED_SCR_DWS_MEDSRV_WORK'. " comp.DWS services
*   KG, MED-30727 - Begin
    WHEN 'C03'.
      p_reporta = 'CL_ISHMED_SCR_ME_ORDER_GRID'.  "comp. DWS medication
*   KG, MED-30727 - End
    WHEN 'C05' OR 'C06'.
      p_reporta = 'CL_ISHMED_NRS_GV_SERVICES'.
*   Michael Manoch, 15.04.2009, MED-33282   Begin
    WHEN 'C07'.
      p_reporta = 'NRSPSA.CL_ISHMED_NRS_GV_PLANHIERARCHY'.
    WHEN 'C08'.
      p_reporta = 'NRSPDWS.CL_ISHMED_NRS_GV_PLANHIERARCHY'.
    WHEN 'C09'.
      p_reporta = 'NRSPDWSBI.CL_ISHMED_NRS_GV_PLANHIERARCHY'.
*   Michael Manoch, 15.04.2009, MED-33282   End
*   KG, MED-40981 - Begin
    WHEN 'C10'.
      p_reporta = 'CL_ISHMED_SCR_ME_EVENT_LIST'.
*   KG, MED-40981 - End
*   START ISHFR-270 - EHPAD
    WHEN 'FR1' .                              "Abwesenheiten
      IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
        p_reporta = 'RNWPVIEWFR1'.
      ENDIF.
*   END ISHFR-270 - EHPAD
    WHEN OTHERS.
*     other standard viewtypes (ID 18129)
      DO 3 TIMES.
        IF l_progname IS INITIAL.
          CLEAR l_progname.
          CONCATENATE 'RNWPVIEW' p_viewtype  INTO l_progname.
        ELSEIF l_progname(4) = 'RNWP'.
          CLEAR l_progname.
          CONCATENATE 'RN1WPVIEW' p_viewtype INTO l_progname.
        ELSEIF l_progname(5) = 'RN1WP'.
          CLEAR l_progname.
          CONCATENATE 'RN2WPVIEW' p_viewtype INTO l_progname.
        ELSE.
          EXIT.
        ENDIF.
        SELECT SINGLE * FROM progdir INTO ls_progdir
               WHERE name  = l_progname
                 AND state = 'A'.
        IF sy-subrc = 0.
          p_reporta = l_progname.
          EXIT.
        ENDIF.
      ENDDO.
      IF p_reporta IS INITIAL.
*       customer specific or add-on viewtypes (ID 18129)
        PERFORM get_viewvar_data USING    p_viewtype
                                 CHANGING ls_viewvar.
        IF ls_viewvar-report IS NOT INITIAL.
          l_progname = ls_viewvar-report.
          SELECT SINGLE * FROM progdir INTO ls_progdir
                 WHERE name  = l_progname
                   AND state = 'A'.
          IF sy-subrc = 0.
            p_reporta = l_progname.
            EXIT.
          ENDIF.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.                               " GET_REPORT_ANZVAR

*&---------------------------------------------------------------------*
*&      Form  GET_REPORT_FUNCVAR
*&---------------------------------------------------------------------*
*       Je Sichttyp die Funktionsgruppe und den GUI-Status der
*       Funktionsvariante ermitteln
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE    Sichttyp
*      <-- P_GUI_PGM     Funktionsgruppe/Report/Klasse
*      <-- P_GUI_STATUS  GUI-Status (Funktionsvorrat)
*----------------------------------------------------------------------*
FORM get_report_funcvar USING    VALUE(p_viewtype) TYPE nwview-viewtype
                        CHANGING p_gui_pgm         TYPE trdir-name
                                 p_gui_status      TYPE rsmpe_sta-code.

  DATA: l_progname     TYPE progdir-name,
        ls_progdir     TYPE progdir,
        ls_viewvar     TYPE nwviewvar.

  CASE p_viewtype.
*   viewtypes of clincal workplace
    WHEN '001'.
      p_gui_pgm    = 'SAPLN_WP_INP_MOVEMENTS'.
      p_gui_status = 'FCT_ISH_001'.
    WHEN '002'.
      p_gui_pgm    = 'SAPLN_WP_INP_MOVEMENTS'.
      p_gui_status = 'FCT_ISH_002'.
    WHEN '003'.
      p_gui_pgm    = 'SAPLN_WP_INP_MOVEMENTS'.
      p_gui_status = 'FCT_ISH_003'.
    WHEN '004'.
      p_gui_pgm    = 'SAPLN1AU'.
      p_gui_status = 'FCT_004'.
    WHEN '005'.
      p_gui_pgm    = 'SAPLN1_WP_PTS'.
      p_gui_status = 'FCT_005'.
    WHEN '006'.
      p_gui_pgm    = 'SAPLN2WP006'.
      p_gui_status = 'FCT_006'.
    WHEN '007'.
      p_gui_pgm    = 'SAPLN1LSTAMB'.
      p_gui_status = 'FKT_007_ISH'.
    WHEN '008'.
      p_gui_pgm    = 'SAPLN_WP_008'.
      p_gui_status = 'FCT_008'.
    WHEN '009'.
      p_gui_pgm    = 'SAPLN_WP_009'.
      p_gui_status = 'FCT_ISH_009'.
    WHEN '010'.
      p_gui_pgm    = 'SAPLN_WP_010'.
      p_gui_status = 'FCT_ISH_010'.
    WHEN '011'.
      p_gui_pgm    = 'SAPLN1WPOP'.
      p_gui_status = 'FCT_011'.
    WHEN '012'.
      p_gui_pgm    = 'SAPLN1_WP_012'.
      p_gui_status = 'FCT_ISHMED_012'.
    WHEN '013'.
      p_gui_pgm    = 'SAPLN1_WP_013'.
      p_gui_status = 'FCT_ISHMED_013'.
    WHEN '014'.
      p_gui_pgm    = 'SAPLN1WP014'.
      p_gui_status = 'FCT_014'.
    WHEN '016'.
      p_gui_pgm    = 'SAPLN2_WP_016'.
      p_gui_status = 'FCT_016'.
*   viewtype components
    WHEN 'C01'.
      p_gui_pgm    = 'SAPLN1_MDY_MEDSRV_MED'.
      p_gui_status = '0200'.
    WHEN 'C02'.
      p_gui_pgm    = 'SAPLN1_MDY_MEDSRV_MED'.
      p_gui_status = '0300'.
*   KG, MED-30727 - Begin
    WHEN 'C03'.
      p_gui_pgm    = 'SAPLN1ME_MED_ORDER_FRAMEWORK'.
      p_gui_status = '0200'.
    WHEN 'C04'.
      p_gui_pgm    = 'SAPLN1ME_MED_ORDER_FRAMEWORK'.
      p_gui_status = '0300'.
*   KG, MED-30727 - End
    WHEN 'C05'.
      p_gui_pgm    = 'SAPLN1_NRS_MDY_SERVICES'.
      p_gui_status = 'NRS_SRV_DWS'.
    WHEN 'C06'.
      p_gui_pgm    = 'SAPLN1_NRS_MDY_SERVICES'.
      p_gui_status = 'NRS_SRV_SA'.
*   Michael Manoch, MED-33282   Begin
    WHEN 'C07'.
      p_gui_pgm    = 'SAPLN1_NRS_PLAN_FVAR'.
      p_gui_status = 'PHIER_SA'.
    WHEN 'C08'.
      p_gui_pgm    = 'SAPLN1_NRS_PLAN_FVAR'.
      p_gui_status = 'PHIER_DWS'.
    WHEN 'C09'.
      p_gui_pgm    = 'SAPLN1_NRS_PLAN_FVAR'.
      p_gui_status = 'PHIER_DWS_BI'.
*   Michael Manoch, MED-33282   End
*   KG, MED-40981 - Begin
    WHEN 'C10'.
      p_gui_pgm    = 'SAPLN1ME_ADMIN_EVENT'.
      p_gui_status = 'ADMINEVT_DWS'.
*   KG, MED-40981 - End
*   vm med-45165 begin
    WHEN 'C11'.
      p_gui_pgm    = 'SAPLN1ME_MED_ORDER_FRAMEWORK'.
      p_gui_status = '0400'. "standalone

    WHEN 'C12'.
      p_gui_pgm    = 'SAPLN1ME_MED_ORDER_FRAMEWORK'.
      p_gui_status = '0500'.  "embedded into dws
*   vm med-45165 end

*   START ISHFR-270 - EHPAD
    WHEN 'FR1'.
      IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
        p_gui_pgm    = 'SAPLN1WPFR1'.
        p_gui_status = 'FCT_ISH_FR1'.
      ENDIF.
*   END ISHFR-270 - EHPAD
    WHEN OTHERS.
      IF p_viewtype >= 'D01' AND p_viewtype <= 'D99'.
*       viewtypes of document workstation
        p_gui_pgm         = 'SAPLN2SVAR'.
        p_gui_status      = 'N2DWS_'.
        p_gui_status+6(3) = p_viewtype.
      ELSE.
        CLEAR l_progname.
        IF p_viewtype BETWEEN '001' AND '099'.
*         other standard-viewtypes (ID 18129)
          DO 3 TIMES.
            IF l_progname IS INITIAL.
              CLEAR l_progname.
              CONCATENATE 'SAPLNWP' p_viewtype INTO  l_progname.
            ELSEIF l_progname(7) = 'SAPLNWP'.
              CLEAR l_progname.
              CONCATENATE 'SAPLN1WP' p_viewtype INTO l_progname.
            ELSEIF l_progname(8) = 'SAPLN1WP'.
              CLEAR l_progname.
              CONCATENATE 'SAPLN2WP' p_viewtype INTO l_progname.
            ELSE.
              EXIT.
            ENDIF.
            SELECT SINGLE * FROM progdir INTO ls_progdir
                   WHERE name  = l_progname
                     AND state = 'A'.
            IF sy-subrc = 0.
              CLEAR: p_gui_pgm, p_gui_status.
              p_gui_pgm = l_progname.
              CONCATENATE 'FCT_' p_viewtype INTO p_gui_status.
              EXIT.
            ELSE.
              IF sy-index = 3.
                CLEAR l_progname.
              ENDIF.
            ENDIF.
          ENDDO.
        ENDIF.
        IF l_progname IS INITIAL.
*         customer specific or add-on viewtypes (ID 18129)
          PERFORM get_viewvar_data USING    p_viewtype
                                   CHANGING ls_viewvar.
          IF ( ls_viewvar-fugr          IS NOT INITIAL   OR
               ls_viewvar-fugr_progname IS NOT INITIAL ) AND
               ls_viewvar-gui_status    IS NOT INITIAL.
            IF ls_viewvar-fugr_progname IS NOT INITIAL.
              l_progname = ls_viewvar-fugr_progname.
            ELSE.
              CONCATENATE 'SAPL' ls_viewvar-fugr INTO l_progname.
            ENDIF.
            SELECT SINGLE * FROM progdir INTO ls_progdir
                   WHERE name  = l_progname
                     AND state = 'A'.
            IF sy-subrc = 0.
              CLEAR: p_gui_pgm, p_gui_status.
              p_gui_pgm    = l_progname.
              p_gui_status = ls_viewvar-gui_status.
              EXIT.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.                               " GET_REPORT_FUNCVAR

*&---------------------------------------------------------------------*
*&      Form  GET_VIEWVAR
*&---------------------------------------------------------------------*
*       Die Varianten-IDs zu einer Sicht aus den Sicht-
*       Spezialisierungstabellen lesen
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE  Sichttyp
*      --> P_VIEWID    Sicht
*      <-- P_VIEWVAR   Sicht mit Varianten-IDs
*      <-- P_REFRESH   Autorefresh-Info (aktiv + Sekundenintervall)
*      <-- P_RC        Returncode
*----------------------------------------------------------------------*
FORM get_viewvar USING    VALUE(p_viewtype)  LIKE nwview-viewtype
                          VALUE(p_viewid)    LIKE nwview-viewid
                 CHANGING p_viewvar          LIKE rnviewvar
                          p_refresh          TYPE rnrefresh
                          p_rc               LIKE sy-subrc.

  DATA: ls_wa             TYPE REF TO data,
        l_dbname          TYPE lvc_tname,
        ls_viewvar        TYPE nwviewvar.

  DATA: l_dbname1         TYPE lvc_tname,           " ATC SQL potential injection M.Rebegea 18.12.2012
        lv_dbname         TYPE string.              " ATC SQL potential injection M.Rebegea 18.12.2012

  FIELD-SYMBOLS: <l_wa>   TYPE any.

  CLEAR: p_viewvar, p_refresh, p_rc, l_dbname, ls_wa, ls_viewvar.

  IF p_viewtype BETWEEN '001' AND '099' OR
     p_viewtype EQ 'P01' OR                                   " MED-29599
     ( cl_ish_switch_check=>ish_cv_fr( ) = abap_true AND      "ISHFR-270 - EHPAD
       p_viewtype EQ 'FR1' ).                                 "ISHFR-270 - EHPAD
    l_dbname = 'NWVIEW_'.
    l_dbname+7(3) = p_viewtype.
  ELSE.
*   customer specific or add-on viewtypes (ID 18129)
    PERFORM get_viewvar_data USING    p_viewtype
                             CHANGING ls_viewvar.
    IF ls_viewvar-nwview_s IS NOT INITIAL.
      l_dbname = ls_viewvar-nwview_s.
    ENDIF.
  ENDIF.

  IF l_dbname IS NOT INITIAL.
    CREATE DATA ls_wa TYPE (l_dbname).
    ASSIGN ls_wa->* TO <l_wa>.
****  Start: ATC potential SQL injection M.Rebegea 18.12.2012
    l_dbname1 = l_dbname.

    TRY.
        cl_abap_dyn_prg=>check_table_name_str(
          EXPORTING
            val                    = l_dbname1
            packages               = 'IS-H'
            incl_sub_packages      = abap_true
          RECEIVING
            val_str                = lv_dbname
        ).

        SELECT SINGLE * FROM (lv_dbname) INTO <l_wa>
            WHERE  viewtype  = p_viewtype
            AND    viewid    = p_viewid.

      CATCH cx_root.

        TRY.
            cl_abap_dyn_prg=>check_table_name_str(
              EXPORTING
                val                    = l_dbname1
                packages               = 'IS-HMED'
                incl_sub_packages      = abap_true
              RECEIVING
                val_str                = lv_dbname
            ).

            SELECT SINGLE * FROM (lv_dbname) INTO <l_wa>
                WHERE  viewtype  = p_viewtype
                AND    viewid    = p_viewid.

          CATCH cx_root.
****Start: MED-51283 M.Rebegea 08.07.2013
          TRY.
              DATA lt_whitelist TYPE string_hashed_table.

              cl_ishmed_sec_utl=>get_db_whitelist_4_nwview(
                IMPORTING
                  et_whitelist = lt_whitelist    " Positiv-Liste aller DB-Tabellen kund. Sichttypen
              ).

              cl_abap_dyn_prg=>check_whitelist_tab(
                EXPORTING
                  val                      = l_dbname1
                  whitelist                = lt_whitelist
                RECEIVING
                  val_str                  = lv_dbname   " Same as the input
              ).

               SELECT SINGLE * FROM (lv_dbname) INTO <l_wa>
                WHERE  viewtype  = p_viewtype
                AND    viewid    = p_viewid.

            CATCH cx_abap_not_in_whitelist.    "
              MESSAGE a001(n1sec).
          ENDTRY.
****End: MED-51283 M.Rebegea 08.07.2013
        ENDTRY.

    ENDTRY.
*    SELECT SINGLE * FROM (l_dbname) INTO <l_wa>
*           WHERE  viewtype  = p_viewtype
*           AND    viewid    = p_viewid.
****  End: ATC potential SQL injection M.Rebegea 18.12.2012
    IF sy-subrc = 0.
      MOVE-CORRESPONDING <l_wa> TO p_viewvar.               "#EC ENHOK
      MOVE-CORRESPONDING <l_wa> TO p_refresh.               "#EC ENHOK
    ELSE.
      p_viewvar-viewtype = p_viewtype.
      p_viewvar-viewid   = p_viewid.
    ENDIF.
  ELSE.
    p_viewvar-viewtype = p_viewtype.
    p_viewvar-viewid   = p_viewid.
  ENDIF.

ENDFORM.                               " GET_VIEWVAR

*--------------------------------------------------------------------
* Form Check_ISHMED
* Prüft ob ISHMED verwendet wird
*--------------------------------------------------------------------
FORM check_ishmed CHANGING l_ishmed_used LIKE true.

  DATA: l_wa_tn00 LIKE tn00.

  l_ishmed_used = false.

  PERFORM ren00(sapmnpa0) USING l_wa_tn00.
  IF l_wa_tn00-ishmed = 'X'.
    l_ishmed_used = true.
  ENDIF.

ENDFORM.                               " CHECK_ISHMED

*&---------------------------------------------------------------------*
*&      Form  VARIANTS_READ
*&---------------------------------------------------------------------*
*       Lesen von Varianten zu einem Sichttyp (Report)
*----------------------------------------------------------------------*
*FORM variants_read   TABLES   rt_variants     STRUCTURE ltvariant
*                     USING    r_tool          LIKE ltdx-relid
*                              rs_variant      LIKE disvariant
*                              r_user_specific TYPE c
*                              r_text          TYPE c
*                              r_subrc         LIKE sy-subrc.
*
*  RANGES: lr_report    FOR ltdx-report,
*          lr_handle    FOR ltdx-handle,
*          lr_log_group FOR ltdx-log_group,
*          lr_username  FOR ltdx-username,
*          lr_variant   FOR ltdx-variant,
*          lr_type      FOR ltdx-type.
*
*  lr_report-sign   = 'I'.
*  lr_report-option = 'EQ'.
*  lr_report-low    = rs_variant-report.
*  APPEND lr_report.
*
*  lr_handle-sign   = 'I'.
*  lr_handle-option = 'EQ'.
*  lr_handle-low    = rs_variant-handle.
*  APPEND lr_handle.
*
*  lr_log_group-sign   = 'I'.
*  lr_log_group-option = 'EQ'.
*  lr_log_group-low    = rs_variant-log_group.
*  APPEND lr_log_group.
*
*  IF NOT r_user_specific IS INITIAL.
*    lr_username-sign   = 'I'.
*    lr_username-option = 'EQ'.
*    IF rs_variant-username IS INITIAL.
*      lr_username-sign   = 'I'.
*      lr_username-option = 'EQ'.
*      lr_username-low    = space.
*      APPEND lr_username.
*      lr_username-low    = sy-uname.
*    ELSE.
*      lr_username-low    = rs_variant-username.
*    ENDIF.
*    APPEND lr_username.
*  ELSE.
*    lr_username-sign   = 'I'.
*    lr_username-option = 'EQ'.
*    lr_username-low    = space.
*    APPEND lr_username.
*  ENDIF.
*
*  IF NOT rs_variant-variant IS INITIAL.
*    lr_variant-sign   = 'I'.
*    lr_variant-option = 'EQ'.
*    lr_variant-low    = rs_variant-variant.
*    APPEND lr_variant.
*  ENDIF.
*
*  lr_type-sign   = 'I'.
*  lr_type-option = 'EQ'.
*  lr_type-low    = 'F'.                "fieldcat
*  APPEND lr_type.
*
*
*  CALL FUNCTION 'LT_VARIANTS_READ_FROM_LTDX'
*    EXPORTING
*      i_tool          = r_tool
*      i_text          = r_text
*    TABLES
*      et_variants     = rt_variants
*      it_ra_report    = lr_report
*      it_ra_handle    = lr_handle
*      it_ra_log_group = lr_log_group
*      it_ra_username  = lr_username
*      it_ra_variant   = lr_variant
*      it_ra_type      = lr_type
*    EXCEPTIONS
*      not_found       = 1
*      OTHERS          = 2.
*
*  r_subrc = sy-subrc.
*
*ENDFORM.                               " VARIANTS_READ
*&---------------------------------------------------------------------*
*&      Form  get_key
*&---------------------------------------------------------------------*
*       Neue Nummer aus Nummernkreisobjekt ausfassen
*----------------------------------------------------------------------*
*      --> P_OBJECT  Nummernkreisobjekt
*      <-- P_KEY     Teil des Schlüssels (neue 4-stellige Nummer)
*----------------------------------------------------------------------*
*form get_key using    value(p_object)    like tnkrs-nkobj
*             changing p_key              like rnwp_gen_key-n1genkey6.
*
*  data: modus_normal     like tnkrs-modus value 'N',
*        modus_standalone like tnkrs-modus value 'S',
*        intern_nr(1)                      value 'I',
*        new_number       like n1fat-fatid.
*
*  data: nr_range_nr      like nriv-nrrangenr,
*        nr_range_type(1).              "Werte: I/E/A
*
*  data: subobject        like tnkrs-obkey      value '*',
*        toyear_0000      like inri-toyear      value '0000',
*        quantity_in      like inri-quantity    value 1,  "Anz. zuverg
*        quantity_nlei    like inri-quantity    value 30, "Nummern
*        quantity         like inri-quantity,
*        rcode_nr         like inri-returncode,
*        dummy_rc         like sy-subrc.
*
*  clear p_key.
*
*  perform check_number_range(sapmnpas)
*                      using '    ' new_number p_object
*                            subobject nr_range_nr nr_range_type
*                            dummy_rc true.
*  if nr_range_type = intern_nr.
*    perform number_get_next(sapmnpas)
*                      using nr_range_nr p_object quantity_in
*                            toyear_0000 p_key
*                            quantity rcode_nr subobject.
*  endif.
*
*endform.                               " get_key
*&---------------------------------------------------------------------*
*&      Form  get_key_v
*&---------------------------------------------------------------------*
*       Neue Sicht-ID ermitteln
*       Refactored with MED-61616 CKi
*          - 3 variants of getting a new key
*            - Take highest key, increment it
*            - if highest key is 9999, search for gaps
*            - else take a Id from a new number range C<system>nnnnnn
*              (new with MED-61616)
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE    Sichttyp
*      --> P_SAP_STD     SAP-Standard-Sicht anlegen
*      --> P_COUNT_ADD   Wieviel hochzählen?
*      <-- P_KEY         Neue Sicht-ID  ( z.b. CSTKK40001 )
*----------------------------------------------------------------------*
FORM get_key_v USING    VALUE(p_viewtype)    LIKE nwview-viewtype
                        VALUE(p_sap_std)     TYPE ish_on_off
                        VALUE(p_count_add)   LIKE sy-index
               CHANGING p_key                LIKE rnwp_gen_key-nwkey.

  " MED-61616 CKi -----------------------------------------------------------

  DATA: l_num(4) TYPE n.
  DATA: l_num6(6)                TYPE n,
*       l_new_number             LIKE sy-tabix,
        l_available_key          LIKE rnwp_gen_key-nwkey,
        l_number_range_exhausted TYPE ish_on_off.

  IF p_count_add > 9999.
    CLEAR p_key.
    EXIT.
  ENDIF.

  CLEAR p_key.

  PERFORM get_highest_key_from_nwview             "MED-61616 CKi
     USING    p_viewtype
              p_sap_std
     CHANGING p_key
              l_num.

* calculate next key.
  l_num6 = l_num.
  ADD p_count_add TO l_num6.

  IF l_num6 <= '009999'.         " no problem with number range
    l_num = l_num6.
    IF p_sap_std = on.
      p_key+4(4) = l_num.
    ELSE.
      p_key+6(4) = l_num.
    ENDIF.

  ELSE.                          " try to find a gap in number range
    PERFORM search_available_number
                USING
                    p_viewtype
                    p_sap_std
                CHANGING
                   l_available_key
                   l_number_range_exhausted.
    IF l_number_range_exhausted = off.
      p_key = l_available_key.
    ELSE.
      IF p_sap_std = off.                 "create a key in new C-number-range
        PERFORM create_c_number_range_key
                    USING
                        p_viewtype
                        p_count_add
                    CHANGING
                       l_available_key.
        IF NOT l_available_key IS INITIAL.
          p_key = l_available_key.
        ENDIF.

      ELSE.    "no solution
        CLEAR p_key.
      ENDIF.

    ENDIF.
  ENDIF.
  " End of MED-61616 CKi -----------------------------------------------------


ENDFORM.                    " get_key_v

*&---------------------------------------------------------------------*
*&      Form  get_key_w
*&---------------------------------------------------------------------*
*       Neue Arbeitsumfeld-ID ermitteln
*----------------------------------------------------------------------*
*      --> P_WPLACETYPE  Arbeitsumfeld-Typ
*      --> P_SAP_STD     SAP-Standard-Arbeitsumfeld anlegen
*      --> P_COUNT_ADD   Wieviel hochzählen?
*      <-- P_KEY         Neues Arbeitsumfeld-ID
*                        (z.b.  CSTKK4000001  oder  SKK4000001)
*----------------------------------------------------------------------*
FORM get_key_w USING    VALUE(p_wplacetype)  LIKE nwplace-wplacetype
                        VALUE(p_sap_std)     TYPE ish_on_off
                        VALUE(p_count_add)   LIKE sy-index
               CHANGING p_key                LIKE rnwp_gen_key-nwkey.

  DATA: l_id     LIKE nwplace-wplaceid,
        l_wpid   LIKE nwplace-wplaceid,
        l_num(6) TYPE n.

  IF p_count_add > 999999.
    CLEAR p_key.
    EXIT.
  ENDIF.

* Arbeitsumfeldnamen können wenn gewünscht als SAP-Standard-Namen
* generiert werden (Präfix S)
  IF p_sap_std = on.
    CONCATENATE co_prefix_sap sy-sysid '%' INTO l_id.  " Präfix 'S'
  ELSE.
    CONCATENATE co_prefix     sy-sysid '%' INTO l_id.  " Präfix 'CST'
  ENDIF.
  CONDENSE l_id NO-GAPS.

  SELECT wplaceid FROM nwplace INTO l_wpid UP TO 1 ROWS
         WHERE  wplacetype  =    p_wplacetype
         AND    wplaceid    LIKE l_id
         ORDER BY wplaceid DESCENDING.                      "#EC *
    EXIT.
  ENDSELECT.                                                "#EC *

  IF sy-subrc = 0.
    IF p_sap_std = on.
      l_num = l_wpid+4(6).
    ELSE.
      l_num = l_wpid+6(6).
    ENDIF.
  ELSE.
    l_num = '000000'.
  ENDIF.

  ADD p_count_add TO l_num.

  IF p_sap_std = on.
    CONCATENATE co_prefix_sap sy-sysid l_num INTO l_id.  " Präfix 'S'
  ELSE.
    CONCATENATE co_prefix     sy-sysid l_num INTO l_id.  " Präfix 'CST'
  ENDIF.
  CONDENSE l_id NO-GAPS.

  p_key = l_id.

ENDFORM.                    " get_key_w

*&---------------------------------------------------------------------*
*&      Form  get_key_a
*&---------------------------------------------------------------------*
*       Neues Anzeigevarianten-ID für Layout ermitteln
*----------------------------------------------------------------------*
*      --> P_USER_SPEC   Benutzerspezifisches Layout anlegen
*      --> P_VIEWTYPE    Sichttyp
*      --> P_COUNT_ADD   Wieviel hochzählen?
*      <-- P_KEY         Neues Anzeigevarianten-ID
*                        (z.b.  CKK4000001  oder  /CKK4000001)
*----------------------------------------------------------------------*
FORM get_key_a USING    VALUE(p_user_spec)   TYPE ish_on_off
                        VALUE(p_viewtype)    LIKE nwview-viewtype
                        VALUE(p_wplacetype)  LIKE nwplace-wplacetype "MED-44567
                        VALUE(p_count_add)   LIKE sy-index
               CHANGING p_key                LIKE rnwp_gen_key-nwkey.

  DATA: l_id        LIKE ltdx-variant,
        l_varid     LIKE ltdx-variant,
        l_username  LIKE ltdx-username,
        l_report    LIKE ltdx-report,
        l_num(6)    TYPE n.

  IF p_count_add > 999999.
    CLEAR p_key.
    EXIT.
  ENDIF.

  PERFORM get_report_anzvar(sapln1workplace)
                            USING    p_viewtype
                            CHANGING l_report.

* Standard-Kunden-Anzeigevarianten (also jene ohne Benutzerbezug)
* brauchen ein '/' zu Beginn des Namens
  IF p_user_spec = on.
    CONCATENATE     co_prefix_a sy-sysid '%' INTO l_id.  " Präfix 'C'
    l_username = sy-uname.
  ELSE.
    CONCATENATE '/' co_prefix_a sy-sysid '%' INTO l_id.  " Präfix '/C'
    CLEAR l_username.
  ENDIF.
  CONDENSE l_id NO-GAPS.

  IF p_wplacetype = '001'.                                  "MED-44567
    SELECT variant FROM ltdx INTO l_varid UP TO 1 ROWS
           WHERE  relid     =    'LT'
           AND    report    =    l_report
           AND    username  =    l_username
           AND    handle    =    space
           AND    log_group =    space
           AND    variant   LIKE l_id
           ORDER BY variant DESCENDING.
      EXIT.
    ENDSELECT.
  ELSE.
    SELECT variant FROM ltdx INTO l_varid UP TO 1 ROWS
           WHERE  relid     =    'LT'
           AND    report    =    l_report
           AND    username  =    l_username
           AND    log_group =    space
           AND    variant   LIKE l_id
           ORDER BY variant DESCENDING.
      EXIT.
    ENDSELECT.
  ENDIF.

  IF sy-subrc = 0.
    IF p_user_spec = on.
      l_num = l_varid+4(6).
    ELSE.
      l_num = l_varid+5(6).
    ENDIF.
  ELSE.
    l_num = '000000'.
  ENDIF.

  ADD p_count_add TO l_num.

  IF p_user_spec = on.
    CONCATENATE     co_prefix_a sy-sysid l_num INTO l_id.  " Präfix 'C'
  ELSE.
    CONCATENATE '/' co_prefix_a sy-sysid l_num INTO l_id.  " Präfix '/C'
  ENDIF.
  CONDENSE l_id NO-GAPS.

  p_key = l_id.

ENDFORM.                    " get_key_a

*&---------------------------------------------------------------------*
*&      Form  get_key_f
*&---------------------------------------------------------------------*
*       Neues Funktionsvarianten-ID ermitteln
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE    Sichttyp
*      --> P_COUNT_ADD   Wieviel hochzählen?
*      <-- P_KEY         Neues Funktionsvarianten-ID
*                        (z.b.  CSTKK4000001)
*----------------------------------------------------------------------*
FORM get_key_f USING    VALUE(p_viewtype)    LIKE nwview-viewtype
                        VALUE(p_count_add)   LIKE sy-index
               CHANGING p_key                LIKE rnwp_gen_key-nwkey.

  DATA: l_id      LIKE nwfvar-fvar,
        l_fvarid  LIKE nwfvar-fvar,
        l_num(6)  TYPE n.

  IF p_count_add > 999999.
    CLEAR p_key.
    EXIT.
  ENDIF.

  CONCATENATE co_prefix sy-sysid '%' INTO l_id.  " Präfix 'CST'
  CONDENSE l_id NO-GAPS.

  SELECT fvar FROM nwfvar INTO l_fvarid UP TO 1 ROWS
         WHERE  viewtype  =    p_viewtype
         AND    fvar      LIKE l_id
         ORDER BY fvar DESCENDING.                          "#EC *
    EXIT.
  ENDSELECT.                                                "#EC *

  IF sy-subrc = 0.
    l_num = l_fvarid+6(6).
  ELSE.
    l_num = '000000'.
  ENDIF.

  ADD p_count_add TO l_num.

  CONCATENATE co_prefix sy-sysid l_num INTO l_id.  " Präfix 'CST'
  CONDENSE l_id NO-GAPS.

  p_key = l_id.

ENDFORM.                    " get_key_f
*&---------------------------------------------------------------------*
*&      Form  fill_lb_open_nodes
*&---------------------------------------------------------------------*
*       Listbox mit den gültigen Zeilentypen des Sichttypen befüllen
*----------------------------------------------------------------------*
*      --> P_FNAME     Feldname
*      --> P_VIEWTYPE  Sichttyp
*----------------------------------------------------------------------*
FORM fill_lb_open_nodes USING VALUE(p_fname)    TYPE vrm_id
                              VALUE(p_viewtype) LIKE nwview-viewtype
                              VALUE(p_act004)   TYPE char1.

  DATA: lt_list    TYPE vrm_values,
        l_wa_list  LIKE LINE OF lt_list.

  REFRESH: lt_list.

  CASE p_viewtype.
    WHEN '004'.                          " viewtype clinical orders
      IF p_act004 = 'R'.                 " only requests
        CLEAR l_wa_list.
        l_wa_list-key  = 'P'.
        l_wa_list-text = 'Patienten'(003).
        APPEND l_wa_list TO lt_list.
        l_wa_list-key  = 'R'.
        l_wa_list-text = 'Anforderungen'(004).
        APPEND l_wa_list TO lt_list.
        l_wa_list-key  = 'S'.
        l_wa_list-text = 'Leistungen'(005).
        APPEND l_wa_list TO lt_list.
      ELSEIF p_act004 = 'O'.             " only clinical orders
        CLEAR l_wa_list.
        l_wa_list-key  = 'P'.
        l_wa_list-text = 'Patienten'(003).
        APPEND l_wa_list TO lt_list.
        l_wa_list-key  = 'O'.
        l_wa_list-text = 'Klinische Aufträge'(006).
        APPEND l_wa_list TO lt_list.
        l_wa_list-key  = 'R'.
        l_wa_list-text = 'Auftragspositionen'(007).
        APPEND l_wa_list TO lt_list.
        l_wa_list-key  = 'S'.
        l_wa_list-text = 'Leistungen'(005).
        APPEND l_wa_list TO lt_list.
      ELSE.                              " requests and clinical orders
        CLEAR l_wa_list.
        l_wa_list-key  = 'P'.
        l_wa_list-text = 'Patienten'(003).
        APPEND l_wa_list TO lt_list.
        l_wa_list-key  = 'O'.
        l_wa_list-text = 'Klinische Aufträge'(006).
        APPEND l_wa_list TO lt_list.
        l_wa_list-key  = 'R'.
        l_wa_list-text = 'Anford./Positionen'(008).
        APPEND l_wa_list TO lt_list.
        l_wa_list-key  = 'S'.
        l_wa_list-text = 'Leistungen'(005).
        APPEND l_wa_list TO lt_list.
      ENDIF.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = p_fname
      values = lt_list
    EXCEPTIONS
*     id_illegal_name = 1
      OTHERS = 0.

ENDFORM.                    " fill_lb_open_nodes
*&---------------------------------------------------------------------*
*&      Form  delete_avar
*&---------------------------------------------------------------------*
*       Persönliches Layout löschen
*----------------------------------------------------------------------*
*      -->P_NWVIEW_PERS  Persönl. Daten (mit Layoutdaten)
*----------------------------------------------------------------------*
FORM delete_avar USING    p_nwview_pers  LIKE nwview_pers.

  DATA: lt_dvar     TYPE STANDARD TABLE OF ltdxkey,
        l_dvar      TYPE ltdxkey.

  CHECK NOT p_nwview_pers-reporta    IS INITIAL AND
        NOT p_nwview_pers-username   IS INITIAL AND
        NOT p_nwview_pers-avariantid IS INITIAL.

* Persönliche Anzeigevariante einer Sicht löschen
  CLEAR l_dvar. REFRESH lt_dvar.
  l_dvar-report    = p_nwview_pers-reporta.
  l_dvar-handle    = p_nwview_pers-handle.
  l_dvar-log_group = p_nwview_pers-log_group.
  l_dvar-username  = p_nwview_pers-username.
  l_dvar-variant   = p_nwview_pers-avariantid.
  l_dvar-type      = p_nwview_pers-type.
  APPEND l_dvar TO lt_dvar.
  CALL FUNCTION 'LT_VARIANTS_DELETE'
*      EXPORTING
*           I_TOOL        = 'LT'
*           I_TEXT_DELETE = 'X'
    TABLES
      t_varkey  = lt_dvar
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.
  IF sy-subrc <> 0.
*   Fehler beim Löschen
    EXIT.
  ENDIF.

ENDFORM.                    " delete_avar
*&---------------------------------------------------------------------*
*&      Form  datetime_fields_set
*&---------------------------------------------------------------------*
*       Setzen Fix-KZ für Datums- und Zeitfelder der Selektionsvariante
*----------------------------------------------------------------------*
*       --> P_VIEW      Sicht- und Selektionsvarianten-Daten
*       <-> PT_SELVAR   Selektionsvariante
*----------------------------------------------------------------------*
FORM datetime_fields_set USING VALUE(p_view)    TYPE rnviewvar
                         CHANGING    pt_selvar  TYPE tyt_selvars.

* dzt. sind mal max. 20 verschiedene Datums- bzw. Zeitfelder je
* Sichttyp-Selektionsbild vorgesehen

  DATA: l_field             TYPE fieldname,
        l_fix               TYPE fieldname,
        l_oblig             TYPE ish_on_off,                "#EC NEEDED
        l_time_value_low    TYPE sy-uzeit,
        l_time_value_high   TYPE sy-uzeit,
        l_time_value_low1   TYPE sy-uzeit,
        l_time_value_high1  TYPE sy-uzeit,
        l_time_value_low2   TYPE sy-uzeit,
        l_time_value_high2  TYPE sy-uzeit,
        l_time_value_low3   TYPE sy-uzeit,
        l_time_value_high3  TYPE sy-uzeit,
        l_time_value_low4   TYPE sy-uzeit,
        l_time_value_high4  TYPE sy-uzeit,
        l_time_value_low5   TYPE sy-uzeit,
        l_time_value_high5  TYPE sy-uzeit,
        l_time_value_low6   TYPE sy-uzeit,
        l_time_value_high6  TYPE sy-uzeit,
        l_time_value_low7   TYPE sy-uzeit,
        l_time_value_high7  TYPE sy-uzeit,
        l_time_value_low8   TYPE sy-uzeit,
        l_time_value_high8  TYPE sy-uzeit,
        l_time_value_low9   TYPE sy-uzeit,
        l_time_value_high9  TYPE sy-uzeit,
        l_time_value_low10  TYPE sy-uzeit,
        l_time_value_high10 TYPE sy-uzeit,
        l_time_value_low11  TYPE sy-uzeit,
        l_time_value_high11 TYPE sy-uzeit,
        l_time_value_low12  TYPE sy-uzeit,
        l_time_value_high12 TYPE sy-uzeit,
        l_time_value_low13  TYPE sy-uzeit,
        l_time_value_high13 TYPE sy-uzeit,
        l_time_value_low14  TYPE sy-uzeit,
        l_time_value_high14 TYPE sy-uzeit,
        l_time_value_low15  TYPE sy-uzeit,
        l_time_value_high15 TYPE sy-uzeit,
        l_time_value_low16  TYPE sy-uzeit,
        l_time_value_high16 TYPE sy-uzeit,
        l_time_value_low17  TYPE sy-uzeit,
        l_time_value_high17 TYPE sy-uzeit,
        l_time_value_low18  TYPE sy-uzeit,
        l_time_value_high18 TYPE sy-uzeit,
        l_time_value_low19  TYPE sy-uzeit,
        l_time_value_high19 TYPE sy-uzeit,
        l_time_value_low20  TYPE sy-uzeit,
        l_time_value_high20 TYPE sy-uzeit.

  FIELD-SYMBOLS: <ls_selvar>     TYPE ty_selvar.

  CLEAR: l_time_value_low,   l_time_value_high,
         l_time_value_low1,  l_time_value_high1,
         l_time_value_low2,  l_time_value_high2,
         l_time_value_low3,  l_time_value_high3,
         l_time_value_low4,  l_time_value_high4,
         l_time_value_low5,  l_time_value_high5,
         l_time_value_low6,  l_time_value_high6,
         l_time_value_low7,  l_time_value_high7,
         l_time_value_low8,  l_time_value_high8,
         l_time_value_low9,  l_time_value_high9,
         l_time_value_low10, l_time_value_high10,
         l_time_value_low11, l_time_value_high11,
         l_time_value_low12, l_time_value_high12,
         l_time_value_low13, l_time_value_high13,
         l_time_value_low14, l_time_value_high14,
         l_time_value_low15, l_time_value_high15,
         l_time_value_low16, l_time_value_high16,
         l_time_value_low17, l_time_value_high17,
         l_time_value_low18, l_time_value_high18,
         l_time_value_low19, l_time_value_high19,
         l_time_value_low20, l_time_value_high20.

  IF sy-ucomm <> 'BASSET'.                                  " MED-35028
*   (MED-35028: function 'BASE SETTINGS' - don't get values from SELVAR)

*   Zuerst mal die Werte der Zeitfelder bestimmen
    LOOP AT pt_selvar ASSIGNING <ls_selvar>.
      CASE p_view-viewtype.
        WHEN '001' OR '002' OR '003'.
*         Belegung/Zugänge/Abgänge
          CASE <ls_selvar>-selname.
            WHEN 'KEYDATE'.
            WHEN 'KEYTIME'.
              l_time_value_low  = <ls_selvar>-low.
          ENDCASE.
        WHEN '004'.
*         Anforderungen / Klinische Aufträge
          CASE <ls_selvar>-selname.
            WHEN 'GR_DATE'.
            WHEN 'GR_TIME'.
              l_time_value_low  = <ls_selvar>-low.
              l_time_value_high = <ls_selvar>-high.
          ENDCASE.
        WHEN '005'.
*         Fahraufträge
          CASE <ls_selvar>-selname.
            WHEN 'GR_DATAG'.
            WHEN 'GR_UZTAG'.
              l_time_value_low  = <ls_selvar>-low.
              l_time_value_high = <ls_selvar>-high.
          ENDCASE.
        WHEN '006'.
*         Dokumente
          CASE <ls_selvar>-selname.
            WHEN 'R_DODAT'.
            WHEN 'R_UPDAT'.
            WHEN 'R_ERDAT'.
          ENDCASE.
        WHEN '007'.
*         Leistungsstelle/Ambulanz
          CASE <ls_selvar>-selname.
            WHEN 'P_DATUMV'.
            WHEN 'P_ZEITV'.
              l_time_value_low  = <ls_selvar>-low.
              l_time_value_high = <ls_selvar>-high.
            WHEN 'P_DATUMB'.
            WHEN 'P_ZEITB'.
              l_time_value_low1  = <ls_selvar>-low.
              l_time_value_high1 = <ls_selvar>-high.
          ENDCASE.
        WHEN '008'.
*         Medizincontrolling
          CASE <ls_selvar>-selname.
            WHEN 'KEYDATE'.
            WHEN 'KEYTIME'.
              l_time_value_low  = <ls_selvar>-low.
          ENDCASE.
        WHEN '009'.
*         Fachrichtungsbezogene Belegungen
          CASE <ls_selvar>-selname.
            WHEN 'KEYDATE'.
            WHEN 'KEYTIME'.
              l_time_value_low  = <ls_selvar>-low.
          ENDCASE.
        WHEN '010'.
*         Vormerkungen
          CASE <ls_selvar>-selname.
            WHEN 'KEYDATE'.
            WHEN 'KEYTIME'.
              l_time_value_low  = <ls_selvar>-low.
          ENDCASE.
        WHEN '011'.
*         Operationen
          CASE <ls_selvar>-selname.
            WHEN 'R_DATE'.
*            WHEN 'R_DATEMT'.
            WHEN 'R_DATEOT'.
*            WHEN 'R_TIME'.
*              l_time_value_low  = <ls_selvar>-low.
          ENDCASE.
        WHEN '012'.
*         Arzneimittelverordnungen
          CASE <ls_selvar>-selname.
            WHEN 'S_ERDTF'.
            WHEN 'S_ERTMF'.
              l_time_value_low  = <ls_selvar>-low.
            WHEN 'S_UPDTF'.
            WHEN 'S_UPTMF'.
              l_time_value_low1 = <ls_selvar>-low.
            WHEN 'S_ERDTT'.
            WHEN 'S_ERTMT'.
              l_time_value_low2 = <ls_selvar>-low.
            WHEN 'S_UPDTT'.
            WHEN 'S_UPTMT'.
              l_time_value_low3 = <ls_selvar>-low.
            WHEN 'S_MOVDF'.
            WHEN 'S_MOVTF'.
              l_time_value_low4 = <ls_selvar>-low.
            WHEN 'S_MOVDT'.
            WHEN 'S_MOVTT'.
              l_time_value_low5 = <ls_selvar>-low.
            WHEN 'S_PBDADF'.
            WHEN 'S_PBTADF'.
              l_time_value_low6 = <ls_selvar>-low.
            WHEN 'S_PBDADT'.
            WHEN 'S_PBTADT'.
              l_time_value_low7 = <ls_selvar>-low.
          ENDCASE.
        WHEN '013'.
*         Arzneimittelereignisse
          CASE <ls_selvar>-selname.
            WHEN 'S_EPBDF'.
            WHEN 'S_EPBTF'.
              l_time_value_low  = <ls_selvar>-low.
            WHEN 'S_ERBDF'.
            WHEN 'S_ERBTF'.
              l_time_value_low1 = <ls_selvar>-low.
            WHEN 'S_EPBDT'.
            WHEN 'S_EPBTT'.
              l_time_value_low2 = <ls_selvar>-low.
            WHEN 'S_ERBDT'.
            WHEN 'S_ERBTT'.
              l_time_value_low3 = <ls_selvar>-low.
            WHEN 'S_EERDTF'.
            WHEN 'S_EERTMF'.
              l_time_value_low4 = <ls_selvar>-low.
            WHEN 'S_EUPDTF'.
            WHEN 'S_EUPTMF'.
              l_time_value_low5 = <ls_selvar>-low.
            WHEN 'S_EERDTT'.
            WHEN 'S_EERTMT'.
              l_time_value_low6 = <ls_selvar>-low.
            WHEN 'S_EUPDTT'.
            WHEN 'S_EUPTMT'.
              l_time_value_low7 = <ls_selvar>-low.
            WHEN 'S_ERDTF'.
            WHEN 'S_ERTMF'.
              l_time_value_low8 = <ls_selvar>-low.
            WHEN 'S_UPDTF'.
            WHEN 'S_UPTMF'.
              l_time_value_low9 = <ls_selvar>-low.
            WHEN 'S_ERDTT'.
            WHEN 'S_ERTMT'.
              l_time_value_low10 = <ls_selvar>-low.
            WHEN 'S_UPDTT'.
            WHEN 'S_UPTMT'.
              l_time_value_low11 = <ls_selvar>-low.
            WHEN 'S_MOVDF'.
            WHEN 'S_MOVTF'.
              l_time_value_low12 = <ls_selvar>-low.
            WHEN 'S_MOVDT'.
            WHEN 'S_MOVTT'.
              l_time_value_low13 = <ls_selvar>-low.
            WHEN 'P_DATEFR'.
            WHEN 'P_TIMEFR'.
              l_time_value_low14 = <ls_selvar>-low.
            WHEN 'P_DATETO'.
            WHEN 'P_TIMETO'.
              l_time_value_low15 = <ls_selvar>-low.
          ENDCASE.
        WHEN '014'.
*         Terminplanung
          CASE <ls_selvar>-selname.
            WHEN 'R_DATE'.
*            WHEN 'R_DATEMT'.
            WHEN 'R_DATEOT'.
*            WHEN 'R_TIME'.
*              l_time_value_low  = <ls_selvar>-low.
          ENDCASE.
        WHEN '016'.
*         Diktate
          CASE <ls_selvar>-selname.
            WHEN 'R_DODAT'.
            WHEN 'R_DIEDAT'.
            WHEN 'R_DATE'.
*            WHEN 'KEYTIME'.
*              l_time_value_low  = <ls_selvar>-low.
          ENDCASE.
*       START ISHFR-270 - EHPAD
        WHEN 'FR1'.
*         Abwesenheiten
          IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
            CASE <ls_selvar>-selname.
              WHEN 'KEYDATE'.
              WHEN 'KEYTIME'.
                l_time_value_low  = <ls_selvar>-low.
            ENDCASE.
          ENDIF.
*       END ISHFR-270 - EHPAD
        WHEN OTHERS.
*         other viewtypes (ID 18129)
          CASE <ls_selvar>-selname(6).
            WHEN 'R_DATE' OR 'G_DATE'.
            WHEN 'R_TIME' OR 'G_TIME'.
              l_field = <ls_selvar>-selname.
              PERFORM datetime_fields_fix USING    p_view-viewtype
                                                   l_field
                                          CHANGING l_fix
                                                   l_oblig.
              CASE l_fix.
                WHEN 'TIME_FIX'.
                  l_time_value_low   = <ls_selvar>-low.
                  l_time_value_high  = <ls_selvar>-high.
                WHEN 'TIME_FX1'.
                  l_time_value_low1  = <ls_selvar>-low.
                  l_time_value_high1 = <ls_selvar>-high.
                WHEN 'TIME_FX2'.
                  l_time_value_low2  = <ls_selvar>-low.
                  l_time_value_high2 = <ls_selvar>-high.
                WHEN 'TIME_FX3'.
                  l_time_value_low3  = <ls_selvar>-low.
                  l_time_value_high3 = <ls_selvar>-high.
                WHEN 'TIME_FX4'.
                  l_time_value_low4  = <ls_selvar>-low.
                  l_time_value_high4 = <ls_selvar>-high.
                WHEN 'TIME_FX5'.
                  l_time_value_low5  = <ls_selvar>-low.
                  l_time_value_high5 = <ls_selvar>-high.
                WHEN 'TIME_FX6'.
                  l_time_value_low6  = <ls_selvar>-low.
                  l_time_value_high6 = <ls_selvar>-high.
                WHEN 'TIME_FX7'.
                  l_time_value_low7  = <ls_selvar>-low.
                  l_time_value_high7 = <ls_selvar>-high.
                WHEN 'TIME_FX8'.
                  l_time_value_low8  = <ls_selvar>-low.
                  l_time_value_high8 = <ls_selvar>-high.
                WHEN 'TIME_FX9'.
                  l_time_value_low9  = <ls_selvar>-low.
                  l_time_value_high9 = <ls_selvar>-high.
                WHEN 'TIMEFX10'.
                  l_time_value_low10  = <ls_selvar>-low.
                  l_time_value_high10 = <ls_selvar>-high.
                WHEN 'TIMEFX11'.
                  l_time_value_low11  = <ls_selvar>-low.
                  l_time_value_high11 = <ls_selvar>-high.
                WHEN 'TIMEFX12'.
                  l_time_value_low12  = <ls_selvar>-low.
                  l_time_value_high12 = <ls_selvar>-high.
                WHEN 'TIMEFX13'.
                  l_time_value_low13  = <ls_selvar>-low.
                  l_time_value_high13 = <ls_selvar>-high.
                WHEN 'TIMEFX14'.
                  l_time_value_low14  = <ls_selvar>-low.
                  l_time_value_high14 = <ls_selvar>-high.
                WHEN 'TIMEFX15'.
                  l_time_value_low15  = <ls_selvar>-low.
                  l_time_value_high15 = <ls_selvar>-high.
                WHEN 'TIMEFX16'.
                  l_time_value_low16  = <ls_selvar>-low.
                  l_time_value_high16 = <ls_selvar>-high.
                WHEN 'TIMEFX17'.
                  l_time_value_low17  = <ls_selvar>-low.
                  l_time_value_high17 = <ls_selvar>-high.
                WHEN 'TIMEFX18'.
                  l_time_value_low18  = <ls_selvar>-low.
                  l_time_value_high18 = <ls_selvar>-high.
                WHEN 'TIMEFX19'.
                  l_time_value_low19  = <ls_selvar>-low.
                  l_time_value_high19 = <ls_selvar>-high.
                WHEN 'TIMEFX20'.
                  l_time_value_low20  = <ls_selvar>-low.
                  l_time_value_high20 = <ls_selvar>-high.
              ENDCASE.
          ENDCASE.
      ENDCASE.
    ENDLOOP.

  ENDIF.                                                    " MED-35028

* SPACE soll für den 'IS INITIAL'-Vergleich nicht drinn stehen
  IF l_time_value_low  = space.
    CLEAR l_time_value_low.
  ENDIF.
  IF l_time_value_high = space.
    CLEAR l_time_value_high.
  ENDIF.
  IF l_time_value_low1  = space. CLEAR l_time_value_low1.  ENDIF.
  IF l_time_value_high1 = space. CLEAR l_time_value_high1. ENDIF.
  IF l_time_value_low2  = space. CLEAR l_time_value_low2.  ENDIF.
  IF l_time_value_high2 = space. CLEAR l_time_value_high2. ENDIF.
  IF l_time_value_low3  = space. CLEAR l_time_value_low3.  ENDIF.
  IF l_time_value_high3 = space. CLEAR l_time_value_high3. ENDIF.
  IF l_time_value_low4  = space. CLEAR l_time_value_low4.  ENDIF.
  IF l_time_value_high4 = space. CLEAR l_time_value_high4. ENDIF.
  IF l_time_value_low5  = space. CLEAR l_time_value_low5.  ENDIF.
  IF l_time_value_high5 = space. CLEAR l_time_value_high5. ENDIF.
  IF l_time_value_low6  = space. CLEAR l_time_value_low6.  ENDIF.
  IF l_time_value_high6 = space. CLEAR l_time_value_high6. ENDIF.
  IF l_time_value_low7  = space. CLEAR l_time_value_low7.  ENDIF.
  IF l_time_value_high7 = space. CLEAR l_time_value_high7. ENDIF.
  IF l_time_value_low8  = space. CLEAR l_time_value_low8.  ENDIF.
  IF l_time_value_high8 = space. CLEAR l_time_value_high8. ENDIF.
  IF l_time_value_low9  = space. CLEAR l_time_value_low9.  ENDIF.
  IF l_time_value_high9 = space. CLEAR l_time_value_high9. ENDIF.
  IF l_time_value_low10  = space. CLEAR l_time_value_low10.  ENDIF.
  IF l_time_value_high10 = space. CLEAR l_time_value_high10. ENDIF.
  IF l_time_value_low11  = space. CLEAR l_time_value_low11.  ENDIF.
  IF l_time_value_high11 = space. CLEAR l_time_value_high11. ENDIF.
  IF l_time_value_low12  = space. CLEAR l_time_value_low12.  ENDIF.
  IF l_time_value_high12 = space. CLEAR l_time_value_high12. ENDIF.
  IF l_time_value_low13  = space. CLEAR l_time_value_low13.  ENDIF.
  IF l_time_value_high13 = space. CLEAR l_time_value_high13. ENDIF.
  IF l_time_value_low14  = space. CLEAR l_time_value_low14.  ENDIF.
  IF l_time_value_high14 = space. CLEAR l_time_value_high14. ENDIF.
  IF l_time_value_low15  = space. CLEAR l_time_value_low15.  ENDIF.
  IF l_time_value_high15 = space. CLEAR l_time_value_high15. ENDIF.
  IF l_time_value_low16  = space. CLEAR l_time_value_low16.  ENDIF.
  IF l_time_value_high16 = space. CLEAR l_time_value_high16. ENDIF.
  IF l_time_value_low17  = space. CLEAR l_time_value_low17.  ENDIF.
  IF l_time_value_high17 = space. CLEAR l_time_value_high17. ENDIF.
  IF l_time_value_low18  = space. CLEAR l_time_value_low18.  ENDIF.
  IF l_time_value_high18 = space. CLEAR l_time_value_high18. ENDIF.
  IF l_time_value_low19  = space. CLEAR l_time_value_low19.  ENDIF.
  IF l_time_value_high19 = space. CLEAR l_time_value_high19. ENDIF.
  IF l_time_value_low20  = space. CLEAR l_time_value_low20.  ENDIF.
  IF l_time_value_high20 = space. CLEAR l_time_value_high20. ENDIF.

* Und dann das Fix-KZ setzen
* Datumsfelder: immer auf OFF (d.h. soll immer aktualisiert werden)
* Zeitfelder: wenn befüllt auf ON, wenn leer auf OFF
  LOOP AT pt_selvar ASSIGNING <ls_selvar>.
    CASE <ls_selvar>-selname.
      WHEN 'DATE_FIX' OR
           'DATE_FX1' OR 'DATE_FX2' OR 'DATE_FX3' OR
           'DATE_FX4' OR 'DATE_FX5' OR 'DATE_FX6' OR
           'DATE_FX7' OR 'DATE_FX8' OR 'DATE_FX9' OR
           'DATEFX10' OR 'DATEFX11' OR 'DATEFX12' OR
           'DATEFX13' OR 'DATEFX14' OR 'DATEFX15' OR
           'DATEFX16' OR 'DATEFX17' OR 'DATEFX18' OR
           'DATEFX19' OR 'DATEFX20'.
        <ls_selvar>-low = off.
      WHEN 'TIME_FIX'.
        IF l_time_value_low  IS INITIAL AND
           l_time_value_high IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX1'.
        IF l_time_value_low1  IS INITIAL AND
           l_time_value_high1 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX2'.
        IF l_time_value_low2  IS INITIAL AND
           l_time_value_high2 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX3'.
        IF l_time_value_low3  IS INITIAL AND
           l_time_value_high3 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX4'.
        IF l_time_value_low4  IS INITIAL AND
           l_time_value_high4 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX5'.
        IF l_time_value_low5  IS INITIAL AND
           l_time_value_high5 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX6'.
        IF l_time_value_low6  IS INITIAL AND
           l_time_value_high6 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX7'.
        IF l_time_value_low7  IS INITIAL AND
           l_time_value_high7 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX8'.
        IF l_time_value_low8  IS INITIAL AND
           l_time_value_high8 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIME_FX9'.
        IF l_time_value_low9  IS INITIAL AND
           l_time_value_high9 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX10'.
        IF l_time_value_low10  IS INITIAL AND
           l_time_value_high10 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX11'.
        IF l_time_value_low11  IS INITIAL AND
           l_time_value_high11 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX12'.
        IF l_time_value_low12  IS INITIAL AND
           l_time_value_high12 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX13'.
        IF l_time_value_low13  IS INITIAL AND
           l_time_value_high13 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX14'.
        IF l_time_value_low14  IS INITIAL AND
           l_time_value_high14 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX15'.
        IF l_time_value_low15  IS INITIAL AND
           l_time_value_high15 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX16'.
        IF l_time_value_low16  IS INITIAL AND
           l_time_value_high16 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX17'.
        IF l_time_value_low17  IS INITIAL AND
           l_time_value_high17 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX18'.
        IF l_time_value_low18  IS INITIAL AND
           l_time_value_high18 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX19'.
        IF l_time_value_low19  IS INITIAL AND
           l_time_value_high19 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN 'TIMEFX20'.
        IF l_time_value_low20  IS INITIAL AND
           l_time_value_high20 IS INITIAL OR
           p_view-svariantid IS INITIAL AND NOT
           ( l_time_value_low  = '000000' AND
           l_time_value_high = '240000' ) .                 " ID 10166
          <ls_selvar>-low = off.
        ELSE.
          <ls_selvar>-low = on.
        ENDIF.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
*    MODIFY pt_selvar FROM <ls_selvar>.
  ENDLOOP.

ENDFORM.                    " datetime_fields_set
*&---------------------------------------------------------------------*
*&      Form  datetime_fields_get
*&---------------------------------------------------------------------*
*       Datums- und Zeitfelder nicht aus dem Puffer nehmen, sondern
*       erneut aus der Selektionsvariante lesen, wenn das Fix-KZ auf
*       OFF gesetzt ist
*----------------------------------------------------------------------*
*      --> P_VIEW       Sicht- und Selektionsvarianten-Daten
*      --> P_CONV_FUNC  Datenkonvertierung durchführen ON/OFF
*      --> P_SELPAR_GET Selektionsattribute ermitteln ON/OFF
*      <-> PT_SELVAR    Selektionsvariante
*      <-- PT_SELPARAM  Selektionsattribute
*----------------------------------------------------------------------*
FORM datetime_fields_get USING    VALUE(p_view)       TYPE rnviewvar
                                  VALUE(p_conv_func)  TYPE c
                                  VALUE(p_selpar_get) TYPE ish_on_off
                         CHANGING pt_selvar           TYPE tyt_selvars
                                  pt_selparam         TYPE rsti_t_van.

* dzt. sind mal max. 20 verschiedene Datums- bzw. Zeitfelder je
* Sichttyp-Selektionsbild vorgesehen

  DATA: lt_rsparams      TYPE tyt_selvars,
        l_rsparams       LIKE LINE OF lt_rsparams,
        lt_rsparams_conv LIKE rsparams OCCURS 0 WITH HEADER LINE,
        l_time_fix       TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix       TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix1      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix1      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix2      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix2      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix3      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix3      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix4      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix4      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix5      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix5      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix6      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix6      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix7      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix7      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix8      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix8      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix9      TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix9      TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix10     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix10     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix11     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix11     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix12     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix12     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix13     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix13     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix14     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix14     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix15     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix15     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix16     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix16     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix17     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix17     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix18     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix18     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix19     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix19     TYPE ish_on_off,                   "#EC NEEDED
        l_time_fix20     TYPE ish_on_off,                   "#EC NEEDED
        l_date_fix20     TYPE ish_on_off.                   "#EC NEEDED
  DATA: len_low          TYPE i,
        len_high         TYPE i,
        l_field          TYPE fieldname,
        l_fix            TYPE fieldname,
        l_oblig          TYPE ish_on_off,
        l_obligatory     TYPE ish_on_off.
  DATA: l_dynamic        TYPE ish_on_off.
  DATA: ls_selparam      LIKE LINE OF pt_selparam.
  DATA: l_rc             LIKE sy-subrc. ""MED-46958,AM

  FIELD-SYMBOLS: <ls_selvar>  TYPE ty_selvar.

  CLEAR: l_time_fix,   l_date_fix,   l_obligatory,
         l_time_fix1,  l_date_fix1,  l_time_fix2,  l_date_fix2,
         l_time_fix3,  l_date_fix3,  l_time_fix4,  l_date_fix4,
         l_time_fix5,  l_date_fix5,  l_time_fix6,  l_date_fix6,
         l_time_fix7,  l_date_fix7,  l_time_fix8,  l_date_fix8,
         l_time_fix9,  l_date_fix9,  l_time_fix10, l_date_fix10,
         l_time_fix11, l_date_fix11, l_time_fix12, l_date_fix12,
         l_time_fix13, l_date_fix13, l_time_fix14, l_date_fix14,
         l_time_fix15, l_date_fix15, l_time_fix16, l_date_fix16,
         l_time_fix17, l_date_fix17, l_time_fix18, l_date_fix18,
         l_time_fix19, l_date_fix19, l_time_fix20, l_date_fix20.

  CLEAR   l_rsparams.
  REFRESH lt_rsparams.

* Selektionsvariante (und ev. Selektionsattribute) lesen
  IF NOT p_view-reports    IS INITIAL AND
     NOT p_view-svariantid IS INITIAL.
    IF p_selpar_get = off.
      CALL FUNCTION 'RS_VARIANT_CONTENTS'
        EXPORTING
          report               = p_view-reports
          variant              = p_view-svariantid
*         MOVE_OR_WRITE        = 'W'
*         NO_IMPORT            = ' '
*       IMPORTING
*         SP                   =
        TABLES
          valutab              = lt_rsparams
        EXCEPTIONS
          variant_non_existent = 1
          variant_obsolete     = 2
          OTHERS               = 3.                         "#EC *
      IF sy-subrc <> 0.
        CLEAR l_rsparams.                                   "dummy
      ENDIF.
    ELSE.
      PERFORM get_sel_var_and_par USING    p_view
                                  CHANGING lt_rsparams
                                           pt_selparam
                                           l_rc. ""MED-46958,AM
    ENDIF.
    SORT lt_rsparams BY selname.
  ENDIF.
* Und nun, falls das Fix-KZ auf OFF ist, den Wert für Datums- und
* Zeitfelder aus dem Puffer mit dem Wert aus der Selektionsvariante
* überschreiben
* ... also zuerst die Fix-KZ bestimmen
  LOOP AT pt_selvar ASSIGNING <ls_selvar>.
    CASE <ls_selvar>-selname.
      WHEN 'DATE_FIX'.
        l_date_fix = <ls_selvar>-low.
      WHEN 'TIME_FIX'.
        l_time_fix = <ls_selvar>-low.
      WHEN 'DATE_FX1'.
        l_date_fix1 = <ls_selvar>-low.
      WHEN 'TIME_FX1'.
        l_time_fix1 = <ls_selvar>-low.
      WHEN 'DATE_FX2'.
        l_date_fix2 = <ls_selvar>-low.
      WHEN 'TIME_FX2'.
        l_time_fix2 = <ls_selvar>-low.
      WHEN 'DATE_FX3'.
        l_date_fix3 = <ls_selvar>-low.
      WHEN 'TIME_FX3'.
        l_time_fix3 = <ls_selvar>-low.
      WHEN 'DATE_FX4'.
        l_date_fix4 = <ls_selvar>-low.
      WHEN 'TIME_FX4'.
        l_time_fix4 = <ls_selvar>-low.
      WHEN 'DATE_FX5'.
        l_date_fix5 = <ls_selvar>-low.
      WHEN 'TIME_FX5'.
        l_time_fix5 = <ls_selvar>-low.
      WHEN 'DATE_FX6'.
        l_date_fix6 = <ls_selvar>-low.
      WHEN 'TIME_FX6'.
        l_time_fix6 = <ls_selvar>-low.
      WHEN 'DATE_FX7'.
        l_date_fix7 = <ls_selvar>-low.
      WHEN 'TIME_FX7'.
        l_time_fix7 = <ls_selvar>-low.
      WHEN 'DATE_FX8'.
        l_date_fix8 = <ls_selvar>-low.
      WHEN 'TIME_FX8'.
        l_time_fix8 = <ls_selvar>-low.
      WHEN 'DATE_FX9'.
        l_date_fix9 = <ls_selvar>-low.
      WHEN 'TIME_FX9'.
        l_time_fix9 = <ls_selvar>-low.
      WHEN 'DATEFX10'.
        l_date_fix10 = <ls_selvar>-low.
      WHEN 'TIMEFX10'.
        l_time_fix10 = <ls_selvar>-low.
      WHEN 'DATEFX11'.
        l_date_fix11 = <ls_selvar>-low.
      WHEN 'TIMEFX11'.
        l_time_fix11 = <ls_selvar>-low.
      WHEN 'DATEFX12'.
        l_date_fix12 = <ls_selvar>-low.
      WHEN 'TIMEFX12'.
        l_time_fix12 = <ls_selvar>-low.
      WHEN 'DATEFX13'.
        l_date_fix13 = <ls_selvar>-low.
      WHEN 'TIMEFX13'.
        l_time_fix13 = <ls_selvar>-low.
      WHEN 'DATEFX14'.
        l_date_fix14 = <ls_selvar>-low.
      WHEN 'TIMEFX14'.
        l_time_fix14 = <ls_selvar>-low.
      WHEN 'DATEFX15'.
        l_date_fix15 = <ls_selvar>-low.
      WHEN 'TIMEFX15'.
        l_time_fix15 = <ls_selvar>-low.
      WHEN 'DATEFX16'.
        l_date_fix6 = <ls_selvar>-low.
      WHEN 'TIMEFX16'.
        l_time_fix16 = <ls_selvar>-low.
      WHEN 'DATEFX17'.
        l_date_fix17 = <ls_selvar>-low.
      WHEN 'TIMEFX17'.
        l_time_fix17 = <ls_selvar>-low.
      WHEN 'DATEFX18'.
        l_date_fix18 = <ls_selvar>-low.
      WHEN 'TIMEFX18'.
        l_time_fix18 = <ls_selvar>-low.
      WHEN 'DATEFX19'.
        l_date_fix19 = <ls_selvar>-low.
      WHEN 'TIMEFX19'.
        l_time_fix19 = <ls_selvar>-low.
      WHEN 'DATEFX20'.
        l_date_fix20 = <ls_selvar>-low.
      WHEN 'TIMEFX20'.
        l_time_fix20 = <ls_selvar>-low.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
  ENDLOOP.

* MED-35028: function 'BASE SETTINGS' - get values from SELVAR
  IF sy-ucomm = 'BASSET'.
    CLEAR: l_time_fix,   l_date_fix,   l_obligatory,
           l_time_fix1,  l_date_fix1,  l_time_fix2,  l_date_fix2,
           l_time_fix3,  l_date_fix3,  l_time_fix4,  l_date_fix4,
           l_time_fix5,  l_date_fix5,  l_time_fix6,  l_date_fix6,
           l_time_fix7,  l_date_fix7,  l_time_fix8,  l_date_fix8,
           l_time_fix9,  l_date_fix9,  l_time_fix10, l_date_fix10,
           l_time_fix11, l_date_fix11, l_time_fix12, l_date_fix12,
           l_time_fix13, l_date_fix13, l_time_fix14, l_date_fix14,
           l_time_fix15, l_date_fix15, l_time_fix16, l_date_fix16,
           l_time_fix17, l_date_fix17, l_time_fix18, l_date_fix18,
           l_time_fix19, l_date_fix19, l_time_fix20, l_date_fix20.
  ENDIF.

* ... und nun anhand des Fix-KZ den Wert ev. überschreiben
  LOOP AT pt_selvar ASSIGNING <ls_selvar>.

*   MED-35028: use the dynamic time calculation if it is defined in the
*              selection variant (except after function 'selection change',
*              in that case the time manually inserted should be used)
    l_dynamic = off.
*    IF sy-ucomm <> 'APPLY'.                          "CDuerr, MED-84588
    IF sy-ucomm <> 'APPLY' AND sy-ucomm <> 'ENTR'.    "CDuerr, MED-84588
      CLEAR ls_selparam.
      READ TABLE pt_selparam INTO ls_selparam WITH KEY name = <ls_selvar>-selname.
      IF sy-subrc = 0 AND ls_selparam-vname IS NOT INITIAL.
        l_dynamic = on.
      ENDIF.
    ENDIF.

    CASE p_view-viewtype.
      WHEN '001' OR '002' OR '003'.
*       Belegung/Zugänge/Abgänge
        CASE <ls_selvar>-selname.
          WHEN 'KEYDATE'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN 'KEYTIME'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '004'.
*       Anforderungen / Klinische Aufträge
        CASE <ls_selvar>-selname.
          WHEN 'GR_DATE'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
            IF <ls_selvar>-low IS INITIAL.                  " ID 13457
              <ls_selvar>-low = sy-datum.                   " ID 13457
            ENDIF.                                          " ID 13457
          WHEN 'GR_TIME'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '005'.
*       Fahraufträge
        CASE <ls_selvar>-selname.
          WHEN 'GR_DATAG'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN 'GR_UZTAG'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '006'.
*       Dokumente
        CASE <ls_selvar>-selname.
          WHEN 'R_DODAT'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'R_UPDAT'.
            IF l_date_fix1 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'R_ERDAT'.
            IF l_date_fix2 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '007'.
*       Leistungsstelle/Ambulanz
        CASE <ls_selvar>-selname.
          WHEN 'P_DATUMV'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN 'P_ZEITV'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'P_DATUMB'.
            IF l_date_fix1 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'P_ZEITB'.
            IF l_time_fix1 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '008'.
*       Medizincontrolling
        CASE <ls_selvar>-selname.
          WHEN 'KEYDATE'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN 'KEYTIME'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '009'.
*       Fachrichtungsbezogene Belegungen
        CASE <ls_selvar>-selname.
          WHEN 'KEYDATE'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN 'KEYTIME'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '010'.
*       Vormerkungen
        CASE <ls_selvar>-selname.
          WHEN 'KEYDATE'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN 'KEYTIME'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '011'.
*       Operationen
        CASE <ls_selvar>-selname.
          WHEN 'R_DATE'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
*          WHEN 'R_DATEMT'.
*            IF l_date_fix1 = on.
*              CONTINUE.           " Wert aus Puffer belassen
*            ENDIF.
*            l_obligatory = off.    " KEIN Mußfeld
          WHEN 'R_DATEOT'.
            IF l_date_fix2 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.    " KEIN Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '012'.
*       Arzneimittelverordnungen
        CASE <ls_selvar>-selname.
          WHEN 'S_ERDTF'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERTMF'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_UPDTF'.
            IF l_date_fix1 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_UPTMF'.
            IF l_time_fix1 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERDTT'.
            IF l_date_fix2 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERTMT'.
            IF l_time_fix2 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_UPDTT'.
            IF l_date_fix3 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_UPTMT'.
            IF l_time_fix3 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_MOVDF'.
            IF l_date_fix4 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_MOVTF'.
            IF l_time_fix4 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_MOVDT'.
            IF l_date_fix5 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_MOVTT'.
            IF l_time_fix5 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_PBDADF'.
            IF l_date_fix6 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_PBTADF'.
            IF l_time_fix6 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_PBDADT'.
            IF l_date_fix7 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_PBTADT'.
            IF l_time_fix7 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '013'.
*       Arzneimittelereignisse
        CASE <ls_selvar>-selname.
          WHEN 'S_EPBDF'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EPBTF'.
            IF l_time_fix = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERBDF'.
            IF l_date_fix1 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERBTF'.
            IF l_time_fix1 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EPBDT'.
            IF l_date_fix2 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EPBTT'.
            IF l_time_fix2 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERBDT'.
            IF l_date_fix3 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERBTT'.
            IF l_time_fix3 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EERDTF'.
            IF l_date_fix4 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EERTMF'.
            IF l_time_fix4 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EUPDTF'.
            IF l_date_fix5 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EUPTMF'.
            IF l_time_fix5 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EERDTT'.
            IF l_date_fix6 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EERTMT'.
            IF l_time_fix6 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EUPDTT'.
            IF l_date_fix7 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_EUPTMT'.
            IF l_time_fix7 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERDTF'.
            IF l_date_fix8 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERTMF'.
            IF l_time_fix8 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_UPDTF'.
            IF l_date_fix9 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_UPTMF'.
            IF l_time_fix9 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERDTT'.
            IF l_date_fix10 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_ERTMT'.
            IF l_time_fix10 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_UPDTT'.
            IF l_date_fix11 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_UPTMT'.
            IF l_time_fix11 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_MOVDF'.
            IF l_date_fix12 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_MOVTF'.
            IF l_time_fix12 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_MOVDT'.
            IF l_date_fix13 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'S_MOVTT'.
            IF l_time_fix13 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'P_DATEFR'.
            IF l_date_fix14 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'P_TIMEFR'.
            IF l_time_fix14 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'P_DATETO'.
            IF l_date_fix15 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'P_TIMETO'.
            IF l_time_fix15 = on AND l_dynamic = off.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '014'.
*       Terminplanung
        CASE <ls_selvar>-selname.
          WHEN 'R_DATE'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
*          WHEN 'R_DATEMT'.
*            IF l_date_fix1 = on.
*              CONTINUE.           " Wert aus Puffer belassen
*            ENDIF.
*            l_obligatory = off.    " KEIN Mußfeld
          WHEN 'R_DATEOT'.
            IF l_date_fix2 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.    " KEIN Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '016'.
*       Diktate
        CASE <ls_selvar>-selname.
          WHEN 'R_DODAT'.
            IF l_date_fix1 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'R_DIEDAT'.
            IF l_date_fix2 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN 'R_DATE'.
            IF l_date_fix3 = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = off.   " KEIN Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      WHEN '017'.
*       OP-Disposition
        CASE <ls_selvar>-selname.
          WHEN 'R_DATE'.
            IF l_date_fix = on.
              CONTINUE.           " Wert aus Puffer belassen
            ENDIF.
            l_obligatory = on.    " Mußfeld
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
*     START ISHFR-270 - EHPAD
      WHEN 'FR1'.
*       Abwesenheiten
        IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
          CASE <ls_selvar>-selname.
            WHEN 'KEYDATE'.
              IF l_date_fix = on.
                CONTINUE.           " Wert aus Puffer belassen
              ENDIF.
              l_obligatory = on.    " Mußfeld
            WHEN 'KEYTIME'.
              IF l_time_fix = on AND l_dynamic = off.
                CONTINUE.           " Wert aus Puffer belassen
              ENDIF.
              l_obligatory = on.    " Mußfeld
            WHEN OTHERS.
              CONTINUE.
          ENDCASE.
        ENDIF.
*     END ISHFR-270 - EHPAD
      WHEN OTHERS.
*       other viewtypes (ID 18129)
        CASE <ls_selvar>-selname(6).
          WHEN 'R_DATE' OR 'G_DATE'.
            l_field = <ls_selvar>-selname.
            PERFORM datetime_fields_fix USING    p_view-viewtype
                                                 l_field
                                        CHANGING l_fix
                                                 l_oblig.
            CASE l_fix.
              WHEN 'DATE_FIX'.
                IF l_date_fix = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX1'.
                IF l_date_fix1 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX2'.
                IF l_date_fix2 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX3'.
                IF l_date_fix3 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX4'.
                IF l_date_fix4 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX5'.
                IF l_date_fix5 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX6'.
                IF l_date_fix6 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX7'.
                IF l_date_fix7 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX8'.
                IF l_date_fix8 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATE_FX9'.
                IF l_date_fix9 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX10'.
                IF l_date_fix10 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX11'.
                IF l_date_fix11 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX12'.
                IF l_date_fix12 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX13'.
                IF l_date_fix13 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX14'.
                IF l_date_fix14 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX15'.
                IF l_date_fix15 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX16'.
                IF l_date_fix16 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX17'.
                IF l_date_fix17 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX18'.
                IF l_date_fix18 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX19'.
                IF l_date_fix19 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'DATEFX20'.
                IF l_date_fix20 = on.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN OTHERS.
                CONTINUE.
            ENDCASE.
            l_obligatory = l_oblig.     " Mußfeld (ON/OFF)
          WHEN 'R_TIME' OR 'G_TIME'.
            l_field = <ls_selvar>-selname.
            PERFORM datetime_fields_fix USING    p_view-viewtype
                                                 l_field
                                        CHANGING l_fix
                                                 l_oblig.
            CASE l_fix.
              WHEN 'TIME_FIX'.
                IF l_time_fix = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX1'.
                IF l_time_fix1 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX2'.
                IF l_time_fix2 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX3'.
                IF l_time_fix3 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX4'.
                IF l_time_fix4 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX5'.
                IF l_time_fix5 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX6'.
                IF l_time_fix6 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX7'.
                IF l_time_fix7 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX8'.
                IF l_time_fix8 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIME_FX9'.
                IF l_time_fix9 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX10'.
                IF l_time_fix10 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX11'.
                IF l_time_fix11 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX12'.
                IF l_time_fix12 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX13'.
                IF l_time_fix13 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX14'.
                IF l_time_fix14 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX15'.
                IF l_time_fix15 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX16'.
                IF l_time_fix16 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX17'.
                IF l_time_fix17 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX18'.
                IF l_time_fix18 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX19'.
                IF l_time_fix19 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
              WHEN 'TIMEFX20'.
                IF l_time_fix20 = on AND l_dynamic = off.
                  CONTINUE.             " Wert aus Puffer belassen
                ENDIF.
            ENDCASE.
            l_obligatory = l_oblig.     " Mußfeld (ON/OFF)
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
    ENDCASE.
*   Mit Wert aus Selektionsvariante überschreiben
    READ TABLE lt_rsparams INTO l_rsparams
                           WITH KEY selname = <ls_selvar>-selname
                                              BINARY SEARCH.
    IF sy-subrc = 0.
*     Eintrag zuvor konvertieren
      REFRESH lt_rsparams_conv.
      APPEND l_rsparams TO lt_rsparams_conv.
      PERFORM convert_selvar TABLES lt_rsparams_conv
                             USING  p_conv_func 'S'
                                    p_view.
      READ TABLE lt_rsparams_conv INDEX 1.
      IF l_obligatory = on AND lt_rsparams_conv-low IS INITIAL.
*       Wenn das entsprechende Feld ein Mußfeld ist, in der
*       Selektionsvariante aber nichts eingetragen ist, dann den
*       Systemzeitpunkt reinstellen!
        len_low  = strlen( <ls_selvar>-low ).
        len_high = strlen( <ls_selvar>-high ).
        IF len_low = 6 AND NOT <ls_selvar>-low IS INITIAL.
          IF <ls_selvar>-kind = 'S'.                        " ID 14309
            <ls_selvar>-low = '000000'.                     " ID 14309
          ELSE.                                             " ID 14309
            <ls_selvar>-low = sy-uzeit.
          ENDIF.                                            " ID 14309
        ENDIF.
        IF len_low = 8 AND NOT <ls_selvar>-low IS INITIAL.
          <ls_selvar>-low = sy-datum.
        ENDIF.
        IF len_high = 6 AND NOT <ls_selvar>-high IS INITIAL.
          IF <ls_selvar>-kind = 'S'.                        " ID 14309
            <ls_selvar>-high = '240000'.                    " ID 14309
          ELSE.                                             " ID 14309
            <ls_selvar>-high = sy-uzeit.
          ENDIF.                                            " ID 14309
        ENDIF.
        IF len_high = 8 AND NOT <ls_selvar>-high IS INITIAL.
          <ls_selvar>-high = sy-datum.
        ENDIF.
      ELSE.
        <ls_selvar>-low  = lt_rsparams_conv-low.
        <ls_selvar>-high = lt_rsparams_conv-high.
      ENDIF.
    ELSE.
*     ... bzw. wenn keine Sel.var. vorhanden, dann Systemzeitpunkt
      IF l_obligatory = on.
*       ... aber nur wenn das entsprechende Feld ein Mußfeld ist
        len_low  = strlen( <ls_selvar>-low ).
        len_high = strlen( <ls_selvar>-high ).
        IF len_low = 6 AND NOT <ls_selvar>-low IS INITIAL.
          <ls_selvar>-low = sy-uzeit.
        ENDIF.
        IF len_low = 8 AND NOT <ls_selvar>-low IS INITIAL.
          <ls_selvar>-low = sy-datum.
        ENDIF.
        IF len_high = 6 AND NOT <ls_selvar>-high IS INITIAL.
          <ls_selvar>-high = sy-uzeit.
        ENDIF.
        IF len_high = 8 AND NOT <ls_selvar>-high IS INITIAL.
          <ls_selvar>-high = sy-datum.
        ENDIF.
      ENDIF.
    ENDIF.
*    MODIFY pt_selvar FROM <ls_selvar>.
  ENDLOOP.

ENDFORM.                    " datetime_fields_get
*&---------------------------------------------------------------------*
*&      Form  get_sel_var_and_par
*&---------------------------------------------------------------------*
*       Get selection variant and parameter              ID 9860/11341
*----------------------------------------------------------------------*
*      --> P_VIEW       view data
*      <-- PT_SELVAR    selection variant
*      <-- PT_SELPARAM  selection parameter
*----------------------------------------------------------------------*
FORM get_sel_var_and_par USING    VALUE(p_view)       TYPE rnviewvar
                         CHANGING pt_selvar           TYPE tyt_selvars
                                  pt_selparam         TYPE rsti_t_van
                                  e_rc                LIKE sy-subrc. "MED-46958,AM

  DATA: lt_params         TYPE TABLE OF vanz,
        lt_selop          TYPE TABLE OF vanz,
        lt_params_nonv    TYPE TABLE OF vanz,
        lt_selop_nonv     TYPE TABLE OF vanz.

  REFRESH: lt_params, lt_selop, lt_params_nonv, lt_selop_nonv.

  CHECK NOT p_view-svariantid IS INITIAL AND
        NOT p_view-reports    IS INITIAL.

* Selektionsvariante und Variantenattribute auslesen
  CALL FUNCTION 'RS_VARIANT_CONTENTS'
    EXPORTING
      report               = p_view-reports
      variant              = p_view-svariantid
    TABLES
      l_params             = lt_params
      l_params_nonv        = lt_params_nonv
      l_selop              = lt_selop
      l_selop_nonv         = lt_selop_nonv
      valutab              = pt_selvar
    EXCEPTIONS
      variant_non_existent = 1
      variant_obsolete     = 2
      OTHERS               = 3.
  IF sy-subrc <> 0.
    "MED-46958,AM
    e_rc = sy-subrc.
    "END"MED-46958,AM
  ELSE.
    APPEND LINES OF lt_selop TO lt_params.
*   vollständig unsichtbare Felder rauslöschen
    DELETE lt_params_nonv WHERE invisible = 'N'.
    DELETE lt_selop_nonv  WHERE invisible = 'N'.
*   ausgeblendete Felder auch übergeben
    APPEND LINES OF lt_params_nonv TO lt_params.
    APPEND LINES OF lt_selop_nonv  TO lt_params.
    pt_selparam[] = lt_params[].
  ENDIF.

ENDFORM.                    " get_sel_var_and_par

*&---------------------------------------------------------------------*
*&      Form  GET_VIEWTYPE_TEXTS
*&---------------------------------------------------------------------*
*       Bezeichnungen der Sichttypen ermitteln
*       (auch bzw. vor allem externe Aufrufe !!!)
*----------------------------------------------------------------------*
*      --> P_PLACETYPE  Arbeitsumfeldtyp
*      --> P_CHECK_MED  Prüfung auf IS-H*MED aktiv
*                       ON  = nur Bezeichnung für IS-H Sichttypen
*                             ermitteln, wenn IS-H*MED inaktiv ist
*                       OFF = alle Bezeichnungen ermitteln
*      <-- PT_LIST      Bezeichnungen der Sichttypen
*----------------------------------------------------------------------*
FORM get_viewtype_texts
                  USING    VALUE(p_placetype) LIKE nwplace-wplacetype
                           VALUE(p_check_med) TYPE ish_on_off
                  CHANGING pt_list            TYPE vrm_values.

  DATA: l_wa_list     LIKE LINE OF pt_list.
  DATA: l_ishmed_used LIKE true.
  DATA: lt_dom_val    TYPE TABLE OF dd07v,
        ls_dom_val    TYPE dd07v,
        ls_list       TYPE vrm_value,
        ls_list_old   TYPE vrm_value,
        l_viewtype    TYPE nviewtype,
        l_acm_active  TYPE ish_on_off,                      " MED-31201
        l_flag        TYPE c.
  DATA: lt_viewvar         TYPE TABLE OF nwviewvar,
        ls_viewvar         LIKE LINE OF lt_viewvar,
        lt_range_viewvar   TYPE RANGE OF nwviewvar-viewtype,
        ls_range_viewvar   LIKE LINE OF lt_range_viewvar.

  REFRESH pt_list.

* maybe the requested texts are in buffer already?
  IF p_check_med = on.
    IF NOT gt_viewtype_list_ish[] IS INITIAL.
      pt_list[] = gt_viewtype_list_ish[].
      EXIT.
    ENDIF.
  ELSE.
    IF NOT gt_viewtype_list_all[] IS INITIAL.
      pt_list[] = gt_viewtype_list_all[].
      EXIT.
    ENDIF.
  ENDIF.

* falls IS-H*MED inaktiv ist, dann bestimmte Sichttypen NICHT
* berücksichtigen
  PERFORM check_ishmed CHANGING l_ishmed_used.

  CASE p_placetype.
    WHEN '001'.                        " Workplace
*     ---
      CLEAR l_wa_list.
      l_wa_list-key = '001'.           " Belegungen
      PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '001'
                                                    l_wa_list-text.
      APPEND l_wa_list TO pt_list.
*     ---
      CLEAR l_wa_list.
      l_wa_list-key = '002'.           " Zugänge
      PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '002'
                                                    l_wa_list-text.
      APPEND l_wa_list TO pt_list.
*     ---
      CLEAR l_wa_list.
      l_wa_list-key = '003'.           " Abgänge
      PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '003'
                                                    l_wa_list-text.
      APPEND l_wa_list TO pt_list.
*     ---
      CLEAR l_wa_list.
      l_wa_list-key = '007'.           " Leistungsstelle/Ambulanz
      PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '007'
                                                    l_wa_list-text.
      APPEND l_wa_list TO pt_list.
*     ---
      CLEAR l_wa_list.
      l_wa_list-key = '008'.           " Medizincontrolling
      PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '008'
                                                    l_wa_list-text.
      APPEND l_wa_list TO pt_list.
*     ---
      CLEAR l_wa_list.
      l_wa_list-key = '009'.           " Belegungsmerkmale
      PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '009'
                                                    l_wa_list-text.
      APPEND l_wa_list TO pt_list.
*     ---
      CLEAR l_wa_list.
      l_wa_list-key = '010'.           " Vormerkungen
      PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '010'
                                                    l_wa_list-text.
      APPEND l_wa_list TO pt_list.
*     --- (MED-31201)
*     SAP ACM - active? (MED-31201)
      CALL FUNCTION 'ISH_OUTPATIENT_ACTIVE'
        IMPORTING
          e_active = l_acm_active.
      IF p_check_med = off OR
         ( p_check_med = on AND l_ishmed_used = true ) OR
         l_acm_active  = on.
        CLEAR l_wa_list.
        l_wa_list-key = '006'.           " Dokumente
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '006'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
      ENDIF.
*     ---
      IF p_check_med = off OR
         ( p_check_med = on AND l_ishmed_used = true ).
        CLEAR l_wa_list.
        l_wa_list-key = '004'.           " Klinische Aufträge
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '004'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
*       ---
        CLEAR l_wa_list.
        l_wa_list-key = '005'.           " Fahraufträge
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '005'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
**       --- REM MED-31201
*        CLEAR l_wa_list.
*        l_wa_list-key = '006'.           " Dokumente
*        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '006'
*                                                      l_wa_list-text.
*        APPEND l_wa_list TO pt_list.
*       ---
        CLEAR l_wa_list.
        l_wa_list-key = '011'.           " Operationen
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '011'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
*       ---
        CLEAR l_wa_list.
        l_wa_list-key = '012'.           " Arzneimittelverordnungen
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '012'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
*       ---
        CLEAR l_wa_list.
        l_wa_list-key = '013'.           " Arzneimittelereignisse
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '013'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
*       ---
        CLEAR l_wa_list.
        l_wa_list-key = '014'.           " Terminplanung
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '014'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
*       ---
        CLEAR l_wa_list.
        l_wa_list-key = '016'.           " Diktate
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' '016'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
      ENDIF.
*     START ISHFR-270 - EHPAD
      IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
        CLEAR l_wa_list.
        l_wa_list-key = 'FR1'.           " Abwesenheiten
        PERFORM get_domain_value_desc(sapmn1pa) USING 'NVIEWTYPE' 'FR1'
                                                      l_wa_list-text.
        APPEND l_wa_list TO pt_list.
      ENDIF.
*     END ISHFR-270 - EHPAD
*     ---
*     other viewtypes (ID 18129)
      PERFORM get_domain_values IN PROGRAM sapmn1pa
                                    TABLES lt_dom_val
                                     USING 'NVIEWTYPE'.
      SELECT * FROM nwviewvar INTO TABLE lt_viewvar.        "#EC *
      LOOP AT lt_viewvar INTO ls_viewvar.
        CLEAR ls_range_viewvar.
        ls_range_viewvar-sign   = 'I'.
        ls_range_viewvar-option = 'EQ'.
        ls_range_viewvar-low    = ls_viewvar-viewtype.
        APPEND ls_range_viewvar TO lt_range_viewvar.
      ENDLOOP.
      IF lt_range_viewvar[] IS NOT INITIAL.
        LOOP AT lt_dom_val INTO ls_dom_val
                WHERE domvalue_l BETWEEN '015' AND '099'
                   OR domvalue_l IN lt_range_viewvar.
          CLEAR l_wa_list.
          l_wa_list-key = ls_dom_val-domvalue_l.
          PERFORM get_domain_value_desc(sapmn1pa)
            USING 'NVIEWTYPE' ls_dom_val-domvalue_l l_wa_list-text.
          APPEND l_wa_list TO pt_list.
        ENDLOOP.
      ELSE.
        LOOP AT lt_dom_val INTO ls_dom_val
                WHERE domvalue_l BETWEEN '015' AND '099'.
          CLEAR l_wa_list.
          l_wa_list-key = ls_dom_val-domvalue_l.
          PERFORM get_domain_value_desc(sapmn1pa)
            USING 'NVIEWTYPE' ls_dom_val-domvalue_l l_wa_list-text.
          APPEND l_wa_list TO pt_list.
        ENDLOOP.
      ENDIF.
    WHEN OTHERS.                       " momentan keine anderen ...
      EXIT.
  ENDCASE.

  SORT pt_list BY key.
  DELETE ADJACENT DUPLICATES FROM pt_list.                "note 1178866

* ID 18129: check each viewtype if it should be active or not
  CLEAR: ls_list_old.
  LOOP AT pt_list INTO ls_list.
    IF ls_list-key(3) <> ls_list_old-key(3).
      l_viewtype = ls_list-key(3).
      PERFORM check_viewtype_active USING    l_viewtype
                                    CHANGING l_flag.
      IF l_flag = off.
        DELETE pt_list WHERE key(3) = l_viewtype.
      ENDIF.
    ENDIF.
    ls_list_old = ls_list.
  ENDLOOP.

* move texts to buffer!
  IF p_check_med = on.
    gt_viewtype_list_ish[] = pt_list[].
  ELSE.
    gt_viewtype_list_all[] = pt_list[].
  ENDIF.

ENDFORM.                               " GET_VIEWTYPE_TEXTS

*&---------------------------------------------------------------------*
*&      Form  get_sap_std_view_id
*&---------------------------------------------------------------------*
*       SAP-Standard-Sicht-ID ermitteln
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE  Sichttyp
*      <-- P_VIEWID    Sicht-ID
*----------------------------------------------------------------------*
FORM get_sap_std_view_id USING  VALUE(p_viewtype) TYPE nwview-viewtype
                         CHANGING p_viewid        TYPE nwview-viewid.

  DATA: ls_viewvar       TYPE nwviewvar.

  CASE p_viewtype.
*   views of clinical workplace
    WHEN '001'.
      p_viewid = 'SAP_OCC'.
    WHEN '002'.
      p_viewid = 'SAP_ARR'.
    WHEN '003'.
      p_viewid = 'SAP_DEP'.
    WHEN '004'.
      p_viewid = 'SAP_REQ'.
    WHEN '005'.
      p_viewid = 'SAP_PTS'.
    WHEN '006'.
      p_viewid = 'SAP_DOC'.
    WHEN '007'.
      p_viewid = 'SAP_LSA'.
    WHEN '008'.
      p_viewid = 'SAP_MCO'.
    WHEN '009'.
      p_viewid = 'SAP_OCP'.
    WHEN '010'.
      p_viewid = 'SAP_PRE'.
    WHEN '011'.
      p_viewid = 'SAP_OPP'.
    WHEN '012'.
      p_viewid = 'SAP_MEO'.
    WHEN '013'.
      p_viewid = 'SAP_MEE'.
    WHEN '014'.
      p_viewid = 'SAP_APP'.
    WHEN '016'.
      p_viewid = 'SAP_DIC'.
*   START ISHFR-270 - EHPAD
    WHEN 'FR1'.
      IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
        p_viewid = 'SAP_FR_ABS'.
      ENDIF.
*   END ISHFR-270 - EHPAD
    WHEN OTHERS.
*     other viewtypes (ID 18129)
      PERFORM get_viewvar_data USING    p_viewtype
                               CHANGING ls_viewvar.
      IF ls_viewvar-std_view IS NOT INITIAL.
        p_viewid   = ls_viewvar-std_view.
      ELSE.
        p_viewid   = 'SAP_'.
        p_viewid+4 = p_viewtype.
      ENDIF.
  ENDCASE.

ENDFORM.                    " get_sap_std_view_id

*&---------------------------------------------------------------------*
*&      Form  open_nodes_004_specific
*&---------------------------------------------------------------------*
*       specific coding for viewtype 004 for open_nodes-function
*----------------------------------------------------------------------*
*      -->P_VIEW     view
*      -->P_PLACE    workplace
*----------------------------------------------------------------------*
FORM open_nodes_004_specific  USING    VALUE(p_view)  TYPE nwview
                                       VALUE(p_place) TYPE nwplace.

  DATA: lt_selvar           TYPE TABLE OF rsparams,
        l_selvar            LIKE rsparams,
        l_einri             TYPE einri,
        l_tn00q             TYPE tn00q.

  CLEAR: l_selvar, l_einri, l_tn00q,
         g_100_act004.

  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid    = p_view-viewid
      i_viewtype  = p_view-viewtype
      i_mode      = 'L'
      i_caller    = 'LN1WORKPLACEF01'
      i_placeid   = p_place-wplaceid
      i_placetype = p_place-wplacetype
    TABLES
      t_selvar    = lt_selvar.

  READ TABLE lt_selvar INTO l_selvar WITH KEY selname = 'G_EINRI'.
  IF sy-subrc <> 0 OR l_selvar-low IS INITIAL.
    CALL FUNCTION 'ISH_GET_PARAMETER_ID'
      EXPORTING
        i_parameter_id    = 'EIN'
      IMPORTING
        e_parameter_value = l_einri.
  ELSE.
    l_einri = l_selvar-low.
  ENDIF.
  PERFORM ren00q(sapmnpa0) USING l_einri 'N1CORDER' l_tn00q-value.
  MOVE l_tn00q-value(1) TO g_100_act004.

ENDFORM.                    " open_nodes_004_specific
*&---------------------------------------------------------------------*
*&      Form  oe_in_text_004_specific
*&---------------------------------------------------------------------*
*       check if org.units of clinical order should be used for
*       beeing inserted into viewtext and get parameter 'N1CORDER'
*----------------------------------------------------------------------*
*      -->PT_SELVAR           selection criteria
*      <--P_USE_ORDER_FIELDS  use selection fields of clinical order
*----------------------------------------------------------------------*
FORM oe_in_text_004_specific
                TABLES   pt_selvar          STRUCTURE rsparams
                CHANGING p_use_order_fields TYPE ish_on_off
                         p_etrby            TYPE n1cordetrby
                         p_trtby            TYPE n1cordtrtby
                         p_n1corder         TYPE char1.

  DATA: l_einri          TYPE einri,
        l_tn00q          TYPE tn00q,
        l_selvar         TYPE rsparams,
        l_etrby          TYPE n1cordetrby,
        l_trtby          TYPE n1cordtrtby,
        l_etr            TYPE n1cordetr,
        l_trt            TYPE n1cordtrt,
        l_dep            TYPE n1corddep.

  CLEAR: l_tn00q, l_einri, p_n1corder, p_etrby, p_trtby.

* get institution
  READ TABLE pt_selvar INTO l_selvar WITH KEY selname = 'G_EINRI'.
  IF sy-subrc <> 0 OR l_selvar-low IS INITIAL.
    CALL FUNCTION 'ISH_GET_PARAMETER_ID'
      EXPORTING
        i_parameter_id    = 'EIN'
      IMPORTING
        e_parameter_value = l_einri.
  ELSE.
    l_einri = l_selvar-low.
  ENDIF.

* get parameter if request and/or clinical orders are active
  PERFORM ren00q(sapmnpa0) USING l_einri 'N1CORDER' l_tn00q-value.
  MOVE l_tn00q-value(1) TO p_n1corder.

* check if org.units of clinical order should be used for
* beeing inserted into viewtext
  CASE p_n1corder.
    WHEN 'R'.                    " only requests
*     only requests
      p_use_order_fields = off.
    WHEN OTHERS .
*     only clinical orders OR requests + clinical orders
      p_use_order_fields = on.
      CLEAR: l_etrby, l_trtby, l_etr, l_trt, l_dep.
      LOOP AT pt_selvar INTO l_selvar WHERE NOT low IS INITIAL.
        CASE l_selvar-selname.
          WHEN 'G_ETRBY'.
            l_etrby = l_selvar-low.
            p_etrby = l_etrby.
          WHEN 'G_TRTBY'.
            l_trtby = l_selvar-low.
            p_trtby = l_trtby.
          WHEN 'GR_ETR'.
            l_etr = l_selvar-low.
          WHEN 'GR_TRT'.
            l_trt = l_selvar-low.
          WHEN 'GR_DEP'.
            l_dep = l_selvar-low.
          WHEN OTHERS.
            CONTINUE.
        ENDCASE.
      ENDLOOP.
      IF l_etr IS INITIAL AND l_trt IS INITIAL AND l_dep IS INITIAL.
        p_use_order_fields = off.
      ELSEIF ( NOT l_etr IS INITIAL AND l_etrby <> '1' ) AND
             ( NOT l_trt IS INITIAL AND l_trtby <> '1' ).
        p_use_order_fields = off.
      ELSEIF ( NOT l_etr IS INITIAL AND l_etrby <> '1' ) AND
             l_trt IS INITIAL.
        p_use_order_fields = off.
      ELSEIF ( NOT l_trt IS INITIAL AND l_trtby <> '1' ) AND
             l_etr IS INITIAL.
        p_use_order_fields = off.
      ENDIF.
  ENDCASE.

ENDFORM.                    " oe_in_text_004_specific
*&---------------------------------------------------------------------*
*&      Form  set_autorefresh
*&---------------------------------------------------------------------*
*       check automatic refresh interval
*----------------------------------------------------------------------*
*       ATTENTION: external dynamic call from function
*                  FuB 'ISHMED_POPUP_ENTER_VALUES' !
*----------------------------------------------------------------------*
*      -->P_INTERVAL    auto refresh interval (in minutes)
*----------------------------------------------------------------------*
FORM check_autorfsh_interval
     USING VALUE(p_interval) TYPE ish_inputfield.           "#EC CALLED

* an interval more than 60000 seconds really makes no sense ...
  IF p_interval > 60000.
    MESSAGE e023(n4).
*   Ein Intervall von mehr als 60000 Sekunden ist nicht gültig.
  ENDIF.

ENDFORM.                    " CHECK_AUTORFSH_INTERVAL
*&---------------------------------------------------------------------*
*&      Form  call_svar
*&---------------------------------------------------------------------*
*      --> P_VIEWTYPE
*      --> P_EINRI
*      --> P_POPUP
*      <-- P_EXEC_COMMAND
*      <-> PT_SELVAR
*      <-> PT_PARAMS
*----------------------------------------------------------------------*
FORM call_svar   TABLES  pt_selvar            STRUCTURE rsparams
                         pt_params            STRUCTURE vanz
                 USING   VALUE(p_viewtype)    TYPE nwview-viewtype
                         VALUE(p_einri)       TYPE einri
                         VALUE(p_popup)       TYPE ish_on_off
                CHANGING p_exec_command       TYPE sy-tcode.

  DATA: l_func_name     TYPE ish_fbname,
        l_function(35)  TYPE c,
        ls_viewvar      TYPE nwviewvar.
*        ls_view         TYPE rnviewvar.                     " MED-33211

  CLEAR p_exec_command.

  CASE p_viewtype.
*   viewtypes for clinical workplace
    WHEN '001'.
*     Belegung
      CALL FUNCTION 'ISH_VP_SVAR_001'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '002'.
*     Zugänge
      CALL FUNCTION 'ISH_VP_SVAR_002'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '003'.
*     Abgänge
      CALL FUNCTION 'ISH_VP_SVAR_003'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '004'.
*     Klinische Aufträge & Anforderungen
      CALL FUNCTION 'ISHMED_VP_SVAR_004'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
          i_caller         = 'LN1WORKPLACEF01'
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          t_svar_contents  = pt_selvar
          t_svar_params    = pt_params.
    WHEN '005'.
*     Fahraufträge
      CALL FUNCTION 'ISHMED_VP_SVAR_005'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
          i_caller         = 'LN1WORKPLACEF01'
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          t_svar_contents  = pt_selvar
          t_svar_params    = pt_params.
    WHEN '006'.
*     Dokumente
      CALL FUNCTION 'ISH_N2_VP_SVAR_006'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
          i_caller         = 'LN1WORKPLACEF01'
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '007'.
*     Leistungsstelle/Ambulanz
      CALL FUNCTION 'ISHMED_VP_SVAR_007'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '008'.
*     Medizincontrolling
      CALL FUNCTION 'ISH_VP_SVAR_008'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '009'.
*     Fachrichtungsbezogene Belegungen
      CALL FUNCTION 'ISH_VP_SVAR_009'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar.
*         t_svar_params    = pt_params.   " ID 9860
    WHEN '010'.
*     Vormerkungen
      CALL FUNCTION 'ISH_VP_SVAR_010'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '011'.
*     Operationen
      CALL FUNCTION 'ISHMED_VP_SVAR_011'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          t_svar_contents  = pt_selvar
          t_svar_params    = pt_params.
    WHEN '012'.
*     Arzneimittelverordnungen
      CALL FUNCTION 'ISHMED_VP_SVAR_012'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '013'.
*     Arzneimittelereignisse
      CALL FUNCTION 'ISHMED_VP_SVAR_013'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
    WHEN '014'.
*     Terminplanung
      CALL FUNCTION 'ISHMED_VP_SVAR_014'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          t_svar_contents  = pt_selvar
          t_svar_params    = pt_params.
    WHEN '016'.
*     Diktate
      CALL FUNCTION 'ISHMED_VP_SVAR_016'
        EXPORTING
          i_institution_id = p_einri
          i_popup          = p_popup
        IMPORTING
          e_exec_command   = p_exec_command
        TABLES
          svar_contents    = pt_selvar
          t_svar_params    = pt_params.
*   START ISHFR-270 - EHPAD
    WHEN 'FR1'.
      IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
        CALL FUNCTION 'ISH_FR_VP_SVAR_FR1'
          EXPORTING
            i_institution_id = p_einri
            i_popup          = p_popup
          IMPORTING
            e_exec_command   = p_exec_command
          TABLES
            t_svar_contents  = pt_selvar
            t_svar_params    = pt_params.
      ENDIF.
*   END ISHFR-270 - EHPAD
    WHEN OTHERS.
      CLEAR: l_function.
      IF p_viewtype BETWEEN '001' AND '099'.
*       other standard-viewtypes (ID 18129)
        DO 3 TIMES.
*         Build the name of the function module to call
          IF l_function IS INITIAL.
            l_function = 'ISH_VP_SVAR_'.
          ELSEIF l_function(6) = 'ISH_VP'.
            l_function = 'ISHMED_VP_SVAR_'.
          ELSEIF l_function(9) = 'ISHMED_VP'.
            l_function = 'ISH_N2_VP_SVAR_'.
          ELSE.
            EXIT.
          ENDIF.
          CONCATENATE l_function p_viewtype INTO l_function.
          IF strlen( l_function ) > 30.
            l_function = l_function(30).
          ENDIF.
          l_func_name = l_function.
          TRY.
              CALL FUNCTION l_func_name
                EXPORTING
                  i_institution_id = p_einri
                  i_popup          = p_popup
                IMPORTING
                  e_exec_command   = p_exec_command
                TABLES
                  t_svar_contents  = pt_selvar
                  t_svar_params    = pt_params.
              EXIT.   " leave the DO-loop
            CATCH cx_root.                                  "#EC *
*             If the function does not exist, this should not raise
*             an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
          ENDTRY.
        ENDDO.
      ENDIF.
      IF l_function IS INITIAL.
*       Build the name of the function module to call for
*       customer specific or add-on viewtypes (ID 18129)
        PERFORM get_viewvar_data USING    p_viewtype
                                 CHANGING ls_viewvar.
        IF ls_viewvar-vp_svar IS NOT INITIAL.
          l_function = ls_viewvar-vp_svar.
          IF strlen( l_function ) > 30.
            l_function = l_function(30).
          ENDIF.
          l_func_name = l_function.
          TRY.
              CALL FUNCTION l_func_name
                EXPORTING
                  i_institution_id = p_einri
                  i_popup          = p_popup
                IMPORTING
                  e_exec_command   = p_exec_command
                TABLES
                  t_svar_contents  = pt_selvar
                  t_svar_params    = pt_params.
            CATCH cx_root.                                  "#EC *
*           If the function does not exist, this should not raise
*           an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
          ENDTRY.
        ENDIF.
      ENDIF.
  ENDCASE.

** MED-33211
*  CLEAR: ls_view.
*  ls_view-viewtype = p_viewtype.
*  PERFORM convert_selvar TABLES pt_selvar
*                         USING  'X' 'S' ls_view.

ENDFORM.                    " call_svar
*&---------------------------------------------------------------------*
*&      Form  get_data_table for standard-tabletype          ID 18129
*&---------------------------------------------------------------------*
FORM get_data_table USING    p_viewtype TYPE nwview-viewtype
                             p_tabname  TYPE nwviewvar-fieldcat_tabtyp
                    CHANGING pr_table   TYPE REF TO data.

  DATA: l_tabname     TYPE dd40l-typename,
        ls_dd40l      TYPE dd40l.
  DATA: lr_tabledesc  TYPE REF TO cl_abap_tabledescr.

  IF p_tabname IS INITIAL.
*   get ddic table type name
    DO 3 TIMES.
      IF l_tabname IS INITIAL.
        CLEAR l_tabname.
        CONCATENATE 'ISH_T_' p_viewtype '_LIST'
               INTO l_tabname.
      ELSEIF l_tabname(6) = 'ISH_T_'.
        CLEAR l_tabname.
        CONCATENATE 'ISHMED_T_' p_viewtype '_LIST'
               INTO l_tabname.
      ELSEIF l_tabname(9) = 'ISHMED_T_'.
        CLEAR l_tabname.
        CONCATENATE 'ISH_N2_T_' p_viewtype '_LIST'
               INTO l_tabname.
      ELSE.
        EXIT.
      ENDIF.
      SELECT SINGLE * FROM dd40l INTO ls_dd40l
             WHERE  typename  = l_tabname
             AND    as4local  = 'A'.
      IF sy-subrc = 0.
        EXIT.
      ELSE.
        IF sy-index = 3.
          CLEAR l_tabname.
        ENDIF.
      ENDIF.
    ENDDO.
  ELSE.
    l_tabname = p_tabname.
    SELECT SINGLE * FROM dd40l INTO ls_dd40l
           WHERE  typename  = l_tabname
           AND    as4local  = 'A'.
    IF sy-subrc <> 0.
      CLEAR l_tabname.
    ENDIF.
  ENDIF.

  CHECK l_tabname IS NOT INITIAL.

* get tabledescriptor objekt
*  CATCH sy_move_cast_error = 1.
  lr_tabledesc ?= cl_abap_typedescr=>describe_by_name( l_tabname ).
*  ENDCATCH.
*  CHECK sy-subrc = 0.
  CHECK lr_tabledesc IS BOUND.

* create table dynamic (like DATA statement)
  CREATE DATA pr_table TYPE HANDLE lr_tabledesc.

ENDFORM.                    " get_data_table

*&---------------------------------------------------------------------*
* FORM check_viewtype_active                                ID 18129
*&---------------------------------------------------------------------*
* Check if a viewtype is active. This could be a licence key or
* anything else. The name of the function should be
* for ISH: ISH_WP_VIEW_xxx_CHECK_ACTIV
* for GSD: ISH_N2_WP_VIEW_xxx_CHECK_ACTIV
* for TSA: ISHMED_WP_VIEW_xxx_CHECK_ACTIV
* where xxx is the number of the view
* ATTENTION: This form is called from other function groups by
*            an external PERFORM!!!
*&---------------------------------------------------------------------*
FORM check_viewtype_active USING    VALUE(p_viewtype) TYPE nviewtype
                           CHANGING p_active          TYPE c.

  DATA: l_function         TYPE c LENGTH 35,
        l_flag             TYPE c,
        ls_viewvar         TYPE nwviewvar.

  CLEAR: l_function.

  p_active = on.
  l_flag   = on.

  DO 3 TIMES.
*   Build the name of the standard function module to call
    IF l_function IS INITIAL.
      l_function = 'ISH_WP_VIEW_'.
    ELSEIF l_function(6) = 'ISH_WP'.
      l_function = 'ISHMED_WP_VIEW_'.
    ELSEIF l_function(9) = 'ISHMED_WP'.
      l_function = 'ISH_N2_WP_VIEW_'.
    ELSE.
      EXIT.
    ENDIF.
    CONCATENATE l_function
                p_viewtype
                '_CHECK_ACTIV'
           INTO l_function.
    IF strlen( l_function ) > 30.
      l_function = l_function(30).
    ENDIF.
    TRY.
        CALL FUNCTION l_function
          IMPORTING
            e_active = l_flag.
        EXIT.   " leave the DO-loop
      CATCH cx_root.                                        "#EC *
*       If the function does not exist, this should not raise
*       an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
    ENDTRY.
  ENDDO.

  IF l_function IS INITIAL.
*   customer specific or add-on viewtypes
    PERFORM get_viewvar_data USING    p_viewtype
                             CHANGING ls_viewvar.
    IF ls_viewvar-wp_view_chk_act IS NOT INITIAL.
      l_function = ls_viewvar-wp_view_chk_act.
      TRY.
          CALL FUNCTION l_function
            IMPORTING
              e_active = l_flag.
          EXIT.   " leave the DO-loop
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDIF.
  ENDIF.

  p_active = l_flag.

ENDFORM.   " check_viewtype_active
*&---------------------------------------------------------------------*
* FORM set_alv_field_groups                                 ID 18129
*&---------------------------------------------------------------------*
* Set Field Groups for ALV Layout
* The name of the function should be
* for ISH: ISH_WP_ALV_FIELD_GROUPS_xxx
* for GSD: ISH_N2_WP_ALV_FIELD_GROUPS_xxx
* for TSA: ISHMED_WP_ALV_FIELD_GROUPS_xxx
* where xxx is the number of the view
* ATTENTION: This form is called from other function groups by
*            an external PERFORM!!!
*&---------------------------------------------------------------------*
FORM set_alv_field_groups USING    VALUE(p_viewtype) TYPE nviewtype
                          CHANGING pt_groups         TYPE lvc_t_sgrp.

  DATA: l_function        TYPE c LENGTH 35.
  DATA: ls_viewvar        TYPE nwviewvar.

  CLEAR: l_function, ls_viewvar.

  IF p_viewtype BETWEEN '001' AND '099'.
*   standard viewtypes
    DO 3 TIMES.
*     Build the name of the function module to call
      IF l_function IS INITIAL.
        l_function = 'ISH_WP_ALV_FIELD_GROUPS_'.
      ELSEIF l_function(6) = 'ISH_WP'.
        l_function = 'ISHMED_WP_ALV_FIELD_GROUPS_'.
      ELSEIF l_function(9) = 'ISHMED_WP'.
        l_function = 'ISH_N2_WP_ALV_FIELD_GROUPS_'.
      ELSE.
        EXIT.
      ENDIF.
      CONCATENATE l_function p_viewtype INTO l_function.
      IF strlen( l_function ) > 30.
        l_function = l_function(30).
      ENDIF.
      TRY.
          CALL FUNCTION l_function
            CHANGING
              ct_field_groups = pt_groups.
          EXIT.   " leave the DO-loop
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDDO.
  ENDIF.

  IF l_function IS INITIAL.
*   customer specific or add-on viewtypes
    PERFORM get_viewvar_data USING    p_viewtype
                             CHANGING ls_viewvar.
    IF ls_viewvar-wp_alv_field_grp IS NOT INITIAL.
      l_function = ls_viewvar-wp_alv_field_grp.
      TRY.
          CALL FUNCTION l_function
            CHANGING
              ct_field_groups = pt_groups.
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDIF.
  ENDIF.

ENDFORM.   " set_alv_field_groups
*&---------------------------------------------------------------------*
* FORM datetime_fields_fix                                  ID 18129
*&---------------------------------------------------------------------*
* Get the connection of date/time-fields with the fix-fields
* (this fields are part of the selection variant)
* for ISH: ISH_VP_DATETIME_FIX_xxx
* for GSD: ISH_N2_VP_DATETIME_FIX_xxx
* for TSA: ISHMED_VP_DATETIME_FIX_xxx
* where xxx is the number of the view
*&---------------------------------------------------------------------*
FORM datetime_fields_fix USING    VALUE(p_viewtype) TYPE nviewtype
                                  VALUE(p_field)    TYPE fieldname
                         CHANGING p_fix             TYPE fieldname
                                  p_obligatory      TYPE ish_on_off.

  DATA: l_function       TYPE c LENGTH 35.
  DATA: ls_viewvar       TYPE nwviewvar.

  CLEAR: l_function, ls_viewvar, p_fix.

  IF p_viewtype BETWEEN '001' AND '099'.
*   standard viewtypes
    DO 3 TIMES.
*     Build the name of the function module to call
      IF l_function IS INITIAL.
        l_function = 'ISH_VP_DATETIME_FIX_'.
      ELSEIF l_function(6) = 'ISH_VP'.
        l_function = 'ISHMED_VP_DATETIME_FIX_'.
      ELSEIF l_function(9) = 'ISHMED_VP'.
        l_function = 'ISH_N2_VP_DATETIME_FIX_'.
      ELSE.
        EXIT.
      ENDIF.
      CONCATENATE l_function p_viewtype INTO l_function.
      IF strlen( l_function ) > 30.
        l_function = l_function(30).
      ENDIF.
      TRY.
          CALL FUNCTION l_function
            EXPORTING
              i_field      = p_field
            IMPORTING
              e_fix        = p_fix
              e_obligatory = p_obligatory.
          EXIT.   " leave the DO-loop
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDDO.
  ENDIF.

  IF l_function IS INITIAL.
*   customer specific or add-on viewtypes
    PERFORM get_viewvar_data USING    p_viewtype
                             CHANGING ls_viewvar.
    IF ls_viewvar-vp_datetime_fix IS NOT INITIAL.
      l_function = ls_viewvar-vp_datetime_fix.
      TRY.
          CALL FUNCTION l_function
            EXPORTING
              i_field      = p_field
            IMPORTING
              e_fix        = p_fix
              e_obligatory = p_obligatory.
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDIF.
  ENDIF.

ENDFORM.   " datetime_fields_fix

*&---------------------------------------------------------------------*
* FORM vp_view_spec_func                                     ID 18129
*&---------------------------------------------------------------------*
* Handle functions für view specific fields (NWVIEWxxx)
* The name of the function should be
* for ISH: ISH_VP_VIEW_SPEC_FUNC_xxx
* for GSD: ISH_N2_VP_VIEW_SPEC_FUNC_xxx
* for TSA: ISHMED_VP_VIEW_SPEC_FUNC_xxx
* where xxx is the number of the view
* ATTENTION: This form is called from other function groups by
*            an external PERFORM!!!
*&---------------------------------------------------------------------*
FORM vp_view_spec_func USING    VALUE(i_okcode)   TYPE sy-ucomm
                                VALUE(i_when)     TYPE num1
                                VALUE(i_view)     TYPE nwview
                                VALUE(i_vcode)    TYPE ish_vcode
                                VALUE(i_einri)    TYPE einri
                                VALUE(i_var_old)  TYPE rnviewvar
                                VALUE(i_var_new)  TYPE rnviewvar
                                VALUE(i_rfsh_old) TYPE rnrefresh
                                VALUE(i_rfsh_new) TYPE rnrefresh
                                VALUE(i_std_rc)   TYPE ish_method_rc
                       CHANGING e_no_std          TYPE ish_on_off
                                e_svar_txt        TYPE nwsvar_txt
                                e_avar_txt        TYPE nwavar_txt
                                e_fvar_txt        TYPE nwfvar_txt
                                e_rc              TYPE ish_method_rc
                                cr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.

  DATA: l_function        TYPE c LENGTH 35.
  DATA: ls_viewvar        TYPE nwviewvar.

  CLEAR: l_function, ls_viewvar.

  IF i_view-viewtype BETWEEN '001' AND '099'.
*   standard viewtypes
    DO 3 TIMES.
*     Build the name of the function module to call
      IF l_function IS INITIAL.
        l_function = 'ISH_VP_VIEW_SPEC_FUNC_'.
      ELSEIF l_function(6) = 'ISH_VP'.
        l_function = 'ISHMED_VP_VIEW_SPEC_FUNC_'.
      ELSEIF l_function(9) = 'ISHMED_VP'.
        l_function = 'ISH_N2_VP_VIEW_SPEC_FUNC_'.
      ELSE.
        EXIT.
      ENDIF.
      CONCATENATE l_function i_view-viewtype INTO l_function.
      IF strlen( l_function ) > 30.
        l_function = l_function(30).
      ENDIF.
      TRY.
          CALL FUNCTION l_function
            EXPORTING
              i_okcode        = i_okcode
              i_when          = i_when
              i_view          = i_view
              i_vcode         = i_vcode
              i_einri         = i_einri
              i_variants_old  = i_var_old
              i_variants_new  = i_var_new
              i_refresh_old   = i_rfsh_old
              i_refresh_new   = i_rfsh_new
              i_std_func_rc   = i_std_rc
            IMPORTING
              e_no_std        = e_no_std
              e_svar_txt      = e_svar_txt
              e_avar_txt      = e_avar_txt
              e_fvar_txt      = e_fvar_txt
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
          EXIT.   " leave the DO-loop
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDDO.
  ENDIF.

  IF l_function IS INITIAL.
*   customer specific or add-on viewtypes
    PERFORM get_viewvar_data USING    i_view-viewtype
                             CHANGING ls_viewvar.
    IF ls_viewvar-vp_viewspec_func IS NOT INITIAL.
      l_function = ls_viewvar-vp_viewspec_func.
      TRY.
          CALL FUNCTION l_function
            EXPORTING
              i_okcode        = i_okcode
              i_when          = i_when
              i_view          = i_view
              i_vcode         = i_vcode
              i_einri         = i_einri
              i_variants_old  = i_var_old
              i_variants_new  = i_var_new
              i_refresh_old   = i_rfsh_old
              i_refresh_new   = i_rfsh_new
              i_std_func_rc   = i_std_rc
            IMPORTING
              e_no_std        = e_no_std
              e_svar_txt      = e_svar_txt
              e_avar_txt      = e_avar_txt
              e_fvar_txt      = e_fvar_txt
              e_rc            = e_rc
            CHANGING
              cr_errorhandler = cr_errorhandler.
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDIF.
  ENDIF.

ENDFORM.   " vp_view_spec_func

*&---------------------------------------------------------------------*
* FORM get_view_specific                                      ID 18129
*&---------------------------------------------------------------------*
* Get the view specific table data
*&---------------------------------------------------------------------*
FORM get_view_specific  USING    VALUE(p_viewtype) TYPE nviewtype
                        CHANGING p_dbname          TYPE lvc_tname
                                 p_dbname_v        TYPE lvc_tname
                                 p_func_name       TYPE ish_fbname.

  DATA: ls_viewvar      TYPE nwviewvar.

  CLEAR: p_dbname, p_dbname_v, p_func_name.

  CHECK p_viewtype IS NOT INITIAL.

  IF p_viewtype BETWEEN '001' AND '099' OR p_viewtype EQ 'P01' OR
     ( cl_ish_switch_check=>ish_cv_fr( ) = abap_true AND      "ISHFR-270 - EHPAD
       p_viewtype EQ 'FR1' ).
*   standard viewtypes
    p_dbname          = 'NWVIEW_'.
    p_dbname+7(3)     = p_viewtype.
    p_dbname_v        = 'VNWVIEW_'.
    p_dbname_v+8(3)   = p_viewtype.
    p_func_name       = 'ISH_VERBUCHER_NWVIEW_'.
    p_func_name+21(3) = p_viewtype.
  ELSE.
*   customer specific or add-on viewtypes
    PERFORM get_viewvar_data IN PROGRAM sapln1workplace
                             USING      p_viewtype
                             CHANGING   ls_viewvar.
    IF ls_viewvar-nwview_s        IS NOT INITIAL AND
       ls_viewvar-vnwview_s       IS NOT INITIAL AND
       ls_viewvar-update_nwview_s IS NOT INITIAL.
      p_dbname    = ls_viewvar-nwview_s.
      p_dbname_v  = ls_viewvar-vnwview_s.
      p_func_name = ls_viewvar-update_nwview_s.
    ENDIF.
  ENDIF.

ENDFORM.   " get_view_specific

*&---------------------------------------------------------------------*
* FORM wp_view_transport
*&---------------------------------------------------------------------*
* Handle transport function für view specific data
* The name of the function should be
* for ISH: ISH_WP_VIEW_xxx_TRANSPORT
* for GSD: ISH_N2_WP_VIEW_xxx_TRANSPORT
* for TSA: ISHMED_WP_VIEW_xxx_TRANSPORT
* where xxx is the number of the view
* ATTENTION: This form is called from other function groups by
*            an external PERFORM!!!
*&---------------------------------------------------------------------*
FORM wp_view_transport USING    VALUE(i_viewtype) TYPE nviewtype
                                VALUE(i_viewid)   TYPE nviewid
                                VALUE(i_task)     TYPE trkorr
                                VALUE(i_all)      TYPE ish_on_off
                       CHANGING et_e071           TYPE tr_objects
                                et_e071k          TYPE tr_keys.

  DATA: l_function        TYPE c LENGTH 35.
  DATA: ls_viewvar        TYPE nwviewvar.
  DATA: lt_e071           TYPE tr_objects.
  DATA: lt_e071k          TYPE tr_keys.

  CLEAR: l_function, ls_viewvar.

  IF i_viewtype BETWEEN '001' AND '099'.
*   standard viewtypes
    DO 3 TIMES.
*     Build the name of the function module to call
      IF l_function IS INITIAL.
        l_function = 'ISH_WP_VIEW_'.
      ELSEIF l_function(6) = 'ISH_WP'.
        l_function = 'ISHMED_WP_VIEW_'.
      ELSEIF l_function(9) = 'ISHMED_WP'.
        l_function = 'ISH_N2_WP_VIEW_'.
      ELSE.
        EXIT.
      ENDIF.
      CONCATENATE l_function i_viewtype '_TRANSPORT' INTO l_function.
      IF strlen( l_function ) > 30.
        l_function = l_function(30).
      ENDIF.
      TRY.
          CALL FUNCTION l_function
            EXPORTING
              i_viewid = i_viewid
              i_task   = i_task
              i_all    = i_all
            IMPORTING
              et_e071  = lt_e071
              et_e071k = lt_e071k.
          EXIT.   " leave the DO-loop
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDDO.
  ENDIF.

  IF l_function IS INITIAL.
*   customer specific or add-on viewtypes
    PERFORM get_viewvar_data USING    i_viewtype
                             CHANGING ls_viewvar.
    IF ls_viewvar-wp_view_transp IS NOT INITIAL.
      l_function = ls_viewvar-wp_view_transp.
      TRY.
          CALL FUNCTION l_function
            EXPORTING
              i_viewid = i_viewid
              i_task   = i_task
              i_all    = i_all
            IMPORTING
              et_e071  = lt_e071
              et_e071k = lt_e071k.
        CATCH cx_root.                                      "#EC *
*         If the function does not exist, this should not raise
*         an error ("#EC CATCH_ALL / "#EC NO_HANDLER)
      ENDTRY.
    ENDIF.
  ENDIF.

  IF lt_e071[] IS NOT INITIAL.
    APPEND LINES OF lt_e071 TO et_e071.
  ENDIF.
  IF lt_e071k[] IS NOT INITIAL.
    APPEND LINES OF lt_e071k TO et_e071k.
  ENDIF.

ENDFORM.   " wp_view_transport

*&---------------------------------------------------------------------*
* FORM get_range_viewvar                                      ID 18129
*&---------------------------------------------------------------------*
* Get the range of all customer or add-on specific viewtypes
*&---------------------------------------------------------------------*
FORM get_range_viewvar
     CHANGING pt_viewvar   TYPE ish_t_rangeviewtype.

  DATA: lt_viewvar         TYPE TABLE OF nwviewvar,
        ls_viewvar         LIKE LINE OF lt_viewvar,
        lt_range_viewvar   TYPE TABLE OF rnrangeviewtype,
        ls_range_viewvar   LIKE LINE OF lt_range_viewvar.

  REFRESH: pt_viewvar, lt_viewvar, lt_range_viewvar.

  SELECT * FROM nwviewvar INTO TABLE lt_viewvar.            "#EC *
  CHECK sy-subrc = 0.

  LOOP AT lt_viewvar INTO ls_viewvar.
    CLEAR ls_range_viewvar.
    ls_range_viewvar-sign   = 'I'.
    ls_range_viewvar-option = 'EQ'.
    ls_range_viewvar-low    = ls_viewvar-viewtype.
    APPEND ls_range_viewvar TO lt_range_viewvar.
  ENDLOOP.

  pt_viewvar[] = lt_range_viewvar[].

ENDFORM.   " get_range_viewvar

*&---------------------------------------------------------------------*
* FORM get_viewvar_data                                       ID 18129
*&---------------------------------------------------------------------*
* Get the view specific data (especially for customer+add-on-viewtypes)
*&---------------------------------------------------------------------*
FORM get_viewvar_data  USING    VALUE(p_viewtype) TYPE nviewtype
                       CHANGING ps_viewvar        TYPE nwviewvar.

  CLEAR ps_viewvar.

  CHECK p_viewtype IS NOT INITIAL.

  SELECT SINGLE * FROM nwviewvar INTO ps_viewvar
         WHERE  viewtype  = p_viewtype.
  IF sy-subrc <> 0.
    CLEAR ps_viewvar.
  ENDIF.

ENDFORM.   " get_viewvar_data
*&---------------------------------------------------------------------*
*&      Form  get_highest_key_from_nwview      MED-61616 CKi
*&---------------------------------------------------------------------*
*       Get highest key in number range S or CST number range
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE    Sichttyp
*      --> P_SAP_STD     SAP-Standard-Sicht anlegen
*      <-- P_HIGHEST_KEY   ( z.b. CSTKK40001 )
*      <-- P_HIGHEST_NUMBER
*----------------------------------------------------------------------*
FORM get_highest_key_from_nwview USING    VALUE(p_viewtype)    LIKE nwview-viewtype
                                          VALUE(p_sap_std)     TYPE ish_on_off
                                 CHANGING c_highest_key         LIKE rnwp_gen_key-nwkey
                                          c_highest_number      TYPE n.

  DATA: l_num(4) TYPE n,
        l_viewid TYPE nviewid.

  DATA  l_key LIKE rnwp_gen_key-nwkey.
  CLEAR l_key.

  IF p_sap_std = on.
    l_key(1)   = co_prefix_sap.     " Präfix 'S'
    l_key+1(3) = sy-sysid.
    l_key+4(1) = '%'.
  ELSE.
    l_key(3)   = co_prefix.         " Präfix 'CST'
    l_key+3(3) = sy-sysid.
    l_key+6(1) = '%'.
  ENDIF.

  SELECT viewid FROM nwview INTO l_viewid UP TO 1 ROWS
         WHERE  viewtype  =    p_viewtype
         AND    viewid    LIKE l_key
         ORDER BY viewid DESCENDING.                        "#EC *
    EXIT.
  ENDSELECT.                                                "#EC *

  IF sy-subrc = 0.
    IF p_sap_std = on.
      l_num = l_viewid+4(4).
    ELSE.
      l_num = l_viewid+6(4).
    ENDIF.
  ELSE.
    l_num = '0000'.
    l_viewid = l_key.       "MED-62453 AGujev - need to have a valid prefix for the key!
  ENDIF.

  c_highest_key = l_viewid.
  c_highest_number = l_num.


ENDFORM.                    " get_highest_key_from_nwview

*&---------------------------------------------------------------------*
*&      Form  search_available_number      MED-61616 CKi
*&---------------------------------------------------------------------*
*       search_available_number
*          Search for gaps in number range
*       Algorithm was implemented for MED-49026 by AM
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE        Sichttyp
*      --> P_SAP_STD         SAP-Standard-Sicht anlegen
*      <-- C_AVAILABLE_KEY   Sicht-ID  ( z.b. CSTKK40001 ), die genutzt werden kann
*      <-- C_NUMBER_RANGE_EXHAUSTED   Nummernkreis ausgeschöpft?
*----------------------------------------------------------------------*
FORM search_available_number USING
               VALUE(p_viewtype)    LIKE nwview-viewtype
               VALUE(p_sap_std)     TYPE ish_on_off
               CHANGING c_available_key            LIKE rnwp_gen_key-nwkey
                        c_number_range_exhausted   TYPE ish_on_off.


  DATA: l_num(4) TYPE n,
        l_viewid TYPE nviewid.
  DATA: l_searchkey   LIKE rnwp_gen_key-nwkey.


  DATA lt_viewid TYPE STANDARD TABLE OF nviewid WITH DEFAULT KEY .
  DATA l_viewkey(4)   TYPE n."MED-49026,AM
  DATA l_nextkey(4)   TYPE n. ""MED-49026,AM
  DATA l_goodkey(4)   TYPE n. ""MED-49026,AM
  DATA l_lines         TYPE i.
  FIELD-SYMBOLS: <fs_viewid> TYPE nviewid ."MED-49026,AM

  l_searchkey(3)   = co_prefix.         " Präfix 'CST'
  l_searchkey+3(3) = sy-sysid.
  l_searchkey+6(1) = '%'.

  IF p_sap_std = on.
    l_searchkey(1)   = co_prefix_sap.     " Präfix 'S'
    l_searchkey+1(3) = sy-sysid.
    l_searchkey+4(1) = '%'.
  ELSE.
    l_searchkey(3)   = co_prefix.         " Präfix 'CST'
    l_searchkey+3(3) = sy-sysid.
    l_searchkey+6(1) = '%'.
  ENDIF.

  SELECT viewid FROM nwview INTO TABLE lt_viewid         "#EC CI_BYPASS
     WHERE  viewtype  =    p_viewtype AND
             viewid    LIKE l_searchkey
      ORDER BY viewid ASCENDING.

  DESCRIBE TABLE lt_viewid LINES l_lines.
  IF l_lines = 9999.                       "number range is exhausted
    c_number_range_exhausted = on.
    CLEAR c_available_key.
    EXIT.
  ELSE.                                 " there are still available numbers
*   Starting from '0001' check if number is available
    l_nextkey = '0001'.
    CLEAR l_goodkey.
    LOOP AT lt_viewid ASSIGNING <fs_viewid> .
      l_viewkey = <fs_viewid>+6(4).
*     if the key of the entry is different then the expected next key, then we can use the next key
      IF l_nextkey < l_viewkey.   " gap found
        l_goodkey = l_nextkey.
        EXIT.                     "exit loop because an available key has been found
      ELSE.
        l_nextkey = l_nextkey + 1.  "else try next number
      ENDIF.
*
    ENDLOOP.
*
    IF l_goodkey IS NOT INITIAL.            " there must be a "goodkey" because there were less than 9999 entries in the table
      c_available_key = l_searchkey.
      c_available_key+6(4) = l_goodkey.
      c_number_range_exhausted = off.
*    ELSE.
*      c_cst_number_range_exhausted = on.
*      CLEAR c_available_key.
    ENDIF.

  ENDIF.

ENDFORM.                    " search_available_CST_number

*&---------------------------------------------------------------------*
*&      Form  create_c_number_range_key     MED-61616 CKi
*&---------------------------------------------------------------------*
*       create_c_number_range_key
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE    Sichttyp
*      --> P_COUNT_ADD   Wieviel hochzählen?
*      <-- P_KEY         Key in the (new) number range C<system>nnnnnn eg CEWI000001
*----------------------------------------------------------------------*
FORM create_c_number_range_key
               USING    VALUE(p_viewtype)    LIKE nwview-viewtype
                        VALUE(p_count_add)   LIKE sy-index
               CHANGING c_key                LIKE rnwp_gen_key-nwkey.

  DATA: l_num6(6) TYPE n,
        l_viewid  TYPE nviewid.

  DATA  l_key LIKE rnwp_gen_key-nwkey.
  CLEAR l_key.
  l_key(1)   = co_prefix.         " Präfix 'C'
  l_key+1(3) = sy-sysid.
  l_key+4(1) = '%'.


  SELECT viewid FROM nwview INTO l_viewid UP TO 1 ROWS
         WHERE  viewtype  =    p_viewtype
         AND    viewid    LIKE l_key
         ORDER BY viewid DESCENDING.                        "#EC *
    EXIT.
  ENDSELECT.                                                "#EC *

  IF sy-subrc = 0.
    l_num6 = l_viewid+4(6).
  ELSE.
    l_num6 = '000000'.
  ENDIF.
  ADD p_count_add TO l_num6.

  c_key = l_key.
  c_key+4(6) = l_num6.

ENDFORM.                    " create_c_number_range_key
