class CL_ISH_SC_RANGE definition
  public
  create protected .

*"* public components of class CL_ISH_SC_RANGE
*"* do not include other source files here!!!
public section.
  type-pools ICON .

  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .

  type-pools CO .
  class-methods CREATE
    importing
      !I_RANGEID type INT1
      !I_FIELDNAME_LOW type ISH_FIELDNAME
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !I_ICON_ENTER_MORE type N1ICON optional
      !I_ICON_DISPLAY_MORE type N1ICON optional
      !I_TITLE type SY-TITLE optional
      !I_TEXT type RSSELINT-TEXT optional
      !I_SIGNED type RSCONVERT-SIGN default ON
      !I_LOWER_CASE type RSCONVERT-LOWER default OFF
      !I_NO_INTERVAL_CHECK type RSVUVINT-NO_INT_CHK default OFF
      !I_JUST_INCL type ISH_ON_OFF default OFF
      !I_EXCLUDED_OPTIONS type RSOPTIONS optional
      !I_DESCRIPTION type RSFLDESC optional
      !I_HELP_FIELD type RSSCR-DBFIELD optional
      !I_SEARCH_HELP type DDSHDESCR-SHLPNAME optional
      !I_TAB_AND_FIELD type RSTABFIELD optional
    exporting
      value(ER_SC_RANGE) type ref to CL_ISH_SC_RANGE
    changing
      !C_DYNPFIELD_LOW type ANY
      !C_DYNPFIELD_BUTTON type ANY
      !CT_RANGE type TABLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods DESTROY .
  methods GET_VCODE
    returning
      value(R_VCODE) type TNDYM-VCODE .
  methods PAI .
  methods PBO .
  methods RUN_POPUP
    importing
      !I_TITLE type SY-TITLE optional
      !I_TEXT type RSSELINT-TEXT optional
      !I_SIGNED type RSCONVERT-SIGN default ON
      !I_LOWER_CASE type RSCONVERT-LOWER default OFF
      !I_NO_INTERVAL_CHECK type RSVUVINT-NO_INT_CHK default OFF
      !I_JUST_INCL type ISH_ON_OFF default OFF
      !I_EXCLUDED_OPTIONS type RSOPTIONS optional
      !I_DESCRIPTION type RSFLDESC optional
      !I_HELP_FIELD type RSSCR-DBFIELD optional
      !I_SEARCH_HELP type DDSHDESCR-SHLPNAME optional
      !I_TAB_AND_FIELD type RSTABFIELD optional
    returning
      value(R_CANCELLED) type ISH_ON_OFF .
  methods SET_VCODE
    importing
      !I_VCODE type TNDYM-VCODE .
  methods GET_RANGEID
    returning
      value(R_RANGEID) type INT1 .
protected section.
*"* protected components of class CL_ISH_SC_RANGE
*"* do not include other source files here!!!

  data GR_DYNPFIELD_BUTTON type ref to DATA .
  data GR_DYNPFIELD_LOW type ref to DATA .
  data GR_RANGE type ref to DATA .
  data G_DESCRIPTION type RSFLDESC .
  data G_EXCLUDED_OPTIONS type RSOPTIONS .
  data G_FIELDNAME_LOW type ISH_FIELDNAME .
  data G_HELP_FIELD type RSSCR-DBFIELD .
  data G_ICON_DISPLAY_MORE type N1ICON .
  data G_ICON_ENTER_MORE type N1ICON .
  data G_JUST_INCL type ISH_ON_OFF value OFF .
  data G_LOWER_CASE type RSCONVERT-LOWER value OFF .
  data G_NO_INTERVAL_CHECK type RSVUVINT-NO_INT_CHK value OFF .
  data G_RANGEID type INT1 .
  data G_SEARCH_HELP type DDSHDESCR-SHLPNAME .
  data G_SIGNED type RSCONVERT-SIGN value ON .
  data G_TAB_AND_FIELD type RSTABFIELD .
  data G_TEXT type RSSELINT-TEXT .
  data G_TITLE type SY-TITLE .
  data G_VCODE type TNDYM-VCODE .

  methods COMPLETE_CONSTRUCTION
    importing
      !I_RANGEID type INT1
      !I_FIELDNAME_LOW type ISH_FIELDNAME
      !I_VCODE type TNDYM-VCODE default CO_VCODE_DISPLAY
      !I_ICON_ENTER_MORE type N1ICON optional
      !I_ICON_DISPLAY_MORE type N1ICON optional
      !I_TITLE type SY-TITLE optional
      !I_TEXT type RSSELINT-TEXT optional
      !I_SIGNED type RSCONVERT-SIGN default ON
      !I_LOWER_CASE type RSCONVERT-LOWER default OFF
      !I_NO_INTERVAL_CHECK type RSVUVINT-NO_INT_CHK default OFF
      !I_JUST_INCL type ISH_ON_OFF default OFF
      !I_EXCLUDED_OPTIONS type RSOPTIONS optional
      !I_DESCRIPTION type RSFLDESC optional
      !I_HELP_FIELD type RSSCR-DBFIELD optional
      !I_SEARCH_HELP type DDSHDESCR-SHLPNAME optional
      !I_TAB_AND_FIELD type RSTABFIELD optional
    changing
      !C_DYNPFIELD_LOW type ANY
      !C_DYNPFIELD_BUTTON type ANY
      !CT_RANGE type TABLE
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_SC_RANGE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SC_RANGE IMPLEMENTATION.


METHOD complete_construction.

  DATA: lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling.

* Initializations.
  g_rangeid           = i_rangeid.
  g_fieldname_low     = i_fieldname_low.
  g_vcode             = i_vcode.
  g_icon_enter_more   = i_icon_enter_more.
  g_icon_display_more = i_icon_display_more.
  g_title             = i_title.
  g_text              = i_text.
  g_signed            = i_signed.
  g_lower_case        = i_lower_case.
  g_no_interval_check = i_no_interval_check.
  g_just_incl         = i_just_incl.
  g_excluded_options  = i_excluded_options.
  g_description       = i_description.
  g_help_field        = i_help_field.
  g_search_help       = i_search_help.
  g_tab_and_field     = i_tab_and_field.
  GET REFERENCE OF c_dynpfield_low    INTO gr_dynpfield_low.
  GET REFERENCE OF c_dynpfield_button INTO gr_dynpfield_button.
  GET REFERENCE OF ct_range           INTO gr_range.

* Set the icons.
  IF g_icon_enter_more IS INITIAL.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name                  = icon_enter_more
      IMPORTING
        RESULT                = g_icon_enter_more
      EXCEPTIONS
        icon_not_found        = 1
        outputfield_too_short = 2
        OTHERS                = 3.
  ENDIF.
  IF g_icon_display_more IS INITIAL.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name                  = icon_display_more
      IMPORTING
        RESULT                = g_icon_display_more
      EXCEPTIONS
        icon_not_found        = 1
        outputfield_too_short = 2
        OTHERS                = 3.
  ENDIF.

* Check initialization.
  IF gr_dynpfield_low    IS NOT BOUND OR
     gr_dynpfield_button IS NOT BOUND OR
     gr_range            IS NOT BOUND.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '004'
        i_mv1           = 'CL_ISH_SC_RANGE'
      CHANGING
        cr_errorhandler = lr_errorhandler.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD create.

  DATA: lr_sc_range  TYPE REF TO cl_ish_sc_range.

  CREATE OBJECT lr_sc_range.

  TRY.
      CALL METHOD lr_sc_range->complete_construction
        EXPORTING
          i_rangeid           = i_rangeid
          i_fieldname_low     = i_fieldname_low
          i_vcode             = i_vcode
          i_icon_enter_more   = i_icon_enter_more
          i_icon_display_more = i_icon_display_more
          i_title             = i_title
          i_text              = i_text
          i_signed            = i_signed
          i_lower_case        = i_lower_case
          i_no_interval_check = i_no_interval_check
          i_just_incl         = i_just_incl
          i_excluded_options  = i_excluded_options
          i_description       = i_description
          i_help_field        = i_help_field
          i_search_help       = i_search_help
          i_tab_and_field     = i_tab_and_field
        CHANGING
          c_dynpfield_low     = c_dynpfield_low
          c_dynpfield_button  = c_dynpfield_button
          ct_range            = ct_range.
    CLEANUP.
      lr_sc_range->destroy( ).
  ENDTRY.

  er_sc_range = lr_sc_range.

ENDMETHOD.


METHOD destroy.

  CLEAR: gr_dynpfield_low,
         gr_dynpfield_button,
         gr_range,
         g_vcode.

ENDMETHOD.


METHOD get_rangeid.

  r_rangeid = g_rangeid.

ENDMETHOD.


METHOD get_vcode.

  r_vcode = g_vcode.

ENDMETHOD.


METHOD pai.

  DATA: lr_tabledescr   TYPE REF TO cl_abap_tabledescr,
        lr_structdescr  TYPE REF TO cl_abap_structdescr,
        lr_s_range      TYPE REF TO data,
        l_set_low       TYPE ish_on_off.

  FIELD-SYMBOLS: <lt_range>            TYPE table,
                 <ls_range>            TYPE ANY,
                 <l_sign>              TYPE ANY,
                 <l_option>            TYPE ANY,
                 <l_low>               TYPE ANY,
                 <l_dynpfield_button>  TYPE ANY,
                 <l_dynpfield_low>     TYPE ANY.

* Initial checking.
  CHECK gr_range            IS BOUND.
  CHECK gr_dynpfield_low    IS BOUND.
  CHECK gr_dynpfield_button IS BOUND.
  CHECK g_fieldname_low     IS NOT INITIAL.

* Assignments.
  ASSIGN gr_range->*            TO <lt_range>.
  CHECK sy-subrc = 0.
  ASSIGN gr_dynpfield_low->*    TO <l_dynpfield_low>.
  CHECK sy-subrc = 0.
  ASSIGN gr_dynpfield_button->* TO <l_dynpfield_button>.
  CHECK sy-subrc = 0.

* Process only if input is allowed.
  CHECK g_vcode               <> co_vcode_display.
  CHECK g_excluded_options-eq  = off.

* Try to actualize the first valid entry of the range.
  l_set_low = off.
  LOOP AT <lt_range> ASSIGNING <ls_range>.
    ASSIGN COMPONENT 'SIGN'   OF STRUCTURE <ls_range> TO <l_sign>.
    CHECK sy-subrc = 0.
    CHECK <l_sign> = 'I'.
    ASSIGN COMPONENT 'OPTION' OF STRUCTURE <ls_range> TO <l_option>.
    CHECK sy-subrc = 0.
    CHECK <l_option> = 'EQ' OR
          <l_option> = 'CP'.
    l_set_low = on.
    EXIT.
  ENDLOOP.
  IF l_set_low = on.
    ASSIGN COMPONENT 'LOW' OF STRUCTURE <ls_range> TO <l_low>.
    CHECK sy-subrc = 0.
    IF <l_dynpfield_low> IS INITIAL.
      DELETE <lt_range> INDEX 1.
    ELSE.
      <l_low> = <l_dynpfield_low>.
    ENDIF.
    EXIT.
  ENDIF.

* Try to insert a new entry.
  CHECK <l_dynpfield_low> IS NOT INITIAL.
  TRY.
      lr_tabledescr ?= cl_abap_typedescr=>describe_by_data( <lt_range> ).
    CATCH cx_sy_move_cast_error.
  ENDTRY.
  CHECK lr_tabledescr IS BOUND.
  TRY.
      lr_structdescr ?= lr_tabledescr->get_table_line_type( ).
    CATCH cx_sy_move_cast_error.
  ENDTRY.
  CHECK lr_structdescr IS BOUND.
  CREATE DATA lr_s_range TYPE HANDLE lr_structdescr.
  ASSIGN lr_s_range->* TO <ls_range>.
  ASSIGN COMPONENT 'SIGN' OF STRUCTURE <ls_range> TO <l_sign>.
  CHECK sy-subrc = 0.
  ASSIGN COMPONENT 'OPTION' OF STRUCTURE <ls_range> TO <l_option>.
  CHECK sy-subrc = 0.
  ASSIGN COMPONENT 'LOW' OF STRUCTURE <ls_range> TO <l_low>.
  CHECK sy-subrc = 0.
  <l_sign>   = 'I'.
  IF <l_dynpfield_low> CA '*'.
    <l_option> = 'CP'.
  ELSE.
    <l_option> = 'EQ'.
  ENDIF.
  <l_low>    = <l_dynpfield_low>.
  APPEND <ls_range> TO <lt_range>.

ENDMETHOD.


METHOD pbo.

  DATA: l_set_low  TYPE ish_on_off.

  FIELD-SYMBOLS: <lt_range>            TYPE table,
                 <ls_range>            TYPE ANY,
                 <l_sign>              TYPE ANY,
                 <l_option>            TYPE ANY,
                 <l_low>               TYPE ANY,
                 <l_dynpfield_button>  TYPE ANY,
                 <l_dynpfield_low>     TYPE ANY.

* Initial checking.
  CHECK gr_range            IS BOUND.
  CHECK gr_dynpfield_low    IS BOUND.
  CHECK gr_dynpfield_button IS BOUND.
  CHECK g_fieldname_low     IS NOT INITIAL.

* Assignments.
  ASSIGN gr_range->*            TO <lt_range>.
  CHECK sy-subrc = 0.
  ASSIGN gr_dynpfield_low->*    TO <l_dynpfield_low>.
  CHECK sy-subrc = 0.
  ASSIGN gr_dynpfield_button->* TO <l_dynpfield_button>.
  CHECK sy-subrc = 0.

* Set the low dnyprofield.
  CLEAR: <l_dynpfield_low>.
  DO 1 TIMES.
    l_set_low = off.
    LOOP AT <lt_range> ASSIGNING <ls_range>.
      ASSIGN COMPONENT 'SIGN'   OF STRUCTURE <ls_range> TO <l_sign>.
      CHECK sy-subrc = 0.
      CHECK <l_sign> = 'I'.
      ASSIGN COMPONENT 'OPTION' OF STRUCTURE <ls_range> TO <l_option>.
      CHECK sy-subrc = 0.
      CHECK <l_option> = 'EQ' OR
            <l_option> = 'CP'.
      l_set_low = on.
      EXIT.
    ENDLOOP.
    CHECK l_set_low = on.
    ASSIGN COMPONENT 'LOW' OF STRUCTURE <ls_range> TO <l_low>.
    CHECK sy-subrc = 0.
    <l_dynpfield_low> = <l_low>.
  ENDDO.

* Set the button.
  CASE LINES( <lt_range> ).
    WHEN 0.
      <l_dynpfield_button> = g_icon_enter_more.
    WHEN 1.
      IF <l_dynpfield_low> IS INITIAL.
        <l_dynpfield_button> = g_icon_display_more.
      ELSE.
        <l_dynpfield_button> = g_icon_enter_more.
      ENDIF.
    WHEN OTHERS.
      <l_dynpfield_button> = g_icon_display_more.
  ENDCASE.

* Modify screen.
  IF g_vcode               = co_vcode_display    OR
     ( g_excluded_options-eq = on AND
       g_excluded_options-cp = on ).
    LOOP AT SCREEN.
      CASE screen-name.
        WHEN g_fieldname_low.
          screen-input = 0.
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.
      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.

ENDMETHOD.


METHOD run_popup.

  DATA: l_just_display        TYPE ish_on_off,
        l_title               LIKE g_title,
        l_text                LIKE g_text,
        l_signed              LIKE g_signed,
        l_lower_case          LIKE g_lower_case,
        l_no_interval_check   LIKE g_no_interval_check,
        l_just_incl           LIKE g_just_incl,
        l_excluded_options    LIKE g_excluded_options,
        l_description         LIKE g_description,
        l_help_field          LIKE g_help_field,
        l_search_help         LIKE g_search_help,
        l_tab_and_field       LIKE g_tab_and_field.

  FIELD-SYMBOLS: <lt_range>  TYPE table.

* Initializations.
  r_cancelled = on.

* Initial checking.
  CHECK gr_range IS BOUND.

* Assignments.
  ASSIGN gr_range->* TO <lt_range>.

* Set just_display.
  IF g_vcode = co_vcode_display.
    l_just_display = on.
  ELSE.
    l_just_display = off.
  ENDIF.

* Set other parameters.
  IF i_title IS SUPPLIED.
    l_title = i_title.
  ELSE.
    l_title = g_title.
  ENDIF.
  IF i_text IS SUPPLIED.
    l_text = i_text.
  ELSE.
    l_text = g_text.
  ENDIF.
  IF i_signed IS SUPPLIED.
    l_signed = i_signed.
  ELSE.
    l_signed = g_signed.
  ENDIF.
  IF i_lower_case IS SUPPLIED.
    l_lower_case = i_lower_case.
  ELSE.
    l_lower_case = g_lower_case.
  ENDIF.
  IF i_no_interval_check IS SUPPLIED.
    l_no_interval_check = i_no_interval_check.
  ELSE.
    l_no_interval_check = g_no_interval_check.
  ENDIF.
  IF i_just_incl IS SUPPLIED.
    l_just_incl = i_just_incl.
  ELSE.
    l_just_incl = g_just_incl.
  ENDIF.
  IF i_excluded_options IS SUPPLIED.
    l_excluded_options = i_excluded_options.
  ELSE.
    l_excluded_options = g_excluded_options.
  ENDIF.
  IF i_description IS SUPPLIED.
    l_description = i_description.
  ELSE.
    l_description = g_description.
  ENDIF.
  IF i_help_field IS SUPPLIED.
    l_help_field = i_help_field.
  ELSE.
    l_help_field = g_help_field.
  ENDIF.
  IF i_search_help IS SUPPLIED.
    l_search_help = i_search_help.
  ELSE.
    l_search_help = g_search_help.
  ENDIF.
  IF i_tab_and_field IS SUPPLIED.
    l_tab_and_field = i_tab_and_field.
  ELSE.
    l_tab_and_field = g_tab_and_field.
  ENDIF.

* Run the popup.
  CALL FUNCTION 'COMPLEX_SELECTIONS_DIALOG'
    EXPORTING
      title             = l_title
      text              = l_text
      signed            = l_signed
      lower_case        = l_lower_case
      no_interval_check = l_no_interval_check
      just_display      = l_just_display
      just_incl         = l_just_incl
      excluded_options  = l_excluded_options
      description       = l_description
      help_field        = l_help_field
      search_help       = l_search_help
      tab_and_field     = l_tab_and_field
    TABLES
      range             = <lt_range>
    EXCEPTIONS
      no_range_tab      = 1
      cancelled         = 2
      internal_error    = 3
      invalid_fieldname = 4
      OTHERS            = 5.
  CHECK sy-subrc = 0.

* Export.
  r_cancelled = off.

ENDMETHOD.


METHOD set_vcode.

  g_vcode = i_vcode.

ENDMETHOD.
ENDCLASS.
