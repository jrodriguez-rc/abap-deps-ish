*----------------------------------------------------------------------*
***INCLUDE LN1WPCOPYF02 .
*----------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  copy_special_wplace_data
*&---------------------------------------------------------------------*
*       copy special workplace data for other worplacetypes than the
*       clinical workplace
*----------------------------------------------------------------------*
*      <--PT_MESSAGES      messages
*      -->P_NWPLACE        workplace to be copied
*      -->P_NEW_PLACEID    new workplace id
*      -->P_UPDATE_TASK    in update task (ON/OFF)
*      <--P_RC             returncode
*----------------------------------------------------------------------*
FORM copy_special_wplace_data
         TABLES   pt_messages          STRUCTURE bapiret2  "#EC NEEDED
         USING    value(p_nwplace)     TYPE nwplace
                  value(p_new_placeid) TYPE nwplaceid
                  value(p_update_task) TYPE ish_on_off
         CHANGING p_rc                 TYPE sy-subrc.

* in that form the special workplace data (except those for
* the clinical workplace) should be selected (for 'old' workplace =
* P_NWPLACE) and copied (to the 'new' workplace = P_NEW_PLACEID)
* --> tables NWPLACE_xxx

* Verbucher hier aufrufen, COMMIT WORK erfolgt durch Aufrufer des Forms

*  DATA: l_wa_msg          TYPE bapiret2.
  DATA: lt_n_nwplace_p01  LIKE TABLE OF vnwplace_p01,
        lt_o_nwplace_p01  LIKE TABLE OF vnwplace_p01,
        l_wa_nwplace_p01  LIKE vnwplace_p01,
        l_nwplace_p01     TYPE nwplace_p01.

  REFRESH: lt_n_nwplace_p01, lt_o_nwplace_p01.

  CLEAR p_rc.

  CASE p_nwplace-wplacetype.
    WHEN 'P01'.
*     ... patient organizer
      CLEAR l_nwplace_p01.
      SELECT SINGLE * FROM nwplace_p01 INTO l_nwplace_p01
             WHERE  wplacetype  = p_nwplace-wplacetype
             AND    wplaceid    = p_nwplace-wplaceid.
      IF sy-subrc <> 0.
        l_nwplace_p01-mandt      = sy-mandt.
        l_nwplace_p01-wplacetype = p_nwplace-wplacetype.
      ENDIF.
      l_nwplace_p01-wplaceid = p_new_placeid.         " new ID !
      CLEAR l_wa_nwplace_p01.
      l_wa_nwplace_p01    = l_nwplace_p01.
      l_wa_nwplace_p01-kz = 'I'.                      " Insert
      APPEND l_wa_nwplace_p01 TO lt_n_nwplace_p01.
*     Verbuchen
      IF p_update_task = on.
        CALL FUNCTION 'ISH_VERBUCHER_NWPLACE_P01' IN UPDATE TASK
          EXPORTING
            i_tcode         = sy-tcode
          TABLES
            t_n_nwplace_p01 = lt_n_nwplace_p01
            t_o_nwplace_p01 = lt_o_nwplace_p01.
      ELSE.
        CALL FUNCTION 'ISH_VERBUCHER_NWPLACE_P01'
          EXPORTING
            i_tcode         = sy-tcode
          TABLES
            t_n_nwplace_p01 = lt_n_nwplace_p01
            t_o_nwplace_p01 = lt_o_nwplace_p01.
      ENDIF.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

ENDFORM.                    " copy_special_wplace_data

*&---------------------------------------------------------------------*
*&      Form  copy_special_view_data
*&---------------------------------------------------------------------*
*       copy special view data for other viewtypes than those for the
*       workplacetypes of the clinical workplace
*----------------------------------------------------------------------*
*      <--PT_MESSAGES      messages
*      -->P_NWVIEW         view to be copied
*      -->P_NEW_VIEWID     new viewid
*      -->P_PLACETYPE      workplacetype
*      -->P_PLACEID        workplace id
*      -->P_VARIANTS_COPY  copy special data?
*                          (C=copy, Z=leave previous data, N=don't copy)
*      -->P_UPDATE_TASK    in update task (ON/OFF)
*      <--P_RC             returncode
*----------------------------------------------------------------------*
FORM copy_special_view_data
     TABLES   pt_messages            STRUCTURE bapiret2  "#EC NEEDED
     USING    value(p_nwview)        TYPE nwview         "#EC NEEDED
              value(p_new_viewid)    TYPE nviewid        "#EC NEEDED
              value(p_placetype)     TYPE nwplacetype    "#EC NEEDED
              value(p_placeid)       TYPE nwplaceid      "#EC NEEDED
              value(p_variants_copy) TYPE ish_on_off     "#EC NEEDED
              value(p_update_task)   TYPE ish_on_off     "#EC NEEDED
     CHANGING p_rc                   TYPE sy-subrc.

* in that form the special view data (except those for the clinical
* workplace) should be selected (for 'old' view = P_NWVIEW) and copied
* (to the 'new' view = P_NEW_VIEWID) --> tables NWVIEW_xxx

* Verbucher hier aufrufen, COMMIT WORK erfolgt durch Aufrufer des
* Forms

*  DATA: l_wa_msg           TYPE bapiret2.

  CLEAR p_rc.

  CASE p_nwview-viewtype.
    WHEN 'P01'.
*     patient organizer
*     table NWVIEW_P01 is not handled here! but what about N1WVIEWZ?
    WHEN OTHERS.
      EXIT.
  ENDCASE.

ENDFORM.                    " copy_special_view_data
