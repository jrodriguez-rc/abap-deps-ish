FUNCTION ishmed_vm_generate_key.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_KEY_TYPE) TYPE  RNWP_GEN_KEY-NWKEYTYPE
*"     VALUE(I_USER_SPECIFIC) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_SAP_STANDARD) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_PLACETYPE) TYPE  NWPLACE-WPLACETYPE OPTIONAL
*"     VALUE(I_VIEWTYPE) TYPE  NWVIEW-VIEWTYPE OPTIONAL
*"  EXPORTING
*"     REFERENCE(E_KEY) TYPE  RNWP_GEN_KEY-NWKEY
*"     REFERENCE(E_RC) LIKE  SY-SUBRC
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_wa_msg              LIKE bapiret2,
        l_count_add           like sy-index,
        l_nwview              LIKE nwview,                  "#EC NEEDED
        l_nwplace             LIKE nwplace,                 "#EC NEEDED
        l_nwfvar              LIKE nwfvar,                  "#EC NEEDED
        l_reporta             LIKE disvariant-report,
        l_variant             LIKE disvariant.

  CLEAR:   e_rc, e_key.
  REFRESH: t_messages.

* Schleife solange durchlaufen, bis ein neuer gültiger
* Schlüssel gefunden wird.
  DO.

    l_count_add = sy-index.
*   Je nach gewünschtem Schlüsseltyp die nächste Nummer
*   ermitteln
    CASE i_key_type.
      WHEN 'W'.
*       Arbeitsumfeld (Workplace)
        PERFORM get_key_w using    i_placetype
                                   i_sap_standard
                                   l_count_add
                          changing e_key.
      WHEN 'V'.
*       Sicht (View)
        PERFORM get_key_v using    i_viewtype
                                   i_sap_standard
                                   l_count_add
                          changing e_key.
      WHEN 'A'.
*       Anzeigevariante
        PERFORM get_key_a using    i_user_specific
                                   i_viewtype
                                   i_placetype      "MED-44567
                                   l_count_add
                          changing e_key.
      WHEN 'F'.
*       Funktionsvariante
        PERFORM get_key_f using    i_viewtype
                                   l_count_add
                          changing e_key.
      WHEN OTHERS.
*       Ungültiger Schlüsseltyp
        PERFORM build_bapiret2(sapmn1pa)
                USING 'E' 'NF' '666' 'Ungültiger Schlüsseltyp'(001)
                      space space space
                      space space space
                CHANGING l_wa_msg.
        APPEND l_wa_msg TO t_messages.
        e_rc = 1.
        EXIT.
    ENDCASE.

*   Neue Nummer muß gefunden werden
    IF e_key IS INITIAL.
*     Es konnte kein neuer Schlüssel für das Objekt ermittelt werden
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '496' space space space space
                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      e_rc = 1.
      EXIT.
    ENDIF.

*   Prüfen, ob dieser Schlüssel schon existiert
    CASE i_key_type.
      WHEN 'W'.
*       Arbeitsumfeld (Workplace)
        SELECT SINGLE * FROM nwplace INTO l_nwplace
               WHERE  wplacetype  = i_placetype
               AND    wplaceid    = e_key.
      WHEN 'V'.
*       Sicht (View)
        SELECT SINGLE * FROM nwview INTO l_nwview
               WHERE  viewtype  = i_viewtype
               AND    viewid    = e_key.
      WHEN 'A'.
*       Anzeigevariante
        PERFORM get_report_anzvar(sapln1workplace)
                                  USING    i_viewtype
                                  CHANGING l_reporta.
        CLEAR l_variant.
        l_variant-report     = l_reporta.
        IF i_user_specific = on.
          l_variant-username = sy-uname.
        ENDIF.
        l_variant-variant    = e_key.
        CALL FUNCTION 'LVC_VARIANT_EXISTENCE_CHECK'
             EXPORTING
                  i_save        = 'U'  " user-specific possible
             CHANGING
                  cs_variant    = l_variant
             EXCEPTIONS
                  wrong_input   = 1
                  not_found     = 2
                  program_error = 3
                  OTHERS        = 4.
      WHEN 'F'.
*       Funktionsvariante
        SELECT SINGLE * FROM nwfvar INTO l_nwfvar
               WHERE  viewtype  = i_viewtype
               AND    fvar      = e_key.
    ENDCASE.

*   Wenn noch kein Eintrag mit diesem Schlüssel existiert, dann
*   kann die Schleife verlassen werden
    IF sy-subrc <> 0.
      EXIT.
    ELSE.
      CLEAR e_key.
    ENDIF.

  ENDDO.

ENDFUNCTION.
