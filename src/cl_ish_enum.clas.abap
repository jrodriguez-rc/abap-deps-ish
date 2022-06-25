class CL_ISH_ENUM definition
  public
  create protected .

public section.
*"* public components of class CL_ISH_ENUM
*"* do not include other source files here!!!

  type-pools ABAP .
  class-methods GET_INSTANCE_BY_DOMNAME
    importing
      !I_DOMNAME type DOMNAME
      !I_LOAD type ABAP_BOOL default ABAP_TRUE
    returning
      value(RR_INSTANCE) type ref to CL_ISH_ENUM
    raising
      CX_ISH_STATIC_HANDLER .
  methods AS_DRAL_VALUES
    importing
      !I_SORT type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_DRAL_VALUE) type ISH_T_GUI_DRAL_VALUES .
  type-pools VRM .
  methods AS_VRM_VALUES
    importing
      !I_SORT type ABAP_BOOL default ABAP_TRUE
    returning
      value(RT_VRM_VALUE) type VRM_VALUES .
  methods CONSTRUCTOR
    importing
      !I_NAME type DOMNAME
      !IT_IDTEXT type ISH_T_ENUM_IDTEXT_H
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DRAL_HANDLE
  final
    returning
      value(R_DRAL_HANDLE) type INT4 .
  methods GET_ID_BY_TEXT
    importing
      !I_TEXT type VAL_TEXT
    returning
      value(R_ID) type DOMVALUE_L
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_NAME
  final
    returning
      value(R_NAME) type DOMNAME .
  methods GET_TEXT_BY_ID
    importing
      !I_ID type DATA
    returning
      value(R_TEXT) type VAL_TEXT
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_T_DATA
    returning
      value(RT_DATA) type ISH_T_ENUM_IDTEXT_H .
protected section.
*"* protected components of class CL_ISH_ENUM
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_ENUM
*"* do not include other source files here!!!

  class-data GT_INSTANCE_DOMAIN type ISH_T_ENUM_OBJIDH .
  class-data G_NEXT_DRAL_HANDLE type INT4 value 1. "#EC NOTEXT .
  data GT_IDTEXT type ISH_T_ENUM_IDTEXT_H .
  data GT_TEXTID type ISH_T_ENUM_TEXTID_H .
  data G_DRAL_HANDLE type INT4 .
  data G_NAME type DOMNAME .
ENDCLASS.



CLASS CL_ISH_ENUM IMPLEMENTATION.


METHOD as_dral_values.

  DATA ls_dral_value            TYPE rn1_gui_dral_values.

  FIELD-SYMBOLS <ls_data>     TYPE rn1_enum_data.

  LOOP AT gt_idtext ASSIGNING <ls_data>.
    ls_dral_value-dral_key    = <ls_data>-id.
    ls_dral_value-dral_value  = <ls_data>-text.
    INSERT ls_dral_value INTO TABLE rt_dral_value.
  ENDLOOP.

  IF i_sort = abap_true.
    SORT rt_dral_value BY dral_value.
  ENDIF.

ENDMETHOD.


METHOD as_vrm_values.

  DATA ls_vrm_value           TYPE vrm_value.

  FIELD-SYMBOLS <ls_data>     TYPE rn1_enum_data.

  LOOP AT gt_idtext ASSIGNING <ls_data>.
    ls_vrm_value-key  = <ls_data>-id.
    ls_vrm_value-text = <ls_data>-text.
    INSERT ls_vrm_value INTO TABLE rt_vrm_value.
  ENDLOOP.

  IF i_sort = abap_true.
    SORT rt_vrm_value BY text.
  ENDIF.

ENDMETHOD.


METHOD constructor.

  DATA ls_data            TYPE rn1_enum_data.

  IF i_name IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_ENUM' ).
  ENDIF.

  g_name = i_name.

  LOOP AT it_idtext INTO ls_data.
    READ TABLE gt_textid
      WITH TABLE KEY text = ls_data-text
      TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      ls_data-text = ls_data-id.
    ENDIF.
    INSERT ls_data INTO TABLE gt_idtext.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'CONSTRUCTOR'
          i_mv3        = 'CL_ISH_ENUM' ).
    ENDIF.
    INSERT ls_data INTO TABLE gt_textid.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '3'
          i_mv2        = 'CONSTRUCTOR'
          i_mv3        = 'CL_ISH_ENUM' ).
    ENDIF.
  ENDLOOP.

  g_dral_handle = g_next_dral_handle.

  g_next_dral_handle = g_next_dral_handle + 1.

ENDMETHOD.


METHOD get_dral_handle.

  r_dral_handle = g_dral_handle.

ENDMETHOD.


METHOD get_id_by_text.

  FIELD-SYMBOLS <ls_data>           TYPE rn1_enum_data.

  READ TABLE gt_textid
    WITH TABLE KEY text = i_text
    ASSIGNING <ls_data>.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_ID_BY_TEXT'
        i_mv3        = 'CL_ISH_ENUM' ).
  ENDIF.

  r_id = <ls_data>-id.

ENDMETHOD.


METHOD get_instance_by_domname.

  DATA lt_dd07v                                 TYPE TABLE OF dd07v.
  DATA ls_data                                  TYPE rn1_enum_data.
  DATA lt_idtext                                TYPE ish_t_enum_idtext_h.
  DATA ls_instance_domain                       LIKE LINE OF gt_instance_domain.

  FIELD-SYMBOLS <ls_instance_domain>            LIKE LINE OF gt_instance_domain.
  FIELD-SYMBOLS <ls_dd07v>                      TYPE dd07v.

  READ TABLE gt_instance_domain
    WITH TABLE KEY id = i_domname
    ASSIGNING <ls_instance_domain>.
  IF sy-subrc = 0.
    rr_instance = <ls_instance_domain>-r_obj.
    RETURN.
  ENDIF.

  CHECK i_load = abap_true.

  lt_dd07v = cl_ish_utl_rtti=>get_values_of_domain( i_domname ).
  CALL FUNCTION 'DD_DOMVALUES_GET'
    EXPORTING
      domname   = i_domname
      text      = abap_true
    TABLES
      dd07v_tab = lt_dd07v
    EXCEPTIONS
      OTHERS    = 1.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_INSTANCE_BY_DOMNAME'
        i_mv3        = 'CL_ISH_ENUM' ).
  ENDIF.

  LOOP AT lt_dd07v ASSIGNING <ls_dd07v>.
    ls_data-id = <ls_dd07v>-domvalue_l.
    IF <ls_dd07v>-ddtext IS INITIAL.
      ls_data-text = ls_data-id.
    ELSE.
      ls_data-text  = <ls_dd07v>-ddtext.
    ENDIF.
    INSERT ls_data INTO TABLE lt_idtext.
    IF sy-subrc <> 0.
      cl_ish_utl_exception=>raise_static(
          i_typ        = 'E'
          i_kla        = 'N1BASE'
          i_num        = '030'
          i_mv1        = '2'
          i_mv2        = 'GET_INSTANCE_BY_DOMNAME'
          i_mv3        = 'CL_ISH_ENUM' ).
    ENDIF.
  ENDLOOP.

  CREATE OBJECT rr_instance
    EXPORTING
      i_name    = i_domname
      it_idtext = lt_idtext.

  ls_instance_domain-id     = i_domname.
  ls_instance_domain-r_obj  = rr_instance.
  INSERT ls_instance_domain INTO TABLE gt_instance_domain.

ENDMETHOD.


METHOD get_name.

  r_name = g_name.

ENDMETHOD.


METHOD get_text_by_id.

  DATA l_id                         TYPE domvalue_l.
  DATA l_rc                         TYPE ish_method_rc.

  FIELD-SYMBOLS <ls_data>           TYPE rn1_enum_data.

  CALL METHOD cl_ish_utl_rtti=>assign_content
    EXPORTING
      i_source = i_id
    IMPORTING
      e_rc     = l_rc
    CHANGING
      c_target = l_id.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_TEXT_BY_ID'
        i_mv3        = 'CL_ISH_ENUM' ).
  ENDIF.

  READ TABLE gt_idtext
    WITH TABLE KEY id = l_id
    ASSIGNING <ls_data>.
  IF sy-subrc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '2'
        i_mv2        = 'GET_TEXT_BY_ID'
        i_mv3        = 'CL_ISH_ENUM' ).
  ENDIF.

  r_text = <ls_data>-text.

ENDMETHOD.


METHOD get_t_data.

  rt_data = gt_idtext.

ENDMETHOD.
ENDCLASS.
