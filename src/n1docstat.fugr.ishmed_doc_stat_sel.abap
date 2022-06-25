FUNCTION ishmed_doc_stat_sel.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IT_TDWST_LIST) TYPE  DMS_TBL_TDWST OPTIONAL
*"  CHANGING
*"     VALUE(CT_TDWST_SEL) TYPE  DMS_TBL_TDWST OPTIONAL
*"     VALUE(C_RC) TYPE  SY-SUBRC
*"----------------------------------------------------------------------
* Selected items
  DATA: lt_tdwst   TYPE STANDARD TABLE OF tdwst.

* Requested list, or all possible data
  IF it_tdwst_list[] IS INITIAL.
    SELECT * FROM tdwst INTO TABLE gt_tdwst_list
             WHERE cvlang = sy-langu.
  ELSE.
    gt_tdwst_list[] = it_tdwst_list[].
  ENDIF.

* Selected entries
  gt_tdwst_sel[] = ct_tdwst_sel[].

  CALL SCREEN 100 STARTING AT 5 5.

* Selected entries
  ct_tdwst_sel[] = gt_tdwst_sel[].

ENDFUNCTION.
