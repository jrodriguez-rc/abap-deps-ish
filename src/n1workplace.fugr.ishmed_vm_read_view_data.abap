FUNCTION ishmed_vm_read_view_data.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEWID) LIKE  NWVIEW-VIEWID
*"     VALUE(I_VIEWTYPE) LIKE  NWVIEW-VIEWTYPE
*"     VALUE(I_MODE) TYPE  C DEFAULT 'L'
*"     VALUE(I_CALLER) LIKE  SY-REPID
*"     VALUE(I_PLACEID) LIKE  NWPLACE-WPLACEID OPTIONAL
*"     VALUE(I_PLACETYPE) LIKE  NWPLACE-WPLACETYPE DEFAULT '001'
*"     VALUE(I_CONV_FUNC) TYPE  C DEFAULT 'X'
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"     VALUE(E_SELVAR_TXT) LIKE  VARIT-VTEXT
*"     VALUE(E_VIEW) TYPE  V_NWVIEW
*"     VALUE(E_VIEWVAR) TYPE  RNVIEWVAR
*"     VALUE(E_GRID_ROW_MARKER) TYPE  N_ROW_MARKER
*"     VALUE(E_TREE_OPEN_NODES) TYPE  N_OPEN_NODES
*"     VALUE(E_REFRESH) TYPE  RNREFRESH
*"     VALUE(E_REFRESH_USER) TYPE  ISH_ON_OFF
*"  TABLES
*"      T_SELVAR STRUCTURE  RSPARAMS OPTIONAL
*"      T_SELPARAM STRUCTURE  VANZ OPTIONAL
*"      T_FVAR STRUCTURE  V_NWFVAR OPTIONAL
*"      T_FVAR_BUTTON STRUCTURE  V_NWBUTTON OPTIONAL
*"      T_FVAR_FUTXT STRUCTURE  V_NWFVARP OPTIONAL
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"  CHANGING
*"     REFERENCE(C_DISPVAR) TYPE  LVC_T_FCAT OPTIONAL
*"     REFERENCE(C_DISPSORT) TYPE  LVC_T_SORT OPTIONAL
*"     REFERENCE(C_DISPFILTER) TYPE  LVC_T_FILT OPTIONAL
*"     REFERENCE(C_LAYOUT) TYPE  LVC_S_LAYO OPTIONAL
*"----------------------------------------------------------------------
  DATA: lt_rsparams       TYPE tyt_selvars,
        lt_message        TYPE tyt_messages,
        lt_fvar           TYPE tyt_fvar,
        lt_button         TYPE tyt_button,
        lt_fvarp          TYPE tyt_fvarp,
        lt_params         TYPE TABLE OF vanz.               " ID 9860
  DATA: l_wa_nwview       LIKE nwview,
        l_wa_msg          LIKE bapiret2,
        l_wa_selbuf       TYPE ty_selvarbuf,
        l_wa_dispsort     TYPE lvc_s_sort,
        l_wa_dispfilter   TYPE lvc_s_filt,
        l_wa_dispbuf      TYPE ty_dispvarbuf,
        l_wa_dispsortbuf  TYPE ty_dispsortbuf,
        l_wa_dispfiltbuf  TYPE ty_dispfiltbuf,
        l_wa_layoutbuf    TYPE ty_layoutbuf,
        l_wa_fvarbuf      TYPE ty_fvarbuf,
        l_wa_buttonbuf    TYPE ty_buttonbuf,
        l_wa_fvarpbuf     TYPE ty_fvarpbuf,
        l_wa_place_001    TYPE nwplace_001,
        l_nwplace         TYPE nwplace,                     " ID 12249
        l_viewvar         TYPE rnviewvar,
        l_rnsvar          TYPE rnsvar,
        l_rnavar          TYPE rnavar,
        l_rnfvar          TYPE rnfvar,
        l_nwview_pers     TYPE nwview_pers,
        l_usr_param_value LIKE usr05-parva,
        l_datetime_get    TYPE ish_on_off,
        l_selparam_get    TYPE ish_on_off,
        l_rc              LIKE sy-subrc.

  FIELD-SYMBOLS: <ls_selvar>   TYPE ty_selvar,
                 <ls_dispvar>  TYPE lvc_s_fcat,
                 <ls_fvar>     TYPE ty_fvar,
                 <ls_fvarp>    TYPE ty_fvarp,
                 <ls_button>   TYPE ty_button.

  CLEAR: e_view, e_viewvar, l_rnsvar, l_rnavar, l_rnfvar,
         e_grid_row_marker, e_tree_open_nodes, e_refresh,
         e_refresh_user.

* Soll der FBS die Daten zurückliefern (entweder aus dem Puffer,
* oder von der Datenbank), müssen die Aufruftabellen gelöscht werden
  IF i_mode = 'L'  OR  i_mode = 'R'  OR i_mode = 'C'.
    CLEAR t_selvar.        REFRESH t_selvar.
    CLEAR t_fvar.          REFRESH t_fvar.
    CLEAR t_fvar_button.   REFRESH t_fvar_button.
    CLEAR t_fvar_futxt.    REFRESH t_fvar_futxt.
    CLEAR c_dispvar.       REFRESH c_dispvar.
    CLEAR c_dispsort.      REFRESH c_dispsort.
    CLEAR c_dispfilter.    REFRESH c_dispfilter.
    CLEAR c_layout.
  ENDIF.
  CLEAR t_messages.   REFRESH t_messages.
  REFRESH lt_message.

  IF i_viewid IS INITIAL.
    EXIT.
  ENDIF.

* Einlesen der gewünschten Sicht, um die Attribute zu erhalten
  IF i_mode <> 'C'.
    SELECT SINGLE * FROM nwview INTO l_wa_nwview
                    WHERE viewid   = i_viewid
                    AND   viewtype = i_viewtype.
    IF sy-subrc <> 0.
*     Die Sicht & (Sichttyp &) wurde nicht gefunden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '228' i_viewid i_viewtype space space
                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      e_rc = 1.
      EXIT.
    ENDIF.
    IF e_view IS REQUESTED.
      MOVE-CORRESPONDING l_wa_nwview TO e_view.             "#EC ENHOK
      SELECT SINGLE spras txt FROM nwpvzt
                    INTO (e_view-spras, e_view-txt)
             WHERE  wplacetype  = i_placetype
             AND    wplaceid    = i_placeid
             AND    viewtype    = l_wa_nwview-viewtype
             AND    viewid      = l_wa_nwview-viewid
             AND    spras       = sy-langu.
      IF sy-subrc <> 0 OR e_view-txt IS INITIAL.
        SELECT SINGLE spras txt FROM nwviewt
                      INTO (e_view-spras, e_view-txt)
                      WHERE viewtype = l_wa_nwview-viewtype
                      AND   viewid   = l_wa_nwview-viewid
                      AND   spras    = sy-langu.
      ENDIF.
    ENDIF.

*   Je Sichttyp aus der speziellen Tabelle die Varianten lesen
    CLEAR: l_viewvar.
    PERFORM get_viewvar USING    i_viewtype  i_viewid
                        CHANGING l_viewvar   e_refresh
                                 e_rc.
    IF e_rc <> 0.
      IF i_placetype = '001'.
*       Die Sicht & (Sichttyp &) wurde nicht gefunden
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF1' '228' i_viewid i_viewtype space space
                      space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO t_messages.
        EXIT.
      ELSE.
        e_rc = 0.
      ENDIF.
    ENDIF.

*   Personalisierungsinformation zur Sicht lesen                ID 6486
    IF i_caller    <> 'LN1VIEWU01' AND  " Außer im Sichtpflege-Popup ...
       i_caller(9) <> 'LN1WPCOPY'.      " und beim Kopieren von Sichten!
      SELECT SINGLE * FROM nwview_pers INTO l_nwview_pers
             WHERE  benutzer  = sy-uname
             AND    viewtype  = l_wa_nwview-viewtype
             AND    viewid    = l_wa_nwview-viewid.
      IF sy-subrc = 0.
*       Persönliche Selektionsvariante vorhanden?
        IF NOT l_nwview_pers-reports    IS INITIAL AND
           NOT l_nwview_pers-svariantid IS INITIAL.
          l_viewvar-reports    = l_nwview_pers-reports.
          l_viewvar-svariantid = l_nwview_pers-svariantid.
          l_viewvar-flag1      = l_nwview_pers-flag1.
          l_viewvar-flag2      = l_nwview_pers-flag2.
        ENDIF.
*       Persönliches Layout vorhanden?
        IF NOT l_nwview_pers-reporta    IS INITIAL AND
           NOT l_nwview_pers-username   IS INITIAL AND
           NOT l_nwview_pers-avariantid IS INITIAL.
          l_viewvar-reporta    = l_nwview_pers-reporta.
          l_viewvar-handle     = l_nwview_pers-handle.
          l_viewvar-log_group  = l_nwview_pers-log_group.
          l_viewvar-username   = l_nwview_pers-username.
          l_viewvar-avariantid = l_nwview_pers-avariantid.
          l_viewvar-type       = l_nwview_pers-type.
        ENDIF.
*       Persönliche Funktionsvariante vorhanden?
        IF NOT l_nwview_pers-fvariantid IS INITIAL.
          l_viewvar-fvariantid = l_nwview_pers-fvariantid.
        ENDIF.
      ELSE.
        CLEAR l_nwview_pers.
        l_nwview_pers-grid_row_marker = '*'.
        l_nwview_pers-tree_open_nodes = '*'.
      ENDIF.
*     Falls noch kein persönlicher Wert gepflegt wurde, dann den
*     Benutzerparameter lesen (für Trees je Sichttyp)
      IF l_nwview_pers-grid_row_marker = '*'.
        CLEAR l_usr_param_value.
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
            OTHERS           = 4.                           "#EC *
        IF sy-subrc <> 0.
          CLEAR l_usr_param_value.
        ENDIF.
        l_nwview_pers-grid_row_marker = l_usr_param_value.
      ENDIF.
      IF l_nwview_pers-tree_open_nodes = '*'.
        CASE i_viewtype.
          WHEN '004'.
            GET PARAMETER ID 'N1WP_004_EXP'
                          FIELD l_nwview_pers-tree_open_nodes.
          WHEN OTHERS.
            CLEAR l_nwview_pers-tree_open_nodes.
        ENDCASE.
      ENDIF.
*     Werte zurückliefern
      e_grid_row_marker = l_nwview_pers-grid_row_marker.
      e_tree_open_nodes = l_nwview_pers-tree_open_nodes.
      IF e_refresh-rfsh = on AND
         NOT l_nwview_pers-rfsh_interval IS INITIAL.
        e_refresh-rfsh_interval = l_nwview_pers-rfsh_interval.
        e_refresh_user          = on.
      ENDIF.
    ENDIF.

*   Varianten merken
    e_viewvar = l_viewvar.
    MOVE-CORRESPONDING l_viewvar TO l_rnsvar.               "#EC ENHOK
    MOVE-CORRESPONDING l_viewvar TO l_rnavar.               "#EC ENHOK
    MOVE-CORRESPONDING l_viewvar TO l_rnfvar.               "#EC ENHOK

  ENDIF.           " if i_mode <> 'C'

* Refresh: D.h. die Daten zu dieser Sicht sollen erneut
* von der DB gelesen werden. Dazu hier die Daten aus den
* globalen Tabellen entfernen. Weiter unten werden sie dann
* frisch aus der DB gelesen
* Bei Modus = 'U' (d.h. Update) werden hier auch die alten
* Werte gelöscht, um "saubere" Puffertabellen zu erhalten
  IF i_mode = 'R'  OR  i_mode = 'U'.
*   Selektionsvarianten
    IF t_selvar IS REQUESTED  OR
       ( e_view IS REQUESTED AND e_view-txt CA '&' ) OR
       e_selvar_txt IS REQUESTED.
*     Bei Update Gepufferte Variante merken
      IF l_viewvar-svariantid IS INITIAL AND i_mode = 'U'.
        READ TABLE gt_selvar INTO l_wa_selbuf WITH KEY
                                  wplacetype = i_placetype
                                  wplaceid   = i_placeid
                                  viewtype   = i_viewtype
                                  viewid     = i_viewid.
        IF sy-subrc = 0.
          MOVE-CORRESPONDING l_wa_selbuf TO l_rnsvar.       "#EC ENHOK
        ENDIF.
      ENDIF.
      DELETE gt_selvar WHERE wplacetype = i_placetype
                       AND   wplaceid   = i_placeid
                       AND   viewtype   = i_viewtype
                       AND   viewid     = i_viewid.
    ENDIF.
*   Anzeigevarianten
    IF c_dispvar    IS REQUESTED OR
       c_dispsort   IS REQUESTED OR
       c_dispfilter IS REQUESTED OR
       c_layout     IS REQUESTED.
*     Bei Update Gepufferte Variante merken
*     if l_viewvar-avariantid is initial and i_mode = 'U'. " rem 5683
      IF i_mode = 'U'.                                      "  ID 5683
        READ TABLE gt_dispvar INTO l_wa_dispbuf WITH KEY
                                   viewtype = i_viewtype
                                   viewid   = i_viewid.
        IF sy-subrc = 0.
          MOVE-CORRESPONDING l_wa_dispbuf TO l_rnavar.      "#EC ENHOK
          MOVE-CORRESPONDING l_rnavar     TO e_viewvar.     "#EC ENHOK
        ENDIF.
      ENDIF.
      DELETE gt_dispvar    WHERE viewid   = i_viewid
                           AND   viewtype = i_viewtype.
      DELETE gt_dispsort   WHERE viewid   = i_viewid
                           AND   viewtype = i_viewtype.
      DELETE gt_dispfilter WHERE viewid   = i_viewid
                           AND   viewtype = i_viewtype.
      DELETE gt_lvc_layout WHERE viewid   = i_viewid
                           AND   viewtype = i_viewtype.
    ENDIF.
*   Funktionsvarianten
    IF t_fvar        IS REQUESTED  OR
       t_fvar_button IS REQUESTED  OR
       t_fvar_futxt  IS REQUESTED.
*     Bei Update Gepufferte Variante merken
      IF l_viewvar-fvariantid IS INITIAL AND i_mode = 'U'.
        READ TABLE gt_fvar INTO l_wa_fvarbuf WITH KEY
                                viewtype = i_viewtype
                                viewid   = i_viewid.
        IF sy-subrc = 0.
          MOVE-CORRESPONDING l_wa_fvarbuf TO l_rnfvar.      "#EC ENHOK
        ENDIF.
      ENDIF.
      DELETE gt_fvar   WHERE viewid   = i_viewid
                       AND   viewtype = i_viewtype.
      DELETE gt_fvarp  WHERE viewid   = i_viewid
                       AND   viewtype = i_viewtype.
      DELETE gt_button WHERE viewid   = i_viewid
                       AND   viewtype = i_viewtype.
    ENDIF.
  ELSEIF i_mode = 'C'.
*   Alle Puffer löschen
    IF i_viewid IS INITIAL OR i_viewtype IS INITIAL.
      IF t_selvar IS REQUESTED.
        REFRESH: gt_selvar.
      ENDIF.
      IF c_dispvar    IS REQUESTED OR
         c_dispsort   IS REQUESTED OR
         c_dispfilter IS REQUESTED OR
         c_layout     IS REQUESTED.
        REFRESH: gt_dispvar, gt_dispsort, gt_dispfilter, gt_lvc_layout.
      ENDIF.
      IF t_fvar        IS REQUESTED  OR
         t_fvar_button IS REQUESTED  OR
         t_fvar_futxt  IS REQUESTED.
        REFRESH: gt_fvar, gt_fvarp, gt_button.
      ENDIF.
    ELSE.
      IF t_selvar IS REQUESTED.
        DELETE gt_selvar     WHERE wplacetype = i_placetype
                             AND   wplaceid   = i_placeid
                             AND   viewtype   = i_viewtype
                             AND   viewid     = i_viewid.
      ENDIF.
      IF c_dispvar    IS REQUESTED OR
         c_dispsort   IS REQUESTED OR
         c_dispfilter IS REQUESTED OR
         c_layout     IS REQUESTED.
        DELETE gt_dispvar    WHERE viewtype   = i_viewtype
                             AND   viewid     = i_viewid.
        DELETE gt_dispsort   WHERE viewid     = i_viewid
                             AND   viewtype   = i_viewtype.
        DELETE gt_dispfilter WHERE viewid     = i_viewid
                             AND   viewtype   = i_viewtype.
        DELETE gt_lvc_layout WHERE viewid     = i_viewid
                             AND   viewtype   = i_viewtype.
      ENDIF.
      IF t_fvar        IS REQUESTED  OR
         t_fvar_button IS REQUESTED  OR
         t_fvar_futxt  IS REQUESTED.
        DELETE gt_fvar       WHERE viewtype   = i_viewtype
                             AND   viewid     = i_viewid.
        DELETE gt_fvarp      WHERE viewtype   = i_viewtype
                             AND   viewid     = i_viewid.
        DELETE gt_button     WHERE viewtype   = i_viewtype
                             AND   viewid     = i_viewid.
      ENDIF.
    ENDIF.
    EXIT.
  ENDIF.   " if i_mode = 'R'  or  i_mode = 'U'  elseif i_mode = 'C'.

* Einlesen der Daten von den internen (Puffer-)Tabellen, oder wenn
* dort nicht vorhanden, von der Datenbank
  IF i_mode = 'L'  OR  i_mode = 'R'.

*   Lesen IS-H*MED-Kennzeichen
    PERFORM check_ishmed CHANGING g_ishmed_used.

*   Bestimmen der Selektionsvarianten (ev. inkl. Variantenattribute)
    IF t_selvar IS REQUESTED   OR
       ( e_view IS REQUESTED   AND e_view-txt CA '&' ) OR
       t_selparam IS REQUESTED OR e_selvar_txt IS REQUESTED.
      IF t_selvar IS REQUESTED.
        l_datetime_get = on.
      ELSE.
        l_datetime_get = off.
      ENDIF.
      IF t_selparam IS REQUESTED.
        l_selparam_get = on.
      ELSE.
        l_selparam_get = off.
      ENDIF.
      PERFORM fetch_selvar USING    l_viewvar
                                    i_placetype i_placeid
                                    i_conv_func
                                    l_datetime_get
                                    l_selparam_get
                           CHANGING lt_rsparams
                                    lt_params
                                    lt_message  l_rc  l_rnsvar.
*MED-46958,AM
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*END MED-46958,AM
      t_selparam[] = lt_params[].               " Variantenattribute
      IF NOT l_rnsvar IS INITIAL.
        MOVE-CORRESPONDING l_rnsvar TO e_viewvar.           "#EC ENHOK
        MOVE-CORRESPONDING l_rnsvar TO l_viewvar.           "#EC ENHOK
      ENDIF.
      APPEND LINES OF lt_message  TO t_messages.
      APPEND LINES OF lt_rsparams TO t_selvar.
      IF e_selvar_txt IS REQUESTED.
        CALL FUNCTION 'RS_VARIANT_TEXT'
             EXPORTING
                  curr_report  = l_viewvar-reports
                  langu        = sy-langu
                  variant      = l_viewvar-svariantid
*           ALL_VARIANTS = ' '
             IMPORTING
                  v_text       = e_selvar_txt
             EXCEPTIONS
                  OTHERS       = 2.
        IF sy-subrc <> 0.
          CLEAR e_selvar_txt.
        ENDIF.
      ENDIF.   " IF e_selvar_txt IS REQUESTED.
    ENDIF.   " IF T_SELVAR IS REQUESTED  OR  ...
**   ID 9860: Variantenattribute auslesen
*    (REM ID 11341 --> moved to form fetch_selvar!)
*    IF t_selparam IS REQUESTED.
*      REFRESH: lt_params, lt_selop, lt_params_nonv,
*               lt_selop_nonv, lt_selvar_dummy.
*      IF NOT l_viewvar-svariantid IS INITIAL.
*        CALL FUNCTION 'RS_VARIANT_CONTENTS'
*          EXPORTING
*            report               = l_viewvar-reports
*            variant              = l_viewvar-svariantid
*          TABLES
*            l_params             = lt_params
*            l_params_nonv        = lt_params_nonv
*            l_selop              = lt_selop
*            l_selop_nonv         = lt_selop_nonv
*            valutab              = lt_selvar_dummy
*          EXCEPTIONS
*            variant_non_existent = 1
*            variant_obsolete     = 2
*            OTHERS               = 3.
*        IF sy-subrc <> 0.
**         do nothing in case of error
*        ELSE.
*          APPEND LINES OF lt_selop TO lt_params.
**         vollständig unsichtbare Felder rauslöschen
*          DELETE lt_params_nonv WHERE invisible = 'N'.
*          DELETE lt_selop_nonv  WHERE invisible = 'N'.
**         ausgeblendete Felder auch übergeben
*          APPEND LINES OF lt_params_nonv TO lt_params.
*          APPEND LINES OF lt_selop_nonv  TO lt_params.
*          t_selparam[] = lt_params[].
*        ENDIF.
*      ENDIF.
*    ENDIF.   " ID T_SELPARAM IS REQUESTED.

*   Bestimmen der ALV-Anzeigevarianten
    IF c_dispvar    IS REQUESTED OR
       c_dispsort   IS REQUESTED OR
       c_dispfilter IS REQUESTED OR
       c_layout     IS REQUESTED.
      CLEAR l_nwplace.                                      " ID 12249
      l_nwplace-mandt      = sy-mandt.                      " ID 12249
      l_nwplace-wplacetype = i_placetype.                   " ID 12249
      l_nwplace-wplaceid   = i_placeid.                     " ID 12249
      PERFORM fetch_dispvar USING    l_viewvar
                                     l_nwplace
                            CHANGING c_dispvar  c_dispsort c_dispfilter
                                     c_layout
                                     lt_message l_rc       l_rnavar.
      IF NOT l_rnavar IS INITIAL.
        MOVE-CORRESPONDING l_rnavar TO e_viewvar.           "#EC ENHOK
        MOVE-CORRESPONDING l_rnavar TO l_viewvar.           "#EC ENHOK
      ENDIF.
      APPEND LINES OF lt_message  TO t_messages.
    ENDIF.

*   Bestimmen der Funktionsvarianten
    IF t_fvar        IS REQUESTED  OR
       t_fvar_button IS REQUESTED  OR
       t_fvar_futxt  IS REQUESTED.
      PERFORM fetch_funcvar USING    l_viewvar
                            CHANGING lt_fvar    lt_fvarp lt_button
                                     lt_message l_rc     l_rnfvar.
      IF NOT l_rnfvar IS INITIAL.
        MOVE-CORRESPONDING l_rnfvar TO e_viewvar.           "#EC ENHOK
        MOVE-CORRESPONDING l_rnfvar TO l_viewvar.           "#EC ENHOK
      ENDIF.
      APPEND LINES OF lt_message  TO t_messages.
      APPEND LINES OF lt_fvar     TO t_fvar.
      APPEND LINES OF lt_fvarp    TO t_fvar_futxt.
      APPEND LINES OF lt_button   TO t_fvar_button.
    ENDIF.

* UPDATE, d.h. dem FBS werden Daten mitgegeben, die er in seinen
* Puffer stellen muss
  ELSEIF i_mode = 'U'.

*   Selektionsvarianten
*   Sind die OEs des Arbeitsumfeldes befüllt, aber die der
*   Selektionsvariante leer, sollen sie aus dem A.Umfeld befüllt werden
*    clear l_wa_place_001.
*    PERFORM fill_oe_from_wplace USING    l_wa_nwview-viewtype
*                                         i_placetype i_placeid
*                                         l_wa_place_001
*                                CHANGING t_selvar[].
    LOOP AT t_selvar ASSIGNING <ls_selvar>.
      MOVE-CORRESPONDING <ls_selvar> TO l_wa_selbuf.        "#EC ENHOK
      MOVE-CORRESPONDING l_rnsvar    TO l_wa_selbuf.        "#EC ENHOK
      l_wa_selbuf-viewid     = l_wa_nwview-viewid.
      l_wa_selbuf-viewtype   = l_wa_nwview-viewtype.
      l_wa_selbuf-wplaceid   = i_placeid.
      l_wa_selbuf-wplacetype = i_placetype.
      APPEND l_wa_selbuf TO gt_selvar.
    ENDLOOP.
    MOVE-CORRESPONDING l_rnsvar TO e_viewvar.               "#EC ENHOK

*   ALV-Anzeigevarianten
    LOOP AT c_dispvar ASSIGNING <ls_dispvar>.
      MOVE-CORRESPONDING <ls_dispvar> TO l_wa_dispbuf.      "#EC ENHOK
      MOVE-CORRESPONDING l_rnavar     TO l_wa_dispbuf.      "#EC ENHOK
      l_wa_dispbuf-viewid   = l_wa_nwview-viewid.
      l_wa_dispbuf-viewtype = l_wa_nwview-viewtype.
      APPEND l_wa_dispbuf TO gt_dispvar.
    ENDLOOP.
    LOOP AT c_dispsort INTO l_wa_dispsort.
      MOVE-CORRESPONDING l_wa_dispsort TO l_wa_dispsortbuf. "#EC ENHOK
      l_wa_dispsortbuf-viewid   = l_wa_nwview-viewid.
      l_wa_dispsortbuf-viewtype = l_wa_nwview-viewtype.
      APPEND l_wa_dispsortbuf TO gt_dispsort.
    ENDLOOP.
    LOOP AT c_dispfilter INTO l_wa_dispfilter.
      MOVE-CORRESPONDING l_wa_dispfilter TO l_wa_dispfiltbuf."#EC ENHOK
      l_wa_dispfiltbuf-viewid   = l_wa_nwview-viewid.
      l_wa_dispfiltbuf-viewtype = l_wa_nwview-viewtype.
      APPEND l_wa_dispfiltbuf TO gt_dispfilter.
    ENDLOOP.
    IF c_layout IS REQUESTED.
      MOVE-CORRESPONDING c_layout TO l_wa_layoutbuf.        "#EC ENHOK
      l_wa_layoutbuf-viewid   = l_wa_nwview-viewid.
      l_wa_layoutbuf-viewtype = l_wa_nwview-viewtype.
      APPEND l_wa_layoutbuf TO gt_lvc_layout.               "#EC ENHOK
    ENDIF.
    MOVE-CORRESPONDING l_rnavar TO e_viewvar.               "#EC ENHOK

*   Funktionsvarianten
    LOOP AT t_fvar ASSIGNING <ls_fvar>.
      MOVE-CORRESPONDING <ls_fvar> TO l_wa_fvarbuf.         "#EC ENHOK
      MOVE-CORRESPONDING l_rnfvar  TO l_wa_fvarbuf.         "#EC ENHOK
      l_wa_fvarbuf-viewid   = l_wa_nwview-viewid.
      l_wa_fvarbuf-viewtype = l_wa_nwview-viewtype.
      APPEND l_wa_fvarbuf TO gt_fvar.
    ENDLOOP.
    LOOP AT t_fvar_futxt ASSIGNING <ls_fvarp>.
      MOVE-CORRESPONDING <ls_fvarp> TO l_wa_fvarpbuf.       "#EC ENHOK
      l_wa_fvarpbuf-viewid   = l_wa_nwview-viewid.
      l_wa_fvarpbuf-viewtype = l_wa_nwview-viewtype.
      APPEND l_wa_fvarpbuf TO gt_fvarp.
    ENDLOOP.
    LOOP AT t_fvar_button ASSIGNING <ls_button>.
      MOVE-CORRESPONDING <ls_button> TO l_wa_buttonbuf.     "#EC ENHOK
      l_wa_buttonbuf-viewid   = l_wa_nwview-viewid.
      l_wa_buttonbuf-viewtype = l_wa_nwview-viewtype.
      APPEND l_wa_buttonbuf TO gt_button.
    ENDLOOP.
    MOVE-CORRESPONDING l_rnfvar TO e_viewvar.               "#EC ENHOK

  ENDIF.   " ELSEIF I_MODE = 'U'

* Platzhalter im Text der Sicht aus den OEs der Selektions-
* variante (wenn vorhanden) aktualisieren
* (außer beim Kopieren von Sichten)
  IF i_mode <> 'C' AND i_caller(9) <> 'LN1WPCOPY'.
    IF e_view IS REQUESTED AND e_view-txt CA '&'.
      CLEAR l_wa_place_001.
      DESCRIBE TABLE t_selvar.
      IF sy-tfill > 0.
        PERFORM refresh_oe_in_text TABLES   t_selvar
                                   USING    i_placetype
                                            i_placeid
                                            i_viewtype
                                            i_viewid
                                            l_wa_place_001
                                   CHANGING e_view-txt.
      ELSE.
        PERFORM fill_oe_in_text USING    i_placetype
                                         i_placeid
                                         l_wa_place_001
                                CHANGING e_view-txt.
      ENDIF.
    ENDIF.
  ENDIF.           " if i_mode <> 'C'

ENDFUNCTION.
