*----------------------------------------------------------------------*
***INCLUDE LN1FVARF01 .
*----------------------------------------------------------------------*

*----------------------------------------------------------------------*
* ID          : ZA001
* Autor/Datum : Zach Bernhard, 25.02.2008
* Beschreibung: EHP4-Verschalterung (ISHA-8251)
*----------------------------------------------------------------------*


*---------------------------------------------------------------------*
* Form FILL_EXCLTAB
* Auszuschließende FCodes
*----------------------------------------------------------------------*
FORM fill_excltab.
  CLEAR gt_ex_fkt.   REFRESH gt_ex_fkt.
  IF g_mode = 'D'.
    PERFORM append_excltab USING 'SAVE'.
  ENDIF.
  IF g_translation = on.
    PERFORM append_excltab USING 'INS_NODE'.
    PERFORM append_excltab USING 'INS_FUNC'.
    PERFORM append_excltab USING 'INS_SEP'.
    PERFORM append_excltab USING 'INS_CUST'.
    PERFORM append_excltab USING 'DEL'.
  ENDIF.
ENDFORM.                    " FILL_EXCLTAB

*---------------------------------------------------------------------*
* FORM APPEND_EXCLTAB
* Satz in EXCL_TAB einfügen, wenn noch nicht vorhanden
*---------------------------------------------------------------------*
FORM append_excltab USING l_function TYPE any.
  READ TABLE gt_ex_fkt WITH KEY function = l_function.
  IF sy-subrc <> 0.
    gt_ex_fkt-function = l_function.
    APPEND gt_ex_fkt.
  ENDIF.
ENDFORM.                               " APPEND_EXCLTAB

*---------------------------------------------------------------------
* Form MODIFY_SCREEN
*---------------------------------------------------------------------
FORM modify_screen.

  CASE sy-dynnr.
    WHEN '0100'.

      LOOP AT SCREEN.
*       Buttons en(dis)ablen
        IF screen-name = 'BUTTON_CHANGE' OR
           screen-name = 'BUTTON_NOCHANGE'.
          IF g_show_button_change = off.
            screen-input = false.
          ELSE.
            screen-input = true.
          ENDIF.
          MODIFY SCREEN.
        ENDIF.
*       Icon-Button en(dis)ablen
        IF screen-name = 'G_DYNPRO-ICON'.
          IF g_show_button_change = off OR g_translation = on.
            screen-input = false.
          ELSE.
            screen-input = true.
          ENDIF.
          MODIFY SCREEN.
        ENDIF.
*       CheckBox en(dis)ablen
        IF screen-name = 'G_DYNPRO-DBCLK'.
          IF g_show_dbclk = off OR g_translation = on.
            screen-input = false.
          ELSE.
            screen-input = true.
          ENDIF.
          MODIFY SCREEN.
        ENDIF.
*       DropDownListbox en(dis)ablen
        IF screen-name = 'G_DYNPRO-FKEY'.
          IF g_translation = on.
            screen-input = false.
          ELSE.
            screen-input = true.
          ENDIF.
          MODIFY SCREEN.
        ENDIF.

        IF g_edit_mode = on.
          IF g_cust_ins = off.
            IF screen-name = 'G_DYNPRO-FCODE'.
              screen-input = false.
              MODIFY SCREEN.
            ENDIF.
          ENDIF.
          IF screen-name = 'G_DYNPRO-TXT'.
            screen-input = true.
            MODIFY SCREEN.
          ENDIF.
          IF screen-name = 'G_DYNPRO-ICON'.
            screen-input = true.
            MODIFY SCREEN.
          ENDIF.
          IF screen-name = 'G_DYNPRO-ICON_Q'.
            screen-input = true.
            MODIFY SCREEN.
          ENDIF.
          IF screen-name = 'G_DYNPRO-FKEY'.                 " ID 10202
            IF g_translation = off.
              screen-input = true.
              MODIFY SCREEN.
            ENDIF.
          ENDIF.
        ELSE.
          IF screen-name = 'G_DYNPRO-FCODE'.
            screen-input = false.
            MODIFY SCREEN.
          ENDIF.
          IF screen-name = 'G_DYNPRO-TXT'.
            screen-input = false.
            MODIFY SCREEN.
          ENDIF.
          IF screen-name = 'G_DYNPRO-ICON'.
            screen-input = false.
            MODIFY SCREEN.
          ENDIF.
          IF screen-name = 'G_DYNPRO-ICON_Q'.
            screen-input = false.
            MODIFY SCREEN.
          ENDIF.
          IF screen-name = 'G_DYNPRO-FKEY'.                 " ID 10202
            screen-input = false.
            MODIFY SCREEN.
          ENDIF.
        ENDIF.

        IF g_edit_iconbutton = on.
          IF screen-name = 'G_DYNPRO-ICON' OR
             screen-name = 'G_DYNPRO-ICON_Q'.               " ID 11754
            screen-input = true.
            MODIFY SCREEN.
          ENDIF.
        ELSE.
          IF screen-name = 'G_DYNPRO-ICON' OR
             screen-name = 'G_DYNPRO-ICON_Q'.               " ID 11754
            screen-input = false.
            MODIFY SCREEN.
          ENDIF.
        ENDIF.
      ENDLOOP.

    WHEN '0200'.

      LOOP AT SCREEN.
*       Buttons en(dis)ablen
        IF screen-name = 'G_DYNPRO200-VIEWID' OR
           screen-name = 'NAME_TEXT'          OR
           screen-name = 'G_DYNPRO200-NAME'.
          screen-input  = false.
          screen-active = false.
          MODIFY SCREEN.
        ENDIF.
        IF ( screen-name = 'G_DYNPRO200-VIEWBEZ'  OR
             screen-name = '%#AUTOTEXT001'      ) AND
           g_dynpro200-viewbez IS INITIAL.
          screen-input  = false.
          screen-active = false.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.

  ENDCASE.

ENDFORM.                    "modify_screen

*---------------------------------------------------------------------*
* Form  GET_FCODES
* Lesen der FCodes eines gegebenen GUI-Status und extrahieren der
* dort verwendeten Funktionscodes
*----------------------------------------------------------------------*
FORM get_fcodes USING VALUE(p_program) LIKE trdir-name
                      VALUE(p_guistat) LIKE rsmpe_sta-code
                      pt_fcodes        TYPE ishmed_t_wp_func
                      pt_message       TYPE tyt_messages
                      p_rc             LIKE sy-subrc
                      p_init           TYPE c.

  DATA: lt_status  LIKE rsmpe_stat OCCURS 0 WITH HEADER LINE,
        lt_act     LIKE rsmpe_act  OCCURS 0 WITH HEADER LINE,
        lt_men     LIKE rsmpe_men  OCCURS 0 WITH HEADER LINE,
        lt_fun     LIKE rsmpe_funt OCCURS 0 WITH HEADER LINE,
        lt_mtx     LIKE rsmpe_mnlt OCCURS 0 WITH HEADER LINE,
        lt_but     LIKE rsmpe_but  OCCURS 0 WITH HEADER LINE,
        lt_pfk     LIKE rsmpe_pfk  OCCURS 0 WITH HEADER LINE,
        lt_set     LIKE rsmpe_staf OCCURS 0 WITH HEADER LINE,
        lt_doc     LIKE rsmpe_atrt OCCURS 0 WITH HEADER LINE,
        lt_tit     LIKE rsmpe_titt OCCURS 0 WITH HEADER LINE,
        l_wa_fcode TYPE rn1wp_func,
        l_wa_msg   TYPE ty_message.
  DATA: lt_tmp_fun     TYPE ishmed_t_wp_func WITH HEADER LINE.
  DATA: l_wa_tmp_fun   TYPE rn1wp_func.
  DATA: l_wa_fun       LIKE lt_fun.

* Initialisierungen
  IF p_init = 'I'.
    REFRESH pt_fcodes.
  ENDIF.
  p_rc = 1.
  CHECK NOT p_program IS INITIAL  AND
        NOT p_guistat IS INITIAL.

  CALL FUNCTION 'RS_CUA_INTERNAL_FETCH'
    EXPORTING
      program         = p_program
      language        = sy-langu
    TABLES
      sta             = lt_status
      fun             = lt_fun
      men             = lt_men
      mtx             = lt_mtx
      act             = lt_act
      but             = lt_but
      pfk             = lt_pfk
      set             = lt_set
      doc             = lt_doc
      tit             = lt_tit
    EXCEPTIONS
      not_found       = 1
      unknown_version = 2
      OTHERS          = 3.
  p_rc = sy-subrc.
  IF p_rc <> 0.
    EXIT.
  ENDIF.


* da RS_CUA_INTERNAL_FETCH die Struktur lt. lt_fun braucht
* das fun_text feld jedoch für unsere zwecke zu klein ist
* wird inhalt in eine hilfstabelle kopiert
  CLEAR l_wa_fun.
  REFRESH lt_tmp_fun.
  LOOP AT lt_fun INTO l_wa_fun.
    CLEAR l_wa_tmp_fun.
    l_wa_tmp_fun-code      = l_wa_fun-code.
    l_wa_tmp_fun-textno    = l_wa_fun-textno.
    l_wa_tmp_fun-type      = l_wa_fun-type.
    l_wa_tmp_fun-modif     = l_wa_fun-modif.
    l_wa_tmp_fun-text_type = l_wa_fun-text_type.
    l_wa_tmp_fun-text_name = l_wa_fun-text_name.
    l_wa_tmp_fun-icon_id   = l_wa_fun-icon_id.
    l_wa_tmp_fun-fun_text  = l_wa_fun-fun_text.
    l_wa_tmp_fun-icon_text = l_wa_fun-icon_text.
    l_wa_tmp_fun-info_text = l_wa_fun-info_text.
    l_wa_tmp_fun-path      = l_wa_fun-path.
    APPEND l_wa_tmp_fun TO lt_tmp_fun.
  ENDLOOP.


* Jetzt aus den gelesenen Menüs und den Drucktasten usw. die in
* diesem GUI-Status verwendeten Funktionscodes ableiten (nicht
* einfach die Funktionsliste nehmen, denn die beinhalten alle
* FCodes aller in diesem Programm enthaltenen GUI-Status, was
* hier unbrauchbar wäre)
  READ TABLE lt_status WITH KEY code = p_guistat.
  IF sy-subrc <> 0.
    p_rc = 1.
*   GUI-Status & konnte im Programm & nicht gefunden werden
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '246' p_guistat p_program space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO pt_message.
    EXIT.
  ENDIF.

* Zuerst die Menüs auswerten
  DELETE lt_act WHERE code <> lt_status-actcode.
  SORT lt_mtx BY code.
  LOOP AT lt_act.
    PERFORM read_menu TABLES lt_men lt_mtx
                      USING  lt_act-menucode
                             ''
                             pt_fcodes.
  ENDLOOP.

* Nun noch die Funktionscodes der Funktionstasten holen
  CLEAR l_wa_fcode.
  LOOP AT lt_pfk WHERE code = lt_status-pfkcode.
    l_wa_fcode-code   = lt_pfk-funcode.
    l_wa_fcode-textno = lt_pfk-funno.
    APPEND l_wa_fcode TO pt_fcodes.
  ENDLOOP.

* Jetzt sind alle FCodes gesammelt. Nun sortieren, doppelte
* löschen und die FCodes mit allen Attributen versehen
  SORT pt_fcodes BY code.
  DELETE ADJACENT DUPLICATES FROM pt_fcodes
                             COMPARING code.
  SORT lt_tmp_fun BY code textno.
  LOOP AT pt_fcodes INTO l_wa_fcode.
    READ TABLE lt_tmp_fun WITH KEY code   = l_wa_fcode-code
                               textno = l_wa_fcode-textno
                      BINARY SEARCH.
    IF sy-subrc <> 0.
      DELETE pt_fcodes.
      CONTINUE.
    ENDIF.
    IF NOT l_wa_fcode-fun_text IS INITIAL.
*      concatenate l_wa_fcode-fun_text '->' lt_tmp_fun-fun_text
*                  into lt_tmp_fun-fun_text.

    ENDIF.
    MODIFY pt_fcodes FROM lt_tmp_fun.
  ENDLOOP.
ENDFORM.                    " GET_FCODES

*---------------------------------------------------------------------
* Form READ_MENU
* Extrahieren aller Funktionscodes eines Menüs (inclusive aller
* Untermenüs)
*---------------------------------------------------------------------
FORM read_menu TABLES pt_men           STRUCTURE rsmpe_men
                      pt_mtx           STRUCTURE rsmpe_mnlt
               USING VALUE(p_code)     LIKE rsmpe_men-code
                     VALUE(p_menupath) TYPE any
                     pt_fcodes         TYPE ishmed_t_wp_func.

  DATA: l_menupath(70) TYPE c,
        l_wa_fcode     TYPE rn1wp_func.

  LOOP AT pt_men WHERE code = p_code.
*   Menütext holen
    READ TABLE pt_mtx WITH KEY code = p_code
                      BINARY SEARCH.
    IF sy-subrc = 0.
      IF p_menupath IS INITIAL.
        l_menupath = pt_mtx-text.
      ELSE.
        CONCATENATE p_menupath '->' pt_mtx-text INTO l_menupath.
      ENDIF.
    ELSE.
      l_menupath = p_menupath.
    ENDIF.

    CASE pt_men-ref_type.
      WHEN 'F'.
        l_wa_fcode-code     = pt_men-ref_code.
        l_wa_fcode-textno   = pt_men-ref_no.
        l_wa_fcode-fun_text = l_menupath.
        APPEND l_wa_fcode TO pt_fcodes.
      WHEN 'M'.
        PERFORM read_menu TABLES pt_men pt_mtx
                          USING pt_men-ref_code l_menupath pt_fcodes.
    ENDCASE.
  ENDLOOP.

ENDFORM.                                                    " READ_MENU

*---------------------------------------------------------------------*
* Form  INIT_ALL
* Initialisierung der gesamten Container, Trees usw.
*----------------------------------------------------------------------*
FORM init_all.

  DATA: l_rc           LIKE sy-subrc,
        l_wa_fcode     TYPE rn1wp_func,
        l_wa_functree  TYPE ty_functree,
        l_wa_edittree  TYPE ty_edittree,
        l_wa_nwbutton  TYPE ty_nwbutton,
        l_wa_nwfvarp   TYPE ty_nwfvarp,
        lt_node_struct TYPE tyt_edittree .

  IF g_first_time_100 = on.

*   Jetzt den Inhalt der Tabelle GT_EDITTREE bilden. In dieser
*   Tabelle stehen die Daten, die im EditTree zusammengestellt
*   wurden
    REFRESH gt_edittree.
    REFRESH gt_functree.
    g_show_button_change = off.
    g_edit_mode          = off.
    g_cust_ins           = off.                             " ID 11731
    CLEAR g_dynpro.
*   Mit den Drucktasten beginnen
    LOOP AT gt_nwbutton INTO l_wa_nwbutton.
      CLEAR l_wa_edittree.
      l_wa_edittree-buttonnr = l_wa_nwbutton-buttonnr.
      IF l_wa_nwbutton-fcode IS INITIAL.
        l_wa_edittree-type     = 'S'.   " FCode leer => Separator
        l_wa_edittree-icon     = l_wa_nwbutton-icon.
        APPEND l_wa_edittree TO gt_edittree.
        CONTINUE.
      ELSE.
        l_wa_edittree-type   = 'B'.   " Dies ist ein Button
      ENDIF.

      l_wa_edittree-fcode    = l_wa_nwbutton-fcode.
      l_wa_edittree-txt      = l_wa_nwbutton-buttontxt.
      l_wa_edittree-icon     = l_wa_nwbutton-icon.
      l_wa_edittree-icon_q   = l_wa_nwbutton-icon_q.
      l_wa_edittree-lfdnr     = 0.
      l_wa_edittree-dbclkinfo = l_wa_nwbutton-dbclk.
      l_wa_edittree-fkey     = l_wa_nwbutton-fkey.          " ID 10202
*     ID 10202: Funktionstastentext
      PERFORM get_domain_value_desc(sapmn1pa)
                               USING 'NFKEY' l_wa_nwbutton-fkey
                                             l_wa_edittree-fkeytxt.
      l_wa_edittree-tb_butt  = space.
      APPEND l_wa_edittree TO gt_edittree.
    ENDLOOP.

*   An den Drucktasten können diese Untermenüs hängen
*   Die jetzt in die Tabelle aufnehmen
    LOOP AT gt_edittree INTO l_wa_edittree
                        WHERE type = 'B'.
      LOOP AT gt_nwfvarp INTO l_wa_nwfvarp
                         WHERE buttonnr = l_wa_edittree-buttonnr.
        IF l_wa_nwfvarp-fcode IS INITIAL.
          CLEAR l_wa_edittree.

*         FCode leer => Separator. Im Unterschied zum Button
*         muss hier aber auch die lfdnr gesetzt werden, die
*         ja die Position innerhalb des Menüs festlegt
          l_wa_edittree-type     = 'Z'.
          l_wa_edittree-lfdnr     = l_wa_nwfvarp-lfdnr.
          l_wa_edittree-buttonnr = l_wa_nwfvarp-buttonnr.
          l_wa_edittree-icon     = icon_space.
          APPEND l_wa_edittree TO gt_edittree.
          CONTINUE.
        ENDIF.

        l_wa_edittree-type      = 'F'.   " Eine Funktion
        l_wa_edittree-fcode     = l_wa_nwfvarp-fcode.
        l_wa_edittree-txt       = l_wa_nwfvarp-txt.
        l_wa_edittree-icon      = space.
        l_wa_edittree-icon_q    = space.
        l_wa_edittree-lfdnr      = l_wa_nwfvarp-lfdnr.
        l_wa_edittree-dbclkinfo = l_wa_nwfvarp-dbclk.
        l_wa_edittree-tb_butt   = l_wa_nwfvarp-tb_butt.
        l_wa_edittree-fkey      = l_wa_nwfvarp-fkey.        " ID 10202
*       ID 10202: Funktionstastentext
        PERFORM get_domain_value_desc(sapmn1pa)
                                 USING 'NFKEY' l_wa_nwfvarp-fkey
                                               l_wa_edittree-fkeytxt.
        APPEND l_wa_edittree TO gt_edittree.
      ENDLOOP.
    ENDLOOP.

*   Sortierung nach Buttonnr und Lauf. Nummer aufsteigend
    SORT gt_edittree BY buttonnr lfdnr.

*   Die Tabelle GT_FUNCTREE bilden. Die FCodes, die dort angezeigt
*   werden entsprechen der Tabelle GT_FCODES minus den FCodes, die
*   schon in der Funktionsvariante verwendet werden
    LOOP AT gt_fcodes INTO l_wa_fcode.
      READ TABLE gt_edittree
                 INTO l_wa_edittree
                 WITH KEY fcode = l_wa_fcode-code.
      IF sy-subrc <> 0.
        CLEAR l_wa_functree.
        l_wa_functree-hierarchy = l_wa_fcode-fun_text.
        l_wa_functree-text      = l_wa_fcode-code.
        l_wa_functree-icon_id   = l_wa_fcode-icon_id.
        l_wa_functree-icon_text = l_wa_fcode-icon_text.
        APPEND l_wa_functree TO gt_functree.
      ENDIF.
    ENDLOOP.   " LOOP AT GT_FCODES

    CREATE OBJECT g_main_cust_container
      EXPORTING
        container_name              = 'MAINCONTAINER'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    l_rc = sy-subrc.
    IF l_rc <> 0.
    ENDIF.

    CREATE OBJECT g_splitter_main_cont
      EXPORTING
        metric            = '1'
        parent            = g_main_cust_container
        rows              = 2
        columns           = 1
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
*
    CALL METHOD g_splitter_main_cont->set_row_height
      EXPORTING
        id                = 1
        height            = 5
*     IMPORTING
*       RESULT            =
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

    CALL METHOD g_splitter_main_cont->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = g_splitter_main_cont_top.

    CALL METHOD g_splitter_main_cont->get_container
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = g_splitter_main_cont_bottom.

    CREATE OBJECT g_splitter_child_cont
      EXPORTING
        parent            = g_splitter_main_cont_bottom
        rows              = 1
        columns           = 2
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.
*
    CALL METHOD g_splitter_child_cont->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = g_splitter_child_cont_left.

    CALL METHOD g_splitter_child_cont->get_container
      EXPORTING
        row       = 1
        column    = 2
      RECEIVING
        container = g_splitter_child_cont_right.

    CALL METHOD g_splitter_child_cont->set_column_width
      EXPORTING
        id                = 1
        width             = 62
*     IMPORTING
*       RESULT            =
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

*   Den Funktionstree aufbauen
    CREATE OBJECT g_func_tree
      EXPORTING
*       PARENT                      = g_tree_cont
        parent                      = g_splitter_child_cont_right
        node_selection_mode         =
                                      cl_gui_column_tree=>node_sel_mode_multiple
        item_selection              = on
        no_toolbar                  = on
        no_html_header              = on
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        illegal_node_selection_mode = 5
        failed                      = 6
        illegal_column_name         = 7
        OTHERS                      = 8.
    l_rc = sy-subrc.
    IF l_rc <> 0.
*     Fehler & beim Anlegen des Controls & (Programm &)
      MESSAGE x247 WITH l_rc 'G_FUNC_TREE' 'LN1FVARF01'.
    ENDIF.

    CREATE OBJECT g_edit_tree
      EXPORTING
*       PARENT                      = g_edit_cont
        parent                      = g_splitter_child_cont_left
        node_selection_mode         =
                                      cl_gui_column_tree=>node_sel_mode_multiple
        item_selection              = on
        no_toolbar                  = on
        no_html_header              = on
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        illegal_node_selection_mode = 5
        failed                      = 6
        illegal_column_name         = 7
        OTHERS                      = 8.
    l_rc = sy-subrc.
    IF l_rc <> 0.
*     Fehler & beim Anlegen des Controls & (Programm &)
      MESSAGE x247 WITH l_rc 'G_EDIT_TREE' 'LN1FVARF01'.
    ENDIF.

*   Den Toolbar anlegen
    CREATE OBJECT g_result_bar
      EXPORTING
*       PARENT             = g_result_bar_cont
        parent             = g_splitter_main_cont_top
        shellstyle         = ws_visible
      EXCEPTIONS
        cntl_install_error = 1
        cntl_error         = 2
        OTHERS             = 3.
    l_rc = sy-subrc.
    IF l_rc <> 0.
*     Fehler & beim Anlegen des Controls & (Programm &)
      MESSAGE i247 WITH l_rc 'G_EDIT_CONT' 'LN1FVARF01'.
    ENDIF.

*   Definition of drag drop behaviour for edit_tree
    IF g_translation = ' '.                                 "MED-32254
      CREATE OBJECT behaviour_edit_tree.
      CALL METHOD behaviour_edit_tree->add
        EXPORTING
          flavor         = 'drag_move'
          dragsrc        = 'X'
          droptarget     = 'X'
          effect         = cl_dragdrop=>copy
          effect_in_ctrl = cl_dragdrop=>copy.
      CALL METHOD behaviour_edit_tree->get_handle
        IMPORTING
          handle = handle_edit_tree.
    ENDIF.                                                  "MED-32254

*   -----------------------------------------------
*   Den rechten Tree mit den gefundenen Funktionscodes befüllen
    PERFORM init_func_tree USING gt_functree l_rc.
    IF l_rc <> 0.
      SET SCREEN 0.   LEAVE SCREEN.
    ENDIF.

*   Den Edit-Tree (links, im Dynpro) befüllen
    PERFORM init_edit_tree USING gt_edittree l_rc.
    IF l_rc <> 0.
      SET SCREEN 0.   LEAVE SCREEN.
    ENDIF.

*   Den Toolbar nun mit Werten versorgen
*   strukt. Liste von edittree holen
    PERFORM get_edittree_struct_list CHANGING lt_node_struct.

*   Den Toolbar nun mit Werten versorgen
    PERFORM set_result_bar USING lt_node_struct
                                 g_result_bar.

*   registration of drag and drop events
    IF g_translation = ' '.                                 "MED-32254
      CREATE OBJECT dragdrop.
      SET HANDLER dragdrop->edit_tree_drag FOR g_edit_tree.
      SET HANDLER dragdrop->edit_tree_drop FOR g_edit_tree.
      SET HANDLER dragdrop->edit_tree_drop_complete FOR g_edit_tree.
    ENDIF.                                                  "MED-32254

    CALL METHOD cl_gui_cfw=>flush.

  ENDIF.
  g_first_time_100 = off.

  CALL METHOD cl_gui_cfw=>flush.

ENDFORM.                                                    " INIT_ALL

*--------------------------------------------------------------------
* Form INIT_FUNC_TREE
* Initialisierung des Function-Tree"s (rechts)
*--------------------------------------------------------------------
FORM init_func_tree USING pt_functree TYPE tyt_functree
                          p_rc        LIKE sy-subrc.

  DATA: l_hier_header TYPE        treev_hhdr,
        lt_fieldcat   TYPE        lvc_t_fcat,
        l_wa_functree TYPE        ty_functree,
        l_wa_itemlay  TYPE        lvc_s_layi,
        lt_itemlay    TYPE        lvc_t_layi,
        l_node_lay    TYPE        lvc_s_layn,
        lt_functree   TYPE        tyt_functree,
        l_variant     TYPE        disvariant,
        l_node_text   TYPE        lvc_value,
        l_node_key    TYPE        lvc_nkey,
        l_wa_ev       TYPE        cntl_simple_event,
        lt_events     TYPE        cntl_simple_events,
        l_ev_receiver TYPE REF TO lcl_functree_event_receiver.
*        l_x           TYPE i.

  p_rc = 0.

* Den Feldkatalog bilden
  PERFORM build_fieldcat_functree USING lt_fieldcat.

* Den Header für die Hierarchiespalte bilden
  CLEAR l_hier_header.
  l_hier_header-heading   = 'Funktionstext'(004).
  l_hier_header-tooltip   = 'Auswählbare Funktionscodes'(002).
*  loop at pt_functree into l_wa_functree.
*    l_x = strlen( l_wa_functree-hierarchy ).
*    if l_x > l_hier_header-width.
*      l_hier_header-width = l_x.
*    endif.
*  endloop.
  l_hier_header-width = 45.

* Das leere Treecontrol anlegen
  CLEAR l_variant.
  l_variant-report = sy-repid.
* Achtung: Die Tabelle wird von der folgenden Methode gelöscht!
* Deshalb hier wegsichern.
* Achtung: Durch die Methode "ADD_NODE" werden die Daten der
* Workarea in die hier angegebene globale Tabelle PT_FUNCTREE
* insertiert, d.h. PT_FUNCTREE muss bis zum Aufruf von ADD_NODE
* unbedingt leer bleiben (sonst Endlosschleife!)
  lt_functree[] = pt_functree[].
  REFRESH pt_functree.

  CALL METHOD g_func_tree->set_table_for_first_display
    EXPORTING
*     I_STRUCTURE_NAME    =
      is_variant          = l_variant
      i_save              = 'A'
*     I_DEFAULT           = 'X'
      is_hierarchy_header = l_hier_header
      i_background_id     = 'ALV_BACKGROUND'
    CHANGING
      it_outtab           = pt_functree
      it_fieldcatalog     = lt_fieldcat.


* Die Events nun registrieren
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_expand_no_children.
  APPEND l_wa_ev TO lt_events.
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_checkbox_change.
  APPEND l_wa_ev TO lt_events.
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_item_keypress.
  APPEND l_wa_ev TO lt_events.
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_node_context_menu_req.
  APPEND l_wa_ev TO lt_events.
*  l_wa_ev-eventid = cl_gui_column_tree=>EVENTID_ITEM_CONTEXT_MENU_REQ.
*  append l_wa_ev to lt_events.

*  call method g_func_tree->SET_CTX_MENU_SELECT_EVENT_APPL
*      exporting I_appl_event = 'X'.

  CALL METHOD g_func_tree->set_registered_events
    EXPORTING
      events                    = lt_events
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3
      OTHERS                    = 4.
  p_rc = sy-subrc.
  IF p_rc <> 0.
    SET SCREEN 0.   LEAVE SCREEN.
  ENDIF.

* EVENTRECEIVER
  CREATE OBJECT l_ev_receiver.
  SET HANDLER l_ev_receiver->handle_item_double_click
              FOR g_func_tree.
  SET HANDLER l_ev_receiver->handle_button_click
              FOR g_func_tree.
  SET HANDLER l_ev_receiver->handle_link_click
              FOR g_func_tree.
  SET HANDLER l_ev_receiver->handle_node_ctmenu_request
              FOR g_func_tree.
*  set handler l_ev_receiver->handle_item_ctmenu_request
*              for g_func_tree.
  SET HANDLER l_ev_receiver->handle_node_ctmenu_selected
              FOR g_func_tree.
*  set handler l_ev_receiver->handle_item_ctmenu_selected
*              for g_func_tree.


* Nun die Daten in den Tree einfügen
  CLEAR l_node_key.
  SORT lt_functree BY hierarchy.
  LOOP AT lt_functree INTO l_wa_functree.
*   Der erste Eintrag wurde schon bearbeitet => überspringen
*    check sy-tabix > 1.

    REFRESH lt_itemlay.
    CLEAR l_wa_itemlay.
    l_wa_itemlay-fieldname = g_func_tree->c_hierarchy_column_name.
    l_wa_itemlay-class     = cl_gui_column_tree=>item_class_text.
    l_wa_itemlay-editable  = off.
    APPEND l_wa_itemlay TO lt_itemlay.
    CLEAR l_wa_itemlay.
    l_wa_itemlay-fieldname = co_functree_text.
    l_wa_itemlay-class     = cl_gui_column_tree=>item_class_text.
*    l_wa_itemlay-t_image   = l_wa_functree-icon_id.
    APPEND l_wa_itemlay TO lt_itemlay.

    l_node_text = l_wa_functree-hierarchy.
    CLEAR l_node_lay.
    l_node_lay-isfolder  = off.
    l_node_lay-no_branch = on.

*   ID 6148, 18.9.00
    IF l_wa_functree-icon_id = ''.
      l_wa_functree-icon_id = icon_space.
    ENDIF.

    l_node_lay-n_image = l_wa_functree-icon_id.
    l_wa_functree-icon_id = icon_space.

*    l_node_lay-dragdropid = handle_func_tree.

    CALL METHOD g_func_tree->add_node
      EXPORTING
        i_relat_node_key     = l_node_key
        i_relationship       = cl_gui_column_tree=>relat_last_child
        is_outtab_line       = l_wa_functree
        is_node_layout       = l_node_lay
        it_item_layout       = lt_itemlay
        i_node_text          = l_node_text
*      IMPORTING
*       E_NEW_NODE_KEY       =
      EXCEPTIONS
        relat_node_not_found = 1
        node_not_found       = 2
        OTHERS               = 3.
    p_rc = sy-subrc.
    IF p_rc <> 0.
      SET SCREEN 0.   LEAVE SCREEN.
    ENDIF.
  ENDLOOP.   " LOOP AT LT_FUNCTREE

* Die Daten zum Frontend schicken
  CALL METHOD g_func_tree->frontend_update.

* Die Spaltenbreiten nun optimieren
*  CALL METHOD G_FUNC_TREE->COLUMN_OPTIMIZE
*    EXCEPTIONS
*      others                 = 3.

ENDFORM.   " INIT_FUNC_TREE

*--------------------------------------------------------------------
* Form BUILD_FIELDCAT_FUNCTREE
* Zusammenstellen des Feldkatalogs für den Funktions-Tree
*--------------------------------------------------------------------
FORM build_fieldcat_functree USING pt_fieldcat TYPE lvc_t_fcat.

  DATA: l_wa_fieldcat TYPE lvc_s_fcat.

* Feldkatalog (d.h. die Spalten für den Tree) bilden
* (Das hat aber noch nichts mit dem Inhalt der Spalten zu tun!)
  REFRESH pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_functree_text.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 1.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-reptext   = 'Funktionscode'(001).
  l_wa_fieldcat-outputlen = 50.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_functree_icon.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 2.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-outputlen = 10.
  l_wa_fieldcat-tech      = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_functree_icon_text.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 3.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-outputlen = 30.
  l_wa_fieldcat-tech      = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

*  clear l_wa_fieldcat.
*  l_wa_fieldcat-fieldname = co_functree_hierarchy.
*  l_wa_fieldcat-tabname   = 1.
*  l_wa_fieldcat-col_pos   = 4.
*  l_wa_fieldcat-key       = off.
*  l_wa_fieldcat-reptext   = 'Funktionscode'(005).
*  l_wa_fieldcat-outputlen = 30.
*  l_wa_fieldcat-tech      = off.
*  append l_wa_fieldcat to pt_fieldcat.

ENDFORM.   " BUILD_FIELDCAT_FUNCTREE

*--------------------------------------------------------------------
* Form INIT_EDIT_TREE
* Initialisierung des Edit-Tree"s (links, im Dynpro)
*--------------------------------------------------------------------
FORM init_edit_tree USING pt_edittree TYPE tyt_edittree
                          p_rc        LIKE sy-subrc.
  DATA: l_hier_header TYPE        treev_hhdr,
        lt_fieldcat   TYPE        lvc_t_fcat,
*        l_wa_itemlay  TYPE lvc_s_layi,
*        lt_itemlay    TYPE lvc_t_layi,
*        l_node_lay    TYPE lvc_s_layn,
        lt_edittree   TYPE        tyt_edittree,
*        l_wa_edittree TYPE ty_edittree,
        l_variant     TYPE        disvariant,
*        l_node_text   TYPE lvc_value,
        l_root_key    TYPE        lvc_nkey,
        l_wa_ev       TYPE        cntl_simple_event,
        lt_events     TYPE        cntl_simple_events,
        l_ev_receiver TYPE REF TO lcl_edittree_event_receiver.

  p_rc = 0.

* Den Feldkatalog bilden
  PERFORM build_fieldcat_edittree USING lt_fieldcat.

* Den Header für die Hierarchiespalte bilden
  CLEAR l_hier_header.
  l_hier_header-heading = 'Funktion'(009).
  l_hier_header-tooltip = 'Tasten, Funktionen usw.'(010).
  l_hier_header-width   = 40.

* Das leere Treecontrol anlegen
  CLEAR l_variant.
  l_variant-report = sy-repid.
* Achtung: Die Tabelle wird von der folgenden Methode gelöscht!
* Deshalb hier wegsichern.
* Achtung: Durch die Methode "ADD_NODE" werden die Daten der
* Workarea in die hier angegebene globale Tabelle PT_EDITTREE
* insertiert, d.h. PT_EDITTREE muss bis zum Aufruf von ADD_NODE
* unbedingt leer bleiben (sonst Endlosschleife!)
  lt_edittree[] = pt_edittree[].
  REFRESH pt_edittree.
  CALL METHOD g_edit_tree->set_table_for_first_display
    EXPORTING
*     I_STRUCTURE_NAME    =
      is_variant          = l_variant
      i_save              = 'A'
*     I_DEFAULT           = 'X'
      is_hierarchy_header = l_hier_header
      i_background_id     = 'ALV_BACKGROUND'
    CHANGING
      it_outtab           = pt_edittree
      it_fieldcatalog     = lt_fieldcat.

* Die Events nun registrieren
  REFRESH lt_events.
  CLEAR l_wa_ev.
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_expand_no_children.
  APPEND l_wa_ev TO lt_events.
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_checkbox_change.
  APPEND l_wa_ev TO lt_events.
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_item_double_click.
  APPEND l_wa_ev TO lt_events.
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_node_double_click.
  APPEND l_wa_ev TO lt_events.
  l_wa_ev-eventid = cl_gui_column_tree=>eventid_node_context_menu_req.
  APPEND l_wa_ev TO lt_events.

  CALL METHOD g_edit_tree->set_registered_events
    EXPORTING
      events                    = lt_events
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3
      OTHERS                    = 4.
  p_rc = sy-subrc.
  IF p_rc <> 0.
    SET SCREEN 0.   LEAVE SCREEN.
  ENDIF.

  CREATE OBJECT l_ev_receiver.
  SET HANDLER l_ev_receiver->handle_expand_no_children
              FOR g_edit_tree.
  SET HANDLER l_ev_receiver->handle_checkbox_change
              FOR g_edit_tree.
  SET HANDLER l_ev_receiver->handle_item_double_click
             FOR g_edit_tree.
  SET HANDLER l_ev_receiver->handle_node_double_click
               FOR g_edit_tree.
  SET HANDLER l_ev_receiver->handle_node_ctmenu_request
              FOR g_edit_tree.
  SET HANDLER l_ev_receiver->handle_node_ctmenu_selected
              FOR g_edit_tree.

* Nun die Daten in den Tree einfügen
  PERFORM build_edittree USING g_edit_tree lt_edittree
                               l_root_key p_rc.

* alles expanden
  CALL METHOD g_edit_tree->expand_node
    EXPORTING
      i_node_key       = l_root_key
      i_level_count    = 99
      i_expand_subtree = 'X'
    EXCEPTIONS
      OTHERS           = 1.

* Die Daten zum Frontend schicken
  CALL METHOD g_edit_tree->frontend_update.

* Die Spaltenbreiten nun optimieren (Das darf erst NACH Aufruf
* der Methode FRONTEND_UPDATE passieren!)
*  CALL METHOD G_EDIT_TREE->COLUMN_OPTIMIZE
*     EXCEPTIONS
*       others                 = 1.
ENDFORM.   " INIT_EDIT_TREE

*---------------------------------------------------------------------
* Form BUILD_EDITTREE
* Den Edit-Tree mit Daten füllen
*---------------------------------------------------------------------
FORM build_edittree USING p_edit_tree TYPE REF TO cl_gui_alv_tree
                          pt_edittree TYPE tyt_edittree
                          p_root_key  TYPE lvc_nkey
                          p_rc        LIKE sy-subrc.
  DATA: lt_itemlay    TYPE lvc_t_layi,
        l_node_lay    TYPE lvc_s_layn,
        lt_edittree   TYPE tyt_edittree,
        l_wa_edittree TYPE ty_edittree,
        l_node_text   TYPE lvc_value,
        l_node_key    TYPE lvc_nkey,
        l_node_key2   TYPE lvc_nkey,
        l_func_flag   TYPE c.

  CLEAR: p_rc, p_root_key.

  SORT pt_edittree BY buttonnr lfdnr.
  CLEAR: l_node_key, l_node_key2, l_func_flag.
  lt_edittree[] = pt_edittree[].
  REFRESH pt_edittree.

* Zuerst den Root-Knoten einfügen. Der ist immer da
  READ TABLE lt_edittree INTO l_wa_edittree
                         WITH KEY type = 'R'.
  IF sy-subrc <> 0.
    CLEAR l_wa_edittree.
    l_wa_edittree-type = 'R'.     " Root-Knoten hat speziellen Typ
    l_wa_edittree-txt  = 'Funktionsvariante'(t05).
    INSERT l_wa_edittree INTO lt_edittree INDEX 1.
  ENDIF.
  LOOP AT lt_edittree INTO l_wa_edittree.
    PERFORM build_items_edittree USING p_edit_tree l_wa_edittree
                                       lt_itemlay 0.
    l_node_text = l_wa_edittree-txt.
*    if l_node_text is initial.                         " REM ID 10202
    IF l_wa_edittree-type = 'F' AND l_wa_edittree-txt = ''. " ID 10202
      l_node_text = l_wa_edittree-fcode.
    ENDIF.
    CLEAR l_node_lay.
    CASE l_wa_edittree-type.
*     Root-Knoten
      WHEN 'R'.
        CLEAR l_node_key.
        l_node_lay-isfolder = on.
        l_func_flag         = off.

*     Button (mit oder ohne Menü)
      WHEN 'B'.
        l_node_key          = p_root_key.
        l_node_lay-isfolder = on.
        l_func_flag         = off.

*     Separator
      WHEN 'S'.
        l_node_key          = p_root_key.
        l_func_flag         = off.
        l_node_text         = co_edittree_separator.
        l_node_lay-isfolder = on.

*     Funktions-Separator
      WHEN 'Z'.
        IF l_func_flag = off.
          l_node_key = l_node_key2.
        ENDIF.
        l_func_flag = on.
        l_node_lay-isfolder = off.
        l_node_text = co_edittree_separator.

*     Funktion
      WHEN 'F'.
        IF l_func_flag = off.
          l_node_key  = l_node_key2.
        ENDIF.
        l_func_flag = on.
        l_node_lay-isfolder = off.

    ENDCASE.

    l_node_lay-dragdropid = handle_edit_tree.

    CALL METHOD g_edit_tree->add_node
      EXPORTING
        i_relat_node_key     = l_node_key
        i_relationship       = cl_gui_column_tree=>relat_last_child
        is_outtab_line       = l_wa_edittree
        is_node_layout       = l_node_lay
        it_item_layout       = lt_itemlay
        i_node_text          = l_node_text
      IMPORTING
        e_new_node_key       = l_node_key2
      EXCEPTIONS
        relat_node_not_found = 1
        node_not_found       = 2
        OTHERS               = 3.
    p_rc = sy-subrc.
    IF p_rc <> 0.
      SET SCREEN 0.   LEAVE SCREEN.
    ENDIF.

    IF l_wa_edittree-type = 'R'.
      p_root_key = l_node_key2.
      g_top_node_key = l_node_key2.  "globaler Top-Node
    ENDIF.
  ENDLOOP.   " LOOP AT LT_EDITTREE

ENDFORM.   " BUILD_EDITTREE

*--------------------------------------------------------------------
* Form BUILD_FIELDCAT_EDITTREE
* Zusammenstellen des Feldkatalogs für den Edit-Tree
*--------------------------------------------------------------------
FORM build_fieldcat_edittree USING pt_fieldcat TYPE lvc_t_fcat.

  DATA: l_wa_fieldcat TYPE lvc_s_fcat.

* Feldkatalog (d.h. die Spalten für den Tree) bilden
* (Das hat aber noch nichts mit dem Inhalt der Spalten zu tun!)
  REFRESH pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_edittree_fcode.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 1.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-reptext   = 'Funktionscode'(005).
  l_wa_fieldcat-outputlen = 18.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_edittree_icon.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 2.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-tech      = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_edittree_icon_q.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 3.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-reptext   = 'Ikone, Quickinfo'(007).
  l_wa_fieldcat-outputlen = 22.
  APPEND l_wa_fieldcat TO pt_fieldcat.

* ID 10202: Funktionstaste anzeigen
  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname  = co_edittree_fkeytxt.
  l_wa_fieldcat-tabname    = 1.
  l_wa_fieldcat-col_pos    = 4.
  l_wa_fieldcat-key        = off.
  l_wa_fieldcat-reptext   = 'Funktionstaste'(019).
  l_wa_fieldcat-outputlen = 10.
  l_wa_fieldcat-tech       = off.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_edittree_dbclk.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 5.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-reptext   = 'Doppelklick'(008).
*  l_wa_fieldcat-checkbox  = 'X'.
  l_wa_fieldcat-outputlen = 17.
*  l_wa_fieldcat-icon      = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_edittree_tb_butt.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 6.
  l_wa_fieldcat-key       = off.
*  l_wa_fieldcat-reptext   = ''(007).
*  l_wa_fieldcat-outputlen = 3.
  l_wa_fieldcat-tech      = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_edittree_buttonnr.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 7.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-tech      = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname = co_edittree_prio.
  l_wa_fieldcat-tabname   = 1.
  l_wa_fieldcat-col_pos   = 8.
  l_wa_fieldcat-key       = off.
  l_wa_fieldcat-tech      = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname  = co_edittree_dbclkinfo.
  l_wa_fieldcat-tabname    = 1.
  l_wa_fieldcat-col_pos    = 9.
  l_wa_fieldcat-key        = off.
  l_wa_fieldcat-tech       = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

* ID 10202: Funktionstaste
  CLEAR l_wa_fieldcat.
  l_wa_fieldcat-fieldname  = co_edittree_fkey.
  l_wa_fieldcat-tabname    = 1.
  l_wa_fieldcat-col_pos    = 10.
  l_wa_fieldcat-key        = off.
  l_wa_fieldcat-tech       = on.
  APPEND l_wa_fieldcat TO pt_fieldcat.

ENDFORM.   " BUILD_FIELDCAT_EDITTREE

*--------------------------------------------------------------------
* Form BUILD_ITEMS_EDITTREE
* Zusammensetzen des Ergebnis-Toolbars
*--------------------------------------------------------------------
FORM build_items_edittree
            USING VALUE(p_tree)     TYPE REF TO cl_gui_alv_tree
                  VALUE(p_edittree) TYPE ty_edittree
                  pt_items          TYPE lvc_t_layi
                  l_disabled        TYPE i.

  DATA: l_wa_item TYPE lvc_s_layi.

  REFRESH pt_items.
  CLEAR l_wa_item.
  l_wa_item-fieldname = p_tree->c_hierarchy_column_name.
  IF p_edittree-type = 'S'.
    l_wa_item-class   = cl_gui_column_tree=>item_class_text.
    l_wa_item-editable  = off.
  ELSE.
    l_wa_item-class = cl_gui_column_tree=>item_class_text.

*   Tree disabled oder default darstellen
    IF l_disabled = true.
      l_wa_item-style = cl_gui_column_tree=>style_inactive.
    ELSE.
      l_wa_item-style = cl_gui_column_tree=>style_default.
    ENDIF.

  ENDIF.
  APPEND l_wa_item TO pt_items.

  CLEAR l_wa_item.
  l_wa_item-fieldname = co_edittree_fcode.
  l_wa_item-class     = cl_gui_column_tree=>item_class_text.
  APPEND l_wa_item TO pt_items.

  CLEAR l_wa_item.
  l_wa_item-fieldname = co_edittree_icon.
  l_wa_item-class     = cl_gui_column_tree=>item_class_text.
  APPEND l_wa_item TO pt_items.

  CLEAR l_wa_item.
  l_wa_item-fieldname = co_edittree_icon_q.
  l_wa_item-class     = cl_gui_column_tree=>item_class_text.
  l_wa_item-t_image   = p_edittree-icon.
  APPEND l_wa_item TO pt_items.

* ID 10202: Funktionstaste
  CLEAR l_wa_item.
  l_wa_item-fieldname = co_edittree_fkey.
  l_wa_item-class     = cl_gui_column_tree=>item_class_text.
  APPEND l_wa_item TO pt_items.

* ID 10202: Funktionstastentext
  CLEAR l_wa_item.
  l_wa_item-fieldname = co_edittree_fkeytxt.
  l_wa_item-class     = cl_gui_column_tree=>item_class_text.
  APPEND l_wa_item TO pt_items.

  CLEAR l_wa_item.
  l_wa_item-fieldname = co_edittree_dbclk.
  IF p_edittree-dbclkinfo = 'X'.
    l_wa_item-t_image   = icon_okay.
*    l_wa_item-class     = cl_gui_column_tree=>item_class_checkbox.
  ELSE.
    l_wa_item-t_image   = icon_space.
  ENDIF.
  APPEND l_wa_item TO pt_items.

ENDFORM.   " BUILD_ITEMS_EDITTREE

*--------------------------------------------------------------------
* Form SET_RESULT_BAR
* Zusammensetzen des Ergebnis-Toolbars
*--------------------------------------------------------------------
FORM delete_marks.

  DATA: lt_edit_marks   TYPE         lvc_t_nkey,
        l_wa_edit_marks TYPE         lvc_nkey,
        l_wa_edittree   TYPE         ty_edittree,
        l_node_key      TYPE         lvc_nkey,
        l_node_lay      TYPE         lvc_s_layn,
        lt_itemlay      TYPE         lvc_t_layi,
        l_wa_itemlay    TYPE         lvc_s_layi,
        l_node_text     TYPE         lvc_value,
        l_wa_functree   TYPE         ty_functree,
        lt_functree_tmp TYPE         tyt_functree,
        l_rc            LIKE         sy-subrc,
        l_msg_done      TYPE         ish_on_off,
        l_wa_gt_fcodes  LIKE LINE OF gt_fcodes,   "rsmpe_funt.
        lt_node_struct  TYPE         tyt_edittree.

  CLEAR l_msg_done.

* temporär kopieren und später loop
  lt_functree_tmp[] = gt_functree[].

* Alle selektierten Nodes im Edittree ermitteln
* 'D' ist für die Deletefunktion (pCaller)
  PERFORM get_marked_nodekeys USING g_edit_tree
                                    lt_edit_marks
                                    'D'.
  DESCRIBE TABLE lt_edit_marks.
  IF sy-tfill < 1.
    EXIT.
  ENDIF.

* Functree löschen
  CALL METHOD g_func_tree->delete_all_nodes.

* Loop durch die Liste und Deleten der Nodes sowie
* wieder Einfügen in den FunctionTree
  LOOP AT lt_edit_marks INTO l_wa_edit_marks.

    CLEAR l_wa_functree.

*   Den Eintrag aus der internen Tabelle des
*   Function-Trees holen
    CALL METHOD g_edit_tree->get_outtab_line
      EXPORTING
        i_node_key    = l_wa_edit_marks
      IMPORTING
        e_outtab_line = l_wa_edittree.

    IF NOT ( l_wa_edittree-type = 'S'
             OR l_wa_edittree-type = 'Z' ) .

*     ID 11341: Meldung, wenn Kundenfunktion gelöscht wird
      IF l_msg_done = off.
        READ TABLE gt_fcodes TRANSPORTING NO FIELDS
                   WITH KEY code = l_wa_edittree-fcode.
        IF sy-subrc <> 0.
          MESSAGE i777.
*         Gelöschte Kundenfkt werden beim Sichern endgültig gelöscht
          l_msg_done = on.                 " Meldung nur 1x ausgeben
        ENDIF.
      ENDIF.

      l_wa_functree-icon_id = l_wa_edittree-icon.
      l_wa_functree-icon_text = l_wa_edittree-txt.
      l_wa_functree-text = l_wa_edittree-fcode.
      l_wa_functree-hierarchy = l_wa_edittree-icon_q.

      APPEND l_wa_functree TO lt_functree_tmp.
*      l_stop = 0.
    ENDIF.

    CALL METHOD g_edit_tree->delete_subtree
      EXPORTING
        i_node_key                = l_wa_edit_marks
        i_update_parents_expander = 'X'
      EXCEPTIONS
        node_key_not_in_model     = 1.

  ENDLOOP.

* Einfügen der Nodes in den Functree
  LOOP AT lt_functree_tmp INTO l_wa_functree.
*   User kann Buttontext verändert haben -> deshalb anhand
*   von fcode im gt_fcode bestand die original daten holen
    LOOP AT gt_fcodes INTO l_wa_gt_fcodes.

      IF l_wa_functree-text = l_wa_gt_fcodes-code.
        l_wa_functree-hierarchy = l_wa_gt_fcodes-fun_text.
        l_wa_functree-icon_id   = l_wa_gt_fcodes-icon_id.
        l_wa_functree-icon_text = l_wa_gt_fcodes-icon_text.
        MODIFY lt_functree_tmp FROM l_wa_functree.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  SORT lt_functree_tmp BY hierarchy.

* der 2.loop ist notwendig, da Nodetext geändert sein kann,
* der tree jedoch nach dem NOdetext (hierarchy) sortiert ist->
* somit muß zuerst die liste komplett stehen, dann kann erst
* der loop zum inserten in den tree erfolgen
  CLEAR l_wa_functree.
  LOOP AT lt_functree_tmp INTO l_wa_functree.

    REFRESH lt_itemlay.
    CLEAR l_wa_itemlay.
    l_wa_itemlay-fieldname = g_func_tree->c_hierarchy_column_name.
    l_wa_itemlay-class     = cl_gui_column_tree=>item_class_text.
    l_wa_itemlay-editable  = off.
    APPEND l_wa_itemlay TO lt_itemlay.
    CLEAR l_wa_itemlay.
    l_wa_itemlay-fieldname = co_functree_text.
    l_wa_itemlay-class     = cl_gui_column_tree=>item_class_text.
*    l_wa_itemlay-t_image   = l_wa_functree-icon_id.
    APPEND l_wa_itemlay TO lt_itemlay.

    l_node_text = l_wa_functree-hierarchy.
    CLEAR l_node_lay.
    l_node_lay-isfolder  = off.
    l_node_lay-no_branch = on.

*   ID 6148, 18.9.00
    IF l_wa_functree-icon_id EQ ''.
      l_wa_functree-icon_id = icon_space.
    ENDIF.

    l_node_lay-n_image = l_wa_functree-icon_id.
    l_wa_functree-icon_id = icon_space.


    CALL METHOD g_func_tree->add_node
      EXPORTING
        i_relat_node_key     = l_node_key
        i_relationship       = cl_gui_column_tree=>relat_last_child
        is_outtab_line       = l_wa_functree
        is_node_layout       = l_node_lay
        it_item_layout       = lt_itemlay
        i_node_text          = l_node_text
*      IMPORTING
*       E_NEW_NODE_KEY       =
      EXCEPTIONS
        relat_node_not_found = 1
        node_not_found       = 2
        OTHERS               = 3.
    l_rc = sy-subrc.
    IF l_rc <> 0.
      SET SCREEN 0.   LEAVE SCREEN.
    ENDIF.
  ENDLOOP.   " LOOP AT LT_FUNCTREE

* Den Toolbar nun mit Werten versorgen

* Daten holen
  PERFORM get_ordered_edittree CHANGING lt_node_struct.

* Toolbar aufbereiten
  PERFORM set_result_bar USING lt_node_struct
                               g_result_bar.

  CALL METHOD cl_gui_cfw=>flush.

* Die Daten zum Frontend schicken
  CALL METHOD g_edit_tree->frontend_update.
  CALL METHOD g_func_tree->frontend_update.

  g_anythingchanged    = true.

ENDFORM.                    "delete_marks

*--------------------------------------------------------------------
* Form SET_RESULT_BAR
* Zusammensetzen des Ergebnis-Toolbars
*--------------------------------------------------------------------
FORM set_result_bar USING VALUE(pt_functions)
                          TYPE tyt_edittree
                          p_result_bar TYPE REF TO cl_gui_toolbar.
  DATA: l_wa_func   TYPE ty_edittree,
        l_wa_func2  TYPE ty_edittree,
        l_butn_type TYPE tb_btype,
        l_fcode     TYPE ui_func,
        l_icon      TYPE char30,
        l_buttxt    TYPE text40,
        l_qinfo     TYPE iconquick,
        l_rc        LIKE sy-subrc,
        l_idx       LIKE sy-tabix,
        lt_events   TYPE cntl_simple_events,
        l_event     TYPE cntl_simple_event.

* Zuerst alles initialisieren
  CALL METHOD p_result_bar->delete_all_buttons.

* Jetzt den Toolbar neu aufbauen
* So sortieren, dass zuerst die Buttons und dann die Funktionen
* (d.h. die Menüs) kommen
*  sort pt_functions by buttonnr type.
  l_idx = 1.
  DO.
    READ TABLE pt_functions INTO l_wa_func
                            INDEX l_idx.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    l_idx = l_idx + 1.

*   Hier nur Buttons und Button-Separatoren (bei denen ist
*   lfdnr initial) bearbeiten. Funktionen (und deren Separatoren
*   werden im Event-Handler des Toolbars bearbeitet)
    IF l_wa_func-type = 'B'  OR
       l_wa_func-type = 'S'  AND  l_wa_func-lfdnr IS INITIAL.
*     Es soll ein Button oder ein Separator angelegt werden
      READ TABLE pt_functions INTO l_wa_func2
                              INDEX l_idx.
      l_rc = sy-subrc.
      IF l_wa_func-type = 'S'.
        l_butn_type = cntb_btype_sep.
      ELSEIF l_rc <> 0  OR  l_wa_func2-type <> 'F'.
*       Ist dieser nächste Eintrag ein Button, oder gar nicht
*       vorhanden, so ist der Eintrag in L_WA_FUNC ein
*       normaler Button (ohne Menü) oder ein Separator
        l_butn_type = cntb_btype_button.
      ELSE.
*       Es soll ein Button mit DropDown-Menü angelegt werden
        l_butn_type = cntb_btype_dropdown.
      ENDIF.
      l_fcode  = l_wa_func-fcode.
      IF l_wa_func-icon IS INITIAL.
        l_icon = icon_space.
      ELSE.
        l_icon   = l_wa_func-icon.
      ENDIF.
      l_buttxt = l_wa_func-txt.
      l_qinfo  = l_wa_func-icon_q.
      CALL METHOD p_result_bar->add_button
        EXPORTING
          fcode            = l_fcode
          icon             = l_icon
*         IS_DISABLED      =
          butn_type        = l_butn_type
          text             = l_buttxt
          quickinfo        = l_qinfo
*         IS_CHECKED       =
        EXCEPTIONS
          cntl_error       = 1
          cntb_btype_error = 2
          OTHERS           = 3.
      IF sy-subrc <> 0.
      ENDIF.

    ELSEIF l_wa_func-type = 'F'.
*     Menüs können hier nicht gleich angelegt werden. Das geht nur
*     beim Event ON_TOOLBAR_DROPDOWN im Eventhandler des Toolbars
    ENDIF.
  ENDDO.

* Nun noch die notwendigen Eventhandler setzen
  l_event-eventid = cl_gui_toolbar=>m_id_function_selected.
  APPEND l_event TO lt_events.
  l_event-eventid = cl_gui_toolbar=>m_id_dropdown_clicked.
  APPEND l_event TO lt_events.
  CALL METHOD p_result_bar->set_registered_events
    EXPORTING
      events                    = lt_events
    EXCEPTIONS
      cntl_error                = 1
      cntl_system_error         = 2
      illegal_event_combination = 3
      OTHERS                    = 4.
  IF sy-subrc <> 0.
  ENDIF.

  CREATE OBJECT g_res_bar_ev_hdl.
  SET HANDLER g_res_bar_ev_hdl->on_function_selected
              FOR p_result_bar.
  SET HANDLER g_res_bar_ev_hdl->on_toolbar_dropdown
              FOR p_result_bar.
ENDFORM.   " SET_RESULT_BAR

*--------------------------------------------------------------------
* Form ORDER_ED_BUTTONNR
* Loop durch Edittree und sortiert die Buttonnr aufsteigend
*--------------------------------------------------------------------
FORM get_ordered_edittree CHANGING lt_node_struct
                                       TYPE tyt_edittree.

  DATA: l_wa_node_struct TYPE ty_edittree.
  DATA: btn_cnt LIKE nwbutton-buttonnr.
  DATA: fkt_cnt TYPE i.

* Struktur holen
  PERFORM get_edittree_struct_list CHANGING lt_node_struct.

  btn_cnt = '000'.
  LOOP AT lt_node_struct INTO l_wa_node_struct.

    IF l_wa_node_struct-type = 'B' OR l_wa_node_struct-type = 'S'.
      btn_cnt = btn_cnt + 1.
      fkt_cnt = 0.
    ELSE.
      fkt_cnt = fkt_cnt + 1.
    ENDIF.

    l_wa_node_struct-buttonnr = btn_cnt.

    IF l_wa_node_struct-type = 'F' OR l_wa_node_struct-type = 'Z'.
      l_wa_node_struct-lfdnr = fkt_cnt.
    ENDIF.

    MODIFY lt_node_struct FROM l_wa_node_struct.

  ENDLOOP.

ENDFORM.                    "get_ordered_edittree

*--------------------------------------------------------------------
* Form FILL_GT_TABLES
* Füllt die globalen Listen für nwfvar,nwbutton und nwfvarp
*--------------------------------------------------------------------
FORM fill_gt_tables USING VALUE(p_viewtype)    LIKE nwview-viewtype
                          VALUE(p_fvar)        LIKE nwfvar-fvar
                          VALUE(p_txt)         LIKE nwfvart-txt.

  DATA: l_wa_nwfvar   LIKE v_nwfvar.
  DATA: l_wa_nwbutton LIKE v_nwbutton.
  DATA: l_wa_nwfvarp  LIKE v_nwfvarp.

  DATA: lt_node_struct    TYPE tyt_edittree.
  DATA: l_wa_node_struct  TYPE ty_edittree.

  CLEAR gt_nwfvar.    REFRESH gt_nwfvar.
  CLEAR gt_nwbutton.  REFRESH gt_nwbutton.
  CLEAR gt_nwfvarp.   REFRESH gt_nwfvarp.

* Strukturierte Liste mit geordneter buttonnr holen
  PERFORM get_ordered_edittree CHANGING lt_node_struct.

* gt_nwfvar füllen
  CLEAR l_wa_nwfvar.
  l_wa_nwfvar-viewtype    = p_viewtype.
  l_wa_nwfvar-fvar        = p_fvar.
  l_wa_nwfvar-spras       = sy-langu.
  l_wa_nwfvar-txt         = p_txt.
  APPEND l_wa_nwfvar TO gt_nwfvar.

* gt_nwbutton füllen (Buttons u. Separatoren)
  CLEAR l_wa_node_struct.
  LOOP AT lt_node_struct INTO l_wa_node_struct
                         WHERE type = 'B'
                         OR    type = 'S'.
    CLEAR l_wa_nwbutton.
    l_wa_nwbutton-viewtype   = p_viewtype.
    l_wa_nwbutton-fvar       = p_fvar.
    l_wa_nwbutton-buttonnr   = l_wa_node_struct-buttonnr.
    l_wa_nwbutton-spras      = sy-langu.
    l_wa_nwbutton-icon       = l_wa_node_struct-icon.
    l_wa_nwbutton-fcode      = l_wa_node_struct-fcode.
    l_wa_nwbutton-icon_q     = l_wa_node_struct-icon_q.
    l_wa_nwbutton-dbclk      = l_wa_node_struct-dbclkinfo.
    l_wa_nwbutton-fkey       = l_wa_node_struct-fkey.       " ID 10202
    l_wa_nwbutton-buttontxt  = l_wa_node_struct-txt.

    APPEND l_wa_nwbutton TO gt_nwbutton.

  ENDLOOP.

* gt_nwfvarp füllen (Funktionen u. Separatoren)
  CLEAR l_wa_node_struct.
  LOOP AT lt_node_struct INTO l_wa_node_struct
                         WHERE type = 'F'
                         OR    type = 'Z'.
    CLEAR l_wa_nwfvarp.
    l_wa_nwfvarp-viewtype    = p_viewtype.
    l_wa_nwfvarp-fvar        = p_fvar.
    l_wa_nwfvarp-buttonnr    = l_wa_node_struct-buttonnr.
    l_wa_nwfvarp-fcode       = l_wa_node_struct-fcode.
    l_wa_nwfvarp-spras       = sy-langu.
    l_wa_nwfvarp-lfdnr       = l_wa_node_struct-lfdnr.
    l_wa_nwfvarp-dbclk       = l_wa_node_struct-dbclkinfo.
    l_wa_nwfvarp-fkey        = l_wa_node_struct-fkey.       " ID 10202
    l_wa_nwfvarp-tb_butt     = l_wa_node_struct-tb_butt.
    IF NOT l_wa_node_struct-type = 'Z'.
      l_wa_nwfvarp-txt         = l_wa_node_struct-txt.
    ENDIF.

    APPEND l_wa_nwfvarp TO gt_nwfvarp.

  ENDLOOP.

ENDFORM.                    "fill_gt_tables

*--------------------------------------------------------------------
* Form Check_DBCLICK
* überprüft, ob DBCLICK editierbar sein soll oder nicht
* generell nur bei Funktionen und nur bei einer Funktion pro FVAR
*--------------------------------------------------------------------
FORM check_dbclick USING VALUE(l_outtab_line) TYPE ty_edittree.

  DATA: lt_node_struct    TYPE tyt_edittree.
  DATA: l_wa_node_struct  TYPE ty_edittree.
  DATA: l_cnt             TYPE i.

* Prüfung Teil 1 -> auch wenn Funktion gewählt wurde aber schon bei
* einer andere Funktion die DbClick Funktionalität gesetzt wurde
* dann ebenfalls keine Eingabe erlauben.
* form liefert sturct. edittree-liste

  PERFORM get_edittree_struct_list CHANGING lt_node_struct.

  CLEAR l_wa_node_struct.
  l_cnt = 0.
  LOOP AT lt_node_struct INTO l_wa_node_struct
                         WHERE type = 'F'
                         OR    type = 'B'.

*   das ganze nicht für die aktuelle funktion
    IF l_wa_node_struct-fcode <> l_outtab_line-fcode.
      IF l_wa_node_struct-dbclkinfo = 'X'.
        l_cnt = l_cnt + 1.
      ENDIF.
    ENDIF.

  ENDLOOP.

  IF l_cnt > 0.
    g_show_dbclk = off.
  ELSE.
    g_show_dbclk = on.
  ENDIF.

ENDFORM.                    "check_dbclick

*&---------------------------------------------------------------------*
*&      Form  HELP_INPUT_FVAR
*&---------------------------------------------------------------------*
*       F4-Hilfe für Funktionsvarianten
*----------------------------------------------------------------------*
*FORM help_input_fvar.
*
*  DATA: l_wa_v_nwfvar   LIKE v_nwfvar,
*        l_rc            LIKE sy-subrc.
*
*  CALL FUNCTION 'ISHMED_VM_FVAR_F4'
*    EXPORTING
*      i_viewtype = g_view-viewtype
*    IMPORTING
*      e_rc       = l_rc
*      e_fvar     = l_wa_v_nwfvar.
*
*  CASE l_rc.
*    WHEN 0.                                             " OK
*      IF NOT l_wa_v_nwfvar IS INITIAL.
*        g_dynpro200-name    = l_wa_v_nwfvar-fvar.
*        g_dynpro200-bezeich = l_wa_v_nwfvar-txt.
*        PERFORM dynpro_value USING 'W' 'G_DYNPRO200-BEZEICH'.
*      ENDIF.
*    WHEN 2.                                                 " Cancel
*    WHEN OTHERS.                                            " Error
*      MESSAGE e359 WITH g_view-viewtype.
**     Zu Sichttyp & sind keine Funktionsvarianten vorhanden
*  ENDCASE.
*
*ENDFORM.                    " HELP_INPUT_FVAR

*--------------------------------------------------------------------
* Form MODIFY_EDITTREE
* Enabled oder Disabled Treenodes
*--------------------------------------------------------------------
FORM modify_edittree.

* darf lt. Int. Meldung 4282040 nicht verwendet werden?!

*  if g_edit_mode = on.
**  Tree sperren
*    call method g_edit_tree->set_mode
*      exporting
*        mode    = 1.
*
*    if sy-subrc <> 0.
*    endif.
*  else.
**  Tree freigeben
*    call method g_edit_tree->set_mode
*      exporting
*        mode    = 0.
*    if sy-subrc <> 0.
*    endif.
**  Text default darstellen
*  endif.

ENDFORM.                    "modify_edittree

*--------------------------------------------------------------------
* Form Check_ISHMED
* Prüft ob ISHMED verwendet wird
*--------------------------------------------------------------------
FORM check_ishmed CHANGING l_ishmed_used LIKE true.

  DATA: l_wa_tn00 LIKE tn00.

  l_ishmed_used = false.

  SELECT SINGLE * FROM tn00 INTO l_wa_tn00
         WHERE keyfil = '1'.
  IF sy-subrc = 0.
    IF l_wa_tn00-ishmed = 'X'.
      l_ishmed_used = true.
    ENDIF.
  ENDIF.

ENDFORM.                    "check_ishmed

*-------------------------------------------------------------------
* Form BUILD_OUTTAB_FVAR
* Aufbauen der Ausgabetabelle für die Funktionsvarianten-F4-Hilfe
*-------------------------------------------------------------------
FORM build_outtab_fvar TABLES pt_fvar  STRUCTURE v_nwfvar.

  DATA: l_wa_outtab LIKE LINE OF gt_outtab_fvar.

  REFRESH gt_outtab_fvar.
  LOOP AT pt_fvar.
    l_wa_outtab-fvar = pt_fvar-fvar.
    l_wa_outtab-txt  = pt_fvar-txt.
    APPEND l_wa_outtab TO gt_outtab_fvar.
  ENDLOOP.                             " LOOP AT PT_FVAR

ENDFORM.                               " BUILD_OUTTAB_FVAR

*-------------------------------------------------------------------
* Form call_show_fvar
* Aufruf der Funktionsvarianten-F4-Hilfe im ActiveX-Look
*-------------------------------------------------------------------
FORM call_show_fvar TABLES   pt_fvar         STRUCTURE v_nwfvar
                             pt_ret_fvar     STRUCTURE v_nwfvar
                    USING    VALUE(p_mfsel)  TYPE c
                    CHANGING p_rc            LIKE sy-subrc.

  DATA: lt_field    LIKE STANDARD TABLE OF dfies,
        l_wa_field  LIKE LINE OF           lt_field,
        lt_return   LIKE STANDARD TABLE OF ddshretval WITH HEADER LINE,
        l_wa_return LIKE LINE OF           lt_return.
  DATA: l_display   TYPE ddbool_d.
  DATA: l_multiple_choice(1)  TYPE c.

  CLEAR pt_ret_fvar. REFRESH pt_ret_fvar.
  p_rc = 0.
* Zuerst einmal die Feldinformationen für die Übergabetabelle
* in einer eigenen Tabelle vorbereiten
  REFRESH lt_field.
  CLEAR lt_field.
* BEGIN Boden 25.02.2004 ID 10350
  l_wa_field-tabname   = 'RN1_F4FVAR_HLP'.
  l_wa_field-fieldname = 'FVAR'.
  APPEND l_wa_field TO lt_field.
  l_wa_field-tabname   = 'RN1_F4FVAR_HLP'.
  l_wa_field-fieldname = 'TXT'.
  APPEND l_wa_field TO lt_field.
*  l_wa_field-tabname   = 'GT_OUTTAB_FVAR'.
*  l_wa_field-fieldname = 'FVAR'.
*  l_wa_field-position  = l_pos.
*  l_wa_field-rollname  = 'NFVARID'.
** Die Felder OUTPUTLEN, INTLEN und OFFSET (bei den anderen
** Spalten) sind UNBEDINGT notwendig, da sonst die Ausgabe
** nicht richtig aufgebaut wird
*  l_wa_field-outputlen = 15.
*  l_wa_field-intlen    = 15.
** REPTEXT: Spaltenüberschrift
*  l_wa_field-reptext   = 'Variante'(t08).
*  l_wa_field-keyflag   = on.
** INTTYPE auf 'C' setzen. Wird es leer gelassen, ist nämlich
** eine Wildcard-Suche (d.h. mit '*' usw.) nicht möglich
*  l_wa_field-inttype   = 'C'.
*  APPEND l_wa_field TO lt_field.
*
*  l_pos = l_pos + 1.
*  CLEAR l_wa_field.
*  l_wa_field-tabname   = 'GT_OUTTAB_FVAR'.
*  l_wa_field-fieldname = 'TXT'.
*  l_wa_field-position  = l_pos.
*  l_wa_field-rollname  = 'NWFVARTXT'.
*  l_wa_field-outputlen = 50.
*  l_wa_field-intlen    = 50.
*  DESCRIBE DISTANCE BETWEEN gt_outtab_fvar-fvar
*                    AND     gt_outtab_fvar-txt
*                    INTO    l_wa_field-offset IN CHARACTER MODE.
*  l_wa_field-reptext   = 'Bezeichnung'(t06).
*  l_wa_field-inttype   = 'C'.
*  APPEND l_wa_field TO lt_field.
* END Boden 25.02.2004 ID 10350

* Aus der PT_FVAR nun die Ausgabetabelle GT_OUTTAB_FVAR herleiten
  PERFORM build_outtab_fvar TABLES pt_fvar.

  l_display = off.
  REFRESH lt_return.

  IF p_mfsel = space.
    l_multiple_choice = off.
  ELSE.
    l_multiple_choice = on.
  ENDIF.

* RETFIELD muß unbedingt angegeben sein,
* da sonst in RETURN_TAB nichts zurückgegeben wird
  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
*     DDIC_STRUCTURE  = ' '
      retfield        = 'FVAR'
*     PVALKEY         = ' '
      window_title    = 'Funktionsvariante auswählen'(t07)
*     VALUE           =
      value_org       = 'S'
      multiple_choice = l_multiple_choice
      display         = l_display
*     callback_program = 'SAPLN1FVAR'
*     callback_form   = 'FVAR_CALLBACK'
    TABLES
      value_tab       = gt_outtab_fvar
      field_tab       = lt_field
      return_tab      = lt_return
    EXCEPTIONS
      parameter_error = 1
      no_values_found = 2
      OTHERS          = 3.
  IF sy-subrc = 0.
    IF l_multiple_choice = space.
      READ TABLE lt_return INTO l_wa_return
                           WITH KEY fieldname = 'FVAR'.
      IF sy-subrc = 0.
        READ TABLE pt_fvar WITH KEY fvar = l_wa_return-fieldval.
        IF sy-subrc <> 0.
          CLEAR pt_fvar.
        ELSE.
          pt_ret_fvar = pt_fvar.
          APPEND pt_ret_fvar.
        ENDIF.
      ELSE.
        CLEAR pt_fvar.
      ENDIF.
    ELSE.
      LOOP AT lt_return INTO l_wa_return
                        WHERE fieldname = 'FVAR'.
        READ TABLE pt_fvar WITH KEY fvar = l_wa_return-fieldval.
        IF sy-subrc = 0.
          pt_ret_fvar = pt_fvar.
          APPEND pt_ret_fvar.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ELSE.
    p_rc = 1.
  ENDIF.

ENDFORM.                               " CALL_SHOW_FVAR

*--------------------------------------------------------------------
* Form FVAR_CALLBACK
* Dieser Form wird per Callback von dem Funktionsbaustein
* F4IF_INT_TABLE_VALUE_REQUEST aufgerufen. Deshalb auf keinen
* Fall die Schnittstelle verändern!!!
*--------------------------------------------------------------------
*FORM fvar_callback TABLES   pt_rectab  STRUCTURE seahlpres
*                   CHANGING p_shlp     TYPE shlp_descr_t
*                            p_callctrl LIKE ddshf4ctrl.
*  DATA: l_wa_selopt     LIKE ddshselopt,
*        l_wa_fprop      LIKE ddshfprop.
*
* Die Datenselektion der Suchhilfe wird mit dem hier angegebenen
* Funktionsbaustein gesteuert, der dann später (ebenfalls per
* CALLBACK) aufgerufen wird
*  p_shlp-intdescr-selmexit = 'ISHMED_SEARCHHELP_NGPA'.
*
** Sind die Haupt-Selektionsparameter leer und ist auch die
** globale INGPA leer, dann muss die Suchhilfe zuerst ohne
** Trefferliste und nur mit dem Dialog der Werteeinschränkung
** aufgebaut werden. Außerdem muss hier natürlich im Suchhilfe-Exit
** (d.h. hier im ISHMED_SEARCHHELP_NGPA') die Selektion
** durchgeführt werden
** 'D'...Sofortige Werteanzeige (Dropdown)
*  p_shlp-intdescr-dialogtype = 'D'.
*  describe table gt_outtab_fvar.
*  if sy-tfill = 0.
**   'C'...Immer komplexer Dialog mit Werteeinschränkung bringen
*    p_shlp-intdescr-dialogtype = 'C'.
*  endif.
*
** Auch gleich das Suchmuster vom Aufrufer übernehmen, damit
** die Ergebnismenge gleich entsprechend eingeschränkt wird
*  refresh p_shlp-selopt.
*  if gpart ca '*'.
*    clear l_wa_selopt.
*    l_wa_selopt-shlpfield = 'FVAR'.
*    l_wa_selopt-sign      = 'I'.
*    l_wa_selopt-option    = 'CP'.
*    l_wa_selopt-low       = gpart.
*    append l_wa_selopt to p_shlp-selopt.
*  endif.
*
** Das Aussehen der F4-Hilfe nun bestimmen. D.h. hier die Felder
** Sperrkz, VMA_Text, Nam_String nur auf der Liste ausgeben und
** dafür die Felder Vorname und Nachname nicht auf der Liste und
** nur auf der Werteeingrenzung anzeigen
*  loop at p_shlp-fieldprop into l_wa_fprop.
*    l_wa_fprop-shlpoutput = off.
*    case l_wa_fprop-fieldname.
*      when co_fld_vma_text    or
*           co_fld_nam_string  or
*           co_fld_sperr_kz.
**       Diese Felder nicht auf der Werteeingrenzung anzeigen
**       => Position auf 0 setzen
*        l_wa_fprop-shlpselpos = 0.
*
*      when co_fld_vname  or
*           co_fld_nname.
**       Diese Felder nicht auf der Liste anzeigen
*        l_wa_fprop-shlplispos = 0.
*
*      when co_fld_gpart.
**       Dieses Feld muss als OUTPUT gekennzeichnet sein,
**       sonst funktioniert das Zurückliefern des ausgewählten
**       Werts nicht. Siehe dazu auch Aufruf des FBS
**       F4IF_INT_TABLE_VALUE_REQUEST, Parameter RETFIELD
*        l_wa_fprop-shlpoutput = on.
*    endcase.
*    modify p_shlp-fieldprop from l_wa_fprop.
*  endloop.                             " LOOP AT P_SHLP-FIELDPROP ...
*
*ENDFORM.                               " FVAR_CALLBACK
*&---------------------------------------------------------------------*
*&      Form  customer_function_insert
*&---------------------------------------------------------------------*
*       Add customer function to function variant          (ID 11731)
*----------------------------------------------------------------------*
FORM customer_function_insert .

  DATA: l_node_key    TYPE lvc_nkey.

  CLEAR l_node_key.

  g_cust_ins  = on.

  PERFORM node_double_click USING l_node_key.

  SET CURSOR FIELD 'G_DYNPRO-FCODE'.

ENDFORM.                    " customer_function_insert
*&---------------------------------------------------------------------*
*&      Form  node_double_click
*&---------------------------------------------------------------------*
*       Double Click on a node key in the edit tree
*----------------------------------------------------------------------*
*      -->P_NODE_KEY   key of node in tree
*----------------------------------------------------------------------*
FORM node_double_click  USING   VALUE(p_node_key)  TYPE lvc_nkey.

  DATA: l_outtab_line TYPE ty_edittree,
        l_wa_icon     TYPE icon.

  IF g_edit_mode = on.
    MESSAGE s395.
    EXIT.
*   Daten sind gerade in Bearbeitung - Funktion nicht verfügbar
  ENDIF.

* Zuerst die Zeile der passenden internen Tabelle holen
* (außer im Modus 'Kunden-Funktion anlegen': ID 11731)
  IF g_cust_ins = off.
    CALL METHOD g_edit_tree->get_outtab_line
      EXPORTING
        i_node_key    = p_node_key
      IMPORTING
        e_outtab_line = l_outtab_line.
*        E_NODE_TEXT   =
  ELSE.
    CLEAR l_outtab_line.
    l_outtab_line-type = 'B'.
    l_outtab_line-icon = icon_space.
  ENDIF.

* Diese Werte nun im Dynpro anzeigen, aber nur dann,
* wenn es sich hier nicht um einen Separator oder den
* Root-Knoten handelt
  CHECK l_outtab_line-type = 'B'  OR
        l_outtab_line-type = 'F'.

  g_dynpro-node_key   = p_node_key.
  g_dynpro-fcode      = l_outtab_line-fcode.
  g_dynpro-txt        = l_outtab_line-txt.

* Prüfen ob DBClk-CheckBox editierbar sein soll
  PERFORM check_dbclick USING l_outtab_line.

  g_dynpro-dbclk      = l_outtab_line-dbclkinfo.
  g_dynpro-icon       = l_outtab_line-icon.

* Funktionstaste zugeordnet?
  g_dynpro-fkey       = l_outtab_line-fkey.                 " ID 10202

* Icon-Techn. Bezeichnung ermitteln
  SELECT SINGLE * FROM icon INTO l_wa_icon
                      WHERE id = l_outtab_line-icon.

  g_dynpro-icontech   = l_wa_icon-name.

  g_dynpro-icon_q     = l_outtab_line-icon_q.

* Den Button "Änderung übernehmen" aktivieren
  g_show_button_change = on.

* Edit Modus setzen
  g_edit_mode          = on.

* ggf. Icon-Button freigeben oder sperren
  IF l_outtab_line-type = 'B'.
    g_edit_iconbutton  = on.
  ELSE.
    g_edit_iconbutton  = off.
  ENDIF.

* set ok code 'TEST'
  CALL METHOD cl_gui_cfw=>set_new_ok_code
    EXPORTING
      new_code = 'TEST'.

* Explizites Dynpro-Feld-Refresh
  PERFORM dynpro_value USING 'W' 'REFRESH'.

* Edittree-Bearbeitungsstatus ggf. umsetzen
  PERFORM modify_edittree.

ENDFORM.                    " node_double_click
*&---------------------------------------------------------------------*
*&      Form  rework_fcodes
*&---------------------------------------------------------------------*
*       rework function codes;
*       do not display functions (e.g. depends on system parameters)
*----------------------------------------------------------------------*
*      -->P_VIEWTYPE     view type
*      -->P_WPLACEID     workplace id
*      -->P_WPLACETYPE   workplace type
*      -->P_ISHMED       ishmed is used (TRUE/FALSE)
*      -->P_TRANSLATION  translation mode (ON/OFF)
*      <--PT_FCODES      function codes
*----------------------------------------------------------------------*
FORM rework_fcodes  USING  VALUE(p_viewtype)    TYPE nwview-viewtype
                           VALUE(p_wplaceid)    TYPE nwplace-wplaceid
                           VALUE(p_wplacetype)  TYPE nwplace-wplacetype
                           VALUE(p_ishmed)      LIKE true
                           VALUE(p_translation) TYPE ish_on_off
                  CHANGING pt_fcodes            TYPE ishmed_t_wp_func.

  DATA: l_active(1)     TYPE         c,
        l_guideline_act TYPE         ish_on_off,
        l_acm_active    TYPE         ish_on_off,
        l_ims_available TYPE         abap_bool,
        l_tn00q         TYPE         tn00q,
        l_einri         TYPE         einri,
        l_idx           TYPE         sy-tabix,
        l_place_001     TYPE         nwplace_001,
        l_fcode         LIKE LINE OF pt_fcodes,
        ls_nwbutton     LIKE LINE OF gt_nwbutton,
        ls_nwfvarp      LIKE LINE OF gt_nwfvarp.

  CLEAR: l_einri, l_active, l_tn00q, l_place_001.


* Check switch for surgery workplace in DWS (MED-32354)
  IF cl_ishmed_switch_check=>ishmed_edp( ) = off.
    DELETE pt_fcodes WHERE code = 'OPDWS'.
    DELETE pt_fcodes WHERE code = 'PPERIOD'.                " MED-34935
    DELETE pt_fcodes WHERE code = 'NPERIOD'.                " MED-34935
  ELSE.                                                     " MED-33868
    DELETE pt_fcodes WHERE code = 'OPMO'.                   " MED-33868
    DELETE pt_fcodes WHERE code = 'OMON'.                   " MED-33868
  ENDIF.

* SAP ACM - active
  CALL FUNCTION 'ISH_OUTPATIENT_ACTIVE'
    IMPORTING
      e_active = l_acm_active.

  IF l_acm_active = off AND p_viewtype = '007'.
    DELETE pt_fcodes WHERE code = 'N2DWS1' OR " Situation zuordnen
                           code = 'N2DWS2' OR " Situation bearbeiten
                           code = 'N2DWS3' OR " Situation erstellen
                           code = 'KVWS'   OR " KV-Arbeitsplatz
                           code = 'KVCH'   OR " KV-Prüfung
                           code = 'RDPR'   OR " Bescheinigung drucken
                           code = 'RDRL'   OR " Bescheinigung freigeben
                           code = 'RDCL'   OR " Bescheinigung stornieren
                           code = 'RDCR'   OR " Bescheinigung erneuern
                           code = 'RDCF'   OR " Endbescheinigung erstellen
                           code = 'RDCI'   OR " unabhängige Besch. erstellen
                           code = 'RDDO'   OR " Bescheinigungsübersicht
                           code = 'RDCD'   OR " Bescheinigung erstellen
                           code = 'NP44'.     " Behandlungsscheine
  ENDIF.

* if IS-H*MED is used, change some function texts for
* preregistration/clinical order in some viewtypes
  IF p_ishmed = true AND
   ( p_viewtype = '001' OR p_viewtype = '002' OR
     p_viewtype = '003' OR p_viewtype = '007' OR
     p_viewtype = '010' ).
    LOOP AT pt_fcodes INTO l_fcode WHERE code(3) = 'VKG'
                                      OR code    = 'CORDD'.
      CASE l_fcode-code.
        WHEN 'VKGC'.
          l_fcode-fun_text  = 'Klinischen Auftrag anlegen'(020).
          l_fcode-icon_text = 'Klinischer Auftrag'(023).
        WHEN 'VKGU' OR 'VKGN'.
          l_fcode-fun_text  = 'Klinischen Auftrag ändern'(021).
          l_fcode-icon_text = 'Klinischer Auftrag'(023).
        WHEN 'VKGD'.
          IF p_viewtype = '010'.
            l_fcode-fun_text  = 'Auftragsposition stornieren'(026).
          ELSE.
            l_fcode-fun_text  = 'Klinischen Auftrag anzeigen'(024).
          ENDIF.
          l_fcode-icon_text = 'Klinischer Auftrag'(023).
        WHEN 'CORDD'.
          l_fcode-fun_text  = 'Klinischen Auftrag anzeigen'(024).
          l_fcode-icon_text = 'Klinischer Auftrag'(023).
*        WHEN 'VKGS'.
*          l_fcode-fun_text  = 'Klinischen Auftrag suchen'(022).
*          l_fcode-icon_text = 'Klinischer Auftrag'(023).
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.
      MODIFY pt_fcodes FROM l_fcode.
    ENDLOOP.
  ENDIF.

* if IS-H*MED is used, there are some checks necessary for these view
* types
  IF p_ishmed = true AND
   ( p_viewtype = '004' OR p_viewtype = '007' OR p_viewtype = '011' ).
*   get institution
    IF p_wplacetype = '001'.
      SELECT SINGLE * FROM nwplace_001 INTO l_place_001
             WHERE  wplacetype  = p_wplacetype
             AND    wplaceid    = p_wplaceid.
    ENDIF.
    IF sy-subrc <> 0 OR l_place_001-einri IS INITIAL.
      CALL FUNCTION 'ISH_GET_PARAMETER_ID'
        EXPORTING
          i_parameter_id    = 'EIN'
        IMPORTING
          e_parameter_value = l_einri.
    ELSE.
      l_einri = l_place_001-einri.
    ENDIF.
*   institution is necessary
    IF NOT l_einri IS INITIAL.
*     get parameter if requests and/or clinical orders are active
      CLEAR l_active.
      IF NOT l_einri IS INITIAL.
        PERFORM ren00q(sapmnpa0) USING l_einri 'N1CORDER' l_tn00q-value.
        MOVE l_tn00q-value(1) TO l_active.
      ENDIF.
*     remove some request functions if requests are not active
      IF l_active = 'O'.                     " only orders are active
        CASE p_viewtype.
          WHEN '004'.                        " clinical orders
            DELETE pt_fcodes WHERE code = 'BEST'.
          WHEN '007'.                       " ambulance/service facil.
            DELETE pt_fcodes WHERE code = 'ANSP'.
          WHEN '011'.                       " operations
            DELETE pt_fcodes WHERE code = 'ANSP'.
          WHEN OTHERS.
        ENDCASE.
      ENDIF.
    ENDIF.
  ENDIF.

* rework fcodes for viewtype 007
  IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_false AND p_viewtype = '007'.
    DELETE pt_fcodes WHERE code = 'P1NW'.
    DELETE pt_fcodes WHERE code = 'CORDI_A_M'.
  ENDIF.

* rework fcodes for viewtype 013
  IF p_ishmed = true AND p_viewtype = '013'.
    CALL FUNCTION 'ISHMED_VP_FVAR_013'
      CHANGING
        ct_fcodes = pt_fcodes.
  ENDIF.

* exclude some functions for viewtypes 001-003 (MED-46307)
  IF p_ishmed = true AND
     cl_ishmed_switch_check=>ishmed_misc01( ) = abap_false AND
   ( p_viewtype = '001' OR p_viewtype = '002' OR p_viewtype = '003' OR
     p_viewtype = '008' ).                               "note 1659317
    DELETE pt_fcodes WHERE code = 'CALEND_123'
                        OR code = 'PDAY_123'
                        OR code = 'NDAY_123'.
  ENDIF.

* ISHMED - pathway active
  CLEAR l_guideline_act.
  IF p_ishmed = true.
    IF l_einri IS INITIAL.
      IF p_wplacetype = '001'.
        SELECT SINGLE * FROM nwplace_001 INTO l_place_001
               WHERE  wplacetype  = p_wplacetype
               AND    wplaceid    = p_wplaceid.
      ENDIF.
      IF sy-subrc <> 0 OR l_place_001-einri IS INITIAL.
        CALL FUNCTION 'ISH_GET_PARAMETER_ID'
          EXPORTING
            i_parameter_id    = 'EIN'
          IMPORTING
            e_parameter_value = l_einri.
      ELSE.
        l_einri = l_place_001-einri.
      ENDIF.
    ENDIF.

    IF NOT l_einri IS INITIAL.
      CALL METHOD cl_ishmed_fct_guideline=>is_in_use
        EXPORTING
          i_institution = l_einri
        RECEIVING
          r_use         = l_guideline_act.
      IF l_guideline_act = off.
        DELETE pt_fcodes WHERE code = 'N2GA' OR
                               code = 'N2GU'.
      ENDIF.
    ENDIF.
  ENDIF.

*                                                                   6.05
  IF p_ishmed = true AND
    cl_ishmed_switch_check=>ishmed_scd( ) = abap_false.
    DELETE pt_fcodes WHERE code = 'N2AD1' OR
                           code = 'N2AD2' OR
                           code = 'N2VS1' OR
                           code = 'N2VS2' OR
                           code = 'N2VS3' OR
                           code = 'N2PHYO1' OR
                           code = 'N2PHYO2' OR
                           code = 'N2PHYO3' OR "Med-52511
                           code = 'N2IPPD1' OR
                           code = 'N2IPPD2' OR
                           code = 'N2NPND1' OR
                           code = 'N2NPND2'.
  ENDIF.

*                                                                   6.06
  IF p_ishmed = true.
*   licence check for image study
    cl_ishmed_im_util=>is_license_available(
      EXPORTING
        i_einri             = l_einri
      IMPORTING
        e_license_available = l_ims_available ).

    IF l_ims_available = abap_false.
      DELETE pt_fcodes WHERE code = 'N1IM1' OR
                             code = 'N1IM2' OR
                             code = 'N1IM3'.
    ENDIF.
  ENDIF.

*                                                                   6.07
  IF p_ishmed = true AND
     cl_ishmed_switch_check=>ishmed_misc01( ) = abap_false.
    DELETE pt_fcodes WHERE
*                           code = 'N1PDS1' OR                  "MED-54419
*                           code = 'N1PDS2' OR                  "MED-54419
                           code = 'N1IPC1'.
  ENDIF.

* in translation mode the standard function texts should be shown
* if the language texts are empty
  IF p_translation = on.
    LOOP AT gt_nwbutton INTO ls_nwbutton WHERE icon_q    IS INITIAL
                                            OR buttontxt IS INITIAL.
      l_idx = sy-tabix.
      READ TABLE pt_fcodes INTO l_fcode
                 WITH KEY code = ls_nwbutton-fcode.
      CHECK sy-subrc = 0.
      IF ls_nwbutton-icon_q IS INITIAL.
        ls_nwbutton-icon_q = l_fcode-fun_text.
      ENDIF.
      IF ls_nwbutton-buttontxt IS INITIAL.
        ls_nwbutton-buttontxt = l_fcode-icon_text.
      ENDIF.
      MODIFY gt_nwbutton FROM ls_nwbutton INDEX l_idx.
    ENDLOOP.
    LOOP AT gt_nwfvarp INTO ls_nwfvarp WHERE txt IS INITIAL.
      l_idx = sy-tabix.
      READ TABLE pt_fcodes INTO l_fcode
                 WITH KEY code = ls_nwfvarp-fcode.
      CHECK sy-subrc = 0.
      ls_nwfvarp-txt = l_fcode-fun_text.
      MODIFY gt_nwfvarp FROM ls_nwfvarp INDEX l_idx.
    ENDLOOP.
  ENDIF.

ENDFORM.                    " rework_fcodes
*&---------------------------------------------------------------------*
*&      Form  fetch_fcodes
*&---------------------------------------------------------------------*
*       fetch function codes from gui-status of viewtype
*----------------------------------------------------------------------*
*      --> P_VIEWTYPE    view type
*      --> P_ISHMED      IS-H*MED used/active (ON/OFF)
*      <-- PT_FCODES     function codes
*      <-- P_T_MESSAGE   messages
*      <-- P_RC          returncode (0=OK, 1=Error)
*----------------------------------------------------------------------*
FORM fetch_fcodes  USING    VALUE(p_viewtype)  TYPE nwview-viewtype
                            VALUE(p_ishmed)    LIKE true
                   CHANGING pt_fcodes          TYPE ishmed_t_wp_func
                            pt_message         TYPE tyt_messages
                            p_rc               TYPE sy-subrc.

*  DATA: lt_list    TYPE vrm_values,
*        ls_list    LIKE LINE OF lt_list,
  DATA l_cvers          TYPE tn00-cvers.
  DATA l_gui_status     LIKE g_gui_status.        "MED-9377 C. Honeder

  REFRESH: pt_fcodes.  ", lt_list.

** get texts for viewtypes from data dictionary
*  PERFORM get_viewtype_texts(sapln1workplace) USING    '001'
*                                                       off
*                                              CHANGING lt_list.
*
*  READ TABLE lt_list INTO ls_list WITH KEY key = p_viewtype.
*  CHECK sy-subrc = 0.
*
*  g_gui_pgmtxt = ls_list-text.

* Ausgehend vom Sichttyp den GUI-Status herleiten, der die
* Grundmenge der Funktionscodes bestimmt
  PERFORM get_report_funcvar(sapln1workplace) USING    p_viewtype
                                              CHANGING g_gui_pgm
                                                       g_gui_status.

  IF g_gui_pgm IS INITIAL OR g_gui_status IS INITIAL.
    p_rc = 1.
    EXIT.
  ENDIF.

* Die Funktionscodes dieses Programms/GUI-Status nun ermitteln
  PERFORM get_fcodes USING g_gui_pgm  g_gui_status
                           pt_fcodes  pt_message
                           p_rc       'I'.
  IF p_rc <> 0.
    EXIT.
  ENDIF.

* wird IS-H*MED verwendet, dann ev. auch den entsprechenden GUI-Status
* dazulesen
  IF p_ishmed = true.
    CASE p_viewtype.
      WHEN '001' OR '002' OR '003'.
        PERFORM get_fcodes USING 'SAPLN_WP_INP_MOVEMENTS'
                                 'FCT_ISHMED'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
        IF p_viewtype = '003'.                             "note 1384425
          DELETE pt_fcodes WHERE code = 'N2DWS1'
                              OR code = 'N2DWS3'
                              OR code = 'N2INPADWS5'
                              OR code = 'N2INPADWS6'.
        ENDIF.
      WHEN '007'.
        PERFORM get_fcodes USING 'SAPLN1LSTAMB'
                                 'FCT_007'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
      WHEN '008'.
        PERFORM get_fcodes USING 'SAPLN_WP_008'
                                 'FCT_ISHMED'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
      WHEN '010'.
        PERFORM get_fcodes USING 'SAPLN_WP_010'
                                 'FCT_ISHMED_010'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
      WHEN '016'.
        PERFORM get_fcodes USING 'SAPLN2_WP_016'
                                 'FCT_016'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
* - - - - - - - BEGIN MED-9377 C. Honeder
      WHEN OTHERS.
        IF g_gui_status(7) = 'N2DWS_D'.
*         Build gui-status name
          CONCATENATE g_gui_status '_ISHMED' INTO l_gui_status.

*         Get fcodes from our status
          PERFORM get_fcodes USING 'SAPLN2SVAR'
                                   l_gui_status
                                   pt_fcodes    pt_message
                                   p_rc         ' '.
*         We don't need a return code
          CLEAR p_rc.
        ENDIF.
* - - - - - - - END MED-9377 C. Honeder
    ENDCASE.
    IF p_rc <> 0.
      EXIT.
    ENDIF.
  ENDIF.

* IS-H NL im Einstatz - entsprechenden GUI-Status dazulesen (6.01)
* provide country version
  CALL FUNCTION 'ISH_COUNTRY_VERSION_GET'
    IMPORTING
      ss_cvers = l_cvers.

* only for NL!
  IF l_cvers = cv_netherlands.
    CASE p_viewtype.
      WHEN '001' OR '002' OR '003'.
        PERFORM get_fcodes USING 'SAPLN_WP_INP_MOVEMENTS'
                                 'FCT_ISH_NL'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
      WHEN '004'.
        PERFORM get_fcodes USING 'SAPLN1AU'
                                 'FCT_004_NL'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
      WHEN '007'.
        PERFORM get_fcodes USING 'SAPLN1LSTAMB'
                                 'FCT_007_NL'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
      WHEN '008'.
        PERFORM get_fcodes USING 'SAPLN_WP_008'
                                 'FCT_008_NL'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
      WHEN '011'.
        PERFORM get_fcodes USING 'SAPLN1WPOP'
                                 'FCT_011_NL'
                                 pt_fcodes    pt_message
                                 p_rc         ' '.
    ENDCASE.
    IF p_rc <> 0.
      EXIT.
    ENDIF.
  ENDIF.

* only for AT!
  IF l_cvers = cv_austria.
    CASE p_viewtype.
      WHEN '001' OR '002' OR '003'.
*       only for special EHP4-SWITCH                             ZA001
        IF cl_ish_switch_check=>ish_misc1( ) = on.
          PERFORM get_fcodes USING 'SAPLN_WP_INP_MOVEMENTS'
                                   'FCT_ISH_AT'
                                   pt_fcodes    pt_message
                                   p_rc         ' '.
        ENDIF.
    ENDCASE.
  ENDIF.

* it won't work with baseitems               "MED-52483
  IF p_viewtype NP 'C*'.                     "MED-52483
    DELETE pt_fcodes WHERE code = 'CANCEL'
                        OR code = 'BACK'
                        OR code = 'EXIT'.
  ENDIF.                                     "MED-52483

ENDFORM.                    " fetch_fcodes
