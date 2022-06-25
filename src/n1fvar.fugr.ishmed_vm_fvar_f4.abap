FUNCTION ishmed_vm_fvar_f4.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEWTYPE) LIKE  NWVIEW-VIEWTYPE
*"     VALUE(I_ACTIVEX) TYPE  ISH_ON_OFF DEFAULT 'X'
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"     VALUE(E_FVAR) LIKE  V_NWFVAR STRUCTURE  V_NWFVAR
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: a_key         LIKE rn1f4-key,
        lt_table      LIKE TABLE OF rn1f4,
        lt_fvar       LIKE TABLE OF v_nwfvar,
        lt_fvar_ret   LIKE TABLE OF v_nwfvar,
        l_wa_table    LIKE rn1f4,
        l_fvar        LIKE v_nwfvar.

  CLEAR: e_fvar, e_rc.

  CALL FUNCTION 'ISHMED_VM_FVAR_GET'
       EXPORTING
            i_viewtype   = i_viewtype
*           I_FVARIANTID =             " keine bestimmte !
       IMPORTING
            e_rc         = e_rc
       TABLES
            t_fvar       = lt_fvar
*           T_FVARP      =
*           T_BUTTON     =
            t_messages   = t_messages.

  CHECK e_rc = 0.

  IF i_activex = on.
*   ActiveX-Control mit Suchhilfe aufrufen
    PERFORM call_show_fvar TABLES   lt_fvar
                                    lt_fvar_ret
                           USING    off
                           CHANGING e_rc.
*   Ausgewählte Funktionsvariante zurückliefern
    CHECK e_rc = 0.
    READ TABLE lt_fvar_ret INDEX 1 INTO l_fvar.
    CHECK sy-subrc = 0.
    e_fvar = l_fvar.
  ELSE.
*   Liste aller Funktionsvarianten
    LOOP AT lt_fvar INTO l_fvar.
      CLEAR l_wa_table.
      l_wa_table-key  = sy-tabix.
      l_wa_table-code = l_fvar-fvar.
      l_wa_table-text = l_fvar-txt.
      APPEND l_wa_table TO lt_table.
    ENDLOOP.
*   Überschrift
    CLEAR l_wa_table.
    l_wa_table-code = 'Variante'(t08).
    l_wa_table-text = 'Bezeichnung'(t06).
*   F4-Hilfe-Baustein
    CALL FUNCTION 'ISHMED_F4_ALLG'
         EXPORTING
           i_headline        = l_wa_table
           i_height          = 0           " dynamische Höhe
           i_len_key         = 10
           i_len_code        = 15
*          I_LEN_OTHER       = 10
           i_len_text        = 60
           i_sort            = space
           i_title           = 'Funktionsvariante auswählen'(t07)
           i_vcode           = g_vcode_update
           i_mfsel           = ' '
           i_enter_key       = 'X'
           i_refresh         = ' '
           i_activex         = 'X'
        IMPORTING
           e_key             = a_key
        TABLES
           t_f4tab           = lt_table.
    IF NOT a_key IS INITIAL.
*     Ausgewählte Funktionsvariante zurückliefern
      CLEAR l_fvar.
      READ TABLE lt_fvar INTO l_fvar INDEX a_key.
      IF sy-subrc = 0.
        e_fvar = l_fvar.
      ENDIF.
    ELSE.
      e_rc = 2.                                             " Cancel
    ENDIF.
  ENDIF.

ENDFUNCTION.
