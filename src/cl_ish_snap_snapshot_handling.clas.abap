class CL_ISH_SNAP_SNAPSHOT_HANDLING definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create protected

  global friends CL_ISH_SNAPSHOT_HANDLING .

*"* public components of class CL_ISH_SNAP_SNAPSHOT_HANDLING
*"* do not include other source files here!!!
public section.

  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
protected section.
*"* protected components of class CL_ISH_SNAP_SNAPSHOT_HANDLING
*"* do not include other source files here!!!

  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_SNAP_SNAPSHOT_HANDLING
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_SNAP_SNAPSHOT_HANDLING
*"* do not include other source files here!!!

  data GT_OBJECT type ISHMED_T_SNAPSHOT .
ENDCLASS.



CLASS CL_ISH_SNAP_SNAPSHOT_HANDLING IMPLEMENTATION.


METHOD constructor .
* Führer, 13/01/05
  CALL METHOD super->constructor.
ENDMETHOD.


METHOD CREATE .

* Hilfsfelder und -strukturen
  DATA: l_rc                  TYPE ish_method_rc.
* ---------- ---------- ----------
* Instanz erzeugen
  CREATE OBJECT er_instance
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
