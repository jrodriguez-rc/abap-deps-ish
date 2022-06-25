FUNCTION ishmed_popup_to_display_text.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_TITEL) DEFAULT SPACE
*"     VALUE(I_TEXTLINE1)
*"     VALUE(I_TEXTLINE2) DEFAULT SPACE
*"     VALUE(I_START_COLUMN) LIKE  SY-CUCOL DEFAULT 25
*"     VALUE(I_START_ROW) LIKE  SY-CUROW DEFAULT 6
*"----------------------------------------------------------------------

  spop-titel     = i_titel.

  spop-textline1 = i_textline1.
  spop-textline2 = i_textline2.

  CALL SCREEN 200 STARTING AT i_start_column i_start_row.

ENDFUNCTION.
