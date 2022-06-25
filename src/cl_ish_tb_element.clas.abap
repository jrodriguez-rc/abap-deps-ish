class CL_ISH_TB_ELEMENT definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_TB_ELEMENT
*"* do not include other source files here!!!

  constants CO_PROPERTY_VISIBLE type STRING value 'VISIBLE'. "#EC NOTEXT

  events EV_PROPERTY_CHANGED
    exporting
      value(E_PROPERTY) type STRING
      value(E_OLD_VALUE) type ANY
      value(E_NEW_VALUE) type ANY .
  events EV_BEFORE_PROPERTY_CHANGE
    exporting
      value(E_PROPERTY) type STRING
      value(E_OLD_VALUE) type ANY
      value(E_NEW_VALUE) type ANY .

  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !I_VISIBLE type ABAP_BOOL default ABAP_TRUE .
  methods GET_PROPERTY
    importing
      !I_PROPERTY type STRING
    returning
      value(R_VALUE) type STRING
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_PROPERTY
    importing
      !I_PROPERTY type STRING
      !I_VALUE type ANY
    raising
      CX_ISH_STATIC_HANDLER .
  methods SET_PROPERTY_CHANGE_ERROR .
protected section.
*"* protected components of class CL_ISH_TB_ELEMENT
*"* do not include other source files here!!!

  data G_PROPERTY_CHANGE_ERROR type ABAP_BOOL .
  data G_VISIBLE type ABAP_BOOL .

  methods _SET_PROPERTY
    importing
      !I_PROPERTY type STRING
      !I_VALUE type ANY
    raising
      CX_ISH_STATIC_HANDLER .
private section.
*"* private components of class CL_ISH_TB_ELEMENT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_TB_ELEMENT IMPLEMENTATION.


METHOD constructor.

  g_visible = i_visible.

ENDMETHOD.


METHOD get_property.

  CASE i_property.
    WHEN co_property_visible.
      r_value = g_visible.
    WHEN OTHERS.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDCASE.

ENDMETHOD.


METHOD set_property.

  DATA: l_value_old  TYPE string,
        lx_root      TYPE REF TO cx_root.

  l_value_old = get_property( i_property ).
  CHECK l_value_old <> i_property.

  g_property_change_error = abap_false.
  RAISE EVENT ev_before_property_change
    EXPORTING
        e_property  = i_property
        e_old_value = l_value_old
        e_new_value = i_value.
  IF g_property_change_error = abap_true.
    RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDIF.

  TRY.
      _set_property( i_property = i_property
                     i_value    = i_value ).
    CATCH cx_root INTO lx_root.
      RAISE EXCEPTION TYPE cx_ish_static_handler
        EXPORTING
          previous = lx_root.
  ENDTRY.

  RAISE EVENT ev_property_changed
    EXPORTING
      e_property  = i_property
      e_old_value = l_value_old
      e_new_value = i_value.

ENDMETHOD.


METHOD set_property_change_error.

  g_property_change_error = abap_true.

ENDMETHOD.


METHOD _set_property.

  CASE i_property.
    WHEN co_property_visible.
      g_visible = i_value.
    WHEN OTHERS.
      RAISE EXCEPTION TYPE cx_ish_static_handler.
  ENDCASE.

ENDMETHOD.
ENDCLASS.
