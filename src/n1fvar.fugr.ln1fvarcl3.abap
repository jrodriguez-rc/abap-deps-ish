*----------------------------------------------------------------------*
*   INCLUDE LN1FVARCL3                                                 *
*----------------------------------------------------------------------*
* Event-Handling für Edittree (DEFINITION)
CLASS lcl_edittree_event_receiver DEFINITION.

  PUBLIC SECTION.

*   handle_node_ctmenu_request
    METHODS handle_node_ctmenu_request
      FOR EVENT node_context_menu_request OF cl_gui_alv_tree
        IMPORTING node_key
                  menu.
*   handle_node_ctmenu_selected
    METHODS handle_node_ctmenu_selected
      FOR EVENT node_context_menu_selected OF cl_gui_alv_tree
        IMPORTING node_key
                  fcode.
*   handle_expand_no_children
    METHODS handle_expand_no_children
      FOR EVENT expand_nc OF cl_gui_alv_tree
        IMPORTING node_key.
*   handle_checkbox_change
    METHODS handle_checkbox_change
      FOR EVENT checkbox_change OF cl_gui_alv_tree
        IMPORTING node_key
                  fieldname
                  checked.
*   handle_item_double_click
    METHODS handle_item_double_click
      FOR EVENT item_double_click OF cl_gui_alv_tree
      IMPORTING node_key
                fieldname.
**   handle_header_click
*    METHODS handle_header_click
*      FOR EVENT header_click OF cl_gui_alv_tree
*      IMPORTING fieldname.
*   handle_node_double_click
    METHODS handle_node_double_click
      FOR EVENT node_double_click OF cl_gui_alv_tree
      IMPORTING node_key.

ENDCLASS.                    "lcl_edittree_event_receiver DEFINITION

* Event-Handling für Edittree (IMPLEMENTIERUNG)
CLASS lcl_edittree_event_receiver IMPLEMENTATION.

* handle_node_ctmenu_request
  METHOD handle_node_ctmenu_request.

    DATA: l_txt TYPE gui_text.

*   append own functions
    l_txt = 'Trennlinie einfügen'(t09).
    CALL METHOD menu->add_function
      EXPORTING
        fcode       = 'INS_SEP'
        text        = l_txt
        accelerator = 'S'.

    l_txt = 'Löschen'(017).
    CALL METHOD menu->add_function
      EXPORTING
        fcode       = 'DEL'
        text        = l_txt
        accelerator = 'L'.

  ENDMETHOD.                    "handle_node_ctmenu_request

* handle_node_ctmenu_selected
  METHOD handle_node_ctmenu_selected.
    CASE fcode.
      WHEN 'DEL'.
        PERFORM delete_marks.           "Einträge löschen

      WHEN 'INS_SEP'.
        PERFORM insert_marks USING 'S'. "Separator einfügen

    ENDCASE.
  ENDMETHOD.                    "handle_node_ctmenu_selected

* handle_expand_no_children
  METHOD handle_expand_no_children.
*   nicht implementiert
  ENDMETHOD.                    "handle_expand_no_children

* handle_checkbox_change
  METHOD handle_checkbox_change.
*   nicht implementiert
  ENDMETHOD.                    "handle_checkbox_change

* Doppelklick auf einem Item (d.h. einem Feld)
  METHOD handle_item_double_click.

    IF NOT g_edit_mode = on.
      CALL METHOD me->handle_node_double_click
        EXPORTING
          node_key = node_key.
    ELSE.
      MESSAGE s395.
      EXIT.
*     Daten sind gerade in Bearbeitung - Funktion nicht verfügbar
    ENDIF.

  ENDMETHOD.                    "handle_item_double_click

** handle_header_click
*  METHOD handle_header_click.
**   nicht implementiert
*  ENDMETHOD.                    "handle_header_click

* Doppelklick auf einem Knoten
  METHOD handle_node_double_click.

    PERFORM node_double_click USING node_key.

  ENDMETHOD.                    "handle_node_double_click

ENDCLASS.                    "lcl_edittree_event_receiver IMPLEMENTATION
