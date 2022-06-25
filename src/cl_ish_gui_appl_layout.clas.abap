class CL_ISH_GUI_APPL_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_LAYOUT
  create public .

public section.
*"* public components of class CL_ISH_GUI_APPL_LAYOUT
*"* do not include other source files here!!!

  constants CO_FIELDNAME_R_APPLICATION type ISH_FIELDNAME value 'R_APPLICATION'. "#EC NOTEXT
  constants CO_FIELDNAME_T_EXCLFUNC type ISH_FIELDNAME value 'T_EXCLFUNC'. "#EC NOTEXT
  constants CO_FIELDNAME_USE_MSG_VIEWER type ISH_FIELDNAME value 'USE_MSG_VIEWER'. "#EC NOTEXT
  constants CO_RELID_APPLICATION type INDX_RELID value 'GA'. "#EC NOTEXT

  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_USE_MSG_VIEWER type N1GUI_APPL_USE_MSG_VIEWER default ABAP_FALSE
      !IT_EXCLFUNC type SYUCOMM_T optional
    preferred parameter I_ELEMENT_NAME .
  methods GET_APPLICATION
  final
    returning
      value(RR_APPLICATION) type ref to IF_ISH_GUI_APPLICATION .
  methods GET_T_EXCLFUNC
    returning
      value(RT_EXCLFUNC) type SYUCOMM_T .
  methods GET_USE_MSG_VIEWER
    returning
      value(R_USE_MSG_VIEWER) type N1GUI_APPL_USE_MSG_VIEWER .
  methods SET_APPLICATION
    importing
      !IR_APPLICATION type ref to IF_ISH_GUI_APPLICATION
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_T_EXCLFUNC
    importing
      !IT_EXCLFUNC type SYUCOMM_T
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_USE_MSG_VIEWER
    importing
      !I_USE_MSG_VIEWER type N1GUI_APPL_USE_MSG_VIEWER
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
  methods NEW_CONFIG_CTR
    redefinition .
  methods SAVE
    redefinition .
protected section.
*"* protected components of class CL_ISH_GUI_APPL_LAYOUT
*"* do not include other source files here!!!

  methods _GET_CB_STRUCTURE_MODEL
    redefinition .
  methods _GET_RELID
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_APPL_LAYOUT
*"* do not include other source files here!!!

  data GR_APPLICATION type ref to IF_ISH_GUI_APPLICATION .
  data GT_EXCLFUNC type SYUCOMM_T .
  data G_USE_MSG_VIEWER type N1GUI_APPL_USE_MSG_VIEWER .
ENDCLASS.



CLASS CL_ISH_GUI_APPL_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name  = i_element_name
      i_layout_name   = i_layout_name ).

  g_use_msg_viewer  = i_use_msg_viewer.
  gt_exclfunc       = it_exclfunc.

ENDMETHOD.


METHOD get_application.

  rr_application = gr_application.

ENDMETHOD.


METHOD get_copy.

  DATA lr_copy            TYPE REF TO cl_ish_gui_appl_layout.

* Call the super method.
  rr_copy = super->get_copy( ).

* Disconnect from the application.
  TRY.
      lr_copy ?= rr_copy.
      CLEAR lr_copy->gr_application.
    CATCH cx_sy_move_cast_error.                        "#EC NO_HANDLER
  ENDTRY.

ENDMETHOD.


METHOD get_t_exclfunc.

  rt_exclfunc = gt_exclfunc.

ENDMETHOD.


METHOD get_use_msg_viewer.

  r_use_msg_viewer = g_use_msg_viewer.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA l_rc                   TYPE ish_method_rc.

* Get the field content.
  CASE i_fieldname.
    WHEN co_fieldname_r_application.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = gr_application
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN co_fieldname_t_exclfunc.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = gt_exclfunc
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN co_fieldname_use_msg_viewer.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source = g_use_msg_viewer
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = c_content.
    WHEN OTHERS.
      CALL METHOD super->if_ish_gui_structure_model~get_field_content
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
        i_mv3        = 'CL_ISH_GUI_APPL_LAYOUT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  rt_supported_fieldname = super->if_ish_gui_structure_model~get_supported_fields( ).

  INSERT co_fieldname_r_application         INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_t_exclfunc            INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_use_msg_viewer        INTO TABLE rt_supported_fieldname.

ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.

  DATA lr_cb                        TYPE REF TO if_ish_gui_cb_structure_model.
  DATA lt_changed_field             TYPE ish_t_fieldname.
  DATA l_rc                         TYPE ish_method_rc.

* Callback.
  lr_cb = _get_cb_structure_model( ).
  IF lr_cb IS BOUND.
    CHECK lr_cb->cb_set_field_content(
        ir_model    = me
        i_fieldname = i_fieldname
        i_content   = i_content ) = abap_true.
  ENDIF.

* Set field content.
  CASE i_fieldname.
    WHEN co_fieldname_r_application.
      IF gr_application IS BOUND.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = 'SET_FIELD_CONTENT'
            i_mv3        = 'CL_ISH_GUI_APPL_LAYOUT' ).
      ENDIF.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source  = i_content
        IMPORTING
          e_changed = r_changed
          e_rc      = l_rc
        CHANGING
          c_target  = gr_application.
    WHEN co_fieldname_t_exclfunc.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source  = i_content
        IMPORTING
          e_changed = r_changed
          e_rc      = l_rc
        CHANGING
          c_target  = gt_exclfunc.
    WHEN co_fieldname_use_msg_viewer.
      CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
        EXPORTING
          i_source  = i_content
        IMPORTING
          e_changed = r_changed
          e_rc      = l_rc
        CHANGING
          c_target  = g_use_msg_viewer.
    WHEN OTHERS.
      r_changed = super->if_ish_gui_structure_model~set_field_content(
          i_fieldname = i_fieldname
          i_content   = i_content ).
      RETURN.
  ENDCASE.

* Errorhandling.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'SET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_GUI_APPL_LAYOUT' ).
  ENDIF.

* Further processing only on changes.
  CHECK r_changed = abap_true.

* Raise event ev_changed.
  INSERT i_fieldname INTO TABLE lt_changed_field.
  RAISE EVENT ev_changed
    EXPORTING
      et_changed_field = lt_changed_field.

ENDMETHOD.


METHOD new_config_ctr.

  DATA lr_parent_view                   TYPE REF TO if_ish_gui_dynpro_view.
  DATA lr_config_ctr                    TYPE REF TO cl_ish_gc_simple.
  DATA lr_config_view                   TYPE REF TO cl_ish_gv_sdy_simple.

* The parent controller has to be specified.
  IF ir_parent_controller IS NOT BOUND.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'NEW_CONFIG_CTR'
        i_mv3        = 'CL_ISH_GUI_APPL_LAYOUT' ).
  ENDIF.

* Get the parent view.
  TRY.
      lr_parent_view ?= ir_parent_controller->get_view( ).
    CATCH cx_sy_move_cast_error.
      CLEAR lr_parent_view.
  ENDTRY.

* Create and initialize the config ctr + view.
  lr_config_ctr = cl_ish_gc_simple=>create(
      i_element_name = i_ctrname ).
  lr_config_view = cl_ish_gv_sdy_simple=>create(
      i_element_name = i_viewname ).
  lr_config_ctr->initialize(
      ir_parent_controller  = ir_parent_controller
      ir_model              = me
      ir_view               = lr_config_view
      i_vcode               = i_vcode ).
  lr_config_view->initialize(
      ir_controller     = lr_config_ctr
      ir_parent_view    = lr_parent_view
      ir_layout         = ir_layout
      i_vcode           = i_vcode
      i_repid           = 'SAPLN1_GUI_SDY_LAYO_APPL'
      i_dynnr           = '0100'
      i_dynpstruct_name = 'RN1_GUI_DYNP_LAYO_APPL'
      it_dynplay_vcode  = it_layout_vcode ).

* Export
  rr_config_ctr = lr_config_ctr.

ENDMETHOD.


METHOD save.

  DATA lr_application                     TYPE REF TO if_ish_gui_application.

* Avoid serializing the application.
  lr_application = gr_application.
  CLEAR gr_application.

* Call the super method to save the layout.
  TRY.
      super->save(
          i_username     = i_username
          i_internal_key = i_internal_key
          i_erdat        = i_erdat
          i_ertim        = i_ertim
          i_erusr        = i_erusr ).
    CLEANUP.
      gr_application = lr_application.
  ENDTRY.

* Reset the application.
  gr_application = lr_application.

ENDMETHOD.


METHOD set_application.

  CHECK ir_application <> gr_application.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_r_application
      i_content   = ir_application ).

ENDMETHOD.


METHOD set_t_exclfunc.

  CHECK it_exclfunc <> gt_exclfunc.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_t_exclfunc
      i_content   = it_exclfunc ).

ENDMETHOD.


METHOD set_use_msg_viewer.

  CHECK i_use_msg_viewer <> g_use_msg_viewer.

  r_changed = set_field_content(
      i_fieldname = co_fieldname_use_msg_viewer
      i_content   = i_use_msg_viewer ).

ENDMETHOD.


METHOD _get_cb_structure_model.

  TRY.
      rr_cb_structure_model ?= gr_application.
    CATCH cx_sy_move_cast_error.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD _get_relid.

  r_relid = co_relid_application.

ENDMETHOD.
ENDCLASS.
