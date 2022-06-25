*----------------------------------------------------------------------*
***INCLUDE LN1TC_TESTI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_ON_EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE patsearch_on_exit INPUT.
  PERFORM patsearch_on_exit.
ENDMODULE.                 " PATSEARCH_ON_EXIT  INPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_GET_CURSOR  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE patsearch_get_cursor INPUT.
  GET CURSOR FIELD g_cursor_field.
ENDMODULE.                 " PATSEARCH_GET_CURSOR  INPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_OKCODE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_OKCODE input.
* --- Status init. ---------------------------------------------
  CLEAR g_state_srch.
  clear g_state_test.

* --- OK_CODE ---------------------------------------------
  IF OK_CODE IS INITIAL.
    new_ok = 'TEST'.
  ELSE.
    new_ok = OK_CODE.
    CLEAR OK_CODE.
  ENDIF.
endmodule.                 " PATSEARCH_OKCODE  INPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_CHECK_EINRI  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_CHECK_EINRI input.
  perform patserch_check_einri.
endmodule.                 " PATSEARCH_CHECK_EINRI  INPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_ISH_INIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_ISH_INIT input.
  PERFORM patsearch_ish_init
    CHANGING
      rnpa1.
endmodule.                 " PATSEARCH_ISH_INIT  INPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_ISH_GET_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_ISH_GET_DATA input.
 PERFORM patsearch_ish_get_data
    USING
      new_ok
      g_before_patnr
    CHANGING
      rnpa1-patnr
      rnpa1-falnr.
endmodule.                 " PATSEARCH_ISH_GET_DATA  INPUT

*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_CHECK_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_CHECK_DATA input.
IF new_ok <> 'TEST'.
    RETURN.
  ENDIF.
  PERFORM patsearch_check_data
    USING
      rnpa1-einri
      rnpa1-falnr
    CHANGING
      rnpa1-patnr
      g_state_test.

* optionale Daten prüfen
  IF g_state_test <> 'OK'.
    RETURN.
  ENDIF.

endmodule.                 " PATSEARCH_CHECK_DATA  INPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_GO  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_GO input.
 PERFORM concat_pname
    USING
      rnpa1-einri
      rnpa1-patnr
    CHANGING
      rnpa1-pname.

  IF new_ok = 'TEST'.

    CASE g_state_test.

      WHEN 'OK'.
        SET PARAMETER ID 'EIN' FIELD rnpa1-einri.
        SET PARAMETER ID 'PAT' FIELD rnpa1-patnr.
        SET PARAMETER ID 'FAL' FIELD rnpa1-falnr.
        SET SCREEN 0.
        CLEAR g_cursor_field.
*        CALL FUNCTION 'ISH_TC_SWITCH_OFF_UNDO'.
        perform call_test.
      WHEN 'PAT_EMPTY'.
        MESSAGE s800(n1tc).
*       Wählen Sie einen Patienten aus
        g_cursor_field = 'RNPA1-PATNR'.                     "#EC NOTEXT
        g_cursor_intensified = true.
        SET SCREEN search_pat_screen.
      WHEN 'PAT_DOES_NOT_EXIST'.
* >>> IXX-18293
*        MESSAGE s801(n1tc) WITH rnpa1-patnr.
*       Patient mit der Patientennummer &1 ist im System nicht vorhanden
        g_cursor_field = 'RNPA1-PATNR'.                     "#EC NOTEXT
        g_cursor_intensified = true.
        clear rnpa1-pname.
* <<< IXX-18293
        SET SCREEN search_pat_screen.
* begin MED-55962
      WHEN 'CASE_DOES_NOT_EXIST'.
        MESSAGE s005(NK) WITH rnpa1-falnr DISPLAY LIKE 'E'.   " MED-55962
*       Patient mit der Patientennummer &1 ist im System nicht vorhanden
        g_cursor_field = 'RNPA1-FALNR'.                     "#EC NOTEXT
        g_cursor_intensified = true.
        SET SCREEN search_pat_screen.
* end MED-55962
      WHEN 'NOT_MATCHING'.
        MESSAGE s802(n1tc) WITH rnpa1-patnr rnpa1-falnr.
*       Patientennummer &1 und Fallnummer &2 gehören nicht zusammen
        g_cursor_field = 'RNPA1-FALNR'.
        g_cursor_intensified = true.
        SET SCREEN search_pat_screen.

*      WHEN 'NO_CASE_ID'.
*        MESSAGE s803(n1tc).
**       Kein Fall zum Patienten angegeben
*        g_cursor_field = 'RNPA1-FALNR'.
*        g_cursor_intensified = true.
*        SET SCREEN search_pat_screen.
      when others.
    ENDCASE.

  ELSE.

    IF ( new_ok = 'SRCH' ).
      SET SCREEN search_pat_screen.
    ENDIF.

    IF ( new_ok = 'SRCH' ) AND ( NOT rnpa1-patnr IS INITIAL ).
      g_cursor_field = 'RNPA1-FALNR'.
    ENDIF.
  ENDIF.
endmodule.                 " PATSEARCH_GO  INPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_F4_CASE  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_F4_CASE input.
 PERFORM f4_case
        USING
          rnpa1-einri
          rnpa1-patnr
          prog_repid
          search_pat_screen
          'RNPA1-EINRI'
          'RNPA1-PATNR'
          'RNPA1-FALNR'
          CHANGING
          rnpa1-falnr.
endmodule.                 " PATSEARCH_F4_CASE  INPUT
*&---------------------------------------------------------------------*
*&      Form  CALL_TEST
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form CALL_TEST .
TRY.
cl_ishmed_tc_api=>check_authority_test_admin( i_institution_id = rnpa1-einri ).
 CATCH cx_ishmed_tc_authority .
    CALL SCREEN test_tc.
    return.
ENDTRY.
CALL SCREEN test_tc_admin.
endform.                    " CALL_TEST
