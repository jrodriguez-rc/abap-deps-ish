FUNCTION-POOL n1wpl  MESSAGE-ID nf1.

*----------------------------------------------------------------------*
* Definition von TRUE, FALSE ...
*----------------------------------------------------------------------*
INCLUDE mndata00.
INCLUDE <icon>.

*----------------------------------------------------------------------*
* Tablesdefinitionen
*----------------------------------------------------------------------*
TABLES: rn1_scr_wpl100,
        rn1_scr_wpl101,
        rn1_scr_wpl300,
        rn1_scr_wpl301.

*----------------------------------------------------------------------*
* Typdefinitionen
*----------------------------------------------------------------------*
* Definition of Control Framework
TYPE-POOLS cndp.                                            "#EC *
TYPE-POOLS cntb.                                            "#EC *

* Definition for list box
TYPE-POOLS vrm.                                             "#EC *

TYPES: item_table_type TYPE STANDARD TABLE OF mtreeitm
                                     WITH DEFAULT KEY.


* Auszuschließende Funktionen des GUI-Status
TYPES: BEGIN OF ty_ex_fct,
         function(30) TYPE c,
       END OF ty_ex_fct.

DATA: gt_nwpvz_old      TYPE TABLE OF v_nwpvz,
*       Alle Sichten zu den Sichttypen eines Arbeitsumfeldtypen
      gt_views_all      TYPE TABLE OF v_nwview,
*       Daten für den Vorrat an Sichten (Anzeige rechter Tree)
      gt_views          TYPE TABLE OF v_nwview,
*       Spezielle Daten für Arbeitsumfeldtyp 001
      gt_nwplace_001    TYPE TABLE OF nwplace_001.

* Daten für das Launchpad (aber hier sind die Platzhalter
* nicht ersetzt)
DATA: gt_nwplace        TYPE TABLE OF v_nwplace,
      gt_nwpusz         TYPE TABLE OF v_nwpusz,
      gt_nwview         TYPE TABLE OF v_nwview,
      gt_nwpvz          TYPE TABLE OF v_nwpvz.

* Daten die am Launchpad angezeigt werden (linker Tree)
DATA: gt_nwplace_lp     TYPE TABLE OF v_nwplace,
      gt_nwpusz_lp      TYPE TABLE OF v_nwpusz,
      gt_nwview_lp      TYPE TABLE OF v_nwview,
      gt_nwpvz_lp       TYPE TABLE OF v_nwpvz.


*----------------------------------------------------------------------*
* Globale Tabellendefinitionen
*----------------------------------------------------------------------*

* Auszuschließende Funktionen des GUI-Status
DATA: gt_ex_fct         TYPE TABLE OF ty_ex_fct WITH HEADER LINE.



*----------------------------------------------------------------------
* Konstantendefinitionen
*----------------------------------------------------------------------
CONSTANTS: g_vcode_insert   TYPE ish_vcode  VALUE 'INS',
           g_vcode_update   TYPE ish_vcode  VALUE 'UPD',
           g_vcode_display  TYPE ish_vcode  VALUE 'DIS'.

CONSTANTS: gc_viewtype(2)   TYPE c VALUE 'ty',
           gc_viewid(2)     TYPE c VALUE 'id'.

CONSTANTS: gc_wplace(2)     TYPE c VALUE 'vp',
           gc_view(2)       TYPE c VALUE 'vw'.

*----------------------------------------------------------------------*
* Control & Column Tree Definitionen
*----------------------------------------------------------------------*
DATA: g_launchpad_container TYPE REF TO cl_gui_custom_container,
      g_view_container      TYPE REF TO cl_gui_custom_container,
      g_launchpad_tree      TYPE REF TO cl_gui_column_tree,
      g_view_tree           TYPE REF TO cl_gui_column_tree,
      g_lpad_dd_tree        TYPE REF TO cl_dragdrop,
      g_view_dd_tree        TYPE REF TO cl_dragdrop.

DATA: g_handle_lpad         TYPE i,
      g_handle_view         TYPE i.


DATA: g_container_name_lp TYPE scrfname VALUE 'G_LAUNCHPAD_CONTAINER',
      g_container_name    TYPE scrfname VALUE 'G_VIEW_CONTAINER'.


*----------------------------------------------------------------------*
* Weitere Datendefinitionen für die Tree-Bearbeitung
*----------------------------------------------------------------------*
DATA: g_menu_req             LIKE off,
      g_dragdrop_req         LIKE off.

*----------------------------------------------------------------------*
* Sonstige globale Datendefinitionen
*----------------------------------------------------------------------*
DATA: g_place                TYPE nwplace,              " veraltet!!!
      g_place_old            TYPE nwplace,
      g_place_001            TYPE nwplace_001,
      g_vcode                TYPE ish_vcode,
      g_vcode_txt            TYPE ish_vcode,
      g_caller               TYPE sy-repid,
      g_buttons_in_launchpad TYPE ish_on_off VALUE on,
      g_place_txt            TYPE nwplacet-txt,         " veraltet!!!
      g_place_txt_old        TYPE nwplacet-txt,
      g_title_100(50)        TYPE c,
      g_title_200(50)        TYPE c,
      g_title_300(50)        TYPE c,
      g_first_time_100       LIKE off,
      g_first_time_200       LIKE off,
      g_first_time_300       LIKE off,
      g_first_time_subscreen LIKE off,
*      g_first_time_warning   LIKE off,
      g_error                LIKE off,
      g_sapstandard          TYPE nwplacesapstd,
      g_system_sap           LIKE off,
      g_subscreen_changed    LIKE off,
      g_sub_pgm              LIKE sy-cprog,
      g_sub_dynnr            LIKE sy-dynnr,
      g_save_ok_code         LIKE ok-code,
      g_save_ok_code_300     LIKE ok-code,
      g_yn(2)                TYPE c.


* Daten für 'Popup Bez. Arb.umf./Sicht-Zuordnung ändern (Dynpro 300)
DATA: s300                   TYPE v_nwpvz.       " veraltet!!!
DATA: g300_viewtxt           TYPE nwviewt-txt.   " veraltet !!!



*----------------------------------------------------------------------*
* Klassendefinitionen und -implementationen
*----------------------------------------------------------------------*
*
*---------------------------------------------------------------------*
*       CLASS lcl_view_event DEFINITION
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*

CLASS lcl_view_event DEFINITION.                            "#EC *

  PUBLIC SECTION.
    CLASS-METHODS:
      handle_item_button_click
        FOR EVENT button_click
        OF cl_gui_column_tree
        IMPORTING node_key item_name sender,                "#EC NEEDED
      handle_item_link_click
        FOR EVENT link_click
        OF cl_gui_column_tree
        IMPORTING node_key item_name sender,                "#EC NEEDED
      handle_item_double_click
        FOR EVENT item_double_click
        OF cl_gui_column_tree
        IMPORTING node_key item_name sender,                "#EC NEEDED
      handle_node_context_menu_req
        FOR EVENT node_context_menu_request
        OF cl_gui_column_tree
        IMPORTING node_key menu,                            "#EC NEEDED
      handle_node_context_menu_sel
        FOR EVENT node_context_menu_select
        OF cl_gui_column_tree
        IMPORTING node_key fcode.                           "#EC NEEDED

ENDCLASS.                    "lcl_view_event DEFINITION

*---------------------------------------------------------------------*
*       CLASS lcl_view_event IMPLEMENTATION
*---------------------------------------------------------------------*
*       ........                                                      *
*---------------------------------------------------------------------*
CLASS lcl_view_event IMPLEMENTATION.

* button click on item in the view list
  METHOD handle_item_button_click.
    CASE node_key(2).
*     launchpad-place
      WHEN gc_wplace.
*     launchpad-view
      WHEN gc_view.
*       change place/view zuo
        PERFORM call_zuo_popup USING node_key.
*     viewlist-viewtype
      WHEN gc_viewtype.
*     viewlist-view
      WHEN gc_viewid.
*       view update
        PERFORM call_view_update USING node_key.
*       refreshing the viewlist & launchpad
        PERFORM build_launchpad_nodes USING on.
        PERFORM build_view_list_nodes USING on.
    ENDCASE.
  ENDMETHOD.                    "handle_item_button_click

* link click on item in the view list
  METHOD handle_item_link_click.
    CASE node_key(2).
*     launchpad-place
      WHEN gc_wplace.
*     launchpad-view
      WHEN gc_view.
*       change place/view zuo
        PERFORM call_zuo_popup USING node_key.
*     viewlist-viewtype
      WHEN gc_viewtype.
*     viewlist-view
      WHEN gc_viewid.
*       view update
        PERFORM call_view_update USING node_key.
*       refreshing the viewlist & launchpad
        PERFORM build_launchpad_nodes USING on.
        PERFORM build_view_list_nodes USING on.
    ENDCASE.
  ENDMETHOD.                    "handle_item_link_click

* double click on item in the view list
  METHOD handle_item_double_click.
    CASE node_key(2).
*     launchpad-place
      WHEN gc_wplace.
*     launchpad-view
      WHEN gc_view.
*       change place/view zuo
        PERFORM call_zuo_popup USING node_key.
*     viewlist-viewtype
      WHEN gc_viewtype.
*       view insert
        PERFORM call_view_insert USING node_key on.
*     viewlist-view
      WHEN gc_viewid.
*       view update
        PERFORM call_view_update USING node_key.
*       refreshing the viewlist & launchpad
        PERFORM build_launchpad_nodes USING on.
        PERFORM build_view_list_nodes USING on.
    ENDCASE.
  ENDMETHOD.                    "handle_item_double_click

* building up the context menu with functions
  METHOD handle_node_context_menu_req.
    g_menu_req = on.
    CASE node_key(2).
*     context functions for launchpad-place
      WHEN gc_wplace.
*     context functions for launchpad-view
      WHEN gc_view.
*       where-used-list
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-038
            fcode = 'VWUL'.
*       change place/view zuo
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-010
            fcode = 'ZUPD'.
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-014
            fcode = 'VUPD'.
        CALL METHOD menu->add_separator.
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-018
            fcode = 'VOFL'.
*     context functions for viewlist-viewtype
      WHEN gc_viewtype.
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-013
            fcode = 'VINS'.
*     context functions for viewlist-view
      WHEN gc_viewid.
*       where-used-list
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-038
            fcode = 'VWUL'.
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-014
            fcode = 'VUPD'.
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-015
            fcode = 'VDEL'.
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-028
            fcode = 'VCOP'.
        CALL METHOD menu->add_separator.
        CALL METHOD menu->add_function
          EXPORTING
            text  = text-017
            fcode = 'VTOL'.
    ENDCASE.
  ENDMETHOD.                    "handle_node_context_menu_req

* call functions (fcode) of the view management for a certain view
  METHOD  handle_node_context_menu_sel.

    DATA: l_v_nwpvz           TYPE v_nwpvz,
          l_v_nwview          TYPE v_nwview,
          l_sortid            TYPE nwpvz-sortid,
          l_tab_index         TYPE sy-tabix,
          lt_nwpvz_dd         TYPE TABLE OF v_nwpvz,
          lt_nodes            TYPE lvc_t_nkey,
          l_node              TYPE lvc_nkey.

    CASE node_key(2).
*     context functions for launchpad-place
      WHEN gc_wplace.
*     context functions for launchpad-view
      WHEN gc_view.
        CASE fcode.
*         Where-Used-List
          WHEN 'VWUL'.
            PERFORM call_where_used_list USING node_key.
          WHEN 'ZUPD'.
*           change place/view zuo
            PERFORM call_zuo_popup USING node_key.
*           refreshing the launchpad
            PERFORM build_launchpad_nodes USING on.
          WHEN 'VUPD'.
*           view update
            PERFORM call_view_update USING node_key.
*           refreshing the viewlist & launchpad
            PERFORM build_launchpad_nodes USING on.
            PERFORM build_view_list_nodes USING on.
          WHEN 'VOFL'.
*           remove view from launchpad
            CLEAR: l_sortid, l_v_nwpvz.
            REFRESH: lt_nwpvz_dd.
*           only views (not workplace) can be removed
            IF node_key(2) = gc_view.
*             get all selected nodes
              PERFORM get_sel_nodes_launchpad CHANGING lt_nodes.
              LOOP AT lt_nodes INTO l_node.
                CHECK l_node(2) <> gc_view.
                DELETE TABLE lt_nodes FROM l_node.
              ENDLOOP.
*             get data of the view(s) to be removed
              DESCRIBE TABLE lt_nodes.
              IF sy-tfill > 1.
                LOOP AT lt_nodes INTO l_node.
                  l_tab_index = l_node+2(10).
                  READ TABLE gt_nwpvz_lp INTO l_v_nwpvz
                                         INDEX l_tab_index.
                  APPEND l_v_nwpvz TO lt_nwpvz_dd.
                ENDLOOP.
              ELSE.
                l_tab_index = node_key+2(10).
                READ TABLE gt_nwpvz_lp INTO l_v_nwpvz INDEX l_tab_index.
                APPEND l_v_nwpvz TO lt_nwpvz_dd.
              ENDIF.
              PERFORM insert_view_to_view_tree TABLES lt_nwpvz_dd.
*             refreshing viewlist and launchpad
              PERFORM build_launchpad_nodes USING on.
              PERFORM build_view_list_nodes USING on.
            ENDIF.
        ENDCASE.
*     context functions for viewlist-viewtype
      WHEN gc_viewtype.
        CASE fcode.
          WHEN 'VINS'.
*           view insert
            PERFORM call_view_insert USING node_key on.
*           refreshing the viewlist
            PERFORM build_view_list_nodes USING on.
        ENDCASE.
*     context functions for viewlist-view
      WHEN gc_viewid.
        CASE fcode.
*         Where-Used-List
          WHEN 'VWUL'.
            PERFORM call_where_used_list USING node_key.
          WHEN 'VUPD'.
*           view update
            PERFORM call_view_update USING node_key.
*           refreshing the viewlist
            PERFORM build_view_list_nodes USING on.
          WHEN 'VDEL'.
*           view delete
            PERFORM call_view_delete USING node_key.
          WHEN 'VCOP'.
*           view copy
            PERFORM call_view_copy USING node_key.
*           refreshing the viewlist
            PERFORM build_view_list_nodes USING on.
          WHEN 'VTOL'.
*           add view to launchpad (at last position)
            CLEAR: l_sortid, l_v_nwpvz.
            REFRESH: lt_nwpvz_dd, lt_nodes.
*           only views (not viewtypes) can be added
            IF node_key(2) = gc_viewid.
*             get all selected nodes
              PERFORM get_sel_nodes_view_tree CHANGING lt_nodes.
              LOOP AT lt_nodes INTO l_node.
                CHECK l_node(2) <> gc_viewid.
                DELETE TABLE lt_nodes FROM l_node.
              ENDLOOP.
*             get last sortid
              LOOP AT gt_nwpvz_lp INTO l_v_nwpvz.
                IF l_v_nwpvz-sortid > l_sortid.
                  l_sortid = l_v_nwpvz-sortid.
                ENDIF.
              ENDLOOP.
              l_sortid = l_sortid + 1.
*             get data of the view(s) to be added
              DESCRIBE TABLE lt_nodes.
              IF sy-tfill > 1.
                LOOP AT lt_nodes INTO l_node.
                  l_tab_index = l_node+2(10).
                  READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
                  CLEAR l_v_nwpvz.
                  MOVE-CORRESPONDING rn1_scr_wpl101 TO l_v_nwpvz."#EC ENHOK
                  MOVE-CORRESPONDING l_v_nwview TO l_v_nwpvz."#EC ENHOK
                  l_v_nwpvz-sortid = l_sortid.
                  APPEND l_v_nwpvz TO lt_nwpvz_dd.
                  l_sortid = l_sortid + 1.
                ENDLOOP.
              ELSE.
                l_tab_index = node_key+2(10).
                READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
                CLEAR l_v_nwpvz.
                MOVE-CORRESPONDING rn1_scr_wpl101 TO l_v_nwpvz."#EC ENHOK
                MOVE-CORRESPONDING l_v_nwview     TO l_v_nwpvz."#EC ENHOK
                l_v_nwpvz-sortid = l_sortid.
                APPEND l_v_nwpvz TO lt_nwpvz_dd.
              ENDIF.
              PERFORM insert_view_to_launchpad TABLES lt_nwpvz_dd.
*             refreshing viewlist and launchpad
              PERFORM build_launchpad_nodes USING on.
              PERFORM build_view_list_nodes USING on.
            ENDIF.
        ENDCASE.
    ENDCASE.
    g_menu_req = off.
  ENDMETHOD.                    "handle_node_context_menu_sel

ENDCLASS.                    "lcl_view_event IMPLEMENTATION

*---------------------------------------------------------------------*
*       CLASS lcl_drag_object DEFINITION
*---------------------------------------------------------------------*
*       Definition of Data Container for Drag & Drop
*---------------------------------------------------------------------*
CLASS lcl_drag_object DEFINITION.                           "#EC *
  PUBLIC SECTION.
    DATA: text TYPE treev_ntab.
ENDCLASS.                    "lcl_drag_object DEFINITION

*---------------------------------------------------------------------*
*       CLASS lcl_dragdrop_receiver DEFINITION
*---------------------------------------------------------------------*
*       Methods for Tree events raised by the drag and drop control
*---------------------------------------------------------------------*
CLASS lcl_dragdrop_receiver DEFINITION.                     "#EC *

  PUBLIC SECTION.

    CLASS-METHODS:
      view_tree_drag FOR EVENT on_drag_multiple OF cl_gui_column_tree
                     IMPORTING node_key_table drag_drop_object,
      launchpad_drag FOR EVENT on_drag_multiple OF cl_gui_column_tree
                     IMPORTING node_key_table drag_drop_object,
      view_tree_drop FOR EVENT on_drop OF cl_gui_column_tree
                     IMPORTING node_key drag_drop_object,
      launchpad_drop FOR EVENT on_drop OF cl_gui_column_tree
                     IMPORTING node_key drag_drop_object.

ENDCLASS.                    "lcl_dragdrop_receiver DEFINITION
*---------------------------------------------------------------------*
*       CLASS lcl_dragdrop_receiver IMPLEMENTATION
*---------------------------------------------------------------------*
*       Methods for Tree events raised by the drag and drop control
*---------------------------------------------------------------------*
CLASS lcl_dragdrop_receiver IMPLEMENTATION.

  METHOD view_tree_drag.
    DATA: drag_object    TYPE REF TO lcl_drag_object,
          node_key       TYPE treev_node-node_key.
    CREATE OBJECT drag_object.
    LOOP AT node_key_table INTO node_key.
*     only views (no viewtypes) can be dragged
      IF node_key(2) = gc_viewtype.
        MESSAGE s381.
*       Es können nur einzelne Sichten verschoben werden
        CONTINUE.
      ENDIF.
      APPEND node_key TO drag_object->text.
    ENDLOOP.
    drag_drop_object->object = drag_object.
    g_dragdrop_req = on.
  ENDMETHOD.                    "view_tree_drag

  METHOD launchpad_drag.
    DATA: drag_object    TYPE REF TO lcl_drag_object,
          node_key       TYPE treev_node-node_key.
    CREATE OBJECT drag_object.
    LOOP AT node_key_table INTO node_key.
*     only views (no wplace) can be dragged
      IF node_key(2) = gc_wplace.
        MESSAGE s381.
*       Es können nur einzelne Sichten verschoben werden
        CONTINUE.
      ENDIF.
      APPEND node_key TO drag_object->text.
    ENDLOOP.
    drag_drop_object->object = drag_object.
    g_dragdrop_req = on.
  ENDMETHOD.                    "launchpad_drag

  METHOD view_tree_drop.
    DATA: drag_object         TYPE REF TO lcl_drag_object,
          xnode_key           TYPE treev_node-node_key,
          l_v_nwpvz           TYPE v_nwpvz,
          l_tab_index         TYPE sy-tabix,
          lt_nwpvz_dd         TYPE TABLE OF v_nwpvz.
    g_dragdrop_req = off.
    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
      drag_object ?= drag_drop_object->object.
*     Egal wohin in der View-List gedroppt wird, die Sicht wird immer
*     alphabetisch unter den entsprechenden Sichttypen eingeordnet
      CASE node_key(2).
        WHEN gc_viewtype OR gc_viewid.
*         get data of the view to be dropped after
          l_tab_index = node_key+2(10).
          READ TABLE gt_views INTO l_v_nwpvz INDEX l_tab_index.
        WHEN OTHERS.
          EXIT.
      ENDCASE.
      CLEAR lt_nwpvz_dd[].
*     LOOP ÜBER ZU DRAGGENDE OBJEKTE ------------------------- L O O P
      LOOP AT drag_object->text INTO xnode_key.
        CASE xnode_key(2).
*         launchpad-place
          WHEN gc_wplace.
            CONTINUE.              " --> Arbeitsumfeld nicht draggbar
*         launchpad-view
          WHEN gc_view.
*           Verschieben vom Launchpad in den Sichtvorrat
*           get data of the view to be dragged
            l_tab_index = xnode_key+2(10).
            READ TABLE gt_nwpvz_lp INTO l_v_nwpvz INDEX l_tab_index.
            APPEND l_v_nwpvz TO lt_nwpvz_dd.
          WHEN gc_viewtype OR gc_viewid.
*           Verschieben innerhalb Sichtvorrat nicht möglich
            CLEAR lt_nwpvz_dd[].
            EXIT.
          WHEN OTHERS.
            CLEAR lt_nwpvz_dd[].
            EXIT.
        ENDCASE.
      ENDLOOP.  " --------------------------------------- E N D L O O P
      DESCRIBE TABLE lt_nwpvz_dd.
      IF sy-tfill > 0.
        PERFORM insert_view_to_view_tree TABLES lt_nwpvz_dd.
*       refreshing viewlist and launchpad
        PERFORM build_launchpad_nodes USING on.
        PERFORM build_view_list_nodes USING on.
      ENDIF.
    ENDCATCH.
*   If anything went wrong this is the clean way of aborting the
*   drag and drop operation:
    IF sy-subrc <> 0.
      CALL METHOD drag_drop_object->abort.
    ENDIF.
  ENDMETHOD.                    "view_tree_drop

  METHOD launchpad_drop.
    DATA: drag_object         TYPE REF TO lcl_drag_object,
          xnode_key           TYPE treev_node-node_key,
          l_v_nwpvz           TYPE v_nwpvz,
          l_v_nwview          TYPE v_nwview,
          l_sortid            TYPE nwpvz-sortid,
          l_tab_index         TYPE sy-tabix,
          lt_nwpvz_dd         TYPE TABLE OF v_nwpvz.
    g_dragdrop_req = off.
    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
      drag_object ?= drag_drop_object->object.
*     Aktuellen Node holen auf den gedropped worden ist, um zu bestimmen
*     mit welchem SORTID die Sicht eingefügt werden soll
      CASE node_key(2).
*       launchpad-place
        WHEN gc_wplace.
          CLEAR l_sortid.           " --> Sicht an 1. Stelle einfügen
*       launchpad-view
        WHEN gc_view.
*         get data of the view to be dropped after
          l_tab_index = node_key+2(10).
          READ TABLE gt_nwpvz_lp INTO l_v_nwpvz INDEX l_tab_index.
          l_sortid = l_v_nwpvz-sortid.
        WHEN OTHERS.
          EXIT.
      ENDCASE.
      CLEAR lt_nwpvz_dd[].
*     LOOP ÜBER ZU DRAGGENDE OBJEKTE ------------------------- L O O P
      LOOP AT drag_object->text INTO xnode_key.
        l_sortid = l_sortid + 1.
        CASE xnode_key(2).
*         launchpad-place
          WHEN gc_wplace.
            CLEAR lt_nwpvz_dd[].
            EXIT.              " --> Arbeitsumfeld nicht draggbar
*         launchpad-view
          WHEN gc_view.
*           Verschieben im Launchpad selbst
*           Droppen auf sich selbst ist nicht erlaubt
            IF node_key = xnode_key.
              CLEAR lt_nwpvz_dd[].
              EXIT.
            ENDIF.
*           get data of the view to be dragged
            l_tab_index = xnode_key+2(10).
*           ID 16848: read other global table (because of place holder)
*            READ TABLE gt_nwpvz_lp INTO l_v_nwpvz INDEX l_tab_index.
            READ TABLE gt_nwpvz INTO l_v_nwpvz INDEX l_tab_index.
            l_v_nwpvz-sortid = l_sortid.
            APPEND l_v_nwpvz TO lt_nwpvz_dd.
          WHEN gc_viewtype.
            CLEAR lt_nwpvz_dd[].
            EXIT.              " --> Sichttyp nicht draggbar
          WHEN gc_viewid.
*           Verschieben vom Sichtvorrat ins Launchpad
*           get data of the view to be dragged
            l_tab_index = xnode_key+2(10).
            READ TABLE gt_views INTO l_v_nwview INDEX l_tab_index.
            CLEAR l_v_nwpvz.
            MOVE-CORRESPONDING rn1_scr_wpl101 TO l_v_nwpvz. "#EC ENHOK
            MOVE-CORRESPONDING l_v_nwview     TO l_v_nwpvz. "#EC ENHOK
            l_v_nwpvz-sortid = l_sortid.
            APPEND l_v_nwpvz TO lt_nwpvz_dd.
          WHEN OTHERS.
            CLEAR lt_nwpvz_dd[].
            EXIT.
        ENDCASE.
      ENDLOOP.  " --------------------------------------- E N D L O O P
      DESCRIBE TABLE lt_nwpvz_dd.
      IF sy-tfill > 0.
        PERFORM insert_view_to_launchpad TABLES lt_nwpvz_dd.
*       refreshing viewlist and launchpad
        PERFORM build_launchpad_nodes USING on.
        PERFORM build_view_list_nodes USING on.
      ENDIF.
    ENDCATCH.
*   If anything went wrong this is the clean way of aborting the
*   drag and drop operation:
    IF sy-subrc <> 0.
      CALL METHOD drag_drop_object->abort.
    ENDIF.
  ENDMETHOD.                    "launchpad_drop

ENDCLASS.                    "lcl_dragdrop_receiver IMPLEMENTATION
*
