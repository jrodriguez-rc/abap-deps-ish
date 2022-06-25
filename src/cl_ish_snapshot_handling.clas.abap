class CL_ISH_SNAPSHOT_HANDLING definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_SNAPSHOT_HANDLING
*"* do not include other source files here!!!

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_SNAPSHOT_OBJECT .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases DESTROY_SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~DESTROY_SNAPSHOT .
  aliases SNAPSHOT
    for IF_ISH_SNAPSHOT_OBJECT~SNAPSHOT .
  aliases UNDO
    for IF_ISH_SNAPSHOT_OBJECT~UNDO .

  constants CO_OTYPE_SNAPSHOT_HANDLING type ISH_OBJECT_TYPE value 4007. "#EC NOTEXT

  methods DESTROY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_DATA_CONTAINER
    importing
      !IR_CONTAINER type ref to CL_ISH_DATA_CONTAINER optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_ENVIRONMENT
    importing
      !IR_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT optional
      value(I_ALLOW_NEW_OBJ) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_EXCL_OBJECTS
    importing
      !IT_OBJECTS type ISH_T_IDENTIFY_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_OBJECTS
    importing
      !IT_OBJECTS type ISH_T_IDENTIFY_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_SNAPSHOT_HANDLING
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_SNAPSHOT_HANDLING
*"* do not include other source files here!!!

  data G_ALLOW_NEW_OBJ type ISH_ON_OFF .
  data GR_CONTAINER type ref to CL_ISH_DATA_CONTAINER .
  data GR_ENV type ref to CL_ISH_ENVIRONMENT .
  data GT_EXCL_ID_OBJ type ISH_T_IDENTIFY_OBJECT .
  data GT_ID_OBJ type ISH_T_IDENTIFY_OBJECT .
  data GT_SNAPSHOT type ISH_T_SNAPSHOT .

  methods INITIALIZE .
  methods GET_SNAP_OBJECTS
    importing
      value(IT_ID_OBJ) type ISH_T_IDENTIFY_OBJECT
    returning
      value(RT_SNAP_OBJ) type ISH_T_SNAPSHOT_OBJECT .
  methods GET_OBJECTS
    importing
      value(I_ONLY_ENV) type ISH_ON_OFF default OFF
    exporting
      value(ET_SNAP_OBJ) type ISH_T_SNAPSHOT_OBJECT
      value(ET_ID_OBJ) type ISH_T_IDENTIFY_OBJECT
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FILTER_OBJECTS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_ID_OBJ) type ISH_T_IDENTIFY_OBJECT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods UNDO_SNAPSHOT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_SNAPSHOT_OBJECT type ref to CL_ISH_SNAPSHOT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_SNAPSHOT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_SNAPSHOT_OBJECT type ref to CL_ISH_SNAPSHOT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_SNAPSHOT_HANDLING
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SNAPSHOT_HANDLING IMPLEMENTATION.


METHOD build_snapshot .

* local tables
  DATA: lt_snap_obj     TYPE ish_t_snapshot_object.
* definitions
  DATA: l_rc            TYPE ish_method_rc,
        l_snapkey       TYPE ishmed_snapkey.
* workareas
  DATA: ls_snapshot     TYPE ishmed_snapshot.
* object references
  FIELD-SYMBOLS:
        <lr_snap_obj>   TYPE REF TO if_ish_snapshot_object.
  DATA: lr_snapshot     TYPE REF TO cl_ish_snap_snapshot_handling.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  lr_snapshot ?= cr_snapshot_object.
* ---------- ---------- ----------
* get relevant objects to make a snapshot
  CALL METHOD me->get_objects
    IMPORTING
      et_snap_obj     = lt_snap_obj
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* call snapshot for each object
  LOOP AT lt_snap_obj ASSIGNING <lr_snap_obj>.
    CALL METHOD <lr_snap_obj>->snapshot
      IMPORTING
        e_rc  = l_rc
        e_key = l_snapkey.
    IF l_rc = 0.
*     append snapshot
      CLEAR: ls_snapshot.
      ls_snapshot-key    = l_snapkey.
      ls_snapshot-object = <lr_snap_obj>.
      INSERT ls_snapshot INTO TABLE lr_snapshot->gt_object.
    ELSE.
*     error; but don't abort
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD constructor .
ENDMETHOD.


METHOD create .

* definitions
  DATA: l_rc                  TYPE ish_method_rc.
* ---------- ---------- ----------
* create instance
  CREATE OBJECT er_instance
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
*   Eine Instanz der Klasse & konnte nicht angelegt werden
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'N1BASE'
        i_num  = '003'
        i_mv1  = 'CL_ISH_SNAPSHOT_HANDLING'
        i_last = ' '.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* initialize
  CALL METHOD er_instance->initialize.
* ---------- ---------- ----------

ENDMETHOD.


METHOD destroy .

* ---------- ---------- ----------
* initialize
  CALL METHOD me->initialize.
* ---------- ---------- ----------

ENDMETHOD.


METHOD filter_objects .

* local tables
  DATA: lt_id_obj       TYPE ish_t_identify_object.
* object references
  FIELD-SYMBOLS:
        <lr_id_obj>     TYPE REF TO if_ish_identify_object.
* definitions
  DATA: l_rc            TYPE ish_method_rc,
        l_is            TYPE ish_on_off.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  lt_id_obj = ct_id_obj.
* ---------- ---------- ----------
  LOOP AT lt_id_obj ASSIGNING <lr_id_obj>.
*   ---------- ----------
*   is special interface for snapshot is implemented?
*   yes = object can be used
    CALL METHOD cl_ish_utl_base=>is_interface_implemented
      EXPORTING
        ir_object        = <lr_id_obj>
        i_interface_name = 'IF_ISH_SNAPSHOT_OBJECT'
      RECEIVING
        r_is_implemented = l_is.
*   ---------- ----------
*   object can't be used
    IF l_is = off.
      DELETE lt_id_obj.
    ENDIF.
*   ---------- ----------
  ENDLOOP.
* ---------- ---------- ----------
* return values
  CHECK e_rc = 0.
  ct_id_obj = lt_id_obj.
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_objects .

* local tables
  DATA: lt_objlist      TYPE ish_objectlist,
        lt_id_obj       TYPE ish_t_identify_object,
        lt_id_obj_env   TYPE ish_t_identify_object.
* definitions
  DATA: l_rc            TYPE ish_method_rc.
* object references
  FIELD-SYMBOLS:
        <lr_id_obj>     TYPE REF TO if_ish_identify_object.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: et_id_obj, lt_id_obj_env, lt_id_obj.
* ---------- ---------- ----------
* first get objects of environment
  IF NOT gr_env IS INITIAL.
    CLEAR: lt_objlist.
    CALL METHOD gr_env->get_data
      IMPORTING
        e_rc           = l_rc
        et_objectlist  = lt_objlist
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc = 0.
      lt_id_obj_env =
          cl_ish_utl_base=>get_id_objects_of_objlist( lt_objlist ).
    ELSE.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* get objects of data container
  IF NOT gr_container IS INITIAL AND
         i_only_env   =  off.
    CLEAR: lt_objlist.
    CALL METHOD gr_container->get_data
      IMPORTING
        e_rc           = l_rc
        et_object      = lt_objlist
      CHANGING
        c_errorhandler = cr_errorhandler.
    IF l_rc = 0.
      lt_id_obj =
          cl_ish_utl_base=>get_id_objects_of_objlist( lt_objlist ).
    ELSE.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* append special set objects
  IF i_only_env = off.
    APPEND LINES OF gt_id_obj TO lt_id_obj.
  ENDIF.
* ---------- ---------- ----------
* remove not supported objects
  IF NOT lt_id_obj IS INITIAL.
    CALL METHOD me->filter_objects
      IMPORTING
        e_rc            = l_rc
      CHANGING
        ct_id_obj       = lt_id_obj
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDIF.     " IF NOT lt_id_obj IS INITIAL.
* ---------- ---------- ----------
* environment contains only supported objects
* now append objects of environment
  APPEND LINES OF lt_id_obj_env TO lt_id_obj.
* ---------- ---------- ----------
* remove duplicates
  SORT lt_id_obj.
  DELETE ADJACENT DUPLICATES FROM lt_id_obj.
* ---------- ---------- ----------
* remove objects, which are allowed to be changed
  LOOP AT gt_excl_id_obj ASSIGNING <lr_id_obj>.
    DELETE lt_id_obj WHERE table_line = <lr_id_obj>.
  ENDLOOP.
* ---------- ---------- ----------
* return values
  CHECK e_rc  = 0.
  et_id_obj   = lt_id_obj.
  et_snap_obj = me->get_snap_objects( lt_id_obj ).
* ---------- ---------- ----------

ENDMETHOD.


METHOD get_snap_objects .

* object references
  FIELD-SYMBOLS:
        <lr_id_obj>     TYPE REF TO if_ish_identify_object.
  DATA: lr_snap_obj     TYPE REF TO if_ish_snapshot_object.
* ---------- ---------- ----------
* initialize
  CLEAR: rt_snap_obj.
* ---------- ---------- ----------
* cast objects
  LOOP AT it_id_obj ASSIGNING <lr_id_obj>.
*   ----------
*   cast type to snapshot object
    TRY.
        lr_snap_obj ?= <lr_id_obj>.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
*   ----------
    INSERT lr_snap_obj INTO TABLE rt_snap_obj.
*   ----------
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_identify_object~get_type .
  e_object_type = co_otype_snapshot_handling.
ENDMETHOD.


METHOD if_ish_identify_object~is_a .

  IF i_object_type = co_otype_snapshot_handling.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_snapshot_handling.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_snapshot_object~destroy_snapshot.
* new since ID 19361 Implement if you needed
ENDMETHOD.


METHOD if_ish_snapshot_object~snapshot .

* definitions
  DATA: l_snapkey       TYPE ishmed_snapkey,
        l_rc            TYPE ish_method_rc.
* workareas
  DATA: ls_snapshot     LIKE LINE OF gt_snapshot.
* object references
  DATA: lr_error        TYPE REF TO cl_ishmed_errorhandling,
        lr_snapshot     TYPE REF TO cl_ish_snap_snapshot_handling.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  CLEAR: e_key.
* ---------- ---------- ----------
* get unique key for snapshot
  CALL METHOD cl_ish_objectcentral=>get_snapshot_key
    IMPORTING
      e_rc  = l_rc
      e_key = ls_snapshot-key.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* create snapshot object
  CALL METHOD cl_ish_snap_snapshot_handling=>create
    IMPORTING
      er_instance     = lr_snapshot
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = lr_error.
  IF l_rc = 0.
    ls_snapshot-object = lr_snapshot.
  ELSE.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* build snapshot
  CALL METHOD me->build_snapshot
    IMPORTING
      e_rc               = l_rc
    CHANGING
      cr_snapshot_object = ls_snapshot-object.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* insert snapshot on first position
  INSERT ls_snapshot INTO gt_snapshot INDEX 1.
* ---------- ---------- ----------
* return key
  e_key = ls_snapshot-key.
* ---------- ---------- ----------
* delete unnecessary snapshot entries
  DELETE gt_snapshot FROM if_ish_objectbase=>co_max_snapshots.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_snapshot_object~undo.

* workareas
  FIELD-SYMBOLS:
        <ls_snapshot>   LIKE LINE OF gt_snapshot.
* definitions
  DATA: l_rc            TYPE ish_method_rc.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
  READ TABLE gt_snapshot ASSIGNING <ls_snapshot>
     WITH KEY key = i_key.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* realize undo
  CALL METHOD undo_snapshot
    IMPORTING
      e_rc               = l_rc
    CHANGING
      cr_snapshot_object = <ls_snapshot>-object.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* remove snapshot from global table
  DELETE gt_snapshot WHERE key = i_key.
* ---------- ---------- ----------

ENDMETHOD.


METHOD initialize .

  CLEAR: gt_snapshot,
         gr_env,
         g_allow_new_obj,
         gt_excl_id_obj,
         gt_id_obj,
         gr_container.

ENDMETHOD.


METHOD set_data_container .

* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* set to global attributes
  gr_container    = ir_container.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_environment .

* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* set to global attributes
  gr_env          = ir_environment.
  g_allow_new_obj = i_allow_new_obj.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_excl_objects .

* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* set to global attributes
  gt_excl_id_obj = it_objects.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_objects .

* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* set to global attributes
  gt_id_obj = it_objects.
* ---------- ---------- ----------

ENDMETHOD.


METHOD undo_snapshot .

* local tables
  DATA: lt_snap_obj     TYPE ish_t_snapshot_object,
        lt_snap_obj_act TYPE ish_t_snapshot_object.
* definitions
  DATA: l_rc            TYPE ish_method_rc,
        l_snapkey       TYPE ishmed_snapkey.
* workareas
  FIELD-SYMBOLS:
        <ls_snapshot>   TYPE ishmed_snapshot.
* object references
  DATA: lr_snap_obj     TYPE REF TO if_ish_snapshot_object,
        lr_snapshot     TYPE REF TO cl_ish_snap_snapshot_handling,
        lr_object       TYPE REF TO object.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
  lr_snapshot ?= cr_snapshot_object.
* ---------- ---------- ----------
  LOOP AT lr_snapshot->gt_object ASSIGNING <ls_snapshot>.
*   ----------
*   cast type to snapshot object
    TRY.
        lr_snap_obj ?= <ls_snapshot>-object.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
*   ----------
*   set snapshot object to local table for further checks
    INSERT lr_snap_obj INTO TABLE lt_snap_obj.
*   ----------
*   realize undo
    CALL METHOD lr_snap_obj->undo
      EXPORTING
        i_key = <ls_snapshot>-key
      IMPORTING
        e_rc  = l_rc.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
*   ----------
  ENDLOOP.
* ---------- ---------- ----------
* if necessary remove "new" objects
  CHECK g_allow_new_obj = off.
* ---------- ----------
* get objects (which are known now)
  CALL METHOD me->get_objects
    EXPORTING
      i_only_env      = on
    IMPORTING
      et_snap_obj     = lt_snap_obj_act
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

  SORT lt_snap_obj BY table_line. " MED-48177 VS
* destroy all new objects
  LOOP AT lt_snap_obj_act INTO lr_snap_obj.
    READ TABLE lt_snap_obj TRANSPORTING NO FIELDS
       WITH KEY table_line = lr_snap_obj BINARY SEARCH. " MED-48177 VS
    IF sy-subrc <> 0.
*     ----------
*     call "destroy"
      TRY.
          lr_object = lr_snap_obj.
          CALL METHOD lr_object->('DESTROY')
            IMPORTING
              e_rc = l_rc.
        CATCH cx_sy_dyn_call_illegal_method.
          CONTINUE.
      ENDTRY.
*     ----------
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
