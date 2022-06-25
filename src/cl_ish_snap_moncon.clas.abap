class CL_ISH_SNAP_MONCON definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create protected

  global friends CL_ISH_MONCON .

*"* public components of class CL_ISH_SNAP_MONCON
*"* do not include other source files here!!!
public section.
protected section.
*"* protected components of class CL_ISH_SNAP_MONCON
*"* do not include other source files here!!!

  data GT_COMPLSTAGE type ISH_T_COMPLSTAGE_OBJ .
  type-pools ABAP .
  data G_COMPLSTAGES_LOADED type ABAP_BOOL .
  data G_DELETIONMARK type ABAP_BOOL .
  data G_LOCKED type ABAP_BOOL .
  data G_NAME type N1MONCON_NAME .
  data G_NAME_ORIG type N1MONCON_NAME .
  data G_NEW type ABAP_BOOL .
private section.
*"* private components of class CL_ISH_SNAP_MONCON
*"* do not include other source files here!!!

  data GR_AREA type ref to CL_ISH_MONCON_AREA .
  data G_ID type N1MONCON_ID .
  data G_TIMESTAMP type TIMESTAMPL .
ENDCLASS.



CLASS CL_ISH_SNAP_MONCON IMPLEMENTATION.
ENDCLASS.
