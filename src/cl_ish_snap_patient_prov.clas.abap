class CL_ISH_SNAP_PATIENT_PROV definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create public

  global friends CL_ISH_PATIENT_PROVISIONAL .

*"* public components of class CL_ISH_SNAP_PATIENT_PROV
*"* do not include other source files here!!!
public section.
protected section.
*"* protected components of class CL_ISH_SNAP_WAITING_LIST_ABS
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SNAP_PATIENT_PROV
*"* do not include other source files here!!!

  data G_KEY_SNAPSHOT_ADDRESS type ISH_SNAPKEY .
  data G_NPAP type NPAP .
  data G_GSCHLE type GSCHLE .
  data G_ANRDE type RI_ANRDE .
ENDCLASS.



CLASS CL_ISH_SNAP_PATIENT_PROV IMPLEMENTATION.
ENDCLASS.
