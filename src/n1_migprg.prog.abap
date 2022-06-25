*&---------------------------------------------------------------------*
*& Report  N1_MIGPRG                                                   *
*& TW 17/03/04                                                         *
*&---------------------------------------------------------------------*
*& This report is part of the upgrade programs to migrate              *
*& preregistration related data of IS-H/IS-H*MED releases < 4.72       *
*& to the new Clinical Order(CORD) for release 4.72.                   *
*& This report migrates the existing preregistrations into Clinical    *
*& Orders. Depending on the order type the original preregistration    *
*& type has been migrated to, the preregistration is converted to an   *
*& order with one or two order items, an admission item and/or a treat-*
*& ment item.                                                          *
*& Existing related objects are converted to new related objects, parts*
*& of the original preregistration are converted to new objects in the *
*& Clinical Order framework.                                           *
*& Data of the original preregistration is split into the header table *
*& N1CORDER as well as the position table(s) N1VKG.                    *
*& Two related objects, appointments and services, are not copied but  *
*& their relation is updated for the new Clinical Order                *
*&---------------------------------------------------------------------*
*& 19/01/04: appointment constraint data preallocation included        *
*& 23/03/04: exclude cancelled source (preregs)                        *
*& --------------------------------------------------------------------*
*& !!!!!!!!!!!!!!!!!!!!!!!IMPORTANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! *
*& 18/02/04: CLIENT SPECIFICATION removed; report has to be run after  *
*& the XPRA for every client which has to be migrated;                 *
*& Reason: for the sake of consistent order data to be created, we make*
*& use of a number of data objects and services from SAP basis upwards.*
*& Most of these data objects and services cannot be called CLIENT     *
*& SPECIFIED since they simply don't support it. Therefore this report *
*& has to be run in every client manually.                             *
*& - oldstyle flag added					       *
*&---------------------------------------------------------------------*
*& appended fields: as of 09/03/04 assigned to N1CORDER                *
*&---------------------------------------------------------------------*
*& Messages:                                                           *
*&  010: -=========== Starting Report & on & at & ===========-         *
*&  011: -=========== Finished Report & on & at & ===========-         *
*&  012: The source prereg is cancelled and not migrated.              *
*&  024: Error in prereg ID & &.                                       *
*&  025: Converted & (of &) preregistrations in & seconds.             *
*&  026: Unknown Error. Sorry.                                         *
*&---------------------------------------------------------------------*
*& Parameter Usage:                                                    *
*&   VKGIDIN    enter the ID of the prereg to be migrated              *
*&   VKGIDMX    all preregs with VKGIDIN <= ID <= VKGIDMX are migrated *
*&   TESTONLY   testrun the migration only                             *
*&   ALLVKGS    migrate all preregs                                    *
*&   SHSTORN    show cancelled preregs                                 *
*&---------------------------------------------------------------------*

REPORT  n1_migprg MESSAGE-ID n1base.

DATA: my_map               TYPE ishmed_migtyp,
      l_comp_map           LIKE LINE OF my_map,
      t_old_n1vkg          TYPE TABLE OF n1vkg,
      l_old_n1vkg          LIKE LINE OF t_old_n1vkg,
      my_n1vkg             TYPE n1vkg,
      my_corderid          TYPE n1cordid,
      my_rc                TYPE ish_method_rc,
      my_errorhandler      TYPE REF TO cl_ishmed_errorhandling,
      my_cordtid_adm       TYPE n1cordtyp-cordtypid,
      my_cordtid_tre       TYPE n1cordtyp-cordtypid,
      my_further_relations TYPE string,
      my_apcnid            TYPE n1apcn-apcnid,
       BEGIN OF my_vk,
         vkgid             TYPE n1vkg-vkgid,
       END OF my_vk,
      my_vkgid             LIKE TABLE OF my_vk,
      my_anfid             TYPE n1anf-anfid,
      myt_anfid            LIKE TABLE OF my_anfid,
      my_count             TYPE i,
      t1                   TYPE f,
      t2                   TYPE f,
      dt                   TYPE f,
      my_posno             TYPE i,
      my_cursor            TYPE cursor,
      myt_n1vkg            TYPE TABLE OF n1vkg,
      myl_n1vkg            LIKE LINE OF myt_n1vkg,
      BEGIN OF my_ntm,
        tmnid              TYPE ntmn-tmnid,
        vkgid              TYPE n1vkg-vkgid,
        tmnoe              TYPE ntmn-tmnoe,    "Käfer, ID: 14520 150704
        storn              TYPE ntmn-storn,    "Käfer, ID: 14520 150704
        falnr              TYPE ntmn-falnr,                 "MED-09725
      END OF my_ntm,
      my_ntmn              LIKE TABLE OF my_ntm,
      myt_dum_tmnid        LIKE TABLE OF my_ntm,
      myl_dum_tmnid        LIKE LINE OF myt_dum_tmnid,
      BEGIN OF myl_nlem,
        lnrls              TYPE nlem-lnrls,
        vkgid              TYPE n1vkg-vkgid,
        anfid              TYPE n1anf-anfid,
      END OF myl_nlem,
      my_nlem              LIKE TABLE OF myl_nlem,
      my_new_vkgid         TYPE n1vkg-vkgid,
      my_tre_required      TYPE ish_on_off,
      my_adm_required      TYPE ish_on_off,
      my_more              TYPE ish_on_off,
      mys_wtl_atributes    TYPE rnwlm_attrib,
      mys_ins_attributes   TYPE rnipp_attrib,
      my_environment       TYPE REF TO cl_ish_environment,
      my_environment1      TYPE REF TO cl_ish_environment,
      my_absence           TYPE REF TO cl_ish_waiting_list_absence,
      my_insurance         TYPE REF TO cl_ish_insurance_policy_prov,
      my_corder            TYPE REF TO cl_ish_corder,
      my_corderpos         TYPE REF TO cl_ishmed_prereg,
      my_prereg            TYPE REF TO cl_ishmed_prereg,
      my_service           TYPE REF TO cl_ishmed_service,
      my_appcon            TYPE REF TO cl_ish_app_constraint,
      my_lnrls             TYPE nlem-lnrls,
      myt_cordpos          TYPE ish_t_cordpos,
      myl_cordpos          LIKE LINE OF myt_cordpos,
      my_stat              TYPE n1lsstae,
      mys_service          TYPE rn1med_service,

      my_tmnid             TYPE ntmn-tmnid,
      my_appointment       TYPE REF TO cl_ish_appointment,
      mys_appointment      TYPE rntmnx,
      my_cordtyp           TYPE REF TO cl_ish_cordtyp,
      my_cordtypid         TYPE n1cordtyp-cordtypid,
      my_vkg               TYPE REF TO cl_ishmed_prereg,
      myt_context          TYPE ish_objectlist,
      myl_context          TYPE ish_object,
      myt_contor           TYPE ish_objectlist,
      myl_contor           TYPE ish_object,
      myt_conttr           TYPE ish_objectlist,
      myl_conttr           TYPE ish_object,
      myt_objects          TYPE ish_objectlist,
      myl_objects          TYPE ish_object,

      my_context           TYPE REF TO cl_ish_context,
      my_contor            TYPE REF TO cl_ish_context_object,
      mys_context          TYPE nctx,
      mys_contor           TYPE ncto,

      my_new_context       TYPE REF TO cl_ish_context,
      my_req_context       TYPE REF TO cl_ish_context,
      my_new_object        TYPE REF TO object,
      my_rncto             TYPE rncto_restricted,

      my_useless_nctx      TYPE nctx,
      my_reqnctx           TYPE nctx,

      str_trigger          TYPE string,
      my_tline             TYPE ish_t_textmodule_tline,
      BEGIN OF myl_lttypes,
        oldid              TYPE ish_textmodule_id,
        newid              TYPE ish_textmodule_id,
      END OF myl_lttypes,
      my_lttypes           LIKE TABLE OF myl_lttypes,

      my_cordposid         TYPE n1vkg-vkgid,
      my_request           TYPE REF TO cl_ishmed_request,
      my_wtla              TYPE REF TO cl_ish_waiting_list_absence,
      myl_nwlm             TYPE rnwlm_attrib,
      myt_nwlm             TYPE TABLE OF rnwlm_attrib,
      myl_npcp             TYPE rnpcp_attrib,
      myt_npcp             TYPE TABLE OF rnpcp_attrib,
      my_proced            TYPE REF TO cl_ish_prereg_procedure,
      myl_nipp             TYPE rnipp_attrib,
      myt_nipp             TYPE TABLE OF rnipp_attrib,
      my_insp              TYPE REF TO cl_ish_insurance_policy_prov,
      my_instno            TYPE i,
      my_dummy_srv         TYPE nlei-leist,
      myt_n1vkgnd          TYPE n1vkg,
      myt_ndip             TYPE ish_t_vndip,
      myl_ndip             LIKE LINE OF myt_ndip,
      my_diag_data         TYPE rndip_attrib,
      my_diagnosis         TYPE REF TO cl_ish_prereg_diagnosis,
      my_tid               TYPE ish_textmodule_id,
      myt_dfies            TYPE TABLE OF dfies,
      myl_dfies            LIKE LINE OF myt_dfies,
      myl_x03              TYPE x030l,
      my_appfcount         TYPE i,
      my_df_count          TYPE i,
      singvkg              TYPE n1vkg-vkgid,
      minvkg               TYPE n1vkg-vkgid,
      maxvkg               TYPE n1vkg-vkgid,
      my_scr_order         TYPE REF TO cl_ish_scr_order,
      fname                TYPE string,
      myt_serv_lnrls       TYPE TABLE OF nlem-lnrls,
      myl_serv_lnrls       TYPE nlem-lnrls,
      myt_norg             TYPE TABLE OF norg,
      myl_norg             LIKE LINE OF myt_norg,
      testx                TYPE ish_on_off,
      my_checkmark         TYPE ish_on_off,
      my_convcount         TYPE i.

DATA: l_max_vkgid  TYPE n1vkg-vkgid,
      l_vkgid_from TYPE n1vkg-vkgid,
      l_vkgid_to   TYPE n1vkg-vkgid,
      l_vkgid_last TYPE n1vkg-vkgid,
      l_first_time TYPE ish_on_off.
DATA: lt_cordpos  TYPE ish_t_cordpos,
      lr_cordpos  TYPE REF TO cl_ishmed_prereg,
      ls_n1vkg    TYPE n1vkg,
      lr_ac       TYPE REF TO cl_ish_app_constraint,
      ls_n1apcn   TYPE n1apcn,
      lt_app      TYPE ishmed_t_appointment_object,
      lr_app      TYPE REF TO cl_ish_appointment,
      ls_ntmn     TYPE ntmn,
      lt_lfdbew   TYPE TABLE OF nbew-lfdnr,
      l_lfdbew    TYPE nbew-lfdnr,
      lt_vnlei    TYPE ishmed_t_vnlei,
      l_string    TYPE string.

DATA: lt_env_objectlist TYPE ish_objectlist,
      lr_data_object    TYPE REF TO if_ish_data_object.

DATA: ls_ntmn_adm      LIKE my_ntm,          "Käfer, ID: 14520 15072004
*      ls_ntmn_adm      TYPE ntmn,           "Käfer, ID: 14520 15072004
      lr_cordtyp_adm   TYPE REF TO cl_ish_cordtyp.

* Käfer, ID: 14520 180604 - Begin
DATA:  lt_temp_lnrls   TYPE TABLE OF nlem-lnrls,
       ll_temp_lnrls   LIKE LINE OF lt_temp_lnrls.
* Käfer, ID: 14520 180604 - End

* Käfer, ID: 14520 07072004 - Begin
DATA:  l_is_op     TYPE ish_on_off,
       l_count     TYPE i,
       l_lrnls     TYPE nlei-lnrls,
       l_min_vkgid TYPE n1vkg-vkgid.

* Begin Grill - MED-31571
DATA: l_format_exist TYPE ish_on_off,
      ls_tline       TYPE tline.

FIELD-SYMBOLS: <ls_tline> TYPE tline.
* End   Grill - MED-31571

FIELD-SYMBOLS: <ls_ntmn>        LIKE my_ntm.
* Käfer, ID: 14520 07072004 - End

FIELD-SYMBOLS: <l_lfdbew>       TYPE nbew-lfdnr,
               <ls_vnlei>       TYPE vnlei,
               <ls_env_object>  TYPE ish_object.

DATA: BEGIN OF myt_iprot OCCURS 0.
        INCLUDE STRUCTURE sprot_u.
DATA: END OF myt_iprot.


FIELD-SYMBOLS:
               <fst> TYPE any.

PARAMETERS: vkgidin        TYPE n1vkg-vkgid,
            vkgidmx        TYPE n1vkg-vkgid,
            testonly       TYPE ish_on_off DEFAULT 'X',
            allvkgs        TYPE ish_on_off,
            shstorn        TYPE ish_on_off DEFAULT 'X'.

* first let's see what the user wants us to do **********************
*   - if she enters a value into vkgidin and none into vkgidmx, we **
*     migrate a single prereg
*   - if she enters a value into vkgidmx and none into vkgidin, we **
*     migrate all preregs up to the vkgid given
*   - if she enters a value into vkgidin and one into vkgidmx, we ***
*     migrate all preregs with vkgids between the two given
*   - testonly checked means - well - checkonly                   ***
*   - allvkgs checked means all preregs are migrated regardless of  *
*     any values in vkgidin and vkgidmx
CLEAR: singvkg, testx, minvkg, maxvkg.
testx = ''.
* Käfer, ID: 17083 - Begin
*IF vkgidin GT '0' AND vkgidmx LE '0'.
IF ( vkgidin GT '0' AND vkgidmx LE '0' ) OR
   ( vkgidin GT '0' AND vkgidin = vkgidmx ).
* Käfer, ID: 17083 - End
  singvkg = vkgidin.                           "single
ELSEIF vkgidmx GT '0' AND vkgidin GT '0' AND vkgidmx GT vkgidin.
  minvkg = vkgidin.
  maxvkg = vkgidmx.                            "range
ELSEIF vkgidmx GT '0' AND vkgidin LE '0'.
  minvkg = '00000001'.
  maxvkg = vkgidmx.                            "range
* Käfer, ID: 14520 05072004 - Begin
*ELSE.
ELSEIF vkgidin LE '0' AND vkgidmx LE '0' AND allvkgs EQ space.
* Käfer, ID: 14520 05072004 - End
  MESSAGE s100(n1) WITH 'range not useful'.                 "ID 15283
* WRITE:/ 'range not useful'.                                 "ID 15283
  EXIT.
ENDIF.
IF allvkgs EQ 'X'.
  minvkg = '00000001'.
  maxvkg = '99999999'.
* Käfer, ID: 14520 05072004 - Begin
* if allvkgs is checked and a single vkgid was entered by the user
* ignore this single vkgid
  CLEAR singvkg.
* Käfer, ID: 14520 05072004 - End
ENDIF.                                         "range
IF testonly EQ 'X'.
  testx = 'X'.
ENDIF.
*********************************************************************

* !!!!!!!!! SECURITY!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*testx = 'X'.
* !!!!!!!!! SECURITY end. remove the line above later. it's only
* here to make sure nobody hits f8 accidentally and migrates the
* whole system !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

*********************************************************************
* log the start of this program *************************************
PERFORM proto USING
          4 space 'N1BASE' '110' sy-repid sy-datum sy-uzeit space.
*********************************************************************

* in testing mode runtime is measured *******************************
IF testx EQ 'X'.
  SET RUN TIME CLOCK RESOLUTION HIGH.
  GET RUN TIME FIELD t1.
ENDIF.
* *******************************************************************

* we need a description of table N1VKG ******************************
CALL FUNCTION 'DDIF_FIELDINFO_GET'
  EXPORTING
    tabname   = 'N1VKG'
  IMPORTING
    x030l_wa  = myl_x03
  TABLES
    dfies_tab = myt_dfies.
* *******************************************************************

* Michael Manoch, 02.06.2004   START
* Do not use a cursor.
** first we define a cursor for our preregs to migrate ***************
*CLEAR my_cursor.
** we check if we have a single vkgid to migrate, else we migrate all
*
*IF NOT singvkg IS INITIAL.
*  OPEN CURSOR WITH HOLD my_cursor FOR
*    SELECT * FROM n1vkg
*             WHERE corderid LE '0' AND stusr NE '@#OK#@'
*             AND    stusr NE '@#NOK#@'
*             AND    vkgid EQ singvkg
*             ORDER BY vkgid.
*
*ELSEIF NOT minvkg IS INITIAL AND NOT maxvkg IS INITIAL.
*  OPEN CURSOR WITH HOLD my_cursor FOR
*    SELECT * FROM n1vkg
*             WHERE corderid LE '0' AND stusr NE '@#OK#@'
*             AND    stusr NE '@#NOK#@'
*             AND vkgid GE minvkg
*             AND vkgid LE maxvkg
*             ORDER BY vkgid.
*
*ENDIF.
* *******************************************************************
* Michael Manoch, 02.06.2004   END

* Select the biggest existing vkgid.
IF NOT singvkg IS INITIAL.
  l_vkgid_from = singvkg.
  l_vkgid_to   = singvkg.
  l_max_vkgid = singvkg.                        " ID: 14520 08072004
ELSEIF NOT minvkg IS INITIAL AND NOT maxvkg IS INITIAL.
  SELECT MAX( vkgid )
    FROM n1vkg
    INTO l_max_vkgid
    WHERE ( corderid LE '0'
            OR corderid IS NULL )                           " ID 14520
      AND stusr NE '@#OK#@'
      AND stusr NE '@#NOK#@'
      AND vkgid GE minvkg
      AND vkgid LE maxvkg.
*  l_vkgid_from = minvkg.                       " REM ID:14520 08072004
  IF l_max_vkgid < maxvkg.
    l_vkgid_to = l_max_vkgid.
  ELSE.
    l_vkgid_to = maxvkg.
  ENDIF.
* Käfer, ID: 14520 08072004 - Begin
  l_max_vkgid = l_vkgid_to.
* select the smallest existing vkgid
  SELECT MIN( vkgid )
    FROM n1vkg
    INTO l_min_vkgid
    WHERE ( corderid LE '0'
            OR corderid IS NULL )
      AND stusr NE '@#OK#@'
      AND stusr NE '@#NOK#@'
      AND vkgid GE minvkg
      AND vkgid LE maxvkg.
  IF l_min_vkgid > minvkg.
    l_vkgid_from = l_min_vkgid.
  ELSE.
    l_vkgid_from = minvkg.
  ENDIF.
* Käfer, ID: 14520 08072004 - End
ENDIF.
* *******************************************************************
* while there are more preregs to migrate ... ***********************
my_count = 0.
my_convcount = 0.
my_more = 'X'.
l_first_time = 'X'.
* Käfer, ID: 14520 08072004 - Begin
*IF l_vkgid_from > 0.
*  l_vkgid_last = l_vkgid_from - 1.
*ELSE.
*  l_vkgid_last = 0.
*ENDIF.
* Käfer, ID: 14520 08072004 - End
WHILE my_more EQ 'X'.

  CLEAR myt_n1vkg.

* Käfer, ID: 14520 08072004 - Begin
  IF NOT l_first_time = 'X'.
    l_vkgid_from = l_vkgid_to + 1.
    l_vkgid_to = l_vkgid_to + 100.

    IF l_vkgid_from > l_max_vkgid.
      my_more = space.
      CONTINUE.
    ENDIF.
  ELSE.
    l_first_time = space.
    IF singvkg IS INITIAL.
      l_vkgid_to = l_vkgid_from + 99.
    ENDIF.
  ENDIF.

  IF l_vkgid_to > l_max_vkgid.
    l_vkgid_to = l_max_vkgid.
  ENDIF.
* Increment l_vkgid_from.
*  l_vkgid_from = l_vkgid_last + 1.
*
** Ready?
*  IF l_vkgid_from > l_vkgid_to.
*    my_more = space.
*    CONTINUE.
*  ENDIF.
* Käfer, ID: 14520 08072004 - End

* Get the next 100 n1vkg.
  SELECT *
*    UP TO 100 ROWS                             "REM ID: 14520 08072004
    FROM n1vkg
    INTO TABLE myt_n1vkg
    WHERE ( corderid LE '0'
            OR corderid IS NULL )                           " ID 14520
      AND stusr NE '@#OK#@'
      AND stusr NE '@#NOK#@'
      AND vkgid GE l_vkgid_from
      AND vkgid LE l_vkgid_to.

  READ TABLE myt_n1vkg INDEX 1 INTO myl_n1vkg.
* check if we've got more preregs to convert ************************
  IF sy-subrc <> 0.
*   we didn't find any more ***************************************
*    my_more = space.                          "REM ID: 14520 08072004
    CONTINUE.
  ELSE.
*   there are more preregs to convert, so lets go *****************
*   get related services and appointments *************************
    CLEAR: my_nlem, my_ntmn.
    SELECT lnrls vkgid anfid INTO TABLE my_nlem
             FROM nlem FOR ALL ENTRIES IN myt_n1vkg
             WHERE vkgid = myt_n1vkg-vkgid.
*    SELECT tmnid vkgid tmnoe storn INTO TABLE my_ntmn          "REM MED-09725
    SELECT tmnid vkgid tmnoe storn falnr INTO TABLE my_ntmn "MED-09725
             FROM ntmn FOR ALL ENTRIES IN myt_n1vkg
             WHERE vkgid = myt_n1vkg-vkgid.

*   ***************************************************************
    CLEAR myl_n1vkg.
    LOOP AT myt_n1vkg INTO myl_n1vkg.
*     Käfer, ID: 14520 08072004 - Begin
**     Actualize l_vkgid_last.
*      l_vkgid_last = myl_n1vkg-vkgid.
**     Ready?
*      IF l_vkgid_last > l_vkgid_to.
*        EXIT.
*      ENDIF.
*     Käfer, ID: 14520 08072004 - End
*     count preregs touched *****************************************
      my_count = my_count + 1.
*     ***************************************************************
*     exclude cancelled preregs ***********************************
      IF myl_n1vkg-storn EQ 'X'.
*       log them if desired ***************************************
        IF shstorn EQ 'X'.
          PERFORM proto USING
            4 space 'N1BASE' '124' myl_n1vkg-vkgid '(0)' space space.
          PERFORM proto USING
            4 space 'N1BASE' '112' space space space space.
        ENDIF.
        CONTINUE.
      ENDIF.
      CLEAR my_errorhandler.
*     we need to read out the identifier use for dummy services on
*     the system                                                 *
      CLEAR my_dummy_srv.
      CALL FUNCTION 'ISH_TN00R_READ'
        EXPORTING
          ss_einri = myl_n1vkg-einri
          ss_param = 'NPRGSRV'
          ss_alpha = 'X'
        IMPORTING
          ss_value = my_dummy_srv.
*     *************************************************************

*     create an environment for the preregistration ***************
      IF NOT my_environment1 IS INITIAL.
*       Reuse the environment, but not the data objects in it.
        CALL METHOD my_environment1->get_data
          IMPORTING
            et_objectlist = lt_env_objectlist.
        LOOP AT lt_env_objectlist ASSIGNING <ls_env_object>.
          CHECK NOT <ls_env_object>-object IS INITIAL.
          lr_data_object ?= <ls_env_object>-object.
          CALL METHOD lr_data_object->destroy.
        ENDLOOP.
      ELSE.
*       Create a new environment for the old preregistration.
        CALL METHOD cl_ish_fac_environment=>create
          EXPORTING
            i_program_name = sy-repid
          IMPORTING
            e_instance     = my_environment1
            e_rc           = my_rc
          CHANGING
            c_errorhandler = my_errorhandler.
        IF my_rc <> 0.
          PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(1)'.
          CONTINUE.
        ENDIF.
      ENDIF.
*     *************************************************************
*     create an environment for the new clinical order  ***********
      IF NOT my_environment IS INITIAL.
*       Reuse the environment, but not the data objects in it.
        CALL METHOD my_environment->get_data
          IMPORTING
            et_objectlist = lt_env_objectlist.
        LOOP AT lt_env_objectlist ASSIGNING <ls_env_object>.
          CHECK NOT <ls_env_object>-object IS INITIAL.
          lr_data_object ?= <ls_env_object>-object.
          CALL METHOD lr_data_object->destroy.
        ENDLOOP.
      ELSE.
        CALL METHOD cl_ish_fac_environment=>create
          EXPORTING
            i_program_name = sy-repid
          IMPORTING
            e_instance     = my_environment
            e_rc           = my_rc
          CHANGING
            c_errorhandler = my_errorhandler.
        IF my_rc <> 0.
          PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(2)'.
          CONTINUE.
        ENDIF.
      ENDIF.
*     *************************************************************

*     load the preregistration object *****************************
      CALL METHOD cl_ishmed_prereg=>load
        EXPORTING
          i_vkgid        = myl_n1vkg-vkgid
          i_environment  = my_environment1
        IMPORTING
          e_instance     = my_vkg
          e_rc           = my_rc
        CHANGING
          c_errorhandler = my_errorhandler.
*     if the old prereg object could not be created we leave here *
      IF my_rc <> 0 OR my_vkg IS INITIAL.
*       log it and process it later manually ********************
        PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(3)'.
*       codify the failure into N1VKG-stusr *********************
        IF testx NE 'X'.   "only update if not testing mode
*         Michael Manoch, 02.06.2004, ID 14520   START
*         Discharge any db-updates for this preregistration
          ROLLBACK WORK.
*         Michael Manoch, 02.06.2004, ID 14520   END
          UPDATE n1vkg SET stusr = '@#NOK#@'
            WHERE vkgid = myl_n1vkg-vkgid.
*         Michael Manoch, 02.06.2004, ID 14520   START
*         Commit the n1vkg-failure.
          COMMIT WORK AND WAIT.
*         Michael Manoch, 02.06.2004, ID 14520   END
        ENDIF.
        CONTINUE.
      ENDIF.
*     *************************************************************
*     since methods of the old pregregistration classes have been *
*     adopted for the new order processes, we have to use the old *
*     style flag **************************************************
      my_vkg->set_oldstyle( 'X' ).
*     *************************************************************

*     load existing waiting list absences *************************
      CLEAR: myt_objects, myl_objects.
      CALL METHOD my_vkg->get_absences
        EXPORTING
          ir_environment  = my_environment1
        IMPORTING
          et_absences     = myt_objects
          e_rc            = my_rc
        CHANGING
          cr_errorhandler = my_errorhandler.
      IF my_rc <> 0.
        PERFORM proto_ishmed
              USING 4 my_errorhandler myl_n1vkg-vkgid '(4)'.
        CONTINUE.
      ENDIF.
*     a prereg can have number of absences, so we loop through them
*     and put the data into a table *******************************
      LOOP AT myt_objects INTO myl_objects.
        my_wtla ?= myl_objects-object.
        CALL METHOD my_wtla->get_data
          IMPORTING
            es_data        = myl_nwlm
            e_rc           = my_rc
          CHANGING
            c_errorhandler = my_errorhandler.
        IF my_rc <> 0.
          PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(5)'.
          CONTINUE.
        ENDIF.
        APPEND myl_nwlm TO myt_nwlm.
      ENDLOOP.
*     *************************************************************
*     load existing procedures ************************************
      CLEAR: myt_objects, myl_objects, myl_npcp, myt_npcp.
      CALL METHOD my_vkg->get_procedures
        EXPORTING
          ir_environment  = my_environment1
        IMPORTING
          et_procedures   = myt_objects
          e_rc            = my_rc
        CHANGING
          cr_errorhandler = my_errorhandler.
      IF my_rc <> 0.
        PERFORM proto_ishmed
              USING 4 my_errorhandler myl_n1vkg-vkgid '(6)'.
        CONTINUE.
      ENDIF.
*     a prereg can have a number of procedures, so we loop through*
*     them and put the data into a table **************************
      LOOP AT myt_objects INTO myl_objects.
        my_proced ?= myl_objects-object.
        CALL METHOD my_proced->get_data
          IMPORTING
            es_data        = myl_npcp
            e_rc           = my_rc
          CHANGING
            c_errorhandler = my_errorhandler.
        IF my_rc <> 0.
          PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(6)'.
          CONTINUE.
        ENDIF.
        APPEND myl_npcp TO myt_npcp.
      ENDLOOP.
*     *************************************************************
*     load existing insurances  ***********************************
      CLEAR: myt_objects, myl_objects, myl_nipp, myt_nipp.
      CLEAR myt_nwlm.
      CALL METHOD my_vkg->get_insur_policies
        EXPORTING
          ir_environment  = my_environment1
        IMPORTING
          et_policies     = myt_objects
          e_rc            = my_rc
        CHANGING
          cr_errorhandler = my_errorhandler.
      IF my_rc <> 0.
        PERFORM proto_ishmed
              USING 4 my_errorhandler myl_n1vkg-vkgid '(7)'.
        CONTINUE.
      ENDIF.
*     a prereg can have a number of insurances, so we loop through*
*     them and put the data into a table **************************
      LOOP AT myt_objects INTO myl_objects.
        my_insp ?= myl_objects-object.
        CALL METHOD my_insp->get_data
          IMPORTING
            es_data        = myl_nipp
            e_rc           = my_rc
          CHANGING
            c_errorhandler = my_errorhandler.
        IF my_rc <> 0.
          PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(8)'.
          CONTINUE.
        ENDIF.
        APPEND myl_nipp TO myt_nipp.
      ENDLOOP.
*     *************************************************************

*     how many positions? *****************************************
      my_tre_required = space.
      my_adm_required = space.
*     Michael Manoch, 03.06.2004, ID 14520   START
*     Remember the admission appointment ntmn.
*      READ TABLE my_ntmn WITH KEY vkgid = myl_n1vkg-vkgid
*          TRANSPORTING NO FIELDS.
      CLEAR ls_ntmn_adm.
*     Käfer, ID: 14520 15072004 - Begin
*     only create an admission position, when FALAR not outpatient
*     and there is an admission appointment (can be cancelled)
      IF NOT myl_n1vkg-falar = '2'.
        LOOP AT my_ntmn ASSIGNING <ls_ntmn>.
          CHECK <ls_ntmn>-vkgid = myl_n1vkg-vkgid.
          my_adm_required = 'X'.
          IF <ls_ntmn>-storn = 'X'.
            DELETE my_ntmn.
            CONTINUE.
          ENDIF.
          ls_ntmn_adm = <ls_ntmn>.
        ENDLOOP.
      ENDIF.
*      READ TABLE my_ntmn
*        INTO ls_ntmn_adm
*        WITH KEY vkgid = myl_n1vkg-vkgid.
**     Michael Manoch, 03.06.2004, ID 14520   END
**     if we find an appointment, we need an admission item in our
**     order *******************************************************
*      IF sy-subrc = 0.
*        my_adm_required = 'X'.
*      ENDIF.
*     Käfer, ID: 14520 15072004 - End
*     is there a condition for the need of a treatment item ? for
*     the moment we set it every time
*     Michael Manoch, 03.06.2004, ID 14520   START
*     Creation of a treatment position depends on existence
*     of ORGID/TRTOE.
      IF myl_n1vkg-orgid IS INITIAL AND
         myl_n1vkg-trtoe IS INITIAL.
        my_tre_required = space.
      ELSE.
        my_tre_required = 'X'.
      ENDIF.
*     Michael Manoch, 03.06.2004, ID 14520   END

*-- begin Grill, ID-18240
      IF my_adm_required = space AND
         my_tre_required = space AND
      NOT myl_n1vkg-orgfa IS INITIAL.
        my_adm_required = 'X'.
      ENDIF.
*-- end Grill, ID-18240

*     Michael Manoch, 03.06.2004, ID 14520   START
*     There has to be at least an adm or treating position.
      IF my_adm_required = space AND
         my_tre_required = space.
        l_string = my_vkg->get_text_cordpos( ).
        PERFORM proto USING
          4 space 'N1BASE' '124' myl_n1vkg-vkgid '(0)' space space.
        PERFORM proto USING
          4 space 'N1CORDMG' '108' l_string space space space.
        CONTINUE.
      ENDIF.
*     Michael Manoch, 03.06.2004, ID 14520   END

*     read the preregistration type and get the types of the order*
*     items from that *********************************************
      CLEAR: my_cordtid_adm, my_cordtid_tre.
      CONCATENATE 'A_' myl_n1vkg-prtid
        INTO my_cordtid_adm.                        "Admission
      CONCATENATE 'T_' myl_n1vkg-prtid
        INTO my_cordtid_tre.                        "Treatment

*     Michael Manoch, 03.06.2004, ID 14520   START
*     For the new adm_pos the tmnoe of the admission appointment
*     will be used.
*     Therefore check if it is valid.
*     If not -> do not use tmnoe of the admission appointment.
      IF my_adm_required = 'X' AND
         NOT ls_ntmn_adm-tmnoe IS INITIAL.
        DO 1 TIMES.
*         Get the adm cordtyp object.
          lr_cordtyp_adm =
            cl_ish_cordtyp=>get_cordtyp( my_cordtid_adm ).
          CHECK NOT lr_cordtyp_adm IS INITIAL.
*         If the tmnoe would not be valid, clear it
*         and use only the orgfa.
          IF lr_cordtyp_adm->is_cordttr_supported(
                      ls_ntmn_adm-tmnoe ) = space.
            CLEAR ls_ntmn_adm-tmnoe.
          ENDIF.
        ENDDO.
      ENDIF.
*     Michael Manoch, 03.06.2004, ID 14520   END

*     now we start to create our data map which we supply to the  *
*     order creation function later *******************************
*     The anatomy of a map entry is like this:                    *
*       posno       order item number                             *
*       instno      instance number                               *
*       compid      component ID or special identifier            *
*       fieldname   name of the dynpro- or object structure field *
*       fieldvalue  value of the field                            *
      CLEAR: l_comp_map, my_map.

*     position (item) 0 is the header of the clinical order *******
*     @HEAD identifies general order data *************************
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'einri'.
      l_comp_map-fvalue     = myl_n1vkg-einri.
      APPEND l_comp_map TO my_map.                "institution
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'reftyp'.
      IF NOT myl_n1vkg-patnr IS INITIAL.
        l_comp_map-fvalue     = 'P'.
      ELSE.
        l_comp_map-fvalue     = 'V'.
      ENDIF.
      APPEND l_comp_map TO my_map.                "kind of patient
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      IF NOT myl_n1vkg-patnr IS INITIAL.
        l_comp_map-fieldname  = 'patnr'.
        l_comp_map-fvalue     = myl_n1vkg-patnr.
      ELSE.
        l_comp_map-fieldname  = 'papid'.
        l_comp_map-fvalue     = myl_n1vkg-papid.
      ENDIF.
      APPEND l_comp_map TO my_map.                	"patient ID
*                     ***
*     *************************************************************
*     we need to find out the names of the screen field names of
*     the order component
      CALL METHOD cl_ish_fac_scr_order=>create
        EXPORTING
          ir_environment  = my_environment
        IMPORTING
          er_instance     = my_scr_order
          e_rc            = my_rc
        CHANGING
          cr_errorhandler = my_errorhandler.
      IF my_rc <> 0.
        PERFORM proto_ishmed
              USING 4 my_errorhandler myl_n1vkg-vkgid '(9)'.
        CONTINUE.
      ENDIF.
*     ***************************************************************
      l_comp_map-posno      = 0.
      l_comp_map-compid     = 'SAP_ORDER'.            "order data
      l_comp_map-fieldname  = my_scr_order->g_fieldname_etrby.
      l_comp_map-fvalue     = myl_n1vkg-etrby.
      APPEND l_comp_map TO my_map.
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = 'SAP_ORDER'.            "order data
      l_comp_map-fieldname  = my_scr_order->g_fieldname_etroegp.
      IF myl_n1vkg-etrby  = 1.
        l_comp_map-fvalue     = myl_n1vkg-etroe.
      ELSE.
        l_comp_map-fvalue     = myl_n1vkg-etrgp.
      ENDIF.
      APPEND l_comp_map TO my_map.
*                    ***

*     Käfer, ID: 15788 - Begin
*     do not prealloc orddep; the orddep will be ascertained
*     automatically
*      l_comp_map-posno      = 0.
*      l_comp_map-compid     = 'SAP_ORDER'.            "order data
*      l_comp_map-fieldname  = my_scr_order->g_fieldname_orddep.
*      l_comp_map-fvalue     = myl_n1vkg-orgfa.
*      APPEND l_comp_map TO my_map.
*     Käfer, ID: 15788 - End

*                    ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = 'SAP_ORDER'.            "order data
      l_comp_map-fieldname  = my_scr_order->g_fieldname_gpart.
      l_comp_map-fvalue     = myl_n1vkg-etrgp.
      APPEND l_comp_map TO my_map.
*                ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = 'SAP_ORDER'.            "order data
      l_comp_map-fieldname  = my_scr_order->g_fieldname_cordtitle.
*     Käfer, ID: 14520 08072004 - Begin
      IF NOT myl_n1vkg-prgnr IS INITIAL.
*     Käfer, ID: 14520 08072004 - End
        CONCATENATE '(VKG ' myl_n1vkg-prgnr ')'
                                    INTO l_comp_map-fvalue.
*     Käfer, ID: 14520 08072004 - Begin
      ELSE.
        CONCATENATE '(VKG ' myl_n1vkg-vkgid ')'
                                    INTO l_comp_map-fvalue.
      ENDIF.
*     Käfer, ID: 14520 08072004 - End
      APPEND l_comp_map TO my_map.
*                     ***

*     Käfer, ID: 15788 - Begin
      l_comp_map-posno      = 0.
      l_comp_map-compid     = 'SAP_ORDER'.
      l_comp_map-fieldname  = my_scr_order->g_fieldname_wlsta.
      l_comp_map-fvalue     = myl_n1vkg-wlsta.
      APPEND l_comp_map TO my_map.                	"wlsta
*                     ***
*     Käfer, ID: 15788 - End

      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'kanam'.
      l_comp_map-fvalue     = myl_n1vkg-kanam.
      APPEND l_comp_map TO my_map.                	"kanam
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'kaltx'.
      l_comp_map-fvalue     = myl_n1vkg-kaltx.
      APPEND l_comp_map TO my_map.                	"kaltx
*     the associated longtext - if any - is migrated later *****
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'rmcord'.
      l_comp_map-fvalue     = myl_n1vkg-bmvkg.
      APPEND l_comp_map TO my_map.                	"bmvkg
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'rmltx'.
      l_comp_map-fvalue     = myl_n1vkg-bmltx.
      APPEND l_comp_map TO my_map.                	"bmltx
*     the associated longtext - if any - is migrated later *****
*                     ***
*     waiting list data *******************************************
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'wlpri'.
      l_comp_map-fvalue     = myl_n1vkg-wlpri.
      APPEND l_comp_map TO my_map.                	"wlpri
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'wltyp'.
      l_comp_map-fvalue     = myl_n1vkg-wltyp.
      APPEND l_comp_map TO my_map.                	"wltyp
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'wlrem'.
      l_comp_map-fvalue     = myl_n1vkg-wlrem.
      APPEND l_comp_map TO my_map.                	"wlrem
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'wlrdt'.
      l_comp_map-fvalue     = myl_n1vkg-wlrdt.
      APPEND l_comp_map TO my_map.                	"wlrdt
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'wlrrn'.
      l_comp_map-fvalue     = myl_n1vkg-wlrrn.
      APPEND l_comp_map TO my_map.                	"wlrrn
*                     ***

*     Käfer, ID: 15788 - Begin
*     the preallocation of WLSTA is not correct here
*      l_comp_map-posno      = 0.
*      l_comp_map-compid     = '@HEAD'.
*      l_comp_map-fieldname  = 'wlsta'.
*      l_comp_map-fvalue     = myl_n1vkg-wlsta.
*      APPEND l_comp_map TO my_map.                	"wlsta
*     Käfer, ID: 15788 - End

*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'wlhsp'.
      l_comp_map-fvalue     = myl_n1vkg-wlhsp.
      APPEND l_comp_map TO my_map.                	"wlhsp
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'wladt'.
      l_comp_map-fvalue     = myl_n1vkg-wladt.
      APPEND l_comp_map TO my_map.                	"wladt
*                     ***
*     administrativ data ******************************************
*     migrated to the order header as well as to the new positions*
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'erdat'.
      l_comp_map-fvalue     = myl_n1vkg-erdat.
      APPEND l_comp_map TO my_map.                	"erdat
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'erusr'.
      l_comp_map-fvalue     = myl_n1vkg-erusr.
      APPEND l_comp_map TO my_map.                	"erusr
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'updat'.
      l_comp_map-fvalue     = myl_n1vkg-updat.
      APPEND l_comp_map TO my_map.                	"updat
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'upusr'.
      l_comp_map-fvalue     = myl_n1vkg-upusr.
      APPEND l_comp_map TO my_map.                	"upusr
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'storn'.
      l_comp_map-fvalue     = myl_n1vkg-storn.
      APPEND l_comp_map TO my_map.                	"storn
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'stusr'.
      l_comp_map-fvalue     = myl_n1vkg-stusr.
      APPEND l_comp_map TO my_map.                	"stusr
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'stdat'.
      l_comp_map-fvalue     = myl_n1vkg-stdat.
      APPEND l_comp_map TO my_map.                	"stdat
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'stoid'.
      l_comp_map-fvalue     = myl_n1vkg-stoid.
      APPEND l_comp_map TO my_map.                	"stoid
*                     ***

*     *** user specific fields *********************************
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'user1'.
      l_comp_map-fvalue     = myl_n1vkg-user1.
      APPEND l_comp_map TO my_map.                	         "user1
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'user2'.
      l_comp_map-fvalue     = myl_n1vkg-user2.
      APPEND l_comp_map TO my_map.                	         "user2
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'user3'.
      l_comp_map-fvalue     = myl_n1vkg-user3.
      APPEND l_comp_map TO my_map.                	         "user3
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'user4'.
      l_comp_map-fvalue     = myl_n1vkg-user4.
      APPEND l_comp_map TO my_map.                	         "user4
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'user5'.
      l_comp_map-fvalue     = myl_n1vkg-user5.
      APPEND l_comp_map TO my_map.                	         "user5
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'user6'.
      l_comp_map-fvalue     = myl_n1vkg-user6.
      APPEND l_comp_map TO my_map.                	         "user6
*                     ***
      l_comp_map-posno      = 0.
      l_comp_map-compid     = '@HEAD'.
      l_comp_map-fieldname  = 'user7'.
      l_comp_map-fvalue     = myl_n1vkg-user7.
      APPEND l_comp_map TO my_map.                	         "user7
*     **********************************************************
*     create waiting list absences, one instance per absence   *
*     identified by @WTLA **************************************
      my_instno = 0.
      LOOP AT myt_nwlm INTO myl_nwlm.
        my_instno = my_instno + 1.
        l_comp_map-instno     = my_instno.
        l_comp_map-posno      = 0.
        l_comp_map-compid     = '@WTLA'.

        l_comp_map-fieldname  = 'einri'.
        l_comp_map-fvalue     = myl_nwlm-einri.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-fieldname  = 'absbdt'.
        l_comp_map-fvalue     = myl_nwlm-absbdt.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-fieldname  = 'absedt'.
        l_comp_map-fvalue     = myl_nwlm-absedt.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-fieldname  = 'absrsn'.
        l_comp_map-fvalue     = myl_nwlm-absrsn.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-fieldname  = 'storn'.
        l_comp_map-fvalue     = myl_nwlm-storn.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-fieldname  = 'stusr'.
        l_comp_map-fvalue     = myl_nwlm-stusr.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-fieldname  = 'stdat'.
        l_comp_map-fvalue     = myl_nwlm-stdat.
        APPEND l_comp_map TO my_map.
*                      ***
      ENDLOOP.
*     *************************************************************
*     create insurances, one instance per insurance entry         *
*     identified by @INSP *****************************************
      my_instno = 0.
      LOOP AT myt_nipp INTO myl_nipp.
        my_instno = my_instno + 1.
        l_comp_map-instno     = my_instno.
        l_comp_map-posno      = 0.
        l_comp_map-compid     = '@INSP'.

        l_comp_map-fieldname  = 'einri'.
        l_comp_map-fvalue     = myl_nipp-einri.
        APPEND l_comp_map TO my_map.
*                    ***
        l_comp_map-fieldname  = 'ipid'.
        l_comp_map-fvalue     = myl_nipp-ipid.
        APPEND l_comp_map TO my_map.
*                    ***
        l_comp_map-fieldname  = 'lfdvv'.
        l_comp_map-fvalue     = myl_nipp-lfdvv.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'kname'.
        l_comp_map-fvalue     = myl_nipp-kname.
        APPEND l_comp_map TO my_map.
*                    ***
        l_comp_map-fieldname  = 'vnumm'.
        l_comp_map-fvalue     = myl_nipp-vnumm.
        APPEND l_comp_map TO my_map.
*                    ***
        l_comp_map-fieldname  = 'rangf'.
        l_comp_map-fvalue     = myl_nipp-rangf.
        APPEND l_comp_map TO my_map.
*                    ***
        l_comp_map-fieldname  = 'mgart'.
        l_comp_map-fvalue     = myl_nipp-mgart.
        APPEND l_comp_map TO my_map.
*                    ***
        l_comp_map-fieldname  = 'vzuza'.
        l_comp_map-fvalue     = myl_nipp-vzuza.
        APPEND l_comp_map TO my_map.
*                    ***
        l_comp_map-fieldname  = 'verbi'.
        l_comp_map-fvalue     = myl_nipp-verbi.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'vknr'.
        l_comp_map-fvalue     = myl_nipp-vknr.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'vstat'.
        l_comp_map-fvalue     = myl_nipp-vstat.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'vster'.
        l_comp_map-fvalue     = myl_nipp-vster.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'vscod'.
        l_comp_map-fvalue     = myl_nipp-vscod.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'kvdat'.
        l_comp_map-fvalue     = myl_nipp-kvdat.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'pcard'.
        l_comp_map-fvalue     = myl_nipp-pcard.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'storn'.
        l_comp_map-fvalue     = myl_nipp-storn.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'stusr'.
        l_comp_map-fvalue     = myl_nipp-stusr.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'stdat'.
        l_comp_map-fvalue     = myl_nipp-stdat.
        APPEND l_comp_map TO my_map.
*                  ***
      ENDLOOP.
*     *************************************************************
*     create procedures, one instance per procedure               *
*     identified by @PROC *****************************************
      my_instno = 0.
      LOOP AT myt_npcp INTO myl_npcp.
        my_instno = my_instno + 1.
        l_comp_map-instno     = my_instno.
        l_comp_map-posno      = 0.
        l_comp_map-compid     = '@PROC'.
*                   ***
        l_comp_map-fieldname  = 'einri'.
        l_comp_map-fvalue     = myl_npcp-einri.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'icpmc'.
        l_comp_map-fvalue     = myl_npcp-icpmc.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'icpm'.
        l_comp_map-fvalue     = myl_npcp-icpm.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'icpml'.
        l_comp_map-fvalue     = myl_npcp-icpml.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'storn'.
        l_comp_map-fvalue     = myl_npcp-storn.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'stusr'.
        l_comp_map-fvalue     = myl_npcp-stusr.
        APPEND l_comp_map TO my_map.
*                  ***
        l_comp_map-fieldname  = 'stdat'.
        l_comp_map-fvalue     = myl_npcp-stdat.
        APPEND l_comp_map TO my_map.
*                  ***
      ENDLOOP.
*     *************************************************************

      my_posno = 0.
      IF my_adm_required EQ 'X'.
        my_posno = my_posno + 1.
*       data so far -appended- to table N1VKG *********************
*       table dfies contains the fieldnames of table N1VKG ********
*       old N1VKG-appends are appended to both positions since we *
*       don't know what that data was used for; the user should ***
*       migrate them separately to N1CORDER if needed (use the ****
*       following procedure as template ***************************
        my_df_count = 1.
        CLEAR myl_dfies.
        LOOP AT myt_dfies INTO myl_dfies.
          IF my_df_count >= 85.  "<<<!!! standard n1vkg has 84 fields!!!
            CONCATENATE 'myl_n1vkg-' myl_dfies-fieldname
                                                  INTO fname.
            ASSIGN (fname) TO <fst>.
            l_comp_map-posno      = my_posno.
            l_comp_map-compid     = '@POSHEAD'.
            l_comp_map-fieldname  = myl_dfies-fieldname.
            l_comp_map-fvalue     = <fst>.
            APPEND l_comp_map TO my_map.
          ENDIF.
          my_df_count = my_df_count + 1.
        ENDLOOP.
*       ***********************************************************
*       admission item ********************************************
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'cordtypid'.
        l_comp_map-fvalue     = my_cordtid_adm.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'orgid'.
*       Michael Manoch, 03.06.2004, ID 14520   START
*       Do not use the old orgid.
*       Instead use the TMNOE of the admission appointment.
*        l_comp_map-fvalue     = myl_n1vkg-orgid.
        l_comp_map-fvalue     = ls_ntmn_adm-tmnoe.
*       Michael Manoch, 03.06.2004, ID 14520   END
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'trtby'.
        l_comp_map-fvalue     = '1'.                        "1=OU
        APPEND l_comp_map TO my_map.                        "trtby
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'trtoe'.
*       Michael Manoch, 03.06.2004, ID 14520   START
*       Do not use the old orgid.
*       Instead use the TMNOE of the admission appointment.
*        l_comp_map-fvalue     = myl_n1vkg-orgid.
        l_comp_map-fvalue     = ls_ntmn_adm-tmnoe.
*       Michael Manoch, 03.06.2004, ID 14520   END
        APPEND l_comp_map TO my_map.                        "trtoe
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'orgfa'.
*       Michael Manoch, 03.06.2004, ID 14520   START
*       Do not use the old orgfa.
*       Instead just clear the orgfa to let the cordpos
*       generate it from orgid.
        IF ls_ntmn_adm-tmnoe IS INITIAL.
          l_comp_map-fvalue     = myl_n1vkg-orgfa.
        ELSE.
          CLEAR l_comp_map-fvalue.
        ENDIF.
*       Michael Manoch, 03.06.2004, ID 14520   END
        APPEND l_comp_map TO my_map.                        "orgfa
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'prereg'.
        l_comp_map-fvalue     = 'X'.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'einri'.
        l_comp_map-fvalue     = myl_n1vkg-einri.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'falnr'.
*       use the FALNR of the admission appointment.
*        l_comp_map-fvalue     = myl_n1vkg-falnr.       "REM MED-09725
        l_comp_map-fvalue     = ls_ntmn_adm-falnr.          "MED-09725
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'falar'.
        l_comp_map-fvalue     = myl_n1vkg-falar.
        APPEND l_comp_map TO my_map.                   "falar
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'bewar'.
        l_comp_map-fvalue     = myl_n1vkg-bewar.       "bewar
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'bekat'.
        l_comp_map-fvalue     = myl_n1vkg-bekat.
        APPEND l_comp_map TO my_map.                   "bekat
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'rfsrc'.
        l_comp_map-fvalue     = myl_n1vkg-rfsrc.
        APPEND l_comp_map TO my_map.                  "rfsrc
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'pvpat'.
        l_comp_map-fvalue     = myl_n1vkg-pvpat.
        APPEND l_comp_map TO my_map.                  "pvpat
*                      ***

*     	  referrals
*************************************************
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'earnr'.
        l_comp_map-fvalue     = myl_n1vkg-earnr.	"earnr
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'extkh'.
        l_comp_map-fvalue     = myl_n1vkg-extkh.	"extkh
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'uarnr'.
        l_comp_map-fvalue     = myl_n1vkg-uarnr.	"uarnr
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'harnr'.
        l_comp_map-fvalue     = myl_n1vkg-harnr.	"harnr
        APPEND l_comp_map TO my_map.
*                      ***

*       administrativ data ****************************************
*       migrated to the order header as well as to the new position
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'erdat'.
        l_comp_map-fvalue     = myl_n1vkg-erdat.
        APPEND l_comp_map TO my_map.                	"erdat
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'erusr'.
        l_comp_map-fvalue     = myl_n1vkg-erusr.
        APPEND l_comp_map TO my_map.                	"erusr
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'updat'.
        l_comp_map-fvalue     = myl_n1vkg-updat.
        APPEND l_comp_map TO my_map.                	"updat
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'upusr'.
        l_comp_map-fvalue     = myl_n1vkg-upusr.
        APPEND l_comp_map TO my_map.                	"upusr
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'storn'.
        l_comp_map-fvalue     = myl_n1vkg-storn.
        APPEND l_comp_map TO my_map.                	"storn
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'stusr'.
        l_comp_map-fvalue     = myl_n1vkg-stusr.
        APPEND l_comp_map TO my_map.                	"stusr
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'stdat'.
        l_comp_map-fvalue     = myl_n1vkg-stdat.
        APPEND l_comp_map TO my_map.                	"stdat
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'stoid'.
        l_comp_map-fvalue     = myl_n1vkg-stoid.
        APPEND l_comp_map TO my_map.                	"stoid
*                       ***

*       appointment constraint data *******************************
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'wuzpi'.
        l_comp_map-fvalue     = myl_n1vkg-wuzpi.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'wumnt'.
        l_comp_map-fvalue     = myl_n1vkg-wumnt.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'wujhr'.
        l_comp_map-fvalue     = myl_n1vkg-wujhr.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'aufds'.
        l_comp_map-fvalue     = myl_n1vkg-aufds.
        APPEND l_comp_map TO my_map.
*       ***********************************************************
      ENDIF.
      IF my_tre_required EQ 'X'.
        my_posno = my_posno + 1.
*       data so far -appended- to table N1VKG *********************
*       table dfies contains the fieldnames of table N1VKG ********
*       old N1VKG-appends are appended to both positions since we *
*       don't know what that data was used for; the user should ***
*       migrate them separately to N1CORDER if needed (use the ****
*       following procedure as template ***************************
        my_df_count = 1.
        CLEAR myl_dfies.
        LOOP AT myt_dfies INTO myl_dfies.
          IF my_df_count >= 85.  "<<<!!! standard n1vkg has 84 fields
            CONCATENATE 'myl_n1vkg-' myl_dfies-fieldname
                                                  INTO fname.
            ASSIGN (fname) TO <fst>.
            l_comp_map-posno      = my_posno.
            l_comp_map-compid     = '@POSHEAD'.
            l_comp_map-fieldname  = myl_dfies-fieldname.
            l_comp_map-fvalue     = <fst>.
            APPEND l_comp_map TO my_map.
          ENDIF.
          my_df_count = my_df_count + 1.
        ENDLOOP.
*       ***********************************************************
*       treatment item ********************************************
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'cordtypid'.
        l_comp_map-fvalue     = my_cordtid_tre.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'orgid'.
        l_comp_map-fvalue     = myl_n1vkg-orgid.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'trtby'.
        l_comp_map-fvalue     = '1'.                        "1=OU
        APPEND l_comp_map TO my_map.                        "trtby
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'trtoe'.
        l_comp_map-fvalue     = myl_n1vkg-orgid.
        APPEND l_comp_map TO my_map.                        "trtoe
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'orgfa'.
*       Käfer, ID: 15788 - 280105 - Begin
*       clear the orgfa and let the cordpos generate the orgfa
*       itself
*        l_comp_map-fvalue     = myl_n1vkg-orgfa.
        CLEAR l_comp_map-fvalue.
*       Käfer, ID: 15788 - 280105 - End
        APPEND l_comp_map TO my_map.                        "orgfa
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'prereg'.
        l_comp_map-fvalue     = 'X'.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'einri'.
        l_comp_map-fvalue     = myl_n1vkg-einri.
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'falnr'.
        l_comp_map-fvalue     = myl_n1vkg-falnr.
*                      ***
        APPEND l_comp_map TO my_map.
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'falar'.
        l_comp_map-fvalue     = myl_n1vkg-falar.
        APPEND l_comp_map TO my_map.                   "falar
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'bewar'.
*       Käfer, ID: 14520 18072004 - Begin
        IF NOT myl_n1vkg-bewar IS INITIAL.
          CALL FUNCTION 'ISH_BWART_CHECK'
            EXPORTING
              ss_einri  = myl_n1vkg-einri
              ss_bewty  = '4'
              ss_bwart  = myl_n1vkg-bewar
            EXCEPTIONS
              not_found = 1
              OTHERS    = 2.

          IF sy-subrc <> 0.
            CLEAR l_comp_map-fvalue.
          ELSE.
            l_comp_map-fvalue = myl_n1vkg-bewar.
          ENDIF.
        ELSE.
          l_comp_map-fvalue     = myl_n1vkg-bewar.       "bewar
        ENDIF.
*       Käfer, ID: 14520 18072004 - End
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'bekat'.
        l_comp_map-fvalue     = myl_n1vkg-bekat.
        APPEND l_comp_map TO my_map.                   "bekat
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'rfsrc'.
        l_comp_map-fvalue     = myl_n1vkg-rfsrc.
        APPEND l_comp_map TO my_map.                  "rfsrc
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'pvpat'.
        l_comp_map-fvalue     = myl_n1vkg-pvpat.
        APPEND l_comp_map TO my_map.                  "pvpat
*                      ***

*	  referrals *************************************************
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'earnr'.
        l_comp_map-fvalue     = myl_n1vkg-earnr.	"earnr
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'extkh'.
        l_comp_map-fvalue     = myl_n1vkg-extkh.	"extkh
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'uarnr'.
        l_comp_map-fvalue     = myl_n1vkg-uarnr.	"uarnr
        APPEND l_comp_map TO my_map.
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'harnr'.
        l_comp_map-fvalue     = myl_n1vkg-harnr.	"harnr
        APPEND l_comp_map TO my_map.
*       administrativ data ****************************************
*       migrated to the order header as well as to the new position
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'erdat'.
        l_comp_map-fvalue     = myl_n1vkg-erdat.
        APPEND l_comp_map TO my_map.                	"erdat
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'erusr'.
        l_comp_map-fvalue     = myl_n1vkg-erusr.
        APPEND l_comp_map TO my_map.                	"erusr
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'updat'.
        l_comp_map-fvalue     = myl_n1vkg-updat.
        APPEND l_comp_map TO my_map.                	"updat
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'upusr'.
        l_comp_map-fvalue     = myl_n1vkg-upusr.
        APPEND l_comp_map TO my_map.                	"upusr
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'storn'.
        l_comp_map-fvalue     = myl_n1vkg-storn.
        APPEND l_comp_map TO my_map.                	"storn
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'stusr'.
        l_comp_map-fvalue     = myl_n1vkg-stusr.
        APPEND l_comp_map TO my_map.                	"stusr
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'stdat'.
        l_comp_map-fvalue     = myl_n1vkg-stdat.
        APPEND l_comp_map TO my_map.                	"stdat
*                       ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@POSHEAD'.
        l_comp_map-fieldname  = 'stoid'.
        l_comp_map-fvalue     = myl_n1vkg-stoid.
        APPEND l_comp_map TO my_map.                	"stoid
*                       ***
*       appointment constraint data *******************************
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'wuzpi'.
        l_comp_map-fvalue     = myl_n1vkg-wuzpi.
        APPEND l_comp_map TO my_map.                    "wuzpi
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'wumnt'.
        l_comp_map-fvalue     = myl_n1vkg-wumnt.
        APPEND l_comp_map TO my_map.                    "wumnt
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'wujhr'.
        l_comp_map-fvalue     = myl_n1vkg-wujhr.
        APPEND l_comp_map TO my_map.                    "wujhr
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'aufds'.
        l_comp_map-fvalue     = myl_n1vkg-aufds.
        APPEND l_comp_map TO my_map.                    "aufds
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'troom'.
        l_comp_map-fvalue     = myl_n1vkg-troom.
        APPEND l_comp_map TO my_map.                    "troom
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'troomx'.
        l_comp_map-fvalue     = myl_n1vkg-troomx.
        APPEND l_comp_map TO my_map.                    "troomx
*                      ***
        IF NOT myl_n1vkg-troom IS INITIAL.
*         if we have a troom, we need to supply the
*         OU of the appointment too; we use the OU of the room ******
          CALL FUNCTION 'ISHMED_GET_OE_FOR_BAUID'
            EXPORTING
              i_bauid = myl_n1vkg-troom
*             I_DATUM = SY-DATUM
            IMPORTING
              e_norg  = myl_norg.
          l_comp_map-posno      = my_posno.
          l_comp_map-compid     = '@APCO'.
          l_comp_map-fieldname  = 'trtoe'.
          l_comp_map-fvalue     = myl_norg-orgid.
          APPEND l_comp_map TO my_map.                    "trtoe
*       Käfer, ID: 15788 - Begin
*       when there is no room the OE of the appointment constraint
*       should be prealloced by OE of orderposition
*        ENDIF.
        ELSE.
          l_comp_map-posno      = my_posno.
          l_comp_map-compid     = '@APCO'.
          l_comp_map-fieldname  = 'trtoe'.
          l_comp_map-fvalue     = myl_n1vkg-orgid.
          APPEND l_comp_map TO my_map.
        ENDIF.
*       Käfer, ID: 15788 - End
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'trdrn'.
        l_comp_map-fvalue     = myl_n1vkg-trdrn.
        APPEND l_comp_map TO my_map.                      "trdrn
*                      ***
        l_comp_map-posno      = my_posno.
        l_comp_map-compid     = '@APCO'.
        l_comp_map-fieldname  = 'trdrnx'.
        l_comp_map-fvalue     = myl_n1vkg-trdrnx.
        APPEND l_comp_map TO my_map.                      "trdrnx

*     *************************************************************
      ENDIF.
*     *** END OF MAPPING ******************************************

*     now we create the new order *********************************
      CALL FUNCTION 'ISHMED_PRGUPGR'
        EXPORTING
          it_map          = my_map
          i_testrun       = ' '
          i_log           = ' '
        IMPORTING
          e_corderid      = my_corderid
          e_rc            = my_rc
          er_corder       = my_corder
        CHANGING
          cr_errorhandler = my_errorhandler
          cr_environment  = my_environment.
*     *************************************************************
      IF my_rc <> 0.
*       log it and process it later manually ********************
        PERFORM proto_ishmed
                  USING 4 my_errorhandler myl_n1vkg-vkgid '(10)'.
*       codify the failure into N1VKG-stusr *********************
        IF testx NE 'X'.   "only update if not testing mode
*         Michael Manoch, 02.06.2004, ID 14520   START
*         Discharge any db-updates for this preregistration
          ROLLBACK WORK.
*         Michael Manoch, 02.06.2004, ID 14520   END
          UPDATE n1vkg SET stusr = '@#NOK#@'
               WHERE vkgid = myl_n1vkg-vkgid.
*         Michael Manoch, 02.06.2004, ID 14520   START
*         Commit the n1vkg-failure.
          COMMIT WORK AND WAIT.
*         Michael Manoch, 02.06.2004, ID 14520   END
        ENDIF.
*     *************************************************************
        CONTINUE.
      ELSE.
*         process further relations
        my_further_relations = 'yes'.
        IF my_further_relations EQ 'yes'.
*         *********************************************************
*         we migrate the contexts *********************************
*         get contexts of the preregistration *********************
          CLEAR: myt_objects, my_context.
*         context object ******************************************
          CALL METHOD my_vkg->get_context_for_prereg
            EXPORTING
              i_prereg                    = my_vkg
              i_environment               = my_environment1
            IMPORTING
              et_context                  = myt_context
              et_context_object_relations = myt_contor
              e_rc                        = my_rc
            CHANGING
              c_errorhandler              = my_errorhandler.
          IF my_rc <> 0.
            PERFORM proto_ishmed
                  USING 4 my_errorhandler myl_n1vkg-vkgid '(12)'.
            CONTINUE.
          ENDIF.
*         *********************************************************
          my_checkmark = ' '.
          LOOP AT myt_context INTO myl_context.
            IF my_checkmark = 'X'.
              EXIT.
            ENDIF.
*           now we loop through the contexts **********************
            my_context ?= myl_context-object.
*           get the objects assigned to this context **************
            CALL METHOD cl_ish_context=>get_objects_for_context
              EXPORTING
                i_context                   = my_context
                i_environment               = my_environment1
              IMPORTING
                et_objects                  = myt_objects
                et_context_object_relations = myt_contor
                et_context_trigger          = myt_conttr
                e_rc                        = my_rc
              CHANGING
                c_errorhandler              = my_errorhandler.
            IF my_rc <> 0.
              PERFORM proto_ishmed
                  USING 4 my_errorhandler myl_n1vkg-vkgid '(13)'.
              my_checkmark = 'X'.
              CONTINUE.
            ENDIF.
*           *******************************************************
            IF NOT myt_objects IS INITIAL.
              CLEAR my_useless_nctx.
*             get the context data ********************************
              CALL METHOD my_context->get_data
                IMPORTING
                  e_nctx         = my_useless_nctx
                  e_rc           = my_rc
                CHANGING
                  c_errorhandler = my_errorhandler.
              IF my_rc <> 0.
                PERFORM proto_ishmed
                    USING 4 my_errorhandler myl_n1vkg-vkgid '(14)'.
                my_checkmark = 'X'.
                CONTINUE.
              ENDIF.

*             Käfer, ID: 17083 - Begin
*             delete old context data but only in real mode
              IF NOT my_useless_nctx-cxid IS INITIAL.
                IF testx <> 'X'.
                  DELETE FROM nctx WHERE cxid = my_useless_nctx-cxid.
                  DELETE FROM ncto WHERE cxid = my_useless_nctx-cxid.
                ENDIF.
              ENDIF.
*             Käfer, ID: 17083 - End

              my_useless_nctx-cxid     = space.
*             create a new context based on the old one  **********
              CALL METHOD cl_ish_context=>create
                EXPORTING
                  i_nctx         = my_useless_nctx
*                 i_copy_of      = my_context
                  i_environment  = my_environment
                IMPORTING
                  e_instance     = my_new_context
                  e_rc           = my_rc
                CHANGING
                  c_errorhandler = my_errorhandler.
              IF my_rc <> 0.
                PERFORM proto_ishmed
                    USING 4 my_errorhandler myl_n1vkg-vkgid '(15)'.
                my_checkmark = 'X'.
                CONTINUE.
              ENDIF.

*             Käfer, ID: 15788 - Begin
*             set g_force_erup_data to off, so that the erup-data
*             for the new context-object will not be actualized
              CALL METHOD my_new_context->set_force_erup_data
                EXPORTING
                  i_force_erup_data = space.
*             Käfer, ID: 15788 - End

*             add objects to the context **************************
*             the order itself ************************************
              CLEAR my_rncto.
              my_rncto-ctoty = '0'.
              my_rncto-ctoty_x = 'X'.
              CALL METHOD my_new_context->add_obj_to_context
                EXPORTING
                  i_object       = my_corder
                  i_attributes   = my_rncto
                IMPORTING
                  e_rc           = my_rc
                CHANGING
                  c_errorhandler = my_errorhandler.
              IF my_rc <> 0.
                PERFORM proto_ishmed
                    USING 4 my_errorhandler myl_n1vkg-vkgid '(16)'.
                my_checkmark = 'X'.
                CONTINUE.
              ENDIF.

*             *****************************************************
*             add all objects collected except the preregistration*
              LOOP AT myt_objects INTO myl_objects.
                IF my_checkmark = 'X'.
                  EXIT.
                ENDIF.
                READ TABLE myt_conttr INDEX 1 INTO myl_conttr.
                IF myl_objects-object <> myl_conttr-object.
                  CLEAR my_rncto.
                  my_rncto-ctoty   = '1'.
                  my_rncto-ctoty_x = 'X'.
                  CALL METHOD my_new_context->add_obj_to_context
                    EXPORTING
                      i_object       = myl_objects-object
                      i_attributes   = my_rncto
                    IMPORTING
                      e_rc           = my_rc
                    CHANGING
                      c_errorhandler = my_errorhandler.
                  IF my_rc <> 0.
                    PERFORM proto_ishmed
                        USING 4 my_errorhandler myl_n1vkg-vkgid '(17)'.
                    my_checkmark = 'X'.
                    CONTINUE.
                  ENDIF.
                ENDIF.
              ENDLOOP.
*             *****************************************************
*             connect context to clinical order *******************
              CALL METHOD my_corder->add_connection
                EXPORTING
                  i_object = my_new_context.
            ENDIF.
          ENDLOOP.
*         *********************************************************
*         migrate long texts **************************************
          CLEAR: myl_lttypes, my_lttypes.
*         first we map the longtext types of the preregistration  *
*         and the Clinical Order onto each other ******************
*          APPEND my_vkg->co_text_kanam TO my_lttypes.
*          APPEND my_vkg->co_text_bmvkg TO my_lttypes.

          myl_lttypes-oldid = my_vkg->co_text_kanam.
          myl_lttypes-newid = my_corder->co_text_kanam.
          APPEND myl_lttypes TO my_lttypes.
          myl_lttypes-oldid = my_vkg->co_text_bmvkg.
          myl_lttypes-newid = my_corder->co_text_rmcord.
          APPEND myl_lttypes TO my_lttypes.

          CLEAR: myl_lttypes, my_tline.
*         now we get the prereg longtexts and create them for the *
*         Clinical Order ******************************************
          my_checkmark = ' '.
          LOOP AT my_lttypes INTO myl_lttypes.
            IF my_checkmark = 'X'.
              EXIT.
            ENDIF.
            CALL METHOD my_vkg->get_text
              EXPORTING
                i_text_id      = myl_lttypes-oldid
              IMPORTING
                e_rc           = my_rc
                et_tline       = my_tline
              CHANGING
                c_errorhandler = my_errorhandler.
            IF my_rc <> 0.
              PERFORM proto_ishmed
                  USING 4 my_errorhandler myl_n1vkg-vkgid '(18)'.
              my_checkmark = 'X'.
              CONTINUE.
            ENDIF.

*           Begin Grill - MED-31571
            DO 1 TIMES.
              CHECK myl_lttypes-oldid = cl_ishmed_prereg=>co_text_bmvkg.
              l_format_exist = space.
              LOOP AT my_tline INTO ls_tline.
                CHECK ls_tline-tdformat IS NOT INITIAL.
                l_format_exist = 'X'.
                EXIT.
              ENDLOOP.
              CHECK l_format_exist = space.
              LOOP AT my_tline ASSIGNING <ls_tline>.
                <ls_tline>-tdformat = '*'.
              ENDLOOP.
            ENDDO.
*           End   Grill - MED-31571

            IF NOT my_tline IS INITIAL.
              CALL METHOD my_corder->change_text
                EXPORTING
                  i_text_id      = myl_lttypes-newid
                  it_tline       = my_tline
                  i_tline_x      = 'X'
                IMPORTING
                  e_rc           = my_rc
                CHANGING
                  c_errorhandler = my_errorhandler.
              IF my_rc <> 0.
                PERFORM proto_ishmed
                    USING 4 my_errorhandler myl_n1vkg-vkgid '(19)'.
                my_checkmark = 'X'.
                CONTINUE.
              ENDIF.

            ENDIF.
          ENDLOOP.
*         *********************************************************
*         Migration of diagnoses and longtexts belonging to them **
*	   first we read the old ndip-diagnoses...******************
          CALL METHOD my_vkg->get_diagnosis
            	
            EXPORTING
*             I_CANCELLED_DATAS = OFF
              ir_environment    = my_environment1
            IMPORTING
              e_rc              = my_rc
              et_ndip           = myt_ndip	
            CHANGING
              cr_errorhandler   = my_errorhandler.
          IF my_rc <> 0.
            PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(20)'.
            CONTINUE.
          ENDIF.

*         then we create new diagnosis objects and connect them   *
*         to the corder *******************************************
          LOOP AT myt_ndip INTO myl_ndip.
            	
            CLEAR: my_diag_data, my_diagnosis.
            MOVE-CORRESPONDING myl_ndip TO my_diag_data.
            my_diag_data-vkgid = '0' .
            CALL METHOD cl_ish_prereg_diagnosis=>create
              EXPORTING
                is_data       = my_diag_data
                i_environment = my_environment
              IMPORTING
                e_instance    = my_diagnosis
              EXCEPTIONS
                OTHERS        = 2.

            CALL METHOD my_corder->add_connection
              EXPORTING
                i_object = my_diagnosis.
          ENDLOOP.
*         next we get the diagnosis so far in N1VKG and -         *
*	   if it exists its corresponding longtext, put alltogether*
*	   into a new diagnosis object and connect it to the corder*
          CLEAR my_tline.
          CALL METHOD my_vkg->get_data
            IMPORTING
              e_rc           = my_rc
              e_n1vkg        = myt_n1vkgnd
            CHANGING
              c_errorhandler = my_errorhandler.
          IF my_rc <> 0.
            PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(21)'.
            CONTINUE.
          ENDIF.

          IF NOT myt_n1vkgnd-ditxt IS INITIAL.
            CLEAR: my_diag_data, my_diagnosis.
            my_diag_data-ditxt = myt_n1vkgnd-ditxt.
*            my_diag_data-diltx = myt_n1vkgnd-diltx.  " ID 14520
            my_diag_data-diklat = 'X'.
            CALL METHOD cl_ish_prereg_diagnosis=>create
              EXPORTING
                is_data       = my_diag_data
                i_environment = my_environment
              IMPORTING
                e_instance    = my_diagnosis
              EXCEPTIONS
                OTHERS        = 2.

            IF myt_n1vkgnd-diltx EQ 'X'.
              CALL METHOD my_vkg->get_text
                EXPORTING
                  i_text_id      = my_vkg->co_text_ditxt
                IMPORTING
                  e_rc           = my_rc
                  et_tline       = my_tline
                CHANGING
                  c_errorhandler = my_errorhandler.
              IF my_rc <> 0.
                PERFORM proto_ishmed
                    USING 4 my_errorhandler myl_n1vkg-vkgid '(22)'.
                CONTINUE.
              ENDIF.

*             Michael Manoch, 02.06.2004, ID 14520   START
*              my_tid = my_diagnosis->get_text_id( ).
              my_tid = cl_ish_prereg_diagnosis=>co_text_diltxt.
*             Michael Manoch, 02.06.2004, ID 14520   END

              CALL METHOD my_diagnosis->change_text
                EXPORTING
                  i_text_id      = my_tid
                  it_tline       = my_tline
                  i_tline_x      = 'X'
                IMPORTING
                  e_rc           = my_rc
                CHANGING
                  c_errorhandler = my_errorhandler.
              IF my_rc <> 0.
                PERFORM proto_ishmed
                    USING 4 my_errorhandler myl_n1vkg-vkgid '(23)'.
                CONTINUE.
              ENDIF.
            ENDIF.
            CALL METHOD my_corder->add_connection
              EXPORTING
                i_object = my_diagnosis.
          ENDIF.
*         *********************************************************

*         load order positions ************************************
          CALL METHOD my_corder->get_t_cordpos
            IMPORTING
              et_cordpos      = myt_cordpos
              e_rc            = my_rc
            CHANGING
              cr_errorhandler = my_errorhandler.
          IF my_rc <> 0.
            PERFORM proto_ishmed
                USING 4 my_errorhandler myl_n1vkg-vkgid '(24)'.
            CONTINUE.
          ENDIF.
          my_checkmark = ' '.
          LOOP AT myt_cordpos INTO myl_cordpos.
            IF my_checkmark = 'X'.
              EXIT.
            ENDIF.
*           get app constraint for this position ******************
            CALL METHOD myl_cordpos->get_app_constraint
              IMPORTING
                er_app_constraint = my_appcon
                e_rc              = my_rc
              CHANGING
                cr_errorhandler   = my_errorhandler.
            IF my_rc <> 0.
              PERFORM proto_ishmed
                  USING 4 my_errorhandler myl_n1vkg-vkgid '(25)'.
              my_checkmark = 'X'.
              CONTINUE.
            ENDIF.

            my_cordtyp    = myl_cordpos->get_cordtyp( ).
            my_cordtypid  = my_cordtyp->get_cordtypid( ).
            my_cordposid  = myl_cordpos->get_vkgid( ).
*           *******************************************************
*           now we connect the appointments ***********************
            CLEAR my_ntm.
            IF my_cordtypid EQ my_cordtid_adm.
              READ TABLE my_ntmn INTO my_ntm
                           WITH KEY vkgid = myl_n1vkg-vkgid.
*             load the appointment object *************************
*             Käfer, ID: 14520 15072004 - Begin
*             only process further, when a real appointment is
*             within the internal table.
*             now it could be initial, because in coding above the
*             cancelled appointments will be removed from this table
              IF sy-subrc = 0 AND NOT my_ntm-tmnid IS INITIAL.
                CALL METHOD cl_ish_appointment=>load
                  EXPORTING
                    i_tmnid        = my_ntm-tmnid
                    i_environment  = my_environment
                  IMPORTING
                    e_instance     = my_appointment
                    e_rc           = my_rc
                  CHANGING
                    c_errorhandler = my_errorhandler.
                IF my_rc <> 0.
                  PERFORM proto_ishmed
                      USING 4 my_errorhandler myl_n1vkg-vkgid '(26)'.
                  my_checkmark = 'X'.
                  CONTINUE.
                ENDIF.
*               *****************************************************
*             Remove any old cordpos connections from appointment *
                CALL METHOD my_appointment->remove_connection
                  EXPORTING
                    i_type = cl_ishmed_prereg=>co_otype_prereg.
*             connect appointment to app constraint *************
                CALL METHOD my_appcon->add_connection
                  EXPORTING
                    i_object = my_appointment.
              ENDIF.
*             Käfer, ID: 14520 15072004 - End
            ENDIF.
*             now we connect services *****************************
            IF my_cordtypid = my_cordtid_tre.
*             update preregs without an anfid-entry, which are **
*	       no dummy services (according to sys param NPRGSRV)*
*             read it from v_nlem, write it to nlem. ************
              CLEAR: myt_serv_lnrls, myl_serv_lnrls.
              SELECT lnrls INTO TABLE myt_serv_lnrls FROM v_nlem
                    WHERE vkgid  = myl_n1vkg-vkgid
                    AND   ( anfid  LE '0'
                            OR anfid IS NULL )              " ID 14520
                    AND   leist  NE my_dummy_srv.

*             Käfer, ID: 14520 180604 - Begin
*             select the anchor-service too, because now the VKGID must
*             be inserted in the anchor-service too.
              READ TABLE myt_serv_lnrls INDEX 1 TRANSPORTING NO FIELDS.
              IF sy-subrc = 0.
                CLEAR: myl_serv_lnrls, lt_temp_lnrls, ll_temp_lnrls.

                LOOP AT myt_serv_lnrls INTO myl_serv_lnrls.
                  SELECT lnrls1 INTO ll_temp_lnrls
  		       FROM nllz
  		       WHERE lnrls2 = myl_serv_lnrls
  		         AND zotyp EQ 'F'.
                    	APPEND ll_temp_lnrls TO lt_temp_lnrls.
                  ENDSELECT.
                ENDLOOP.
                APPEND LINES OF lt_temp_lnrls TO myt_serv_lnrls.
              ENDIF.

*              LOOP AT myt_serv_lnrls INTO myl_serv_lnrls.
*                IF testx NE 'X'.   "only update if not testing mode
*                  UPDATE nlem
*                    SET   vkgid  = my_cordposid
*                    WHERE lnrls  = myl_serv_lnrls.
*                ENDIF.
*              ENDLOOP.
*              Käfer, ID: 14520 180604 - End

*               get the appointments related to this services and
*               connect them to the appointment constraint of the
*               order position *************************************
              CLEAR: myt_dum_tmnid, myl_dum_tmnid.
              SELECT tmnid vkgid FROM v_nlem INTO TABLE myt_dum_tmnid
                        WHERE vkgid  = myl_n1vkg-vkgid
                        AND   ( anfid  LE '0'
                                OR anfid IS NULL )          " ID 14520
                        AND   leist NE my_dummy_srv
                        AND tmnid IS NOT NULL               " ID 14520
                        AND tmnid NE ' '                    " ID 14520
                        AND tmnid GT '0'.
              IF sy-subrc = 0.
                my_checkmark = ' '.
*               Käfer, ID: 14520 180604 - Begin
                LOOP AT myt_serv_lnrls INTO myl_serv_lnrls.
                  IF testx NE 'X'.   "only update if not testing mode
                    UPDATE nlem
                      SET   vkgid  = my_cordposid
                      WHERE lnrls  = myl_serv_lnrls.
                  ENDIF.
                ENDLOOP.
*               Käfer, ID: 14520 180604 - End

                LOOP AT myt_dum_tmnid INTO myl_dum_tmnid.
                  IF my_checkmark = 'X'.
                    EXIT.
                  ENDIF.
*                   load the appointment object *********************
                  CALL METHOD cl_ish_appointment=>load
                    EXPORTING
                      i_tmnid        = myl_dum_tmnid-tmnid
                      i_environment  = my_environment
                    IMPORTING
                      e_instance     = my_appointment
                      e_rc           = my_rc
                    CHANGING
                      c_errorhandler = my_errorhandler.
                  IF my_rc <> 0.
                    PERFORM proto_ishmed
                        USING 4 my_errorhandler myl_n1vkg-vkgid '(27)'.
                    my_checkmark = 'X'.
                    CONTINUE.
                  ENDIF.

*                   *************************************************
*                   Remove any old cordpos connections from appointmt
                  CALL METHOD my_appointment->remove_connection
                    EXPORTING
                      i_type = cl_ishmed_prereg=>co_otype_prereg.
*                   connect appointment to app constraint ***********
                  CALL METHOD my_appcon->add_connection
                    EXPORTING
                      i_object = my_appointment.
                ENDLOOP.
*             Käfer, ID: 14520 180604 - Begin
              ELSE.
                LOOP AT myt_serv_lnrls INTO myl_serv_lnrls.
                  IF testx NE 'X'.   "only update if not testing mode
                    UPDATE nlem
                      SET   vkgid  = my_cordposid
                      WHERE lnrls  = myl_serv_lnrls.
                  ENDIF.
                ENDLOOP.
*             Käfer, ID: 14520 180604 - End
              ENDIF.
*               *****************************************************
*               convert those with anfid, which are******************
*	         no dummy services (according to sys param NPRGSRV)*

*             Käfer, ID: 14520 180604 - Begin
              REFRESH: myt_anfid.
*             Käfer, ID: 14520 180604 - End
              SELECT DISTINCT anfid
                        FROM v_nlem INTO TABLE myt_anfid
                        WHERE vkgid  = myl_n1vkg-vkgid
                        AND   anfid  GT '0'
                        AND   leist NE my_dummy_srv.
              IF sy-subrc = 0.
                CLEAR my_reqnctx.
                SELECT SINGLE cxtyp FROM ncxtyt
                  INTO my_reqnctx-cxtyp
                  WHERE cxtyp LIKE 'RQ%'
                    AND spras EQ 'D'
                   AND cxtypsn EQ 'Anforderungen'.          "#EC NOTEXT
                my_reqnctx-mandt = sy-mandt.
                IF NOT my_reqnctx-cxtyp IS INITIAL.
*                   create a context to hold requests ***************
                  CALL METHOD cl_ish_context=>create
                    EXPORTING
                      i_nctx         = my_reqnctx
                      i_environment  = my_environment
                    IMPORTING
                      e_instance     = my_req_context
                      e_rc           = my_rc
                    CHANGING
                      c_errorhandler = my_errorhandler.
                  IF my_rc <> 0.
                    PERFORM proto_ishmed
                        USING 4 my_errorhandler myl_n1vkg-vkgid '(28)'.
                    my_checkmark = 'X'.
                    CONTINUE.
                  ENDIF.

*                   add objects to the context **********************
*                   first the order itself **************************
                  CLEAR my_rncto.
                  my_rncto-ctoty = '0'.
                  my_rncto-ctoty_x = 'X'.
                  CALL METHOD my_req_context->add_obj_to_context
                    EXPORTING
                      i_object       = my_corder
                      i_attributes   = my_rncto
                    IMPORTING
                      e_rc           = my_rc
                    CHANGING
                      c_errorhandler = my_errorhandler.
                  IF my_rc <> 0.
                    PERFORM proto_ishmed
                        USING 4 my_errorhandler myl_n1vkg-vkgid '(29)'.
                    my_checkmark = 'X'.
                    CONTINUE.
                  ENDIF.
*                   load requests to put into the context ***********
                  LOOP AT myt_anfid INTO my_anfid.
                    IF my_checkmark = 'X'.
                      EXIT.
                    ENDIF.
                    CALL METHOD cl_ishmed_request=>load
                      EXPORTING
                        i_einri        = myl_n1vkg-einri
                        i_anfid        = my_anfid
                        i_environment  = my_environment
                      IMPORTING
                        e_instance     = my_request
                        e_rc           = my_rc
                      CHANGING
                        c_errorhandler = my_errorhandler.
                    IF my_rc <> 0.
                      PERFORM proto_ishmed
                      USING 4 my_errorhandler myl_n1vkg-vkgid '(30)'.
                      my_checkmark = 'X'.
                      CONTINUE.
                    ENDIF.

*                     ...and add it to the special context for it ***
                    CLEAR my_rncto.
                    my_rncto-ctoty = '1'.
                    my_rncto-ctoty_x = 'X'.
                    CALL METHOD my_req_context->add_obj_to_context
                      EXPORTING
                        i_object       = my_request
                        i_attributes   = my_rncto
                      IMPORTING
                        e_rc           = my_rc
                      CHANGING
                        c_errorhandler = my_errorhandler.
                    IF my_rc <> 0.
                      PERFORM proto_ishmed
                      USING 4 my_errorhandler myl_n1vkg-vkgid '(31)'.
                      my_checkmark = 'X'.
                      CONTINUE.
                    ENDIF.
                  ENDLOOP.
*                   connect context to clinical order ***************
                  CALL METHOD my_corder->add_connection
                    EXPORTING
                      i_object = my_req_context.
*                   clear the prereg key from nlem ******************
                  CLEAR: myt_serv_lnrls, myl_serv_lnrls.
                  SELECT lnrls INTO TABLE myt_serv_lnrls FROM v_nlem
                     WHERE vkgid  = myl_n1vkg-vkgid
*                    Käfer, ID: 14520 05072004 - Begin
*                     AND   ( anfid  LE '0'
*                             OR anfid IS NULL )             " ID 14520
                     AND   anfid GT '0'
*                    Käfer, ID: 14520 05072004 - End
                     AND   leist  NE my_dummy_srv.
                  LOOP AT myt_serv_lnrls INTO myl_serv_lnrls.
                    IF testx NE 'X'. "only update if not testing mode
                      UPDATE nlem
                        SET   vkgid  = space
                        WHERE lnrls  = myl_serv_lnrls.
                    ENDIF.
                  ENDLOOP.
                ENDIF.
              ENDIF.
*               *****************************************************
*               finally, we connect those appointments which were re*
*	         lated to the prereg via a dummy_service*
*             Käfer, ID: 14520 180604 - Begin
              REFRESH: myt_dum_tmnid.
*             Käfer, ID: 14520 180604 - End
              SELECT tmnid vkgid FROM v_nlem INTO TABLE myt_dum_tmnid
                        WHERE vkgid  = myl_n1vkg-vkgid
                        AND   leist EQ my_dummy_srv
                        AND tmnid GT '0'
                        AND tmnid IS NOT NULL               " ID 14520
                        AND tmnid NE ' '.                   " ID 14520
              IF sy-subrc = 0.
                my_checkmark = ' '.
                LOOP AT myt_dum_tmnid INTO myl_dum_tmnid.
                  IF my_checkmark = 'X'.
                    EXIT.
                  ENDIF.
*                  load the appointment object *********************
                  CALL METHOD cl_ish_appointment=>load
                    EXPORTING
                      i_tmnid        = myl_dum_tmnid-tmnid
                      i_environment  = my_environment
                    IMPORTING
                      e_instance     = my_appointment
                      e_rc           = my_rc
                    CHANGING
                      c_errorhandler = my_errorhandler.
                  IF my_rc <> 0.
                    PERFORM proto_ishmed
                        USING 4 my_errorhandler myl_n1vkg-vkgid '(32)'.
                    my_checkmark = 'X'.
                    CONTINUE.
                  ENDIF.
*                 *************************************************
*                 Remove any old cordpos connections from appointment
                  CALL METHOD my_appointment->remove_connection
                    EXPORTING
                      i_type = cl_ishmed_prereg=>co_otype_prereg.
*                 connect appointment to app constraint ***********
                  CALL METHOD my_appcon->add_connection
                    EXPORTING
                      i_object = my_appointment.
                  	
  	         ENDLOOP.
                ENDIF.
*                 ***************************************************
              ENDIF.
            ENDLOOP.
*             save the Clinical Order *******************************
            CALL METHOD my_corder->save
              EXPORTING
                i_testrun           = testx
                i_save_conn_objects = 'X'
                i_tcode             = sy-tcode
              IMPORTING
                e_rc                = my_rc
              CHANGING
                c_errorhandler      = my_errorhandler.
*             ****************************************************
*             save the movements *********************************
            IF my_rc = 0.
              CLEAR: lt_cordpos,
                     lt_app,
                     lt_vnlei,
                     lt_lfdbew.
              DO 1 TIMES.
*               Get the new cordpos objects.
                CALL METHOD my_corder->get_t_cordpos
                  IMPORTING
                    et_cordpos      = lt_cordpos
                    e_rc            = my_rc
                  CHANGING
                    cr_errorhandler = my_errorhandler.
                CHECK my_rc = 0.
                LOOP AT lt_cordpos INTO lr_cordpos.
                  CHECK NOT lr_cordpos IS INITIAL.
                  CALL METHOD lr_cordpos->get_data
                    IMPORTING
                      e_rc           = my_rc
                      e_n1vkg        = ls_n1vkg
                    CHANGING
                      c_errorhandler = my_errorhandler.
                  CHECK my_rc = 0.
*                 Update movements only if there is a case.
                  CHECK NOT ls_n1vkg-falnr IS INITIAL.
*                 Get the app_constraint and apcnid.
                  CALL METHOD lr_cordpos->get_app_constraint
                    IMPORTING
                      er_app_constraint = lr_ac
                      e_rc              = my_rc
                    CHANGING
                      cr_errorhandler   = my_errorhandler.
                  CHECK my_rc = 0.
                  CHECK NOT lr_ac IS INITIAL.
                  CALL METHOD lr_ac->get_data
                    IMPORTING
                      e_rc            = my_rc
                      es_n1apcn       = ls_n1apcn
                    CHANGING
                      cr_errorhandler = my_errorhandler.
                  CHECK my_rc = 0.
*                 Get movements via appointments.
                  CALL METHOD lr_ac->get_t_app
                    IMPORTING
                      et_apps         = lt_app
                      e_rc            = my_rc
                    CHANGING
                      cr_errorhandler = my_errorhandler.
                  CHECK my_rc = 0.
                  LOOP AT lt_app INTO lr_app.
                    CHECK NOT lr_app IS INITIAL.
                    CALL METHOD lr_app->get_data
                      EXPORTING
                        i_fill_appointment = space
                      IMPORTING
                        es_ntmn            = ls_ntmn
                        e_rc               = my_rc
                      CHANGING
                        c_errorhandler     = my_errorhandler.
                    CHECK my_rc = 0.
                    CHECK NOT ls_ntmn-tmnlb IS INITIAL.
                    APPEND ls_ntmn-tmnlb TO lt_lfdbew.
                  ENDLOOP.
                  CHECK my_rc = 0.
*                 Get movements via services.
                  CALL METHOD
                    cl_ishmed_prereg=>get_services_for_prereg
                    EXPORTING
                      i_prereg       = lr_cordpos
                      i_read_db      = space
                    IMPORTING
                      e_rc           = my_rc
                      et_nlei        = lt_vnlei
                    CHANGING
                      c_errorhandler = my_errorhandler.
                  CHECK my_rc = 0.
                  LOOP AT lt_vnlei ASSIGNING <ls_vnlei>.
                    CHECK NOT <ls_vnlei>-lfdbew IS INITIAL.
                    APPEND <ls_vnlei>-lfdbew TO lt_lfdbew.
                  ENDLOOP.
*                 Update movements (connect with apcn).
                  SORT lt_lfdbew.
                  DELETE ADJACENT DUPLICATES FROM lt_lfdbew.
                  LOOP AT lt_lfdbew ASSIGNING <l_lfdbew>.
                    CHECK NOT <l_lfdbew> IS INITIAL.
                    IF testx NE 'X'.
                      UPDATE nbew
                        SET apcnid = ls_n1apcn-apcnid
                        WHERE einri = ls_n1vkg-einri
                          AND falnr = ls_n1vkg-falnr
                          AND lfdnr = <l_lfdbew>.
                    ENDIF.
                  ENDLOOP.
                ENDLOOP.
                CHECK my_rc = 0.
              ENDDO.
            ENDIF.
*             ****************************************************
            IF my_rc <> 0.
*               log it and process it later manually ****************
              PERFORM proto_ishmed
                       USING 4 my_errorhandler myl_n1vkg-vkgid '(33)'.
*               codify the failure into N1VKG-stusr ****************
              IF testx NE 'X'.   "only update if not testing mode
*               Michael Manoch, 02.06.2004, ID 14520   START
*               Discharge any db-updates for this preregistration
                ROLLBACK WORK.
*               Michael Manoch, 02.06.2004, ID 14520   END
                UPDATE n1vkg SET stusr = '@#NOK#@'
                     WHERE vkgid = myl_n1vkg-vkgid.
*               Michael Manoch, 02.06.2004, ID 14520   START
*               Commit the n1vkg-failure.
                COMMIT WORK AND WAIT.
*               Michael Manoch, 02.06.2004, ID 14520   END
              ENDIF.
            ELSE.
*               *****************************************************
*               codify the sucess into N1VKG-stusr ******************
              my_convcount = my_convcount + 1.

              IF testx NE 'X'.   "only update if not testing mode
                UPDATE n1vkg SET stusr = '@#OK#@'
                                 storn = 'X'          "Käfer, ID: 14520
                       WHERE vkgid = myl_n1vkg-vkgid.
              ENDIF.
*               *****************************************************
            ENDIF.
          ENDIF.
*         Michael Manoch, 02.06.2004, ID 14520   START
*         ***********************************************************
*         Commit/Rollback the one migrated preregistration
          IF testx NE 'X'.   "only update if not testing mode
            IF my_rc = 0.
              COMMIT WORK AND WAIT.
*             Käfer, ID: 14520 07072004 - Begin
*             if there are two anchor-services connected to the
*             orderposition, so delete the second one.
              LOOP AT myt_cordpos INTO myl_cordpos.
                CALL METHOD myl_cordpos->is_op
                  IMPORTING
                    e_is_op = l_is_op.
                CHECK l_is_op = 'X'.
                my_cordposid = myl_cordpos->get_vkgid( ).
                REFRESH myt_serv_lnrls.
                SELECT lnrls FROM v_nlem INTO TABLE myt_serv_lnrls
                  WHERE vkgid = my_cordposid
                    AND ankls = 'X'
                    AND storn = ' '.
                CHECK sy-subrc = 0.
                l_count = 0.
                DESCRIBE TABLE myt_serv_lnrls LINES l_count.
                CHECK l_count = 2.
                SORT myt_serv_lnrls DESCENDING.
                READ TABLE myt_serv_lnrls INTO myl_serv_lnrls INDEX 1.
                DELETE FROM nlei WHERE lnrls = myl_serv_lnrls.
                DELETE FROM nlem WHERE lnrls = myl_serv_lnrls.
                COMMIT WORK AND WAIT.
              ENDLOOP.
*             Käfer, ID: 14520 07072004 - End
            ELSE.
              ROLLBACK WORK.
            ENDIF.
          ENDIF.
*         ***********************************************************
*         Michael Manoch, 02.06.2004, ID 14520   END
        ENDIF.
      ENDLOOP.
*     Michael Manoch, 02.06.2004, ID 14520   START
*     COMMIT WORK on each single migrated preregistration.
**       now we commit the last couple of preregs we migrated ********
*      IF testx NE 'X'.   "only update if not testing mode
*        COMMIT WORK AND WAIT.
*      ENDIF.
*     Michael Manoch, 02.06.2004, ID 14520   END
*       *************************************************************
    ENDIF.
  ENDWHILE.
*********************************************************************

* in testing mode runtime is measured *******************************
  IF testx EQ 'X'.
    GET RUN TIME FIELD t2.
    COMPUTE dt = ( t2 - t1 ) / 1000000.
    PERFORM proto USING
              4 space 'N1BASE' '125' my_convcount my_count dt space.
  ENDIF.
*********************************************************************

* log the end of this program ***************************************
  PERFORM proto USING
            4 space 'N1BASE' '111' sy-repid sy-datum sy-uzeit space.
*********************************************************************

* now we append our logs to the general XPRA-logging-framework ******
  CALL FUNCTION 'TR_APPEND_LOG'
* EXPORTING
*   CONDENSE                     = 'X'
*   MASTER_LANGU                 = 'E'
*   ACCEPT_NOT_INIT              = ' '
*   IV_SUPPRESS_STATISTICS       = ' '
    TABLES
      xmsg                         = myt_iprot
* EXCEPTIONS
*   FILE_NOT_FOUND               = 1
*   WRONG_CALL                   = 2
*   OTHERS                       = 3
  .
*********************************************************************
* >>> if you run the program standalone uncomment the following line*
  CALL FUNCTION 'TR_FLUSH_LOG'.
*********************************************************************

* we're done ********************************************************

*--------------------------------------------------------------------
*--------------------------------------------------------------------

*********************************************************************
* FORM PROTO
* -> P_LEVEL   Level 1|2|3|4
* -> P_SEVER   SEVERITY ''|W|P|E|A
* -> P_AG      message class
* -> P_MSGNR   message number
* -> P_VAR1    &-Variable 1
* -> P_VAR2    &-Variable 2
* -> P_VAR3    &-Variable 3
* -> P_VAR4    &-Variable 4
*********************************************************************
FORM proto USING  p_level   TYPE n
                  p_sever   TYPE c
                  p_ag      TYPE sy-msgid
                  p_msgnr   TYPE sy-msgno
                  p_var1
                  p_var2
                  p_var3
                  p_var4.

  CLEAR myt_iprot.
  myt_iprot-level     = p_level.
  myt_iprot-severity  = p_sever.
  myt_iprot-langu     = sy-langu.
  myt_iprot-ag        = p_ag.
  myt_iprot-msgnr     = p_msgnr.
  myt_iprot-newobj    = ' '.
  myt_iprot-var1      = p_var1.
  myt_iprot-var2      = p_var2.
  myt_iprot-var3      = p_var3.
  myt_iprot-var4      = p_var4.
  APPEND myt_iprot.
ENDFORM.                    "PROTO
*********************************************************************
*********************************************************************
* FORM PROTO_ISHMED
* append ishmed errorhandler messages to general log
* -> P_LEVEL          Level 1|2|3|4
* -> P_ERRORHANDLER
*********************************************************************
FORM proto_ishmed USING
        p_level   TYPE n
        p_errorhandler TYPE REF TO cl_ishmed_errorhandling
        p_vkgid  TYPE n1vkg-vkgid
        p_intcd.

  DATA:  lt_exmsg         TYPE ishmed_t_messages,
         ll_exmsg         LIKE LINE OF lt_exmsg.

  CLEAR: lt_exmsg, ll_exmsg.
  CALL METHOD p_errorhandler->get_messages
    IMPORTING
      t_extended_msg = lt_exmsg.

  PERFORM proto USING
              4 space 'N1BASE' '124' p_vkgid p_intcd space space.
  IF NOT lt_exmsg IS INITIAL.
    LOOP AT lt_exmsg INTO ll_exmsg.
      PERFORM proto USING p_level
                          ll_exmsg-type
                          ll_exmsg-id
                          ll_exmsg-number
                          ll_exmsg-message_v1
                          ll_exmsg-message_v2
                          ll_exmsg-message_v3
                          ll_exmsg-message_v4.

    ENDLOOP.
  ELSE.
    PERFORM proto USING
              4 space 'N1BASE' '126' space space space space.

  ENDIF.
ENDFORM.                    "PROTO_ISHMED
