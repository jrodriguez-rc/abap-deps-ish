*----------------------------------------------------------------------*
***INCLUDE LN1FVARF10 .
*----------------------------------------------------------------------*
*---------------------------------------------------------------------*
* Form  HELP_INPUT
* F4-Hilfe im Dynpro
*----------------------------------------------------------------------*
FORM help_input.

  DATA: l_fname(40) TYPE c,
        l_icon      LIKE icon_space,
        l_line      TYPE i.                 "#EC NEEDED

* Auf welchem Feld stand der Cursor
  GET CURSOR FIELD l_fname LINE l_line.
  CASE l_fname.
*   Icon
    WHEN 'G_DYNPRO-ICON'.
      CHECK g_translation = off.
      l_icon = g_dynpro-icon.
      CALL FUNCTION 'ISHMED_ICON_SHOW'
        EXPORTING
          i_length     = 2
          i_none_entry = on
          i_vcode      = 'UPD'
          i_modal      = on
        IMPORTING
          e_icon_id    = l_icon
        EXCEPTIONS
          read_error   = 1
          cancel       = 2
          OTHERS       = 3.
      CHECK sy-subrc = 0.

*     ID 11731: ICON_SPACE als gültig erlauben!
      IF l_icon = '****'.
        l_icon = icon_space.
      ENDIF.

      g_dynpro-icon = l_icon.
      PERFORM dynpro_value USING 'W' 'G_DYNPRO-ICON'.
*     Das Icon kann leider nur zum PBO-Zeitpunnkt angezeigt
*     werden => SUPPRESS DIALOG durchführen
      SUPPRESS DIALOG.
  ENDCASE.

ENDFORM.                    " HELP_INPUT

*-----------------------------------------------------------------------
* Form DYNPRO_VALUE - Auslesen und Setzen einiger Dynprofelder
* Auslesen bzw. Schreiben des Dynpros
*-----------------------------------------------------------------------
* -> p1: Modus - 'W'...Write, 'R'...Read
*-----------------------------------------------------------------------
FORM dynpro_value USING value(p_mode)  TYPE c
                        value(p_fname) TYPE c.

  DATA: lt_dynpfields LIKE dynpread OCCURS 0 WITH HEADER LINE.
  DATA: l_repid LIKE d020s-prog,
        l_dynnr LIKE d020s-dnum.

  l_repid = sy-repid.
  l_dynnr = sy-dynnr.
  CASE p_mode.
*   Direktes Schreiben in das Dynpro
    WHEN 'W'.
      CLEAR lt_dynpfields.   REFRESH lt_dynpfields.
      CASE p_fname.
*       Icon
        WHEN 'G_DYNPRO-ICON'.
          lt_dynpfields-fieldname  = 'G_DYNPRO-ICON'.
          lt_dynpfields-fieldvalue = g_dynpro-icon.
          APPEND lt_dynpfields.
      ENDCASE.

*     Bezeichnung
      CASE p_fname.
        WHEN 'G_DYNPRO200-BEZEICH'.
          lt_dynpfields-fieldname  = 'G_DYNPRO200-BEZEICH'.
          lt_dynpfields-fieldvalue = g_dynpro200-bezeich.
          APPEND lt_dynpfields.
      ENDCASE.

*     Dynprotxt, dynproicon_q
      CASE p_fname.
        WHEN 'REFRESH'.

          lt_dynpfields-fieldname  = 'G_DYNPRO-TXT'.
          lt_dynpfields-fieldvalue = g_dynpro-txt.
          APPEND lt_dynpfields.
          lt_dynpfields-fieldname  = 'G_DYNPRO-ICON_Q'.
          lt_dynpfields-fieldvalue = g_dynpro-icon_q.
          APPEND lt_dynpfields.

      ENDCASE.
      CALL FUNCTION 'DYNP_VALUES_UPDATE'
        EXPORTING
          dyname     = l_repid
          dynumb     = l_dynnr
        TABLES
          dynpfields = lt_dynpfields.

  ENDCASE.                             " CASE MODE

ENDFORM.                               " DYNPRO_VALUE

*---------------------------------------------------------------------*
* Form CHANGE_LINE_EDIT_TREE
* Übernehmen der Dynprofelder in eine Zeile des Edit-Trees
*---------------------------------------------------------------------*
FORM change_line_edit_tree.

  DATA: lt_edittree    TYPE tyt_edittree,
        l_wa_edittree  TYPE ty_edittree,
        l_edittree     LIKE LINE OF lt_edittree,            " ID 10202
        lt_items       TYPE lvc_t_layi,
        l_wa_items     TYPE lvc_s_layi,
        l_node_text    TYPE lvc_value,
        lt_new_items   TYPE lvc_t_laci,
        l_wa_new_items TYPE lvc_s_laci,
        l_rc           LIKE sy-subrc,
        lt_node_struct TYPE tyt_edittree.

* BEGIN MED-47552  Oana Bocarnea 21.05.2012
  DATA: l_ns_found TYPE trnspace-namespace,
        lt_rxres   TYPE match_result_tab,
        ls_rxres   TYPE match_result.
* END MED-47552    Oana Bocarnea

*  STATICS: l_warn_cus_fcode TYPE lvc_fname.

  l_rc = 0.                                                 " ID 10202

  lt_edittree[] = gt_edittree[].                            " ID 10202

* ID 11731: Funktionscode muß eingegeben werden!
  IF g_dynpro-fcode IS INITIAL.
    l_rc = 1.
    MESSAGE i224.
*   Bitte einen Funktionscode eingeben
    EXIT.
  ENDIF.

  IF g_cust_ins = off.
*   Bestehende Funktion ändern, daher zuvor aus lok. Tab. löschen
    DELETE lt_edittree WHERE fcode = g_dynpro-fcode.        " ID 10202
  ENDIF.

* Prüfung ob Icon vorhanden ist, wenn es sich um
* einen Button handelt ....
  IF g_edit_iconbutton = on AND
     ( g_dynpro-icon IS INITIAL OR g_dynpro-icon = '****' ).
    l_rc = 1.                                               " ID 10202
    MESSAGE i373.
*   Bitte ein Icon auswählen
    EXIT.
  ENDIF.

* ID 10202: Jede Funktionstaste darf nur 1x verwendet werden
  IF NOT g_dynpro-fkey IS INITIAL.
    READ TABLE lt_edittree INTO l_edittree
               WITH KEY fkey = g_dynpro-fkey.
    IF sy-subrc = 0.
*     Diese Funktionstaste wird bereits für die Funktion & verwendet
      IF l_edittree-txt IS INITIAL.
        l_edittree-txt = l_edittree-icon_q.
      ENDIF.
      l_rc = 1.                                             " ID 10202
      MESSAGE i795 WITH l_edittree-txt.
      EXIT.
    ENDIF.
  ENDIF.

* ID 11731: Beim Anlegen einer neuen Kunden-Funktion muß diese
*           zuerst in den Edit-Tree insertiert werden!
  IF g_cust_ins = on.
*   Zuerst prüfen, ob der FCODE bereits vergeben ist
    READ TABLE lt_edittree TRANSPORTING NO FIELDS
               WITH KEY fcode = g_dynpro-fcode.
    IF sy-subrc <> 0.
      READ TABLE gt_functree TRANSPORTING NO FIELDS
                 WITH KEY text = g_dynpro-fcode.
    ENDIF.
    IF sy-subrc = 0.
      MESSAGE i808.
*     Dieser Funktionscode ist bereits vergeben
      EXIT.
    ELSE.

* BEGIN MED-47552 Oana Bocarnea 21.05.2012

**     Der FCODE muß mit Y oder Z beginnen
*      IF g_dynpro-fcode(1) CN 'YZ'.  " AND
**       doch keine Warnung nötig -> sondern Fehler (nur Y+Z erlaubt)
**         g_dynpro-fcode    <> l_warn_cus_fcode.
*        MESSAGE i809.
**       Kundenfunktionscodes sollen mit dem Buchstaben Y oder Z beginnen
**        l_warn_cus_fcode = g_dynpro-fcode.
*        EXIT.
*      ENDIF.
**      l_warn_cus_fcode = g_dynpro-fcode.
*      PERFORM insert_marks USING 'B'.

*Check if the function code is a regular expression like the followings:

*g_dynpro-fcode = '/1BCABA/'.
*g_dynpro-fcode = 'Y3456ZTE'.
*g_dynpro-fcode = 'ZABCDE' .

* If the function code is between '/ /' than the function 'TR_CHECK_NAMESPACE' is called
* to check if the used namespace is a licenced one.
* Otherwise if the namespace is not licenced and starts not with Y or Z a pop-up with error message will be displayed
* and the function will not be saved .

      FIND ALL OCCURRENCES OF REGEX '^((/[^/]*/)|(Y)|(Z))' IN g_dynpro-fcode RESULTS lt_rxres.

      IF sy-subrc = 0.
        READ TABLE lt_rxres INTO ls_rxres INDEX 1.
        IF strlen( g_dynpro-fcode+ls_rxres-length  ) = 0.
          MESSAGE i160(n1base).
          EXIT.
        ELSE.
          l_ns_found = g_dynpro-fcode+ls_rxres-offset(ls_rxres-length).
          IF ls_rxres-length <> 1.

            CALL FUNCTION 'TR_CHECK_NAMESPACE'
              EXPORTING
                iv_namespace        = l_ns_found
                iv_edit_only        = ' '
                iv_producer_only    = 'X'
                iv_licensed_only    = 'X'
              EXCEPTIONS
                namespace_not_valid = 1
                OTHERS              = 2.
            IF sy-subrc <> 0.
*             BEGIN MED-86748
*              MESSAGE i159(n1base).
*              EXIT.
              CALL FUNCTION 'TR_CHECK_NAMESPACE'
                EXPORTING
                  iv_namespace        = l_ns_found
                  iv_edit_only        = ' '
                  iv_producer_only    = ' '
                  iv_licensed_only    = 'X'
                EXCEPTIONS
                  namespace_not_valid = 1
                  OTHERS              = 2.
                IF sy-subrc <> 0.
                  MESSAGE i159(n1base).
                EXIT.
              ENDIF.
            ENDIF.
*           END MED-86748
          ENDIF.
        ENDIF.

        PERFORM insert_marks USING 'B'.


      ELSE.
        MESSAGE i809.
      ENDIF.
    ENDIF.
  ENDIF.
* END MED-47552 Oana Bocarnea 21.05.2012

* Nun die betreffende Zeile suchen
  LOOP AT gt_edittree INTO l_wa_edittree
                      WHERE fcode = g_dynpro-fcode.

    l_wa_edittree-txt    = g_dynpro-txt.
*   Auf Wunsch wieder rausgenommen ( für Buttons )
*    if l_wa_edittree-txt = ''.
*      l_wa_edittree-txt = g_dynpro-fcode.
*    endif.
    IF l_wa_edittree-type = 'F' AND l_wa_edittree-txt = ''.
      l_wa_edittree-txt = l_wa_edittree-fcode.
    ENDIF.

    l_wa_edittree-icon       = g_dynpro-icon.
    l_wa_edittree-icon_q     = g_dynpro-icon_q.
    l_wa_edittree-dbclkinfo  = g_dynpro-dbclk.
    l_wa_edittree-fkey       = g_dynpro-fkey.               " ID 10202
*   ID 10202: Funktionstastentext
    PERFORM get_domain_value_desc(sapmn1pa)
                             USING 'NFKEY' g_dynpro-fkey
                                           l_wa_edittree-fkeytxt.
*   Diesen Knoten nun ändern
    PERFORM build_items_edittree
            USING g_edit_tree l_wa_edittree lt_items 0.
    l_node_text = l_wa_edittree-txt.

*   Auf Wunsch wieder rausgenommen
*    if l_node_text is initial.
*      l_node_text = l_wa_edittree-fcode.
*    endif.

    LOOP AT lt_items INTO l_wa_items.
      CLEAR l_wa_new_items.
      MOVE-CORRESPONDING l_wa_items TO l_wa_new_items.
      l_wa_new_items-u_t_image = 'X'.
      APPEND l_wa_new_items TO lt_new_items.
    ENDLOOP.
*    clear l_wa_edittree-dbclk.
    CALL METHOD g_edit_tree->change_node
      EXPORTING
        i_node_key     = g_dynpro-node_key
        i_outtab_line  = l_wa_edittree
*       IS_NODE_LAYOUT =
        it_item_layout = lt_new_items
        i_node_text    = l_node_text
        i_u_node_text  = on.
    EXIT.
  ENDLOOP.

  CHECK l_rc = 0.                                           " ID 10202

* Die Daten zum Frontend schicken
  CALL METHOD g_edit_tree->frontend_update.

* Den Toolbar nun mit Werten versorgen
* strukt. Liste von edittree holen
  PERFORM get_edittree_struct_list CHANGING lt_node_struct.

* Den Toolbar nun mit Werten versorgen
  PERFORM set_result_bar USING lt_node_struct
                               g_result_bar.

  CLEAR g_dynpro-icon.

* Den Change-Button wieder ausblenden und die Felder löschen
  g_show_button_change = off.
  g_edit_mode          = off.
  g_cust_ins           = off.                               " ID 11731
  g_anythingchanged    = true.
  g_show_dbclk         = off.
  g_edit_iconbutton    = off.
  CLEAR g_dynpro.

  PERFORM modify_edittree.

ENDFORM.   " CHANGE_LINE_EDIT_TREE

*--------------------------------------------------------------------*
* Form INSERT_MARKS
* Die im Function-Tree markierten Daten in den Edit-Tree übernehmen
*--------------------------------------------------------------------*
FORM insert_marks USING value(p_insert_as) TYPE c.

  DATA: lt_func_marks TYPE lvc_t_nkey,
        lt_edit_marks TYPE lvc_t_nkey,
        l_edit_root   TYPE lvc_nkey,
        l_wa_node     TYPE lvc_nkey,
        l_insert_node TYPE lvc_nkey,
*        l_wa_edit     TYPE ty_edittree,
        l_wa_edittree TYPE ty_edittree,
*        l_wa_edit_marks TYPE ty_edittree,
        l_wa_gt_edittree TYPE ty_edittree,
        l_ins_after   TYPE ty_edittree,
        l_wa_func     TYPE ty_functree,
        l_node_text   TYPE lvc_value,
        l_node_key    TYPE lvc_nkey,
        l_node_key2   TYPE lvc_nkey,
        l_root_key    TYPE lvc_nkey,
        l_node_lay    TYPE lvc_s_layn,
*        l_func_flag   TYPE c,
        lt_itemlay    TYPE lvc_t_layi,
        l_relatship   LIKE cl_gui_column_tree=>relat_first_child,
        l_max_btn_nr  LIKE nwbutton-buttonnr,
        l_node_lay_t  LIKE lvc_s_layn,
        l_no_ed_selected TYPE i.
  DATA: lt_node_struct    TYPE tyt_edittree.
*  DATA: l_wa_node_struct  TYPE ty_edittree.

  CLEAR: l_node_key, l_node_key2.

  REFRESH lt_func_marks.

  l_no_ed_selected = 0.

* Überprüfen ob Funktion markiert wurde
  IF NOT p_insert_as = 'S' AND g_cust_ins = off.
*   Die markierten Datensätze des Function-Trees bestimmen
*   wenn es sich um keinen Separator handelt
    PERFORM get_marked_nodekeys USING g_func_tree
                                      lt_func_marks
                                      'S'.
    DESCRIBE TABLE lt_func_marks.
    IF sy-tfill = 0.
*     Es war im Quellbaum nichts markiert
      MESSAGE s371.
*     Bitte gewünschte Funktionen selektieren
      EXIT.
    ENDIF.
  ENDIF.

* Anlegen neue Kundenfunktion (ID 11731)
* --> Dummy-Eintrag in Tabelle der 'markierten Funktionen' aufnehmen
  IF g_cust_ins = on.
    CLEAR l_wa_node.
    APPEND l_wa_node TO lt_func_marks.
  ENDIF.

* Feststellen, ob im Edit-Tree eh nur maximal eine Zeile
* markiert war
  PERFORM get_marked_nodekeys USING g_edit_tree
                                    lt_edit_marks
                                    'S'.
  DESCRIBE TABLE lt_edit_marks.
  IF sy-tfill > 1.
    IF g_cust_ins = off.
*     Sie dürfen im Zielbaum nur genau eine Markierung setzen
      MESSAGE s257.
      EXIT.
    ENDIF.
  ENDIF.

* Root-Knoten ermitteln, der wird auf jeden Fall gebraucht
  CLEAR l_edit_root.
  l_wa_node = g_top_node_key.

  l_root_key = l_wa_node.
* Flush ist notwendig wenn Node selektiert wird,
* daß l_wa_node befüllt wird !!!
  CALL METHOD cl_gui_cfw=>flush.
  IF sy-subrc <> 0.
  ENDIF.

* Überprüfung auf VIRTUALROOT
  DO.
    l_edit_root = l_wa_node.
    CALL METHOD g_edit_tree->get_parent
      EXPORTING
        i_node_key        = l_edit_root
      IMPORTING
        e_parent_node_key = l_wa_node.
    IF l_wa_node = '&VIRTUALROOT'.
      EXIT.
    ENDIF.
  ENDDO.

* Markierung im EditTree lesen
* wurde eine Zeile markiert -> diese ermitteln
  READ TABLE lt_edit_marks INTO l_wa_node INDEX 1.
  IF sy-subrc = 0.
    CALL METHOD g_edit_tree->get_outtab_line
      EXPORTING
        i_node_key    = l_wa_node
      IMPORTING
        e_outtab_line = l_ins_after.

    l_insert_node = l_wa_node.
  ELSE.
*   Es wurde keine Zeile markiert => Letzte Zeile holen,
*   da dahinter die Daten eingefügt werden
    DESCRIBE TABLE gt_edittree.
    IF sy-tfill < 1.
      EXIT.
    ENDIF.

    l_no_ed_selected = 1.

*   wenn kein Knoten selektiert und zu insertierende Funktion
*   ein Separator ist, dann insert_after rootkz zuweisen
    IF p_insert_as = 'S'.
      l_ins_after-type = 'R'.
      l_insert_node = l_root_key.
    ELSE.
      READ TABLE gt_edittree INTO l_ins_after INDEX 1.
*     Da nichts markiert wurde, wird der Root-Knoten als
*     Insertierungspunkt genommen
      l_insert_node = l_edit_root.
    ENDIF.
  ENDIF.

* Ist der letzte Eintrag in der internen Tabelle ein
* Button-Separator, können unter diesem keine Funktionen
* eingefügt werden
  IF p_insert_as = 'F'  AND
     ( l_ins_after-type = 'S'  OR  l_ins_after-type = 'R' )  AND
     l_ins_after-lfdnr IS INITIAL.
*   Sie dürfen Funktionen nur einer Taste zuweisen
    MESSAGE s258.
    EXIT.
  ENDIF.

* Sollen die neuen Einträge als Buttons eingefügt werden,
* muss - sofern im Edit-Tree eine Funktion markiert wurde -
* der Parent der Funktion ermittelt werden, dass dann auf
* dieser Hierarieebene als nächster Button die Einträge
* eingefügt werden können
  IF p_insert_as = 'B'  AND  ( l_ins_after-type = 'F'  OR
     l_ins_after-type = 'S'  AND
     NOT l_ins_after-lfdnr IS INITIAL ).
    l_wa_node = l_insert_node.
    CALL METHOD g_edit_tree->get_parent
      EXPORTING
        i_node_key        = l_wa_node
      IMPORTING
        e_parent_node_key = l_insert_node.
  ENDIF.

* höchste Buttonnummer rausfinden
  LOOP AT gt_edittree INTO l_wa_gt_edittree.
    IF l_wa_gt_edittree-buttonnr > l_max_btn_nr.
      l_max_btn_nr = l_wa_gt_edittree-buttonnr.
    ENDIF.
  ENDLOOP.

  CLEAR l_node_lay.

* Separator inserten
* BUTTON-SEPARATOR nach BUTTON
  IF l_ins_after-type = 'B' AND p_insert_as = 'S'.

    l_wa_edittree-buttonnr = l_ins_after-buttonnr.
    l_wa_edittree-type = 'S'.
    l_wa_edittree-txt = co_edittree_separator.
    l_node_text  = co_edittree_separator.
    l_relatship = cl_gui_column_tree=>relat_next_sibling.
    l_node_lay-isfolder   = on.
*    l_func_flag           = off.
    l_node_key            = l_insert_node.
    l_wa_edittree-icon    = icon_space.

    l_node_lay-dragdropid = handle_edit_tree.

*   Edittree-Items
    PERFORM build_items_edittree USING g_edit_tree l_wa_edittree
                                             lt_itemlay 0.
    CALL METHOD g_edit_tree->add_node
      EXPORTING
        i_relat_node_key     = l_node_key
        i_relationship       = l_relatship
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
    IF sy-subrc <> 0.
    ENDIF.

* BUTTON-SEPARATOR nach Funktion
  ELSEIF l_ins_after-type = 'F' AND p_insert_as = 'S'.

    l_wa_edittree-buttonnr = l_ins_after-buttonnr.
    l_wa_edittree-type = 'Z'.
    l_wa_edittree-txt = co_edittree_separator.
    l_node_text  = co_edittree_separator.
    l_relatship = cl_gui_column_tree=>relat_next_sibling.
    l_node_lay-isfolder   = off.
*    l_func_flag           = on.
    l_node_key            = l_insert_node.
    l_wa_edittree-icon    = icon_space.

    l_node_lay-dragdropid = handle_edit_tree.

*   Edittree-Items
    PERFORM build_items_edittree USING g_edit_tree l_wa_edittree
                                             lt_itemlay 0.

    CALL METHOD g_edit_tree->add_node
      EXPORTING
        i_relat_node_key     = l_node_key
        i_relationship       = l_relatship
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
    IF sy-subrc <> 0.
    ENDIF.

* BUTTON-SEPARATOR nach ROOT
  ELSEIF l_ins_after-type = 'R' AND p_insert_as = 'S'.

    l_max_btn_nr = l_max_btn_nr + 1.
    l_wa_edittree-buttonnr = l_max_btn_nr.
    l_wa_edittree-type = 'S'.
    l_wa_edittree-txt = co_edittree_separator.
    l_node_text  = co_edittree_separator.
    l_relatship = cl_gui_column_tree=>relat_last_child.
    l_node_lay-isfolder   = on.
*    l_func_flag           = off.
    l_node_key            = l_insert_node.
    l_wa_edittree-icon    = icon_space.


    l_node_lay-dragdropid = handle_edit_tree.

*   Edittree Items
    PERFORM build_items_edittree USING g_edit_tree l_wa_edittree
                                             lt_itemlay 0.

    CALL METHOD g_edit_tree->add_node
      EXPORTING
        i_relat_node_key     = l_insert_node
        i_relationship       = l_relatship
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
    IF sy-subrc <> 0.
    ENDIF.

  ELSE.

*   ggf. die Sortierung umdrehen wenn es sich um Mehrfacheinträge
*   auf der gleichen Ebene handelt
    IF ( p_insert_as = 'F' AND l_ins_after-type = 'F' ) OR
       ( p_insert_as = 'B' AND l_ins_after-type = 'B' ) .
      SORT lt_func_marks DESCENDING.
    ENDIF.

*   Nun die markierten Einträge in den Edit-Tree insertieren
*   MAIN LOOP --------------------------------------------------------
    LOOP AT lt_func_marks INTO l_wa_node.
      CLEAR l_node_lay_t.

      IF l_wa_node IS INITIAL AND g_cust_ins = on.
*       Die eingegebenen Daten der neuen Funktion verwenden (ID 11731)
        IF g_dynpro-fcode IS INITIAL.
          EXIT.
        ENDIF.
        l_wa_edittree-fcode  = g_dynpro-fcode.
        l_wa_edittree-icon   = g_dynpro-icon.
        l_wa_edittree-icon_q = g_dynpro-icon_q.
        l_wa_edittree-txt    = g_dynpro-txt.
        l_wa_edittree-dbclk  = g_dynpro-dbclk.
        l_wa_edittree-fkey   = g_dynpro-fkey.
      ELSE.
*       Den Eintrag aus der internen Tabelle des Function-Trees holen
        CALL METHOD g_func_tree->get_outtab_line
          EXPORTING
            i_node_key     = l_wa_node
          IMPORTING
            e_outtab_line  = l_wa_func
            es_node_layout = l_node_lay_t.
        IF l_wa_func-icon_id IS INITIAL.
          l_wa_edittree-icon = icon_space.
        ELSE.
*          l_wa_edittree-icon = l_wa_func-icon_id.
          l_wa_edittree-icon = l_node_lay_t-n_image.
        ENDIF.
        l_wa_edittree-icon_q = l_wa_func-hierarchy.
        l_wa_edittree-txt    = l_wa_func-icon_text.
        l_wa_edittree-fcode  = l_wa_func-text.
      ENDIF.

      l_node_key            = l_insert_node.
      CLEAR l_node_lay.

*     und damit einen Eintrag im Edit-Tree anlegen
*     --------------------------FUNKTIONS EBENE --------------------
      IF p_insert_as = 'F'.

*       Node-Text erstellen
        IF NOT l_wa_edittree-icon_q IS INITIAL.
          l_node_text = l_wa_edittree-icon_q.
          l_wa_edittree-txt = l_wa_edittree-icon_q.
          CLEAR l_wa_edittree-icon_q.
        ELSE.
          l_node_text = l_wa_edittree-txt.
        ENDIF.

*       Funktion insertieren wenn Button selektiert ist->nächste Ebene
        IF l_ins_after-type = 'B'.
          l_relatship = cl_gui_column_tree=>relat_last_child.
        ELSE.
*         Funktion insertieren wenn Funktion selektiert ist
*         --> gleiche Ebene
          l_relatship = cl_gui_column_tree=>relat_next_sibling.
        ENDIF.

*       aktuell selektierten EditTree Knoten ermittel
*       read table lt_edit_marks into l_wa_edit_marks index 1

        l_node_lay-isfolder   = off.
*        l_func_flag           = on.
        l_wa_edittree-type    = 'F'.
        CLEAR l_wa_edittree-icon.

*       Buttonnummer vergeben
        l_wa_edittree-buttonnr = l_ins_after-buttonnr.
        l_wa_edittree-tb_butt  = '01'.


*     ---------------------------BUTTON EBENE --------------------
      ELSEIF p_insert_as = 'B'.

*       Node-Text erstellen
        l_node_text = l_wa_edittree-txt.

*       Hierarchie nach letzter Funktion dieses Buttons einfügen
*        if l_insert_node = l_edit_root.
        IF l_no_ed_selected = 1.
          l_relatship = cl_gui_column_tree=>relat_last_child.
        ELSE.

          IF l_ins_after-type = 'R'.
            l_relatship = cl_gui_column_tree=>relat_first_child.
          ELSE.
            l_relatship = cl_gui_column_tree=>relat_next_sibling.
          ENDIF.
        ENDIF.

        l_node_lay-isfolder = on.
*        l_func_flag         = off.
        l_wa_edittree-type  = 'B'.
        l_max_btn_nr = l_max_btn_nr + 1.

*       Buttonnummer vergeben
        l_wa_edittree-buttonnr = l_max_btn_nr.

      ENDIF.

*     Auf Wunsch wieder rausgenommen
*      if l_node_text is initial.
*       l_node_text = l_wa_edittree-fcode.
*      endif.

*     Edittree Items
      PERFORM build_items_edittree USING g_edit_tree l_wa_edittree
                                         lt_itemlay  0.

      l_node_lay-dragdropid = handle_edit_tree.

      CALL METHOD g_edit_tree->add_node
        EXPORTING
          i_relat_node_key     = l_node_key
          i_relationship       = l_relatship
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
      IF sy-subrc <> 0.
*       nothing to do! should not happen ...
      ELSE.
*       Beim Anlegen von neuen Kundenfunktionen (ID 11731)
*       --> NodeKey ins globale Dynprofeld stellen
        IF g_cust_ins = on.
          g_dynpro-node_key = l_node_key2.
        ENDIF.
      ENDIF.

*     Eintrag aus dem Functiontree löschen
      IF g_cust_ins = off.
        CALL METHOD g_func_tree->delete_subtree
          EXPORTING
            i_node_key = l_wa_node.
      ENDIF.

    ENDLOOP.   " LOOP AT LT_FUNC_MARKS ...
  ENDIF.

* Strukturierte Liste mit geordneter buttonnr holen
  PERFORM get_ordered_edittree CHANGING lt_node_struct.

*  alte Variante
*  perform GET_EDITTREE_STRUCT_LIST changing lt_node_struct.

* Den Toolbar nun mit Werten versorgen
*  perform set_result_bar using gt_edittree
  PERFORM set_result_bar USING lt_node_struct
                               g_result_bar.

* Aufgrund der internen Abhängigkeiten (buttonnr und lfdnr)
* bzw. der zuordnung von funktionen zu button gibt es beim
* d&d immer wieder probleme mit mehrfachselektion und moven
* von neuen einträgen, da diese die höchste Node-Nummer erhalten
* jedoch in der Struktur vielleicht mitten drinnen stehen.
* da auf die datenliste des trees nur mit den add,change usw.
* methoden zugegriffen werden kann, ist ein neuer treeaufbau notwendig

  CALL METHOD cl_gui_cfw=>flush.

*  CALL METHOD g_edit_tree->delete_subtree
*    EXPORTING
*      i_node_key = g_top_node_key
*      i_update_parents_expander = 'X'.
*
*
*  CALL METHOD cl_gui_cfw=>flush.
*  CALL METHOD g_edit_tree->frontend_update.
*  CALL METHOD cl_gui_cfw=>update_view.
*
*
*  PERFORM build_edittree USING g_edit_tree
*                            lt_node_struct
*                            g_top_node_key
*                            l_rc.
*
*
*  CALL METHOD cl_gui_cfw=>flush.
**  l_root_key = g_top_node_key.
*
*
** Den Root-Knoten immer geöffnet darstellen
*  CALL METHOD g_edit_tree->expand_node
*    EXPORTING
*      i_node_key          = g_top_node_key
*      i_level_count       = 99
*      i_expand_subtree    = 'X'
*    EXCEPTIONS
*      OTHERS              = 1.

* Die Daten zum Frontend schicken
  CALL METHOD g_edit_tree->frontend_update.
  CALL METHOD g_func_tree->frontend_update.

  g_anythingchanged    = true.

ENDFORM.   " INSERT_MARKS

*--------------------------------------------------------------------
* Form GET_MARKED_NODEKEYS
* Ermitteln der markierten Node-Keys eines Trees
* Dabei gilt - wenn kein Node markiert wurde - auch ein markiertes
* Item als Markierung eines Knotens
*--------------------------------------------------------------------
FORM get_marked_nodekeys USING value(p_tree)
                                    TYPE REF TO cl_gui_alv_tree
                                    pt_marked_nodes TYPE lvc_t_nkey
                                    pcaller TYPE c.
  DATA: l_wa_node       TYPE lvc_nkey.
  DATA: BEGIN OF lt_tree_hier OCCURS 0.
  DATA:   node      TYPE lvc_nkey,
          hierarchy TYPE i,
        END OF lt_tree_hier,
*        level TYPE i,
        l_node_outtab   TYPE ty_edittree,
        lt_child_list TYPE lvc_t_nkey,
        l_wa_child_list TYPE lvc_nkey,
        l_wa_tree_hier LIKE lt_tree_hier.

* in die lt_tree_hier die Reihenfolge im Edittree eintragen
* nach Hierarchie absteigend gereiht, damit bei
* delete_subtree zuerst die Children und dann die
* ParentNodes deletet werden können

* Die markierten Datensätze bestimmen
  REFRESH pt_marked_nodes.
  CALL METHOD p_tree->get_selected_nodes
    CHANGING
      ct_selected_nodes = pt_marked_nodes
    EXCEPTIONS
      cntl_system_error = 1
      dp_error          = 2
      failed            = 3
      OTHERS            = 4.
  IF sy-subrc <> 0.
  ENDIF.

* Kein Knoten markiert? => Itemmarkierung prüfen
  DESCRIBE TABLE pt_marked_nodes.
  IF sy-tfill = 0.
    CALL METHOD p_tree->get_selected_item
      IMPORTING
        e_selected_node   = l_wa_node
*       E_FIELDNAME       =
      EXCEPTIONS
        no_item_selection = 1
        cntl_system_error = 2
        failed            = 3
        OTHERS            = 4.
    IF sy-subrc <> 0.
    ENDIF.

    IF NOT l_wa_node IS INITIAL.
      APPEND l_wa_node TO pt_marked_nodes.
*     Eintragreihenfolge umkehren zwecks Darstellungslogik
*      insert l_wa_node into pt_marked_nodes index 1.
    ENDIF.
  ENDIF.

*  sort pt_marked_nodes descending.

* wenn es sich um den edittree und delete handelt
  IF p_tree = g_edit_tree AND pcaller = 'D'.

*   loop über gefundene Nodes und Zuweisen Children und der Hierarchie
    CLEAR l_wa_node.
    LOOP AT pt_marked_nodes INTO l_wa_node.

      CLEAR l_node_outtab.

      CALL METHOD g_edit_tree->get_outtab_line
        EXPORTING
          i_node_key    = l_wa_node
        IMPORTING
          e_outtab_line = l_node_outtab.

*     Hierarchiekennzeichen setzen
      IF l_node_outtab-type = 'B'.
        l_wa_tree_hier-hierarchy = 2.
      ELSEIF l_node_outtab-type = 'F'.
        l_wa_tree_hier-hierarchy = 3.
      ELSEIF l_node_outtab-type = 'S'.
        l_wa_tree_hier-hierarchy = 2.
      ELSEIF l_node_outtab-type = 'Z'.
        l_wa_tree_hier-hierarchy = 3.
      ENDIF.

      l_wa_tree_hier-node = l_wa_node.

*     Root Node nicht in die Liste stellen
      IF NOT l_node_outtab-type = 'R'.
        APPEND l_wa_tree_hier TO lt_tree_hier.
      ENDIF.

*     ggf. Children dazulesen auf Ebene Button(2)
      IF l_wa_tree_hier-hierarchy = 2.

        REFRESH lt_child_list.
        CALL METHOD g_edit_tree->get_children
          EXPORTING
            i_node_key  = l_wa_tree_hier-node
          IMPORTING
            et_children = lt_child_list.

        DESCRIBE TABLE lt_child_list.
        IF sy-tfill > 0.
          LOOP AT lt_child_list INTO l_wa_child_list.
            CLEAR l_wa_tree_hier.
            l_wa_tree_hier-node = l_wa_child_list.
            l_wa_tree_hier-hierarchy = 3.

            APPEND l_wa_tree_hier TO lt_tree_hier.

          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDLOOP.

*   Liste nach Hierarchie sortieren alle Doppelten rausnehmen
    SORT lt_tree_hier BY hierarchy DESCENDING node .
    DELETE ADJACENT DUPLICATES FROM lt_tree_hier.

    REFRESH pt_marked_nodes.

*   Eigentliche Rückgabeliste mit der richtigen Reihenfolge
*   für die weiter Bearbeitung erstellen
    LOOP AT lt_tree_hier INTO l_wa_tree_hier.
      l_wa_node = l_wa_tree_hier-node.
      APPEND l_wa_node TO pt_marked_nodes.
*      insert l_wa_node into pt_marked_nodes index 1.
    ENDLOOP.

  ENDIF.

ENDFORM.   " GET_MARKED_NODEKEYS

*--------------------------------------------------------------------*
* Form  OK_CODE
* Den OK-Code des Dynpros auswerten
*--------------------------------------------------------------------*
FORM ok_code.

  DATA: l_save_ok_code  LIKE ok-code,
        l_icon_code     LIKE icon_space,
        yn(2)           TYPE c,
        l_wa_icon       TYPE icon.

  l_save_ok_code = ok-code.
  CLEAR ok-code.
  CLEAR g_okcode.

  CASE l_save_ok_code.
    WHEN 'TEST'.

*   Sichern
    WHEN 'SAVE'.
      g_first_time_200 = on.
      CALL SCREEN 200 STARTING AT 20 10 ENDING AT 80 14.
      IF g_okcode = 'ENTER'.
        SET SCREEN 0. LEAVE SCREEN.
      ENDIF.

*   Fertig
    WHEN 'ENTER' OR 'ECAN'.
      IF g_anythingchanged = true AND g_mode = 'S' OR
         g_vcode = g_vcode_insert AND g_mode = 'S'.
        IF l_save_ok_code = 'ECAN'.
          PERFORM popup_to_confirm(sapmnpa0)
              USING ' ' 'Nicht gespeicherte Änderungen'(p12)
              'gehen verloren. Daten sichern?'(p13)
              'Funktionsvariantenpflege beenden'(m04)    yn.
        ELSE.
          yn = 'J'.
        ENDIF.
        IF yn = 'J' .
          g_first_time_200 = on.
          CALL SCREEN 200 STARTING AT 20 10 ENDING AT 80 14.
          SET SCREEN 0. LEAVE SCREEN.
        ELSEIF yn = 'N'.
          SET SCREEN 0. LEAVE SCREEN.
        ENDIF.
      ELSE.
        SET SCREEN 0. LEAVE SCREEN.
      ENDIF.

*   Neue (Kunden-)Funktion anlegen (ID 11731)
    WHEN 'INS_CUST'.
      IF NOT g_edit_mode = on.
        PERFORM customer_function_insert.
      ELSE.
        MESSAGE s395.
        EXIT.
*       Daten sind gerade in Bearbeitung - Funktion nicht verfügbar
      ENDIF.

*   Änderungen in den Edit-Tree übernehmen
    WHEN 'DO_CHANGE'.
      PERFORM change_line_edit_tree.

*   Abbrechen auf Ändern-Dynpro
    WHEN 'NO_CHANGE'.
      PERFORM no_change_line_edit_tree.

*   Die im Function-Tree markierten Daten als Button übernehmen
    WHEN 'INS_NODE'.
      IF NOT g_edit_mode = on.
        PERFORM insert_marks USING 'B'.
      ELSE.
        MESSAGE s395.
        EXIT.
*       Daten sind gerade in Bearbeitung - Funktion nicht verfügbar
      ENDIF.

*   Die im Function-Tree markierten Daten als Funktionen übern.
    WHEN 'INS_FUNC'.
      IF NOT g_edit_mode = on.
        PERFORM insert_marks USING 'F'.
      ELSE.
        MESSAGE s395.
        EXIT.
*       Daten sind gerade in Bearbeitung - Funktion nicht verfügbar
      ENDIF.

    WHEN 'INS_SEP'.
      IF NOT g_edit_mode = on.
        PERFORM insert_marks USING 'S'.
      ELSE.
        MESSAGE s395.
        EXIT.
*       Daten sind gerade in Bearbeitung - Funktion nicht verfügbar
      ENDIF.

*   Einträge aus Edittree löschen
    WHEN 'DEL'.
      IF NOT g_edit_mode = on.
        PERFORM delete_marks.
      ELSE.
        MESSAGE s395.
        EXIT.
*       Daten sind gerade in Bearbeitung - Funktion nicht verfügbar
      ENDIF.

*   F4-Hilfe auf Icon-Button
    WHEN 'FCIB'.
      CHECK g_translation = off.
      CALL FUNCTION 'ISHMED_ICON_SHOW'
           EXPORTING
                i_length     = 2
                i_none_entry = on
*               I_TITLE      = ' '
                i_vcode      = 'UPD'
                i_modal      = on
           IMPORTING
                e_icon_id    = l_icon_code
*          TABLES
*               T_ICON       =
           EXCEPTIONS
                read_error   = 1
                cancel       = 2
                OTHERS       = 3.
      CHECK sy-subrc = 0.

*     ID 11731: ICON_SPACE als gültig erlauben!
      IF l_icon_code = '****'.
        l_icon_code = icon_space.
      ENDIF.

      g_dynpro-icon = l_icon_code.

*     Icon-Techn. Bezeichnung ermitteln
      SELECT SINGLE * FROM icon INTO l_wa_icon
             WHERE id = l_icon_code.

      g_dynpro-icontech = l_wa_icon-name.

*   Control-Dispatch- Events
    WHEN OTHERS.  " Control Events routen
      IF l_save_ok_code(1) = '%'.
        CALL METHOD cl_gui_cfw=>dispatch.
      ENDIF.
  ENDCASE.
ENDFORM.                    " OK_CODE

*--------------------------------------------------------------------*
* Form  GET_FUNCTREE_ITEM_POS
* ermittelt die Pos im Functree wo geinsertet werden soll.
*--------------------------------------------------------------------*
*FORM get_functree_item_pos USING l_wa_functree TYPE ty_functree
*                           CHANGING position TYPE lvc_nkey.
*
*  DATA: lt_functree_tmp   TYPE tyt_functree,
*        l_wa_functree_tmp TYPE ty_functree.
*
** Globale Funccodes-Tabelle in temp. kopieren
*  lt_functree_tmp[] = gt_functree[].
*
** Wa adden
*  APPEND l_wa_functree TO lt_functree_tmp.
*
** Sortieren nach FCodes
*  SORT lt_functree_tmp BY hierarchy.
*
*  LOOP AT lt_functree_tmp INTO l_wa_functree_tmp.
*    IF l_wa_functree_tmp-hierarchy = l_wa_functree-hierarchy.
*      position = sy-tabix - 1.
*      EXIT.
*    ENDIF.
*  ENDLOOP.
*ENDFORM.                    "get_functree_item_pos

*--------------------------------------------------------------------*
* Form  GET_EDITTREE_STRUCT_LSIT
* liefert strukturierte Liste des Edittrees
*--------------------------------------------------------------------*
FORM get_edittree_struct_list CHANGING lt_node_struct
                                TYPE tyt_edittree.

* die oberst node holen und alle nodes
* darunter in itab einlesen damit struktur
* der nodes für toolbar klar ist
  DATA: l_topmost_node    TYPE lvc_nkey,
        lt_edtree_nodes   TYPE lvc_t_nkey,
        l_wa_edtree_nodes TYPE lvc_nkey,
        l_wa_edit         TYPE ty_edittree.

  l_topmost_node = g_top_node_key.

* Subtree holen
  CALL METHOD g_edit_tree->get_subtree
    EXPORTING
      i_node_key       = l_topmost_node
    IMPORTING
      et_subtree_nodes = lt_edtree_nodes.
  CALL METHOD cl_gui_cfw=>flush.

  CLEAR l_wa_edit.
  LOOP AT lt_edtree_nodes INTO l_wa_edtree_nodes.
* die Daten zu den nodes holen
    CALL METHOD g_edit_tree->get_outtab_line
      EXPORTING
        i_node_key    = l_wa_edtree_nodes
      IMPORTING
        e_outtab_line = l_wa_edit.

    APPEND l_wa_edit TO lt_node_struct.
  ENDLOOP.

ENDFORM.                    "get_edittree_struct_list
*&---------------------------------------------------------------------*
*&      Form  INIT_CUA_D200
*&---------------------------------------------------------------------*
FORM init_cua_d200.

  DATA: l_wa_nwfvar LIKE v_nwfvar.
  DATA: l_desc(30).

  IF g_first_time_200 = on.
    READ TABLE gt_nwfvar INTO l_wa_nwfvar INDEX 1.

    IF sy-subrc = 0.
      g_dynpro200-name = l_wa_nwfvar-fvar.
      g_dynpro200-bezeich  = l_wa_nwfvar-txt.
    ELSE.
      CLEAR g_dynpro200-name.
*     ID 5683: Ev. Namen vorbelegen beim Anlegen (SAP-Varianten)
      g_dynpro200-name = g_viewvar-fvariantid.
      CLEAR g_dynpro200-bezeich.
    ENDIF.

*   Domäne auslesen
    PERFORM get_domain_value_desc(sapmn1pa) USING
                        'NVIEWTYPE'
                        g_view-viewtype
                        l_desc.

    g_dynpro200-viewtype = l_desc.
    g_dynpro200-viewid  = g_view-viewid.
    g_dynpro200-viewbez = g_v_nwview-txt.

*   Einige Felder sollen nicht angezeigt werden
    PERFORM modify_screen.

*    g_first_time_warning = true.
    g_first_time_200 = off.
  ENDIF.

ENDFORM.                    " INIT_CUA_D200

*&---------------------------------------------------------------------*
*&      Form  VERBUCHEN_FVAR
*&---------------------------------------------------------------------*
*       Sichern (Verbuchen) einer Funktionsvariante
*----------------------------------------------------------------------*
FORM verbuchen_fvar USING value(p_viewtype)    LIKE nwview-viewtype
                          value(p_fvar)        LIKE nwfvar-fvar
*                          value(p_txt)         LIKE nwfvart-txt
                          value(p_update_task) TYPE ish_on_off
                          value(p_translation) TYPE ish_on_off.

* Verbucher tabellen
* vnwfvar
  DATA: lt_o_vnwfvar LIKE TABLE OF vnwfvar WITH HEADER LINE,
        lt_n_vnwfvar LIKE TABLE OF vnwfvar WITH HEADER LINE.
* vnwfvart
  DATA: lt_o_vnwfvart LIKE TABLE OF vnwfvart WITH HEADER LINE,
        lt_n_vnwfvart LIKE TABLE OF vnwfvart WITH HEADER LINE.
* vnwbutton
  DATA: lt_o_vnwbutton LIKE TABLE OF vnwbutton WITH HEADER LINE,
        lt_n_vnwbutton LIKE TABLE OF vnwbutton WITH HEADER LINE.
* vnwbuttont
  DATA: lt_o_vnwbuttont LIKE TABLE OF vnwbuttont WITH HEADER LINE,
        lt_n_vnwbuttont LIKE TABLE OF vnwbuttont WITH HEADER LINE.
* vnwfvarp
  DATA: lt_o_vnwfvarp LIKE TABLE OF vnwfvarp WITH HEADER LINE,
        lt_n_vnwfvarp LIKE TABLE OF vnwfvarp WITH HEADER LINE.
* vnwfvarpt
  DATA: lt_o_vnwfvarpt LIKE TABLE OF vnwfvarpt WITH HEADER LINE,
        lt_n_vnwfvarpt LIKE TABLE OF vnwfvarpt WITH HEADER LINE.

  DATA: l_wa_vnwfvar        LIKE vnwfvar.
  DATA: l_wa_vnwfvart       LIKE vnwfvart.
  DATA: l_wa_vnwbutton      LIKE vnwbutton.
  DATA: l_wa_vnwbuttont     LIKE vnwbuttont.
  DATA: l_wa_vnwfvarp       LIKE vnwfvarp.
  DATA: l_wa_vnwfvarpt      LIKE vnwfvarpt.

  DATA: l_wa_v_nwfvar   LIKE v_nwfvar.
  DATA: l_wa_v_nwbutton LIKE v_nwbutton.
  DATA: l_wa_v_nwfvarp  LIKE v_nwfvarp.
  DATA: l_wa_nwfvar     LIKE nwfvar.
  DATA: l_wa_nwfvart    LIKE nwfvart.
*  DATA: l_wa_nwbutton   LIKE nwbutton.
*  DATA: l_wa_nwbuttont  LIKE nwbuttont.
*  DATA: l_wa_nwfvarp    LIKE nwfvarp.
*  DATA: l_wa_nwfvarpt   LIKE nwfvarpt.
*
*  DATA: lt_v_nwbutton   TYPE TABLE OF v_nwbutton,           " ID 11754
*        l_v_nwbutton    LIKE LINE OF lt_v_nwbutton.         " ID 11754
*  DATA: lt_v_nwfvarp    TYPE TABLE OF v_nwfvarp,            " ID 11754
*        l_v_nwfvarp     LIKE LINE OF lt_v_nwfvarp.          " ID 11754

  DATA: lt_tmp_nwbutton TYPE STANDARD TABLE OF nwbutton.
  DATA: l_wa_tmp_nwbutton LIKE nwbutton.
  DATA: lt_tmp_nwbuttont TYPE STANDARD TABLE OF nwbuttont.
  DATA: l_wa_tmp_nwbuttont LIKE nwbuttont.
  DATA: lt_tmp_nwfvarp TYPE STANDARD TABLE OF nwfvarp.
  DATA: l_wa_tmp_nwfvarp LIKE nwfvarp.
  DATA: lt_tmp_nwfvarpt TYPE STANDARD TABLE OF nwfvarpt.
  DATA: l_wa_tmp_nwfvarpt LIKE nwfvarpt.

  DATA: lt_tmp_v_nwfvarp TYPE STANDARD TABLE OF v_nwfvarp,    "MED-32254
        ls_tmp_v_nwfvarp TYPE v_nwfvarp,                      "MED-32254
        lt_tmp_v_nwbutton TYPE STANDARD TABLE OF v_nwbutton,  "MED-32254
        ls_tmp_v_nwbutton TYPE v_nwbutton.                    "MED-32254

  CLEAR: lt_o_vnwfvar,      lt_n_vnwfvar.
  CLEAR: lt_o_vnwfvart,     lt_n_vnwfvart.
  CLEAR: lt_o_vnwbutton,    lt_n_vnwbutton.
  CLEAR: lt_o_vnwbuttont,   lt_n_vnwbuttont.
  CLEAR: lt_o_vnwfvarp,     lt_n_vnwfvarp.
  CLEAR: lt_o_vnwfvarpt,    lt_n_vnwfvarpt.
  CLEAR: ls_tmp_v_nwfvarp,  ls_tmp_v_nwbutton.                "MED-32254

  REFRESH: lt_o_vnwfvar,    lt_n_vnwfvar.
  REFRESH: lt_o_vnwfvart,   lt_n_vnwfvart.
  REFRESH: lt_o_vnwbutton,  lt_n_vnwbutton.
  REFRESH: lt_o_vnwbuttont, lt_n_vnwbuttont.
  REFRESH: lt_o_vnwfvarp,   lt_n_vnwfvarp.
  REFRESH: lt_o_vnwfvarpt,  lt_n_vnwfvarpt.
  REFRESH: lt_tmp_v_nwfvarp, lt_tmp_v_nwbutton.               "MED-32254

*  REFRESH: lt_v_nwbutton, lt_v_nwfvarp.                     " ID 11754

* nwfvar alte daten lesen ---------------------------------
  SELECT SINGLE * FROM nwfvar INTO l_wa_nwfvar
                       WHERE fvar     =  p_fvar
                       AND   viewtype =  p_viewtype.
* daten gefunden
  IF sy-subrc = 0.
*   in die old liste stellen
    CLEAR l_wa_vnwfvar.
    l_wa_vnwfvar-viewtype  = l_wa_nwfvar-viewtype.
    l_wa_vnwfvar-fvar      = l_wa_nwfvar-fvar.
    APPEND l_wa_vnwfvar TO lt_o_vnwfvar.
*   update setzen
    CLEAR l_wa_vnwfvar.
    CLEAR l_wa_v_nwfvar.
    READ TABLE gt_nwfvar INTO l_wa_v_nwfvar INDEX 1.
    l_wa_vnwfvar-viewtype  = l_wa_v_nwfvar-viewtype.
    l_wa_vnwfvar-fvar      = l_wa_v_nwfvar-fvar.
    l_wa_vnwfvar-kz        = 'U'.
    APPEND l_wa_vnwfvar TO lt_n_vnwfvar.
  ELSE.                "  insert setzen
    CLEAR l_wa_vnwfvar.
    CLEAR l_wa_v_nwfvar.
    READ TABLE gt_nwfvar INTO l_wa_v_nwfvar INDEX 1.
    l_wa_vnwfvar-viewtype  = l_wa_v_nwfvar-viewtype.
    l_wa_vnwfvar-fvar      = l_wa_v_nwfvar-fvar.
    l_wa_vnwfvar-kz        = 'I'.
    APPEND l_wa_vnwfvar TO lt_n_vnwfvar.
  ENDIF.

* nwfvart alte daten lesen ---------------------------------
  SELECT SINGLE * FROM nwfvart INTO l_wa_nwfvart
                       WHERE fvar     =  p_fvar
                       AND   viewtype =  p_viewtype
                       AND   spras    =  sy-langu.          " ID 11754
* daten gefunden
  IF sy-subrc = 0.
*   in die old liste stellen
    CLEAR l_wa_vnwfvart.
    l_wa_vnwfvart-viewtype  = l_wa_nwfvart-viewtype.
    l_wa_vnwfvart-fvar      = l_wa_nwfvart-fvar.
    l_wa_vnwfvart-spras     = l_wa_nwfvart-spras.
    l_wa_vnwfvart-txt       = l_wa_nwfvart-txt.
    APPEND l_wa_vnwfvart TO lt_o_vnwfvart.
*   update setzen
    CLEAR l_wa_vnwfvart.
    CLEAR l_wa_v_nwfvar.
    READ TABLE gt_nwfvar INTO l_wa_v_nwfvar INDEX 1.
    l_wa_vnwfvart-viewtype  = l_wa_v_nwfvar-viewtype.
    l_wa_vnwfvart-fvar      = l_wa_v_nwfvar-fvar.
    l_wa_vnwfvart-spras     = sy-langu.
    l_wa_vnwfvart-txt       = l_wa_v_nwfvar-txt.
    l_wa_vnwfvart-kz        = 'U'.
    APPEND l_wa_vnwfvart TO lt_n_vnwfvart.
  ELSE.           " insert setzen
    CLEAR l_wa_vnwfvart.
    CLEAR l_wa_v_nwfvar.
    READ TABLE gt_nwfvar INTO l_wa_v_nwfvar INDEX 1.
    l_wa_vnwfvart-viewtype  = l_wa_v_nwfvar-viewtype.
    l_wa_vnwfvart-fvar      = l_wa_v_nwfvar-fvar.
    l_wa_vnwfvart-spras     = sy-langu.
    l_wa_vnwfvart-txt       = l_wa_v_nwfvar-txt.
    l_wa_vnwfvart-kz        = 'I'.
    APPEND l_wa_vnwfvart TO lt_n_vnwfvart.
  ENDIF.

* nwbutton alte daten lesen ------------------------------------
  SELECT * FROM nwbutton INTO TABLE lt_tmp_nwbutton
                         WHERE viewtype = p_viewtype
                         AND   fvar     = p_fvar.

* nwbuttont alte daten lesen ------------------------------------
  SELECT * FROM nwbuttont INTO TABLE lt_tmp_nwbuttont "#EC CI_NOFIRST
                         WHERE viewtype = p_viewtype
                         AND   fvar     = p_fvar.

  SELECT * FROM v_nwbutton INTO TABLE lt_tmp_v_nwbutton
                         WHERE viewtype = p_viewtype
                         AND   fvar     = p_fvar.                "MED-32254

  DELETE lt_tmp_v_nwbutton WHERE spras = sy-langu.               "MED-32254

** ID 11754: gegencheck mit der DB -> nur bei änderung updaten
*  LOOP AT lt_tmp_nwbutton INTO l_wa_tmp_nwbutton.
*    READ TABLE lt_tmp_nwbuttont INTO l_wa_tmp_nwbuttont
*               WITH KEY viewtype = l_wa_tmp_nwbutton-viewtype
*                        fvar     = l_wa_tmp_nwbutton-fvar
*                        buttonnr = l_wa_tmp_nwbutton-buttonnr
*                        spras    = sy-langu.
*    CHECK sy-subrc = 0.
*    CLEAR l_v_nwbutton.
*    MOVE-CORRESPONDING l_wa_tmp_nwbuttont TO l_v_nwbutton.
*    MOVE-CORRESPONDING l_wa_tmp_nwbutton  TO l_v_nwbutton.
*    APPEND l_v_nwbutton TO lt_v_nwbutton.
*  ENDLOOP.
*  LOOP AT lt_v_nwbutton INTO l_v_nwbutton.
*    READ TABLE gt_nwbutton INTO l_wa_v_nwbutton
*               WITH KEY viewtype = l_v_nwbutton-viewtype
*                        fvar     = l_v_nwbutton-fvar
*                        buttonnr = l_v_nwbutton-buttonnr.
*    CHECK sy-subrc = 0.
*    l_wa_v_nwbutton-mandt = sy-mandt.
*    IF l_v_nwbutton = l_wa_v_nwbutton.
**     keine änderung -> daher nicht updaten!
*      DELETE gt_nwbutton WHERE viewtype = l_v_nwbutton-viewtype
*                           AND fvar     = l_v_nwbutton-fvar
*                           AND buttonnr = l_v_nwbutton-buttonnr.
*      DELETE lt_tmp_nwbutton
*             WHERE viewtype = l_v_nwbutton-viewtype
*               AND fvar     = l_v_nwbutton-fvar
*               AND buttonnr = l_v_nwbutton-buttonnr.
*      DELETE lt_tmp_nwbuttont
*             WHERE viewtype = l_v_nwbutton-viewtype
*               AND fvar     = l_v_nwbutton-fvar
*               AND buttonnr = l_v_nwbutton-buttonnr.
*      DELETE lt_v_nwbutton.
*    ENDIF.
*  ENDLOOP.

* in translation mode the the buttons and menu-functions can not be
* changed (only translation of texts is allowed); so buttons must not
* be saved
*  IF p_translation = off.                  "REM MED 32254
*   alte nwbutton-daten gefunden?
    DESCRIBE TABLE lt_tmp_nwbutton.
    IF sy-tfill > 0.
      CLEAR l_wa_tmp_nwbutton.
      LOOP AT lt_tmp_nwbutton INTO l_wa_tmp_nwbutton.
        CLEAR l_wa_vnwbutton.
*       in die old liste stellen
        MOVE-CORRESPONDING l_wa_tmp_nwbutton TO l_wa_vnwbutton.
        APPEND l_wa_vnwbutton TO lt_o_vnwbutton.
*       in die new liste mit kz D stellen
        l_wa_vnwbutton-kz = 'D'.
        APPEND l_wa_vnwbutton TO lt_n_vnwbutton.
      ENDLOOP.
    ENDIF.
*   neue werte in die liste mit kz I stellen
    CLEAR l_wa_v_nwbutton.
    LOOP AT gt_nwbutton INTO l_wa_v_nwbutton.
      CLEAR l_wa_vnwbutton.
      l_wa_vnwbutton-viewtype = l_wa_v_nwbutton-viewtype.
      l_wa_vnwbutton-fvar     = l_wa_v_nwbutton-fvar.
      l_wa_vnwbutton-buttonnr = l_wa_v_nwbutton-buttonnr.
      l_wa_vnwbutton-icon     = l_wa_v_nwbutton-icon.
      l_wa_vnwbutton-fcode    = l_wa_v_nwbutton-fcode.
      l_wa_vnwbutton-dbclk    = l_wa_v_nwbutton-dbclk.
      l_wa_vnwbutton-fkey     = l_wa_v_nwbutton-fkey.       " ID 10202
      l_wa_vnwbutton-kz       = 'I'.
      APPEND l_wa_vnwbutton TO lt_n_vnwbutton.
    ENDLOOP.
*  ENDIF.                                  "REM MED 32254

*  IF p_translation = off.                 "REM MED 32254
* alte nwbuttont-daten gefunden?
    DESCRIBE TABLE lt_tmp_nwbuttont.
    IF sy-tfill > 0.
      CLEAR l_wa_tmp_nwbuttont.
      LOOP AT lt_tmp_nwbuttont INTO l_wa_tmp_nwbuttont.
        CLEAR l_wa_vnwbuttont.
*     in die old liste stellen
        MOVE-CORRESPONDING l_wa_tmp_nwbuttont TO l_wa_vnwbuttont.
        APPEND l_wa_vnwbuttont TO lt_o_vnwbuttont.
*     in die new liste mit kz D stellen
        l_wa_vnwbuttont-kz = 'D'.
        APPEND l_wa_vnwbuttont TO lt_n_vnwbuttont.
      ENDLOOP.
    ENDIF.
*  ENDIF.                                "REM MED 32254
* neue werte in die liste mit kz I stellen
  CLEAR l_wa_v_nwbutton.
  LOOP AT gt_nwbutton INTO l_wa_v_nwbutton.
    CLEAR l_wa_vnwbuttont.
    l_wa_vnwbuttont-viewtype  = l_wa_v_nwbutton-viewtype.
    l_wa_vnwbuttont-fvar      = l_wa_v_nwbutton-fvar.
    l_wa_vnwbuttont-buttonnr  = l_wa_v_nwbutton-buttonnr.
    l_wa_vnwbuttont-spras     = sy-langu.
    l_wa_vnwbuttont-icon_q    = l_wa_v_nwbutton-icon_q.
    l_wa_vnwbuttont-buttontxt = l_wa_v_nwbutton-buttontxt.
*    IF p_translation = off.                "REM MED 32254
      l_wa_vnwbuttont-kz      = 'I'.
*    ELSE.                                   "REM MED 32254
*      READ TABLE lt_tmp_nwbuttont INTO l_wa_tmp_nwbuttont
*           WITH KEY viewtype = l_wa_v_nwbutton-viewtype
*                    fvar     = l_wa_v_nwbutton-fvar
*                    buttonnr = l_wa_v_nwbutton-buttonnr
*                    spras    = sy-langu.
*      IF sy-subrc = 0.
*        l_wa_vnwbuttont-kz    = 'U'.
*      ELSE.
*        l_wa_vnwbuttont-kz    = 'I'.
*      ENDIF.
*    ENDIF.                                  "REM MED 32254
    APPEND l_wa_vnwbuttont TO lt_n_vnwbuttont.
**   ID 11754: ev. gleichgebliebene Button-Einträge anderer Sprachen
**             ebenfalls wieder (mit ursprünglichem Text) insertieren
*    READ TABLE lt_tmp_nwbutton INTO l_wa_tmp_nwbutton
*               WITH KEY viewtype = l_wa_v_nwbutton-viewtype
*                        fvar     = l_wa_v_nwbutton-fvar
*                        buttonnr = l_wa_v_nwbutton-buttonnr.
*    IF sy-subrc = 0 AND
*       l_wa_v_nwbutton-fcode = l_wa_tmp_nwbutton-fcode.
*      LOOP AT lt_tmp_nwbuttont INTO l_wa_tmp_nwbuttont
*              WHERE viewtype = l_wa_v_nwbutton-viewtype
*                AND fvar     = l_wa_v_nwbutton-fvar
*                AND buttonnr = l_wa_v_nwbutton-buttonnr
*                AND spras   <> sy-langu.
*        CLEAR l_wa_vnwbuttont.
*        l_wa_vnwbuttont-viewtype  = l_wa_v_nwbutton-viewtype.
*        l_wa_vnwbuttont-fvar      = l_wa_v_nwbutton-fvar.
*        l_wa_vnwbuttont-buttonnr  = l_wa_v_nwbutton-buttonnr.
*        l_wa_vnwbuttont-spras     = l_wa_tmp_nwbuttont-spras.
*        l_wa_vnwbuttont-icon_q    = l_wa_tmp_nwbuttont-icon_q.
*        l_wa_vnwbuttont-buttontxt = l_wa_tmp_nwbuttont-buttontxt.
*        l_wa_vnwbuttont-kz        = 'I'.
*        APPEND l_wa_vnwbuttont TO lt_n_vnwbuttont.
*      ENDLOOP.
*    ENDIF.
*     BEGIN BM MED-32254
      LOOP AT lt_tmp_v_nwbutton INTO ls_tmp_v_nwbutton
              WHERE viewtype = l_wa_v_nwbutton-viewtype
                AND fvar     = l_wa_v_nwbutton-fvar
                AND fcode = l_wa_v_nwbutton-fcode.
        CLEAR l_wa_vnwbuttont.
        l_wa_vnwbuttont-viewtype  = l_wa_v_nwbutton-viewtype.
        l_wa_vnwbuttont-fvar      = l_wa_v_nwbutton-fvar.
        l_wa_vnwbuttont-buttonnr  = l_wa_v_nwbutton-buttonnr.
        l_wa_vnwbuttont-spras     = ls_tmp_v_nwbutton-spras.
        l_wa_vnwbuttont-icon_q    = ls_tmp_v_nwbutton-icon_q.
        l_wa_vnwbuttont-buttontxt = ls_tmp_v_nwbutton-buttontxt.
        l_wa_vnwbuttont-kz        = 'I'.
        APPEND l_wa_vnwbuttont TO lt_n_vnwbuttont.
*       MED-33775: make sure to do not duplicate seperator entries
        IF l_wa_v_nwbutton-fcode IS INITIAL.         " MED-33775
          EXIT.                                      " MED-33775
        ENDIF.                                       " MED-33775
      ENDLOOP.
*     END BM MED-32254
  ENDLOOP.

* nwfvarp alte daten lesen ------------------------------------
  SELECT * FROM nwfvarp INTO TABLE lt_tmp_nwfvarp
                         WHERE viewtype = p_viewtype
                         AND   fvar     = p_fvar.

* nwfvarpt alte daten lesen ------------------------------------
  SELECT * FROM nwfvarpt INTO TABLE lt_tmp_nwfvarpt "#EC CI_NOFIRST
                         WHERE viewtype = p_viewtype
                         AND   fvar     = p_fvar.

  SELECT * FROM v_nwfvarp INTO TABLE lt_tmp_v_nwfvarp
                         WHERE viewtype = p_viewtype
                         AND   fvar     = p_fvar.             "MED-32254

  DELETE lt_tmp_v_nwfvarp WHERE spras = sy-langu.             "MED-32254

** ID 11754: gegencheck mit der DB -> nur bei änderung updaten
*  LOOP AT lt_tmp_nwfvarp INTO l_wa_tmp_nwfvarp.
*    READ TABLE lt_tmp_nwfvarpt INTO l_wa_tmp_nwfvarpt
*               WITH KEY viewtype = l_wa_tmp_nwfvarp-viewtype
*                        fvar     = l_wa_tmp_nwfvarp-fvar
*                        buttonnr = l_wa_tmp_nwfvarp-buttonnr
*                        lfdnr    = l_wa_tmp_nwfvarp-lfdnr
*                        spras    = sy-langu.
*    CHECK sy-subrc = 0.
*    CLEAR l_v_nwfvarp.
*    MOVE-CORRESPONDING l_wa_tmp_nwfvarpt TO l_v_nwfvarp.
*    MOVE-CORRESPONDING l_wa_tmp_nwfvarp  TO l_v_nwfvarp.
*    APPEND l_v_nwfvarp TO lt_v_nwfvarp.
*  ENDLOOP.
*  LOOP AT lt_v_nwfvarp INTO l_v_nwfvarp.
*    READ TABLE gt_nwfvarp INTO l_wa_v_nwfvarp
*               WITH KEY viewtype = l_v_nwfvarp-viewtype
*                        fvar     = l_v_nwfvarp-fvar
*                        buttonnr = l_v_nwfvarp-buttonnr
*                        lfdnr    = l_v_nwfvarp-lfdnr.
*    CHECK sy-subrc = 0.
*    l_wa_v_nwfvarp-mandt = sy-mandt.
*    IF l_v_nwfvarp = l_wa_v_nwfvarp.
**     keine änderung -> daher nicht updaten!
*      DELETE gt_nwfvarp WHERE viewtype = l_v_nwfvarp-viewtype
*                          AND fvar     = l_v_nwfvarp-fvar
*                          AND buttonnr = l_v_nwfvarp-buttonnr
*                          AND lfdnr    = l_v_nwfvarp-lfdnr.
*      DELETE lt_tmp_nwfvarp
*             WHERE viewtype = l_v_nwfvarp-viewtype
*               AND fvar     = l_v_nwfvarp-fvar
*               AND buttonnr = l_v_nwfvarp-buttonnr
*               AND lfdnr    = l_v_nwfvarp-lfdnr.
*      DELETE lt_tmp_nwfvarpt
*             WHERE viewtype = l_v_nwfvarp-viewtype
*               AND fvar     = l_v_nwfvarp-fvar
*               AND buttonnr = l_v_nwfvarp-buttonnr
*               AND lfdnr    = l_v_nwfvarp-lfdnr.
*      DELETE lt_v_nwfvarp.
*    ENDIF.
*  ENDLOOP.

* in translation mode the the buttons and menu-functions can not be
* changed (only translation of texts is allowed); so menu-functions
* must not be saved
*  IF p_translation = off.                  "REM MED 32254
*   alte nwfvarp-daten gefunden?
    DESCRIBE TABLE lt_tmp_nwfvarp.
    IF sy-tfill > 0.
      CLEAR l_wa_tmp_nwfvarp.
      LOOP AT lt_tmp_nwfvarp INTO l_wa_tmp_nwfvarp.
        CLEAR l_wa_vnwfvarp.
*       in die old liste stellen
        MOVE-CORRESPONDING l_wa_tmp_nwfvarp TO l_wa_vnwfvarp.
        APPEND l_wa_vnwfvarp TO lt_o_vnwfvarp.
*       in die new liste mit kz D stellen
        l_wa_vnwfvarp-kz = 'D'.
        APPEND l_wa_vnwfvarp TO lt_n_vnwfvarp.
      ENDLOOP.
    ENDIF.
*   neue werte in die liste mit kz I stellen
    CLEAR l_wa_v_nwfvarp.
    LOOP AT gt_nwfvarp INTO l_wa_v_nwfvarp.
      CLEAR l_wa_vnwfvarp.
      l_wa_vnwfvarp-viewtype = l_wa_v_nwfvarp-viewtype.
      l_wa_vnwfvarp-fvar     = l_wa_v_nwfvarp-fvar.
      l_wa_vnwfvarp-buttonnr = l_wa_v_nwfvarp-buttonnr.
      l_wa_vnwfvarp-lfdnr    = l_wa_v_nwfvarp-lfdnr.
      l_wa_vnwfvarp-fcode    = l_wa_v_nwfvarp-fcode.
      l_wa_vnwfvarp-dbclk    = l_wa_v_nwfvarp-dbclk.
      l_wa_vnwfvarp-tb_butt  = l_wa_v_nwfvarp-tb_butt.
      l_wa_vnwfvarp-fkey     = l_wa_v_nwfvarp-fkey.         " ID 10202
      l_wa_vnwfvarp-kz       = 'I'.
      APPEND l_wa_vnwfvarp TO lt_n_vnwfvarp.
    ENDLOOP.
*  ENDIF.                                      "REM MED 32254

*  IF p_translation = off.                     "REM MED 32254
*   alte nwfvarpt-daten gefunden?
    DESCRIBE TABLE lt_tmp_nwfvarpt.
    IF sy-tfill > 0.
      CLEAR l_wa_tmp_nwfvarpt.
      LOOP AT lt_tmp_nwfvarpt INTO l_wa_tmp_nwfvarpt.
        CLEAR l_wa_vnwfvarpt.
*     in die old liste stellen
        MOVE-CORRESPONDING l_wa_tmp_nwfvarpt TO l_wa_vnwfvarpt.
        APPEND l_wa_vnwfvarpt TO lt_o_vnwfvarpt.
*     in die new liste mit kz D stellen
        l_wa_vnwfvarpt-kz = 'D'.
        APPEND l_wa_vnwfvarpt TO lt_n_vnwfvarpt.
      ENDLOOP.
    ENDIF.
*  ENDIF.                                        "REM MED 32254
* neue werte in die liste mit kz I stellen
  CLEAR l_wa_v_nwfvarp.
  LOOP AT gt_nwfvarp INTO l_wa_v_nwfvarp.
    CLEAR l_wa_vnwfvarpt.
    l_wa_vnwfvarpt-viewtype = l_wa_v_nwfvarp-viewtype.
    l_wa_vnwfvarpt-fvar     = l_wa_v_nwfvarp-fvar.
    l_wa_vnwfvarpt-buttonnr = l_wa_v_nwfvarp-buttonnr.
    l_wa_vnwfvarpt-lfdnr    = l_wa_v_nwfvarp-lfdnr.
    l_wa_vnwfvarpt-spras    = sy-langu.
    l_wa_vnwfvarpt-txt      = l_wa_v_nwfvarp-txt.
*    IF p_translation = off.              "REM MED 32254
      l_wa_vnwfvarpt-kz     = 'I'.
*    ELSE.                                "REM MED 32254
*      READ TABLE lt_tmp_nwfvarpt INTO l_wa_tmp_nwfvarpt
*           WITH KEY viewtype = l_wa_v_nwfvarp-viewtype
*                    fvar     = l_wa_v_nwfvarp-fvar
*                    buttonnr = l_wa_v_nwfvarp-buttonnr
*                    lfdnr    = l_wa_v_nwfvarp-lfdnr
*                    spras    = sy-langu.
*      IF sy-subrc = 0.
*        l_wa_vnwfvarpt-kz   = 'U'.
*      ELSE.
*        l_wa_vnwfvarpt-kz   = 'I'.
*      ENDIF.
*    ENDIF.                              "REM MED 32254
    APPEND l_wa_vnwfvarpt TO lt_n_vnwfvarpt.
**   ID 11754: ev. gleichgebliebene Funktions-Einträge anderer Sprachen
**             ebenfalls wieder (mit ursprünglichem Text) insertieren
*    READ TABLE lt_tmp_nwfvarp INTO l_wa_tmp_nwfvarp
*               WITH KEY viewtype = l_wa_v_nwfvarp-viewtype
*                        fvar     = l_wa_v_nwfvarp-fvar
*                        buttonnr = l_wa_v_nwfvarp-buttonnr
*                        lfdnr    = l_wa_v_nwfvarp-lfdnr.
*    IF sy-subrc = 0 AND
*       l_wa_v_nwfvarp-fcode = l_wa_tmp_nwfvarp-fcode.
*      LOOP AT lt_tmp_nwfvarpt INTO l_wa_tmp_nwfvarpt
*              WHERE viewtype = l_wa_v_nwfvarp-viewtype
*                AND fvar     = l_wa_v_nwfvarp-fvar
*                AND buttonnr = l_wa_v_nwfvarp-buttonnr
*                AND lfdnr    = l_wa_v_nwfvarp-lfdnr
*                AND spras   <> sy-langu.
*        CLEAR l_wa_vnwfvarpt.
*        l_wa_vnwfvarpt-viewtype = l_wa_v_nwfvarp-viewtype.
*        l_wa_vnwfvarpt-fvar     = l_wa_v_nwfvarp-fvar.
*        l_wa_vnwfvarpt-buttonnr = l_wa_v_nwfvarp-buttonnr.
*        l_wa_vnwfvarpt-lfdnr    = l_wa_v_nwfvarp-lfdnr.
*        l_wa_vnwfvarpt-spras    = l_wa_tmp_nwfvarpt-spras.
*        l_wa_vnwfvarpt-txt      = l_wa_tmp_nwfvarpt-txt.
*        l_wa_vnwfvarpt-kz       = 'I'.
*        APPEND l_wa_vnwfvarpt TO lt_n_vnwfvarpt.
*      ENDLOOP.
*    ENDIF.
*    BEGIN BM MED-32254
     LOOP AT lt_tmp_v_nwfvarp INTO ls_tmp_v_nwfvarp
              WHERE viewtype = l_wa_v_nwfvarp-viewtype
                AND fvar     = l_wa_v_nwfvarp-fvar
                AND fcode    = l_wa_v_nwfvarp-fcode
                AND lfdnr    = l_wa_v_nwfvarp-lfdnr.
        CLEAR l_wa_vnwfvarpt.
        l_wa_vnwfvarpt-viewtype = l_wa_v_nwfvarp-viewtype.
        l_wa_vnwfvarpt-fvar     = l_wa_v_nwfvarp-fvar.
        l_wa_vnwfvarpt-buttonnr = l_wa_v_nwfvarp-buttonnr.
        l_wa_vnwfvarpt-lfdnr    = l_wa_v_nwfvarp-lfdnr.
        l_wa_vnwfvarpt-spras    = ls_tmp_v_nwfvarp-spras.
        l_wa_vnwfvarpt-txt      = ls_tmp_v_nwfvarp-txt.
        l_wa_vnwfvarpt-kz       = 'I'.
        APPEND l_wa_vnwfvarpt TO lt_n_vnwfvarpt.
*       MED-33775: make sure to do not duplicate seperator entries
        IF l_wa_v_nwfvarp-fcode IS INITIAL.          " MED-33775
          EXIT.                                      " MED-33775
        ENDIF.                                       " MED-33775
      ENDLOOP.
*     END BM MED-32254
  ENDLOOP.

* Verbucher aufrufen
  PERFORM call_verbucher TABLES lt_n_vnwfvar    lt_o_vnwfvar
                                lt_n_vnwfvart   lt_o_vnwfvart
                                lt_n_vnwfvarp   lt_o_vnwfvarp
                                lt_n_vnwfvarpt  lt_o_vnwfvarpt
                                lt_n_vnwbutton  lt_o_vnwbutton
                                lt_n_vnwbuttont lt_o_vnwbuttont
                         USING  p_update_task.

ENDFORM.                    " VERBUCHEN_FVAR

*&---------------------------------------------------------------------*
*&      Form  CHECK_FVAR_NAME
*&---------------------------------------------------------------------*
*       Prüfung Name der Funktionsvariante beim Sichern
*----------------------------------------------------------------------*
FORM check_fvar_name USING    value(p_fvarid)      LIKE nwfvar-fvar
                              value(p_direct_msg)  TYPE ish_on_off
                     CHANGING p_rc                 TYPE sy-subrc.

  DATA: l_allowed,
        tablekey   LIKE  e071k-tabkey,
        tablename  LIKE  tresc-tabname,
        fieldname  LIKE  tresc-fieldname.

  CLEAR p_rc.

  CHECK NOT p_fvarid IS INITIAL.

  CHECK g_system_sap = off.   " Prüfung nur auf Kundensystemen ID 7947

  MOVE: p_fvarid TO tablekey,
        'NWFVAR' TO tablename,
        'FVAR'   TO fieldname.

  CALL FUNCTION 'CHECK_CUSTOMER_NAME_FIELD'
       EXPORTING
*     OBJECTTYPE            = 'TABU'
           tablekey              = tablekey
           tablename             = tablename
           fieldname             = fieldname
      IMPORTING
           keyfield_allowed      = l_allowed
*     SYSTEM_SAP            =
*     TABLE_NOT_FOUND       =
*     RESERVED_IN_TRESC     =
      EXCEPTIONS
           objecttype_not_filled = 1
           tablename_not_filled  = 2
           fieldname_not_filled  = 3
           OTHERS                = 4.                       "#EC *
  IF sy-subrc <> 0.
  ENDIF.

  IF l_allowed <> 'X'.
*    if g_first_time_warning = true.
    IF p_direct_msg = on.
*      Von SAP ausgelieferte Funkt.var. dürfen nicht geändert werden
*      g_first_time_warning = false.
      MESSAGE e365(nf1).
      CLEAR ok-code.
    ENDIF.
    p_rc = 1.
  ENDIF.

ENDFORM.                    " CHECK_FVAR_NAME

*&---------------------------------------------------------------------*
*&      Form  VERBUCHER_FVAR_DELETE
*&---------------------------------------------------------------------*
*       Aufruf der Verbucher für das Löschen einer Funktionsvariante
*----------------------------------------------------------------------*
*      --> PT_V_NWFVAR    Funktionsvariante (+ Text)
*      --> PT_V_NWFVARP   Funktionen zu Buttons (+ Text)
*      --> PT_V_NWBUTTON  Buttons (+ Text)
*      --> P_UPDATE_TASK  Verbuchung in update task ON/OFF
*----------------------------------------------------------------------*
FORM verbucher_fvar_delete TABLES pt_v_nwfvar   STRUCTURE v_nwfvar
                                  pt_v_nwfvarp  STRUCTURE v_nwfvarp
                                  pt_v_nwbutton STRUCTURE v_nwbutton
                           USING  value(p_update_task) TYPE ish_on_off.

  DATA: lt_o_nwfvar    LIKE TABLE OF vnwfvar,
        lt_n_nwfvar    LIKE TABLE OF vnwfvar,
        l_nwfvar       LIKE vnwfvar,
        lt_o_nwfvart   LIKE TABLE OF vnwfvart,
        lt_n_nwfvart   LIKE TABLE OF vnwfvart,
        l_nwfvart      LIKE vnwfvart,
        lt_o_nwfvarp   LIKE TABLE OF vnwfvarp,
        lt_n_nwfvarp   LIKE TABLE OF vnwfvarp,
        l_nwfvarp      LIKE vnwfvarp,
        lt_o_nwfvarpt  LIKE TABLE OF vnwfvarpt,
        lt_n_nwfvarpt  LIKE TABLE OF vnwfvarpt,
        l_nwfvarpt     LIKE vnwfvarpt,
        lt_o_nwbutton  LIKE TABLE OF vnwbutton,
        lt_n_nwbutton  LIKE TABLE OF vnwbutton,
        l_nwbutton     LIKE vnwbutton,
        lt_o_nwbuttont LIKE TABLE OF vnwbuttont,
        lt_n_nwbuttont LIKE TABLE OF vnwbuttont,
        l_nwbuttont    LIKE vnwbuttont,
        l_v_nwfvar     LIKE v_nwfvar,
        l_v_nwfvarp    LIKE v_nwfvarp,
        l_v_nwbutton   LIKE v_nwbutton.

  REFRESH: lt_o_nwfvar,    lt_n_nwfvar,
           lt_o_nwfvart,   lt_n_nwfvart,
           lt_o_nwfvarp,   lt_n_nwfvarp,
           lt_o_nwfvarpt,  lt_n_nwfvarpt,
           lt_o_nwbutton,  lt_n_nwbutton,
           lt_o_nwbuttont, lt_n_nwbuttont.

* Verbuchertabellen für das Löschen befüllen
  LOOP AT pt_v_nwfvar INTO l_v_nwfvar.
    MOVE-CORRESPONDING l_v_nwfvar TO l_nwfvar.              "#EC ENHOK
    MOVE-CORRESPONDING l_v_nwfvar TO l_nwfvart.             "#EC ENHOK
    APPEND l_nwfvar  TO lt_o_nwfvar.
    l_nwfvar-kz  = 'D'.
    APPEND l_nwfvar  TO lt_n_nwfvar.
    IF NOT l_nwfvart-spras IS INITIAL.
      APPEND l_nwfvart TO lt_o_nwfvart.
      l_nwfvart-kz = 'D'.
      APPEND l_nwfvart TO lt_n_nwfvart.
    ENDIF.
*   Texte in allen Sprachen löschen
    SELECT * FROM nwfvart INTO l_nwfvart "#EC CI_NOFIRST
           WHERE  viewtype  = l_nwfvar-viewtype
           AND    fvar      = l_nwfvar-fvar
           AND    spras    <> sy-langu.
      APPEND l_nwfvart TO lt_o_nwfvart.
      l_nwfvart-kz = 'D'.
      APPEND l_nwfvart TO lt_n_nwfvart.
    ENDSELECT.
  ENDLOOP.
  LOOP AT pt_v_nwfvarp INTO l_v_nwfvarp.
    MOVE-CORRESPONDING l_v_nwfvarp TO l_nwfvarp.            "#EC ENHOK
    MOVE-CORRESPONDING l_v_nwfvarp TO l_nwfvarpt.           "#EC ENHOK
    APPEND l_nwfvarp  TO lt_o_nwfvarp.
    l_nwfvarp-kz  = 'D'.
    APPEND l_nwfvarp  TO lt_n_nwfvarp.
    IF NOT l_nwfvarpt-spras IS INITIAL.
      APPEND l_nwfvarpt TO lt_o_nwfvarpt.
      l_nwfvarpt-kz = 'D'.
      APPEND l_nwfvarpt TO lt_n_nwfvarpt.
    ENDIF.
*   Texte in allen Sprachen löschen
    SELECT * FROM nwfvarpt INTO l_nwfvarpt "#EC CI_NOFIRST
           WHERE  viewtype  = l_nwfvarp-viewtype
           AND    fvar      = l_nwfvarp-fvar
           AND    buttonnr  = l_nwfvarp-buttonnr
           AND    lfdnr     = l_nwfvarp-lfdnr
           AND    spras    <> sy-langu.
      APPEND l_nwfvarpt TO lt_o_nwfvarpt.
      l_nwfvart-kz = 'D'.
      APPEND l_nwfvarpt TO lt_n_nwfvarpt.
    ENDSELECT.
  ENDLOOP.
  LOOP AT pt_v_nwbutton INTO l_v_nwbutton.
    MOVE-CORRESPONDING l_v_nwbutton TO l_nwbutton.          "#EC ENHOK
    MOVE-CORRESPONDING l_v_nwbutton TO l_nwbuttont.         "#EC ENHOK
    APPEND l_nwbutton  TO lt_o_nwbutton.
    l_nwbutton-kz  = 'D'.
    APPEND l_nwbutton  TO lt_n_nwbutton.
    IF NOT l_nwbuttont-spras IS INITIAL.
      APPEND l_nwbuttont TO lt_o_nwbuttont.
      l_nwbuttont-kz = 'D'.
      APPEND l_nwbuttont TO lt_n_nwbuttont.
    ENDIF.
*   Texte in allen Sprachen löschen
    SELECT * FROM nwbuttont INTO l_nwbuttont    "#EC CI_NOFIRST
           WHERE  viewtype  = l_nwbutton-viewtype
           AND    fvar      = l_nwbutton-fvar
           AND    buttonnr  = l_nwbutton-buttonnr
           AND    spras    <> sy-langu.
      APPEND l_nwbuttont TO lt_o_nwbuttont.
      l_nwbuttont-kz = 'D'.
      APPEND l_nwbuttont TO lt_n_nwbuttont.
    ENDSELECT.
  ENDLOOP.

* Verbucher aufrufen
  PERFORM call_verbucher TABLES lt_n_nwfvar    lt_o_nwfvar
                                lt_n_nwfvart   lt_o_nwfvart
                                lt_n_nwfvarp   lt_o_nwfvarp
                                lt_n_nwfvarpt  lt_o_nwfvarpt
                                lt_n_nwbutton  lt_o_nwbutton
                                lt_n_nwbuttont lt_o_nwbuttont
                         USING  p_update_task.

ENDFORM.                    " VERBUCHER_FVAR_DELETE

*&---------------------------------------------------------------------*
*&      Form  CALL_VERBUCHER
*&---------------------------------------------------------------------*
*       Verbucher für alle Daten der Funktionsvariante aufrufen
*----------------------------------------------------------------------*
FORM call_verbucher TABLES   pt_n_vnwfvar    STRUCTURE vnwfvar
                             pt_o_vnwfvar    STRUCTURE vnwfvar
                             pt_n_vnwfvart   STRUCTURE vnwfvart
                             pt_o_vnwfvart   STRUCTURE vnwfvart
                             pt_n_vnwfvarp   STRUCTURE vnwfvarp
                             pt_o_vnwfvarp   STRUCTURE vnwfvarp
                             pt_n_vnwfvarpt  STRUCTURE vnwfvarpt
                             pt_o_vnwfvarpt  STRUCTURE vnwfvarpt
                             pt_n_vnwbutton  STRUCTURE vnwbutton
                             pt_o_vnwbutton  STRUCTURE vnwbutton
                             pt_n_vnwbuttont STRUCTURE vnwbuttont
                             pt_o_vnwbuttont STRUCTURE vnwbuttont
                    USING    value(p_update_task) TYPE ish_on_off.

** vnwfvar---------------------------------------------
  DESCRIBE TABLE pt_n_vnwfvar.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWFVAR' IN UPDATE TASK
           EXPORTING
*         I_DATE     = SY-DATUM
          i_tcode    = sy-tcode
*         I_UNAME    = SY-UNAME
*         I_UTIME    = SY-UZEIT
           TABLES
                t_n_nwfvar     = pt_n_vnwfvar
                t_o_nwfvar     = pt_o_vnwfvar.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWFVAR'
           EXPORTING
*         I_DATE     = SY-DATUM
          i_tcode    = sy-tcode
*         I_UNAME    = SY-UNAME
*         I_UTIME    = SY-UZEIT
           TABLES
                t_n_nwfvar     = pt_n_vnwfvar
                t_o_nwfvar     = pt_o_vnwfvar.
    ENDIF.
  ENDIF.

* vnwfvart ---------------------------------------------
  DESCRIBE TABLE pt_n_vnwfvart.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWFVART' IN UPDATE TASK
           EXPORTING
*         I_DATE      = SY-DATUM
          i_tcode     = sy-tcode
*         I_UNAME     = SY-UNAME
*         I_UTIME     = SY-UZEIT
           TABLES
                t_n_nwfvart    = pt_n_vnwfvart
                t_o_nwfvart    = pt_o_vnwfvart.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWFVART'
           EXPORTING
*         I_DATE      = SY-DATUM
          i_tcode     = sy-tcode
*         I_UNAME     = SY-UNAME
*         I_UTIME     = SY-UZEIT
           TABLES
                t_n_nwfvart    = pt_n_vnwfvart
                t_o_nwfvart    = pt_o_vnwfvart.
    ENDIF.
  ENDIF.

* vnwbutton ---------------------------------------------
  DESCRIBE TABLE pt_n_vnwbutton.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWBUTTON' IN UPDATE TASK
           EXPORTING
*         I_DATE       = SY-DATUM
          i_tcode      = sy-tcode
*         I_UNAME      = SY-UNAME
*         I_UTIME      = SY-UZEIT
           TABLES
                t_n_nwbutton   = pt_n_vnwbutton
                t_o_nwbutton   = pt_o_vnwbutton.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWBUTTON'
           EXPORTING
*         I_DATE       = SY-DATUM
          i_tcode      = sy-tcode
*         I_UNAME      = SY-UNAME
*         I_UTIME      = SY-UZEIT
           TABLES
                t_n_nwbutton   = pt_n_vnwbutton
                t_o_nwbutton   = pt_o_vnwbutton.
    ENDIF.
  ENDIF.

* vnwbuttont ---------------------------------------------
  DESCRIBE TABLE pt_n_vnwbuttont.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWBUTTONT' IN UPDATE TASK
           EXPORTING
*         I_DATE        = SY-DATUM
          i_tcode       = sy-tcode
*         I_UNAME       = SY-UNAME
*         I_UTIME       = SY-UZEIT
           TABLES
                t_n_nwbuttont  = pt_n_vnwbuttont
                t_o_nwbuttont  = pt_o_vnwbuttont.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWBUTTONT'
           EXPORTING
*         I_DATE        = SY-DATUM
          i_tcode       = sy-tcode
*         I_UNAME       = SY-UNAME
*         I_UTIME       = SY-UZEIT
           TABLES
                t_n_nwbuttont  = pt_n_vnwbuttont
                t_o_nwbuttont  = pt_o_vnwbuttont.
    ENDIF.
  ENDIF.

* vnwfvarp ---------------------------------------------
  DESCRIBE TABLE pt_n_vnwfvarp.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWFVARP' IN UPDATE TASK
           EXPORTING
*         I_DATE      = SY-DATUM
          i_tcode     = sy-tcode
*         I_UNAME     = SY-UNAME
*         I_UTIME     = SY-UZEIT
           TABLES
                t_n_nwfvarp    = pt_n_vnwfvarp
                t_o_nwfvarp    = pt_o_vnwfvarp.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWFVARP'
           EXPORTING
*         I_DATE      = SY-DATUM
          i_tcode     = sy-tcode
*         I_UNAME     = SY-UNAME
*         I_UTIME     = SY-UZEIT
           TABLES
                t_n_nwfvarp    = pt_n_vnwfvarp
                t_o_nwfvarp    = pt_o_vnwfvarp.
    ENDIF.
  ENDIF.

* vnwfvarpt ---------------------------------------------
  DESCRIBE TABLE pt_n_vnwfvarpt.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION 'ISH_VERBUCHER_NWFVARPT' IN UPDATE TASK
           EXPORTING
*         I_DATE       = SY-DATUM
          i_tcode      = sy-tcode
*         I_UNAME      = SY-UNAME
*         I_UTIME      = SY-UZEIT
           TABLES
                t_n_nwfvarpt   = pt_n_vnwfvarpt
                t_o_nwfvarpt   = pt_o_vnwfvarpt.
    ELSE.
      CALL FUNCTION 'ISH_VERBUCHER_NWFVARPT'
           EXPORTING
*         I_DATE       = SY-DATUM
          i_tcode      = sy-tcode
*         I_UNAME      = SY-UNAME
*         I_UTIME      = SY-UZEIT
           TABLES
                t_n_nwfvarpt   = pt_n_vnwfvarpt
                t_o_nwfvarpt   = pt_o_vnwfvarpt.
    ENDIF.
  ENDIF.

ENDFORM.                    " CALL_VERBUCHER

*&---------------------------------------------------------------------*
*&      Form  NO_CHANGE_LINE_EDIT_TREE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM no_change_line_edit_tree.

  CLEAR g_dynpro-icon.

* Den Change-Button wieder ausblenden und die Felder löschen
  g_show_button_change = off.
  g_edit_mode          = off.
  g_cust_ins           = off.                               " ID 11731
  g_anythingchanged    = true.
  g_show_dbclk         = off.
  g_edit_iconbutton    = off.
  CLEAR g_dynpro.

  PERFORM modify_edittree.

ENDFORM.                    " NO_CHANGE_LINE_EDIT_TREE

*&---------------------------------------------------------------------*
*&      Form  OK_CODE_200
*&---------------------------------------------------------------------*
FORM ok_code_200.

  DATA: l_save_ok_code  LIKE ok-code.

  l_save_ok_code = ok-code.
  CLEAR ok-code.
  CLEAR g_okcode.

  CASE l_save_ok_code.
    WHEN 'TEST'.
*   Fertig
    WHEN 'ENTER' OR 'ECAN'.
      g_okcode = l_save_ok_code.
      SET SCREEN 0. LEAVE SCREEN.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.                    " OK_CODE_200
*&---------------------------------------------------------------------*
*&      Form  read_system
*&---------------------------------------------------------------------*
* Ermitteln, in welchem System man sich befindet
*---------------------------------------------------------------------
FORM read_system.

  DATA:  sap_cus(10)   TYPE  c.

  CALL 'C_SAPGPARAM' ID 'NAME'  FIELD 'transport/systemtype'
                     ID 'VALUE' FIELD sap_cus.
  CASE sap_cus.
    WHEN  'SAP'.
      g_system_sap = on.
    WHEN OTHERS.
      g_system_sap = off.
  ENDCASE.

ENDFORM.                               " read_system
