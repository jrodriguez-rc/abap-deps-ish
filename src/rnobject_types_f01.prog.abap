*----------------------------------------------------------------------*
***INCLUDE RNOBJECT_TYPES_F01 .
*----------------------------------------------------------------------*


*-------------------------------------------------------------------
* Form INITIALIZATION
*-------------------------------------------------------------------
FORM initialization.
ENDFORM.   " initialization



*-------------------------------------------------------------------
* Form AT_SELECTION_SCREEN
*-------------------------------------------------------------------
FORM at_selection_screen.
* Nothing here yet
ENDFORM.   " at_selection_screen



*-------------------------------------------------------------------
* Form TOP_OF_PAGE
*-------------------------------------------------------------------
FORM top_of_page .

  WRITE: /1 <g_line>.
  PERFORM col_background USING off.
  WRITE: /1 <g_vline> NO-GAP.
  PERFORM col_heading USING on.
  WRITE:  2(40) 'Programmobjekt'(002),
           (30) 'Konstantenname'(003),
           (6)  'Wert'(004),
           (30) 'Entwicklungsklasse'(006),
           (1)  'K'(005).                                   "#EC *
  PERFORM col_background USING off.
  POSITION g_line_size.
  WRITE: sy-vline NO-GAP.

ENDFORM.                    " top_of_page



*-------------------------------------------------------------------
* Form TOP_OF_PAGE
*-------------------------------------------------------------------
FORM start_of_selection.
  DATA: lt_object_type    TYPE ish_t_obj_constant,
        lt_tadir          TYPE gtyt_tadir,
        ls_tadir          TYPE gty_tadir,
        ls_outtab         TYPE gty_outtab,
        lt_message        TYPE ishmed_t_messages,
        l_next_free_value TYPE ish_object_type,
        l_intens          TYPE c,
        l_vline           TYPE c LENGTH 200,
        l_rc              TYPE ish_method_rc,               "#EC NEEDED
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
  FIELD-SYMBOLS:
        <ls_obj_type>     TYPE ish_s_obj_constant,
        <ls_outtab>       TYPE gty_outtab,
        <ls_msg>          TYPE rn1message.

* -----------------------------------------------
* Initialization
  g_line_size  = 114.

  CLEAR: l_vline.
  l_vline(1) = sy-vline.
  ASSIGN sy-uline+0(g_line_size) TO <g_line>.
  ASSIGN l_vline+0(g_line_size)  TO <g_vline>.

  CLEAR: lt_object_type[],
         gt_outtab[],
         lr_errorhandler.
  l_rc = 0.
  NEW-PAGE NO-TITLE LINE-SIZE g_line_size.

* -----------------------------------------------
* Call function module to get the object types.
  CALL FUNCTION 'ISH_READ_OBJECT_TYPES'
    EXPORTING
      i_customer_obj    = '*'
    IMPORTING
      et_object_type    = lt_object_type
      e_next_free_value = l_next_free_value
      e_rc              = l_rc
    CHANGING
      cr_errorhandler   = lr_errorhandler.
  CLEAR: lt_message[].
  IF NOT lr_errorhandler IS INITIAL.
    CALL METHOD lr_errorhandler->get_messages
      IMPORTING
        t_extended_msg = lt_message.
    SORT lt_message BY parameter.
  ENDIF.

* Select the development class (the package) for each object
  CLEAR: lt_tadir[].
  IF NOT lt_object_type[] IS INITIAL.
    SELECT obj_name devclass                   "#EC CI_SGLSELECT "#EC CI_GENBUFF
           FROM tadir INTO TABLE lt_tadir
           FOR ALL ENTRIES IN lt_object_type
           WHERE pgmid    = 'R3TR'
           AND   object   IN ('CLAS','INTF')
           AND   obj_name = lt_object_type-pgmobj_name
           AND   devclass IN gt_devcl.
  ENDIF.

* Build the outtab
  LOOP AT lt_object_type ASSIGNING <ls_obj_type>.
    CLEAR: ls_outtab.
    ls_outtab-pgmobj_name   = <ls_obj_type>-pgmobj_name.
    ls_outtab-cmpname       = <ls_obj_type>-cmpname.
    IF <ls_obj_type>-value CO ' 0123456789'.
      ls_outtab-value         = <ls_obj_type>-value.
    ENDIF.
    ls_outtab-cust_specific = <ls_obj_type>-cust_specific.
    ls_outtab-no_constant   = <ls_obj_type>-no_constant.
    READ TABLE lt_tadir INTO ls_tadir
         WITH KEY obj_name = ls_outtab-pgmobj_name.
    CHECK sy-subrc = 0.
    ls_outtab-devclass = ls_tadir-devclass.
    IF g_pgm_wo = on.
      READ TABLE lt_message TRANSPORTING NO FIELDS
           WITH KEY parameter = ls_outtab-pgmobj_name BINARY SEARCH.
      IF sy-subrc <> 0.
        CHECK ls_outtab-cmpname     IS INITIAL OR
              ls_outtab-value       IS INITIAL OR
              ls_outtab-no_constant  = on.
      ENDIF.
    ENDIF.
    IF g_stand = on.
      CHECK ls_outtab-cust_specific = off.
    ELSEIF g_cust = on.
      CHECK ls_outtab-cust_specific = on.
    ENDIF.
    APPEND ls_outtab TO gt_outtab.
  ENDLOOP.

* -----------------------------------------------
* Write the list

* First write the next free number
  PERFORM col_background USING off.
  WRITE: /1 <g_line> NO-GAP.
  WRITE: /1 <g_vline> NO-GAP.

  PERFORM col_group USING on.
  WRITE:  2 'Nächster verfügbarer Wert: '(009),             "#EC *
            l_next_free_value.
  POSITION g_line_size.
  WRITE: sy-vline NO-GAP.

* Write the constants
  IF g_sortdc = on.
    SORT gt_outtab BY devclass cmpname value.
  ELSEIF g_sortcn = on.
    SORT gt_outtab BY cmpname value.
  ELSEIF g_sortpo = on.
    SORT gt_outtab BY pgmobj_name value.
  ELSE.
    SORT gt_outtab BY value.
  ENDIF.

  l_intens = on.

  PERFORM col_background USING off.
  WRITE: /1 <g_line> NO-GAP.

  LOOP AT gt_outtab ASSIGNING <ls_outtab>.
    PERFORM col_background USING off.
    WRITE: /1 <g_vline> NO-GAP.

    PERFORM col_normal USING l_intens.
    WRITE:  2    <ls_outtab>-pgmobj_name.
    IF <ls_outtab>-no_constant = on  OR
       <ls_outtab>-value IS INITIAL.
      PERFORM col_total USING l_intens.
    ENDIF.
    WRITE:       <ls_outtab>-cmpname,
             (6) <ls_outtab>-value RIGHT-JUSTIFIED.

    PERFORM col_normal USING l_intens.
    WRITE:       <ls_outtab>-devclass,
                 <ls_outtab>-cust_specific.

    POSITION g_line_size.
    WRITE: sy-vline NO-GAP.

    LOOP AT lt_message ASSIGNING <ls_msg>
         WHERE parameter = <ls_outtab>-pgmobj_name.
      IF <ls_msg>-type CA 'EA'.
        PERFORM col_negative USING l_intens.
      ELSE.
        PERFORM col_normal USING l_intens.
      ENDIF.
      WRITE: /1 <g_vline> NO-GAP.
      IF <ls_msg>-type CA 'EA'.
        WRITE: 2 'Fehler:'(007).
      ELSEIF <ls_msg>-type = 'W'.
        WRITE: 2 'Warnung:'(008).
      ENDIF.
      WRITE: (90) <ls_msg>-message.
      POSITION g_line_size.
      WRITE: sy-vline NO-GAP.

      IF <ls_msg>-message+90 IS NOT INITIAL.
        WRITE: /1 <g_vline> NO-GAP.
        WRITE: 18(90) <ls_msg>-message+90.
        POSITION g_line_size.
        WRITE: sy-vline NO-GAP.
      ENDIF.

      DELETE lt_message.
    ENDLOOP.

    IF l_intens = on.
      l_intens = off.
    ELSE.
      l_intens = on.
    ENDIF.
  ENDLOOP.

* Write further messages from the errorhandler, but only the
* messages which have no object assigned to
  LOOP AT lt_message ASSIGNING <ls_msg>
       WHERE parameter IS INITIAL.
    WRITE: /1 <g_vline> NO-GAP.
    IF <ls_msg>-type CA 'EA'.
      WRITE: 2 'Fehler:'(007).
    ELSEIF <ls_msg>-type = 'W'.
      WRITE: 2 'Warnung:'(008).
    ENDIF.
    WRITE: (90) <ls_msg>-message.
    POSITION g_line_size.
    WRITE: sy-vline NO-GAP.
    IF <ls_msg>-message+90 IS NOT INITIAL.
      WRITE: /1 <g_vline> NO-GAP.
      WRITE: 18(90) <ls_msg>-message+90.
      POSITION g_line_size.
      WRITE: sy-vline NO-GAP.
    ENDIF.
  ENDLOOP.

  WRITE: /1 <g_line> NO-GAP.

  WRITE: /1 <g_vline> NO-GAP.
  DESCRIBE TABLE gt_outtab.
  WRITE:  2 'Anzahl Objekttypen: '(011),
            sy-tfill.
  POSITION g_line_size.
  WRITE: sy-vline NO-GAP.
  WRITE: /1 <g_line> NO-GAP.

ENDFORM.   " start_of_selection
