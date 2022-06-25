*----------------------------------------------------------------------*
***INCLUDE LN1WPLSUBF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  MODIFY_SCREEN
*&---------------------------------------------------------------------*
FORM modify_screen.

  CASE sy-dynnr.
    WHEN '0100'.                                 " Workplace
      IF vcode = g_vcode_display.
        LOOP AT SCREEN.
          screen-input = false.
          MODIFY SCREEN.
        ENDLOOP.
      ENDIF.
    WHEN OTHERS.                                 " Andere
  ENDCASE.

ENDFORM.                    " MODIFY_SCREEN

*&---------------------------------------------------------------------*
*&      Form  CHECK_EINRI
*&---------------------------------------------------------------------*
*       Prüfung der Einrichtung
*----------------------------------------------------------------------*
FORM check_einri USING    value(p_einri)     LIKE tn01-einri
                          value(p_fieldname) TYPE any.

  DATA: l_tn01   LIKE tn01,
        l_length TYPE i.

  IF p_einri CO ' 0123456789'.
    l_length = 4.
    PERFORM format_numc_string(sapmn1pa) USING p_einri l_length.
  ENDIF.
  CLEAR l_tn01.
  SELECT SINGLE * FROM tn01 INTO l_tn01 WHERE einri = p_einri.
  IF sy-subrc NE 0.
    SET CURSOR FIELD p_fieldname.
    MESSAGE ID 'N1' TYPE 'E' NUMBER '117' WITH p_einri.
  ENDIF.

ENDFORM.                    " CHECK_EINRI
*&---------------------------------------------------------------------*
*&      Form  CHECK_ORGID
*&---------------------------------------------------------------------*
FORM check_orgid USING value(p_einri)     LIKE tn01-einri
                       value(p_orgid)     LIKE norg-orgid
                       value(p_fieldname) TYPE any
                       value(p_fazuw)     LIKE norg-fazuw
                       value(p_pfzuw)     LIKE norg-pfzuw
                       value(p_n1anfkz)   LIKE norg-n1anfkz
                       value(p_n1erbrkz)  LIKE norg-n1erbrkz.

  CALL FUNCTION 'ISHMED_CHECK_NORG'
    EXPORTING
      ss_einri      = p_einri
      ss_einri_chk  = 'J'
      ss_fazuw      = p_fazuw
      ss_pfzuw      = p_pfzuw
      ss_n1anfkz    = p_n1anfkz
      ss_n1erbrkz   = p_n1erbrkz
      ss_check_date = off                         " MED-34018
      ss_orgid      = p_orgid
    EXCEPTIONS
      not_found     = 1
      not_valid     = 2.

  CASE sy-subrc.
    WHEN 1.
      SET CURSOR FIELD p_fieldname.
      MESSAGE ID 'N1' TYPE 'E' NUMBER '204' WITH p_orgid.
    WHEN 2.
      SET CURSOR FIELD p_fieldname.
      MESSAGE ID 'NF' TYPE 'E' NUMBER '171' WITH p_orgid.
  ENDCASE.

ENDFORM.                    " CHECK_ORGID

*&---------------------------------------------------------------------*
*&      Form  HELP_ORGID
*&---------------------------------------------------------------------*
*       F4-Hilfe für Org.Einheit
*----------------------------------------------------------------------*
*      --> P_FIELDNAME_EINRI   Feldname der Einrichtung
*      --> P_FIELDNAME_ORGID   Feldname der Org.Einheit
*      <-- P_EINRI             Einrichtung
*      <-- P_ORGID             Org.Einheit
*----------------------------------------------------------------------*
FORM help_orgid USING    value(p_fieldname_einri)   TYPE any
                         value(p_fieldname_orgid)   TYPE any
                CHANGING p_einri                    TYPE einri
                         p_orgid                    TYPE orgid.

  DATA: h_fname      LIKE dynpread-fieldname,
        h_einri      LIKE tn01-einri,
*        h_title(40)  type c,
*        h_nosel(1)   TYPE c,
        h_erbkz(1)   TYPE c,
        h_fazuw(1)   TYPE c,
        h_pfzuw(1)   TYPE c.

  DATA: lt_dynpr     LIKE TABLE OF dynpread WITH HEADER LINE.

  h_fname = p_fieldname_einri.

  REFRESH lt_dynpr. CLEAR lt_dynpr.
  lt_dynpr-fieldname = h_fname.
  APPEND lt_dynpr.

  PERFORM read_from_dynpro TABLES lt_dynpr USING '*'.

  READ TABLE lt_dynpr WITH KEY fieldname = h_fname.
  p_einri = lt_dynpr-fieldvalue.
  h_einri = p_einri.

  CASE p_fieldname_orgid.
    WHEN 'RN1_SCR_WPLSUB100-PFLEGOE'.
*       h_title = 'Plegerische OE'(001).
      h_erbkz = '*'.
      h_fazuw = '*'.
      h_pfzuw = on.
    WHEN 'RN1_SCR_WPLSUB100-FACHLOE'.
*       h_title = 'Fachliche OE'(002).
      h_erbkz = '*'.
      h_fazuw = on.
      h_pfzuw = '*'.
    WHEN 'RN1_SCR_WPLSUB100-ERBOE'.
*       h_title = 'Erbringende OE'(003).
      h_erbkz = on.
      h_fazuw = '*'.
      h_pfzuw = '*'.
    WHEN 'RN1_SCR_WPLSUB100-PLANOE'.
*       h_title = 'Planende/Eintragende OE'(004).
      h_erbkz = '*'.
      h_fazuw = '*'.
      h_pfzuw = '*'.
  ENDCASE.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = h_einri
    IMPORTING
      output = h_einri.

  CALL FUNCTION 'ISH_GRAPHIC_ORGID_SELECT'
    EXPORTING
      einri             = h_einri
      erbkz             = h_erbkz
      fazuw             = h_fazuw
      pfzuw             = h_pfzuw
      zimkz             = off
      no_bauid          = off
      date              = sy-datum
    IMPORTING
*     nothing_selected  = h_nosel
      selected_orgid    = p_orgid
    EXCEPTIONS
      bauid_not_in_nbau = 1
      einri_not_in_tn01 = 2
      no_hierarchy      = 3
      orgid_not_in_norg = 4
      OTHERS            = 5.

  IF sy-subrc <> 0.
    CLEAR p_orgid.
  ENDIF.

ENDFORM.                    " HELP_ORGID

*&---------------------------------------------------------------------*
*&      Form  READ_FROM_DYNPRO
*&---------------------------------------------------------------------*
FORM read_from_dynpro TABLES pt_dynpr STRUCTURE dynpread
                      USING  p_mode   TYPE c.

  DATA: l_repid LIKE sy-repid.
  DATA: l_dynnr LIKE sy-dynnr.

  l_repid = sy-repid.
  l_dynnr = sy-dynnr.

* Werte der Dynprofelder einlesen
  IF p_mode = 'R' OR p_mode = '*'.
    CALL FUNCTION 'ISH_DYNP_VALUES_READ'
      EXPORTING
        dyname     = l_repid
        dynumb     = l_dynnr
      TABLES
        dynpfields = pt_dynpr.
  ENDIF.

  READ TABLE pt_dynpr INDEX 1.
  CHECK sy-subrc = 0.

  LOOP AT pt_dynpr.
* ED, ID 10730: gefährliche Verwendung von Translate
    TRANSLATE pt_dynpr-fieldvalue TO UPPER CASE.         "#EC TRANSLANG
    MODIFY pt_dynpr INDEX sy-tabix.
  ENDLOOP.

  IF p_mode = 'W' OR p_mode = '*'.
    CALL FUNCTION 'DYNP_VALUES_UPDATE'
      EXPORTING
        dyname     = l_repid
        dynumb     = l_dynnr
      TABLES
        dynpfields = pt_dynpr.
  ENDIF.

ENDFORM.                               " READ_FROM_DYNPRO

*&---------------------------------------------------------------------*
*&      Form  HELP_EINRI
*&---------------------------------------------------------------------*
*       F4-Hilfe für Einrichung
*----------------------------------------------------------------------*
*      <-- P_EINRI       Einrichtung
*----------------------------------------------------------------------*
FORM help_einri  CHANGING  p_einri    LIKE tn01-einri.

  CALL FUNCTION 'ISH_N2_SHOW_EINRI'
    IMPORTING
      ss_einri     = p_einri
    EXCEPTIONS
      no_institute = 1
      OTHERS       = 2.
  IF sy-subrc <> 0.
    CLEAR p_einri.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    " HELP_EINRI
