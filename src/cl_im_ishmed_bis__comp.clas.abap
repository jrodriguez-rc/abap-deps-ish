class CL_IM_ISHMED_BIS__COMP definition
  public
  final
  create public .

*"* public components of class CL_IM_ISHMED_BIS__COMP
*"* do not include other source files here!!!
public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ISHMED_BASEITEM_DEF .
protected section.
*"* protected components of class CL_IM_ISHMED_BIS__COMP
*"* do not include other source files here!!!
private section.
*"* private components of class CL_IM_ISHMED_BIS__COMP
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_IM_ISHMED_BIS__COMP IMPLEMENTATION.


METHOD if_ex_ishmed_baseitem_def~get_instance_baseitem.

  DATA lx_baseitems     TYPE REF TO cx_ishmed_baseitems.
*----------------------------------------------------------
  TRY.
      r_baseitem_manager = cl_ishmed_baseitems_manager=>get_instance( ).

    CATCH cx_ishmed_baseitems INTO lx_baseitems.
      RAISE EXCEPTION TYPE cx_ishmed_baseitem_screen
        EXPORTING
          previous = lx_baseitems.
  ENDTRY.

ENDMETHOD.
ENDCLASS.
