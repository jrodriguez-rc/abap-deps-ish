FUNCTION ish_sdy_admission_init.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_SCR_ADMISSION) TYPE REF TO  CL_ISH_SCR_ADMISSION
*"       OPTIONAL
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(ES_PARENT) TYPE  RNSCR_PARENT
*"     REFERENCE(ER_DYNPG_LB_FALAR) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNNR_LB_FALAR) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNPG_LB_BEWAR) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNNR_LB_BEWAR) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNPG_LB_FATYP) TYPE REF TO  DATA
*"     REFERENCE(ER_DYNNR_LB_FATYP) TYPE REF TO  DATA
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"     REFERENCE(CR_DYNP_DATA) TYPE REF TO  DATA
*"----------------------------------------------------------------------

* Michael Manoch, 11.02.2010, MED-38637
* Whole function redesigned.

  GET REFERENCE OF rn1_dynp_admission INTO cr_dynp_data.


*  CLEAR: gr_subscr_admission,
*         es_parent,
*         e_rc.
*
** Handle process object.
*  gr_subscr_admission = ir_scr_admission.
*  IF gr_subscr_admission IS INITIAL.
*    e_rc = 1.
*  ENDIF.
*
*  CHECK e_rc = 0.
*
** program and dynpro
*  CALL METHOD gr_subscr_admission->get_parent
*    IMPORTING
*      es_parent = es_parent.
*
** Export dynpro structure.
*  GET REFERENCE OF rn1_dynp_admission INTO cr_dynp_data.
*
*  GET REFERENCE OF g_dynpg_lb_falar INTO er_dynpg_lb_falar.
*  GET REFERENCE OF g_dynnr_lb_falar INTO er_dynnr_lb_falar.
*  GET REFERENCE OF g_dynpg_lb_bewar INTO er_dynpg_lb_bewar.
*  GET REFERENCE OF g_dynnr_lb_bewar INTO er_dynnr_lb_bewar.
*  GET REFERENCE OF g_dynpg_lb_fatyp INTO er_dynpg_lb_fatyp.
*  GET REFERENCE OF g_dynnr_lb_fatyp INTO er_dynnr_lb_fatyp.

ENDFUNCTION.
