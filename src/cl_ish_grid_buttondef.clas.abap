class CL_ISH_GRID_BUTTONDEF definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_GRID_BUTTONDEF
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

  data G_FIELDNAME_BUTTON type ISH_FIELDNAME read-only .
  data G_FIELDNAME_BUTTONOBJ type ISH_FIELDNAME read-only .
  data G_ENABLED type ISH_ON_OFF read-only .
  data G_HANDLE_VCODE type ISH_ON_OFF read-only .
  data G_ICON type N1ICON read-only .
  data G_OUTPUTLEN type I read-only .
  data G_TRANS_BUTTON_FV type ISH_ON_OFF read-only .
  data G_TRANS_BUTTONOBJ_FV type ISH_ON_OFF read-only .
  data GR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID read-only .
  constants CO_OTYPE_GRID_BUTTONDEF type ISH_OBJECT_TYPE value 4012. "#EC NOTEXT

  class-methods BUILD_ICON
    importing
      !I_ICON type N1_ICON optional
      !I_TEXT type STRING optional
      !I_INFO type STRING optional
    preferred parameter I_ICON
    returning
      value(R_ICON) type N1ICON .
  class-methods CREATE_BUTTONDEF
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
      !I_TRANS_BUTTON_FV type ISH_ON_OFF default ON
      !I_TRANS_BUTTONOBJ_FV type ISH_ON_OFF default OFF
    returning
      value(RR_BUTTONDEF) type ref to CL_ISH_GRID_BUTTONDEF .
  methods CREATE_EMPTY_COLUMN
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(RS_COL_FIELDVAL) type RNFIELD_VALUE .
  methods DESTROY .
  methods FINALIZE_OUTTAB_ENTRY
    changing
      !CS_OUTTAB type ANY .
  methods FINALIZE_ROW
    importing
      !IR_ROW_FIELDVAL type ref to CL_ISH_FIELD_VALUES
      !IS_OUTTAB type ANY .
  methods GET_BUTTON
    importing
      !IS_OUTTAB type ANY
    returning
      value(RR_BUTTON) type ref to CL_ISH_GRID_BUTTON .
  methods GET_CURSORFIELD
    importing
      !I_FIELD type BAPI_FLD
    returning
      value(R_FIELD) type BAPI_FLD .
  methods IS_ENABLED
    returning
      value(R_ENABLED) type ISH_ON_OFF .
  methods IS_FIELD_SUPPORTED
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_SUPPORTED) type ISH_ON_OFF .
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
protected section.
*"* protected components of class CL_ISH_GRID_BUTTONDEF
*"* do not include other source files here!!!

  methods COMPLETE_CONSTRUCTION
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
      !I_TRANS_BUTTON_FV type ISH_ON_OFF default ON
      !I_TRANS_BUTTONOBJ_FV type ISH_ON_OFF default OFF .
  methods CREATE_BUTTON
    returning
      value(RR_BUTTON) type ref to CL_ISH_GRID_BUTTON .
private section.
*"* private components of class CL_ISH_GRID_BUTTONDEF
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_BUTTONDEF IMPLEMENTATION.


METHOD build_icon.

  CLEAR r_icon.

* If we have an icon: use ICON_CREATE.
  IF NOT i_icon IS INITIAL AND
     NOT i_icon = icon_space.
    CALL FUNCTION 'ICON_CREATE'
      EXPORTING
        name   = i_icon
        text   = i_text
        info   = i_info
      IMPORTING
        RESULT = r_icon.
    EXIT.
  ENDIF.

* We do not have an icon: use only text + info.
  IF NOT i_info IS INITIAL.
    CONCATENATE '@\Q'
                i_info
                '@'
                space
           INTO r_icon.
  ENDIF.
  CONCATENATE r_icon
              i_text
         INTO r_icon.

ENDMETHOD.


METHOD complete_construction.

  gr_scr_alv_grid       = ir_scr_alv_grid.
  g_fieldname_button    = i_fieldname_button.
  g_fieldname_buttonobj = i_fieldname_buttonobj.
  g_icon                = build_icon(
                            i_icon = i_icon
                            i_text = i_text
                            i_info = i_info ).
  g_outputlen           = i_outputlen.
  g_enabled             = i_enabled.
  g_handle_vcode        = i_handle_vcode.
  g_trans_button_fv     = i_trans_button_fv.
  g_trans_buttonobj_fv  = i_trans_buttonobj_fv.

ENDMETHOD.


METHOD create_button.

  rr_button = cl_ish_grid_button=>create_button(
                ir_buttondef      = me
                i_enabled         = g_enabled ).

ENDMETHOD.


METHOD create_buttondef.

  CHECK NOT ir_scr_alv_grid       IS INITIAL.
  CHECK NOT i_fieldname_button    IS INITIAL.
  CHECK NOT i_fieldname_buttonobj IS INITIAL.

  CREATE OBJECT rr_buttondef.

  CALL METHOD rr_buttondef->complete_construction
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
      i_trans_buttonobj_fv  = i_trans_buttonobj_fv.

ENDMETHOD.


METHOD create_empty_column.

  CLEAR rs_col_fieldval.

  CASE i_fieldname.
    WHEN g_fieldname_button.
      CHECK g_trans_button_fv = on.
      rs_col_fieldval-fieldname = i_fieldname.
      rs_col_fieldval-type      = co_fvtype_single.
    WHEN g_fieldname_buttonobj.
      CHECK g_trans_buttonobj_fv = on.
      rs_col_fieldval-fieldname = i_fieldname.
      rs_col_fieldval-type      = co_fvtype_identify.
  ENDCASE.

ENDMETHOD.


METHOD destroy.

  CLEAR: g_fieldname_button,
         g_fieldname_buttonobj,
         g_enabled,
         g_handle_vcode,
         g_icon,
         g_outputlen.

ENDMETHOD.


METHOD finalize_outtab_entry.

  DATA: lr_button  TYPE REF TO cl_ish_grid_button.

  FIELD-SYMBOLS: <l_buttonobj>  TYPE ANY.

* Initial checking.
  CHECK NOT cs_outtab IS INITIAL.

* Get the button object.
  lr_button = get_button( cs_outtab ).

* If we do not have a button object yet create one
* and set it in the outtab.
  IF lr_button IS INITIAL.
    CHECK NOT g_fieldname_buttonobj IS INITIAL.
    CHECK NOT cs_outtab             IS INITIAL.
    ASSIGN COMPONENT g_fieldname_buttonobj
      OF STRUCTURE cs_outtab
      TO <l_buttonobj>.
    CHECK sy-subrc = 0.
    lr_button = create_button( ).
    <l_buttonobj> = lr_button.
  ENDIF.

  CHECK lr_button IS BOUND.

* Let the button object do the work.
  CALL METHOD lr_button->finalize_outtab_entry
    CHANGING
      cs_outtab = cs_outtab.

ENDMETHOD.


METHOD finalize_row.

  DATA: lr_button  TYPE REF TO cl_ish_grid_button.

* Get the button object.
  lr_button = get_button( is_outtab ).
  CHECK NOT lr_button IS INITIAL.

* Let the button object do the work.
  CALL METHOD lr_button->finalize_row
    EXPORTING
      ir_row_fieldval = ir_row_fieldval
      is_outtab       = is_outtab.

ENDMETHOD.


METHOD get_button .

  FIELD-SYMBOLS: <l_buttonobj>  TYPE ANY.

  CLEAR rr_button.

* Initial checking.
  CHECK NOT g_fieldname_buttonobj IS INITIAL.
  CHECK NOT is_outtab             IS INITIAL.

* Assign the button object.
  ASSIGN COMPONENT g_fieldname_buttonobj
    OF STRUCTURE is_outtab
    TO <l_buttonobj>.
  CHECK sy-subrc = 0.

* Export.
  rr_button = <l_buttonobj>.

ENDMETHOD.


METHOD get_cursorfield.

* Initializations.
  CLEAR r_field.

* Initial checking.
  CHECK NOT i_field IS INITIAL.

* Process.
  CASE i_field.
    WHEN g_fieldname_button.
      r_field = i_field.
    WHEN g_fieldname_buttonobj.
      r_field = g_fieldname_button.
  ENDCASE.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_buttondef.

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

  IF i_object_type = co_otype_grid_buttondef.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD is_enabled.

* Initializations.
  r_enabled = off.

* No grid screen? -> not enabled.
  CHECK gr_scr_alv_grid IS BOUND.

* If g_enabled=off we are not enabled.
  r_enabled = g_enabled.
  CHECK r_enabled = on.

* Handle the vcode.
  IF g_handle_vcode = on AND
     gr_scr_alv_grid->get_vcode( ) = co_vcode_display.
    r_enabled = off.
  ENDIF.

ENDMETHOD.


METHOD is_field_supported.

  IF i_fieldname = g_fieldname_button    OR
     i_fieldname = g_fieldname_buttonobj.
    r_supported = on.
  ELSE.
    r_supported = off.
  ENDIF.

ENDMETHOD.


METHOD modify_cellstyle.

  DATA: lr_button  TYPE REF TO cl_ish_grid_button.

  FIELD-SYMBOLS: <l_buttonobj>  TYPE ANY.

* Initializations.
  e_modified = off.

* Initial checking.
  CHECK NOT i_fieldname  IS INITIAL.
  CHECK NOT cs_outtab    IS INITIAL.
  CHECK is_field_supported( i_fieldname ) = on.

* Get the button object.
  lr_button = get_button( cs_outtab ).

* If we do not have a button object yet create one
* and set it in the outtab.
  IF lr_button IS INITIAL.
    CHECK NOT g_fieldname_buttonobj IS INITIAL.
    CHECK NOT cs_outtab             IS INITIAL.
    ASSIGN COMPONENT g_fieldname_buttonobj
      OF STRUCTURE cs_outtab
      TO <l_buttonobj>.
    CHECK sy-subrc = 0.
    lr_button = create_button( ).
    <l_buttonobj> = lr_button.
  ENDIF.

  CHECK lr_button IS BOUND.

* Let the button object do the work.
  CALL METHOD lr_button->modify_cellstyle
    EXPORTING
      i_fieldname  = i_fieldname
      i_enable     = i_enable
      i_disable_f4 = i_disable_f4
    IMPORTING
      e_modified   = e_modified
    CHANGING
      cs_outtab    = cs_outtab.

ENDMETHOD.


METHOD modify_fieldcat_properties.

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat.

* Initial checking.
  CHECK NOT ct_fieldcat IS INITIAL.

* Handle the buttonobj field.
* This is always a tech field.
  DO 1 TIMES.
    CHECK NOT g_fieldname_buttonobj IS INITIAL.
    READ TABLE ct_fieldcat
      ASSIGNING <ls_fieldcat>
      WITH KEY fieldname = g_fieldname_buttonobj.
    CHECK sy-subrc = 0.
    <ls_fieldcat>-tech = on.
  ENDDO.

* Handle the button field.
* This is an icon (not a button).
  DO 1 TIMES.
    CHECK NOT g_fieldname_button IS INITIAL.
    READ TABLE ct_fieldcat
      ASSIGNING <ls_fieldcat>
      WITH KEY fieldname = g_fieldname_button.
    CHECK sy-subrc = 0.
    <ls_fieldcat>-edit         = off.
    <ls_fieldcat>-f4availabl   = off.
    <ls_fieldcat>-icon         = on.
    IF g_outputlen IS INITIAL.
      <ls_fieldcat>-outputlen  = 2.
    ELSE.
      <ls_fieldcat>-outputlen  = g_outputlen.
    ENDIF.
  ENDDO.

ENDMETHOD.
ENDCLASS.
