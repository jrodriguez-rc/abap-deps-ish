class CL_ISH_SNAP_ADDRESS definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create public

  global friends CL_ISH_ADDRESS .

*"* public components of class CL_ISH_SNAP_ADDRESS
*"* do not include other source files here!!!
public section.
protected section.
*"* protected components of class CL_ISH_SNAP_WAITING_LIST_ABS
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SNAP_ADDRESS
*"* do not include other source files here!!!

  data G_NADR type NADR .
  data GT_NADR2 type ISH_T_NADR2 .
ENDCLASS.



CLASS CL_ISH_SNAP_ADDRESS IMPLEMENTATION.
ENDCLASS.
