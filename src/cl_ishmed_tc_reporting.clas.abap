class CL_ISHMED_TC_REPORTING definition
  public
  final
  create public .

public section.
  type-pools ICON .

  interfaces IF_ISHMED_OBJECT .

  class-methods F4_PATNR
    changing
      !CT_RANGE_PATNR type RNRANGEPATNR_TT .
  methods CONSTRUCTOR
    importing
      !IT_RANGE_EINRI type RNRANGEEINRI_TT
      !IT_RANGE_PATNR type RNRANGEPATNR_TT
      !IT_RANGE_USER type ISHMED_T_ME_RANGE_UNAME
      !IT_RANGE_DATE type ISHMED_T_RANGE_DATE
      !I_VIP type VIPKZ
    raising
      CX_ISHMED_TC_AUTHORITY .
  methods DISPLAY_DATA
    raising
      CX_SALV_MSG .
  type-pools ABAP .
  methods HAS_DATA
    returning
      value(R_VALUE) type ABAP_BOOL .
  methods SELECT_DATA .
protected section.
private section.

  constants CO_COLUMN_REASON type SALV_DE_COLUMN value 'REASON1'. "#EC NOTEXT
  constants CO_FC_REFRESH type SALV_DE_FUNCTION value 'REFRESH'. "#EC NOTEXT
  constants CO_FC_SHOW_LOG_ISHMED type SALV_DE_FUNCTION value 'SHOW_LOG_I'. "#EC NOTEXT
  constants CO_FC_SHOW_LOG type SALV_DE_FUNCTION value 'SHOW_LOG'. "#EC NOTEXT
  constants CO_GUI_STATUS_ISHMED type SYPFKEY value 'SALV_TABLE_STANDARD1'. "#EC NOTEXT
  constants CO_GUI_STATUS type SYPFKEY value 'SALV_TABLE_STANDARD'. "#EC NOTEXT
  constants CO_REPORT_NAME type SYREPID value 'RN1TC_REPORTING'. "#EC NOTEXT
  data GR_TABLE type ref to CL_SALV_TABLE .
  data GT_DATA type RN1TC_REQUEST_REPORT_DISPLAY_T .
  data GT_RANGE_DATE type ISHMED_T_RANGE_DATE .
  data GT_RANGE_EINRI type RNRANGEEINRI_TT .
  data GT_RANGE_PATNR type RNRANGEPATNR_TT .
  data GT_RANGE_USER type ISHMED_T_ME_RANGE_UNAME .
  data G_EINRI type EINRI .
  data G_VIP type VIPKZ .

  class-methods GET_EINRI_FROM_SCREEN
    returning
      value(R_VALUE) type EINRI .
  methods ADJUST_COLUMNS
    importing
      !IR_COLUMNS type ref to CL_SALV_COLUMNS .
  methods ADJUST_DATA .
  methods DEREGISTER_EVENTS .
  methods GET_EMERGENCY_ICON
    importing
      !I_EMERGENCY type N1TC_EMERGENCY_REQUEST
    returning
      value(R_VALUE) type N1TC_EMERGENCY_REQUEST_ICON .
  methods GET_PATIENT_NAME
    importing
      !I_PATNR type PATNR
    returning
      value(R_VALUE) type ISH_NAME_SEX_AGE .
  methods GET_REQUEST_TYPE_ICON
    importing
      !I_REQUEST_TYPE type N1TC_REQ_TYPE
    returning
      value(R_VALUE) type N1TC_REQ_TYPE_ICON .
  methods GET_USER_NAME
    importing
      !I_USER type XUBNAME
    returning
      value(R_VALUE) type AD_NAMTEXT .
  methods GET_VIP_ICON
    importing
      !I_VIP type VIPKZ
    returning
      value(R_VALUE) type ISH_VIP_ICON .
  methods ON_ADDED_FUNCTION
    for event ADDED_FUNCTION of CL_SALV_EVENTS_TABLE
    importing
      !SENDER
      !E_SALV_FUNCTION .
  methods ON_LINK_CLICK
    for event LINK_CLICK of CL_SALV_EVENTS_TABLE
    importing
      !SENDER
      !ROW
      !COLUMN .
  methods REASON_CLICKED
    importing
      !IS_DATA type RN1TC_REQUEST_REPORT_DISPLAY .
  methods REFRESH .
  methods REGISTER_EVENTS .
  methods SHOW_LOG_ISHMED .
  methods SHOW_LOG .
  methods SHOW_REQUEST_DELEGATION
    importing
      !IS_DATA type RN1TC_REQUEST_REPORT_DISPLAY .
  methods SHOW_REQUEST_TC
    importing
      !IS_DATA type RN1TC_REQUEST_REPORT_DISPLAY .
ENDCLASS.



CLASS CL_ISHMED_TC_REPORTING IMPLEMENTATION.


METHOD adjust_columns.
  DATA lr_column      TYPE REF TO cl_salv_column_table.

  TRY.
      lr_column ?= ir_columns->get_column( 'REQUEST_ID' ).
      lr_column->set_technical( if_salv_c_bool_sap=>true ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'REASON1' ).
      lr_column->set_output_length( 50 ).
      lr_column->set_cell_type( if_salv_c_cell_type=>hotspot ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'PATIENT' ).
      lr_column->set_output_length( 25 ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'USERNAME' ).
      lr_column->set_output_length( 20 ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'INSERT_USERNAME' ).
      lr_column->set_output_length( 20 ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'INSERT_TIME' ).
      lr_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'EMERGENCY' ).
      lr_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'REQ_TYPE' ).
      lr_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'VIP' ).
      lr_column->set_visible( abap_false ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.

  TRY.
      lr_column ?= ir_columns->get_column( 'VIP_ICON' ).
      lr_column->set_output_length( 4 ).
    CATCH cx_salv_not_found.                            "#EC NO_HANDLER
  ENDTRY.
ENDMETHOD.


METHOD adjust_data.
  FIELD-SYMBOLS <ls_data>       TYPE rn1tc_request_report_display.

  LOOP AT me->gt_data ASSIGNING <ls_data>.
*   fill patient name
    <ls_data>-patient = me->get_patient_name( i_patnr = <ls_data>-patient_id ).

*   fill user name
    <ls_data>-username = me->get_user_name( i_user = <ls_data>-uname ).

*   fill insert user name
    <ls_data>-insert_username = me->get_user_name( i_user = <ls_data>-insert_user ).

*   fill icon request type
    <ls_data>-req_type_icon = me->get_request_type_icon( i_request_type = <ls_data>-req_type ).

*   fill vip icon
    <ls_data>-vip_icon = me->get_vip_icon( i_vip = <ls_data>-vip ).

*   fill emergency icon
    <ls_data>-emergency_icon = me->get_emergency_icon( i_emergency = <ls_data>-emergency ).
  ENDLOOP.
ENDMETHOD.


METHOD constructor.
  DATA ls_range_einri TYPE rnrangeeinri.

  READ TABLE it_range_einri INTO ls_range_einri INDEX 1.

  me->g_einri = ls_range_einri-low.

  me->gt_range_einri = it_range_einri.
  me->gt_range_patnr = it_range_patnr.
  me->gt_range_user  = it_range_user.
  me->gt_range_date  = it_range_date.
  me->g_vip          = i_vip.

  cl_ishmed_tc_api=>check_authority_reporting( i_institution_id = me->g_einri ).
ENDMETHOD.


METHOD deregister_events.
  DATA lr_events    TYPE REF TO cl_salv_events_table.

  lr_events = me->gr_table->get_event( ).

  SET HANDLER me->on_link_click FOR lr_events ACTIVATION abap_false.
  SET HANDLER me->on_added_function FOR lr_events ACTIVATION abap_false.
ENDMETHOD.


METHOD display_data.
  DATA lr_columns   TYPE REF TO cl_salv_columns.
  DATA lr_layout    TYPE REF TO cl_salv_layout.

  DATA ls_key       TYPE salv_s_layout_key.

  DATA l_status TYPE sypfkey.

  IF cl_ishmed_switch_check=>ishmed_main( ) = if_ish_constant_definition=>on.
    l_status = co_gui_status_ishmed.
  ELSE.
    l_status = co_gui_status.
  ENDIF.

* create an ALV table
  cl_salv_table=>factory(
    IMPORTING
      r_salv_table = me->gr_table
    CHANGING
      t_table      = me->gt_data ).

* activate ALV generic functions and add own function
  me->gr_table->set_screen_status(
    pfstatus      = l_status
    report        = co_report_name
    set_functions = cl_salv_table=>c_functions_all ).

* adjust columns properties
  lr_columns = me->gr_table->get_columns( ).
  me->adjust_columns( ir_columns = lr_columns ).

* set layout
  lr_layout = me->gr_table->get_layout( ).

* set the Layout Key
  ls_key-report = co_report_name.
  lr_layout->set_key( ls_key ).

* set Layout save restriction
  lr_layout->set_save_restriction( if_salv_c_layout=>restrict_none ).

* register table events
  me->register_events( ).

*  display the table
  me->gr_table->display( ).
ENDMETHOD.


METHOD f4_patnr.
  DATA l_einri          TYPE einri.
  DATA l_patnr          TYPE patnr.

  DATA ls_range_patnr   TYPE rnrangepatnr.

  l_einri = cl_ishmed_tc_reporting=>get_einri_from_screen( ).

  CALL FUNCTION 'ISH_SHOW_LIST_PATIENT'
    EXPORTING
      anfo              = abap_true
      npat_einri        = l_einri
      vcode             = if_ish_constant_definition=>co_vcode_display
    IMPORTING
      npat_patnr        = l_patnr
    EXCEPTIONS
      geschlecht_falsch = 1
      no_authority      = 2
      npat_not_found    = 3
      selection_false   = 4
      message           = 5
      OTHERS            = 6.
  CASE sy-subrc.
    WHEN 0.
    WHEN OTHERS.

      EXIT.
  ENDCASE.

  IF l_patnr IS NOT INITIAL.
    REFRESH ct_range_patnr.

    ls_range_patnr-sign   = 'I'.
    ls_range_patnr-option = 'EQ'.
    ls_range_patnr-low    = l_patnr.
    APPEND ls_range_patnr TO ct_range_patnr.
  ENDIF.
ENDMETHOD.


METHOD get_einri_from_screen.
  DATA ls_value     TYPE rsselread.

  DATA lt_values    TYPE STANDARD TABLE OF rsselread.

  add_field_value 'R_EINRI' 'S' 'LOW'.

  CALL FUNCTION 'RS_SELECTIONSCREEN_READ'
    EXPORTING
      program     = co_report_name
    TABLES
      fieldvalues = lt_values.

  LOOP AT lt_values INTO ls_value.
    CASE ls_value-name.
      WHEN 'R_EINRI'.
        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
          EXPORTING
            input  = ls_value-fieldvalue
          IMPORTING
            output = r_value.
    ENDCASE.
  ENDLOOP.
ENDMETHOD.


METHOD get_emergency_icon.
  IF i_emergency EQ abap_true.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name                        = icon_alert
*       TEXT                        = ' '
        INFO                        = 'Notfallbeantragung'(100)
*       ADD_STDINF                  = 'X'
      IMPORTING
        RESULT                      = r_value
     EXCEPTIONS
       ICON_NOT_FOUND              = 1
       OUTPUTFIELD_TOO_SHORT       = 2
       OTHERS                      = 3.

    IF sy-subrc <> 0.
      r_value = icon_alert.
    ENDIF.
  ENDIF.
ENDMETHOD.


METHOD get_patient_name.
  CALL FUNCTION 'ISH_PATNAME_GET'
    EXPORTING
      i_patnr          = i_patnr
      i_read_npat      = abap_true
      i_read_db        = abap_true
    IMPORTING
      e_pnamec1        = r_value
    EXCEPTIONS
      patnr_not_found  = 1
      no_authority     = 2
      no_einri         = 3
      gender_not_found = 4
      age_not_found    = 5
      OTHERS           = 6.
  IF sy-subrc EQ 1.
    CLEAR r_value.
  ENDIF.
ENDMETHOD.


METHOD get_request_type_icon.
  CASE i_request_type.
    WHEN if_ishmed_tc_constant_def=>co_tc_req_type_temporary OR space.
      CALL FUNCTION 'ICON_CREATE'
        EXPORTING
          name                        = icon_business_partner_master_d
*         TEXT                        = ' '
          INFO                        = 'temporär beantragt'(101)
*         ADD_STDINF                  = 'X'
        IMPORTING
          RESULT                      = r_value
        EXCEPTIONS
          ICON_NOT_FOUND              = 1
          OUTPUTFIELD_TOO_SHORT       = 2
          OTHERS                      = 3.
      IF sy-subrc <> 0.
        r_value = icon_business_partner_master_d.
      ENDIF.
    WHEN if_ishmed_tc_constant_def=>co_tc_req_type_delegation.
      CALL FUNCTION 'ICON_CREATE'
        EXPORTING
          name                        = icon_deputy
*         TEXT                        = ' '
          INFO                        = 'per Delegation beantragt'(102)
*         ADD_STDINF                  = 'X'
        IMPORTING
          RESULT                      = r_value
        EXCEPTIONS
          ICON_NOT_FOUND              = 1
          OUTPUTFIELD_TOO_SHORT       = 2
          OTHERS                      = 3.
      IF sy-subrc <> 0.
        r_value = icon_deputy.
      ENDIF.
  ENDCASE.
ENDMETHOD.


METHOD get_user_name.
  DATA: ls_user_address TYPE addr3_val.

  CALL FUNCTION 'SUSR_USER_ADDRESS_READ'
    EXPORTING
      user_name              = i_user
*     READ_DB_DIRECTLY       = ' '
    IMPORTING
      user_address           = ls_user_address
*     USER_USR03             =
    EXCEPTIONS
      user_address_not_found = 1
      OTHERS                 = 2.

  IF sy-subrc EQ 0.
    r_value = ls_user_address-name_text.
  ENDIF.
ENDMETHOD.


METHOD get_vip_icon.
  IF i_vip EQ abap_false.
    CLEAR r_value.
  ELSE.
    cl_ish_display_tools=>get_wp_icon(
      EXPORTING
        i_einri     = me->g_einri
        i_indicator = '020'
      IMPORTING
        e_icon      = r_value ).

    IF r_value IS INITIAL.
      r_value = i_vip.
    ENDIF.
  ENDIF.
ENDMETHOD.


METHOD has_data.
  IF lines( me->gt_data ) GT 0.
    r_value = abap_true.
  ELSE.
    r_value = abap_false.
  ENDIF.
ENDMETHOD.


METHOD if_ishmed_object~finalize.
  REFRESH me->gt_data.

  IF me->gr_table IS BOUND.
    me->deregister_events( ).

    FREE me->gr_table.
  ENDIF.
ENDMETHOD.


METHOD on_added_function.
  CASE e_salv_function.
    WHEN co_fc_refresh.
      me->refresh( ).
    WHEN co_fc_show_log.
      me->show_log( ).
    WHEN co_fc_show_log_ishmed.
      me->show_log_ishmed( ).
  ENDCASE.
ENDMETHOD.


METHOD on_link_click.
  DATA ls_data    TYPE rn1tc_request_report_display.

  READ TABLE me->gt_data INTO ls_data INDEX row.

  CASE column.
    WHEN co_column_reason.
      me->reason_clicked(
        is_data = ls_data ).
  ENDCASE.
ENDMETHOD.


METHOD reason_clicked.
  CASE is_data-req_type.
    WHEN if_ishmed_tc_constant_def=>co_tc_req_type_temporary OR space.
      me->show_request_tc( is_data = is_data ).
    WHEN if_ishmed_tc_constant_def=>co_tc_req_type_delegation.
      me->show_request_delegation( is_data = is_data ).
  ENDCASE.
ENDMETHOD.


METHOD refresh.
  me->select_data( ).

*... refresh the table in order to see the new data
  me->gr_table->refresh( refresh_mode = if_salv_c_refresh=>full ). "full refresh necessary cause of data changes
ENDMETHOD.


METHOD register_events.
  DATA lr_events    TYPE REF TO cl_salv_events_table.

  lr_events = me->gr_table->get_event( ).

  SET HANDLER me->on_link_click FOR lr_events ACTIVATION abap_true.
  SET HANDLER me->on_added_function FOR lr_events ACTIVATION abap_true.
ENDMETHOD.


METHOD select_data.
  REFRESH me->gt_data.

  SELECT * FROM n1tc_request
           INTO CORRESPONDING FIELDS OF TABLE me->gt_data
           WHERE institution_id IN me->gt_range_einri AND
                 patient_id     IN me->gt_range_patnr AND
                 uname          IN me->gt_range_user  AND
                 insert_date    IN me->gt_range_date.
  IF me->g_vip EQ abap_true.
    DELETE me->gt_data WHERE vip NE abap_true.
  ENDIF.

  me->adjust_data( ).
ENDMETHOD.


METHOD show_log.
DATA: ls_selection_params TYPE rnralevalselectionparams,
      l_row               TYPE i,
      lr_selections       TYPE REF TO cl_salv_selections,
      lt_rows             TYPE salv_t_row,
      ls_data             TYPE rn1tc_request_report_display,
      l_ish_users         TYPE bal_s_user,
      l_ish_patnr         TYPE bal_s_extn.


  lr_selections = me->gr_table->get_selections( ).
  lt_rows       = lr_selections->get_selected_rows( ).

  CHECK lines( lt_rows ) NE 0.
  READ TABLE lt_rows INTO l_row INDEX 1.
  READ TABLE me->gt_data INTO ls_data INDEX l_row.
  CHECK sy-subrc EQ 0.

*
*** Build the selection parameters structure and send to the method
  ls_selection_params-instn = ls_data-institution_id.
  ls_selection_params-dsply = 'X'.
  ls_selection_params-mantn = 'X'.
  ls_selection_params-denied = 'X'.
  ls_selection_params-vryimp = 'X'.
  ls_selection_params-imp = 'X'.
  ls_selection_params-lesimp = 'X'.
  ls_selection_params-frmdt = ls_data-insert_date.
  ls_selection_params-todt = ls_data-insert_date.
  ls_selection_params-frmtm = if_ish_ral_const=>gc_lowtime.
  ls_selection_params-totime = if_ish_ral_const=>gc_hightime.
  l_ish_patnr-sign   = 'I'.
  l_ish_patnr-option = 'EQ'.
  l_ish_patnr-low    = ls_data-patient_id.
  APPEND l_ish_patnr  TO ls_selection_params-pat_nr.

  l_ish_users-sign   = 'I'.
  l_ish_users-option = 'EQ'.
  l_ish_users-low    = ls_data-uname.
  APPEND  l_ish_users TO ls_selection_params-appl_user.

  CALL METHOD cl_ish_ral_processing_ui=>appl_eval_log_display
    EXPORTING
      is_sel_params = ls_selection_params.


ENDMETHOD.


METHOD SHOW_LOG_ISHMED.
  DATA l_row              TYPE i.
  DATA l_extnumber        TYPE balnrext.

  DATA lr_selections      TYPE REF TO cl_salv_selections.
  DATA lr_viewer          TYPE REF TO cl_ishmed_alprot_viewer.

  DATA ls_data            TYPE rn1tc_request_report_display.
  DATA ls_range_extnumber TYPE bal_s_extn.
  DATA ls_range_object    TYPE bal_s_obj.
  DATA ls_range_subobject TYPE bal_s_sub.
  DATA ls_range_aldate    TYPE bal_s_date.
  DATA ls_filter          TYPE bal_s_lfil.

  DATA lt_rows            TYPE salv_t_row.
  DATA lt_log_header      TYPE bal_t_logh.

  DEFINE add_single_filter.
    clear ls_range_&1.

    ls_range_&1-sign   = 'I'.
    ls_range_&1-option = 'EQ'.
    ls_range_&1-low    = &2.

    append ls_range_&1 to ls_filter-&1.
  END-OF-DEFINITION.

  lr_selections = me->gr_table->get_selections( ).
  lt_rows       = lr_selections->get_selected_rows( ).

  CHECK lines( lt_rows ) NE 0.
  READ TABLE lt_rows INTO l_row INDEX 1.
  READ TABLE me->gt_data INTO ls_data INDEX l_row.
  CHECK sy-subrc EQ 0.

* create filter for log selection
  CONCATENATE 'PATNR' ls_data-patient_id INTO l_extnumber.

  add_single_filter extnumber l_extnumber.
  add_single_filter object 'ISHMED'.
  add_single_filter subobject 'ALPATIENT'.
*  add_single_filter aldate ls_data-insert_date.  "REM MED-90337

* load protocols
  lt_log_header = cl_ishmed_alprot_loader=>load_protocols_by_filters( is_lfil = ls_filter ).

  IF lines( lt_log_header ) EQ 0.
    MESSAGE s069(n1almg_med).
*   Keine Protokolle zu den angegebenen Kriterien vorhanden
    RETURN.
  ENDIF.

* If there are protocols for the specified filters -> display them.
  CALL FUNCTION 'BAL_DB_RELOAD'
    EXPORTING
      i_t_log_handle    = lt_log_header
    EXCEPTIONS
      OTHERS            = 0.
  CREATE OBJECT lr_viewer.
  lr_viewer->display_protocols( lt_log_header ).
  lr_viewer->destroy( ).
ENDMETHOD.


METHOD show_request_delegation.
  DATA ls_request   TYPE rn1tc_request_db.

  MOVE-CORRESPONDING is_data TO ls_request.

  TRY.
      CALL FUNCTION 'ISHMED_TC_DELEGATION_DLG'
        EXPORTING
          i_vcode    = if_ish_constant_definition=>co_vcode_display
        CHANGING
          cs_request = ls_request.
    CATCH cx_ishmed_tc_delegation_cancel.               "#EC NO_HANDLER
  ENDTRY.
ENDMETHOD.


METHOD show_request_tc.
  DATA ls_request   TYPE rn1tc_request_db.

  MOVE-CORRESPONDING is_data TO ls_request.

  TRY.
      CALL FUNCTION 'ISHMED_TC_REQUEST_DLG'
        EXPORTING
          i_vcode    = if_ish_constant_definition=>co_vcode_display
        CHANGING
          cs_request = ls_request.
    CATCH cx_ishmed_tc_request_canceled.                "#EC NO_HANDLER
  ENDTRY.
ENDMETHOD.
ENDCLASS.
