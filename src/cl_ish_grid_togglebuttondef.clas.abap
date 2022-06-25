class CL_ISH_GRID_TOGGLEBUTTONDEF definition
  public
  inheriting from CL_ISH_GRID_KEYBUTTONDEF
  create protected .

*"* public components of class CL_ISH_GRID_TOGGLEBUTTONDEF
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_GRID_TOGGLEBUTTONDEF type ISH_OBJECT_TYPE value 4016. "#EC NOTEXT

  class-methods CREATE_TOGGLEBUTTONDEF
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
      value(RR_TOGGLEBUTTONDEF) type ref to CL_ISH_GRID_TOGGLEBUTTONDEF .
  methods GET_NEXT_KEYBUTTON
    importing
      !I_KEY_VALUE type NFVVALUE
    returning
      value(RS_KEYBUTTON) type RN1_GRID_KEYBUTTON .

  methods ADD_KEYBUTTON
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_GRID_TOGGLEBUTTONDEF
*"* do not include other source files here!!!

  methods CREATE_BUTTON
    redefinition .
private section.
*"* private components of class CL_ISH_GRID_TOGGLEBUTTONDEF
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_TOGGLEBUTTONDEF IMPLEMENTATION.


METHOD add_keybutton.

  DATA: ls_keybutton  TYPE rn1_grid_keybutton.

* Do not allow duplicate key entries.
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

* Do not allow duplicate icon entries.
  READ TABLE gt_keybutton
    WITH KEY icon = ls_keybutton-icon
    TRANSPORTING NO FIELDS.
  CHECK NOT sy-subrc = 0.

* Add the keybutton.
  APPEND ls_keybutton TO gt_keybutton.

ENDMETHOD.


METHOD create_button.

  CLEAR rr_button.

  rr_button = cl_ish_grid_togglebutton=>create_togglebutton(
                ir_togglebuttondef = me
                i_enabled          = g_enabled ).

ENDMETHOD.


METHOD create_togglebuttondef .

  CLEAR rr_togglebuttondef.

  CHECK NOT ir_scr_alv_grid       IS INITIAL.
  CHECK NOT i_fieldname_button    IS INITIAL.
  CHECK NOT i_fieldname_buttonobj IS INITIAL.
  CHECK NOT i_fieldname_key       IS INITIAL.

  CREATE OBJECT rr_togglebuttondef.

  CALL METHOD rr_togglebuttondef->complete_construction_key
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


METHOD get_next_keybutton.

  DATA: l_idx  TYPE i.

  CLEAR rs_keybutton.

* Get the index of the actual key.
  READ TABLE gt_keybutton
    WITH KEY key_value = i_key_value
    TRANSPORTING NO FIELDS.
  IF sy-subrc = 0.
    l_idx = sy-tabix.
  ELSE.
    l_idx = 0.
  ENDIF.

* Try to get the next keybutton.
  l_idx = l_idx + 1.
  READ TABLE gt_keybutton
    INTO rs_keybutton
    INDEX l_idx.
  CHECK NOT sy-subrc = 0.

* The actual key is the last one, so return the first keybutton.
  READ TABLE gt_keybutton
    INTO rs_keybutton
    INDEX 1.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_togglebuttondef.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_grid_togglebuttondef.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.
ENDCLASS.
