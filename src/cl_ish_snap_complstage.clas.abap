class CL_ISH_SNAP_COMPLSTAGE definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create protected

  global friends CL_ISH_COMPLSTAGE .

*"* public components of class CL_ISH_SNAP_COMPLSTAGE
*"* do not include other source files here!!!
public section.
protected section.
*"* protected components of class CL_ISH_SNAP_COMPLSTAGE
*"* do not include other source files here!!!

  data GS_DATA type RN1COMPLSTAGE_DATA .
  data GS_DATA_ORIG type RN1COMPLSTAGE_DATA .
  type-pools ABAP .
  data G_DELETIONMARK type ABAP_BOOL .
  data G_NEW type ABAP_BOOL .
private section.
*"* private components of class CL_ISH_SNAP_COMPLSTAGE
*"* do not include other source files here!!!

  data GR_MONCON type ref to CL_ISH_MONCON .
  data G_ID type N1MONCON_ID .
ENDCLASS.



CLASS CL_ISH_SNAP_COMPLSTAGE IMPLEMENTATION.
ENDCLASS.
