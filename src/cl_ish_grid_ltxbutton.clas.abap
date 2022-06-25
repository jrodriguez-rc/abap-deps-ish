class CL_ISH_GRID_LTXBUTTON definition
  public
  inheriting from CL_ISH_GRID_BUTTON
  create protected .

*"* public components of class CL_ISH_GRID_LTXBUTTON
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_GRID_LTXBUTTON type ISH_OBJECT_TYPE value 4019. "#EC NOTEXT

  class-methods CREATE_LTXBUTTON
    importing
      !IR_LTXBUTTONDEF type ref to CL_ISH_GRID_LTXBUTTONDEF
      !I_ENABLED type ISH_ON_OFF default ON
    returning
      value(RR_LTXBUTTON) type ref to CL_ISH_GRID_LTXBUTTON .

  methods FINALIZE_OUTTAB_ENTRY
    redefinition .
  methods FINALIZE_ROW
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods PROCESS_BUTTON_CLICK
    redefinition .
protected section.
*"* protected components of class CL_ISH_GRID_LTXBUTTON
*"* do not include other source files here!!!

  methods GET_LTXBUTTONDEF
    returning
      value(RR_LTXBUTTONDEF) type ref to CL_ISH_GRID_LTXBUTTONDEF .
private section.
*"* private components of class CL_ISH_GRID_LTXBUTTON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_LTXBUTTON IMPLEMENTATION.


METHOD create_ltxbutton .

  CHECK NOT ir_ltxbuttondef     IS INITIAL.

  CREATE OBJECT rr_ltxbutton.

  CALL METHOD rr_ltxbutton->complete_construction
    EXPORTING
      ir_buttondef = ir_ltxbuttondef
      i_enabled    = i_enabled.

ENDMETHOD.


METHOD finalize_outtab_entry .

  DATA: lr_def              TYPE REF TO cl_ish_grid_ltxbuttondef,
        l_vcode             TYPE tndym-vcode,
        l_icon              TYPE n1icon,
        l_style             TYPE lvc_style.

  FIELD-SYMBOLS: <l_ltx>        TYPE any,
                 <l_button>     TYPE any,
                 <l_firstline>  TYPE any,
                 <l_ltxobj>     TYPE any.

* Initial checking.
  lr_def = get_ltxbuttondef( ).
  CHECK NOT lr_def                     IS INITIAL.
  CHECK NOT lr_def->g_fieldname_button IS INITIAL.
  CHECK NOT lr_def->g_fieldname_ltx    IS INITIAL.
  CHECK NOT lr_def->g_fieldname_ltxobj IS INITIAL.
  CHECK NOT lr_def->gr_scr_alv_grid    IS INITIAL.
  CHECK NOT cs_outtab                  IS INITIAL.

* For processing we need the ltx, button and ltxobj fields.
  ASSIGN COMPONENT lr_def->g_fieldname_ltx
    OF STRUCTURE cs_outtab
    TO <l_ltx>.
  CHECK sy-subrc = 0.
  ASSIGN COMPONENT lr_def->g_fieldname_button
    OF STRUCTURE cs_outtab
    TO <l_button>.
  CHECK sy-subrc = 0.
  ASSIGN COMPONENT lr_def->g_fieldname_ltxobj
    OF STRUCTURE cs_outtab
    TO <l_ltxobj>.
  CHECK sy-subrc = 0.

* Get the vcode for the actual outtab entry.
  IF lr_def->g_handle_vcode = off.
    l_vcode = co_vcode_update.
  ELSE.
    l_vcode = lr_def->gr_scr_alv_grid->get_vcode_for_button(
                ir_button = me
                is_outtab = cs_outtab ).
  ENDIF.

* En-/Disable the button.
  IF "is_enabled( ) = off   OR      Michael Manoch, 24.07.2009
     <l_ltxobj> IS INITIAL OR
     ( l_vcode = co_vcode_display AND
       <l_ltx> = off ).
    CLEAR l_style.
  ELSE.
    l_style = cl_gui_alv_grid=>mc_style_button.
  ENDIF.

* Set the button field of the outtab entry.
  IF <l_ltx> = on.
    IF l_vcode = co_vcode_display.
      l_icon = lr_def->g_icon_display.
    ELSE.
      l_icon = lr_def->g_icon_update.
    ENDIF.
  ELSE.
    IF l_vcode = co_vcode_display.
      l_style = cl_gui_alv_grid=>mc_style_disabled.
      CLEAR: l_icon.
    ELSE.
      l_icon = lr_def->g_icon_insert.
    ENDIF.
  ENDIF.
  <l_button> = l_icon.

  CALL METHOD set_cellstyle
    EXPORTING
      i_fieldname = lr_def->g_fieldname_button
      i_style     = l_style
    CHANGING
      cs_outtab   = cs_outtab.

* Handle the firstline field.
  DO 1 TIMES.
    CHECK NOT lr_def->g_fieldname_firstline IS INITIAL.
*   Assign the firstline field of the outtab entry.
    ASSIGN COMPONENT lr_def->g_fieldname_firstline
      OF STRUCTURE cs_outtab
      TO <l_firstline>.
    CHECK sy-subrc = 0.
*   En-/Disable the firstline.
    IF is_enabled( ) = off OR
       <l_ltx>       = on  OR
       l_vcode = co_vcode_display.
      l_style = cl_gui_alv_grid=>mc_style_disabled.
    ELSE.
      CLEAR l_style.
    ENDIF.
    CALL METHOD set_cellstyle
      EXPORTING
        i_fieldname = lr_def->g_fieldname_firstline
        i_style     = l_style
      CHANGING
        cs_outtab   = cs_outtab.
  ENDDO.

ENDMETHOD.


METHOD finalize_row .

* This method transports the fields of the given outtab entry
* to the given row fieldval.

  DATA: lr_def  TYPE REF TO cl_ish_grid_ltxbuttondef.

  FIELD-SYMBOLS: <l_ltx>        TYPE ANY,
                 <l_firstline>  TYPE ANY.

* First call the super method to finalize the button column.
  CALL METHOD super->finalize_row
    EXPORTING
      ir_row_fieldval = ir_row_fieldval
      is_outtab       = is_outtab.

* Initial checking.
  lr_def = get_ltxbuttondef( ).
  CHECK NOT lr_def                   IS INITIAL.
  CHECK NOT ir_row_fieldval          IS INITIAL.
  CHECK NOT is_outtab                IS INITIAL.

* Transport the ltx field.
  DO 1 TIMES.
    CHECK NOT lr_def->g_fieldname_ltx  IS INITIAL.
*   Transport only if specified.
    CHECK lr_def->g_trans_ltx_fv = on.
*   Get the ltx from the outtab entry.
    ASSIGN COMPONENT lr_def->g_fieldname_ltx
      OF STRUCTURE is_outtab
      TO <l_ltx>.
    CHECK sy-subrc = 0.
*   Transport the ltx to the corresponding column fieldval.
    ir_row_fieldval->set_value_single(
                       i_fieldname = lr_def->g_fieldname_ltx
                       i_value     = <l_ltx> ).
  ENDDO.

* Transport the firstline field.
  DO 1 TIMES.
    CHECK NOT lr_def->g_fieldname_firstline IS INITIAL.
*   Transport only if specified.
    CHECK lr_def->g_trans_firstline_fv = on.
*   Get the firstline from the outtab entry.
    ASSIGN COMPONENT lr_def->g_fieldname_firstline
      OF STRUCTURE is_outtab
      TO <l_firstline>.
    CHECK sy-subrc = 0.
*   Transport the firstline to the corresponding column fieldval.
    ir_row_fieldval->set_value_single(
                       i_fieldname = lr_def->g_fieldname_firstline
                       i_value     = <l_firstline> ).
  ENDDO.

ENDMETHOD.


METHOD get_ltxbuttondef .

  CLEAR rr_ltxbuttondef.

  CHECK NOT gr_buttondef IS INITIAL.

  rr_ltxbuttondef ?= gr_buttondef.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_ltxbutton.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_grid_ltxbutton.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD process_button_click.

  DATA: lr_def               TYPE REF TO cl_ish_grid_ltxbuttondef,
        l_act_ltx            TYPE ish_on_off,
        l_act_firstline(50)  TYPE c,
        l_act_button         TYPE n1_icon,
        l_vcode              TYPE tndym-vcode,
        lr_textmodule        TYPE REF TO if_ish_use_textmodule,
        l_textline(50)       TYPE c,
        l_textsign           TYPE ri_lgtxt,
        ls_itcer             TYPE itcer,
        ls_modi              TYPE lvc_s_modi,
        l_ltxid              TYPE ish_textmodule_id.

  FIELD-SYMBOLS: <ls_outtab>      TYPE any,
                 <l_ltx>          TYPE any,
                 <l_button>       TYPE any,
                 <l_ltxobj>       TYPE any,
                 <l_firstline>    TYPE any,
                 <l_ltxid>        TYPE any.

* Initializations.
  e_handled = on.
  e_rc      = 0.
  CLEAR et_modi.

* Initial checking.
  CHECK NOT i_row_idx                     IS INITIAL.
  CHECK NOT ct_outtab                     IS INITIAL.
  lr_def = get_ltxbuttondef( ).
  CHECK NOT lr_def                        IS INITIAL.
  CHECK NOT lr_def->g_fieldname_button    IS INITIAL.
  CHECK NOT lr_def->g_fieldname_ltx       IS INITIAL.
  CHECK NOT lr_def->g_fieldname_ltxobj    IS INITIAL.
  CHECK NOT lr_def->g_fieldname_firstline IS INITIAL.
  CHECK NOT lr_def->gr_scr_alv_grid       IS INITIAL.
  CHECK NOT lr_def->g_ltxid               IS INITIAL OR
        NOT lr_def->g_fieldname_ltxid     IS INITIAL.

* Get the corresponding outtab entry.
  READ TABLE ct_outtab
    ASSIGNING <ls_outtab>
    INDEX i_row_idx.
  CHECK sy-subrc = 0.

* For processing we need the ltx, button, ltxobj and firstline fields.
  ASSIGN COMPONENT lr_def->g_fieldname_ltx
    OF STRUCTURE <ls_outtab>
    TO <l_ltx>.
  CHECK sy-subrc = 0.
  ASSIGN COMPONENT lr_def->g_fieldname_button
    OF STRUCTURE <ls_outtab>
    TO <l_button>.
  CHECK sy-subrc = 0.
  ASSIGN COMPONENT lr_def->g_fieldname_ltxobj
    OF STRUCTURE <ls_outtab>
    TO <l_ltxobj>.
  CHECK sy-subrc = 0.
  ASSIGN COMPONENT lr_def->g_fieldname_firstline
    OF STRUCTURE <ls_outtab>
    TO <l_firstline>.
  CHECK sy-subrc = 0.
  IF lr_def->g_fieldname_ltxid IS NOT INITIAL.
    ASSIGN COMPONENT lr_def->g_fieldname_ltxid
      OF STRUCTURE <ls_outtab>
      TO <l_ltxid>.
    CHECK sy-subrc = 0.
    l_ltxid = <l_ltxid>.
  ELSE.
    l_ltxid = lr_def->g_ltxid.
  ENDIF.

* Remember the actual ltx, firstline and button.
  l_act_ltx        = <l_ltx>.
  l_act_firstline  = <l_firstline>.
  l_act_button     = <l_button>.

* Get the actual vcode.
  l_vcode =  lr_def->gr_scr_alv_grid->get_vcode_for_button(
               ir_button = me
               is_outtab = <ls_outtab> ).

* Edit the ltx.
  lr_textmodule ?= <l_ltxobj>.
  CHECK NOT lr_textmodule IS INITIAL.
  CALL METHOD lr_textmodule->edit_text
    EXPORTING
      i_text_id      = l_ltxid
      i_vcode        = l_vcode
    IMPORTING
      e_result       = ls_itcer
      e_rc           = e_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

* No further processing on cancellation of the ltx editation.
  CHECK NOT ls_itcer-function IS INITIAL.

* Get the new text data.
  IF ls_itcer-function = 'D'.
    l_textsign = off.
    CLEAR l_textline.
  ELSE.
    CALL METHOD lr_textmodule->get_text_header
      EXPORTING
        i_text_id      = l_ltxid
      IMPORTING
        e_textline     = l_textline
        e_textsign     = l_textsign
        e_rc           = e_rc
      CHANGING
        c_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Actualize the ltx and firstline fields.
  <l_ltx>       = l_textsign.
  <l_firstline> = l_textline.

* Now finalize the outtab entry.
  CALL METHOD finalize_outtab_entry
    CHANGING
      cs_outtab = <ls_outtab>.

* Now handle et_modi.
  IF l_act_ltx <> <l_ltx>.
    CLEAR ls_modi.
    ls_modi-row_id    = i_row_idx.
    ls_modi-fieldname = lr_def->g_fieldname_ltx.
    APPEND ls_modi TO et_modi.
  ENDIF.
  IF l_act_button <> <l_button>.
    CLEAR ls_modi.
    ls_modi-row_id    = i_row_idx.
    ls_modi-fieldname = lr_def->g_fieldname_button.
    APPEND ls_modi TO et_modi.
  ENDIF.
  IF l_act_firstline <> <l_firstline>.
    CLEAR ls_modi.
    ls_modi-row_id    = i_row_idx.
    ls_modi-fieldname = lr_def->g_fieldname_firstline.
    APPEND ls_modi TO et_modi.
  ENDIF.

ENDMETHOD.
ENDCLASS.
