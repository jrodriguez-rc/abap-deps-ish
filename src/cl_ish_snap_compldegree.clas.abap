class CL_ISH_SNAP_COMPLDEGREE definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create protected

  global friends CL_ISH_COMPLDEGREE .

*"* public components of class CL_ISH_SNAP_COMPLDEGREE
*"* do not include other source files here!!!
public section.
protected section.
*"* protected components of class CL_ISH_SNAP_COMPLDEGREE
*"* do not include other source files here!!!

  data GS_N1COMPLDEGREE_ORIG type N1COMPLDEGREE .
  type-pools ABAP .
  data G_DELETIONMARK type ABAP_BOOL .
  data G_LOCKED type ABAP_BOOL .
  data G_NAME type N1MONCON_NAME .
  data G_NAME_ORIG type N1MONCON_NAME .
  data G_NEW type ABAP_BOOL .
private section.
*"* private components of class CL_ISH_SNAP_COMPLDEGREE
*"* do not include other source files here!!!

  data GS_N1COMPLDEGREE type N1COMPLDEGREE .
ENDCLASS.



CLASS CL_ISH_SNAP_COMPLDEGREE IMPLEMENTATION.
ENDCLASS.
