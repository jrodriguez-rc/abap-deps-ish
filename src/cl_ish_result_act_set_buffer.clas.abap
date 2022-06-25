class CL_ISH_RESULT_ACT_SET_BUFFER definition
  public
  inheriting from CL_ISH_RESULT
  create public .

public section.
*"* public components of class CL_ISH_RESULT_ACT_SET_BUFFER
*"* do not include other source files here!!!

  type-pools ABAP .
  methods SET_CONTENT_BOOLEAN
    importing
      value(I_NAME) type N1CONTENTNAME
      value(I_CONTENT) type ABAP_BOOL
      value(I_REPLACE) type ABAP_BOOL default ABAP_TRUE
    returning
      value(R_CONTENT_SET) type ABAP_BOOL .
  methods GET_CONTENT_BOOLEAN
    importing
      value(I_NAME) type N1CONTENTNAME
    exporting
      value(E_NOT_FOUND) type ABAP_BOOL
    changing
      value(C_CONTENT) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_RESULT_ACT_SET_BUFFER
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_RESULT_ACT_SET_BUFFER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_RESULT_ACT_SET_BUFFER IMPLEMENTATION.


METHOD GET_CONTENT_BOOLEAN.
  DATA l_rc                             TYPE ish_method_rc.

  FIELD-SYMBOLS <ls_named_content>      LIKE LINE OF gt_named_content.
  FIELD-SYMBOLS <l_content>             TYPE any.
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
  ENDIF.
  IF <l_content> IS ASSIGNED.
    c_content = <l_content>.
  ELSE.
    e_not_found = abap_true.
  ENDIF.
ENDMETHOD.


METHOD SET_CONTENT_BOOLEAN.

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

  CLEAR <ls_named_content>-r_obj.
  CREATE DATA <ls_named_content>-r_data LIKE i_content.
  ASSIGN <ls_named_content>-r_data->* TO <l_data>.
  <l_data> = i_content.

  r_content_set = abap_true.
ENDMETHOD.
ENDCLASS.
