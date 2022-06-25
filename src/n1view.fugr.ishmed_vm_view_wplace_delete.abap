FUNCTION ishmed_vm_view_wplace_delete.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_SAVE) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     REFERENCE(I_CALLER) LIKE  SY-REPID
*"  TABLES
*"      T_NWPVZ STRUCTURE  VNWPVZ OPTIONAL
*"      T_NWPVZT STRUCTURE  VNWPVZT OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_nwpvz  LIKE TABLE OF vnwpvz,
        lt_nwpvzt LIKE TABLE OF vnwpvzt,
        l_nwpvz   LIKE vnwpvz,
        l_nwpvzt  LIKE vnwpvzt.

  REFRESH: lt_nwpvz, lt_nwpvzt, t_nwpvzt.

  DESCRIBE TABLE t_nwpvz.
  CHECK sy-tfill > 0.

  SELECT * FROM nwpvz INTO TABLE lt_nwpvz
         FOR ALL ENTRIES IN t_nwpvz
         WHERE  wplacetype  = t_nwpvz-wplacetype
         AND    wplaceid    = t_nwpvz-wplaceid
         AND    viewtype    = t_nwpvz-viewtype
         AND    viewid      = t_nwpvz-viewid.
  CHECK sy-subrc = 0.

  LOOP AT lt_nwpvz INTO l_nwpvz.
    l_nwpvz-kz = 'D'.
    MODIFY lt_nwpvz FROM l_nwpvz.
  ENDLOOP.

  DESCRIBE TABLE lt_nwpvz.
  CHECK sy-tfill > 0.

  SELECT * FROM nwpvzt INTO TABLE lt_nwpvzt
         FOR ALL ENTRIES IN lt_nwpvz
         WHERE  wplacetype  = lt_nwpvz-wplacetype
         AND    wplaceid    = lt_nwpvz-wplaceid
         AND    viewtype    = lt_nwpvz-viewtype
         AND    viewid      = lt_nwpvz-viewid
         AND    spras       = sy-langu.

  LOOP AT lt_nwpvzt INTO l_nwpvzt.
    l_nwpvzt-kz = 'D'.
    MODIFY lt_nwpvzt FROM l_nwpvzt.
  ENDLOOP.

  t_nwpvz[]  = lt_nwpvz[].
  t_nwpvzt[] = lt_nwpvzt[].

  IF i_save = on.
    IF i_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPVZ' IN UPDATE TASK
        EXPORTING
*         I_DATE          = SY-DATUM
          i_tcode         = sy-tcode
*         I_UNAME         = SY-UNAME
*         I_UTIME         = SY-UZEIT
        TABLES
          t_n_nwpvz       = lt_nwpvz
          t_o_nwpvz       = lt_nwpvz.
      CALL FUNCTION 'ISH_VERBUCHER_NWPVZT' IN UPDATE TASK
        EXPORTING
*         I_DATE           = SY-DATUM
          i_tcode          = sy-tcode
*         I_UNAME          = SY-UNAME
*         I_UTIME          = SY-UZEIT
        TABLES
          t_n_nwpvzt       = lt_nwpvzt
          t_o_nwpvzt       = lt_nwpvzt.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPVZ'
        EXPORTING
*         I_DATE          = SY-DATUM
          i_tcode         = sy-tcode
*         I_UNAME         = SY-UNAME
*         I_UTIME         = SY-UZEIT
        TABLES
          t_n_nwpvz       = lt_nwpvz
          t_o_nwpvz       = lt_nwpvz.
      CALL FUNCTION 'ISH_VERBUCHER_NWPVZT'
        EXPORTING
*         I_DATE           = SY-DATUM
          i_tcode          = sy-tcode
*         I_UNAME          = SY-UNAME
*         I_UTIME          = SY-UZEIT
        TABLES
          t_n_nwpvzt       = lt_nwpvzt
          t_o_nwpvzt       = lt_nwpvzt.
    ENDIF.
    IF i_commit = on.
      COMMIT WORK AND WAIT.
    ENDIF.
*   Puffer clearen
    CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
         EXPORTING
              i_placetype = l_nwpvz-wplacetype
              i_mode      = 'C'
              i_caller    = 'LN1VIEWU04'.
  ENDIF.

ENDFUNCTION.
