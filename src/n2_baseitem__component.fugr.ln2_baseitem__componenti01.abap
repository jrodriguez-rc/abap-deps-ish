*----------------------------------------------------------------------*
***INCLUDE LN2_BASEITEM__COMPONENTI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  set_data  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_data INPUT.

  CHECK g_readonly = abap_off.

  MOVE-CORRESPONDING rn2_baseitem__component_d TO gs_component.

  TRY.
      gr_manager->set_baseitem_data(
                    is_data = gs_component  ).

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
          CATCH cx_ishmed_baseitems.
        ENDTRY.
        FREE gr_manager.
        LEAVE PROGRAM.
      ENDIF.
  ENDTRY.

ENDMODULE.                 " set_data  INPUT
*&---------------------------------------------------------------------*
*&      Module  ok_code_handling  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE ok_code_handling INPUT.

  TRY.
      CHECK gr_screen IS BOUND.

      gr_screen->set_ok_code(
          EXPORTING
            i_okcode        = sy-ucomm
          IMPORTING                                         " 6.05
            e_rc            = g_rc                          " 6.05
          CHANGING                                          " 6.05
            cr_errorhandler = gr_error ).                   " 6.05

    CATCH cx_ishmed_baseitems INTO gx_baseitems.

      cl_ish_utl_base=>collect_messages_by_exception(
        EXPORTING
          i_exceptions    = gx_baseitems
        CHANGING
          cr_errorhandler = gr_error ).

      IF gr_error IS BOUND.
        gr_error->display_messages( ).
        gr_manager->finalize( ).
        FREE gr_manager.
        LEAVE PROGRAM.
      ENDIF.

  ENDTRY.

* 6.05:
  CHECK g_rc <> 0.
  cl_ish_utl_base=>collect_messages_by_exception(
    EXPORTING
      i_exceptions    = gx_baseitems
    CHANGING
      cr_errorhandler = gr_error ).
  IF gr_error IS BOUND.
    gr_error->display_messages( ).
  ENDIF.

ENDMODULE.                 " ok_code_handling  INPUT
*&---------------------------------------------------------------------*
*&      Module  get_data_from_sub  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_data_from_sub INPUT.

  CHECK g_readonly = abap_off.

  TRY.
      CHECK gr_screen IS BOUND.

      gr_screen->get_data(
        IMPORTING
          e_xmldoc = gs_component-comp_as_xml ).


    CATCH cx_ishmed_baseitems INTO gx_baseitems.

      cl_ish_utl_base=>collect_messages_by_exception(
        EXPORTING
          i_exceptions    = gx_baseitems
        CHANGING
          cr_errorhandler = gr_error ).

      IF gr_error IS BOUND.
        gr_error->display_messages( ).
        gr_manager->finalize( ).
        FREE gr_manager.
        LEAVE PROGRAM.
      ENDIF.

  ENDTRY.

ENDMODULE.                 " get_data_from_sub  INPUT
