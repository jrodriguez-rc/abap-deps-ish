class CL_ISH_RANGE definition
  public
  create public
  shared memory enabled .

*"* public components of class CL_ISH_RANGE
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OPT_BT type TVARV_OPTI value 'BT'. "#EC NOTEXT
  constants CO_OPT_CP type TVARV_OPTI value 'CP'. "#EC NOTEXT
  constants CO_OPT_EQ type TVARV_OPTI value 'EQ'. "#EC NOTEXT
  constants CO_OPT_GE type TVARV_OPTI value 'GE'. "#EC NOTEXT
  constants CO_OPT_GT type TVARV_OPTI value 'GT'. "#EC NOTEXT
  constants CO_OPT_LE type TVARV_OPTI value 'LE'. "#EC NOTEXT
  constants CO_OPT_LT type TVARV_OPTI value 'LT'. "#EC NOTEXT
  constants CO_OPT_NE type TVARV_OPTI value 'NE'. "#EC NOTEXT
  constants CO_OPT_NP type TVARV_OPTI value 'NP'. "#EC NOTEXT
  constants CO_OTYPE_RANGE type ISH_OBJECT_TYPE value 12160. "#EC NOTEXT
  constants CO_SIGN_E type TVARV_SIGN value 'E'. "#EC NOTEXT
  constants CO_SIGN_I type TVARV_SIGN value 'I'. "#EC NOTEXT

  methods ADD_ENTRIES
    importing
      !IT_ENTRY type STANDARD TABLE .
  methods ADD_ENTRY
    importing
      !I_SIGN type TVARV_SIGN
      !I_OPTION type TVARV_OPTI
      !I_LOW type ANY
      !I_HIGH type ANY .
  methods ADD_RANGE_ENTRIES
    importing
      !IR_RANGE type ref to CL_ISH_RANGE .
  methods CLEAR .
  methods EXCL_BT
    importing
      !I_LOW type ANY
      !I_HIGH type ANY .
  methods EXCL_EQ
    importing
      !I_VALUE type ANY .
  methods EXCL_GE
    importing
      !I_VALUE type ANY .
  methods EXCL_GT
    importing
      !I_VALUE type ANY .
  methods EXCL_LE
    importing
      !I_VALUE type ANY .
  methods EXCL_LT
    importing
      !I_VALUE type ANY .
  methods EXCL_NE
    importing
      !I_VALUE type ANY .
  methods GET_ENTRIES
    returning
      value(RT_ENTRY) type ISH_T_R_STRING .
  methods GET_NR_OF_ENTRIES
    returning
      value(R_COUNT) type I .
  methods INCL_BT
    importing
      !I_LOW type ANY
      !I_HIGH type ANY .
  methods INCL_EQ
    importing
      !I_VALUE type ANY .
  methods INCL_GE
    importing
      !I_VALUE type ANY .
  methods INCL_GT
    importing
      !I_VALUE type ANY .
  methods INCL_LE
    importing
      !I_VALUE type ANY .
  methods INCL_LT
    importing
      !I_VALUE type ANY .
  methods INCL_NE
    importing
      !I_VALUE type ANY .
  methods IS_EMPTY
    returning
      value(R_EMPTY) type ISH_ON_OFF .
  methods IS_VALUE_IN_RANGE
    importing
      !I_VALUE type ANY
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods SET_ENTRIES
    importing
      !IT_ENTRY type ISH_T_R_STRING .
protected section.
*"* protected components of class CL_ISH_RANGE
*"* do not include other source files here!!!

  data GT_ENTRY type ISH_T_R_STRING .

  methods BUILD_ENTRY
    importing
      !I_SIGN type TVARV_SIGN
      !I_OPTION type TVARV_OPTI
      !I_LOW type ANY
      !I_HIGH type ANY
    returning
      value(RS_ENTRY) type RN1_R_STRING .
  methods CHECK_ENTRY
    importing
      !IS_ENTRY type RN1_R_STRING
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods CHECK_OPTION
    importing
      !I_OPTION type TVARV_OPTI
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods CHECK_SIGN
    importing
      !I_SIGN type TVARV_SIGN
    returning
      value(R_SUCCESS) type ISH_ON_OFF .
  methods STRINGIFY_VALUE
    importing
      !I_VALUE type ANY
    returning
      value(R_VALUE) type STRING .
private section.
*"* private components of class CL_ISH_RANGE
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_RANGE IMPLEMENTATION.


METHOD add_entries.

  FIELD-SYMBOLS: <ls_entry>  TYPE ANY,
                 <l_sign>    TYPE tvarv_sign,
                 <l_option>  TYPE tvarv_opti,
                 <l_low>     TYPE ANY,
                 <l_high>    TYPE ANY.

  LOOP AT it_entry ASSIGNING <ls_entry>.
    ASSIGN COMPONENT 'SIGN'   OF STRUCTURE <ls_entry> TO <l_sign>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT 'OPTION' OF STRUCTURE <ls_entry> TO <l_option>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT 'LOW'    OF STRUCTURE <ls_entry> TO <l_low>.
    CHECK sy-subrc = 0.
    ASSIGN COMPONENT 'HIGH'   OF STRUCTURE <ls_entry> TO <l_high>.
    CHECK sy-subrc = 0.
    add_entry( i_sign        = <l_sign>
               i_option      = <l_option>
               i_low         = <l_low>
               i_high        = <l_high> ).
  ENDLOOP.

ENDMETHOD.


METHOD add_entry.

  DATA: ls_entry  LIKE LINE OF gt_entry.

* Build the entry.
  ls_entry = build_entry( i_sign   = i_sign
                          i_option = i_option
                          i_low    = i_low
                          i_high   = i_high ).

* Check the entry.
  IF check_entry( ls_entry ) = off.
    RAISE EXCEPTION TYPE cx_ish_no_check_handler.
  ENDIF.

* Add the entry.
  APPEND ls_entry TO gt_entry.

ENDMETHOD.


METHOD add_range_entries.

  DATA: lt_entry  LIKE gt_entry.

* Initial checking.
  CHECK ir_range IS BOUND.
  CHECK ir_range <> me.

* Copy.
  lt_entry = ir_range->get_entries( ).
  add_entries( lt_entry ).

ENDMETHOD.


METHOD build_entry.

  rs_entry-sign   = i_sign.
  rs_entry-option = i_option.
  rs_entry-low    = stringify_value( i_low ).
  rs_entry-high   = stringify_value( i_high ).

ENDMETHOD.


METHOD check_entry.

* Initializations.
  r_success = off.

* Check sign.
  CHECK check_sign( is_entry-sign ) = on.

* Check option.
  CHECK check_option( is_entry-option ) = on.

* Check low.
  IF is_entry-option = co_opt_cp OR
     is_entry-option = co_opt_np.
    CHECK is_entry-low CA '*'.
  ELSEIF is_entry-option = co_opt_eq OR
         is_entry-option = co_opt_ne.
    CHECK NOT is_entry-low CA '*'.
  ENDIF.

* Check high.
  IF is_entry-option <> co_opt_bt.
    CHECK is_entry-high IS INITIAL.
  ENDIF.

* The entry is valid.
  r_success = on.

ENDMETHOD.


METHOD check_option.

  r_success = off.

  CHECK i_option = co_opt_bt OR
        i_option = co_opt_cp OR
        i_option = co_opt_eq OR
        i_option = co_opt_ge OR
        i_option = co_opt_gt OR
        i_option = co_opt_le OR
        i_option = co_opt_lt OR
        i_option = co_opt_ne OR
        i_option = co_opt_np.

  r_success = on.

ENDMETHOD.


METHOD check_sign.

  r_success = off.

  CHECK i_sign = co_sign_e OR
        i_sign = co_sign_i.

  r_success = on.

ENDMETHOD.


METHOD clear.

  CLEAR: gt_entry.

ENDMETHOD.


METHOD excl_bt.

  add_entry( i_sign   = co_sign_e
             i_option = co_opt_bt
             i_low    = i_low
             i_high   = i_high ).

ENDMETHOD.


METHOD excl_eq.

  DATA: l_value  TYPE string.

  l_value = stringify_value( i_value ).

  IF l_value CA '*'.
    add_entry( i_sign   = co_sign_e
               i_option = co_opt_cp
               i_low    = i_value
               i_high   = space ).
  ELSE.
    add_entry( i_sign   = co_sign_e
               i_option = co_opt_eq
               i_low    = i_value
               i_high   = space ).
  ENDIF.

ENDMETHOD.


METHOD excl_ge.

  add_entry( i_sign   = co_sign_e
             i_option = co_opt_ge
             i_low    = i_value
             i_high   = space ).

ENDMETHOD.


METHOD excl_gt.

  add_entry( i_sign   = co_sign_e
             i_option = co_opt_gt
             i_low    = i_value
             i_high   = space ).

ENDMETHOD.


METHOD excl_le.

  add_entry( i_sign   = co_sign_e
             i_option = co_opt_le
             i_low    = i_value
             i_high   = space ).

ENDMETHOD.


METHOD excl_lt.

  add_entry( i_sign   = co_sign_e
             i_option = co_opt_lt
             i_low    = i_value
             i_high   = space ).

ENDMETHOD.


METHOD excl_ne.

  DATA: l_value  TYPE string.

  l_value = stringify_value( i_value ).

  IF l_value CA '*'.
    add_entry( i_sign   = co_sign_e
               i_option = co_opt_np
               i_low    = i_value
               i_high   = space ).
  ELSE.
    add_entry( i_sign   = co_sign_e
               i_option = co_opt_ne
               i_low    = i_value
               i_high   = space ).
  ENDIF.

ENDMETHOD.


METHOD get_entries.

  rt_entry = gt_entry.

ENDMETHOD.


METHOD get_nr_of_entries.

  r_count = LINES( gt_entry ).

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_range.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.

  DATA: l_type  TYPE ish_object_type.

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

  IF i_object_type = co_otype_range.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD incl_bt.

  add_entry( i_sign   = co_sign_i
             i_option = co_opt_bt
             i_low    = i_low
             i_high   = i_high ).

ENDMETHOD.


METHOD incl_eq.

  DATA: l_value  TYPE string.

  l_value = stringify_value( i_value ).

  IF l_value CA '*'.
    add_entry( i_sign   = co_sign_i
               i_option = co_opt_cp
               i_low    = i_value
               i_high   = space ).
  ELSE.
    add_entry( i_sign   = co_sign_i
               i_option = co_opt_eq
               i_low    = i_value
               i_high   = space ).
  ENDIF.

ENDMETHOD.


METHOD incl_ge.

  add_entry( i_sign   = co_sign_i
             i_option = co_opt_ge
             i_low    = i_value
             i_high   = space ).

ENDMETHOD.


METHOD incl_gt.

  add_entry( i_sign   = co_sign_i
             i_option = co_opt_gt
             i_low    = i_value
             i_high   = space ).

ENDMETHOD.


METHOD incl_le.

  add_entry( i_sign   = co_sign_i
             i_option = co_opt_le
             i_low    = i_value
             i_high   = space ).

ENDMETHOD.


METHOD incl_lt.

  add_entry( i_sign   = co_sign_i
             i_option = co_opt_lt
             i_low    = i_value
             i_high   = space ).

ENDMETHOD.


METHOD incl_ne.

  DATA: l_value  TYPE string.

  l_value = stringify_value( i_value ).

  IF l_value CA '*'.
    add_entry( i_sign   = co_sign_i
               i_option = co_opt_np
               i_low    = i_value
               i_high   = space ).
  ELSE.
    add_entry( i_sign   = co_sign_i
               i_option = co_opt_ne
               i_low    = i_value
               i_high   = space ).
  ENDIF.

ENDMETHOD.


METHOD is_empty.

  IF gt_entry IS INITIAL.
    r_empty = on.
  ELSE.
    r_empty = off.
  ENDIF.

ENDMETHOD.


METHOD is_value_in_range.

  DATA: l_value  TYPE string.

* Initializations.
  r_success = off.

* On no range -> valid.
  IF gt_entry IS INITIAL.
    r_success = on.
    EXIT.
  ENDIF.

* Check the value.
  l_value = stringify_value( i_value ).
  CHECK l_value IN gt_entry.

* The value is valid.
  r_success = on.

ENDMETHOD.


METHOD set_entries.

  clear( ).

  add_entries( it_entry ).

ENDMETHOD.


METHOD stringify_value.

  r_value = i_value.

ENDMETHOD.
ENDCLASS.
