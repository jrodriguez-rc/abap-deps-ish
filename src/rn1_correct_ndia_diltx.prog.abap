*&---------------------------------------------------------------------*
*& Report  RN1_CORRECT_NDIA_DILTX
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT  rn1_correct_ndia_diltx.

INCLUDE mndata00.

SELECTION-SCREEN BEGIN OF BLOCK one.
*-- Test run.
PARAMETERS pa_test AS CHECKBOX DEFAULT on.

*-- date
PARAMETERS p_beg_dt TYPE dats OBLIGATORY.
PARAMETERS p_end_dt TYPE dats OBLIGATORY DEFAULT sy-datum.
SELECTION-SCREEN END OF BLOCK one.

DATA: l_cursor     TYPE cursor,
      lt_ndia      TYPE TABLE OF ndia,
      lt_stxh      TYPE TABLE OF stxh,
      ls_stxh      TYPE stxh,
      ls_ndia      TYPE ndia,
      l_diakey(70) TYPE c,
      lt_ndia_n    TYPE TABLE OF ndia,
      lt_ndia_w    TYPE TABLE OF ndia,
      ls_ndia_n    TYPE ndia,
      l_falnr      TYPE ndia-falnr,
      l_einri      TYPE ndia-einri,
      l_lfdnr      TYPE ndia-lfdnr.

START-OF-SELECTION.

*-- Open Cursor for current client.
  OPEN CURSOR WITH HOLD l_cursor FOR
     SELECT * FROM stxh
       WHERE tdobject   = 'NDIA' AND
             tdfdate   >= p_beg_dt AND
             tdfdate   <= p_end_dt.
  DO.
    REFRESH: lt_stxh, lt_ndia_n.

*-- Select data.
    FETCH NEXT CURSOR l_cursor INTO TABLE lt_stxh PACKAGE SIZE 5000.
    IF sy-subrc <> 0.
*-- No more entries => exit for next client.
      EXIT.
    ENDIF.

    LOOP AT lt_stxh INTO ls_stxh.
      CLEAR ls_ndia.
      l_einri = ls_stxh-tdname(4).
      l_falnr = ls_stxh-tdname+4(10).
      l_lfdnr = ls_stxh-tdname+14(3).
      CHECK NOT l_einri IS INITIAL AND
            NOT l_falnr IS INITIAL AND
            NOT l_lfdnr IS INITIAL.
*-- select ndia
      SELECT SINGLE * FROM ndia INTO ls_ndia
        WHERE einri = l_einri AND
              falnr = l_falnr AND
              lfdnr = l_lfdnr AND
              diltx = off.
      CHECK sy-subrc EQ 0.
      ls_ndia-diltx = on.
      WRITE:/ 'TDNAME' ,ls_stxh-tdname.
      APPEND ls_ndia TO lt_ndia_n.
      APPEND ls_ndia TO lt_ndia_w.
    ENDLOOP.

    IF pa_test = off AND NOT lt_ndia_n IS INITIAL.
      MODIFY ndia FROM TABLE lt_ndia_n.
      CALL FUNCTION 'DB_COMMIT'.
    ENDIF.

  ENDDO.

  IF lt_ndia_w[] IS INITIAL.
    WRITE:/ text-001.
  ENDIF.

*-- close cursor for current client.
  CLOSE CURSOR l_cursor.
