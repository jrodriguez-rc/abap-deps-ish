class CL_ISH_GM_TABSTRUCT_SIMPLE definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_GM_TABSTRUCT_SIMPLE
*"* do not include other source files here!!!

  interfaces IF_ISH_DESTROYABLE .
  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_TABLE_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .

  aliases ADD_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~ADD_ENTRY .
  aliases DESTROY
    for IF_ISH_DESTROYABLE~DESTROY .
  aliases GET_ENTRIES
    for IF_ISH_GUI_TABLE_MODEL~GET_ENTRIES .
  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_DESTROYED
    for IF_ISH_DESTROYABLE~IS_DESTROYED .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases IS_IN_DESTROY_MODE
    for IF_ISH_DESTROYABLE~IS_IN_DESTROY_MODE .
  aliases REMOVE_ENTRY
    for IF_ISH_GUI_TABLE_MODEL~REMOVE_ENTRY .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_AFTER_DESTROY
    for IF_ISH_DESTROYABLE~EV_AFTER_DESTROY .
  aliases EV_BEFORE_DESTROY
    for IF_ISH_DESTROYABLE~EV_BEFORE_DESTROY .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .
  aliases EV_ENTRY_ADDED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_ADDED .
  aliases EV_ENTRY_REMOVED
    for IF_ISH_GUI_TABLE_MODEL~EV_ENTRY_REMOVED .

  class-methods CREATE_BY_DATA
    importing
      !IS_DATA type DATA
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABSTRUCT_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_STRUCTDESCR
    importing
      !IR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABSTRUCT_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE_BY_STRUCTNAME
    importing
      !I_STRUCTNAME type TABNAME
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
    returning
      value(RR_INSTANCE) type ref to CL_ISH_GM_TABSTRUCT_SIMPLE
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONSTRUCTOR
    importing
      !IR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL optional
      !IR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE optional
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
*"* protected components of class CL_ISH_GM_TABSTRUCT_SIMPLE
*"* do not include other source files here!!!

  data GR_CB_DESTROYABLE type ref to IF_ISH_CB_DESTROYABLE .
  data GR_CB_STRUCTMDL type ref to IF_ISH_GUI_CB_STRUCTURE_MODEL .
  data GR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL .
  data GT_ENTRY type ISH_T_GUI_MODEL_OBJHASH .
  type-pools ABAP .
  data G_DESTROYED type ABAP_BOOL .
  data G_DESTROY_MODE type ABAP_BOOL .

  methods _DESTROY .
private section.
*"* private components of class CL_ISH_GM_TABSTRUCT_SIMPLE
*"* do not include other source files here!!!

  data GR_DATA type ref to DATA .
  data GR_STRUCTDESCR type ref to CL_ABAP_STRUCTDESCR .
ENDCLASS.



CLASS CL_ISH_GM_TABSTRUCT_SIMPLE IMPLEMENTATION.


METHOD constructor.

  DATA:
    lx_root      TYPE REF TO cx_root.

* Initial checking.
  IF ir_structdescr IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_GM_TABSTRUCT_SIMPLE' ).
  ENDIF.

* Call the super constructor.
  super->constructor( ).

* Initialize attributes.
  gr_structdescr = ir_structdescr.

* Create the data reference.
  TRY.
      CREATE DATA gr_data TYPE HANDLE gr_structdescr.
    CATCH cx_root INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Remember the callback objects.
  gr_cb_tabmdl      = ir_cb_tabmdl.
  gr_cb_structmdl   = ir_cb_structmdl.
  gr_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD create_by_data.

  DATA:
    lr_structdescr  TYPE REF TO cl_abap_structdescr,
    lx_root         TYPE REF TO cx_root.

* Determine the structure descriptor for the given data.
  TRY.
      lr_structdescr ?= cl_abap_typedescr=>describe_by_data( p_data = is_data ).
    CATCH cx_sy_move_cast_error INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Create the instance.
  CREATE OBJECT rr_instance
    EXPORTING
      ir_structdescr    = lr_structdescr
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_structmdl   = ir_cb_structmdl
      ir_cb_destroyable = ir_cb_destroyable.

* Set data.
  rr_instance->set_data( is_data = is_data ).

ENDMETHOD.


METHOD create_by_structdescr.

* Create the instance.
  CREATE OBJECT rr_instance
    EXPORTING
      ir_structdescr    = ir_structdescr
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_structmdl   = ir_cb_structmdl
      ir_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD create_by_structname.

  DATA:
    lr_typedescr    TYPE REF TO cl_abap_typedescr,
    lr_structdescr  TYPE REF TO cl_abap_structdescr,
    lx_root         TYPE REF TO cx_root.

* Get the typedescriptor for the given structure name.
  CALL METHOD cl_abap_typedescr=>describe_by_name
    EXPORTING
      p_name      = i_structname
    RECEIVING
      p_descr_ref = lr_typedescr
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* The typedescriptor has to be a structure descriptor.
  TRY.
      lr_structdescr ?= lr_typedescr.
    CATCH cx_sy_move_cast_error INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

* Create the instance.
  CREATE OBJECT rr_instance
    EXPORTING
      ir_structdescr    = lr_structdescr
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_structmdl   = ir_cb_structmdl
      ir_cb_destroyable = ir_cb_destroyable.

ENDMETHOD.


METHOD get_data.

  FIELD-SYMBOLS:
    <ls_data>  TYPE data.

  ASSIGN gr_data->* TO <ls_data>.

  cs_data = <ls_data>.

ENDMETHOD.


METHOD if_ish_destroyable~destroy.

* Process only if we are not already destroyed or in destroy mode.
  CHECK is_destroyed( )       = abap_false.
  CHECK is_in_destroy_mode( ) = abap_false.

* Callback.
  IF gr_cb_destroyable IS BOUND.
    CHECK gr_cb_destroyable->cb_destroy( ir_destroyable = me ) = abap_true.
  ENDIF.

* Raise event before_destroy.
  RAISE EVENT ev_before_destroy.

* Set self in destroy mode.
  g_destroy_mode = abap_true.

* Destroy.
  _destroy( ).

* We are destroyed.
  g_destroy_mode = abap_false.
  g_destroyed    = abap_true.

* Export.
  r_destroyed = abap_true.

* Raise event after_destroy.
  RAISE EVENT ev_after_destroy.

ENDMETHOD.


METHOD if_ish_destroyable~is_destroyed.

  r_destroyed = g_destroyed.

ENDMETHOD.


METHOD if_ish_destroyable~is_in_destroy_mode.

  r_destroy_mode = g_destroy_mode.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA:
    l_fieldname    TYPE ish_fieldname,
    lr_typedescr1  TYPE REF TO cl_abap_typedescr,
    lr_typedescr2  TYPE REF TO cl_abap_typedescr,
    lx_root        TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_data>    TYPE data,
    <l_content>  TYPE any.

* Fieldname.
  l_fieldname = i_fieldname.

* Assign the structure.
  ASSIGN gr_data->* TO <ls_data>.

* Assign the component with the given fieldname
  ASSIGN COMPONENT l_fieldname
    OF STRUCTURE <ls_data>
    TO <l_content>.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* Get the typedescriptor of the component.
  CALL METHOD gr_structdescr->get_component_type
    EXPORTING
      p_name      = l_fieldname
    RECEIVING
      p_descr_ref = lr_typedescr1
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* Get the typedescriptor of the given content.
  lr_typedescr2 = cl_abap_typedescr=>describe_by_data( c_content ).

* Export.
  CASE lr_typedescr1->type_kind.
    WHEN cl_abap_typedescr=>typekind_dref OR
         cl_abap_typedescr=>typekind_oref.
      IF lr_typedescr1->type_kind <> lr_typedescr2->type_kind.
        RAISE EXCEPTION TYPE cx_ish_static_handler.
      ENDIF.
      TRY.
          c_content ?= <l_content>.
        CATCH cx_sy_move_cast_error INTO lx_root.
          RAISE EXCEPTION TYPE cx_ish_static_handler
            EXPORTING
              previous = lx_root.
      ENDTRY.
    WHEN OTHERS.
      IF lr_typedescr2->type_kind = cl_abap_typedescr=>typekind_dref OR
         lr_typedescr2->type_kind = cl_abap_typedescr=>typekind_oref.
        RAISE EXCEPTION TYPE cx_ish_static_handler.
      ENDIF.
      c_content = <l_content>.
  ENDCASE.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  DATA:
    l_fieldname     TYPE ish_fieldname.

  FIELD-SYMBOLS:
    <ls_component>  TYPE abap_compdescr.

  LOOP AT gr_structdescr->components ASSIGNING <ls_component>.
    l_fieldname = <ls_component>-name.
    INSERT l_fieldname INTO TABLE rt_supported_fieldname.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.

  READ TABLE gr_structdescr->components
    WITH KEY name = i_fieldname
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_supported = abap_true.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA:
    l_fieldname        TYPE ish_fieldname,
    lr_typedescr1      TYPE REF TO cl_abap_typedescr,
    lr_typedescr2      TYPE REF TO cl_abap_typedescr,
    lr_datadescr       TYPE REF TO cl_abap_datadescr,
    lr_new_content     TYPE REF TO data,
    lt_changed_field   TYPE ish_t_fieldname,
    lx_root            TYPE REF TO cx_root.

  FIELD-SYMBOLS:
    <ls_data>          TYPE any,
    <l_content>        TYPE any,
    <l_new_content>    TYPE any.

* Fieldname.
  l_fieldname = i_fieldname.

* Assign the structure.
  ASSIGN gr_data->* TO <ls_data>.

* Assign the component with the given fieldname.
  ASSIGN COMPONENT l_fieldname
    OF STRUCTURE <ls_data>
    TO <l_content>.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* Get the typedescriptor of the component.
  CALL METHOD gr_structdescr->get_component_type
    EXPORTING
      p_name      = l_fieldname
    RECEIVING
      p_descr_ref = lr_typedescr1
    EXCEPTIONS
      OTHERS      = 1.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

* Get the typedescriptor of the given content.
  lr_typedescr2 = cl_abap_typedescr=>describe_by_data( i_content ).

* Set content.
  CASE lr_typedescr1->type_kind.
    WHEN cl_abap_typedescr=>typekind_dref OR
         cl_abap_typedescr=>typekind_oref.
*     For references the type_kind of the component and the given content have to be equal.
      IF lr_typedescr1->type_kind <> lr_typedescr2->type_kind.
        RAISE EXCEPTION TYPE cx_ish_static_handler.
      ENDIF.
*     Process only on changes.
      CHECK <l_content> <> i_content.
*     Callback.
      IF gr_cb_structmdl IS BOUND.
        CHECK gr_cb_structmdl->cb_set_field_content(
                  ir_model    = me
                  i_fieldname = i_fieldname
                  i_content   = i_content ) = abap_true.
      ENDIF.
*     Set the content.
      TRY.
          <l_content> ?= i_content.
        CATCH cx_sy_move_cast_error INTO lx_root.
          RAISE EXCEPTION TYPE cx_ish_static_handler
            EXPORTING
              previous = lx_root.
      ENDTRY.
    WHEN OTHERS.
*     For non-references the type_kind of the given content has to be no reference.
      IF lr_typedescr2->type_kind = cl_abap_typedescr=>typekind_dref OR
         lr_typedescr2->type_kind = cl_abap_typedescr=>typekind_oref.
        RAISE EXCEPTION TYPE cx_ish_static_handler.
      ENDIF.
*     Clone the given content to be able to compare the component and the given content.
      lr_datadescr ?= lr_typedescr1.
      CREATE DATA lr_new_content TYPE HANDLE lr_datadescr.
      ASSIGN lr_new_content->* TO <l_new_content>.
      <l_new_content> = i_content.
*     Process only on changes.
      CHECK <l_content> <> <l_new_content>.
*     Callback.
      IF gr_cb_structmdl IS BOUND.
        CHECK gr_cb_structmdl->cb_set_field_content(
                  ir_model    = me
                  i_fieldname = i_fieldname
                  i_content   = i_content ) = abap_true.
      ENDIF.
*     Set the content.
      <l_content> = i_content.
  ENDCASE.

* Content was changes. So raise event ev_changed.
  INSERT i_fieldname INTO TABLE lt_changed_field.
  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

* Export.
  r_changed = abap_true.

ENDMETHOD.


METHOD if_ish_gui_table_model~add_entry.

  CHECK ir_entry IS BOUND.
  CHECK ir_entry <> me.

  IF gr_cb_tabmdl IS BOUND.
    CHECK gr_cb_tabmdl->cb_add_entry(
              ir_model   = me
              ir_entry   = ir_entry ) = abap_true.
  ENDIF.

  INSERT ir_entry INTO TABLE gt_entry.
  IF sy-subrc <> 0.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  RAISE EVENT ev_entry_added
    EXPORTING
      er_entry = ir_entry.

  r_added = abap_true.

ENDMETHOD.


METHOD if_ish_gui_table_model~get_entries.

  rt_entry = gt_entry.

ENDMETHOD.


METHOD if_ish_gui_table_model~remove_entry.

  IF gr_cb_tabmdl IS BOUND.
    CHECK gr_cb_tabmdl->cb_remove_entry(
              ir_model   = me
              ir_entry   = ir_entry ) = abap_true.
  ENDIF.

  DELETE TABLE gt_entry WITH TABLE KEY table_line = ir_entry.
  CHECK sy-subrc = 0.

  RAISE EVENT ev_entry_removed
    EXPORTING
      er_entry = ir_entry.

  r_removed = abap_true.

ENDMETHOD.


METHOD set_data.

  DATA:
    lr_new_data    TYPE REF TO data.

  FIELD-SYMBOLS:
    <ls_data>      TYPE data,
    <ls_new_data>  TYPE data.

* Assign the structure.
  ASSIGN gr_data->* TO <ls_data>.

* Clone the given data to be able to compare.
  CREATE DATA lr_new_data TYPE HANDLE gr_structdescr.
  ASSIGN lr_new_data->* TO <ls_new_data>.
  <ls_new_data> = is_data.

* Process only on changes.
  CHECK <ls_new_data> <> <ls_data>.

* Set data.
  <ls_data> = <ls_new_data>.

* Raise event ev_changed.
  RAISE EVENT ev_changed.

* Export.
  r_changed = abap_true.

ENDMETHOD.


METHOD _destroy.

  FIELD-SYMBOLS:
    <ls_data>  TYPE data.

* Clear only the data, not the data reference.
* The structdescr is also not freed.
  ASSIGN gr_data->* TO <ls_data>.
  CLEAR: <ls_data>.

* Clear the entries.
  CLEAR: gt_entry.

* Clear callback objects.
  CLEAR gr_cb_structmdl.
  CLEAR gr_cb_tabmdl.
  CLEAR gr_cb_destroyable.

ENDMETHOD.
ENDCLASS.
