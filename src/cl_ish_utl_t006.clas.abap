class CL_ISH_UTL_T006 definition
  public
  abstract
  final
  create public .

public section.
*"* public components of class CL_ISH_UTL_T006
*"* do not include other source files here!!!

  constants CO_MIN_DAY_FACTOR type P value 50000. "#EC NOTEXT
  constants CO_MAX_DAY_FACTOR type P value 100000. "#EC NOTEXT
  constants CO_SECS_PER_DAY type P value 86400. "#EC NOTEXT

  class-methods READ_TIME_UNITS
    exporting
      !ET_V_T006_T type ISHMED_T_V_T006_T
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CALCULATE_START_TIME
    importing
      value(I_END_DATE) type SY-DATUM
      value(I_END_TIME) type SY-UZEIT
      value(I_DURATION) type N1DURATION
      value(I_UNIT) type MEINS
    exporting
      value(E_START_DATE) type SY-DATUM
      value(E_START_TIME) type SY-UZEIT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CALCULATE_END_TIME
    importing
      value(I_START_DATE) type SY-DATUM
      value(I_START_TIME) type SY-UZEIT
      value(I_DURATION) type N1DURATION
      value(I_UNIT) type MEINS optional
    exporting
      value(E_END_DATE) type SY-DATUM
      value(E_END_TIME) type SY-UZEIT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHECK_TIME_UNIT
    importing
      value(I_UNIT) type MEINS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CALCULATE_DURATION
    importing
      value(I_START_DATE) type SY-DATUM
      value(I_START_TIME) type SY-UZEIT
      value(I_END_DATE) type SY-DATUM
      value(I_END_TIME) type SY-UZEIT
      value(I_UNIT) type MEINS optional
    exporting
      value(E_DURATION) type N1DURATION
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DAY_UNIT
    returning
      value(R_UNIT) type MEINS .
  class-methods GET_T_DAY_UNIT
    returning
      value(RT_UNIT) type ISH_T_MSEHI .
  class-methods IS_DAY_UNIT
    importing
      !IS_T006 type T006
    returning
      value(R_IS_DAY_UNIT) type ISH_ON_OFF .
protected section.
*"* protected components of class CL_ISH_UTL_T006
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_T006
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_T006 IMPLEMENTATION.


METHOD calculate_duration.

* ------ ------- ------
  CLEAR: e_duration, e_rc.
* ------ ------- ------
  IF i_start_date IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = '1'
        i_mv2           = 'CALCULATE_END_TIME'
        i_mv3           = 'CL_ISH_UTL_T006'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
    RETURN.
  ENDIF.

  IF i_end_date IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = '1'
        i_mv2           = 'CALCULATE_END_TIME'
        i_mv3           = 'CL_ISH_UTL_T006'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
    RETURN.
  ENDIF.

* ------ ------- ------
  CALL FUNCTION 'DURATION_DETERMINE'
    EXPORTING
      unit                       = i_unit
    IMPORTING
      duration                   = e_duration
    CHANGING
      start_date                 = i_start_date
      start_time                 = i_start_time
      end_date                   = i_end_date
      end_time                   = i_end_time
    EXCEPTIONS
      factory_calendar_not_found = 1
      date_out_of_calendar_range = 2
      date_not_valid             = 3
      unit_conversion_error      = 4
      si_unit_missing            = 5
      parameters_not_valid       = 6
      OTHERS                     = 7.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.
* ------ ------- ------
ENDMETHOD.


METHOD calculate_end_time.

* ------ ------- ------
  CLEAR: e_end_date, e_end_time, e_rc.
* ------ ------- ------
  IF i_start_date IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = '1'
        i_mv2           = 'CALCULATE_END_TIME'
        i_mv3           = 'CL_ISH_UTL_T006'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
    RETURN.
  ENDIF.
* ------ ------- ------
  CALL FUNCTION 'END_TIME_DETERMINE'
    EXPORTING
      duration                   = i_duration
      unit                       = i_unit
    IMPORTING
      end_date                   = e_end_date
      end_time                   = e_end_time
    CHANGING
      start_date                 = i_start_date
      start_time                 = i_start_time
    EXCEPTIONS
      factory_calendar_not_found = 1
      date_out_of_calendar_range = 2
      date_not_valid             = 3
      unit_conversion_error      = 4
      si_unit_missing            = 5
      parameters_no_valid        = 6
      OTHERS                     = 7.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.
* ------ ------- ------
ENDMETHOD.


METHOD calculate_start_time.

* ------ ------- ------
  CLEAR: e_start_date, e_start_time, e_rc.
* ------ ------- ------
  IF i_end_date IS INITIAL.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '030'
        i_mv1           = '1'
        i_mv2           = 'CALCULATE_START_TIME'
        i_mv3           = 'CL_ISH_UTL_T006'
      CHANGING
        cr_errorhandler = cr_errorhandler.
    e_rc = 1.
    RETURN.
  ENDIF.
* ------ ------- ------
  CALL FUNCTION 'START_TIME_DETERMINE'
    EXPORTING
      duration                   = i_duration
      unit                       = i_unit
    IMPORTING
      start_date                 = e_start_date
      start_time                 = e_start_time
    CHANGING
      end_date                   = i_end_date
      end_time                   = i_end_time
    EXCEPTIONS
      factory_calendar_not_found = 1
      date_out_of_calendar_range = 2
      date_not_valid             = 3
      unit_conversion_error      = 4
      si_unit_missing            = 5
      parameters_not_valid       = 6
      OTHERS                     = 7.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
      CHANGING
        cr_errorhandler = cr_errorhandler.

  ENDIF.
* ------ ------- ------
ENDMETHOD.


METHOD check_time_unit.

  CLEAR: e_rc.

  CALL FUNCTION 'DIMENSIONCHECK_TIME'
    EXPORTING
      meinh               = i_unit
    EXCEPTIONS
      dimension_not_time  = 1
      t006d_entry_missing = 2
      t006_entry_missing  = 3
      OTHERS              = 4.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD get_day_unit.

  DATA: lt_t006d       TYPE STANDARD TABLE OF t006d,
        lt_t006        TYPE STANDARD TABLE OF t006,
        l_zaehl(9)     TYPE p,
        l_nennr(9)     TYPE p,
        l_factor(9)    TYPE p  DECIMALS 3,
        l_exp10(3)     TYPE p.

  FIELD-SYMBOLS <ls_t006>        TYPE t006.

* ---------------------------------------------------------
* Initialization
  CLEAR: r_unit.
* ---------------------------------------------------------
* Get unit for day
* Get dimension for time
  CLEAR: lt_t006d.
  SELECT * FROM t006d INTO TABLE lt_t006d
           WHERE mass  = 0
           AND   leng  = 0
           AND   timex = 1
           AND   ecurr = 0
           AND   temp  = 0
           AND   molqu = 0
           AND   light = 0.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.
* ---------------------------------------------------------
* Get the units for time
  CLEAR: lt_t006.
  SELECT * FROM t006 INTO TABLE lt_t006
           FOR ALL ENTRIES IN lt_t006d
           WHERE dimid = lt_t006d-dimid.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.
  SORT lt_t006 BY msehi.

  LOOP AT lt_t006 ASSIGNING <ls_t006>.
    CLEAR: l_factor.
    IF cl_ish_utl_t006=>is_day_unit( is_t006 = <ls_t006> ) = abap_true.
      r_unit = <ls_t006>-msehi.
      EXIT.
    ENDIF.
  ENDLOOP.
* ---------------------------------------------------------
ENDMETHOD.


METHOD get_t_day_unit.

  DATA: lt_t006d       TYPE STANDARD TABLE OF t006d,
        lt_t006        TYPE STANDARD TABLE OF t006,
        l_zaehl(9)     TYPE p,
        l_nennr(9)     TYPE p,
        l_factor(9)    TYPE p  DECIMALS 3,
        l_exp10(3)     TYPE p.

  FIELD-SYMBOLS <ls_t006>        TYPE t006.

* ---------------------------------------------------------
* Initialization
  CLEAR: rt_unit.
* ---------------------------------------------------------
* Get unit for day
* Get dimension for time
  CLEAR: lt_t006d.
  SELECT * FROM t006d INTO TABLE lt_t006d
           WHERE mass  = 0
           AND   leng  = 0
           AND   timex = 1
           AND   ecurr = 0
           AND   temp  = 0
           AND   molqu = 0
           AND   light = 0.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.
* ---------------------------------------------------------
* Get the units for time
  CLEAR: lt_t006.
  SELECT * FROM t006 INTO TABLE lt_t006
           FOR ALL ENTRIES IN lt_t006d
           WHERE dimid = lt_t006d-dimid.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.
  SORT lt_t006 BY msehi.

  LOOP AT lt_t006 ASSIGNING <ls_t006>.
    IF cl_ish_utl_t006=>is_day_unit( is_t006 = <ls_t006> ) = abap_true.
      APPEND <ls_t006>-msehi TO rt_unit.
    ENDIF.
  ENDLOOP.
* ---------------------------------------------------------
ENDMETHOD.


METHOD is_day_unit.

  DATA:  l_zaehl(9)     TYPE p,
         l_nennr(9)     TYPE p,
         l_factor(9)    TYPE p  DECIMALS 3,
         l_exp10(3)     TYPE p.

* ---------------------------------------------------------
* Initialization
  CLEAR: r_is_day_unit.
* ---------------------------------------------------------
  IF is_t006 IS INITIAL.
    RETURN.
  ENDIF.
* ---------------------------------------------------------
  l_zaehl = is_t006-zaehl.
  l_nennr = is_t006-nennr.
  l_exp10 = is_t006-exp10.
  IF l_nennr = 0.
    RETURN.
  ENDIF.
  l_factor = ( l_zaehl / l_nennr ) * ( 10 ** l_exp10 ).
*   Fichte, 3.12.09: Changed it to 60s * 60min * 24h = 86400s
*    IF l_factor > co_min_day_factor  AND  l_factor < co_max_day_factor.
  IF l_factor = co_secs_per_day.
*     Fichte, 3.12.09 - End
    r_is_day_unit = abap_true.
    RETURN.
  ENDIF.
* ---------------------------------------------------------
ENDMETHOD.


METHOD read_time_units.

  SELECT * FROM v_t006_t INTO TABLE et_v_t006_t WHERE spras = sy-langu.

ENDMETHOD.
ENDCLASS.
