*&---------------------------------------------------------------------*
*& Report  RN1TC_REPORTING
*&---------------------------------------------------------------------*

REPORT rn1tc_reporting.

TABLES rn1tc_request_dlg.

DATA g_first_error       TYPE abap_bool VALUE abap_true.

SELECTION-SCREEN BEGIN OF BLOCK selcrit WITH FRAME TITLE g_b01.
SELECT-OPTIONS r_einri FOR rn1tc_request_dlg-institution_id OBLIGATORY NO INTERVALS NO-EXTENSION.
SELECT-OPTIONS r_patnr FOR rn1tc_request_dlg-patient_id. "NO INTERVALS NO-EXTENSION.
*SELECT-OPTIONS r_falnr FOR rn1tc_request_dlg-case_id NO INTERVALS NO-EXTENSION.
SELECT-OPTIONS r_user FOR rn1tc_request_dlg-uname NO INTERVALS NO-EXTENSION.
SELECT-OPTIONS r_date FOR rn1tc_request_dlg-insert_date.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (31) g_b02 FOR FIELD p_vip.
PARAMETER p_vip TYPE vipkz AS CHECKBOX.                  "#EC SEL_WRONG
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK selcrit.

INITIALIZATION.
  PERFORM init.

START-OF-SELECTION.
  PERFORM run.

AT SELECTION-SCREEN OUTPUT.
  PERFORM modify_status.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR r_patnr-low.
  PERFORM f4_patnr.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR r_patnr-high.
  PERFORM f4_patnr.

*&---------------------------------------------------------------------*
*&      Form  init
*&---------------------------------------------------------------------*
FORM init.
  DATA l_einri    TYPE einri.

* init global variables
  GET PARAMETER ID 'EIN' FIELD l_einri.
  IF sy-subrc EQ 0 AND
     l_einri  IS NOT INITIAL.
    r_einri-sign   = 'I'.
    r_einri-option = 'EQ'.
    r_einri-low    = l_einri.
    APPEND r_einri.
  ENDIF.

* init text of selection screen
  MESSAGE s007(n1tc) INTO g_b01.
  MESSAGE s008(n1tc) INTO g_b02.
ENDFORM.                    "init

*&---------------------------------------------------------------------*
*&      Form  modify_status
*&---------------------------------------------------------------------*
FORM modify_status.
  DATA lt_exclude TYPE TABLE OF sy-ucomm.

  APPEND 'PRIN' TO lt_exclude."Execute and Print
  APPEND 'SJOB' TO lt_exclude."Execute in Background

  CALL FUNCTION 'RS_SET_SELSCREEN_STATUS'
    EXPORTING
      p_status  = sy-pfkey
    TABLES
      p_exclude = lt_exclude.
ENDFORM.                    "modify_status

*&---------------------------------------------------------------------*
*&      Form  f4_patnr
*&---------------------------------------------------------------------*
FORM f4_patnr.
  cl_ishmed_tc_reporting=>f4_patnr( CHANGING ct_range_patnr = r_patnr[] ).
  READ TABLE r_patnr[] INTO r_patnr INDEX 1.
ENDFORM.                    "f4_patnr

*&---------------------------------------------------------------------*
*&      Form  run
*&---------------------------------------------------------------------*
FORM run.
  DATA lr_process     TYPE REF TO cl_ishmed_tc_reporting.
  DATA lr_exception   TYPE REF TO cx_root.
  DATA lr_authority   TYPE REF TO cx_ishmed_tc_authority.

  TRY.

      CREATE OBJECT lr_process
        EXPORTING
          it_range_einri = r_einri[]
          it_range_patnr = r_patnr[]
          it_range_user  = r_user[]
          it_range_date  = r_date[]
          i_vip          = p_vip.

      lr_process->select_data( ).

      IF lr_process->has_data( ) EQ abap_true.
        lr_process->display_data( ).
      ELSE.
        MESSAGE s009(n1tc).
*       Keine Daten anhand der Selektion gefunden
      ENDIF.

    CATCH cx_salv_msg INTO lr_exception.
      PERFORM write_exception USING lr_exception.
    CATCH cx_ishmed_tc_authority INTO lr_authority.
      lr_authority->display_messages( ).
  ENDTRY.

  IF lr_process IS BOUND.
    TRY.
        lr_process->if_ishmed_object~finalize( ).
      CATCH cx_ishmed_object.                           "#EC NO_HANDLER
    ENDTRY.
  ENDIF.

  FREE lr_process.
ENDFORM.                    "run

*&---------------------------------------------------------------------*
*&      Form  write_exception
*&---------------------------------------------------------------------*
FORM write_exception USING ur_exception TYPE REF TO cx_root.
  DATA lr_errorhandler    TYPE REF TO cl_ishmed_errorhandling.

  DATA ls_message         TYPE bapiret2.

  DATA lt_messages        TYPE STANDARD TABLE OF bapiret2.

  cl_ish_utl_base=>collect_messages_by_exception(
    EXPORTING
      i_exceptions    = ur_exception
    CHANGING
      cr_errorhandler = lr_errorhandler ).

  lr_errorhandler->get_messages(
    IMPORTING
      t_messages = lt_messages ).

  LOOP AT lt_messages INTO ls_message.
    PERFORM write_error USING ls_message.
  ENDLOOP.
ENDFORM.                    "write_exception

*&---------------------------------------------------------------------*
*&      Form  write_error
*&---------------------------------------------------------------------*
FORM write_error USING us_bapiret TYPE bapiret2.

  IF g_first_error = abap_true.
    WRITE: / text-020.
    WRITE: / text-021.
    SKIP 1.
    WRITE: / text-022,
             text-023,
             text-024,
             text-025.
    WRITE: / sy-uline.
    g_first_error = abap_false.
  ENDIF.

  WRITE: / us_bapiret-type UNDER text-022,
           us_bapiret-id UNDER text-023,
           us_bapiret-number UNDER text-024,
           us_bapiret-message UNDER text-025.
ENDFORM.                    " write_error
