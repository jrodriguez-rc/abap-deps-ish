FUNCTION ishmed_vm_avar_copy.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_AVAR) TYPE  RNAVAR
*"     VALUE(I_POPUP) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_VIEWTYPE) TYPE  NVIEWTYPE
*"     VALUE(I_VIEWID) TYPE  NVIEWID OPTIONAL
*"     VALUE(I_AVAR_TEXT) TYPE  SLIS_VARBZ DEFAULT SPACE
*"     VALUE(I_NWPLACE) TYPE  NWPLACE OPTIONAL
*"  EXPORTING
*"     VALUE(E_AVAR) TYPE  RNAVAR
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(E_CANCEL) TYPE  ISH_ON_OFF
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_variant            TYPE disvariant,
        l_wa_msg             TYPE bapiret2,
        l_key                TYPE rnwp_gen_key-nwkey,
        l_view               TYPE rnviewvar,
        l_rc                 TYPE sy-subrc,
        l_rc_char(1)         TYPE c,
        l_poptext            TYPE char50,
        l_poptext_new        TYPE char50,
*        l_exit(1)            TYPE c,
        lt_dispvar           TYPE lvc_t_fcat,
        lt_dispsort          TYPE lvc_t_sort,
        lt_dispfilter        TYPE lvc_t_filt,
        ls_lvc_layout        TYPE lvc_s_layo,
        lt_dummy_dispvar     TYPE lvc_t_fcat,
        lt_messages          TYPE TABLE OF bapiret2.
*  DATA: lt_data              TYPE lvc_t_filt.            " Dummy
*  DATA: lt_data_001          TYPE ish_t_occupancy_list.  " Sichttyp 001
*  DATA: lt_data_002          TYPE ish_t_arrival_list.    " Sichttyp 002
*  DATA: lt_data_003          TYPE ish_t_departure_list.  " Sichttyp 003
*  DATA: lt_data_004          TYPE ishmed_t_request_list. " Sichttyp 004
*  DATA: lt_data_005          TYPE ishmed_t_pts_list.     " Sichttyp 005
*  DATA: lt_data_006          TYPE ish_n2_document_list.  " Sichttyp 006
*  DATA: lt_data_007          TYPE ish_t_lststelle_list.  " Sichttyp 007
*  DATA: lt_data_008          TYPE ish_t_medcontrol_list. " Sichttyp 008
*  DATA: lt_data_009          TYPE ish_t_occplanning_list." Sichttyp 009
*  DATA: lt_data_010          TYPE ish_t_prereg_list.     " Sichttyp 010
*  DATA: lt_data_011          TYPE ishmed_t_op_list.      " Sichttyp 011
*  DATA: lt_data_012          TYPE ishmed_t_meorder_list. " Sichttyp 012
*  DATA: lt_data_013          TYPE ishmed_t_meevent_list. " Sichttyp 013
**  DATA: lt_data_014          TYPE ishmed_t_???_list.    " Sichttyp 014
*
*  FIELD-SYMBOLS: <lt_data> TYPE STANDARD TABLE.

  CLEAR:   e_rc, e_avar, e_cancel,
           l_variant, l_rc, ls_lvc_layout, l_key,
           l_poptext, l_poptext_new, l_view.
  REFRESH: lt_dispvar, lt_dispsort, lt_dispfilter, lt_dummy_dispvar.

  IF i_avar IS INITIAL.
    EXIT.
  ENDIF.

  l_view-viewtype   = i_viewtype.
  l_view-viewid     = i_viewid.
  MOVE-CORRESPONDING i_avar TO l_view.                      "#EC ENHOK

* does the layout variant exist?
  l_variant-report    = i_avar-reporta.
  l_variant-variant   = i_avar-avariantid.
  l_variant-handle    = i_avar-handle.
  l_variant-log_group = i_avar-log_group.
  l_variant-username  = i_avar-username.
  CALL FUNCTION 'LVC_VARIANT_EXISTENCE_CHECK'
    EXPORTING
      i_save        = ' '
    CHANGING
      cs_variant    = l_variant
    EXCEPTIONS
      wrong_input   = 1
      not_found     = 2
      program_error = 3
      OTHERS        = 4.
  IF sy-subrc <> 0.
*   layout variant not found
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '355' i_avar-avariantid space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ENDIF.

** Je Sichttyp die Struktur der Ausgabetabelle unterschiedlich
** übergeben (für Filterkriterien)
*  CASE i_viewtype.
*    WHEN '001'.
*      ASSIGN lt_data_001[] TO <lt_data>.
*    WHEN '002'.
*      ASSIGN lt_data_002[] TO <lt_data>.
*    WHEN '003'.
*      ASSIGN lt_data_003[] TO <lt_data>.
*    WHEN '004'.
*      ASSIGN lt_data_004[] TO <lt_data>.
*    WHEN '005'.
*      ASSIGN lt_data_005[] TO <lt_data>.
*    WHEN '006'.
*      ASSIGN lt_data_006[] TO <lt_data>.
*    WHEN '007'.
*      ASSIGN lt_data_007[] TO <lt_data>.
*    WHEN '008'.
*      ASSIGN lt_data_008[] TO <lt_data>.
*    WHEN '009'.
*      ASSIGN lt_data_009[] TO <lt_data>.
*    WHEN '010'.
*      ASSIGN lt_data_010[] TO <lt_data>.
*    WHEN '011'.
*      ASSIGN lt_data_011[] TO <lt_data>.
*    WHEN '012'.
*      ASSIGN lt_data_012[] TO <lt_data>.
*    WHEN '013'.
*      ASSIGN lt_data_013[] TO <lt_data>.
*    WHEN '014'.
**      ASSIGN lt_data_014[] TO <lt_data>.
*    WHEN OTHERS.
*      ASSIGN lt_data       TO <lt_data>.
*  ENDCASE.

* read layout data
  IF NOT i_viewid IS INITIAL.
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_viewid     = i_viewid
        i_viewtype   = i_viewtype
        i_mode       = 'L'
        i_caller     = 'LN1WPCOPYU05'
      IMPORTING
        e_rc         = l_rc
      TABLES
        t_messages   = lt_messages
      CHANGING
        c_dispvar    = lt_dispvar
        c_dispsort   = lt_dispsort
        c_dispfilter = lt_dispfilter
        c_layout     = ls_lvc_layout.
    APPEND LINES OF lt_messages TO t_messages.
    IF l_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.

  DESCRIBE TABLE lt_dispvar.
  IF sy-tfill = 0.
    PERFORM create_fieldcat(sapln1workplace)
                            USING    i_nwplace
                                     l_view
                                     on
                                     off
                            CHANGING lt_dummy_dispvar
                                     lt_messages
                                     l_rc.
    APPEND LINES OF lt_messages TO t_messages.
    IF l_rc <> 0.
      e_rc = 1.
      EXIT.
    ENDIF.
    CALL FUNCTION 'LVC_VARIANT_SELECT'
      EXPORTING
        i_dialog            = ' '
        i_user_specific     = 'U'  " user-specific possible !
        it_default_fieldcat = lt_dummy_dispvar
      IMPORTING
        et_fieldcat         = lt_dispvar
        et_sort             = lt_dispsort
        et_filter           = lt_dispfilter
        es_layout           = ls_lvc_layout
*      TABLES
*        it_data             = <lt_data>
      CHANGING
        cs_variant          = l_variant
      EXCEPTIONS
        wrong_input         = 1
        fc_not_complete     = 2
        not_found           = 3
        program_error       = 4
        OTHERS              = 5.
    IF sy-subrc <> 0.
*     layout variant not found
      PERFORM build_bapiret2(sapmn1pa)
              USING 'E' 'NF1' '355' i_avar-avariantid space space space
                    space space space
              CHANGING l_wa_msg.
      APPEND l_wa_msg TO t_messages.
      e_rc = 1.
      EXIT.
    ENDIF.
  ENDIF.

* read layout text (usually filled in EXISTANCE_CHECK)
  IF l_variant-text IS INITIAL.
    CALL FUNCTION 'LVC_VARIANT_SELECT'
      EXPORTING
        i_dialog            = ' '
        i_user_specific     = ' '
        it_default_fieldcat = lt_dummy_dispvar
      CHANGING
        cs_variant          = l_variant
      EXCEPTIONS
        wrong_input         = 1
        fc_not_complete     = 2
        not_found           = 3
        program_error       = 4
        OTHERS              = 5.
    IF sy-subrc <> 0.
*     no error if no text was found
      e_rc = 0.
    ENDIF.
  ENDIF.

* popup to get new layout text
  IF i_avar_text IS INITIAL.                                " ID 10499
    l_poptext = l_variant-text.
  ELSE.                                                     " ID 10499
    l_poptext = i_avar_text.                                " ID 10499
    IF i_popup = off.                                       " ID 10499
      l_variant-text = l_poptext.                           " ID 10499
    ENDIF.                                                  " ID 10499
  ENDIF.                                                    " ID 10499
  IF i_popup = on.
    CALL FUNCTION 'ISHMED_VM_VARIANT_TEXT_POPUP'
      EXPORTING
        i_text  = l_poptext
        i_titel = 'Layout kopieren'(006)
        i_type  = 'A'
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
      l_variant-text = l_poptext_new.
    ELSE.
      EXIT.
    ENDIF.
  ENDIF.

* get new layout id
  CALL FUNCTION 'ISHMED_VM_GENERATE_KEY'
    EXPORTING
      i_key_type      = 'A'
      i_user_specific = off
      i_viewtype      = i_viewtype
    IMPORTING
      e_key           = l_key
      e_rc            = l_rc
    TABLES
      t_messages      = lt_messages.
  APPEND LINES OF lt_messages TO t_messages.
  IF l_rc <> 0.
*   error on generating key
    e_rc = 1.
    EXIT.
  ELSE.
    l_variant-variant = l_key.
  ENDIF.

  REFRESH lt_dispfilter.                                    " ID 10858

* copy layout variant (= save with new id)
  CALL FUNCTION 'LVC_VARIANT_SAVE'
       EXPORTING
            it_fieldcat     = lt_dispvar
            it_sort         = lt_dispsort
            it_filter       = lt_dispfilter
            is_layout       = ls_lvc_layout
            i_dialog        = ' '
            i_overwrite     = 'X'
            i_user_specific = ' '
*       IMPORTING
*            e_exit          = l_exit
*       TABLES
*            it_data         = <lt_data>
       CHANGING
            cs_variant      = l_variant
       EXCEPTIONS
            wrong_input     = 1
            fc_not_complete = 2
            foreign_lock    = 3
            variant_exists  = 4
            name_reserved   = 5
            program_error   = 6
            OTHERS          = 7.
  IF sy-subrc <> 0.
*   layout & can not be copied (returncode = &)
    l_rc_char = sy-subrc.
    PERFORM build_bapiret2(sapmn1pa)
         USING 'E' 'NF1' '676' i_avar-avariantid l_rc_char space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ELSE.
*   layout has been copied
    e_avar = i_avar.
    e_avar-avariantid = l_variant-variant.
*   success message - layout & has been copied
    PERFORM build_bapiret2(sapmn1pa)
         USING 'S' 'NF1' '680' l_poptext space space space
                  space space space
         CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
  ENDIF.

ENDFUNCTION.
