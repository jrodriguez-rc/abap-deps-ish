FUNCTION ishmed_vm_fvar_delete.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEWTYPE) LIKE  NWVIEW-VIEWTYPE
*"     VALUE(I_FVARIANTID) LIKE  RNFVAR-FVARIANTID
*"     VALUE(I_CHECK_USED) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_VIEWID) LIKE  NWVIEW-VIEWID OPTIONAL
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT ' '
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_POPUP) TYPE  ISH_ON_OFF DEFAULT ' '
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------
  DATA: lt_v_nwfvar    LIKE TABLE OF v_nwfvar,
        lt_v_nwfvarp   LIKE TABLE OF v_nwfvarp,
        lt_v_nwbutton  LIKE TABLE OF v_nwbutton,
        lt_view        LIKE TABLE OF nwview,
        l_v_nwfvar     LIKE v_nwfvar,
        l_tabname      TYPE lvc_tname,
        l_viewname     TYPE lvc_tname,
        l_func_name    TYPE ish_fbname,
        l_wa_msg       LIKE bapiret2,
        l_allowed(1)   TYPE c,
        l_txt1(70)     TYPE c,
        l_txt2(70)     TYPE c,
        l_text(140)    TYPE c,
        l_answer(1)    TYPE c,
        l_icon_1       TYPE icon-name,
        l_icon_2       TYPE icon-name,
        l_rc           TYPE sy-subrc,
        l_tablekey     LIKE e071k-tabkey,
        l_tablename    LIKE tresc-tabname,
        l_fieldname    LIKE tresc-fieldname,
        l_tabname_checked TYPE string.  " TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX

  CLEAR e_rc.
  CLEAR: t_messages. REFRESH: t_messages.

  REFRESH: lt_v_nwfvar, lt_v_nwfvarp, lt_v_nwbutton.

* Sichttyp und Funktionsvariante muß übergeben werden
  IF i_viewtype IS INITIAL OR i_fvariantid IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* System bestimmen - SAP oder Kunde (und in globale Variable stellen)
  PERFORM read_system.

* Prüfung: Es dürfen keine SAP-Standard-Fkt.varianten gelöscht werden
  IF g_system_sap = off.     " Prüfung nur auf Kundensystemen ID 7947
    l_tablekey  = i_fvariantid.
    l_tablename = 'NWFVAR'.
    l_fieldname = 'FVAR'.
    CALL FUNCTION 'CHECK_CUSTOMER_NAME_FIELD'
      EXPORTING
*       OBJECTTYPE            = 'TABU'
        tablekey              = l_tablekey
        tablename             = l_tablename
        fieldname             = l_fieldname
      IMPORTING
        keyfield_allowed      = l_allowed
*       SYSTEM_SAP            =
*       TABLE_NOT_FOUND       =
*       RESERVED_IN_TRESC     =
      EXCEPTIONS
        objecttype_not_filled = 1
        tablename_not_filled  = 2
        fieldname_not_filled  = 3
        OTHERS                = 4.                     "#EC *
    IF sy-subrc <> 0.
    ENDIF.
    IF l_allowed <> 'X'.
*      MESSAGE i365.
      e_rc = 1.
*     Von SAP ausgelieferte Fkt.varianten dürfen nicht geändert werden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '365' i_fvariantid  space space space
                                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      EXIT.
    ENDIF.
  ENDIF.

* Prüfen, ob noch andere Verwender (Sichten)
  IF i_check_used = on.
    REFRESH lt_view.
    CLEAR l_tabname.
*   get name of view specific table (ID 18129)
    PERFORM get_view_specific IN PROGRAM sapln1workplace
                              USING      i_viewtype
                              CHANGING   l_tabname
                                         l_viewname
                                         l_func_name.
    IF l_tabname IS NOT INITIAL.
      " TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) FIX Start
      TRY.
          cl_abap_dyn_prg=>check_table_name_str(
                  EXPORTING
                    val               = l_tabname    " Input that shall be checked
                    packages          = 'IS-HMED,IS-H'    " Package to which the table shall belong
                    incl_sub_packages = abap_true
                  RECEIVING
                    val_str           = l_tabname_checked    " Same as the input
                ).
        CATCH cx_abap_not_a_table.
          MESSAGE a001(n1sec).
*   SQL-Befehlsinjektion - interner Fehler
        CATCH cx_abap_not_in_package.
          TRY.
              DATA lt_whitelist TYPE string_hashed_table.

              cl_ishmed_sec_utl=>get_db_whitelist_4_nwview(
                IMPORTING
                  et_whitelist = lt_whitelist    " Positiv-Liste aller DB-Tabellen kund. Sichttypen
              ).

              cl_abap_dyn_prg=>check_whitelist_tab(
                EXPORTING
                  val                      = l_tabname
                  whitelist                = lt_whitelist
                RECEIVING
                  val_str                  = l_tabname_checked    " Same as the input
              ).
            CATCH cx_abap_not_in_whitelist.    "
              MESSAGE a001(n1sec).
*   SQL-Befehlsinjektion - interner Fehler
          ENDTRY.
      ENDTRY.

      SELECT mandt viewtype viewid FROM (l_tabname_checked)
             INTO TABLE lt_view
             WHERE viewtype    = i_viewtype
               AND fvariantid  = i_fvariantid.
      " TP 06.03.2013 Chechman error: Potentielle SQL injection (1118) End
*     Übergebene Sicht nicht beachten
      IF NOT i_viewid IS INITIAL.
        DELETE lt_view WHERE viewtype = i_viewtype
                         AND viewid   = i_viewid.
      ENDIF.
      DESCRIBE TABLE lt_view.
      IF sy-tfill > 0.
        e_rc = 3.                      " nur Zuordnung löschen ID 7958
*        e_rc = 1.
**       Funktionsvariante & wird noch von anderen Sichten verwendet
*        PERFORM build_bapiret2(sapmn1pa)
*                USING 'E' 'NF1' '364' i_fvariantid  space space space
*                                      space space space
*                CHANGING l_wa_msg.
*        APPEND l_wa_msg TO t_messages.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

* Alle Daten der Funktionsvariante lesen
  CALL FUNCTION 'ISHMED_VM_FVAR_GET'
    EXPORTING
      i_viewtype   = i_viewtype
      i_fvariantid = i_fvariantid
    IMPORTING
      e_rc         = l_rc
    TABLES
      t_fvar       = lt_v_nwfvar
      t_fvarp      = lt_v_nwfvarp
      t_button     = lt_v_nwbutton
      t_messages   = t_messages.
  IF l_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* Abfrage-Popup bringen
  IF i_popup = on.
    READ TABLE lt_v_nwfvar INTO l_v_nwfvar INDEX 1.
    CONCATENATE 'Wollen Sie die Funktionsvariante'(f04)
                l_v_nwfvar-txt INTO l_txt1 SEPARATED BY space.
    l_txt2 = 'oder nur die Zuordnung zur Sicht löschen?'(f05).
    CONCATENATE l_txt1 l_txt2 INTO l_text SEPARATED BY space.
    l_icon_1 = icon_delete.
    l_icon_2 = icon_disconnect.
    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar              = 'Funktionsvariante löschen'(f03)
*       diagnose_object       = ' '
        text_question         = l_text
        text_button_1         = 'Variante'(f01)
        icon_button_1         = l_icon_1
        text_button_2         = 'Zuordnung'(f02)
        icon_button_2         = l_icon_2
        default_button        = '1'
        display_cancel_button = 'X'
*       popup_type            = ' '
      IMPORTING
        answer                = l_answer
      EXCEPTIONS
        text_not_found        = 1
        OTHERS                = 2.
    IF sy-subrc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    CASE l_answer.
      WHEN '1'.
*       OK -> Löschen
      WHEN '2'.
        e_rc = 3.                      " nur Zuordnung löschen
        EXIT.
      WHEN OTHERS.
        e_rc = 2.                      " Cancel
        EXIT.
    ENDCASE.
  ENDIF.

* Funktionsvariante löschen (Verbuchung)
  PERFORM verbucher_fvar_delete TABLES lt_v_nwfvar
                                       lt_v_nwfvarp
                                       lt_v_nwbutton
                                USING  i_update_task.
  IF i_commit = on.
    COMMIT WORK AND WAIT.
  ENDIF.

ENDFUNCTION.
