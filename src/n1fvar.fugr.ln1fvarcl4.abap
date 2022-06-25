*----------------------------------------------------------------------*
*   INCLUDE LN1FVARCL4                                                 *
*----------------------------------------------------------------------*

*---------------------------------------------------------------------*
*       CLASS dragdrop_receiver DEFINITION
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
CLASS lcl_dragdrop_receiver DEFINITION.
  PUBLIC SECTION.
    METHODS:

*      on_drag_multiple EVENT
       edit_tree_drag FOR EVENT on_drag_multiple OF cl_gui_alv_tree
                      IMPORTING node_key_table drag_drop_object,
*      on_drop EVENT
       edit_tree_drop FOR EVENT on_drop OF cl_gui_alv_tree
                      IMPORTING node_key drag_drop_object,
*      on_drop_complete_multiple EVENT
       edit_tree_drop_complete FOR EVENT on_drop_complete_multiple OF
                      cl_gui_alv_tree
                      IMPORTING node_key_table drag_drop_object.

ENDCLASS.                    "lcl_dragdrop_receiver DEFINITION

************************************************************************

*---------------------------------------------------------------------*
*       CLASS DRAGDROP_RECEIVER IMPLEMENTATION
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
CLASS lcl_dragdrop_receiver IMPLEMENTATION.

* on_drag - EVENT
  METHOD edit_tree_drag.

    DATA: drag_object    TYPE REF TO lcl_drag_object,
          l_wa_edittree  TYPE ty_edittree,
          type(1),
          node_key       TYPE lvc_nkey.

    CLEAR node_key.
    CLEAR type.
*   Objekt Drag_object anlegen
    CREATE OBJECT drag_object.

*   loop über zu draggende Nodes
*   Prüfung: es ist nur ein Verschieben von gleichen
*   Typen möglich. Also nicht Buttons und Funktionen solange
*   es sich bei dem Button nicht um den eigenen Parentbutton
*   handelt. Separatoren (S u. Z) sind auch nur unter Funktionen
*   bzw. unter Button gleichen Typs erlaubt
    LOOP AT node_key_table INTO node_key.

*     Daten holen
      CALL METHOD g_edit_tree->get_outtab_line
        EXPORTING
          i_node_key    = node_key
        IMPORTING
          e_outtab_line = l_wa_edittree.

      IF type IS INITIAL.
        IF NOT ( l_wa_edittree-type = 'S' OR
                 l_wa_edittree-type = 'Z' ) .
          type = l_wa_edittree-type.
        ENDIF.
      ELSE.
        IF NOT ( l_wa_edittree-type = 'S' OR
                 l_wa_edittree-type = 'Z' ) .
          IF type <> l_wa_edittree-type.
            CALL METHOD drag_drop_object->abort.
            MESSAGE s380(nf1).
*           Verschieben ist nur bei gleichen Typen möglich

            EXIT.
          ENDIF.
        ENDIF.
      ENDIF.

*     der Drag-Drop Liste drag_object->text anhängen
      APPEND node_key TO drag_object->text.
    ENDLOOP.

*   ist die Liste leer, dann drag-drop-aktion abbrechen
    DESCRIBE TABLE drag_object->text.
    IF sy-tfill <= 0.
      CALL METHOD drag_drop_object->abort.
      EXIT.
    ENDIF.

*   Object zuweisen
    drag_drop_object->object = drag_object.

  ENDMETHOD.                    "edit_tree_drag
* -----------------------------------------------------------------
* on_drop_multiple EVENT
* -----------------------------------------------------------------
  METHOD edit_tree_drop.
    DATA: drag_object             TYPE REF TO lcl_drag_object,
          xnode_key               TYPE lvc_nkey,
          l_wa_edittree           TYPE ty_edittree,
          l_wa_gt_edittree        TYPE ty_edittree,
          l_wa_ins_after_edittree TYPE ty_edittree,
          l_relatship             TYPE i,
          l_node_text             TYPE lvc_value,
          l_node_lay              TYPE lvc_s_layn,
          l_new_node_key          TYPE lvc_nkey,
*          l_func_flag             TYPE c,
          lt_itemlay              TYPE lvc_t_layi,
          l_max_btn_nr            TYPE nwbutton-buttonnr,
          lt_child_list           TYPE lvc_t_nkey,
          l_wa_child_list         TYPE lvc_nkey,
          l_wa_tmp_edittree       TYPE ty_edittree,
          lt_node_struct          TYPE tyt_edittree,
          l_wa_drag_object        TYPE lvc_nkey,
          lt_tmp_drag_object      TYPE lvc_t_nkey.

*   Überprüfung auf Systemexceptions
    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
      drag_object ?= drag_drop_object->object.
    ENDCATCH.
    IF sy-subrc = 1.
      " data object has unexpected class
      " => cancel Drag & Drop
* operation abbrechen
      CALL METHOD drag_drop_object->abort.
      EXIT.
    ENDIF.

* Aktuellen Node holen auf den gedropped worden ist
    CALL METHOD g_edit_tree->get_outtab_line
      EXPORTING
        i_node_key    = node_key
      IMPORTING
        e_outtab_line = l_wa_ins_after_edittree.


*   Überprüfen ob auf gleicher Ebene geinsertet wird,
*   demnach ist die Relationship zu setzen
    READ TABLE drag_object->text INTO xnode_key INDEX 1.
    CALL METHOD g_edit_tree->get_outtab_line
      EXPORTING
        i_node_key    = xnode_key
      IMPORTING
        e_outtab_line = l_wa_edittree.

    IF ( l_wa_edittree-type = 'F' AND
         l_wa_ins_after_edittree-type = 'F' ) OR
       ( l_wa_edittree-type = 'B' AND
         l_wa_ins_after_edittree-type = 'B' ) OR
       ( l_wa_edittree-type = 'Z' AND
         l_wa_ins_after_edittree-type = 'F' ) OR
*       ( l_wa_edittree-type = 'S' and
*         l_wa_ins_after_edittree-type = 'B' ) or
       ( l_wa_edittree-type = 'F' AND
         l_wa_ins_after_edittree-type = 'Z' ) OR
       ( l_wa_edittree-type = 'B' AND
         l_wa_ins_after_edittree-type = 'S' ) OR
       ( l_wa_edittree-type = 'F' AND
         l_wa_ins_after_edittree-type = 'B' ).

*     die Reihenfolge umdrehen
      REFRESH lt_tmp_drag_object.
      LOOP AT drag_object->text INTO l_wa_drag_object.
        INSERT l_wa_drag_object INTO lt_tmp_drag_object INDEX 1.
      ENDLOOP.

      REFRESH drag_object->text.
*     der globalen liste wieder zuweisen
      drag_object->text[] = lt_tmp_drag_object.

    ENDIF.

    CLEAR l_wa_edittree.
    CLEAR xnode_key.

* LOOP ÜBER ZU DRAGGENDE OBJEKTE -------------------------L O O P
    LOOP AT drag_object->text INTO xnode_key.

*     Droppen auf sich selbst ist nicht erlaubt
      IF node_key = xnode_key.
        EXIT.
      ENDIF.

      CALL METHOD g_edit_tree->get_outtab_line
        EXPORTING
          i_node_key    = xnode_key
        IMPORTING
          e_outtab_line = l_wa_edittree.

*       höchste Buttonnummer rausfinden
      LOOP AT gt_edittree INTO l_wa_gt_edittree.
        IF l_wa_gt_edittree-buttonnr > l_max_btn_nr.
          l_max_btn_nr = l_wa_gt_edittree-buttonnr.
        ENDIF.
      ENDLOOP.

*     Funktionen können nicht unter einem Button Separator
*     gehängt werden
      IF l_wa_edittree-type = 'F' AND
         l_wa_ins_after_edittree-type = 'S'.
        CONTINUE.
      ENDIF.

*     Sonderbehandlung für Separatoren
* -----------------------------------------------------------
      IF l_wa_edittree-type = 'S' OR l_wa_edittree-type = 'Z'.

*       Funktionsseparatoren sind auf Button/Root Ebene nicht erlaubt.
        IF "( l_wa_ins_after_edittree-type = 'B' or
             l_wa_ins_after_edittree-type = 'R'  AND
             l_wa_edittree-type = 'Z'.
          CALL METHOD drag_drop_object->abort.
          EXIT.
        ENDIF.

*       Genausowenig wie Buttonseparatoren auf Funktionsebene
        IF ( l_wa_edittree-type = 'S' AND
             l_wa_ins_after_edittree-type = 'F' ) OR
           ( l_wa_edittree-type = 'Z' AND
             l_wa_ins_after_edittree-type = 'S' ) .
          CALL METHOD drag_drop_object->abort.
          EXIT.
        ENDIF.

        CLEAR l_node_lay.
        l_wa_edittree-icon = icon_space.
        l_wa_edittree-txt = co_edittree_separator.
        l_node_text  = co_edittree_separator.

*       Node Layout setzen
        IF l_wa_edittree-type = 'S'.
          l_node_lay-isfolder = on.
*          l_func_flag         = off.

          l_max_btn_nr = l_max_btn_nr + 1.
*         Buttonnummer vergeben
          l_wa_edittree-buttonnr = l_max_btn_nr.
        ELSE.
          l_node_lay-isfolder = off.
*          l_func_flag         = on.
          l_wa_edittree-buttonnr = l_wa_ins_after_edittree-buttonnr.
        ENDIF.

*       Drag-Drop - ID setzen sonst kennt er es nicht
        l_node_lay-dragdropid = handle_edit_tree.
        l_node_text = l_wa_edittree-txt.

*       Relationship festlegen
        IF ( l_wa_ins_after_edittree-type = 'R' AND
             l_wa_edittree-type = 'S' ) OR
           ( l_wa_ins_after_edittree-type = 'B' AND
             l_wa_edittree-type = 'Z' ) .
          l_relatship = cl_gui_column_tree=>relat_first_child.
        ELSE.
          l_relatship = cl_gui_column_tree=>relat_next_sibling.
        ENDIF.

*       Itemliste des Edittrees erstellen
        PERFORM build_items_edittree USING g_edit_tree l_wa_edittree
                                           lt_itemlay 0.
*       Node inserten
        CALL METHOD g_edit_tree->add_node
          EXPORTING
            i_relat_node_key     = node_key
            i_relationship       = l_relatship
            is_outtab_line       = l_wa_edittree
            is_node_layout       = l_node_lay
            it_item_layout       = lt_itemlay
            i_node_text          = l_node_text
          IMPORTING
            e_new_node_key       = l_new_node_key
          EXCEPTIONS
            relat_node_not_found = 1
            node_not_found       = 2
            OTHERS               = 3.
        IF sy-subrc <> 0.
        ENDIF.

*       Ursprüngliche Node (Position) löschen
*       ggf. UPdate des Expander (+/-) Kz
        CALL METHOD g_edit_tree->delete_subtree
          EXPORTING
            i_node_key                = xnode_key
            i_update_parents_expander = 'X'.

      ELSE. " ---------------------------------------


*       Prüfung: es kann nur ein Button hinter einem Button und
*       eine Funktion hinter einer Funktion eingefügt werden.
*       Sonderbehandlung: Funktion(F) wird unter anderem Button bzw.
*       Funktion verlagert.
*       Ebenso wenn eine Funktion unter den Root-Knoten gehängt werden
*       soll.
        IF ( l_wa_ins_after_edittree-type = 'F'   AND
             l_wa_edittree-type           = 'B' ) OR
           ( l_wa_ins_after_edittree-type = 'R'   AND
             l_wa_edittree-type           = 'F' ) .
*         Ausnahme sind Funktionen (ohne Children!): z.B. Kunden-
*         Funktionen: denn die werden als Buttons angelegt und könnten
*         sonst nie als Funktionen unter Buttons gehängt werden (weil
*         sie ja nicht in den Funktionsvorrats-Tree geschoben werden
*         können!)                                            ID 11731
          REFRESH lt_child_list.
          CALL METHOD g_edit_tree->get_children
            EXPORTING
              i_node_key  = xnode_key
            IMPORTING
              et_children = lt_child_list.
          DESCRIBE TABLE lt_child_list.
          IF sy-tfill > 0.
            CALL METHOD drag_drop_object->abort.
            EXIT.
          ENDIF.
        ENDIF.

        CLEAR l_node_lay.

*       Node-Text erstellen
        l_node_text = l_wa_edittree-txt.

*       und damit einen Eintrag im Edit-Tree anlegen
* --------------------------------FUNKTIONS EBENE --------------------
        IF l_wa_edittree-type = 'F'.

          IF l_wa_ins_after_edittree-type = 'R'.
*           Eine Funktion wird zu einem Button unter Root (ID 11731)
            l_node_lay-isfolder   = on.
*            l_func_flag           = off.
            l_wa_edittree-icon = icon_space.
            l_max_btn_nr = l_max_btn_nr + 1.
*           Buttonnummer vergeben
            l_wa_edittree-buttonnr = l_max_btn_nr.
            l_wa_edittree-type     = 'B'.
            CLEAR l_wa_edittree-tb_butt.
          ELSE.
*           Funktion unter Funktion umhängen
            l_node_lay-isfolder   = off.
*            l_func_flag           = on.
*           Buttonnummer vergeben
            l_wa_edittree-buttonnr = l_wa_ins_after_edittree-buttonnr.
            CLEAR l_wa_edittree-icon.
          ENDIF.
* --------------------------------BUTTON EBENE --------------------
        ELSEIF l_wa_edittree-type = 'B'.

          IF l_wa_ins_after_edittree-type = 'F'.
*           Ein Button wird zu einer Funktion (ID 11731)
*           Node-Text erstellen
            IF NOT l_wa_edittree-icon_q IS INITIAL.
              l_node_text = l_wa_edittree-icon_q.
              l_wa_edittree-txt = l_wa_edittree-icon_q.
              CLEAR l_wa_edittree-icon_q.
            ELSE.
              l_node_text = l_wa_edittree-txt.
            ENDIF.
            l_node_lay-isfolder    = off.
*            l_func_flag            = on.
*           Buttonnummer vergeben
            l_wa_edittree-buttonnr = l_wa_ins_after_edittree-buttonnr.
            l_wa_edittree-type     = 'F'.
            l_wa_edittree-tb_butt  = '01'.
            CLEAR l_wa_edittree-icon.
*           an der entsprechenden Stelle einfügen (nicht nötig!?)
*          LOOP AT gt_edittree INTO l_wa_gt_edittree
*                  WHERE buttonnr = l_wa_ins_after_edittree-buttonnr.
*            IF l_wa_ins_after_edittree-lfdnr = l_wa_gt_edittree-lfdnr.
*              l_wa_edittree-lfdnr = l_wa_ins_after_edittree-lfdnr + 1.
*            ELSEIF l_wa_gt_edittree-lfdnr >
*                   l_wa_ins_after_edittree-lfdnr AND
*                   NOT l_wa_gt_edittree-lfdnr IS INITIAL.
*              l_wa_gt_edittree-lfdnr = l_wa_gt_edittree-lfdnr + 1.
*              MODIFY gt_edittree FROM l_wa_gt_edittree.
*            ENDIF.
*          ENDLOOP.
          ELSE.
*           Button unter Button umhängen
*           Hierarchie nach letzter Funktion dieses Buttons einfüg.
            l_node_lay-isfolder = on.
*            l_func_flag         = off.
            l_max_btn_nr = l_max_btn_nr + 1.
*           Buttonnummer vergeben
            l_wa_edittree-buttonnr = l_max_btn_nr.
          ENDIF.
        ENDIF.

        l_node_lay-dragdropid = handle_edit_tree.

*       Relationship bestimmen
        IF l_wa_ins_after_edittree-type = 'R'.
          IF l_wa_edittree-type = 'B'.
            l_relatship = cl_gui_column_tree=>relat_first_child.
          ENDIF.

        ELSEIF ( l_wa_ins_after_edittree-type = 'B' AND
                  l_wa_edittree-type = 'F' ) .
          l_relatship = cl_gui_column_tree=>relat_first_child.
        ELSE.
          l_relatship = cl_gui_column_tree=>relat_next_sibling.
        ENDIF.

*       Itemsliste anlegen
        PERFORM build_items_edittree USING g_edit_tree l_wa_edittree
                                           lt_itemlay 0.
*       Node anlegen
        CALL METHOD g_edit_tree->add_node
          EXPORTING
            i_relat_node_key     = node_key
            i_relationship       = l_relatship
            is_outtab_line       = l_wa_edittree
            is_node_layout       = l_node_lay
            it_item_layout       = lt_itemlay
            i_node_text          = l_node_text
          IMPORTING
            e_new_node_key       = l_new_node_key
          EXCEPTIONS
            relat_node_not_found = 1
            node_not_found       = 2
            OTHERS               = 3.
        IF sy-subrc <> 0.
        ENDIF.

*       Children des zu movenden Nodes ermitteln, damit diese
*       umgehängt werden können
*       Hier werden die ggf. vorhandenen Funktionen umgehängt
        REFRESH lt_child_list.
        CLEAR l_wa_gt_edittree.
        CALL METHOD g_edit_tree->get_children
          EXPORTING
            i_node_key  = xnode_key
          IMPORTING
            et_children = lt_child_list.

        DESCRIBE TABLE lt_child_list.
        IF sy-tfill > 0.
*         Loop über die gefundenen Children
          LOOP AT lt_child_list INTO l_wa_child_list.
*           Holen der Daten
            CLEAR l_wa_tmp_edittree.
            CALL METHOD g_edit_tree->get_outtab_line
              EXPORTING
                i_node_key    = l_wa_child_list
              IMPORTING
                e_outtab_line = l_wa_tmp_edittree.


*           Loop über die glob. Treeliste und updaten der Referenz
            READ TABLE gt_edittree INTO l_wa_gt_edittree
                    WITH KEY fcode = l_wa_tmp_edittree-fcode.

            IF sy-subrc = 0.
              l_wa_tmp_edittree-buttonnr = l_wa_edittree-buttonnr.

*             Node-Text erstellen
              IF l_wa_tmp_edittree-type = 'Z'.
                l_node_text  = co_edittree_separator.
              ELSE.
                l_node_text = l_wa_tmp_edittree-txt.
              ENDIF.

*             Node Layout
              l_node_lay-isfolder   = off.
*              l_func_flag           = on.
              CLEAR l_wa_edittree-icon.

*             Drag-Drop ID setzen sonst kennt er es nicht
              l_node_lay-dragdropid = handle_edit_tree.
              l_relatship = cl_gui_column_tree=>relat_last_child.

*             Itemlist anlegen
              PERFORM build_items_edittree USING g_edit_tree  "#EC *
                           l_wa_tmp_edittree lt_itemlay 0.

*             Node adden
              CALL METHOD g_edit_tree->add_node
                EXPORTING
                  i_relat_node_key     = l_new_node_key
                  i_relationship       = l_relatship
                  is_outtab_line       = l_wa_tmp_edittree
                  is_node_layout       = l_node_lay
                  it_item_layout       = lt_itemlay
                  i_node_text          = l_node_text
                EXCEPTIONS
                  relat_node_not_found = 1
                  node_not_found       = 2
                  OTHERS               = 3.
              IF sy-subrc <> 0.
              ENDIF.
            ENDIF.
          ENDLOOP.
        ENDIF.

*       Ursprüngliche Node (Position) löschen
        CALL METHOD g_edit_tree->delete_subtree
          EXPORTING
            i_node_key                = xnode_key
            i_update_parents_expander = 'X'.

      ENDIF.

    ENDLOOP.   " LOOP AT LT_FUNC_MARKS ...

    node_key = g_top_node_key.

*   Strukturierte Liste mit geordneter buttonnr holen
    PERFORM get_ordered_edittree CHANGING lt_node_struct.

*   Den Toolbar nun mit Werten versorgen
    PERFORM set_result_bar USING lt_node_struct
                                 g_result_bar.

*   Flush und Frontend-Update durchführen
    CALL METHOD cl_gui_cfw=>flush.
    CALL METHOD g_edit_tree->frontend_update.

    g_anythingchanged = true.

  ENDMETHOD.                    "edit_tree_drop

* on_drop_complete
  METHOD edit_tree_drop_complete.
*   nicht implementiert
  ENDMETHOD.                    "edit_tree_drop_complete
ENDCLASS.                    "lcl_dragdrop_receiver IMPLEMENTATION

************************************************************************
