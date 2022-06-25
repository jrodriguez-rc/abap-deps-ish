class CL_ISH_RUN_DATA definition
  public
  inheriting from CL_ISH_DATA_OBJECT
  abstract
  create public .

public section.
*"* public components of class CL_ISH_RUN_DATA
*"* do not include other source files here!!!

  interfaces IF_ISH_OBJECTBASE
      data values G_AUTHORITY_CHECK = ON .
  interfaces IF_ISH_CONTROLLABLE .

  aliases ADD_CONNECTION
    for IF_ISH_OBJECTBASE~ADD_CONNECTION .
  aliases CLEAR_LOCK
    for IF_ISH_OBJECTBASE~CLEAR_LOCK .
  aliases CONNECT
    for IF_ISH_OBJECTBASE~CONNECT .
  aliases DELETE_CONNECTION
    for IF_ISH_OBJECTBASE~DELETE_CONNECTION .
  aliases DISCONNECT
    for IF_ISH_OBJECTBASE~DISCONNECT .
  aliases GET_CONNECTIONS
    for IF_ISH_OBJECTBASE~GET_CONNECTIONS .
  aliases GET_DATA_FIELD
    for IF_ISH_OBJECTBASE~GET_DATA_FIELD .
  aliases GET_ENVIRONMENT
    for IF_ISH_OBJECTBASE~GET_ENVIRONMENT .
  aliases GET_FORCE_ERUP_DATA
    for IF_ISH_OBJECTBASE~GET_FORCE_ERUP_DATA .
  aliases HIDE
    for IF_ISH_OBJECTBASE~HIDE .
  aliases IS_COMPLETE
    for IF_ISH_OBJECTBASE~IS_COMPLETE .
  aliases IS_HIDDEN
    for IF_ISH_OBJECTBASE~IS_HIDDEN .
  aliases REMOVE_CONNECTION
    for IF_ISH_OBJECTBASE~REMOVE_CONNECTION .
  aliases SAVE
    for IF_ISH_OBJECTBASE~SAVE .
  aliases SET_FORCE_ERUP_DATA
    for IF_ISH_OBJECTBASE~SET_FORCE_ERUP_DATA .
  aliases SET_LOCK
    for IF_ISH_OBJECTBASE~SET_LOCK .

  data G_SNAPSHOT_IF_REQUIRED type ISH_ON_OFF read-only .
  constants CO_OTYPE_RUN_DATA type ISH_OBJECT_TYPE value 3003. "#EC NOTEXT
  constants CO_ACTS_BEFORE_SAVE type N1_CB_ACTION value 'BEFORE_SAVE'. "#EC NOTEXT
  constants CO_ACTPAR_TESTRUN type N1CONTENTNAME value 'TESTRUN'. "#EC NOTEXT
  constants CO_ACTPAR_TCODE type N1CONTENTNAME value 'TCODE'. "#EC NOTEXT
  constants CO_ACTPAR_CONNOBJ type N1CONTENTNAME value 'CONNOBJ'. "#EC NOTEXT
  constants CO_ACTB_CHK_DEP_PATCASE type N1_CB_ACTION value 'CHECK_FALNR_PATNR_PAPID'. "#EC NOTEXT
  constants CO_ACTPAR_CHK_FALNR type N1CONTENTNAME value 'CHECK_FALNR'. "#EC NOTEXT
  constants CO_ACTPAR_CHK_PATNR type N1CONTENTNAME value 'CHECK_PATNR'. "#EC NOTEXT
  constants CO_ACTPAR_CHK_PAPID type N1CONTENTNAME value 'CHECK_PAPID'. "#EC NOTEXT
  constants CO_ACTS_SET_BUFFER type N1_CB_ACTION value 'SET_BUFFER'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      value(I_MODE) type ISH_MODUS optional .

  methods BUILD_SNAPSHOT
    redefinition .
  methods IF_ISH_DATA_OBJECT~DESTROY
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SNAPSHOT_OBJECT~UNDO
    redefinition .
protected section.
*"* protected components of class CL_ISH_RUN_DATA
*"* do not include other source files here!!!

  aliases G_ENVIRONMENT
    for IF_ISH_OBJECTBASE~G_ENVIRONMENT .
  aliases G_OBJECTBASE
    for IF_ISH_OBJECTBASE~G_OBJECTBASE .

  data GR_DATA type ref to DATA .
  data GR_T_FK_MAPPING type ref to ISH_T_FK_MAPPING .
  data G_FORCE_ERUP_DATA type ISH_ON_OFF value ON. "#EC NOTEXT .
  data G_HIDDEN type ISH_ON_OFF .
  data GT_OWNER type ISH_T_CONTROLLABLE_OWNER .

  methods _CHECK_CASE_PAT_IS_TO_CHECK
    importing
      value(I_CHECK_FALNR) type ISH_ON_OFF
      value(I_CHECK_PATNR) type ISH_ON_OFF
      value(I_CHECK_PAPID) type ISH_ON_OFF
    exporting
      value(E_NO_CHECK) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SNAPSHOT_BEFORE_CHANGE
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods COMPLETE_CONSTRUCTION
    importing
      value(IR_ENVIRONMENT) type ref to CL_ISH_ENVIRONMENT
      value(IT_CONNECTED_OBJECTS) type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_CONNECTED_OBJECTS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_READ_ONLY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods _CHECK_BUFFER_SET_IS_ALLOWED
    importing
      value(I_OBJECT_NAME) type N1CONTENTNAME
      value(I_BUFFER_OBJECT_NAME) type N1CONTENTNAME
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_DESTROY_ON_CONNOBJ
    importing
      value(I_CONNOBJ) type ref to IF_ISH_IDENTIFY_OBJECT
      value(I_FINAL) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_FK_OBJECTS
    importing
      value(IT_CHANGED_FIELDS) type DDFIELDS
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_AFTER_DESTROY
  abstract .
  methods SAVE_INTERNAL
  abstract
    importing
      value(I_TESTRUN) type ISH_ON_OFF default OFF
      value(I_TCODE) type SY-TCODE default SY-TCODE
      value(I_SAVE_CONN_OBJECTS) type ISH_ON_OFF default OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING .
  methods _CHECK_REGISTER_OWNER
    importing
      !IR_OWNER type ref to IF_ISH_CONTROLLABLE_OWNER
      value(I_ACTION) type N1_CB_ACTION
    raising
      CX_ISH_STATIC_HANDLER .

  methods SNAPSHOT_CONNECTION
    redefinition .
  methods UNDO_CONNECTION
    redefinition .
private section.
*"* private components of class CL_ISH_RUN_DATA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_RUN_DATA IMPLEMENTATION.


METHOD build_snapshot.
*Redef/PN/MED-40483

  DATA: l_create_snapshot  TYPE ish_on_off.

* initialization
  CLEAR: es_snapshot, e_rc.

* check if environement has callback object for snapshot
  IF g_environment IS BOUND AND g_environment->gr_cb_snapshot IS BOUND.
*   check if snapshot should be created immediately
    CALL METHOD g_environment->gr_cb_snapshot->cb_snapshot
      EXPORTING
        ir_run_data       = me
      IMPORTING
        e_create_snapshot = l_create_snapshot
        e_rc              = e_rc
      CHANGING
        cr_errorhandler   = cr_errorhandler.
    CHECK e_rc = 0.
    IF l_create_snapshot = off.
*     return because real snapshot is done later if neccessary
*     snapshotkey is created elsewhere
      RETURN.
    ENDIF.
  ENDIF.

* call super
  CALL METHOD super->build_snapshot
    IMPORTING
      es_snapshot     = es_snapshot
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD check_connected_objects .

  DATA: lt_connobj      TYPE ish_objectlist,
        lr_run_data     TYPE REF TO if_ish_objectbase,
        l_rc            TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_connobj>  TYPE ish_object.

* Get connected objects.
  CALL METHOD get_connections
    EXPORTING
      i_all_conn_objects = on
    IMPORTING
      et_objects         = lt_connobj.

* Check each connected object.
  LOOP AT lt_connobj ASSIGNING <ls_connobj>.
    CHECK NOT <ls_connobj>-object IS INITIAL.
*   Casting.
    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
      lr_run_data ?= <ls_connobj>-object.
    ENDCATCH.
    CHECK sy-subrc = 0.  " No data object -> no checking.
*   Check connected object.
    CALL METHOD lr_run_data->check
      EXPORTING
        i_check_conn_objects = space
      IMPORTING
        e_rc                 = l_rc
      CHANGING
        c_errorhandler       = cr_errorhandler.
*   Handle e_rc.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD check_read_only .

* Errorhandler ist nicht obligatorisch
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* ID 19195: check if environment exists
*           (otherwise object is already destroyed)
  IF g_environment IS NOT BOUND.
    e_rc = 1.
    EXIT.
  ENDIF.

  IF g_environment->get_read_only( ) = 'X'.
    e_rc = 4.
*   Änderungen im Anzeigemodus nicht möglich
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ    = 'E'
        i_kla    = 'N1BASE'
        i_num    = '024'
        i_object = me
        i_last   = space.
  ENDIF.

ENDMETHOD.


METHOD complete_construction .

  FIELD-SYMBOLS: <ls_connobj>  TYPE ish_object.

* Initializations
  CLEAR: e_rc.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* G_ACTIVE
  g_active = on.

* G_ENVIRONMENT
  g_environment = ir_environment.
  IF g_environment IS INITIAL.
    CALL METHOD cr_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NFCL'
        i_num  = '061'
        i_mv1  = 'CL_ISH_CORDER'
        i_last = space.
    e_rc = 1.
  ENDIF.

  CHECK e_rc = 0.

* Register in environment
  CALL METHOD g_environment->set_data
    EXPORTING
      i_object = me.

* Handle connected objects
  CREATE OBJECT g_objectbase.
  LOOP AT it_connected_objects ASSIGNING <ls_connobj>.
    CALL METHOD add_connection
      EXPORTING
        i_object = <ls_connobj>-object.
  ENDLOOP.

ENDMETHOD.


METHOD constructor .

  CALL METHOD super->constructor
    EXPORTING
      i_mode = i_mode.

ENDMETHOD.


METHOD handle_destroy_on_connobj . "#EC NEEDED

* Default: No implementation.

ENDMETHOD.


METHOD handle_fk_objects .

  FIELD-SYMBOLS: <ls_cf>    TYPE dfies,
                 <lt_fkm>   TYPE ish_t_fk_mapping,
                 <ls_fkm>   TYPE rn1_fk_mapping.

  CHECK NOT g_objectbase IS INITIAL.

* Process only if gr_t_fk_mapping is bound.
  CHECK gr_t_fk_mapping IS BOUND.

* Assign gr_t_fk_mapping.
  ASSIGN gr_t_fk_mapping->* TO <lt_fkm>.

* Just remove connections if foreign key fields were changed.
  LOOP AT it_changed_fields ASSIGNING <ls_cf>.
    CHECK NOT <ls_cf>-fieldname IS INITIAL.
    READ TABLE <lt_fkm>
      ASSIGNING <ls_fkm>
      WITH KEY fieldname = <ls_cf>-fieldname.
    CHECK sy-subrc = 0.
    CALL METHOD g_objectbase->remove_connection
      EXPORTING
        i_type = <ls_fkm>-object_type.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_controllable~deregister_owner.
* MED-42121

* if owner is not bound no deregistration is bossible
  IF ir_owner IS NOT BOUND OR i_action IS INITIAL.
    RETURN.
  ENDIF.

* if owner is not registered deregistration is not necessary
  READ TABLE gt_owner TRANSPORTING NO FIELDS
   WITH TABLE KEY r_owner = ir_owner
                  action  = i_action.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

* check if owner allow deregistration
  IF ir_owner->cb_dereg_from_controllable( ir_controllable = me
                                           i_action        = i_action ) = abap_false.
    RETURN.
  ENDIF.

* deregister owner
  DELETE gt_owner WHERE r_owner = ir_owner
                    AND action  = i_action.

* raise event owner is deregistered
  RAISE EVENT if_ish_controllable~ev_owner_deregistered
    EXPORTING
      er_owner = ir_owner
      e_action = i_action.

ENDMETHOD.


METHOD if_ish_controllable~get_owners.
* MED-42121
  FIELD-SYMBOLS <ls_owner> LIKE LINE OF gt_owner.

  CLEAR rt_owner.
* if owner is not bound no deregistration is bossible
  IF i_action IS INITIAL.
    RETURN.
  ENDIF.

  LOOP AT gt_owner ASSIGNING <ls_owner>
    WHERE action = i_action.
    INSERT <ls_owner>-r_owner INTO TABLE rt_owner.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_controllable~has_owner.
* MED-42121
  CLEAR r_has_owner.
  IF ir_owner IS BOUND AND i_action IS NOT INITIAL.

    IF gt_owner IS INITIAL.
      RETURN.
    ENDIF.

    READ TABLE gt_owner TRANSPORTING NO FIELDS
     WITH TABLE KEY action  = i_action
                    r_owner = ir_owner.
    IF sy-subrc = 0.
      r_has_owner = abap_true.
    ENDIF.
  ENDIF.
ENDMETHOD.


METHOD if_ish_controllable~register_owner.
* MED-42121
  DATA ls_owner   LIKE LINE OF gt_owner.

* if owner is not bound no registration is bossible
  IF ir_owner IS NOT BOUND OR i_action IS INITIAL.
    RETURN.
  ENDIF.

* if owner is already registered registration is not necessary
  READ TABLE gt_owner TRANSPORTING NO FIELDS
     WITH TABLE KEY r_owner = ir_owner
                    action  = i_action.
  IF sy-subrc = 0.
    RETURN.
  ENDIF.

* check if owner allow to register for this controllable
  CALL METHOD ir_owner->cb_reg_to_controllable
    EXPORTING
      ir_controllable = me
      i_action        = i_action.

  LOOP AT gt_owner INTO ls_owner
     WHERE action = i_action.
    CALL METHOD ls_owner-r_owner->cb_reg_further_owner
      EXPORTING
        ir_controllable  = me
        i_action         = i_action
        ir_further_owner = ir_owner.
  ENDLOOP.

* check if me accept this owner
  CALL METHOD me->_check_register_owner
    EXPORTING
      ir_owner = ir_owner
      i_action = i_action.

* register owner
  CLEAR ls_owner.
  ls_owner-r_owner = ir_owner.
  ls_owner-action  = i_action.
  INSERT ls_owner INTO TABLE gt_owner.

* raise event owner is registered
  RAISE EVENT if_ish_controllable~ev_owner_registered
    EXPORTING
      er_owner = ir_owner
      e_action = i_action.

ENDMETHOD.


METHOD if_ish_data_object~destroy .

  DATA: lt_conn_objs         TYPE ish_objectlist,
        l_obj                TYPE ish_object,
        l_rc                 TYPE ish_method_rc,
        lref_identify_object TYPE REF TO if_ish_identify_object.

* Initializations
  e_rc = 0.

*Sta/PN/MED-40483
  CALL METHOD me->snapshot_before_change
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.
  CHECK e_rc = 0.
*End/PN/MED-40483

* Call super method.
  CALL METHOD super->if_ish_data_object~destroy
    EXPORTING
      i_final        = i_final                              " ID 19195
    IMPORTING
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Get all connected objects.
  REFRESH lt_conn_objs.
  CALL METHOD get_connections
    EXPORTING
      i_all_conn_objects = off
      i_inactive_conns   = off
    IMPORTING
      et_objects         = lt_conn_objs.

* Allow derived classes to implement special logic
* for all connected objects.
  LOOP AT lt_conn_objs INTO l_obj.
    CATCH SYSTEM-EXCEPTIONS move_cast_error = 1.
      lref_identify_object ?= l_obj-object.
      IF sy-subrc = 0.
        CALL METHOD handle_destroy_on_connobj
          EXPORTING
            i_connobj      = lref_identify_object
            i_final        = i_final                        " ID 19195
          IMPORTING
            e_rc           = l_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
        ENDIF.
      ENDIF.
    ENDCATCH.
  ENDLOOP.   " loop at lt_conn_objs into l_obj

* Deactivate all connections.
* ID 19195: final destroy (= no UNDO is possible)
  LOOP AT lt_conn_objs INTO l_obj.
    IF i_final = off.
      CALL METHOD remove_connection
        EXPORTING
          i_object = l_obj-object.
    ELSE.
      CALL METHOD delete_connection
        EXPORTING
          i_object = l_obj-object.
    ENDIF.
  ENDLOOP.

* Remove self from environment.
  IF g_environment IS BOUND.
    CALL METHOD g_environment->remove
      EXPORTING
        i_object = me.
  ENDIF.

* Initialize self.
  CALL METHOD initialize_after_destroy.

* ID 19195: final destroy (= no UNDO is possible)
  IF i_final = on.
    CLEAR: g_environment,
           g_objectbase,
           gt_snapshots[].
  ENDIF.

* Mark self as inactive.
  g_active = off.

  CLEAR: gt_owner.                                          "MED-42121

ENDMETHOD.


METHOD if_ish_identify_object~get_type .
  e_object_type = co_otype_run_data.
ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_run_data.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_objectbase~add_connection .

  CHECK g_objectbase IS BOUND.

*Sta/PN/MED-40483
  CALL METHOD me->snapshot_before_change.
*End/PN/MED-40483

  CALL METHOD g_objectbase->add_connection
    EXPORTING
      i_me                = me
      i_partner           = i_object
      i_partner_x         = i_object_x
      i_attribute         = i_attribute
      i_attribute_x       = i_attribute_x
      i_attrib_apply_to   = i_attrib_apply_to
      i_attrib_apply_to_x = i_attrib_apply_to_x.

ENDMETHOD.


METHOD if_ish_objectbase~check.                             "#EC NEEDED

ENDMETHOD.


METHOD if_ish_objectbase~clear_lock .

  CHECK g_objectbase IS BOUND.

  CALL METHOD g_objectbase->clear_lock
    EXPORTING
      i_key = i_key
    IMPORTING
      e_rc  = e_rc.

ENDMETHOD.


METHOD if_ish_objectbase~connect .

  DATA: l_fld_not_found    TYPE ish_on_off,
        l_object_type      TYPE i,
        lt_object          TYPE ish_objectlist,
        l_remove_old_conn  TYPE ish_on_off,
        lr_pap             TYPE REF TO cl_ish_patient_provisional,
        ls_pap_key         TYPE rnpap_key.

  FIELD-SYMBOLS: <lt_fkm>        TYPE ish_t_fk_mapping,
                 <ls_fkm>        TYPE rn1_fk_mapping,
                 <ls_data>       TYPE any,
                 <l_field>       TYPE any,
                 <ls_object>     TYPE ish_object.

* Process only if an object is specified.
  CHECK NOT ir_object IS INITIAL.

  CHECK g_objectbase IS BOUND.                              " ID 19195

*Sta/PN/MED-40483
* Connect to ir_object.
  CALL METHOD me->if_ish_objectbase~add_connection
    EXPORTING
      i_object            = ir_object
      i_object_x          = i_object_x
      i_attribute         = ir_attribute
      i_attribute_x       = i_attribute_x
      i_attrib_apply_to   = i_attrib_apply_to
      i_attrib_apply_to_x = i_attrib_apply_to_x.
** Connect to ir_object.
*  CALL METHOD g_objectbase->add_connection
*    EXPORTING
*      i_me                = me
*      i_partner           = ir_object
*      i_partner_x         = i_object_x
*      i_attribute         = ir_attribute
*      i_attribute_x       = i_attribute_x
*      i_attrib_apply_to   = i_attrib_apply_to
*      i_attrib_apply_to_x = i_attrib_apply_to_x.
*End/PN/MED-40483

* Further processing only for foreign keys.
  CHECK i_handle_foreign_keys = on.

* Further processing only if gr_data is set.
  CHECK gr_data IS BOUND.

* Further processing only if gr_t_fk_mapping is set.
  CHECK gr_t_fk_mapping IS BOUND.

* Assign gr_data.
  ASSIGN gr_data->* TO <ls_data>.

* Assign gr_t_fk_mapping.
  ASSIGN gr_t_fk_mapping->* TO <lt_fkm>.

* Handle foreign keys.
  LOOP AT <lt_fkm> ASSIGNING <ls_fkm>.
    CHECK ir_object->is_inherited_from( <ls_fkm>-object_type ) = on.
    CHECK NOT <ls_fkm>-fieldname IS INITIAL.
    CHECK NOT <ls_fkm>-fk_fieldname IS INITIAL.
    ASSIGN COMPONENT <ls_fkm>-fieldname
      OF STRUCTURE <ls_data>
      TO <l_field>.
    CHECK sy-subrc = 0.
    l_fld_not_found = off.
    IF <ls_fkm>-fk_fieldname = 'PAPID' AND
       <ls_fkm>-object_type  =
         cl_ish_patient_provisional=>co_otype_prov_patient.
*     Special processing for papid.
      lr_pap ?= ir_object.
      CALL METHOD lr_pap->get_data
        IMPORTING
          es_key         = ls_pap_key
          e_rc           = e_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF e_rc = 0.
        <l_field> = ls_pap_key-papid.
      ENDIF.
    ELSE.
*     Default processing
      CALL METHOD ir_object->get_data_field
        EXPORTING
          i_fieldname     = <ls_fkm>-fk_fieldname
        IMPORTING
          e_rc            = e_rc
          e_field         = <l_field>
          e_fld_not_found = l_fld_not_found
        CHANGING
          c_errorhandler  = cr_errorhandler.
    ENDIF.
    IF e_rc <> 0 OR
       l_fld_not_found = on.
      CLEAR <l_field>.
    ENDIF.
    IF e_rc <> 0.
      EXIT.
    ENDIF.
    CHECK l_fld_not_found = off.
    l_remove_old_conn = on.
  ENDLOOP.
  CHECK e_rc = 0.

* Further processing depends on l_remove_old_conn.
  CHECK l_remove_old_conn = on.

* Get ir_object's type.
  CALL METHOD ir_object->get_type
    IMPORTING
      e_object_type = l_object_type.

* Remove any old connections of ir_object's type.
  CALL METHOD get_connections
    EXPORTING
      i_type     = l_object_type
    IMPORTING
      et_objects = lt_object.
  LOOP AT lt_object ASSIGNING <ls_object>.
    CHECK NOT <ls_object>-object IS INITIAL.
    CHECK NOT <ls_object>-object = ir_object.
    CALL METHOD remove_connection
      EXPORTING
        i_object = <ls_object>-object.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_objectbase~delete_connection.

  CHECK g_objectbase IS BOUND.

*Sta/PN/MED-40483
  CALL METHOD me->snapshot_before_change.
*End/PN/MED-40483

  CALL METHOD g_objectbase->delete_connection
    EXPORTING
      i_me      = me
      i_partner = i_object
      i_type    = i_type.

ENDMETHOD.


METHOD if_ish_objectbase~disconnect .

  DATA: l_object_type      TYPE i.

  FIELD-SYMBOLS: <lt_fkm>        TYPE ish_t_fk_mapping,
                 <ls_fkm>        TYPE rn1_fk_mapping,
                 <ls_data>       TYPE any,
                 <l_field>       TYPE any.

  CHECK g_objectbase IS BOUND.                              " ID 19195

*Sta/PN/MED-40483
  CALL METHOD me->if_ish_objectbase~remove_connection
    EXPORTING
      i_object = ir_object
      i_type   = i_type.
** Remove connection.
*  CALL METHOD g_objectbase->remove_connection
*    EXPORTING
*      i_me      = me
**     Michael Manoch, 04.06.2004, ID 14247   START
**     Use ir_object instead of lr_object (fatal error).
**      i_partner = lr_object
*      i_partner = ir_object
**     Michael Manoch, 04.06.2004, ID 14247   END
*      i_type    = i_type.
*End/PN/MED-40483

* Further processing only for foreign keys.
  CHECK i_handle_foreign_keys = on.

* Further processing only if gr_data is set.
  CHECK gr_data IS BOUND.

* Further processing only if gr_t_fk_mapping is set.
  CHECK gr_t_fk_mapping IS BOUND.

* Assign gr_data.
  ASSIGN gr_data->* TO <ls_data>.

* Assign gr_t_fk_mapping.
  ASSIGN gr_t_fk_mapping->* TO <lt_fkm>.

* Get ir_object's type.
  IF NOT ir_object IS INITIAL.
    CALL METHOD ir_object->get_type
      IMPORTING
        e_object_type = l_object_type.
  ELSE.
    l_object_type = i_type.
  ENDIF.

* Handle foreign keys.
  LOOP AT <lt_fkm>
              ASSIGNING <ls_fkm>
              WHERE object_type = l_object_type.
    CHECK NOT <ls_fkm>-fieldname IS INITIAL.
    ASSIGN COMPONENT <ls_fkm>-fieldname
      OF STRUCTURE <ls_data>
      TO <l_field>.
    CHECK sy-subrc = 0.
    CLEAR <l_field>.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_objectbase~get_authority_check.
  e_authority_check = if_ish_objectbase~g_authority_check.
ENDMETHOD.


METHOD if_ish_objectbase~get_connections .

* Michael Manoch, 06.07.2004, ID 14907   START
* g_objectbase may not have been already set.
  CLEAR et_objects.
  CHECK NOT g_objectbase IS INITIAL.
* Michael Manoch, 06.07.2004, ID 14907   END

  CALL METHOD g_objectbase->get_connections
    EXPORTING
      i_me               = me
      i_all_conn_objects = i_all_conn_objects
      i_type             = i_type
      i_inactive_conns   = i_inactive_conns
    IMPORTING
      et_objects         = et_objects.

ENDMETHOD.


METHOD if_ish_objectbase~get_data_field .                   "#EC NEEDED

ENDMETHOD.


METHOD if_ish_objectbase~get_environment .

  e_environment = g_environment.

ENDMETHOD.


METHOD if_ish_objectbase~get_force_erup_data .

  r_force_erup_data = g_force_erup_data.

ENDMETHOD.


METHOD if_ish_objectbase~hide.

* local tables
  DATA: lt_objects      TYPE ish_objectlist.
* workareas
  DATA: ls_object       LIKE LINE OF lt_objects.
* definitions
  DATA: l_rc            TYPE ish_method_rc.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* ---------- ---------- ----------
* set flag
  g_hidden = i_hide.
* ---------- ---------- ----------
  IF g_environment IS BOUND.                                " ID 19195
    IF g_hidden = on.
*     remove object of environment
      CALL METHOD g_environment->remove
        EXPORTING
          i_object = me.
    ELSE.
*     add object to environment
*     take care: object may be in environment already !
      CALL METHOD g_environment->set_data
        EXPORTING
          i_object       = me
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* handle connections
* ----------
* get all connected objects
  CALL METHOD me->get_connections
    EXPORTING
      i_all_conn_objects = off
      i_inactive_conns   = off
    IMPORTING
      et_objects         = lt_objects.
* update connection
  LOOP AT lt_objects INTO ls_object.
*   first remove connection
    CALL METHOD me->remove_connection
      EXPORTING
        i_object = ls_object-object.
*   now add connection again
    CALL METHOD me->add_connection
      EXPORTING
        i_object            = ls_object-object
        i_object_x          = 'X'
        i_attribute         = ls_object-attribute
        i_attribute_x       = on
        i_attrib_apply_to   = ls_object-attrib_apply_to
        i_attrib_apply_to_x = on.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_objectbase~is_actual.                         "#EC NEEDED

ENDMETHOD.


METHOD if_ish_objectbase~is_complete .                      "#EC NEEDED

ENDMETHOD.


METHOD if_ish_objectbase~is_hidden.
  r_hidden = g_hidden.
ENDMETHOD.


METHOD if_ish_objectbase~remove_connection .

  CHECK g_objectbase IS BOUND.

*Sta/PN/MED-40483
  CALL METHOD me->snapshot_before_change.
*End/PN/MED-40483

  CALL METHOD g_objectbase->remove_connection
    EXPORTING
      i_me      = me
      i_partner = i_object
      i_type    = i_type.

ENDMETHOD.


METHOD if_ish_objectbase~save .

  DATA: l_complete      TYPE ish_on_off.
* START MED-42121 2010/08/20
  DATA lt_owner             TYPE ish_t_controllable_owner_obj.
  DATA lr_owner             TYPE REF TO if_ish_controllable_owner.
  DATA lr_action_parameters TYPE REF TO cl_ish_named_content_list.
  DATA l_name               TYPE n1contentname.
  DATA lx_static            TYPE REF TO cx_ish_static_handler.
  DATA l_type               TYPE ish_object_type.
  FIELD-SYMBOLS <ls_owner>  LIKE LINE OF gt_owner.
* END MED-42121

* Initializations.
  e_rc = 0.

* Process SAVE only for active objects.
  CHECK g_active = on.

* START MED-42121 2010/08/20
  lt_owner =  me->if_ish_controllable~get_owners( i_action = co_acts_before_save ).

  IF lt_owner IS NOT INITIAL.
    TRY.
*       create content for action check
        CREATE OBJECT lr_action_parameters.
        l_name = co_actpar_testrun.
        lr_action_parameters->set_content( i_name    = l_name
                                           i_content = i_testrun
                                           i_replace = abap_true ).
        l_name = co_actpar_connobj.
        lr_action_parameters->set_content( i_name    = l_name
                                           i_content = i_save_conn_objects
                                           i_replace = abap_true ).

        l_name = co_actpar_tcode.
        lr_action_parameters->set_content( i_name    = l_name
                                           i_content = i_tcode
                                           i_replace = abap_true ).

        LOOP AT lt_owner INTO lr_owner.
*         call controller if allowed to save
          lr_owner->cb_simple_action( ir_controllable = me
                                      i_action = co_acts_before_save
                                      ir_parameters = lr_action_parameters ).
        ENDLOOP.

      CATCH cx_ish_static_handler  INTO lx_static.
*       save is not allowed collect messages and return
        e_rc = 1.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          EXPORTING
            i_exceptions    = lx_static
          CHANGING
            cr_errorhandler = c_errorhandler.
*       Speichern wurde nicht erlaubt.
        CALL METHOD me->get_type
          IMPORTING
            e_object_type = l_type.
*       Speichern des Objekt & wurde nicht erlaubt
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '160'
            i_mv1           = l_type
            ir_object       = me
          CHANGING
            cr_errorhandler = c_errorhandler.
        RETURN.
    ENDTRY.
  ENDIF.
* END MED-42121

* Begin Boden M. ID 12871
* check modi
  CALL METHOD me->check_read_only
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = c_errorhandler.

  IF e_rc <> 0.
    EXIT.
  ENDIF.
* End Boden M. ID 12871

* SAVE for the whole environment?
  IF i_save_conn_objects = on.
*   Führer, ID 14664 14.09.04 - begin
*   hidden objects aren't in the environment
*   saving the environment will not save the object, that's why
*   this action isn't allowed for hidden objects
    IF me->is_hidden( ) = on.
      e_rc = 9.
      EXIT.
    ENDIF.
*   Führer, ID 14664 14.09.04 - end
    CHECK g_environment IS BOUND.                           " ID 19195
    CALL METHOD g_environment->save
      EXPORTING
        i_testrun      = i_testrun
      IMPORTING
        e_rc           = e_rc
      CHANGING
        c_errorhandler = c_errorhandler.
    EXIT.
  ENDIF.

* Save only self.

* Process SAVE only, if self is complete.
  CALL METHOD me->is_complete
    IMPORTING
      e_complete = l_complete.
  IF l_complete <> on.
    EXIT.
  ENDIF.

* Now process the real SAVE.
  CALL METHOD save_internal
    EXPORTING
      i_testrun           = i_testrun
      i_tcode             = i_tcode
      i_save_conn_objects = i_save_conn_objects
    IMPORTING
      e_rc                = e_rc
    CHANGING
      c_errorhandler      = c_errorhandler.

ENDMETHOD.


METHOD if_ish_objectbase~set_authority_check.
  if_ish_objectbase~g_authority_check = i_authority_check.
ENDMETHOD.


METHOD if_ish_objectbase~set_force_erup_data .

  g_force_erup_data = i_force_erup_data.

ENDMETHOD.


METHOD if_ish_objectbase~set_lock .

  CHECK g_objectbase IS BOUND.

  CALL METHOD g_objectbase->set_lock
    IMPORTING
      e_key = e_key
      e_rc  = e_rc.

ENDMETHOD.


METHOD if_ish_snapshot_object~undo.

* Method redefined for MED-31905

  DATA: l_wa_snapshot          TYPE ish_snapshot,
        lr_object              TYPE REF TO object,
        l_key                  TYPE string,
        l_activate             TYPE ish_on_off.

* Initializations.
  e_rc = 0.
  CLEAR l_wa_snapshot.

* Determine the snapshot entry.
  READ TABLE gt_snapshots INTO l_wa_snapshot WITH KEY key = i_key.
  IF sy-subrc <> 0.
*   An error occured -> no UNDO.
    e_rc = 1.
    EXIT.
  ENDIF.

*Sta/PN/MED-40483
* check if snapshot object is available
* because it could be initial when using
* callback object for snapshot
  IF l_wa_snapshot-object IS INITIAL.
    DELETE gt_snapshots WHERE key = i_key.
    EXIT.
  ENDIF.
*End/PN/MED-40483

* Should the object be reactivated?
  IF g_active = off.
*   Andreea Rapa, MED-46159, 2011-11-08   START
*   Activation should only be done if the object gets really activated.
*    l_activate = on.
    l_activate = l_wa_snapshot-active.
*   Andreea Rapa, MED-46159, 2011-11-08   END
  ENDIF.

* Undo the attributes G_ACTIVE and G_MODE.
  g_active = l_wa_snapshot-active.
  g_mode   = l_wa_snapshot-mode.

* Allow derived classes to undo their data.
  CALL METHOD undo_snapshot_object
    EXPORTING
      i_snapshot_object = l_wa_snapshot-object
    IMPORTING
      e_rc              = e_rc.
  IF e_rc <> 0.
*     An error occured -> no UNDO.
    EXIT.
  ENDIF.

* If object is reactivated is has to be in the environment
*   Andreea Rapa, MED-46159, 2011-11-08   START
*   Add object in the environment only if the environment exists
*    IF l_activate = on
  IF l_activate = on AND g_environment IS BOUND.
*   Andreea Rapa, MED-46159, 2011-11-08   END
    CALL METHOD me->if_ish_data_object~get_key_string
*      EXPORTING
*        i_with_mandt = '*'
      IMPORTING
        e_key        = l_key.
    CALL METHOD g_environment->is_in_objectlist
      EXPORTING
        i_key    = l_key
        i_type   = cl_ish_appointment=>co_otype_appointment
      IMPORTING
        e_object = lr_object.
    IF lr_object IS BOUND AND lr_object <> me.
      e_rc = 1.
      EXIT.
    ELSE.
      CALL METHOD g_environment->set_data
        EXPORTING
          i_object = me.
    ENDIF.
  ENDIF.

* The field L_WA_SNAPSHOT-CONNECTION_KEY is not used here.
* It is only considered in class CL_ISH_RUN_DATA.
  CALL METHOD undo_connection
    EXPORTING
      i_connection_key = l_wa_snapshot-connection_key.

* This snapshot can now be deleted.
  DELETE gt_snapshots WHERE key = i_key.

ENDMETHOD.


METHOD snapshot_before_change.
*New/PN/MED-40483

  DATA: l_create_snapshot    TYPE ish_on_off,
        l_rc                 TYPE ish_method_rc.
  DATA: ls_snapshot          LIKE LINE OF gt_snapshots.
  FIELD-SYMBOLS:
        <ls_snapshot>        LIKE LINE OF gt_snapshots.

* check if snapshot on demand is supported
  CHECK g_snapshot_if_required = on.

* check if environment available
  CHECK g_environment IS BOUND.

* check if environement has callback objekct for snapshot
  CHECK g_environment->gr_cb_snapshot IS BOUND.

* check if snapshot should be done
  CALL METHOD g_environment->gr_cb_snapshot->cb_snapshot_before_change
    EXPORTING
      ir_run_data       = me
    IMPORTING
      e_create_snapshot = l_create_snapshot
      e_rc              = e_rc
    CHANGING
      cr_errorhandler   = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK l_create_snapshot = on.

  CLEAR: ls_snapshot.
* loop over all entries with no snapshot object
  LOOP AT gt_snapshots ASSIGNING <ls_snapshot> WHERE object IS INITIAL.
    IF ls_snapshot-object IS INITIAL.
*     build snapshot
      CALL METHOD me->build_snapshot
        IMPORTING
          es_snapshot     = ls_snapshot
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = cr_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
    ENDIF.
*   change entry
    <ls_snapshot>-active = g_active.
    <ls_snapshot>-mode = g_mode.
    <ls_snapshot>-object = ls_snapshot-object.
  ENDLOOP.

ENDMETHOD.


METHOD snapshot_connection .

  CHECK g_objectbase IS BOUND.

* Snapshot the connections and return the connection key.
  CALL METHOD g_objectbase->snapshot
    IMPORTING
      e_key = e_connection_key.

ENDMETHOD.


METHOD undo_connection .

  CHECK g_objectbase IS BOUND.

* Snapshot the connections and return the connection key.
  CALL METHOD g_objectbase->undo
    EXPORTING
*     CDuerr, MED-31035 - Begin
      i_me  = me
*     CDuerr, MED-31035 - End
      i_key = i_connection_key.

ENDMETHOD.


METHOD _check_buffer_set_is_allowed.
* MED-40483

  DATA lx_static            TYPE REF TO cx_ish_static_handler.
  DATA ls_owner             LIKE LINE OF gt_owner.

* ----- ----- -----
  CLEAR: e_rc.
* ----- ----- -----
* if thre is no owner it is not allowed to set buffer
  IF gt_owner IS INITIAL.
    e_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '161'
        i_mv1           = i_buffer_object_name
        i_mv2           = i_object_name
        i_mv3           = '1'
        ir_object       = me
      CHANGING
        cr_errorhandler = cr_errorhandler.
    RETURN.
  ENDIF.
* ----- ----- -----
  LOOP AT gt_owner INTO ls_owner
    WHERE action = co_acts_set_buffer.
    TRY .
        ls_owner-r_owner->cb_simple_action( ir_controllable =  me
                                            i_action        =  co_acts_set_buffer ).

*     if there is an exeption buffer set is not allowed
      CATCH cx_ish_static_handler INTO lx_static.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          EXPORTING
            i_exceptions    = lx_static
          CHANGING
            cr_errorhandler = cr_errorhandler.
        e_rc = 1.
        CALL METHOD cl_ish_utl_base=>collect_messages
          EXPORTING
            i_typ           = 'E'
            i_kla           = 'N1BASE'
            i_num           = '161'
            i_mv1           = i_buffer_object_name
            i_mv2           = i_object_name
            i_mv3           = '3'
            ir_object       = me
          CHANGING
            cr_errorhandler = cr_errorhandler.
        RETURN.
    ENDTRY.

  ENDLOOP.
* There is no owner for this action
  IF sy-subrc <> 0.
    e_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '161'
        i_mv1           = i_buffer_object_name
        i_mv2           = i_object_name
        i_mv3           = '2'
        ir_object       = me
      CHANGING
        cr_errorhandler = cr_errorhandler.
    RETURN.
  ENDIF.

ENDMETHOD.


METHOD _check_case_pat_is_to_check.
* MED-40483

  DATA lt_owner             TYPE ish_t_controllable_owner_obj.
  DATA lr_owner             TYPE REF TO if_ish_controllable_owner.
  DATA lr_action_parameters TYPE REF TO cl_ish_result_act_set_buffer.
  DATA l_name               TYPE n1contentname.
  DATA l_result             TYPE ish_on_off.

  CLEAR: e_rc, e_no_check.

  lt_owner = me->if_ish_controllable~get_owners( i_action = co_actb_chk_dep_patcase ).

  IF lt_owner IS NOT INITIAL.
    TRY.
*       create content for action check
        CREATE OBJECT lr_action_parameters.
        l_name = co_actpar_chk_falnr.
        lr_action_parameters->set_content_boolean( i_name    = l_name
                                           i_content = i_check_falnr
                                           i_replace = abap_true ).
        l_name = co_actpar_chk_patnr.
        lr_action_parameters->set_content_boolean( i_name    = l_name
                                           i_content = i_check_patnr
                                           i_replace = abap_true ).

        l_name = co_actpar_chk_patnr.
        lr_action_parameters->set_content_boolean( i_name    = l_name
                                           i_content = i_check_papid
                                           i_replace = abap_true ).
        CLEAR e_no_check.
        LOOP AT lt_owner INTO lr_owner.
*         call controller if allowed to save
          l_result = lr_owner->cb_boolean_action( ir_controllable = me
                                           i_action = co_actb_chk_dep_patcase
                                           ir_parameters = lr_action_parameters ).

          IF l_result = abap_true.
*               check is not necessary
            CLEAR e_no_check.
            RETURN.
          ELSE.
            e_no_check = abap_true.
          ENDIF.
        ENDLOOP.
      CATCH cx_ish_static_handler.
*       nothing to do
        CLEAR e_no_check.
    ENDTRY.
  ENDIF.
ENDMETHOD.


METHOD _check_register_owner.
* MED-42121
  CALL METHOD cl_ish_utl_exception=>raise_static
    EXPORTING
      i_typ = 'E'
      i_kla = 'N1BASE'
      i_num = '030'
      i_mv1 = '1'
      i_mv2 = '_CHECK_REGISTER_OWNER'
      i_mv3 = 'CL_ISH_RUN_DATA'.
ENDMETHOD.
ENDCLASS.
