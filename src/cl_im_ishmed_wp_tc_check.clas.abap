class CL_IM_ISHMED_WP_TC_CHECK definition
  public
  inheriting from CL_FB_ISH_WP_TC_CHECK
  final
  create public .

public section.

  methods IF_EX_ISH_WP_TC_CHECK~CHECK_FUNCTION
    redefinition .
  methods IF_EX_ISH_WP_TC_CHECK~CHECK_VIEW
    redefinition .
protected section.

  methods CHECK_VIEW_011
    importing
      !I_INSTITUTION type EINRI
      value(I_VIEW_TYPE) type NVIEWTYPE optional
      value(I_VIEW_ID) type NVIEWID optional
      value(IT_CASES2CHECK) type RNRANGEFALNR_TT optional
    exporting
      value(ET_CASES_WITH_TC) type RNRANGEFALNR_TT
    changing
      value(CT_VIEW_OUTPUT) type STANDARD TABLE .
  methods CHECK_VIEW_006
    importing
      !I_INSTITUTION type EINRI
      value(I_VIEW_TYPE) type NVIEWTYPE optional
      value(I_VIEW_ID) type NVIEWID optional
      value(IT_CASES2CHECK) type RNRANGEFALNR_TT optional
    exporting
      value(ET_CASES_WITH_TC) type RNRANGEFALNR_TT
    changing
      value(CT_VIEW_OUTPUT) type STANDARD TABLE .
  methods CHECK_VIEW_004
    importing
      !I_INSTITUTION type EINRI
      value(I_VIEW_TYPE) type NVIEWTYPE optional
      value(I_VIEW_ID) type NVIEWID optional
      value(IT_CASES2CHECK) type RNRANGEFALNR_TT optional
    exporting
      value(ET_CASES_WITH_TC) type RNRANGEFALNR_TT
    changing
      value(CT_VIEW_OUTPUT) type STANDARD TABLE .
  methods CHECK_VIEW_007
    importing
      !I_INSTITUTION type EINRI
      value(I_VIEW_TYPE) type NVIEWTYPE optional
      value(I_VIEW_ID) type NVIEWID optional
      value(IT_CASES2CHECK) type RNRANGEFALNR_TT optional
    exporting
      value(ET_CASES_WITH_TC) type RNRANGEFALNR_TT
    changing
      value(CT_VIEW_OUTPUT) type STANDARD TABLE .
private section.

  aliases DISPLAY
    for IF_ISH_CONSTANT_DEFINITION~CO_VCODE_DISPLAY .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
ENDCLASS.



CLASS CL_IM_ISHMED_WP_TC_CHECK IMPLEMENTATION.


METHOD check_view_004.
  DATA: lr_tc_api       TYPE REF TO cl_ishmed_tc_api,
        lr_tabdescr     TYPE REF TO cl_abap_tabledescr,
        lr_structdescr  TYPE REF TO cl_abap_structdescr,
        lt_components   TYPE abap_compdescr_tab,
        ls_case_with_tc TYPE rnrangefalnr,
        ls_log_info     TYPE rn1tc_log_info,
        l_tc_exist      TYPE ish_true_false VALUE '1',
        l_linetype      TYPE  n1linetype,
        l_hierarchy     TYPE n1hierarchy,
        l_node_key      TYPE lvc_nkey,
        li_linetype     TYPE sytabix,
        li_hierarchy    TYPE sytabix,
        li_node_key     TYPE sytabix,
        li_falnr        TYPE sytabix,
        li_patnr        TYPE sytabix,      " note 2905002
        l_inactive      TYPE abap_bool.    " note 2905002

  FIELD-SYMBOLS: <line>      TYPE any,
                 <patnr>     TYPE patnr,
                 <falnr>     TYPE falnr,
                 <linetype>  TYPE n1linetype,
                 <hierarchy> TYPE n1hierarchy,
                 <node_key>  TYPE lvc_nkey.


* get the API instance of the treatment contract
  TRY.
      lr_tc_api = cl_ishmed_tc_api=>load( i_institution ).
    CATCH cx_ishmed_tc.
  ENDTRY.
  IF lr_tc_api IS NOT BOUND OR lr_tc_api->is_active( ) = false.
    RETURN.
  ENDIF.
* check if customizing for user/System lead to a TC anyway
  if lr_tc_api->is_active_for_user( ) = false.             "note 1855514
    RETURN.
  ENDIF.

* set log infos
  ls_log_info-vcode = display.
  ls_log_info-object_type = i_view_type.
  ls_log_info-object_key = i_view_id.

* get the field index of the field FALNR in the structure
  READ TABLE ct_view_output ASSIGNING <line> INDEX 1.
  lr_tabdescr ?= cl_abap_typedescr=>describe_by_data( ct_view_output ).
  lr_structdescr ?= lr_tabdescr->get_table_line_type( ).
  lt_components = lr_structdescr->components.
  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'FALNR'.
  IF sy-subrc = 0.
    li_falnr = sy-tabix.
  ENDIF.

* note 2905002 Begin
  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'PATNR'.
  IF sy-subrc = 0.
    li_patnr = sy-tabix.
  ENDIF.
* note 2905002 End

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'LINETYPE'.
  IF sy-subrc = 0.
    li_linetype = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'HIERARCHY'.
  IF sy-subrc = 0.
    li_hierarchy = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'NODE_KEY'.
  IF sy-subrc = 0.
    li_node_key = sy-tabix.
  ENDIF.

* make the content of the view output according to the treatment contract
  LOOP AT ct_view_output ASSIGNING <line>.
    ASSIGN COMPONENT li_falnr OF STRUCTURE <line> TO <falnr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

* note 2905002 Begin
    ASSIGN COMPONENT li_patnr OF STRUCTURE <line> TO <patnr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
* note 2905002 End

    ASSIGN COMPONENT li_linetype OF STRUCTURE <line> TO <linetype>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_linetype.
    l_linetype = <linetype>.

    ASSIGN COMPONENT li_hierarchy OF STRUCTURE <line> TO <hierarchy>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_hierarchy.
    l_hierarchy = <hierarchy>.

    ASSIGN COMPONENT li_node_key OF STRUCTURE <line> TO <node_key>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_node_key.
    l_node_key = <node_key>.


    IF <falnr> IS  NOT INITIAL.
      CHECK <falnr> IN it_cases2check.
    ENDIF.

*   make the content of the view line according to the treatment contract
    CALL FUNCTION 'ISH_TC_LIST_LINE_CHECK'
      EXPORTING
        i_einri    = i_institution
        is_tc_log  = ls_log_info
        ir_tc_api  = lr_tc_api
      IMPORTING
        e_tc_exist = l_tc_exist
      CHANGING
        cs_line    = <line>
      EXCEPTIONS
        OTHERS     = 0.

*   return all checked cases
*     - set 'I' (include) for cases with a valid treatment contract; for these cases
*       further view data can be requested/read in the ongoing process
*     - set 'E' (exclude) for cases without a valid treatment contract; for these cases
*       further view data will not be requested/read in the ongoing process
    ls_case_with_tc-low = <falnr>.
    ls_case_with_tc-option = 'EQ'.
    IF l_tc_exist = true AND <falnr> IS NOT INITIAL.
      ls_case_with_tc-sign = 'I'.
      APPEND ls_case_with_tc TO et_cases_with_tc.
    ENDIF.
    IF l_tc_exist = false AND <falnr> IS NOT INITIAL.
      ls_case_with_tc-sign = 'E'.
      APPEND ls_case_with_tc TO et_cases_with_tc.
    ENDIF.

    IF l_tc_exist = false.
      IF l_linetype EQ '1'.
        <linetype>  = l_linetype.
        <node_key>  = l_node_key.
* note 2905002 Begin
        l_inactive = cl_ishmed_utl_wp_func=>check_pat_is_inactive( i_patient_id = <patnr> ).
        IF l_inactive = abap_true.
          <hierarchy> = <patnr>.
        ELSE.
          <hierarchy> = l_hierarchy.
        ENDIF.
* note 2905002 End
      ELSE.
       DELETE ct_view_output.
      ENDIF.
    ENDIF.

  ENDLOOP.
ENDMETHOD.


METHOD CHECK_VIEW_006.
  DATA: lr_tc_api       TYPE REF TO cl_ishmed_tc_api,
        lr_tabdescr     TYPE REF TO cl_abap_tabledescr,
        lr_structdescr  TYPE REF TO cl_abap_structdescr,
        lt_components   TYPE abap_compdescr_tab,
        ls_case_with_tc TYPE rnrangefalnr,
        ls_log_info     TYPE rn1tc_log_info,
        l_tc_exist      TYPE ish_true_false VALUE '1',
        l_dokar         TYPE dokar,
        l_doknr         TYPE doknr,
        l_dokvr         TYPE dokvr,
        l_doktl         TYPE doktl_d,
        l_pgbdat        TYPE ri_gbdat,  "MED-90584 GratzlS
        li_dokar        TYPE sytabix,
        li_doknr        TYPE sytabix,
        li_dokvr        TYPE sytabix,
        li_doktl        TYPE sytabix,
        li_pgbdat       TYPE sytabix, "MED-90584 GratzlS
        li_falnr        TYPE sytabix.

  FIELD-SYMBOLS: <line>      TYPE any,
                 <patnr>     TYPE patnr,
                 <falnr>     TYPE falnr,
                 <pgbdat> TYPE ri_gbdat, "MED-90584 GratzlS
                 <dokar>  TYPE dokar,
                 <doknr>     TYPE doknr,
                 <dokvr>     TYPE dokvr,
                 <doktl>     type doktl_d.

* get the API instance of the treatment contract
  TRY.
      lr_tc_api = cl_ishmed_tc_api=>load( i_institution ).
    CATCH cx_ishmed_tc.
  ENDTRY.
  IF lr_tc_api IS NOT BOUND OR lr_tc_api->is_active( ) = false.
    RETURN.
  ENDIF.
* check if customizing for user/System lead to a TC anyway
  if lr_tc_api->is_active_for_user( ) = false.             "note 1855514
    RETURN.
  ENDIF.

* set log infos
  ls_log_info-vcode = display.
  ls_log_info-object_type = i_view_type.
  ls_log_info-object_key = i_view_id.

* get the field index of the field FALNR in the structure
  READ TABLE ct_view_output ASSIGNING <line> INDEX 1.
  lr_tabdescr ?= cl_abap_typedescr=>describe_by_data( ct_view_output ).
  lr_structdescr ?= lr_tabdescr->get_table_line_type( ).
  lt_components = lr_structdescr->components.
  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'FALNR'.
  IF sy-subrc = 0.
    li_falnr = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'DOKAR'.
  IF sy-subrc = 0.
    li_dokar = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'DOKNR'.
  IF sy-subrc = 0.
    li_doknr = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'DOKVR'.
  IF sy-subrc = 0.
    li_dokvr = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'DOKTL'.
  IF sy-subrc = 0.
    li_doktl = sy-tabix.
  ENDIF.

* begin MED-90584 GratzlS
  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'PGBDAT'.
  IF sy-subrc = 0.
    li_pgbdat = sy-tabix.
  ENDIF.
* end MED-90584 GratzlS

* make the content of the view output according to the treatment contract
  LOOP AT ct_view_output ASSIGNING <line>.
    ASSIGN COMPONENT li_falnr OF STRUCTURE <line> TO <falnr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

    ASSIGN COMPONENT li_dokar OF STRUCTURE <line> TO <dokar>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_dokar.
    l_dokar = <dokar>.

    ASSIGN COMPONENT li_doknr OF STRUCTURE <line> TO <doknr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_doknr.
    l_doknr = <doknr>.

    ASSIGN COMPONENT li_dokvr OF STRUCTURE <line> TO <dokvr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_dokvr.
    l_dokvr = <dokvr>.

    ASSIGN COMPONENT li_doktl OF STRUCTURE <line> TO <doktl>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_doktl.
    l_doktl = <doktl>.

*   begin MED-90584 GratzlS
    ASSIGN COMPONENT li_pgbdat OF STRUCTURE <line> TO <pgbdat>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_pgbdat.
    l_pgbdat = <pgbdat>.
*   end MED-90584 GratzlS

    IF <falnr> IS  NOT INITIAL.
      CHECK <falnr> IN it_cases2check.
    ENDIF.

*   make the content of the view line according to the treatment contract
    CALL FUNCTION 'ISH_TC_LIST_LINE_CHECK'
      EXPORTING
        i_einri    = i_institution
        is_tc_log  = ls_log_info
        ir_tc_api  = lr_tc_api
      IMPORTING
        e_tc_exist = l_tc_exist
      CHANGING
        cs_line    = <line>
      EXCEPTIONS
        OTHERS     = 0.

*   return all checked cases
*     - set 'I' (include) for cases with a valid treatment contract; for these cases
*       further view data can be requested/read in the ongoing process
*     - set 'E' (exclude) for cases without a valid treatment contract; for these cases
*       further view data will not be requested/read in the ongoing process
    ls_case_with_tc-low = <falnr>.
    ls_case_with_tc-option = 'EQ'.
    IF l_tc_exist = true AND <falnr> IS NOT INITIAL.
      ls_case_with_tc-sign = 'I'.
      APPEND ls_case_with_tc TO et_cases_with_tc.
    ENDIF.
    IF l_tc_exist = false AND <falnr> IS NOT INITIAL.
      ls_case_with_tc-sign = 'E'.
      APPEND ls_case_with_tc TO et_cases_with_tc.
    ENDIF.

    IF l_tc_exist = false.
        <dokar>  = l_dokar.
        <doknr>  = l_doknr.
        <dokvr>  = l_dokvr.
        <doktl>  = l_doktl.
      <pgbdat> = l_pgbdat.  "MED-90584 GratzlS
    ENDIF.

  ENDLOOP.
ENDMETHOD.


METHOD check_view_007.
* method created - Gratzl Sabine MED-79529

  DATA: lr_tc_api       TYPE REF TO cl_ishmed_tc_api,
        lr_tabdescr     TYPE REF TO cl_abap_tabledescr,
        lr_structdescr  TYPE REF TO cl_abap_structdescr,
        lt_components   TYPE abap_compdescr_tab,
        ls_case_with_tc TYPE rnrangefalnr,
        ls_log_info     TYPE rn1tc_log_info,
        l_tc_exist      TYPE ish_true_false VALUE '1',
        l_sort(5)       TYPE n VALUE '00000',
        l_datum         TYPE sy-datum,
        l_zeit(5)       TYPE c,
        l_zeit_intern   TYPE sy-uzeit,
        l_gebdatum      TYPE n1wpv007_gebdatum,  "MED-90584 GratzlS
        li_falnr        TYPE sytabix,
        li_patnr        TYPE sytabix,
        li_sort         TYPE sytabix,
        li_datum        TYPE sytabix,
        li_zeit         TYPE sytabix,
        li_zeit_intern  TYPE sytabix,
        li_gebdatum     TYPE sytabix.  "MED-90584 GratzlS

  FIELD-SYMBOLS: <line>        TYPE any,
                 <patnr>       TYPE patnr,
                 <sort>        TYPE n,
                 <datum>       TYPE sy-datum,
                 <zeit>        TYPE c,
                 <zeit_intern> TYPE sy-uzeit,
                 <falnr>       TYPE falnr,
                 <gebdatum>    TYPE n1wpv007_gebdatum. "MED-90584 GratzlS.

* get the API instance of the treatment contract
  TRY.
      lr_tc_api = cl_ishmed_tc_api=>load( i_institution ).
    CATCH cx_ishmed_tc.
  ENDTRY.
  IF lr_tc_api IS NOT BOUND OR lr_tc_api->is_active( ) = false.
    RETURN.
  ENDIF.
* check if customizing for user/System lead to a TC anyway
  IF lr_tc_api->is_active_for_user( ) = false.
    RETURN.
  ENDIF.

* set log infos
  ls_log_info-vcode = display.
  ls_log_info-object_type = i_view_type.
  ls_log_info-object_key = i_view_id.

* get the field index of the field FALNR in the structure
  READ TABLE ct_view_output ASSIGNING <line> INDEX 1.
  lr_tabdescr ?= cl_abap_typedescr=>describe_by_data( ct_view_output ).
  lr_structdescr ?= lr_tabdescr->get_table_line_type( ).
  lt_components = lr_structdescr->components.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'FALNR'.
  IF sy-subrc = 0.
    li_falnr = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'PATNR'.
  IF sy-subrc = 0.
    li_patnr = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'SORT'.
  IF sy-subrc = 0.
    li_sort = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'DATUM'.
  IF sy-subrc = 0.
    li_datum = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'ZEIT'.
  IF sy-subrc = 0.
    li_zeit = sy-tabix.
  ENDIF.

  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'ZEIT_INTERN'.
  IF sy-subrc = 0.
    li_zeit_intern = sy-tabix.
  ENDIF.

* begin MED-90584 GratzlS
  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'GEBDATUM'.
  IF sy-subrc = 0.
    li_gebdatum = sy-tabix.
  ENDIF.
* end MED-90584 GratzlS

* make the content of the view output
  LOOP AT ct_view_output ASSIGNING <line>.

    ASSIGN COMPONENT li_falnr OF STRUCTURE <line> TO <falnr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

    ASSIGN COMPONENT li_patnr OF STRUCTURE <line> TO <patnr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

    ASSIGN COMPONENT li_sort OF STRUCTURE <line> TO <sort>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_sort.
    l_sort = <sort>.

    ASSIGN COMPONENT li_datum OF STRUCTURE <line> TO <datum>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_datum.
    l_datum = <datum>.

    ASSIGN COMPONENT li_zeit OF STRUCTURE <line> TO <zeit>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_zeit.
    l_zeit = <zeit>.

    ASSIGN COMPONENT li_zeit_intern OF STRUCTURE <line> TO <zeit_intern>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_zeit_intern.
    l_zeit_intern = <zeit_intern>.

*   begin MED-90584 GratzlS
    ASSIGN COMPONENT li_gebdatum OF STRUCTURE <line> TO <gebdatum>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_gebdatum.
    l_gebdatum = <gebdatum>.
*   end MED-90584 GratzlS

    IF <falnr> IS  NOT INITIAL.
      CHECK <falnr> IN it_cases2check.
    ENDIF.

*   make the content of the view line
    CALL FUNCTION 'ISH_TC_LIST_LINE_CHECK'
      EXPORTING
        i_einri    = i_institution
        is_tc_log  = ls_log_info
        ir_tc_api  = lr_tc_api
      IMPORTING
        e_tc_exist = l_tc_exist
      CHANGING
        cs_line    = <line>
      EXCEPTIONS
        OTHERS     = 0.

*   return all checked cases
*     - set 'I' (include) for cases with a valid treatment contract; for these cases
*       further view data can be requested/read in the ongoing process
*     - set 'E' (exclude) for cases without a valid treatment contract; for these cases
*       further view data will not be requested/read in the ongoing process
    ls_case_with_tc-low = <falnr>.
    ls_case_with_tc-option = 'EQ'.
    IF l_tc_exist = true AND <falnr> IS NOT INITIAL.
      ls_case_with_tc-sign = 'I'.
      APPEND ls_case_with_tc TO et_cases_with_tc.
    ENDIF.
    IF l_tc_exist = false AND <falnr> IS NOT INITIAL.
      ls_case_with_tc-sign = 'E'.
      APPEND ls_case_with_tc TO et_cases_with_tc.
    ENDIF.

    IF l_tc_exist = false.
      IF l_sort IS NOT INITIAL.
        <sort> = l_sort.
      ENDIF.
      IF l_datum IS NOT INITIAL.
        <datum> = l_datum.
      ENDIF.
      IF l_zeit IS NOT INITIAL.
        <zeit> = l_zeit.
      ENDIF.
      IF l_zeit_intern IS NOT INITIAL.
        <zeit_intern> = l_zeit_intern.
      ENDIF.
*     begin MED-90584 GratzlS
      IF l_gebdatum IS NOT INITIAL.
        <gebdatum> = l_gebdatum.
      endif.
*     end MED-90584 GratzlS
    ENDIF.

  ENDLOOP.

ENDMETHOD.


METHOD check_view_011.
  DATA: lr_tc_api       TYPE REF TO cl_ishmed_tc_api,
        lr_tabdescr     TYPE REF TO cl_abap_tabledescr,
        lr_structdescr  TYPE REF TO cl_abap_structdescr,
        lt_components   TYPE abap_compdescr_tab,
        ls_case_with_tc TYPE rnrangefalnr,
        ls_log_info     TYPE rn1tc_log_info,
        ls_op_line      TYPE rn1wp_op_list,
        l_tc_exist      TYPE ish_true_false VALUE '1',
        l_impobj        TYPE n1objectref,
        li_impobj       TYPE sytabix,
        li_patnr        TYPE sytabix,
        li_falnr        TYPE sytabix,
        l_inactive      TYPE abap_bool.  " note 2905002

  FIELD-SYMBOLS: <line>      TYPE any,
                 <op_line>   TYPE rn1wp_op_list,
                 <patnr>     TYPE patnr,
                 <falnr>     TYPE falnr,
                 <impobj>    TYPE n1objectref.


* get the API instance of the treatment contract
  TRY.
      lr_tc_api = cl_ishmed_tc_api=>load( i_institution ).
    CATCH cx_ishmed_tc.
  ENDTRY.
  IF lr_tc_api IS NOT BOUND OR lr_tc_api->is_active( ) = false.
    RETURN.
  ENDIF.
* check if customizing for user/System lead to a TC anyway
  if lr_tc_api->is_active_for_user( ) = false.             "note 1855514
    RETURN.
  ENDIF.

* set log infos
  ls_log_info-vcode = display.
  ls_log_info-object_type = i_view_type.
  ls_log_info-object_key = i_view_id.

* get the field index of the field FALNR in the structure
  READ TABLE ct_view_output ASSIGNING <line> INDEX 1.
  lr_tabdescr ?= cl_abap_typedescr=>describe_by_data( ct_view_output ).
  lr_structdescr ?= lr_tabdescr->get_table_line_type( ).
  lt_components = lr_structdescr->components.
  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'FALNR'.
  IF sy-subrc = 0.
    li_falnr = sy-tabix.
  ENDIF.
  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'PATNR'.
  IF sy-subrc = 0.
    li_patnr = sy-tabix.
  ENDIF.
  READ TABLE lt_components TRANSPORTING NO FIELDS WITH KEY name = 'IMPOBJ'.
  IF sy-subrc = 0.
    li_impobj = sy-tabix.
  ENDIF.

* make the content of the view output according to the treatment contract
  LOOP AT ct_view_output ASSIGNING <line>.
    ASSIGN COMPONENT li_falnr OF STRUCTURE <line> TO <falnr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

    ASSIGN COMPONENT li_patnr OF STRUCTURE <line> TO <patnr>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.

    ASSIGN COMPONENT li_impobj OF STRUCTURE <line> TO <impobj>.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
    CLEAR l_impobj.
    l_impobj = <impobj>.


    IF <falnr> IS INITIAL AND <patnr> IS INITIAL.
      CONTINUE.
    ENDIF.

    ASSIGN <line> TO <op_line>.
    CLEAR ls_op_line.
    ls_op_line = <op_line>.

*   make the content of the view line according to the treatment contract
    CALL FUNCTION 'ISH_TC_LIST_LINE_CHECK'
      EXPORTING
        i_einri    = i_institution
        is_tc_log  = ls_log_info
        ir_tc_api  = lr_tc_api
      IMPORTING
        e_tc_exist = l_tc_exist
      CHANGING
        cs_line    = <line>
      EXCEPTIONS
        OTHERS     = 0.


    l_inactive = cl_ishmed_utl_wp_func=>check_pat_is_inactive( i_patient_id = ls_op_line-patnr ).  " note 2905002

*recover all non patien releatet fields
    <op_line>-impobj    = ls_op_line-impobj.
    <op_line>-dspobj    = ls_op_line-dspobj.
    <op_line>-object    = ls_op_line-object.
    <op_line>-keyno     = ls_op_line-keyno.
    <op_line>-seqno     = ls_op_line-seqno.
    <op_line>-date      = ls_op_line-date.
    <op_line>-time      = ls_op_line-time.
    <op_line>-room      = ls_op_line-room.
    <op_line>-room_k    = ls_op_line-room_k.
    <op_line>-room_kb   = ls_op_line-room_kb.
    <op_line>-tmtag     = ls_op_line-tmtag.
    <op_line>-rfg       = ls_op_line-rfg.
    <op_line>-dauer     = ls_op_line-dauer.
    <op_line>-pzman     = ls_op_line-pzman.
    <op_line>-patnr     = ls_op_line-patnr.
    <op_line>-falnr     = ls_op_line-falnr.
    <op_line>-einri     = ls_op_line-einri.
    <op_line>-dayofweek = ls_op_line-dayofweek.
    <op_line>-room_akt  = ls_op_line-room_akt.
    <op_line>-room_akt_kb = ls_op_line-room_akt_kb.
    <op_line>-gschle    = ls_op_line-gschle.
    <op_line>-agepat    = ls_op_line-agepat.
    <op_line>-gbdat     = ls_op_line-gbdat.
    <op_line>-diagobj   = ls_op_line-diagobj.
    <op_line>-srvobj    = ls_op_line-srvobj.
    <op_line>-openclose = ls_op_line-openclose.
    <op_line>-dragable  = ls_op_line-dragable.
    <op_line>-dropable  = ls_op_line-dropable.
    <op_line>-linecolor = ls_op_line-linecolor.
    <op_line>-cellcolor = ls_op_line-cellcolor.
    <op_line>-dragdrop  = ls_op_line-dragdrop.
    <op_line>-sort01    = ls_op_line-sort01.
    <op_line>-sort02    = ls_op_line-sort02.
    <op_line>-sort03    = ls_op_line-sort03.
    <op_line>-sort04    = ls_op_line-sort04.
    <op_line>-sort05    = ls_op_line-sort05.
    <op_line>-sort06    = ls_op_line-sort06.
    <op_line>-sort07    = ls_op_line-sort07.
    <op_line>-sort08    = ls_op_line-sort08.
    <op_line>-sort09    = ls_op_line-sort09.
    <op_line>-sort10    = ls_op_line-sort10.

* note 2905002 begin
    if l_inactive = abap_false.
      <op_line>-pnamec    = ls_op_line-pnamec.
      <op_line>-pnamec1   = ls_op_line-pnamec1.
      <op_line>-nnams     = ls_op_line-nnams.
      <op_line>-vnams     = ls_op_line-vnams.
      <op_line>-gbnam     = ls_op_line-gbnam.
    endif.
* note 2905002 end

    CLEAR ls_op_line.

*   return all checked cases
*     - set 'I' (include) for cases with a valid treatment contract; for these cases
*       further view data can be requested/read in the ongoing process
*     - set 'E' (exclude) for cases without a valid treatment contract; for these cases
*       further view data will not be requested/read in the ongoing process
    ls_case_with_tc-low = <falnr>.
    ls_case_with_tc-option = 'EQ'.
    IF l_tc_exist = true AND <falnr> IS NOT INITIAL.
      ls_case_with_tc-sign = 'I'.
      APPEND ls_case_with_tc TO et_cases_with_tc.
    ENDIF.
    IF l_tc_exist = false AND <falnr> IS NOT INITIAL.
      ls_case_with_tc-sign = 'E'.
      APPEND ls_case_with_tc TO et_cases_with_tc.
    ENDIF.

  ENDLOOP.
ENDMETHOD.


METHOD if_ex_ish_wp_tc_check~check_function.
  DATA: lr_tc_api         TYPE REF TO cl_ishmed_tc_api,
        ls_return         TYPE bapiret2,
        ls_log_info       TYPE rn1tc_log_info,
        l_tc_exist        TYPE ish_true_false,
        l_papid           TYPE ish_papid,
        l_patnr           TYPE patnr,
        l_falnr           TYPE falnr,
        l_tc_tmp          TYPE ish_on_off,
        l_tc_switched_off TYPE ish_on_off.

*  begin of MED-69713 Cip
  DATA l_temp_patient               TYPE patnr.
  DATA l_temp_papid                 TYPE ish_papid.

  FIELD-SYMBOLS: <ls_line_check>    TYPE any.
  FIELD-SYMBOLS: <l_patient_check>  TYPE patnr.
  FIELD-SYMBOLS: <l_papid_check>    TYPE ish_papid.
*  end of MED-69713 Cip

  DATA: l_no_check                  TYPE ish_on_off.    "CDuerr, MED-79008

  FIELD-SYMBOLS: <line>  TYPE any,
                 <patnr>     TYPE patnr,
                 <papid>     TYPE ish_papid,
                 <falnr>     TYPE falnr.

* changed in MED-47234 because request not handeld as function

* get the API instance of the treatment contract
  TRY.
      lr_tc_api = cl_ishmed_tc_api=>load( i_institution ).
    CATCH cx_ishmed_tc.
  ENDTRY.
  IF lr_tc_api IS NOT BOUND OR lr_tc_api->is_active( ) = false.
    RETURN.
  ENDIF.

* set log infos
  ls_log_info-tcode = i_fcode.
  ls_log_info-object_type = i_view_type.
  ls_log_info-object_key = i_view_id.

* don't check the treatment contract for certain functions
  CALL FUNCTION 'ISHMED_TC_SWITCH_OFF_BY_FUNC'
    EXPORTING
      i_fcode = i_fcode.

* requesting a temporary treatment contract is only supported if
* the function has been executed for a single patient ( to prevent
* a lot of dialog popups)

*  begin of MED-69713 Cip - comment this code
*  already existing code doesn't cover the situation when more than one line in the view is selected for the same patient
*  DESCRIBE TABLE ct_para.
*  IF sy-tfill = 1.
*    l_tc_tmp = on.
*  ENDIF.
  l_tc_tmp = on. " check after if there are more than one patient selected in the view
  LOOP AT ct_para ASSIGNING <ls_line_check>.
    ASSIGN COMPONENT 'PATNR' OF STRUCTURE <ls_line_check> TO <l_patient_check>.
    IF sy-subrc = 0.
      IF  l_temp_patient IS INITIAL. " backup only once the patient
        l_temp_patient = <l_patient_check>.
      ENDIF.
      IF l_temp_patient <>  <l_patient_check>. " if there is more than one patient selected don't allow this tc request popup
        l_tc_tmp = off.
      ENDIF.
    ENDIF.
    ASSIGN COMPONENT 'PAPID' OF STRUCTURE <ls_line_check> TO <l_papid_check>.
    IF sy-subrc = 0.
      IF l_temp_papid IS INITIAL. " backup only once the provisional patient patient
        l_temp_papid = <l_papid_check>.
      ENDIF.
      IF l_temp_papid <> <l_papid_check>. " if there is more than one provisional patient selected don't allow this tc request popup
        l_tc_tmp = off.
      ENDIF.
    ENDIF.
  ENDLOOP.
*  end of MED-69713 Cip

* check and request the treatment contract when executing a function
  LOOP AT ct_para ASSIGNING <line>.
    ASSIGN COMPONENT 'FALNR' OF STRUCTURE <line> TO <falnr>.
    IF sy-subrc = 0.
      l_falnr = <falnr>.
    ENDIF.
    ASSIGN COMPONENT 'PATNR' OF STRUCTURE <line> TO <patnr>.
    IF sy-subrc = 0.
      l_patnr = <patnr>.
    ENDIF.
    ASSIGN COMPONENT 'PAPID' OF STRUCTURE <line> TO <papid>.
    IF sy-subrc = 0.
      l_papid = <papid>.
    ENDIF.

    CASE i_fcode.
      WHEN 'TC_DELEG'.
        TRY.
            CALL METHOD lr_tc_api->request_delegation
              EXPORTING
                i_patient_id = l_patnr
                i_case_id    = l_falnr
                i_uname      = sy-uname.
          CATCH cx_ishmed_tc_delegation_cancel .
            CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
              EXPORTING
                msgty  = 'S'
                msgid  = 'N1TC'
                msgno  = '710'
              IMPORTING
                return = ls_return
              EXCEPTIONS
                OTHERS = 0.
            APPEND ls_return TO ct_return.
            c_retmaxtype = 'E'.
*     delete patient from the parameter table so that the function
*     will not be executed in the further processing
            DELETE ct_para.
          CATCH cx_ishmed_tc_authority.
            CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
              EXPORTING
                msgty  = 'S'
                msgid  = 'N1TC'
                msgno  = '102'
              IMPORTING
                return = ls_return
              EXCEPTIONS
                OTHERS = 0.
            APPEND ls_return TO ct_return.
            c_retmaxtype = 'E'.
*     delete patient from the parameter table so that the function
*     will not be executed in the further processing
            DELETE ct_para.
          CATCH cx_ishmed_tc .
            CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
              EXPORTING
                msgty  = 'S'
                msgid  = 'N1TC'
                msgno  = '001'
              IMPORTING
                return = ls_return
              EXCEPTIONS
                OTHERS = 0.
            APPEND ls_return TO ct_return.
            c_retmaxtype = 'E'.
*     delete patient from the parameter table so that the function
*     will not be executed in the further processing
            DELETE ct_para.
        ENDTRY.
      WHEN 'TC_REQ'.
        TRY.
            CALL METHOD lr_tc_api->request_tc
              EXPORTING
                i_patient_id = l_patnr
                i_case_id    = l_falnr.
          CATCH cx_ishmed_tc_request_canceled.
            CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
              EXPORTING
                msgty  = 'S'
                msgid  = 'N1TC'
                msgno  = '700'
              IMPORTING
                return = ls_return
              EXCEPTIONS
                OTHERS = 0.
            APPEND ls_return TO ct_return.
            c_retmaxtype = 'E'.
*     delete patient from the parameter table so that the function
*     will not be executed in the further processing
            DELETE ct_para.
          CATCH cx_ishmed_tc .
            CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
              EXPORTING
                msgty  = 'S'
                msgid  = 'N1TC'
                msgno  = '000'
              IMPORTING
                return = ls_return
              EXCEPTIONS
                OTHERS = 0.
            APPEND ls_return TO ct_return.
            c_retmaxtype = 'E'.
*     delete patient from the parameter table so that the function
*     will not be executed in the further processing
            DELETE ct_para.
        ENDTRY.
      WHEN OTHERS.

*       CDuerr, MED-79008 - begin
        IF i_fcode = 'PLANNING'.
          IMPORT planning_no_tc_check TO l_no_check FROM MEMORY ID 'PLANNING_NO_TC_CHECK'.
          IF l_no_check = on.
            CALL FUNCTION 'ISH_TC_SWITCH_OFF'.
          ENDIF.
        ENDIF.
*       CDuerr, MED-79008 - end

*   check and request a treatment contract for the given patient/case
        CALL FUNCTION 'ISH_TC_CHECK_AND_REQUEST'
          EXPORTING
            i_einri               = i_institution
            i_papid               = l_papid
            i_patnr               = l_patnr
            i_falnr               = l_falnr
            i_tc_tmp              = l_tc_tmp
            is_tc_log             = ls_log_info
          EXCEPTIONS
            no_treatment_contract = 1
            OTHERS                = 0.
*   treatment contract exists; function execution possible
        IF sy-subrc = 1.
*   no treatment contract exist; function execution not possible
      CALL FUNCTION 'ISH_BAPI_FILL_RETURN_PARAM'
        EXPORTING
          msgty  = sy-msgty
          msgid  = sy-msgid
          msgno  = sy-msgno
          msgv1  = sy-msgv1
          msgv2  = sy-msgv2
          msgv3  = sy-msgv3
        IMPORTING
          return = ls_return
        EXCEPTIONS
          OTHERS = 1.
      APPEND ls_return TO ct_return.
      c_retmaxtype = 'E'.
*     delete patient from the parameter table so that the function
*     will not be executed in the further processing
      DELETE ct_para.
    ENDIF.

*     CDuerr, MED-79008 - begin
      IF l_no_check = on.
        CALL FUNCTION 'ISH_TC_SWITCH_OFF_UNDO'.
      ENDIF.
*     CDuerr, MED-79008 - end

    ENDCASE.
  ENDLOOP.
ENDMETHOD.


METHOD if_ex_ish_wp_tc_check~check_view.
  CASE i_view_type.
    when '004'.
      check_view_004(
        EXPORTING
          i_institution    = i_institution
          i_view_type      = i_view_type
          i_view_id        = i_view_id
          it_cases2check   = it_cases2check
        IMPORTING
          et_cases_with_tc = et_cases_with_tc
        CHANGING
          ct_view_output   = ct_view_output
             ).
    when '006'.
      check_view_006(
        EXPORTING
          i_institution    = i_institution
          i_view_type      = i_view_type
          i_view_id        = i_view_id
          it_cases2check   = it_cases2check
        IMPORTING
          et_cases_with_tc = et_cases_with_tc
        CHANGING
          ct_view_output   = ct_view_output
             ).
*   begin Gratzl MED-79529
    when '007'.
      check_view_007(
        EXPORTING
          i_institution    = i_institution
          i_view_type      = i_view_type
          i_view_id        = i_view_id
          it_cases2check   = it_cases2check
        IMPORTING
          et_cases_with_tc = et_cases_with_tc
        CHANGING
          ct_view_output   = ct_view_output
             ).
*   end Gratzl MED-79529
    when '011'.
      check_view_011(
        EXPORTING
          i_institution    = i_institution
          i_view_type      = i_view_type
          i_view_id        = i_view_id
          it_cases2check   = it_cases2check
        IMPORTING
          et_cases_with_tc = et_cases_with_tc
        CHANGING
          ct_view_output   = ct_view_output
             ).
    WHEN OTHERS.
      super->if_ex_ish_wp_tc_check~check_view(
        EXPORTING
          i_institution    = i_institution
          i_view_type      = i_view_type
          i_view_id        = i_view_id
          it_cases2check   = it_cases2check
        IMPORTING
          et_cases_with_tc = et_cases_with_tc
        CHANGING
          ct_view_output   = ct_view_output
             ).
  ENDCASE.
ENDMETHOD.
ENDCLASS.
