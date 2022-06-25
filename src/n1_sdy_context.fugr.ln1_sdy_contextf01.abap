*----------------------------------------------------------------------*
***INCLUDE LN1_SDY_CONTEXTF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  pbo_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pbo_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_context IS INITIAL.

* Set dynpro fields
  CALL METHOD gr_subscr_context->process_before_output
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                                                    "pbo_0100
*&---------------------------------------------------------------------*
*&      Form  pai_0100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM pai_0100 .

* definitions
  DATA: l_rc                  TYPE ish_method_rc,
        lr_error              TYPE REF TO cl_ishmed_errorhandling.

  CHECK NOT gr_subscr_context IS INITIAL.

  CALL METHOD gr_subscr_context->process_after_input
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                                                    " pai_0100
*&---------------------------------------------------------------------*
*&      Form  init_tabstrip
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM init_tabstrip USING p_rc TYPE ish_method_rc
                         pr_errorhandler
                            TYPE REF TO cl_ishmed_errorhandling.

  CLEAR: p_rc.

  CALL METHOD gr_subscr_context->init_tabstrip
    IMPORTING
      e_rc            = p_rc
    CHANGING
      cr_errorhandler = pr_errorhandler.


ENDFORM.                    " init_tabstrip
*&---------------------------------------------------------------------*
*&      Form  set_default_tab
*&---------------------------------------------------------------------*
*       Führer, ID. 9239
*       Registerkarte aufschlagen (nur beim Ersten Aufruf)
*----------------------------------------------------------------------*
FORM set_default_tab
   USING     value(p_regcard)   LIKE g_regcard
   CHANGING  p_rc               TYPE ish_method_rc
             pr_errorhandler    TYPE REF TO cl_ishmed_errorhandling
             p_function         LIKE g_tabstrip_dynpro-function
             p_scroll_position  LIKE g_tabstrip_dynpro-function.

  CLEAR: p_rc.

  CALL METHOD gr_subscr_context->set_default_tab
    EXPORTING
      i_regcard         = p_regcard
    IMPORTING
      e_function        = p_function
      e_scroll_position = p_scroll_position
      e_rc              = p_rc
    CHANGING
      cr_errorhandler   = pr_errorhandler.
  CHECK p_rc = 0.

ENDFORM.                    " set_default_tab
*&---------------------------------------------------------------------*
*&      Form  set_tabstrip_dyn
*&---------------------------------------------------------------------*
*       Dynamische Anzeige der Registerkarten
*----------------------------------------------------------------------*
FORM set_tabstrip_dyn USING p_rc TYPE ish_method_rc
                            pr_errorhandler
                                 TYPE REF TO cl_ishmed_errorhandling.

  CLEAR: p_rc.

  DATA: l_tabstrip TYPE rn1_dynp_context_tabstrip.
  DATA: l_function     TYPE sy-ucomm,
        l_active       TYPE ish_on_off,
        l_active_tab   TYPE sy-ucomm,
        l_tab_name(50) TYPE c,
        l_no(2)        TYPE n,
        l_sort_no(2)         TYPE n,
        l_tabstrip_dyn       LIKE LINE OF gt_tabstrip_dyn,
        l_tabstrip_name(50)  TYPE c  VALUE 'TS_CONTEXT_TAB'.

* Feldsymbole
  FIELD-SYMBOLS: <l_field>  TYPE ANY.

  CLEAR: g_tabstrip_dynpro, gt_tabstrip_dyn[].
  CALL METHOD gr_subscr_context->get_tabstrip_data
    IMPORTING
      et_tabstrip       = gt_tabstrip_dyn
      e_tabstrip_dynpro = g_tabstrip_dynpro.

* Loop at screen don't call in the class!!
  LOOP AT SCREEN.
*   ----------
    CLEAR: l_function.
*   ----------
    IF screen-name(14) = 'TS_CONTEXT_TAB'.
*     ----------
*     Um die Dynpromodifikation der Registerkarten zu ignorieren
*     - diese hier nochmals aktiv setzen.
*     Muss erfolgen bevor Titel gesetzt wird da dieser sonst
*     ignoriert wird.
      screen-input     = true.
      screen-output    = true.
      screen-invisible = false.
*     ----------
      l_sort_no = screen-name+14(2).
      READ TABLE gt_tabstrip_dyn INTO l_tabstrip_dyn
         WITH KEY sort = l_sort_no.
      IF sy-subrc = 0.
        CONCATENATE l_tabstrip_name(14) l_tabstrip_dyn-sort
           INTO l_tabstrip_name.
        ASSIGN (l_tabstrip_name) TO <l_field>.
        IF sy-subrc = 0.
          <l_field> = l_tabstrip_dyn-text.
        ENDIF.
        l_function = l_tabstrip_dyn-id_sub.
      ELSE.
        screen-active = false.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

    IF NOT l_function IS INITIAL.
* ---------- ---------- ----------
*     Prüfung ob eine Registerkarte aktiv ist.
      CALL METHOD gr_subscr_context->check_tabstrip_active_dyn
        EXPORTING
          i_id_sub        = l_function
        IMPORTING
          e_active        = l_active
          e_rc            = p_rc
        CHANGING
          cr_errorhandler = pr_errorhandler.
      CHECK p_rc = 0.
      screen-active    = l_active.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

  CALL METHOD gr_subscr_context->set_tabstrip_dyn
    IMPORTING
      e_rc            = p_rc
      e_tabstrip      = l_tabstrip
    CHANGING
      cr_errorhandler = pr_errorhandler.
  CHECK p_rc = 0.
  g_tabstrip-activetab = l_tabstrip-function.

ENDFORM.                    " set_tabstrip_dyn
**-------------------------------------------------------------------
** GET_FIRST_ACTIVE_TAB
** Den ersten aktiven Tabstrip ermitteln
** Reihenfolge: OP/Behandlung vor Aufnahme vor Einweisung vor
**              Weitere Angaben
**-------------------------------------------------------------------
*FORM get_first_active_tab USING p_function TYPE sy-ucomm
*                                p_rc       TYPE ish_method_rc
*                                pr_errorhandler
*                                    TYPE REF TO cl_ishmed_errorhandling.
*
*  CLEAR: p_rc.
*
*  CALL METHOD gr_subscr_context->get_first_active_tab
*    IMPORTING
*      e_function      = p_function
*      e_rc            = p_rc
*    CHANGING
*      cr_errorhandler = pr_errorhandler.
*
*ENDFORM.   " get_first_active_tab
*&---------------------------------------------------------------------*
*&      Form  init_context
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM init_context  USING    p_rc TYPE ish_method_rc
                            pr_errorhandler
                               TYPE REF TO cl_ishmed_errorhandling.

  CLEAR: p_rc.
*  IF g_first_time = on.
  CALL METHOD gr_subscr_context->init_context
    IMPORTING
      e_rc            = p_rc
    CHANGING
      cr_errorhandler = pr_errorhandler.
*  ENDIF.
ENDFORM.                    " init_context

*&---------------------------------------------------------------------*
*&      Form  refresh_tabstrip
*&---------------------------------------------------------------------*
*       aktualisieren der Tabstrip-Tabelle
*----------------------------------------------------------------------*
*      -->P_RC  Returncode
*      -->PR_ERRORHANDLER  Klasse für Fehlerbehandlung
*----------------------------------------------------------------------*
FORM refresh_tabstrip  USING    p_rc TYPE ish_method_rc
                                pr_errorhandler
                                  TYPE REF TO cl_ishmed_errorhandling.

* refresh only tabstrip-table
  CLEAR p_rc.
  CALL METHOD gr_subscr_context->refresh_tabstrip
    IMPORTING
      e_rc            = p_rc
    CHANGING
      cr_errorhandler = pr_errorhandler.

ENDFORM.                    " refresh_tabstrip
