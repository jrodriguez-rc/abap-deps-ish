*----------------------------------------------------------------------*
***INCLUDE LN1TC_TESTF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  PATSEARCH_FILL_TEXTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_RNPA1_EINRI  text
*      <--P_RNPA1_PATNR  text
*      <--P_RNPA1_FALNR  text
*----------------------------------------------------------------------*
FORM patsearch_fill_texts
   CHANGING
    c_insitution TYPE einri
    c_patnr      TYPE patnr
    c_falnr      TYPE falnr
    c_inst_name  TYPE einkb.

* --- Init ---------------------------------------------
  IF c_insitution IS INITIAL.
    CLEAR c_inst_name.
  ENDIF.

* --- Einrichtung ---------------------------------------------
* Benutzerparameter "EIN"
* Explizetes lesen notwendig, damit sprechende Texte beim ersten Aufruf angezeigt werden
  IF c_insitution IS INITIAL.
    GET PARAMETER ID 'EIN' FIELD c_insitution.
  ENDIF.
  IF c_insitution IS NOT INITIAL.
    CALL FUNCTION 'ISH_EINRI_CHECK'
      EXPORTING
        ss_einri = c_insitution
      IMPORTING
        ss_einkb = c_inst_name
      EXCEPTIONS
        OTHERS   = 1.
    if sy-subrc NE 0.
      CLEAR c_inst_name.
      clear c_insitution.
    endif.
  ENDIF.

* --- Patient, Fall ---------------------------------------------
* Benutzerparemter "PAT", "FAL"
  IF c_patnr IS INITIAL.
    GET PARAMETER ID 'PAT' FIELD c_patnr.
    GET PARAMETER ID 'FAL' FIELD c_falnr.
  ENDIF.

  IF c_patnr IS INITIAL.
    CLEAR c_falnr.
  ENDIF.

ENDFORM.                    " PATSEARCH_FILL_TEXTS
*&---------------------------------------------------------------------*
*&      Form  CONCAT_PNAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_RNPA1_EINRI  text
*      -->P_RNPA1_PATNR  text
*      <--P_RNPA1_PNAME  text
*----------------------------------------------------------------------*
FORM concat_pname
    USING
    value(i_einri) TYPE einri
    value(i_patnr) TYPE patnr
  CHANGING
    e_pname TYPE ri_name.

  CLEAR e_pname.

  IF i_patnr IS NOT INITIAL.
    CALL FUNCTION 'ISH_NPAT_CONCATENATE'
      EXPORTING
        ss_einri     = i_einri
        ss_patnr     = i_patnr
        ss_read_npat = 'X'
      IMPORTING
        ss_pname     = e_pname.
  ENDIF.

ENDFORM.                    " CONCAT_PNAME
*&---------------------------------------------------------------------*
*&      Form  PATSEARCH_ISH_INIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_RNPA1  text
*----------------------------------------------------------------------*
FORM patsearch_ish_init
 CHANGING cs_rnpa1 TYPE rnpa1.

  CALL FUNCTION 'ISH_PATIENTLIST_SEARCH_SET'
    EXPORTING
      ss_einri       = cs_rnpa1-einri
      ss_patnr       = off
      ss_falnr       = off
      ss_okcode      = new_ok
*     ss_patnr_value = cs_rnpa1-patnr  " nicht übergeben, dient Suche mit eingeblendetem Feld Patnr
      ss_nname_value = cs_rnpa1-nname
      ss_vname_value = cs_rnpa1-vname
      ss_gbnam_value = cs_rnpa1-gbnam
      ss_gbdav_value = cs_rnpa1-gbdav
      ss_gbdab_value = cs_rnpa1-gbdab
      ss_gschl_value = cs_rnpa1-gschl
      ss_rvnum_value = cs_rnpa1-rvnum
      ss_extnr_value = cs_rnpa1-extnr
      ss_pasnr_value = cs_rnpa1-passnr
    IMPORTING
            ss_repid         = sea_repid
            ss_dynnr         = sea_dynnr
    EXCEPTIONS
      OTHERS         = 0.
ENDFORM.                    " PATSEARCH_ISH_INIT
*&---------------------------------------------------------------------*
*&      Form  DYNPRO_SET_CURSOR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_G_CURSOR_FIELD  text
*      <--P_G_CURSOR_INTENSIFIED  text
*----------------------------------------------------------------------*
FORM dynpro_set_cursor
 CHANGING
    c_cursor_field LIKE screen-name
    c_cursor_intensified LIKE screen-intensified.

  CHECK NOT c_cursor_field IS INITIAL.


  LOOP AT SCREEN.
    IF screen-name = c_cursor_field.
      IF screen-input = true.
        screen-intensified = c_cursor_intensified.
        MODIFY SCREEN.
        SET CURSOR FIELD c_cursor_field.
      ENDIF.
    ENDIF.
  ENDLOOP.

  CLEAR c_cursor_field.
  c_cursor_intensified = false.
ENDFORM.                    " DYNPRO_SET_CURSOR
*&---------------------------------------------------------------------*
*&      Form  PATSEARCH_ON_EXIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM patsearch_on_exit .
  new_ok = OK_CODE.
  CLEAR OK_CODE.

  CASE new_ok.

    WHEN 'EBCK'.                        "Zurück
      SET SCREEN 0.
      LEAVE SCREEN.

    WHEN 'EEND'.                        "Beenden
      SET SCREEN 0.
      LEAVE PROGRAM.

    WHEN 'ECAN'.                        "Abbrechen
      SET SCREEN 0.
      LEAVE SCREEN.

  ENDCASE.
ENDFORM.                    " PATSEARCH_ON_EXIT
*&---------------------------------------------------------------------*
*&      Form  PATSEARCH_ISH_GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_RNPA1_EINRI  text
*      -->P_NEW_OK  text
*      -->P_G_BEFORE_PATNR  text
*      <--P_RNPA1_PATNR  text
*      <--P_RNPA1_FALNR  text
*----------------------------------------------------------------------*
FORM patsearch_ish_get_data
          USING
*          value(i_einri) TYPE einri
          value(i_ok) TYPE syucomm
          value(i_before_patnr) TYPE patnr
        CHANGING
          c_patnr TYPE patnr
          c_falnr TYPE falnr.

  IF i_ok <> 'SRCH'.
    RETURN.
  ENDIF.

  CALL FUNCTION 'ISH_PATIENTLIST_SEARCH_GET'
    IMPORTING
      ss_patnr_value = rnpa1-patnr
      ss_nname_value = rnpa1-nname
      ss_vname_value = rnpa1-vname
      ss_gbnam_value = rnpa1-gbnam
      ss_gbdav_value = rnpa1-gbdav
      ss_gbdab_value = rnpa1-gbdab
      ss_gschl_value = rnpa1-gschl
      ss_rvnum_value = rnpa1-rvnum
      ss_extnr_value = rnpa1-extnr
      ss_pasnr_value = rnpa1-passnr. "#EC PF_ACT_GLO
*      ss_select_npat = l_select_npat. "###
*      ss_continue    = l_continue.

* Fallnummer löschen, wenn der Benutzer die Patnr löscht
  IF rnpa1-patnr IS INITIAL.
    CLEAR c_falnr.
  ENDIF.

* Fallnummer löschen, wenn der Benutzer den Patienten wechselt
  IF i_before_patnr <> c_patnr.
    CLEAR c_falnr.
  ENDIF.
ENDFORM.                    " PATSEARCH_ISH_GET_DATA
*&---------------------------------------------------------------------*
*&      Form  PATSEARCH_CHECK_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_RNPA1_EINRI  text
*      -->P_RNPA1_PATNR  text
*      -->P_RNPA1_FALNR  text
*      <--P_G_STATE_TEST  text
*----------------------------------------------------------------------*
FORM patsearch_check_data
  USING
    value(i_einri) TYPE einri
    value(i_falnr) TYPE falnr
  CHANGING
    c_patnr        TYPE patnr               " MED-55962
    e_check_result TYPE syucomm.

  DATA ls_nfal   TYPE nfal.                   " MED-55962

* patnr and falnr empty?
  IF c_patnr IS INITIAL
  AND i_falnr IS INITIAL.                  " MED-55962
    e_check_result = 'PAT_EMPTY'.
    RETURN.
  ENDIF.

* begin MED-55962
* does FALNR exist?
  IF i_falnr IS NOT INITIAL.
    CALL FUNCTION 'ISH_READ_NFAL'
      EXPORTING
        ss_einri     = i_einri
        ss_falnr     = i_falnr
      IMPORTING
        ss_nfal      = ls_nfal
      EXCEPTIONS
        not_found    = 01
        no_authority = 02
        OTHERS       = 03.
    IF sy-subrc > 0.
      e_check_result = 'CASE_DOES_NOT_EXIST'.
      RETURN.
    ENDIF.
    IF c_patnr IS INITIAL.
      c_patnr = ls_nfal-patnr.
    ELSE.
* case correct for patnr?
      IF c_patnr NE ls_nfal-patnr.
        e_check_result = 'NOT_MATCHING'.
        RETURN.
      ENDIF.
    ENDIF.
  ENDIF.
* end MED-55962

* does patnr exist?
  DATA ret TYPE TABLE OF bapiret2.
  DATA rettype TYPE ish_bapiretmaxty.

  e_check_result = 'OK'.


  CALL FUNCTION 'ISH_PATIENT_GET'
    EXPORTING
      ss_einri      = i_einri
      ss_patnr      = c_patnr
      ss_check_auth = 'X'
    IMPORTING
      ss_retmaxtype = rettype
    TABLES
      ss_return     = ret.

  IF rettype = 'A' OR rettype = 'E'.
    e_check_result = 'PAT_DOES_NOT_EXIST'.
    RETURN.
  ENDIF.


* begin MED-55962
** case correct for patnr?
*  IF NOT i_falnr IS INITIAL.
*
*    DATA l_einri TYPE einri.
*
*    SELECT SINGLE einri
*    FROM nfal
*    INTO l_einri
*    WHERE einri = i_einri
*    AND patnr = c_patnr
*    AND falnr = i_falnr.
*
*    IF sy-subrc <> 0.
*      e_check_result = 'NOT_MATCHING'.
*    ENDIF.
*
**  ELSE.
***   no case id is supplied
**    e_check_result = 'NO_CASE_ID'.
*  ENDIF.
* end MED-55962


ENDFORM.                    " PATSEARCH_CHECK_DATA
*&---------------------------------------------------------------------*
*&      Form  F4_CASE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_RNPA1_EINRI  text
*      -->P_RNPA1_PATNR  text
*      -->P_PROG_REPID  text
*      -->P_SEARCH_PAT_SCREEN  text
*      -->P_0209   text
*      -->P_0210   text
*      -->P_0211   text
*      <--P_RNPA1_FALNR  text
*----------------------------------------------------------------------*
FORM f4_case
    USING
            value(i_einri) TYPE einri
            value(i_patnr) TYPE patnr
            value(i_dyname) TYPE syrepid
            value(i_dynumb) TYPE sydynnr
            value(i_fieldname_einri) TYPE c
            value(i_fieldname_patnr) TYPE c
            value(i_fieldname_falnr) TYPE c
          CHANGING
            c_falnr TYPE falnr.

* case
  DATA lt_case TYPE ish_t_nfal.

* errorhandling
  DATA l_max_error TYPE ish_bapiretmaxty.
  DATA lt_errors TYPE ish_bapiret2_tab_type.
*  DATA lt_messages TYPE ishmed_t_messages.
*  DATA wa_message TYPE LINE OF ishmed_t_messages.


* -----------------------------------------------------------------
* field transport from dynpro
  CLEAR s_dyfi.
  CLEAR t_dyfi[].

  s_dyfi-fieldname = i_fieldname_einri.
  APPEND s_dyfi TO t_dyfi.

  s_dyfi-fieldname = i_fieldname_patnr.
  APPEND s_dyfi TO t_dyfi.

  CALL FUNCTION 'DYNP_VALUES_READ'
    EXPORTING
      dyname                   = i_dyname
      dynumb                   = i_dynumb
      perform_conversion_exits = 'X'
    TABLES
      dynpfields               = t_dyfi
    EXCEPTIONS
      invalid_abapworkarea     = 1
      invalid_dynprofield      = 2
      invalid_dynproname       = 3
      invalid_dynpronummer     = 4
      invalid_request          = 5
      no_fielddescription      = 6
      invalid_parameter        = 7
      undefind_error           = 8
      double_conversion        = 9
      stepl_not_found          = 10
      OTHERS                   = 11.
  IF sy-subrc <> 0.
    MESSAGE s805(n1tc) WITH i_dyname i_dynumb.
  ENDIF.

  LOOP AT t_dyfi INTO s_dyfi.

    IF s_dyfi-fieldname = i_fieldname_einri.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = s_dyfi-fieldvalue
        IMPORTING
          output = i_einri.

    ELSEIF s_dyfi-fieldname = i_fieldname_patnr.
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
        EXPORTING
          input  = s_dyfi-fieldvalue
        IMPORTING
          output = i_patnr.

    ENDIF.

  ENDLOOP.

*>>> IXX-18329 FM
* check authority on patient
  DATA: l_rettype type NPDOK-BAPIRETMAXTY,
        lt_ret    TYPE TABLE OF bapiret2.

  IF i_einri is not INITIAL AND i_patnr is not INITIAL.
    CALL FUNCTION 'ISH_PATIENT_GET'
      EXPORTING
        ss_einri      = i_einri
        ss_patnr      = i_patnr
        ss_check_auth = 'X'
      IMPORTING
        ss_retmaxtype = l_rettype
      TABLES
        ss_return     = lt_ret.

    IF l_rettype = 'A' OR l_rettype = 'E'.
      EXIT.
    ENDIF.
  ENDIF.
*>>> IXX-18329 FM

* -----------------------------------------------------------------
*  are there any cases at all?
  DATA: l_falnr TYPE falnr.

  SELECT SINGLE falnr FROM nfal INTO l_falnr
               WHERE einri = i_einri
               AND   patnr = i_patnr
               AND   storn = ' '. "#EC WARNOK
  IF sy-subrc <> 0.
    CLEAR c_falnr.
    PERFORM f4_case_updatescreen
                USING
                   c_falnr
                   i_dyname
                   i_dynumb
                   i_fieldname_falnr
                CHANGING
                   c_falnr.
    RETURN.
  ENDIF.

* >>> IXX-18293
* only if access to patient is allowed
  DATA l_state_test      TYPE syucomm.
  DATA l_caseid          TYPE FALNR.

  PERFORM patsearch_check_data
    USING
      i_einri
      l_caseid
    CHANGING
      rnpa1-patnr                  " MED-55962
      l_state_test.

* Leave if Pat not OK
  IF l_state_test = 'PAT_DOES_NOT_EXIST'.
*    MESSAGE s801(n1tc) WITH i_patnr.
    PERFORM f4_case_clear_pname.
    RETURN.
  ENDIF.
*<<< IXX-18293

* --- get all cases for patient that are not cancelled ---------------------------------------------
  CALL FUNCTION 'ISH_CASE_LIST'
    EXPORTING
      i_einri           = i_einri
      i_patnr           = i_patnr
      i_authority_check = 'X'
    IMPORTING
      e_wst_msg_type    = l_max_error
    TABLES
      t_nfal            = lt_case
      t_return          = lt_errors.

  IF l_max_error IS NOT INITIAL.
    CLEAR c_falnr.
    PERFORM f4_case_updatescreen
                USING
                   c_falnr
                   i_dyname
                   i_dynumb
                   i_fieldname_falnr
                CHANGING
                   c_falnr.
    RETURN.
  ENDIF.



  CALL FUNCTION 'ISH_SHOW_LIST_FALL'
    EXPORTING
      nfal_einri     = i_einri
      nfal_patnr     = i_patnr
      vcode          = if_ish_constant_definition=>co_vcode_display
      popup          = abap_on
      col            = 5
      row            = 6
      exit_on_weiter = abap_on
      mark_multiple  = abap_off
    IMPORTING
      nfal_falnr     = c_falnr
    EXCEPTIONS
      pat_not_found  = 1
      repid_missing  = 2
      OTHERS         = 3.



  IF sy-subrc <> 0.
    CLEAR c_falnr.
  ENDIF.
  PERFORM f4_case_updatescreen
              USING
                 c_falnr
                 i_dyname
                 i_dynumb
                 i_fieldname_falnr
              CHANGING
                 c_falnr.

ENDFORM.                                                    " F4_CASE
*&---------------------------------------------------------------------*
*&      Form  F4_CASE_UPDATESCREEN
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_C_FALNR  text
*      -->P_I_DYNAME  text
*      -->P_I_DYNUMB  text
*      -->P_I_FIELDNAME_FALNR  text
*      <--P_C_FALNR  text
*----------------------------------------------------------------------*
FORM f4_case_updatescreen
                       USING
                          value(i_current_falnr) TYPE falnr
                          value(i_dyname) TYPE syrepid
                          value(i_dynumb) TYPE sydynnr
                          value(i_fieldname_falnr) TYPE c
                        CHANGING
                          c_falnr TYPE falnr.

  c_falnr = i_current_falnr.

  CLEAR t_dyfi[].
  CLEAR s_dyfi.

*  MOVE 'rnpa1-FALNR' TO s_dyfi-fieldname.
  MOVE i_fieldname_falnr TO s_dyfi-fieldname.
  MOVE i_current_falnr TO s_dyfi-fieldvalue.
  APPEND s_dyfi TO t_dyfi.

  CALL FUNCTION 'DYNP_VALUES_UPDATE'
    EXPORTING
      dyname     = i_dyname
      dynumb     = i_dynumb
    TABLES
      dynpfields = t_dyfi
    EXCEPTIONS
      OTHERS     = 0.

ENDFORM.                    " F4_CASE_UPDATESCREEN
*>>> IXX-18293
*&---------------------------------------------------------------------*
*&      Form  F4_CASE_CLEAR_PNAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM f4_case_clear_pname.

  CLEAR t_dyfi[].
  CLEAR s_dyfi.

  MOVE 'RNPA1-PNAME' TO s_dyfi-fieldname.
  APPEND s_dyfi TO t_dyfi.

  CALL FUNCTION 'DYNP_VALUES_UPDATE'
    EXPORTING
      dyname     = prog_repid
      dynumb     = search_pat_screen
    TABLES
      dynpfields = t_dyfi
    EXCEPTIONS
      OTHERS     = 0.

ENDFORM.                    " F4_CASE_CLEAR_PNAME
*<<< IXX-18293
*&---------------------------------------------------------------------*
*&      Form  CHECK_EINRI
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_RNPA1_EINRI  text
*      <--P_RNPA1_FZENM  text
*      <--P_LS_MESSAGE  text
*----------------------------------------------------------------------*
FORM check_einri
  USING
    value(i_institution) TYPE einri
  CHANGING
    e_inst_name TYPE einkb
    es_message TYPE t100.

* --- Init ---------------------------------------------
  CLEAR e_inst_name.
  CLEAR es_message.

* --- Check ---------------------------------------------
  IF i_institution IS NOT INITIAL.
    CALL FUNCTION 'ISH_EINRI_CHECK'
      EXPORTING
        ss_einri = i_institution
      IMPORTING
        ss_einkb = e_inst_name
      EXCEPTIONS
        OTHERS   = 1.
    IF sy-subrc <> 0.
      CLEAR e_inst_name.
      es_message-arbgb = 'N2GL_ASSIGN'.
      es_message-msgnr = '001'.
*     Einrichtung &1 ist im System nicht vorhanden
    ENDIF.

  ELSE.
    es_message-arbgb = 'N2GL_ASSIGN'.
    es_message-msgnr = '002'.
*   Geben Sie eine Einrichtung ein
  ENDIF.
ENDFORM.                    " CHECK_EINRI
*&---------------------------------------------------------------------*
*&      Form  PATSERCH_CHECK_EINRI
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form PATSERCH_CHECK_EINRI .
  DATA ls_message TYPE t100.

  PERFORM check_einri
    USING
      rnpa1-einri
    CHANGING
      rnpa1-fzenm
      ls_message.

  IF ls_message IS NOT INITIAL.
    g_cursor_field = 'RNPA1-EINRI'.
    g_cursor_intensified = true.
    SET CURSOR FIELD g_cursor_field.

    MESSAGE ID ls_message-arbgb TYPE 'E' NUMBER ls_message-msgnr
      WITH rnpa1-einri.
  ENDIF.
endform.                    " PATSERCH_CHECK_EINRI
