*----------------------------------------------------------------------*
*   INCLUDE LN1FVARCL2                                                 *
*----------------------------------------------------------------------*
* Event-Handling für ToolBar (DEFINITION)
CLASS lcl_res_bar_event_receiver DEFINITION.

  PUBLIC SECTION.
*            Funktion selektiert
    METHODS: on_function_selected
               FOR EVENT function_selected OF cl_gui_toolbar
                 IMPORTING fcode,

*            DropDown gedrückt
             on_toolbar_dropdown
               FOR EVENT dropdown_clicked OF cl_gui_toolbar
                 IMPORTING fcode
                           posx
                           posy.

ENDCLASS.                    "lcl_res_bar_event_receiver DEFINITION

*----------------------------------------------------------------------
* IMPLEMENTATION
*----------------------------------------------------------------------
* Event-Handling für ToolBar (IMPLEMENTIERUNG)
CLASS lcl_res_bar_event_receiver IMPLEMENTATION.

* Funktion selektiert
  METHOD on_function_selected.
*   nicht implementiert
  ENDMETHOD.                    "on_function_selected

* DropDown gedrückt
  METHOD on_toolbar_dropdown.
    DATA: l_menu        TYPE REF TO cl_ctmenu,
          l_wa_edittree TYPE ty_edittree,
          l_buttonnr    LIKE l_wa_edittree-buttonnr,
          l_fcode       TYPE ui_func,
          l_icon        TYPE icon_d,
          l_buttxt      TYPE text40,
          l_flag        TYPE c.

    CREATE OBJECT l_menu.
    CLEAR l_flag.


*   strukt. Liste von edittree holen
    DATA: lt_node_struct TYPE tyt_edittree.

*   Strukturiertes Treeabbild holen um Menü aufbereiten zu können
    PERFORM get_edittree_struct_list CHANGING lt_node_struct.

    READ TABLE lt_node_struct INTO l_wa_edittree
                      WITH KEY fcode = fcode.

    l_buttonnr = l_wa_edittree-buttonnr.
    LOOP AT lt_node_struct INTO l_wa_edittree
                          WHERE buttonnr = l_buttonnr
                          AND   ( type = 'F'  OR
                                  type = 'Z' ).
      IF l_menu IS INITIAL.
        CREATE OBJECT l_menu.   " Menue-Objekt anlegen
      ENDIF.

      l_flag   = on.

*     Handelt es sich um einen Separator->dann weiter
      IF l_wa_edittree-type = 'Z'.
        CALL METHOD l_menu->add_separator.
        CONTINUE.
      ENDIF.

      l_fcode  = l_wa_edittree-fcode.
      l_icon   = l_wa_edittree-icon.
      l_buttxt = l_wa_edittree-txt.

*     Funktion adden
      CALL METHOD l_menu->add_function
        EXPORTING
          fcode = l_fcode
          text  = l_buttxt
          icon  = l_icon.
    ENDLOOP.
*    endif.   " IF SY-SUBRC = 0

*   Jetzt das Menü sichtbar machen
    IF l_flag = on.
      CALL METHOD g_result_bar->track_context_menu
        EXPORTING
          context_menu = l_menu
          posx         = posx
          posy         = posy
        EXCEPTIONS
          ctmenu_error = 1
          OTHERS       = 2.
      IF sy-subrc <> 0.
      ENDIF.
    ENDIF.
  ENDMETHOD.                    "on_toolbar_dropdown
ENDCLASS.                    "lcl_res_bar_event_receiver IMPLEMENTATION
