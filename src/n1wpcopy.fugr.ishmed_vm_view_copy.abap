FUNCTION ishmed_vm_view_copy.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IT_NWVIEWS) TYPE  ISHMED_T_NWVIEW
*"     VALUE(I_VARIANTS_COPY) TYPE  CHAR1 DEFAULT 'C'
*"     VALUE(I_VIEW_TEXT) TYPE  NVIEWSTXT DEFAULT SPACE
*"     VALUE(I_PLACETYPE) TYPE  NWPLACETYPE DEFAULT '001'
*"     VALUE(I_PLACEID) TYPE  NWPLACEID OPTIONAL
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_CALLER) TYPE  SY-REPID
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(ET_NWVIEWS) TYPE  ISHMED_T_NWVIEW
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------
  TYPES: BEGIN OF ty_viewtxt,                               " ID 10499
           viewtype    TYPE nwview-viewtype,
           viewid      TYPE nwview-viewid,
           text        TYPE nwviewt-txt,
         END OF ty_viewtxt.

  DATA: lt_nwview          TYPE TABLE OF nwview,
        lt_nwview_dup      TYPE TABLE OF nwview,            " ID 10499
        l_nwview_dup       TYPE nwview,                     " ID 10499
        lt_nwview_txt      TYPE TABLE OF ty_viewtxt,        " ID 10499
        l_nwview_txt       TYPE ty_viewtxt,                 " ID 10499
        l_cnt              TYPE i,                          " ID 10499
        l_cnt_c(5)         TYPE c,                          " ID 10499
        l_text_nbr         TYPE nwviewt-txt,                " ID 10499
        l_last_viewtype    TYPE nwview-viewtype,            " ID 10499
        l_nwview           TYPE nwview,
        l_nwviewt          TYPE nwviewt,
        l_nwview_old       TYPE nwview,
        l_view             TYPE v_nwview,
        l_viewvar          TYPE rnviewvar,
        l_refresh          TYPE rnrefresh,
        l_rc               TYPE sy-subrc,
        l_key              TYPE rnwp_gen_key-nwkey,
        lt_range_viewvar   TYPE TABLE OF rnrangeviewtype,
        ls_range_viewvar   LIKE LINE OF lt_range_viewvar,
        lt_messages        TYPE TABLE OF bapiret2,
        l_wa_msg           TYPE bapiret2.

* initialization
  CLEAR:   t_messages, e_rc.
  REFRESH: t_messages, et_nwviews,
           lt_nwview, lt_nwview_dup, lt_nwview_txt.

* is there any data to copy?
  DESCRIBE TABLE it_nwviews.
  IF sy-tfill = 0.
    e_rc = 1.
    EXIT.
  ENDIF.

  lt_nwview[] = it_nwviews[].

* ID 10499: if more than 1 view of the same viewtype has to be copied,
* add a serial number to the new view- and variant-description
  IF NOT i_view_text IS INITIAL.
    lt_nwview_dup[] = lt_nwview[].
    SORT lt_nwview_dup BY viewtype viewid.
    READ TABLE lt_nwview_dup INTO l_nwview_dup INDEX 1.
    l_last_viewtype = l_nwview_dup-viewtype.
    CLEAR l_cnt.
    LOOP AT lt_nwview_dup INTO l_nwview_dup.
      IF l_nwview_dup-viewtype <> l_last_viewtype.
        IF l_cnt <= 1.
          DELETE lt_nwview_dup WHERE viewtype = l_last_viewtype.
        ENDIF.
        CLEAR l_cnt.
      ENDIF.
      l_last_viewtype = l_nwview_dup-viewtype.
      l_cnt = l_cnt + 1.
    ENDLOOP.
    DELETE ADJACENT DUPLICATES FROM lt_nwview_dup COMPARING viewtype.
    DESCRIBE TABLE lt_nwview_dup.
    IF sy-tfill > 1.
*     there is more than 1 view of the same viewtype
      LOOP AT lt_nwview_dup INTO l_nwview_dup.
        CLEAR: l_text_nbr, l_cnt, l_cnt_c.
        LOOP AT lt_nwview INTO l_nwview
                WHERE viewtype = l_nwview_dup-viewtype.
          l_cnt = l_cnt + 1.
          l_cnt_c = l_cnt.
          PERFORM del_lead_zero(sapmn1pa) USING l_cnt_c.
          CONDENSE l_cnt_c.
          CLEAR l_text_nbr.
          CONCATENATE i_view_text l_cnt_c INTO l_text_nbr
                      SEPARATED BY space.
          l_nwview_txt-viewtype = l_nwview-viewtype.
          l_nwview_txt-viewid   = l_nwview-viewid.
          l_nwview_txt-text     = l_text_nbr.
          APPEND l_nwview_txt TO lt_nwview_txt.
        ENDLOOP.
      ENDLOOP.
      SORT lt_nwview_txt BY viewtype viewid.
    ENDIF.
  ENDIF.

* copy views
  LOOP AT lt_nwview INTO l_nwview.
*   initialization
    CLEAR: l_nwviewt, l_view, l_viewvar, l_nwview_old, l_refresh.

*   ID 10499: add serial number to view text if requested
    CLEAR l_text_nbr.
    IF NOT i_view_text IS INITIAL.
      READ TABLE lt_nwview_txt INTO l_nwview_txt
                 WITH KEY viewtype = l_nwview-viewtype
                          viewid   = l_nwview-viewid   BINARY SEARCH.
      IF sy-subrc = 0.
        l_text_nbr = l_nwview_txt-text.
      ELSE.
        l_text_nbr = i_view_text.
      ENDIF.
    ENDIF.

*   read all view data
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid    = l_nwview-viewid
        i_viewtype  = l_nwview-viewtype
        i_mode      = 'L'
        i_caller    = 'LN1WPCOPYU02'
        i_placeid   = i_placeid
        i_placetype = i_placetype
      IMPORTING
        e_rc        = l_rc
        e_view      = l_view
        e_viewvar   = l_viewvar
        e_refresh   = l_refresh
      TABLES
        t_messages  = lt_messages.

    IF l_rc <> 0.
*     error on view data read
      APPEND LINES OF lt_messages TO t_messages.
      e_rc = 1.
      EXIT.
    ENDIF.

*   select text of view (because READ_VIEW_DATA gets
*   the text of the workplace-view-connection
    SELECT SINGLE txt FROM nwviewt INTO l_view-txt
                  WHERE viewtype = l_view-viewtype
                  AND   viewid   = l_view-viewid
                  AND   spras    = sy-langu.

*   get view data
    IF NOT l_view IS INITIAL.
      MOVE-CORRESPONDING l_view TO l_nwview.                "#EC ENHOK
      MOVE-CORRESPONDING l_view TO l_nwviewt.               "#EC ENHOK
      IF l_nwviewt-spras IS INITIAL.
        l_nwviewt-spras = sy-langu.
      ENDIF.
    ELSE.
      l_nwviewt-mandt    = sy-mandt.
      l_nwviewt-viewtype = l_nwview-viewtype.
      l_nwviewt-viewid   = l_nwview-viewid.
      l_nwviewt-spras    = sy-langu.
    ENDIF.

    l_nwview_old = l_nwview.

*   generate new key for viewid now
    CALL FUNCTION 'ISHMED_VM_GENERATE_KEY'
      EXPORTING
        i_key_type            = 'V'    " View
*       I_USER_SPECIFIC       = ' '
*       I_SAP_STANDARD        = ' '
*       i_placetype           =
        i_viewtype            = l_nwview-viewtype
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

*   new key has been generated -> fill in for new view tables
    l_nwview-viewid  = l_key.
    l_nwviewt-viewid = l_key.

*   get customer specific and add-on viewtypes (ID 18129)
    PERFORM get_range_viewvar IN PROGRAM sapln1workplace
                                CHANGING lt_range_viewvar.
    CLEAR ls_range_viewvar.                           " ID 18129 (3)
    ls_range_viewvar-sign   = 'I'.                    " ID 18129 (3)
    ls_range_viewvar-option = 'BT'.                   " ID 18129 (3)
    ls_range_viewvar-low    = '001'.                  " ID 18129 (3)
    ls_range_viewvar-high   = '099'.                  " ID 18129 (3)
    APPEND ls_range_viewvar TO lt_range_viewvar.      " ID 18129 (3)
    CLEAR ls_range_viewvar.                           " ID 18129 (3)
    ls_range_viewvar-sign   = 'I'.                    " ID 18129 (3)
    ls_range_viewvar-option = 'BT'.                   " ID 18129 (3)
    ls_range_viewvar-low    = 'C01'.                  " ID 18129 (3)
    ls_range_viewvar-high   = 'C99'.                  " ID 18129 (3)
    APPEND ls_range_viewvar TO lt_range_viewvar.      " ID 18129 (3)
    CLEAR ls_range_viewvar.                           " ID 18129 (3)
    ls_range_viewvar-sign   = 'I'.                    " ID 18129 (3)
    ls_range_viewvar-option = 'EQ'.                   " ID 18129 (3)
    ls_range_viewvar-low    = 'P01'.                  " ID 18129 (3)
    APPEND ls_range_viewvar TO lt_range_viewvar.      " ID 18129 (3)

*   view special data (tables NWVIEW_xxx) for ...
*    IF l_nwview-viewtype BETWEEN '001' AND '099' OR  " ID 18129 (3) REM
*       l_nwview-viewtype BETWEEN 'C01' AND 'C99' OR  " ID 18129 (3) REM
*       l_nwview-viewtype EQ 'P01'                OR  " ID 18129 (3) REM
*       l_nwview-viewtype IN lt_range_viewvar.        " ID 18129 (3) REM
    IF l_nwview-viewtype IN lt_range_viewvar.         " ID 18129 (3)
*     ... views of clinical workplace
*     ... views of components
*     ... views of patient organizer
*     ... views of customers or from add-on
      IF i_variants_copy = 'N'.
*       don't add variants
        CLEAR l_viewvar.
      ENDIF.
*     get view special data for copy (necessary in any case!)
      IF l_viewvar IS INITIAL.
        l_viewvar-viewtype = l_nwview-viewtype.
      ENDIF.
*     copy variants?
      IF i_variants_copy = 'C'.
        PERFORM variant_copy USING    i_update_task
                                      l_text_nbr            " ID 10499
                                      i_placetype           " ID 12249
                                      i_placeid             " ID 12249
                             CHANGING l_viewvar.
      ELSEIF i_variants_copy = 'Z'.
*       add variant data of special view data table as they are
      ENDIF.
      l_viewvar-viewid = l_nwview-viewid.          " new ID !
*      IF l_nwview-viewtype EQ 'P01'.
*        PERFORM copy_special_view_data TABLES   lt_messages
*                                       USING    l_nwview_old
*                                                l_nwview-viewid
*                                                i_placetype
*                                                i_placeid
*                                                i_variants_copy
*                                                i_update_task
*                                       CHANGING l_rc.
*        IF l_rc <> 0.
**         error on special view data copy
*          APPEND LINES OF lt_messages TO t_messages.
*          e_rc = 1.
*          EXIT.
*        ENDIF.
*      ENDIF.
    ELSE.
*     ... views of other workplacetypes
      CLEAR l_viewvar.
      PERFORM copy_special_view_data TABLES   lt_messages
                                     USING    l_nwview_old
                                              l_nwview-viewid
                                              i_placetype
                                              i_placeid
                                              i_variants_copy
                                              i_update_task
                                     CHANGING l_rc.
      IF l_rc <> 0.
*       error on special view data copy
        APPEND LINES OF lt_messages TO t_messages.
        e_rc = 1.
        EXIT.
      ENDIF.
    ENDIF.

*   success message - view & has been copied
    PERFORM build_bapiret2(sapmn1pa)
         USING 'S' 'NF1' '678' l_nwviewt-txt space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.

*   new view text?
    IF NOT i_view_text IS INITIAL.
*      l_nwviewt-txt = i_view_text.                     " REM ID 10499
      l_nwviewt-txt = l_text_nbr.                           " ID 10499
    ENDIF.

*   save view tables
    PERFORM save_view USING l_nwview
                            l_nwviewt
                            l_viewvar
                            l_refresh
                            l_nwview_old
                            i_update_task.

*   return copied view data
    APPEND l_nwview TO et_nwviews.

  ENDLOOP.

  IF i_commit = on.
    IF e_rc = 0.
      COMMIT WORK AND WAIT.
    ELSE.
      ROLLBACK WORK.                                   "#EC CI_ROLLBACK
    ENDIF.
  ENDIF.

ENDFUNCTION.
