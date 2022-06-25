class CL_ISH_MANAGER definition
  public
  final
  create public .

*"* public components of class CL_ISH_MANAGER
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_CONT_MANAGER type ISH_OBJECT_TYPE value 2001. "#EC NOTEXT

  class-methods APPEND
    importing
      value(I_OBJECT) type ref to OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  class-methods REMOVE
    importing
      value(I_OBJECT) type ref to OBJECT .
  class-methods GET_DATA
    importing
      value(I_TYPE) type I optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_OBJECT) type ISH_OBJECTLIST
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISHMED_MANAGER
*"* do not include other source files here!!!
private section.
*"* private components of class CL_ISH_MANAGER
*"* do not include other source files here!!!

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .

  class-data G_OBJ_CONTAINER type ref to CL_ISH_DATA_CONTAINER .
ENDCLASS.



CLASS CL_ISH_MANAGER IMPLEMENTATION.


method APPEND .
  data: l_rc type ish_method_rc.

  check not i_object is initial.

* If the global data container does not exist it must be
* created
  if g_obj_container is initial.
    CALL METHOD CL_ISH_DATA_CONTAINER=>CREATE
      IMPORTING
        E_INSTANCE     = g_obj_container
        E_RC           = l_rc
      CHANGING
        C_ERRORHANDLER = c_errorhandler.
    if l_rc <> 0.
      e_rc = l_rc.
      exit.
    endif.
  endif.   " if g_obj_container is initial

* Maybe CL_ISH_DATA_CONTAINER sets itself into the manager.
* That"s not a good idea, so prevent this
  check i_object <> g_obj_container.

* Append the object into the global container
  CALL METHOD G_OBJ_CONTAINER->APPEND_OBJECT
    EXPORTING
      I_OBJECT       = i_object
      I_MULTIPLE_OBJ = OFF.
endmethod.


method GET_DATA .
  data: l_rc     type ish_method_rc,
        lt_obj   type ish_objectlist,
        l_wa_obj type line of ish_objectlist.

* Initialization
  e_rc = 0.
  refresh: et_object.

  check not g_obj_container is initial.

  clear: lt_obj[].
  CALL METHOD G_OBJ_CONTAINER->GET_DATA
    EXPORTING
      I_TYPE         = i_type
    IMPORTING
      E_RC           = l_rc
      ET_OBJECT      = lt_obj
    CHANGING
      C_ERRORHANDLER = c_errorhandler.
  if l_rc <> 0.
    e_rc = l_rc.
    exit.
  endif.

* Fichte, Nr 12007: Give back the object so that the last inserted
* object is the first in the list, because this objects could
* contain the most topical data
  loop at lt_obj into l_wa_obj.
    insert l_wa_obj into et_object index 1.
  endloop.
endmethod.


METHOD if_ish_identify_object~get_type .
* Typ des Objekts an den Aufrufer zurückgeben
  e_object_type = co_otype_cont_manager.
ENDMETHOD.


METHOD if_ish_identify_object~is_a .

  DATA: l_object_type                 TYPE i.

  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_cont_manager.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD remove .

  CHECK NOT i_object        IS INITIAL  AND
        NOT g_obj_container IS INITIAL.

  CALL METHOD g_obj_container->remove_object
    EXPORTING
      i_object = i_object.

ENDMETHOD.
ENDCLASS.
