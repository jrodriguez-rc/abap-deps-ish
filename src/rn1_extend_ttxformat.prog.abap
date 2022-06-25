*&---------------------------------------------------------------------*
*& Report  RN1_EXTEND_TTXFORMAT
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  rn1_extend_ttxformat.

INCLUDE mndata00.

DATA lt_ttxformat               TYPE TABLE OF ttxformat.
DATA ls_ttxformat               TYPE ttxformat.
DATA l_error                    TYPE c LENGTH 1.

* Select the entry N1LTE from the table
SELECT * FROM ttxformat INTO TABLE lt_ttxformat WHERE orgformat = 'N1LTE'.

* If we already have the entry put out a message but if we don't find it
* append it.
IF sy-subrc = 0.
  MESSAGE 'Der Eintrag "N1LTE" ist bereits vorhanden.'(001) TYPE 'S'.
ELSE.

* Initialize the structure which should be appended
  ls_ttxformat-orgformat = 'N1LTE'.
  ls_ttxformat-altformat = 'N1LTE'.
  ls_ttxformat-supported = on.

* put out a message and insert the values into the table
  INSERT into ttxformat values ls_ttxformat.
  COMMIT WORK AND WAIT.
  IF sy-subrc = 0.
    MESSAGE 'Der Eintrag "N1LTE" wurde eingefügt.'(002) TYPE 'S'.
    l_error = off.
  ELSE.
    MESSAGE 'Es ist ein Fehler beim Einfügen aufgetreten.'(003) TYPE 'S'.
    ROLLBACK WORK.
    l_error = on.
  ENDIF.
ENDIF.

* Output
WRITE: AT /2 'Report versucht Tabelle TTXFORMAT zu ergänzen...'(004).
ULINE AT /1(64).
NEW-LINE.
WRITE: '|'.
WRITE: 'Eintrag "N1LTE" kann eingefügt werden:'(005).

READ TABLE lt_ttxformat WITH KEY orgformat = 'N1LTE' TRANSPORTING NO FIELDS.
IF sy-subrc = 0.
* We already have the entry in the database
  WRITE: '|'.
  FORMAT COLOR = 6.
  WRITE: 'Nein'(007).
  WRITE: '|'.
  ULINE AT /1(64).
  FORMAT COLOR = OFF.
  NEW-LINE.
  WRITE: '|'.
  WRITE: 'Eintrag "N1LTE" eingefügt:'(008).
  WRITE: '|'.
  FORMAT COLOR = 6.
  WRITE: 'Nein'(007).
  WRITE: '|'.
  FORMAT COLOR = OFF.
  ULINE AT /1(64).
  NEW-LINE.
  WRITE: '|'.
  WRITE AT (60) 'Der Eintrag ist bereits vorhanden.'(009).
  WRITE: '|'.
  ULINE AT /1(64).
ELSE.
* We don't have the entry in the database
  WRITE: '|'.
  FORMAT COLOR = 5.
  WRITE: 'Ja'(006).
  WRITE: '|'.
  FORMAT COLOR = OFF.
  ULINE AT /1(64).
  NEW-LINE.
  WRITE: '|'.
  WRITE: 'Eintrag "N1LTE" eingefügt:'(008).
  WRITE: '|'.

* Error occured?
  IF l_error = off.
    FORMAT COLOR = 5.
    WRITE: 'Ja'(006).
  ELSE.
    FORMAT COLOR = 6.
    WRITE: 'Nein'(007).
  ENDIF.
    WRITE: '|'.
    ULINE AT /1(64).
ENDIF.
