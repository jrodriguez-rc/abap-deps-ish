FUNCTION ishmed_vm_wplace_copy.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IT_NWPLACES) TYPE  ISHMED_T_NWPLACE
*"     VALUE(I_VIEWS_COPY) TYPE  CHAR1 DEFAULT 'C'
*"     VALUE(I_VARIANTS_COPY) TYPE  CHAR1 DEFAULT 'C'
*"     VALUE(I_PLACE_TEXT) TYPE  NWPLACETXT DEFAULT SPACE
*"     VALUE(I_USER_ZUO) TYPE  CHAR1 DEFAULT 'X'
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(ET_NWPLACES) TYPE  ISHMED_T_NWPLACE
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: lt_nwplace         TYPE TABLE OF nwplace,
        l_nwplace          TYPE nwplace,
        lt_nwplacet        TYPE HASHED TABLE OF nwplacet
                           WITH UNIQUE KEY wplacetype wplaceid spras,
        l_nwplacet         TYPE nwplacet,
        l_nwplace_001      TYPE nwplace_001,
        lt_nwpvz_all       TYPE TABLE OF nwpvz,
        lt_nwpvz           TYPE TABLE OF nwpvz,
        l_nwpvz            TYPE nwpvz,
        lt_nwpvzt_all      TYPE HASHED TABLE OF nwpvzt
                           WITH UNIQUE KEY wplacetype wplaceid
                                           viewtype   viewid   spras,
        lt_nwpvzt          TYPE TABLE OF nwpvzt,
        l_nwpvzt           TYPE nwpvzt,
        lt_nwview          TYPE ishmed_t_nwview,
        lt_nwview_new      TYPE ishmed_t_nwview,
        l_nwview           TYPE nwview,
        l_nwplace_old      TYPE nwplace,
        lt_nwpusz_all      TYPE TABLE OF nwpusz,
        lt_nwpusz          TYPE TABLE OF nwpusz,
        l_nwpusz           TYPE nwpusz,
        lt_nwpuszt_all     TYPE HASHED TABLE OF nwpuszt
                           WITH UNIQUE KEY wplacetype wplaceid
                                           agr_name   benutzer spras,
        lt_nwpuszt         TYPE TABLE OF nwpuszt,
        l_nwpuszt          TYPE nwpuszt,
        l_prio             TYPE nwpusz-prio,
        l_rc               TYPE sy-subrc,
        l_key              TYPE rnwp_gen_key-nwkey,
        lt_messages        TYPE TABLE OF bapiret2,
        l_wa_msg           TYPE bapiret2,
        l_agr_name         TYPE nwpusz-agr_name,
        l_idx              LIKE sy-index,
        l_idx_t            LIKE sy-tabix.

* initialization
  CLEAR:   t_messages, e_rc.
  REFRESH: t_messages, et_nwplaces, lt_nwpusz_all, lt_nwpuszt_all,
           lt_nwplace, lt_nwplacet, lt_nwpvz_all, lt_nwpvzt_all.

* is there any data to copy?
  DESCRIBE TABLE it_nwplaces.
  IF sy-tfill = 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* read all workplace data
  SELECT * FROM nwplace INTO TABLE lt_nwplace
         FOR ALL ENTRIES IN it_nwplaces
         WHERE  wplacetype  = it_nwplaces-wplacetype
         AND    wplaceid    = it_nwplaces-wplaceid.
  IF sy-subrc <> 0.
    READ TABLE it_nwplaces INTO l_nwplace INDEX 1.
*   workplace & not found
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '366' l_nwplace-wplaceid space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ELSE.
*   read workplace texts
    SELECT * FROM nwplacet INTO TABLE lt_nwplacet
           FOR ALL ENTRIES IN lt_nwplace
           WHERE  wplacetype  = lt_nwplace-wplacetype
           AND    wplaceid    = lt_nwplace-wplaceid
           AND    spras       = sy-langu.
*   read workplace-view-connection if requested
    IF i_views_copy = 'C' OR i_views_copy = 'Z'.
      SELECT * FROM nwpvz INTO TABLE lt_nwpvz_all
             FOR ALL ENTRIES IN lt_nwplace
             WHERE  wplacetype  = lt_nwplace-wplacetype
             AND    wplaceid    = lt_nwplace-wplaceid.   "#EC *
      IF sy-subrc = 0.
        SELECT * FROM nwpvzt INTO TABLE lt_nwpvzt_all
               FOR ALL ENTRIES IN lt_nwpvz_all
               WHERE  wplacetype  = lt_nwpvz_all-wplacetype
               AND    wplaceid    = lt_nwpvz_all-wplaceid
               AND    viewtype    = lt_nwpvz_all-viewtype
               AND    viewid      = lt_nwpvz_all-viewid
               AND    spras       = sy-langu.
      ENDIF.
    ENDIF.
*   read workplace-user-connections if it should be copied
    IF i_user_zuo = '*'.
      SELECT * FROM nwpusz into table lt_nwpusz_all
             for all entries in lt_nwplace
             WHERE  wplacetype  = lt_nwplace-wplacetype
             AND    wplaceid    = lt_nwplace-wplaceid.
      if sy-subrc = 0.
        SELECT * FROM nwpuszt into table lt_nwpuszt_all
               for all entries in lt_nwpusz_all
               WHERE  wplacetype  = lt_nwpusz_all-wplacetype
               AND    wplaceid    = lt_nwpusz_all-wplaceid
               AND    agr_name    = lt_nwpusz_all-agr_name
               AND    benutzer    = lt_nwpusz_all-benutzer
               AND    spras       = sy-langu.
      endif.
    ENDIF.
  ENDIF.

* copy workplaces
  LOOP AT lt_nwplace INTO l_nwplace.

*   initialization
    CLEAR:   l_nwplacet, l_nwplace_001, l_nwplace_old.
    REFRESH: lt_nwpvz, lt_nwpvzt, lt_nwview, lt_nwview_new,
             lt_nwpusz, lt_nwpuszt.

*   read text of workplace for copy
    READ TABLE lt_nwplacet INTO l_nwplacet
               WITH TABLE KEY wplacetype = l_nwplace-wplacetype
                              wplaceid   = l_nwplace-wplaceid
                              spras      = sy-langu.
    IF sy-subrc <> 0.
      l_nwplacet-mandt      = sy-mandt.
      l_nwplacet-wplacetype = l_nwplace-wplacetype.
      l_nwplacet-spras      = sy-langu.
    ENDIF.

*   read workplace-view-connection if requested
    LOOP AT lt_nwpvz_all INTO l_nwpvz
                         WHERE wplacetype = l_nwplace-wplacetype
                           AND wplaceid   = l_nwplace-wplaceid.
      APPEND l_nwpvz TO lt_nwpvz.
      CLEAR l_nwpvzt.
      READ TABLE lt_nwpvzt_all INTO l_nwpvzt
                 WITH TABLE KEY wplacetype = l_nwplace-wplacetype
                                wplaceid   = l_nwplace-wplaceid
                                viewtype   = l_nwpvz-viewtype
                                viewid     = l_nwpvz-viewid
                                spras      = sy-langu.
      IF sy-subrc <> 0.
        l_nwpvzt-mandt      = sy-mandt.
        l_nwpvzt-wplacetype = l_nwplace-wplacetype.
        l_nwpvzt-wplaceid   = l_nwplace-wplaceid.
        l_nwpvzt-viewtype   = l_nwpvz-viewtype.
        l_nwpvzt-viewid     = l_nwpvz-viewid.
        l_nwpvzt-spras      = sy-langu.
      ENDIF.
      APPEND l_nwpvzt TO lt_nwpvzt.
    ENDLOOP.

*   read workplace-user-connection if requested
    LOOP AT lt_nwpusz_all INTO l_nwpusz
                          WHERE wplacetype = l_nwplace-wplacetype
                            AND wplaceid   = l_nwplace-wplaceid.
      APPEND l_nwpusz TO lt_nwpusz.
      CLEAR l_nwpuszt.
      READ TABLE lt_nwpuszt_all INTO l_nwpuszt
                 WITH TABLE KEY wplacetype = l_nwplace-wplacetype
                                wplaceid   = l_nwplace-wplaceid
                                agr_name   = l_nwpusz-agr_name
                                benutzer   = l_nwpusz-benutzer
                                spras      = sy-langu.
      IF sy-subrc <> 0.
        l_nwpuszt-mandt      = sy-mandt.
        l_nwpuszt-wplacetype = l_nwplace-wplacetype.
        l_nwpuszt-wplaceid   = l_nwplace-wplaceid.
        l_nwpuszt-agr_name   = l_nwpusz-agr_name.
        l_nwpuszt-benutzer   = l_nwpusz-benutzer.
        l_nwpuszt-spras      = sy-langu.
      ENDIF.
      APPEND l_nwpuszt TO lt_nwpuszt.
    ENDLOOP.

*   copy views if requested
    IF i_views_copy = 'C'.
      LOOP AT lt_nwpvz INTO l_nwpvz.
        CLEAR l_nwview.
        l_nwview-viewtype = l_nwpvz-viewtype.
        l_nwview-viewid   = l_nwpvz-viewid.
        APPEND l_nwview TO lt_nwview.
      ENDLOOP.
      CALL FUNCTION 'ISHMED_VM_VIEW_COPY'
           EXPORTING
                it_nwviews      = lt_nwview
                i_variants_copy = i_variants_copy
*               i_view_text     = SPACE
                i_view_text     = i_place_text               " ID 10499
                i_placetype     = l_nwplace-wplacetype
                i_placeid       = l_nwplace-wplaceid
                i_commit        = off
                i_update_task   = i_update_task
                i_caller        = 'LN1WPCOPYU01'
           IMPORTING
                e_rc            = l_rc
                et_nwviews      = lt_nwview_new
           TABLES
                t_messages      = lt_messages.
      IF l_rc <> 0.
*       error on view copy
        APPEND LINES OF lt_messages TO t_messages.
        e_rc = 1.
        EXIT.
      ENDIF.

*     change connections to new view ids
      l_idx = 0.
      LOOP AT lt_nwpvz INTO l_nwpvz.
        l_idx = l_idx + 1.
        READ TABLE lt_nwpvzt INTO l_nwpvzt
                   WITH KEY wplacetype = l_nwpvz-wplacetype
                            wplaceid   = l_nwpvz-wplaceid
                            viewtype   = l_nwpvz-viewtype
                            viewid     = l_nwpvz-viewid.
        l_idx_t = sy-tabix.
        CHECK sy-subrc = 0.
        READ TABLE lt_nwview_new INTO l_nwview INDEX l_idx.
        CHECK sy-subrc = 0.
        l_nwpvz-viewid = l_nwview-viewid.
        MODIFY lt_nwpvz FROM l_nwpvz.
        l_nwpvzt-viewid = l_nwview-viewid.
        MODIFY lt_nwpvzt FROM l_nwpvzt INDEX l_idx_t.
      ENDLOOP.

    ELSEIF i_views_copy = 'Z'.
*     add values of NWPVZ(T) as they are
    ENDIF.

    l_nwplace_old = l_nwplace.

*   generate new key for workplaceid now
    CALL FUNCTION 'ISHMED_VM_GENERATE_KEY'
      EXPORTING
        i_key_type            = 'W'    " Workplace
*       I_USER_SPECIFIC       = ' '
*       I_SAP_STANDARD        = ' '
        i_placetype           = l_nwplace-wplacetype
*       I_VIEWTYPE            =
      IMPORTING
        e_key                 = l_key
        e_rc                  = l_rc
      TABLES
        t_messages            = lt_messages.
    IF l_rc <> 0 OR l_key IS INITIAL.
*     error on generating key
      APPEND LINES OF lt_messages TO t_messages.
      e_rc = 1.
      EXIT.
    ENDIF.

*   new key has been generated -> fill in for new workplace tables
    l_nwplace-wplaceid  = l_key.
    l_nwplacet-wplaceid = l_key.
    LOOP AT lt_nwpvz INTO l_nwpvz.
      l_nwpvz-wplaceid = l_key.
      MODIFY lt_nwpvz FROM l_nwpvz.
    ENDLOOP.
    LOOP AT lt_nwpvzt INTO l_nwpvzt.
      l_nwpvzt-wplaceid = l_key.
      MODIFY lt_nwpvzt FROM l_nwpvzt.
    ENDLOOP.
    LOOP AT lt_nwpusz INTO l_nwpusz.
      l_nwpusz-wplaceid = l_key.
      MODIFY lt_nwpusz FROM l_nwpusz.
    ENDLOOP.
    LOOP AT lt_nwpuszt INTO l_nwpuszt.
      l_nwpuszt-wplaceid = l_key.
      MODIFY lt_nwpuszt FROM l_nwpuszt.
    ENDLOOP.

*   creator of workplace
    l_nwplace-owner = sy-uname.

*   read workplace special data (tables NWPLACE_xxx) for copy for ...
    CASE l_nwplace-wplacetype.
      WHEN '001'.
*       ... clinical workplace
        SELECT SINGLE * FROM nwplace_001 INTO l_nwplace_001
               WHERE  wplacetype  = l_nwplace_old-wplacetype
               AND    wplaceid    = l_nwplace_old-wplaceid.
        IF sy-subrc <> 0.
          l_nwplace_001-mandt      = sy-mandt.
          l_nwplace_001-wplacetype = l_nwplace-wplacetype.
        ENDIF.
        l_nwplace_001-wplaceid = l_nwplace-wplaceid.         " new ID !
      WHEN OTHERS.
*       ... other workplace types
        PERFORM copy_special_wplace_data TABLES   lt_messages
                                         USING    l_nwplace_old
                                                  l_nwplace-wplaceid
                                                  i_update_task
                                         CHANGING l_rc.
        IF l_rc <> 0.
*         error on special workplace data copy
          APPEND LINES OF lt_messages TO t_messages.
          e_rc = 1.
          EXIT.
        ENDIF.
    ENDCASE.

*   success message - workplace & has been copied
    PERFORM build_bapiret2(sapmn1pa)
         USING 'S' 'NF1' '677' l_nwplacet-txt space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.

*   new workplace text?
    IF NOT i_place_text IS INITIAL.
      l_nwplacet-txt = i_place_text.
    ENDIF.

*   save workplace tables
    PERFORM save_wplace TABLES lt_nwpvz
                               lt_nwpvzt
                               lt_nwpusz
                               lt_nwpuszt
                        USING  l_nwplace
                               l_nwplacet
                               l_nwplace_001
                               i_update_task.

*   if requested, the new workplace should be connected to the user
    IF i_user_zuo = on.
      CLEAR: l_prio, l_agr_name.
      PERFORM place_user_zuo(sapln1wpl)
              USING sy-uname l_agr_name l_nwplace l_nwplacet-txt l_prio
                    off i_update_task off.
    ENDIF.

*   return copied workplace
    APPEND l_nwplace TO et_nwplaces.

  ENDLOOP.

  IF i_commit = on.
    IF e_rc = 0.
      COMMIT WORK AND WAIT.
    ELSE.
      ROLLBACK WORK.                 "#EC CI_ROLLBACK
    ENDIF.
  ENDIF.


ENDFUNCTION.
