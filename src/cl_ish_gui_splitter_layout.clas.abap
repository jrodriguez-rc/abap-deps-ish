class CL_ISH_GUI_SPLITTER_LAYOUT definition
  public
  inheriting from CL_ISH_GUI_CONTAINER_LAYOUT
  create public .

public section.
*"* public components of class CL_ISH_GUI_SPLITTER_LAYOUT
*"* do not include other source files here!!!

  constants CO_DEF_BOTTOM_RIGHT_NAME type N1GUI_ELEMENT_NAME value 'BOTTOM_RIGHT'. "#EC NOTEXT
  constants CO_DEF_TOP_LEFT_NAME type N1GUI_ELEMENT_NAME value 'TOP_LEFT'. "#EC NOTEXT

  interface IF_ISH_GUI_SPLITTER_VIEW load .
  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !I_ELEMENT_NAME type N1GUI_ELEMENT_NAME optional
      !I_LAYOUT_NAME type N1GUI_LAYOUT_NAME optional
      !I_MODE type N1GUI_SPLITTER_MODE default IF_ISH_GUI_SPLITTER_VIEW=>CO_MODE_RELATIVE
      !I_ORIENTATION type N1GUI_SPLITTER_ORIENTATION default IF_ISH_GUI_SPLITTER_VIEW=>CO_ORIENTATION_HORIZONTAL
      !I_SASH_MOVABLE type N1GUI_SPLITTER_SASHMOVABLE default ABAP_TRUE
      !I_SASH_POSITION type N1GUI_SPLITTER_SASHPOSITION default 50
      !I_TOP_LEFT_NAME type N1GUI_ELEMENT_NAME default CO_DEF_TOP_LEFT_NAME
      !I_BOTTOM_RIGHT_NAME type N1GUI_ELEMENT_NAME default CO_DEF_BOTTOM_RIGHT_NAME
      !I_SPLITTER_VISIBILITY type N1GUI_SPLITTER_VISIBILITY default IF_ISH_GUI_SPLITTER_VIEW=>CO_SPLITVIS_BOTH
    preferred parameter I_ELEMENT_NAME .
  methods GET_BOTTOM_RIGHT_NAME
    returning
      value(R_BOTTOM_RIGHT_NAME) type N1GUI_ELEMENT_NAME .
  methods GET_DATA
    returning
      value(RS_DATA) type RN1_GUI_LAYO_SPLITTER_DATA .
  methods GET_MODE
    returning
      value(R_MODE) type N1GUI_SPLITTER_MODE .
  methods GET_ORIENTATION
    returning
      value(R_ORIENTATION) type N1GUI_SPLITTER_ORIENTATION .
  methods GET_SASH_MOVABLE
    returning
      value(R_SASH_MOVABLE) type N1GUI_SPLITTER_SASHMOVABLE .
  methods GET_SASH_POSITION
    returning
      value(R_SASH_POSITION) type N1GUI_SPLITTER_SASHPOSITION .
  methods GET_SPLITTER_VISIBILITY
    returning
      value(R_SPLITTER_VISIBILITY) type N1GUI_SPLITTER_VISIBILITY .
  methods GET_TOP_LEFT_NAME
    returning
      value(R_TOP_LEFT_NAME) type N1GUI_ELEMENT_NAME .
  methods SET_MODE
    importing
      !I_MODE type N1GUI_SPLITTER_MODE
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods SET_ORIENTATION
    importing
      !I_ORIENTATION type N1GUI_SPLITTER_ORIENTATION
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods SET_SASH_MOVABLE
    importing
      !I_SASH_MOVABLE type N1GUI_SPLITTER_SASHMOVABLE
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods SET_SASH_POSITION
    importing
      !I_SASH_POSITION type N1GUI_SPLITTER_SASHPOSITION
    returning
      value(R_CHANGED) type ABAP_BOOL .
  methods SET_SPLITTER_VISIBILITY
    importing
      !I_SPLITTER_VISIBILITY type N1GUI_SPLITTER_VISIBILITY
    returning
      value(R_CHANGED) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_GUI_SPLITTER_LAYOUT
*"* do not include other source files here!!!

  data GS_DATA type RN1_GUI_LAYO_SPLITTER_DATA .

  methods _GET_T_DATAREF
    redefinition .
private section.
*"* private components of class CL_ISH_GUI_SPLITTER_LAYOUT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_GUI_SPLITTER_LAYOUT IMPLEMENTATION.


METHOD constructor.

  super->constructor(
      i_element_name        = i_element_name
      i_layout_name         = i_layout_name ).

  gs_data-splitter_mode         = i_mode.
  gs_data-splitter_orientation  = i_orientation.
  gs_data-sash_movable          = i_sash_movable.
  gs_data-sash_position         = i_sash_position.
  gs_data-top_left_name         = i_top_left_name.
  gs_data-bottom_right_name     = i_bottom_right_name.
  gs_data-splitter_visibility   = i_splitter_visibility.

ENDMETHOD.


METHOD get_bottom_right_name.

  r_bottom_right_name = gs_data-bottom_right_name.

ENDMETHOD.


METHOD get_data.

  rs_data = gs_data.

ENDMETHOD.


METHOD get_mode.

  r_mode = gs_data-splitter_mode.

ENDMETHOD.


METHOD get_orientation.

  r_orientation = gs_data-splitter_orientation.

ENDMETHOD.


METHOD get_sash_movable.

  r_sash_movable = gs_data-sash_movable.

ENDMETHOD.


METHOD get_sash_position.

  r_sash_position = gs_data-sash_position.

ENDMETHOD.


METHOD get_splitter_visibility.

  r_splitter_visibility = gs_data-splitter_visibility.

ENDMETHOD.


METHOD get_top_left_name.

  r_top_left_name = gs_data-top_left_name.

ENDMETHOD.


METHOD set_mode.

  CHECK gs_data-splitter_mode <> i_mode.

  gs_data-splitter_mode = i_mode.

  r_changed = abap_true.

ENDMETHOD.


METHOD set_orientation.

  CHECK i_orientation <> gs_data-splitter_orientation.

  gs_data-splitter_orientation = i_orientation.

  r_changed = abap_true.

ENDMETHOD.


METHOD set_sash_movable.

  CHECK gs_data-sash_movable <> i_sash_movable.

  gs_data-sash_movable = i_sash_movable.

  r_changed = abap_true.

ENDMETHOD.


METHOD set_sash_position.

  CHECK gs_data-sash_position <> i_sash_position.

  gs_data-sash_position = i_sash_position.

  r_changed = abap_true.

ENDMETHOD.


METHOD set_splitter_visibility.

  CHECK i_splitter_visibility <> gs_data-splitter_visibility.

  gs_data-splitter_visibility = i_splitter_visibility.

  r_changed = abap_true.

ENDMETHOD.


METHOD _get_t_dataref.

  DATA lr_data            TYPE REF TO data.

  rt_dataref = super->_get_t_dataref( ).

  GET REFERENCE OF gs_data INTO lr_data.

  INSERT lr_data INTO TABLE rt_dataref.

ENDMETHOD.
ENDCLASS.
