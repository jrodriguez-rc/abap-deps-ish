*----------------------------------------------------------------------*
***INCLUDE LN1MONCONF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  status_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM status_0100 .

  DATA: lt_excl        TYPE TABLE OF sy-ucomm.

  REFRESH lt_excl.

* exclude some functions eventually
  IF g_vcode = 'DIS'.
    APPEND 'CHECK' TO lt_excl.
  ENDIF.
  IF g_vcode = 'DIS' OR g_save = off.
    APPEND 'SAVE'  TO lt_excl.
  ENDIF.
  IF g_vcode <> 'DIS'.
    APPEND 'ENTER' TO lt_excl.
  ENDIF.

* set status
  SET PF-STATUS 'MONCON' EXCLUDING lt_excl.

* set titlebar
  SET TITLEBAR 'MONCON' WITH g_title.

ENDFORM.                    " status_0100
*&---------------------------------------------------------------------*
*&      Form  build_grid
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM build_grid .

  IF gr_container IS INITIAL.
    CREATE OBJECT gr_container
      EXPORTING
        container_name              = 'G_CONTAINER'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      SET SCREEN 0. LEAVE SCREEN.
    ENDIF.
    TRY.
        CALL METHOD cl_ish_complstage_grid=>create
          EXPORTING
            ir_moncon          = gr_moncon
          RECEIVING
            rr_complstage_grid = gr_complstage_grid.
      CATCH cx_ish_static_handler .
        SET SCREEN 0. LEAVE SCREEN.
    ENDTRY.
    TRY.
        CALL METHOD gr_complstage_grid->first_display
          EXPORTING
            i_vcode      = g_vcode
            ir_container = gr_container.
      CATCH cx_ish_static_handler .
        SET SCREEN 0. LEAVE SCREEN.
    ENDTRY.
*  ELSE.
*    TRY.
*        CALL METHOD gr_complstage_grid->refresh
*          EXPORTING
*            i_vcode = g_vcode.
*      CATCH cx_ish_static_handler .
*        SET SCREEN 0. LEAVE SCREEN.
*    ENDTRY.
  ENDIF.

ENDFORM.                    " build_grid
*&---------------------------------------------------------------------*
*&      Form  user_command_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM user_command_0100 .

  DATA: l_okcode              TYPE sy-ucomm,
        l_answer(1)           TYPE c,
        l_rc                  TYPE ish_method_rc,
        lr_errorhandler       TYPE REF TO cl_ishmed_errorhandling.

  l_okcode = ok-code.
  CLEAR: ok-code.

  CASE l_okcode.
    WHEN 'ECAN'.
      IF gr_complstage_grid->check_for_change( ) = abap_on.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            titlebar              = g_title
            diagnose_object       = 'ISH_INP_CANCEL'
            text_question         = text-001
            default_button        = '2'
            display_cancel_button = ' '
            popup_type            = 'ICON_MESSAGE_WARNING'
          IMPORTING
            answer                = l_answer
          EXCEPTIONS
            text_not_found        = 1
            OTHERS                = 2.
        IF sy-subrc = 0 AND l_answer = '1'.
          g_cancelled = on.
          SET SCREEN 0. LEAVE SCREEN.
        ENDIF.
      ELSE.
        g_cancelled = on.
        SET SCREEN 0. LEAVE SCREEN.
      ENDIF.
    WHEN 'ENTER'.
      IF g_vcode = 'DIS'.
        SET SCREEN 0. LEAVE SCREEN.
      ENDIF.
    WHEN 'CHECK'.
      CALL METHOD gr_complstage_grid->check
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        CALL METHOD lr_errorhandler->display_messages.
      ENDIF.
    WHEN 'SAVE'.
      CALL METHOD gr_complstage_grid->save
        EXPORTING
          i_update_task   = g_update_task
          i_commit        = g_commit
        IMPORTING
          e_saved         = g_saved
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = lr_errorhandler.
      IF l_rc <> 0.
        CALL METHOD lr_errorhandler->display_messages.
      ELSE.
        SET SCREEN 0. LEAVE SCREEN.
      ENDIF.
    WHEN OTHERS.
      EXIT.
  ENDCASE.

ENDFORM.                    " user_command_0100
*&---------------------------------------------------------------------*
*&      Form  set_moncon_name
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_moncon_name .

  CALL METHOD gr_moncon->set_name
    EXPORTING
      i_name = g_name.

ENDFORM.                    " set_moncon_name
*&---------------------------------------------------------------------*
*&      Form  get_moncon_name
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_moncon_name .

  CALL METHOD gr_moncon->get_name
    RECEIVING
      r_name = g_name.

ENDFORM.                    " get_moncon_name
*&---------------------------------------------------------------------*
*&      Form  modify_screen
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM modify_screen .

  LOOP AT SCREEN.
    IF screen-name = 'G_NAME' AND g_vcode = 'DIS'.
      screen-input = off.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " modify_screen
