class CL_ISHMED_SNAP_PREREG definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create protected

  global friends CL_ISHMED_PREREG .

public section.
*"* public components of class CL_ISHMED_SNAP_PREREG
*"* do not include other source files here!!!
protected section.
*"* protected components of class CL_ISHMED_SNAP_PREREG
*"* do not include other source files here!!!

  data G_N1VKG type N1VKG .
  data G_OLD_N1VKG type N1VKG .
  data GT_TEXTMODULE type ISH_T_TEXTMOD_USE_SNAP .
  data GR_CORDTYP type ref to CL_ISH_CORDTYP .
  data GR_CORDTYP_OLD type ref to CL_ISH_CORDTYP .
  data GR_STSMA type ref to CL_ISH_STSMA .
  data GR_STSMA_OLD type ref to CL_ISH_STSMA .
  data GR_ESTAT type ref to CL_ISH_ESTAT .
  data GR_ESTAT_OLD type ref to CL_ISH_ESTAT .
  data GR_CASE_CHANGE type ref to CL_ISH_CASE_CHANGE .
  data GT_COMPMETH_RUN type ISH_T_COMPONENT_METHOD .
  data GT_CANCELLED_COMPHEAD type ISH_T_COMPONENT .
  data G_SERVICES_DB_READ type ISH_ON_OFF .
  data GT_LNRLS type ISH_T_LNRLS .
private section.
*"* private components of class CL_ISHMED_SNAP_PREREG
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISHMED_SNAP_PREREG IMPLEMENTATION.
ENDCLASS.
