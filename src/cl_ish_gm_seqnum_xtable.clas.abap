class CL_ISH_GM_SEQNUM_XTABLE definition
  public
  inheriting from CL_ISH_GM_SORTED_XTABLE
  create public .

public section.
*"* public components of class CL_ISH_GM_SEQNUM_XTABLE
*"* do not include other source files here!!!

  methods GET_HIGHEST_SEQNUM
    returning
      value(R_HIGHEST_SEQNUM) type N1_SEQNUM .
  methods RECALCULATE_SEQNUMS
    returning
      value(RT_CHANGED_ENTRY) type ISH_T_GUI_MODEL_OBJHASH
    raising
      CX_ISH_STATIC_HANDLER .
protected section.
*"* protected components of class CL_ISH_GM_SEQNUM_XTABLE
*"* do not include other source files here!!!

  methods _CHECK_ADD_ENTRY
    redefinition .
private section.
*"* private components of class CL_ISH_GM_SEQNUM_XTABLE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GM_SEQNUM_XTABLE IMPLEMENTATION.


method GET_HIGHEST_SEQNUM.

* get the highest number

endmethod.


method RECALCULATE_SEQNUMS.


* change it

endmethod.


METHOD _check_add_entry.

  TRY.

      CALL METHOD super->_check_add_entry
        EXPORTING
          ir_entry = ir_entry.

    CATCH cx_ish_static_handler .
  ENDTRY.

ENDMETHOD.
ENDCLASS.
