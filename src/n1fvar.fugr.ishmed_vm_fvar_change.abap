FUNCTION ishmed_vm_fvar_change.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEW) TYPE  NWVIEW
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_MODE) TYPE  N1FLD-N1MODE DEFAULT 'D'
*"     VALUE(I_VCODE) TYPE  ISH_VCODE DEFAULT 'UPD'
*"     VALUE(I_SAVE) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT ' '
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_CALLER) TYPE  SY-REPID OPTIONAL
*"     VALUE(I_READ_BUFFER) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_BUFFER) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_READ_VIEWVAR) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_FVARIANTID) TYPE  RNFVAR-FVARIANTID DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(E_VIEWVAR) TYPE  RNVIEWVAR
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------
  DATA: lt_message       TYPE tyt_messages,
        l_wa_msg         LIKE bapiret2,
        l_nwviewt        LIKE nwviewt,
        l_viewvar        LIKE rnviewvar,
        l_viewvar_old    TYPE rnviewvar.

  DATA: l_variantid      LIKE nwfvar-fvar,
        l_varianttxt     LIKE nwfvart-txt,
        l_wa_tmp_nwfvar  LIKE v_nwfvar,
        l_wa_tmp_nwfvarp LIKE v_nwfvarp,                    "#EC NEEDED
        l_wa_tmp_button  LIKE v_nwbutton,                   "#EC NEEDED
        l_mode_buf(1)    TYPE c,
        l_key            LIKE rnwp_gen_key-nwkey,
        l_vcode          TYPE ish_vcode.

  DATA: lt_nwfvar        LIKE gt_nwfvar,
        lt_nwbutton      LIKE gt_nwbutton,
        lt_nwfvarp       LIKE gt_nwfvarp.

* Initialisierung + Belegung globaler Variablen
  CLEAR: e_rc, l_viewvar, g_v_nwview.
  g_mode               = i_mode.
  g_view               = i_view.
*  g_caller             = i_caller.
  g_translation        = off.
  g_show_button_change = off.
  g_edit_iconbutton    = off.
  g_edit_mode          = off.
  g_show_dbclk         = off.
  REFRESH: gt_nwfvar, gt_nwfvarp, gt_nwbutton, t_messages.

* Sichttyp ist unbedingt erforderlich
  IF g_view-viewtype IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* viewtype 014 does not use function variants
  IF g_view-viewtype = '014' OR
     g_view-viewtype = '018'.                            "MED-33470
    e_rc = 1.
*   Funktionsvarianten werden für diesen Sichttyp nicht unterstützt
    PERFORM build_bapiret2(sapmn1pa)
            USING 'I' 'N1BASE' '037' space space space
                                     space space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    EXIT.
  ENDIF.

* Nur Verarbeitungscode INS und UPD erlaubt
  l_vcode = i_vcode.
  IF l_vcode <> g_vcode_insert AND l_vcode <> g_vcode_update.
    l_vcode = g_vcode_update.
  ENDIF.

  g_vcode = l_vcode.

* Lesen ISHMED kennzeichen
  PERFORM check_ishmed CHANGING g_ishmed_used.

* System bestimmen - SAP oder Kunde (und in globale Variable stellen)
  PERFORM read_system.

* Lesen des Inhalts der Funktionsvariante *****************************
  IF l_vcode <> g_vcode_insert AND i_read_viewvar = on.
    IF i_read_buffer = on.
      l_mode_buf = 'L'.                " Load
    ELSE.
      l_mode_buf = 'R'.                " Refresh
    ENDIF.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid      = g_view-viewid
        i_viewtype    = g_view-viewtype
        i_mode        = l_mode_buf
        i_caller      = 'LN1FVARU01'
        i_placeid     = i_place-wplaceid
        i_placetype   = i_place-wplacetype
      IMPORTING
        e_rc          = e_rc
        e_view        = g_v_nwview
        e_viewvar     = l_viewvar
      TABLES
        t_fvar        = gt_nwfvar
        t_fvar_button = gt_nwbutton
        t_fvar_futxt  = gt_nwfvarp
        t_messages    = lt_message.
    APPEND LINES OF lt_message TO t_messages.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    l_viewvar-viewtype = g_view-viewtype.
    l_viewvar-viewid   = g_view-viewid.
    SELECT SINGLE * FROM nwviewt INTO l_nwviewt
           WHERE  viewtype  = g_view-viewtype
           AND    viewid    = g_view-viewid
           AND    spras     = sy-langu.
    IF sy-subrc = 0.
      MOVE-CORRESPONDING l_nwviewt TO g_v_nwview.           "#EC ENHOK
    ENDIF.
  ENDIF.

  l_viewvar_old = l_viewvar.

* Falls gewünscht eine andere Funktionsvariante ändern oder anlegen
  IF NOT i_fvariantid IS INITIAL.
    l_viewvar-fvariantid = i_fvariantid.
    REFRESH: gt_nwfvar, gt_nwfvarp, gt_nwbutton.
    CALL FUNCTION 'ISHMED_VM_FVAR_GET'
      EXPORTING
        i_viewtype   = l_viewvar-viewtype
        i_fvariantid = l_viewvar-fvariantid
      IMPORTING
        e_rc         = e_rc
      TABLES
        t_fvar       = gt_nwfvar
        t_fvarp      = gt_nwfvarp
        t_button     = gt_nwbutton
        t_messages   = lt_message.
    APPEND LINES OF lt_message TO t_messages.
    IF g_vcode = g_vcode_update.
      IF e_rc <> 0.
        e_rc = 1.
*       Funkt.variante & für diesen Sichttypen konnte nicht gef. werden
        PERFORM build_bapiret2(sapmn1pa)
                USING 'I' 'NF1' '242' i_fvariantid space space
                                      space space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO t_messages.
        EXIT.
      ENDIF.
    ELSEIF g_vcode = g_vcode_insert.
      IF e_rc = 0.
        e_rc = 1.
*       Funktionsvariante & existiert bereits
        PERFORM build_bapiret2(sapmn1pa)
                USING 'I' 'NF1' '485' i_fvariantid space space
                                      space space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO t_messages.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

  g_viewvar     = l_viewvar.

* Beim Ändern gleich hier ev. eine Info-Message ausgeben, falls
* eine Funktionsvariante aus einem 'unerlaubten' Namensraum
* geändert werden soll (ID 6203)
  IF g_vcode = g_vcode_update.
*    g_first_time_warning = true.
    PERFORM check_fvar_name USING    g_viewvar-fvariantid  off
                            CHANGING e_rc.
    IF e_rc <> 0.
      e_rc = 1.
*     Von SAP ausgelieferte Funkt.var. dürfen nicht geändert werden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'I' 'NF1' '365' space space space
                                    space space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      EXIT.
    ENDIF.
  ENDIF.

* check if the function variant should be maintained in the original
* creation language, otherwise switch to "translation-mode"
  IF g_vcode = g_vcode_update.
    READ TABLE gt_nwfvar INTO l_wa_tmp_nwfvar INDEX 1.
    IF sy-subrc = 0 AND l_wa_tmp_nwfvar-spras IS INITIAL.
      g_translation = on.
    ENDIF.
    IF g_translation = off.
      LOOP AT gt_nwfvarp INTO l_wa_tmp_nwfvarp WHERE spras IS INITIAL.
        g_translation = on.
        EXIT.
      ENDLOOP.
    ENDIF.
    IF g_translation = off.
      LOOP AT gt_nwbutton INTO l_wa_tmp_button WHERE spras IS INITIAL.
        g_translation = on.
        EXIT.
      ENDLOOP.
    ENDIF.
  ENDIF.

* Ausgehend vom Sichttyp den GUI-Status herleiten, der die
* Grundmenge der Funktionscodes bestimmt
  PERFORM fetch_fcodes USING    g_view-viewtype
                                g_ishmed_used
                       CHANGING gt_fcodes
                                lt_message
                                e_rc.
  APPEND LINES OF lt_message TO t_messages.
  IF e_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* U.u. für gewisse Sichttypen einige Funktionen aufgrund
* weiterer Kriterien (z.B. Systemparameter) vom Funktionsvorrat
* entfernen
  PERFORM rework_fcodes USING    g_view-viewtype
                                 i_place-wplaceid i_place-wplacetype
                                 g_ishmed_used    g_translation
                        CHANGING gt_fcodes.

* Nun das Dynpro öffnen, das die Funktionspflege beinhaltet
  g_first_time_100 = on.

  CALL SCREEN 100 STARTING AT 18 1 ENDING AT 122 25.

* ID der Variante und Bez. mit korrekten Werten füllen
  IF i_mode = 'S' AND g_okcode = 'ENTER'.
*   ID 5683: Namen automatisch generieren
    IF g_dynpro200-name IS INITIAL.
      CALL FUNCTION 'ISHMED_VM_GENERATE_KEY'
           EXPORTING
              i_key_type       = 'F'        " Funktionsvariante
*             i_user_specific  =
              i_placetype      = i_place-wplacetype
              i_viewtype       = i_view-viewtype
           IMPORTING
              e_key            = l_key
              e_rc             = e_rc
           TABLES
              t_messages       = lt_message.
      APPEND LINES OF lt_message TO t_messages.
      IF e_rc <> 0.
*       Fehler beim Generieren des Schlüssels
        e_rc = 1.
        EXIT.
      ELSE.
        g_dynpro200-name = l_key.
      ENDIF.
    ENDIF.
    l_variantid          = g_dynpro200-name.
    l_varianttxt         = g_dynpro200-bezeich.
    g_viewvar-fvariantid = g_dynpro200-name.
  ELSE.
    l_variantid  = g_viewvar-fvariantid.
    READ TABLE gt_nwfvar INTO l_wa_tmp_nwfvar INDEX 1.
    IF sy-subrc = 0.
      l_varianttxt = l_wa_tmp_nwfvar-txt.
    ELSE.
      CLEAR l_varianttxt.
    ENDIF.
  ENDIF.

  IF i_mode = 'S' AND g_okcode = 'ENTER'.

*   globale Listen für fvar,button und fvarp
    PERFORM fill_gt_tables USING g_view-viewtype
                                 l_variantid
                                 l_varianttxt.

    lt_nwfvar[]   = gt_nwfvar[].
    lt_nwbutton[] = gt_nwbutton[].
    lt_nwfvarp[]  = gt_nwfvarp[].

*   Verbuchen der Funtionsvariante
    PERFORM verbuchen_fvar USING g_view-viewtype
                                 g_dynpro200-name
*                                 g_dynpro200-bezeich
                                 i_update_task
                                 g_translation.
*   Die Funktionsvariante wurde gesichert und soll auch zur
*   Sicht gespeichert werden, wenn gewünscht
    IF i_save = on.
      IF g_viewvar-fvariantid <> l_viewvar_old-fvariantid.
        PERFORM verbuchen_nwview_var(sapln1svar)
                                    USING g_viewvar l_viewvar_old
                                          i_update_task.
      ENDIF.
    ENDIF.
  ENDIF.

* Commit Work, falls gewünscht
  IF i_commit = on.
    COMMIT WORK AND WAIT.
  ENDIF.

* Schreiben der Daten der Funktionsvariante in den Puffer ************
  IF i_update_buffer = on.
    l_mode_buf = 'U'.
    CLEAR lt_message. REFRESH lt_message.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid      = i_view-viewid
        i_viewtype    = i_view-viewtype
        i_mode        = l_mode_buf
        i_caller      = 'LN1FVARU01'
        i_placeid     = i_place-wplaceid
        i_placetype   = i_place-wplacetype
      IMPORTING
        e_rc          = e_rc
      TABLES
        t_fvar        = lt_nwfvar
        t_fvar_button = lt_nwbutton
        t_fvar_futxt  = lt_nwfvarp
        t_messages    = lt_message.
    APPEND LINES OF lt_message TO t_messages.
    IF e_rc <> 0.
*     EXIT. " doch kein Exit -> Objekte müssen unten freigegeben werden
    ENDIF.
  ENDIF.

* Abbrechen
  IF g_okcode = 'ECAN'.
    e_rc = 2.                         " cancel
  ENDIF.

* Sicht mit Selektionsvariante zurückliefern
  e_viewvar = g_viewvar.

* Nun noch die Objekte freigeben
  CALL METHOD g_func_tree->free.
  CALL METHOD g_result_bar->free.
  CALL METHOD g_edit_tree->free.
*  CALL METHOD g_tree_cont->free.
*  CALL METHOD g_result_bar_cont->free.
*  CALL METHOD g_edit_cont->free.

  CALL METHOD g_splitter_child_cont_left->free.
  CALL METHOD g_splitter_child_cont_right->free.
  CALL METHOD g_splitter_child_cont->free.

  CALL METHOD g_splitter_main_cont_top->free.
  CALL METHOD g_splitter_main_cont_bottom->free.
  CALL METHOD g_splitter_main_cont->free.

  CALL METHOD g_main_cust_container->free.

ENDFUNCTION.
