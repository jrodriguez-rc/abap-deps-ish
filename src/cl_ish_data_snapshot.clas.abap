class CL_ISH_DATA_SNAPSHOT definition
  public
  inheriting from CL_ISH_SNAPSHOT
  abstract
  create public .

*"* public components of class CL_ISH_DATA_SNAPSHOT
*"* do not include other source files here!!!
public section.

  methods GET_ACTIVE
    returning
      value(R_ACTIVE) type ISH_ON_OFF .
  methods GET_MODE
    returning
      value(R_MODE) type ISH_MODUS .
  methods SET_ACTIVE
    importing
      value(I_ACTIVE) type ISH_ON_OFF .
  methods SET_MODE
    importing
      value(I_MODE) type ISH_MODUS .
protected section.
*"* protected components of class CL_ISH_DATA_SNAPSHOT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_DATA_SNAPSHOT
*"* do not include other source files here!!!

  data G_ACTIVE type ISH_ON_OFF .
  data G_MODE type ISH_MODUS .
ENDCLASS.



CLASS CL_ISH_DATA_SNAPSHOT IMPLEMENTATION.


METHOD get_active .

  r_active = g_active.

ENDMETHOD.


METHOD get_mode .

  r_mode = g_mode.

ENDMETHOD.


METHOD set_active .

  g_active = i_active.

ENDMETHOD.


METHOD set_mode .

  g_mode = i_mode.

ENDMETHOD.
ENDCLASS.
