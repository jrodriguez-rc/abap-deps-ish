*&---------------------------------------------------------------------*
*& Report  RN1_CORRECT_PATREG_PAT_NAME
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  rn1_correct_patreg_pat_name.
TYPE-POOLS slis.
INCLUDE mndata00.

SELECTION-SCREEN BEGIN OF BLOCK one.
*-- Test run.
PARAMETERS pa_test AS CHECKBOX DEFAULT on.

SELECTION-SCREEN END OF BLOCK one.

DATA: l_cursor      TYPE cursor,
      lt_n1prpat    TYPE TABLE OF n1prpat,
      lt_n1prpat_c  TYPE TABLE OF n1prpat,
      lt_n1prpat_w  TYPE TABLE OF n1prpat,
      lt_n1prpatzuo TYPE TABLE OF n1prpatzuo,
      ls_n1prpix    TYPE n1prpix,
      lt_npat       TYPE TABLE OF npat,
      ls_n1prpat    TYPE n1prpat.

DATA: BEGIN OF wa,
         mandtloc TYPE n1prtlnr-mandtloc,
           patid TYPE n1prpatzuo-patid,
           patnr TYPE n1prpatzuo-patnr,
       END OF wa.

DATA: lt_patreg_zuo LIKE TABLE OF wa,
      lt_patreg     LIKE TABLE OF wa.
FIELD-SYMBOLS: <ls_n1prpat> TYPE n1prpat,
               <ls_n1prpatzuo> TYPE n1prpatzuo,
               <ls_npat>       TYPE npat,
               <ls_pat>        LIKE LINE OF lt_patreg_zuo.

START-OF-SELECTION.

*-- Open Cursor for current client.
  OPEN CURSOR WITH HOLD l_cursor FOR
     SELECT * FROM n1prpat                              "#EC CI_NOFIELD
     WHERE storn = off.                                 "#EC CI_NOFIELD
  DO.
    REFRESH: lt_n1prpat, lt_n1prpat_c,lt_patreg.

*-- Select data.
    FETCH NEXT CURSOR l_cursor INTO TABLE lt_n1prpat PACKAGE SIZE 5000.
    IF sy-subrc <> 0.
*-- No more entries => exit .
      EXIT.
    ENDIF.
    IF lt_n1prpat IS INITIAL.
      EXIT.
    ENDIF.
    SELECT p~mandtloc c~patnr c~patid
       INTO CORRESPONDING FIELDS OF TABLE lt_patreg
       FROM ( n1prpatzuo AS c                           "#EC CI_NOFIELD
            INNER JOIN n1prtlnr AS p ON p~tlnrid  = c~tlnrid ) "#EC CI_NOFIELD "#EC CI_BUFFJOIN
       FOR ALL ENTRIES IN lt_n1prpat                    "#EC CI_NOFIELD
       WHERE c~patid = lt_n1prpat-patid.                "#EC CI_NOFIELD

    LOOP AT lt_n1prpat ASSIGNING <ls_n1prpat>.
      IF ( <ls_n1prpat>-nname+1(1) CA 'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ' "#EC *
         AND <ls_n1prpat>-nname NA 'abxdefghijklmnopqrstuvwxyzäöü' ) "#EC *
        OR ( <ls_n1prpat>-vname+1(1) CA 'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ' "#EC *
          AND <ls_n1prpat>-vname NA 'abxdefghijklmnopqrstuvwxyzäöü' ) "#EC *
        OR ( <ls_n1prpat>-gbnam+1(1) CA 'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ' "#EC *
          AND <ls_n1prpat>-gbnam NA 'abxdefghijklmnopqrstuvwxyzäöü' ). "#EC *

        CLEAR: lt_patreg_zuo.
        LOOP AT lt_patreg ASSIGNING <ls_pat>
          WHERE patid = <ls_n1prpat>-patid.
          APPEND <ls_pat> TO lt_patreg_zuo.
        ENDLOOP.

        IF lt_patreg_zuo IS NOT INITIAL.
          CALL METHOD cl_ish_dbr_pat=>get_t_pat_by_patnr
            EXPORTING
              it_patnr = lt_patreg_zuo
            IMPORTING
              et_npat  = lt_npat.
*          SELECT * FROM npat CLIENT SPECIFIED
*            INTO TABLE lt_npat
*            FOR ALL ENTRIES IN lt_patreg_zuo
*            WHERE mandt = lt_patreg_zuo-mandtloc
*            AND   patnr = lt_patreg_zuo-patnr.
          LOOP AT  lt_npat ASSIGNING <ls_npat>.
            IF <ls_npat>-nname CA 'abxdefghijklmnopqrstuvwxyzäöü' OR "#EC *
                <ls_npat>-vname CA 'abxdefghijklmnopqrstuvwxyzäöü' OR "#EC *
                <ls_npat>-gbnam CA 'abxdefghijklmnopqrstuvwxyzäöü'. "#EC *
*             Correct second name
              PERFORM convert_string CHANGING <ls_n1prpat>-nname.
*             Correct first name
              PERFORM convert_string  CHANGING <ls_n1prpat>-vname.
*             Correct name at birth
              PERFORM convert_string CHANGING <ls_n1prpat>-gbnam.
*             Correct City
              PERFORM convert_string CHANGING <ls_n1prpat>-ort.
*             Correct Street
              PERFORM convert_string CHANGING <ls_n1prpat>-stras.
*             Correct Last Name of Person to Be Contacted
              PERFORM convert_string CHANGING <ls_n1prpat>-anna1.
*             Correct First Name of Person to Be Contacted
              PERFORM convert_string CHANGING <ls_n1prpat>-anvn1.
*             Correct City
              PERFORM convert_string CHANGING <ls_n1prpat>-anor1.
*             Correct Street
              PERFORM convert_string CHANGING <ls_n1prpat>-anst1.
**             Correct District
*              PERFORM convert_string CHANGING <ls_n1prpat>-ort2.
**             Correct Patient Birthplace
*              PERFORM convert_string CHANGING <ls_n1prpat>-gbort.
**             Correct Description
*              PERFORM convert_string CHANGING <ls_n1prpat>-blandtxt.
**             Correct Patient Occupation
*              PERFORM convert_string CHANGING <ls_n1prpat>-beruf.
**             Correct Name Affix
*              PERFORM convert_string CHANGING <ls_n1prpat>-namzu.
**             Correct Name Prefix
*              PERFORM convert_string CHANGING <ls_n1prpat>-vorsw.
**             Correct Sex Specification - User-Specific
*              PERFORM convert_string CHANGING <ls_n1prpat>-gschltxt.
**             Correct Title
*              PERFORM convert_string CHANGING <ls_n1prpat>-titel.
**             Correct Country Name
*              PERFORM convert_string CHANGING <ls_n1prpat>-glandtxt.
**             Correct Cause of Death Text
*              PERFORM convert_string CHANGING <ls_n1prpat>-TODURTXT.
**             Correct Form-of-Address Text
*              PERFORM convert_string CHANGING <ls_n1prpat>-ANREDTXT.
**             Correct Marital Status
*              PERFORM convert_string CHANGING <ls_n1prpat>-FAMSTTXT.
**             Correct Religious Denomination Long Text
*              PERFORM convert_string CHANGING <ls_n1prpat>-KONFETXT.
**             Correct Nationality
*              PERFORM convert_string CHANGING <ls_n1prpat>-NATIOTXT.
**             Correct Language
*              PERFORM convert_string CHANGING <ls_n1prpat>-SPRASTXT.
**             Correct Country Name
*              PERFORM convert_string CHANGING <ls_n1prpat>-LANDTXT.
**             Correct Explanation for Donor Indicator
*              PERFORM convert_string CHANGING <ls_n1prpat>-SPENT.
**             Correct Country Name
*              PERFORM convert_string CHANGING <ls_n1prpat>-ANLA1TXT.
**             Correct Text for Relationship
*              PERFORM convert_string CHANGING <ls_n1prpat>-ANVV1TXT.
**             Correct Comment on Patient
*              PERFORM convert_string CHANGING <ls_n1prpat>-KZTXT.
**             Correct Text for Identification Document Type
*              PERFORM convert_string CHANGING <ls_n1prpat>-PASSTYTXT.

              APPEND <ls_n1prpat> TO lt_n1prpat_c.
              APPEND <ls_n1prpat> TO lt_n1prpat_w.

              ls_n1prpix-mandt = <ls_n1prpat>-mandt.
              ls_n1prpix-patid = <ls_n1prpat>-patid.
              ls_n1prpix-nname = <ls_n1prpat>-nname.
*             update only if not test run
              IF pa_test = off.
                UPDATE n1prpix
                   SET nname = <ls_n1prpat>-nname
                 WHERE patid = <ls_n1prpat>-patid.
              ENDIF.
              EXIT.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDLOOP.
*   update only if not test run
    IF pa_test = off AND NOT lt_n1prpat_c IS INITIAL.
      MODIFY n1prpat FROM TABLE lt_n1prpat_c.
      CALL FUNCTION 'DB_COMMIT'.                            "#EC *
    ENDIF.

  ENDDO.
*-- close cursor for current client.
  CLOSE CURSOR l_cursor.

  IF lt_n1prpat_w[] IS INITIAL.
    WRITE:/ text-001.
  ELSE.
    PERFORM make_alv_table.
  ENDIF.

*&---------------------------------------------------------------------*
*&      Form  convert_string
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_STRING   text
*      -->P_EXP      text
*----------------------------------------------------------------------*
FORM convert_string CHANGING p_string.
  DATA: l_first TYPE ish_on_off,
        l_helper TYPE string,
        l_istring TYPE string.

  DATA: l_c TYPE c.
  DATA: lt_supstrings TYPE TABLE OF string,
        ls_supstrings TYPE string.

* ----- ------ ------
  IF p_string IS INITIAL.
    EXIT.
  ENDIF.
* ----- ------ ------
  l_istring = p_string.
  CLEAR: p_string.
  TRANSLATE l_istring TO LOWER CASE.
  l_c = l_istring.
  TRANSLATE l_c TO UPPER CASE.
  SHIFT l_istring.
  CONCATENATE l_c l_istring  INTO p_string.
* ----- ------ ------
  IF p_string CA '- /'.
*   ----- ------ ------
    IF p_string CA '-'.
      CLEAR: lt_supstrings.
      SPLIT p_string AT '-'INTO TABLE lt_supstrings.
      CLEAR: p_string, l_first.
*     ----- ------ ------
      LOOP AT lt_supstrings INTO ls_supstrings.
        l_c = ls_supstrings.
        TRANSLATE l_c TO UPPER CASE.
        SHIFT ls_supstrings.

        IF l_first = space.
          CONCATENATE l_c ls_supstrings INTO p_string.
        ELSE.
          IF l_c = space.
            CONCATENATE p_string '-' INTO p_string.
            CONCATENATE p_string ls_supstrings INTO p_string SEPARATED BY space.
          ELSE.
            CONCATENATE p_string '-' l_c ls_supstrings INTO p_string.
          ENDIF.
        ENDIF.
        l_first = 'X'.
      ENDLOOP.

    ENDIF.
*   ----- ------ ------
    IF p_string CA ' ' .
      CLEAR: lt_supstrings.
      SPLIT p_string AT ' 'INTO TABLE lt_supstrings.
      CLEAR: p_string, l_first.
*     ----- ------ ------
      LOOP AT lt_supstrings INTO ls_supstrings.
        l_c = ls_supstrings.
        TRANSLATE l_c TO UPPER CASE.
        SHIFT ls_supstrings.

        IF l_first = space.
          CONCATENATE l_c ls_supstrings INTO p_string.
        ELSE.
          CONCATENATE l_c ls_supstrings INTO l_helper.
          CONCATENATE p_string l_helper INTO p_string SEPARATED BY space.
        ENDIF.
        l_first = 'X'.
      ENDLOOP.

    ENDIF.
*   ----- ------ ------
    IF p_string CA '/' .
      CLEAR: lt_supstrings.
      SPLIT p_string AT '/'INTO TABLE lt_supstrings.
      CLEAR: p_string, l_first.
*     ----- ------ ------
      LOOP AT lt_supstrings INTO ls_supstrings.
        l_c = ls_supstrings.
        TRANSLATE l_c TO UPPER CASE.
        SHIFT ls_supstrings.

        IF l_first = space.
          CONCATENATE l_c ls_supstrings INTO p_string.
        ELSE.
          IF l_c = space.
            CONCATENATE p_string  '/' INTO p_string.
            CONCATENATE p_string ls_supstrings INTO p_string SEPARATED BY space.
          ELSE.
            CONCATENATE p_string  '/' l_c ls_supstrings INTO p_string.
          ENDIF.
        ENDIF.
        l_first = 'X'.
      ENDLOOP.

    ENDIF.
  ENDIF.
* ----- ------ ------
ENDFORM.                    "convert_String
*&---------------------------------------------------------------------*
*&      Form  make_alv_table
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM make_alv_table.

  DATA: l_repid         LIKE sy-repid.

  DATA: lt_fcat     TYPE lvc_t_fcat,
        lt_fieldcat TYPE slis_t_fieldcat_alv.
  DATA: ls_fieldcat LIKE LINE OF lt_fieldcat,
        ls_layout   TYPE slis_layout_alv.
  FIELD-SYMBOLS: <ls_fcat> LIKE LINE OF lt_fcat.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'N1PRPAT'
    CHANGING
      ct_fieldcat            = lt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  LOOP AT lt_fcat ASSIGNING <ls_fcat>.
    CLEAR: ls_fieldcat.
    MOVE-CORRESPONDING <ls_fcat> TO ls_fieldcat.
    ls_fieldcat-seltext_l = <ls_fcat>-scrtext_l.
    ls_fieldcat-seltext_m = <ls_fcat>-scrtext_m.
    ls_fieldcat-seltext_s = <ls_fcat>-scrtext_s.
*    ls_fieldcat-ddictxt = <ls_fcat>-reptext.
*    ls_fieldcat-ref_fieldname = <ls_fcat>-ref_field.
*    ls_fieldcat-ref_tabname = <ls_fcat>-ref_table.
    IF ls_fieldcat-fieldname <> 'NNAME'
      AND ls_fieldcat-fieldname <> 'VNAME'
      AND ls_fieldcat-fieldname <> 'GBNAM'
      AND ls_fieldcat-fieldname <> 'ORT'
      AND ls_fieldcat-fieldname <> 'STRAS'
      AND ls_fieldcat-fieldname <> 'ANNA1'
      AND ls_fieldcat-fieldname <> 'ANVN1'
      AND ls_fieldcat-fieldname <> 'VNOR1'
      AND ls_fieldcat-fieldname <> 'ANST1'
      AND ls_fieldcat-fieldname <> 'PATID'.
      ls_fieldcat-no_out = 'X'.
    ENDIF.
    APPEND ls_fieldcat TO lt_fieldcat.
  ENDLOOP.

  CLEAR ls_layout.
*  ls_layout-no_vline = 'X'.    " columns separated by space
*  ls_layout-get_selinfos = 'X'.
  ls_layout-header_text = 'Geänderte Patienten'(003).

  CLEAR: l_repid.
  l_repid = sy-repid.


  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = l_repid
      it_fieldcat        = lt_fieldcat
      is_layout          = ls_layout
      i_default          = 'X'
      i_save             = 'A'
    TABLES
      t_outtab           = lt_n1prpat_w
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.                    "make_alv_table
