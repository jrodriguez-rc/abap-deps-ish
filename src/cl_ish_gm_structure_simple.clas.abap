class CL_ISH_GM_STRUCTURE_SIMPLE definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_GM_STRUCTURE_SIMPLE
*"* do not include other source files here!!!

  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .

  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

  class-methods CREATE_BY_DATA
    importing
      !IS_DATA type DATA
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_STRUCTURE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_STRUCTDESCR
    importing
      !IR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_STRUCTURE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_STRUCTNAME
    importing
      !I_STRUCTNAME type TABNAME
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_STRUCTURE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DATA
    changing
      !CS_DATA type DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_STRUCTDESCR
    returning
      value(RR_STRUCTDESCR) type ref to CL_ABAP_STRUCTDESCR .
  type-pools ABAP .
  methods SET_DATA
    importing
      !IS_DATA type DATA
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GM_STRUCTURE_SIMPLE
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL .
  type-pools ABAP .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .

  methods _DESTROY .
  methods _RAISE_EV_CHANGED
    importing
      !I_CHANGED_FIELD type ISH_FIELDNAME optional
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME optional .
  methods _SET_FIELD_CONTENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
      !I_RAISE_EVENT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GM_STRUCTURE_SIMPLE
*"* do not include other source files here!!!

  data GR_DATA type ref to DATA .
  data GR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR .
ENDCLASS.



CLASS CL_ISH_GM_STRUCTURE_SIMPLE IMPLEMENTATION.


METHOD constructor.

  DATA:
    lx_root      TYPE REF TO cx_root.

* Initial checking.
  IF ir_structdescr IS NOT BOUND.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* Call the super constructor.
  super->constructor( ).

* Initialize attributes.
  gr_structdescr = ir_structdescr.

* Create the data reference.
  TRY.
      CREATE DATA gr_data TYPE HANDLE gr_structdescr.
    CATCH cx_root INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Remember the callback object.
  gr_cb_structmdl   = ir_cb_structmdl.
  gr_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD create_by_data.

  DATA:
    lr_structdescr  TYPE REF TO cl_abap_structdescr,
    lx_root         TYPE REF TO cx_root.

* Determine the structure descriptor for the given data.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = is_data ).
    CATCH cx_sy_move_cast_error INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Create the instance.
  CREATE OBJECT rr_instance
    EXPORTING
      ir_structdescr    = lr_structdescr
      ir_cb_structmdl   = ir_cb_structmdl
      ir_cb_destroyable = ir_cb_destroyable.

* Set data.
  rr_instance->set_data( is_data = is_data ).

ENDMETHOD.


METHOD create_by_structdescr.

* Create the instance.
  CREATE OBJECT rr_instance
    EXPORTING
      ir_structdescr    = ir_structdescr
      ir_cb_structmdl   = ir_cb_structmdl
      ir_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD create_by_structname.

  DATA:
    lr_typedescr    TYPE REF TO cl_abap_typedescr,
    lr_structdescr  TYPE REF TO cl_abap_structdescr,
    lx_root         TYPE REF TO cx_root.

* Get the typedescriptor for the given structure name.
  CALL METHOD cl_abap_typedescr=>describe_by_name
    EXPORTING
      p_name      = i_structname
    RECEIVING
      p_descr_ref = lr_typedescr
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* The typedescriptor has to be a structure descriptor.
  TRY.
      lr_structdescr ?= lr_typedescr.
    CATCH cx_sy_move_cast_error INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Create the instance.
  CREATE OBJECT rr_instance
    EXPORTING
      ir_structdescr    = lr_structdescr
      ir_cb_structmdl   = ir_cb_structmdl
      ir_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD get_data.

  FIELD-SYMBOLS <ls_data>         TYPE data.

  ASSIGN gr_data->* TO <ls_data>.

  IF gr_structdescr->applies_to_data( p_data = cs_data ) = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_DATA'
        i_mv3        = 'CL_ISH_GM_STRUCTURE_SIMPLE' ).
  ENDIF.

  cs_data = <ls_data>.

ENDMETHOD.


METHOD get_structdescr.

  rr_structdescr = gr_structdescr.

ENDMETHOD.


METHOD if_ish_destroyable~destroy.

* Process only if we are not already destroyed or in destroy mode.
  CHECK is_destroyed( )       = abap_false.
  CHECK is_in_destroy_mode( ) = abap_false.

* Callback.
  IF gr_cb_destroyable IS BOUND.
    CHECK gr_cb_destroyable->cb_destroy( ir_destroyable = me ) = abap_true.
  ENDIF.

* Raise event before_destroy.
  RAISE EVENT ev_before_destroy.

* Set self in destroy mode.
  g_destroy_mode = abap_true.

* Destroy.
  _destroy( ).

* We are destroyed.
  g_destroy_mode = abap_false.
  g_destroyed    = abap_true.

* Export.
  r_destroyed = abap_true.

* Raise event after_destroy.
  RAISE EVENT ev_after_destroy.

ENDMETHOD.


METHOD if_ish_destroyable~is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD if_ish_destroyable~is_in_destroy_mode.

  r_destroy_mode = g_destroy_mode.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  ASSIGN gr_data->* TO <ls_data>.

  CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
    EXPORTING
      ir_model    = me
      is_data     = <ls_data>
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA l_fieldname                TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_component>    TYPE abap_compdescr.

  LOOP AT gr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    INSERT l_fieldname INTO TABLE rt_supported_fieldname.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  READ TABLE gr_structdescr->components
    WITH KEY name = i_fieldname
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  r_changed = _set_field_content(
      i_fieldname   = i_fieldname
      i_content     = i_content
      i_raise_event = abap_true ).

ENDMETHOD.


METHOD set_data.

  DATA lr_structdescr             TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                TYPE ish_fieldname.
  DATA lt_changed_field           TYPE ish_t_fieldname.

  FIELD-SYMBOLS <ls_component>    TYPE abap_compdescr.
  FIELD-SYMBOLS <l_content>       TYPE any.

  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( is_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'SET_DATA'
          i_mv3        = 'CL_ISH_GM_STRUCTURE_SIMPLE' ).
  ENDTRY.

  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    ASSIGN COMPONENT l_fieldname OF STRUCTURE is_data TO <l_content>.
    CHECK _set_field_content(
       i_fieldname   = l_fieldname
       i_content     = <l_content>
       i_raise_event = abap_false ) = abap_true.
    INSERT l_fieldname INTO TABLE lt_changed_field.
  ENDLOOP.

  CHECK lt_changed_field IS NOT INITIAL.

  _raise_ev_changed( it_changed_field = lt_changed_field ).

  r_changed = abap_true.

ENDMETHOD.


METHOD _destroy.

  FIELD-SYMBOLS:
    <ls_data>  TYPE data.

* Clear only the data, not the data reference.
* The structdescr is also not freed.
  ASSIGN gr_data->* TO <ls_data>.
  CLEAR: <ls_data>.
  CLEAR gr_cb_structmdl.
  CLEAR gr_cb_destroyable.

ENDMETHOD.


METHOD _raise_ev_changed.

  DATA lt_changed_field           TYPE ish_t_fieldname.

  lt_changed_field = it_changed_field.
  IF i_changed_field IS NOT INITIAL.
    INSERT i_changed_field INTO TABLE lt_changed_field.
  ENDIF.

  CHECK lt_changed_field IS NOT INITIAL.

  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

ENDMETHOD.


METHOD _set_field_content.

  FIELD-SYMBOLS <ls_data>           TYPE any.
  FIELD-SYMBOLS <l_content>         TYPE any.

* i_fieldname has to be specified.
  IF i_fieldname IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GM_STRUCTURE_SIMPLE' ).
  ENDIF.

* Assign the structure.
  ASSIGN gr_data->* TO <ls_data>.

* Assign the component with the given fieldname.
  ASSIGN COMPONENT i_fieldname OF STRUCTURE <ls_data> TO <l_content>.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = '_SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GM_STRUCTURE_SIMPLE' ).
  ENDIF.

* Check if assignment is allowed.
  IF cl_ish_utl_gui_structure_model=>is_assignment_allowed(
      i_source  = i_content
      i_target  = <l_content> ) = 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '3'
        i_mv2        = '_SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GM_STRUCTURE_SIMPLE' ).
  ENDIF.

* Process only on changes.
  CHECK i_content <> <l_content>.

* Callback.
  IF gr_cb_structmdl IS BOUND.
    CHECK gr_cb_structmdl->cb_set_field_content(
        ir_model    = me
        i_fieldname = i_fieldname
        i_content   = i_content ) = abap_true.
  ENDIF.

* Set field content.
  <l_content> = i_content.

* Raise event ev_changed.
  IF i_raise_event = abap_true.
    _raise_ev_changed( i_changed_field = i_fieldname ).
  ENDIF.

* Export.
  r_changed = abap_true.

ENDMETHOD.
ENDCLASS.
