class CL_ISH_GUI_CONTAINER_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_CONTROL_LAYOUT
  create public .

*"* public components of class CL_ISH_GUI_CONTAINER_LAYOUT
*"* do not include other source files here!!!
public section.

  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
    preferred parameter I_ELEMENT_NAME .
protected section.
*"* protected components of class CL_ISH_GUI_CONTAINER_LAYOUT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_GUI_CONTAINER_LAYOUT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_CONTAINER_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name        = i_element_name
      i_layout_name         = i_layout_name ).

ENDMETHOD.
ENDCLASS.
