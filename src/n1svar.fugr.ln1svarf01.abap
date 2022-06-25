*----------------------------------------------------------------------*
***INCLUDE LN1SVARF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  VERBUCHEN_NWVIEW_VAR
*&---------------------------------------------------------------------*
*       Verbuchung der Varianten zur Sicht
*----------------------------------------------------------------------*
*      -->P_VIEWVAR_NEW  Neue Sicht-Daten
*      -->P_VIEWVAR_OLD  Alte Sicht-Daten
*      -->P_UPDATE_TASK  In Update Task ON/OFF
*----------------------------------------------------------------------*
FORM verbuchen_nwview_var USING  value(p_viewvar_new) LIKE rnviewvar
                                 value(p_viewvar_old) LIKE rnviewvar
                                 value(p_update_task) LIKE rnt40-mark.

  DATA: ls_wa_n           TYPE REF TO data,
        ls_wa_o           TYPE REF TO data,
        lt_ref_n          TYPE REF TO data,
        lt_ref_o          TYPE REF TO data,
        l_comp_kz(2)      TYPE c,
        l_comp_mandt      TYPE lvc_fname,
        l_comp_type_pg    TYPE lvc_fname,
        l_comp_id_pg      TYPE lvc_fname,
        l_dbname_dummy    TYPE lvc_tname,
        l_dbname          TYPE lvc_tname,
        l_func_name       TYPE ish_fbname,
        ls_nwview_014     TYPE nwview_014.

  FIELD-SYMBOLS: <l_wa_n>      TYPE ANY,
                 <l_wa_o>      TYPE ANY,
                 <l_kz>        TYPE vnwviewt-kz,
                 <l_mandt>     TYPE vnwviewt-mandt,
                 <l_type_pg>   TYPE vnwview_014-nwplacetype_pg,
                 <l_id_pg>     TYPE vnwview_014-nwplaceid_pg,
                 <lt_n>        TYPE STANDARD TABLE,
                 <lt_o>        TYPE STANDARD TABLE.

  CHECK NOT p_viewvar_new IS INITIAL.

* Befüllung der Verbucherstrukturen je Sichttyp
  CLEAR: l_dbname, l_func_name, ls_wa_n, ls_wa_o, lt_ref_n, lt_ref_o.
* get view specific table data (ID 18129)
  PERFORM get_view_specific IN PROGRAM sapln1workplace
                            USING      p_viewvar_new-viewtype
                            CHANGING   l_dbname_dummy
                                       l_dbname
                                       l_func_name.
  CREATE DATA lt_ref_n TYPE STANDARD TABLE OF (l_dbname).
  ASSIGN lt_ref_n->* TO <lt_n>.
  CREATE DATA lt_ref_o TYPE STANDARD TABLE OF (l_dbname).
  ASSIGN lt_ref_o->* TO <lt_o>.
  CREATE DATA ls_wa_n LIKE LINE OF <lt_n>.
  ASSIGN ls_wa_n->* TO <l_wa_n>.
  CREATE DATA ls_wa_o LIKE LINE OF <lt_o>.
  ASSIGN ls_wa_o->* TO <l_wa_o>.
* Neue Daten
  CLEAR <l_wa_n>.
  MOVE-CORRESPONDING p_viewvar_new TO <l_wa_n>.
* ID 13398: viewtype 014 has 2 additional fields which should
*           not be changed!
  IF p_viewvar_new-viewtype = '014'.
    SELECT SINGLE * FROM nwview_014 INTO ls_nwview_014
           WHERE  viewtype  = p_viewvar_new-viewtype
           AND    viewid    = p_viewvar_new-viewid.
    IF sy-subrc = 0.
      l_comp_type_pg   = 'NWPLACETYPE_PG'.
      ASSIGN COMPONENT l_comp_type_pg OF STRUCTURE <l_wa_n>
                       TO <l_type_pg>.
      <l_type_pg>      = ls_nwview_014-nwplacetype_pg.
      l_comp_id_pg     = 'NWPLACEID_PG'.
      ASSIGN COMPONENT l_comp_id_pg   OF STRUCTURE <l_wa_n>
                       TO <l_id_pg>.
      <l_id_pg>        = ls_nwview_014-nwplaceid_pg.
    ENDIF.
  ENDIF.
* mandant
  l_comp_mandt = 'MANDT'.
  ASSIGN COMPONENT l_comp_mandt OF STRUCTURE <l_wa_n> TO <l_mandt>.
  IF <l_mandt> IS INITIAL.
    <l_mandt> = sy-mandt.
  ENDIF.
* update flag
  l_comp_kz = 'KZ'.
  ASSIGN COMPONENT l_comp_kz OF STRUCTURE <l_wa_n> TO <l_kz>.
  <l_kz> = 'U'.
  APPEND <l_wa_n> TO <lt_n>.
* Alte Daten
  CLEAR <l_wa_o>.
  MOVE-CORRESPONDING p_viewvar_old TO <l_wa_o>.
  APPEND <l_wa_o> TO <lt_o>.
* Verbucher aufrufen
  DESCRIBE TABLE <lt_n>.
  IF sy-tfill > 0.
    IF p_update_task = on.
      CALL FUNCTION l_func_name IN UPDATE TASK
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwview = <lt_n>
          t_o_nwview = <lt_o>.
    ELSE.
      CALL FUNCTION l_func_name
        EXPORTING
          i_tcode    = sy-tcode
        TABLES
          t_n_nwview = <lt_n>
          t_o_nwview = <lt_o>.
    ENDIF.
  ENDIF.

ENDFORM.                    " VERBUCHEN_NWVIEW

*&---------------------------------------------------------------------*
*&      Form  READ_SELVAR
*&---------------------------------------------------------------------*
*       Lesen des Inhalts einer Selektionsvariante
*----------------------------------------------------------------------*
*      --> P_VIEWVAR   Sicht mit Varianten
*      --> P_PLACE     Arbeitsumfeld
*      <-- PT_SELVAR   Selektionsvariante (Inhalt)
*      <-- PT_MESSAGE  Meldungen
*      <-- P_RC        Returncode
*----------------------------------------------------------------------*
FORM read_selvar USING    value(p_viewvar) LIKE rnviewvar
                          value(p_place)   LIKE nwplace
                 CHANGING pt_selvar        TYPE tyt_selvars
                          pt_message       TYPE tyt_messages
                          p_rc             LIKE sy-subrc.

  DATA: l_wa_msg          TYPE ty_message,
        l_wa_nwplace_001  LIKE nwplace_001.

  p_rc = 0.
  CLEAR: pt_selvar, pt_message. REFRESH: pt_selvar, pt_message.

  CALL FUNCTION 'RS_VARIANT_CONTENTS'
       EXPORTING
              report                = p_viewvar-reports
              variant               = p_viewvar-svariantid
*             MOVE_OR_WRITE         = 'W'
*             NO_IMPORT             = ' '
*      IMPORTING
*             SP                    =
       TABLES
              valutab               = pt_selvar
       EXCEPTIONS
              variant_non_existent  = 1
              variant_obsolete      = 2
              OTHERS                = 3.
  p_rc = sy-subrc.
  IF p_rc <> 0.
*   Selektionsvariante & für Report & konnte nicht gefunden werden
    PERFORM build_bapiret2(sapmn1pa)
            USING    'E' 'NF1' '229' p_viewvar-svariantid
                     p_viewvar-reports space space space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO pt_message.
    EXIT.
  ENDIF.

* Ist die OE des Arbeitsumfeldes befüllt, aber die der
* Selektionsvariante leer, soll sie aus dem A.Umfeld befüllt werden
  CLEAR l_wa_nwplace_001.
  PERFORM fill_oe_from_wplace(sapln1workplace)
                                         USING    p_viewvar-viewtype
                                                  p_place-wplacetype
                                                  p_place-wplaceid
                                                  l_wa_nwplace_001
                                         CHANGING pt_selvar.

ENDFORM.                    " READ_SELVAR
