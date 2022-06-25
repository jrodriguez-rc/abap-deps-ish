class CL_ISH_SNAPSHOT definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_SNAPSHOT
*"* do not include other source files here!!!

  methods GET_ATTRIBUTE
    importing
      value(I_ATTRIBUTE_NAME) type ISH_FIELDNAME
    exporting
      value(E_VALUE) type ANY
      value(E_TYPE) type CHAR200
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY .
protected section.
*"* protected components of class CL_ISH_SNAPSHOT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_SNAPSHOT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SNAPSHOT IMPLEMENTATION.


method DESTROY.
endmethod.


method GET_ATTRIBUTE.
endmethod.
ENDCLASS.
