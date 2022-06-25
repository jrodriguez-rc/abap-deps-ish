FUNCTION ishmed_check_date_time.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_DATE) TYPE  CHAR10 OPTIONAL
*"     VALUE(I_TIME) TYPE  CHAR8 OPTIONAL
*"     VALUE(I_NO_DATE_SEPARATORS) TYPE  XFELD OPTIONAL
*"     VALUE(I_MSG_PAR) TYPE  BAPIRET2-PARAMETER OPTIONAL
*"     VALUE(I_MSG_ROW) TYPE  BAPIRET2-ROW OPTIONAL
*"     VALUE(I_MSG_FLD) TYPE  BAPIRET2-FIELD OPTIONAL
*"     VALUE(I_MSG_OBJ) TYPE  N1OBJECTREF OPTIONAL
*"     VALUE(I_MSG_LINE_KEY) TYPE  CHAR100 OPTIONAL
*"     VALUE(I_DATE_FILL) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_TIME_FILL) TYPE  ISH_ON_OFF DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_DATE) TYPE  SY-DATUM
*"     VALUE(E_TIME) TYPE  SY-UZEIT
*"     VALUE(E_DATE_EXT) TYPE  CHAR10
*"     VALUE(E_TIME_EXT) TYPE  CHAR8
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     REFERENCE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------

  DATA: l_tmp_date    TYPE syst-datum,
        l_tmp_time    TYPE sy-uzeit,
        l_conv_time   TYPE char8,
        l_conv_date   TYPE char10,
        l_time_c      TYPE char8,
        l_date_c      TYPE char10,
        l_ld_strlen   LIKE sy-tabix,
        l_field       TYPE tabfield,
        l_par1        TYPE sy-msgv1,
        l_par2        TYPE sy-msgv2.

  CLEAR: e_rc, e_date, e_time.
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  IF c_errorhandler IS INITIAL.
*   Instanz für Errorhandling erzeugen
    CREATE OBJECT c_errorhandler.
  ENDIF.
* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

*-----Process date input
  IF i_date IS INITIAL.
*.....Date not provided --> fill with local system date
    IF i_date_fill = on.
      e_date = sy-datlo.
    ELSE.
      e_date = i_date.
    ENDIF.
  ELSE.
*.....Check and convert entered date into internal format
    CALL FUNCTION 'CONVERT_DATE_TO_INTERNAL'
         EXPORTING
              date_external = i_date
         IMPORTING
              date_internal = l_tmp_date
         EXCEPTIONS
              OTHERS        = 1.
    IF sy-subrc EQ 0.
      e_date = l_tmp_date.
    ELSE.
      l_par1 = i_date.
      IF NOT i_no_date_separators IS INITIAL.
        WRITE sy-datlo TO l_par2 DDMMYY.
      ELSE.
        WRITE sy-datlo TO l_par2 DD/MM/YYYY.
      ENDIF.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NF1'
          i_num           = '721'
          i_mv1           = l_par1
          i_mv2           = l_par2
          i_par           = i_msg_par
          i_row           = i_msg_row
          i_fld           = i_msg_fld
          i_object        = i_msg_obj
          i_line_key      = i_msg_line_key
          i_last          = space.
      e_rc = 1.
      CLEAR e_date.
      EXIT.
    ENDIF.                             "IF sy-subrc EQ 0
  ENDIF.                               "IF i_date IS INITIAL

*-----Process time input
  IF i_time IS INITIAL.
*.....Time not provided --> fill with local system time
    IF i_time_fill = on.
      l_tmp_time = sy-timlo.
    ELSE.
      l_tmp_time = i_time.
    ENDIF.
  ELSE.
    WRITE i_time TO l_conv_time NO-GAP.
    IF l_conv_time CN ' 0123456789:'.
      l_par1 = i_time.
      WRITE sy-timlo TO l_par2.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NF1'
          i_num           = '722'
          i_mv1           = l_par1
          i_mv2           = l_par2
          i_par           = i_msg_par
          i_row           = i_msg_row
          i_fld           = i_msg_fld
          i_object        = i_msg_obj
          i_line_key      = i_msg_line_key
          i_last          = space.
      e_rc = 2.
      EXIT.
    ENDIF.
    IF l_conv_time CO ' 0123456789'.
      l_ld_strlen  = strlen( l_conv_time ).
      IF l_conv_time < 10 AND l_ld_strlen  = 1.           "#EC PORTABLE
*.....Handle one-digit entries
        CONCATENATE '0' l_conv_time INTO l_conv_time.
      ENDIF.
    ENDIF.
*.....Check and convert entered time into internal format
    CALL FUNCTION 'CONVERSION_EXIT_TIMLO_INPUT'
         EXPORTING
              input  = l_conv_time
         IMPORTING
              output = l_tmp_time
         EXCEPTIONS
              OTHERS = 1.
    IF sy-subrc EQ 1.
      l_par1 = i_time.
      WRITE sy-timlo TO l_par2.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NF1'
          i_num           = '722'
          i_mv1           = l_par1
          i_mv2           = l_par2
          i_par           = i_msg_par
          i_row           = i_msg_row
          i_fld           = i_msg_fld
          i_object        = i_msg_obj
          i_line_key      = i_msg_line_key
          i_last          = space.
      e_rc = 3.
      EXIT.
    ENDIF.
    CALL FUNCTION 'TIME_CHECK_PLAUSIBILITY'
         EXPORTING
              time   = l_tmp_time
         EXCEPTIONS
              OTHERS = 1.
    IF sy-subrc EQ 1.
      l_par1 = l_tmp_time.
      WRITE sy-timlo TO l_par2.
      CALL METHOD c_errorhandler->collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NF1'
          i_num           = '723'
          i_mv1           = l_par1
          i_par           = i_msg_par
          i_row           = i_msg_row
          i_fld           = i_msg_fld
          i_object        = i_msg_obj
          i_line_key      = i_msg_line_key
          i_last          = space.
      e_rc = 4.
      EXIT.
    ENDIF.
  ENDIF.
  WRITE l_tmp_time TO e_time.

*.....Convert date to external again if requested
  IF e_date_ext IS REQUESTED AND NOT e_date = space.
    CLEAR l_field.
    l_field-tabname   = 'SY'.
    l_field-fieldname = 'DATUM'.
    l_date_c = e_date.
    CALL FUNCTION 'RS_DS_CONV_IN_2_EX'
         EXPORTING
              input       = l_date_c
              table_field = l_field
         IMPORTING
              output      = l_conv_date.
    e_date_ext = l_conv_date.
  ENDIF.

*.....Convert time to external again if requested
  IF e_time_ext IS REQUESTED AND NOT e_time = space.
    CLEAR l_field.
    l_field-tabname   = 'SY'.
    l_field-fieldname = 'UZEIT'.
    l_time_c = e_time.
    CALL FUNCTION 'RS_DS_CONV_IN_2_EX'
         EXPORTING
              input       = l_time_c
              table_field = l_field
         IMPORTING
              output      = l_conv_time.
    IF l_conv_time IS INITIAL.
      l_conv_time = '00:00:00'.
    ENDIF.
    e_time_ext = l_conv_time.
  ENDIF.

ENDFUNCTION.
