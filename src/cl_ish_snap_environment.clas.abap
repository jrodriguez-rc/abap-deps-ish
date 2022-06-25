class CL_ISH_SNAP_ENVIRONMENT definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create public

  global friends CL_ISH_ENVIRONMENT .

*"* public components of class CL_ISH_SNAP_ENVIRONMENT
*"* do not include other source files here!!!
public section.
protected section.
*"* protected components of class CL_ISH_SNAP_WAITING_LIST_ABS
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SNAP_ENVIRONMENT
*"* do not include other source files here!!!

  data GT_ENVIRONMENT_SNAPSHOT type ISH_T_ENVIRONMENT_SNAPSHOT .
ENDCLASS.



CLASS CL_ISH_SNAP_ENVIRONMENT IMPLEMENTATION.
ENDCLASS.
