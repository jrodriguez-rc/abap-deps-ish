FUNCTION ish_gui_mdy_popup_simple .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_APPLICATION) TYPE REF TO  IF_ISH_GUI_APPLICATION
*"     REFERENCE(I_START_COL) TYPE  I DEFAULT 10
*"     REFERENCE(I_START_ROW) TYPE  I DEFAULT 10
*"     REFERENCE(I_END_COL) TYPE  I DEFAULT 70
*"     REFERENCE(I_END_ROW) TYPE  I DEFAULT 25
*"     REFERENCE(IS_LT_FALLNR_INITIAL) TYPE  ABAP_BOOL DEFAULT ' '
*"     REFERENCE(I_EINRI) TYPE  EINRI OPTIONAL
*"     REFERENCE(I_PATNR) TYPE  PATNR OPTIONAL
*"     REFERENCE(IT_NBEW_TMP) TYPE  ISHMED_T_NBEW OPTIONAL
*"  CHANGING
*"     REFERENCE(CT_FALNR) TYPE  ISH_T_NFAL OPTIONAL
*"----------------------------------------------------------------------


  DATA l_dynnr            TYPE sydynnr.
  DATA lr_controller      TYPE REF TO if_ish_gui_controller.
  DATA lr_view            TYPE REF TO if_ish_gui_dynpro_view.


  DATA l_patnr TYPE patnr.  " med-48629
  RANGES: r_falnr FOR nfal-falnr,  " med-48629
          r_orgid FOR norg-orgid.  " med-48629


*  CHECK ir_application IS BOUND.  " med-48629
  IF ir_application IS BOUND.  " med-48629
  lr_controller = ir_application->get_main_controller( ).
  CHECK lr_controller IS BOUND.
  TRY.
      lr_view ?= lr_controller->get_view( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_view IS BOUND.

  l_dynnr = lr_view->get_dynnr( ).
*  CHECK l_dynnr >= 0100. "MED-47686 M.Rebegea 28.05.2012
*  CHECK l_dynnr <= 0101.  "MED-47686 M.Rebegea 28.05.2012

  ENDIF.   " med-48629

*****Start: MED-52333 M.Rebegea 09.12.2013
* Refactoring of MED-48629

***Begin of MED-48629, Jitareanu Cristina 24.10.2012
  "für die Rekonstruktion der Fallliste
  IF is_lt_fallnr_initial = 'X'.      "the case table is here populated in the _INITIALIZE method of
                                      "the class CL_ISHMED_NRS_PKMS_HANDLER, in order not to change the workflow of
                                      "other calls of this Function module I let the if like this

*    "Initialize the global fields of the Pop-up with the values from the handler to write the list
*    einri = i_einri.
*    l_patnr = i_patnr.

*    SELECT * FROM nfal INTO TABLE outtab_nfal
*             WHERE  einri = einri
*             AND   patnr = l_patnr.
*
*    LOOP AT outtab_nfal .
** Koppensteiner, ID 5111 - End
*      r_falnr-sign   = 'I'.
*      r_falnr-option = 'EQ'.
*      r_falnr-low    = outtab_nfal-falnr.
*      APPEND r_falnr.
*    ENDLOOP.
*
*    SELECT * FROM nbew INTO TABLE outtab_nbew
*                   WHERE einri = einri
*                   AND   falnr IN r_falnr
*                   AND   orgpf IN r_orgid
*                   AND   bwidt >= '19000101' " this dates are set,
*                   AND   bwidt <= '99991231' " because the case number is no longer valid.
*                   AND   storn <> 'X'.
  CLEAR outtab_nfal.
  CLEAR outtab_nfal[].
  CLEAR outtab_nbew.
  CLEAR outtab_nbew[].
  APPEND LINES OF it_nbew_tmp TO outtab_nbew.
  APPEND LINES OF ct_falnr TO outtab_nfal.
*****End: MED-52333 M.Rebegea 09.12.2013

    g_node_plus  = sym_plus_folder.    "4
    g_node_minus = sym_minus_folder.   "5
    g_node_empty = sym_folder.         "3

    LOOP AT outtab_nfal.
      READ TABLE outtab_nbew WITH KEY einri = outtab_nfal-einri
                                      falnr = outtab_nfal-falnr.
      IF sy-subrc = 0.
*     Den Knoten nur auf Benutzerwunsch defaultmäßig öffnen
        outtab_nfal-node = g_node_minus.
        IF g_mts_closed = 'X'.
          outtab_nfal-node = g_node_plus.
        ENDIF.
      ELSE.
        outtab_nfal-node = g_node_empty.
      ENDIF.
      MODIFY outtab_nfal.
    ENDLOOP.

    CLEAR ct_falnr.                                                       "MED-52333 M.Rebegea 09.12.2013 Clear ct_falnr and fill it with the selected entry
    CALL SCREEN 200 STARTING AT 17 9 ENDING AT 108 22. "ED, ID 7442
  ELSE.
***End of MED-48629, Jitareanu Cristina 24.10.2012  "für die Rekonstruktion der Fallliste

    IF l_dynnr >= 0100 OR l_dynnr <= 0101 OR l_dynnr <= 0102. "MED-47686 M.Rebegea 28.05.2012
  IF i_end_col <= i_start_col OR
     i_end_row <= i_start_row.
    CALL SCREEN l_dynnr
      STARTING AT i_start_col i_start_row.
  ELSE.
    CALL SCREEN l_dynnr
      STARTING AT i_start_col i_start_row
      ENDING AT i_end_col i_end_row.
  ENDIF.
ENDIF. "MED-47686 M.Rebegea 28.05.2012
  ENDIF.
***Begin of MED-48629, Jitareanu Cristina 24.10.2012
  IF gs_nfal IS NOT INITIAL AND ( fcode <> 'END' OR fcode <> 'CAN' ).
    APPEND gs_nfal TO ct_falnr.
  ENDIF.
***End of MED-48629, Jitareanu Cristina 24.10.2012
ENDFUNCTION.
