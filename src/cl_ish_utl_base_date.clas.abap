class CL_ISH_UTL_BASE_DATE definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_UTL_BASE_DATE
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

  constants CO_EMPTY_TIME type TIMS value '      '. "#EC NOTEXT

  class-methods FORMAT_DATE_TIME
    importing
      value(I_DATE) type SY-DATUM
      value(I_TIME) type SY-UZEIT default '      '
      value(I_LEN) type I
      value(I_CUT) type STRING
    exporting
      !E_TEXT type STRING .
  class-methods GET_DATE_FOR_WEEKDAYS
    importing
      value(I_FRDATE) type SY-DATUM
      value(I_MONDAY) type ISH_ON_OFF default ON
      value(I_TUESDAY) type ISH_ON_OFF default ON
      value(I_WEDNESDAY) type ISH_ON_OFF default ON
      value(I_THURSDAY) type ISH_ON_OFF default ON
      value(I_FRIDAY) type ISH_ON_OFF default ON
      value(I_SATURDAY) type ISH_ON_OFF default ON
      value(I_SUNDAY) type ISH_ON_OFF default ON
      value(I_NUMBER_OF_DAYS) type I
      value(I_SIGN_DAYS) type ISH_ON_OFF default '+'
    exporting
      value(ET_DATE) type ISHMED_T_DATE
      value(ERT_DATE) type ISHMED_T_RN1RANGE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DATE_FOR_WEEKDAYS_FIRST
    importing
      value(I_DAY1) type I default 0
      value(I_FRDATE) type SY-DATUM
      value(I_MONDAY) type ISH_ON_OFF default ON
      value(I_TUESDAY) type ISH_ON_OFF default ON
      value(I_WEDNESDAY) type ISH_ON_OFF default ON
      value(I_THURSDAY) type ISH_ON_OFF default ON
      value(I_FRIDAY) type ISH_ON_OFF default ON
      value(I_SATURDAY) type ISH_ON_OFF default ON
      value(I_SUNDAY) type ISH_ON_OFF default ON
      value(I_NUMBER_OF_DAYS) type I
      value(I_SIGN_DAYS) type ISH_ON_OFF default '+'
    exporting
      value(ET_DATE) type ISHMED_T_DATE
      value(ERT_DATE) type ISHMED_T_RN1RANGE
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_DAYS_OF_PERIOD
    importing
      value(I_DATE_FROM) type SY-DATUM
      value(I_DATE_TO) type SY-DATUM
    exporting
      value(ET_DAYS) type ISHMED_T_DATE .
protected section.
*"* protected components of class CL_ISH_UTL_BASE_DATE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_BASE_DATE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_BASE_DATE IMPLEMENTATION.


METHOD format_date_time.
  CONSTANTS: xdatfmdefault(10) TYPE c VALUE 'TT.MM.JJJJ'.
  STATICS:   udatfm(10)    TYPE  c VALUE '?'.
  DATA:      xdfies        TYPE TABLE OF dfies,
             xdd07v        TYPE  dd07v,
             xdomval       TYPE  dd07l-domvalue_l,
             xfmt(10)      TYPE  c,
             z(8)          TYPE  c,
             zl            TYPE  i,    " Zeitstring und -länge
             d(10)         TYPE  c,
             dl            TYPE  i,    " Datumstring und -länge
             c             TYPE  c,
             s(2)          TYPE  c,
             tl            TYPE  i,    " Länge des Gesamtstrings
             hl            TYPE  i,    " Hilfsvariable für Länge
             jofs          TYPE  i.
  DATA:      ls_usr01      TYPE  usr01,
             ls_xdfies     TYPE  dfies.

* Formatierung nur sinnvoll, wenn Datum angegeben ist.
  CHECK NOT i_date IS INITIAL AND
        NOT i_date =  '        '.
*
* 1. Aufruf: Datumsformat des Benutzers lesen
  IF udatfm = '?'.
    SELECT SINGLE * FROM usr01 INTO ls_usr01
      WHERE bname = sy-uname.
*   Domäne von USR01-DATFM ermitteln
    CALL FUNCTION 'DDIF_FIELDINFO_GET'
      EXPORTING
        tabname        = 'USR01'
        fieldname      = 'DATFM'
      TABLES
        dfies_tab      = xdfies
      EXCEPTIONS
        not_found      = 1
        internal_error = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      udatfm = xdatfmdefault.
    ELSE.
*     Datumsformat aus den Festwerten lesen
      xdomval = ls_usr01-datfm.
      READ TABLE xdfies INDEX 1 INTO ls_xdfies.
      IF sy-subrc <> 0.
        udatfm = xdatfmdefault.
      ELSE.
        CALL FUNCTION 'DD_DOMVALUE_TEXT_GET'
          EXPORTING
            domname  = ls_xdfies-domname
            value    = xdomval
            langu    = 'D'  "! Wichtig für J, kein Y
          IMPORTING
            dd07v_wa = xdd07v
          EXCEPTIONS
            OTHERS   = 1.
        IF sy-subrc <> 0.
          udatfm = xdatfmdefault.
        ELSE.
          udatfm = xdd07v-ddtext.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.
  IF udatfm CS 'J'.
    jofs = sy-fdpos.
  ENDIF.
*
  WRITE i_date TO d.                    " im Benutzerformat
  dl = STRLEN( d ).
  IF i_time = space.
    z = 'XX:XX:XX'.
  ELSE.
    WRITE i_time TO z USING EDIT MASK '__:__:__'.
  ENDIF.
  zl = STRLEN( z ).                    " HH:MM:SS
  tl = dl + zl + 1.
*
* Standardausgabe kürzen, wenn nötig.
  WHILE tl > i_len AND NOT i_cut IS INITIAL.
    c = i_cut(1).
    CASE c.
      WHEN 'J'.
        IF dl = 10.
          WRITE i_date TO d DD/MM/YY.   " kürzere Ausgabe
          tl = tl - 2.
          dl = dl - 2.
        ELSE.                          " Jahr weglassen
          IF jofs = 0.                 " jj.dd.mm
            SHIFT d LEFT BY 2 PLACES.  " jj.dd.mm -> .dd.mm
            dl = dl - 2.
            tl = tl - 2.
            IF d(1) CA './-'.                               "
              IF udatfm+8(2) = 'MM'.   " .dd.mm -> dd.mm.
                SHIFT d LEFT BY 1 PLACES CIRCULAR.
              ELSE.
                SHIFT d LEFT BY 1 PLACES." -dd-mm -> dd-mm
                dl = dl - 1.
                tl = tl - 1.
              ENDIF.
            ENDIF.
          ELSE.                        " dd.mm.jj
            dl = dl - 2.
            tl = tl - 2.
            d = d(dl).                 " dd.mm.jj -> dd.mm.
*           Format ohne Punkt? -> letzten Char weglassen
            hl = dl - 1.
            IF d+hl(1) NA '0123456789.'.
              d  = d(hl).
              dl = dl - 1.
              tl = tl - 1.
            ENDIF.
          ENDIF.
        ENDIF.
      WHEN 'S'.
        zl = zl - 3. z = z(zl).        " Sekunden weglassen
        tl = tl - 3.
      WHEN 'M'.
        zl = zl - 3. z = z(zl).        " Minuten weglassen
        tl = tl - 3.
      WHEN 'H'.                        " Stunden weglassen
        IF zl > 2.
          zl = zl - 3. SHIFT z LEFT BY 3 PLACES. tl = tl - 3.
        ELSE.
          zl = 0. CLEAR z. tl = tl - 2.
        ENDIF.
*       Zeit weggekürzt? -> auf Space zwischen Datum und Zeit verzichten
        hl = STRLEN( z ).
        IF hl = 0. tl = tl - 1. ENDIF.
      WHEN OTHERS.
    ENDCASE.
    SHIFT i_cut LEFT BY 1 PLACES.
  ENDWHILE.
* String zusammenbauen, X in der Zeit gegen Blank tauschen
  IF z CO 'X: '.
    CLEAR z.
  ELSE.
    TRANSLATE z USING 'X '.
  ENDIF.
  CONCATENATE d z INTO e_text SEPARATED BY space.

ENDMETHOD.


METHOD GET_DATE_FOR_WEEKDAYS .

* local tables
  DATA: lt_date                 TYPE ishmed_t_date.
* workareas
  FIELD-SYMBOLS:
        <ls_date>               LIKE LINE OF lt_date.
  DATA: lrs_date                LIKE LINE OF ert_date.
* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_date                  TYPE sy-datum,
        l_cnt                   TYPE i,
        l_ok                    TYPE ish_on_off,
        l_day                   TYPE scal-indicator.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  CLEAR: et_date, ert_date.
  IF i_sign_days <> '+' AND
     i_sign_days <> '-'.
    i_sign_days = '+'.
  ENDIF.
* ---------- ---------- ----------
  CHECK NOT i_frdate IS INITIAL.
* ---------- ---------- ----------
  l_date = i_frdate.
  l_cnt  = 1.
* ---------- ---------- ----------
  WHILE l_cnt <= i_number_of_days.
*   ----------
    CLEAR: l_day, l_ok.
*   ----------
*   get day for date
    CALL FUNCTION 'DATE_COMPUTE_DAY'
      EXPORTING
        date = l_date
      IMPORTING
        day  = l_day.
*   ----------
    CASE l_day.
      WHEN 1.
        IF i_monday = on.
          l_ok = on.
        ENDIF.
      WHEN 2.
        IF i_tuesday = on.
          l_ok = on.
        ENDIF.
      WHEN 3.
        IF i_wednesday = on.
          l_ok = on.
        ENDIF.
      WHEN 4.
        IF i_thursday = on.
          l_ok = on.
        ENDIF.
      WHEN 5.
        IF i_friday = on.
          l_ok = on.
        ENDIF.
      WHEN 6.
        IF i_saturday = on.
          l_ok = on.
        ENDIF.
      WHEN 7.
        IF i_sunday = on.
          l_ok = on.
        ENDIF.
    ENDCASE.
*   ----------
*   day is desired
    IF l_ok = on.
      INSERT l_date INTO TABLE lt_date.
      l_cnt = l_cnt + 1.
    ENDIF.
*   ----------
*   check next date
    IF i_sign_days = '+'.
      l_date = l_date + 1.
    ELSE.
      l_date = l_date - 1.
    ENDIF.
*   ----------
  ENDWHILE.

* fill range table and
* return values
  LOOP AT lt_date ASSIGNING <ls_date>.
    CLEAR: lrs_date.
    lrs_date-sign    =  'I'.
    lrs_date-option  =  'EQ'.
    lrs_date-low     =  <ls_date>.
    INSERT lrs_date INTO TABLE ert_date.
  ENDLOOP.
* ---------- ----------
  et_date   =  lt_date.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_date_for_weekdays_first .

* local tables
  DATA: lt_date                 TYPE ishmed_t_date.
* workareas
  FIELD-SYMBOLS:
        <ls_date>               LIKE LINE OF lt_date.
  DATA: lrs_date                LIKE LINE OF ert_date.
* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_date                  TYPE sy-datum,
        l_cnt                   TYPE i,
        l_ok                    TYPE ish_on_off,
        l_sign_days             TYPE ish_on_off,
        l_monday                TYPE ish_on_off,
        l_tuesday               TYPE ish_on_off,
        l_wednesday             TYPE ish_on_off,
        l_thursday              TYPE ish_on_off,
        l_friday                TYPE ish_on_off,
        l_saturday              TYPE ish_on_off,
        l_sunday                TYPE ish_on_off,
        l_day                   TYPE scal-indicator.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  CLEAR: et_date, ert_date.
  IF i_sign_days <> '+' AND
     i_sign_days <> '-' AND
     i_sign_days <> '*'.
    i_sign_days = '*'.
  ENDIF.
* ---------- ---------- ----------
  CHECK NOT i_frdate IS INITIAL.
* ---------- ---------- ----------
  l_date = i_frdate.
*Sta/PN/MED-31112/2007/09/04
*Sta/PN/MED-33693/2009/02/11
* Get next visible date
  IF i_day1 = 0.
    IF i_sign_days = '*'.
      l_sign_days = '+'.
    ELSE.
      l_sign_days = i_sign_days.
    ENDIF.
    CALL METHOD cl_ish_utl_base_date=>get_date_for_weekdays
      EXPORTING
        i_frdate         = l_date
        i_monday         = i_monday
        i_tuesday        = i_tuesday
        i_wednesday      = i_wednesday
        i_thursday       = i_thursday
        i_friday         = i_friday
        i_saturday       = i_saturday
        i_sunday         = i_sunday
        i_number_of_days = 1
        i_sign_days      = l_sign_days
      IMPORTING
        et_date          = lt_date
*      ERT_DATE         =
        e_rc             = l_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
  ELSE.
* Get first day
    CASE i_day1.
      WHEN 1.
        l_monday = on.
      WHEN 2.
        l_tuesday = on.
      WHEN 3.
        l_wednesday = on.
      WHEN 4.
        l_thursday = on.
      WHEN 5.
        l_friday = on.
      WHEN 6.
        l_saturday = on.
      WHEN 7.
        l_sunday = on.
    ENDCASE.
    IF i_sign_days = '*'.
      CALL METHOD cl_ish_utl_base_date=>get_date_for_weekdays
        EXPORTING
          i_frdate         = i_frdate
          i_monday         = i_monday
          i_tuesday        = i_tuesday
          i_wednesday      = i_wednesday
          i_thursday       = i_thursday
          i_friday         = i_friday
          i_saturday       = i_saturday
          i_sunday         = i_sunday
          i_number_of_days = 1
          i_sign_days      = '+'
        IMPORTING
          et_date          = lt_date
*      ERT_DATE         =
          e_rc             = l_rc
        CHANGING
          cr_errorhandler  = cr_errorhandler.
      SORT lt_date.
      READ TABLE lt_date INTO l_date INDEX 1.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
    ENDIF.
    IF i_sign_days = '*' OR
       i_sign_days = '-'.
      l_sign_days = '-'.
    ELSE.
      l_sign_days = '+'.
    ENDIF.
    CLEAR lt_date.
    CALL METHOD cl_ish_utl_base_date=>get_date_for_weekdays
      EXPORTING
        i_frdate         = l_date
        i_monday         = l_monday
        i_tuesday        = l_tuesday
        i_wednesday      = l_wednesday
        i_thursday       = l_thursday
        i_friday         = l_friday
        i_saturday       = l_saturday
        i_sunday         = l_sunday
        i_number_of_days = 1
        i_sign_days      = l_sign_days
      IMPORTING
        et_date          = lt_date
*      ERT_DATE         =
        e_rc             = l_rc
      CHANGING
        cr_errorhandler  = cr_errorhandler.
  ENDIF.

  SORT lt_date.
  READ TABLE lt_date INTO l_date INDEX 1.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.

* Get i_number_of_days days
  CALL METHOD cl_ish_utl_base_date=>get_date_for_weekdays
    EXPORTING
      i_frdate         = l_date
      i_monday         = i_monday
      i_tuesday        = i_tuesday
      i_wednesday      = i_wednesday
      i_thursday       = i_thursday
      i_friday         = i_friday
      i_saturday       = i_saturday
      i_sunday         = i_sunday
      i_number_of_days = i_number_of_days
      i_sign_days      = '+'
    IMPORTING
      et_date          = et_date
      ert_date         = ert_date
      e_rc             = e_rc
    CHANGING
      cr_errorhandler  = cr_errorhandler.
*End/PN/MED-33693/2009/02/11

*Sta/PN/MED-33693/2009/02/11
*  IF i_day1 > 0.
*    IF i_sign_days = '*' OR i_sign_days = '-'.
*      l_sign_days = '-'.
*    ELSE.
*      l_sign_days = '+'.
*    ENDIF.
*    CASE i_day1.
*      WHEN 1.
*        l_monday = on.
*      WHEN 2.
*        l_tuesday = on.
*      WHEN 3.
*        l_wednesday = on.
*      WHEN 4.
*        l_thursday = on.
*      WHEN 5.
*        l_friday = on.
*      WHEN 6.
*        l_saturday = on.
*      WHEN 7.
*        l_sunday = on.
*    ENDCASE.
*    CALL METHOD cl_ish_utl_base_date=>get_date_for_weekdays
*      EXPORTING
*        i_frdate         = l_date
*        i_monday         = l_monday
*        i_tuesday        = l_tuesday
*        i_wednesday      = l_wednesday
*        i_thursday       = l_thursday
*        i_friday         = l_friday
*        i_saturday       = l_saturday
*        i_sunday         = l_sunday
*        i_number_of_days = 1
*        i_sign_days      = l_sign_days
*      IMPORTING
*        et_date          = lt_date
*        e_rc             = l_rc
*      CHANGING
*        cr_errorhandler  = cr_errorhandler.
*
*    SORT lt_date.
*    READ TABLE lt_date INTO l_date INDEX 1.
*
*    l_sign_days = '+'.
*  ENDIF.
*
** Get i_number_of_days days
*  CALL METHOD cl_ish_utl_base_date=>get_date_for_weekdays
*    EXPORTING
*      i_frdate         = l_date
*      i_monday         = i_monday
*      i_tuesday        = i_tuesday
*      i_wednesday      = i_wednesday
*      i_thursday       = i_thursday
*      i_friday         = i_friday
*      i_saturday       = i_saturday
*      i_sunday         = i_sunday
*      i_number_of_days = i_number_of_days
*      i_sign_days      = l_sign_days
*    IMPORTING
*      et_date          = et_date
*      ert_date         = ert_date
*      e_rc             = e_rc
*    CHANGING
*      cr_errorhandler  = cr_errorhandler.
*End/PN/MED-33693/2009/02/11
*End/PN/MED-31112/2007/09/04

ENDMETHOD.


METHOD GET_DAYS_OF_PERIOD .

* definitions
  DATA: l_date_from          TYPE sy-datum,
        l_date_to            TYPE sy-datum.
* ---------- ---------- ----------
* initialize
  CLEAR: et_days[].
* ---------- ---------- ----------
  l_date_from   =  i_date_from.
  l_date_to     =  i_date_to.
* ---------- ---------- ----------
  WHILE l_date_from <= l_date_to.
    INSERT l_date_from INTO TABLE et_days.
    l_date_from = l_date_from + 1.
  ENDWHILE.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
