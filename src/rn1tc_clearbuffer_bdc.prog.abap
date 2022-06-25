*&---------------------------------------------------------------------*
*& Report RN1TC_CLEARBUFFER_BDC
*&---------------------------------------------------------------------*
*& Clears all treatment contract buffers
*& Does not provide any dialoge and is intended to be used via BDC
*&---------------------------------------------------------------------*
REPORT rn1tc_clearbuffer_bdc.

*----------------------------------------------------------------------*
*       CLASS lcl_report DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_report DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-DATA sr_instance      TYPE REF TO lcl_report.

    CLASS-METHODS get_instance  RETURNING VALUE(rr_value) TYPE REF TO lcl_report.

*   Change name of the report.
    CONSTANTS co_repid          TYPE syrepid   VALUE 'RN1TC_CLEARBUFFER_BDC'.
    CONSTANTS co_log_object     TYPE balobj_d  VALUE 'ISHMED'.
    CONSTANTS co_log_subobject  TYPE balsubobj VALUE 'REPORT'.

    DATA gr_logger              TYPE REF TO cl_ishmed_bal.

    METHODS constructor.

    METHODS run.

ENDCLASS.

INITIALIZATION.
  lcl_report=>get_instance( ).

START-OF-SELECTION.
  lcl_report=>get_instance( )->run( ).

*----------------------------------------------------------------------*
*       CLASS lcl_report IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_report IMPLEMENTATION.
  METHOD get_instance.
    IF lcl_report=>sr_instance IS NOT BOUND.
      CREATE OBJECT lcl_report=>sr_instance.
    ENDIF.

    rr_value = sr_instance.
  ENDMETHOD.

  METHOD constructor.
    DATA l_auth       TYPE abap_bool.

*   Authority check via report group
    PERFORM check_authority_report IN PROGRAM sapmnpa0
                                   USING lcl_report=>co_repid
                                   'N_2_DV1'
                                   l_auth.
    IF l_auth EQ abap_false.
      LEAVE PROGRAM.
    ENDIF.

    TRY.
        CREATE OBJECT me->gr_logger
          EXPORTING
            i_object    = lcl_report=>co_log_object       " Anwendungs-Log: Objektname (Applikationskürzel)
            i_subobject = lcl_report=>co_log_subobject    " Anwendungs-Log: Unterobjekt
            i_repid     = lcl_report=>co_repid.           " ABAP-Programm, aktuelles Rahmenprogramm

        me->gr_logger->add_title( i_repid = lcl_report=>co_repid    " ABAP-Programm, aktuelles Rahmenprogramm
                                  i_title = sy-title ).             " Bildschirmbilder, Text in der Titelzeile
      CATCH cx_ishmed_log.
        LEAVE PROGRAM.
    ENDTRY.
  ENDMETHOD.

  METHOD run.

    DATA: l_date  TYPE string,
          l_time  TYPE string,
          l_text  TYPE c length 200,
          l_count TYPE c length 12.

    TRY.

*     "Report gestartet am XX.XX.XXXX um XX:XX"
      l_date = sy-datum.
      l_time = sy-uzeit.
      CONCATENATE 'Report gestartet am'(001) l_date 'um'(002) l_time INTO l_text SEPARATED BY space.
      me->gr_logger->add_free_text( i_msg_type = 'S'
                                    i_text     = l_text ).

      "Tabelle N1TC_BUFFER: XXXXX Datensätze gelöscht"
      DELETE FROM n1tc_buffer     WHERE INSERT_DATE LT sy-datum.  "#EC CI_NOFIRST
      l_count = sy-dbcnt.
      SHIFT l_count LEFT DELETING LEADING space.
      CONCATENATE 'Tabelle N1TC_BUFFER:'(004)      l_count ' Datensätze gelöscht'(005) INTO l_text SEPARATED BY space.
      me->gr_logger->add_free_text( i_msg_type = 'S'
                                    i_text     = l_text ).

      "Tabelle N1TC_BUFFER_PAP: XXXXX Datensätze gelöscht"
      DELETE FROM n1tc_buffer_pap WHERE INSERT_DATE LT sy-datum.  "#EC CI_NOFIRST
      l_count = sy-dbcnt.
      SHIFT l_count LEFT DELETING LEADING space.
      CONCATENATE 'Tabelle N1TC_BUFFER_PAP:'(006)  l_count ' Datensätze gelöscht'(005) INTO l_text SEPARATED BY space.
      me->gr_logger->add_free_text( i_msg_type = 'S'
                                    i_text     = l_text ).

      "Tabelle N1TC_MATRIX: XXXXX Datensätze gelöscht"
      DELETE FROM n1tc_matrix_buf WHERE VALID_DATE  LT sy-datum.  "#EC CI_NOFIRST
*MED-68399 BEGIN
      DELETE FROM n1tc_matrix_b_in WHERE VALID_DATE  LT sy-datum.  "#EC CI_NOFIRST
*MED-68399 BEGIN
      l_count = sy-dbcnt.
      SHIFT l_count LEFT DELETING LEADING space.
      CONCATENATE 'Tabelle N1TC_MATRIX:'(007)      l_count ' Datensätze gelöscht'(005) INTO l_text SEPARATED BY space.
      me->gr_logger->add_free_text( i_msg_type = 'S'
                                    i_text     = l_text ).

*MED-70070 BEGIN
        DELETE FROM n1tc_matrix_b_h. "#EC CI_NOWHERE
*MED-70070 END

        COMMIT WORK.

*     "Report beendet am XX.XX.XXXX um XX:XX"
      l_date = sy-datum.
      l_time = sy-uzeit.
      CONCATENATE 'Report beendet am'(008) l_date 'um'(002) l_time INTO l_text SEPARATED BY space.
      me->gr_logger->add_free_text( i_msg_type = 'S'
                                    i_text     = l_text ).

*     Save log.
      me->gr_logger->save( i_commit = abap_true ).
      me->gr_logger->add_logging_saved(
                 EXPORTING
                   i_log_save     = abap_true ).
*     Log display ?
      IF sy-batch EQ abap_false.
        me->gr_logger->display( ).
      ENDIF.

      IF sy-batch EQ abap_true.
*       Protkoll über Transaktion SLG1 Objekt /GSD/ARC anzeigen.
        MESSAGE s005(n2all) WITH lcl_report=>co_log_object
                                 lcl_report=>co_log_subobject space.
      ENDIF.
      CATCH cx_ishmed_log ##no_handler.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
