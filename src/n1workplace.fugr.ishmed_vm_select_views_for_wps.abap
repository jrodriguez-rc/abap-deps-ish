FUNCTION ishmed_vm_select_views_for_wps .
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IT_WORKPLACES) TYPE  ISHMED_T_V_NWPLACE
*"  EXPORTING
*"     REFERENCE(ET_V_NWPVZ) TYPE  ISHMED_T_V_NWPVZ
*"  EXCEPTIONS
*"      NO_NWPVZ
*"----------------------------------------------------------------------
*
* MED66621 Optimized access to views for workplaces
*   Preparation/creation by note 2584646
*   Release by note 2588834

  DATA lt_nwpvz TYPE ishmed_t_v_nwpvz.
  DATA l_wa_nwpvz TYPE v_nwpvz.
  FIELD-SYMBOLS <ls_workplace> TYPE v_nwplace.


  IF gt_nwpvz IS NOT INITIAL.         " Try to get data from global buffer
    LOOP AT it_workplaces ASSIGNING <ls_workplace>.
      LOOP AT gt_nwpvz INTO l_wa_nwpvz
                       WHERE wplacetype = <ls_workplace>-wplacetype
                         AND wplaceid   = <ls_workplace>-wplaceid.
        APPEND l_wa_nwpvz TO lt_nwpvz.
      ENDLOOP.
    ENDLOOP.
  ENDIF.
  DESCRIBE TABLE lt_nwpvz.
  IF sy-tfill = 0.
    SELECT
       nwv~mandt
       nwv~wplacetype
       nwv~wplaceid
       nwv~viewtype
       nwv~viewid
       nwv~sortid
       nwv~vdefault
       nwv~foldertype
       nwv~folderid
       nwvt~spras
       nwvt~txt
     INTO CORRESPONDING FIELDS OF TABLE lt_nwpvz
     FROM nwpvz AS nwv
     LEFT OUTER JOIN nwpvzt AS nwvt                         "#EC CI_BUFFJOIN
        ON   nwv~wplacetype EQ nwvt~wplacetype
        AND nwv~wplaceid   EQ nwvt~wplaceid
        AND nwv~viewtype  EQ nwvt~viewtype
        AND nwv~viewid    EQ nwvt~viewid
        AND nwvt~spras      = sy-langu
     FOR ALL ENTRIES IN it_workplaces
        WHERE nwv~wplacetype EQ it_workplaces-wplacetype
        AND   nwv~wplaceid   EQ it_workplaces-wplaceid.
    .
    IF sy-subrc = 0.
      gt_nwpvz = lt_nwpvz.
    ENDIF.

  ENDIF.

  DESCRIBE TABLE lt_nwpvz.
  IF sy-tfill = 0.
    RAISE no_nwpvz.        " auch OK, wenn noch keine Sicht
    EXIT.                        " vorhanden ist ...
  ELSE.
    et_v_nwpvz = lt_nwpvz.
  ENDIF.


ENDFUNCTION.
