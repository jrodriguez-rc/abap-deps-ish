class CL_ISH_ORDSP_MAIN_OBJECT definition
  public
  inheriting from CL_ISH_ORDSP_OBJECT
  abstract
  create public .

*"* public components of class CL_ISH_ORDSP_MAIN_OBJECT
*"* do not include other source files here!!!
public section.

  constants CO_FIELDNAME_EINRI type ISH_FIELDNAME value 'EINRI'. "#EC NOTEXT
  constants CO_FIELDNAME_ETRBY type ISH_FIELDNAME value 'ETRBY'. "#EC NOTEXT
  constants CO_FIELDNAME_ETRGP type ISH_FIELDNAME value 'ETRGP'. "#EC NOTEXT
  constants CO_FIELDNAME_ETROE type ISH_FIELDNAME value 'ETROE'. "#EC NOTEXT
  constants CO_FIELDNAME_ORDDEP type ISH_FIELDNAME value 'ORDDEP'. "#EC NOTEXT
  constants CO_FIELDNAME_PATNR type ISH_FIELDNAME value 'PATNR'. "#EC NOTEXT
  constants CO_FIELDNAME_REFTYP type ISH_FIELDNAME value 'REFTYP'. "#EC NOTEXT
  constants CO_FIELDNAME_R_PAP type ISH_FIELDNAME value 'R_PAP'. "#EC NOTEXT

  class CL_ISH_CORDER definition load .
  methods CONSTRUCTOR
    importing
      !IR_PARENT_NODE type ref to IF_ISH_GUI_PARENT_NODE_MODEL optional
      !IR_CB_TABMDL type ref to IF_ISH_GUI_CB_TABLE_MODEL optional
      !IR_CB_XTABMDL type ref to IF_ISH_GUI_CB_XTABLE_MODEL optional
      !I_ALLOWED_ENTRIES type I default CO_AE_ALL
      !I_EINRI type EINRI
      !I_REFTYP type N1CORDREFTYP default CL_ISH_CORDER=>CO_REFTYP_PAT
      !I_PATNR type PATNR optional
      !IR_PAP type ref to CL_ISH_PATIENT_PROVISIONAL optional
      !I_ETRBY type N1CORDETRBY default CL_ISH_CORDER=>CO_ETRBY_OE
      !I_ETROE type N1CORDETROE optional
      !I_ETRGP type N1CORDETRGP optional
      !I_ORDDEP type N1CORDDEP optional
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_EINRI
    returning
      value(R_EINRI) type EINRI .
  methods GET_ETRBY
    returning
      value(R_ETRBY) type N1CORDETRBY .
  methods GET_ETRGP
    returning
      value(R_ETRGP) type N1CORDETRGP .
  methods GET_ETROE
    returning
      value(R_ETROE) type N1CORDETROE .
  methods GET_ORDDEP
    returning
      value(R_ORDDEP) type N1CORDDEP .
  methods GET_PATNR
    returning
      value(R_PATNR) type PATNR .
  methods GET_REFTYP
    returning
      value(R_REFTYP) type N1CORDREFTYP .
  methods GET_R_PAP
    returning
      value(RR_PAP) type ref to CL_ISH_PATIENT_PROVISIONAL .

  methods IF_ISH_GUI_STRUCTURE_MODEL~GET_FIELD_CONTENT
    redefinition .
  methods IF_ISH_GUI_STRUCTURE_MODEL~GET_SUPPORTED_FIELDS
    redefinition .
protected section.
*"* protected components of class CL_ISH_ORDSP_MAIN_OBJECT
*"* do not include other source files here!!!

  data GR_PAP type ref to CL_ISH_PATIENT_PROVISIONAL .
  data G_EINRI type EINRI .
  data G_ETRBY type N1CORDETRBY .
  data G_ETRGP type N1CORDETRGP .
  data G_ETROE type N1CORDETROE .
  data G_ORDDEP type N1CORDDEP .
  data G_PATNR type PATNR .
  data G_REFTYP type N1CORDREFTYP .
private section.
*"* private components of class CL_ISH_ORDSP_MAIN_OBJECT
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_ORDSP_MAIN_OBJECT IMPLEMENTATION.


METHOD constructor.

  IF i_einri IS INITIAL.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'CONSTRUCTOR'
        i_mv3        = 'CL_ISH_ORDSP_MAIN_OBJECT' ).
  ENDIF.

  super->constructor(
      ir_parent_node    = ir_parent_node
      ir_cb_tabmdl      = ir_cb_tabmdl
      ir_cb_xtabmdl     = ir_cb_xtabmdl
      i_allowed_entries = i_allowed_entries ).

  g_einri   = i_einri.
  g_reftyp  = i_reftyp.
  g_patnr   = i_patnr.
  gr_pap    = ir_pap.
  g_etrby   = i_etrby.
  g_etroe   = i_etroe.
  g_etrgp   = i_etrgp.
  g_orddep  = i_orddep.

ENDMETHOD.


METHOD GET_EINRI.

  r_einri = g_einri.

ENDMETHOD.


METHOD GET_ETRBY.

  r_etrby = g_etrby.

ENDMETHOD.


METHOD GET_ETRGP.

  r_etrgp = g_etrgp.

ENDMETHOD.


METHOD GET_ETROE.

  r_etroe = g_etroe.

ENDMETHOD.


METHOD get_orddep.

  r_orddep = g_orddep.

ENDMETHOD.


METHOD GET_PATNR.

  r_patnr = g_patnr.

ENDMETHOD.


METHOD GET_REFTYP.

  r_reftyp = g_reftyp.

ENDMETHOD.


METHOD GET_R_PAP.

  rr_pap = gr_pap.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_field_content.

  DATA l_rc                           TYPE ish_method_rc.

  FIELD-SYMBOLS <l_content>           TYPE ANY.

  CASE i_fieldname.
    WHEN co_fieldname_einri.
      ASSIGN g_einri TO <l_content>.
    WHEN co_fieldname_etrby.
      ASSIGN g_etrby TO <l_content>.
    WHEN co_fieldname_etrgp.
      ASSIGN g_etrgp TO <l_content>.
    WHEN co_fieldname_etroe.
      ASSIGN g_etroe TO <l_content>.
    WHEN co_fieldname_orddep.
      ASSIGN g_orddep TO <l_content>.
    WHEN co_fieldname_patnr.
      ASSIGN g_patnr TO <l_content>.
    WHEN co_fieldname_reftyp.
      ASSIGN g_reftyp TO <l_content>.
    WHEN co_fieldname_r_pap.
      ASSIGN gr_pap TO <l_content>.
    WHEN OTHERS.
      RETURN.
  ENDCASE.

  CALL METHOD cl_ish_utl_gui_structure_model=>assign_content
    EXPORTING
      i_source = <l_content>
    IMPORTING
      e_rc     = l_rc
    CHANGING
      c_target = c_content.
  IF l_rc <> 0.
    cl_ish_utl_exception=>raise_static(
        i_typ        = 'E'
        i_kla        = 'N1BASE'
        i_num        = '030'
        i_mv1        = '1'
        i_mv2        = 'GET_FIELD_CONTENT'
        i_mv3        = 'CL_ISH_ORDSP_MAIN_OBJECT' ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_gui_structure_model~get_supported_fields.

  INSERT co_fieldname_einri         INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_etrby         INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_etrgp         INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_etroe         INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_orddep        INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_patnr         INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_reftyp        INTO TABLE rt_supported_fieldname.
  INSERT co_fieldname_r_pap         INTO TABLE rt_supported_fieldname.

ENDMETHOD.
ENDCLASS.
