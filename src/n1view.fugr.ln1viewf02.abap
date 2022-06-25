*----------------------------------------------------------------------*
***INCLUDE LN1VIEWF02 .
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  help_avar_pg
*&---------------------------------------------------------------------*
*       F4-value-request for layouts of viewtype 014 (presentation
*       variants) -> ID 13398
*----------------------------------------------------------------------*
FORM help_avar_pg .

  DATA: l_fname         TYPE dynpread-fieldname,
        lt_dynpr        TYPE TABLE OF dynpread WITH HEADER LINE,
        lt_nwplace      TYPE TABLE OF nwplace,
        ls_nwplace      LIKE LINE OF lt_nwplace,
        lt_nwplacet     TYPE TABLE OF nwplacet,
        ls_nwplacet     LIKE LINE OF lt_nwplacet,
        l_einri         TYPE einri,
        l_okcode        TYPE sy-ucomm,
        l_rc            TYPE ish_method_rc,
        l_full_screen   TYPE ish_on_off.

  CHECK g_view-viewtype = '014'
        OR g_view-viewtype = '018'.                         "MED-33470
  CHECK g_vcode <> g_vcode_display.

  PERFORM get_einri CHANGING l_einri.

  REFRESH: lt_nwplace, lt_nwplacet.

* ---------- ---------- ----------
* if switch ishmed_scd is active display variant dialog full screen
  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.
    l_full_screen = abap_true.
  ELSE.
    l_full_screen = abap_false.
  ENDIF.

  CALL FUNCTION 'ISHMED_PG_AVAILABLE_VARIANTS'
    EXPORTING
      i_mode                = 'A'
      i_einri               = l_einri
      i_popup_on            = on
      i_display_full_screen = l_full_screen
    IMPORTING
      e_rc                  = l_rc
      e_okcode              = l_okcode
    TABLES
      et_nwplace            = lt_nwplace
      et_nwplacet           = lt_nwplacet.

  CHECK l_rc = 0.

  IF l_okcode = 'CANCEL' OR l_okcode = 'EXIT' OR l_okcode = 'RETURN'.
    EXIT.
  ENDIF.

  READ TABLE lt_nwplace INTO ls_nwplace INDEX 1.
  IF sy-subrc <> 0.
    MESSAGE s230 WITH ' ' ' ' sy-subrc.
*   Anzeigevariante & für Report & konnte nicht gef. werden (Fehler &)
    EXIT.
  ENDIF.

  READ TABLE lt_nwplacet INTO ls_nwplacet INDEX 1.
  CHECK sy-subrc = 0.

  g_placetype_pg = ls_nwplace-wplacetype.
  g_placeid_pg   = ls_nwplace-wplaceid.

  rn1_scr_view100-avar_txt = ls_nwplacet-txt.

* set text of presentation variant to dynpro field
  CLEAR lt_dynpr. REFRESH lt_dynpr.
  l_fname = 'RN1_SCR_VIEW100-AVAR_TXT'.
  lt_dynpr-fieldname  = l_fname.
  lt_dynpr-fieldvalue = rn1_scr_view100-avar_txt.
  APPEND lt_dynpr.
  PERFORM read_from_dynpro TABLES lt_dynpr USING 'W'.

ENDFORM.                    " help_avar_pg
*&---------------------------------------------------------------------*
*&      Form  check_avar_pg
*&---------------------------------------------------------------------*
*       check for layouts of viewtype 014 (presentation variants)
*       -> ID 13398
*----------------------------------------------------------------------*
FORM check_avar_pg .

  DATA: ls_nwplace        TYPE nwplace,                     "#EC NEEDED
        ls_n1wplace_pg    TYPE n1wplace_pg,                 "#EC NEEDED
        l_error           TYPE ish_on_off.

  CHECK g_view-viewtype = '014'
        OR g_view-viewtype = '018'.                         "MED-33470

  CLEAR l_error.

  IF NOT g_placetype_pg IS INITIAL AND
     NOT g_placeid_pg   IS INITIAL.
    SELECT SINGLE * FROM nwplace INTO ls_nwplace
           WHERE  wplacetype  = g_placetype_pg
           AND    wplaceid    = g_placeid_pg.
    IF sy-subrc = 0.
      SELECT SINGLE * FROM n1wplace_pg INTO ls_n1wplace_pg
             WHERE  nwplacetype  = g_placetype_pg
             AND    nwplaceid    = g_placeid_pg.
      IF sy-subrc = 0.
        EXIT.               " OK
      ELSE.
        l_error = on.
      ENDIF.
    ELSE.
      l_error = on.
    ENDIF.
    IF l_error = on.
      g_error = on.
      SET CURSOR FIELD 'RN1_SCR_VIEW100-AVAR_TXT'.
      MESSAGE i355 WITH g_placeid_pg.
*     presentation variant not found
*      MESSAGE i892 WITH g_placeid_pg.
      CLEAR: g_placetype_pg, g_placeid_pg.
    ENDIF.
  ENDIF.

ENDFORM.                    " check_avar_pg
*&---------------------------------------------------------------------*
*&      Form  avar_call_pg
*&---------------------------------------------------------------------*
*       create or change presentation variants for viewtype 014
*       -> ID 13398
*----------------------------------------------------------------------*
*      --> P_VCODE  Verarbeitungscode (INS oder UPD)
*----------------------------------------------------------------------*
FORM avar_call_pg  USING    value(p_vcode)  LIKE g_vcode
                   CHANGING p_rc            TYPE sy-subrc.

  DATA: l_einri           TYPE einri,
        l_rc              TYPE ish_method_rc,
        l_okcode          TYPE sy-ucomm,
        lt_n1wplace_pg    TYPE TABLE OF n1wplace_pg,
        ls_n1wplace_pg    TYPE n1wplace_pg,
        l_full_screen     TYPE ish_on_off.                  "MED-33470.

  p_rc = 0.

  CHECK g_view-viewtype = '014'
        OR g_view-viewtype = '018'.                         "MED-33470.

  CLEAR ls_n1wplace_pg.
  REFRESH lt_n1wplace_pg.

  IF p_vcode <> g_vcode_insert.
*   change presentation variant
    IF g_placetype_pg IS INITIAL OR g_placeid_pg IS INITIAL.
      MESSAGE i355 WITH g_placeid_pg.
      p_rc = 1.
*     presentation variant not found
*      MESSAGE i892 WITH g_placeid_pg.
      EXIT.
    ELSE.
      ls_n1wplace_pg-nwplacetype = g_placetype_pg.
      ls_n1wplace_pg-nwplaceid   = g_placeid_pg.
    ENDIF.
  ENDIF.

  PERFORM get_einri CHANGING l_einri.

* if switch ishmed_scd is active display variant dialog full screen
  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_true.     "MED-33470.
    l_full_screen = abap_true.
  ELSE.
    l_full_screen = abap_false.
  ENDIF.
* call dialog for presentation variants of appointment schedule
  CALL FUNCTION 'ISHMED_PG_VARIANT_DIALOG'
    EXPORTING
      i_einri               = l_einri
      is_n1wplace_pg        = ls_n1wplace_pg
      i_vcode               = p_vcode
      i_caller              = 'K'
      i_display_full_screen = l_full_screen                 "MED-33470.
    IMPORTING
      e_rc                  = l_rc
      e_okcode              = l_okcode
    TABLES
      et_n1wplace_pg        = lt_n1wplace_pg.
  IF l_rc <> 0.
    p_rc = 1.
    EXIT.
  ENDIF.
  IF l_okcode = 'CANCEL' OR l_okcode = 'EXIT' OR l_okcode = 'RETURN'. " popup cancelled
    p_rc = 2.
    EXIT.
  ELSEIF l_okcode = 'DEL_WPLACE'.                    " variant deleted
    CLEAR: g_placetype_pg, g_placeid_pg.
    EXIT.
  ENDIF.

  READ TABLE lt_n1wplace_pg INTO ls_n1wplace_pg INDEX 1.
  CHECK sy-subrc = 0 AND
        NOT ls_n1wplace_pg-nwplacetype IS INITIAL AND
        NOT ls_n1wplace_pg-nwplaceid   IS INITIAL.

  g_placetype_pg = ls_n1wplace_pg-nwplacetype.
  g_placeid_pg   = ls_n1wplace_pg-nwplaceid.

ENDFORM.                    " avar_call_pg
*&---------------------------------------------------------------------*
*&      Form  get_einri
*&---------------------------------------------------------------------*
*       get institution for workplace (ID 13398)
*----------------------------------------------------------------------*
*      <--P_EINRI  institution
*----------------------------------------------------------------------*
FORM get_einri  CHANGING p_einri    TYPE einri.

  CLEAR p_einri.
  IF NOT g_place IS INITIAL.
    SELECT SINGLE einri FROM nwplace_001 INTO p_einri
           WHERE  wplacetype  = g_place-wplacetype
           AND    wplaceid    = g_place-wplaceid.
  ENDIF.
  IF p_einri IS INITIAL.
    CALL FUNCTION 'ISH_GET_PARAMETER_ID'
      EXPORTING
        i_parameter_id    = 'EIN'
      IMPORTING
        e_parameter_value = p_einri.
  ENDIF.

ENDFORM.                    " get_einri
*&---------------------------------------------------------------------*
*&      Form  avar_delete_pg
*&---------------------------------------------------------------------*
*       delete presentation variants for viewtype 014
*       -> ID 13398
*----------------------------------------------------------------------*
FORM avar_delete_pg CHANGING p_cancel TYPE ish_on_off.

  DATA: l_cancel          TYPE ish_on_off,
        ls_n1wplace_pg    TYPE n1wplace_pg.

  CLEAR p_cancel.

  CHECK g_view-viewtype = '014'
        OR g_view-viewtype = '018'.                         "MED-33470

  CHECK g_vcode <> g_vcode_display.

  CHECK NOT g_placetype_pg IS INITIAL AND NOT g_placeid_pg IS INITIAL.

  CLEAR ls_n1wplace_pg.
  ls_n1wplace_pg-nwplacetype = g_placetype_pg.
  ls_n1wplace_pg-nwplaceid   = g_placeid_pg.

  PERFORM delete_avar_pg USING    ls_n1wplace_pg
                                  g_view
                                  on
                         CHANGING l_cancel.
  IF l_cancel = on.
    p_cancel = on.
    EXIT.
  ENDIF.

  CLEAR: g_placetype_pg, g_placeid_pg.

ENDFORM.                    " avar_delete_pg

*&---------------------------------------------------------------------*
*&      Form  delete_avar_pg
*&---------------------------------------------------------------------*
*       delete presentation variant if no longer used in
*       other views -> ID 13398
*----------------------------------------------------------------------*
FORM delete_avar_pg USING    value(p_n1wplace_pg) TYPE n1wplace_pg
                             value(p_view)        TYPE nwview
                             value(p_popup)       TYPE ish_on_off
                    CHANGING p_cancel             TYPE ish_on_off.

  DATA: l_avar_used     LIKE off,
        l_txt1(70)      TYPE c,
        l_txt2(70)      TYPE c,
        l_text(140)     TYPE c,
        l_icon_1        TYPE icon-name,
        l_icon_2        TYPE icon-name,
        l_answer(1)     TYPE c,
        l_anzvar_txt    LIKE rn1_scr_view100-avar_txt,
        l_dummy_stxt    LIKE rn1_scr_view100-svar_txt,
        l_dummy_ftxt    LIKE rn1_scr_view100-fvar_txt,
        l_dummy_svarid  LIKE rn1_scr_view100-svarid,
        l_dummy_avarid  LIKE rn1_scr_view100-avarid,
        l_dummy_fvarid  LIKE rn1_scr_view100-fvarid,
        l_dummy_repa    TYPE rnviewvar-reporta,
        l_dummy_reps    TYPE rnviewvar-reports,
        l_rc            TYPE ish_method_rc.

  p_cancel = off.

  CHECK NOT p_n1wplace_pg IS INITIAL.

  PERFORM check_avar_used_pg USING    p_n1wplace_pg
                                      p_view
                             CHANGING l_avar_used.
  IF l_avar_used = off.
*   send popup to decide if requested
    IF p_popup = on.
      PERFORM get_var_texts
              USING    off on off
                       l_dummy_svarid
                       l_dummy_avarid
                       l_dummy_fvarid
                       l_dummy_reps
                       l_dummy_repa
                       p_view-viewtype
                       p_view-viewid
              CHANGING l_dummy_stxt l_anzvar_txt l_dummy_ftxt.
      CONCATENATE 'Wollen Sie das Layout'(022)
                  l_anzvar_txt INTO l_txt1 SEPARATED BY space.
      l_txt2 = 'oder nur die Zuordnung zur Sicht löschen?'(023).
      CONCATENATE l_txt1 l_txt2 INTO l_text SEPARATED BY space.
      l_icon_1 = icon_delete.
      l_icon_2 = icon_disconnect.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          titlebar              = 'Layout löschen'(037)
*         diagnose_object       = ' '
          text_question         = l_text
          text_button_1         = 'Layout'(030)
          icon_button_1         = l_icon_1
          text_button_2         = 'Zuordnung'(015)
          icon_button_2         = l_icon_2
          default_button        = '1'
          display_cancel_button = 'X'
*         popup_type            = ' '
        IMPORTING
          answer                = l_answer
        EXCEPTIONS
          text_not_found        = 1
          OTHERS                = 2.
      IF sy-subrc <> 0.
        p_cancel = on.
        EXIT.
      ENDIF.
    ELSE.
      l_answer = '1'.                " Layout löschen
    ENDIF.
    IF l_answer = '1'.
*     delete presentation variant
      CALL FUNCTION 'ISHMED_PG_DELETE_VARIANTS'
        EXPORTING
          is_n1wplace_pg = p_n1wplace_pg
        IMPORTING
          e_rc           = l_rc.
      IF l_rc <> 0.
        EXIT.
      ENDIF.
    ELSEIF l_answer = 'A'.           " Cancel
      p_cancel = on.
*    ELSE.
*     if answer is '2' - only connection to view should be deleted
*     (Bei 2 soll nur die Zuordnung gelöscht werden)   -> OK
    ENDIF.
  ENDIF.

ENDFORM.                               " delete_avar_pg
*&---------------------------------------------------------------------*
*&      Form  CHECK_AVAR_USED_PG
*&---------------------------------------------------------------------*
*       check if presentation variant is used in other views
*       -> ID 13398
*----------------------------------------------------------------------*
*      --> P_N1WPLACE_PG   presentation variant
*      --> P_VIEW          view
*      <-- P_AVAR_USED     other user of variant found (ON/OFF)
*----------------------------------------------------------------------*
FORM check_avar_used_pg USING    value(p_n1wplace_pg)  TYPE n1wplace_pg
                                 value(p_view)         TYPE nwview
                        CHANGING p_avar_used           TYPE ish_on_off.

  p_avar_used = off.

  IF p_view-viewtype = '014'.
    CALL FUNCTION 'ISHMED_VP_AVAR_014_USE_PG'
      EXPORTING
        i_nwplacetype = p_n1wplace_pg-nwplacetype
        i_nwplaceid   = p_n1wplace_pg-nwplaceid
        i_mode        = 'C'                          " check
        i_view        = p_view
      IMPORTING
        e_used        = p_avar_used.
  ELSEIF p_view-viewtype = '018'.
    CALL FUNCTION 'ISHMED_VP_AVAR_018_USE_PG'
      EXPORTING
        i_nwplacetype = p_n1wplace_pg-nwplacetype
        i_nwplaceid   = p_n1wplace_pg-nwplaceid
        i_mode        = 'C'                          " check
        i_view        = p_view
      IMPORTING
        e_used        = p_avar_used.
  ENDIF.

ENDFORM.                               " CHECK_AVAR_USED_PG
