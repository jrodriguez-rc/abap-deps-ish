class CL_ISH_RUN_DATA_SNAPSHOT definition
  public
  inheriting from CL_ISH_DATA_SNAPSHOT
  abstract
  create public .

*"* public components of class CL_ISH_RUN_DATA_SNAPSHOT
*"* do not include other source files here!!!
public section.

  methods GET_CONNECTION_KEY
    returning
      value(R_CONNECTION_KEY) type ISH_SNAPKEY .
  methods SET_CONNECTION_KEY
    importing
      value(I_CONNECTION_KEY) type ISH_SNAPKEY .
protected section.
*"* protected components of class CL_ISH_RUN_DATA_SNAPSHOT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_RUN_DATA_SNAPSHOT
*"* do not include other source files here!!!

  data G_CONNECTION_KEY type ISH_SNAPKEY .
ENDCLASS.



CLASS CL_ISH_RUN_DATA_SNAPSHOT IMPLEMENTATION.


METHOD get_connection_key .

  r_connection_key = g_connection_key.

ENDMETHOD.


METHOD set_connection_key .

  g_connection_key = i_connection_key.

ENDMETHOD.
ENDCLASS.
