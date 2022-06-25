*&---------------------------------------------------------------------*
*& Report  RN1_GENERATE_MISSING_OP_APPS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  rn1_generate_missing_op_apps.

TABLES: n1anf, nbew, ntmn, napp, nlei, nlem.

* institution
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (15) text-a01 FOR FIELD pa_einri.
SELECTION-SCREEN POSITION 45.
PARAMETERS pa_einri TYPE n1anf-einri.
SELECTION-SCREEN END OF LINE.

* date
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (30) text-a02 FOR FIELD so_bwidt.
SELECTION-SCREEN POSITION 42.
SELECT-OPTIONS so_bwidt FOR nbew-bwidt DEFAULT sy-datum.
SELECTION-SCREEN END OF LINE.

* org. unit
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (30) text-a03 FOR FIELD pa_orgpf.
SELECTION-SCREEN POSITION 45.
PARAMETERS: pa_orgpf TYPE nbew-orgpf.
SELECTION-SCREEN END OF LINE.

* correct data
SELECTION-SCREEN SKIP.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (39) text-a04 FOR FIELD pa_test.
SELECTION-SCREEN POSITION 45.
PARAMETERS pa_test  AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF LINE.

DATA: gt_nbew        TYPE STANDARD TABLE OF nbew.
DATA: gt_nlei_anchor TYPE STANDARD TABLE OF nlei.
DATA: gt_nlei        TYPE STANDARD TABLE OF nlei.
DATA: gt_nlem_anchor TYPE STANDARD TABLE OF nlem.
DATA: gt_nlem        TYPE STANDARD TABLE OF nlem.
DATA: gt_ntmn        TYPE STANDARD TABLE OF ntmn.

INITIALIZATION.

  IF pa_einri IS INITIAL.
    GET PARAMETER ID 'EIN' FIELD pa_einri.
  ENDIF.

START-OF-SELECTION.

* check institution
  IF pa_einri IS INITIAL.
    SET CURSOR FIELD pa_einri.
    MESSAGE s819(nf1).
    EXIT.
  ENDIF.
* check date
  IF so_bwidt-low IS INITIAL.
    SET CURSOR FIELD so_bwidt-low.
    MESSAGE s664(nf1).
    EXIT.
  ENDIF.
  IF so_bwidt-high IS INITIAL.
    SET CURSOR FIELD so_bwidt-high.
    MESSAGE s664(nf1).
    EXIT.
  ENDIF.
* check org. unit
  IF pa_orgpf IS INITIAL.
    SET CURSOR FIELD pa_orgpf.
    MESSAGE s314(nf).
    EXIT.
  ENDIF.

* select movements with anchor-service but without appointment
  PERFORM select_data.

* create header
  PERFORM header.

* now generate the appointments
  PERFORM generate_app.


*&---------------------------------------------------------------------*
*&      Form  SELECT_DATA
*&---------------------------------------------------------------------*
FORM select_data.

  DATA: lt_tn14b       TYPE STANDARD TABLE OF tn14b,
        lt_objectlist  TYPE ish_objectlist,
        lt_nlei_anchor TYPE STANDARD TABLE OF nlei,
        lt_nlei        TYPE STANDARD TABLE OF nlei,
        lt_nlem_anchor TYPE STANDARD TABLE OF nlem,
        lt_nlem        TYPE STANDARD TABLE OF nlem.
  DATA: ls_nbew        TYPE nbew,
        ls_nlei        TYPE nlei,
        ls_nlem        TYPE nlem,
        ls_ntmn        TYPE ntmn,
        ls_object      TYPE ish_object.
  DATA: l_idx          TYPE sy-tabix,
        l_is_op        TYPE ish_on_off,
        l_rc           TYPE ish_method_rc.
  DATA: lr_env         TYPE REF TO cl_ish_environment,
        lr_err         TYPE REF TO cl_ishmed_errorhandling,
        lr_mov         TYPE REF TO cl_ishmed_outpat_visit,
        lr_app         TYPE REF TO cl_ish_appointment.

* first get all surgery movement-types ...
  REFRESH lt_tn14b.
  SELECT * FROM tn14b INTO TABLE lt_tn14b
    WHERE einri = pa_einri
      AND ( ambop = 'X' OR
            opera = 'X' ).
  CHECK NOT lt_tn14b[] IS INITIAL.

* get all movements
  REFRESH gt_nbew.
  SELECT * FROM nbew INTO TABLE gt_nbew
    FOR ALL ENTRIES IN lt_tn14b
    WHERE einri = pa_einri
      AND bwidt IN so_bwidt
      AND orgpf = pa_orgpf
      AND bewty = lt_tn14b-bewty
      AND storn = ' '.
  CHECK NOT gt_nbew[] IS INITIAL.

  CLEAR: lr_env, lr_err.
  CALL METHOD cl_ish_fac_environment=>create
    EXPORTING
      i_program_name = 'RN1_GENERATE_MISSING_OP_APPS'
    IMPORTING
      e_instance     = lr_env
      e_rc           = l_rc
    CHANGING
      c_errorhandler = lr_err.
  CHECK lr_env IS BOUND.

  CLEAR: ls_nbew.
  REFRESH: gt_nlei, gt_nlem, gt_nlei_anchor, gt_nlem_anchor.

  LOOP AT gt_nbew INTO ls_nbew.
    l_idx = sy-tabix.
    CALL METHOD cl_ish_fac_outpat_visit=>load
      EXPORTING
        i_einri        = ls_nbew-einri
        i_falnr        = ls_nbew-falnr
        i_lfdnr        = ls_nbew-lfdnr
        is_nbew        = ls_nbew
        i_read_db      = ' '
        i_environment  = lr_env
      IMPORTING
        e_instance     = lr_mov
        e_rc           = l_rc
      CHANGING
        c_errorhandler = lr_err.
    CHECK lr_mov IS BOUND.

*   get appointment for movement
    CALL METHOD cl_ishmed_outpat_visit=>get_appmnt_for_movement
      EXPORTING
        i_movement     = lr_mov
      IMPORTING
        e_rc           = l_rc
        e_appmnt       = lr_app
      CHANGING
        c_errorhandler = lr_err.
    CHECK l_rc = 0.
    IF lr_app IS BOUND.
      DELETE gt_nbew INDEX l_idx.
      CONTINUE.
    ENDIF.

    CLEAR: lt_objectlist[], ls_object.
    ls_object-object = lr_mov.
    INSERT ls_object INTO TABLE lt_objectlist.

    REFRESH: lt_nlei, lt_nlem, lt_nlei_anchor, lt_nlem_anchor.

    CALL METHOD cl_ishmed_functions=>get_services
      EXPORTING
        it_objects         = lt_objectlist
        i_cancelled_datas  = ' '
        i_conn_srv         = 'X'
        i_only_main_anchor = ' '
      IMPORTING
        e_rc               = l_rc
        et_nlei            = lt_nlei
        et_nlem            = lt_nlem
        et_anchor_nlei     = lt_nlei_anchor
        et_anchor_nlem     = lt_nlem_anchor
      CHANGING
        c_environment      = lr_env
        c_errorhandler     = lr_err.
    CHECK l_rc = 0.
    APPEND LINES OF lt_nlei TO gt_nlei.
    APPEND LINES OF lt_nlem TO gt_nlem.
    APPEND LINES OF lt_nlei_anchor TO gt_nlei_anchor.
    APPEND LINES OF lt_nlem_anchor TO gt_nlem_anchor.
  ENDLOOP.

  IF lr_mov IS BOUND.
    CALL METHOD lr_mov->if_ish_data_object~destroy.
    CLEAR lr_mov.
  ENDIF.
  IF lr_app IS BOUND.
    CALL METHOD lr_app->if_ish_data_object~destroy.
    CLEAR lr_app.
  ENDIF.
  IF lr_err IS BOUND.
    CALL METHOD lr_err->initialize.
    CLEAR lr_err.
  ENDIF.
  IF lr_env IS BOUND.
    CALL METHOD lr_env->if_ish_data_object~destroy.
    CLEAR lr_env.
  ENDIF.

ENDFORM.                    " SELECT_DATA
*&---------------------------------------------------------------------*
*&      Form  GENERATE_APP
*&---------------------------------------------------------------------*
FORM generate_app.

  DATA: ls_nbew        TYPE nbew,
        ls_nlei_anchor TYPE nlei,
        ls_nlei        TYPE nlei,
        ls_nlem        TYPE nlem,
        ls_ntmn        TYPE ntmn.
  DATA: lt_nlei        TYPE STANDARD TABLE OF nlei,
        lt_nlem        TYPE STANDARD TABLE OF nlem.
  DATA: l_rc           TYPE ish_method_rc.

  LOOP AT gt_nbew INTO ls_nbew.
    CLEAR: ls_nlei_anchor.
    READ TABLE gt_nlei_anchor INTO ls_nlei_anchor WITH KEY einri  = ls_nbew-einri
                                                           falnr  = ls_nbew-falnr
                                                           lfdbew = ls_nbew-lfdnr.
    IF sy-subrc = 0.

      REFRESH: lt_nlei, lt_nlem. CLEAR ls_nlei.
      LOOP AT gt_nlei INTO ls_nlei WHERE einri  = ls_nbew-einri
                                     AND falnr  = ls_nbew-falnr
                                     AND lfdbew = ls_nbew-lfdnr.
        CLEAR ls_nlem.
        READ TABLE gt_nlem INTO ls_nlem WITH KEY lnrls = ls_nlei-lnrls.
        IF sy-subrc = 0.
          APPEND ls_nlei TO lt_nlei.
          APPEND ls_nlem TO lt_nlem.
        ENDIF.
        CLEAR ls_nlei.
      ENDLOOP.

      IF pa_test = ' '.

        CLEAR: ls_ntmn.
        CALL FUNCTION 'ISHMED_TERMIN_SAVE_FOR_ANK_BEW'
          EXPORTING
            i_anklei = ls_nlei_anchor
          IMPORTING
            e_rc     = l_rc
            e_ntmn   = ls_ntmn
          TABLES
            t_nlei   = lt_nlei[]
            t_nlem   = lt_nlem[].

        IF sy-subrc = 0.

          WRITE:/1(8)   ls_nbew-orgpf.
          WRITE: 11(10) ls_nbew-bwidt USING EDIT MASK '__.__.____'.
          WRITE: 24(10) ls_nbew-falnr.
          WRITE: 37(20) ls_nbew-lfdnr.
          WRITE: 60(13) ls_nlei_anchor-lnrls.
          WRITE: 76(10) ls_ntmn-tmnid.
          WRITE:/ sy-uline.

        ENDIF.

      ELSE.

        WRITE:/1(8)   ls_nbew-orgpf.
        WRITE: 11(10) ls_nbew-bwidt USING EDIT MASK '__.__.____'.
        WRITE: 24(10) ls_nbew-falnr.
        WRITE: 37(20) ls_nbew-lfdnr.
        WRITE: 60(13) ls_nlei_anchor-lnrls.
        WRITE: 76(30) text-h07.
        WRITE:/ sy-uline.

      ENDIF.

    ENDIF.

    CLEAR: ls_nbew.
  ENDLOOP.

ENDFORM.                    " GENERATE_APP
*&---------------------------------------------------------------------*
*&      Form  HEADER
*&---------------------------------------------------------------------*
FORM header.

  WRITE:/1(8)   text-h01 COLOR 4 INTENSIFIED ON.
  WRITE: 11(10) text-h02 COLOR 4 INTENSIFIED ON.
  WRITE: 24(10) text-h03 COLOR 4 INTENSIFIED ON.
  WRITE: 37(20) text-h04 COLOR 4 INTENSIFIED ON.
  WRITE: 60(13) text-h05 COLOR 4 INTENSIFIED ON.
  WRITE: 76(10) text-h06 COLOR 4 INTENSIFIED ON.
  WRITE:/ sy-uline.

ENDFORM.                    " HEADER
