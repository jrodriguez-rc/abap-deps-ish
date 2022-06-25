*----------------------------------------------------------------------*
***INCLUDE LN2_BASEITEM__COMPONENTF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  set_first_actions
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_first_actions .

* Internal Table for Listbox
  DATA  lt_listbox TYPE TABLE OF vrm_value.
  DATA  ls_listbox TYPE          vrm_value.

  FIELD-SYMBOLS:
        <action>   TYPE LINE OF  ishmed_t_action_id.

  CLEAR   lt_listbox.
  REFRESH lt_listbox.

  LOOP AT gt_first_actions ASSIGNING <action>.

    MOVE: <action>-action_desc TO ls_listbox-text,
          <action>-action_id   TO ls_listbox-key.

    APPEND ls_listbox TO lt_listbox.

  ENDLOOP.
*
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'RN2_BASEITEM__COMPONENT_D-ACTION_ID_FIRST'
      values = lt_listbox[].

ENDFORM.                    " set_first_actions
*&---------------------------------------------------------------------*
*&      Form  set_again_actions
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_again_actions .

* Internal Table for Listbox
  DATA  lt_listbox TYPE TABLE OF vrm_value.
  DATA  ls_listbox TYPE          vrm_value.

  FIELD-SYMBOLS:
        <action>   TYPE LINE OF  ishmed_t_action_id.

  CLEAR   lt_listbox.
  REFRESH lt_listbox.

  LOOP AT gt_again_actions ASSIGNING <action>.

    MOVE: <action>-action_desc TO ls_listbox-text,
          <action>-action_id   TO ls_listbox-key.

    APPEND ls_listbox TO lt_listbox.

  ENDLOOP.
*
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = 'RN2_BASEITEM__COMPONENT_D-ACTION_ID_AGAIN'
      values = lt_listbox[].

ENDFORM.                    " set_again_actions
*&---------------------------------------------------------------------*
*&      Form  get_actions
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_actions .
*  IF gt_again_actions[] IS INITIAL AND
*     gt_first_actions[] IS INITIAL.

    REFRESH: gt_again_actions, gt_first_actions.

    TRY.
        gr_manager->get_actions(
          IMPORTING
            et_action_first = gt_first_actions[]
            et_action_again = gt_again_actions[]  ).

      CATCH cx_ishmed_baseitems INTO gx_baseitems.

        cl_ish_utl_base=>collect_messages_by_exception(
          EXPORTING
            i_exceptions    = gx_baseitems
          CHANGING
            cr_errorhandler = gr_error ).

        IF gr_error IS BOUND.
          gr_error->display_messages( ).
          TRY.
              gr_manager->finalize( ).
            CATCH cx_root.
          ENDTRY.
          FREE gr_manager.
          LEAVE PROGRAM.
        ENDIF.

    ENDTRY.

*  ENDIF.

ENDFORM.                    " get_actions
