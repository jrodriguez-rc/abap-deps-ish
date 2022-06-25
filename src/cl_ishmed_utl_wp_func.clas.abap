class CL_ISHMED_UTL_WP_FUNC definition
  public
  final
  create public .

public section.

  constants CO_INTF_NAME type SEOCLSNAME value 'IF_ISHMED_WP_FUNC' ##NO_TEXT.

  class-methods EXECUTE_FUNCTION
    importing
      value(I_FCODE) type CUA_CODE
      value(I_VIEW_ID) type NWVIEW-VIEWID
      value(I_VIEW_TYPE) type NWVIEW-VIEWTYPE
      value(I_WPLACEID) type NWPLACEID
      value(I_FIELDNAME) type LVC_FNAME
      !IT_ISH_OBJECTS type ISH_T_DRAG_DROP_DATA
    exporting
      value(E_FUNC_DONE) type ISH_TRUE_FALSE
      value(E_REFRESH) type N1FLD-REFRESH
      value(E_RC) type ISH_METHOD_RC
    changing
      !CT_MESSAGE type BAPIRET2_T optional .
  class-methods CHECK_PAT_AUTHORITY
    importing
      !IT_PATIENT type ISHMED_T_PAT
    changing
      !C_RC type SY-SUBRC
      !C_DONE type ISH_TRUE_FALSE
      !CT_BAPIRET type BAPIRETTAB .
  class-methods CHECK_PAT_IS_INACTIVE
    importing
      !I_PATIENT_ID type PATNR
    returning
      value(R_INACTIVE) type ABAP_BOOL .
protected section.
private section.
ENDCLASS.



CLASS CL_ISHMED_UTL_WP_FUNC IMPLEMENTATION.


  METHOD check_pat_authority.

    DATA: l_rettype  TYPE npdok-bapiretmaxty,
          ls_patient TYPE rn1pat.


    LOOP AT it_patient INTO ls_patient.
* check authority on patient
      CALL FUNCTION 'ISH_PATIENT_GET'
        EXPORTING
          ss_einri      = ls_patient-einri
          ss_patnr      = ls_patient-patnr
          ss_check_auth = 'X'
        IMPORTING
          ss_retmaxtype = l_rettype
        TABLES
          ss_return     = ct_bapiret.

      IF l_rettype = 'A' OR l_rettype = 'E'.
        c_done = '1'.
        c_rc = '1'.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  method CHECK_PAT_IS_INACTIVE.
   DATA l_npat type npat.

    clear l_npat.
    r_inactive = abap_false.

    CALL FUNCTION 'ISH_READ_NPAT'
      EXPORTING
        ss_patnr                      = i_patient_id
        SS_CHECK_AUTH                 = 'X'
        SS_CHECK_INACTIVE             = 'X'
        SS_NO_MESSAGES                = 'X'
        I_TC_AUTH                     = ' '
      IMPORTING
        SS_NPAT                       = l_npat
      EXCEPTIONS
        NOT_FOUND                     = 1
        NO_AUTHORITY                  = 2
        NO_EINRI                      = 3
        NO_TREATMENT_CONTRACT         = 4
        OTHERS                        = 5
              .
    IF sy-subrc <> 0.
*now get data to see if inactive patient is the root cause

      CALL FUNCTION 'ISH_READ_NPAT'
        EXPORTING
          ss_patnr                      = i_patient_id
          SS_CHECK_AUTH                 = ' '
          SS_CHECK_INACTIVE             = ' '
          SS_NO_MESSAGES                = 'X'
          I_TC_AUTH                     = ' '
        IMPORTING
          SS_NPAT                       = l_npat
        EXCEPTIONS
          NOT_FOUND                     = 1
          NO_AUTHORITY                  = 2
          NO_EINRI                      = 3
          NO_TREATMENT_CONTRACT         = 4
        OTHERS                        = 5
              .

      IF sy-subrc = 0 AND l_npat-inact EQ 'X'.
        r_inactive = abap_true.
      ENDIF.
    ENDIF.
  endmethod.


  METHOD execute_function.
*   Fichte, IXX-13797: Class created
*   It can be used within function modules of NWP1 in order to call functions
    DATA: lt_clskey  TYPE TABLE OF seoclskey,
          lr_interf  TYPE REF TO if_ishmed_wp_func,
          l_rfr      TYPE n1fld-refresh,
          l_flag     TYPE abap_bool,
          lt_message TYPE ishmed_t_bapiret2,
          lr_error   TYPE REF TO cl_ishmed_errorhandling,
          l_rc       TYPE ish_method_rc.
    FIELD-SYMBOLS:
      <ls_msg>    TYPE bapiret2,
      <ls_clskey> TYPE seoclskey.

    e_rc = 0.
    e_refresh = 0.
    e_func_done = '0'.

*   Get classes implementing interface IF_ISHMED_WP_FUNC
    lt_clskey = cl_ish_utl_rtti=>get_interface_implementations(
      EXPORTING
        i_interface_name  = co_intf_name
        i_with_subclasses = abap_false ).

    LOOP AT lt_clskey ASSIGNING <ls_clskey>.
      TRY.
          CREATE OBJECT lr_interf TYPE (<ls_clskey>-clsname).
        CATCH cx_root.
          CONTINUE.
      ENDTRY.

      CALL METHOD lr_interf->is_right_viewtype
        EXPORTING
          i_view_type = i_view_type
        RECEIVING
          r_result    = l_flag.
      IF l_flag <> abap_true.
        CONTINUE.
      ENDIF.

      CALL METHOD lr_interf->execute_functions
        EXPORTING
          i_fcode         = i_fcode
          i_view_id       = i_view_id
          i_view_type     = i_view_type
          i_wplaceid      = i_wplaceid
          i_fieldname     = i_fieldname
          it_ish_objects  = it_ish_objects
        IMPORTING
          e_func_done     = e_func_done
          e_refresh       = l_rfr
          e_rc            = l_rc
        CHANGING
          cr_errorhandler = lr_error.
      IF lr_error IS NOT INITIAL.
        CLEAR: lt_message[].
        CALL METHOD lr_error->get_messages
          IMPORTING
            t_messages = lt_message.
        LOOP AT lt_message ASSIGNING <ls_msg>.
          APPEND <ls_msg> TO ct_message.
        ENDLOOP.
      ENDIF.

      IF l_rc <> 0.
        e_rc = l_rc.
        RETURN.
      ENDIF.

*     0	... Dont refresh anything
*     1	... Just refresh selected rows
*     2	... Refresh whole list
      IF l_rfr > e_refresh.
        e_refresh = l_rfr.
      ENDIF.

      IF e_func_done = '1'.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
