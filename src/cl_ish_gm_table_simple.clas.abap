class CL_ISH_GM_TABLE_SIMPLE definition
  public
  inheriting from CL_ISH_GM_TABLE
  create protected .

public section.
*"* public components of class CL_ISH_GM_TABLE_SIMPLE
*"* do not include other source files here!!!

  class-methods CREATE_BY_STRUCTDESCR
    importing
      !IR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABLE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_STRUCTNAME
    importing
      !I_STRUCTNAME type TABNAME
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABLE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_STRUCTURE
    importing
      !IS_DATA type DATA
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABLE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_TABLE
    importing
      !IT_TABLE type TABLE
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABLE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_TABLEDESCR
    importing
      !IR_TABLEDESCR type ref to CL_ABAP_TABLEDESCR
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABLE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_TABNAME
    importing
      !I_TABNAME type TABNAME
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABLE_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods ADD_ENTRY_BY_DATA
    importing
      !IS_DATA type DATA
    returning
      value(RR_ENTRY) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
      !I_NODE_TEXT type LVC_VALUE optional
      !I_NODE_ICON type TV_IMAGE optional
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GM_TABLE_SIMPLE
*"* do not include other source files here!!!

  methods _CREATE_ENTRY_BY_DATA
    importing
      !IS_DATA type DATA
    returning
      value(RR_ENTRY) type ref to IF_ISH_GUI_MODEL
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_GM_TABLE_SIMPLE
*"* do not include other source files here!!!

  data GR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR .
ENDCLASS.



CLASS CL_ISH_GM_TABLE_SIMPLE IMPLEMENTATION.


METHOD add_entry_by_data.

  rr_entry = _create_entry_by_data( is_data = is_data ).

  IF add_entry( ir_entry = rr_entry ) = abap_false.
    CLEAR: rr_entry.
  ENDIF.

ENDMETHOD.


METHOD constructor.

* The structure descriptor has to be specified.
  IF ir_structdescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDIF.

* Call the super constructor.
  super->constructor(
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_destroyable = ir_cb_destroyable
      i_node_text       = i_node_text
      i_node_icon       = i_node_icon ).

* Initialize attributes.
  gr_structdescr = ir_structdescr.

ENDMETHOD.


METHOD create_by_structdescr.

  CREATE OBJECT rr_instance
    EXPORTING
      ir_structdescr    = ir_structdescr
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_destroyable = ir_cb_destroyable
      i_node_text       = i_node_text
      i_node_icon       = i_node_icon.

ENDMETHOD.


METHOD create_by_structname.

  DATA lr_typedescr       TYPE REF TO cl_abap_typedescr.
  DATA lr_structdescr     TYPE REF TO cl_abap_structdescr.

* Get the typedescriptor for the given structure name.
  CALL METHOD cl_abap_typedescr=>describe_by_name
    EXPORTING
      p_name      = i_structname
    RECEIVING
      p_descr_ref = lr_typedescr
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CREATE_BY_STRUCTNAME'
        i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDIF.

* The typedescriptor has to be a structure descriptor.
  TRY.
      lr_structdescr ?= lr_typedescr.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'CREATE_BY_STRUCTNAME'
          i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDTRY.

* Create the instance.
  rr_instance = create_by_structdescr(
                    ir_structdescr    = lr_structdescr
                    ir_cb_tabmdl      = ir_cb_tabmdl
                    ir_cb_destroyable = ir_cb_destroyable
                    i_node_text       = i_node_text
                    i_node_icon       = i_node_icon ).

ENDMETHOD.


METHOD create_by_structure.

  DATA lr_structdescr     TYPE REF TO cl_abap_structdescr.

* Get the structure descriptor.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = is_data ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'CREATE_BY_STRUCTURE'
          i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDTRY.

* Create the instance.
  rr_instance = create_by_structdescr(
                    ir_structdescr    = lr_structdescr
                    ir_cb_tabmdl      = ir_cb_tabmdl
                    ir_cb_destroyable = ir_cb_destroyable
                    i_node_text       = i_node_text
                    i_node_icon       = i_node_icon ).

* Add the given entry.
  rr_instance->add_entry_by_data( is_data = is_data ).

ENDMETHOD.


METHOD create_by_table.

  DATA lr_tabledescr        TYPE REF TO cl_abap_tabledescr.

  FIELD-SYMBOLS:
    <ls_data>  TYPE data.

* Get the table descriptor.
  TRY.
      lr_tabledescr ?= cl_abap_typedescr=>describe_by_data( p_data = it_table ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'CREATE_BY_TABLE'
          i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDTRY.

* Create the instance.
  rr_instance = create_by_tabledescr(
                    ir_tabledescr     = lr_tabledescr
                    ir_cb_tabmdl      = ir_cb_tabmdl
                    ir_cb_destroyable = ir_cb_destroyable
                    i_node_text       = i_node_text
                    i_node_icon       = i_node_icon ).

* Add the given entries.
  LOOP AT it_table ASSIGNING <ls_data>.
    rr_instance->add_entry_by_data( is_data = <ls_data> ).
  ENDLOOP.

ENDMETHOD.


METHOD create_by_tabledescr.

  DATA lr_structdescr     TYPE REF TO cl_abap_structdescr.

* Initial checking.
  IF ir_tabledescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CREATE_BY_TABLEDESCR'
        i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDIF.

* Get the structure descriptor.
  TRY.
      lr_structdescr ?= ir_tabledescr->get_table_line_type( ).
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '1'
          i_mv2        = 'CREATE_BY_TABLEDESCR'
          i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDTRY.

* Create the instance.
  rr_instance = create_by_structdescr(
                    ir_structdescr    = lr_structdescr
                    ir_cb_tabmdl      = ir_cb_tabmdl
                    ir_cb_destroyable = ir_cb_destroyable
                    i_node_text       = i_node_text
                    i_node_icon       = i_node_icon ).

ENDMETHOD.


METHOD create_by_tabname.

  DATA lr_typedescr         TYPE REF TO cl_abap_typedescr.
  DATA lr_tabledescr        TYPE REF TO cl_abap_tabledescr.

* Get the typedescriptor for the given table name.
  CALL METHOD cl_abap_typedescr=>describe_by_name
    EXPORTING
      p_name      = i_tabname
    RECEIVING
      p_descr_ref = lr_typedescr
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CREATE_BY_TABNAME'
        i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDIF.

* The typedescriptor has to be a table descriptor.
  TRY.
      lr_tabledescr ?= lr_typedescr.
    CATCH cx_sy_move_cast_error.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'CREATE_BY_TABNAME'
          i_mv3        = 'CL_ISH_GM_TABLE_SIMPLE' ).
  ENDTRY.

* Create the instance.
  rr_instance = create_by_tabledescr(
                    ir_tabledescr     = lr_tabledescr
                    ir_cb_tabmdl      = ir_cb_tabmdl
                    ir_cb_destroyable = ir_cb_destroyable
                    i_node_text       = i_node_text
                    i_node_icon       = i_node_icon ).

ENDMETHOD.


METHOD _create_entry_by_data.

  DATA:
    lr_data    TYPE REF TO data.

  FIELD-SYMBOLS:
    <ls_data>  TYPE data.

  CREATE DATA lr_data TYPE HANDLE gr_structdescr.
  ASSIGN lr_data->* TO <ls_data>.

  <ls_data> = is_data.

  rr_entry = cl_ish_gm_structure_simple=>create_by_data( is_data = <ls_data> ).

ENDMETHOD.
ENDCLASS.
