*----------------------------------------------------------------------*
***INCLUDE LN_SDY_COLLAPSILBEF01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  initialize_0100
*&---------------------------------------------------------------------*
*       initialize dynpro 100
*----------------------------------------------------------------------*
FORM initialize_0100.

* object references
  DATA: lr_dynprofields    TYPE REF TO cl_ish_field_values,
        lr_subscr          TYPE REF TO if_ish_screen,
        lr_error           TYPE REF TO cl_ishmed_errorhandling.
* definitions
  DATA: ls_field_value     TYPE rnfield_value,
        l_rc               TYPE ish_method_rc,
        ls_parent          TYPE rnscr_parent.
* ---------- ---------- ----------
* Initializations
  g_collapsible_pgm   = 'SAPLN1SC'.
  g_collapsible_dynnr = '0001'.
* ---------- ---------- ----------
  IF NOT gr_collapsible IS INITIAL.
    CALL METHOD gr_collapsible->process_before_output
      IMPORTING
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = lr_error.
  ENDIF.
* ---------- ---------- ----------
* embedded subscreens in the current screen are stored
* in lr_dynprofields (i_type = 'S');
* get the parameters for 'CALL SUBSCREEN ..INCLUDING ..'
* ---------- ---------- ----------
  IF NOT gr_collapsible IS INITIAL.
    CALL METHOD gr_collapsible->get_data
      IMPORTING
        e_screen_values = lr_dynprofields.
  ENDIF.
  IF NOT lr_dynprofields IS INITIAL.
*   subscreen with the header data of an appointment
    CALL METHOD lr_dynprofields->get_data
      EXPORTING
        i_fieldname    = 'G_CO_SUBSCREEN'
        i_type         = 'S'
      IMPORTING
        e_field_value  = ls_field_value
        e_rc           = l_rc
      CHANGING
        c_errorhandler = lr_error.
    IF NOT ls_field_value-object IS INITIAL.
      lr_subscr ?= ls_field_value-object.
      CALL METHOD lr_subscr->get_parent
        IMPORTING
          es_parent = ls_parent.
      g_collapsible_pgm   = ls_parent-repid.
      g_collapsible_dynnr = ls_parent-dynnr.
*     Couple the screen object with its corresponding function group.
      CALL METHOD lr_subscr->before_call_subscreen
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = lr_error.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

ENDFORM.                    " initialize_0100


*&---------------------------------------------------------------------*
*&      Form  pbo_pb_collapse
*&---------------------------------------------------------------------*
*       Process Before Output for SC_PB_COLLAPSE.
*----------------------------------------------------------------------*
FORM pbo_pb_collapse.

  DATA: lr_error           TYPE REF TO cl_ishmed_errorhandling,
        lr_scr_pb_coll     TYPE REF TO cl_ish_scr_pushbutton,
        l_rc               TYPE ish_method_rc,
        ls_parent          TYPE rnscr_parent.

* Initializations
  g_pb_coll_pgm   = 'SAPLN1SC'.
  g_pb_coll_dynnr = '0001'.

  CHECK NOT gr_collapsible IS INITIAL.

* Get the pushbutton object.
  CALL METHOD gr_collapsible->get_scr_pb_coll
    IMPORTING
      er_scr_pb_coll  = lr_scr_pb_coll
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  CHECK NOT lr_scr_pb_coll IS INITIAL.

* Handle pgm + dynnr.
  CALL METHOD lr_scr_pb_coll->get_parent
    IMPORTING
      es_parent = ls_parent.
  g_pb_coll_pgm   = ls_parent-repid.
  g_pb_coll_dynnr = ls_parent-dynnr.

* Couple the pushbutton object with its function group.
  CALL METHOD lr_scr_pb_coll->before_call_subscreen
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.

ENDFORM.                    " initialize_0100


*&---------------------------------------------------------------------*
*&      Form  pai_0100
*&---------------------------------------------------------------------*
*       Process After Input for dynpro 0100.
*----------------------------------------------------------------------*
FORM pai_0100 .

* object references
  DATA: lr_dynprofields    TYPE REF TO cl_ish_field_values,
        lr_subscr          TYPE REF TO if_ish_screen,
        lr_error           TYPE REF TO cl_ishmed_errorhandling.
* definitions
  DATA: ls_field_value     TYPE rnfield_value,
        l_rc               TYPE ish_method_rc.
* ---------- ---------- ----------
* embedded subscreens in the current screen are stored
* in lr_dynprofields (i_type = 'S');
* get the parameters for 'CALL SUBSCREEN ..INCLUDING ..'
* ---------- ---------- ----------
  IF NOT gr_collapsible IS INITIAL.
    CALL METHOD gr_collapsible->get_data
      IMPORTING
        e_screen_values = lr_dynprofields.
  ENDIF.
  IF NOT lr_dynprofields IS INITIAL.
*   subscreen with the header data of an appointment
    CALL METHOD lr_dynprofields->get_data
      EXPORTING
        i_fieldname    = cl_ish_scr_collapsible=>co_fieldname_subscreen
      IMPORTING
        e_field_value  = ls_field_value
        e_rc           = l_rc
      CHANGING
        c_errorhandler = lr_error.
    IF NOT ls_field_value-object IS INITIAL.
      lr_subscr ?= ls_field_value-object.
*     Couple the screen object with its corresponding function group.
      CALL METHOD lr_subscr->before_call_subscreen
        IMPORTING
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = lr_error.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

ENDFORM.                                                    " pai_0100
