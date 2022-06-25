FUNCTION ishmed_gui_appl_settings.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_STARTING_ROW) TYPE  I DEFAULT 5
*"     REFERENCE(I_STARTING_COL) TYPE  I DEFAULT 5
*"     REFERENCE(I_ENDING_ROW) TYPE  I DEFAULT 10
*"     REFERENCE(I_ENDING_COL) TYPE  I DEFAULT 85
*"----------------------------------------------------------------------


  CALL SCREEN 0100
    STARTING AT i_starting_col i_starting_row
    ENDING AT i_ending_col i_ending_row.


ENDFUNCTION.
