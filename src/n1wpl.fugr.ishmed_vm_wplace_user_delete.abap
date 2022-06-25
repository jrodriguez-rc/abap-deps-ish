FUNCTION ishmed_vm_wplace_user_delete.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_USERID) LIKE  SY-UNAME DEFAULT SY-UNAME
*"     VALUE(I_AGR_NAME) TYPE  AGR_NAME OPTIONAL
*"     VALUE(I_SAVE) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     REFERENCE(I_CALLER) LIKE  SY-REPID
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"  TABLES
*"      T_NWPLACE STRUCTURE  NWPLACE
*"      T_NWPUSZ STRUCTURE  VNWPUSZ OPTIONAL
*"      T_NWPUSZT STRUCTURE  VNWPUSZT OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_nwpusz  LIKE TABLE OF vnwpusz,
        lt_nwpuszt LIKE TABLE OF vnwpuszt,
        l_nwpusz   LIKE vnwpusz,
        l_nwpuszt  LIKE vnwpuszt.

  CLEAR:   e_rc.
  REFRESH: lt_nwpusz, lt_nwpuszt, t_nwpusz, t_nwpuszt.

  DESCRIBE TABLE t_nwplace.
  CHECK sy-tfill > 0.

*  IF i_agr_name IS INITIAL.                           " REM ID 16502
  IF NOT i_agr_name IS SUPPLIED.                           " ID 16502
    SELECT * FROM nwpusz INTO TABLE lt_nwpusz
           FOR ALL ENTRIES IN t_nwplace
           WHERE  wplacetype  = t_nwplace-wplacetype
           AND    wplaceid    = t_nwplace-wplaceid
           AND    benutzer    = i_userid.
  ELSE.
    SELECT * FROM nwpusz INTO TABLE lt_nwpusz
           FOR ALL ENTRIES IN t_nwplace
           WHERE  wplacetype  = t_nwplace-wplacetype
           AND    wplaceid    = t_nwplace-wplaceid
           AND    benutzer    = i_userid
           AND    agr_name    = i_agr_name.
  ENDIF.
  IF sy-subrc <> 0.
    MESSAGE s503.
*   Über Rollen/* zugeordnete Arbeitsumfelder sind nicht ausgeblendbar
    e_rc = 1.
    EXIT.
  ENDIF.

  LOOP AT lt_nwpusz INTO l_nwpusz.
    l_nwpusz-kz = 'D'.
    MODIFY lt_nwpusz FROM l_nwpusz.
  ENDLOOP.

  SELECT * FROM nwpuszt INTO TABLE lt_nwpuszt
         FOR ALL ENTRIES IN lt_nwpusz
         WHERE  wplacetype  = lt_nwpusz-wplacetype
         AND    wplaceid    = lt_nwpusz-wplaceid
         AND    agr_name    = lt_nwpusz-agr_name
         AND    benutzer    = lt_nwpusz-benutzer
         AND    spras       = sy-langu.

  LOOP AT lt_nwpuszt INTO l_nwpuszt.
    l_nwpuszt-kz = 'D'.
    MODIFY lt_nwpuszt FROM l_nwpuszt.
  ENDLOOP.

  t_nwpusz[]  = lt_nwpusz[].
  t_nwpuszt[] = lt_nwpuszt[].

  IF i_save = on.
    IF i_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWPUSZ' IN UPDATE TASK
           EXPORTING
*            I_DATE           = SY-DATUM
             i_tcode          = sy-tcode
*            I_UNAME          = SY-UNAME
*            I_UTIME          = SY-UZEIT
           TABLES
             t_n_nwpusz       = lt_nwpusz
             t_o_nwpusz       = lt_nwpusz.
      CALL FUNCTION 'ISH_VERBUCHER_NWPUSZT' IN UPDATE TASK
           EXPORTING
*            I_DATE            = SY-DATUM
             i_tcode           = sy-tcode
*            I_UNAME           = SY-UNAME
*            I_UTIME           = SY-UZEIT
           TABLES
             t_n_nwpuszt       = lt_nwpuszt
             t_o_nwpuszt       = lt_nwpuszt.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWPUSZ'
           EXPORTING
*            I_DATE           = SY-DATUM
             i_tcode          = sy-tcode
*            I_UNAME          = SY-UNAME
*            I_UTIME          = SY-UZEIT
           TABLES
             t_n_nwpusz       = lt_nwpusz
             t_o_nwpusz       = lt_nwpusz.
      CALL FUNCTION 'ISH_VERBUCHER_NWPUSZT'
           EXPORTING
*            I_DATE            = SY-DATUM
             i_tcode           = sy-tcode
*            I_UNAME           = SY-UNAME
*            I_UTIME           = SY-UZEIT
           TABLES
             t_n_nwpuszt       = lt_nwpuszt
             t_o_nwpuszt       = lt_nwpuszt.
    ENDIF.
    IF i_commit = on.
      COMMIT WORK AND WAIT.
    ENDIF.
*   Puffer clearen
    CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
      EXPORTING
        i_placetype = l_nwpusz-wplacetype
        i_mode      = 'C'
        i_caller    = 'LN1WPLU04'.
  ENDIF.

ENDFUNCTION.
