*----------------------------------------------------------------------*
*   INCLUDE LN1FVARCL1                                                 *
*----------------------------------------------------------------------*
* Event-Handling für Funktions-Tree-Control (Arbeitsvorrat)
CLASS lcl_functree_event_receiver DEFINITION.
  PUBLIC SECTION.

    METHODS handle_node_ctmenu_request
      FOR EVENT node_context_menu_request OF cl_gui_alv_tree
        IMPORTING node_key
                  menu.

    METHODS handle_node_ctmenu_selected
      FOR EVENT node_context_menu_selected OF cl_gui_alv_tree
        IMPORTING node_key
                  fcode.

    METHODS handle_item_double_click
      FOR EVENT item_double_click OF cl_gui_alv_tree
      IMPORTING node_key
                fieldname.

    METHODS handle_button_click
      FOR EVENT button_click OF cl_gui_alv_tree
      IMPORTING node_key
                fieldname.

    METHODS handle_link_click
      FOR EVENT link_click OF cl_gui_alv_tree
      IMPORTING node_key
                fieldname.

*    methods handle_header_click
*      for event header_click of cl_gui_alv_tree
*      importing fieldname.

ENDCLASS.                    "lcl_functree_event_receiver DEFINITION

* Event-Handling für Funktions-Tree-Control
* IMPLEMENTIERUNG
CLASS lcl_functree_event_receiver IMPLEMENTATION.

* METHOD: handle_node_ctmenu_request ------------
  METHOD handle_node_ctmenu_request.
    DATA: l_txt1 TYPE gui_text.
    DATA: l_txt2 TYPE gui_text.

    l_txt1 = 'Als Drucktaste einfügen'(015).
    l_txt2 = 'Als Funktion einfügen'(016).

    CALL METHOD menu->add_function
      EXPORTING
        fcode       = 'INS_NODE'
        text        = l_txt1
        accelerator = 'D'.

    CALL METHOD menu->add_function
      EXPORTING
        fcode       = 'INS_FUNC'
        text        = l_txt2
        accelerator = 'F'.

  ENDMETHOD.                    "handle_node_ctmenu_request

* METHOD: HANDLE_NODE_CTMENU_SELECTED -------------
  METHOD handle_node_ctmenu_selected.
    CASE fcode.
      WHEN 'INS_NODE'.
        PERFORM insert_marks USING 'B'.   " Insert Button
      WHEN 'INS_FUNC'.
        PERFORM insert_marks USING 'F'.   " Insert Funktion
    ENDCASE.
  ENDMETHOD.                    "handle_node_ctmenu_selected


  METHOD handle_item_double_click.
*   nicht implementiert
  ENDMETHOD.                    "handle_item_double_click

  METHOD handle_button_click.
*   nicht implementiert
  ENDMETHOD.                    "handle_button_click

  METHOD handle_link_click.
*   nicht implementiert
  ENDMETHOD.                    "handle_link_click

*  method handle_header_click.
**   nicht implementiert
*  endmethod.

ENDCLASS.                    "lcl_functree_event_receiver IMPLEMENTATION
