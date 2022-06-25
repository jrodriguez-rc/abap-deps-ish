FUNCTION ishmed_vm_fvar_get.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEWTYPE) LIKE  NWVIEW-VIEWTYPE
*"     VALUE(I_FVARIANTID) LIKE  RNFVAR-FVARIANTID OPTIONAL
*"     VALUE(I_FILL_TXT_LANGU) TYPE  ISH_ON_OFF DEFAULT OFF
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"  TABLES
*"      T_FVAR STRUCTURE  V_NWFVAR
*"      T_FVARP STRUCTURE  V_NWFVARP OPTIONAL
*"      T_BUTTON STRUCTURE  V_NWBUTTON OPTIONAL
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------
  DATA: lt_fvar    LIKE TABLE OF nwfvar,
        l_fvar     LIKE nwfvar,
        lt_fvarp   LIKE TABLE OF nwfvarp,
        lt_button  LIKE TABLE OF nwbutton,
        lt_fcodes  TYPE ishmed_t_wp_func,
        ls_fcode   LIKE LINE OF lt_fcodes,
        lt_message TYPE tyt_messages,
        l_wa_msg   LIKE bapiret2,
        l_idx      TYPE sy-tabix,
        l_get_txt  TYPE ish_on_off.

  FIELD-SYMBOLS: <ls_fvar>    TYPE nwfvar,
                 <ls_fvarp>   TYPE nwfvarp,
                 <ls_button>  TYPE nwbutton.

  CLEAR: e_rc, l_get_txt.
  CLEAR: t_messages. REFRESH: t_messages.

  CLEAR:   t_fvar, t_fvarp, t_button, lt_fvar, lt_fvarp, lt_button.
  REFRESH: t_fvar, t_fvarp, t_button, lt_fvar, lt_fvarp, lt_button.

* Sichttyp muß übergeben werden
  IF i_viewtype IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Welche Funktionsvariante(n) soll(en) gelesen werden ?
  IF i_fvariantid IS INITIAL.
*   Alle Funktionsvarianten zum Sichttyp lesen
    SELECT * FROM nwfvar INTO TABLE lt_fvar
             WHERE viewtype = i_viewtype.
    IF sy-subrc <> 0.
      e_rc = 1.
*     Zu Sichttyp & sind keine Funktionsvarianten vorhanden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '359' i_viewtype space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      EXIT.
    ENDIF.
  ELSE.
*   Bestimmte Funktionsvariante lesen
    SELECT SINGLE * FROM nwfvar INTO l_fvar
             WHERE viewtype = i_viewtype
             AND   fvar     = i_fvariantid.
    IF sy-subrc <> 0.
      e_rc = 1.
*     Funktionsvariante & nicht vorhanden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '356' i_fvariantid space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      EXIT.
    ELSE.
      APPEND l_fvar TO lt_fvar.
    ENDIF.
  ENDIF.                " if i_fvariantid is initial

  DESCRIBE TABLE lt_fvar.
  CHECK sy-tfill > 0.

* Text zu den Funktionsvarianten lesen
  LOOP AT lt_fvar ASSIGNING <ls_fvar>.
    MOVE-CORRESPONDING <ls_fvar> TO t_fvar.                 "#EC ENHOK
    SELECT SINGLE spras txt
                  FROM nwfvart
                  INTO (t_fvar-spras, t_fvar-txt)
                  WHERE viewtype = t_fvar-viewtype
                  AND   fvar     = t_fvar-fvar
                  AND   spras    = sy-langu.
    IF sy-subrc <> 0.
      l_get_txt = on.
      CLEAR: t_fvar-spras, t_fvar-txt.
    ENDIF.
    APPEND t_fvar.
  ENDLOOP.

* Funktionen zu Buttons lesen
  IF t_fvarp IS REQUESTED.
    SELECT * FROM nwfvarp INTO TABLE lt_fvarp
             FOR ALL ENTRIES IN t_fvar
             WHERE viewtype = t_fvar-viewtype
             AND   fvar     = t_fvar-fvar.
    IF sy-subrc = 0.
*     Texte zu den Funktionen zu Buttons lesen
      LOOP AT lt_fvarp ASSIGNING <ls_fvarp>.
        MOVE-CORRESPONDING <ls_fvarp> TO t_fvarp.           "#EC ENHOK
        SELECT SINGLE spras txt
                      FROM nwfvarpt
                      INTO (t_fvarp-spras, t_fvarp-txt)
                      WHERE viewtype = t_fvarp-viewtype
                      AND   fvar     = t_fvarp-fvar
                      AND   buttonnr = t_fvarp-buttonnr
                      AND   lfdnr    = t_fvarp-lfdnr
                      AND   spras    = sy-langu.
        IF sy-subrc <> 0.
          l_get_txt = on.
          CLEAR: t_fvarp-spras, t_fvarp-txt.
        ENDIF.
        APPEND t_fvarp.
      ENDLOOP.
    ENDIF.
  ENDIF.

* Buttons der Funktionsvariante lesen
  IF t_button IS REQUESTED.
    SELECT * FROM nwbutton INTO TABLE lt_button
             FOR ALL ENTRIES IN t_fvar
             WHERE viewtype = t_fvar-viewtype
             AND   fvar     = t_fvar-fvar.
    IF sy-subrc = 0.
      LOOP AT lt_button ASSIGNING <ls_button>.
        MOVE-CORRESPONDING <ls_button> TO t_button.         "#EC ENHOK
        SELECT SINGLE spras icon_q buttontxt
                      FROM nwbuttont
                      INTO (t_button-spras, t_button-icon_q,
                            t_button-buttontxt)
                      WHERE viewtype = t_button-viewtype
                      AND   fvar     = t_button-fvar
                      AND   buttonnr = t_button-buttonnr
                      AND   spras    = sy-langu.
        IF sy-subrc <> 0.
          l_get_txt = on.
          CLEAR: t_button-spras, t_button-icon_q, t_button-buttontxt.
        ENDIF.
        APPEND t_button.
      ENDLOOP.
    ENDIF.
  ENDIF.

  IF i_fill_txt_langu = on AND l_get_txt = on AND
     ( t_fvarp IS REQUESTED OR t_button IS REQUESTED ).
*   Lesen ISHMED kennzeichen
    PERFORM check_ishmed CHANGING g_ishmed_used.
*   Ausgehend vom Sichttyp die Standard-Funktionscodes aus dem
*   entsprechenden GUI-Status holen
    PERFORM fetch_fcodes USING    i_viewtype
                                  g_ishmed_used
                         CHANGING lt_fcodes
                                  lt_message
                                  e_rc.
    APPEND LINES OF lt_message TO t_messages.
    IF e_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    LOOP AT t_fvarp WHERE txt IS INITIAL.
      l_idx = sy-tabix.
      READ TABLE lt_fcodes INTO ls_fcode
                 WITH KEY code = t_fvarp-fcode.
      CHECK sy-subrc = 0.
      t_fvarp-txt = ls_fcode-fun_text.
      MODIFY t_fvarp INDEX l_idx.
    ENDLOOP.
    LOOP AT t_button WHERE icon_q    IS INITIAL
                        OR buttontxt IS INITIAL.
      l_idx = sy-tabix.
      READ TABLE lt_fcodes INTO ls_fcode
                 WITH KEY code = t_button-fcode.
      CHECK sy-subrc = 0.
      IF t_button-icon_q IS INITIAL.
        t_button-icon_q    = ls_fcode-fun_text.
      ENDIF.
      IF t_button-buttontxt IS INITIAL.
        t_button-buttontxt = ls_fcode-icon_text.
      ENDIF.
      MODIFY t_button INDEX l_idx.
    ENDLOOP.
  ENDIF.

ENDFUNCTION.
