class CL_ISH_GRID_BUTTONHANDLER definition
  public
  create protected .

*"* public components of class CL_ISH_GRID_BUTTONHANDLER
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_FV_CONSTANTS .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases CO_FVTYPE_FV
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_FV .
  aliases CO_FVTYPE_IDENTIFY
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_IDENTIFY .
  aliases CO_FVTYPE_SCREEN
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_SCREEN .
  aliases CO_FVTYPE_SINGLE
    for IF_ISH_FV_CONSTANTS~CO_FVTYPE_SINGLE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_GRID_BUTTONHANDLER type ISH_OBJECT_TYPE value 4011. "#EC NOTEXT

  class-methods CREATE_BUTTONHANDLER
    importing
      !IR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID
    returning
      value(RR_BUTTONHANDLER) type ref to CL_ISH_GRID_BUTTONHANDLER .
  methods ADD_BUTTONDEF
    importing
      !IR_BUTTONDEF type ref to CL_ISH_GRID_BUTTONDEF .
  methods CREATE_EMPTY_COLUMN
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(RS_COL_FIELDVAL) type RNFIELD_VALUE .
  methods DESTROY .
  methods GET_CURSORFIELD
    importing
      !I_FIELD type BAPI_FLD
    returning
      value(R_FIELD) type BAPI_FLD .
  methods GET_BUTTON
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !IS_OUTTAB type ANY
    returning
      value(RR_BUTTON) type ref to CL_ISH_GRID_BUTTON .
  methods IS_FIELD_SUPPORTED
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_SUPPORTED) type ISH_ON_OFF .
  methods FINALIZE_OUTTAB_ENTRY
    changing
      !CS_OUTTAB type ANY .
  methods FINALIZE_ROW
    importing
      !IR_ROW_FIELDVAL type ref to CL_ISH_FIELD_VALUES
      !IS_OUTTAB type ANY .
  methods MODIFY_CELLSTYLE
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_ENABLE type ISH_ON_OFF
      !I_DISABLE_F4 type ISH_ON_OFF default OFF
    exporting
      !E_MODIFIED type ISH_ON_OFF
    changing
      !CS_OUTTAB type ANY .
  methods MODIFY_FIELDCAT_PROPERTIES
    changing
      !CT_FIELDCAT type LVC_T_FCAT .
  methods PROCESS_BUTTON_CLICK
    importing
      !I_ROW_IDX type INT4
      !I_FIELDNAME_BUTTON type ISH_FIELDNAME
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CT_OUTTAB type STANDARD TABLE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REMOVE_BUTTONDEF
    importing
      !IR_BUTTONDEF type ref to CL_ISH_GRID_BUTTONDEF .
protected section.
*"* protected components of class CL_ISH_GRID_BUTTONHANDLER
*"* do not include other source files here!!!

  data GR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID .
  data GT_BUTTONDEF type ISH_T_GRID_BUTTONDEF .

  methods COMPLETE_CONSTRUCTION
    importing
      !IR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID .
private section.
*"* private components of class CL_ISH_GRID_BUTTONHANDLER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_BUTTONHANDLER IMPLEMENTATION.


METHOD add_buttondef.

  CHECK NOT ir_buttondef IS INITIAL.

  READ TABLE gt_buttondef
    FROM ir_buttondef
    TRANSPORTING NO FIELDS.
  CHECK NOT sy-subrc = 0.

  APPEND ir_buttondef TO gt_buttondef.

ENDMETHOD.


METHOD complete_construction.

  gr_scr_alv_grid = ir_scr_alv_grid.

ENDMETHOD.


METHOD create_buttonhandler.

  CHECK NOT ir_scr_alv_grid IS INITIAL.

  CREATE OBJECT rr_buttonhandler.

  CALL METHOD rr_buttonhandler->complete_construction
    EXPORTING
      ir_scr_alv_grid = ir_scr_alv_grid.

ENDMETHOD.


METHOD create_empty_column.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

  CLEAR rs_col_fieldval.

  CHECK NOT i_fieldname IS INITIAL.

  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK NOT lr_buttondef IS INITIAL.
    CHECK lr_buttondef->is_field_supported( i_fieldname ) = on.
    rs_col_fieldval = lr_buttondef->create_empty_column( i_fieldname ).
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD destroy.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK NOT lr_buttondef IS INITIAL.
    CALL METHOD lr_buttondef->destroy.
  ENDLOOP.

  CLEAR: gr_scr_alv_grid,
         gt_buttondef.

ENDMETHOD.


METHOD finalize_outtab_entry.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

  CHECK NOT cs_outtab IS INITIAL.

  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK NOT lr_buttondef IS INITIAL.
    CALL METHOD lr_buttondef->finalize_outtab_entry
      CHANGING
        cs_outtab = cs_outtab.
  ENDLOOP.

ENDMETHOD.


METHOD finalize_row.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

  CHECK NOT is_outtab IS INITIAL.

  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK NOT lr_buttondef IS INITIAL.
    CALL METHOD lr_buttondef->finalize_row
      EXPORTING
        ir_row_fieldval = ir_row_fieldval
        is_outtab       = is_outtab.
  ENDLOOP.

ENDMETHOD.


METHOD get_button.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

* Initializations.
  CLEAR rr_button.

* Initial checking.
  CHECK NOT i_fieldname IS INITIAL.
  CHECK NOT is_outtab   IS INITIAL.

* Get the button object from the buttondef.
  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK NOT lr_buttondef IS INITIAL.
    CHECK lr_buttondef->is_field_supported( i_fieldname ) = on.
    rr_button = lr_buttondef->get_button( is_outtab  ).
    IF rr_button IS BOUND.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_cursorfield.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

* Initializations.
  CLEAR r_field.

* Initial checking.
  CHECK NOT i_field IS INITIAL.

* Get the real cursorfield from the buttondefs.
  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK lr_buttondef IS BOUND.
    r_field = lr_buttondef->get_cursorfield( i_field ).
    IF NOT r_field IS INITIAL.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_buttonhandler.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type TYPE i.

  r_is_a = off.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF i_object_type = l_object_type.
    r_is_a = on.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_grid_buttonhandler.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD is_field_supported.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

  r_supported = off.

  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK NOT lr_buttondef IS INITIAL.
    r_supported = lr_buttondef->is_field_supported( i_fieldname ).
    IF r_supported = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD modify_cellstyle.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

  e_modified = off.

  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK NOT lr_buttondef IS INITIAL.
    CALL METHOD lr_buttondef->modify_cellstyle
      EXPORTING
        i_fieldname  = i_fieldname
        i_enable     = i_enable
        i_disable_f4 = i_disable_f4
      IMPORTING
        e_modified   = e_modified
      CHANGING
        cs_outtab    = cs_outtab.
    IF e_modified = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD modify_fieldcat_properties.

  DATA: lr_buttondef  TYPE REF TO cl_ish_grid_buttondef.

  CHECK NOT ct_fieldcat IS INITIAL.

  LOOP AT gt_buttondef INTO lr_buttondef.
    CHECK NOT lr_buttondef IS INITIAL.
    CALL METHOD lr_buttondef->modify_fieldcat_properties
      CHANGING
        ct_fieldcat = ct_fieldcat.
  ENDLOOP.

ENDMETHOD.


METHOD process_button_click.

  DATA: lr_tmp_buttondef  TYPE REF TO cl_ish_grid_buttondef,
        lr_buttondef      TYPE REF TO cl_ish_grid_buttondef.

  FIELD-SYMBOLS: <lt_outtab>  TYPE table,
                 <ls_outtab>  TYPE ANY,
                 <lr_button>  TYPE REF TO cl_ish_grid_button.

* Initializations.
  e_rc      = 0.
  e_handled = off.
  CLEAR et_modi.

* Initial checking.
  CHECK NOT i_row_idx          IS INITIAL.
  CHECK NOT i_fieldname_button IS INITIAL.
  CHECK NOT ct_outtab          IS INITIAL.

* Get the corresponding buttondef object.
  CLEAR: lr_buttondef.
  LOOP AT gt_buttondef INTO lr_tmp_buttondef.
    CHECK NOT lr_tmp_buttondef IS INITIAL.
    CHECK lr_tmp_buttondef->g_fieldname_button = i_fieldname_button.
    lr_buttondef = lr_tmp_buttondef.
    EXIT.
  ENDLOOP.
  CHECK NOT lr_buttondef IS INITIAL.

* Get the corresponding outtab entry.
  READ TABLE ct_outtab
    ASSIGNING <ls_outtab>
    INDEX i_row_idx.
  CHECK sy-subrc = 0.

* Get the corresponding button object.
  CHECK NOT lr_buttondef->g_fieldname_buttonobj IS INITIAL.
  ASSIGN COMPONENT lr_buttondef->g_fieldname_buttonobj
    OF STRUCTURE <ls_outtab>
    TO <lr_button>.
  CHECK sy-subrc = 0.
  CHECK <lr_button> IS BOUND.

* Let the button object process the button_click.
  CALL METHOD <lr_button>->process_button_click
    EXPORTING
      i_row_idx       = i_row_idx
    IMPORTING
      e_handled       = e_handled
      et_modi         = et_modi
      e_rc            = e_rc
    CHANGING
      ct_outtab       = ct_outtab
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD remove_buttondef.

  CHECK NOT ir_buttondef IS INITIAL.

  DELETE TABLE gt_buttondef FROM ir_buttondef.

ENDMETHOD.
ENDCLASS.
