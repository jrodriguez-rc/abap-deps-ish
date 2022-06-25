class CL_ISH_SNAP_PREREG_PROC definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create public

  global friends CL_ISH_PREREG_PROCEDURE .

*"* public components of class CL_ISH_SNAP_PREREG_PROC
*"* do not include other source files here!!!
public section.
protected section.
*"* protected components of class CL_ISH_SNAP_WAITING_LIST_ABS
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SNAP_PREREG_PROC
*"* do not include other source files here!!!

  data G_NPCP type NPCP .
ENDCLASS.



CLASS CL_ISH_SNAP_PREREG_PROC IMPLEMENTATION.
ENDCLASS.
