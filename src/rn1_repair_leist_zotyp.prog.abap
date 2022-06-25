*&---------------------------------------------------------------------*
*& Report  RN1_REPAIR_LEIST_ZOTYP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  RN1_REPAIR_LEIST_ZOTYP                  .

*---------------------------------------------------------------------*
* tables
*---------------------------------------------------------------------*
TABLES: nlei.
*---------------------------------------------------------------------*
* definitios
*---------------------------------------------------------------------*
INCLUDE mndata00.
*---------------------------------------------------------------------*
* colour change
*---------------------------------------------------------------------*
INCLUDE mncolour.
*---------------------------------------------------------------------*
* declarations
*---------------------------------------------------------------------*

DATA:
      lt_nlei_all TYPE STANDARD TABLE OF nlei,
      ls_nlei_all TYPE nlei,
      lt_nllz_all TYPE STANDARD TABLE OF nllz,
      ls_nllz_all TYPE nllz,
      lt_ntpk_all TYPE STANDARD TABLE OF ntpk,
      ls_ntpk_all TYPE ntpk,
      lt_nlei_correct TYPE STANDARD TABLE OF nlei,
      l_correct TYPE i,
      l_zotyp TYPE tnt0-zotyp,
      r_zotyp LIKE RANGE OF nllz-zotyp WITH HEADER LINE,    "ID 19140
      l_test TYPE i,                                        "ID 19140
      l_value type RI_PARVAL,
      l_switch type ish_on_off,
      l_count type i.

*---------------------------------------------------------------------*
* Declaration der Parameter für das Einstiegsbild
*---------------------------------------------------------------------*
* institution
PARAMETERS: pa_einri LIKE nlei-einri OBLIGATORY.

*----------------------------------------------------------------------*
* date
*----------------------------------------------------------------------*
SELECT-OPTIONS r_datum FOR nlei-ibgdt OBLIGATORY.

*----------------------------------------------------------------------*
* buttons
*----------------------------------------------------------------------*
PARAMETERS: pa_test AS CHECKBOX DEFAULT on.
*----------------------------------------------------------------------*
* initialisation at starting up
* call dynpro
*----------------------------------------------------------------------*
INITIALIZATION.
  GET PARAMETER ID 'EIN' FIELD pa_einri.
*----------------------------------------------------------------------*
* AT SELECTION-SCREEN - check input
*----------------------------------------------------------------------*
AT SELECTION-SCREEN.
* check date
  IF NOT r_datum-low IS INITIAL AND NOT r_datum-high IS INITIAL.
    IF r_datum-low GT r_datum-high.
      SET CURSOR FIELD 'R_DATUM'.
      MESSAGE e014(nf).
    ENDIF.
  ENDIF.
*----------------------------------------------------------------------*
* AT USER-COMMAND = check function.
*----------------------------------------------------------------------*
AT USER-COMMAND.

*----------------------------------------------------------------------*
* begin of work
*----------------------------------------------------------------------*
START-OF-SELECTION.

  CALL FUNCTION 'ISH_EINRI_CHECK'
    EXPORTING
      ss_einri  = pa_einri
    EXCEPTIONS
      not_found = 1
      OTHERS    = 2.

  IF sy-subrc <> 0.
    MESSAGE s117(n1) WITH pa_einri.
    EXIT.
  ENDIF.

*----------------------------------------------------------------------*
*fill tabel with information
*----------------------------------------------------------------------*
  PERFORM find_data.

  DESCRIBE TABLE lt_nlei_all LINES l_correct.
  IF l_correct < 1.
    WRITE: /
    'Es wurden keine Leistungsdaten zur Korrektur gefunden'(001).
  ELSE.
    IF pa_test = ' '.
      WRITE: / 'Es wurden'(004), l_correct,
      'Leistungseinträge korrigiert.'(005).
    ELSE.
      WRITE: / 'Es können'(002), l_correct,
      'Leistungseinträge korrigiert werden.'(003).
    ENDIF.
    PERFORM write_list.
    PERFORM update_list.
  ENDIF.

*&---------------------------------------------------------------------*
*&      Form  FIND_DATA
*&---------------------------------------------------------------------*
*       text                                                           *
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM find_data.


* CDuerr, ID 17475 - Begin
*  SELECT * FROM nllz INTO TABLE lt_nllz_all
*                  WHERE zotyp = 'A'.
* CDuerr, 02.08.2005
*  SELECT * FROM nllz INTO TABLE lt_nllz_all
  SELECT * FROM nllz INTO TABLE lt_nllz_all   "#EC CI_NOFIRST
* CDuerr, 02.08.2005
                  WHERE einri = pa_einri
                    AND erdat IN r_datum
                    AND zotyp IN ('A','M').    "ID 19140
* CDuerr, ID 17475 - End  	

IF NOT lt_nllz_all IS INITIAL.

  SELECT * FROM nlei INTO TABLE lt_nlei_all
              FOR ALL ENTRIES IN lt_nllz_all
                WHERE LNRLS = lt_nllz_all-lnrls2
                  AND zotyp =  ' '.

    IF NOT lt_nlei_all[] IS INITIAL.   "CDuerr, ID 17475
      SELECT * FROM ntpk INTO TABLE lt_ntpk_all
                  FOR ALL ENTRIES IN lt_nlei_all
                    WHERE talst = lt_nlei_all-leist
*                     CDuerr, 02.08.2005
                      AND einri = lt_nlei_all-einri
                      AND tarif = lt_nlei_all-haust
*                     CDuerr, 02.08.2005
                      AND tgrkz =  'X'.
    ENDIF.                             "CDuerr, ID 17475

  loop at lt_nlei_all into ls_nlei_all.
    l_count = sy-tabix.
    Read table lt_ntpk_all into ls_ntpk_all with key talst =
ls_nlei_all-leist.
    if sy-subrc <> 0.
      delete lt_nlei_all index l_count.
    endif.
  endloop.

  PERFORM ren00q(sapmnpa0) USING ls_nlei_all-einri 'N1ZOTYP' l_value.
  WRITE L_value(3) TO l_zotyp.

  loop at lt_nlei_all into ls_nlei_all.
    LS_NLEI_ALL-ZOTYP = l_zotyp.
    append LS_NLEI_ALL to Lt_NLEI_correct.
  ENDLOOP.

endif.
ENDFORM.                               "FIND DATA

*&---------------------------------------------------------------------*
*&      Form  UPDATE_LIST
*&---------------------------------------------------------------------*
*       text                                                           *
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM update_list.

  IF pa_test = ' '.
    IF NOT lt_nlei_correct[] IS INITIAL.

      MODIFY nlei FROM TABLE lt_nlei_correct.
      IF sy-subrc = 0.
        COMMIT WORK.
        WRITE: / 'Update auf die NLEI war erfolgreich!'(006).
      ELSE.
        ROLLBACK WORK.
        WRITE: / 'Update auf die NLEI war nicht erfolgreich!'(007).
      ENDIF.
    ENDIF.
  ELSE.
    WRITE: / 'Testlauf, keine Änderung in der Datenbank!'(008).
  ENDIF.

ENDFORM.                    "update_list
*&---------------------------------------------------------------------*
*&      Form  WRITE_LIST
*&---------------------------------------------------------------------*
*       text                                                           *
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM write_list.



  SKIP 1.
  WRITE: / 'Leistungsfehler:'(009).
  WRITE: / sy-uline.

  SORT lt_nlei_correct BY lnrls.

  LOOP AT lt_nlei_correct INTO ls_nlei_all.
    if  l_switch = 'X'.
      l_switch = ' '.
    else.
      l_switch = 'X'.
    endif.
    PERFORM col_normal USING l_switch.
    WRITE: / sy-vline.
    WRITE:   'Leistungsnummer:'(010).
    WRITE:    ls_nlei_all-lnrls.
    WRITE:    'Leistungscode:'(011).
    WRITE:    ls_nlei_all-leist.
  ENDLOOP.
  WRITE: sy-uline.

ENDFORM.                    "write_list
