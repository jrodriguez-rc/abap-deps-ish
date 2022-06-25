*&---------------------------------------------------------------------*
*& Report  RN1_CORRECT_NTMN_NAPP
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  rn1_correct_ntmn_napp.

INCLUDE <icon>.
INCLUDE <symbol>.
INCLUDE mndata00.
INCLUDE mncolour.
INCLUDE <line>.

TABLES: n1anf, nlei.

* Selektion über NLEM mit IBGDT und FALNR und ANFID
* NUR Leistungen MIT Termin UND Bewegungsbezug berücksichtigen
* Termine selektieren
* wenn Termine OHNE Bewegungsbezug gefunden werden, dann korrigieren

* institution
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (15) text-a01 FOR FIELD pa_einri.
SELECTION-SCREEN POSITION 40.
PARAMETERS pa_einri TYPE n1anf-einri.
SELECTION-SCREEN END OF LINE.
* date
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (24) text-a02 FOR FIELD so_ibgdt.
SELECTION-SCREEN POSITION 37.
SELECT-OPTIONS so_ibgdt FOR nlei-ibgdt DEFAULT sy-datum.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN SKIP.
* correct data
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (39) text-a03 FOR FIELD pa_test.
SELECTION-SCREEN POSITION 41.
PARAMETERS pa_test  AS CHECKBOX DEFAULT on.
SELECTION-SCREEN END OF LINE.

DATA: gt_nlem          TYPE STANDARD TABLE OF nlem,
      gt_nlei          TYPE STANDARD TABLE OF nlei,
      gt_nbew          TYPE STANDARD TABLE OF nbew,
      gt_ntmn          TYPE STANDARD TABLE OF ntmn,
      gt_napp          TYPE STANDARD TABLE OF napp.

INITIALIZATION.

  IF pa_einri IS INITIAL.
    GET PARAMETER ID 'EIN' FIELD pa_einri.
  ENDIF.

START-OF-SELECTION.

* check institution
  IF pa_einri IS INITIAL.
    SET CURSOR FIELD pa_einri.
    MESSAGE s819(nf1).
    EXIT.
  ENDIF.
* check date
  IF so_ibgdt-low IS INITIAL.
    SET CURSOR FIELD so_ibgdt-low.
    MESSAGE s664(nf1).
    EXIT.
  ENDIF.
  IF so_ibgdt-high IS INITIAL.
    SET CURSOR FIELD so_ibgdt-high.
    MESSAGE s664(nf1).
    EXIT.
  ENDIF.

* select incorrect data
  PERFORM select_data.

* update data in internal tables
  PERFORM update_internal.

* write header
  PERFORM header.

* write corrected data
  PERFORM output.

* update data on database
  CHECK pa_test = off.
  PERFORM update_db.

*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
FORM select_data.

  SELECT * FROM nlei INTO TABLE gt_nlei
    WHERE einri =  pa_einri
      AND ibgdt IN so_ibgdt
      AND falnr <> space
      AND storn =  off.

  DELETE gt_nlei WHERE lfdbew IS INITIAL.
  CHECK NOT gt_nlei IS INITIAL.

  SELECT * FROM nlem INTO TABLE gt_nlem
    FOR ALL ENTRIES IN gt_nlei
      WHERE einri = gt_nlei-einri
        AND lnrls = gt_nlei-lnrls.

  DELETE gt_nlem WHERE tmnid IS INITIAL.
  DELETE gt_nlem WHERE anfid IS INITIAL.
  CHECK NOT gt_nlem IS INITIAL.

  SELECT * FROM ntmn INTO TABLE gt_ntmn
    FOR ALL ENTRIES IN gt_nlem
      WHERE einri = gt_nlem-einri
        AND tmnid = gt_nlem-tmnid.

  DELETE gt_ntmn WHERE NOT tmnlb IS INITIAL.
  DELETE gt_ntmn WHERE storn = on.
  CHECK NOT gt_ntmn IS INITIAL.

  SELECT * FROM napp INTO TABLE gt_napp
    FOR ALL ENTRIES IN gt_ntmn
      WHERE einri = gt_ntmn-einri
        AND tmnid = gt_ntmn-tmnid.

ENDFORM.                    " SELECT_DATA
*&---------------------------------------------------------------------*
*&      Form  UPDATE_INTERNAL
*&---------------------------------------------------------------------*
FORM update_internal.

  FIELD-SYMBOLS: <ls_ntmn>  TYPE ntmn,
                 <ls_napp>  TYPE napp,
                 <ls_nlei>  TYPE nlei,
                 <ls_nlem>  TYPE nlem.

  LOOP AT gt_ntmn ASSIGNING <ls_ntmn>.
    READ TABLE gt_napp ASSIGNING <ls_napp> WITH KEY einri = <ls_ntmn>-einri
                                                    tmnid = <ls_ntmn>-tmnid.
    IF sy-subrc = 0.
      READ TABLE gt_nlem ASSIGNING <ls_nlem> WITH KEY einri = <ls_ntmn>-einri
                                                      tmnid = <ls_ntmn>-tmnid.
      IF sy-subrc = 0.
        READ TABLE gt_nlei ASSIGNING <ls_nlei> WITH KEY einri = <ls_nlem>-einri
                                                        lnrls = <ls_nlem>-lnrls.
        IF sy-subrc = 0.
          CHECK <ls_ntmn>-falnr = <ls_nlei>-falnr.
          CHECK <ls_napp>-falnr = <ls_nlei>-falnr.
          <ls_ntmn>-tmnlb = <ls_nlei>-lfdbew.
          <ls_napp>-lfdnr = <ls_nlei>-lfdbew.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " UPDATE_INTERNAL
*&---------------------------------------------------------------------*
*&      Form  HEADER
*&---------------------------------------------------------------------*
FORM header .

  WRITE:/1(10)  text-b01 COLOR 3 INTENSIFIED OFF.
  WRITE: 12(12) text-b02 COLOR 3 INTENSIFIED OFF.
  WRITE: 26(10) text-b03 COLOR 3 INTENSIFIED OFF.
  WRITE: 38(8)  text-b04 COLOR 3 INTENSIFIED OFF.
  WRITE:/ sy-uline.

ENDFORM.                    " HEADER
*&---------------------------------------------------------------------*
*&      Form  OUTPUT
*&---------------------------------------------------------------------*
FORM output .

  DATA: ls_ntmn TYPE ntmn,
        lt_nbew TYPE STANDARD TABLE OF nbew,
        ls_nbew TYPE nbew.

  CHECK NOT gt_ntmn IS INITIAL.
  SORT gt_ntmn BY tmndt DESCENDING.

  SELECT * FROM nbew INTO TABLE lt_nbew
    FOR ALL ENTRIES IN gt_ntmn
      WHERE einri = gt_ntmn-einri
        AND falnr = gt_ntmn-falnr
        AND lfdnr = gt_ntmn-tmnlb.

  LOOP AT gt_ntmn INTO ls_ntmn.
    WRITE:/1 ls_ntmn-tmnid COLOR 3 INTENSIFIED OFF,
          12 ls_ntmn-tmndt,
          26 ls_ntmn-falnr,
          38 ls_ntmn-tmnlb.
    READ TABLE lt_nbew INTO ls_nbew WITH KEY einri = ls_ntmn-einri
                                             falnr = ls_ntmn-falnr
                                             lfdnr = ls_ntmn-tmnlb.
    IF sy-subrc = 0.
      CASE ls_nbew-planb.
        WHEN ' '.
        WHEN OTHERS.
          WRITE: 48 text-c01.
      ENDCASE.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " OUTPUT
*&---------------------------------------------------------------------*
*&      Form  UPDATE_DB
*&---------------------------------------------------------------------*
FORM update_db.

  CHECK pa_test = off.
  CHECK NOT gt_ntmn IS INITIAL.
  CHECK NOT gt_napp IS INITIAL.

  UPDATE ntmn FROM TABLE gt_ntmn.
  IF sy-subrc = 0.
    UPDATE napp FROM TABLE gt_napp.
    COMMIT WORK AND WAIT.
  ELSE.
    ROLLBACK WORK.
  ENDIF.

ENDFORM.                    " UPDATE_DB
