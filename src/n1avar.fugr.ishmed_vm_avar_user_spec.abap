FUNCTION ishmed_vm_avar_user_spec .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEW) TYPE  NWVIEW
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'UPD'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT ' '
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"     VALUE(I_SAVE_TYPE) TYPE  ISH_ON_OFF DEFAULT 'U'
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(E_VIEWVAR) TYPE  RNVIEWVAR
*"     VALUE(E_CHANGED) TYPE  ISH_ON_OFF
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_dvar              TYPE STANDARD TABLE OF ltdxkey,
        l_dvar               TYPE ltdxkey,
        lt_messages          TYPE TABLE OF bapiret2,
        lt_def_fieldcat      TYPE lvc_t_fcat,
        l_dispvar            TYPE lvc_s_fcat,
        l_dispsort           TYPE lvc_s_sort,
        l_dispfilter         TYPE lvc_s_filt,
        l_dispvar_db         TYPE lvc_s_fcat,
        l_dispsort_db        TYPE lvc_s_sort,
        l_dispfilter_db      TYPE lvc_s_filt,
        lt_dispvar           TYPE lvc_t_fcat,
        lt_dispvar_db        TYPE lvc_t_fcat,
        lt_dispvar_chk       TYPE lvc_t_fcat,
        lt_dispvar_chk_db    TYPE lvc_t_fcat,
        lt_dispsort          TYPE lvc_t_sort,
        lt_dispsort_db       TYPE lvc_t_sort,
        lt_dispsort_chk      TYPE lvc_t_sort,
        lt_dispsort_chk_db   TYPE lvc_t_sort,
        lt_dispfilter        TYPE lvc_t_filt,
        lt_dispfilter_db     TYPE lvc_t_filt,
        lt_dispfilter_chk    TYPE lvc_t_filt,
        lt_dispfilter_chk_db TYPE lvc_t_filt,
        l_variant            LIKE disvariant,
        l_layout             TYPE lvc_s_layo,
        l_layout_db          TYPE lvc_s_layo,
        l_layout_c           TYPE lvc_s_layo,
        l_layout_chk         TYPE lvc_s_layo,
        l_layout_chk_db      TYPE lvc_s_layo,
        l_viewvar            TYPE rnviewvar,
        lt_c_selvar          LIKE TABLE OF rsparams,
        lt_c_fvar            LIKE TABLE OF v_nwfvar,
        lt_c_fvar_button     LIKE TABLE OF v_nwbutton,
        lt_c_fvar_futxt      LIKE TABLE OF v_nwfvarp,
        lt_c_dispvar         TYPE lvc_t_fcat,
        lt_c_dispsort        TYPE lvc_t_sort,
        lt_c_dispfilt        TYPE lvc_t_filt,
        l_count              TYPE i,
        l_rc                 LIKE sy-subrc,
        l_v_nwview           TYPE v_nwview,
        l_view_txt           LIKE nwpvzt-txt,
        l_txt(40)            TYPE c,
        l_answer(1)          TYPE c,
        l_save_to_view       TYPE ish_on_off,
        l_save_userspec      TYPE ish_on_off,
        l_update_buffer      TYPE ish_on_off,
        lt_data              TYPE lvc_t_filt.             " Dummy
  DATA: ls_viewvar           TYPE nwviewvar.
  DATA: lr_table             TYPE REF TO data.
  DATA: lt_data_001          TYPE ish_t_occupancy_list.   " Sichttyp 001
  DATA: lt_data_002          TYPE ish_t_arrival_list.     " Sichttyp 002
  DATA: lt_data_003          TYPE ish_t_departure_list.   " Sichttyp 003
  DATA: lt_data_004          TYPE ishmed_t_request_list.  " Sichttyp 004
  DATA: lt_data_005          TYPE ishmed_t_pts_list.      " Sichttyp 005
  DATA: lt_data_006          TYPE ish_n2_document_list.   " Sichttyp 006
  DATA: lt_data_007          TYPE ish_t_lststelle_list.   " Sichttyp 007
  DATA: lt_data_008          TYPE ish_t_medcontrol_list.  " Sichttyp 008
  DATA: lt_data_009          TYPE ish_t_occplanning_list. " Sichttyp 009
  DATA: lt_data_010          TYPE ish_t_prereg_list.      " Sichttyp 010
  DATA: lt_data_011          TYPE ishmed_t_op_list.       " Sichttyp 011
  DATA: lt_data_012          TYPE ishmed_t_meorder_list.  " Sichttyp 012
  DATA: lt_data_013          TYPE ishmed_t_meevent_list.  " Sichttyp 013
*  DATA: lt_data_014          TYPE ishmed_t_???_list.     " Sichttyp 014
  DATA: lt_data_016          TYPE ishmed_t_dictation_list. "Sichttyp 016
* WK, 26.5.2011, ISHFR-270   Beginn
  DATA: lt_data_fr1        TYPE ish_t_occupancy_list.  " Sichttyp FR1
* WK, 26.5.2011, ISHFR-270   Ende

  FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE.

  CLEAR: l_viewvar, l_variant, l_layout, l_layout_db, l_layout_c,
         l_layout_chk, l_layout_chk_db, e_rc, e_viewvar, e_changed.

  REFRESH: lt_dispvar, lt_dispsort, lt_dispfilter, t_messages,
           lt_dispvar_db, lt_dispsort_db, lt_dispfilter_db, lt_data,
           lt_dispvar_chk, lt_dispvar_chk_db,
           lt_dispsort_chk, lt_dispsort_chk_db,
           lt_dispfilter_chk, lt_dispfilter_chk_db,
           lt_c_selvar, lt_c_fvar, lt_c_fvar_button, lt_c_fvar_futxt,
           lt_c_dispvar, lt_c_dispsort, lt_c_dispfilt.
  REFRESH: lt_data_001, lt_data_002, lt_data_004, lt_data_004,
           lt_data_005, lt_data_006, lt_data_007, lt_data_008,
           lt_data_009, lt_data_010, lt_data_011, lt_data_012,
           lt_data_013, lt_data_016, lt_data_fr1.

* viewtype 014 does not use layout variants!
  IF i_view-viewtype = '014'.
    EXIT.
  ENDIF.

* Aktuell gepufferte (ev. geänderte und nicht gesicherte)
* Anzeigevariante der übergebenen (eben angezeigten) Sicht
* lesen
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid     = i_view-viewid
      i_viewtype   = i_view-viewtype
      i_mode       = 'L'
      i_caller     = 'LN1AVARU02'
      i_placeid    = i_place-wplaceid
      i_placetype  = i_place-wplacetype
    IMPORTING
      e_rc         = e_rc
      e_view       = l_v_nwview
      e_viewvar    = l_viewvar
    TABLES
      t_messages   = t_messages
    CHANGING
      c_dispvar    = lt_dispvar
      c_dispsort   = lt_dispsort
      c_dispfilter = lt_dispfilter
      c_layout     = l_layout.
* Falls ein Fehler aufgetreten ist, dann soll der FBS hier
* verlassen werden
  IF e_rc <> 0.
    EXIT.
  ENDIF.

  l_view_txt = l_v_nwview-txt.

* Je nach Verarbeitungscode die Persönl. Anzeigevariante verarbeiten
  CASE i_vcode.
    WHEN 'DEL'.                        " Löschen
*     zu Beginn des FBS wurde die aktuelle Anz.var. der
*     übergebenen Sicht ermittelt, hier nun prüfen, ob es eine
*     persönliche Sicht ist, denn nur dann ist sie zu löschen
      IF NOT l_viewvar-username   IS INITIAL AND
         NOT l_viewvar-avariantid IS INITIAL.
*       Persönliche Anzeigevariante einer Sicht löschen
        CLEAR l_dvar. REFRESH lt_dvar.
        l_dvar-report    = l_viewvar-reporta.
        l_dvar-handle    = l_viewvar-handle.
        l_dvar-log_group = l_viewvar-log_group.
        l_dvar-username  = l_viewvar-username.
        l_dvar-variant   = l_viewvar-avariantid.
        l_dvar-type      = l_viewvar-type.
        APPEND l_dvar TO lt_dvar.
        CALL FUNCTION 'LT_VARIANTS_DELETE'
*            EXPORTING
*                 I_TOOL        = 'LT'
*                 I_TEXT_DELETE = 'X'
             TABLES
                  t_varkey      = lt_dvar
             EXCEPTIONS
                  not_found     = 1
                  OTHERS        = 2.
        IF sy-subrc <> 0.
*         Fehler beim Löschen
          e_rc = 1.
          EXIT.
        ENDIF.
      ENDIF.
*     Anzeigevariante wurde gelöscht
*     --> Puffer der Sicht initialisieren
      CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
        EXPORTING
          i_viewid      = i_view-viewid
          i_viewtype    = i_view-viewtype
          i_mode        = 'C'
          i_caller      = 'LN1AVARU02'
          i_placeid     = i_place-wplaceid
          i_placetype   = i_place-wplacetype
        TABLES
          t_selvar      = lt_c_selvar
          t_fvar        = lt_c_fvar
          t_fvar_button = lt_c_fvar_button
          t_fvar_futxt  = lt_c_fvar_futxt
        CHANGING
          c_dispvar     = lt_c_dispvar
          c_dispsort    = lt_c_dispsort
          c_dispfilter  = lt_c_dispfilt
          c_layout      = l_layout_c.
      CLEAR l_viewvar.
      e_changed = on.

    WHEN 'UPD'.      " Ändern oder Anlegen (wenn noch keine existiert)
*     Da die persönliche Anzeigevariante ohne Benutzerinteraktion
*     mit diesem FBS automatisch angelegt/geändert werden soll,
*     muß hier zuerst festgestellt werden, ob die Anzeigevariante
*     der eben angezeigten Sicht geändert wurde (ohne zu sichern).
*     Falls diese Anzeigevariante ohnehin eine persönliche Anz.variante
*     ist, dann soll sie geändert werden; falls es keine persönliche
*     Anz.variante ist, dann soll, sofern sie geändert wurde, im
*     folgenden eine persönliche Anz.variante angelegt werden.
*     Dazu muß aber der Aufrufer dieses FBS die aktuelle (geänderte)
*     Anzeigevariante zuvor in den Puffer (ISHMED_VM_READ_VIEW_DATA)
*     gestellt haben.
*     --> also zu Beginn des FBS wurde die Anzeigevariante der eben
*         angezeigten Sicht ermittelt.
*     --> nun die Daten dieser Anzeigevariante von der DB lesen
      IF l_viewvar-reporta    IS INITIAL OR
         l_viewvar-avariantid IS INITIAL.
*       falls nichts im Puffer gefunden wurde, dann die Tabellen für
*       den Vergleich leer lassen, somit wird eine Änderung angenommen
      ELSE.
        l_variant-report     = l_viewvar-reporta.
        l_variant-handle     = l_viewvar-handle.
        l_variant-log_group  = l_viewvar-log_group.
        l_variant-username   = l_viewvar-username.
        l_variant-variant    = l_viewvar-avariantid.
        REFRESH: lt_def_fieldcat, lt_messages.
        PERFORM create_fieldcat(sapln1workplace)
                USING    i_place
                         l_viewvar        on           on
                CHANGING lt_def_fieldcat  lt_messages  l_rc.
        IF l_rc <> 0.
          lt_def_fieldcat[] = lt_dispvar[].
          t_messages[]      = lt_messages[].
        ENDIF.
*       Je Sichttyp die Struktur der Ausgabetabelle unterschiedlich
*       übergeben (für Filterkriterien)
        CASE i_view-viewtype.
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
*            ASSIGN lt_data_014[] TO <lt_data>.
          WHEN '016'.
            ASSIGN lt_data_016[] TO <lt_data>.
*   START ISHFR-270 - EHPAD
          WHEN 'FR1'.
            IF cl_ish_switch_check=>ish_cv_fr( ) = abap_true.
              ASSIGN lt_data_fr1[] TO <lt_data>.
            endif.
*   END ISHFR-270 - EHPAD
          WHEN OTHERS.
            CLEAR ls_viewvar.
            IF i_view-viewtype BETWEEN '001' AND '099'.
*             other standard viewtypes (ID 18129)
              PERFORM get_data_table IN PROGRAM sapln1workplace
                               USING i_view-viewtype
                                     ls_viewvar-fieldcat_tabtyp
                            CHANGING lr_table.
            ENDIF.
            IF lr_table IS NOT BOUND.
*             customer specific or add-on viewtypes (ID 18129)
              PERFORM get_viewvar_data IN PROGRAM sapln1workplace
                                       USING      i_view-viewtype
                                       CHANGING   ls_viewvar.
              IF ls_viewvar-fieldcat_tabtyp IS NOT INITIAL.
                PERFORM get_data_table IN PROGRAM sapln1workplace
                                 USING i_view-viewtype
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
        CALL FUNCTION 'LVC_VARIANT_SELECT'
          EXPORTING
            i_dialog            = ' '
            i_user_specific     = 'U'  " user-specific possible
            it_default_fieldcat = lt_def_fieldcat
          IMPORTING
            et_fieldcat         = lt_dispvar_db
            et_sort             = lt_dispsort_db
            et_filter           = lt_dispfilter_db
            es_layout           = l_layout_db
          TABLES
            it_data             = <lt_data>
          CHANGING
            cs_variant          = l_variant
          EXCEPTIONS
            wrong_input         = 1
            fc_not_complete     = 2
            not_found           = 3
            program_error       = 4
            OTHERS              = 5.                        "#EC *
        IF sy-subrc <> 0. ENDIF.                            "#EC NEEDED
        PERFORM create_fieldcat(sapln1workplace)
                USING    i_place
                         l_viewvar      off          on
                CHANGING lt_dispvar_db  lt_messages  l_rc.
      ENDIF.
*     Die gepufferte Variante kann hier nicht einfach komplett mit der
*     Variante von der DB verglichen werden, da die gesicherte Variante
*     beim Speichern durch den FBS LVC_FIELDCAT_COMPLETE geschickt
*     wurde und von diesem FBS komplettiert bzw. geändert wurde, was
*     bei der gepufferten Variante nicht der Fall ist.
*     Somit wäre nicht gewährleistet, daß die folgende Vergleichsprüfung
*     ein richtiges Ergebnis liefert, da z.B. die Sort-IDs (Feld
*     COL_POS) aufgrund unterschiedlicher Einsortierung von nicht
*     angezeigten Feldern (NO_OUT = 'X') verschieden sind.
*     --> Für den Vergleich sind nur die tatsächlich angezeigten Felder
*     relevant, daher alle technischen und nicht angezeigten Felder
*     aus beiden Vergleichstabellen rausschmeißen
*     Spaltenbreite nur vergleichen, wenn nicht im Layout
*      'optimale Spaltenbreite' markiert wurde! (ID 8110)
      LOOP AT lt_dispvar INTO l_dispvar WHERE tech   IS INITIAL
                                          AND no_out IS INITIAL.
        CLEAR l_dispvar_db.
        l_dispvar_db-fieldname  = l_dispvar-fieldname.
        l_dispvar_db-col_pos    = l_dispvar-col_pos.
        IF l_layout-cwidth_opt = off OR
           l_layout-cwidth_opt = 'O'.                   " MED-34941
          l_dispvar_db-outputlen  = l_dispvar-outputlen.
        ENDIF.
        l_dispvar_db-fix_column = l_dispvar-fix_column.
        APPEND l_dispvar_db TO lt_dispvar_chk.
      ENDLOOP.
      LOOP AT lt_dispvar_db INTO l_dispvar WHERE tech   IS INITIAL
                                             AND no_out IS INITIAL.
        CLEAR l_dispvar_db.
        l_dispvar_db-fieldname  = l_dispvar-fieldname.
        l_dispvar_db-col_pos    = l_dispvar-col_pos.
        IF l_layout-cwidth_opt = off OR
           l_layout-cwidth_opt = 'O'.                   " MED-34941
          l_dispvar_db-outputlen  = l_dispvar-outputlen.
        ENDIF.
        l_dispvar_db-fix_column = l_dispvar-fix_column.
        APPEND l_dispvar_db TO lt_dispvar_chk_db.
      ENDLOOP.
      SORT lt_dispvar_chk    BY col_pos fieldname.
      SORT lt_dispvar_chk_db BY col_pos fieldname.
*     Gepufferte AVAR: Tatsächl. angezeigte Felder neu durchnummerieren
      l_count = 0.
      LOOP AT lt_dispvar_chk INTO l_dispvar.
        l_count = l_count + 1.
        l_dispvar-col_pos = l_count.
        MODIFY lt_dispvar_chk FROM l_dispvar.
      ENDLOOP.
*     Gesicherte AVAR: Tatsächl. angezeigte Felder neu durchnummerieren
      l_count = 0.
      LOOP AT lt_dispvar_chk_db INTO l_dispvar_db.
        l_count = l_count + 1.
        l_dispvar_db-col_pos = l_count.
        MODIFY lt_dispvar_chk_db FROM l_dispvar_db.
      ENDLOOP.
*     Auch bei der Sortierungstabelle nur bestimmte Felder vergleichen
      LOOP AT lt_dispsort INTO l_dispsort.
        CLEAR l_dispsort_db.
        l_dispsort_db-fieldname = l_dispsort-fieldname.
        l_dispsort_db-spos      = l_dispsort-spos.
        l_dispsort_db-up        = l_dispsort-up.
        l_dispsort_db-down      = l_dispsort-down.
        APPEND l_dispsort_db TO lt_dispsort_chk.
      ENDLOOP.
      LOOP AT lt_dispsort_db INTO l_dispsort.
        CLEAR l_dispsort_db.
        l_dispsort_db-fieldname = l_dispsort-fieldname.
        l_dispsort_db-spos      = l_dispsort-spos.
        l_dispsort_db-up        = l_dispsort-up.
        l_dispsort_db-down      = l_dispsort-down.
        APPEND l_dispsort_db TO lt_dispsort_chk_db.
      ENDLOOP.
      SORT lt_dispsort_chk BY fieldname spos.
      SORT lt_dispsort_chk_db BY fieldname spos.
*     Auch bei der Filtertabelle nur bestimmte Felder vergleichen
      LOOP AT lt_dispfilter INTO l_dispfilter.
        CLEAR l_dispfilter_db.
        l_dispfilter_db-fieldname = l_dispfilter-fieldname.
        l_dispfilter_db-low       = l_dispfilter-low.
        l_dispfilter_db-high      = l_dispfilter-high.
        l_dispfilter_db-sign      = l_dispfilter-sign.
        l_dispfilter_db-option    = l_dispfilter-option.
        APPEND l_dispfilter_db TO lt_dispfilter_chk.
      ENDLOOP.
      LOOP AT lt_dispfilter_db INTO l_dispfilter.
        CLEAR l_dispfilter_db.
        l_dispfilter_db-fieldname = l_dispfilter-fieldname.
        l_dispfilter_db-low       = l_dispfilter-low.
        l_dispfilter_db-high      = l_dispfilter-high.
        l_dispfilter_db-sign      = l_dispfilter-sign.
        l_dispfilter_db-option    = l_dispfilter-option.
        APPEND l_dispfilter_db TO lt_dispfilter_chk_db.
      ENDLOOP.
      SORT lt_dispfilter_chk BY fieldname.
      SORT lt_dispfilter_chk_db BY fieldname.
*     for some reason 'cwidth_opt' is filled with '1' sometimes
*     (is filled by method 'GET_FRONTENT_LAYOUT'?!)
*     --> so set to 'X' for checking of changes
      IF l_layout-cwidth_opt = '1'.
        l_layout-cwidth_opt = 'X'.
      ENDIF.
      IF l_layout_db-cwidth_opt = '1'.
        l_layout_db-cwidth_opt = 'X'.
      ENDIF.
*     for some reason 'cwidth_opt' is filled with '0' sometimes
*     (is filled by method 'GET_FRONTENT_LAYOUT'?!)
*     --> so set to ' ' for checking of changes (MED-34941)
      IF l_layout-cwidth_opt = 'O'.
        l_layout-cwidth_opt = ' '.
      ENDIF.
      IF l_layout_db-cwidth_opt = 'O'.
        l_layout_db-cwidth_opt = ' '.
      ENDIF.
*     Auch bei den Darstellungs-Attributen nur bestimmte Felder vergl.
      l_layout_chk-zebra      = l_layout-zebra.
      l_layout_chk-no_headers = l_layout-no_headers.
      l_layout_chk-no_hgridln = l_layout-no_hgridln.
      l_layout_chk-no_vgridln = l_layout-no_vgridln.
      l_layout_chk-no_merging = l_layout-no_merging.
      l_layout_chk-cwidth_opt = l_layout-cwidth_opt.
      l_layout_chk-totals_bef = l_layout-totals_bef.
      l_layout_chk_db-zebra      = l_layout_db-zebra.
      l_layout_chk_db-no_headers = l_layout_db-no_headers.
      l_layout_chk_db-no_hgridln = l_layout_db-no_hgridln.
      l_layout_chk_db-no_vgridln = l_layout_db-no_vgridln.
      l_layout_chk_db-no_merging = l_layout_db-no_merging.
      l_layout_chk_db-cwidth_opt = l_layout_db-cwidth_opt.
      l_layout_chk_db-totals_bef = l_layout_db-totals_bef.
*     ID 10246: beim Sichttyp OP wird die Sortierung und das
*               Zebramuster vom Programm vorgegeben und
*               ist nicht vom User änderbar
*               --> daher auch nicht vergleichen
      IF i_view-viewtype = '011'.
        CLEAR:   l_layout_chk-zebra, l_layout_chk_db-zebra.
        REFRESH: lt_dispsort_chk, lt_dispsort_chk_db.
      ENDIF.
*     --> jetzt die gepufferte AVAR mit der von der DB vergleichen
      IF lt_dispvar_chk[]    <> lt_dispvar_chk_db[]    OR
         lt_dispsort_chk[]   <> lt_dispsort_chk_db[]   OR
         lt_dispfilter_chk[] <> lt_dispfilter_chk_db[] OR
         l_layout_chk        <> l_layout_chk_db        OR
         i_save_type          = 'V'.
*       Anzeigevariante wurde geändert ... Berechtigung prüfen
*        AUTHORITY-CHECK OBJECT 'N_VM_DEF' ID 'ACTVT' FIELD '23'.
*        IF sy-subrc <> 0.           " keine Administratorrechte
*       ID 8514: Die Entscheidung, ob das Layout persönlich oder
*                zur Sicht gesichert werden soll, ist nicht mehr
*                von der 'Administrator'-Berechtigung abhängig,
*                sondern von einem neuen Import-Parameter
        IF i_save_type = 'U'.
*         -> als persönliches Layout sichern
          l_answer        = '1'.
          l_save_to_view  = off.
          l_save_userspec = on.
          l_update_buffer = off.
        ELSEIF i_save_type = 'V'.
*         -> zur Sicht sichern
          l_answer        = '2'.
          l_save_to_view  = on.
          l_save_userspec = off.
          l_update_buffer = off.
        ELSEIF i_save_type = 'P'.
*         -> Entscheidungs-Popup, ob die Variante
*         zur Sicht oder als Persönliche gesichert werden soll
          l_txt = 'Wie soll das Layout gesichert werden?'(007).
          CALL FUNCTION 'POPUP_TO_CONFIRM'
            EXPORTING
              titlebar      = l_view_txt
              text_question = l_txt
              text_button_1 = 'Persönlich'(009)
              text_button_2 = 'Allgemein'(010)
            IMPORTING
              answer        = l_answer
            EXCEPTIONS
              OTHERS        = 0.
          CASE l_answer.
            WHEN '1'.                                   " Persönlich
              l_save_to_view  = off.
              l_save_userspec = on.
*             Puffer nicht hier refreshen, sondern das macht der
*             Aufrufer, da dort erst der Personalisierungs-Eintrag
*             erstellt wird, der hier ja noch nicht gelesen werden kann
              l_update_buffer = off.
            WHEN '2'.                                   " Benutzerüb.
              l_save_to_view  = on.
              l_save_userspec = off.
*             Buffer nicht im FuB 'ISHMED_VM_AVAR_CHANGE' updaten,
*             sondern hier dann im Anschluß, da er nicht upgedated,
*             sondern refreshed werden muß; denn falls ein persönl.
*             Layout existiert, und das aktuelle Layout wird hier
*             als Benutzerübergreifendes zur Sicht gespeichert,
*             dann soll in Folge das Persönliche wieder angezeigt werden
              l_update_buffer = off.
            WHEN OTHERS.                                " Cancel
              l_save_to_view  = off.
              l_save_userspec = off.
*             ID 6420: Bei Abbrechen soll das 'alte' Layout
*                      wiederhergestellt werden; daher Puffer refreshen
              l_update_buffer = off.
          ENDCASE.
        ELSE.
          l_save_to_view  = off.
          l_save_userspec = off.
          l_update_buffer = off.
        ENDIF.
*       Persönl. Anzeigevariante einer Sicht anlegen oder ändern
        IF l_answer = '1' OR l_answer = '2'.
          CALL FUNCTION 'ISHMED_VM_AVAR_CHANGE'
               EXPORTING
                  i_view                = i_view
                  i_place               = i_place
                  i_mode                = 'S'        " sichern
                  i_vcode               = i_vcode
                  i_save                = l_save_to_view
                  i_update_task         = i_update_task
                  i_commit              = i_commit
                  i_caller              = 'LN1AVARU02'
*                 I_READ_BUFFER         = 'X'
                  i_update_buffer       = l_update_buffer
*                 I_READ_VIEWVAR        = 'X'
*                 I_AVARIANTID          = ' '
                  i_user_specific       = l_save_userspec
                  i_screen              = ' '
               IMPORTING
                  e_rc                  = e_rc
                  e_viewvar             = l_viewvar
               TABLES
                  t_messages            = t_messages.
          IF e_rc = 0 AND l_answer = '1'.
            e_changed = on.
          ENDIF.
        ELSE.
          e_rc = 0.
        ENDIF.
*       Den Puffer beim Speichern von Benutzerübergreifenden
*       oder beim Wiederherstellen bei Abbrechen nun refreshen
        IF e_rc = 0 AND l_update_buffer = off AND l_save_userspec = off.
          CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
            EXPORTING
              i_viewid     = i_view-viewid
              i_viewtype   = i_view-viewtype
              i_mode       = 'R'
              i_caller     = 'LN1AVARU02'
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
      ENDIF.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

* Sicht mit Anzeigevariante zurückliefern
  e_viewvar = l_viewvar.

ENDFUNCTION.
