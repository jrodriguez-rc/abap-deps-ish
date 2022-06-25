*----------------------------------------------------------------------*
***INCLUDE LN2_BASEITEM__COMPONENTO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  get_instance  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_instance OUTPUT.

  TRY.

      gr_manager = cl_ishmed_baseitems_manager=>get_instance( ).

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

ENDMODULE.                 " get_instance  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  get_readonly  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_readonly OUTPUT.

  TRY.
      g_readonly = gr_manager->is_readonly( ).

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

ENDMODULE.                 " get_readonly  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  get_data  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_data OUTPUT.

  TRY.
      gr_manager->get_baseitem_data(
        IMPORTING
          es_data = gs_component ).

      rn2_baseitem__component_d-frame_comp =
          gr_manager->get_itemtype_text(  ).

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

  MOVE-CORRESPONDING gs_component TO rn2_baseitem__component_d.

ENDMODULE.                 " get_data  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  modify_screen  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE modify_screen OUTPUT.

  IF g_readonly = abap_on.
    LOOP AT SCREEN.
      screen-input = '0'.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

ENDMODULE.                 " modify_screen  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  listboxen  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE listboxen OUTPUT.

  PERFORM get_actions.

  PERFORM set_first_actions.

  PERFORM set_again_actions.

ENDMODULE.                 " listboxen  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  get_comp_cfg  OUTPUT
*&---------------------------------------------------------------------*
*       Component configuration
*----------------------------------------------------------------------*
MODULE get_comp_cfg OUTPUT.
  TRY.
      lcl_component_screen=>create(
        EXPORTING
          i_itemtype    = gs_component-itemtype
          i_baseitem_id = gs_component-baseitemid
        CHANGING
          cr_instance = gr_screen ).

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

ENDMODULE.                 " get_comp_cfg  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  set_mode_to_subscreen  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_mode_to_subscreen OUTPUT.

  TRY.
      CHECK gr_screen IS BOUND.

      gr_screen->set_mode(
          i_readonly    = g_readonly ).

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


ENDMODULE.                 " set_mode_to_subscreen  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  get_subcreen  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE get_subcreen OUTPUT.

  TRY.
      CHECK gr_screen IS BOUND.

      gr_screen->get_screen(
         IMPORTING
          e_dynnr    = g_dynnr
          e_program  = g_repid ).

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

ENDMODULE.                 " get_subcreen  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  set_data_to_sub  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE set_data_to_sub OUTPUT.

  TRY.
      CHECK gr_screen IS BOUND.

      gr_screen->set_data(
          i_xmldoc = gs_component-comp_as_xml ).


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



ENDMODULE.                 " set_data_to_sub  OUTPUT
