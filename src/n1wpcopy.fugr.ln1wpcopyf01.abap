*----------------------------------------------------------------------*
***INCLUDE LN1WPCOPYF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  save_wplace
*&---------------------------------------------------------------------*
*       save copied workplace tables
*----------------------------------------------------------------------*
*      -->PT_NWPVZ       workplace-view-connections
*      -->PT_NWPVZT      workplace-view-connections (texts)
*      -->PT_NWPUSZ      workplace-user-connections
*      -->PT_NWPUSZT     workplace-user-connections (texts)
*      -->P_NWPLACE      workplace
*      -->P_NWPLACET     workplace (text)
*      -->P_NWPLACE_001  workplace special data (clinical workplace)
*      -->P_UPDATE_TASK  in update task (ON/OFF)
*----------------------------------------------------------------------*
FORM save_wplace TABLES   pt_nwpvz             STRUCTURE nwpvz
                          pt_nwpvzt            STRUCTURE nwpvzt
                          pt_nwpusz            STRUCTURE nwpusz
                          pt_nwpuszt           STRUCTURE nwpuszt
                 USING    value(p_nwplace)     TYPE      nwplace
                          value(p_nwplacet)    TYPE      nwplacet
                          value(p_nwplace_001) TYPE      nwplace_001
                          value(p_update_task) TYPE      ish_on_off.

  DATA: lt_n_nwplace      LIKE TABLE OF vnwplace,
        lt_n_nwplacet     LIKE TABLE OF vnwplacet,
        lt_n_nwpvz        LIKE TABLE OF vnwpvz,
        lt_n_nwpvzt       LIKE TABLE OF vnwpvzt,
        lt_o_nwplace      LIKE TABLE OF vnwplace,
        lt_o_nwplacet     LIKE TABLE OF vnwplacet,
        lt_o_nwpvz        LIKE TABLE OF vnwpvz,
        lt_o_nwpvzt       LIKE TABLE OF vnwpvzt,
        l_wa_nwplace      LIKE vnwplace,
        l_wa_nwplacet     LIKE vnwplacet,
        l_wa_nwpvz        LIKE vnwpvz,
        l_wa_nwpvzt       LIKE vnwpvzt,
        l_nwpusz          LIKE vnwpusz,
        l_nwpuszt         LIKE vnwpuszt,
        lt_n_nwpusz       LIKE TABLE OF vnwpusz,
        lt_o_nwpusz       LIKE TABLE OF vnwpusz,
        lt_n_nwpuszt      LIKE TABLE OF vnwpuszt,
        lt_o_nwpuszt      LIKE TABLE OF vnwpuszt.
  DATA: lt_n_nwplace_001  LIKE TABLE OF vnwplace_001,
        lt_o_nwplace_001  LIKE TABLE OF vnwplace_001,
        l_wa_nwplace_001  LIKE vnwplace_001.

  CLEAR:   l_wa_nwplace, l_wa_nwplacet, l_wa_nwpvz,  l_wa_nwpvzt,
           l_nwpusz, l_nwpuszt.
  REFRESH: lt_n_nwplace, lt_n_nwplacet, lt_n_nwpvz,  lt_n_nwpvzt,
           lt_o_nwplace, lt_o_nwplacet, lt_o_nwpvz,  lt_o_nwpvzt,
           lt_n_nwpusz,  lt_n_nwpuszt,  lt_n_nwpusz, lt_o_nwpuszt.
  REFRESH: lt_n_nwplace_001, lt_o_nwplace_001.

* workplace data
  l_wa_nwplace    = p_nwplace.
  l_wa_nwplace-kz = 'I'.                                " Insert
  APPEND l_wa_nwplace TO lt_n_nwplace.

* workplace text data
  l_wa_nwplacet    = p_nwplacet.
  l_wa_nwplacet-kz = 'I'.                               " Insert
  APPEND l_wa_nwplacet TO lt_n_nwplacet.

* workplace-view-connections
  LOOP AT pt_nwpvz INTO l_wa_nwpvz.
    l_wa_nwpvz-kz = 'I'.                                " Insert
    APPEND l_wa_nwpvz TO lt_n_nwpvz.
  ENDLOOP.

* workplace-view-connections (texts)
  LOOP AT pt_nwpvzt INTO l_wa_nwpvzt.
    l_wa_nwpvzt-kz = 'I'.                               " Insert
    APPEND l_wa_nwpvzt TO lt_n_nwpvzt.
  ENDLOOP.

* workplace-user-connections
  LOOP AT pt_nwpusz INTO l_nwpusz.
    l_nwpusz-kz     = 'I'.
    APPEND l_nwpusz  TO lt_n_nwpusz.
  ENDLOOP.

* workplace-user-connections (texts)
  LOOP AT pt_nwpuszt INTO l_nwpuszt.
    l_nwpuszt-kz    = 'I'.
    APPEND l_nwpuszt TO lt_n_nwpuszt.
  ENDLOOP.

* Verbuchen
  DESCRIBE TABLE lt_n_nwplace.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPLACE' IN UPDATE TASK
        EXPORTING
          i_tcode     = sy-tcode
        TABLES
          t_n_nwplace = lt_n_nwplace
          t_o_nwplace = lt_o_nwplace.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPLACE'
        EXPORTING
          i_tcode     = sy-tcode
        TABLES
          t_n_nwplace = lt_n_nwplace
          t_o_nwplace = lt_o_nwplace.
    ENDIF.
  ENDIF.
  DESCRIBE TABLE lt_n_nwplacet.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPLACET' IN UPDATE TASK
        EXPORTING
          i_tcode      = sy-tcode
        TABLES
          t_n_nwplacet = lt_n_nwplacet
          t_o_nwplacet = lt_o_nwplacet.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPLACET'
        EXPORTING
          i_tcode      = sy-tcode
        TABLES
          t_n_nwplacet = lt_n_nwplacet
          t_o_nwplacet = lt_o_nwplacet.
    ENDIF.
  ENDIF.
  DESCRIBE TABLE lt_n_nwpvz.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPVZ' IN UPDATE TASK
        EXPORTING
          i_tcode   = sy-tcode
        TABLES
          t_n_nwpvz = lt_n_nwpvz
          t_o_nwpvz = lt_o_nwpvz.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPVZ'
        EXPORTING
          i_tcode   = sy-tcode
        TABLES
          t_n_nwpvz = lt_n_nwpvz
          t_o_nwpvz = lt_o_nwpvz.
    ENDIF.
  ENDIF.
  DESCRIBE TABLE lt_n_nwpvzt.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPVZT' IN UPDATE TASK
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwpvzt = lt_n_nwpvzt
          t_o_nwpvzt = lt_o_nwpvzt.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPVZT'
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwpvzt = lt_n_nwpvzt
          t_o_nwpvzt = lt_o_nwpvzt.
    ENDIF.
  ENDIF.
  DESCRIBE TABLE lt_n_nwpusz.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPUSZ' IN UPDATE TASK
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwpusz = lt_n_nwpusz
          t_o_nwpusz = lt_o_nwpusz.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPUSZ'
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwpusz = lt_n_nwpusz
          t_o_nwpusz = lt_o_nwpusz.
    ENDIF.
  ENDIF.
  DESCRIBE TABLE lt_n_nwpuszt.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPUSZT' IN UPDATE TASK
        EXPORTING
          i_tcode     = sy-tcode
        TABLES
          t_n_nwpuszt = lt_n_nwpuszt
          t_o_nwpuszt = lt_o_nwpuszt.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPUSZT'
        EXPORTING
          i_tcode     = sy-tcode
        TABLES
          t_n_nwpuszt = lt_n_nwpuszt
          t_o_nwpuszt = lt_o_nwpuszt.
    ENDIF.
  ENDIF.

* special workplace data
  IF NOT p_nwplace_001 IS INITIAL.
    CLEAR l_wa_nwplace_001.
    l_wa_nwplace_001    = p_nwplace_001.
    l_wa_nwplace_001-kz = 'I'.                           " Insert
    APPEND l_wa_nwplace_001 TO lt_n_nwplace_001.
*   Verbuchen
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPLACE_001' IN UPDATE TASK
        EXPORTING
          i_tcode         = sy-tcode
        TABLES
          t_n_nwplace_001 = lt_n_nwplace_001
          t_o_nwplace_001 = lt_o_nwplace_001.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPLACE_001'
        EXPORTING
          i_tcode         = sy-tcode
        TABLES
          t_n_nwplace_001 = lt_n_nwplace_001
          t_o_nwplace_001 = lt_o_nwplace_001.
    ENDIF.
  ENDIF.

ENDFORM.                    " save_wplace
*&---------------------------------------------------------------------*
*&      Form  save_view
*&---------------------------------------------------------------------*
*       save copied view tables
*----------------------------------------------------------------------*
*      -->P_NWVIEW      view
*      -->P_NWVIEWT     view text
*      -->P_VIEWVAR     special data of view
*      -->P_REFRESH     special autorefresh data of view
*      -->P_NWVIEW_SRC  source view (view that is copied)
*      -->P_UPDATE_TASK in update task (ON/OFF)
*----------------------------------------------------------------------*
FORM save_view USING  value(p_nwview)      TYPE nwview
                      value(p_nwviewt)     TYPE nwviewt
                      value(p_viewvar)     TYPE rnviewvar
                      value(p_refresh)     TYPE rnrefresh
                      value(p_nwview_src)  TYPE nwview
                      value(p_update_task) TYPE ish_on_off.

  DATA: lt_n_nwview      LIKE TABLE OF vnwview,
        lt_n_nwviewt     LIKE TABLE OF vnwviewt,
        lt_o_nwview      LIKE TABLE OF vnwview,
        lt_o_nwviewt     LIKE TABLE OF vnwviewt,
        l_wa_nwview      LIKE vnwview,
        l_wa_nwviewt     LIKE vnwviewt.

  DATA: ls_wa_n          TYPE REF TO data,
        ls_wa_o          TYPE REF TO data,
        lt_ref_n         TYPE REF TO data,
        lt_ref_o         TYPE REF TO data,
        l_comp_kz(2)     TYPE c,
        l_comp_mandt     TYPE lvc_fname,
        l_comp_type_pg   TYPE lvc_fname,
        l_comp_id_pg     TYPE lvc_fname,
        l_comp_p01_obj   TYPE lvc_fname,
        l_comp_p01_view  TYPE lvc_fname,
        l_comp_p01_disp  TYPE lvc_fname,
        l_dbname_dummy   TYPE lvc_tname,
        l_dbname         TYPE lvc_tname,
        l_func_name      TYPE ish_fbname,
        ls_nwview_014    TYPE nwview_014,
        ls_nwview_p01    TYPE nwview_p01.

  FIELD-SYMBOLS: <l_wa_n>     TYPE ANY,
                 <l_wa_o>     TYPE ANY,
                 <l_kz>       TYPE vnwviewt-kz,
                 <l_mandt>    TYPE vnwviewt-mandt,
                 <l_type_pg>  TYPE vnwview_014-nwplacetype_pg,
                 <l_id_pg>    TYPE vnwview_014-nwplaceid_pg,
                 <l_p01_obj>  TYPE vnwview_p01-objecttype,
                 <l_p01_view> TYPE vnwview_p01-view_open,
                 <l_p01_disp> TYPE vnwview_p01-display_id,
                 <lt_n>       TYPE STANDARD TABLE,
                 <lt_o>       TYPE STANDARD TABLE.

  CLEAR:   lt_n_nwview, lt_n_nwviewt, lt_o_nwview, lt_o_nwviewt.
  REFRESH: lt_n_nwview, lt_n_nwviewt, lt_o_nwview, lt_o_nwviewt.
  CLEAR:   l_wa_nwview, l_wa_nwviewt.

* view data
  l_wa_nwview    = p_nwview.
  l_wa_nwview-kz = 'I'.                                   " Insert
  APPEND l_wa_nwview TO lt_n_nwview.

* view data (text)
  l_wa_nwviewt    = p_nwviewt.
  l_wa_nwviewt-kz = 'I'.                                  " Insert
  APPEND l_wa_nwviewt TO lt_n_nwviewt.

* Verbuchen
  DESCRIBE TABLE lt_n_nwview.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWVIEW' IN UPDATE TASK
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwview = lt_n_nwview
          t_o_nwview = lt_o_nwview.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWVIEW'
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwview = lt_n_nwview
          t_o_nwview = lt_o_nwview.
    ENDIF.
  ENDIF.

  DESCRIBE TABLE lt_n_nwviewt.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWVIEWT' IN UPDATE TASK
        EXPORTING
          i_tcode     = sy-tcode
        TABLES
          t_n_nwviewt = lt_n_nwviewt
          t_o_nwviewt = lt_o_nwviewt.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWVIEWT'
        EXPORTING
          i_tcode     = sy-tcode
        TABLES
          t_n_nwviewt = lt_n_nwviewt
          t_o_nwviewt = lt_o_nwviewt.
    ENDIF.
  ENDIF.

* special view data
  IF NOT p_viewvar IS INITIAL.
    CLEAR: l_dbname, l_func_name, ls_wa_n, ls_wa_o, lt_ref_n, lt_ref_o.
*   get name of view specific table (ID 18129)
    PERFORM get_view_specific IN PROGRAM sapln1workplace
                              USING      p_viewvar-viewtype
                              CHANGING   l_dbname_dummy
                                         l_dbname
                                         l_func_name.
    CHECK l_dbname IS NOT INITIAL AND l_func_name IS NOT INITIAL.
    CREATE DATA lt_ref_n TYPE STANDARD TABLE OF (l_dbname).
    ASSIGN lt_ref_n->* TO <lt_n>.
    CREATE DATA lt_ref_o TYPE STANDARD TABLE OF (l_dbname).
    ASSIGN lt_ref_o->* TO <lt_o>.
    CREATE DATA ls_wa_n LIKE LINE OF <lt_n>.
    ASSIGN ls_wa_n->* TO <l_wa_n>.
    CREATE DATA ls_wa_o LIKE LINE OF <lt_o>.
    ASSIGN ls_wa_o->* TO <l_wa_o>.
*   Neue Daten
    CLEAR <l_wa_n>.
    MOVE-CORRESPONDING p_viewvar TO <l_wa_n>.               "#EC ENHOK
    MOVE-CORRESPONDING p_refresh TO <l_wa_n>.               "#EC ENHOK
*   ID 13398: viewtype 014 has 2 additional fields
    IF p_viewvar-viewtype = '014'.
      SELECT SINGLE * FROM nwview_014 INTO ls_nwview_014
             WHERE  viewtype  = p_nwview_src-viewtype
             AND    viewid    = p_nwview_src-viewid.
      IF sy-subrc = 0.
        l_comp_type_pg   = 'NWPLACETYPE_PG'.
        ASSIGN COMPONENT l_comp_type_pg OF STRUCTURE <l_wa_n>
                         TO <l_type_pg>.
        <l_type_pg>      = ls_nwview_014-nwplacetype_pg.
        l_comp_id_pg     = 'NWPLACEID_PG'.
        ASSIGN COMPONENT l_comp_id_pg   OF STRUCTURE <l_wa_n>
                         TO <l_id_pg>.
        <l_id_pg>        = ls_nwview_014-nwplaceid_pg.
      ENDIF.
    ENDIF.
*   viewtype P01 (patient organizer) has 3 additional fields
    IF p_viewvar-viewtype = 'P01'.
      SELECT SINGLE * FROM nwview_p01 INTO ls_nwview_p01
             WHERE  viewtype  = p_nwview_src-viewtype
             AND    viewid    = p_nwview_src-viewid.
      IF sy-subrc = 0.
        l_comp_p01_obj   = 'OBJECTTYPE'.
        ASSIGN COMPONENT l_comp_p01_obj OF STRUCTURE <l_wa_n>
                         TO <l_p01_obj>.
        <l_p01_obj>      = ls_nwview_p01-objecttype.
        l_comp_p01_view  = 'VIEW_OPEN'.
        ASSIGN COMPONENT l_comp_p01_view OF STRUCTURE <l_wa_n>
                         TO <l_p01_view>.
        <l_p01_view>     = ls_nwview_p01-view_open.
        l_comp_p01_disp  = 'DISPLAY_ID'.
        ASSIGN COMPONENT l_comp_p01_disp OF STRUCTURE <l_wa_n>
                         TO <l_p01_disp>.
        <l_p01_disp>     = ls_nwview_p01-display_id.
      ENDIF.
    ENDIF.
*   mandant
    l_comp_mandt = 'MANDT'.
    ASSIGN COMPONENT l_comp_mandt OF STRUCTURE <l_wa_n> TO <l_mandt>.
    IF <l_mandt> IS INITIAL.
      <l_mandt> = sy-mandt.
    ENDIF.
*   insert flag
    l_comp_kz = 'KZ'.
    ASSIGN COMPONENT l_comp_kz OF STRUCTURE <l_wa_n> TO <l_kz>.
    <l_kz> = 'I'.
    APPEND <l_wa_n> TO <lt_n>.
*   Alte Daten
    CLEAR <l_wa_o>.
    MOVE-CORRESPONDING p_viewvar TO <l_wa_o>.               "#EC ENHOK
    MOVE-CORRESPONDING p_refresh TO <l_wa_o>.               "#EC ENHOK
    APPEND <l_wa_o> TO <lt_o>.
*   Verbucher aufrufen
    DESCRIBE TABLE <lt_n>.
    IF sy-tfill > 0.
      CALL FUNCTION l_func_name
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwview = <lt_n>
          t_o_nwview = <lt_o>.
    ENDIF.
  ENDIF.

ENDFORM.                    " save_view
*&---------------------------------------------------------------------*
*&      Form  variant_copy
*&---------------------------------------------------------------------*
*       copy variants of a view
*----------------------------------------------------------------------*
*      --> P_UPDATE_TASK  in update task (ON/OFF)
*      --> P_NEW_TEXT     new text for variants (ID 10499)
*      --> P_PLACETYPE    workplace type        (ID 12249)
*      --> P_PLACEID      workplace id          (ID 12249)
*      <-> P_VIEWVAR      variants to copy
*----------------------------------------------------------------------*
FORM variant_copy USING    value(p_update_task)  TYPE ish_on_off
                           value(p_new_text)     TYPE nviewstxt
                           value(p_placetype)    TYPE nwplace-wplacetype
                           value(p_placeid)      TYPE nwplace-wplaceid
                  CHANGING p_viewvar             TYPE rnviewvar.

  DATA: l_svar     TYPE rnsvar,
        l_avar     TYPE rnavar,
        l_fvar     TYPE rnfvar,
        l_svar_new TYPE rnsvar,
        l_avar_new TYPE rnavar,
        l_fvar_new TYPE rnfvar,
        l_svar_txt TYPE rvart_vtxt,                         " ID 10499
        l_avar_txt TYPE slis_varbz,                         " ID 10499
        l_fvar_txt TYPE nwfvartxt,                          " ID 10499
        l_nwplace  TYPE nwplace,                            " ID 12249
        l_rc       TYPE sy-subrc.

  CLEAR: l_svar, l_avar, l_fvar, l_svar_new, l_avar_new, l_fvar_new,
         l_rc, l_svar_txt, l_avar_txt, l_fvar_txt, l_nwplace.

  CHECK NOT p_viewvar IS INITIAL.

  l_nwplace-mandt      = sy-mandt.                          " ID 12249
  l_nwplace-wplacetype = p_placetype.                       " ID 12249
  l_nwplace-wplaceid   = p_placeid.                         " ID 12249

  MOVE-CORRESPONDING p_viewvar TO l_svar.                   "#EC ENHOK
  MOVE-CORRESPONDING p_viewvar TO l_avar.                   "#EC ENHOK
  MOVE-CORRESPONDING p_viewvar TO l_fvar.                   "#EC ENHOK

  l_svar_txt = p_new_text.                                  " ID 10499
  l_avar_txt = p_new_text.                                  " ID 10499
  l_fvar_txt = p_new_text.                                  " ID 10499

* copy selection variant if exists
* (variants beginning with & or sap-standard-variant can not be copied)
  IF NOT l_svar-svariantid    IS INITIAL AND
     NOT l_svar-reports       IS INITIAL AND
     NOT l_svar-svariantid(1)  = '&'     AND
     NOT l_svar-svariantid(4)  = 'SAP&'.
    CALL FUNCTION 'ISHMED_VM_SVAR_COPY'
      EXPORTING
        i_svar      = l_svar
        i_popup     = off
        i_viewtype  = p_viewvar-viewtype
        i_viewid    = p_viewvar-viewid
        i_svar_text = l_svar_txt                            " ID 10499
      IMPORTING
        e_svar      = l_svar_new
        e_rc        = l_rc.
    IF l_rc = 0 AND NOT l_svar_new IS INITIAL.
*     selection variant has been copied successfully
      p_viewvar-svariantid = l_svar_new-svariantid.
    ENDIF.
  ENDIF.

* copy display variant (layout) if exists
  IF NOT l_avar-avariantid IS INITIAL AND
     NOT l_avar-reporta    IS INITIAL.
    CALL FUNCTION 'ISHMED_VM_AVAR_COPY'
      EXPORTING
        i_avar      = l_avar
        i_popup     = off
        i_viewtype  = p_viewvar-viewtype
        i_viewid    = p_viewvar-viewid
        i_avar_text = l_avar_txt                            " ID 10499
        i_nwplace   = l_nwplace                             " ID 12249
      IMPORTING
        e_avar      = l_avar_new
        e_rc        = l_rc.
    IF l_rc = 0 AND NOT l_avar_new IS INITIAL.
*     layout has been copied successfully
      p_viewvar-avariantid = l_avar_new-avariantid.
    ENDIF.
  ENDIF.

* copy function variant if exists
  IF NOT l_fvar-fvariantid IS INITIAL.
    CALL FUNCTION 'ISHMED_VM_FVAR_COPY'
      EXPORTING
        i_fvar        = l_fvar
        i_popup       = off
        i_viewtype    = p_viewvar-viewtype
        i_viewid      = p_viewvar-viewid
        i_fvar_text   = l_fvar_txt                          " ID 10499
        i_commit      = off
        i_update_task = p_update_task
      IMPORTING
        e_fvar        = l_fvar_new
        e_rc          = l_rc.
    IF l_rc = 0 AND NOT l_fvar_new IS INITIAL.
*     function variant has been copied successfully
      p_viewvar-fvariantid = l_fvar_new-fvariantid.
    ENDIF.
  ENDIF.

ENDFORM.                    " variant_copy
*&---------------------------------------------------------------------*
*&      Form  get_new_svar_id
*&---------------------------------------------------------------------*
*       get a new id for a selection variant
*       (insert 01-nn at last position of id)
*----------------------------------------------------------------------*
*      --> P_REPORTS         report name
*      <-> P_VARIANT_NEW_ID  new selection variant id
*----------------------------------------------------------------------*
FORM get_new_svar_id USING    value(p_reports) TYPE rnsvar-reports
                     CHANGING p_variant_new_id TYPE rnsvar-svariantid.

  DATA: l_counter         TYPE i,
        l_counter_char(3) TYPE c,
        l_rc              TYPE sy-subrc,
        l_variant_new_id  TYPE rnsvar-svariantid.

  CHECK NOT p_variant_new_id IS INITIAL.

  CLEAR: l_counter, l_counter_char, l_rc, l_variant_new_id.

  DO.
    l_variant_new_id = p_variant_new_id.
    l_counter = l_counter + 1.
*   not over 999 - to much ...
    IF l_counter > 999.
      EXIT.
    ENDIF.
*   if under 10 - at least 2 characters have to be added
    IF l_counter > 9.
      l_counter_char = l_counter.
    ELSE.
      l_counter_char(1)   = '0'.
      l_counter_char+1(1) = l_counter.
    ENDIF.
*   add 01-nn to id
    IF l_counter < 100.
      IF l_variant_new_id+12(2) IS INITIAL.
        CONCATENATE l_variant_new_id l_counter_char
                    INTO l_variant_new_id.
      ELSE.
        l_variant_new_id+12(2) = l_counter_char.
      ENDIF.
    ELSE.
      IF l_variant_new_id+11(3) IS INITIAL.
        CONCATENATE l_variant_new_id l_counter_char
                    INTO l_variant_new_id.
      ELSE.
        l_variant_new_id+11(3) = l_counter_char.
      ENDIF.
    ENDIF.
*   does this variant id already exist?
    CALL FUNCTION 'RS_VARIANT_EXISTS'
      EXPORTING
        report              = p_reports
        variant             = l_variant_new_id
      IMPORTING
        r_c                 = l_rc
      EXCEPTIONS
        not_authorized      = 1
        no_report           = 2
        report_not_existent = 3
        report_not_supplied = 4
        OTHERS              = 5.
*   if it does not exist - leave DO/ENDDO
*   otherwise - get next id
    IF sy-subrc <> 0 OR l_rc <> 0.
      EXIT.
    ENDIF.
  ENDDO.

  IF sy-subrc <> 0 OR l_rc = 0 OR l_variant_new_id IS INITIAL.
*   clear id if nothing correct could be found
    CLEAR p_variant_new_id.
  ELSE.
*   new id has been found
    p_variant_new_id = l_variant_new_id.
  ENDIF.

ENDFORM.                    " get_new_svar_id
*&---------------------------------------------------------------------*
*&      Form  save_fvar
*&---------------------------------------------------------------------*
*       save new function variant
*----------------------------------------------------------------------*
*      --> PT_NWFVAR      function variant
*      --> PT_NWFVARP     functions
*      --> PT_NWBUTTON    buttons
*      --> P_UPDATE_TASK  in update task ON/OFF
*----------------------------------------------------------------------*
FORM save_fvar TABLES   pt_nwfvar             STRUCTURE v_nwfvar
                        pt_nwfvarp            STRUCTURE v_nwfvarp
                        pt_nwbutton           STRUCTURE v_nwbutton
               USING    value(p_update_task)  TYPE ish_on_off.

* vnwfvar
  DATA: lt_o_vnwfvar LIKE TABLE OF vnwfvar WITH HEADER LINE,
        lt_n_vnwfvar LIKE TABLE OF vnwfvar WITH HEADER LINE.
* vnwfvart
  DATA: lt_o_vnwfvart LIKE TABLE OF vnwfvart WITH HEADER LINE,
        lt_n_vnwfvart LIKE TABLE OF vnwfvart WITH HEADER LINE.
* vnwbutton
  DATA: lt_o_vnwbutton LIKE TABLE OF vnwbutton WITH HEADER LINE,
        lt_n_vnwbutton LIKE TABLE OF vnwbutton WITH HEADER LINE.
* vnwbuttont
  DATA: lt_o_vnwbuttont LIKE TABLE OF vnwbuttont WITH HEADER LINE,
        lt_n_vnwbuttont LIKE TABLE OF vnwbuttont WITH HEADER LINE.
* vnwfvarp
  DATA: lt_o_vnwfvarp LIKE TABLE OF vnwfvarp WITH HEADER LINE,
        lt_n_vnwfvarp LIKE TABLE OF vnwfvarp WITH HEADER LINE.
* vnwfvarpt
  DATA: lt_o_vnwfvarpt LIKE TABLE OF vnwfvarpt WITH HEADER LINE,
        lt_n_vnwfvarpt LIKE TABLE OF vnwfvarpt WITH HEADER LINE.

  DATA: l_wa_vnwfvar        LIKE vnwfvar.
  DATA: l_wa_vnwfvart       LIKE vnwfvart.
  DATA: l_wa_vnwbutton      LIKE vnwbutton.
  DATA: l_wa_vnwbuttont     LIKE vnwbuttont.
  DATA: l_wa_vnwfvarp       LIKE vnwfvarp.
  DATA: l_wa_vnwfvarpt      LIKE vnwfvarpt.

  DATA: l_wa_v_nwfvar   LIKE v_nwfvar.
  DATA: l_wa_v_nwbutton LIKE v_nwbutton.
  DATA: l_wa_v_nwfvarp  LIKE v_nwfvarp.

  CLEAR: lt_o_vnwfvar,      lt_n_vnwfvar.
  CLEAR: lt_o_vnwfvart,     lt_n_vnwfvart.
  CLEAR: lt_o_vnwbutton,    lt_n_vnwbutton.
  CLEAR: lt_o_vnwbuttont,   lt_n_vnwbuttont.
  CLEAR: lt_o_vnwfvarp,     lt_n_vnwfvarp.
  CLEAR: lt_o_vnwfvarpt,    lt_n_vnwfvarpt.

  REFRESH: lt_o_vnwfvar,    lt_n_vnwfvar.
  REFRESH: lt_o_vnwfvart,   lt_n_vnwfvart.
  REFRESH: lt_o_vnwbutton,  lt_n_vnwbutton.
  REFRESH: lt_o_vnwbuttont, lt_n_vnwbuttont.
  REFRESH: lt_o_vnwfvarp,   lt_n_vnwfvarp.
  REFRESH: lt_o_vnwfvarpt,  lt_n_vnwfvarpt.

* nwfvar(t)
  CLEAR: l_wa_v_nwfvar.
  LOOP AT pt_nwfvar INTO l_wa_v_nwfvar.
    CLEAR l_wa_vnwfvar.
    l_wa_vnwfvar-viewtype  = l_wa_v_nwfvar-viewtype.
    l_wa_vnwfvar-fvar      = l_wa_v_nwfvar-fvar.
    l_wa_vnwfvar-kz        = 'I'.
    APPEND l_wa_vnwfvar TO lt_n_vnwfvar.
    CLEAR l_wa_vnwfvart.
    l_wa_vnwfvart-viewtype  = l_wa_v_nwfvar-viewtype.
    l_wa_vnwfvart-fvar      = l_wa_v_nwfvar-fvar.
    l_wa_vnwfvart-spras     = sy-langu.
    l_wa_vnwfvart-txt       = l_wa_v_nwfvar-txt.
    l_wa_vnwfvart-kz        = 'I'.
    APPEND l_wa_vnwfvart TO lt_n_vnwfvart.
  ENDLOOP.

* nwbutton(t)
  CLEAR l_wa_v_nwbutton.
  LOOP AT pt_nwbutton INTO l_wa_v_nwbutton.
    CLEAR l_wa_vnwbutton.
    l_wa_vnwbutton-viewtype = l_wa_v_nwbutton-viewtype.
    l_wa_vnwbutton-fvar     = l_wa_v_nwbutton-fvar.
    l_wa_vnwbutton-buttonnr = l_wa_v_nwbutton-buttonnr.
    l_wa_vnwbutton-icon     = l_wa_v_nwbutton-icon.
    l_wa_vnwbutton-fcode    = l_wa_v_nwbutton-fcode.
    l_wa_vnwbutton-dbclk    = l_wa_v_nwbutton-dbclk.
    l_wa_vnwbutton-fkey     = l_wa_v_nwbutton-fkey.         " ID 10202
    l_wa_vnwbutton-kz       = 'I'.
    APPEND l_wa_vnwbutton TO lt_n_vnwbutton.
    CLEAR l_wa_vnwbuttont.
    l_wa_vnwbuttont-viewtype  = l_wa_v_nwbutton-viewtype.
    l_wa_vnwbuttont-fvar      = l_wa_v_nwbutton-fvar.
    l_wa_vnwbuttont-buttonnr  = l_wa_v_nwbutton-buttonnr.
    l_wa_vnwbuttont-spras     = sy-langu.
    l_wa_vnwbuttont-icon_q    = l_wa_v_nwbutton-icon_q.
    l_wa_vnwbuttont-buttontxt = l_wa_v_nwbutton-buttontxt.
    l_wa_vnwbuttont-kz        = 'I'.
    APPEND l_wa_vnwbuttont TO lt_n_vnwbuttont.
  ENDLOOP.

* nwfvarp(t)
  CLEAR l_wa_v_nwfvarp.
  LOOP AT pt_nwfvarp INTO l_wa_v_nwfvarp.
    CLEAR l_wa_vnwfvarp.
    l_wa_vnwfvarp-viewtype = l_wa_v_nwfvarp-viewtype.
    l_wa_vnwfvarp-fvar     = l_wa_v_nwfvarp-fvar.
    l_wa_vnwfvarp-buttonnr = l_wa_v_nwfvarp-buttonnr.
    l_wa_vnwfvarp-lfdnr    = l_wa_v_nwfvarp-lfdnr.
    l_wa_vnwfvarp-fcode    = l_wa_v_nwfvarp-fcode.
    l_wa_vnwfvarp-dbclk    = l_wa_v_nwfvarp-dbclk.
    l_wa_vnwfvarp-tb_butt  = l_wa_v_nwfvarp-tb_butt.
    l_wa_vnwfvarp-fkey     = l_wa_v_nwfvarp-fkey.           " ID 10202
    l_wa_vnwfvarp-kz       = 'I'.
    APPEND l_wa_vnwfvarp TO lt_n_vnwfvarp.
    CLEAR l_wa_vnwfvarpt.
    l_wa_vnwfvarpt-viewtype = l_wa_v_nwfvarp-viewtype.
    l_wa_vnwfvarpt-fvar     = l_wa_v_nwfvarp-fvar.
    l_wa_vnwfvarpt-buttonnr = l_wa_v_nwfvarp-buttonnr.
    l_wa_vnwfvarpt-lfdnr    = l_wa_v_nwfvarp-lfdnr.
    l_wa_vnwfvarpt-spras    = sy-langu.
    l_wa_vnwfvarpt-txt      = l_wa_v_nwfvarp-txt.
    l_wa_vnwfvarpt-kz       = 'I'.
    APPEND l_wa_vnwfvarpt TO lt_n_vnwfvarpt.
  ENDLOOP.

* Verbucher aufrufen
  PERFORM call_verbucher(sapln1fvar)
                         TABLES lt_n_vnwfvar    lt_o_vnwfvar
                                lt_n_vnwfvart   lt_o_vnwfvart
                                lt_n_vnwfvarp   lt_o_vnwfvarp
                                lt_n_vnwfvarpt  lt_o_vnwfvarpt
                                lt_n_vnwbutton  lt_o_vnwbutton
                                lt_n_vnwbuttont lt_o_vnwbuttont
                         USING  p_update_task.

ENDFORM.                    " save_fvar
