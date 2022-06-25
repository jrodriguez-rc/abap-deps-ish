FUNCTION-POOL n1_sdy_admission.

* Michael Manoch, 11.02.2010, MED-38637
* Whole dynpros redesigned.

CONSTANTS: co_repid     TYPE syrepid VALUE 'SAPLN1_SDY_ADMISSION'.

TABLES: rn1_dynp_admission.


*INCLUDE mndata00.
*INCLUDE mndata01.
*INCLUDE mndata02.
*INCLUDE mncediev.
*INCLUDE mncdat20.
*
*TYPE-POOLS: vrm.
*
*CONSTANTS: vcode_anlegen  LIKE vcode VALUE 'INS',
*           vcode_aendern  LIKE vcode VALUE 'UPD',
*           vcode_anzeigen LIKE vcode VALUE 'DIS'.
*
*TABLES: rn1_dynp_admission.
*
*DATA: gr_subscr_admission TYPE REF TO cl_ish_scr_admission,
*      g_einri TYPE einri.
*
*DATA: g_dynpg_lb_falar       TYPE sy-repid VALUE 'SAPLN1SC',
*      g_dynnr_lb_falar       TYPE sy-dynnr VALUE '0001',
*      g_dynpg_lb_fatyp       TYPE sy-repid VALUE 'SAPLN1SC',
*      g_dynnr_lb_fatyp       TYPE sy-dynnr VALUE '0001',
*      g_dynpg_lb_bewar       TYPE sy-repid VALUE 'SAPLN1SC',
*      g_dynnr_lb_bewar       TYPE sy-dynnr VALUE '0001'.
