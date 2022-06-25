*&---------------------------------------------------------------------*
*& Report  RN1_CORRECT_CORDER_N1COMPA
*&
*&---------------------------------------------------------------------*
REPORT  rn1_correct_corder_n1compa.

INCLUDE mndata00.

* Selection screen, parameters.
SELECTION-SCREEN BEGIN OF BLOCK one WITH FRAME TITLE text-003.

* Test run.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) text-004 FOR FIELD pa_test.
SELECTION-SCREEN POSITION 20.
PARAMETERS pa_test AS CHECKBOX DEFAULT on.      " test run
SELECTION-SCREEN END OF LINE.

* Show list.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) text-005 FOR FIELD pa_list.
SELECTION-SCREEN POSITION 20.
PARAMETERS pa_list AS CHECKBOX DEFAULT on.      " data list
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK one.

* Data definitions.
DATA: lt_t000           TYPE TABLE OF t000,
      ls_t000           LIKE LINE OF lt_t000,
      lt_tn00           TYPE TABLE OF tn00,
      l_cursor          TYPE cursor.

DATA: lt_n1compa        TYPE TABLE OF n1compa,
      ls_n1compa        TYPE n1compa,
      lt_n1compa_check  TYPE TABLE OF n1compa,
      ls_n1compa_check  TYPE n1compa,
      lt_n1compa_double TYPE TABLE OF n1compa,
      ls_n1compa_double TYPE n1compa.

START-OF-SELECTION.

*-- find active clients.
  SELECT * FROM t000 CLIENT SPECIFIED INTO TABLE lt_t000.   "#EC *

*-- Loop clients.
  LOOP AT lt_t000 INTO ls_t000.
    REFRESH: lt_tn00.
*-- find active IS-H/IS-H*MED clients.
    SELECT * FROM tn00 CLIENT SPECIFIED
      INTO TABLE lt_tn00 WHERE mandt = ls_t000-mandt.
*-- only go on with IS-H/IS-H*MED installations.
    CHECK sy-subrc = 0.

*-- open Cursor for current client.
    OPEN CURSOR WITH HOLD l_cursor FOR
       SELECT * FROM n1compa CLIENT SPECIFIED           "#EC CI_NOWHERE
         WHERE mandt = ls_t000-mandt AND
              ( compid = 'SAP_RADIOLOGY' OR
                compid = 'SAP_TRANS_ORDER').
*-- data selection in blocks.
    DO.
      REFRESH: lt_n1compa, lt_n1compa_check, lt_n1compa_double.

*--   select data.
      FETCH NEXT CURSOR l_cursor INTO TABLE lt_n1compa PACKAGE SIZE 5000.
      IF sy-subrc <> 0.
*       No more entries => exit for next client.
        EXIT.
      ENDIF.

      lt_n1compa_check[] = lt_n1compa[].
      SORT lt_n1compa BY compid extuid vkgid.
      SORT lt_n1compa_check BY compid extuid vkgid.

      DELETE ADJACENT DUPLICATES FROM lt_n1compa COMPARING extuid vkgid.
      SORT lt_n1compa BY compid extuid vkgid.

*--   check double entries
      LOOP AT lt_n1compa_check INTO ls_n1compa_check.
        READ TABLE lt_n1compa INTO ls_n1compa
          WITH KEY mandt = ls_t000-mandt
                   compaid = ls_n1compa_check-compaid.
        IF sy-subrc NE 0.
          APPEND ls_n1compa TO lt_n1compa_double.
        ENDIF.
      ENDLOOP.

*--   to list
      IF pa_list EQ on AND NOT lt_n1compa_double[] IS INITIAL.
        FORMAT COLOR 1 INTENSIFIED ON.
        WRITE:/ 'Geloeschte Eintraege Tabelle N1COMPA:'(007).
        WRITE: / 'Mandant:'(008),ls_t000-mandt .
        WRITE sy-uline.
        FORMAT RESET.
        LOOP AT lt_n1compa_double INTO ls_n1compa_double.
          CHECK NOT ls_n1compa_double-extuid IS INITIAL.
          WRITE:/ 'Zuordnung Auftragsposition:'(001) , ls_n1compa_double-compaid.
          WRITE:/ 'Identifikation:'(002) , ls_n1compa_double-extuid.
          WRITE:/ 'Baustein:'(006) , ls_n1compa_double-compid.
          WRITE:/ sy-uline.
          SKIP.
        ENDLOOP.
      ENDIF.

      IF pa_test = off.
        CHECK NOT lt_n1compa[] IS INITIAL.
        DELETE n1compa CLIENT SPECIFIED FROM TABLE lt_n1compa_double.
        CALL FUNCTION 'DB_COMMIT'.
      ENDIF.

    ENDDO.
*-- close cursor for current client.
    CLOSE CURSOR l_cursor.
  ENDLOOP.
