class CL_ISH_HITCAT_SERVICE definition
  public
  inheriting from CL_ISH_HITCAT
  create protected .

*"* public components of class CL_ISH_HITCAT_SERVICE
*"* do not include other source files here!!!
public section.

  constants CO_OTYPE_HITCAT_SERVICE type ISH_OBJECT_TYPE value 12015. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
protected section.
*"* protected components of class CL_ISH_HITCAT_SERVICE
*"* do not include other source files here!!!

  methods INITIALIZE_ATTRIBUTES
    redefinition .
private section.
*"* private components of class CL_ISH_HITCAT_SERVICE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_HITCAT_SERVICE IMPLEMENTATION.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_hitcat_service.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_hitcat_service.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD initialize_attributes.

  DATA: l_einri  TYPE tnk01-einri,
        l_katid  TYPE tnk01-katid,
        ls_tnk01 TYPE tnk01.

* Check g_id.
  IF g_id IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.

* Get einri + katid from g_id.
  l_einri = g_id(4).
  l_katid = g_id+4(2).

* Read data from tnk01
  SELECT SINGLE *
    FROM tnk01
    INTO ls_tnk01
    WHERE einri = l_einri
      AND katid = l_katid.
  IF sy-subrc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* Initialize attributes
  g_longname   = ls_tnk01-katkb.
  g_shortname  = ls_tnk01-kattx.
  CLEAR: g_valid_from,
         g_valid_to.

ENDMETHOD.
ENDCLASS.
