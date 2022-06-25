class CL_ISH_DNDEV definition
  public
  create public .

*"* public components of class CL_ISH_DNDEV
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_DNDEV type ISH_OBJECT_TYPE value 4031. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT optional
      !IR_SOURCE type ref to CL_ISH_DND optional .
  methods DESTROY .
  methods GET_DRAGDROPOBJ
    returning
      value(RR_DRAGDROPOBJ) type ref to CL_DRAGDROPOBJECT .
  methods GET_SOURCE
    returning
      value(RR_SOURCE) type ref to CL_ISH_DND .
  methods SET_DRAGDROPOBJ
    importing
      !IR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_SOURCE
    importing
      !IR_SOURCE type ref to CL_ISH_DND
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
protected section.
*"* protected components of class CL_ISH_DNDEV
*"* do not include other source files here!!!

  data GR_DRAGDROPOBJ type ref to CL_DRAGDROPOBJECT .
  data GR_SOURCE type ref to CL_ISH_DND .
private section.
*"* private components of class CL_ISH_DNDEV
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DNDEV IMPLEMENTATION.


METHOD constructor.

  gr_dragdropobj = ir_dragdropobj.
  gr_source      = ir_source.

ENDMETHOD.


METHOD destroy.

* The source object must not be destroyed here but by the caller.

  CLEAR: gr_dragdropobj,
         gr_source.

ENDMETHOD.


METHOD get_dragdropobj.

  rr_dragdropobj = gr_dragdropobj.

ENDMETHOD.


METHOD get_source.

  rr_source = gr_source.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_dndev.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type  TYPE i.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF i_object_type = l_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_dndev.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD set_dragdropobj.

  gr_dragdropobj = ir_dragdropobj.

  r_success = on.

ENDMETHOD.


METHOD set_source.

  gr_source = ir_source.

  r_success = on.

ENDMETHOD.
ENDCLASS.
