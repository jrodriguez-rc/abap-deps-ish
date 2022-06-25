FUNCTION ISHMED_TC_SHOW_MATRIX.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(I_INSTITUTION_ID) TYPE  EINRI
*"     REFERENCE(IT_MATRIX) TYPE  RN1TC_MATRIX_T OPTIONAL
*"----------------------------------------------------------------------

  clear gt_matrix.
  gt_matrix = it_matrix.

  if lines( gt_matrix ) eq 0.
    perform init_matrix_data USING i_institution_id.
  ENDIF.

  CALL SCREEN show_matrix_screen STARTING AT 10 3
                                 ENDING   AT 100 22.

  free gt_matrix.

ENDFUNCTION.
