class CL_ISH_SNAP_PREREG_DIAG definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create public

  global friends CL_ISH_PREREG_DIAGNOSIS .

*"* public components of class CL_ISH_SNAP_PREREG_DIAG
*"* do not include other source files here!!!
public section.

  data GT_TEXTMODULE type ISH_T_TEXTMOD_USE_SNAP .
protected section.
*"* protected components of class CL_ISH_SNAP_WAITING_LIST_ABS
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SNAP_PREREG_DIAG
*"* do not include other source files here!!!

  data G_NDIP type NDIP .
ENDCLASS.



CLASS CL_ISH_SNAP_PREREG_DIAG IMPLEMENTATION.
ENDCLASS.
