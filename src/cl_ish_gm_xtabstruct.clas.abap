class CL_ISH_GM_XTABSTRUCT definition
  public
  inheriting from CL_ISH_GM_XTABLE
  create public .

public section.
*"* public components of class CL_ISH_GM_XTABSTRUCT
*"* do not include other source files here!!!

  interfaces IF_ISH_GUI_STRUCTURE_MODEL .

  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

  methods CONSTRUCTOR
    importing
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !IT_ENTRY type ISH_T_GUI_MODEL_OBJHASH optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IS_DATA type DATA
    preferred parameter IR_CB_TABMDL
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DATA
    changing
      !CS_DATA type DATA
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods SET_DATA
    importing
      !IS_DATA type DATA
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GM_XTABSTRUCT
*"* do not include other source files here!!!

  data GR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL .
  data GR_DATA type ref to DATA .
private section.
*"* private components of class CL_ISH_GM_XTABSTRUCT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_XTABSTRUCT IMPLEMENTATION.


METHOD constructor.

  DATA lr_structdescr           TYPE REF TO cl_abap_structdescr.

  FIELD-SYMBOLS <ls_data>       TYPE data.

* Determine the structure descriptor for the given data.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = is_data ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_structdescr.
  ENDTRY.
  IF lr_structdescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_GM_XTABSTRUCT' ).
  ENDIF.

* Call the super constructor.
  super->constructor(
      ir_cb_tabmdl  = ir_cb_tabmdl
      ir_cb_xtabmdl = ir_cb_xtabmdl
      it_entry      = it_entry
      i_node_text   = i_node_text
      i_node_icon   = i_node_icon ).

* Initialize attributes.
  gr_cb_structmdl = ir_cb_structmdl.
  CREATE DATA gr_data TYPE HANDLE lr_structdescr.
  ASSIGN gr_data->* TO <ls_data>.
  <ls_data> = is_data.

ENDMETHOD.


METHOD get_data.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  IF gr_data IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_DATA'
        i_mv3        = 'CL_ISH_GM_XTABSTRUCT' ).
  ENDIF.

  ASSIGN gr_data->* TO <ls_data>.

  CALL METHOD cl_ish_utl_gui_structure_model=>set_data
    EXPORTING
      is_source_data = <ls_data>
    CHANGING
      cs_target_data = cs_data.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  IF gr_data IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GM_XTABSTRUCT' ).
  ENDIF.

  ASSIGN gr_data->* TO <ls_data>.

  CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
    EXPORTING
      ir_model    = me
      is_data     = <ls_data>
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  CHECK gr_data IS BOUND.

  ASSIGN gr_data->* TO <ls_data>.

  rt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields( is_data = <ls_data> ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  CHECK gr_data IS BOUND.

  ASSIGN gr_data->* TO <ls_data>.

  r_supported = cl_ish_utl_gui_structure_model=>is_field_supported(
      is_data     = <ls_data>
      i_fieldname = i_fieldname ).

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA lt_changed_field             TYPE ish_t_fieldname.

  FIELD-SYMBOLS <ls_data>           TYPE data.

  IF gr_data IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GM_XTABSTRUCT' ).
  ENDIF.

  ASSIGN gr_data->* TO <ls_data>.

  CALL METHOD cl_ish_utl_gui_structure_model=>set_field_content
    EXPORTING
      ir_model    = me
      i_fieldname = i_fieldname
      i_content   = i_content
      ir_cb       = gr_cb_structmdl
    IMPORTING
      e_changed   = r_changed
    CHANGING
      cs_data     = <ls_data>.

  IF r_changed = abap_true.
    INSERT i_fieldname INTO TABLE lt_changed_field.
    RAISE EVENT ev_changed
      EXPORTING
        et_changed_field = lt_changed_field.
  ENDIF.

ENDMETHOD.


METHOD set_data.

  DATA lr_tmp_data                        TYPE REF TO data.
  DATA lt_changed_field                   TYPE ish_t_fieldname.

  FIELD-SYMBOLS <ls_data>                 TYPE data.
  FIELD-SYMBOLS <ls_tmp_data>             TYPE data.
  FIELD-SYMBOLS <l_changed_fieldname>     TYPE ish_fieldname.
  FIELD-SYMBOLS <l_changed_field>         TYPE any.

  IF gr_data IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'SET_DATA'
        i_mv3        = 'CL_ISH_GM_XTABSTRUCT' ).
  ENDIF.

  ASSIGN gr_data->* TO <ls_data>.

  CREATE DATA lr_tmp_data LIKE <ls_data>.
  ASSIGN lr_tmp_data->* TO <ls_tmp_data>.

  CALL METHOD cl_ish_utl_gui_structure_model=>set_data
    EXPORTING
      is_source_data   = is_data
    IMPORTING
      et_changed_field = lt_changed_field
    CHANGING
      cs_target_data   = <ls_tmp_data>.

  CHECK lt_changed_field IS NOT INITIAL.

  IF gr_cb_structmdl IS BOUND.
    LOOP AT lt_changed_field ASSIGNING <l_changed_fieldname>.
      ASSIGN COMPONENT <l_changed_fieldname>
        OF STRUCTURE <ls_tmp_data>
        TO <l_changed_field>.
      IF gr_cb_structmdl->cb_set_field_content(
          ir_model    = me
          i_fieldname = <l_changed_fieldname>
          i_content   = <l_changed_field> ) = abap_false.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = 'SET_DATA'
            i_mv3        = 'CL_ISH_GM_XTABSTRUCT' ).
      ENDIF.
    ENDLOOP.
  ENDIF.

  <ls_data> = <ls_tmp_data>.

  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

  r_changed = abap_true.

ENDMETHOD.
ENDCLASS.
