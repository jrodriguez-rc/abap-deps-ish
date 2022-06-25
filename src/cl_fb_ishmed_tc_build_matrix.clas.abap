class CL_FB_ISHMED_TC_BUILD_MATRIX definition
  public
  create public .

public section.

  interfaces IF_BADI_INTERFACE .
  interfaces IF_EX_ISHMED_BUILD_MATRIX .
  interfaces IF_ISHMED_TC_CONSTANT_DEF .

  class-methods CLASS_CONSTRUCTOR .
protected section.

  aliases CLASSIFICATION_DIS
    for IF_ISHMED_TC_CONSTANT_DEF~CO_TC_CLASSIFICATION_DIS .
  aliases CLASSIFICATION_ORG
    for IF_ISHMED_TC_CONSTANT_DEF~CO_TC_CLASSIFICATION_ORG .
  aliases DAYS_APPL_MAX
    for IF_ISHMED_TC_CONSTANT_DEF~CO_TC_DAYS_APPL_MAX .
  aliases DAYS_APPL_MIN
    for IF_ISHMED_TC_CONSTANT_DEF~CO_TC_DAYS_APPL_MIN .
  aliases DAYS_EXT_MAX
    for IF_ISHMED_TC_CONSTANT_DEF~CO_TC_DAYS_EXT_MAX .
  aliases DAYS_EXT_MIN
    for IF_ISHMED_TC_CONSTANT_DEF~CO_TC_DAYS_EXT_MIN .
  aliases RESP_TYPE_CASE
    for IF_ISHMED_TC_CONSTANT_DEF~CO_RESP_TYPE_CASE .
  aliases RESP_TYPE_PATIENT
    for IF_ISHMED_TC_CONSTANT_DEF~CO_RESP_TYPE_PATIENT .

  class-data G_STD_DAYS_EXT type N1TC_DAYS_EXT value DAYS_EXT_MIN ##NO_TEXT.
  class-data G_STD_DAYS_APPL type N1TC_DAYS_APPL value DAYS_APPL_MIN ##NO_TEXT.
  data GT_NORG type ISH_T_NORG .
  class-data G_INACTIVE_DAYS type N1TC_INACTIVE_DAYS value 0 ##NO_TEXT.

  methods BUILD_MATRIX_FROM_CUSTOMIZING
    importing
      !I_INSTITUTION_ID type EINRI
      !I_UNAME type XUBNAME
    exporting
      !ET_TC_MATRIX type RN1TC_MATRIX_T .
  methods GET_ALL_DEPT_OU
    importing
      !I_INSTITUTION_ID type EINRI
      !IS_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH
    returning
      value(RT_HIERARCHY_MATRIX) type RN1TC_MATRIX_ROUGH_T .
  methods GET_INTER_OU
    importing
      !I_INSTITUTION_ID type EINRI
      !IS_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH
    returning
      value(RT_HIERARCHY_MATRIX) type RN1TC_MATRIX_ROUGH_T .
  methods GET_HIERARCHY_FOR_ALL
    importing
      !I_INSTITUTION_ID type EINRI
      !IS_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH
    returning
      value(RT_HIERARCHY_MATRIX) type RN1TC_MATRIX_ROUGH_T .
  methods GET_HIERARCHY_FOR_OU
    importing
      !I_INSTITUTION_ID type EINRI
      !IS_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH
    changing
      !CT_HIERARCHY_MATRIX type RN1TC_MATRIX_ROUGH_T .
  methods GET_MATRIX_HIERARCHY_ROUGH
    importing
      !I_INSTITUTION_ID type EINRI
      value(IT_MATRIX_ROUGH) type RN1TC_MATRIX_ROUGH_T
    returning
      value(RT_HIERARCHY_MATRIX) type RN1TC_MATRIX_ROUGH_T .
  methods GET_MATRX_FROM_ROUGH
    exporting
      value(RT_TC_MATRIX) type RN1TC_MATRIX_T
    changing
      !IT_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH_T .
  methods GET_OUS_FOR_RESPONSIBILITIES
    importing
      !I_INSTITUTION_ID type EINRI
      !IT_OU_RESP type RN1TC_OU_RESP_T
    returning
      value(RT_MATRIX_ROUGH) type RN1TC_MATRIX_ROUGH_T .
  methods GET_OUS_FOR_RESPONSIBILITY
    importing
      !I_INSTITUTION_ID type EINRI
      !IS_OU_RESP type RN1TC_OU_RESP
    returning
      value(RT_MATRIX_ROUGH) type RN1TC_MATRIX_ROUGH_T .
  methods GET_OU_RESPONSIBILITY_FOR_ROLE
    importing
      !I_ROLE type AGR_NAME
    changing
      !CT_OU_RESP type RN1TC_OU_RESP_T .
  methods GET_OU_RESPONSIBILITY_ROLES
    importing
      !IT_ROLE type RN1TC_ROLE_T
    returning
      value(RT_OU_RESP) type RN1TC_OU_RESP_T .
  methods GET_ROLES_FOR_USER
    importing
      !I_UNAME type XUBNAME
    returning
      value(RT_ROLES) type RN1TC_ROLE_T .
  methods GET_TIMES_FOR_HIERARCHY_OU
    importing
      !I_INSTITUTION_ID type EINRI
    changing
      !CT_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH_T .
  methods GET_TIME_FOR_INSTITUTION
    importing
      !I_INSTITUTION_ID type EINRI
    changing
      !CS_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH .
  methods GET_TIME_FOR_DEFAULT
    changing
      !CS_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH .
  methods GET_TIME_FOR_OU
    importing
      !I_INSTITUTION_ID type EINRI
    changing
      !CS_MATRIX_ROUGH type RN1TC_MATRIX_ROUGH .
  methods LOAD_MATRIX
    importing
      !I_INSTITUTION_ID type EINRI
    exporting
      !ET_TC_MATRIX type RN1TC_MATRIX_T .
  methods SAVE_MATRIX
    importing
      !I_INSTITUTION_ID type EINRI
      !IT_TC_MATRIX type RN1TC_MATRIX_T .
  methods _GET_NORG
    importing
      !I_ORGID type ORGID
    returning
      value(RS_NORG) type NORG .
private section.

  data G_FIRST_TIME type ABAP_BOOL .
  data G_ALTERNATIVE_MATRIX type ABAP_BOOL .

  methods SAVE_MATRIX_HIERARCHY
    importing
      !I_INSTITUTION_ID type EINRI
      !IT_MATRIX_HIERARCHY type RN1TC_MATRIX_ROUGH_T .
  methods _GET_OU_HIERARCHY
    importing
      !I_INSTITUTION_ID type EINRI
      !I_ORGID type ORGID
    returning
      value(RT_NORG) type ISH_T_NORG .
  methods LOAD_INACTIVE_DAYS
    importing
      !I_INSTITUTION_ID type EINRI .
  methods LOAD_MATRIX_HIERARCHY
    importing
      !I_INSTITUTION_ID type EINRI
    exporting
      !ET_MATRIX_HIERARCHY type RN1TC_MATRIX_ROUGH_T
    changing
      !CT_OU_RESP type RN1TC_OU_RESP_T .
ENDCLASS.



CLASS CL_FB_ISHMED_TC_BUILD_MATRIX IMPLEMENTATION.


  METHOD build_matrix_from_customizing.
*role
    DATA lt_role TYPE rn1tc_role_t.
*ou respos
    DATA lt_ou_resp TYPE rn1tc_ou_resp_t.
*matrix in first read
    DATA lt_matrix_rough     TYPE rn1tc_matrix_rough_t.
*matrix in scond read
    DATA lt_matrix_hierarchy TYPE rn1tc_matrix_rough_t.
* BEGIN MED-74287
    DATA lt_matrix_hierarchy_new TYPE rn1tc_matrix_rough_t.
* END MED-74287

    CLEAR et_tc_matrix.

*read roles for user
    lt_role = get_roles_for_user( i_uname ).
*check if any role is available
    IF lines( lt_role ) EQ 0.
      RETURN.
    ENDIF.

*get ou responsibility for roles Table N1tc_ou_Resp_role
    lt_ou_resp = get_ou_responsibility_roles( lt_role ).
*check if any ou responsebility is available
    IF lines( lt_ou_resp ) EQ 0.
      RETURN.
    ENDIF.

* BEGIN MED-70070
* Load hierarchy from buffer for defined OU-responsibilities and valid date
    load_matrix_hierarchy(
      EXPORTING i_institution_id = i_institution_id
      IMPORTING et_matrix_hierarchy = lt_matrix_hierarchy
      CHANGING  ct_ou_resp = lt_ou_resp ).

    IF  lines( lt_matrix_hierarchy ) GT 0
    AND lines( lt_ou_resp ) EQ 0.
      get_matrx_from_rough(
         IMPORTING
           rt_tc_matrix    = et_tc_matrix    " Die ou-USER Zuordungsmatrix des Behandlungsauftrages
         CHANGING
           it_matrix_rough = lt_matrix_hierarchy    " Behandlungsauftrag Matrix im Rohzustand
       ).

      SORT et_tc_matrix BY  classification DESCENDING resp_type DESCENDING.

      RETURN.
    ENDIF.
* END MED-70070

*get first read for Matrix
    lt_matrix_rough = get_ous_for_responsibilities(
                        i_institution_id = i_institution_id
                        it_ou_resp       = lt_ou_resp ).
*check if any ou's for ou responsebility is available
    IF lines( lt_matrix_rough ) EQ 0.
* BEGIN MED-74287
      IF lines( lt_matrix_hierarchy ) GT 0.
        get_matrx_from_rough(
           IMPORTING
             rt_tc_matrix    = et_tc_matrix    " Die ou-USER Zuordungsmatrix des Behandlungsauftrages
           CHANGING
             it_matrix_rough = lt_matrix_hierarchy    " Behandlungsauftrag Matrix im Rohzustand
         ).

        SORT et_tc_matrix BY  classification DESCENDING resp_type DESCENDING.
      ENDIF.
* END MED-74287
      RETURN.
    ENDIF.

* BEGIN MED-74287
    lt_matrix_hierarchy_new = get_matrix_hierarchy_rough(  i_institution_id = i_institution_id
                                                       it_matrix_rough  = lt_matrix_rough ).

    get_times_for_hierarchy_ou( EXPORTING i_institution_id = i_institution_id
                                CHANGING  ct_matrix_rough = lt_matrix_hierarchy_new ).

* BEGIN MED-70070
* Save hierarchy in DB buffer
    save_matrix_hierarchy( i_institution_id    = i_institution_id
                           it_matrix_hierarchy = lt_matrix_hierarchy_new ).
* END MED-70070

    APPEND LINES OF lt_matrix_hierarchy_new TO lt_matrix_hierarchy.

    SORT lt_matrix_hierarchy.
    DELETE ADJACENT DUPLICATES FROM lt_matrix_hierarchy.
* END MED-74287

    get_matrx_from_rough(
      IMPORTING
        rt_tc_matrix    = et_tc_matrix    " Die ou-USER Zuordungsmatrix des Behandlungsauftrages
      CHANGING
        it_matrix_rough = lt_matrix_hierarchy    " Behandlungsauftrag Matrix im Rohzustand
    ).

    SORT et_tc_matrix BY  classification DESCENDING resp_type DESCENDING.


  ENDMETHOD.                    "build_matrix_from_customizing


  METHOD class_constructor.

    g_std_days_ext   = days_ext_min.
    g_std_days_appl  = days_appl_min.

*** Inactive OUs will still be considered, if they    ***
*** have been active within a specific amount of days ***
*  MED-70775 Cip - comment the next line beacause we take this value from customizing now
*    g_inactive_days  = 500.                           " MED-68399 Note 2645299 Bi

  ENDMETHOD.                    "CLASS_CONSTRUCTOR


METHOD GET_ALL_DEPT_OU.
  DATA ls_hierarchy_matrix TYPE rn1tc_matrix_rough.
  DATA lt_hierarchy_matrix TYPE rn1tc_matrix_rough_t.

  MOVE-CORRESPONDING is_matrix_rough to ls_hierarchy_matrix.
  ls_hierarchy_matrix-deptou = '*'.
  ls_hierarchy_matrix-treaou = '*'.
  lt_hierarchy_matrix = get_hierarchy_for_all( i_institution_id = i_institution_id is_matrix_rough = ls_hierarchy_matrix ).


  CLEAR ls_hierarchy_matrix.
  loop at lt_hierarchy_matrix into ls_hierarchy_matrix.
    if ls_hierarchy_matrix-treaou is INITIAL and ls_hierarchy_matrix-deptou is not INITIAL.
      append ls_hierarchy_matrix to rt_hierarchy_matrix.
    ENDIF.
  endloop.

ENDMETHOD.


METHOD get_hierarchy_for_all.
  DATA: lt_norg_read  TYPE ish_t_rnorghi,
        ls_norg       TYPE norg,
        l_fach        TYPE flag.

  DATA ls_hierarchy_matrix TYPE rn1tc_matrix_rough.
  DATA lt_hierarchy_matrix TYPE rn1tc_matrix_rough_t.
  DATA l_starting_date     TYPE dats.                 " MED-68399 Note 2645299 Bi

  FIELD-SYMBOLS: <ls_norg_read> TYPE rnorghi.

  CLEAR l_fach.

  IF is_matrix_rough-deptou NE '*'.
    IF is_matrix_rough-deptou IS NOT INITIAL.
      ls_norg = _get_norg( i_orgid = is_matrix_rough-deptou ).
      IF ls_norg-fazuw = 'X'.
        l_fach = 'X'.
        MOVE-CORRESPONDING is_matrix_rough TO ls_hierarchy_matrix.
        CLEAR ls_hierarchy_matrix-treaou.
        ls_hierarchy_matrix-classification = classification_Dis.
        APPEND ls_hierarchy_matrix TO rt_hierarchy_matrix.
      ELSEIF ls_norg-pfzuw = 'X' OR ls_norg-ambes = 'X'.
        MOVE-CORRESPONDING is_matrix_rough TO ls_hierarchy_matrix.
        ls_hierarchy_matrix-treaou = ls_hierarchy_matrix-deptou.
        ls_hierarchy_matrix-classification = classification_dis.
        CLEAR ls_hierarchy_matrix-deptou.
        APPEND ls_hierarchy_matrix TO rt_hierarchy_matrix.
      ENDIF.
    ENDIF.
  ENDIF.

  l_starting_date = sy-datum - g_inactive_days.       " MED-68399 Note 2645299 Bi

*use the ishmed FB because of functinality! in case of package violation use
*not ISHMED_FIND_ou_HIERARCHIE
  CALL FUNCTION 'ISH_FIND_ORG_HIERARCHY_LTD'
    EXPORTING
      ending_date          = sy-datum
      entry_org_unit       = is_matrix_rough-deptou
*      starting_date        = sy-datum
      starting_date        = l_starting_date          " MED-68399 Note 2645299 Bi
      interdisz            = 'X'
      einri                = i_institution_id
    TABLES
      back_tab             = lt_norg_read
    EXCEPTIONS
      wrong_entry_org_unit = 1
      wrong_entry_einri    = 2
      OTHERS               = 3.
  IF sy-subrc <> 0.
    RETURN.
  ENDIF.


  IF lines( lt_norg_read ) < 2.
    RETURN.
  ENDIF.

  LOOP AT lt_norg_read ASSIGNING <ls_norg_read> WHERE level = 1 or level = 2.
    IF is_matrix_rough-deptou = <ls_norg_read>-orgid.
      CONTINUE.
    ENDIF.
    if is_matrix_rough-deptou = '*' and <ls_norg_read>-level = 2.
      CONTINUE.
    endif.
    CLEAR ls_norg.
    ls_norg = _get_norg( i_orgid = <ls_norg_read>-orgid ).
    IF ls_norg-fazuw = 'X'.
      MOVE-CORRESPONDING is_matrix_rough TO ls_hierarchy_matrix.
      ls_hierarchy_matrix-deptou = ls_norg-orgid.
      ls_hierarchy_matrix-treaou = '*'.

        CLEAR lt_hierarchy_matrix.
        get_hierarchy_for_ou(
          EXPORTING
            i_institution_id    = i_institution_id    " IS-H: Einrichtung
            is_matrix_rough     = ls_hierarchy_matrix    " Behandlungsauftrag Matrix im Rohzustand
          CHANGING
            ct_hierarchy_matrix = lt_hierarchy_matrix     " Behandlungsauftrag Matrix im Rohzustand
        ).
        APPEND LINES OF lt_hierarchy_matrix TO rt_hierarchy_matrix.





*      CLEAR lt_hierarchy_matrix.
*      lt_hierarchy_matrix = get_hierarchy_for_all( i_institution_id = i_institution_id is_matrix_rough = ls_hierarchy_matrix ).
*      APPEND LINES OF lt_hierarchy_matrix TO rt_hierarchy_matrix..
    ELSEIF ls_norg-pfzuw = 'X' OR ls_norg-ambes = 'X'.
      IF l_fach = 'X'.
        MOVE-CORRESPONDING is_matrix_rough TO ls_hierarchy_matrix.
        ls_hierarchy_matrix-treaou = ls_norg-orgid.
        ls_hierarchy_matrix-classification = classification_org.
        APPEND ls_hierarchy_matrix TO rt_hierarchy_matrix.
      ELSE.
        MOVE-CORRESPONDING is_matrix_rough TO ls_hierarchy_matrix.
        CLEAR ls_hierarchy_matrix-deptou.
        ls_hierarchy_matrix-treaou = ls_norg-orgid.
        ls_hierarchy_matrix-classification = classification_dis.
        APPEND ls_hierarchy_matrix TO rt_hierarchy_matrix.
      ENDIF.
*      CLEAR lt_hierarchy_matrix.
*      ls_hierarchy_matrix-deptou = ls_norg-orgid.
*      ls_hierarchy_matrix-treaou = '*'.
*      lt_hierarchy_matrix = get_hierarchy_for_all( i_institution_id = i_institution_id is_matrix_rough = ls_hierarchy_matrix ).
*      APPEND LINES OF lt_hierarchy_matrix TO rt_hierarchy_matrix.
*
      ELSE.
        MOVE-CORRESPONDING is_matrix_rough TO ls_hierarchy_matrix.
        ls_hierarchy_matrix-deptou = ls_norg-orgid.
        ls_hierarchy_matrix-treaou = '*'.
        lt_hierarchy_matrix = get_hierarchy_for_all( i_institution_id = i_institution_id is_matrix_rough = ls_hierarchy_matrix ).
        APPEND LINES OF lt_hierarchy_matrix TO rt_hierarchy_matrix.
    ENDIF.
  ENDLOOP.
*
*  if lines( lt_hierarchy_matrix ) > 0.
*    rt_hierarchy_matrix = get_matrix_hierarchy_rough(  i_institution_id = i_institution_id
*                                                       it_matrix_rough  = lt_hierarchy_matrix ).
*  endif.

ENDMETHOD.


  METHOD get_hierarchy_for_ou.
    DATA lt_norg TYPE ish_t_norg.
    DATA ls_hierarchy_matrix TYPE rn1tc_matrix_rough.
    DATA ls_matrix_rough TYPE rn1tc_matrix_rough.

    FIELD-SYMBOLS: <ls_norg> TYPE norg,
                   <ls_hierarchy_check> TYPE rn1tc_matrix_rough.

*  CLEAR ct_hierarchy_matrix.
    CLEAR ls_matrix_rough.


    lt_norg = _get_ou_hierarchy(
        i_institution_id = i_institution_id
        i_orgid          = is_matrix_rough-deptou
    ).

    LOOP AT lt_norg ASSIGNING <ls_norg>.
      CLEAR ls_hierarchy_matrix.
      MOVE-CORRESPONDING is_matrix_rough TO ls_hierarchy_matrix.
      CLEAR ls_hierarchy_matrix-treaou.

      IF <ls_norg>-fazuw = 'X'.
        ls_matrix_rough = is_matrix_rough.
        ls_matrix_rough-deptou = <ls_norg>-orgid.
        get_hierarchy_for_ou(
          EXPORTING
            i_institution_id    = i_institution_id    " IS-H: Einrichtung
            is_matrix_rough     = ls_matrix_rough    " Behandlungsauftrag Matrix im Rohzustand
          CHANGING
            ct_hierarchy_matrix = ct_hierarchy_matrix    " Behandlungsauftrag Matrix im Rohzustand
        ).
      ELSE.
* at first all ou that not FA will use -- That's more we need, but dosen_t matter
*    ELSEIF <ls_norg>-ambes = 'X' OR <ls_norg>-pfzuw = 'X'.
        ls_hierarchy_matrix-treaou = <ls_norg>-orgid.
        ls_hierarchy_matrix-classification = 'O'.
* check if cust of ou with all date will bring a loop
        READ TABLE ct_hierarchy_matrix ASSIGNING <ls_hierarchy_check>
    WITH KEY deptou = ls_hierarchy_matrix-deptou
             treaou = ls_hierarchy_matrix-treaou.
        IF sy-subrc = 0.
          RETURN.
        ELSE.
          APPEND ls_hierarchy_matrix TO ct_hierarchy_matrix.
        ENDIF.
      ENDIF.
    ENDLOOP.

    CLEAR ls_hierarchy_matrix.
    MOVE-CORRESPONDING is_matrix_rough TO ls_hierarchy_matrix.
    CLEAR ls_hierarchy_matrix-treaou.
    ls_hierarchy_matrix-classification = 'F'.
* check if cust of ou with all date will bring a loop
    READ TABLE ct_hierarchy_matrix ASSIGNING <ls_hierarchy_check>
         WITH KEY deptou = ls_hierarchy_matrix-deptou
                  treaou = ls_hierarchy_matrix-treaou.
    IF sy-subrc = 0.
      RETURN.
    ELSE.
      APPEND ls_hierarchy_matrix TO ct_hierarchy_matrix.
    ENDIF.

  ENDMETHOD.                    "GET_HIERARCHY_FOR_OU


METHOD GET_INTER_OU.
  DATA ls_hierarchy_matrix TYPE rn1tc_matrix_rough.
  DATA lt_hierarchy_matrix TYPE rn1tc_matrix_rough_t.

  MOVE-CORRESPONDING is_matrix_rough to ls_hierarchy_matrix.
  ls_hierarchy_matrix-deptou = '*'.
  ls_hierarchy_matrix-treaou = '*'.
  lt_hierarchy_matrix = get_hierarchy_for_all( i_institution_id = i_institution_id is_matrix_rough = ls_hierarchy_matrix ).


  CLEAR ls_hierarchy_matrix.
  loop at lt_hierarchy_matrix into ls_hierarchy_matrix.
    if ls_hierarchy_matrix-treaou = is_matrix_rough-treaou.
      append ls_hierarchy_matrix to rt_hierarchy_matrix.
    ENDIF.
  endloop.

ENDMETHOD.


  METHOD get_matrix_hierarchy_rough.
    DATA lt_temp_hierarchy TYPE rn1tc_matrix_rough_t.
    FIELD-SYMBOLS: <ls_matrix_rough> TYPE rn1tc_matrix_rough.


    LOOP AT it_matrix_rough ASSIGNING <ls_matrix_rough>.
      IF <ls_matrix_rough>-deptou EQ '*'.
        IF <ls_matrix_rough>-treaou EQ '*'.   " * * entry
*         +++ begin  inactivation +++       Ba MED-55043, note 2002782
*         CLEAR rt_hierarchy_matrix.
*         rt_hierarchy_matrix = get_hierarchy_for_all( i_institution_id = i_institution_id
*                                                       is_matrix_rough = <ls_matrix_rough> ).
*         RETURN.
*         +++ end  inactivation +++         Ba MED-55043, note 2002782

*         +++ begin   +++                   Ba MED-55043, note 2002782
* MED-73352 Begin
          IF  me->g_alternative_matrix NE abap_true.
            CLEAR lt_temp_hierarchy.
            lt_temp_hierarchy = get_hierarchy_for_all( i_institution_id = i_institution_id
                                                       is_matrix_rough = <ls_matrix_rough> ).

            APPEND LINES OF lt_temp_hierarchy TO rt_hierarchy_matrix.
*           +++ end     +++                    Ba MED-55043, note 2002782
          ELSE.
            CLEAR lt_temp_hierarchy.
            <ls_matrix_rough>-classification = '*'.
            APPEND <ls_matrix_rough> TO rt_hierarchy_matrix.
          ENDIF.
* MED-73352 End
        ELSEIF <ls_matrix_rough>-treaou IS INITIAL.  " * INITAL entry
          CLEAR lt_temp_hierarchy.
          lt_temp_hierarchy = get_all_dept_ou(
            i_institution_id    = i_institution_id    " IS-H: Einrichtung
            is_matrix_rough     = <ls_matrix_rough>    " Behandlungsauftrag Matrix im Rohzustand
        ).
          APPEND LINES OF lt_temp_hierarchy TO rt_hierarchy_matrix.
        ELSE. " * X entry
          CLEAR lt_temp_hierarchy.
          lt_temp_hierarchy = get_inter_ou(
            i_institution_id    = i_institution_id    " IS-H: Einrichtung
            is_matrix_rough     = <ls_matrix_rough>    " Behandlungsauftrag Matrix im Rohzustand
        ).
          APPEND LINES OF lt_temp_hierarchy TO rt_hierarchy_matrix.
        ENDIF.
      ELSEIF <ls_matrix_rough>-treaou IS INITIAL.  " X Inital Entry
        <ls_matrix_rough>-classification = 'F'.
        APPEND <ls_matrix_rough> TO rt_hierarchy_matrix.
      ELSEIF <ls_matrix_rough>-treaou EQ '*'.     " X * Entry
        CLEAR lt_temp_hierarchy.
        get_hierarchy_for_ou(
          EXPORTING
            i_institution_id    = i_institution_id    " IS-H: Einrichtung
            is_matrix_rough     = <ls_matrix_rough>    " Behandlungsauftrag Matrix im Rohzustand
          CHANGING
            ct_hierarchy_matrix = lt_temp_hierarchy     " Behandlungsauftrag Matrix im Rohzustand
        ).
        APPEND LINES OF lt_temp_hierarchy TO rt_hierarchy_matrix.
      ELSE.   " X Y Entry
        <ls_matrix_rough>-classification = 'O'.
        APPEND <ls_matrix_rough> TO rt_hierarchy_matrix.
      ENDIF.
    ENDLOOP.

*MED-70070 BEGIN
    SORT rt_hierarchy_matrix.
    DELETE ADJACENT DUPLICATES FROM rt_hierarchy_matrix.
*MED-70070 END

  ENDMETHOD.                    "get_matrix_hierarchy_rough


  METHOD get_matrx_from_rough.

    FIELD-SYMBOLS: <ls_matrix_rough> TYPE rn1tc_matrix_rough,
                   <ls_matrix> TYPE rn1tc_matrix.

    SORT it_matrix_rough BY deptou treaou ASCENDING resp_type DESCENDING.

    LOOP AT it_matrix_rough ASSIGNING <ls_matrix_rough>.
      READ TABLE rt_tc_matrix ASSIGNING <ls_matrix> WITH KEY
        deptou = <ls_matrix_rough>-deptou
        treaou = <ls_matrix_rough>-treaou.
*        resp_type = <ls_matrix_rough>-resp_type.
      IF sy-subrc = 0.
        IF <ls_matrix>-resp_type = resp_type_patient AND <ls_matrix_rough>-resp_type = resp_type_case.
          CONTINUE.
        ELSEIF <ls_matrix>-resp_type = resp_type_case AND <ls_matrix_rough>-resp_type = resp_type_patient.
          <ls_matrix>-resp_type = <ls_matrix_rough>-resp_type.
          <ls_matrix>-days_ext = <ls_matrix_rough>-days_ext.
          <ls_matrix>-days_appl = <ls_matrix_rough>-days_appl.
        ELSE.
          IF <ls_matrix>-days_ext LT <ls_matrix_rough>-days_ext.
            <ls_matrix>-days_ext = <ls_matrix_rough>-days_ext.
          ENDIF.
          IF <ls_matrix>-days_appl LT <ls_matrix_rough>-days_appl.
            <ls_matrix>-days_appl = <ls_matrix_rough>-days_appl.
          ENDIF.
        ENDIF.
      ELSE.
        APPEND INITIAL LINE TO rt_tc_matrix ASSIGNING <ls_matrix>.
        MOVE-CORRESPONDING <ls_matrix_rough> TO <ls_matrix>.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.                    "get_matrx_from_rough


  METHOD get_ous_for_responsibilities.
    DATA lt_matrix_rough TYPE rn1tc_matrix_rough_t.
    FIELD-SYMBOLS: <ls_ou_resp> TYPE rn1tc_ou_resp.


    LOOP AT it_ou_resp ASSIGNING <ls_ou_resp>.
      CLEAR lt_matrix_rough.
      lt_matrix_rough = get_ous_for_responsibility(
          i_institution_id = i_institution_id
          is_ou_resp       = <ls_ou_resp>
      ).
      APPEND LINES OF lt_matrix_rough TO rt_matrix_rough.
    ENDLOOP.

  ENDMETHOD.                    "GET_OUS_FOR_RESPONSIBILITIES


  METHOD get_ous_for_responsibility.
    DATA: lt_ou_resp_ou TYPE TABLE OF tn1tc_ou_resp_ou,
          ls_matrix_rough TYPE rn1tc_matrix_rough.
    FIELD-SYMBOLS: <ls_ou_resp_ou> TYPE tn1tc_ou_resp_ou.


    SELECT * FROM tn1tc_ou_resp_ou INTO TABLE lt_ou_resp_ou
      WHERE institution_id = i_institution_id
        AND ou_resp = is_ou_resp-ou_resp
        AND delflag NE 'X'.

    LOOP AT lt_ou_resp_ou ASSIGNING <ls_ou_resp_ou>.
      MOVE-CORRESPONDING <ls_ou_resp_ou> TO ls_matrix_rough.
      MOVE-CORRESPONDING is_ou_resp TO ls_matrix_rough.
      APPEND ls_matrix_rough TO rt_matrix_rough.
    ENDLOOP.

  ENDMETHOD.                    "GET_OUS_FOR_RESPONSIBILITY


  METHOD get_ou_responsibility_for_role.
    DATA: lt_ou_resp_role TYPE TABLE OF tn1tc_resp_role,
         ls_ou_resp TYPE rn1tc_ou_resp.

    FIELD-SYMBOLS: <ls_ou_resp>      TYPE rn1tc_ou_resp,
                   <ls_ou_resp_role> TYPE tn1tc_resp_role.


    SELECT * FROM tn1tc_resp_role INTO TABLE lt_ou_resp_role
             WHERE agr_name = i_role
               AND begdt LE sy-datum
               AND enddt GE sy-datum. "#EC CI_GENBUFF

    LOOP AT lt_ou_resp_role ASSIGNING <ls_ou_resp_role>.
      CLEAR ls_ou_resp.
      SELECT SINGLE resp_type FROM tn1tc_ou_resp INTO ls_ou_resp-resp_type
         WHERE ou_resp = <ls_ou_resp_role>-ou_resp.

      READ TABLE ct_ou_resp ASSIGNING <ls_ou_resp> WITH KEY ou_resp = <ls_ou_resp_role>-ou_resp.
      IF sy-subrc = 0.
        IF ls_ou_resp-resp_type = resp_type_patient.
          <ls_ou_resp>-resp_type = ls_ou_resp-resp_type.
        ENDIF.
      ELSE.
        ls_ou_resp-ou_resp = <ls_ou_resp_role>-ou_resp.
        APPEND ls_ou_resp TO ct_ou_resp.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.                    "get_ou_responsibility_for_role


  METHOD get_ou_responsibility_roles.
    DATA l_role TYPE agr_name.

    LOOP AT it_role INTO l_role.
      get_ou_responsibility_for_role( EXPORTING i_role = l_role CHANGING ct_ou_resp = rt_ou_resp ).
    ENDLOOP.
  ENDMETHOD.                    "GET_ou_RESPONSIBILITY_ROLES


  METHOD get_roles_for_user.
    DATA: lt_roles    TYPE rn1tc_role_t,
          l_refuser   TYPE us_refus.

* read all roles for user
    SELECT agr_name FROM agr_users INTO TABLE rt_roles WHERE uname = i_uname
                                                         AND from_dat LE sy-datum
                                                         AND to_dat GE sy-datum. "#EC CI_GENBUFF

* MED-61649: Begin
* add Ref user if needed.
    CLEAR l_refuser.
    SELECT SINGLE refuser FROM usrefus INTO l_refuser WHERE bname = i_uname. "#EC CI_GENBUFF
    IF l_refuser IS NOT INITIAL.
      CLEAR lt_roles.
* read all roles for user
      SELECT agr_name FROM agr_users INTO TABLE lt_roles WHERE uname = l_refuser
                                                           AND from_dat LE sy-datum
                                                           AND to_dat GE sy-datum. "#EC CI_GENBUFF

      APPEND LINES OF lt_roles to rt_roles.
      SORT rt_roles.
      DELETE ADJACENT DUPLICATES FROM rt_roles.
    ENDIF.
* MED-61649: End

  ENDMETHOD.                    "get_roles_for_user


 METHOD get_times_for_hierarchy_ou.
*    DATA lt_temp_hierarchy TYPE rn1tc_matrix_rough_t.

   FIELD-SYMBOLS: <ls_matrix_rough> TYPE rn1tc_matrix_rough.

   LOOP AT ct_matrix_rough ASSIGNING <ls_matrix_rough>.
     get_time_for_ou(
       EXPORTING
         i_institution_id = i_institution_id    " IS-H: Einrichtung
       CHANGING
         cs_matrix_rough  = <ls_matrix_rough>    " Behandlungsauftrag Matrix im Rohzustand
     ).
   ENDLOOP.
 ENDMETHOD.                    "GET_TIMES_FOR_HIERARCHY_OU


  METHOD get_time_for_default.
*set standard times
    cs_matrix_rough-days_ext = g_std_days_ext.
    cs_matrix_rough-days_appl = g_std_days_appl.

  ENDMETHOD.                    "GET_TIME_FOR_DEFAULT


  METHOD get_time_for_institution.

    SELECT SINGLE days_ext days_appl FROM tn1tc_times_inst
      INTO (cs_matrix_rough-days_ext, cs_matrix_rough-days_appl)
      WHERE institution_id EQ i_institution_id AND
            ou_resp EQ cs_matrix_rough-ou_resp.


    IF sy-subrc = 0.
      RETURN.
    ENDIF.


    SELECT SINGLE days_ext days_appl FROM tn1tc_times_inst
      INTO (cs_matrix_rough-days_ext, cs_matrix_rough-days_appl)
      WHERE institution_id EQ i_institution_id AND
            ou_resp EQ '*'.

    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    get_time_for_default(
      CHANGING
        cs_matrix_rough = cs_matrix_rough    " Behandlungsauftrag Matrix im Rohzustand
    ).


  ENDMETHOD.                    "get_time_for_institution


  METHOD get_time_for_ou.

    SELECT SINGLE days_ext days_appl FROM tn1tc_times_ou
      INTO (cs_matrix_rough-days_ext, cs_matrix_rough-days_appl)
      WHERE institution_id EQ i_institution_id AND
            ou_resp EQ cs_matrix_rough-ou_resp AND
            deptou EQ cs_matrix_rough-deptou AND
            treaou EQ cs_matrix_rough-treaou.

    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    SELECT SINGLE days_ext days_appl FROM tn1tc_times_ou
      INTO (cs_matrix_rough-days_ext, cs_matrix_rough-days_appl)
      WHERE institution_id EQ i_institution_id AND
            ou_resp EQ cs_matrix_rough-ou_resp AND
            deptou EQ cs_matrix_rough-deptou AND
            treaou EQ '*'.

    IF sy-subrc = 0.
      RETURN.
    ENDIF.

    get_time_for_institution(
      EXPORTING
        i_institution_id = i_institution_id    " IS-H: Einrichtung
      CHANGING
        cs_matrix_rough  = cs_matrix_rough    " Behandlungsauftrag Matrix im Rohzustand
    ).

  ENDMETHOD.                    "GET_TIME_FOR_OU


  METHOD if_ex_ishmed_build_matrix~build_matrix.

*init export values
    CLEAR et_tc_matrix.

    load_matrix(
*MED-68399 BEGIN
      EXPORTING
        i_institution_id = i_institution_id
*MED-68399 BEGIN
      IMPORTING
        et_tc_matrix = et_tc_matrix    " Die ou-USER Zuordungsmatrix des Behandlungsauftrages
    ).

    IF lines( et_tc_matrix ) NE 0.
      RETURN.
    ENDIF.

    me->load_inactive_days( i_institution_id = i_institution_id ). " MED-70775 Cip - this cutomizing value is used only in method build_matrix_from_customizing

    build_matrix_from_customizing(
      EXPORTING
        i_institution_id = i_institution_id    " IS-H: Einrichtung
        i_uname          = sy-uname
      IMPORTING
        et_tc_matrix     = et_tc_matrix    " Die ou-USER Zuordungsmatrix des Behandlungsauftrages
    ).

    IF lines( et_tc_matrix ) GT 0.
      save_matrix(
*MED-68399 BEGIN
      EXPORTING
        i_institution_id = i_institution_id
        it_tc_matrix = et_tc_matrix
*MED-68399 END
         ).
    ENDIF.

  ENDMETHOD.                    "if_ex_ishmed_build_matrix~build_matrix


  METHOD if_ex_ishmed_build_matrix~build_matrix_for_user.

    me->load_inactive_days( i_institution_id = i_institution_id ). " MED-70775 Cip

    build_matrix_from_customizing(
      EXPORTING
        i_institution_id = i_institution_id    " IS-H: Einrichtung
        i_uname          = i_uname
      IMPORTING
        et_tc_matrix     = et_tc_matrix    " Die ou-USER Zuordungsmatrix des Behandlungsauftrages
    ).
  ENDMETHOD.                    "IF_EX_ISHMED_BUILD_MATRIX~BUILD_MATRIX_FOR_USER


  METHOD if_ex_ishmed_build_matrix~create_matrix_for_user.

*  MED-70070 Cip - method created to reload the matrix for a particular user in the buffer DB table

    DATA ls_matrix_buf  TYPE n1tc_matrix_b_in.

    DATA lt_tc_matrix   TYPE rn1tc_matrix_t.
    DATA lt_matrix_buf  TYPE TABLE OF n1tc_matrix_b_in.

    FIELD-SYMBOLS <ls_matrix>     TYPE rn1tc_matrix.

*  load the inactive days from customizing if needed
    me->load_inactive_days( i_institution_id = i_institution_id ).

*  delete the existing records from the buffer DB table for this user with the given institution
    DELETE FROM n1tc_matrix_b_in WHERE institution_id = i_institution_id AND ubname = i_uname.

*  build the matrix for this user
    me->build_matrix_from_customizing(
      EXPORTING
        i_institution_id = i_institution_id
        i_uname          = i_uname
      IMPORTING
        et_tc_matrix     = lt_tc_matrix
    ).

*  save the matrix in the buffer DB table for this user
    LOOP AT lt_tc_matrix ASSIGNING <ls_matrix>.
      CLEAR ls_matrix_buf.

      MOVE-CORRESPONDING <ls_matrix> TO ls_matrix_buf.

      ls_matrix_buf-mandt           = sy-mandt.
      ls_matrix_buf-ubname          = i_uname.
      ls_matrix_buf-valid_date      = sy-datum.
      ls_matrix_buf-institution_id  = i_institution_id.

      APPEND ls_matrix_buf TO lt_matrix_buf.
    ENDLOOP.

    MODIFY n1tc_matrix_b_in FROM TABLE lt_matrix_buf.

*MED-74837 Begin
*    COMMIT WORK.
    CALL FUNCTION 'DB_COMMIT'.
*MED-74837 End

  ENDMETHOD.


  METHOD load_inactive_days.
*    MED-70775 Cip - load the inactive days value from the customizing

    IF i_institution_id IS NOT INITIAL AND me->g_first_time IS INITIAL. " load the value if we have an institution value
      SELECT SINGLE inactive_days FROM tn1tc_glob_set INTO me->g_inactive_days WHERE institution_id = i_institution_id.
      SELECT SINGLE alternativ_matrix FROM tn1tc_glob_set INTO me->g_alternative_matrix WHERE institution_id = i_institution_id. "MED-73352
      me->g_first_time = abap_true. " load only once this value from customizing
    ENDIF.

  ENDMETHOD.


  METHOD load_matrix.

*MED-68399 BEGIN
    SELECT * FROM n1tc_matrix_b_in INTO CORRESPONDING FIELDS OF TABLE et_tc_matrix
      WHERE ubname = sy-uname AND valid_date = sy-datum AND institution_id = i_institution_id.
*MED-68399 END

    SORT et_tc_matrix BY  classification DESCENDING resp_type DESCENDING.

  ENDMETHOD.                    "LOAD_MATRIX


  METHOD load_matrix_hierarchy.

    FIELD-SYMBOLS <ou_resp> TYPE rn1tc_ou_resp.

    CLEAR et_matrix_hierarchy.

* Read buffer by OU responsibility
    LOOP AT ct_ou_resp ASSIGNING <ou_resp>.

      SELECT * FROM n1tc_matrix_b_h
        APPENDING CORRESPONDING FIELDS OF TABLE et_matrix_hierarchy "#EC CI_SEL_NESTED
        WHERE ou_resp = <ou_resp>-ou_resp
        AND   resp_type = <ou_resp>-resp_type
        AND   institution_id = i_institution_id
        AND   valid_date = sy-datum.

      "Remove OU-resp which is evaluated yet
      IF sy-subrc = 0.
        DELETE ct_ou_resp INDEX sy-tabix.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD save_matrix.
*MED-68399 BEGIN
    DATA lt_matrix_buf TYPE TABLE OF n1tc_matrix_b_in.

    FIELD-SYMBOLS: <ls_matrix_buf> TYPE n1tc_matrix_b_in,
                   <ls_matrix>     TYPE rn1tc_matrix.
*MED-68399 END

*clear Martix Buffer
    DELETE FROM n1tc_matrix_buf WHERE ubname = sy-uname AND valid_date NE sy-datum.
*MED-68399 BEGIN
    DELETE FROM n1tc_matrix_b_in WHERE ubname = sy-uname AND valid_date NE sy-datum AND institution_id = i_institution_id. "#EC CI_NOFIRST "MED-72296
*MED-68399 END
*build new entries
    LOOP AT it_tc_matrix ASSIGNING <ls_matrix>.
      APPEND INITIAL LINE TO lt_matrix_buf ASSIGNING <ls_matrix_buf>.
      MOVE-CORRESPONDING <ls_matrix> TO <ls_matrix_buf>.
      <ls_matrix_buf>-mandt = sy-mandt.
      <ls_matrix_buf>-ubname = sy-uname.
      <ls_matrix_buf>-valid_date = sy-datum.
*MED-68399 BEGIN
      <ls_matrix_buf>-institution_id = i_institution_id.
*MED-68399 BEGIN
    ENDLOOP.

*save matrix
*MED-68399 BEGIN
    MODIFY n1tc_matrix_b_in FROM TABLE lt_matrix_buf.
*MED-68399 END
    CALL FUNCTION 'DB_COMMIT'.

  ENDMETHOD.                    "save_matrix


  METHOD save_matrix_hierarchy.

    DATA lt_matrix_buf TYPE STANDARD TABLE OF n1tc_matrix_b_h.

    FIELD-SYMBOLS: <ls_matrix_buf> TYPE n1tc_matrix_b_h,
                   <ls_matrix>     TYPE rn1tc_matrix_rough.

* Clear matrix hierarchy buffer for entries overdue
    DELETE FROM n1tc_matrix_b_h
      WHERE institution_id = i_institution_id
      AND   valid_date NE sy-datum.

* Add missing admin data
    LOOP AT it_matrix_hierarchy ASSIGNING <ls_matrix>.
      APPEND INITIAL LINE TO lt_matrix_buf ASSIGNING <ls_matrix_buf>.
      MOVE-CORRESPONDING <ls_matrix> TO <ls_matrix_buf>.
      <ls_matrix_buf>-mandt = sy-mandt.
      <ls_matrix_buf>-valid_date = sy-datum.
      <ls_matrix_buf>-institution_id = i_institution_id.
    ENDLOOP.

* Save
    MODIFY n1tc_matrix_b_h FROM TABLE lt_matrix_buf.

*MED-74837 Begin
*    COMMIT WORK.
    CALL FUNCTION 'DB_COMMIT'.
*MED-74837 End

  ENDMETHOD.


METHOD _get_norg.

  DATA: l_rc          TYPE ish_method_rc.


  READ TABLE gt_norg INTO rs_norg WITH KEY orgid = i_orgid.
  IF sy-subrc NE 0.
    CALL METHOD cl_ish_dbr_org=>get_org_by_orgid
      EXPORTING
        i_orgid = i_orgid
      IMPORTING
        es_norg = rs_norg
        e_rc    = l_rc.
    IF l_rc = 0.
      APPEND rs_norg TO gt_norg.
    else.
      clear rs_norg.
    ENDIF.
  ENDIF.

ENDMETHOD.


  METHOD _get_ou_hierarchy.
    DATA: l_rc          TYPE ish_method_rc,
          lt_norg_read  TYPE ish_t_rnorghi,
          ls_norg       TYPE norg.
    DATA l_starting_date     TYPE dats.               " MED-68399 Note 2645299 Bi
    FIELD-SYMBOLS: <ls_norg_read> TYPE rnorghi.

    l_starting_date = sy-datum - g_inactive_days.     " MED-68399 Note 2645299 Bi

*use the ishmed FB because of functinality! in case of package violation use
*not ISHMED_FIND_ou_HIERARCHIE
    CALL FUNCTION 'ISH_FIND_ORG_HIERARCHY_LTD'
      EXPORTING
        ending_date          = sy-datum
        entry_org_unit       = i_orgid
*        starting_date        = sy-datum "'19000101'
        starting_date        = l_starting_date        " MED-68399 Note 2645299 Bi
        interdisz            = 'X'
        einri                = i_institution_id
      TABLES
        back_tab             = lt_norg_read
      EXCEPTIONS
        wrong_entry_org_unit = 1
        wrong_entry_einri    = 2
        OTHERS               = 3.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    LOOP AT lt_norg_read ASSIGNING <ls_norg_read>.
      CLEAR ls_norg.
      IF <ls_norg_read>-orgid = i_orgid.
        CONTINUE.
      ENDIF.
      READ TABLE rt_norg INTO ls_norg WITH KEY orgid = <ls_norg_read>-orgid.
      IF sy-subrc NE 0.
        CALL METHOD cl_ish_dbr_org=>get_org_by_orgid
          EXPORTING
            i_orgid = <ls_norg_read>-orgid
          IMPORTING
            es_norg = ls_norg
            e_rc    = l_rc.
        IF l_rc = 0.
          APPEND ls_norg TO rt_norg.
        ENDIF.
      ENDIF.
    ENDLOOP.
    SORT rt_norg BY orgid.
  ENDMETHOD.                    "_get_ou_hierarchy
ENDCLASS.
