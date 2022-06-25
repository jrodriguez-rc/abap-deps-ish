class CL_ISH_UTL_BASE_CASE definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_UTL_BASE_CASE
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

  class-methods IS_MOV_PART_OF_CORD_OR_REQU
    importing
      !IR_MOVEMENT type ref to CL_ISHMED_MOVEMENT
    exporting
      value(E_IS_PART) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHECK_CASE
    importing
      value(I_EINRI) type EINRI
      value(I_FALNR) type NFAL-FALNR
      value(I_PATNR) type PATNR optional
      value(I_CHECK_CANCELLED) type ISH_ON_OFF default ON
      value(I_CHECK_COMPLETED) type ISH_ON_OFF default ON
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT optional
    exporting
      value(ES_NFAL) type NFAL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods CHECK_CASE_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      value(I_CHECK_COMPLETED) type ISH_ON_OFF optional
      value(I_READ_DB_CASE) type ISH_ON_OFF default SPACE
    exporting
      value(E_FALNR) type NFAL-FALNR
      value(ES_NFAL) type NFAL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods COMPARE_CASE_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
      !IR_OBJECT_COMPARATIVE type ref to IF_ISH_IDENTIFY_OBJECT
      !I_MSG type ISH_ON_OFF default ON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_CASE_OF_OBJ
    importing
      !IR_OBJECT type ref to IF_ISH_IDENTIFY_OBJECT
    exporting
      !E_FALNR type NFAL-FALNR
      !ES_NFAL type NFAL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_CHRON_FIRST_PLANABLE_MVMT
    importing
      !IT_MVMT type ISHMED_T_MOVEMENT
    exporting
      !ER_MVMT type ref to CL_ISHMED_MOVEMENT
      !ES_NBEW type NBEW
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class CL_ISHMED_MOVEMENT definition load .
  class-methods GET_CHRON_LAST_ACTUAL_MVMT
    importing
      !IT_MVMT type ISHMED_T_MOVEMENT
      !I_PLANB type PLANB default CL_ISHMED_MOVEMENT=>CO_PLANB_PLANNED
    exporting
      !ER_MVMT type ref to CL_ISHMED_MOVEMENT
      !ES_NBEW type NBEW
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods GET_FIRST_MOVEDATE_OF_CASE
    importing
      !I_EINRI type EINRI
      !I_FALNR type FALNR
    exporting
      !E_DATUM type DATUM
      !E_UZEIT type UZEIT .
  class-methods GET_LAST_MOVEDATE_OF_CASE
    importing
      !I_EINRI type EINRI
      !I_FALNR type FALNR
    exporting
      !E_DATUM type DATUM
      !E_UZEIT type UZEIT .
  class-methods GET_ACTUAL_OE
    importing
      !I_EINRI type EINRI
      !I_FALNR type FALNR
    exporting
      !E_ORGFA type NZUWFA
      !E_ORGPF type NZUWPF .
protected section.
*"* protected components of class CL_ISH_UTL_BASE_CASE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_BASE_CASE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_BASE_CASE IMPLEMENTATION.


METHOD CHECK_CASE .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_einri                 TYPE tn01-einri,
        l_patnr                 TYPE npat-patnr,
        l_tmp_patnr             TYPE npat-patnr,
        l_falnr                 TYPE nfal-falnr,
        l_tmp_falnr             TYPE nfal-falnr,
        l_fld_not_found         TYPE ish_on_off,
        l_cancelled             TYPE ish_on_off,
        l_cls_name              TYPE seoclass-clsname,
        ls_nfal                 TYPE nfal.
* object references
  DATA: lr_run                  TYPE REF TO cl_ish_run_data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: es_nfal.

* process method only if there is a case
  CHECK NOT i_einri IS INITIAL AND
        NOT i_falnr IS INITIAL.

* ----------
* get class name of object
  IF NOT ir_object IS INITIAL.
    l_cls_name = cl_ish_utl_rtti=>get_class_name( ir_object ).
  ENDIF.
* ---------- ---------- ----------

* JG 030805 14664/2
* first look if case is already on db, 230804
* .. check_case also called from cl_ish_appointment_simple - check
* case not yet on DB
  CALL FUNCTION 'ISH_READ_NFAL'
    EXPORTING
      ss_einri           = i_einri
      ss_falnr           = i_falnr
      ss_read_db         = on
      ss_check_auth      = off
      ss_message_no_auth = off
      ss_no_buffering    = on
    IMPORTING
      ss_nfal            = ls_nfal
    EXCEPTIONS
      not_found          = 1
      OTHERS             = 2.
*   if not already on db - check NPOL
  IF sy-subrc = 1.
* cancel-sign is not in NPOL
    CALL FUNCTION 'ISH_CASE_POOL_GET'
      EXPORTING
        ss_falnr     = i_falnr
        ss_einri     = i_einri
      IMPORTING
        ss_nfal_curr = ls_nfal.
  ENDIF.
*  IF sy-subrc <> 0.
  IF ls_nfal IS INITIAL.
*   JG 14664/2
    e_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1'
        i_num           = '034'
        i_mv1           = i_falnr
        i_mv2           = '(FALNR)'
        ir_object       = ir_object
      CHANGING
        cr_errorhandler = cr_errorhandler.
    EXIT.
  ENDIF.

* set exporting para
  es_nfal = ls_nfal.

* ---------- ---------- ----------
* check if case and patient fit together
  IF i_patnr IS SUPPLIED.
    IF ls_nfal-patnr <> i_patnr.
      e_rc = 152.
*     don't display leading zeros
      IF i_falnr CO ' 0123456789'.
        WRITE i_falnr TO l_tmp_falnr NO-ZERO.
      ENDIF.
      IF i_patnr CO ' 0123456789'.
        WRITE i_patnr TO l_tmp_patnr NO-ZERO.
      ENDIF.
*     &: Inkonsistenz zwischen Fall & und Patient &
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'NFCL'
          i_num           = '104'
          i_mv1           = l_cls_name
          i_mv2           = l_tmp_falnr
          i_mv3           = l_tmp_patnr
          ir_object       = ir_object
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

* ---------- ---------- ----------
* check if case is completed
  IF i_check_completed EQ on.
    IF ls_nfal-statu EQ 'E'.
      e_rc = 153.
*     don't display leading zeros
      IF i_falnr CO ' 0123456789'.
        WRITE i_falnr TO l_tmp_falnr NO-ZERO.
      ENDIF.
*     Fall ist bereits abgeschlossen: &
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1'
          i_num           = '722'
          i_mv1           = l_tmp_falnr
          i_mv2           = space
          ir_object       = ir_object
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

* ---------- ---------- ----------
* check if case is cancelled
  IF i_check_cancelled EQ on.
    IF ls_nfal-storn = on.
      e_rc = 154.
*     don't display leading zeros
      IF i_falnr CO ' 0123456789'.
        WRITE i_falnr TO l_tmp_falnr NO-ZERO.
      ENDIF.
*     Fall & & ist storniert
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1'
          i_num           = '026'
          i_mv1           = l_tmp_falnr
          i_mv2           = space
          ir_object       = ir_object
        CHANGING
          cr_errorhandler = cr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD CHECK_CASE_OF_OBJ .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_einri                 TYPE tn01-einri,
        l_patnr                 TYPE npat-patnr,
        l_tmp_patnr             TYPE npat-patnr,
        l_falnr                 TYPE nfal-falnr,
        l_tmp_falnr             TYPE nfal-falnr,
        l_fld_not_found         TYPE ish_on_off,
        l_cancelled             TYPE ish_on_off,
        l_cls_name              TYPE seoclass-clsname,
        l_check_cancelled       TYPE ish_on_off,
        ls_nfal                 TYPE nfal.
* object references
  DATA: lr_run                  TYPE REF TO cl_ish_run_data.
* ---------- ---------- ----------
* initialize
  CLEAR: e_falnr, es_nfal.
  e_rc = 0.
* ---------- ---------- ----------
* get institution of object
  l_einri = cl_ish_utl_base=>get_institution_of_obj( ir_object ).
* ----------
* get patient of object
  CALL METHOD cl_ish_utl_base_patient=>get_patient_of_obj
    EXPORTING
      ir_object       = ir_object
    IMPORTING
      e_patnr         = l_patnr
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ----------
* get case of object
  CALL METHOD cl_ish_utl_base_case=>get_case_of_obj
    EXPORTING
      ir_object       = ir_object
    IMPORTING
      e_falnr         = l_falnr
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.

* ----------
  l_check_cancelled = off.
* ---------- ---------- ----------
* check if main object is for run data
* ... then check if cancelled
  IF ir_object->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.

    lr_run ?= ir_object.
*   check if object is cancelled
    CALL METHOD lr_run->is_cancelled
      IMPORTING
        e_cancelled = l_cancelled.
*   ----------
*   only if object isn't cancelled it is necessary to check the
*   case canc
    IF l_cancelled EQ off.
      l_check_cancelled = on.
    ELSE.
      l_check_cancelled = off.
    ENDIF.
  ENDIF.

* call method to check casedata
* ----------
  CALL METHOD cl_ish_utl_base_case=>check_case
    EXPORTING
      i_einri           = l_einri
      i_falnr           = l_falnr
      i_patnr           = l_patnr
      i_check_cancelled = l_cancelled
      i_check_completed = i_check_completed
      ir_object         = ir_object
    IMPORTING
      es_nfal           = es_nfal
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.

  e_falnr = es_nfal-falnr.

ENDMETHOD.


METHOD COMPARE_CASE_OF_OBJ .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_falnr                 TYPE nfal-falnr,
        l_falnr_c               TYPE nfal-falnr,
        l_fld_not_found         TYPE ish_on_off,
        l_cls_name              TYPE seoclass-clsname,
        l_cls_name_c            TYPE seoclass-clsname,
        ls_nfal                 TYPE nfal.
* object references
  DATA: lr_run                  TYPE REF TO cl_ish_run_data,
        lr_run_c                TYPE REF TO cl_ish_run_data.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* check if main object is for run data
* ... then there is a method "get_data_field"
  IF ir_object->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
  lr_run ?= ir_object.
* ----------
  IF ir_object_comparative->is_inherited_from(
      cl_ish_run_data=>co_otype_run_data ) = off.
    EXIT.
  ENDIF.
*Sta/PN/18126pkt6/2005/09/27
*  lr_run_c ?= ir_object.
  lr_run_c ?= ir_object_comparative.
*End/PN/18126pkt6/2005/09/27
* ---------- ---------- ----------
* get case of object
  CALL METHOD lr_run->get_data_field
    EXPORTING
      i_fill          = off
      i_fieldname     = 'FALNR'
    IMPORTING
      e_rc            = l_rc
      e_field         = l_falnr
      e_fld_not_found = l_fld_not_found
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  CHECK l_fld_not_found = off.
* ----------
* get case for comparison
  CALL METHOD lr_run_c->get_data_field
    EXPORTING
      i_fill          = off
      i_fieldname     = 'FALNR'
    IMPORTING
      e_rc            = l_rc
      e_field         = l_falnr_c
      e_fld_not_found = l_fld_not_found
    CHANGING
      c_errorhandler  = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
  CHECK l_fld_not_found = off.
* ----------
* get class name of object
  l_cls_name   = cl_ish_utl_rtti=>get_class_name( lr_run ).
* get class name of object for comparison
  l_cls_name_c = cl_ish_utl_rtti=>get_class_name( lr_run_c ).
* ---------- ---------- ----------
  IF l_falnr <> l_falnr_c.
    e_rc = 150.
    IF i_msg = on. "PN/18126pkt6/2005/09/27
*   & &: Fallnummer passt nicht zu &
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'NFCL'
        i_num           = '263'
        i_mv1           = l_cls_name
        i_mv3           = l_cls_name_c
        ir_object       = ir_object
      CHANGING
        cr_errorhandler = cr_errorhandler.
    ENDIF. "PN/18126pkt6/2005/09/27
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_actual_oe.
***Bewegungstypen
*1  Aufnahme
*2  Entlassung
*3  Verlegung
*4  Ambulanter Besuch
*6  Abwesenheitsbeginn
*7  Abwesenheitsende
****Fallstatus
*E  Fall ist abgeschlossen
*I  Fall ist aktuell
*P  Fall ist im Planstatus

  DATA lt_nbew TYPE TABLE OF nbew.
  DATA ls_nbew TYPE nbew.
  DATA ls_nfal TYPE nfal.
  CLEAR: e_orgfa, e_orgpf.

  CALL FUNCTION 'ISH_READ_NFAL'
    EXPORTING
      ss_einri           = i_einri
      ss_falnr           = i_falnr
*     SS_READ_DB         = ' '
*     SS_CHECK_AUTH      = 'X'
*     SS_MESSAGE_NO_AUTH = 'X'
*     SS_NO_BUFFERING    = ' '
*     SS_CHECK_ARCHIVE   = ' '
    IMPORTING
      ss_nfal            = ls_nfal
*     SS_PATNR_ARCHIVE   =
    EXCEPTIONS
      not_found          = 1
      not_found_archived = 2
      no_authority       = 3
      OTHERS             = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
*Kein Fall da? also raus
    RETURN.
  ENDIF.

***Geplanter Fall können wir eh nicht weiter verarbeiten, weil es ja nur geplante Bewegungen gibt
  CHECK ls_nfal-statu NE 'P'.

  CALL FUNCTION 'ISH_NBEWTAB_READ'
    EXPORTING
      ss_einri      = i_einri
      ss_falnr      = i_falnr
      ss_read_db    = 'X'
*     SS_READ_STORN = ' '
    TABLES
      ss_nbewtab    = lt_nbew
    EXCEPTIONS
      not_found     = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    CLEAR: e_orgfa, e_orgpf.
    RETURN.
  ENDIF.

  SORT lt_nbew BY bwidt bwizt.

  READ TABLE lt_nbew WITH KEY bewty = '1' TRANSPORTING NO FIELDS.
  IF sy-subrc EQ 0.
****Aufnahme vorhanden, also Stationärer oder Teilstationärer Fall
*da wir ja schon nach Datum und Zeit sortiert haben einfach nur ein loop für Aufnahme, Verlegung und Entlassung (kann ja auch sein)
    LOOP AT lt_nbew INTO ls_nbew WHERE ( bewty = '1' OR bewty = '2' OR bewty = '3' ) AND  planb NE 'P'.
      e_orgfa = ls_nbew-orgfa.
      e_orgpf = ls_nbew-orgpf.
    ENDLOOP.

  ELSE.
****Keine Aufnahme, also Ambulanter Fall
**Bei Ambulanten fällen nehmen wir einfach den letzten Satz.
    SORT lt_nbew BY bwidt DESCENDING bwizt DESCENDING.
    LOOP AT lt_nbew INTO ls_nbew WHERE planb NE 'P'.
      e_orgfa = ls_nbew-orgfa.
      e_orgpf = ls_nbew-orgpf.
    ENDLOOP.
  ENDIF.

*  IF e_orgfa IS INITIAL AND e_orgpf IS INITIAL.
*
*  ENDIF.


ENDMETHOD.


METHOD GET_CASE_OF_OBJ .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_ishmed_auth           TYPE ish_on_off.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* check if IS-H*MED is active
  l_ishmed_auth = on.
  CALL FUNCTION 'ISHMED_AUTHORITY'
    EXPORTING
      i_msg            = off
    EXCEPTIONS
      ishmed_not_activ = 1
      OTHERS           = 2.
  IF sy-subrc <> 0.
    l_ishmed_auth = off.
  ENDIF.
* ---------- ---------- ----------
  IF l_ishmed_auth = on.
*   IS-H*MED is acitve; call correct method
    CALL METHOD cl_ishmed_ipl_utl_base=>get_case_of_obj_med
      EXPORTING
        ir_object       = ir_object
      IMPORTING
        e_falnr         = e_falnr
        es_nfal         = es_nfal
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ELSEIF l_ishmed_auth = off.
*   IS-H*MED is not active; call correct method
    CALL METHOD cl_ish_ipl_utl_base=>get_case_of_obj
      EXPORTING
        ir_object       = ir_object
      IMPORTING
        e_falnr         = e_falnr
        es_nfal         = es_nfal
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_chron_first_planable_mvmt.

  TYPES: BEGIN OF lty_mvmt,
           date        TYPE sy-datum,
           time        TYPE sy-uzeit,
           r_mvmt      TYPE REF TO cl_ishmed_movement,
           s_nbew      TYPE nbew,
         END OF lty_mvmt.

  DATA: ls_mvmt  TYPE lty_mvmt.
  DATA: lt_mvmt  TYPE STANDARD TABLE OF lty_mvmt.

  FIELD-SYMBOLS: <ls_mvmt>  TYPE lty_mvmt.

* Initializations.
  e_rc = 0.
  CLEAR: er_mvmt.

* Build the sorting table.
  LOOP AT it_mvmt INTO ls_mvmt-r_mvmt.
    CHECK ls_mvmt-r_mvmt IS BOUND.
    CALL METHOD ls_mvmt-r_mvmt->get_data
      EXPORTING
        i_fill_mvmt    = off
      IMPORTING
        e_rc           = e_rc
        e_nbew         = ls_mvmt-s_nbew
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    CHECK ls_mvmt-s_nbew-planb <> cl_ishmed_movement=>co_planb_actual.
    ls_mvmt-date = ls_mvmt-s_nbew-bwidt.
    ls_mvmt-time = ls_mvmt-s_nbew-bwizt.
    APPEND ls_mvmt TO lt_mvmt.
  ENDLOOP.
  CHECK e_rc = 0.

* Sort.
  SORT lt_mvmt BY date time.

* The first entry is the last actual movement.
  READ TABLE lt_mvmt INDEX 1 ASSIGNING <ls_mvmt>.
  CHECK sy-subrc = 0.

* Export.
  er_mvmt = <ls_mvmt>-r_mvmt.
  es_nbew = <ls_mvmt>-s_nbew.

ENDMETHOD.


METHOD get_chron_last_actual_mvmt.

  TYPES: BEGIN OF lty_mvmt,
           date        TYPE sy-datum,
           time        TYPE sy-uzeit,
           r_mvmt      TYPE REF TO cl_ishmed_movement,
           s_nbew      TYPE nbew,
         END OF lty_mvmt.

  DATA: ls_mvmt  TYPE lty_mvmt.
  DATA: lt_mvmt  TYPE STANDARD TABLE OF lty_mvmt.

  FIELD-SYMBOLS: <ls_mvmt>  TYPE lty_mvmt.

* Initializations.
  e_rc = 0.
  CLEAR: er_mvmt.

* Build the sorting table.
  LOOP AT it_mvmt INTO ls_mvmt-r_mvmt.
    CHECK ls_mvmt-r_mvmt IS BOUND.
    CALL METHOD ls_mvmt-r_mvmt->get_data
      EXPORTING
        i_fill_mvmt    = off
      IMPORTING
        e_rc           = e_rc
        e_nbew         = ls_mvmt-s_nbew
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    CHECK ls_mvmt-s_nbew-planb = cl_ishmed_movement=>co_planb_actual.
    ls_mvmt-date = ls_mvmt-s_nbew-bwidt.
    ls_mvmt-time = ls_mvmt-s_nbew-bwizt.
    APPEND ls_mvmt TO lt_mvmt.
  ENDLOOP.
  CHECK e_rc = 0.

* Sort.
  SORT lt_mvmt DESCENDING BY date time.

* The first entry is the last actual movement.
  READ TABLE lt_mvmt INDEX 1 ASSIGNING <ls_mvmt>.
  CHECK sy-subrc = 0.

* Export.
  er_mvmt = <ls_mvmt>-r_mvmt.
  es_nbew = <ls_mvmt>-s_nbew.

ENDMETHOD.


method GET_FIRST_MOVEDATE_OF_CASE.

  DATA lt_nbew TYPE TABLE OF nbew.
  DATA ls_nbew TYPE nbew.

  CLEAR: e_datum, e_uzeit.


  CALL FUNCTION 'ISH_NBEWTAB_READ'
    EXPORTING
      ss_einri      = i_einri
      ss_falnr      = i_falnr
      ss_read_db    = 'X'
*     SS_READ_STORN = ' '
    TABLES
      ss_nbewtab    = lt_nbew
    EXCEPTIONS
      not_found     = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  SORT lt_nbew BY bwidt bwizt.

  READ TABLE lt_nbew INTO ls_nbew INDEX 1.
  IF sy-subrc EQ 0.
    e_datum = ls_nbew-bwidt.
    e_uzeit = ls_nbew-bwizt.
  ENDIF.

endmethod.


method GET_LAST_MOVEDATE_OF_CASE.


  DATA lt_nbew TYPE TABLE OF nbew.
  DATA ls_nbew TYPE nbew.

  CLEAR: e_datum, e_uzeit.


  CALL FUNCTION 'ISH_NBEWTAB_READ'
    EXPORTING
      ss_einri      = i_einri
      ss_falnr      = i_falnr
      ss_read_db    = 'X'
*     SS_READ_STORN = ' '
    TABLES
      ss_nbewtab    = lt_nbew
    EXCEPTIONS
      not_found     = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  SORT lt_nbew BY bwidt DESCENDING bwizt DESCENDING.

  READ TABLE lt_nbew INTO ls_nbew INDEX 1.
  IF sy-subrc EQ 0.
    e_datum = ls_nbew-bwidt.
    e_uzeit = ls_nbew-bwizt.
  ENDIF.

***prüfen gibt es eine Entlassung?
  READ TABLE lt_nbew WITH KEY bewty = '2' TRANSPORTING NO FIELDS.
  IF sy-subrc NE 0.
***wenn es keine Entlasssung  gibt, dann ist der Fall offen oder ein ambulanter
***prüfen ob es eine Aufnahme gibt.
    READ TABLE lt_nbew WITH KEY bewty = '1' TRANSPORTING NO FIELDS.
    IF sy-subrc EQ 0.
**wenn Aufnahme da, dann scheint der fall noch offen zu sein. Das heisst er ist heute noch gültig
      e_datum = '99991231'.
      e_uzeit = '235959'.
**bei Ambulanten ist der oben übergeben Wert ja schon korrekt also raus hier!
    ENDIF.
  ENDIF.

endmethod.


METHOD is_mov_part_of_cord_or_requ.

* definitions
  DATA: l_rc               TYPE ish_method_rc.
* references
  DATA: lr_app_constr      TYPE REF TO cl_ish_app_constraint,
        lr_service         TYPE REF TO cl_ishmed_service,
        lr_request         TYPE REF TO cl_ishmed_request,
        lr_env             TYPE REF TO cl_ish_environment.
* local tables
  DATA: lt_services        TYPE ish_objectlist.
* work areas
  FIELD-SYMBOLS:
        <ls_services>      LIKE LINE OF lt_services.

* initialization
  CLEAR: e_rc.
  e_is_part = off.

* check input
  CHECK ir_movement IS BOUND.

* get app constraint
  CALL METHOD ir_movement->get_app_constraint
    IMPORTING
      e_rc              = e_rc
      er_app_constraint = lr_app_constr
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.
  IF lr_app_constr IS BOUND.
    e_is_part = on.
    RETURN.
  ENDIF.

* get services
  CALL METHOD cl_ishmed_outpat_visit_med=>get_services_for_movmnt
    EXPORTING
      ir_movement     = ir_movement
    IMPORTING
      e_rc            = e_rc
      et_services     = lt_services
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  LOOP AT lt_services ASSIGNING <ls_services>.
    CLEAR: lr_service, lr_request, lr_env.
    lr_service ?= <ls_services>-object.
    CALL METHOD lr_service->get_environment
      IMPORTING
        e_environment = lr_env.
    CALL METHOD cl_ishmed_service=>get_serv_for_anfo_vkg
      EXPORTING
        i_service      = lr_service
        i_environment  = lr_env
      IMPORTING
        e_rc           = l_rc
        e_request      = lr_request
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
    IF lr_request IS BOUND.
      e_is_part = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
