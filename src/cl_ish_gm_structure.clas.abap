class CL_ISH_GM_STRUCTURE definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GM_STRUCTURE
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .
  interfaces IF_ISH_DESTROYABLE .

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

  methods CONSTRUCTOR
    importing
      !IR_CB_STRUCTURE_MODEL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional .
protected section.
*"* protected components of class CL_ISH_GM_STRUCTURE
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GR_CB_STRUCTURE_MODEL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL .
  type-pools ABAP .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .

  methods _ADJUST_CHANGES
    importing
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME .
  methods _DESTROY
  abstract .
  methods _GET_R_DATA
  abstract
    returning
      value(RR_DATA) type ref to DATA .
  methods _RAISE_EV_CHANGED
    importing
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME .
  methods _SET_FIELD_CONTENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_CONTENT type ANY
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME
    raising
      CX_ISH_STATIC_HANDLER .
  methods __ADJUST_CHANGES
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !IT_CHANGED_FIELD type ISH_T_FIELDNAME
    returning
      value(RT_CHANGED_FIELD) type ISH_T_FIELDNAME .
private section.
*"* private components of class CL_ISH_GM_STRUCTURE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_STRUCTURE IMPLEMENTATION.


METHOD constructor.

  gr_cb_structure_model = ir_cb_structure_model.
  gr_cb_destroyable     = ir_cb_destroyable.

ENDMETHOD.


METHOD if_ish_destroyable~destroy.

  DATA lr_cb_destroyable              TYPE REF TO if_ish_destroyable.

* No processing if self is already destroyed.
  IF is_destroyed( ) = abap_true.
    r_destroyed = abap_true.
    RETURN.
  ENDIF.

* Callback.
* A callback is only needed if the cb_destroyable is not destroyed.
  DO 1 TIMES.
    CHECK gr_cb_destroyable IS BOUND.
    TRY.
        lr_cb_destroyable ?= gr_cb_destroyable.
        CHECK lr_cb_destroyable->is_destroyed( ) = abap_false.
        CHECK lr_cb_destroyable->is_in_destroy_mode( ) = abap_false.
      CATCH cx_sy_move_cast_error.                      "#EC NO_HANDLER
    ENDTRY.
    IF gr_cb_destroyable->cb_destroy( me ) = abap_false.
      RETURN.
    ENDIF.
  ENDDO.

* We are in destroy mode.
  g_destroy_mode = abap_true.

* Raise event ev_before_destroy.
  RAISE EVENT ev_before_destroy.

* Internal processing.
  _destroy( ).

* Destroy attributes.
  CLEAR gr_cb_destroyable.
  CLEAR gr_cb_structure_model.

* Now we are destroyed.
  g_destroy_mode = abap_false.
  g_destroyed = abap_true.

* Raise event ev_after_destroy.
  RAISE EVENT ev_after_destroy.

* Export.
  r_destroyed = abap_true.

ENDMETHOD.


METHOD if_ish_destroyable~is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD if_ish_destroyable~is_in_destroy_mode.

  r_destroy_mode = g_destroy_mode.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA lr_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  CHECK is_destroyed( ) = abap_false.

  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

  CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
    EXPORTING
      ir_model    = me
      is_data     = <ls_data>
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA lr_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  CHECK is_destroyed( ) = abap_false.

  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

  rt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields( <ls_data> ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  DATA lr_data                      TYPE REF TO data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  CHECK is_destroyed( ) = abap_false.

  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

  r_supported = cl_ish_utl_gui_structure_model=>is_field_supported(
      is_data     = <ls_data>
      i_fieldname = i_fieldname ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA lt_changed_field             TYPE ish_t_fieldname.

* No processing if self is destroyed.
  IF is_destroyed( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = cl_ish_utl_rtti=>get_class_name( me ) ).
  ENDIF.

* Set field content.
  lt_changed_field = _set_field_content(
      i_fieldname = i_fieldname
      i_content   = i_content ).

* Further processing only on changes.
  CHECK lt_changed_field IS NOT INITIAL.

* Raise event ev_changed.
  _raise_ev_changed( it_changed_field = lt_changed_field ).

* The field was changed.
  r_changed = abap_true.

ENDMETHOD.


METHOD _adjust_changes.

  DATA lt_changed_field                     TYPE ish_t_fieldname.
  DATA lt_tmp_changed_field                 TYPE ish_t_fieldname.

  FIELD-SYMBOLS <l_changed_field>           TYPE ish_fieldname.
  FIELD-SYMBOLS <l_tmp_changed_field>       TYPE ish_fieldname.

  CHECK it_changed_field IS NOT INITIAL.

  lt_changed_field = it_changed_field.

  LOOP AT lt_changed_field ASSIGNING <l_changed_field>.
    lt_tmp_changed_field = __adjust_changes(
        i_fieldname       = <l_changed_field>
        it_changed_field  = it_changed_field ).
    LOOP AT lt_tmp_changed_field ASSIGNING <l_tmp_changed_field>.
      READ TABLE rt_changed_field FROM <l_tmp_changed_field> TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        APPEND <l_tmp_changed_field> TO rt_changed_field.
      ENDIF.
      READ TABLE lt_changed_field FROM <l_tmp_changed_field> TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        APPEND <l_tmp_changed_field> TO lt_changed_field.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD _raise_ev_changed.

  CHECK it_changed_field IS NOT INITIAL.

  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = it_changed_field.

ENDMETHOD.


METHOD _set_field_content.

  DATA lr_data                      TYPE REF TO data.
  DATA l_changed                    TYPE abap_bool.
  DATA lt_tmp_changed_field         TYPE ish_t_fieldname.

  FIELD-SYMBOLS <ls_data>           TYPE data.
  FIELD-SYMBOLS <l_changed_field>   TYPE ish_fieldname.

* Get data.
  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

* Set field content.
  CALL METHOD cl_ish_utl_gui_structure_model=>set_field_content
    EXPORTING
      ir_model    = me
      i_fieldname = i_fieldname
      i_content   = i_content
      ir_cb       = gr_cb_structure_model
    IMPORTING
      e_changed   = l_changed
    CHANGING
      cs_data     = <ls_data>.

* Further processing only on changes.
  CHECK l_changed = abap_true.

* Build a table with the changed fieldnames.
  INSERT i_fieldname INTO TABLE rt_changed_field.

* Adjust changes and collect additionally changed fields.
  lt_tmp_changed_field = _adjust_changes( it_changed_field = rt_changed_field ).
  LOOP AT lt_tmp_changed_field ASSIGNING <l_changed_field>.
    READ TABLE rt_changed_field FROM <l_changed_field> TRANSPORTING NO FIELDS.
    CHECK sy-subrc <> 0.
    INSERT <l_changed_field> INTO TABLE rt_changed_field.
  ENDLOOP.

* Raise event ev_changed.
  _raise_ev_changed( it_changed_field = rt_changed_field ).

ENDMETHOD.


METHOD __adjust_changes.

* No default processing.

* Redefine to adjust field changes.

ENDMETHOD.
ENDCLASS.
