FUNCTION ish_sdy_tabstrip_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_TABSTRIP) TYPE REF TO  CL_ISH_SCR_TABSTRIP
*"  EXPORTING
*"     REFERENCE(ER_TS_TABSTRIP) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNPG_SUBSCREEN) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNNR_SUBSCREEN) TYPE REF TO  DATA
*"     VALUE(ET_TSPB) TYPE  ISH_T_REF_DATA
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------


  DATA: lr_tspb       TYPE n1_ref_data,
        ls_parent     TYPE rnscr_parent,
        l_name        TYPE string,
        l_idx         TYPE i,
        l_idx_string  TYPE string.

  FIELD-SYMBOLS: <l_ts>  TYPE ANY.

* Set screen object.
  gr_scr_tabstrip = ir_scr_tabstrip.

  CHECK NOT gr_scr_tabstrip IS INITIAL.

* Get dynnr
  CALL METHOD gr_scr_tabstrip->get_parent
    IMPORTING
      es_parent = ls_parent.

* ED, ID 19185: check dynpro number greater equal 100 and
* lower equal 119!! -> BEGIN
  CHECK ls_parent-dynnr >= 100 AND ls_parent-dynnr <= 119.
*  CHECK ls_parent-dynnr >= 100 AND ls_parent-dynnr <> 119.
* ED, ID 19185 -> END

* Export tabstrip.
  CONCATENATE 'TS_TABSTRIP'
              ls_parent-dynnr
         INTO l_name
    SEPARATED BY '_'.
  CONDENSE l_name NO-GAPS.
  ASSIGN (l_name) TO <l_ts>.
  GET REFERENCE OF <l_ts> INTO er_ts_tabstrip.

* Export dynpg + dynnr for sc_tabstrip.
  GET REFERENCE OF g_dynpg_subscreen INTO er_dynpg_subscreen.
  GET REFERENCE OF g_dynnr_subscreen INTO er_dynnr_subscreen.

* Export tabstrip pushbuttons.
  l_idx = 0.
  DO 20 TIMES.
    l_idx = l_idx + 1.
    l_idx_string = l_idx.
    CONCATENATE 'TSPB_TAB'
                l_idx_string
           INTO l_name.
    CONDENSE l_name NO-GAPS.
    ASSIGN (l_name) TO <l_ts>.
    GET REFERENCE OF <l_ts> INTO lr_tspb.
    APPEND lr_tspb TO et_tspb.
  ENDDO.

ENDFUNCTION.
