*----------------------------------------------------------------------*
***INCLUDE LN1TC_DIALOGF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  INIT_PATNAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM init_patname .
  DATA: lr_pat_name  TYPE REF TO cl_ishmed_dwswl_patient,
        ls_pat_short TYPE rn2dwswl_patient,
        ss_npat      type npat.
  TRY.
      lr_pat_name =  cl_ishmed_dwswl_patient=>load(
           i_einri     = rn1tc_request_dlg-institution_id    " Einrichtung
           i_patnr     = rn1tc_request_dlg-patient_id    " Patientennummer
       ).

      lr_pat_name->get_data(
        IMPORTING
          es_pat_short = ls_pat_short    " Patientendaten für Aufgabenkomponente
      ).

      rn1tc_request_dlg-name_age_sex = ls_pat_short-name_age_sex.

      lr_pat_name->destroy( ).

      FREE lr_pat_name.

      IF g_vcode NE if_ish_constant_definition=>co_vcode_display.

*MED-60665 Beginn
        CALL FUNCTION 'ISH_READ_NPAT'
          EXPORTING
            SS_EINRI                      = rn1tc_request_dlg-institution_id
            ss_patnr                      = rn1tc_request_dlg-patient_id
            SS_CHECK_AUTH                 = ' '
            SS_CHECK_VIP                  = 'X'
            I_TC_AUTH                     = ' '
*           I_TC_TMP              = ' '
*           I_TC_EXCEP            = ' '
          IMPORTING
            SS_NPAT                       = SS_NPAT
          EXCEPTIONS
            NOT_FOUND                     = 1
            NO_AUTHORITY                  = 2
            NO_EINRI                      = 3
            NO_TREATMENT_CONTRACT         = 4
            OTHERS                        = 5.

        IF sy-subrc <> 0.
          CLEAR rn1tc_request_dlg-vip.
        ELSE.
          rn1tc_request_dlg-vip = ss_npat-vipkz.
        ENDIF.
*MED-60665 End

        rn1tc_request_dlg-insert_user = sy-uname.
        IF g_delegation = on.
          IF rn1tc_request_dlg-uname IS INITIAL.
            GET PARAMETER ID 'XUS' FIELD rn1tc_request_dlg-uname.
          ENDIF.
        ELSE.
          rn1tc_request_dlg-uname = sy-uname.
        ENDIF.
      ENDIF.
    CATCH cx_ishmed_dwswl_rt.    " Ausnahme im Aufgabenmanagement
      CLEAR rn1tc_request_dlg-name_age_sex.
  ENDTRY.

  IF rn1tc_request_dlg-resp_type IS INITIAL.
    rn1tc_request_dlg-resp_type = if_ishmed_tc_constant_def=>co_resp_type_patient.
  ENDIF.

ENDFORM.                    " INIT_PATNAME
*&---------------------------------------------------------------------*
*&      Form  REQUEST_SCREEN_STATUS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM request_screen_status .
  DATA l_date(10) TYPE c.

  WRITE rn1tc_request_dlg-insert_date TO l_date.
  IF g_vcode = if_ish_constant_definition=>co_vcode_display.
    IF g_popup = on.
      SET PF-STATUS 'REQUEST_DIS_STATUS'.
    ELSE.
      SET PF-STATUS 'DELEGATE_DIS_STATUS'.
    ENDIF.
    IF g_delegation = cl_ishmed_tc_api=>on.
      SET TITLEBAR  'DELEGATION_TITLE' WITH l_date.
    ELSE.
      SET TITLEBAR  'REQUEST_TITLE' WITH l_date.
    ENDIF.
  ELSE.
    IF g_delegation = cl_ishmed_tc_api=>on.
      IF g_popup = on.
*        SET PF-STATUS 'REQUEST_NE_STATUS'.                  " MED-57385
        SET PF-STATUS 'REQUEST_STATUS'.                      " MED-57385
      ELSE.
        SET PF-STATUS 'DELEGATE_NE_STATUS'.
      ENDIF.
      SET TITLEBAR  'DELEGATION_TITLE' WITH l_date.
    ELSE.
* BEGIN MED-46861 #RISK#
* begin MED-57385: no more #RISK#,
*       because emergency function is usable in all time
* MED-70766 BEGIN By C5004356
      IF g_special_request = false.
*      IF g_emergency_possible = on.
        SET PF-STATUS 'REQUEST_STATUS'.
      ELSE.
        SET PF-STATUS 'REQUEST_NE_STATUS'.
      ENDIF.
* MED-70766 END By C5004356
* end MED-57385
* END MED-46861 #RISK#
      SET TITLEBAR  'REQUEST_TITLE' WITH l_date.
    ENDIF.
  ENDIF.

ENDFORM.                    " REQUEST_SCREEN_STATUS
*&---------------------------------------------------------------------*
*&      Form  REQUEST_SCREEN_MOD
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM request_screen_mod .
  LOOP AT SCREEN.
    IF g_delegation = off.
      IF screen-group1 = 'D' .  " -- bleibt aktiv (..Taste)
        screen-input   = false.
        screen-invisible = true.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 = 'X' AND g_delegation = off AND
         rn1tc_request_dlg-resp_type = if_ishmed_tc_constant_def=>co_resp_type_patient.  "    bleibt aktiv (..Taste)
        screen-input   = false.
        screen-invisible = true.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 = 'I'.
        screen-input   = false.
        screen-value_help = '0'.
        MODIFY SCREEN.
      ENDIF.
* MED-67191 Begin
      IF screen-group1 = 'CAT'.
        if g_cat_exsit NE 'X' or g_special_request = true.
          screen-input   = false.
          screen-invisible = true.
          MODIFY SCREEN.
        endif.
      ENDIF.
* MED-67191 End
      IF screen-group1 = 'T' AND g_vcode = if_ish_constant_definition=>co_vcode_display.
        screen-input   = false.
        screen-invisible = true.
        MODIFY SCREEN.
      ENDIF.
* MED-67191 Begin
      IF screen-group1 = 'CAT' AND g_vcode = if_ish_constant_definition=>co_vcode_display..
        screen-input   = false.
        screen-invisible = true.
        MODIFY SCREEN.
      ENDIF.
* MED-67191 End

    ELSE.
* MED-67191 Begin
      IF screen-group1 = 'CAT'.
        screen-input   = false.
        screen-invisible = true.
        MODIFY SCREEN.
      ENDIF.
* MED-67191 End
      IF screen-group1 = 'T'.
        screen-input   = false.
        screen-invisible = true.
        MODIFY SCREEN.
      ENDIF.

      IF screen-group1 = 'I' AND g_vcode = if_ish_constant_definition=>co_vcode_display.  " -- bleibt aktiv (..Taste)
        screen-input   = false.
        screen-value_help = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDFORM.                    " REQUEST_SCREEN_MOD
*&---------------------------------------------------------------------*
*&      Form  FREE_CONTENT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM free_content .
  IF lr_ttc_helper IS BOUND.
    lr_ttc_helper->destroy( ).
    FREE lr_ttc_helper.
  ENDIF.

  IF gr_edit_cust IS BOUND.
    gr_edit_cust->free( ).
    FREE gr_edit_cust.
  ENDIF.

  IF gr_edit IS BOUND.
    gr_edit->finalize( ).
    FREE gr_edit.
  ENDIF.

ENDFORM.                    " FREE_CONTENT
*&---------------------------------------------------------------------*
*&      Form  REQUEST_SCREEN_INIT
*&---------------------------------------------------------------------*
*  create helper class & check that emergency button is possible to show
*----------------------------------------------------------------------*
FORM request_screen_init .
  DATA l_enable TYPE flag.
  DATA l_read_only TYPE i.

* BEGIN MED-46861 3037
  IF lr_ttc_helper IS NOT BOUND.
    CREATE OBJECT lr_ttc_helper
      EXPORTING
        is_data = rn1tc_request_dlg.
    PERFORM init_emergency_possible.
    PERFORM init_category. "MED-67191
  ENDIF.
* END MED-46861 3037
  IF gr_edit_cust IS NOT  BOUND.
    CREATE OBJECT gr_edit_cust
      EXPORTING
*       PARENT                      =
        container_name              = 'EDIT_CUST'
*       STYLE                       =
*       LIFETIME                    = lifetime_default
*       REPID                       =
*       DYNNR                       =
*       NO_AUTODEF_PROGID_DYNNR     =
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
*      MESSAGE e101(n2dws_comp).
      CLEAR ok_code.
      SET SCREEN 0.
      LEAVE SCREEN.
    ENDIF.

    CREATE OBJECT gr_edit
      EXPORTING
        max_number_chars       = 200 "MED-67191
        parent                 = gr_edit_cust
        show_statusbar         = cl_gui_textedit=>false
        show_toolbar           = cl_gui_textedit=>false
        einri                  = rn1tc_request_dlg-institution_id
        register_dblclick      = cl_gui_textedit=>false
      EXCEPTIONS
        error_cntl_create      = 1
        error_cntl_init        = 2
        error_cntl_link        = 3
        error_dp_create        = 4
        gui_type_not_supported = 5
        OTHERS                 = 6.
    IF sy-subrc <> 0.
*      MESSAGE e101(n2dws_comp).
      CLEAR ok_code.
      SET SCREEN 0.
      LEAVE SCREEN.
    ENDIF.

    gr_edit->set_text_as_string(
       EXPORTING
         text                   = g_reason1
       EXCEPTIONS
         error_cntl_call_method = 1
         not_supported_by_gui   = 2
         OTHERS                 = 3
            ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    IF g_vcode NE if_ish_constant_definition=>co_vcode_display.
      cl_ishmed_lte_editor=>set_focus(
          EXPORTING
            control           = gr_edit
          EXCEPTIONS
            cntl_error        = 1
            cntl_system_error = 2
            OTHERS            = 3
               ).
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.
    ENDIF.

    IF g_vcode = 'DIS' or g_special_request = true. "MED-70766 By C5004356
      l_enable = ' '.
      l_read_only = cl_ishmed_lte_editor=>true.
    ELSE.
      l_enable ='X'.
      l_read_only = cl_ishmed_lte_editor=>false.
    ENDIF.

    gr_edit->set_readonly_mode(
      EXPORTING
        readonly_mode          = l_read_only
      EXCEPTIONS
        error_cntl_call_method = 1
        invalid_parameter      = 2
        OTHERS                 = 3
           ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.




  ENDIF.
ENDFORM.                    " REQUEST_SCREEN_INIT
*&---------------------------------------------------------------------*
*&      Form  INIT_EMERGENCY_POSSIBLE
*&---------------------------------------------------------------------*
* Test if patient is present in the hospital. If so emergency button
* is visible.
*----------------------------------------------------------------------*
FORM init_emergency_possible .

* BEGIN MED-46861 3037
  g_emergency_possible = lr_ttc_helper->check_emergency_possible( ).
* END MED-46861 3037
  IF g_emergency_possible = on AND g_delegation = off.
    if lr_ttc_helper->check_patient_companion(
         i_patient_id = rn1tc_request_dlg-patient_id
         i_case_id    = rn1tc_request_dlg-case_id
       ) = OFF. "MED-70773 by C5004356
      rn1tc_request_dlg-resp_type = if_ishmed_tc_constant_def=>co_resp_type_patient.
      CLEAR rn1tc_request_dlg-case_id.
    endif. "MED-70773 by C5004356
  ENDIF.

ENDFORM.                    " INIT_EMERGENCY_POSSIBLE
*&---------------------------------------------------------------------*
*&      Form  REQUEST_SCREEN_CHECK_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
FORM request_screen_check_data .
  g_state_request = 'OK'.

  CASE ok_code.
    WHEN 'REQ_OKAY'.
      PERFORM request_screen_check_reason.
      IF g_delegation = on.
        PERFORM request_screen_check_uname.
      ENDIF.
    WHEN OTHERS.
      g_state_request = 'OK'.
  ENDCASE.
ENDFORM.                    " REQUEST_SCREEN_CHECK_DATA
*&---------------------------------------------------------------------*
*&      Form  REQUEST_SCREEN_CHECK_REASON
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM request_screen_check_reason .

  DATA l_reason_opt type N1TC_REQ_JUST_USE.
  DATA l_category type N1TC_REQ_CAT.
  data lt_category TYPE TABLE OF tn1tc_category. "Gratzl MED-90260
  data ls_category LIKE LINE OF lt_category.     "Gratzl MED-90260

  IF g_vcode NE if_ish_constant_definition=>co_vcode_display.
    gr_edit->get_text_as_string(
      EXPORTING
        only_when_modified     = 0
      IMPORTING
        text                   = g_reason1
*    IS_MODIFIED            =
      EXCEPTIONS
        error_cntl_call_method = 1
        not_supported_by_gui   = 2
        OTHERS                 = 3
           ).
    IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER Y-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

*MED-67191 Begin
    if g_cat_exsit = 'X'.
      select SINGLE JUST_USE  FROM tn1tc_category into l_reason_opt  where cat_order = rn1tc_request_dlg-category and institution_id = rn1tc_request_dlg-institution_id and spras = sy-langu.
*     begin Gratzl MED-90260
      IF sy-subrc <> 0.
*       if there is no entry with '0', than get the lowest customized entry values
        SELECT * FROM tn1tc_category INTO TABLE lt_category WHERE institution_id = rn1tc_request_dlg-institution_id AND spras = sy-langu.
        SORT lt_category BY cat_order.
        IF lines( lt_category ) > 0.
          READ TABLE lt_category INTO ls_category index 1.
          l_reason_opt = ls_category-just_use.
        ENDIF.
      ENDIF.
*     end Gratzl MED-90260
      SELECT SINGLE category FROM tn1tc_category INTO l_category WHERE cat_order = rn1tc_request_dlg-category AND institution_id = rn1tc_request_dlg-institution_id AND spras = sy-langu.
      IF g_reason_edit = 'X'.
        if g_reason1 IS INITIAL.
*    select SINGLE OPTIONAL FROM ZMASTCLB into L_OPTIONAL where lbkey = zmas_tc_lb_screen-box.
           if l_reason_opt = '1'.
             g_state_request = 'NO_REASON'.
           else.
             g_reason1 = l_category.
           endif.
        else.
           CONCATENATE l_category '|' g_reason1 into g_reason1 Separated by space.
        endif.
      else.
         g_reason1 = l_category.
      endif.
    else.
      IF g_reason1 IS INITIAL.
        g_state_request = 'NO_REASON'.
      ENDIF.
    ENDIF.
  ENDIF.
*MED-67191 End
ENDFORM.                    " REQUEST_SCREEN_CHECK_reason
*&---------------------------------------------------------------------*
*&      Form  INIT_CATEGORY
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM init_category .

   DATA:
      i_ftext TYPE vrm_values, "-->Table that is passed through FM vrm_set_values
      w_ftext LIKE LINE OF i_ftext,
      lt_category TYPE TABLE OF tn1tc_category,
      ls_category LIKE LINE OF lt_category.


    SELECT * FROM tn1tc_category INTO TABLE lt_category where institution_id = rn1tc_request_dlg-institution_id and spras = sy-langu.

    SORT lt_category BY cat_order.

    if lines( lt_category ) > 0.
    CLEAR i_ftext.      "Gratzl MED-90260
    g_cat_exsit = 'X'.
      LOOP AT lt_category INTO ls_category .
       IF sy-tabix = 1.
         IF ls_category-just_use = '1' or ls_category-just_use = '2'.
           g_reason_edit = 'X'.
         ELSE.
           g_reason_edit = ' '.
         ENDIF.
*        begin Gratzl MED-90260
        w_ftext-key = '0'.
        w_ftext-text = ls_category-category.
        APPEND w_ftext TO i_ftext.
        CLEAR w_ftext.
*       ENDIF.
      ELSE.
*        end Gratzl MED-90260
        w_ftext-key = ls_category-cat_order.
        w_ftext-text = ls_category-category.
        APPEND w_ftext TO i_ftext.
        CLEAR w_ftext.
      ENDIF. "Gratzl MED-90260
    ENDLOOP.

      CALL FUNCTION 'VRM_SET_VALUES'
        EXPORTING
          id              = 'RN1TC_REQUEST_DLG-CATEGORY' "-->Field for which dropdown is needed.
          values          = i_ftext
        EXCEPTIONS
          id_illegal_name = 1
          OTHERS          = 2.
      IF sy-subrc <> 0.

      ENDIF.
    else.
      g_cat_exsit = ' '.
    endif.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_REGUEST_STATUS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_reguest_status .

  DATA l_read_only TYPE i.

  if g_special_request = false.
   if g_vcode = if_ish_constant_definition=>co_vcode_display.
     l_read_only = cl_ishmed_lte_editor=>true.
   else.
     if g_reason_edit = 'X'.
       l_read_only = cl_ishmed_lte_editor=>false.
     else.
       l_read_only = cl_ishmed_lte_editor=>true.
       gr_edit->set_text_as_string(
          EXPORTING
            text                   = ''
          EXCEPTIONS
            error_cntl_call_method = 1
            not_supported_by_gui   = 2
            OTHERS                 = 3
               ).
        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                     WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.
      ENDIF.
    endif.
    gr_edit->set_readonly_mode(
      EXPORTING
        readonly_mode          = l_read_only
      EXCEPTIONS
        error_cntl_call_method = 1
        invalid_parameter      = 2
        OTHERS                 = 3
           ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  endif.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SET_REASON_EDIT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_reason_edit .

DATA l_reason_opt type N1TC_REQ_JUST_USE.

     select SINGLE JUST_USE  FROM tn1tc_category into l_reason_opt  where cat_order = rn1tc_request_dlg-category and institution_id = rn1tc_request_dlg-institution_id and spras = sy-langu.

    if l_reason_opt = '1' or l_reason_opt = '2'.
      g_reason_edit = 'X'.
    else.
      g_reason_edit = ' '.
    endif.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  REQUEST_SCREEN_CHECK_UNAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM request_screen_check_uname .
  IF rn1tc_request_dlg-uname IS INITIAL AND
     g_vcode NE if_ish_constant_definition=>co_vcode_display.
    g_state_request = 'NO_USER'.
  ENDIF.

  IF rn1tc_request_dlg-uname IS NOT INITIAL AND
     g_vcode NE if_ish_constant_definition=>co_vcode_display.
    CALL FUNCTION 'SUSR_USER_CHECK_EXISTENCE'
      EXPORTING
        user_name            = rn1tc_request_dlg-uname
      EXCEPTIONS
        user_name_not_exists = 1
        OTHERS               = 2.
    IF sy-subrc <> 0.
      g_state_request = 'WRONG_USER'.
    ENDIF.
  ENDIF.



  IF rn1tc_request_dlg-case_id IS INITIAL AND
     rn1tc_request_dlg-resp_type = if_ishmed_tc_constant_def=>co_resp_type_case.
    g_state_request = 'WRONG_BEZ'.
  ENDIF.
  IF rn1tc_request_dlg-resp_type IS INITIAL.
    g_state_request = 'NO_BEZ'.
  ENDIF.

ENDFORM.                    " REQUEST_SCREEN_CHECK_UNAME
*&---------------------------------------------------------------------*
*&      Form  SET_EMERGENCY_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_emergency_data .
  IF g_reason1 IS INITIAL.
    g_reason1 = text-100.
  ENDIF.
  rn1tc_request_dlg-emergency = on.
* Begin MED-70773 by C5004356
  rn1tc_request_dlg-resp_type = if_ishmed_tc_constant_def=>co_resp_type_patient.
  CLEAR rn1tc_request_dlg-case_id.
* End MED-70773 by C5004356

ENDFORM.                    " SET_EMERGENCY_DATA
*&---------------------------------------------------------------------*
*&      Form  SET_ADMIN_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_admin_data .
  rn1tc_request_dlg-insert_date = sy-datum.
  rn1tc_request_dlg-insert_time = sy-uzeit.
  rn1tc_request_dlg-insert_user = sy-uname.
ENDFORM.                    " SET_ADMIN_DATA
*&---------------------------------------------------------------------*
*&      Form  REQUEST_SCREEN_SET_CURSOR
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM request_screen_set_cursor .

  CHECK NOT g_cursor_field IS INITIAL.


  LOOP AT SCREEN.
    IF screen-name = g_cursor_field.
      IF screen-input = true.
        screen-intensified = g_cursor_intensified.
        MODIFY SCREEN.
        SET CURSOR FIELD g_cursor_field.
      ENDIF.
    ENDIF.
  ENDLOOP.

  CLEAR g_cursor_field.
  g_cursor_intensified = false.

ENDFORM.                    " REQUEST_SCREEN_SET_CURSOR
