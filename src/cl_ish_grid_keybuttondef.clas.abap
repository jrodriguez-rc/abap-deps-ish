class CL_ISH_GRID_KEYBUTTONDEF definition
  public
  inheriting from CL_ISH_GRID_BUTTONDEF
  create protected .

*"* public components of class CL_ISH_GRID_KEYBUTTONDEF
*"* do not include other source files here!!!
public section.

  data G_FIELDNAME_KEY type ISH_FIELDNAME read-only .
  data G_TRANS_KEY_FV type ISH_ON_OFF read-only .
  data GT_KEYBUTTON type ISH_T_GRID_KEYBUTTON .
  constants CO_OTYPE_GRID_KEYBUTTONDEF type ISH_OBJECT_TYPE value 4014. "#EC NOTEXT

  class-methods CREATE_KEYBUTTONDEF
    importing
      !IR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID
      !I_FIELDNAME_BUTTON type ISH_FIELDNAME
      !I_FIELDNAME_BUTTONOBJ type ISH_FIELDNAME
      !I_ICON type N1_ICON optional
      !I_TEXT type STRING optional
      !I_INFO type STRING optional
      !I_OUTPUTLEN type I default 2
      !I_ENABLED type ISH_ON_OFF default ON
      !I_HANDLE_VCODE type ISH_ON_OFF default ON
      !I_TRANS_BUTTON_FV type ISH_ON_OFF default OFF
      !I_FIELDNAME_KEY type ISH_FIELDNAME
      !I_TRANS_KEY_FV type ISH_ON_OFF default ON
    returning
      value(RR_KEYBUTTONDEF) type ref to CL_ISH_GRID_KEYBUTTONDEF .
  methods ADD_KEYBUTTON
    importing
      !I_KEY_VALUE type NFVVALUE
      !I_ICON type N1_ICON optional
      !I_TEXT type STRING optional
      !I_INFO type STRING optional .
  methods GET_KEYBUTTON_BY_ICON
    importing
      !I_ICON type N1ICON
    returning
      value(RS_KEYBUTTON) type RN1_GRID_KEYBUTTON .
  methods GET_KEYBUTTON_BY_INDEX
    importing
      !I_INDEX type I
    returning
      value(RS_KEYBUTTON) type RN1_GRID_KEYBUTTON .
  methods GET_KEYBUTTON_BY_KEY_VALUE
    importing
      !I_KEY_VALUE type NFVVALUE
    returning
      value(RS_KEYBUTTON) type RN1_GRID_KEYBUTTON .
  methods GET_T_KEYBUTTON
    returning
      value(RT_KEYBUTTON) type ISH_T_GRID_KEYBUTTON .
  methods REMOVE_KEYBUTTON
    importing
      !I_KEY_VALUE type NFVVALUE .

  methods CREATE_EMPTY_COLUMN
    redefinition .
  methods DESTROY
    redefinition .
  methods GET_CURSORFIELD
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IS_FIELD_SUPPORTED
    redefinition .
  methods MODIFY_FIELDCAT_PROPERTIES
    redefinition .
protected section.
*"* protected components of class CL_ISH_GRID_KEYBUTTONDEF
*"* do not include other source files here!!!

  methods COMPLETE_CONSTRUCTION_KEY
    importing
      !IR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID
      !I_FIELDNAME_BUTTON type ISH_FIELDNAME
      !I_FIELDNAME_BUTTONOBJ type ISH_FIELDNAME
      !I_ICON type N1_ICON optional
      !I_TEXT type STRING optional
      !I_INFO type STRING optional
      !I_OUTPUTLEN type I default 2
      !I_ENABLED type ISH_ON_OFF default ON
      !I_HANDLE_VCODE type ISH_ON_OFF default ON
      !I_TRANS_BUTTON_FV type ISH_ON_OFF default OFF
      !I_FIELDNAME_KEY type ISH_FIELDNAME
      !I_TRANS_KEY_FV type ISH_ON_OFF default ON .

  methods CREATE_BUTTON
    redefinition .
private section.
*"* private components of class CL_ISH_GRID_KEYBUTTONDEF
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_KEYBUTTONDEF IMPLEMENTATION.


METHOD add_keybutton.

  DATA: ls_keybutton  TYPE rn1_grid_keybutton.

* Do not allow duplicate entries.
  READ TABLE gt_keybutton
    WITH KEY key_value = i_key_value
    TRANSPORTING NO FIELDS.
  CHECK NOT sy-subrc = 0.

* Build ls_keybutton.
  CLEAR ls_keybutton.
  ls_keybutton-key_value = i_key_value.
  ls_keybutton-icon      = build_icon(
                             i_icon = i_icon
                             i_text = i_text
                             i_info = i_info ).

* Add the keybutton.
  APPEND ls_keybutton TO gt_keybutton.

ENDMETHOD.


METHOD complete_construction_key .

* First complete_construction.
  CALL METHOD complete_construction
    EXPORTING
      ir_scr_alv_grid       = ir_scr_alv_grid
      i_fieldname_button    = i_fieldname_button
      i_fieldname_buttonobj = i_fieldname_buttonobj
      i_icon                = i_icon
      i_text                = i_text
      i_info                = i_info
      i_outputlen           = i_outputlen
      i_enabled             = i_enabled
      i_handle_vcode        = i_handle_vcode
      i_trans_button_fv     = i_trans_button_fv.

* Now handle own attributes.
  g_fieldname_key = i_fieldname_key.
  g_trans_key_fv  = i_trans_key_fv.

ENDMETHOD.


METHOD create_button.

  CLEAR rr_button.

  rr_button = cl_ish_grid_keybutton=>create_keybutton(
                ir_keybuttondef = me
                i_enabled       = g_enabled ).

ENDMETHOD.


METHOD create_empty_column.

* First call super method.
  rs_col_fieldval = super->create_empty_column( i_fieldname ).
  CHECK rs_col_fieldval IS INITIAL.

* Now do own processing.
  CASE i_fieldname.
    WHEN g_fieldname_key.
      CHECK g_trans_key_fv = on.
      rs_col_fieldval-fieldname = i_fieldname.
      rs_col_fieldval-type      = co_fvtype_single.
  ENDCASE.

ENDMETHOD.


METHOD create_keybuttondef .

  CLEAR rr_keybuttondef.

  CHECK NOT ir_scr_alv_grid       IS INITIAL.
  CHECK NOT i_fieldname_button    IS INITIAL.
  CHECK NOT i_fieldname_buttonobj IS INITIAL.
  CHECK NOT i_fieldname_key       IS INITIAL.

  CREATE OBJECT rr_keybuttondef.

  CALL METHOD rr_keybuttondef->complete_construction_key
    EXPORTING
      ir_scr_alv_grid       = ir_scr_alv_grid
      i_fieldname_button    = i_fieldname_button
      i_fieldname_buttonobj = i_fieldname_buttonobj
      i_icon                = i_icon
      i_text                = i_text
      i_info                = i_info
      i_outputlen           = i_outputlen
      i_enabled             = i_enabled
      i_handle_vcode        = i_handle_vcode
      i_trans_button_fv     = i_trans_button_fv
      i_fieldname_key       = i_fieldname_key
      i_trans_key_fv        = i_trans_key_fv.

ENDMETHOD.


METHOD destroy.

* First call the super method.
  CALL METHOD super->destroy.

* Now destroy own attributes.
  CLEAR: gt_keybutton,
         g_fieldname_key,
         g_trans_key_fv.

ENDMETHOD.


METHOD get_cursorfield.

* First call the super method.
  r_field = super->get_cursorfield( i_field ).
  CHECK r_field IS INITIAL.

* Now do own processing.
  IF i_field = g_fieldname_key.
    r_field = g_fieldname_button.
  ENDIF.

ENDMETHOD.


METHOD get_keybutton_by_icon.

  CLEAR rs_keybutton.

  READ TABLE gt_keybutton
    INTO rs_keybutton
    WITH KEY icon = i_icon.

ENDMETHOD.


METHOD get_keybutton_by_index.

  CLEAR rs_keybutton.

  READ TABLE gt_keybutton
    INTO rs_keybutton
    INDEX i_index.

ENDMETHOD.


METHOD get_keybutton_by_key_value.

  CLEAR rs_keybutton.

  READ TABLE gt_keybutton
    INTO rs_keybutton
    WITH KEY key_value = i_key_value.

ENDMETHOD.


METHOD get_t_keybutton.

  rt_keybutton = gt_keybutton.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_keybuttondef.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_grid_keybuttondef.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD is_field_supported.

* First call the super method.
  r_supported = super->is_field_supported( i_fieldname ).
  CHECK r_supported = off.

* Now do own processing.
  IF i_fieldname = g_fieldname_key.
    r_supported = on.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD modify_fieldcat_properties.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat.

* First call the super method.
  CALL METHOD super->modify_fieldcat_properties
    CHANGING
      ct_fieldcat = ct_fieldcat.

* Initial checking.
  CHECK NOT ct_fieldcat IS INITIAL.

* The key field is a tech field.
  DO 1 TIMES.
    READ TABLE ct_fieldcat
      ASSIGNING <ls_fieldcat>
      WITH KEY fieldname = g_fieldname_key.
    CHECK sy-subrc = 0.
    <ls_fieldcat>-tech = on.
  ENDDO.

ENDMETHOD.


METHOD remove_keybutton.

  DELETE gt_keybutton
    WHERE key_value = i_key_value.

ENDMETHOD.
ENDCLASS.
