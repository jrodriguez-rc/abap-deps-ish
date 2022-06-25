class CL_ISH_SNAPSHOT_BO definition
  public
  inheriting from CL_ISH_SNAPSHOT
  create public .

public section.
*"* public components of class CL_ISH_SNAPSHOT_BO
*"* do not include other source files here!!!

  methods CONSTRUCTOR
    importing
      !I_SNAPKEY type ISH_SNAPKEY .
  methods GET_SNAPKEY
    returning
      value(R_SNAPKEY) type ISH_SNAPKEY .
protected section.
*"* protected components of class CL_ISH_SNAPSHOT_BO
*"* do not include other source files here!!!

  data G_SNAPKEY type ISH_SNAPKEY .
private section.
*"* private components of class CL_ISH_SNAPSHOT_BO
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SNAPSHOT_BO IMPLEMENTATION.


method CONSTRUCTOR.

  super->constructor( ).

  g_snapkey = i_snapkey.

endmethod.


method GET_SNAPKEY.

  g_snapkey = r_snapkey.

endmethod.
ENDCLASS.
