FUNCTION ishmed_vm_svar_copy.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_SVAR) TYPE  RNSVAR
*"     VALUE(I_POPUP) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_VIEWTYPE) TYPE  NVIEWTYPE
*"     VALUE(I_VIEWID) TYPE  NVIEWID OPTIONAL
*"     VALUE(I_SVAR_TEXT) TYPE  RVART_VTXT DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_SVAR) TYPE  RNSVAR
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(E_CANCEL) TYPE  ISH_ON_OFF
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_variant         TYPE rsvar-variant,
        l_variant_new_id  TYPE rsvar-variant,
        l_wa_msg          TYPE bapiret2,
        l_rc              TYPE sy-subrc,
        l_rc_char(1)      TYPE c,
        lt_rsparams       TYPE TABLE OF rsparams,
        lt_varit          TYPE TABLE OF varit,
        l_varit           TYPE varit,
        l_varid           TYPE varid,
        l_vtext           TYPE varit-vtext,
        l_vtext_new       TYPE varit-vtext,
        l_poptext         TYPE char50,
        l_poptext_new     TYPE char50.

  CLEAR:   e_rc, e_svar, e_cancel,
           l_variant, l_variant_new_id, l_rc, l_varit, l_varid,
           l_vtext, l_vtext_new, l_poptext, l_poptext_new.
  REFRESH: lt_varit, lt_rsparams.

  IF i_svar IS INITIAL.
    EXIT.
  ENDIF.

* check variant id (if copy is possible)
  IF i_svar-svariantid(1) = '&' OR i_svar-svariantid(4) = 'SAP&'.
*   variant can not be copied
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'DB' '299' i_svar-svariantid space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ENDIF.

* does the variant exist?
  CALL FUNCTION 'RS_VARIANT_EXISTS'
    EXPORTING
      report              = i_svar-reports
      variant             = i_svar-svariantid
    IMPORTING
      r_c                 = l_rc
    EXCEPTIONS
      not_authorized      = 1
      no_report           = 2
      report_not_existent = 3
      report_not_supplied = 4
      OTHERS              = 5.
  IF sy-subrc <> 0 OR l_rc <> 0.
*   variant not found
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '354' i_svar-svariantid space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ENDIF.

* popup to get new variant text
  IF i_svar_text IS INITIAL.                                " ID 10499
    CALL FUNCTION 'RS_VARIANT_TEXT'
      EXPORTING
        curr_report = i_svar-reports
        langu       = sy-langu
        variant     = i_svar-svariantid
      IMPORTING
        v_text      = l_vtext
      EXCEPTIONS
        no_text     = 1
        OTHERS      = 2.
    IF sy-subrc = 0.
      l_poptext = l_vtext.
    ENDIF.
  ELSE.                                                     " ID 10499
    l_poptext = i_svar_text.                                " ID 10499
    IF i_popup = off.                                       " ID 10499
      l_vtext_new     = l_poptext.                          " ID 10499
      l_varit-mandt   = sy-mandt.                           " ID 10499
      l_varit-langu   = sy-langu.                           " ID 10499
      l_varit-report  = i_svar-reports.                     " ID 10499
*     l_varit-variant = ... fill later with new id          " ID 10499
      l_varit-vtext   = l_vtext_new.                        " ID 10499
    ENDIF.                                                  " ID 10499
  ENDIF.                                                    " ID 10499
  IF i_popup = on.
    CALL FUNCTION 'ISHMED_VM_VARIANT_TEXT_POPUP'
      EXPORTING
        i_text  = l_poptext
        i_titel = 'Selektionsvariante kopieren'(005)
        i_type  = 'S'
      IMPORTING
        e_text  = l_poptext_new
      EXCEPTIONS
        cancel  = 1
        OTHERS  = 2.
    IF sy-subrc <> 0.
      e_cancel = on.
      EXIT.
    ENDIF.
    IF NOT l_poptext_new IS INITIAL.
      l_vtext_new     = l_poptext_new.
      l_varit-mandt   = sy-mandt.
      l_varit-langu   = sy-langu.
      l_varit-report  = i_svar-reports.
*     l_varit-variant = ... fill later with new id
      l_varit-vtext   = l_vtext_new.
    ELSE.
      EXIT.
    ENDIF.
  ENDIF.

* get new id (insert 01-nn at last position of id)
  l_variant_new_id = i_svar-svariantid.
  PERFORM get_new_svar_id USING    i_svar-reports
                          CHANGING l_variant_new_id.

* if new id could not be found and no popup should be
* displayed -> leave function now
* otherwise, if popup should be displayed, there will
* be displayed a popup in function RS_VARIANT_COPY
  IF i_popup = off AND l_variant_new_id IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* copy selection variant
  CALL FUNCTION 'RS_VARIANT_COPY'
    EXPORTING
      report                     = i_svar-reports
      variant1                   = i_svar-svariantid
      copy_variant               = l_variant_new_id
    IMPORTING
*     VARIANT1                   =
      variant2                   = l_variant
    EXCEPTIONS
      not_authorized             = 1
      not_executed               = 2
      no_report                  = 3
      report_not_existent        = 4
      report_not_supplied        = 5
      variant_exists             = 6
      variant_locked             = 7
      variant_not_existent       = 8
      OTHERS                     = 9.

  IF sy-subrc <> 0 OR l_variant IS INITIAL.
*   variant & can not be copied (returncode = &)
    l_rc_char = sy-subrc.
    PERFORM build_bapiret2(sapmn1pa)
         USING 'E' 'NF1' '675' i_svar-svariantid l_rc_char space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ELSE.
*   variant has been copied
    e_svar = i_svar.
    e_svar-svariantid = l_variant.
*   success message - selection variant & has been copied
    PERFORM build_bapiret2(sapmn1pa)
         USING 'S' 'NF1' '679' l_vtext space space space
                  space space space
         CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
*   change variant text if requested
    IF NOT l_varit-vtext IS INITIAL.
      l_varit-variant = e_svar-svariantid.
      APPEND l_varit TO lt_varit.
      CALL FUNCTION 'RS_CHANGE_CREATED_VARIANT'
        EXPORTING
          curr_report               = e_svar-reports
          curr_variant              = e_svar-svariantid
          vari_desc                 = l_varid
        TABLES
          vari_contents             = lt_rsparams
          vari_text                 = lt_varit
        EXCEPTIONS
          illegal_report_or_variant = 1
          illegal_variantname       = 2
          not_authorized            = 3
          not_executed              = 4
          report_not_existent       = 5
          report_not_supplied       = 6
          variant_doesnt_exist      = 7
          variant_locked            = 8
          selections_no_match       = 9
          OTHERS                    = 10.
      IF sy-subrc <> 0.
*       no error if text could not be changed
        e_rc = 0.
      ENDIF.
    ENDIF.
  ENDIF.

ENDFUNCTION.
