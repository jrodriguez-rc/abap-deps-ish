class CL_ISH_CDO_GM_CDO definition
  public
  final
  create public .

*"* public components of class CL_ISH_CDO_GM_CDO
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_GUI_MODEL .
  interfaces IF_ISH_GUI_STRUCTURE_MODEL .

  aliases GET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GUI_STRUCTURE_MODEL~IS_FIELD_SUPPORTED .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GUI_STRUCTURE_MODEL~SET_FIELD_CONTENT .
  aliases EV_CHANGED
    for IF_ISH_GUI_STRUCTURE_MODEL~EV_CHANGED .

  methods CONSTRUCTOR
    importing
      value(IS_CDRED) type CDRED
    raising
      CX_ISH_STATIC_HANDLER .
  class-methods CREATE
    importing
      !IS_CDRED type CDRED
    returning
      value(RR_INSTANCE) type ref to CL_ISH_CDO_GM_CDO
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_DATA
    returning
      value(RS_CDREDDISP) type CDREDDISP .
protected section.
*"* protected components of class CL_ISH_CDO_GM_CDO
*"* do not include other source files here!!!

  data GS_CDREDDISP type RN1_CDREDDISP_MODEL .

  methods _ADD_DDIC_DETAILS .
  methods _ADD_DETAILS .
  methods _ADD_USER_DETAILS .
private section.
*"* private components of class CL_ISH_CDO_GM_CDO
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_CDO_GM_CDO IMPLEMENTATION.


METHOD constructor.

  IF is_cdred IS INITIAL.
    cl_ish_utl_exception=>raise_static(
    i_typ        = 'E'
    i_kla        = 'N1BASE'
    i_num        = '030'
    i_mv1        = '1'
    i_mv2        = 'CONSTRUCTOR'
    i_mv3        = 'CL_ISH_CDO_GM_CDOS' ).
  ENDIF.

  MOVE-CORRESPONDING is_cdred TO gs_cdreddisp.
  gs_cdreddisp-r_model = me.
  CALL METHOD me->_add_details.

ENDMETHOD.


METHOD create.

  CREATE OBJECT rr_instance
    EXPORTING
      is_cdred = is_cdred.

ENDMETHOD.


METHOD get_data.
  MOVE-CORRESPONDING gs_cdreddisp to rs_cdreddisp.
ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.
  CALL METHOD cl_ish_utl_gui_structure_model=>get_field_content
    EXPORTING
      ir_model    = me
      is_data     = gs_cdreddisp
      i_fieldname = i_fieldname
    CHANGING
      c_content   = c_content.
ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.
  rt_supported_fieldname = cl_ish_utl_gui_structure_model=>get_supported_fields(
      is_data = gs_cdreddisp ).
ENDMETHOD.


METHOD if_ish_gui_structure_model~is_field_supported.
  r_supported = cl_ish_utl_gui_structure_model=>is_field_supported(
                    is_data     = gs_cdreddisp
                    i_fieldname = i_fieldname ).
ENDMETHOD.


METHOD if_ish_gui_structure_model~set_field_content.
* No changes allowed.
ENDMETHOD.


METHOD _add_ddic_details.
  DATA: ls_dd02t      TYPE dd04t.
  DATA: lt_dfies      TYPE TABLE OF dfies,
        ls_dfies      TYPE dfies.
* ----- ----- -----
  IF gs_cdreddisp-tabname IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
  CLEAR ls_dd02t.
  SELECT SINGLE * FROM dd02t
      INTO ls_dd02t
      WHERE tabname  = gs_cdreddisp-tabname
      AND ddlanguage = sy-langu
      AND as4local   = 'A'
      AND as4vers    = '0000'.
  gs_cdreddisp-ddtext = ls_dd02t-ddtext.
* ----- ----- -----
  CALL FUNCTION 'DDIF_FIELDINFO_GET'
    EXPORTING
      tabname        = gs_cdreddisp-tabname
      fieldname      = gs_cdreddisp-fname
      langu          = sy-langu
    TABLES
      dfies_tab      = lt_dfies
    EXCEPTIONS
      not_found      = 1
      internal_error = 2
      OTHERS         = 3.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.

  CLEAR ls_dfies.
  READ TABLE lt_dfies INTO ls_dfies INDEX 1.
  IF sy-subrc = 0.
* ----- ----- -----
    gs_cdreddisp-scrtext_s = ls_dfies-scrtext_s.
    gs_cdreddisp-scrtext_m = ls_dfies-scrtext_m.
    gs_cdreddisp-scrtext_l = ls_dfies-scrtext_l.
    gs_cdreddisp-ftext     = ls_dfies-fieldtext.
  ENDIF.
* ----- ----- -----
ENDMETHOD.


METHOD _add_details.
  CALL METHOD me->_add_user_details.
  CALL METHOD me->_add_ddic_details.

ENDMETHOD.


METHOD _ADD_USER_DETAILS.

  DATA: ls_addr3_val TYPE addr3_val.
* ----- ----- -----
  IF gs_cdreddisp-username IS INITIAL.
    RETURN.
  ENDIF.
* ----- ----- -----
  CALL FUNCTION 'SUSR_USER_ADDRESS_READ'
    EXPORTING
      user_name              = gs_cdreddisp-username
    IMPORTING
      user_address           = ls_addr3_val
    EXCEPTIONS
      user_address_not_found = 1
      OTHERS                 = 2.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.
* ----- ----- -----
  gs_cdreddisp-name_first      = ls_addr3_val-name_first.
  gs_cdreddisp-name_last       = ls_addr3_val-name_last.
  gs_cdreddisp-department      = ls_addr3_val-department.
* ----- ----- -----
ENDMETHOD.
ENDCLASS.
