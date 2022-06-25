class CL_ISH_UTL_BASE_CONV definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_UTL_BASE_CONV
*"* do not include other source files here!!!
  type-pools ABAP .

  interfaces IF_ISH_CONSTANT_DEFINITION .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .

  class-methods CONVERT_STRING_TO_TABLE
    importing
      value(I_STRING) type STRING
      value(I_TABLINE_LENGTH) type I default 256
    exporting
      value(ET_TABLE) type STANDARD TABLE .
  class-methods CONV_DURATION_TO_EXTERN
    importing
      value(I_DURATION) type ANY
    exporting
      value(E_DURATION) type ANY .
  class-methods CONV_DURATION_TO_INTERN
    importing
      value(I_DURATION) type ANY
      !IR_OBJECT type ref to OBJECT optional
      value(I_FIELD) type BAPI_FLD optional
    exporting
      value(E_DURATION) type ANY
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods ALPHA_TO_EXTERN
    changing
      !C_FIELD type CLIKE .
  class-methods CONVERT_LONGTEXT_TO_STRING
    importing
      value(IT_TLINE) type ISH_T_TEXTMODULE_TLINE
      value(I_SEPARATOR) type STRING optional
      value(I_NO_WHITESPACE) type ISH_ON_OFF default SPACE
    exporting
      value(E_LONGTEXT) type STRING
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods ALPHA_TO_INTERN
    changing
      !C_FIELD type CLIKE .
  class-methods CONVERT_STRING_TO_LONGTEXT
    importing
      value(I_STRING) type STRING
      value(I_LENGTH) type I default 70
      value(I_SEPERATOR_SIGN) type STRING optional
    exporting
      !ET_TLINE type ISH_T_TEXTMODULE_TLINE
      value(E_IS_LONGTEXT) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CONV_CHAR_TO_EXTERN
    changing
      value(C_VALUE) type C .
  class-methods CONV_CHAR_TO_INTERN
    importing
      value(I_LENGTH) type I
    changing
      value(C_VALUE) type C .
  class-methods CONV_TO_OBJLIST
    importing
      value(IT_OBJECTS) type TABLE
    returning
      value(RT_OBJECTLIST) type ISH_OBJECTLIST .
  class-methods CONV_DATE_TO_EXTERN
    importing
      value(I_DATE) type SY-DATUM
    returning
      value(R_DATE) type STRING .
  class-methods CONV_TIME_TO_EXTERN
    importing
      value(I_TIME) type SY-UZEIT
    returning
      value(R_TIME) type STRING .
  class-methods CONV_TIME_TO_INTERN
    importing
      value(I_TIME) type STRING
    exporting
      value(E_TIME) type SY-UZEIT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CONV_EINRI_TO_INTERN
    importing
      value(I_EINRI) type ANY
    returning
      value(R_EINRI) type EINRI
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CONV_GPART_TO_INTERN
    importing
      value(I_GPART) type ANY
    returning
      value(R_GPART) type GPARTNER
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CONV_ORGID_TO_INTERN
    importing
      value(I_ORGID) type ANY
    returning
      value(R_ORGID) type ORGID
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CONV_BAUID_TO_INTERN
    importing
      value(I_BAUID) type ANY
    returning
      value(R_BAUID) type BAUID
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CONV_PERNR_TO_INTERN
    importing
      value(I_PERNR) type ANY
    returning
      value(R_PERNR) type P_PERNR
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CONV_DSPTY_TO_INTERN
    importing
      value(I_DSPTY) type ANY
    returning
      value(R_DSPTY) type ISH_DSPT
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_UTL_BASE_CONV
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_BASE_CONV
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_BASE_CONV IMPLEMENTATION.


  METHOD alpha_to_extern.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_OUTPUT'
      EXPORTING
        input  = c_field
      IMPORTING
        output = c_field.

  ENDMETHOD.


  METHOD alpha_to_intern.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = c_field
      IMPORTING
        output = c_field.

  ENDMETHOD.


METHOD CONVERT_LONGTEXT_TO_STRING.

  DATA: ls_tline        TYPE tline.

* Initializations.
  CLEAR: e_longtext,
         e_rc.

* No text lines => exit.
  CHECK NOT it_tline IS INITIAL.

* Concatenate text lines to string.
  LOOP AT it_tline INTO ls_tline.
    IF sy-tabix = 1.
*     First line without CONCATENATE
*     to prevent separator on first position.
      e_longtext = ls_tline-tdline.
    ELSE.
      IF i_no_whitespace IS NOT INITIAL.                 "MED-64188
*       No whitespace                                    "MED-64188
        CONCATENATE e_longtext ls_tline-tdline           "MED-64188
               INTO e_longtext.                          "MED-64188
      ELSEIF i_separator IS INITIAL.                     "MED-64188
*       No separator => use space.
        CONCATENATE e_longtext ls_tline-tdline
               INTO e_longtext
          SEPARATED BY space.
      ELSE.
*       Use separator.
        CONCATENATE e_longtext ls_tline-tdline
               INTO e_longtext
          SEPARATED BY i_separator.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD convert_string_to_longtext.

* ED, ID 16882 -> BEGIN
  DATA: l_length       TYPE i,
        l_add_length   TYPE i,
        ls_line        TYPE tline,
        l_length_total TYPE i,
        lt_result      TYPE TABLE OF string,
        l_result       TYPE string.

  DATA text_tab        TYPE ishmed_t_clim_tdline.            " MED-64188
  DATA l_lines         TYPE i.                                "MED-90451

  e_rc = 0.
* length by row
  CHECK i_length > 0.

* string length
  l_length = strlen( i_string ).

  CHECK NOT i_string IS INITIAL AND NOT l_length IS INITIAL.

  ls_line-tdformat = '*'.
  IF i_seperator_sign IS INITIAL.
    IF l_length > i_length.
* MED-64188 Begin
* split text at appropriate position
* get position for linebreak
      CALL FUNCTION 'SOTR_SERV_STRING_TO_TABLE'
        EXPORTING
          text                = i_string
          flag_no_line_breaks = abap_off
          line_length         = i_length
*         LANGU               = SY-LANGU
        TABLES
          text_tab            = text_tab.
      LOOP AT text_tab INTO ls_line-tdline.
*      l_add_length = 0.
*      DO.
*        CLEAR ls_line-tdline.
*        l_length_total = l_add_length + i_length.
*        IF l_length_total > l_length.
*          l_length_total = l_length - l_add_length.
*          ls_line-tdline = i_string+l_add_length(l_length_total).
*        ELSE.
*          ls_line-tdline = i_string+l_add_length(i_length).
*        ENDIF.
*        ADD i_length TO l_add_length.
        APPEND ls_line TO et_tline.
*        IF l_add_length > l_length.
*          EXIT.
*        ENDIF.
*      ENDDO.
      ENDLOOP.
* MED-64188 End
    ELSE.
      e_is_longtext = off.
    ENDIF.

  ELSE.
    SPLIT i_string AT i_seperator_sign INTO
          TABLE lt_result.
* BEGIN MED-90451
**-- begin Grill, MED-44132
*    LOOP AT lt_result INTO l_result.
*      CHECK l_result IS INITIAL.
*      DELETE lt_result.
*    ENDLOOP.
*   remove only leading empty lines
    LOOP AT lt_result INTO l_result.
      IF l_result IS INITIAL.
        DELETE lt_result.
      ELSE.
        EXIT.
      ENDIF.
    ENDLOOP.
* END MED-90451
    CHECK lt_result IS NOT INITIAL.
    CLEAR l_result.
    LOOP AT lt_result INTO l_result.
      ls_line-tdline = l_result.
      APPEND ls_line TO et_tline.
    ENDLOOP.
    IF lines( lt_result ) = 1.
      IF i_length > 0.
        READ TABLE lt_result INDEX 1 INTO l_result.
        IF strlen( l_result ) > i_length.
          e_is_longtext = on.
        ENDIF.
      ENDIF.
    ELSE.
      e_is_longtext = on.
    ENDIF.
    RETURN.
*    READ TABLE lt_result INDEX 1 INTO l_result.
*    IF l_result IS INITIAL.
*      DELETE lt_result INDEX 1.
*    ENDIF.
*    DESCRIBE TABLE lt_result.
*    IF sy-tfill < 2.
*      REFRESH lt_result.
*    ENDIF.
*    IF sy-subrc EQ 0 AND NOT lt_result[] IS INITIAL.
*      LOOP AT lt_result INTO l_result.
*        ls_line-tdline = l_result.
*        APPEND ls_line TO et_tline.
*      ENDLOOP.
*    ENDIF.
*-- end Grill, MED-44132
  ENDIF.
  IF NOT et_tline[] IS INITIAL.
    e_is_longtext = on.
  ENDIF.

* ED, ID 16882 -> END

ENDMETHOD.


METHOD convert_string_to_table.

  DATA: l_length      TYPE i,
        l_offset      TYPE i,
        l_full_lines  TYPE i,
        l_last_length TYPE i.
* Hilfsfelder und -strukturen
  DATA  l_data          TYPE REF TO data.
* Feldsymbole
  FIELD-SYMBOLS: <ls_table_lines> type any.

*  Erzeugen eines neuen Datenobjekts (Feldes) vom angegebenen Typ. Nach
* der Erzeugung enthält das Datenobjekt seinen typgerechten Initialwert.
    CREATE DATA l_data LIKE LINE OF et_table.
* Die Datenreferenz (l_data) zeigt auf eine Zeile der Importing-Tabelle
*   it_behfa. Dieses Feld wird nun dem Feldsymbol zugeordnet.
    ASSIGN l_data->* TO <ls_table_lines>.

* get string length
  l_length = strlen( i_string ).
* get number of full lines
  l_full_lines  = l_length DIV i_tabline_length.
* get length of last line
  l_last_length = l_length MOD i_tabline_length.
*
* append full lines to output table
  DO l_full_lines TIMES.
    <ls_table_lines> = i_string+l_offset(i_tabline_length).
    APPEND <ls_table_lines> TO et_table.
    l_offset = l_offset + i_tabline_length.
  ENDDO.

* append last line to output table
  <ls_table_lines> = i_string+l_offset(l_last_length).
  APPEND <ls_table_lines> TO et_table.


ENDMETHOD.


METHOD conv_bauid_to_intern.

  DATA: lr_abap_typedescr TYPE REF TO cl_abap_typedescr,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_len             TYPE i.  "PN/MED-32902/2008/07/02

  CALL METHOD cl_abap_typedescr=>describe_by_data
    EXPORTING
      p_data      = r_bauid
    RECEIVING
      p_descr_ref = lr_abap_typedescr.

*Sta/PN/MED-32902/2008/07/02
*  IF strlen( i_bauid ) > lr_abap_typedescr->length.
  l_len = lr_abap_typedescr->length / cl_abap_char_utilities=>charsize.
  IF STRLEN( i_bauid ) > l_len.
    CREATE OBJECT lr_errorhandler.
*End/PN/MED-32902/2008/07/02
    CALL METHOD lr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'S'
        i_kla = 'N1BASE'
        i_num = '139'
        i_mv1 = 'BAUID'
        i_mv2 = i_bauid.

    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = i_bauid
    IMPORTING
      output = r_bauid.

  IF NOT r_bauid IS INITIAL.

    TRANSLATE r_bauid TO UPPER CASE.                     "#EC TRANSLANG

  ENDIF.

ENDMETHOD.


METHOD CONV_CHAR_TO_EXTERN.

* ---------- ---------- ----------
  CHECK NOT c_value IS INITIAL.
  IF c_value CO ' 0123456789'.
    WRITE c_value TO c_value NO-ZERO.
    CONDENSE c_value.
  ELSE.
    SHIFT c_value LEFT DELETING LEADING ' '.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD CONV_CHAR_TO_INTERN .

  FIELD-SYMBOLS <fs> TYPE ANY.

  CHECK NOT c_value IS INITIAL.

  ASSIGN c_value(i_length) TO <fs>.

  CHECK <fs> CO ' 0123456789'.

  SHIFT <fs> RIGHT DELETING TRAILING ' '.

  TRANSLATE <fs> USING ' 0'.

ENDMETHOD.


METHOD CONV_DATE_TO_EXTERN .

* definitions
  DATA: ls_table_field          TYPE tabfield,
        l_char_date(10)         TYPE c,
        l_date_ext(10)          TYPE c.
* ---------- ---------- ----------
* write date to local attribut in char-format
  l_char_date = i_date.
* ---------- ---------- ----------
* convert date to extern format
  CLEAR: ls_table_field.
  ls_table_field-tabname    =  'NTMN'.
  ls_table_field-fieldname  =  'TMNDT'.
  CALL FUNCTION 'RS_DS_CONV_IN_2_EX'
    EXPORTING
      input       = l_char_date
      table_field = ls_table_field
    IMPORTING
      output      = l_date_ext.
  r_date = l_date_ext.
* ---------- ---------- ----------

ENDMETHOD.


METHOD conv_dspty_to_intern.

  DATA: lr_abap_typedescr TYPE REF TO cl_abap_typedescr,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_len             TYPE i.  "PN/MED-32902/2008/07/02

  CALL METHOD cl_abap_typedescr=>describe_by_data
    EXPORTING
      p_data      = r_dspty
    RECEIVING
      p_descr_ref = lr_abap_typedescr.

*Sta/PN/MED-32902/2008/07/02
*  IF strlen( i_dspty ) > lr_abap_typedescr->length.
  l_len = lr_abap_typedescr->length / cl_abap_char_utilities=>charsize.
  IF STRLEN( i_dspty ) > l_len.
    CREATE OBJECT lr_errorhandler.
*End/PN/MED-32902/2008/07/02
    CALL METHOD lr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'S'
        i_kla = 'N1BASE'
        i_num = '139'
        i_mv1 = 'DSPTY'
        i_mv2 = i_dspty.

    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = i_dspty
    IMPORTING
      output = r_dspty.

  IF NOT r_dspty IS INITIAL.

    TRANSLATE r_dspty TO UPPER CASE.                     "#EC TRANSLANG

  ENDIF.

ENDMETHOD.


METHOD conv_duration_to_extern.

  DATA: l_text(20) TYPE c,
        l_quan(16) TYPE p DECIMALS 5.
  DATA: l_x        TYPE i.    " Fichte, Note 839842

* The following algorithm would have a problem with a value of e.g.
* 1000, which has no places after the comma (in difference to e.g.
* 1000,12). Reason. The WRITE would convert it into "1.000" and the
* algorithm would change it into "1" what would be completely wrong!
* To prevent this the input-value is assigned to a quantity-field
* with some decimals (here L_QUAN). That means that the input-value
* of "1000" will become "1000.00000" => The algorithm converts it
* into "1.000" (thousand) => thats right.
  TRY.
      l_quan = i_duration.
    CATCH cx_root.
      CALL METHOD cl_ish_utl_base_conv=>conv_duration_to_intern
        EXPORTING
          i_duration = i_duration
        IMPORTING
          e_duration = l_quan.
  ENDTRY.

  IF l_quan = 0.
    CLEAR e_duration.
    EXIT.
  ENDIF.

  WRITE l_quan TO l_text.
  IF l_text CA ',.'.
*   Get rid of the '0' after the komma
    SHIFT l_text RIGHT DELETING TRAILING ' 0'.

*   Fichte, Note 839842:
*   If the komma is now the last character of the string, delete
*   the thousand-marks as well to prevent problems with the
*   conversion - because otherwise an input of 1200 would get
*   to 1.200 and this would be shown as 1,2 !!!!
    l_x = strlen( l_text ) - 1.
    IF l_text+l_x(1) CA ',.'.
      TRANSLATE l_text USING ', . '.
      CONDENSE l_text NO-GAPS.
      SHIFT l_text LEFT DELETING LEADING ' '.
      e_duration = l_text.
      EXIT.
    ENDIF.
*   Fichte, 839842 - End

*   If the komma is the last character => get rid of it
    SHIFT l_text RIGHT DELETING TRAILING ',.'.
    SHIFT l_text LEFT DELETING LEADING ' '.
  ENDIF.
  e_duration = l_text.

ENDMETHOD.


METHOD conv_duration_to_intern.

  DATA: BEGIN OF l_emask,
          prefix(2),
          convexit TYPE rsconvert-convexit,
        END   OF l_emask.
  DATA: l_convert TYPE rsconvlite,
        l_duration(15).

  CLEAR: l_convert,
         l_emask.
  DESCRIBE FIELD e_duration OUTPUT-LENGTH l_convert-olength
                        DECIMALS      l_convert-decimals
                        EDIT MASK     l_emask.
  l_convert-active   = 'X'.
  l_convert-convexit = l_emask-convexit.

  l_duration = i_duration.

  CALL FUNCTION 'RS_CONV_EX_2_IN_NO_DD'
    EXPORTING
      input_external              = l_duration
      convert                     = l_convert
*     CURRENCY                    = ' '
*     QUANTITY                    = ' '
    IMPORTING
      output_internal             = e_duration
    EXCEPTIONS
      input_not_numerical         = 1
      too_many_decimals           = 2
      more_than_one_sign          = 3
      ill_thousand_separator_dist = 4
      too_many_digits             = 5
      sign_for_unsigned           = 6
      too_large                   = 7
      too_small                   = 8
      invalid_date_format         = 9
      invalid_date                = 10
      invalid_time_format         = 11
      invalid_time                = 12
      invalid_hex_digit           = 13
      unexpected_error            = 14
      input_too_long              = 15
      no_decimals                 = 16
      invalid_float               = 17
      illegal_type                = 18
      conversion_exit_error       = 19
      OTHERS                      = 20.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = sy-msgty
        i_kla           = sy-msgid
        i_num           = sy-msgno
        i_mv1           = sy-msgv1
        i_mv2           = sy-msgv2
        i_mv3           = sy-msgv3
        i_mv4           = sy-msgv4
        ir_object       = ir_object
        i_field         = i_field
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD conv_einri_to_intern.

  DATA: lr_abap_typedescr TYPE REF TO cl_abap_typedescr,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_len             TYPE i.  "PN/MED-32902/2008/07/02

  CALL METHOD cl_abap_typedescr=>describe_by_data
    EXPORTING
      p_data      = r_einri
    RECEIVING
      p_descr_ref = lr_abap_typedescr.

*Sta/PN/MED-32902/2008/07/02
*  IF strlen( i_einri ) > lr_abap_typedescr->length.
  l_len = lr_abap_typedescr->length / cl_abap_char_utilities=>charsize.
  IF STRLEN( i_einri ) > l_len.
    CREATE OBJECT lr_errorhandler.
*End/PN/MED-32902/2008/07/02
    CALL METHOD lr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'S'
        i_kla = 'N1BASE'
        i_num = '139'
        i_mv1 = 'EINRI'
        i_mv2 = i_einri.

    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = i_einri
    IMPORTING
      output = r_einri.

ENDMETHOD.


METHOD conv_gpart_to_intern.

  DATA: lr_abap_typedescr TYPE REF TO cl_abap_typedescr,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_len             TYPE i.  "PN/MED-32902/2008/07/02

  CALL METHOD cl_abap_typedescr=>describe_by_data
    EXPORTING
      p_data      = r_gpart
    RECEIVING
      p_descr_ref = lr_abap_typedescr.

*Sta/PN/MED-32902/2008/07/02
*  IF strlen( i_gpart) > lr_abap_typedescr->length.
  l_len = lr_abap_typedescr->length / cl_abap_char_utilities=>charsize.
  IF STRLEN( i_gpart ) > l_len.
    CREATE OBJECT lr_errorhandler.
*End/PN/MED-32902/2008/07/02
    CALL METHOD lr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'S'
        i_kla = 'N1BASE'
        i_num = '139'
        i_mv1 = 'GPART'
        i_mv2 = i_gpart.

    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = i_gpart
    IMPORTING
      output = r_gpart.

  IF NOT r_gpart IS INITIAL.

    TRANSLATE r_gpart TO UPPER CASE.  "#EC TRANSLANG

  ENDIF.

ENDMETHOD.


METHOD conv_orgid_to_intern.

  DATA: lr_abap_typedescr TYPE REF TO cl_abap_typedescr,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_len             TYPE i.  "PN/MED-32902/2008/07/02

  CALL METHOD cl_abap_typedescr=>describe_by_data
    EXPORTING
      p_data      = r_orgid
    RECEIVING
      p_descr_ref = lr_abap_typedescr.

*Sta/PN/MED-32902/2008/07/02
*  IF strlen( i_orgid ) > lr_abap_typedescr->length.
  l_len = lr_abap_typedescr->length / cl_abap_char_utilities=>charsize.
  IF STRLEN( i_orgid ) > l_len.
    CREATE OBJECT lr_errorhandler.
*End/PN/MED-32902/2008/07/02
    CALL METHOD lr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'S'
        i_kla = 'N1BASE'
        i_num = '139'
        i_mv1 = 'ORGID'
        i_mv2 = i_orgid.

    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = i_orgid
    IMPORTING
      output = r_orgid.

  IF NOT r_orgid IS INITIAL.

    TRANSLATE r_orgid TO UPPER CASE.    "#EC TRANSLANG

  ENDIF.

ENDMETHOD.


METHOD conv_pernr_to_intern.

  DATA: lr_abap_typedescr TYPE REF TO cl_abap_typedescr,
        lr_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
  DATA: l_len             TYPE i.  "PN/MED-32902/2008/07/02

  CALL METHOD cl_abap_typedescr=>describe_by_data
    EXPORTING
      p_data      = r_pernr
    RECEIVING
      p_descr_ref = lr_abap_typedescr.

*Sta/PN/MED-32902/2008/07/02
*  IF strlen( i_pernr ) > lr_abap_typedescr->length.
  l_len = lr_abap_typedescr->length / cl_abap_char_utilities=>charsize.
  IF STRLEN( i_pernr ) > l_len.
    CREATE OBJECT lr_errorhandler.
*End/PN/MED-32902/2008/07/02
    CALL METHOD lr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'S'
        i_kla = 'N1BASE'
        i_num = '139'
        i_mv1 = 'PERNR'
        i_mv2 = i_pernr.

    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_errorhandler.
  ENDIF.

  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = i_pernr
    IMPORTING
      output = r_pernr.

  IF NOT r_pernr IS INITIAL.

    TRANSLATE r_pernr TO UPPER CASE.  "#EC TRANSLANG

  ENDIF.

ENDMETHOD.


METHOD CONV_TIME_TO_EXTERN .

* definitions
  DATA: ls_table_field          TYPE tabfield,
        l_char_time(10)         TYPE c,
        l_time_ext(8)           TYPE c.
* ---------- ---------- ----------
* write date to local attribut in char-format
  l_char_time = i_time.
* ---------- ---------- ----------
* convert date to extern format
  CLEAR: ls_table_field.
  ls_table_field-tabname    =  'NTMN'.
  ls_table_field-fieldname  =  'TMNZT'.
  CALL FUNCTION 'RS_DS_CONV_IN_2_EX'
    EXPORTING
      input       = l_char_time
      table_field = ls_table_field
    IMPORTING
      output      = l_time_ext.
  r_time = l_time_ext(5).
* ---------- ---------- ----------

ENDMETHOD.


METHOD CONV_TIME_TO_INTERN .

* definitions
  DATA: ls_table_field          TYPE tabfield,
        l_char_time(10)         TYPE c,
        l_time_ext(8)           TYPE c.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* write time to local attribute in char-format
  l_char_time = i_time.
* ---------- ---------- ----------
  CLEAR: ls_table_field.
  ls_table_field-tabname    =  'NTMN'.
  ls_table_field-fieldname  =  'TMNZT'.
* ----------
* convert time
  CALL FUNCTION 'RS_CHECK_CONV_EX_2_IN'
    EXPORTING
      input_external               = l_char_time
      table_field                  = ls_table_field
    IMPORTING
      input_i_format               = l_time_ext
    EXCEPTIONS
      input_not_numerical          = 1
      too_many_decimals            = 2
      more_than_one_sign           = 3
      ill_thousand_separator_dist  = 4
      too_many_digits              = 5
      sign_for_unsigned            = 6
      too_large                    = 7
      too_small                    = 8
      invalid_date_format          = 9
      invalid_date                 = 10
      invalid_time_format          = 11
      invalid_time                 = 12
      invalid_hex_digit            = 13
      unexpected_error             = 14
      invalid_fieldname            = 15
      field_and_descr_incompatible = 16
      input_too_long               = 17
      no_decimals                  = 18
      invalid_float                = 19
      conversion_exit_error        = 20
      OTHERS                       = 21.
  IF sy-subrc = 0.
    e_time = l_time_ext.
  ELSE.
    e_rc = sy-subrc.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = sy-msgty
        i_kla           = sy-msgid
        i_num           = sy-msgno
        i_mv1           = sy-msgv1
        i_mv2           = sy-msgv2
        i_mv3           = sy-msgv3
        i_mv4           = sy-msgv4
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD CONV_TO_OBJLIST .

* workareas
  FIELD-SYMBOLS:
         <ls_imp_obj>               TYPE ANY.
  DATA:  ls_obj                     TYPE ish_object.
* ---------- ---------- ----------
  TRY.
    LOOP AT it_objects ASSIGNING <ls_imp_obj>.
      CLEAR: ls_obj.
      ls_obj-object = <ls_imp_obj>.
      INSERT ls_obj INTO TABLE rt_objectlist.
    ENDLOOP.

*    CATCH ???

  ENDTRY.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
