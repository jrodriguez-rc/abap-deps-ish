FUNCTION ishmed_status_select.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_TITLE) OPTIONAL
*"     VALUE(I_OBTYP) TYPE  TJ21-OBTYP OPTIONAL
*"     VALUE(IT_STSMA) TYPE  ISH_T_STSMA OPTIONAL
*"     VALUE(IT_STATUS_MARK) TYPE  ISH_T_STATUS OPTIONAL
*"     VALUE(IT_STSMA_MARK) TYPE  ISH_T_STSMA OPTIONAL
*"     VALUE(IT_ESTAT_MARK) TYPE  ISH_T_ESTAT OPTIONAL
*"     VALUE(I_MODE) TYPE  VCODE DEFAULT 'UPD'
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     REFERENCE(ET_STATUS) TYPE  ISH_T_STATUS
*"     REFERENCE(ET_STATUS_OBJ) TYPE  ISH_T_STATUS_OBJ
*"     REFERENCE(ET_STSMA) TYPE  ISH_T_STSMA
*"     REFERENCE(ET_ESTAT) TYPE  ISH_T_ESTAT
*"----------------------------------------------------------------------

  CLEAR e_rc.

  REFRESH: gt_stsma, gt_status_marked, gt_status_obj_marked,
           gt_stsma_marked, gt_estat_marked,
           et_status, et_status_obj, et_stsma, et_estat.

* set popup title
  IF i_title IS INITIAL.
    g_title = 'Statusauswahl'(001).
  ELSE.
    g_title = i_title.
  ENDIF.

* set mode
  g_vcode = i_mode.

* set object type for status selection
  g_obtyp = i_obtyp.

* get status to show eventually
  gt_stsma[] = it_stsma[].

* object type or status are required
  IF g_obtyp IS INITIAL AND gt_stsma[] IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* get status to premark
  gt_status_marked[] = it_status_mark[].
  gt_stsma_marked[]  = it_stsma_mark[].
  gt_estat_marked[]  = it_estat_mark[].

* ---------- ---------- ---------- ---------- ---------- ----------
* call popup
  CALL SCREEN 100 STARTING AT 8  3
                  ENDING   AT 53 13.
* ---------- ---------- ---------- ---------- ---------- ----------

  IF ok-code = 'ENTR'.
*   enter
    et_status[]     = gt_status_marked[].
    et_status_obj[] = gt_status_obj_marked[].
    et_stsma[]      = gt_stsma_marked[].
    et_estat[]      = gt_estat_marked[].
  ELSE.
*   cancel
    e_rc = 2.
  ENDIF.

  PERFORM free_status_grid.

ENDFUNCTION.
