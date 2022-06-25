class CL_ISH_GRID_LISTBOXHANDLER definition
  public
  create protected .

*"* public components of class CL_ISH_GRID_LISTBOXHANDLER
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

  constants CO_OTYPE_GRID_LISTBOXHANDLER type ISH_OBJECT_TYPE value 4020. "#EC NOTEXT

  class-methods CREATE_LISTBOXHANDLER
    importing
      !IR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID
    returning
      value(RR_LISTBOXHANDLER) type ref to CL_ISH_GRID_LISTBOXHANDLER .
  methods ADD_LISTBOXDEF
    importing
      !I_FIELDNAME_KEY type ISH_FIELDNAME
      !I_FIELDNAME_VALUE type ISH_FIELDNAME
      !I_FIELDNAME_HANDLE type ISH_FIELDNAME
      !I_FIELDNAME_LBOBJ type ISH_FIELDNAME .
  methods CREATE_EMPTY_COLUMN
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(RS_COL_FIELDVAL) type RNFIELD_VALUE .
  methods DESTROY .
  methods IS_FIELD_SUPPORTED
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(R_SUPPORTED) type ISH_ON_OFF .
  methods FINALIZE_OUTTAB_ENTRY
    importing
      !I_ROW_IDX type INT4
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CS_OUTTAB type ANY
      !CT_DROP_DOWN_ALIAS type LVC_T_DRAL
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods FINALIZE_ROW
    importing
      !IR_ROW_FIELDVAL type ref to CL_ISH_FIELD_VALUES
      !IS_OUTTAB type ANY .
  methods GET_CURSORFIELD
    importing
      !I_FIELD type BAPI_FLD
    returning
      value(R_FIELD) type BAPI_FLD .
  methods GET_KEYFIELD
    importing
      !I_FIELD type BAPI_FLD
    returning
      value(R_FIELD) type BAPI_FLD .
  methods MODIFY_FIELDCAT_PROPERTIES
    changing
      !CT_FIELDCAT type LVC_T_FCAT .
  methods PROCESS_DATA_CHANGED_FINISHED
    importing
      !IS_MODI type LVC_S_MODI
    exporting
      !E_HANDLED type ISH_ON_OFF
    changing
      !CT_MODI type LVC_T_MODI .
  methods REMOVE_LISTBOXDEF
    importing
      !I_FIELDNAME_KEY type ISH_FIELDNAME .
protected section.
*"* protected components of class CL_ISH_GRID_LISTBOXHANDLER
*"* do not include other source files here!!!

  data GR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID .
  data GT_LISTBOXDEF type ISH_T_LISTBOXFIELD .

  methods COMPLETE_CONSTRUCTION
    importing
      !IR_SCR_ALV_GRID type ref to CL_ISH_SCR_ALV_GRID .
private section.
*"* private components of class CL_ISH_GRID_LISTBOXHANDLER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GRID_LISTBOXHANDLER IMPLEMENTATION.


METHOD add_listboxdef.

  DATA: ls_lbf  TYPE rn1_listboxfield.

  CHECK NOT i_fieldname_key    IS INITIAL.
  CHECK NOT i_fieldname_value  IS INITIAL.
  CHECK NOT i_fieldname_handle IS INITIAL.
  CHECK NOT i_fieldname_lbobj  IS INITIAL.

  READ TABLE gt_listboxdef
    WITH KEY fieldname_key = i_fieldname_key
    TRANSPORTING NO FIELDS.
  CHECK NOT sy-subrc = 0.

  ls_lbf-fieldname_key    = i_fieldname_key.
  ls_lbf-fieldname_value  = i_fieldname_value.
  ls_lbf-fieldname_handle = i_fieldname_handle.
  ls_lbf-fieldname_lbobj  = i_fieldname_lbobj.

  APPEND ls_lbf TO gt_listboxdef.

ENDMETHOD.


METHOD complete_construction.

  gr_scr_alv_grid = ir_scr_alv_grid.

ENDMETHOD.


METHOD create_empty_column.

  FIELD-SYMBOLS: <ls_lbdef>  TYPE rn1_listboxfield.

* Initializations.
  CLEAR rs_col_fieldval.

* Initial checking.
  CHECK NOT i_fieldname IS INITIAL.

  LOOP AT gt_listboxdef ASSIGNING <ls_lbdef>.
    IF i_fieldname = <ls_lbdef>-fieldname_key.
      rs_col_fieldval-type      = co_fvtype_single.
      rs_col_fieldval-fieldname = i_fieldname.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD create_listboxhandler.

  CHECK NOT ir_scr_alv_grid IS INITIAL.

  CREATE OBJECT rr_listboxhandler.

  CALL METHOD rr_listboxhandler->complete_construction
    EXPORTING
      ir_scr_alv_grid = ir_scr_alv_grid.

ENDMETHOD.


METHOD destroy.

  CLEAR: gr_scr_alv_grid,
         gt_listboxdef.

ENDMETHOD.


METHOD finalize_outtab_entry.

  DATA: lt_dral    TYPE lvc_t_dral,
        lr_lbobj   TYPE REF TO cl_ish_listbox,
        l_vrm_key  TYPE vrm_value-key,
        l_value    TYPE nfvvalue,
        l_rc       TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_lbdef>    TYPE rn1_listboxfield,
                 <l_key>       TYPE ANY,
                 <l_value>     TYPE ANY,
                 <l_handle>    TYPE ANY,
                 <l_lbobj>     TYPE ANY.

* Michael Manoch, 23.08.2005   START
  DATA: l_enable         TYPE ish_on_off,
        l_row_fieldname  TYPE ish_fieldname,
        ls_fv_col        TYPE rnfield_value.
  FIELD-SYMBOLS: <l_row_fieldname>  TYPE ANY.
* Michael Manoch, 23.08.2005   END

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK gr_scr_alv_grid IS BOUND.

  LOOP AT gt_listboxdef ASSIGNING <ls_lbdef>.
*   Processing can only be done if we have all fieldnames.
    CHECK NOT <ls_lbdef>-fieldname_key    IS INITIAL.
    CHECK NOT <ls_lbdef>-fieldname_value  IS INITIAL.
    CHECK NOT <ls_lbdef>-fieldname_handle IS INITIAL.
    CHECK NOT <ls_lbdef>-fieldname_lbobj  IS INITIAL.
*   Assign the outtab fields.
    ASSIGN COMPONENT <ls_lbdef>-fieldname_key
      OF STRUCTURE cs_outtab
      TO <l_key>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT <ls_lbdef>-fieldname_value
      OF STRUCTURE cs_outtab
      TO <l_value>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT <ls_lbdef>-fieldname_handle
      OF STRUCTURE cs_outtab
      TO <l_handle>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT <ls_lbdef>-fieldname_lbobj
      OF STRUCTURE cs_outtab
      TO <l_lbobj>.
    CHECK sy-subrc = 0.
*   Get/Create the listbox object.
    l_value = <l_key>.
    CALL METHOD gr_scr_alv_grid->create_listbox
      EXPORTING
        i_fieldname     = <ls_lbdef>-fieldname_key
        i_rownumber     = i_row_idx
        i_fieldvalue    = l_value
      IMPORTING
        er_lb_object    = lr_lbobj
        e_rc            = l_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
*   Set the outtab fields.
    <l_lbobj> = lr_lbobj.
    IF lr_lbobj IS INITIAL.
      CLEAR: <l_handle>,
             <l_value>.
    ELSE.
      <l_handle> = lr_lbobj->get_handle( ).
      l_vrm_key = <l_key>.
      <l_value> = lr_lbobj->get_vrm_text( l_vrm_key ).
    ENDIF.
*   Handle the dropdown aliases.
    IF lr_lbobj IS BOUND.
      READ TABLE ct_drop_down_alias
        WITH KEY handle = <l_handle>
        TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        CALL METHOD lr_lbobj->get_drop_down_values
          IMPORTING
            e_rc               = l_rc
            et_drop_down_alias = lt_dral.
        IF l_rc = 0.
          APPEND LINES OF lt_dral TO ct_drop_down_alias.
        ENDIF.
      ENDIF.
    ENDIF.
*   Michael Manoch, 23.08.2005   START
*   En-/disable the listbox.
    DO 1 TIMES.
      CHECK NOT gr_scr_alv_grid->g_fieldname_row_id IS INITIAL.
      ASSIGN COMPONENT gr_scr_alv_grid->g_fieldname_row_id
        OF STRUCTURE cs_outtab
        TO <l_row_fieldname>.
      CHECK sy-subrc = 0.
      l_row_fieldname = <l_row_fieldname>.
      l_enable = on.
      IF gr_scr_alv_grid->get_fvattr_disabled( l_row_fieldname ) = on.
        l_enable = off.
      ENDIF.
      IF l_enable = on.
        CALL METHOD gr_scr_alv_grid->get_cell_fieldval
          EXPORTING
            i_row_fieldname = l_row_fieldname
            i_col_fieldname = <ls_lbdef>-fieldname_key
          IMPORTING
            es_col_fieldval = ls_fv_col
            e_rc            = l_rc.
        IF l_rc <> 0 OR
           ls_fv_col-disabled = on.
          l_enable = off.
        ENDIF.
      ENDIF.
      CALL METHOD gr_scr_alv_grid->modify_cellstyle
        EXPORTING
          i_fieldname = <ls_lbdef>-fieldname_value
          i_enable    = l_enable
        CHANGING
          cs_outtab   = cs_outtab.
    ENDDO.
*   Michael Manoch, 23.08.2005   END
  ENDLOOP.

ENDMETHOD.


METHOD finalize_row.

  DATA: l_vrm_text   TYPE vrm_value-text,
        l_vrm_key    type vrm_value-key,
        l_key        TYPE nfvvalue,
        lr_lbobj     TYPE REF TO cl_ish_listbox,
        ls_fv        TYPE rnfield_value,
        l_rc         TYPE ish_method_rc.

  FIELD-SYMBOLS: <ls_lbdef>    TYPE rn1_listboxfield,
                 <l_key>       TYPE ANY,
                 <l_value>     TYPE ANY,
                 <l_lbobj>     TYPE ANY.

* Initial checking.
  CHECK gr_scr_alv_grid IS BOUND.
  CHECK ir_row_fieldval IS BOUND.

  LOOP AT gt_listboxdef ASSIGNING <ls_lbdef>.
*   Processing can only be done if we have all fieldnames.
    CHECK NOT <ls_lbdef>-fieldname_key    IS INITIAL.
    CHECK NOT <ls_lbdef>-fieldname_value  IS INITIAL.
    CHECK NOT <ls_lbdef>-fieldname_lbobj  IS INITIAL.
*   Assign the outtab fields.
    ASSIGN COMPONENT <ls_lbdef>-fieldname_key
      OF STRUCTURE is_outtab
      TO <l_key>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT <ls_lbdef>-fieldname_value
      OF STRUCTURE is_outtab
      TO <l_value>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT <ls_lbdef>-fieldname_lbobj
      OF STRUCTURE is_outtab
      TO <l_lbobj>.
    CHECK sy-subrc = 0.
    CHECK NOT <l_lbobj> IS INITIAL.
    lr_lbobj   = <l_lbobj>.
*   Processing only if values are different.
    l_vrm_key  = <l_key>.
    l_vrm_text = lr_lbobj->get_vrm_text( l_vrm_key ).
    CHECK l_vrm_text <> <l_value>.
*   Get the key.
    l_vrm_text = <l_value>.
    l_key      = lr_lbobj->get_vrm_key( l_vrm_text ).
*   Set correct initial value if key is initial.
    IF l_key IS INITIAL.
      CALL METHOD ir_row_fieldval->get_data
        EXPORTING
          i_fieldname   = <ls_lbdef>-fieldname_key
        IMPORTING
          e_field_value = ls_fv
          e_rc          = l_rc.
      CHECK l_rc = 0.
      l_key = ls_fv-initial_value.
    ENDIF.
*   Set the key column fieldval.
    ir_row_fieldval->set_value_single(
                       i_fieldname = <ls_lbdef>-fieldname_key
                       i_value     = l_key ).
  ENDLOOP.

ENDMETHOD.


METHOD get_cursorfield.

  FIELD-SYMBOLS: <ls_lbdef>  TYPE rn1_listboxfield.

* Initializations.
  CLEAR r_field.

* Initial checking.
  CHECK NOT i_field IS INITIAL.

* Process.
  LOOP AT gt_listboxdef ASSIGNING <ls_lbdef>.
    CASE i_field.
      WHEN <ls_lbdef>-fieldname_value.
        r_field = i_field.
      WHEN <ls_lbdef>-fieldname_key    OR
           <ls_lbdef>-fieldname_handle OR
           <ls_lbdef>-fieldname_lbobj.
        r_field = <ls_lbdef>-fieldname_value.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD GET_KEYFIELD.

  FIELD-SYMBOLS: <ls_lbdef>  TYPE rn1_listboxfield.

* Initializations.
  CLEAR r_field.

* Initial checking.
  CHECK NOT i_field IS INITIAL.

* Process.
  LOOP AT gt_listboxdef ASSIGNING <ls_lbdef>.
    CASE i_field.
      WHEN <ls_lbdef>-fieldname_key.
        r_field = i_field.
      WHEN <ls_lbdef>-fieldname_value  OR
           <ls_lbdef>-fieldname_handle OR
           <ls_lbdef>-fieldname_lbobj.
        r_field = <ls_lbdef>-fieldname_key.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    EXIT.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_grid_listboxhandler.

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

  IF i_object_type = co_otype_grid_listboxhandler.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD is_field_supported.

  FIELD-SYMBOLS: <ls_lbf>  TYPE rn1_listboxfield.

  r_supported = off.

  LOOP AT gt_listboxdef ASSIGNING <ls_lbf>.
    IF i_fieldname = <ls_lbf>-fieldname_key    OR
       i_fieldname = <ls_lbf>-fieldname_value  OR
       i_fieldname = <ls_lbf>-fieldname_handle OR
       i_fieldname = <ls_lbf>-fieldname_lbobj.
      r_supported = on.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD modify_fieldcat_properties.

  FIELD-SYMBOLS: <ls_lbf>  TYPE rn1_listboxfield,
                 <ls_fcat> TYPE lvc_s_fcat.

  CHECK NOT ct_fieldcat IS INITIAL.

  LOOP AT gt_listboxdef ASSIGNING <ls_lbf>.
    LOOP AT ct_fieldcat ASSIGNING <ls_fcat>.
      CASE <ls_fcat>-fieldname.
        WHEN <ls_lbf>-fieldname_value.
          <ls_fcat>-edit         = on.
          <ls_fcat>-f4availabl   = off.
          <ls_fcat>-drdn_field   = <ls_lbf>-fieldname_handle.
        WHEN <ls_lbf>-fieldname_key    OR
             <ls_lbf>-fieldname_handle OR
             <ls_lbf>-fieldname_lbobj.
          <ls_fcat>-tech = on.
      ENDCASE.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.


METHOD process_data_changed_finished.

  DATA: ls_modi  TYPE lvc_s_modi.

  FIELD-SYMBOLS: <ls_lbdef>  TYPE rn1_listboxfield.

* Initializations.
  e_handled = off.

* Initial checking.
  CHECK NOT is_modi IS INITIAL.

* Get the corresponding listbox definition.
  READ TABLE gt_listboxdef
    ASSIGNING <ls_lbdef>
    WITH KEY fieldname_value = is_modi-fieldname.
  CHECK sy-subrc = 0.

* This cell is handled by self.
  e_handled = on.

* Set the key cell as modified.
  ls_modi = is_modi.
  ls_modi-fieldname = <ls_lbdef>-fieldname_key.
  CLEAR ls_modi-value.
  APPEND ls_modi TO ct_modi.

ENDMETHOD.


METHOD remove_listboxdef.

  CHECK NOT i_fieldname_key IS INITIAL.

  DELETE gt_listboxdef
    WHERE fieldname_key = i_fieldname_key.

ENDMETHOD.
ENDCLASS.
