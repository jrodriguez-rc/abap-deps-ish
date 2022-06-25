class CL_ISH_GRID_TOGGLEBUTTON definition
  public
  inheriting from CL_ISH_GRID_KEYBUTTON
  create protected .

*"* public components of class CL_ISH_GRID_TOGGLEBUTTON
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_GRID_TOGGLEBUTTON type ISH_OBJECT_TYPE value 4017. "#EC NOTEXT

  class-methods CREATE_TOGGLEBUTTON
    importing
      !IR_TOGGLEBUTTONDEF type ref to CL_ISH_GRID_TOGGLEBUTTONDEF
      !I_ENABLED type ISH_ON_OFF default ON
    returning
      value(RR_TOGGLEBUTTON) type ref to CL_ISH_GRID_TOGGLEBUTTON .

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods PROCESS_BUTTON_CLICK
    redefinition .
protected section.
*"* protected components of class CL_ISH_GRID_TOGGLEBUTTON
*"* do not include other source files here!!!

  methods GET_TOGGLEBUTTONDEF
    returning
      value(RR_TOGGLEBUTTONDEF) type ref to CL_ISH_GRID_TOGGLEBUTTONDEF .
private section.
*"* private components of class CL_ISH_GRID_TOGGLEBUTTON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_TOGGLEBUTTON IMPLEMENTATION.


METHOD create_togglebutton .

  CHECK NOT ir_togglebuttondef     IS INITIAL.

  CREATE OBJECT rr_togglebutton.

  CALL METHOD rr_togglebutton->complete_construction
    EXPORTING
      ir_buttondef = ir_togglebuttondef
      i_enabled    = i_enabled.

ENDMETHOD.


METHOD get_togglebuttondef .

  CLEAR rr_togglebuttondef.

  CHECK NOT gr_buttondef IS INITIAL.

  rr_togglebuttondef ?= gr_buttondef.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_togglebutton.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_grid_togglebutton.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD process_button_click.

  DATA: lr_def        TYPE REF TO cl_ish_grid_togglebuttondef,
        ls_keybutton  TYPE rn1_grid_keybutton,
        l_key_value   TYPE nfvvalue,
        ls_modi       TYPE lvc_s_modi.

  FIELD-SYMBOLS: <ls_outtab> TYPE ANY,
                 <l_key>     TYPE ANY,
                 <l_button>  TYPE ANY.

* Initializations.
  e_handled = on.
  e_rc      = 0.
  CLEAR et_modi.

* Initial checking.
  CHECK NOT i_row_idx                   IS INITIAL.
  CHECK NOT ct_outtab                   IS INITIAL.
  lr_def = get_togglebuttondef( ).
  CHECK NOT lr_def                      IS INITIAL.
  CHECK NOT lr_def->gr_scr_alv_grid     IS INITIAL.
  CHECK NOT lr_def->g_fieldname_key     IS INITIAL.
  CHECK NOT lr_def->g_fieldname_button  IS INITIAL.

* Get the corresponding outtab entry.
  READ TABLE ct_outtab
    ASSIGNING <ls_outtab>
    INDEX i_row_idx.
  CHECK sy-subrc = 0.

* Assign the actual key.
  ASSIGN COMPONENT lr_def->g_fieldname_key
    OF STRUCTURE <ls_outtab>
    TO <l_key>.
  CHECK sy-subrc = 0.

* Assign the actual button.
  ASSIGN COMPONENT lr_def->g_fieldname_button
    OF STRUCTURE <ls_outtab>
    TO <l_button>.
  CHECK sy-subrc = 0.

* Get the next keybutton.
  l_key_value = <l_key>.
  ls_keybutton = lr_def->get_next_keybutton( l_key_value ).

* Further processing only if we have a next button.
  CHECK NOT ls_keybutton IS INITIAL.

* Set the key and button fields of the outtab.
  <l_key>    = ls_keybutton-key_value.
  <l_button> = ls_keybutton-icon.

* Add entries for the key and button field to et_modi.
  CLEAR ls_modi.
  ls_modi-row_id    = i_row_idx.
  ls_modi-fieldname = lr_def->g_fieldname_key.
  APPEND ls_modi TO et_modi.
  CLEAR ls_modi.
  ls_modi-row_id    = i_row_idx.
  ls_modi-fieldname = lr_def->g_fieldname_button.
  APPEND ls_modi TO et_modi.

ENDMETHOD.
ENDCLASS.
