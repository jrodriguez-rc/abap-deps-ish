class CL_ISH_CON_CANCEL definition
  public
  create protected

  global friends CL_ISH_FAC_CON_CANCEL .

public section.
*"* public components of class CL_ISH_CON_CANCEL
*"* do not include other source files here!!!

  interfaces IF_ISH_CONFIG_CANCEL .
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

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
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_CON_CANCEL type ISH_OBJECT_TYPE value 9023. "#EC NOTEXT

  methods SET_CHECK_PLANNING_COMPETED
    importing
      value(I_CHECK_PLANNING_COMPLETED) type ISH_ON_OFF .
  methods GET_CHECK_PLANNING_COMPLETED
    returning
      value(R_CHECK_PLANNING_COMPLETED) type ISH_ON_OFF .
  methods SET_CANCEL_CHAIN_APPS
    importing
      value(I_CANCEL_CHAIN_APPS) type ISH_ON_OFF .
  methods GET_CANCEL_CHAIN_APPS
    returning
      value(R_CANCEL_CHAIN_APPS) type ISH_ON_OFF .
  methods SET_TMP_OBJECTS
    importing
      !IT_TMP_OBJECTS type ISH_T_IDENTIFY_OBJECT .
  methods GET_TMP_OBJECTS
    returning
      value(RT_TMP_OBJECTS) type ISH_T_IDENTIFY_OBJECT .
  methods DESTROY .
protected section.
*"* protected components of class CL_ISH_CON_CANCEL
*"* do not include other source files here!!!

  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_CON_CANCEL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods ADD_MAIN_OBJECTS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !CT_OBJECT type ISH_OBJECTLIST
      !CT_NBEW type ISHMED_T_NBEW .
  methods REMOVE_MAIN_OBJECTS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional
      !CT_OBJECT type ISH_OBJECTLIST
      !CT_NBEW type ISHMED_T_NBEW .
  methods GET_APP_FROM_OBJECT
    importing
      !IS_ISH_OBJECT type ISH_OBJECT
    returning
      value(RR_APPOINTMENT) type ref to CL_ISH_APPOINTMENT .
  methods GET_REMOVEABLE_MAIN_OBJECTS
    importing
      !IT_OBJECT type ISH_OBJECTLIST
      !IT_NBEW type ISHMED_T_NBEW
    exporting
      !E_RC type ISH_METHOD_RC
      !ET_REMOVEABLE_OBJECTS type ISH_OBJECTLIST
      !ET_REMOVEABLE_NBEW type ISHMED_T_NBEW
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_CON_CANCEL
*"* do not include other source files here!!!

  data G_CHECK_PLANNING_COMPLETED type ISH_ON_OFF .
  data G_CANCEL_CHAIN_APPS type ISH_ON_OFF .
  data GT_TMP_OBJECTS type ISH_T_IDENTIFY_OBJECT .
ENDCLASS.



CLASS CL_ISH_CON_CANCEL IMPLEMENTATION.


METHOD add_main_objects.
* defintions
  DATA: l_cancel_chain TYPE ish_on_off,
        l_rc           TYPE ish_method_rc.
* tables
  DATA: lt_apps        TYPE ishmed_t_appointment_object,
        lt_add_objects TYPE ish_objectlist.

* structures
  FIELD-SYMBOLS:
       <ls_apps>        LIKE LINE OF lt_apps,
       <ls_object>      LIKE LINE OF lt_add_objects.
* ------- ----- ----- -----
  CLEAR e_rc.

* chain is on get al appointments for chain
  IF  me->get_cancel_chain_apps( ) = on.
    CALL METHOD cl_ish_utl_apmg=>get_apps_of_objlist
      EXPORTING
        it_objlist      = ct_object
      RECEIVING
        rt_appointments = lt_apps.
*   ------- ----- ----- -----
    LOOP AT lt_apps ASSIGNING <ls_apps> .
*     get appointments to chain
      CALL METHOD cl_ish_appointment=>get_chain_for_appmnt
        EXPORTING
          i_cancelled_datas = off
          i_appointment     = <ls_apps>
          i_mode_requested  = space
        IMPORTING
          e_rc              = l_rc
          et_objects        = lt_add_objects
        CHANGING
          c_errorhandler    = cr_errorhandler.
      IF l_rc <> 0.
       e_rc = l_rc.
       CONTINUE.
      ENDIF.
      LOOP AT lt_add_objects ASSIGNING <ls_object>.
        READ TABLE ct_object TRANSPORTING NO FIELDS
           WITH KEY table_line = <ls_object>.
        IF sy-subrc <> 0.
          APPEND <ls_object> TO ct_object.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDIF.
* ------- ----- ----- -----
ENDMETHOD.


METHOD create.
* Initializations.
  CLEAR: er_instance,
         e_rc.

* Create object
  CREATE OBJECT er_instance.
ENDMETHOD.


METHOD destroy.
  CLEAR: gt_tmp_objects,
         g_cancel_chain_apps,
         g_check_planning_completed.
ENDMETHOD.


METHOD get_app_from_object.

* definitions
  DATA: l_is_impl      TYPE ish_on_off.
* object ref
  DATA: lr_run         TYPE REF TO cl_ish_run_data.
* ------- ----- ----- -----
* initialize
  CLEAR: l_is_impl, lr_run, rr_appointment.
* ----------
* check if object is for transaction data
  CALL METHOD cl_ish_utl_base=>is_interface_implemented
    EXPORTING
      ir_object        = is_ish_object-object
      i_interface_name = 'IF_ISH_OBJECTBASE'
    RECEIVING
      r_is_implemented = l_is_impl.
* ----------
  CHECK l_is_impl = on.
  lr_run ?= is_ish_object-object.
* ----------
* check if object is an appointment
  IF lr_run->is_inherited_from(
        cl_ish_appointment=>co_otype_appointment ) = on.
    rr_appointment ?= lr_run.
  ENDIF.
* ------- ----- ----- -----

ENDMETHOD.


METHOD GET_CANCEL_CHAIN_APPS.
  r_cancel_chain_apps = g_cancel_chain_apps.
ENDMETHOD.


METHOD get_check_planning_completed.
  r_check_planning_completed = g_check_planning_completed.
ENDMETHOD.


METHOD get_removeable_main_objects.

* definitions
  DATA: l_completed    TYPE ish_on_off,
        l_rc           TYPE ish_method_rc,
        l_is_impl      TYPE ish_on_off,
        l_pat_tmp      TYPE ish_on_off,
        l_text         TYPE string,
        l_patname      TYPE ish_pnamec,
        l_msg_no       TYPE sy-msgno.
* structures
  FIELD-SYMBOLS:
       <ls_object>     LIKE LINE OF it_object.
* object ref
  DATA: lr_app         TYPE REF TO cl_ish_appointment,
        lr_id_obj      TYPE REF TO if_ish_identify_object.
* ------- ----- ----- -----
  CLEAR: e_rc, et_removeable_objects, et_removeable_nbew.
* ------- ----- ----- -----

  LOOP AT it_object ASSIGNING <ls_object>.
*   initialize
    CLEAR: l_is_impl, lr_id_obj.
*   ---------- ----------
*   planning completed
    IF me->get_check_planning_completed( ) = on.
*     check if planning completed
      lr_app = get_app_from_object( <ls_object> ).
      IF lr_app IS BOUND.
        CALL METHOD cl_ish_utl_apmg=>check_planning_completed
          EXPORTING
            ir_app          = lr_app
            i_pat_based_msg = on
          IMPORTING
            e_completed     = l_completed
            e_rc            = l_rc
          CHANGING
            cr_errorhandler = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
*       -------
*       if planning completed delete object from list.
        IF l_completed = on.
          READ TABLE et_removeable_objects TRANSPORTING NO FIELDS
             with key object = <ls_object>-object.
          IF sy-subrc <> 0.
            APPEND <ls_object> TO et_removeable_objects.
          ENDIF.
        ENDIF.
*       -------
      ENDIF.
    ENDIF.
*   ---------- ----------
*   temporary objects

*   does object implement following interface
    CALL METHOD cl_ish_utl_base=>is_interface_implemented
      EXPORTING
        ir_object        = <ls_object>-object
        i_interface_name = 'IF_ISH_IDENTIFY_OBJECT'
      RECEIVING
        r_is_implemented = l_is_impl.
    IF l_is_impl = on.
      lr_id_obj ?= <ls_object>-object.
*     ----------
      CLEAR: l_msg_no.
      READ TABLE gt_tmp_objects TRANSPORTING NO FIELDS
        with key table_line = lr_id_obj.
      IF sy-subrc <> 0.
*       check if patient of object is temp
        CALL METHOD cl_ish_utl_base_patient=>is_object_of_patient_tmp
          EXPORTING
            ir_identify_object = lr_id_obj
            it_tmp_object      = gt_tmp_objects
          IMPORTING
            e_pat_is_tmp       = l_pat_tmp
            e_rc               = l_rc
          CHANGING
            cr_errorhandler    = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          CONTINUE.
        ENDIF.
        IF l_pat_tmp = on.
          l_msg_no = 129.
        ENDIF.
      ELSE.
        l_msg_no = 130.
      ENDIF.
*     ----------
      IF NOT l_msg_no IS INITIAL.
*       patient or object is temporary
        READ TABLE et_removeable_objects TRANSPORTING NO FIELDS
           with key object = <ls_object>-object.
        IF sy-subrc <> 0.
          APPEND <ls_object> TO et_removeable_objects.
        ENDIF.
*       ----------
*       get name of object
        CALL FUNCTION 'ISHMED_GET_DATA_ICON_AND_TEXT'
          EXPORTING
            i_object       = lr_id_obj
          IMPORTING
            e_rc           = l_rc
            e_text         = l_text
          CHANGING
            c_errorhandler = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          CONTINUE.
        ENDIF.
*       ----------
*       get patient name
        CALL METHOD cl_ish_utl_base_patient=>get_patname_for_object
          EXPORTING
            i_object       = lr_id_obj
          IMPORTING
            e_pnamec       = l_patname
            e_rc           = l_rc
          CHANGING
            c_errorhandler = cr_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          CONTINUE.
        ENDIF.
*       ----------
*       & für Patient & kann nicht storniert werden
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = l_msg_no
            i_mv1           = l_text
            i_mv2           = l_patname
          CHANGING
            cr_errorhandler = cr_errorhandler.
      ENDIF.
*     ----------
    ENDIF.
*   ---------- ----------
  ENDLOOP.
* ------- ----- ----- -----

ENDMETHOD.


METHOD get_tmp_objects.
  rt_tmp_objects = gt_tmp_objects.
ENDMETHOD.


METHOD if_ish_config_cancel~adjust_main_objects.

* ------- ------- ------- -------
  CALL METHOD me->add_main_objects
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler
      ct_object       = ct_object
      ct_nbew         = ct_nbew.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

  CALL METHOD me->remove_main_objects
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler
      ct_object       = ct_object
      ct_nbew         = ct_nbew.
  IF e_rc <> 0.
    EXIT.
  ENDIF.
* ------- ------- ------- -------
ENDMETHOD.


METHOD if_ish_identify_object~get_type.
  e_object_type = co_otype_con_cancel.
ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type                 TYPE i.
* ---------- ---------- ----------

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.
  IF i_object_type = co_otype_con_cancel.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.
ENDMETHOD.


METHOD remove_main_objects.

* definitions
  DATA: l_rc                TYPE ish_method_rc.
* tables
  DATA: lt_removable_obj    TYPE ish_objectlist,
        lt_removable_nbew   TYPE ishmed_t_nbew.
* workareas
  FIELD-SYMBOLS:
          <ls_object>       LIKE LINE OF lt_removable_obj,
          <ls_nbew>         LIKE LINE OF lt_removable_nbew.
* ------- ----- ----- -----
* get objects to remove
  CALL METHOD me->get_removeable_main_objects
    EXPORTING
      it_object             = ct_object
      it_nbew               = ct_nbew
    IMPORTING
      e_rc                  = l_rc
      et_removeable_objects = lt_removable_obj
      et_removeable_nbew    = lt_removable_nbew
    CHANGING
      cr_errorhandler       = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ------- ----- ----- -----
* remove main objects
  LOOP AT lt_removable_obj ASSIGNING <ls_object> .
    DELETE ct_object WHERE  table_line = <ls_object>.
  ENDLOOP.
* remove movements
  LOOP AT  lt_removable_nbew ASSIGNING <ls_nbew> .
    DELETE ct_nbew WHERE  table_line = <ls_nbew>.
  ENDLOOP.
* ------- ----- ----- -----

ENDMETHOD.


METHOD SET_CANCEL_CHAIN_APPS.
  g_cancel_chain_apps = i_cancel_chain_apps.
ENDMETHOD.


METHOD set_check_planning_competed.
  g_check_planning_completed = i_check_planning_completed.
ENDMETHOD.


METHOD set_tmp_objects.
  gt_tmp_objects = it_tmp_objects.
ENDMETHOD.
ENDCLASS.
