*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_CONTEXTO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE pbo_0100 OUTPUT.

  PERFORM pbo_0100.

ENDMODULE.                 " pbo_0100  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  init_tabstrip  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_tabstrip OUTPUT.

  DATA: l_rc TYPE ish_method_rc,
        lr_errorhandler TYPE REF TO cl_ishmed_errorhandling,
        l_scrollpos TYPE sy-ucomm,
* ED, ID 17836 -> BEGIN
        l_tabstrip_dyn        LIKE LINE OF gt_tabstrip_dyn,
        l_key                 TYPE string,
        l_cxid                TYPE nctx-cxid,
        lr_ctx_userdef        TYPE REF TO cl_ishmed_subscr_ctx_userdef,
        lr_context            TYPE REF TO cl_ish_context.
* ED, ID 17836 -> END

  CLEAR: l_rc.

  IF g_first_time = on.
    PERFORM init_tabstrip USING l_rc
                              lr_errorhandler.
*   Käfer, ID: 17836 - Begin
*   only refresh gt_tabstrip, allready existing entries should stay the
*   same
  ELSE.
    PERFORM refresh_tabstrip USING l_rc
                              lr_errorhandler.
*   Käfer, ID: 17836 - End
  ENDIF.


  IF l_rc = 0.
    IF g_first_time = on.
*     for first call
* ED, ID 17836 -> BEGIN
      CLEAR: g_tabstrip_dynpro, gt_tabstrip_dyn[].
      CALL METHOD gr_subscr_context->get_tabstrip_data
        IMPORTING
          et_tabstrip       = gt_tabstrip_dyn
          e_tabstrip_dynpro = g_tabstrip_dynpro.
      IF NOT gt_tabstrip_dyn[] IS INITIAL.
        READ TABLE gt_tabstrip_dyn INTO l_tabstrip_dyn
              INDEX 1.
        IF g_regcard IS INITIAL.
          lr_ctx_userdef ?= l_tabstrip_dyn-subscr.
          CALL METHOD lr_ctx_userdef->('GET_DATA')
            IMPORTING
              e_context = lr_context.
          CALL METHOD lr_context->get_key_string
            IMPORTING
              e_key = l_key.
          CALL METHOD cl_ish_context=>build_data_key
            EXPORTING
              i_key  = l_key
            IMPORTING
              e_cxid = l_cxid.
          g_regcard = l_cxid.
        ENDIF.
      ENDIF.
* ED, ID 17836 -> END
      PERFORM set_default_tab
         USING     g_regcard
         CHANGING  l_rc
                   lr_errorhandler
                   g_tabstrip_dynpro-function
                   l_scrollpos.
      CHECK l_rc = 0.
      g_tabstrip-%_scrollposition = l_scrollpos.
    ENDIF.

* ---------- ---------- ----------
*   Dynamische Anzeige der Registerkarten
    PERFORM set_tabstrip_dyn USING l_rc
                                   lr_errorhandler.
    IF l_rc = 0.

*     get the program and dynpro from the context
      CLEAR: g_dynpg, g_dynnr.
      CALL METHOD gr_subscr_context->get_dynpro_context
        IMPORTING
          e_pgm_context   = g_dynpg
          e_dynnr_context = g_dynnr.
    ENDIF.
  ENDIF.
* if dynnr and repid are initial -> set default
  IF g_dynpg IS INITIAL OR gt_tabstrip_dyn[] IS INITIAL.
    g_dynpg = 'SAPLN1SC'.
  ENDIF.
  IF g_dynnr IS INITIAL OR gt_tabstrip_dyn[] IS INITIAL.
    g_dynnr = '0001'.
  ENDIF.

  g_first_time = off.

ENDMODULE.                 " set_tabstrip  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  init_context  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE init_context OUTPUT.

  l_rc = 0.

  PERFORM init_context USING l_rc lr_errorhandler.
  CHECK l_rc = 0.

ENDMODULE.                 " init_context  OUTPUT
