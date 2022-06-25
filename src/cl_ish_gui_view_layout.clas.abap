class CL_ISH_GUI_VIEW_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_LAYOUT
  abstract
  create public .

*"* public components of class CL_ISH_GUI_VIEW_LAYOUT
*"* do not include other source files here!!!
public section.

  constants CO_FIELDNAME_R_VIEW type ISH_FIELDNAME value 'R_VIEW'. "#EC NOTEXT
  constants CO_RELID_VIEW type INDX_RELID value 'GV'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
    preferred parameter I_ELEMENT_NAME .
  methods GET_VIEW
  final
    returning
      value(RR_VIEW) type ref to IF_ISH_GUI_VIEW .
  methods SET_VIEW
    importing
      !IR_VIEW type ref to IF_ISH_GUI_VIEW
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .

  methods GET_COPY
    redefinition .
  methods IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT
    redefinition .
  methods IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS
    redefinition .
  methods IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT
    redefinition .
  methods SAVE
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_VIEW_LAYOUT
*"* do not include other source files here!!!

  methods _GET_CB_STRUCTURE_MODEL
    redefinition .
  methods _GET_RELID
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_VIEW_LAYOUT
*"* do not include other source files here!!!

  data GR_VIEW type ref to IF_ISH_GUI_VIEW .
ENDCLASS.



CLASS CL_ISH_GUI_VIEW_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name  = i_element_name
      i_layout_name   = i_layout_name ).

ENDMETHOD.


METHOD get_copy.

  DATA lr_copy            TYPE REF TO cl_ish_gui_view_layout.

* Call the super method.
  rr_copy = super->get_copy( ).

* Disconnect from the view.
  TRY.
      lr_copy ?= rr_copy.
      CLEAR lr_copy->gr_view.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD get_view.

  rr_view = gr_view.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA l_rc                   TYPE ish_method_rc.

* Get the field content.
  CASE i_fieldname.
    WHEN co_fieldname_r_view.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = gr_view
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN OTHERS.
      CALL METHOD super->get_field_content
        EXPORTING
          i_fieldname = i_fieldname
        CHANGING
          c_content   = c_content.
      RETURN.
  ENDCASE.

* Errorhandling.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GUI_VIEW_LAYOUT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  rt_supported_fieldname = super->get_supported_fields( ).

  INSERT co_fieldname_r_view                INTO TABLE rt_supported_fieldname.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA lt_changed_field             TYPE ish_t_fieldname.
  DATA l_rc                         TYPE ish_method_rc.

* Set field content.
  CASE i_fieldname.
    WHEN co_fieldname_r_view.
      IF gr_view IS BOUND.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = 'SET_FIELD_CONTENT'
            i_mv3        = 'CL_ISH_GUI_VIEW_LAYOUT' ).
      ENDIF.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source  = i_content
        IMPORTING
          e_changed = r_changed
          e_rc      = l_rc
        CHANGING
          c_target  = gr_view.
      IF l_rc <> 0.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '2'
            i_mv2        = 'SET_FIELD_CONTENT'
            i_mv3        = 'CL_ISH_GUI_VIEW_LAYOUT' ).
      ENDIF.
    WHEN OTHERS.
      r_changed = super->set_field_content(
          i_fieldname = i_fieldname
          i_content   = i_content ).
      RETURN.
  ENDCASE.
  CHECK r_changed = abap_true.

* Raise event ev_changed.
  INSERT i_fieldname INTO TABLE lt_changed_field.
  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

ENDMETHOD.


METHOD save.

  DATA lr_view                    TYPE REF TO if_ish_gui_view.

* Avoid serializing the view.
  lr_view = gr_view.
  CLEAR gr_view.

* Call the super method to save the layout.
  TRY.
      super->save(
          i_username     = i_username
          i_internal_key = i_internal_key
          i_erdat        = i_erdat
          i_ertim        = i_ertim
          i_erusr        = i_erusr ).
    CLEANUP.
      gr_view = lr_view.
  ENDTRY.

* Reset the view.
  gr_view = lr_view.

ENDMETHOD.


METHOD set_view.

  CHECK ir_view <> gr_view.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_r_view
      i_content   = ir_view ).

ENDMETHOD.


METHOD _get_cb_structure_model.

  TRY.
      rr_cb_structure_model ?= gr_view.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD _get_relid.

  r_relid = co_relid_view.

ENDMETHOD.
ENDCLASS.
