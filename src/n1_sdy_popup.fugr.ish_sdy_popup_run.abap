FUNCTION ish_sdy_popup_run.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DYNNR) TYPE  SY-DYNNR
*"     VALUE(I_STARTPOS_COL) TYPE  I DEFAULT 10
*"     VALUE(I_STARTPOS_ROW) TYPE  I DEFAULT 5
*"     VALUE(I_ENDPOS_COL) TYPE  I DEFAULT 0
*"     VALUE(I_ENDPOS_ROW) TYPE  I DEFAULT 0
*"----------------------------------------------------------------------


  CHECK NOT i_dynnr        IS INITIAL.

  IF i_startpos_col IS INITIAL.
    i_startpos_col = 10.
  ENDIF.
  IF i_startpos_row IS INITIAL.
    i_startpos_row = 5.
  ENDIF.

  IF i_endpos_col IS INITIAL OR
     i_endpos_row IS INITIAL.
    CALL SCREEN i_dynnr STARTING AT i_startpos_col i_startpos_row.
  ELSE.
    CALL SCREEN i_dynnr
      STARTING AT i_startpos_col i_startpos_row
        ENDING AT i_endpos_col   i_endpos_row.
  ENDIF.


ENDFUNCTION.
