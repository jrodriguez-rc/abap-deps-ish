FUNCTION ishmed_vm_fvar_append_func.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_PLACEID) LIKE  NWPLACE-WPLACEID
*"     VALUE(I_VIEWID) LIKE  NWVIEW-VIEWID
*"     VALUE(I_VIEWTYPE) LIKE  NWVIEW-VIEWTYPE
*"     VALUE(I_VIEWID_2) LIKE  NWVIEW-VIEWID OPTIONAL
*"     VALUE(I_VIEWTYPE_2) LIKE  NWVIEW-VIEWTYPE OPTIONAL
*"     REFERENCE(I_OBJECT) TYPE REF TO  CL_CTMENU
*"     VALUE(I_CALLER) LIKE  SY-REPID
*"----------------------------------------------------------------------

  DATA: lt_wp_views        LIKE TABLE OF v_nwpvz,
        s_wp_views         LIKE v_nwpvz,
        l_viewid_tmp       TYPE ui_func,
        l_text             TYPE gui_text,
        l_text_2           TYPE gui_text.

* get all views of the actual workplace
  PERFORM get_views_of_wplace TABLES lt_wp_views
                              USING  i_placeid.

* append new menu functions
  CLEAR l_text_2.
  LOOP AT lt_wp_views INTO s_wp_views.
*   only active for viewtypes 001-003
*   and 005 (only for itself)
    IF i_caller = 'LN1_WP_PTSTOP'.
      CHECK s_wp_views-viewtype = '005'.
    ELSE.
      CHECK s_wp_views-viewtype = '001' OR
            s_wp_views-viewtype = '002' OR
            s_wp_views-viewtype = '003'.
    ENDIF.
    CLEAR: l_text, l_viewid_tmp.
    IF s_wp_views-viewtype = i_viewtype AND
       s_wp_views-viewid   = i_viewid.
      DELETE TABLE lt_wp_views FROM s_wp_views.
    ELSEIF s_wp_views-viewtype = i_viewtype_2 AND
           s_wp_views-viewid   = i_viewid_2.
      s_wp_views-txt = s_wp_views-txt(29).
      CONCATENATE s_wp_views-txt 'ausblenden'(011)
                  INTO l_text_2 SEPARATED BY space.
    ELSE.
      l_viewid_tmp(3) = s_wp_views-viewtype.
      l_viewid_tmp+3  = s_wp_views-viewid.
      s_wp_views-txt  = s_wp_views-txt(29).
      CONCATENATE s_wp_views-txt 'einblenden'(013)
                  INTO l_text SEPARATED BY space.
      CALL METHOD i_object->add_function
           EXPORTING fcode  = l_viewid_tmp
                     text   = l_text.
    ENDIF.
  ENDLOOP.

  IF NOT l_text_2 IS INITIAL.
    CALL METHOD i_object->add_separator.
    CALL METHOD i_object->add_function
         EXPORTING fcode  = 'DVIEW_OFF'
                   text   = l_text_2.
  ENDIF.

ENDFUNCTION.
