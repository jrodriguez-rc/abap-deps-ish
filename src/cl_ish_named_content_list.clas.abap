class CL_ISH_NAMED_CONTENT_LIST definition
  public
  create public .

*"* public components of class CL_ISH_NAMED_CONTENT_LIST
*"* do not include other source files here!!!
public section.

  methods CLEAR .
  type-pools ABAP .
  methods GET_CONTENT
    importing
      !I_NAME type N1CONTENTNAME
    exporting
      !E_NOT_FOUND type ABAP_BOOL
    changing
      !C_CONTENT type ANY
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_CONTENT_NAMES
    returning
      value(RT_CONTENT_NAME) type ISH_T_CONTENTNAME_HASH .
  methods GET_NAMED_CONTENTS
    returning
      value(RT_NAMED_CONTENT) type ISH_T_NAMED_CONTENT_HASH .
  methods HAS_CONTENT
    importing
      !I_NAME type N1CONTENTNAME
    returning
      value(R_HAS_CONTENT) type ABAP_BOOL .
  methods REMOVE_CONTENT
    importing
      !I_NAME type N1CONTENTNAME
    returning
      value(R_REMOVED) type ABAP_BOOL .
  methods SET_CONTENT
    importing
      !I_NAME type N1CONTENTNAME
      !I_CONTENT type ANY
      !I_REPLACE type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_CONTENT_SET) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_NAMED_CONTENT_LIST
*"* do not include other source files here!!!

  data GT_NAMED_CONTENT type ISH_T_NAMED_CONTENT_HASH .
private section.
*"* private components of class CL_ISH_NAMED_CONTENT_LIST
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_NAMED_CONTENT_LIST IMPLEMENTATION.


METHOD clear.

  CLEAR gt_named_content.

ENDMETHOD.


METHOD get_content.

  DATA l_rc                             TYPE ish_method_rc.

  FIELD-SYMBOLS <ls_named_content>      LIKE LINE OF gt_named_content.
  FIELD-SYMBOLS <l_content>             TYPE ANY.
  FIELD-SYMBOLS <l_data>                TYPE data.

  READ TABLE gt_named_content
    WITH TABLE KEY name = i_name
    ASSIGNING <ls_named_content>.
  IF sy-subrc <> 0.
    CLEAR c_content.
    e_not_found = abap_true.
    RETURN.
  ENDIF.

  IF <ls_named_content>-r_data IS BOUND.
    ASSIGN <ls_named_content>-r_data->* TO <l_content>.
  ELSE.
    ASSIGN <ls_named_content>-r_obj TO <l_content>.
  ENDIF.
  CALL METHOD cl_ish_utl_rtti=>assign_content
    EXPORTING
      i_source = <l_content>
    IMPORTING
      e_rc     = l_rc
    CHANGING
      c_target = c_content.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_CONTENT'
        i_mv3        = 'CL_ISH_NAMED_CONTENT_LIST' ).
  ENDIF.

ENDMETHOD.


METHOD get_content_names.

  FIELD-SYMBOLS <ls_named_content>      LIKE LINE OF gt_named_content.

  LOOP AT gt_named_content ASSIGNING <ls_named_content>.
    INSERT <ls_named_content>-name INTO TABLE rt_content_name.
  ENDLOOP.

ENDMETHOD.


METHOD get_named_contents.

  rt_named_content = gt_named_content.

ENDMETHOD.


METHOD has_content.

  READ TABLE gt_named_content
    WITH TABLE KEY name = i_name
    TRANSPORTING NO FIELDS.
  CHECK sy-subrc = 0.

  r_has_content = abap_true.

ENDMETHOD.


METHOD remove_content.

  DELETE TABLE gt_named_content
    WITH TABLE KEY name = i_name.
  CHECK sy-subrc = 0.

  r_removed = abap_true.

ENDMETHOD.


METHOD set_content.

  DATA ls_named_content                 LIKE LINE OF gt_named_content.
  DATA lr_typedescr                     TYPE REF TO cl_abap_typedescr.

  FIELD-SYMBOLS <ls_named_content>      LIKE LINE OF gt_named_content.
  FIELD-SYMBOLS <l_data>                TYPE data.

  READ TABLE gt_named_content
    WITH TABLE KEY name = i_name
    ASSIGNING <ls_named_content>.
  IF sy-subrc = 0.
    CHECK i_replace = abap_true.
  ELSE.
    ls_named_content-name = i_name.
    INSERT ls_named_content INTO TABLE gt_named_content.
    READ TABLE gt_named_content
      WITH TABLE KEY name = i_name
      ASSIGNING <ls_named_content>.
  ENDIF.

  lr_typedescr = cl_abap_typedescr=>describe_by_data( i_content ).
  IF lr_typedescr->type_kind = lr_typedescr->typekind_oref.
    CLEAR <ls_named_content>-r_data.
    <ls_named_content>-r_obj = i_content.
  ELSE.
    CLEAR <ls_named_content>-r_obj.
    CREATE DATA <ls_named_content>-r_data LIKE i_content.
    ASSIGN <ls_named_content>-r_data->* TO <l_data>.
    <l_data> = i_content.
  ENDIF.

  r_content_set = abap_true.

ENDMETHOD.
ENDCLASS.
