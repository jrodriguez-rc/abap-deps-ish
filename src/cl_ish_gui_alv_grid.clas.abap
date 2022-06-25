class CL_ISH_GUI_ALV_GRID definition
  public
  inheriting from CL_GUI_ALV_GRID
  create public .

*"* public components of class CL_ISH_GUI_ALV_GRID
*"* do not include other source files here!!!
public section.

  methods ISH_GET_ACT_EVENTID
    returning
      value(R_EVENTID) type I .
protected section.
*"* protected components of class CL_ISH_GUI_ALV_GRID
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_ALV_GRID
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_ALV_GRID IMPLEMENTATION.


METHOD ish_get_act_eventid.

  r_eventid = m_eventid.

ENDMETHOD.
ENDCLASS.
