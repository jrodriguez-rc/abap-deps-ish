class CL_ISH_UTL_GUI_TABLE_MODEL definition
  public
  abstract
  final
  create public .

public section.
*"* public components of class CL_ISH_UTL_GUI_TABLE_MODEL
*"* do not include other source files here!!!

  class-methods GET_ALL_CHILD_MODELS
    importing
      !IR_TABLE_MODEL type ref to IF_ISH_GUI_TABLE_MODEL
    returning
      value(RT_CHILD_MODEL) type ISH_T_GUI_MODEL_OBJHASH
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_UTL_GUI_TABLE_MODEL
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_GUI_TABLE_MODEL
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_GUI_TABLE_MODEL IMPLEMENTATION.


METHOD get_all_child_models.

  DATA lt_child_model           TYPE ish_t_gui_model_objhash.
  DATA lr_child_model           TYPE REF TO if_ish_gui_model.
  DATA lr_child_tabmdl          TYPE REF TO if_ish_gui_table_model.
  DATA lt_tmp_model             TYPE ish_t_gui_model_objhash.
  DATA lr_tmp_model             TYPE REF TO if_ish_gui_model.

  CHECK ir_table_model IS BOUND.

  lt_child_model = ir_table_model->get_entries( ).
  LOOP AT lt_child_model INTO lr_child_model.
    CHECK lr_child_model IS BOUND.
    INSERT lr_child_model INTO TABLE rt_child_model.
    TRY.
        lr_child_tabmdl ?= lr_child_model.
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    lt_tmp_model = get_all_child_models( ir_table_model = lr_child_tabmdl ).
    LOOP AT lt_tmp_model INTO lr_tmp_model.
      CHECK lr_tmp_model IS BOUND.
      INSERT lr_tmp_model INTO TABLE rt_child_model.
    ENDLOOP.
  ENDLOOP.

ENDMETHOD.
ENDCLASS.
