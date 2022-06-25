class CL_ISH_IDENTIFY_COLLECTION definition
  public
  create public .

public section.
*"* public components of class CL_ISH_IDENTIFY_COLLECTION
*"* do not include other source files here!!!

  interfaces IF_ISH_IDENTIFY_COLLECTION .

  aliases ADD_OBJECT
    for IF_ISH_IDENTIFY_COLLECTION~ADD_OBJECT .
  aliases CLEAR
    for IF_ISH_IDENTIFY_COLLECTION~CLEAR .
  aliases GET_OBJECTLIST
    for IF_ISH_IDENTIFY_COLLECTION~GET_OBJECTLIST .
  aliases GET_OBJECTLIST_BY_TYPE
    for IF_ISH_IDENTIFY_COLLECTION~GET_OBJECTLIST_BY_TYPE .
  aliases GET_OBJECTS
    for IF_ISH_IDENTIFY_COLLECTION~GET_OBJECTS .
  aliases GET_OBJECTS_BY_TYPE
    for IF_ISH_IDENTIFY_COLLECTION~GET_OBJECTS_BY_TYPE .
  aliases HAS_OBJECT
    for IF_ISH_IDENTIFY_COLLECTION~HAS_OBJECT .
  aliases REMOVE_OBJECT
    for IF_ISH_IDENTIFY_COLLECTION~REMOVE_OBJECT .
protected section.
*"* protected components of class CL_ISH_IDENTIFY_COLLECTION
*"* do not include other source files here!!!

  data GT_OBJECT type ISH_T_IDENTIFY_OBJECT .
private section.
*"* private components of class CL_ISH_IDENTIFY_COLLECTION
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_IDENTIFY_COLLECTION IMPLEMENTATION.


METHOD if_ish_identify_collection~add_object.

  CHECK ir_object IS BOUND.
  CHECK has_object( ir_object ) = abap_false.

  APPEND ir_object TO gt_object.

ENDMETHOD.


METHOD if_ish_identify_collection~clear.

  CLEAR: gt_object.

ENDMETHOD.


METHOD if_ish_identify_collection~get_objectlist.

  DATA: lr_object  TYPE REF TO if_ish_identify_object,
        ls_object  LIKE LINE OF rt_object.

  LOOP AT gt_object INTO lr_object.
    ls_object-object = lr_object.
    APPEND ls_object TO rt_object.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_identify_collection~get_objectlist_by_type.

  DATA: lr_object  TYPE REF TO if_ish_identify_object,
        ls_object  LIKE LINE OF rt_object.

  LOOP AT gt_object INTO lr_object.
    IF i_incl_derived = abap_true.
      CHECK lr_object->is_inherited_from( i_type ) = abap_true.
    ELSE.
      CHECK lr_object->is_a( i_type ) = abap_true.
    ENDIF.
    ls_object-object = lr_object.
    APPEND ls_object TO rt_object.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_identify_collection~get_objects.

  rt_object = gt_object.

ENDMETHOD.


METHOD if_ish_identify_collection~get_objects_by_type.

  DATA: lr_object  TYPE REF TO if_ish_identify_object.

  LOOP AT gt_object INTO lr_object.
    IF i_incl_derived = abap_true.
      CHECK lr_object->is_inherited_from( i_type ) = abap_true.
    ELSE.
      CHECK lr_object->is_a( i_type ) = abap_true.
    ENDIF.
    APPEND lr_object TO rt_object.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_identify_collection~has_object.

  CHECK ir_object IS BOUND.

  READ TABLE gt_object FROM ir_object TRANSPORTING no fields.
  CHECK sy-subrc = 0.

  r_has_object = abap_true.

ENDMETHOD.


METHOD if_ish_identify_collection~remove_object.

  CHECK ir_object IS BOUND.

##INDEX_NUM  DELETE gt_object FROM ir_object.
  CHECK sy-subrc = 0.

  r_removed = abap_true.

ENDMETHOD.
ENDCLASS.
