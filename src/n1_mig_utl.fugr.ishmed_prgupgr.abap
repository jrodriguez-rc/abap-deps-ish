FUNCTION ishmed_prgupgr.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(IT_MAP) TYPE  ISHMED_MIGTYP
*"     VALUE(I_TESTRUN) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_LOG) TYPE  ISH_ON_OFF DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_CORDERID) TYPE  N1CORDID
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     REFERENCE(ER_CORDER) TYPE REF TO  CL_ISH_CORDER
*"  CHANGING
*"     REFERENCE(CR_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"     REFERENCE(CR_ENVIRONMENT) TYPE REF TO  CL_ISH_ENVIRONMENT
*"       OPTIONAL
*"----------------------------------------------------------------------

* declerations ******************************************************
  DATA:   lr_corder        TYPE REF TO cl_ish_corder,
          lr_corderpos     TYPE REF TO cl_ishmed_prereg,
          my_n1corder      TYPE n1corder,
          my_n1vkg         TYPE n1vkg,
          my_psanfid       TYPE n1anf-anfid,
          my_returncode    TYPE inri-returncode,
          my_componentlist TYPE ish_t_component,
          my_compobject    TYPE REF TO if_ish_component,
          my_map           TYPE ishmed_migtyp,
          wa_map           LIKE LINE OF my_map,
          my_no_of_pos     TYPE i,
          my_pos           TYPE i,
          my_ino           TYPE i,
          my_file          TYPE string,
          my_result        TYPE string,
          my_outstring     TYPE string,
          my_more          TYPE string,
          my_logging       TYPE string VALUE 'no',
          fname TYPE string,
*       zu Konfigurieren:
*       Pseudoanf-ID anlegen? yes|no
          my_pseudoanf     TYPE string VALUE 'no',
*       Testrun? space | X (X=yes, space echt)
          my_testrun       TYPE ish_on_off VALUE ' ',
*       Sollen wir in ein File loggen? yes | no
          my_log           TYPE ish_on_off  VALUE ' '.
  DATA: mys_wtl_attributes TYPE rnwlm_attrib,
        mys_ins_attributes TYPE rnipp_attrib,
        mys_prc_attributes TYPE rnpcp_attrib,
        mys_dia_attributes TYPE rndip_attrib,
        mys_rad_attributes TYPE n1cpr,
        mys_tra_attributes TYPE n1ctr,
        mys_apco_attributes TYPE rn1apcn_x,
        lr_appc            TYPE REF TO cl_ish_app_constraint,
        my_absence         TYPE REF TO cl_ish_waiting_list_absence,
        my_insurance       TYPE REF TO cl_ish_insurance_policy_prov,
        my_procedure       TYPE REF TO cl_ish_prereg_procedure,
        my_diagnosis       TYPE REF TO cl_ish_prereg_diagnosis,
        my_radiology       TYPE REF TO cl_ishmed_radiology,
        my_transport       TYPE REF TO cl_ishmed_trans_order.

  FIELD-SYMBOLS: <ls_field_value>  TYPE rnfield_value,
                 <fst> TYPE ANY.
*********************************************************************

* Initializations.
  e_rc = 0.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
  CLEAR e_corderid.

  my_map     = it_map.
  my_testrun = i_testrun.
  my_log     = i_log.

* first we open a logfile, which can be created using ***************
* transaction FILE **************************************************
* to enable it, comment the following line **************************
  my_log = space.
*********************************************************************
  IF my_log EQ 'X'.
    CALL FUNCTION 'FILE_GET_NAME'
      EXPORTING
        logical_filename = 'ZTWMIGLOG'
      IMPORTING
        file_name        = my_file.
    OPEN DATASET my_file
            FOR APPENDING IN TEXT MODE ENCODING DEFAULT.
    IF sy-subrc = 0.
      my_logging = 'yes'.
    ENDIF.
  ENDIF.
* example syntax for writing to that file:
*concatenate sy-datum '--' sy-uzeit '--some text' into my_outstring.
*transfer my_outstring to my_file.
*********************************************************************

* create an environment for the Clinical Order **********************
  IF cr_environment IS INITIAL.
    CALL METHOD cl_ish_fac_environment=>create
      EXPORTING
        i_program_name = sy-repid
      IMPORTING
        e_instance     = cr_environment
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.
*********************************************************************

* preallocate general order data identified by @HEAD ****************
  LOOP AT my_map INTO wa_map WHERE posno  = 0 AND
                                    compid = '@HEAD'.
    CONCATENATE 'my_n1corder-' wa_map-fieldname INTO fname.
    ASSIGN (fname) TO <fst>.
    <fst> = wa_map-fvalue.
  ENDLOOP.
* preallocation finished ********************************************

* create an order object using the environment and prealloc. data ***
  CALL METHOD cl_ish_fac_corder=>create
    EXPORTING
      is_n1corder     = my_n1corder
      ir_environment  = cr_environment
    IMPORTING
      er_instance     = lr_corder
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
* Michael Manoch, 20040601, ID 14520   START
* ER* and UP* data should not be generated.
  CALL METHOD lr_corder->set_force_erup_data
    EXPORTING
      i_force_erup_data = space.
* Michael Manoch, 20040601, ID 14520   END
*********************************************************************
* preallocate waiting list absences WTLA, identified by @WTLA *******
* there are instno instances of WTLAs *******************************
  my_ino  = 1.
  my_more = 'yes'.
  WHILE my_more = 'yes'.
    CLEAR: wa_map,mys_wtl_attributes, my_absence.
    LOOP AT my_map INTO wa_map WHERE posno  = 0
                               AND   compid = '@WTLA'
                               AND   instno = my_ino.
      CONCATENATE 'mys_wtl_attributes-' wa_map-fieldname INTO fname.
      ASSIGN (fname) TO <fst>.
      <fst> = wa_map-fvalue.
    ENDLOOP.
*  ******************************************************************
*  create an instance of a WTLA... **********************************
    IF NOT mys_wtl_attributes IS INITIAL.
      CALL METHOD cl_ish_waiting_list_absence=>create
        EXPORTING
          is_data       = mys_wtl_attributes
          i_environment = cr_environment
        IMPORTING
          e_instance    = my_absence.
*    and connect it to the CORD *************************************
      CALL METHOD lr_corder->add_connection
        EXPORTING
          i_object = my_absence.
    ELSE.
      my_more = 'no'.
    ENDIF.
    my_ino = my_ino + 1.
  ENDWHILE.
  CHECK e_rc = 0.
* *******************************************************************
* preallocate insurance data INSP, identified by @INSP **************
* there are instno instances of INSPs *******************************
  my_ino  = 1.
  my_more = 'yes'.
  WHILE my_more = 'yes'.
    CLEAR: wa_map, mys_ins_attributes, my_insurance.
    LOOP AT my_map INTO wa_map WHERE posno  = 0
                               AND   compid = '@INSP'
                               AND   instno = my_ino.
      CONCATENATE 'mys_ins_attributes-' wa_map-fieldname INTO fname.
      ASSIGN (fname) TO <fst>.
      <fst> = wa_map-fvalue.
    ENDLOOP.
*  ******************************************************************
*  create an instance of an INSP... *********************************
    IF NOT mys_ins_attributes IS INITIAL.
      CALL METHOD cl_ish_insurance_policy_prov=>create
        EXPORTING
          is_data       = mys_ins_attributes
          i_environment = cr_environment
        IMPORTING
          e_instance    = my_insurance.
*    and connect it to the CORD *************************************
      CALL METHOD lr_corder->add_connection
        EXPORTING
          i_object = my_insurance.
    ELSE.
      my_more = 'no'.
    ENDIF.
    my_ino = my_ino + 1.
  ENDWHILE.
  CHECK e_rc = 0.
*********************************************************************
* preallocate procedures data PROC, identified by @PROC *************
* there are instno instances of PROCs *******************************
  my_ino  = 1.
  my_more = 'yes'.
  WHILE my_more = 'yes'.
    CLEAR: wa_map, mys_prc_attributes, my_procedure.
    LOOP AT my_map INTO wa_map WHERE posno  = 0
                               AND   compid = '@PROC'
                               AND   instno = my_ino.
      CONCATENATE 'mys_prc_attributes-' wa_map-fieldname INTO fname.
      ASSIGN (fname) TO <fst>.
      <fst> = wa_map-fvalue.
    ENDLOOP.
*  ******************************************************************
*  create an instance of a PROC... **********************************
    IF NOT mys_prc_attributes IS INITIAL.
      CALL METHOD cl_ish_prereg_procedure=>create
        EXPORTING
          is_data       = mys_prc_attributes
          i_environment = cr_environment
        IMPORTING
          e_instance    = my_procedure.
*    and connect it to the CORD *************************************
      CALL METHOD lr_corder->add_connection
        EXPORTING
          i_object = my_procedure.
    ELSE.
      my_more = 'no'.
    ENDIF.
    my_ino = my_ino + 1.
  ENDWHILE.
  CHECK e_rc = 0.
* Diagnosis objects have to be handled by the caller.
**********************************************************************
** preallocate diagnoses data DIAG, identified by @DIAG **************
** there are instno instances of DIAGs *******************************
*  my_ino  = 1.
*  my_more = 'yes'.
*  WHILE my_more = 'yes'.
*    CLEAR: wa_map, mys_dia_attributes, my_diagnosis.
*    LOOP AT my_map INTO wa_map WHERE posno  = 0
*                               AND   compid = '@DIAG'
*                               AND   instno = my_ino.
*      CONCATENATE 'mys_dia_attributes-' wa_map-fieldname INTO fname.
*      ASSIGN (fname) TO <fst>.
*      <fst> = wa_map-fvalue.
*    ENDLOOP.
**  ******************************************************************
**  create an instance of a DIAG... **********************************
*    IF NOT mys_dia_attributes IS INITIAL.
*      CALL METHOD cl_ish_prereg_diagnosis=>create
*        EXPORTING
*          is_data        = mys_dia_attributes
*          i_environment  = cr_environment
*        IMPORTING
*          e_instance     = my_diagnosis
*          e_rc           = e_rc
*        CHANGING
*          c_errorhandler = cr_errorhandler.
*      CHECK e_rc = 0.
**    and connect it to the CORD *************************************
*      CALL METHOD lr_corder->add_connection
*        EXPORTING
*          i_object = my_diagnosis.
*    ELSE.
*      my_more = 'no'.
*    ENDIF.
*    my_ino = my_ino + 1.
*  ENDWHILE.
*  CHECK e_rc = 0.
*********************************************************************
* how many positions (items) do we have in our map? *****************
  my_no_of_pos = -1.  "header = position 0 !!!
  LOOP AT my_map INTO wa_map.
    AT NEW posno.
      my_no_of_pos = my_no_of_pos + 1.
    ENDAT.
  ENDLOOP.
* *******************************************************************
* now we create the number of positions (items) found ***************
  DO my_no_of_pos TIMES.
    my_pos = sy-index.
* ...first we preallocate the position header, identified by @POSHEAD
    CLEAR my_n1vkg.
    LOOP AT my_map INTO wa_map WHERE posno  = my_pos AND
                                     compid = '@POSHEAD'.
      my_pseudoanf = 'no'.
      IF wa_map-fieldname EQ 'pseudoanf'.
*     identify the special field pseudoanf **************************
        my_pseudoanf = wa_map-fvalue.
      ELSE.
        CONCATENATE 'my_n1vkg-' wa_map-fieldname INTO fname.
        ASSIGN (fname) TO <fst>.
        <fst> = wa_map-fvalue.
      ENDIF.
    ENDLOOP.
* *******************************************************************
*   some order types require the field N1VKG-REQCOMPID to be filled *
*   with a number out of the number range of requests for           *
*   compatibility reasons with existing applications                *
    IF my_pseudoanf = 'yes'.
      CALL FUNCTION 'NUMBER_GET_NEXT'
        EXPORTING
          nr_range_nr             = '01'
          object                  = 'ISH_N1AFIT'
        IMPORTING
          number                  = my_psanfid
          returncode              = my_returncode
        EXCEPTIONS
          interval_not_found      = 1
          number_range_not_intern = 2
          object_not_found        = 3
          quantity_is_0           = 4
          quantity_is_not_1       = 5
          interval_overflow       = 6
          buffer_overflow         = 7
          OTHERS                  = 8.

      my_n1vkg-reqcompid = my_psanfid.
    ENDIF.
* *******************************************************************
* create order item object for order object *************************
    CALL METHOD lr_corder->add_new_cordpos
      EXPORTING
        is_n1vkg        = my_n1vkg
      IMPORTING
        e_rc            = e_rc
        er_cordpos      = lr_corderpos
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
* Michael Manoch, 20040601, ID 14520   START
* ER* and UP* data should not be generated.
    CALL METHOD lr_corderpos->set_force_erup_data
      EXPORTING
        i_force_erup_data = space.
* Michael Manoch, 20040601, ID 14520   END
* *******************************************************************
* first we preallocate the appointment constraint data, identified  *
* by @APCO                                                          *
    CLEAR: wa_map, mys_apco_attributes, lr_appc.
    LOOP AT my_map INTO wa_map WHERE posno  = my_pos
                               AND   compid = '@APCO'.
      CONCATENATE 'mys_apco_attributes-' wa_map-fieldname INTO fname.
      ASSIGN (fname) TO <fst>.
      <fst> = wa_map-fvalue.
      CONCATENATE 'mys_apco_attributes-'
                  wa_map-fieldname '_x' INTO fname.
      ASSIGN (fname) TO <fst>.
*     Käfer, ID: 15788 - Begin
*      <fst> = wa_map-fvalue.
      <fst> = 'X'.
*     Käfer, ID: 15788 - End
    ENDLOOP.
* *******************************************************************
* get the appointment constraint object *****************************
    CALL METHOD lr_corderpos->get_app_constraint
      EXPORTING
        ir_environment    = cr_environment
      IMPORTING
        er_app_constraint = lr_appc
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.

*   Käfer, ID: 15788 - Begin
    CALL METHOD lr_appc->set_force_erup_data
      EXPORTING
        i_force_erup_data = space.
*   Käfer, ID: 15788 - End

* *******************************************************************
* change it *********************************************************
    CALL METHOD lr_appc->change
      EXPORTING
        is_app_constraint = mys_apco_attributes
      IMPORTING
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.
* *******************************************************************

* preallocate radiology data, identified by @RADI *******************
    CLEAR: wa_map, mys_rad_attributes, my_radiology.
    LOOP AT my_map INTO wa_map WHERE posno  = my_pos
                               AND   compid = '@RADI'.
      CONCATENATE 'mys_rad_attributes-' wa_map-fieldname INTO fname.
      ASSIGN (fname) TO <fst>.
      <fst> = wa_map-fvalue.
    ENDLOOP.
* *******************************************************************
* create an instance of a radiology object **************************
    IF NOT mys_rad_attributes IS INITIAL.
      CALL METHOD cl_ishmed_radiology=>create
        EXPORTING
          is_n1cpr        = mys_rad_attributes
          ir_environment  = cr_environment
        IMPORTING
          er_instance     = my_radiology
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
*    ...connect it to the order item object *************************
      CALL METHOD lr_corderpos->add_connection
        EXPORTING
          i_object = my_radiology.
    ENDIF.
* *******************************************************************
* preallocation of transport order data, identified by @TRANS *******
    CLEAR: wa_map, mys_tra_attributes, my_transport.
    LOOP AT my_map INTO wa_map WHERE posno  = my_pos
                               AND   compid = '@TRAN'.
      CONCATENATE 'mys_tra_attributes-' wa_map-fieldname INTO fname.
      ASSIGN (fname) TO <fst>.
      <fst> = wa_map-fvalue.
    ENDLOOP.
* *******************************************************************
* create an instance of TRANS ***************************************
    IF NOT mys_tra_attributes IS INITIAL.
      CALL METHOD cl_ishmed_trans_order=>create
        EXPORTING
          is_n1ctr        = mys_tra_attributes
          ir_environment  = cr_environment
        IMPORTING
          er_instance     = my_transport
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      CHECK e_rc = 0.
*    ...connect it to the order item object *************************
      CALL METHOD lr_corderpos->add_connection
        EXPORTING
          i_object = my_transport.
    ENDIF.
* *******************************************************************

* get order item components *****************************************
    CALL METHOD lr_corderpos->get_t_comppos
      IMPORTING
        et_component    = my_componentlist
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.

*   Process position component's data.
    PERFORM process_components
      USING    my_map
               my_componentlist
               my_pos
      CHANGING e_rc
               cr_errorhandler.
    CHECK e_rc = 0.
  ENDDO.
  CHECK e_rc = 0.
*********************************************************************

* get the header components *****************************************
* !!! This has to happen here after order items have been created   *
* since header components result from order types !!!!!!!!!!!!!!! ***
  my_pos = 0.
  CLEAR my_componentlist.
  CALL METHOD lr_corder->get_t_comphead
    IMPORTING
      et_component    = my_componentlist
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* Process header component's data.
  PERFORM process_components
    USING    my_map
             my_componentlist
             my_pos
    CHANGING e_rc
             cr_errorhandler.
  CHECK e_rc = 0.

*********************************************************************
* save the Order and all connected objects **************************
  CALL METHOD lr_corder->save
    EXPORTING
      i_testrun           = my_testrun
      i_save_conn_objects = 'X'
      i_tcode             = sy-tcode
    IMPORTING
      e_rc                = e_rc
    CHANGING
      c_errorhandler      = cr_errorhandler.
  CHECK e_rc = 0.

* Save was succesful -> export the new corder + corderid.
  e_corderid = lr_corder->get_corderid( ).
  er_corder  = lr_corder.

* close Log-File ****************************************************
  IF my_logging EQ 'yes'.
    CLOSE DATASET my_file.
  ENDIF.
*********************************************************************




ENDFUNCTION.
