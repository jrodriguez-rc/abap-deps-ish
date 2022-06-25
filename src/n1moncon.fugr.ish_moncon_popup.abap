FUNCTION ish_moncon_popup.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IR_MONCON) TYPE REF TO  CL_ISH_MONCON
*"     VALUE(I_DISPLAY_ONLY) TYPE  ISH_ON_OFF DEFAULT OFF
*"     VALUE(I_SAVE) TYPE  ISH_ON_OFF DEFAULT ON
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT ON
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT ON
*"     VALUE(I_TITLE) TYPE  STRING OPTIONAL
*"     VALUE(I_STARTING_ROW) TYPE  I DEFAULT 5
*"     VALUE(I_STARTING_COL) TYPE  I DEFAULT 5
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(E_CANCELLED) TYPE  ISH_ON_OFF
*"     VALUE(E_SAVED) TYPE  ISH_ON_OFF
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

  DATA: lr_cx_static_handler   TYPE REF TO cx_ish_static_handler,
        lr_errorhandler        TYPE REF TO cl_ishmed_errorhandling,
        l_is_valid             TYPE i.

  CLEAR: e_rc, e_cancelled, e_saved, g_cancelled, g_saved.

  gr_moncon     = ir_moncon.

  g_save        = i_save.
  g_update_task = i_update_task.
  g_commit      = i_commit.
  g_title       = i_title.

  IF i_display_only = on.
    g_vcode = 'DIS'.
  ELSE.
    IF gr_moncon->is_new( ) = on.
      g_vcode = 'INS'.
    ELSE.
      g_vcode = 'UPD'.
    ENDIF.
  ENDIF.

  IF g_vcode <> 'DIS'.
    TRY.
        CALL METHOD gr_moncon->lock.
      CATCH cx_ish_static_handler INTO lr_cx_static_handler.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          EXPORTING
            i_exceptions    = lr_cx_static_handler
          CHANGING
            cr_errorhandler = lr_errorhandler.
        CALL METHOD lr_errorhandler->display_messages
          EXPORTING
            i_control     = on           " display as success-msg
            i_send_if_one = on.          " do not display in popup
        g_vcode = 'DIS'.
    ENDTRY.
  ENDIF.

  IF g_title IS INITIAL.
    g_title = 'Monitoring Konfiguration'(002).
    CASE g_vcode.
      WHEN 'DIS'.
        CONCATENATE g_title text-003 INTO g_title SEPARATED BY space.
      WHEN 'INS'.
        CONCATENATE g_title text-004 INTO g_title SEPARATED BY space.
      WHEN 'UPD'.
        CONCATENATE g_title text-005 INTO g_title SEPARATED BY space.
    ENDCASE.
  ENDIF.

  CALL SCREEN 100 STARTING AT i_starting_col i_starting_row.

  IF g_vcode <> 'DIS'.
    CALL METHOD gr_moncon->unlock.
  ENDIF.

* Michael Manoch, 02.06.2009   START
* If processing is cancelled we have to refresh the moncon.
  IF g_cancelled = abap_true.
    TRY.
        gr_moncon->refresh( ).
      CATCH cx_ish_static_handler.                      "#EC NO_HANDLER
    ENDTRY.
  ENDIF.
* Michael Manoch, 02.06.2009   END

  IF gr_complstage_grid IS BOUND.
    CALL METHOD gr_complstage_grid->destroy.
  ENDIF.

  IF gr_container IS BOUND.
    CALL METHOD gr_container->is_valid
      IMPORTING
        result = l_is_valid.
    IF l_is_valid = 1.
      CALL METHOD gr_container->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2.
      IF sy-subrc <> 0.
        CLEAR gr_container.
      ENDIF.
    ENDIF.
    FREE  gr_container.
    CLEAR gr_container.
  ENDIF.

  e_saved     = g_saved.
  e_cancelled = g_cancelled.

ENDFUNCTION.
