class CL_ISH_GUI_DYNPRO_VIEW definition
  public
  inheriting from CL_ISH_GUI_VIEW
  abstract
  create public

  global friends CL_ISH_GUI_DYNPRO_CONNECTOR .

public section.
*"* public components of class CL_ISH_GUI_DYNPRO_VIEW
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_DYNPRO_VIEW .

  aliases CO_UCOMM_POV_PROCESSED
    for IF_ISH_GUI_DYNPRO_VIEW~CO_UCOMM_POV_PROCESSED .
  aliases COMPLETE_POV
    for IF_ISH_GUI_DYNPRO_VIEW~COMPLETE_POV .
  aliases GET_DYNNR
    for IF_ISH_GUI_DYNPRO_VIEW~GET_DYNNR .
  aliases GET_DYNPRO_LAYOUT
    for IF_ISH_GUI_DYNPRO_VIEW~GET_DYNPRO_LAYOUT .
  aliases GET_DYNPSTRUCT_FIELDNAME
    for IF_ISH_GUI_DYNPRO_VIEW~GET_DYNPSTRUCT_FIELDNAME .
  aliases GET_DYNPSTRUCT_NAME
    for IF_ISH_GUI_DYNPRO_VIEW~GET_DYNPSTRUCT_NAME .
  aliases GET_REPID
    for IF_ISH_GUI_DYNPRO_VIEW~GET_REPID .

  type-pools ABAP .
  class-methods DYNP_VALUES_READ
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
      !I_TRANSLATE_TO_UPPER type ABAP_BOOL default ABAP_FALSE
      !I_CONVERT type ABAP_BOOL default ABAP_TRUE
      !IR_ERROR_OBJECT type ref to OBJECT optional
    changing
      !CT_DYNPREAD type ISH_T_DYNPREAD
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods DYNP_VALUES_UPDATE
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
      !IT_DYNPREAD type ISH_T_DYNPREAD
      !IR_ERROR_OBJECT type ref to OBJECT optional
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods DYNP_VALUE_READ
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME
      !I_TRANSLATE_TO_UPPER type ABAP_BOOL default ABAP_FALSE
      !I_CONVERT type ABAP_BOOL default ABAP_TRUE
      !IR_ERROR_OBJECT type ref to OBJECT optional
    returning
      value(R_VALUE) type DYNFIELDVALUE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods DYNP_VALUE_UPDATE
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME
      !I_FIELDVALUE type DYNFIELDVALUE
      !IR_ERROR_OBJECT type ref to OBJECT optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    preferred parameter I_ELEMENT_NAME .

  methods IF_ISH_GUI_VIEW~SET_FOCUS
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_DYNPRO_VIEW
*"* do not include other source files here!!!

  data GR_DYNPSTRUCT type ref to DATA .
  data GR_DYNPSTRUCTDESCR type ref to CL_ABAP_STRUCTDESCR .
  data GR_DYNPSTRUCT_PBO type ref to DATA .
  data GT_DYNPLAY_VCODE type ISH_T_GUI_DYNPLAY_VCODE_H .
  data GT_TMP_POV_CHANGED_FIELD type ISH_T_DYNPREAD .
  data G_CURSORFIELD type ISH_FIELDNAME .
  data G_DYNNR type SYDYNNR value '0001'. "#EC NOTEXT .
  type-pools ABAP .
  data G_POV_IN_PROCESS type ABAP_BOOL .
  data G_REPID type SYREPID value 'SAPLN1SC'. "#EC NOTEXT .
  data G_TMP_POV_DYNNR type SYDYNNR .
  data G_TMP_POV_REPID type SYREPID .

  methods ON_MODEL_CHANGED
    for event EV_CHANGED of IF_ISH_GUI_STRUCTURE_MODEL
    importing
      !ET_CHANGED_FIELD
      !SENDER .
  methods _CONNECT_TO_DYNPRO
    importing
      !I_DYNNR_TO type SYDYNNR optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DYNP_VALUES_READ
    importing
      !I_TRANSLATE_TO_UPPER type ABAP_BOOL default ABAP_FALSE
      !I_CONVERT type ABAP_BOOL default ABAP_TRUE
    changing
      !CT_DYNPREAD type ISH_T_DYNPREAD
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DYNP_VALUES_UPDATE
    importing
      !IT_DYNPREAD type ISH_T_DYNPREAD
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DYNP_VALUE_READ
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_TRANSLATE_TO_UPPER type ABAP_BOOL default ABAP_FALSE
      !I_CONVERT type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_VALUE) type DYNFIELDVALUE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _DYNP_VALUE_UPDATE
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_FIELDVALUE type DYNFIELDVALUE
    raising
      CX_ISH_STATIC_HANDLER .
  methods _GET_CURSORFIELD_BY_MESSAGE
    importing
      !IS_MESSAGE type RN1MESSAGE
    returning
      value(R_CURSORFIELD) type ISH_FIELDNAME .
  methods _GET_DEFAULT_CURSORFIELD
    returning
      value(R_DEFAULT_CURSORFIELD) type ISH_FIELDNAME .
  methods _GET_STRUCTURE_MODEL
    returning
      value(RR_STRUCTURE_MODEL) type ref to IF_ISH_GUI_STRUCTURE_MODEL .
  methods _INIT_DYNPRO_VIEW
    importing
      !IR_CONTROLLER type ref to IF_ISH_GUI_CONTROLLER
      !IR_PARENT_VIEW type ref to IF_ISH_GUI_DYNPRO_VIEW optional
      !IR_LAYOUT type ref to CL_ISH_GUI_DYNPRO_LAYOUT optional
      !I_VCODE type ISH_VCODE default CO_VCODE_DISPLAY
      !I_REPID type SYREPID
      !I_DYNNR type SYDYNNR
      !I_DYNPSTRUCT_NAME type TABNAME optional
      !IT_DYNPLAY_VCODE type ISH_T_GUI_DYNPLAY_VCODE_H optional
      !I_DYNNR_TO type SYDYNNR optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _MODIFY_SCREEN
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _MODIFY_SCREEN_ISH_SCRM
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !I_EINRI type EINRI optional .
  methods _MODIFY_SCREEN_LAYOUT
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !IR_LAYOUT type ref to CL_ISH_GUI_DYNPRO_LAYOUT optional .
  methods _MODIFY_SCREEN_VCODE
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional .
  methods _MODIFY_SCREEN_XSTRUCTMDL
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !IR_MODEL type ref to IF_ISH_GUI_XSTRUCTURE_MODEL optional .
  methods _POH
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_PROCESSED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods _POV
    importing
      !I_REPID type SY-REPID
      !I_DYNNR type SY-DYNNR
      !I_FIELDNAME type ISH_FIELDNAME
    exporting
      !E_PROCESSED type ABAP_BOOL
      !ET_CHANGED_FIELD type ISH_T_DYNPREAD
    raising
      CX_ISH_STATIC_HANDLER .
  methods _PROPAGATE_DYNPRO_EVENT
    importing
      !I_PROCESSING_BLOCK type N1GUI_DYNP_PROCBLOCK
      !I_UCOMM type SYUCOMM optional
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROPAGATE_DYNPRO_HELP_EVENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME optional
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _PROPAGATE_DYNPRO_VALUE_EVENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME optional
    returning
      value(RR_RESPONSE) type ref to CL_ISH_GUI_RESPONSE .
  methods _SET_CURSOR_AT_PBO
    importing
      !IS_DYNPSTRUCT type DATA
    returning
      value(R_CURSOR_SET) type ABAP_BOOL .
  methods _TRANSPORT_DYNPRO_TO_MODEL
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !IS_DYNPSTRUCT type DATA optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods _TRANSPORT_MODEL_TO_DYNPRO
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
    changing
      !CS_DYNPSTRUCT type DATA optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods __AFTER_PAI
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional .
  methods __AFTER_PBO
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional .
  methods __BEFORE_CALL_SUBSCREEN
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !I_SUBSCREEN_NAME type N1GUI_ELEMENT_NAME
    exporting
      !E_SUBSCREEN_REPID type SY-REPID
      !E_SUBSCREEN_DYNNR type SY-DYNNR .
  methods __BEFORE_PAI
    importing
      !I_REPID type SYREPID optional
      !I_DYNNR type SYDYNNR optional
      !I_UCOMM type SYUCOMM optional .
  methods __BEFORE_PBO
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional .
  methods __PAI
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !IS_DYNPSTRUCT type DATA optional .
  methods __PBO
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
    changing
      !CS_DYNPSTRUCT type DATA optional .
  methods __POH
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !I_FIELDNAME type ISH_FIELDNAME optional .
  methods __POV
    importing
      !I_REPID type SY-REPID optional
      !I_DYNNR type SY-DYNNR optional
      !I_FIELDNAME type ISH_FIELDNAME optional .

  methods _DESTROY
    redefinition .
  methods _SET_VCODE
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_DYNPRO_VIEW
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_DYNPRO_VIEW IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name    = i_element_name
      ir_cb_destroyable = ir_cb_destroyable ).

ENDMETHOD.


METHOD dynp_values_read.

  CALL FUNCTION 'ISH_DYNP_VALUES_READ'
    EXPORTING
      dyname               = i_repid
      dynumb               = i_dynnr
      translate_to_upper   = i_translate_to_upper
      conversion           = i_convert
    TABLES
      dynpfields           = ct_dynpread
    EXCEPTIONS
      invalid_abapworkarea = 1
      invalid_dynprofield  = 2
      invalid_dynproname   = 3
      invalid_dynpronummer = 4
      invalid_request      = 5
      no_fielddescription  = 6
      undefind_error       = 7
      OTHERS               = 8.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static_by_syst( ir_object = ir_error_object ).
  ENDIF.

ENDMETHOD.


METHOD dynp_values_update.

  CALL FUNCTION 'DYNP_VALUES_UPDATE'
    EXPORTING
      dyname               = i_repid
      dynumb               = i_dynnr
    TABLES
      dynpfields           = it_dynpread
    EXCEPTIONS
      invalid_abapworkarea = 1
      invalid_dynprofield  = 2
      invalid_dynproname   = 3
      invalid_dynpronummer = 4
      invalid_request      = 5
      no_fielddescription  = 6
      undefind_error       = 7
      OTHERS               = 8.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static_by_syst( ir_object = ir_error_object ).
  ENDIF.

ENDMETHOD.


METHOD dynp_value_read.

  DATA:
    lt_dynpread            TYPE ish_t_dynpread,
    ls_dynpread            TYPE dynpread.

  FIELD-SYMBOLS:
    <ls_dynpread>          TYPE dynpread.

  ls_dynpread-fieldname = i_fieldname.
  INSERT ls_dynpread INTO TABLE lt_dynpread.

  CALL METHOD dynp_values_read
    EXPORTING
      i_repid              = i_repid
      i_dynnr              = i_dynnr
      i_translate_to_upper = i_translate_to_upper
      i_convert            = i_convert
      ir_error_object      = ir_error_object
    CHANGING
      ct_dynpread          = lt_dynpread.

  READ TABLE lt_dynpread INDEX 1 ASSIGNING <ls_dynpread>.
  CHECK sy-subrc = 0.

  r_value = <ls_dynpread>-fieldvalue.

ENDMETHOD.


METHOD dynp_value_update.

  DATA:
    ls_dynpread            TYPE dynpread,
    lt_dynpread            TYPE ish_t_dynpread.

  ls_dynpread-fieldname  = i_fieldname.
  ls_dynpread-fieldvalue = i_fieldvalue.
  INSERT ls_dynpread INTO TABLE lt_dynpread.

  dynp_values_update( i_repid         = i_repid
                      i_dynnr         = i_dynnr
                      it_dynpread     = lt_dynpread
                      ir_error_object = ir_error_object ).

ENDMETHOD.


METHOD if_ish_gui_dynpro_view~complete_pov.

  DATA l_repid            TYPE syrepid.
  DATA l_dynnr            TYPE sydynnr.

* POV has to be in process.
  IF g_pov_in_process = abap_false.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'COMPLETE_POV'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_VIEW' ).
  ENDIF.

* Process only on changed fields.
  CHECK it_changed_field IS NOT INITIAL.

  IF i_repid IS INITIAL.
    l_repid = g_repid.
    l_dynnr = g_dynnr.
  ELSE.
    l_repid = i_repid.
    l_dynnr = i_dynnr.
  ENDIF.

* Update dynpro values.
  dynp_values_update(
      i_repid         = l_repid
      i_dynnr         = l_dynnr
      it_dynpread     = it_changed_field ).

* Remember temporary data to be handled in _transport_dynpro_to_model.
  g_tmp_pov_repid           = l_repid.
  g_tmp_pov_dynnr           = l_dynnr.
  gt_tmp_pov_changed_field  = it_changed_field.

* Set new ok_code.
  CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'
    EXPORTING
      functioncode = co_ucomm_pov_processed
    EXCEPTIONS
      OTHERS       = 0.
  CALL METHOD cl_gui_cfw=>update_view.

ENDMETHOD.


METHOD if_ish_gui_dynpro_view~get_dynnr.

  r_dynnr = g_dynnr.

ENDMETHOD.


METHOD if_ish_gui_dynpro_view~get_dynpro_layout.

  TRY.
      rr_dynpro_layout ?= get_layout( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD if_ish_gui_dynpro_view~get_dynpstruct_fieldname.

  DATA l_dynpstruct_name            TYPE tabname.

  CHECK i_fieldname IS NOT INITIAL.

  l_dynpstruct_name = get_dynpstruct_name( ).
  CHECK l_dynpstruct_name IS NOT INITIAL.

  CONCATENATE
    l_dynpstruct_name
    i_fieldname
    INTO r_dynpstruct_fieldname
    SEPARATED BY '-'.

ENDMETHOD.


METHOD if_ish_gui_dynpro_view~get_dynpstruct_name.

  CHECK gr_dynpstructdescr IS BOUND.

  r_dynpstruct_name = gr_dynpstructdescr->get_relative_name( ).

ENDMETHOD.


METHOD if_ish_gui_dynpro_view~get_repid.

  r_repid = g_repid.

ENDMETHOD.


METHOD if_ish_gui_view~set_focus.

  CHECK gr_dynpstructdescr IS BOUND.

  r_success = super->if_ish_gui_view~set_focus( ).

ENDMETHOD.


METHOD on_model_changed.

  DATA lr_model                         TYPE REF TO if_ish_gui_structure_model.
  DATA l_fieldname                      TYPE ish_fieldname.
  DATA lx_root                          TYPE REF TO cx_root.

  FIELD-SYMBOLS <l_fieldname>           TYPE ish_fieldname.
  FIELD-SYMBOLS <ls_dynpstruct>         TYPE data.
  FIELD-SYMBOLS <ls_component>          TYPE abap_compdescr.
  FIELD-SYMBOLS <l_field>               TYPE any.

* The sender has to be our model.
  CHECK sender IS BOUND.
  CHECK sender = _get_model( ).

* On changes we have to remove the corresponding errorfield.
  LOOP AT et_changed_field ASSIGNING <l_fieldname>.
    _remove_errorfield(
        ir_model    = sender
        i_fieldname = <l_fieldname> ).
  ENDLOOP.

* The dynpro structure description has to exist.
  CHECK gr_dynpstructdescr IS BOUND.

* Get the model.
  lr_model = _get_structure_model( ).
  CHECK lr_model IS BOUND.

* Process only our model changes.
  CHECK lr_model = sender.

* Process only if we have an actual dynpro structure.
  CHECK gr_dynpstruct IS BOUND.
  ASSIGN gr_dynpstruct->* TO <ls_dynpstruct>.

* Check the actual dynpro structure.
  IF gr_dynpstructdescr->applies_to_data( p_data = <ls_dynpstruct> ) = abap_false.
    CLEAR: gr_dynpstruct.
    RETURN.
  ENDIF.

* Actualize the actual dynpro structure.
  LOOP AT gr_dynpstructdescr->components ASSIGNING <ls_component>.
*   Process only fields which are supported by the model.
    l_fieldname = <ls_component>-name.
    CHECK l_fieldname IS NOT INITIAL.
    CHECK lr_model->is_field_supported( i_fieldname = l_fieldname ) = abap_true.
*   Process only changed fields.
    IF et_changed_field IS NOT INITIAL.
      READ TABLE et_changed_field FROM l_fieldname TRANSPORTING NO FIELDS.
      CHECK sy-subrc = 0.
    ENDIF.
*   Assign the actual dynpro structure's field.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_dynpstruct>
      TO <l_field>.
    CHECK sy-subrc = 0.
*   Actualize the actual dynpro structure's field.
*   Any errors are propagated.
    TRY.
        CALL METHOD lr_model->get_field_content
          EXPORTING
            i_fieldname = l_fieldname
          CHANGING
            c_content   = <l_field>.
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( ir_exception = lx_root ).
        CONTINUE.
    ENDTRY.
  ENDLOOP.

ENDMETHOD.


METHOD _connect_to_dynpro.

  IF g_repid IS INITIAL    OR
     g_dynnr IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_CONNECT_TO_DYNPRO'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_VIEW' ).
  ENDIF.

  IF g_repid = 'SAPLN1SC' AND
     g_dynnr = '0001'.
    RETURN.
  ENDIF.

  IF i_dynnr_to IS INITIAL.
    cl_ish_gui_dynpro_connector=>connect(
        ir_view = me
        i_repid = g_repid
        i_dynnr = g_dynnr ).
  ELSE.
    g_dynnr = cl_ish_gui_dynpro_connector=>connect_free(
        ir_view      = me
        i_repid      = g_repid
        i_dynnr_from = g_dynnr
        i_dynnr_to   = i_dynnr_to ).
  ENDIF.

ENDMETHOD.


METHOD _destroy.

  DATA lr_structmdl           TYPE REF TO if_ish_gui_structure_model.

* Deregister the eventhandlers.
  lr_structmdl = _get_structure_model( ).
  IF lr_structmdl IS BOUND.
    SET HANDLER on_model_changed FOR lr_structmdl ACTIVATION abap_false.
  ENDIF.

* Call the super method.
  super->_destroy( ).

* Disconnect from the dynpro.
  cl_ish_gui_dynpro_connector=>disconnect( ir_view = me ).

* Clear attributes.
  CLEAR:
    gr_dynpstruct,
    gr_dynpstructdescr,
    gr_dynpstruct_pbo,
    g_cursorfield.
  CLEAR g_pov_in_process.
  CLEAR gt_tmp_pov_changed_field.
  CLEAR g_tmp_pov_repid.
  CLEAR g_tmp_pov_dynnr.
  g_repid = 'SAPLN1SC'.
  g_dynnr = '0001'.

ENDMETHOD.


METHOD _dynp_values_read.

  CALL METHOD cl_ish_gui_dynpro_view=>dynp_values_read
    EXPORTING
      i_repid              = g_repid
      i_dynnr              = g_dynnr
      i_translate_to_upper = i_translate_to_upper
      i_convert            = i_convert
      ir_error_object      = me
    CHANGING
      ct_dynpread          = ct_dynpread.

ENDMETHOD.


METHOD _dynp_values_update.

  CALL METHOD cl_ish_gui_dynpro_view=>dynp_values_update
    EXPORTING
      i_repid         = g_repid
      i_dynnr         = g_dynnr
      it_dynpread     = it_dynpread
      ir_error_object = me.

ENDMETHOD.


METHOD _dynp_value_read.

  DATA:
    lt_dynpread            TYPE ish_t_dynpread,
    ls_dynpread            TYPE dynpread.

  FIELD-SYMBOLS:
    <ls_dynpread>          TYPE dynpread.

  ls_dynpread-fieldname = i_fieldname.
  INSERT ls_dynpread INTO TABLE lt_dynpread.

  CALL METHOD _dynp_values_read
    EXPORTING
      i_translate_to_upper = i_translate_to_upper
      i_convert            = i_convert
    CHANGING
      ct_dynpread          = lt_dynpread.

  READ TABLE lt_dynpread INDEX 1 ASSIGNING <ls_dynpread>.
  CHECK sy-subrc = 0.

  r_value = <ls_dynpread>-fieldvalue.

ENDMETHOD.


METHOD _dynp_value_update.

  DATA:
    ls_dynpread            TYPE dynpread,
    lt_dynpread            TYPE ish_t_dynpread.

  ls_dynpread-fieldname  = i_fieldname.
  ls_dynpread-fieldvalue = i_fieldvalue.
  INSERT ls_dynpread INTO TABLE lt_dynpread.

  _dynp_values_update( it_dynpread = lt_dynpread ).

ENDMETHOD.


METHOD _get_cursorfield_by_message.

  DATA:
    lr_model            TYPE REF TO if_ish_gui_structure_model,
    l_fieldname         TYPE ish_fieldname,
    l_dynpstruct_name   TYPE tabname.

* The dynpro structure description has to exist.
  CHECK gr_dynpstructdescr IS BOUND.

* Get our model. It has to be a structure model.
  lr_model = _get_structure_model( ).
  CHECK lr_model IS BOUND.

* The object of the message has to be our model.
  CHECK is_message-object = lr_model.

* Check the message's field.
  l_fieldname = is_message-field.
  CHECK lr_model->is_field_supported( i_fieldname = l_fieldname ) = abap_true.
  READ TABLE gr_dynpstructdescr->components
    WITH KEY name = l_fieldname
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

* Export.
  l_dynpstruct_name = gr_dynpstructdescr->get_relative_name( ).
  CONCATENATE l_dynpstruct_name
              l_fieldname
    INTO r_cursorfield
    SEPARATED BY '-'.

ENDMETHOD.


METHOD _get_default_cursorfield.

  LOOP AT SCREEN.
    CHECK screen-active = 1.
    IF screen-input = 1.
      r_default_cursorfield = screen-name.
      EXIT.
    ELSEIF r_default_cursorfield IS INITIAL.
      r_default_cursorfield = screen-name.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD _get_structure_model.

  TRY.
      rr_structure_model ?= _get_model( ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD _init_dynpro_view.

  DATA lr_typedescr                     TYPE REF TO cl_abap_typedescr.
  DATA lr_dynpstructdescr               TYPE REF TO cl_abap_structdescr.
  DATA lr_layout                        TYPE REF TO cl_ish_gui_dynpro_layout.
  DATA lr_structmdl                     TYPE REF TO if_ish_gui_structure_model.

  FIELD-SYMBOLS <ls_dynplay_vcode>      LIKE LINE OF gt_dynplay_vcode.

* Repid + dynnr have to be specified.
  IF i_repid IS INITIAL OR
     i_dynnr IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = '_INIT_DYNPRO_VIEW'
        i_mv3        = 'CL_ISH_GUI_DYNPRO_VIEW' ).
  ENDIF.

* Check the dynpstruct_name.
  IF i_dynpstruct_name IS NOT INITIAL.
    CALL METHOD cl_abap_typedescr=>describe_by_name
      EXPORTING
        p_name         = i_dynpstruct_name
      RECEIVING
        p_descr_ref    = lr_typedescr
      EXCEPTIONS
        type_not_found = 1
        OTHERS         = 2.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = '_INIT_DYNPRO_VIEW'
          i_mv3        = 'CL_ISH_GUI_DYNPRO_VIEW' ).
    ENDIF.
    TRY.
        lr_dynpstructdescr ?= lr_typedescr.
      CATCH cx_sy_move_cast_error.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '3'
            i_mv2        = '_INIT_DYNPRO_VIEW'
            i_mv3        = 'CL_ISH_GUI_DYNPRO_VIEW' ).
    ENDTRY.
  ENDIF.

* Handle the layout.
  IF it_dynplay_vcode IS NOT INITIAL.
    READ TABLE it_dynplay_vcode
      WITH TABLE KEY vcode = i_vcode
      ASSIGNING <ls_dynplay_vcode>.
    IF sy-subrc = 0.
      lr_layout = <ls_dynplay_vcode>-r_layout.
    ENDIF.
  ENDIF.
  IF lr_layout IS NOT BOUND.
    lr_layout = ir_layout.
  ENDIF.

* Further initialization by _init_view.
  _init_view(
      ir_controller   = ir_controller
      ir_parent_view  = ir_parent_view
      ir_layout       = lr_layout
      i_vcode         = i_vcode ).

* Initialize attributes.
  g_repid             = i_repid.
  g_dynnr             = i_dynnr.
  gr_dynpstructdescr  = lr_dynpstructdescr.
  gt_dynplay_vcode    = it_dynplay_vcode.
  CLEAR: g_cursorfield.

* Connect to dynpro.
  TRY.
      _connect_to_dynpro(
          i_dynnr_to  = i_dynnr_to ).
    CLEANUP.
      CLEAR g_repid.
      CLEAR g_dynnr.
      CLEAR gr_dynpstructdescr.
      CLEAR gt_dynplay_vcode.
  ENDTRY.

* Register the eventhandlers for the model.
  lr_structmdl = _get_structure_model( ).
  IF lr_structmdl IS BOUND.
    SET HANDLER on_model_changed FOR lr_structmdl ACTIVATION abap_true.
  ENDIF.

ENDMETHOD.


METHOD _modify_screen.

  _modify_screen_ish_scrm(
      i_repid = i_repid
      i_dynnr = i_dynnr ).

  _modify_screen_layout(
      i_repid = i_repid
      i_dynnr = i_dynnr ).

  _modify_screen_vcode(
      i_repid = i_repid
      i_dynnr = i_dynnr ).

  _modify_screen_xstructmdl(
      i_repid = i_repid
      i_dynnr = i_dynnr ).

ENDMETHOD.


METHOD _modify_screen_ish_scrm.

  DATA lr_application               TYPE REF TO if_ish_gui_application.
  DATA l_einri                      TYPE einri.
  DATA lr_get_einri                 TYPE REF TO if_ish_get_institution.

  lr_application = get_application( ).
  CHECK lr_application IS BOUND.
  CHECK lr_application->is_ish_scrm_supported( ir_view = me ) = abap_true.

  l_einri = i_einri.
  IF l_einri IS INITIAL.
    TRY.
        lr_get_einri ?= me.
      CATCH cx_sy_move_cast_error.
        TRY.
            lr_get_einri ?= _get_model( ).
          CATCH cx_sy_move_cast_error.
            TRY.
                lr_get_einri ?= lr_application.
              CATCH cx_sy_move_cast_error.
                CLEAR lr_get_einri.
            ENDTRY.
        ENDTRY.
    ENDTRY.
    IF lr_get_einri IS BOUND.
      l_einri = lr_get_einri->get_institution( ).
    ENDIF.
  ENDIF.

  CHECK l_einri IS NOT INITIAL.

  CALL FUNCTION 'ISH_MODIFY_SCREEN'
    EXPORTING
      dynnr = i_dynnr
      einri = l_einri
      fcode = 'AS '
      pname = i_repid
      vcode = g_vcode.

ENDMETHOD.


METHOD _modify_screen_layout.

  DATA lr_layout                    TYPE REF TO cl_ish_gui_dynpro_layout.

  IF ir_layout IS BOUND.
    lr_layout = ir_layout.
  ELSE.
    lr_layout = get_dynpro_layout( ).
  ENDIF.

  CHECK lr_layout IS BOUND.

  LOOP AT SCREEN.
    CASE lr_layout->get_fieldprop( i_fieldname = screen-name ).
      WHEN cl_ish_gui_dynpro_layout=>co_fieldprop_must.
        screen-active   = 1.
        screen-required = 1.
        screen-input    = 1.
        screen-output   = 1.
      WHEN cl_ish_gui_dynpro_layout=>co_fieldprop_display.
        screen-active   = 1.
        screen-required = 0.
        screen-input    = 0.
        screen-output   = 1.
      WHEN cl_ish_gui_dynpro_layout=>co_fieldprop_inactive.
        screen-active   = 0.
        screen-required = 0.
      WHEN cl_ish_gui_dynpro_layout=>co_fieldprop_can.
        screen-active   = 1.
        screen-input    = 1.
        screen-required = 0.
        screen-output   = 1.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.

ENDMETHOD.


METHOD _modify_screen_vcode.

  CASE g_vcode.
    WHEN co_vcode_display.
      LOOP AT SCREEN.
        CASE screen-group4.
          WHEN 'TUP'.
            screen-input = 0.
          WHEN 'TDI'.
            screen-input = 1.
          WHEN OTHERS.
            screen-input = 0.
        ENDCASE.
        MODIFY SCREEN.
      ENDLOOP.
  ENDCASE.

ENDMETHOD.


METHOD _modify_screen_xstructmdl.

  DATA lr_model                     TYPE REF TO if_ish_gui_xstructure_model.
  DATA l_dynpstruct_name            TYPE tabname.
  DATA l_fieldname                  TYPE ish_fieldname.

  CHECK g_vcode <> co_vcode_display.

  IF ir_model IS BOUND.
    lr_model = ir_model.
  ELSE.
    TRY.
        lr_model ?= _get_structure_model( ).
      CATCH cx_sy_move_cast_error.
        CLEAR lr_model.
    ENDTRY.
  ENDIF.

  CHECK lr_model IS BOUND.

  LOOP AT SCREEN.
    CHECK screen-active = 1.
    CHECK screen-input = 1.
    SPLIT screen-name
      AT '-'
      INTO l_dynpstruct_name l_fieldname.
    IF l_fieldname IS INITIAL.
      l_fieldname = screen-name.
    ENDIF.
    CHECK lr_model->is_field_supported( l_fieldname ) = abap_true.
    CHECK lr_model->is_field_changeable( l_fieldname ) = abap_false.
    screen-input = 0.
    MODIFY SCREEN.
  ENDLOOP.

ENDMETHOD.


METHOD _poh.

* To process the help request this method has to be redefined.

  r_processed = abap_false.

ENDMETHOD.


METHOD _pov.

* To process the value request this method has to be redefined.

  e_processed = abap_false.
  CLEAR: et_changed_field.

ENDMETHOD.


METHOD _propagate_dynpro_event.

  DATA:
    lr_controller  TYPE REF TO if_ish_gui_controller,
    lr_request     TYPE REF TO cl_ish_gui_dynpro_event.

* Get the controller.
  lr_controller = get_controller( ).

* No controller -> no processing.
  CHECK lr_controller IS BOUND.

* Create the request.
  lr_request = cl_ish_gui_dynpro_event=>create(
      ir_sender           = me
      i_processing_block  = i_processing_block
      i_ucomm             = i_ucomm ).

* Let the controller process the request.
  rr_response = lr_controller->process_request( ir_request = lr_request ).

ENDMETHOD.


METHOD _propagate_dynpro_help_event.

  DATA:
    lr_controller  TYPE REF TO if_ish_gui_controller,
    lr_request     TYPE REF TO cl_ish_gui_dynpro_help_event.

* Get the controller.
  lr_controller = get_controller( ).

* No controller -> no processing.
  CHECK lr_controller IS BOUND.

* Create the request.
  lr_request = cl_ish_gui_dynpro_help_event=>create_dynpro_help_event( ir_sender   = me
                                                                       i_fieldname = i_fieldname ).

* Let the controller process the request.
  rr_response = lr_controller->process_request( ir_request = lr_request ).

ENDMETHOD.


METHOD _propagate_dynpro_value_event.

  DATA:
    lr_controller  TYPE REF TO if_ish_gui_controller,
    lr_request     TYPE REF TO cl_ish_gui_dynpro_value_event.

* Get the controller.
  lr_controller = get_controller( ).

* No controller -> no processing.
  CHECK lr_controller IS BOUND.

* Create the request.
  lr_request = cl_ish_gui_dynpro_value_event=>create_dynpro_value_event( ir_sender   = me
                                                                         i_fieldname = i_fieldname ).

* Let the controller process the request.
  rr_response = lr_controller->process_request( ir_request = lr_request ).

ENDMETHOD.


METHOD _set_cursor_at_pbo.

  DATA:
    l_cursorfield             TYPE ish_fieldname,
    lr_application            TYPE REF TO if_ish_gui_application,
    ls_crspos_message         TYPE rn1message.

* Get the application.
  lr_application = get_application( ).
  CHECK lr_application IS BOUND.

* The crspos_message of the application has first priority.
* If there is a crspos_message, we have to set the cursor only if it belongs to us.
* If there is no crspos_message, we have to set the cursor only if we have the focus.
  ls_crspos_message = lr_application->get_crspos_message( ).
  IF ls_crspos_message IS NOT INITIAL.
    l_cursorfield = _get_cursorfield_by_message( is_message = ls_crspos_message ).
    CHECK l_cursorfield IS NOT INITIAL.
    lr_application->clear_crspos_message( ).
    lr_application->set_focussed_view( ir_view = me ).
  ELSE.
    CHECK lr_application->get_focussed_view( ) = me.
    l_cursorfield = g_cursorfield.
  ENDIF.

* We have to set the cursor ( = we have the focus or the crspos_message belongs to us ).

* If the cursorfield is empty we have to set the cursor to the default cursorfield.
  IF l_cursorfield IS INITIAL.
    l_cursorfield = _get_default_cursorfield( ).
  ENDIF.

* Further processing only on valid cursorfield.
  CHECK l_cursorfield IS NOT INITIAL.

* We have the focus.
  lr_application->set_focussed_view( ir_view = me ).

* Set the cursor.
  SET CURSOR FIELD l_cursorfield.

* Remember the cursorfield.
  g_cursorfield = l_cursorfield.

* Export.
  r_cursor_set = abap_true.

ENDMETHOD.


METHOD _set_vcode.

  FIELD-SYMBOLS <ls_dynplay_vcode>            LIKE LINE OF gt_dynplay_vcode.

* Call the super method.
  r_changed = super->_set_vcode( i_vcode = i_vcode ).
  CHECK r_changed = abap_true.

* Handle the layout.
  DO 1 TIMES.
    READ TABLE gt_dynplay_vcode
      WITH TABLE KEY vcode = i_vcode
      ASSIGNING <ls_dynplay_vcode>.
    CHECK sy-subrc = 0.
    gr_layout = <ls_dynplay_vcode>-r_layout.
  ENDDO.

ENDMETHOD.


METHOD _transport_dynpro_to_model.

  DATA lr_model                                 TYPE REF TO if_ish_gui_model.
  DATA l_fieldname                              TYPE ish_fieldname.
  DATA lr_dynpstruct_in                         TYPE REF TO data.
  DATA l_dynpstructname                         TYPE tabname.
  DATA lx_static                                TYPE REF TO cx_ish_static_handler.

  FIELD-SYMBOLS <ls_dynpstruct_pbo>             TYPE data.
  FIELD-SYMBOLS <ls_dynpstruct>                 TYPE data.
  FIELD-SYMBOLS <ls_component>                  TYPE abap_compdescr.
  FIELD-SYMBOLS <l_field>                       TYPE any.
  FIELD-SYMBOLS <l_field_pbo>                   TYPE any.
  FIELD-SYMBOLS <l_field_dynpstruct>            TYPE any.
  FIELD-SYMBOLS <ls_dynpstruct_in>              TYPE data.
  FIELD-SYMBOLS <ls_tmp_pov_changed_field>      TYPE dynpread.

* The dynprostructure has to be supplied.
  CHECK is_dynpstruct IS SUPPLIED.

* The dyynpro structure description has to exist.
  CHECK gr_dynpstructdescr IS BOUND.

* Check the given dynpro structure.
  CHECK gr_dynpstructdescr->applies_to_data( p_data = is_dynpstruct ) = abap_true.

* Assign the pbo dynpro structure.
  IF gr_dynpstruct_pbo IS BOUND.
    ASSIGN gr_dynpstruct_pbo->* TO <ls_dynpstruct_pbo>.
    IF gr_dynpstructdescr->applies_to_data( p_data = <ls_dynpstruct_pbo> ) = abap_false.
      CLEAR: gr_dynpstruct_pbo.
    ENDIF.
  ENDIF.

* Work on a temporary copy of the dynpro structure.
  CREATE DATA lr_dynpstruct_in TYPE HANDLE gr_dynpstructdescr.
  ASSIGN lr_dynpstruct_in->* TO <ls_dynpstruct_in>.
  <ls_dynpstruct_in> = is_dynpstruct.

* Handle temporary pov fields.
  DO 1 TIMES.
    IF i_repid IS INITIAL.
      CHECK g_tmp_pov_repid = i_repid.
    ELSE.
      CHECK g_tmp_pov_repid = g_repid.
    ENDIF.
    IF i_dynnr IS INITIAL.
      CHECK g_tmp_pov_dynnr = i_dynnr.
    ELSE.
      CHECK g_tmp_pov_dynnr = g_dynnr.
    ENDIF.
    LOOP AT gt_tmp_pov_changed_field ASSIGNING <ls_tmp_pov_changed_field>.
      SPLIT <ls_tmp_pov_changed_field>-fieldname
        AT '-'
        INTO l_dynpstructname l_fieldname.
      ASSIGN COMPONENT l_fieldname
        OF STRUCTURE <ls_dynpstruct_in>
        TO <l_field>.
      CHECK sy-subrc = 0.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = <ls_tmp_pov_changed_field>-fieldvalue
        CHANGING
          c_target = <l_field>.
    ENDLOOP.
  ENDDO.

* Get the model.
  lr_model = _get_model( ).
  CHECK lr_model IS BOUND.

* Process the dynpro fields.
  LOOP AT gr_dynpstructdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
*   Get the field content of the dynpro structure.
    ASSIGN COMPONENT l_fieldname
      OF STRUCTURE <ls_dynpstruct_in>
      TO <l_field>.
*   Process only changed fields.
    IF gr_dynpstruct_pbo IS BOUND.
      ASSIGN COMPONENT l_fieldname
        OF STRUCTURE <ls_dynpstruct_pbo>
        TO <l_field_pbo>.
      CHECK <l_field> <> <l_field_pbo>.
    ENDIF.
*   Set the field content of the structure model.
*   Errors are propagated and collected in gt_errorfield.
    TRY.
        __set_field_content(
            ir_model    = lr_model
            i_content   = <l_field>
            i_fieldname = l_fieldname ).
      CATCH cx_ish_static_handler INTO lx_static.
        IF gr_dynpstruct IS BOUND.
          ASSIGN gr_dynpstruct->* TO <ls_dynpstruct>.
          ASSIGN COMPONENT l_fieldname
            OF STRUCTURE <ls_dynpstruct>
            TO <l_field_dynpstruct>.
          <l_field_dynpstruct> = <l_field>.
        ENDIF.
        _set_errorfield(
            ir_model    = lr_model
            i_fieldname = l_fieldname
            ir_messages = lx_static->gr_errorhandler ).
        _propagate_exception( ir_exception = lx_static ).
        CONTINUE.
    ENDTRY.
  ENDLOOP.

ENDMETHOD.


METHOD _transport_model_to_dynpro.

  DATA lr_model                     TYPE REF TO if_ish_gui_model.
  DATA l_fieldname                  TYPE ish_fieldname.
  DATA lx_root                      TYPE REF TO cx_root.

  FIELD-SYMBOLS <ls_dynpstruct>     TYPE data.
  FIELD-SYMBOLS <ls_component>      TYPE abap_compdescr.
  FIELD-SYMBOLS <l_field>           TYPE any.

* The dynprostructure has to be supplied.
  CHECK cs_dynpstruct IS SUPPLIED.

* The dynpro structure description has to exist.
  CHECK gr_dynpstructdescr IS BOUND.

* Check the given dynpro structure.
  CHECK gr_dynpstructdescr->applies_to_data( p_data = cs_dynpstruct ) = abap_true.

* If we have already the actual dynpro structure we just set it.
* But use the actual dynpro structure only if it fits the dynpro structure description.
  IF gr_dynpstruct IS BOUND.
    ASSIGN gr_dynpstruct->* TO <ls_dynpstruct>.
    IF gr_dynpstructdescr->applies_to_data( p_data = <ls_dynpstruct> ) = abap_true.
      cs_dynpstruct = <ls_dynpstruct>.
      RETURN.
    ELSE.
      CLEAR: gr_dynpstruct.
    ENDIF.
  ENDIF.

* We do not already have the actual dynpro structure (= first pbo).
* So we have to create the actual dynpro structure, set it and register the eventhandlers for the model.

* Get the structure model.
  lr_model = _get_model( ).
  CHECK lr_model IS BOUND.

* Create the actual dynpro structure.
  CREATE DATA gr_dynpstruct TYPE HANDLE gr_dynpstructdescr.
  ASSIGN gr_dynpstruct->* TO <ls_dynpstruct>.

* Fill the actual dynpro structure.
  LOOP AT gr_dynpstructdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
*   Errorfields are not transported.
    CHECK _get_errorfield_messages(
              ir_model    = lr_model
              i_fieldname = l_fieldname ) IS NOT BOUND.
*   Assign the dynpro structure field.
    ASSIGN COMPONENT <ls_component>-name
      OF STRUCTURE <ls_dynpstruct>
      TO <l_field>.
*   Set the field content of the dynpro structure.
*   Any errors are propagated.
    TRY.
        CALL METHOD __get_field_content
          EXPORTING
            ir_model    = lr_model
            i_fieldname = l_fieldname
          CHANGING
            c_content   = <l_field>.
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( ir_exception = lx_root ).
        CONTINUE.
    ENDTRY.
  ENDLOOP.

* Set cs_dynpstruct.
  cs_dynpstruct = <ls_dynpstruct>.

ENDMETHOD.


METHOD __after_pai.

* Propagate to controller.
  _propagate_dynpro_event( i_processing_block = cl_ish_gui_dynpro_event=>co_procblock_after_pai ).

* Clear temporary pov data.
  CLEAR g_tmp_pov_repid.
  CLEAR g_tmp_pov_dynnr.
  CLEAR gt_tmp_pov_changed_field.

ENDMETHOD.


METHOD __after_pbo.

  DATA lt_child_view                TYPE ish_t_gui_viewid_hash.
  DATA lr_control_view              TYPE REF TO if_ish_gui_control_view.
  DATA lx_root                      TYPE REF TO cx_root.

  FIELD-SYMBOLS <ls_child_view>     TYPE rn1_gui_viewid_hash.

* Handle first display of the child control views.
  lt_child_view = get_child_views( i_with_subchildren = abap_false ).
  LOOP AT lt_child_view ASSIGNING <ls_child_view>.
    CHECK <ls_child_view>-r_view IS BOUND.
    TRY.
        lr_control_view ?= <ls_child_view>-r_view.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    TRY.
        IF lr_control_view->is_first_display_done( ) = abap_true.
          lr_control_view->refresh_display( i_with_child_views = abap_true ).
        ELSE.
          lr_control_view->first_display( i_with_child_views = abap_true ).
        ENDIF.
      CATCH cx_ish_static_handler INTO lx_root.
        _propagate_exception( lx_root ).
    ENDTRY.
  ENDLOOP.

* Propagate to controller.
  _propagate_dynpro_event( i_processing_block = cl_ish_gui_dynpro_event=>co_procblock_after_pbo ).

* Handle first_display.
  g_first_display_done = abap_true.
  g_first_display_mode = abap_false.

ENDMETHOD.


METHOD __before_call_subscreen.

  DATA:
    lr_subscreen_view  TYPE REF TO if_ish_gui_sdy_view.

* Initializations.
  e_subscreen_repid = 'SAPLN1SC'.
  e_subscreen_dynnr = '0001'.

* Get the subscreen view.
  TRY.
      lr_subscreen_view ?= get_child_view_by_name( i_view_name = i_subscreen_name ).
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.
  CHECK lr_subscreen_view IS BOUND.

* Return the subscreen view's repid + dynnr.
  e_subscreen_repid = lr_subscreen_view->get_repid( ).
  e_subscreen_dynnr = lr_subscreen_view->get_dynnr( ).

ENDMETHOD.


METHOD __before_pai.

* Propagate to controller.
  _propagate_dynpro_event(
      i_processing_block  = cl_ish_gui_dynpro_event=>co_procblock_before_pai
      i_ucomm             = i_ucomm ).

ENDMETHOD.


METHOD __before_pbo.

* Handle first_display.
  IF g_first_display_done = abap_false.
    g_first_display_mode = abap_true.
  ENDIF.

* Propagate to controller.
  _propagate_dynpro_event( i_processing_block = cl_ish_gui_dynpro_event=>co_procblock_before_pbo ).

ENDMETHOD.


METHOD __pai.

  DATA:
    lr_application            TYPE REF TO if_ish_gui_application,
    lx_root                   TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_dynpstruct>           TYPE any.

* Michael Manoch, 07.03.2008
* The actuality of gr_dynpstruct is handled by on_model_changed.
* Therefore we must not transport the whole is_dynpstruct here.
** Set the actual dynpro structure.
*  IF is_dynpstruct IS SUPPLIED   AND
*     gr_dynpstructdescr IS BOUND AND
*     gr_dynpstruct IS BOUND      AND
*     gr_dynpstructdescr->applies_to_data( p_data = is_dynpstruct ) = abap_true.
*    ASSIGN gr_dynpstruct->* TO <ls_dynpstruct>.
*    <ls_dynpstruct> = is_dynpstruct.
*  ENDIF.

* Transport dynpro to model.
  TRY.
      IF is_dynpstruct IS SUPPLIED.
        _transport_dynpro_to_model( i_repid       = i_repid
                                    i_dynnr       = i_dynnr
                                    is_dynpstruct = is_dynpstruct ).
      ELSE.
        _transport_dynpro_to_model( i_repid = i_repid
                                    i_dynnr = i_dynnr ).
      ENDIF.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

* If the cursor is in our dynpro we have to
*   - remind the cursorfield
*   - set the focus to self.
  GET CURSOR FIELD g_cursorfield.
  IF g_cursorfield IS NOT INITIAL.
    lr_application = get_application( ).
    IF lr_application IS BOUND.
      lr_application->set_focussed_view( ir_view = me ).
    ENDIF.
  ENDIF.

ENDMETHOD.


METHOD __pbo.

  DATA:
    lx_root                    TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_dynpstruct_pbo>        TYPE data.

* Transport model to dynpro.
  TRY.
      IF cs_dynpstruct IS SUPPLIED.
        CALL METHOD _transport_model_to_dynpro
          EXPORTING
            i_repid       = i_repid
            i_dynnr       = i_dynnr
          CHANGING
            cs_dynpstruct = cs_dynpstruct.
      ELSE.
        _transport_model_to_dynpro( i_repid = i_repid
                                    i_dynnr = i_dynnr ).
      ENDIF.
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

* Modify screen.
  TRY.
      _modify_screen( i_repid = i_repid
                      i_dynnr = i_dynnr ).
    CATCH cx_ish_static_handler INTO lx_root.
      _propagate_exception( ir_exception = lx_root ).
  ENDTRY.

* Remember a copy of the dynprostructure.
* This copy will be used at pai to transport only changed fields.
  IF cs_dynpstruct IS SUPPLIED.
    CREATE DATA gr_dynpstruct_pbo LIKE cs_dynpstruct.
    ASSIGN gr_dynpstruct_pbo->* TO <ls_dynpstruct_pbo>.
    <ls_dynpstruct_pbo> = cs_dynpstruct.
  ENDIF.

* Set the cursor.
  _set_cursor_at_pbo( is_dynpstruct = cs_dynpstruct ).

ENDMETHOD.


METHOD __poh.

  DATA:
    l_fieldname            TYPE ish_fieldname,
    lr_messages            TYPE REF TO cl_ishmed_errorhandling,
    lx_root                TYPE REF TO cx_root.

* Determine the fieldname.
  l_fieldname = i_fieldname.
  IF l_fieldname IS INITIAL.
    GET CURSOR FIELD l_fieldname.
  ENDIF.

* Propagate the help_event.
* If the help_event is processed (from a parent view / controller or application
* we must not run our own poh.
  CHECK _propagate_dynpro_help_event( i_fieldname = i_fieldname ) IS NOT BOUND.

* Process F1.
  TRY.

*     Process F1.
      _poh(
          i_repid     = i_repid
          i_dynnr     = i_dynnr
          i_fieldname = l_fieldname ).

    CATCH cx_ish_static_handler INTO lx_root.
*     On any errors display the messages.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
        EXPORTING
          i_exceptions    = lx_root
        CHANGING
          cr_errorhandler = lr_messages.
      CHECK lr_messages IS BOUND.
      lr_messages->display_messages( i_send_if_one = abap_true ).
      RETURN.

  ENDTRY.

ENDMETHOD.


METHOD __pov.

  DATA:
    l_fieldname            TYPE ish_fieldname,
    l_processed            TYPE abap_bool,
    lt_changed_field       TYPE ish_t_dynpread,
    lr_messages            TYPE REF TO cl_ishmed_errorhandling,
    lx_root                TYPE REF TO cx_root.

* POV is in process.
  g_pov_in_process = abap_true.

  DO 1 TIMES.

*   Determine the fieldname.
    l_fieldname = i_fieldname.
    IF l_fieldname IS INITIAL.
      GET CURSOR FIELD l_fieldname.
    ENDIF.

*   Propagate the value_event.
*   If the value_event is processed (from a parent view / controller or application
*   we must not run our own pov.
    CHECK _propagate_dynpro_value_event( i_fieldname = i_fieldname ) IS NOT BOUND.

*   Process F4.
    TRY.

*     Process F4.
        CALL METHOD _pov
          EXPORTING
            i_repid          = i_repid
            i_dynnr          = i_dynnr
            i_fieldname      = l_fieldname
          IMPORTING
            e_processed      = l_processed
            et_changed_field = lt_changed_field.

*       Further processing only if any fields have changed.
        CHECK l_processed = abap_true.
        CHECK lt_changed_field IS NOT INITIAL.

*       Complete pov.
        complete_pov(
            i_repid           = i_repid
            i_dynnr           = i_dynnr
            it_changed_field  = lt_changed_field ).

      CATCH cx_ish_static_handler INTO lx_root.
        g_pov_in_process = abap_false.
*       On any errors display the messages.
        CALL METHOD cl_ish_utl_base=>collect_messages_by_exception
          EXPORTING
            i_exceptions    = lx_root
          CHANGING
            cr_errorhandler = lr_messages.
        CHECK lr_messages IS BOUND.
        lr_messages->display_messages( i_send_if_one = abap_true ).
        RETURN.

      CLEANUP.
        g_pov_in_process = abap_false.

    ENDTRY.

  ENDDO.

* POV is no more in process.
  g_pov_in_process = abap_false.

ENDMETHOD.
ENDCLASS.
