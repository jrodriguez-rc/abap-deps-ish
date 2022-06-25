class CL_ISH_RESULT definition
  public
  inheriting from CL_ISH_NAMED_CONTENT_LIST
  create public .

*"* public components of class CL_ISH_RESULT
*"* do not include other source files here!!!
public section.

  constants CO_CONTENTNAME_MESSAGES type N1CONTENTNAME value 'MESSAGES'. "#EC NOTEXT
  constants CO_CONTENTNAME_RC type N1CONTENTNAME value 'RC'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_RC type ISH_METHOD_RC optional
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_MESSAGES
    returning
      value(RR_MESSAGES) type ref to CL_ISHMED_ERRORHANDLING .
  methods GET_RC
    returning
      value(R_RC) type ISH_METHOD_RC .
  methods MERGE
    importing
      !IR_OTHER_RESULT type ref to CL_ISH_RESULT
    raising
      CX_ISH_STATIC_HANDLER .
  type-pools ABAP .
  methods SET_MESSAGES
    importing
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING
      !I_MERGE type ABAP_BOOL default ABAP_TRUE .
  methods SET_RC
    importing
      !I_RC type ISH_METHOD_RC
      !I_MERGE type ABAP_BOOL default ABAP_TRUE .

  methods SET_CONTENT
    redefinition .
protected section.
*"* protected components of class CL_ISH_RESULT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_RESULT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_RESULT IMPLEMENTATION.


METHOD constructor.

  super->constructor( ).

  IF i_rc IS NOT INITIAL.
    set_rc(
        i_rc    = i_rc
        i_merge = abap_false ).
  ENDIF.

  IF ir_messages IS BOUND.
    set_messages(
        ir_messages = ir_messages
        i_merge     = abap_false ).
  ENDIF.

ENDMETHOD.


METHOD get_messages.

  TRY.
      CALL METHOD get_content
        EXPORTING
          i_name    = co_contentname_messages
        CHANGING
          c_content = rr_messages.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_rc.

  TRY.
      CALL METHOD get_content
        EXPORTING
          i_name    = co_contentname_rc
        CHANGING
          c_content = r_rc.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD merge.

  DATA l_content_rc                       TYPE ish_method_rc.
  DATA lr_content_messages                TYPE REF TO cl_ishmed_errorhandling.

  FIELD-SYMBOLS <ls_named_content>        LIKE LINE OF gt_named_content.
  FIELD-SYMBOLS <l_data>                  TYPE data.

  CHECK ir_other_result IS BOUND.

  LOOP AT ir_other_result->gt_named_content ASSIGNING <ls_named_content>.
    CASE <ls_named_content>-name.
      WHEN co_contentname_rc.
        l_content_rc = ir_other_result->get_rc( ).
        set_rc(
            i_rc    = l_content_rc
            i_merge = abap_true ).
      WHEN co_contentname_messages.
        lr_content_messages = ir_other_result->get_messages( ).
        set_messages(
            ir_messages = lr_content_messages
            i_merge     = abap_true ).
      WHEN OTHERS.
        IF <ls_named_content>-r_data IS BOUND.
          ASSIGN <ls_named_content>-r_data->* TO <l_data>.
          set_content(
              i_name    = <ls_named_content>-name
              i_content = <l_data>
              i_replace = abap_false ).
        ELSE.
          set_content(
              i_name    = <ls_named_content>-name
              i_content = <ls_named_content>-r_obj
              i_replace = abap_false ).
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDMETHOD.


METHOD set_content.

  DATA l_content_rc           TYPE ish_method_rc.
  DATA lr_content_messages    TYPE REF TO cl_ishmed_errorhandling.
  DATA lr_typedescr           TYPE REF TO cl_abap_typedescr.
  DATA l_rc                   TYPE ish_method_rc.

  CASE i_name.
    WHEN co_contentname_rc.
      CALL METHOD cl_ish_utl_rtti=>assign_content
        EXPORTING
          i_source = i_content
        IMPORTING
          e_rc     = l_rc
        CHANGING
          c_target = l_content_rc.
      IF l_rc <> 0.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '1'
            i_mv2        = 'SET_CONTENT'
            i_mv3        = 'CL_ISH_RESULT' ).
      ENDIF.
    WHEN co_contentname_messages.
      lr_typedescr = cl_abap_typedescr=>describe_by_data( i_content ).
      IF lr_typedescr->type_kind <> cl_abap_typedescr=>typekind_oref.
        cl_ish_utl_exception=>raise_static(
            i_typ        = 'E'
            i_kla        = 'N1BASE'
            i_num        = '030'
            i_mv1        = '2'
            i_mv2        = 'SET_CONTENT'
            i_mv3        = 'CL_ISH_RESULT' ).
      ENDIF.
      TRY.
          lr_content_messages ?= i_content.
        CATCH cx_sy_move_cast_error.
          cl_ish_utl_exception=>raise_static(
              i_typ        = 'E'
              i_kla        = 'N1BASE'
              i_num        = '030'
              i_mv1        = '3'
              i_mv2        = 'SET_CONTENT'
              i_mv3        = 'CL_ISH_RESULT' ).
      ENDTRY.
  ENDCASE.

  r_content_set = super->set_content(
      i_name        = i_name
      i_content     = i_content
      i_replace     = i_replace ).

ENDMETHOD.


METHOD set_messages.

  DATA lr_content_messages              TYPE REF TO cl_ishmed_errorhandling.

  lr_content_messages = get_messages( ).

  IF i_merge = abap_false OR
     lr_content_messages IS NOT BOUND.
    TRY.
        set_content(
            i_name    = co_contentname_messages
            i_content = ir_messages
            i_replace = abap_true ).
      CATCH cx_ish_static_handler.
        RETURN.
    ENDTRY.
    RETURN.
  ENDIF.

  lr_content_messages->copy_messages( i_copy_from = ir_messages ).

ENDMETHOD.


METHOD set_rc.

  DATA l_content_rc             TYPE ish_method_rc.

  l_content_rc = get_rc( ).

  IF i_merge = abap_true.
    CHECK i_rc > l_content_rc.
  ENDIF.

  TRY.
      set_content(
          i_name    = co_contentname_rc
          i_content = i_rc
          i_replace = abap_true ).
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.
ENDCLASS.
