class CL_ISH_GRID_LTXBUTTONDEF definition
  public
  inheriting from CL_ISH_GRID_BUTTONDEF
  create protected .

public section.
*"* public components of class CL_ISH_GRID_LTXBUTTONDEF
*"* do not include other source files here!!!

  data G_FIELDNAME_FIRSTLINE type ISH_FIELDNAME read-only .
  data G_FIELDNAME_LTX type ISH_FIELDNAME read-only .
  data G_FIELDNAME_LTXOBJ type ISH_FIELDNAME read-only .
  data G_FIELDNAME_LTXID type ISH_FIELDNAME read-only .
  data G_LTXID type ISH_TEXTMODULE_ID read-only .
  data G_TRANS_FIRSTLINE_FV type ISH_ON_OFF read-only .
  data G_TRANS_LTX_FV type ISH_ON_OFF read-only .
  data G_ICON_INSERT type N1ICON read-only .
  data G_ICON_UPDATE type N1ICON read-only .
  data G_ICON_DISPLAY type N1ICON read-only .
  constants CO_OTYPE_GRID_LTXBUTTONDEF type ISH_OBJECT_TYPE value 4018. "#EC NOTEXT

  class-methods CREATE_LTXBUTTONDEF
    importing
      !IR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID
      !I_FIELDNAME_BUTTON type ISH_FIELDNAME
      !I_FIELDNAME_BUTTONOBJ type ISH_FIELDNAME
      !I_FIELDNAME_FIRSTLINE type ISH_FIELDNAME
      !I_FIELDNAME_LTX type ISH_FIELDNAME
      !I_FIELDNAME_LTXOBJ type ISH_FIELDNAME
      !I_FIELDNAME_LTXID type ISH_FIELDNAME optional
      !I_LTXID type ISH_TEXTMODULE_ID optional
      !I_OUTPUTLEN type I default 2
      !I_ENABLED type ISH_ON_OFF default ON
      !I_HANDLE_VCODE type ISH_ON_OFF default ON
      !I_TRANS_BUTTON_FV type ISH_ON_OFF default OFF
      !I_TRANS_FIRSTLINE_FV type ISH_ON_OFF default ON
      !I_TRANS_LTX_FV type ISH_ON_OFF default ON
    returning
      value(RR_LTXBUTTONDEF) type ref to CL_ISH_GRID_LTXBUTTONDEF .
  methods SET_ICON_DISPLAY
    importing
      !I_ICON type N1_ICON optional
      !I_TEXT type STRING optional
      !I_INFO type STRING optional
    preferred parameter I_ICON .
  methods SET_ICON_INSERT
    importing
      !I_ICON type N1_ICON optional
      !I_TEXT type STRING optional
      !I_INFO type STRING optional
    preferred parameter I_ICON .
  methods SET_ICON_UPDATE
    importing
      !I_ICON type N1_ICON optional
      !I_TEXT type STRING optional
      !I_INFO type STRING optional
    preferred parameter I_ICON .

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
*"* protected components of class CL_ISH_GRID_LTXBUTTONDEF
*"* do not include other source files here!!!

  methods COMPLETE_CONSTRUCTION_LTX
    importing
      !IR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID
      !I_FIELDNAME_BUTTON type ISH_FIELDNAME
      !I_FIELDNAME_BUTTONOBJ type ISH_FIELDNAME
      !I_FIELDNAME_FIRSTLINE type ISH_FIELDNAME
      !I_FIELDNAME_LTX type ISH_FIELDNAME
      !I_FIELDNAME_LTXOBJ type ISH_FIELDNAME
      !I_FIELDNAME_LTXID type ISH_FIELDNAME
      !I_LTXID type ISH_TEXTMODULE_ID
      !I_OUTPUTLEN type I default 2
      !I_ENABLED type ISH_ON_OFF default ON
      !I_HANDLE_VCODE type ISH_ON_OFF default OFF
      !I_TRANS_BUTTON_FV type ISH_ON_OFF default OFF
      !I_TRANS_FIRSTLINE_FV type ISH_ON_OFF default ON
      !I_TRANS_LTX_FV type ISH_ON_OFF default ON .

  methods CREATE_BUTTON
    redefinition .
private section.
*"* private components of class CL_ISH_GRID_LTXBUTTONDEF
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_LTXBUTTONDEF IMPLEMENTATION.


METHOD complete_construction_ltx .

  DATA: l_lgtx03  TYPE ish_lgtx03.

* First complete_construction.
  CALL METHOD complete_construction
    EXPORTING
      ir_scr_alv_grid       = ir_scr_alv_grid
      i_fieldname_button    = i_fieldname_button
      i_fieldname_buttonobj = i_fieldname_buttonobj
      i_outputlen           = i_outputlen
      i_enabled             = i_enabled
      i_handle_vcode        = i_handle_vcode
      i_trans_button_fv     = i_trans_button_fv.

* Now handle own attributes.
  g_fieldname_firstline = i_fieldname_firstline.
  g_fieldname_ltx       = i_fieldname_ltx.
  g_fieldname_ltxobj    = i_fieldname_ltxobj.
  g_fieldname_ltxid     = i_fieldname_ltxid.
  g_ltxid               = i_ltxid.
  g_trans_firstline_fv  = i_trans_firstline_fv.
  g_trans_ltx_fv        = i_trans_ltx_fv.

* Handle the icons.
* g_icon_insert.
  CALL FUNCTION 'ISH_TEXTBUTTON_SET'
    EXPORTING
      ss_lgtxt       = off
      ss_button_name = g_fieldname_button
      ss_text_name   = g_fieldname_firstline
      ss_vcode       = co_vcode_insert
    IMPORTING
      ss_button      = l_lgtx03
    EXCEPTIONS
      OTHERS         = 1.
  g_icon_insert = l_lgtx03.
* g_icon_update.
  CALL FUNCTION 'ISH_TEXTBUTTON_SET'
    EXPORTING
      ss_lgtxt       = on
      ss_button_name = g_fieldname_button
      ss_text_name   = g_fieldname_firstline
      ss_vcode       = co_vcode_update
    IMPORTING
      ss_button      = l_lgtx03
    EXCEPTIONS
      OTHERS         = 1.
  g_icon_update = l_lgtx03.
* g_icon_display.
  CALL FUNCTION 'ISH_TEXTBUTTON_SET'
    EXPORTING
      ss_lgtxt       = on
      ss_button_name = g_fieldname_button
      ss_text_name   = g_fieldname_firstline
      ss_vcode       = co_vcode_display
    IMPORTING
      ss_button      = l_lgtx03
    EXCEPTIONS
      OTHERS         = 1.
  g_icon_display = l_lgtx03.

ENDMETHOD.


METHOD create_button .

  CLEAR rr_button.

  rr_button = cl_ish_grid_ltxbutton=>create_ltxbutton(
                ir_ltxbuttondef = me
                i_enabled       = g_enabled ).

ENDMETHOD.


METHOD create_empty_column.

* First call the super method.
  rs_col_fieldval = super->create_empty_column( i_fieldname ).
  CHECK rs_col_fieldval IS INITIAL.

* Now do own processing.
  CASE i_fieldname.
    WHEN g_fieldname_firstline.
      rs_col_fieldval-fieldname = i_fieldname.
      rs_col_fieldval-type      = co_fvtype_single.
    WHEN g_fieldname_ltx.
      rs_col_fieldval-fieldname = i_fieldname.
      rs_col_fieldval-type      = co_fvtype_single.
    WHEN g_fieldname_ltxobj.
      rs_col_fieldval-fieldname = i_fieldname.
      rs_col_fieldval-type      = co_fvtype_identify.
    WHEN g_fieldname_ltxid.
      rs_col_fieldval-fieldname = i_fieldname.
      rs_col_fieldval-type      = co_fvtype_single.
  ENDCASE.

ENDMETHOD.


METHOD create_ltxbuttondef .

  CLEAR rr_ltxbuttondef.

  CHECK NOT ir_scr_alv_grid       IS INITIAL.
  CHECK NOT i_fieldname_button    IS INITIAL.
  CHECK NOT i_fieldname_buttonobj IS INITIAL.
  CHECK NOT i_fieldname_firstline IS INITIAL.
  CHECK NOT i_fieldname_ltx       IS INITIAL.
  CHECK NOT i_fieldname_ltxobj    IS INITIAL.

  CREATE OBJECT rr_ltxbuttondef.

  CALL METHOD rr_ltxbuttondef->complete_construction_ltx
    EXPORTING
      ir_scr_alv_grid       = ir_scr_alv_grid
      i_fieldname_button    = i_fieldname_button
      i_fieldname_buttonobj = i_fieldname_buttonobj
      i_fieldname_firstline = i_fieldname_firstline
      i_fieldname_ltx       = i_fieldname_ltx
      i_fieldname_ltxobj    = i_fieldname_ltxobj
      i_fieldname_ltxid     = i_fieldname_ltxid
      i_ltxid               = i_ltxid
      i_outputlen           = i_outputlen
      i_enabled             = i_enabled
      i_handle_vcode        = i_handle_vcode
      i_trans_button_fv     = i_trans_button_fv
      i_trans_firstline_fv  = i_trans_firstline_fv
      i_trans_ltx_fv        = i_trans_ltx_fv.

ENDMETHOD.


METHOD destroy.

* First call the super method.
  CALL METHOD super->destroy.

* No destroy own attributes.
  CLEAR: g_fieldname_firstline,
         g_fieldname_ltx,
         g_fieldname_ltxobj,
         g_fieldname_ltxid,
         g_icon_display,
         g_icon_insert,
         g_icon_update,
         g_ltxid,
         g_trans_firstline_fv,
         g_trans_ltx_fv.

ENDMETHOD.


METHOD get_cursorfield.

* First call the super method.
  r_field = super->get_cursorfield( i_field ).
  CHECK r_field IS INITIAL.

* Now do own processing.
  CASE i_field.
    WHEN g_fieldname_firstline.
      r_field = i_field.
    WHEN g_fieldname_ltx    OR
         g_fieldname_ltxobj OR
         g_fieldname_ltxid.
      r_field = g_fieldname_button.
  ENDCASE.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_ltxbuttondef.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_grid_ltxbuttondef.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = super->is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD is_field_supported.

  r_supported = off.

* First call the super method.
  r_supported = super->is_field_supported( i_fieldname ).
  CHECK r_supported = off.

* Now do own processing.
  IF i_fieldname = g_fieldname_firstline OR
     i_fieldname = g_fieldname_ltx.
    r_supported = on.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD modify_fieldcat_properties .

  FIELD-SYMBOLS: <ls_fieldcat>  TYPE lvc_s_fcat.

* First call the super method.
  CALL METHOD super->modify_fieldcat_properties
    CHANGING
      ct_fieldcat = ct_fieldcat.

* Initial checking.
  CHECK NOT ct_fieldcat IS INITIAL.

* Handle the firstline field.
  DO 1 TIMES.
    READ TABLE ct_fieldcat
      ASSIGNING <ls_fieldcat>
      WITH KEY fieldname = g_fieldname_firstline.
    CHECK sy-subrc = 0.
    <ls_fieldcat>-edit          = on.
    <ls_fieldcat>-f4availabl    = off.
  ENDDO.

* The ltx field is a tech field.
  DO 1 TIMES.
    READ TABLE ct_fieldcat
      ASSIGNING <ls_fieldcat>
      WITH KEY fieldname = g_fieldname_ltx.
    CHECK sy-subrc = 0.
    <ls_fieldcat>-tech = on.
  ENDDO.

* The ltxobj field is a tech field.
  DO 1 TIMES.
    READ TABLE ct_fieldcat
      ASSIGNING <ls_fieldcat>
      WITH KEY fieldname = g_fieldname_ltxobj.
    CHECK sy-subrc = 0.
    <ls_fieldcat>-tech = on.
  ENDDO.

* The ltxid field is a tech field.
  DO 1 TIMES.
    READ TABLE ct_fieldcat
      ASSIGNING <ls_fieldcat>
      WITH KEY fieldname = g_fieldname_ltxid.
    CHECK sy-subrc = 0.
    <ls_fieldcat>-tech = on.
  ENDDO.

ENDMETHOD.


METHOD set_icon_display .

  g_icon_display = build_icon( i_icon = i_icon
                               i_text = i_text
                               i_info = i_info ).

ENDMETHOD.


METHOD set_icon_insert.

  g_icon_insert = build_icon( i_icon = i_icon
                              i_text = i_text
                              i_info = i_info ).

ENDMETHOD.


METHOD set_icon_update .

  g_icon_update = build_icon( i_icon = i_icon
                              i_text = i_text
                              i_info = i_info ).

ENDMETHOD.
ENDCLASS.
