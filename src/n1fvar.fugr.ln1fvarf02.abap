*----------------------------------------------------------------------*
***INCLUDE LN1FVARF02 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  get_views_of_wplace
*&---------------------------------------------------------------------*
*       get all views of a certain workplace
*----------------------------------------------------------------------*
*      <-- PT_WP_VIEWS  all views
*      --> P_PLACEID    workplace
*----------------------------------------------------------------------*
FORM get_views_of_wplace TABLES pt_wp_views      STRUCTURE v_nwpvz
                         USING  value(p_placeid) LIKE nwplace-wplaceid.

  DATA: ls_view TYPE v_nwpvz.

* get the users's personal settings for the workplace
  CALL FUNCTION 'ISHMED_VM_PERSONAL_DATA_READ'
    EXPORTING
      i_uname              = sy-uname
      i_caller             = 'LN1FVARF02'
      i_replace_substitute = on
    TABLES
      t_nwpvz              = pt_wp_views.

* identify the requested views
  LOOP AT pt_wp_views INTO ls_view.
    IF ls_view-wplaceid <> p_placeid.
      DELETE TABLE pt_wp_views FROM ls_view.
    ENDIF.
  ENDLOOP.

  SORT pt_wp_views BY sortid.

ENDFORM.                    " get_views_of_wplace
