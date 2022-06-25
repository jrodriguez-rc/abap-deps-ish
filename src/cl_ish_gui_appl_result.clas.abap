class CL_ISH_GUI_APPL_RESULT definition
  public
  inheriting from CL_ISH_RESULT
  create public .

public section.
*"* public components of class CL_ISH_GUI_APPL_RESULT
*"* do not include other source files here!!!

  constants CO_CONTENTNAME_LAST_UCOMM type N1CONTENTNAME value 'LAST_UCOMM'. "#EC NOTEXT
  constants CO_CONTENTNAME_SAVED type N1CONTENTNAME value 'SAVED'. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !I_RC type ISH_METHOD_RC optional
      !IR_MESSAGES type ref to CL_ISHMED_ERRORHANDLING optional
      !I_LAST_UCOMM type SYUCOMM optional .
  methods GET_LAST_UCOMM
  final
    returning
      value(R_LAST_UCOMM) type SYUCOMM .
  type-pools ABAP .
  methods GET_SAVED
    returning
      value(R_SAVED) type ABAP_BOOL .
  methods SET_LAST_UCOMM
    importing
      !I_LAST_UCOMM type SYUCOMM .
  methods SET_SAVED
    importing
      !I_SAVED type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GUI_APPL_RESULT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_APPL_RESULT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_APPL_RESULT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_rc        = i_rc
      ir_messages = ir_messages ).

  IF i_last_ucomm IS NOT INITIAL.
    set_last_ucomm( i_last_ucomm ).
  ENDIF.

ENDMETHOD.


METHOD get_last_ucomm.

  TRY.
      CALL METHOD get_content
        EXPORTING
          i_name    = co_contentname_last_ucomm
        CHANGING
          c_content = r_last_ucomm.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD get_saved.

  TRY.
      CALL METHOD get_content
        EXPORTING
          i_name    = co_contentname_saved
        CHANGING
          c_content = r_saved.
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD set_last_ucomm.

  DATA l_content_last_ucomm               TYPE syucomm.

  l_content_last_ucomm = get_last_ucomm( ).

  TRY.
      set_content(
          i_name    = co_contentname_last_ucomm
          i_content = i_last_ucomm
          i_replace = abap_true ).
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.


METHOD set_saved.

  DATA l_content_saved                TYPE abap_bool.

  l_content_saved = get_saved( ).

  TRY.
      set_content(
          i_name    = co_contentname_saved
          i_content = i_saved
          i_replace = abap_true ).
    CATCH cx_ish_static_handler.
      RETURN.
  ENDTRY.

ENDMETHOD.
ENDCLASS.
