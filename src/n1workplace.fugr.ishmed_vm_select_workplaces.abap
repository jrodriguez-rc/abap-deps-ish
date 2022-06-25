FUNCTION ishmed_vm_select_workplaces .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IT_V_NWPUSZ) TYPE  ISHMED_T_V_NWPUSZ
*"  EXPORTING
*"     REFERENCE(ET_V_NWPLACE) TYPE  ISHMED_T_V_NWPLACE
*"  EXCEPTIONS
*"      NO_NWPLACE
*"----------------------------------------------------------------------
*
* MED66621 Optimized access to workplaces
*   Preparation/creation by note 2584646
*   Release by note 2588834

  DATA lt_nwpusz TYPE ishmed_t_v_nwpusz.
  DATA l_wa_nwpusz TYPE v_nwpusz.
  DATA l_wa_nwplace TYPE v_nwplace.

  lt_nwpusz = it_v_nwpusz.

  IF lt_nwpusz IS INITIAL.
    RAISE no_nwplace.
    EXIT.                     "----------------------------------------------------------->
  ENDIF.

* Check if Workplaces are already buffered and try to take from global table if yes

  IF gt_nwplace IS NOT INITIAL.

    LOOP AT lt_nwpusz INTO l_wa_nwpusz.
      READ TABLE gt_nwplace INTO l_wa_nwplace
                WITH KEY wplacetype = l_wa_nwpusz-wplacetype
                          wplaceid   = l_wa_nwpusz-wplaceid.
      IF sy-subrc = 0.
        APPEND l_wa_nwplace TO et_v_nwplace.
      ENDIF.
    ENDLOOP.

  ENDIF.

  DESCRIBE TABLE et_v_nwplace .
  IF sy-tfill = 0 .            " SELECT from Database if data can not be taken from buffering
    SELECT
         np~mandt
         np~wplacetype
         np~wplaceid
         np~titel_inactiv
         np~owner
         nt~spras
         nt~txt
       INTO CORRESPONDING FIELDS OF TABLE et_v_nwplace
       FROM nwplace AS np
       LEFT OUTER JOIN nwplacet AS nt                       "#EC CI_BUFFJOIN
          ON   np~wplacetype EQ nt~wplacetype
          AND np~wplaceid   EQ nt~wplaceid
          AND nt~spras      = sy-langu
       FOR ALL ENTRIES IN lt_nwpusz
          WHERE np~wplacetype EQ lt_nwpusz-wplacetype
          AND   np~wplaceid   EQ lt_nwpusz-wplaceid.
    .
  ENDIF.

*  IF sy-subrc = 0.                                                       " MED-68723 Note 2702876 Bi
  IF sy-subrc = 0 AND lines( gt_nwplace ) LT lines( et_v_nwplace ).       " MED-68723 Note 2702876 Bi
    gt_nwplace = et_v_nwplace .
  ENDIF.

  IF et_v_nwplace IS INITIAL.
    RAISE no_nwplace.
  ENDIF.


ENDFUNCTION.
