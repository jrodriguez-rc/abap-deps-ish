*----------------------------------------------------------------------*
***INCLUDE LN2_POPUP_FOR_ENTER_VALUESF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  help_display
*&---------------------------------------------------------------------*
*       F1 help
*----------------------------------------------------------------------*
FORM help_display .

* Lokale Tabellen
  DATA: lt_dynp_select         TYPE STANDARD TABLE OF dselc,
        lt_dynp_value          TYPE STANDARD TABLE OF dval,
        lt_dummy               TYPE STANDARD TABLE OF tline.
* Workareas
  DATA: l_dynp_select          LIKE LINE OF lt_dynp_select,
        l_dynp_value           LIKE LINE OF lt_dynp_value.
* Hilfsfelder und -strukturen
  DATA: l_help_infos           TYPE help_info,
        l_rc                   TYPE ish_method_rc,
        l_n1vkg                TYPE n1vkg,
        l_field(30)            TYPE c,
        l_line                 TYPE i,
        l_help_object          TYPE ish_on_off,
        l_docclass             TYPE dsysh-dokclass,
        l_docname              TYPE string.
* ---------- ---------- ----------
* where is the cursor ...
  GET CURSOR FIELD l_field LINE l_line.
* ---------- ---------- ----------
* Schnittstelle füllen
  l_help_infos-call      = 'D'.              "Doku-Anzeige
  l_help_infos-object    = 'F'.
  l_help_infos-program   = sy-repid.
  l_help_infos-dynpro    = sy-dynnr.
  l_help_infos-spras     = sy-langu.
  l_help_infos-title     = sy-title.
  l_help_infos-tcode     = sy-tcode.
  l_help_infos-pfkey     = sy-pfkey.
  l_help_infos-report    = sy-repid.
  l_help_infos-docuid    = 'NA'.
  l_help_infos-menufunct = '-DOK'.
  l_help_infos-docuid    = 'FE'.
* ---------- ---------- ----------
* documentation depends on cursor position (field)
  CLEAR: l_help_object.
  CASE l_field.
    WHEN 'RNTOOLS-FIELD'.
      IF g_f1fieldname IS INITIAL.
        EXIT.
      ENDIF.
      l_docclass    = 'DE'.
      l_docname     = g_f1fieldname.
      l_help_object = on.
  ENDCASE.
* ---------- ---------- ----------
  l_help_infos-sy_dyn    = sy-dynnr.
  l_help_infos-dynpprog  = sy-repid.
* ---------- ---------- ----------
* show documentation
  IF l_help_object = off.
    CLEAR: lt_dynp_select[], lt_dynp_value[].
    CALL FUNCTION 'HELP_START'
      EXPORTING
        help_infos   = l_help_infos
      TABLES
        dynpselect   = lt_dynp_select
        dynpvaluetab = lt_dynp_value
      EXCEPTIONS
        OTHERS       = 1.
  ELSE.
    CALL FUNCTION 'HELP_OBJECT_SHOW'
      EXPORTING
        dokclass   = l_docclass
        doklangu   = sy-langu
        dokname    = l_docname
        short_text = on
      TABLES
        links      = lt_dummy
      EXCEPTIONS
        OTHERS     = 1.
  ENDIF.
* ---------- ---------- ----------

ENDFORM.                    " help_display
