class CL_ISH_GM_ITERATOR definition
  public
  create public .

public section.
*"* public components of class CL_ISH_GM_ITERATOR
*"* do not include other source files here!!!

  interfaces IF_ISH_GM_ITERATOR .

  aliases HAS_NEXT
    for IF_ISH_GM_ITERATOR~HAS_NEXT .
  aliases NEXT
    for IF_ISH_GM_ITERATOR~NEXT .

  methods CONSTRUCTOR
    importing
      !IR_TBL_MODEL type ref to IF_ISH_GUI_TABLE_MODEL .
protected section.
*"* protected components of class CL_ISH_GM_ITERATOR
*"* do not include other source files here!!!

  data GR_TBL_MODEL type ref to IF_ISH_GUI_TABLE_MODEL .
  data G_POSITION type I .
private section.
*"* private components of class CL_ISH_GM_ITERATOR
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_ITERATOR IMPLEMENTATION.


method CONSTRUCTOR.

  gr_tbl_model = ir_tbl_model.

endmethod.


method IF_ISH_GM_ITERATOR~HAS_NEXT.

  DATA: lt_entry      TYPE ish_t_gui_model_objhash.

  CHECK gr_tbl_model IS BOUND.

  TRY.
    lt_entry = gr_tbl_model->get_entries( ).
  CATCH cx_root.
    CLEAR lt_entry.
  ENDTRY.

  CHECK g_position < LINES( lt_entry ).

  r_has_next = abap_true.

endmethod.


method IF_ISH_GM_ITERATOR~NEXT.

  DATA: lt_entry      TYPE ish_t_gui_model_obj.

  CHECK gr_tbl_model IS BOUND.

  IF has_next( ) = abap_false.
    RAISE EXCEPTION TYPE cx_ishmed_illegal_position.
  ENDIF.

  TRY.
    lt_entry = gr_tbl_model->get_entries( ).
  CATCH cx_root.
    CLEAR lt_entry.
  ENDTRY.

  g_position = g_position + 1.

  READ TABLE lt_entry INDEX g_position INTO rr_model.

endmethod.
ENDCLASS.
