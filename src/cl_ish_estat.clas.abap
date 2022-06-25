class CL_ISH_ESTAT definition
  public
  create protected .

*"* public components of class CL_ISH_ESTAT
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_ESTAT type ISH_OBJECT_TYPE value 48. "#EC NOTEXT

  methods CONSTRUCTOR
    importing
      value(IS_TJ30) type TJ30
      value(IS_TJ30T) type TJ30T .
  class-methods LOAD
    importing
      value(I_STSMA) type TJ30-STSMA optional
      value(I_ESTAT) type TJ30-ESTAT optional
      value(IS_TJ30) type TJ30 optional
      value(IS_TJ30T) type TJ30T optional
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_ESTAT .
  methods GET_DATA
    exporting
      value(ES_TJ30) type TJ30
      value(ES_TJ30T) type TJ30T .
  methods GET_ESTAT
    exporting
      value(E_ESTAT) type TJ30-ESTAT .
  methods GET_INIST
    exporting
      value(E_INIST) type TJ30-INIST .
  methods GET_TXT04
    returning
      value(R_TXT04) type TJ30T-TXT04 .
  methods GET_TXT30
    returning
      value(R_TXT30) type TJ30T-TXT30 .
protected section.
*"* protected components of class CL_ISH_ESTAT
*"* do not include other source files here!!!

  data GS_TJ30 type TJ30 .
  data GS_TJ30T type TJ30T .
private section.
*"* private components of class CL_ISH_ESTAT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_ESTAT IMPLEMENTATION.


METHOD constructor .

  gs_tj30  = is_tj30.
  gs_tj30t = is_tj30t.

ENDMETHOD.


METHOD get_data .

  es_tj30  = gs_tj30.
  es_tj30t = gs_tj30t.

ENDMETHOD.


METHOD get_estat .

  e_estat = gs_tj30-estat.

ENDMETHOD.


METHOD get_inist .

  e_inist = gs_tj30-inist.

ENDMETHOD.


METHOD get_txt04 .

  r_txt04 = gs_tj30t-txt04.

ENDMETHOD.


METHOD get_txt30 .

  r_txt30 = gs_tj30t-txt30.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_estat.

ENDMETHOD.


METHOD if_ish_identify_object~is_a .

  IF i_object_type = co_otype_estat.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_estat.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD load .

  DATA: ls_tj30  TYPE tj30,
        ls_tj30t TYPE tj30t,
        lt_tj30t TYPE TABLE OF tj30t.   "Grill, ID-20652

  IF is_tj30 IS INITIAL.
*   Read TJ30
    SELECT SINGLE *
      FROM tj30
      INTO ls_tj30
      WHERE stsma = i_stsma
        AND estat = i_estat.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    ls_tj30 = is_tj30.
  ENDIF.

  IF is_tj30t IS INITIAL.
*   Read TJ30T
*-- begin Grill, ID-20652
    SELECT * FROM tj30t INTO TABLE lt_tj30t
      WHERE stsma = i_stsma
      AND   estat = i_estat.
    READ TABLE lt_tj30t INTO ls_tj30t WITH KEY
      spras = sy-langu.
    IF sy-subrc NE 0.
      READ TABLE lt_tj30t INTO ls_tj30t INDEX 1.
    ENDIF.
*-- begin delete
*    SELECT SINGLE *
*      FROM tj30t
*      INTO ls_tj30t
*      WHERE stsma = i_stsma
*        AND estat = i_estat
*        AND spras = sy-langu.
*-- end delete
*-- end Grill, ID-20652
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    ls_tj30t = is_tj30t.
  ENDIF.

* Create self
  CREATE OBJECT er_instance
    EXPORTING
    is_tj30 = ls_tj30
    is_tj30t = ls_tj30t.

ENDMETHOD.
ENDCLASS.
