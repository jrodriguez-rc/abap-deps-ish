class CL_ISH_STATUS definition
  public
  create public .

public section.
*"* public components of class CL_ISH_STATUS
*"* do not include other source files here!!!

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
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

  constants CO_OTYPE_STATUS type ISH_OBJECT_TYPE value 62. "#EC NOTEXT

  class-methods CHANGE_STATUS
    importing
      value(I_OBJNR) type J_OBJNR
      value(I_STATUS) type J_STATUS
      value(I_ESTAT) type J_ESTAT
      value(I_SET_INACT) type ISH_ON_OFF default OFF
      value(I_SET_CHGKZ) type ISH_ON_OFF default ON
      value(I_COMMIT) type ISH_ON_OFF default ON
      value(I_NO_CHECK) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods COPY_STATUS
    importing
      value(I_SRC_OBJNR) type J_OBJNR
      value(I_DEST_OBJNR) type J_OBJNR
      value(I_OBTYP) type J_OBTYP
      value(I_STATUS) type J_STATUS
      value(I_STSMA) type J_STSMA
      value(I_SET_CHGKZ) type ISH_ON_OFF default ON
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
  class-methods CREATE_STATUS
    importing
      value(I_OBTYP) type J_OBTYP
      value(I_OBJNR) type J_OBJNR
      value(I_STATUS) type J_STATUS optional
      value(I_STSMA) type J_STSMA
      value(I_ESTAT) type J_ESTAT optional
      value(I_SET_INACT) type ISH_ON_OFF default OFF
      value(I_SET_CHGKZ) type ISH_ON_OFF default ON
      value(I_SAVE) type ISH_ON_OFF default ON
      value(I_COMMIT) type ISH_ON_OFF default ON
      value(I_NO_CHECK) type ISH_ON_OFF default OFF
    exporting
      value(E_OBJNR) type J_OBJNR
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods READ_T_STATUS
    importing
      value(IT_OBJNR) type ISH_T_OBJNR
      value(I_ONLY_ACTIVE) type ISH_ON_OFF default ON
      value(I_SYST_STATUS) type ISH_ON_OFF default OFF
    exporting
      value(ET_STATUS) type ISH_T_OBJSTATUS
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods READ_STATUS
    importing
      value(I_OBJNR) type J_OBJNR
      value(I_ONLY_ACTIVE) type ISH_ON_OFF default ON
      value(I_SYST_STATUS) type ISH_ON_OFF default OFF
    exporting
      value(E_STSMA) type J_STSMA
      value(E_ESTAT) type J_STATUS
      value(E_OBTYP) type J_OBTYP
      value(ER_STSMA) type ref to CL_ISH_STSMA
      value(ER_ESTAT) type ref to CL_ISH_ESTAT
      value(ET_STAT) type NJSTAT_TAB
      value(ET_STATUS) type ISH_T_STATUS
      value(ET_ESTAT) type ISH_T_ESTAT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_STATUS
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_STATUS
*"* do not include other source files here!!!

  class-methods INIT_MESG .
  class-methods STORE_MESG
    importing
      value(IT_MESG) type TSMESG .
ENDCLASS.



CLASS CL_ISH_STATUS IMPLEMENTATION.


METHOD change_status .

  DATA: lt_jstat       TYPE TABLE OF jstat,
        ls_jstat       TYPE jstat.

  DATA: l_mesg_active  TYPE c,
        lt_mesg_temp   TYPE tsmesg,
        lt_mesg        TYPE tsmesg,
        l_mesg         TYPE LINE OF tsmesg,
        l_msgno        TYPE sy-msgno.

  e_rc = 0.

*-----------------------------------
* check/create object errorhandler
*-----------------------------------
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

*-------------------------
* check import parameter
*-------------------------
  IF i_objnr IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'CHANGE_STATUS'
        i_mv3 = 'I_OBJNR'.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF i_status IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'CHANGE_STATUS'
        i_mv3 = 'I_STATUS'.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF i_estat IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'CHANGE_STATUS'
        i_mv3 = 'I_ESTAT'.
    e_rc = 1.
    EXIT.
  ENDIF.

*-----------------------------------
* check if message queue is active
*-----------------------------------
  CALL FUNCTION 'MESSAGES_ACTIVE'
*   IMPORTING
*     MAX_SEVERITY       =
*     ZEILE              =
    EXCEPTIONS
      not_active         = 1
      OTHERS             = 2.
  IF sy-subrc = 0.
    l_mesg_active = 'X'.
  ELSE.
    l_mesg_active = ' '.
  ENDIF.

  IF l_mesg_active = 'X'.
*-------------------------------------------------------
*   message queue is active => save collected messages
*-------------------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*     EXPORTING
*       I_ZEILE            = ' '
*       I_INCL_TITLE       = 'X'
      TABLES
        t_mesg             = lt_mesg_temp.
*-------------------------------------------
*   start and initialize new message queue
*-------------------------------------------
    CALL METHOD init_mesg.
  ENDIF.                        " IF l_mesg_active='X'.

*--------------------
* set system status
*--------------------
  ls_jstat-stat = i_status.
  APPEND ls_jstat TO lt_jstat.

  CALL FUNCTION 'STATUS_CHANGE_INTERN'
    EXPORTING
*     CHECK_ONLY                = ' '
*     CLIENT                    = SY-MANDT
      objnr                     = i_objnr
*     ZEILE                     = ' '
      set_chgkz                 = i_set_chgkz
*   IMPORTING
*     ERROR_OCCURRED            =
*     OBJECT_NOT_FOUND          =
*     STATUS_INCONSISTENT       =
*     STATUS_NOT_ALLOWED        =
    TABLES
      status                    = lt_jstat
   EXCEPTIONS
     object_not_found          = 1
     status_inconsistent       = 2
     status_not_allowed        = 3
     OTHERS                    = 4.
* Error
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    e_rc = 1.
  ENDIF.

  IF l_mesg_active = 'X'.
*-----------------------------------------------
*   read collected messages from message queue
*-----------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*     EXPORTING
*       I_ZEILE            = ' '
*       I_INCL_TITLE       = 'X'
      TABLES
        t_mesg             = lt_mesg.
    LOOP AT lt_mesg INTO l_mesg.
      l_msgno = l_mesg-txtnr.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = l_mesg-msgty
          i_kla = l_mesg-arbgb
          i_num = l_msgno
          i_mv1 = l_mesg-msgv1.
      e_rc = 1.
    ENDLOOP.
  ENDIF.               " IF l_mesg_active='X'.

  IF e_rc = 1.
    IF l_mesg_active = 'X'.
*---------------------------------------------
*     start and initialize new message queue
*---------------------------------------------
      CALL METHOD init_mesg.
*---------------------------------------------------
*     save back original messages to message queue
*---------------------------------------------------
      CALL METHOD store_mesg
        EXPORTING
          it_mesg = lt_mesg_temp.
    ENDIF.
    EXIT.
  ENDIF.

*--------------------
* set extern status
*---------------------
  CALL FUNCTION 'STATUS_CHANGE_EXTERN'
    EXPORTING
*     CHECK_ONLY                = ' '
*     CLIENT                    = SY-MANDT
      objnr                     = i_objnr
      user_status               = i_estat
      set_inact                 = i_set_inact
      set_chgkz                 = i_set_chgkz
      no_check                  = i_no_check
*   IMPORTING
*     STONR                     =
    EXCEPTIONS
      object_not_found          = 1
      status_inconsistent       = 2
      status_not_allowed        = 3
      OTHERS                    = 4.
* Error
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    e_rc = 1.
  ENDIF.

  IF l_mesg_active = 'X'.
*-----------------------------------------------
*   read collected messages from message queue
*-----------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*     EXPORTING
*       I_ZEILE            = ' '
*       I_INCL_TITLE       = 'X'
      TABLES
        t_mesg             = lt_mesg.
    LOOP AT lt_mesg INTO l_mesg.
      l_msgno = l_mesg-txtnr.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = l_mesg-msgty
          i_kla = l_mesg-arbgb
          i_num = l_msgno
          i_mv1 = l_mesg-msgv1.
      e_rc = 1.
    ENDLOOP.
  ENDIF.                   " IF l_mesg_active='X'.

  IF l_mesg_active = 'X'.
*---------------------------------------------
*   start and initialize new message queue
*---------------------------------------------
    CALL METHOD init_mesg.
*---------------------------------------------------
*   save back original messages to message queue
*---------------------------------------------------
    CALL METHOD store_mesg
      EXPORTING
        it_mesg = lt_mesg_temp.
  ENDIF.

*----------------
* error -> exit
*----------------
  IF e_rc = 1.
    EXIT.
  ENDIF.

*------------------
* commit work
*------------------
  IF i_commit = 'X'.
    COMMIT WORK AND WAIT.
  ENDIF.

ENDMETHOD.


METHOD copy_status.

  DATA: l_dest_objnr   TYPE jsto-objnr.

  DATA: l_mesg_active  TYPE c,
        lt_mesg_temp   TYPE tsmesg,
        lt_mesg        TYPE tsmesg,
        l_mesg         TYPE LINE OF tsmesg,
        l_msgno        TYPE sy-msgno.

  e_rc = 0.

* -----------------------------------
* check/create object errorhandler
* -----------------------------------
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* -------------------------
* check import parameter
* -------------------------
  IF i_src_objnr IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'COPY_STATUS'
        i_mv3 = 'I_SRC_OBJNR'.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF i_dest_objnr IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'COPY_STATUS'
        i_mv3 = 'I_DEST_OBJNR'.
    e_rc = 1.
    EXIT.
  ENDIF.

  l_dest_objnr = i_dest_objnr.

* -----------------------
* create status object
* -----------------------
  CALL METHOD cl_ish_status=>create_status
    EXPORTING
      i_obtyp         = i_obtyp
      i_objnr         = l_dest_objnr
*      I_STATUS        =
      i_stsma         = i_stsma
*      I_ESTAT         =
*      I_SET_INACT     = OFF
      i_set_chgkz     = i_set_chgkz
      i_save          = off
      i_commit        = off
*      I_NO_CHECK      = OFF
    IMPORTING
      e_rc            = e_rc
      e_objnr         = l_dest_objnr
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

*-----------------------------------
* check if message queue is active
*-----------------------------------
  CALL FUNCTION 'MESSAGES_ACTIVE'
*   IMPORTING
*     MAX_SEVERITY       =
*     ZEILE              =
    EXCEPTIONS
      not_active         = 1
      OTHERS             = 2.
  IF sy-subrc = 0.
    l_mesg_active = 'X'.
  ELSE.
    l_mesg_active = ' '.
  ENDIF.

  IF l_mesg_active = 'X'.
*-------------------------------------------------------
*   message queue is active => save collected messages
*-------------------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*     EXPORTING
*       I_ZEILE            = ' '
*       I_INCL_TITLE       = 'X'
      TABLES
        t_mesg             = lt_mesg_temp.
*-------------------------------------------
*   start and initialize new message queue
*-------------------------------------------
    CALL METHOD init_mesg.
  ENDIF.                         " IF l_mesg_active='X'.

* -----------------------
* copy status
* -----------------------
  CALL FUNCTION 'STATUS_COPY'
    EXPORTING
*      CLIENT                       = SY-MANDT
      objnr_quelle                 = i_src_objnr
      objnr_ziel                   = l_dest_objnr
   EXCEPTIONS
     quell_object_not_found       = 1
     ziel_object_not_found        = 2
     OTHERS                       = 3.

  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    e_rc = 1.
  ENDIF.

  IF l_mesg_active = 'X'.
*-----------------------------------------------
*   read collected messages from message queue
*-----------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*       EXPORTING
*         I_ZEILE            = ' '
*         I_INCL_TITLE       = 'X'
        TABLES
          t_mesg             = lt_mesg.
    LOOP AT lt_mesg INTO l_mesg.
      l_msgno = l_mesg-txtnr.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = l_mesg-msgty
          i_kla = l_mesg-arbgb
          i_num = l_msgno
          i_mv1 = l_mesg-msgv1.
      e_rc = 1.
    ENDLOOP.
  ENDIF.                     " IF l_mesg_active='X'.

  IF e_rc = 1.
    IF l_mesg_active = 'X'.
*---------------------------------------------
*     start and initialize new message queue
*---------------------------------------------
      CALL METHOD init_mesg.
*---------------------------------------------------
*     save back original messages to message queue
*---------------------------------------------------
      CALL METHOD store_mesg
        EXPORTING
          it_mesg = lt_mesg_temp.
    ENDIF.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD create_status .

  DATA: l_objnr        TYPE j_objnr,
        l_obart(2)     TYPE c,
        l_tbo00        TYPE tbo00,
        l_jsto         TYPE jsto.

  DATA: lt_jstat       TYPE TABLE OF jstat,
        ls_jstat       TYPE jstat.

  DATA: l_mesg_active  TYPE c,
        lt_mesg_temp   TYPE tsmesg,
        lt_mesg        TYPE tsmesg,
        l_mesg         TYPE LINE OF tsmesg,
        l_msgno        TYPE sy-msgno.

  e_rc = 0.
  clear e_objnr.

*-----------------------------------
* check/create object errorhandler
*-----------------------------------
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

*-------------------------
* check import parameter
*-------------------------
  IF i_obtyp IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'CREATE_STATUS'
        i_mv3 = 'I_OBTYP'.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF i_objnr IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'CREATE_STATUS'
        i_mv3 = 'I_OBJNR'.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF i_stsma IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'CREATE_STATUS'
        i_mv3 = 'I_STSMA'.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF i_status IS INITIAL and i_save = on.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'CREATE_STATUS'
        i_mv3 = 'I_STATUS'.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF i_estat IS INITIAL AND i_save = on.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'CREATE_STATUS'
        i_mv3 = 'I_ESTAT'.
    e_rc = 1.
    EXIT.
  ENDIF.

*--------------------------------------------------
* check if objnr already exists in database
*(otherwise the attempt writing the object to the
* database would end with an error)
*--------------------------------------------------
  l_objnr = i_objnr.

  SELECT SINGLE * FROM jsto INTO l_jsto
           WHERE objnr = l_objnr.
  IF sy-subrc = 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '027'
        i_mv1 = l_objnr.
    e_rc = 1.
    EXIT.
  ENDIF.

*------------------------------------------------------
* check if object type of new objnr is valid
* (otherwise the action would end with a dump)
*------------------------------------------------------
  l_obart = l_objnr(2).

  SELECT SINGLE * FROM tbo00 INTO l_tbo00
           WHERE obart = l_obart.
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '028'
        i_mv1 = l_obart.
    e_rc = 1.
    EXIT.
  ENDIF.

*-----------------------------------
* check if message queue is active
*-----------------------------------
  CALL FUNCTION 'MESSAGES_ACTIVE'
*   IMPORTING
*     MAX_SEVERITY       =
*     ZEILE              =
    EXCEPTIONS
      not_active         = 1
      OTHERS             = 2.
  IF sy-subrc = 0.
    l_mesg_active = 'X'.
  ELSE.
    l_mesg_active = ' '.
  ENDIF.

  IF l_mesg_active = 'X'.
*-------------------------------------------------------
*   message queue is active => save collected messages
*-------------------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*     EXPORTING
*       I_ZEILE            = ' '
*       I_INCL_TITLE       = 'X'
      TABLES
        t_mesg             = lt_mesg_temp.
*-------------------------------------------
*   start and initialize new message queue
*-------------------------------------------
    CALL METHOD init_mesg.
  ENDIF.                         " IF l_mesg_active='X'.

*-----------------------
* create status object
*-----------------------
  CALL FUNCTION 'STATUS_OBJECT_CREATE'
    EXPORTING
     chgkz                              = on
*    CLIENT                             = SY-MANDT
     objnr                              = l_objnr
     obtyp                              = i_obtyp
     stsma                              = i_stsma
*    IONRA_IMP                          =
*    I_OBJECTKEY                        =
   IMPORTING
     objnr                              = l_objnr
*    STONR                              =
   EXCEPTIONS
     obtyp_invalid                      = 1
     status_object_already_exists       = 2
     stsma_invalid                      = 3
     stsma_obtyp_invalid                = 4
     OTHERS                             = 5.

  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    e_rc = 1.
  ENDIF.

  IF l_mesg_active = 'X'.
*-----------------------------------------------
*   read collected messages from message queue
*-----------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*       EXPORTING
*         I_ZEILE            = ' '
*         I_INCL_TITLE       = 'X'
        TABLES
          t_mesg             = lt_mesg.
    LOOP AT lt_mesg INTO l_mesg.
      l_msgno = l_mesg-txtnr.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = l_mesg-msgty
          i_kla = l_mesg-arbgb
          i_num = l_msgno
          i_mv1 = l_mesg-msgv1.
      e_rc = 1.
    ENDLOOP.
  ENDIF.                     " IF l_mesg_active='X'.

  IF e_rc = 1.
    IF l_mesg_active = 'X'.
*---------------------------------------------
*     start and initialize new message queue
*---------------------------------------------
      CALL METHOD init_mesg.
*---------------------------------------------------
*     save back original messages to message queue
*---------------------------------------------------
      CALL METHOD store_mesg
        EXPORTING
          it_mesg = lt_mesg_temp.
    ENDIF.
    EXIT.
  ENDIF.

*----------------------------
* return object number
*----------------------------
  e_objnr = l_objnr.

*----------------------------
* save only if requested
*----------------------------
  CHECK i_save = on.

*----------------------------
* set initial system status
*----------------------------
  ls_jstat-stat = i_status.
  APPEND ls_jstat TO lt_jstat.

  CALL FUNCTION 'STATUS_CHANGE_INTERN'
    EXPORTING
*     CHECK_ONLY                = ' '
*     CLIENT                    = SY-MANDT
      objnr                     = l_objnr
*     ZEILE                     = ' '
      set_chgkz                 = i_set_chgkz
*   IMPORTING
*     ERROR_OCCURRED            =
*     OBJECT_NOT_FOUND          =
*     STATUS_INCONSISTENT       =
*     STATUS_NOT_ALLOWED        =
    TABLES
      status                    = lt_jstat
   EXCEPTIONS
     object_not_found           = 1
     status_inconsistent        = 2
     status_not_allowed         = 3
     OTHERS                     = 4.
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    e_rc = 1.
  ENDIF.

  IF l_mesg_active = 'X'.
*-----------------------------------------------
*   read collected messages from message queue
*-----------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*       EXPORTING
*         I_ZEILE            = ' '
*         I_INCL_TITLE       = 'X'
        TABLES
          t_mesg             = lt_mesg.
    LOOP AT lt_mesg INTO l_mesg.
      l_msgno = l_mesg-txtnr.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = l_mesg-msgty
          i_kla = l_mesg-arbgb
          i_num = l_msgno
          i_mv1 = l_mesg-msgv1.
      e_rc = 1.
    ENDLOOP.
  ENDIF.                   " IF l_mesg_active='X'.

  IF e_rc = 1.
    IF l_mesg_active = 'X'.
*---------------------------------------------
*     start and initialize new message queue
*---------------------------------------------
      CALL METHOD init_mesg.
*---------------------------------------------------
*     save back original messages to message queue
*---------------------------------------------------
      CALL METHOD store_mesg
        EXPORTING
          it_mesg = lt_mesg_temp.
    ENDIF.
    EXIT.
  ENDIF.

*----------------------------
* set initial extern status
*----------------------------
  CALL FUNCTION 'STATUS_CHANGE_EXTERN'
    EXPORTING
*     CHECK_ONLY                = ' '
*     CLIENT                    = SY-MANDT
      objnr                     = l_objnr
      user_status               = i_estat
      set_inact                 = i_set_inact
      set_chgkz                 = i_set_chgkz
      no_check                  = i_no_check
*   IMPORTING
*     STONR                     =
    EXCEPTIONS
      object_not_found          = 1
      status_inconsistent       = 2
      status_not_allowed        = 3
      OTHERS                    = 4.
* Error
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    e_rc = 1.
  ENDIF.

  IF l_mesg_active = 'X'.
*-----------------------------------------------
*   read collected messages from message queue
*-----------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
*       EXPORTING
*         I_ZEILE            = ' '
*         I_INCL_TITLE       = 'X'
        TABLES
          t_mesg             = lt_mesg.
    LOOP AT lt_mesg INTO l_mesg.
      l_msgno = l_mesg-txtnr.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = l_mesg-msgty
          i_kla = l_mesg-arbgb
          i_num = l_msgno
          i_mv1 = l_mesg-msgv1.
      e_rc = 1.
    ENDLOOP.
  ENDIF.                            " IF l_mesg_active='X'.

  IF l_mesg_active = 'X'.
*---------------------------------------------
*   start and initialize new message queue
*---------------------------------------------
    CALL METHOD init_mesg.
*---------------------------------------------------
*   save back original messages to message queue
*---------------------------------------------------
    CALL METHOD store_mesg
      EXPORTING
        it_mesg = lt_mesg_temp.
  ENDIF.

*----------------
* error -> exit
*----------------
  IF e_rc = 1.
    EXIT.
  ENDIF.

*------------------
* commit work
*------------------
  IF i_commit = 'X'.
    COMMIT WORK AND WAIT.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .
  e_object_type = co_otype_status.
ENDMETHOD.


METHOD if_ish_identify_object~is_a .

  IF i_object_type = co_otype_status.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_status.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD init_mesg .

  CALL FUNCTION 'MESSAGES_INITIALIZE'
    EXPORTING
      reset                = 'X'
    EXCEPTIONS
      log_not_active       = 1
      wrong_identification = 2
      OTHERS               = 3.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD read_status .

  DATA: l_obart(2)       TYPE c,
        l_tbo00          TYPE tbo00.

  DATA: lt_stat          TYPE njstat_tab,
        l_stat           LIKE LINE OF lt_stat,
        l_status         LIKE LINE OF et_status,
        l_estat          LIKE LINE OF et_estat.

  DATA: l_mesg_active  TYPE c,
        lt_mesg_temp   TYPE tsmesg,
        lt_mesg        TYPE tsmesg,
        l_mesg         TYPE LINE OF tsmesg,
        l_msgno        TYPE sy-msgno.

  e_rc = 0.

  CLEAR:   e_stsma, e_estat, e_obtyp, er_stsma, er_estat.
  REFRESH: et_stat, et_status, et_estat.

*-----------------------------------
* check/create object errorhandler
*-----------------------------------
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

*-------------------------
* check import parameter
*-------------------------
  IF i_objnr IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'READ_STATUS'
        i_mv3 = 'I_OBJNR'.
    e_rc = 1.
    EXIT.
  ENDIF.

*------------------------------------------------------
* check if object type of objnr is valid
* (otherwise the action would end with a dump)
*------------------------------------------------------
  l_obart = i_objnr(2).
  SELECT SINGLE * FROM tbo00 INTO l_tbo00
           WHERE obart = l_obart.
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '028'
        i_mv1 = l_obart.
    e_rc = 1.
    EXIT.
  ENDIF.

*-----------------------------------
* check if message queue is active
*-----------------------------------
  CALL FUNCTION 'MESSAGES_ACTIVE'
    EXCEPTIONS
      not_active = 1
      OTHERS     = 2.
  IF sy-subrc = 0.
    l_mesg_active = 'X'.
  ELSE.
    l_mesg_active = ' '.
  ENDIF.

  IF l_mesg_active = 'X'.
*-------------------------------------------------------
*   message queue is active => save collected messages
*-------------------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
      TABLES
        t_mesg = lt_mesg_temp.
*-------------------------------------------
*   start and initialize new message queue
*-------------------------------------------
    CALL METHOD init_mesg.
  ENDIF.                                 " l_mesg_active = 'X'

*---------------------
* read status object
*---------------------
  CALL FUNCTION 'STATUS_READ'
    EXPORTING
*     CLIENT                 = SY-MANDT
      objnr                  = i_objnr
      only_active            = i_only_active
    IMPORTING
      obtyp                  = e_obtyp
      stsma                  = e_stsma
*     STONR                  =
    TABLES
      status                 = lt_stat
    EXCEPTIONS
      object_not_found       = 1
      OTHERS                 = 2.
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    e_rc = 1.
  ENDIF.

  IF l_mesg_active = 'X'.
*-----------------------------------------------
*   read collected messages from message queue
*-----------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
      TABLES
        t_mesg = lt_mesg.

    LOOP AT lt_mesg INTO l_mesg.
      l_msgno = l_mesg-txtnr.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = l_mesg-msgty
          i_kla = l_mesg-arbgb
          i_num = l_msgno
          i_mv1 = l_mesg-msgv1.
      e_rc = 1.
    ENDLOOP.
  ENDIF.                                   " l_mesg_active = 'X'

  IF e_rc = 1.
    IF l_mesg_active = 'X'.
*---------------------------------------------
*     start and initialize new message queue
*---------------------------------------------
      CALL METHOD init_mesg.
*---------------------------------------------------
*     save back original messages to message queue
*---------------------------------------------------
      CALL METHOD store_mesg
        EXPORTING
          it_mesg = lt_mesg_temp.
    ENDIF.
    EXIT.
  ENDIF.

*---------------------------
* prepare export parameter
*---------------------------
  IF er_stsma IS REQUESTED.
    CALL METHOD cl_ish_stsma=>load
      EXPORTING
        i_stsma     = e_stsma
      IMPORTING
        er_instance = er_stsma.
  ENDIF.

  LOOP AT lt_stat INTO l_stat.
    IF i_syst_status = off.
      CHECK l_stat-stat(1) = 'E'.
    ENDIF.
*   append user status and system status to table ET_STAT
    APPEND l_stat TO et_stat.
*   append only user status to tables ET_STATUS and ET_ESTAT
    CHECK l_stat-stat(1) = 'E'.
    IF et_status IS REQUESTED.
      CLEAR l_status.
      l_status-stsma = e_stsma.
      l_status-estat = l_stat-stat.
      APPEND l_status TO et_status.
    ENDIF.
    IF et_estat IS REQUESTED OR er_estat IS REQUESTED.
      IF et_estat IS REQUESTED OR
         ( er_estat IS REQUESTED AND l_stat-inact = off ).
        CLEAR l_estat.
        CALL METHOD cl_ish_estat=>load
          EXPORTING
            i_stsma     = e_stsma
            i_estat     = l_stat-stat
          IMPORTING
            er_instance = l_estat.
        APPEND l_estat TO et_estat.
      ENDIF.
      IF l_stat-inact = off.
        er_estat = l_estat.
      ENDIF.
    ENDIF.
*   there is only one active user status - so return in E_ESTAT
    IF l_stat-inact = off.
      e_estat = l_stat-stat.
    ENDIF.
  ENDLOOP.

  IF l_mesg_active = 'X'.
*---------------------------------------------
*   start and initialize new message queue
*---------------------------------------------
    CALL METHOD init_mesg.
*---------------------------------------------------
*   save back original messages to message queue
*---------------------------------------------------
    CALL METHOD store_mesg
      EXPORTING
        it_mesg = lt_mesg_temp.
  ENDIF.

ENDMETHOD.


METHOD read_t_status .

  DATA: lt_jest        TYPE TABLE OF jest,
        ls_jest        TYPE jest,
        lt_jsto        TYPE TABLE OF jsto,
        ls_jsto        TYPE jsto,
        ls_status      LIKE LINE OF et_status.

  DATA: l_mesg_active  TYPE c,
        lt_mesg_temp   TYPE tsmesg,
        lt_mesg        TYPE tsmesg,
        l_mesg         TYPE LINE OF tsmesg,
        l_msgno        TYPE sy-msgno.

  e_rc = 0.

  REFRESH: et_status.

*-----------------------------------
* check/create object errorhandler
*-----------------------------------
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

*-------------------------
* check import parameter
*-------------------------
  IF it_objnr IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = 'E'
        i_kla = 'N1BASE'
        i_num = '014'
        i_mv1 = 'CL_ISH_STATUS'
        i_mv2 = 'READ_STATUS'
        i_mv3 = 'IT_OBJNR'.
    e_rc = 1.
    EXIT.
  ENDIF.

*-----------------------------------
* check if message queue is active
*-----------------------------------
  CALL FUNCTION 'MESSAGES_ACTIVE'
    EXCEPTIONS
      not_active = 1
      OTHERS     = 2.
  IF sy-subrc = 0.
    l_mesg_active = 'X'.
  ELSE.
    l_mesg_active = ' '.
  ENDIF.

  IF l_mesg_active = 'X'.
*-------------------------------------------------------
*   message queue is active => save collected messages
*-------------------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
      TABLES
        t_mesg = lt_mesg_temp.
*-------------------------------------------
*   start and initialize new message queue
*-------------------------------------------
    CALL METHOD init_mesg.
  ENDIF.                                 " l_mesg_active = 'X'

*---------------------
* read status object
*---------------------
  CALL FUNCTION 'STATUS_READ_MULTI'
    EXPORTING
*     CLIENT               = SY-MANDT
      only_active          = i_only_active
*     ALL_IN_BUFFER        = ' '
*     GET_CHANGE_DOCUMENTS = ' '
*     NO_BUFFER_FILL       = ' '
    TABLES
      objnr_tab            = it_objnr
      status               = lt_jest
      jsto_tab             = lt_jsto
    EXCEPTIONS
      OTHERS               = 0.
  IF sy-subrc <> 0.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ = sy-msgty
        i_kla = sy-msgid
        i_num = sy-msgno
        i_mv1 = sy-msgv1
        i_mv2 = sy-msgv2
        i_mv3 = sy-msgv3
        i_mv4 = sy-msgv4.
    e_rc = 1.
  ENDIF.

  IF l_mesg_active = 'X'.
*-----------------------------------------------
*   read collected messages from message queue
*-----------------------------------------------
    CALL FUNCTION 'MESSAGES_GIVE'
      TABLES
        t_mesg = lt_mesg.

    LOOP AT lt_mesg INTO l_mesg.
      l_msgno = l_mesg-txtnr.
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ = l_mesg-msgty
          i_kla = l_mesg-arbgb
          i_num = l_msgno
          i_mv1 = l_mesg-msgv1.
      e_rc = 1.
    ENDLOOP.
  ENDIF.                                   " l_mesg_active = 'X'

  IF e_rc = 1.
    IF l_mesg_active = 'X'.
*---------------------------------------------
*     start and initialize new message queue
*---------------------------------------------
      CALL METHOD init_mesg.
*---------------------------------------------------
*     save back original messages to message queue
*---------------------------------------------------
      CALL METHOD store_mesg
        EXPORTING
          it_mesg = lt_mesg_temp.
    ENDIF.
    EXIT.
  ENDIF.

*---------------------------
* prepare export parameter
*---------------------------
  SORT lt_jsto BY objnr.

  LOOP AT lt_jest INTO ls_jest.
    IF i_syst_status = off.
      CHECK ls_jest-stat(1) = 'E'.
    ENDIF.
    READ TABLE lt_jsto INTO ls_jsto WITH KEY objnr = ls_jest-objnr BINARY SEARCH.
    CHECK sy-subrc = 0.
    CLEAR ls_status.
    ls_status-objnr = ls_jest-objnr.
    ls_status-stsma = ls_jsto-stsma.
    ls_status-estat = ls_jest-stat.
    APPEND ls_status TO et_status.
  ENDLOOP.

  IF l_mesg_active = 'X'.
*---------------------------------------------
*   start and initialize new message queue
*---------------------------------------------
    CALL METHOD init_mesg.
*---------------------------------------------------
*   save back original messages to message queue
*---------------------------------------------------
    CALL METHOD store_mesg
      EXPORTING
        it_mesg = lt_mesg_temp.
  ENDIF.

ENDMETHOD.


METHOD store_mesg .

  DATA: l_mesg    TYPE LINE OF tsmesg.

  LOOP AT it_mesg INTO l_mesg.
    CALL FUNCTION 'MESSAGE_STORE'
      EXPORTING
        arbgb                         = l_mesg-arbgb
*       EXCEPTION_IF_NOT_ACTIVE       = 'X'
        msgty                         = l_mesg-msgty
        msgv1                         = l_mesg-msgv1
        msgv2                         = l_mesg-msgv2
        msgv3                         = l_mesg-msgv3
        msgv4                         = l_mesg-msgv4
        txtnr                         = l_mesg-txtnr
        zeile                         = l_mesg-zeile
*   IMPORTING
*      ACT_SEVERITY                  =
*      MAX_SEVERITY                  =
    EXCEPTIONS
       message_type_not_valid        = 1
       not_active                    = 2
       OTHERS                        = 3.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
