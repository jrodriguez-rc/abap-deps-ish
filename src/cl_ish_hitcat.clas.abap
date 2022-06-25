class CL_ISH_HITCAT definition
  public
  abstract
  create public .

*"* public components of class CL_ISH_HITCAT
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

  constants CO_OTYPE_HITCAT type ISH_OBJECT_TYPE value 12014. "#EC NOTEXT

  methods GET_ID
    returning
      value(R_ID) type STRING .
  methods GET_LONGNAME
    returning
      value(R_LONGNAME) type STRING .
  methods GET_SHORTNAME
    returning
      value(R_SHORTNAME) type STRING .
  methods GET_VALID_FROM
    returning
      value(R_VALID_FROM) type SY-DATUM .
  methods GET_VALID_TO
    importing
      value(R_VALID_TO) type SY-DATUM .
  methods IS_VALID
    importing
      value(I_DATE) type SY-DATUM default SY-DATUM
    preferred parameter I_DATE
    returning
      value(R_IS_VALID) type ISH_ON_OFF .
protected section.
*"* protected components of class CL_ISH_HITCAT
*"* do not include other source files here!!!

  data G_ID type STRING .
  data G_LONGNAME type STRING .
  data G_SHORTNAME type STRING .
  data G_VALID_FROM type SY-DATUM .
  data G_VALID_TO type SY-DATUM .

  methods INITIALIZE
    importing
      value(I_ID) type STRING
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_ATTRIBUTES
  abstract
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_HITCAT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_HITCAT IMPLEMENTATION.


METHOD get_id.

  r_id = g_id.

ENDMETHOD.


METHOD get_longname.

  r_longname = g_longname.

ENDMETHOD.


METHOD get_shortname.

  r_shortname = g_shortname.

ENDMETHOD.


METHOD get_valid_from.

  r_valid_from = g_valid_from.

ENDMETHOD.


METHOD get_valid_to.

  r_valid_to = g_valid_to.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_hitcat.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_object_type  TYPE i.

* Get self's dynamic object type.
  CALL METHOD get_type
    IMPORTING
      e_object_type = l_object_type.

* Export.
  IF i_object_type = l_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_hitcat.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD initialize.

* Set ID
  g_id = i_id.

* Set attributes
  CALL METHOD initialize_attributes
    IMPORTING
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.

ENDMETHOD.


METHOD is_valid.

* Check valid_from
  IF NOT g_valid_from IS INITIAL AND
     i_date < g_valid_from.
    r_is_valid = off.
    EXIT.
  ENDIF.

* Check valid_to
  IF NOT g_valid_to IS INITIAL AND
     i_date > g_valid_to.
    r_is_valid = off.
    EXIT.
  ENDIF.

* Self is valid
  r_is_valid = on.

ENDMETHOD.
ENDCLASS.
