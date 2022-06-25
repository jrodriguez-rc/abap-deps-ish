*----------------------------------------------------------------------*
***INCLUDE LN1LISTF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  LP_AUSGABE
*&---------------------------------------------------------------------*
*       List-Popup Ausgabe
*----------------------------------------------------------------------*
FORM lp_ausgabe.

  LOOP AT lp_outtab.
*   Farbe & Intensität festlegen
    IF NOT lp_outtab-intensiv IS INITIAL AND
       NOT lp_outtab-intensiv EQ on.
      lp_outtab-intensiv = on.
    ENDIF.
    CASE lp_outtab-color.
      WHEN '1'.
        PERFORM col_heading    USING lp_outtab-intensiv.
      WHEN '2'.
        PERFORM col_normal     USING lp_outtab-intensiv.
      WHEN '3'.
        PERFORM col_total      USING lp_outtab-intensiv.
      WHEN '4'.
        PERFORM col_key        USING lp_outtab-intensiv.
      WHEN '5'.
        PERFORM col_positive   USING lp_outtab-intensiv.
      WHEN '6'.
        PERFORM col_negative   USING lp_outtab-intensiv.
      WHEN '7'.
        PERFORM col_group      USING lp_outtab-intensiv.
      WHEN OTHERS.
        PERFORM col_background USING lp_outtab-intensiv.
    ENDCASE.
*   Text ausgeben
    IF NOT lp_outtab-text IS INITIAL.
      WRITE: / lp_outtab-text.
    ELSE.
      SKIP.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " LP_AUSGABE
*&---------------------------------------------------------------------*
*&      Form  USER_COMMAND
*&---------------------------------------------------------------------*
FORM user_command.

  DATA: nr        TYPE i.

  CASE sy-ucomm.
    WHEN 'ENTR'.                       " Enter
      key_back = sy-ucomm.
      SET SCREEN 0. LEAVE SCREEN.
    WHEN 'CANC'.                       " Cancel
      key_back = sy-ucomm.
      SET SCREEN 0. LEAVE SCREEN.
*   Benutzerdefinierte Buttons
    WHEN 'FKT1'  OR  'FKT2'  OR  'FKT3'  OR  'FKT4'  OR  'FKT5'  OR
         'FKT6'  OR  'FKT7'  OR  'FKT8'  OR  'FKT9'  OR  'FKT0'.
      nr = sy-ucomm+3(1).
      IF nr = 0. nr = 10. ENDIF.
      READ TABLE lp_button INDEX nr.
      CHECK sy-subrc = 0.
      key_back = lp_button-fcode.
      SET SCREEN 0.   LEAVE SCREEN.
  ENDCASE.

ENDFORM.                    " USER_COMMAND
*&---------------------------------------------------------------------*
*&      Form  TOP_OF_PAGE
*&---------------------------------------------------------------------*
FORM top_of_page.

  PERFORM col_heading USING on.

  IF NOT lp_header1 IS INITIAL.
    WRITE: / lp_header1.
    SKIP.
  ENDIF.

  IF NOT lp_header2 IS INITIAL.
    WRITE: / lp_header2.
    SKIP.
  ENDIF.

ENDFORM.                    " TOP_OF_PAGE
*&---------------------------------------------------------------------*
*&      Form  SET_BUTTONS
*&---------------------------------------------------------------------*
*       Funktionen FKT1 - FKT10 belegen
*----------------------------------------------------------------------*
FORM set_buttons.

  DATA: text(30).

  CLEAR: button1, button2, button3, button4, button5,
         button6, button7, button8, button9, button10.

  LOOP AT lp_button.
    IF lp_button-icon IS INITIAL.
*     Kein Icon angegeben => Nur Text zuweisen
      CASE sy-tabix.
        WHEN 1.
          button1 = lp_button-text.
        WHEN 2.
          button2 = lp_button-text.
        WHEN 3.
          button3 = lp_button-text.
        WHEN 4.
          button4 = lp_button-text.
        WHEN 5.
          button5 = lp_button-text.
        WHEN 6.
          button6 = lp_button-text.
        WHEN 7.
          button7 = lp_button-text.
        WHEN 8.
          button8 = lp_button-text.
        WHEN 9.
          button9 = lp_button-text.
        WHEN 10.
          button10 = lp_button-text.
      ENDCASE.
    ELSE.
*     Icontext darf max. 14-stellig sein?!
      text = lp_button-icon_qinfo(14).
*     Icon ist angegeben => Zuweisen
      CASE sy-tabix.
        WHEN 1.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button1.
        WHEN 2.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button2.
        WHEN 3.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button3.
        WHEN 4.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button4.
        WHEN 5.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button5.
        WHEN 6.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button6.
        WHEN 7.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button7.
        WHEN 8.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button8.
        WHEN 9.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button9.
        WHEN 10.
          PERFORM icon_create(sapmnpa0) USING lp_button-icon
                                              lp_button-text
                                              text
                                              button10.
      ENDCASE.
    ENDIF.   " ELSE IF LP_BUTTON-ICON IS INITIAL  OR  ...
  ENDLOOP.

ENDFORM.                    " SET_BUTTONS
*&---------------------------------------------------------------------*
*&      Form  FILL_EXCLTAB_0100
*&---------------------------------------------------------------------*
*       Fuellen der internen Tabelle fuer EXCLUDING FCODES
*----------------------------------------------------------------------*
FORM fill_excltab_0100.

  DATA: f(4) TYPE c.                                        "#EC *

  CLEAR excl_tab. REFRESH excl_tab.

* Enter-Taste ausblenden?
  IF lp_enter_key = off.
    PERFORM append_excltab USING 'ENTR'.
  ENDIF.

* Print-Taste ausblenden?
  IF lp_print_key = off.
    PERFORM append_excltab USING 'PRI '.
  ENDIF.

* Blättern- & Suchen-Tasten ausblenden?
  IF lp_zeilen <= 20.
    PERFORM append_excltab USING '%SC '.
    PERFORM append_excltab USING '%SC+'.
    PERFORM append_excltab USING 'P-- '.
    PERFORM append_excltab USING 'P-  '.
    PERFORM append_excltab USING 'P++ '.
    PERFORM append_excltab USING 'P+  '.
  ENDIF.

* Ausschalten gewisser Funktionen
  f = 'FKT'.
  DO 10 TIMES.
    READ TABLE lp_button INDEX sy-index.
    CHECK sy-subrc <> 0.
    IF sy-index = 10.
      f+3(1) = 0.
    ELSE.
      f+3(1) = sy-index.
    ENDIF.
    PERFORM append_excltab USING f.
  ENDDO.

ENDFORM.                    " FILL_EXCLTAB_0100
*---------------------------------------------------------------------*
* FORM APPEND_EXCLTAB
* Satz in EXCL_TAB einfügen, wenn noch nicht existiert
*---------------------------------------------------------------------*
FORM append_excltab USING funk TYPE any.
  READ TABLE excl_tab WITH KEY funktion = funk.
  IF sy-subrc <> 0.
    MOVE funk TO excl_tab-funktion.
    APPEND excl_tab.
  ENDIF.
ENDFORM.                               " APPEND_EXCLTAB
*&---------------------------------------------------------------------*
*&      Form  init_fieldcat
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_L_TAB_FIELDCAT[]  text
*----------------------------------------------------------------------*
FORM init_fieldcat USING     i_tab_info_init TYPE ish_on_off
                   CHANGING  p_tab_fieldcat  TYPE slis_t_fieldcat_alv.

  DATA: l_wrk_fieldcat   TYPE slis_fieldcat_alv.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname     = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname   = 'TABNAME'.
  IF i_tab_info_init = off.
    l_wrk_fieldcat-no_out    = 'X'.
  ENDIF.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname     = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname   = 'TABKEY'.
  IF i_tab_info_init = off.
    l_wrk_fieldcat-no_out    = 'X'.
  ENDIF.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'USERNAME'.
  l_wrk_fieldcat-seltext_l    = 'Benutzer'(004).
  l_wrk_fieldcat-seltext_m    = 'Benutzer'(004).
  l_wrk_fieldcat-seltext_s    = 'Benutzer'(004).
  l_wrk_fieldcat-reptext_ddic = 'Benutzer'(004).
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'NAME_FIRST'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'NAME_LAST'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'DEPARTMENT'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'UDATE'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'UTIME'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'SCRTEXT_S'.
  l_wrk_fieldcat-seltext_l    = 'Feld'(006).
  l_wrk_fieldcat-seltext_m    = 'Feld'(006).
  l_wrk_fieldcat-seltext_s    = 'Feld'(006).
  l_wrk_fieldcat-reptext_ddic = 'Feld'(006).
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'SCRTEXT_M'.
  l_wrk_fieldcat-seltext_l    = 'Feldbezeichnung (mittel)'(007).
  l_wrk_fieldcat-seltext_m    = 'Feldbezeichnung (mittel)'(007).
  l_wrk_fieldcat-seltext_s    = 'Feldbezeichnung (mittel)'(007).
  l_wrk_fieldcat-reptext_ddic = 'Feldbezeichnung (mittel)'(007).
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'SCRTEXT_L'.
  l_wrk_fieldcat-seltext_l    = 'Feldbezeichnung (lang)'(008).
  l_wrk_fieldcat-seltext_m    = 'Feldbezeichnung (lang)'(008).
  l_wrk_fieldcat-seltext_s    = 'Feldbezeichnung (lang)'(008).
  l_wrk_fieldcat-reptext_ddic = 'Feldbezeichnung (lang)'(008).
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'F_OLD'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'F_NEW'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'CHNGIND'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'TEXT_CASE'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'TCODE'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'FNAME'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'FTEXT'.
  l_wrk_fieldcat-seltext_l    = 'Feldbeschreibung'(005).
  l_wrk_fieldcat-seltext_m    = 'Feldbeschreibung'(005).
  l_wrk_fieldcat-seltext_s    = 'Feldbeschreibung'(005).
  l_wrk_fieldcat-reptext_ddic = 'Feldbeschreibung'(005).
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'OBJECTID'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

  CLEAR l_wrk_fieldcat.
  l_wrk_fieldcat-tabname      = 'CDREDDISP'.
  l_wrk_fieldcat-ref_tabname  = 'CDREDDISP'.
  l_wrk_fieldcat-fieldname    = 'CHANGENR'.
  l_wrk_fieldcat-no_out       = 'X'.
  APPEND l_wrk_fieldcat TO p_tab_fieldcat.

ENDFORM.                    " init_fieldcat

*&---------------------------------------------------------------------*
*&      Form  ADD_DDIC_DETAILS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_L_WRK_CDPOSDISP  text
*----------------------------------------------------------------------*
FORM add_ddic_details CHANGING p_wrk_cdreddisp LIKE cdreddisp.

  DATA: l_wrk_dd02t      LIKE dd04t.
  DATA: l_tab_dfies      TYPE TABLE OF dfies,
        l_wrk_dfies      LIKE dfies.

  CLEAR l_wrk_dd02t.
  SELECT SINGLE * FROM dd02t
                  INTO l_wrk_dd02t
                  WHERE tabname    = p_wrk_cdreddisp-tabname
                    AND ddlanguage = sy-langu
                    AND as4local   = 'A'
                    AND as4vers    = '0000'.
  p_wrk_cdreddisp-ddtext = l_wrk_dd02t-ddtext.

  CALL FUNCTION 'DDIF_FIELDINFO_GET'
       EXPORTING
            tabname        = p_wrk_cdreddisp-tabname
            fieldname      = p_wrk_cdreddisp-fname
            langu          = sy-langu
*           LFIELDNAME     = ' '
*           ALL_TYPES      = ' '
*      IMPORTING
*           X030L_WA       =
*           DDOBJTYPE      =
*           DFIES_WA       =
       TABLES
            dfies_tab      = l_tab_dfies
       EXCEPTIONS
            not_found      = 0
            internal_error = 0
            OTHERS         = 0.

  CLEAR l_wrk_dfies.
  LOOP AT l_tab_dfies INTO l_wrk_dfies.
    EXIT.
  ENDLOOP.

  p_wrk_cdreddisp-scrtext_s = l_wrk_dfies-scrtext_s.
  p_wrk_cdreddisp-scrtext_m = l_wrk_dfies-scrtext_m.
  p_wrk_cdreddisp-scrtext_l = l_wrk_dfies-scrtext_l.
  p_wrk_cdreddisp-ftext     = l_wrk_dfies-fieldtext.

ENDFORM.                               " ADD_DDIC_DETAILS

*&---------------------------------------------------------------------*
*&      Form  ADD_USER_DETAILS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM add_user_details CHANGING p_wrk_cdreddisp LIKE cdreddisp.

  DATA: l_wrk_addr3_val LIKE addr3_val.

  CALL FUNCTION 'SUSR_USER_ADDRESS_READ'
       EXPORTING
            user_name              = p_wrk_cdreddisp-username
*           READ_DB_DIRECTLY       = ' '
       IMPORTING
            user_address           = l_wrk_addr3_val
*           USER_USR03             =
      EXCEPTIONS
            user_address_not_found = 0
            OTHERS                 = 0.
  p_wrk_cdreddisp-name_first      = l_wrk_addr3_val-name_first.
  p_wrk_cdreddisp-name_last       = l_wrk_addr3_val-name_last.
  p_wrk_cdreddisp-department      = l_wrk_addr3_val-department.

ENDFORM.                               " ADD_USER_DETAILS
