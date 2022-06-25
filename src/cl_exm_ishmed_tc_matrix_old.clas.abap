class CL_EXM_ISHMED_TC_MATRIX_OLD definition
  public
  inheriting from CL_FB_ISHMED_TC_BUILD_MATRIX
  create public .

public section.
protected section.

  types:
    BEGIN OF LTY_N2_TC_INST_CUST,
      institution TYPE einri,
      param_n2bauftr TYPE ri_parval,
      param_n2batmp TYPE ri_parval,
    END OF LTY_N2_TC_INST_CUST .
  types:
    lty_t_n2_tc_inst_cust TYPE TABLE OF LTY_N2_TC_INST_CUST .
  types:
    BEGIN OF lty_bwart,
    einri         TYPE einri,
    bewty         TYPE bewty,
    bwart         TYPE ri_bwart,
  END OF lty_bwart .

  data GT_TC_PARAMETER type LTY_T_N2_TC_INST_CUST .
  constants CO_PAR_NAME_N2BATMP type ISH_PARAM value 'N2BATMP'. "#EC NOTEXT
  constants CO_PAR_NAME_N2BAUFTR type ISH_PARAM value 'N2BAUFTR'. "#EC NOTEXT
  data:
    GT_RANGE_MITARB TYPE RANGE OF n1mitarb .
  data:
    GT_RANGE_BERKAT type RANGE OF n2_berkat .
  data:
    GT_RANGE_OE TYPE RANGE OF orgid .

  methods INIT_OE
    importing
      !I_INSTITUTION_ID type EINRI
    returning
      value(RT_MATRIX_ROUGH) type RN1TC_MATRIX_ROUGH_T .
  methods READ_PARAMETER
    importing
      !I_INSTITUTION_ID type EINRI
    returning
      value(RS_PARAMETERS) type LTY_N2_TC_INST_CUST .
  methods BUILD_MATRIX_FROM_CUSTOMIZING1
    importing
      !I_INSTITUTION_ID type EINRI
      !I_UNAME type XUBNAME
    exporting
      !ET_TC_MATRIX type RN1TC_MATRIX_T .
  methods INIT_RANGE_MITARB
    importing
      !IS_PARAMETERS type LTY_N2_TC_INST_CUST .
  methods INIT_RANGE_BERKAT
    importing
      !I_INSTITUTION_ID type EINRI .

  methods BUILD_MATRIX_FROM_CUSTOMIZING
    redefinition .
private section.

  data G_INSTITUTION type EINRI .
ENDCLASS.



CLASS CL_EXM_ISHMED_TC_MATRIX_OLD IMPLEMENTATION.


METHOD build_matrix_from_customizing.
  DATA ls_parameter TYPE  lty_n2_tc_inst_cust.
*matrix in first read
  DATA lt_matrix_rough     TYPE rn1tc_matrix_rough_t.
*matrix in scond read
  DATA lt_matrix_hierarchy TYPE rn1tc_matrix_rough_t.

  CLEAR et_tc_matrix.


  ls_parameter = read_parameter( i_institution_id = i_institution_id ).

  CLEAR gt_range_mitarb.
  init_range_mitarb( ls_parameter ).
  CHECK lines( gt_range_mitarb ) GT 0.

  CLEAR gt_range_berkat.
  init_range_berkat( i_institution_id = i_institution_id ).
  CHECK lines( gt_range_berkat ) GT 0.


*get first read for Matrix
  lt_matrix_rough = init_oe( i_institution_id = i_institution_id ).
*check if any ou's for ou responsebility is available
  IF lines( lt_matrix_rough ) EQ 0.
    RETURN.
  ENDIF.

  lt_matrix_hierarchy = get_matrix_hierarchy_rough(  i_institution_id = i_institution_id
                                                     it_matrix_rough  = lt_matrix_rough ).

*    get_times_for_hierarchy_ou( EXPORTING i_institution_id = i_institution_id
*                                CHANGING  ct_matrix_rough = lt_matrix_hierarchy ).

  get_matrx_from_rough(
    IMPORTING
      rt_tc_matrix    = et_tc_matrix    " Die ou-USER Zuordungsmatrix des Behandlungsauftrages
    CHANGING
      it_matrix_rough = lt_matrix_hierarchy    " Behandlungsauftrag Matrix im Rohzustand
  ).

  SORT et_tc_matrix BY resp_type DESCENDING.

ENDMETHOD.


METHOD BUILD_MATRIX_FROM_CUSTOMIZING1.

ENDMETHOD.


  METHOD init_oe.
    DATA: lt_n2bkoe  TYPE TABLE OF n2bkoe,
          ls_n2bkoe  TYPE n2bkoe.

    DATA: ls_matrix_rough TYPE rn1tc_matrix_rough,
          ls_norg TYPE norg.

    SELECT * FROM n2bkoe INTO TABLE lt_n2bkoe
           WHERE einri = i_institution_id
           AND   berkat IN gt_range_berkat
           AND   begdt <= sy-datum
           AND   enddt  >= sy-datum.
    IF sy-subrc > 0.
      RETURN.
    ENDIF.

    LOOP AT lt_n2bkoe INTO ls_n2bkoe.
      CLEAR ls_matrix_rough.
      ls_norg = _get_norg( i_orgid = ls_n2bkoe-orgid ).
      IF ls_norg-fazuw = 'X'.
        ls_matrix_rough-resp_type = resp_type_patient.
        ls_matrix_rough-days_ext = ls_n2bkoe-bertg.
        ls_matrix_rough-days_appl = '99999'.
        ls_matrix_rough-deptou = ls_n2bkoe-orgid.
        ls_matrix_rough-treaou = '*'.
        APPEND ls_matrix_rough TO rt_matrix_rough.
      ELSEIF ls_norg-pfzuw = 'X' OR ls_norg-ambes = 'X'.
        ls_matrix_rough-resp_type = resp_type_patient.
        ls_matrix_rough-days_ext = ls_n2bkoe-bertg.
        ls_matrix_rough-days_appl = '99999'.
        ls_matrix_rough-deptou = '*'.
        ls_matrix_rough-treaou = ls_n2bkoe-orgid.
        APPEND ls_matrix_rough TO rt_matrix_rough.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.                    "GET_OUS_FOR_RESPONSIBILITIES


method INIT_RANGE_BERKAT.
  DATA: ls_range_betkat LIKE LINE OF gt_range_berkat .

  DATA: lt_n2mabk type table of n2mabk,
        ls_n2mabk type n2mabk.

  SELECT * FROM n2mabk INTO TABLE lt_n2mabk
         WHERE einri = i_institution_id
         AND   mitarb IN gt_range_mitarb
         AND   begdt <= sy-datum
         AND   enddt  >= sy-datum.
  IF sy-subrc > 0.
    clear gt_range_berkat.
    return.
  ENDIF.

  ls_range_betkat-option = 'EQ'.
  ls_range_betkat-sign   = 'I'.
  LOOP AT lt_n2mabk into ls_n2mabk.
    ls_range_betkat-low    = ls_n2mabk-berkat.
    append ls_range_betkat to gt_range_berkat.
  ENDLOOP.
endmethod.


method INIT_RANGE_MITARB.
  DATA: ls_range_mitarb LIKE LINE OF gt_range_mitarb .
  DATA: lt_tn2usrma TYPE TABLE OF tn2usrma,
        ls_tn2usrma TYPE tn2usrma.

  IF is_parameters-param_n2bauftr = 'B'.
    SELECT * FROM tn2usrma INTO TABLE lt_tn2usrma
           WHERE uname = sy-uname
           AND   begdt <= sy-datum
           AND   enddt  >= sy-datum.
    IF sy-subrc > 0.
      RETURN.                              "keinen gefunden ---> Ausstieg
    ENDIF.

    ls_range_mitarb-option = 'EQ'.
    ls_range_mitarb-sign   = 'I'.
    LOOP AT lt_tn2usrma INTO ls_tn2usrma.
      ls_range_mitarb-low    = ls_tn2usrma-mitarb.
      APPEND ls_range_mitarb TO gt_range_mitarb.
    ENDLOOP.
  ELSE.
    ls_range_mitarb-option = 'EQ'.
    ls_range_mitarb-sign   = 'I'.
    ls_range_mitarb-low    = sy-uname.
    APPEND ls_range_mitarb TO gt_range_mitarb.
  ENDIF.

endmethod.


method READ_PARAMETER.

  FIELD-SYMBOLS: <ls_para> TYPE LTY_N2_TC_INST_CUST.

  READ TABLE gt_tc_parameter ASSIGNING <ls_para> WITH KEY institution = i_institution_id.

  IF sy-subrc EQ 0.
    rs_parameters = <ls_para>.
  ELSE.
    rs_parameters-institution = i_institution_id.

    CALL FUNCTION 'ISH_TN00R_READ'
      EXPORTING
        ss_einri = i_institution_id
        ss_param = co_par_name_n2bauftr
      IMPORTING
        ss_value = rs_parameters-param_n2bauftr.


    CALL FUNCTION 'ISH_TN00R_READ'
      EXPORTING
        ss_einri = i_institution_id
        ss_param = co_par_name_n2batmp
      IMPORTING
        ss_value = rs_parameters-param_n2batmp.

    APPEND rs_parameters TO gt_tc_parameter.
  ENDIF.

endmethod.
ENDCLASS.
