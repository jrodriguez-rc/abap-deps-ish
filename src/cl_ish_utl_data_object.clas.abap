class CL_ISH_UTL_DATA_OBJECT definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_UTL_DATA_OBJECT
*"* do not include other source files here!!!

  class-methods IS_ACTIVE
    importing
      !IR_DATA_OBJECT type ref to IF_ISH_DATA_OBJECT
    returning
      value(R_ACTIVE) type ISH_ON_OFF .
  class-methods IS_CANCELLED
    importing
      !IR_DATA_OBJECT type ref to IF_ISH_DATA_OBJECT
    returning
      value(R_CANCELLED) type ISH_ON_OFF .
  class-methods IS_DELETED
    importing
      !IR_DATA_OBJECT type ref to IF_ISH_DATA_OBJECT
    returning
      value(R_DELETED) type ISH_ON_OFF .
  class-methods IS_NEW
    importing
      !IR_DATA_OBJECT type ref to IF_ISH_DATA_OBJECT
    returning
      value(R_NEW) type ISH_ON_OFF .
protected section.
*"* protected components of class CL_ISH_UTL_DATA_OBJECT
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_UTL_DATA_OBJECT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_UTL_DATA_OBJECT IMPLEMENTATION.


METHOD is_active.

  CHECK ir_data_object IS BOUND.

  CALL METHOD ir_data_object->is_active
    IMPORTING
      e_active = r_active.

ENDMETHOD.


METHOD is_cancelled.

  CHECK ir_data_object IS BOUND.

  CALL METHOD ir_data_object->is_cancelled
    IMPORTING
      e_cancelled = r_cancelled.

ENDMETHOD.


METHOD is_deleted.

  CHECK ir_data_object IS BOUND.

  CALL METHOD ir_data_object->is_cancelled
    IMPORTING
      e_deleted = r_deleted.

ENDMETHOD.


METHOD is_new.

  CHECK ir_data_object IS BOUND.

  CALL METHOD ir_data_object->is_new
    IMPORTING
      e_new = r_new.

ENDMETHOD.
ENDCLASS.
