class CL_ISH_GRID_KEYBUTTON definition
  public
  inheriting from CL_ISH_GRID_BUTTON
  create protected .

public section.
*"* public components of class CL_ISH_GRID_KEYBUTTON
*"* do not include other source files here!!!

  constants CO_OTYPE_GRID_KEYBUTTON type ISH_OBJECT_TYPE value 4015. "#EC NOTEXT

  class-methods CREATE_KEYBUTTON
    importing
      !IR_KEYBUTTONDEF type ref to CL_ISH_GRID_KEYBUTTONDEF
      !I_ENABLED type ISH_ON_OFF default ON
    returning
      value(RR_KEYBUTTON) type ref to CL_ISH_GRID_KEYBUTTON .

  methods FINALIZE_OUTTAB_ENTRY
    redefinition .
  methods FINALIZE_ROW
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods MODIFY_CELLSTYLE
    redefinition .
protected section.
*"* protected components of class CL_ISH_GRID_KEYBUTTON
*"* do not include other source files here!!!

  methods GET_KEYBUTTONDEF
    returning
      value(RR_KEYBUTTONDEF) type ref to CL_ISH_GRID_KEYBUTTONDEF .
private section.
*"* private components of class CL_ISH_GRID_KEYBUTTON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_KEYBUTTON IMPLEMENTATION.


METHOD create_keybutton .

  CHECK NOT ir_keybuttondef     IS INITIAL.

  CREATE OBJECT rr_keybutton.

  CALL METHOD rr_keybutton->complete_construction
    EXPORTING
      ir_buttondef = ir_keybuttondef
      i_enabled    = i_enabled.

ENDMETHOD.


METHOD finalize_outtab_entry.

  DATA: lr_keybuttondef     TYPE REF TO cl_ish_grid_keybuttondef,
        ls_keybutton        TYPE rn1_grid_keybutton,
        l_key_value         TYPE nfvvalue,
        l_style             TYPE lvc_style.

  FIELD-SYMBOLS: <l_key>     TYPE ANY,
                 <l_button>  TYPE ANY.

* Initial checking.
  lr_keybuttondef = get_keybuttondef( ).
  CHECK lr_keybuttondef                         IS BOUND.
  CHECK lr_keybuttondef->gr_scr_alv_grid        IS BOUND.
  CHECK NOT lr_keybuttondef->g_fieldname_key    IS INITIAL.
  CHECK NOT lr_keybuttondef->g_fieldname_button IS INITIAL.
  CHECK NOT cs_outtab                           IS INITIAL.

* Assign the key field of the outtab entry.
  ASSIGN COMPONENT lr_keybuttondef->g_fieldname_key
    OF STRUCTURE cs_outtab
    TO <l_key>.
  CHECK sy-subrc = 0.

* Assign the button field of the outtab entry.
  ASSIGN COMPONENT lr_keybuttondef->g_fieldname_button
    OF STRUCTURE cs_outtab
    TO <l_button>.
  CHECK sy-subrc = 0.

* Get the corresponding keybutton.
  l_key_value = <l_key>.
  ls_keybutton =
    lr_keybuttondef->get_keybutton_by_key_value( l_key_value ).

* Set the button field of the outtab entry.
  IF ls_keybutton IS INITIAL.
    <l_button> = lr_keybuttondef->g_icon.
  ELSE.
    <l_button> = ls_keybutton-icon.
  ENDIF.

* En-/Disable the button.
  IF is_enabled( ) = on AND
     ( lr_keybuttondef->g_handle_vcode = off OR
       lr_keybuttondef->gr_scr_alv_grid->get_vcode_for_button(
         ir_button = me
         is_outtab = cs_outtab ) <> co_vcode_display ).
    l_style = cl_gui_alv_grid=>mc_style_button.
  ELSE.
*    CLEAR l_style.
    l_style = cl_gui_alv_grid=>mc_style_disabled.
  ENDIF.
  CALL METHOD set_cellstyle
    EXPORTING
      i_fieldname = lr_keybuttondef->g_fieldname_button
      i_style     = l_style
    CHANGING
      cs_outtab   = cs_outtab.

ENDMETHOD.


METHOD finalize_row.

* This method transports the key and button fields of
* the given outtab entry to the given row fieldval.

  DATA: lr_keybuttondef  TYPE REF TO cl_ish_grid_keybuttondef.

  FIELD-SYMBOLS: <l_key>  TYPE ANY.

* First call the super method to finalize the button column.
  CALL METHOD super->finalize_row
    EXPORTING
      ir_row_fieldval = ir_row_fieldval
      is_outtab       = is_outtab.

* Initial checking.
  lr_keybuttondef = get_keybuttondef( ).
  CHECK NOT lr_keybuttondef                   IS INITIAL.
  CHECK NOT lr_keybuttondef->g_fieldname_key  IS INITIAL.
  CHECK NOT ir_row_fieldval                   IS INITIAL.
  CHECK NOT is_outtab                         IS INITIAL.

* Transport the key field.
  DO 1 TIMES.
*   Transport only if specified.
    CHECK lr_keybuttondef->g_trans_key_fv = on.
*   Get the key from the outtab entry.
    ASSIGN COMPONENT lr_keybuttondef->g_fieldname_key
      OF STRUCTURE is_outtab
      TO <l_key>.
    CHECK sy-subrc = 0.

*   Transport the key to the corresponding column fieldval.
    ir_row_fieldval->set_value_single(
                       i_fieldname = lr_keybuttondef->g_fieldname_key
                       i_value     = <l_key> ).
  ENDDO.

ENDMETHOD.


METHOD get_keybuttondef.

  CLEAR rr_keybuttondef.

  CHECK NOT gr_buttondef IS INITIAL.

  rr_keybuttondef ?= gr_buttondef.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_keybutton.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_grid_keybutton.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD modify_cellstyle.

  DATA: lr_keybuttondef   TYPE REF TO cl_ish_grid_keybuttondef.

* Initial checking.
  CHECK NOT gr_buttondef IS INITIAL.
  CHECK NOT i_fieldname  IS INITIAL.
  CHECK NOT cs_outtab    IS INITIAL.
  CHECK gr_buttondef->is_field_supported( i_fieldname ) = on.

* First set g_enabled.
  lr_keybuttondef ?= gr_buttondef.
  IF i_fieldname = lr_keybuttondef->g_fieldname_key.
    g_enabled = i_enable.
  ENDIF.
  IF i_fieldname = lr_keybuttondef->g_fieldname_button.
    g_enabled = i_enable.
  ENDIF.

* call super
  CALL METHOD super->modify_cellstyle
    EXPORTING
      i_fieldname  = i_fieldname
      i_enable     = i_enable
      i_disable_f4 = i_disable_f4
    IMPORTING
      e_modified   = e_modified
    CHANGING
      cs_outtab    = cs_outtab.

ENDMETHOD.
ENDCLASS.
