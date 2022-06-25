class CL_ISH_GM_XSTRUCTURE definition
  public
  inheriting from CL_ISH_GM_STRUCTURE
  abstract
  create public .

public section.
*"* public components of class CL_ISH_GM_XSTRUCTURE
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_XSTRUCTURE_MODEL .

  aliases GET_DATA
    for IF_ISH_GUI_XSTRUCTURE_MODEL~GET_DATA .
  aliases IS_FIELD_CHANGEABLE
    for IF_ISH_GUI_XSTRUCTURE_MODEL~IS_FIELD_CHANGEABLE .
  aliases IS_READONLY
    for IF_ISH_GUI_XSTRUCTURE_MODEL~IS_READONLY .
  aliases SET_DATA
    for IF_ISH_GUI_XSTRUCTURE_MODEL~SET_DATA .

  methods CONSTRUCTOR
    importing
      !IR_CB_STRUCTURE_MODEL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional .
protected section.
*"* protected components of class CL_ISH_GM_XSTRUCTURE
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GM_XSTRUCTURE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_XSTRUCTURE IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      ir_cb_structure_model = ir_cb_structure_model
      ir_cb_destroyable     = ir_cb_destroyable ).

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~get_data.

  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA lr_data                            TYPE REF TO data.
  DATA l_fieldname                        TYPE ish_fieldname.

  FIELD-SYMBOLS <ls_data>                 TYPE data.
  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE any.
  FIELD-SYMBOLS <l_target_field>          TYPE any.

* No processing if self is destroyed.
  IF is_destroyed( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_DATA'
        i_mv3        = cl_ish_utl_rtti=>get_class_name( me ) ).
  ENDIF.

* cs_data has to be a structure.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( cs_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'GET_DATA'
          i_mv3        = cl_ish_utl_rtti=>get_class_name( me ) ).
  ENDTRY.

* Get data.
  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

* Take over fields.
  MOVE-CORRESPONDING <ls_data> TO cs_data.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_field_changeable.

  CHECK is_destroyed( ) = abap_false.

  CHECK is_readonly( ) = abap_false.

  CHECK is_field_supported( i_fieldname ) = abap_true.

  r_changeable = abap_true.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~is_readonly.

  IF is_destroyed( ) = abap_true.
    r_readonly = abap_true.
    RETURN.
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_xstructure_model~set_data.

  DATA lr_data                            TYPE REF TO data.
  DATA lr_structdescr                     TYPE REF TO cl_abap_structdescr.
  DATA l_fieldname                        TYPE ish_fieldname.
  DATA l_fieldname_x                      TYPE ish_fieldname.
  DATA lt_tmp_changed_field               TYPE ish_t_fieldname.
  DATA l_rc                               TYPE ish_method_rc.
  DATA lr_messages                        TYPE REF TO cl_ishmed_errorhandling.
  DATA lx_static                          TYPE REF TO cx_ish_static_handler.

  FIELD-SYMBOLS <ls_data>                 TYPE data.
  FIELD-SYMBOLS <ls_component>            TYPE abap_compdescr.
  FIELD-SYMBOLS <l_source_field>          TYPE any.
  FIELD-SYMBOLS <l_source_field_x>        TYPE any.
  FIELD-SYMBOLS <l_target_field>          TYPE any.
  FIELD-SYMBOLS <l_changed_field>         TYPE ish_fieldname.

* No processing if self is destroyed.
  IF is_destroyed( ) = abap_true.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_DATA'
        i_mv3        = cl_ish_utl_rtti=>get_class_name( me ) ).
  ENDIF.

* is_data has to be a structure.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( is_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'SET_DATA'
          i_mv3        = cl_ish_utl_rtti=>get_class_name( me ) ).
  ENDTRY.

* Get data.
  lr_data = _get_r_data( ).
  ASSIGN lr_data->* TO <ls_data>.

* Process the fields.
  LOOP AT lr_structdescr->components ASSIGNING <ls_component>.

    l_fieldname = <ls_component>-name.

*   Handle it_field2change.
    IF it_field2change IS NOT INITIAL.
      READ TABLE it_field2change FROM l_fieldname TRANSPORTING NO FIELDS.
      CHECK sy-subrc = 0.
    ENDIF.

*   Assign the source field.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE is_data
      TO <l_source_field>.
    CHECK sy-subrc = 0.

*   Assign the target field.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_data>
      TO <l_target_field>.
    CHECK sy-subrc = 0.

*   Handle xfields.
    IF i_handle_xfields = abap_true.
      CONCATENATE l_fieldname 'X' INTO l_fieldname_x SEPARATED BY '_'.
      ASSIGN COMPONENT l_fieldname
        OF STRUCTURE is_data
        TO <l_source_field_x>.
      CHECK sy-subrc = 0.
      CHECK <l_source_field_x> = abap_true.
    ENDIF.

*   Process only on changes.
    CHECK <l_source_field> <> <l_target_field>.

*   Handle i_soft.
    IF i_soft = abap_true.
      CHECK is_field_changeable( l_fieldname ) = abap_true.
    ENDIF.

*   Set field content.
    TRY.
        lt_tmp_changed_field = _set_field_content(
            i_fieldname        = l_fieldname
            i_content          = <l_source_field> ).
      CATCH cx_ish_static_handler INTO lx_static.
        l_rc = 1.
        IF lr_messages IS BOUND.
          IF lx_static->gr_errorhandler IS BOUND.
            lr_messages->copy_messages( i_copy_from = lx_static->gr_errorhandler ).
          ENDIF.
        ELSE.
          lr_messages = lx_static->gr_errorhandler.
        ENDIF.
        CONTINUE.
    ENDTRY.

*   Further processing only on changes.
    CHECK lt_tmp_changed_field IS NOT INITIAL.

*   Build rt_changed_field.
    LOOP AT lt_tmp_changed_field ASSIGNING <l_changed_field>.
      READ TABLE rt_changed_field FROM <l_changed_field> TRANSPORTING NO FIELDS.
      CHECK sy-subrc <> 0.
      INSERT <l_changed_field> INTO TABLE rt_changed_field.
    ENDLOOP.

  ENDLOOP.

* Raise event ev_changed.
  _raise_ev_changed( rt_changed_field ).

* Errorhandling.
  IF l_rc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler
      EXPORTING
        gr_errorhandler = lr_messages.
  ENDIF.

ENDMETHOD.
ENDCLASS.
