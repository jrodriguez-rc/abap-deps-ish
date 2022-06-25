*----------------------------------------------------------------------*
***INCLUDE LN1TC_DIALOGO02 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_SET_STATUS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_SET_STATUS output.
  SET PF-STATUS 'TC_DELEGATION_ENTRY'.
  SET TITLEBAR  'TC_DELEGATION_ENTRY'.
endmodule.                 " PATSEARCH_SET_STATUS  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_FILL_TEXTS  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_FILL_TEXTS output.
  CLEAR ok_code.
  PERFORM patsearch_fill_texts
    CHANGING
      rnpa1-einri
      rnpa1-patnr
      rnpa1-falnr
      rnpa1-fzenm.
endmodule.                 " PATSEARCH_FILL_TEXTS  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_CONCAT_PNAME  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_CONCAT_PNAME output.
* >>> IXX-18329
  DATA l_state_test      TYPE syucomm.

  CHECK rnpa1-patnr IS NOT INITIAL.

  PERFORM patsearch_check_data
    USING
      rnpa1-einri
      rnpa1-falnr
    CHANGING
      rnpa1-patnr
      l_state_test.

* Set Patient Name only if OK
  IF l_state_test = 'PAT_DOES_NOT_EXIST' OR
     l_state_test = 'CASE_DOES_NOT_EXIST' OR
     l_state_test = 'NOT_MATCHING'.
*    MESSAGE s801(n1tc) WITH rnpa1-patnr.
    CLEAR rnpa1-pname.
  ELSE.
*<<< IXX-18329
    PERFORM concat_pname
    USING
      rnpa1-einri
      rnpa1-patnr
    CHANGING
      rnpa1-pname.
  ENDIF. "IXX-18329
endmodule.                 " PATSEARCH_CONCAT_PNAME  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_BEFORE_IMAGE  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_BEFORE_IMAGE output.
  g_before_patnr = rnpa1-patnr.
endmodule.                 " PATSEARCH_BEFORE_IMAGE  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_ISH_INIT  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_ISH_INIT output.
 PERFORM patsearch_ish_init
    CHANGING
      rnpa1.
endmodule.                 " PATSEARCH_ISH_INIT  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  PATSEARCH_SET_CURSOR  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
module PATSEARCH_SET_CURSOR output.
PERFORM dynpro_set_cursor
    CHANGING
      g_cursor_field
      g_cursor_intensified.
endmodule.                 " PATSEARCH_SET_CURSOR  OUTPUT
