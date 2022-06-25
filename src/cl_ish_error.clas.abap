class CL_ISH_ERROR definition
  public
  create protected .

public section.

*"* public components of class CL_ISH_ERROR
*"* do not include other source files here!!!
  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_OBJECT_TYPES .

  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_AUTHORITY type N1_ERROR value '01' ##NO_TEXT.
  constants CO_ENQUEUE type N1_ERROR value '02' ##NO_TEXT.
  constants CO_DATA_ACTUALITY type N1_ERROR value '03' ##NO_TEXT.
  constants CO_SPECIFIC type N1_ERROR value '99' ##NO_TEXT.
  constants CO_OTYPE_ERROR type ISH_OBJECT_TYPE value 11000 ##NO_TEXT.
  constants CO_USER_AWARENESS type N1_ERROR value '04' ##NO_TEXT.

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    exceptions
      INSTANCE_NOT_POSSIBLE .
  class-methods CREATE
    exporting
      !ER_INSTANCE type ref to CL_ISH_ERROR
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_ERROR
    returning
      value(R_ERROR) type N1_ERROR .
  methods IS_ERROR
    importing
      value(I_ERROR) type N1_ERROR
    returning
      value(R_IS) type ISH_ON_OFF .
  methods IS_ERROR_DERIVED_FROM
    importing
      value(I_ERROR) type N1_ERROR
    returning
      value(R_IS) type ISH_ON_OFF .
  methods IS_ERROR_INHERITED_FROM
    importing
      value(I_ERROR) type N1_ERROR
    returning
      value(R_IS) type ISH_ON_OFF .
  methods SET_ERROR
    importing
      value(I_ERROR) type N1_ERROR
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_ERROR
*"* do not include other source files here!!!

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_VCODE_DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases CO_VCODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_INSERT .
  aliases CO_VCODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_UPDATE .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
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

  data G_ERROR type N1_ERROR .

  methods CHECK_ERROR_INHERITED_FROM
    importing
      value(I_ERROR) type N1_ERROR
    returning
      value(R_IS) type ISH_ON_OFF .
  methods GET_ERROR_LEVELS
    importing
      value(I_ERROR) type N1_ERROR
    returning
      value(RT_ERROR_LEVELS) type ISHMED_T_ERROR .
  methods GET_OWN_ERROR
    returning
      value(RT_ERROR) type ISHMED_T_ERROR .
  methods IS_ERROR_IN_TABLE
    importing
      value(I_ERROR) type N1_ERROR
      value(IT_ERROR) type ISHMED_T_ERROR
    returning
      value(R_IS) type ISH_ON_OFF .
  methods IS_OWN_ERROR
    importing
      value(I_ERROR) type N1_ERROR
    returning
      value(R_IS) type ISH_ON_OFF .
private section.
*"* private components of class CL_ISH_ERROR
*"* do not include other source files here!!!

  class-data GT_ERROR type ISHMED_T_ERROR .
ENDCLASS.



CLASS CL_ISH_ERROR IMPLEMENTATION.


METHOD check_error_inherited_from.

  IF is_error_in_table( i_error  = i_error
                        it_error = gt_error ) = on.
    r_is = on.
  ELSE.
    r_is = off.
  ENDIF.

ENDMETHOD.


METHOD class_constructor.

  INSERT co_authority        INTO TABLE gt_error.
  INSERT co_data_actuality   INTO TABLE gt_error.
  INSERT co_enqueue          INTO TABLE gt_error.
  INSERT co_specific         INTO TABLE gt_error.
  INSERT co_user_awareness   INTO TABLE gt_error. "Führer, IXX-7742 13.10.2016

ENDMETHOD.


method CONSTRUCTOR.
endmethod.


METHOD create.

  CREATE OBJECT er_instance
    EXCEPTIONS
      instance_not_possible = 1
      OTHERS                = 2.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.

ENDMETHOD.


METHOD get_error.
  r_error = g_error.
ENDMETHOD.


METHOD GET_ERROR_LEVELS.
  SPLIT i_error AT '.' INTO TABLE rt_error_levels.
ENDMETHOD.


METHOD get_own_error.
  rt_error = gt_error.
ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_error.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type TYPE i.

* Get self's type.
  CALL METHOD get_type
    IMPORTING
      e_object_type = l_type.

  IF l_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_error.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD is_error.

  IF  i_error                 = g_error AND
      is_own_error( i_error ) = on.
    r_is = on.
  ELSE.
    r_is = off.
  ENDIF.

ENDMETHOD.


METHOD is_error_derived_from.

* definitions
  DATA: lt_check_error_levels      TYPE ishmed_t_error,
        lt_error_levels            TYPE ishmed_t_error.
  FIELD-SYMBOLS:
        <l_check_level>            TYPE n1_error,
        <l_level>                  TYPE n1_error.
* ---------- ---------- ----------
* get error levels
  lt_check_error_levels = get_error_levels( i_error ).
  lt_error_levels       = get_error_levels( g_error ).
* ---------- ---------- ----------
  r_is = on.
  LOOP AT lt_check_error_levels ASSIGNING <l_check_level>.
    READ TABLE lt_error_levels ASSIGNING <l_level>
       INDEX sy-tabix.
    IF sy-subrc <> 0 OR
       <l_check_level> <> <l_level>.
      r_is = off.
      EXIT.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD is_error_inherited_from.

  IF i_error = g_error.
    r_is = on.
  ELSE.
    r_is = off.
  ENDIF.

ENDMETHOD.


METHOD is_error_in_table.

  READ TABLE it_error TRANSPORTING NO FIELDS
     WITH KEY table_line = i_error.
  IF sy-subrc = 0.
    r_is = on.
  ELSE.
    r_is = off.
  ENDIF.

ENDMETHOD.


METHOD is_own_error.

  DATA: lt_error        TYPE ishmed_t_error.

  lt_error = get_own_error( ).
  r_is = is_error_in_table( i_error  = i_error
                            it_error = lt_error ).

ENDMETHOD.


METHOD set_error.

* initialize
  e_rc = 0.

* check if given error is inherited
  IF check_error_inherited_from( i_error ) = off.
    e_rc = 1.
    EXIT.
  ENDIF.

* set error if ok
  g_error = i_error.

ENDMETHOD.
ENDCLASS.
