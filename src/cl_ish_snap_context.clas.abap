class CL_ISH_SNAP_CONTEXT definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create public

  global friends CL_ISH_CONTEXT .

*"* public components of class CL_ISH_SNAP_CONTEXT
*"* do not include other source files here!!!
public section.
protected section.
*"* protected components of class CL_ISH_SNAP_WAITING_LIST_ABS
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SNAP_CONTEXT
*"* do not include other source files here!!!

  data G_NCTX type NCTX .
  data G_RELATIONS type RNCTX_T_RELATIONS .
ENDCLASS.



CLASS CL_ISH_SNAP_CONTEXT IMPLEMENTATION.
ENDCLASS.
