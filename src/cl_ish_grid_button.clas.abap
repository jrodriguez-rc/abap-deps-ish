class CL_ISH_GRID_BUTTON definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_GRID_BUTTON
*"* do not include other source files here!!!

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

  constants CO_OTYPE_GRID_BUTTON type ISH_OBJECT_TYPE value 4013. "#EC NOTEXT

  class-methods CREATE_BUTTON
    importing
      !IR_BUTTONDEF type ref to CL_ISH_GRID_BUTTONDEF
      !I_ENABLED type ISH_ON_OFF default ON
    returning
      value(RR_BUTTON) type ref to CL_ISH_GRID_BUTTON .
  methods DESTROY .
  methods FINALIZE_OUTTAB_ENTRY
    changing
      !CS_OUTTAB type ANY .
  methods FINALIZE_ROW
    importing
      !IR_ROW_FIELDVAL type ref to CL_ISH_FIELD_VALUES
      !IS_OUTTAB type ANY .
  methods IS_ENABLED
    returning
      value(R_ENABLED) type ISH_ON_OFF .
  methods MODIFY_CELLSTYLE
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_ENABLE type ISH_ON_OFF
      !I_DISABLE_F4 type ISH_ON_OFF default OFF
    exporting
      !E_MODIFIED type ISH_ON_OFF
    changing
      !CS_OUTTAB type ANY .
  methods PROCESS_BUTTON_CLICK
    importing
      !I_ROW_IDX type INT4
    exporting
      !E_HANDLED type ISH_ON_OFF
      !ET_MODI type LVC_T_MODI
      !E_RC type ISH_METHOD_RC
    changing
      !CT_OUTTAB type STANDARD TABLE
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_BUTTONDEF
    returning
      value(RR_BUTTONDEF) type ref to CL_ISH_GRID_BUTTONDEF .
protected section.
*"* protected components of class CL_ISH_GRID_BUTTON
*"* do not include other source files here!!!

  data G_ENABLED type ISH_ON_OFF .
  data GR_BUTTONDEF type ref to CL_ISH_GRID_BUTTONDEF .

  methods COMPLETE_CONSTRUCTION
    importing
      !IR_BUTTONDEF type ref to CL_ISH_GRID_BUTTONDEF
      !I_ENABLED type ISH_ON_OFF default ON .
  methods SET_CELLSTYLE
    importing
      !I_FIELDNAME type ISH_FIELDNAME
      !I_STYLE type LVC_STYLE
    changing
      !CS_OUTTAB type ANY .
private section.
*"* private components of class CL_ISH_GRID_BUTTON
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_BUTTON IMPLEMENTATION.


METHOD complete_construction .

  gr_buttondef = ir_buttondef.
  g_enabled    = i_enabled.

ENDMETHOD.


METHOD create_button.

  CHECK NOT ir_buttondef     IS INITIAL.

  CREATE OBJECT rr_button.

  CALL METHOD rr_button->complete_construction
    EXPORTING
      ir_buttondef = ir_buttondef
      i_enabled    = i_enabled.

ENDMETHOD.


METHOD destroy.

  CLEAR: g_enabled,
         gr_buttondef.

ENDMETHOD.


METHOD finalize_outtab_entry.

  DATA: l_style             TYPE lvc_style.

  FIELD-SYMBOLS: <l_button>  TYPE ANY.

* Initial checking.
  CHECK gr_buttondef                   IS BOUND.
  CHECK gr_buttondef->gr_scr_alv_grid  IS BOUND.
  CHECK NOT cs_outtab                  IS INITIAL.

* Assign the button field of the outtab entry.
  ASSIGN COMPONENT gr_buttondef->g_fieldname_button
    OF STRUCTURE cs_outtab
    TO <l_button>.
  CHECK sy-subrc = 0.

* Set the button field of the outtab entry.
  <l_button> = gr_buttondef->g_icon.

* En-/Disable the button.
  IF is_enabled( ) = on AND
     ( gr_buttondef->g_handle_vcode = off OR
       gr_buttondef->gr_scr_alv_grid->get_vcode_for_button(
         ir_button = me
         is_outtab = cs_outtab ) <> co_vcode_display ).
    l_style = cl_gui_alv_grid=>mc_style_button.
  ELSE.
    CLEAR l_style.
  ENDIF.
  CALL METHOD set_cellstyle
    EXPORTING
      i_fieldname = gr_buttondef->g_fieldname_button
      i_style     = l_style
    CHANGING
      cs_outtab   = cs_outtab.

ENDMETHOD.


METHOD finalize_row.

* This method finalizes the given row.

  FIELD-SYMBOLS: <l_button>  TYPE ANY.

* Initial checking.
  CHECK NOT gr_buttondef                      IS INITIAL.
  CHECK NOT ir_row_fieldval                   IS INITIAL.
  CHECK NOT is_outtab                         IS INITIAL.

* Transport the button from the outtab to the row fieldval.
  DO 1 TIMES.
    CHECK NOT gr_buttondef->g_fieldname_button IS INITIAL.
*   Transport only if specified.
    CHECK gr_buttondef->g_trans_button_fv = on.
*   Get the button from the outtab entry.
    ASSIGN COMPONENT gr_buttondef->g_fieldname_button
      OF STRUCTURE is_outtab
      TO <l_button>.
    CHECK sy-subrc = 0.
*   Transport the button to the corresponding column fieldval.
    ir_row_fieldval->set_value_single(
                       i_fieldname = gr_buttondef->g_fieldname_button
                       i_value     = <l_button> ).
  ENDDO.

* Transport the buttonobj from the outtab to the row fieldval.
  DO 1 TIMES.
    CHECK NOT gr_buttondef->g_fieldname_buttonobj IS INITIAL.
*   Transport only if specified.
    CHECK gr_buttondef->g_trans_buttonobj_fv = on.
*   Get the button from the outtab entry.
    ASSIGN COMPONENT gr_buttondef->g_fieldname_buttonobj
      OF STRUCTURE is_outtab
      TO <l_button>.
    CHECK sy-subrc = 0.
*   Transport the button to the corresponding column fieldval.
    ir_row_fieldval->set_value_identify(
                       i_fieldname = gr_buttondef->g_fieldname_buttonobj
                       ir_identify = me ).
  ENDDO.

ENDMETHOD.


METHOD get_buttondef.
  rr_buttondef = gr_buttondef.
ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_button.

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

  IF i_object_type = co_otype_grid_button.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD is_enabled.

* Initializations.
  r_enabled = off.

* No buttondef? -> not enabled.
  CHECK gr_buttondef IS BOUND.

* Handle the buttondef.
  CHECK gr_buttondef->is_enabled( ) = on.

* Handle g_enabled.
  r_enabled = g_enabled.

ENDMETHOD.


METHOD modify_cellstyle.

  DATA: l_style             TYPE lvc_style.

  FIELD-SYMBOLS: <l_button>  TYPE ANY.

* Initializations.
  e_modified = off.

* Initial checking.
  CHECK NOT gr_buttondef IS INITIAL.
  CHECK NOT i_fieldname  IS INITIAL.
  CHECK NOT cs_outtab    IS INITIAL.
  CHECK gr_buttondef->is_field_supported( i_fieldname ) = on.

* First set g_enabled.
  IF i_fieldname = gr_buttondef->g_fieldname_buttonobj.
    g_enabled = i_enable.
  ENDIF.

* Check if enabling is allowed.
  IF i_enable = on AND
     is_enabled( ) = off.
    e_modified = on.
    EXIT.
  ENDIF.

* Calculate the style.
  IF i_fieldname = gr_buttondef->g_fieldname_button.
    IF i_enable = on.
      l_style = cl_gui_alv_grid=>mc_style_button.
    ELSE.
      CLEAR l_style.
    ENDIF.
  ELSE.
    IF i_enable = on.
      CLEAR l_style.
    ELSE.
      l_style = cl_gui_alv_grid=>mc_style_disabled.
    ENDIF.
  ENDIF.

* En-/Disable the cell.
  CALL METHOD set_cellstyle
    EXPORTING
      i_fieldname = i_fieldname
      i_style     = l_style
    CHANGING
      cs_outtab   = cs_outtab.

ENDMETHOD.


METHOD process_button_click.

* Nothing to be done.
  e_handled = off.
  e_rc      = 0.
  CLEAR et_modi.

ENDMETHOD.


METHOD set_cellstyle .

  DATA: ls_cellstyle  TYPE lvc_s_styl.

  FIELD-SYMBOLS: <lr_scr_alv_grid>   TYPE REF TO cl_ish_scr_alv_grid,
                 <lt_cellstyle>      TYPE lvc_t_styl,
                 <ls_cellstyle>      TYPE lvc_s_styl.

* Initial checking
  CHECK NOT gr_buttondef                              IS INITIAL.
  CHECK NOT gr_buttondef->gr_scr_alv_grid             IS INITIAL.
  ASSIGN gr_buttondef->gr_scr_alv_grid TO <lr_scr_alv_grid>.
  CHECK sy-subrc = 0.
  CHECK NOT <lr_scr_alv_grid>->g_fieldname_cellstyle  IS INITIAL.

* Assign the cellstyle table.
  ASSIGN COMPONENT <lr_scr_alv_grid>->g_fieldname_cellstyle
    OF STRUCTURE cs_outtab
    TO <lt_cellstyle>.
  CHECK sy-subrc = 0.

* Get/Create the corresponding cellstyle entry.
  READ TABLE <lt_cellstyle>
    ASSIGNING <ls_cellstyle>
    WITH KEY fieldname = i_fieldname.
  IF sy-subrc <> 0.
*   If i_style is initial we have to delete the corresponding
*   cellstyle entry.
*   Therefore do not create an entry.
    CHECK NOT i_style IS INITIAL.
    CLEAR ls_cellstyle.
    ls_cellstyle-fieldname = i_fieldname.
    INSERT ls_cellstyle INTO TABLE <lt_cellstyle>.
    READ TABLE <lt_cellstyle>
      ASSIGNING <ls_cellstyle>
      WITH KEY fieldname = i_fieldname.
    CHECK sy-subrc = 0.
  ENDIF.

* Set the style.
* If i_style is initial we have to delete the corresponding
* cellstyle entry.
  IF i_style IS INITIAL.
    DELETE <lt_cellstyle> INDEX sy-tabix.
  ELSE.
    <ls_cellstyle>-style = i_style.
  ENDIF.

ENDMETHOD.
ENDCLASS.
