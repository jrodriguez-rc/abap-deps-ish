class CL_ISH_STSMA definition
  public
  create protected .

*"* public components of class CL_ISH_STSMA
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .

  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases NO
    for IF_ISH_CONSTANT_DEFINITION~NO .
  aliases OFF
    for IF_ISH_CONSTANT_DEFINITION~OFF .
  aliases ON
    for IF_ISH_CONSTANT_DEFINITION~ON .
  aliases TRUE
    for IF_ISH_CONSTANT_DEFINITION~TRUE .
  aliases YES
    for IF_ISH_CONSTANT_DEFINITION~YES .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases IS_A
    for IF_ISH_IDENTIFY_OBJECT~IS_A .
  aliases IS_INHERITED_FROM
    for IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM .

  constants CO_OTYPE_STSMA type ISH_OBJECT_TYPE value 49. "#EC NOTEXT

  methods GET_T_NEXT_ESTAT
    importing
      !IR_ESTAT type ref to CL_ISH_ESTAT optional
      value(I_ESTAT) type J_ESTAT optional
      value(I_INCLUDE_ESTAT) type ISH_ON_OFF default OFF
    exporting
      value(ER_ESTAT) type ISH_T_ESTAT .
  methods CONSTRUCTOR
    importing
      value(IS_TJ20) type TJ20
      value(IS_TJ20T) type TJ20T .
  class-methods LOAD
    importing
      value(I_STSMA) type TJ20-STSMA optional
      value(IS_TJ20) type TJ20 optional
      value(IS_TJ20T) type TJ20T optional
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_STSMA .
  methods CHECK_ESTAT_TRANSITION
    importing
      !IR_ESTAT_PRE type ref to CL_ISH_ESTAT optional
      value(I_ESTAT_PRE) type J_ESTAT optional
      !IR_ESTAT_POST type ref to CL_ISH_ESTAT optional
      value(I_ESTAT_POST) type J_ESTAT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DATA
    exporting
      value(ES_TJ20) type TJ20
      value(ES_TJ20T) type TJ20T .
  class-methods GET_STSMA_OBJECT
    importing
      value(I_OBTYP) type J_OBTYP
      value(I_STSMA) type TJ20-STSMA
    exporting
      value(ER_STSMA) type ref to CL_ISH_STSMA .
  class-methods GET_T_AVAILABLE_STSMA
    importing
      value(I_REFRESH) type ISH_ON_OFF default ''
      value(I_OBTYP) type TJ21-OBTYP
    exporting
      value(ET_STSMA) type ISH_T_STSMA .
  methods GET_INITIAL_ESTAT
    exporting
      value(ER_ESTAT) type ref to CL_ISH_ESTAT .
  methods GET_ESTAT
    importing
      value(I_ESTAT) type J_ESTAT optional
      value(I_TXT30) type J_TXT30 optional
    exporting
      value(ER_ESTAT) type ref to CL_ISH_ESTAT .
  methods GET_ESTAT_TRANSITIONS
    importing
      value(I_INCLUDE_STAR) type ISH_ON_OFF
    returning
      value(RT_ESTAT_TRANS) type ISH_T_ESTAT_TRANSITION .
  methods GET_NEXT_ESTAT
    importing
      !IR_ESTAT type ref to CL_ISH_ESTAT optional
      value(I_ESTAT) type J_ESTAT optional
    exporting
      value(ER_NEXT_ESTAT) type ref to CL_ISH_ESTAT
      value(E_NEXT_ESTAT) type J_ESTAT
      value(E_FINAL_ESTAT) type ISH_ON_OFF .
  methods GET_STSMA
    returning
      value(R_STSMA) type TJ20-STSMA .
  methods GET_T_ESTAT
    exporting
      value(ET_ESTAT) type ISH_T_ESTAT .
  methods GET_TXT
    returning
      value(R_TXT) type TJ20T-TXT .
protected section.
*"* protected components of class CL_ISH_STSMA
*"* do not include other source files here!!!

  class-data GT_STSMAA type ISH_T_STSMAA .
  data GS_TJ20 type TJ20 .
  data GS_TJ20T type TJ20T .
  data GT_ESTAT type ISH_T_ESTAT .
  data G_ESTAT_READ type ISH_ON_OFF .
private section.
*"* private components of class CL_ISH_STSMA
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_STSMA IMPLEMENTATION.


METHOD check_estat_transition.

  DATA: lr_estat_pre    TYPE REF TO cl_ish_estat,
        ls_tj30_pre     TYPE tj30,
        lb_estat_pre    TYPE boolean,
        lr_estat_post   TYPE REF TO cl_ish_estat,
        ls_tj30_post    TYPE tj30,
        lb_estat_post   TYPE boolean,
        lr_estat        TYPE REF TO cl_ish_estat,
        ls_tj30         TYPE tj30.

* Initialization.
  e_rc = 1.             "estat change not possible

* Check estat_pre.
  IF ir_estat_pre IS INITIAL AND
     i_estat_pre  IS INITIAL.
    EXIT.
  ENDIF.
* Check estat_post.
  IF ir_estat_post IS INITIAL AND
     i_estat_post  IS INITIAL.
    EXIT.
  ENDIF.

* Handle estat pre.
  IF ir_estat_pre IS INITIAL.
*   Get object of imported estat.
    CALL METHOD get_estat
      EXPORTING
        i_estat  = i_estat_pre
      IMPORTING
        er_estat = lr_estat_pre.
  ELSE.
*   Set imported estat object.
    lr_estat_pre = ir_estat_pre.
  ENDIF.

* Handle estat_post.
  IF ir_estat_post IS INITIAL.
*   Get object of imported estat.
    CALL METHOD get_estat
      EXPORTING
        i_estat  = i_estat_post
      IMPORTING
        er_estat = lr_estat_post.
  ELSE.
*   Set imported estat object.
    lr_estat_post = ir_estat_post.
  ENDIF.

* There must be estat objects.
  IF lr_estat_pre  IS INITIAL OR
     lr_estat_post IS INITIAL.
    EXIT.
  ENDIF.

* Get estat data.
  CALL METHOD lr_estat_pre->get_data
    IMPORTING
      es_tj30 = ls_tj30_pre.

  CALL METHOD lr_estat_post->get_data
    IMPORTING
      es_tj30 = ls_tj30_post.

* Ensure that all estat objects are loaded.
  CALL METHOD get_t_estat.

* Loop estat objects.
  LOOP AT gt_estat INTO lr_estat.
    CHECK NOT lr_estat IS INITIAL.
*   Get estat data.
    CALL METHOD lr_estat->get_data
      IMPORTING
        es_tj30 = ls_tj30.
*   Compare estat.
    IF ls_tj30-estat = ls_tj30_pre-estat.
      lb_estat_pre = on.
    ENDIF.
    IF ls_tj30-estat = ls_tj30_post-estat.
      lb_estat_post = on.
    ENDIF.
  ENDLOOP.

* Check estat in stsma.
  CHECK lb_estat_pre  = on AND
        lb_estat_post = on.

* Check stonr.
  CHECK ls_tj30_post-stonr >= ls_tj30_pre-nsonr AND
        ls_tj30_post-stonr <= ls_tj30_pre-hsonr.

  e_rc = 0.             "estat change possible

ENDMETHOD.


METHOD constructor .

  gs_tj20  = is_tj20.
  gs_tj20t = is_tj20t.

ENDMETHOD.


METHOD get_data .

  es_tj20  = gs_tj20.
  es_tj20t = gs_tj20t.

ENDMETHOD.


METHOD get_estat .

  DATA: l_estat TYPE tj30-estat.

* Ensure that all estat objects are loaded.
  CALL METHOD get_t_estat.

* Search for ESTAT
  LOOP AT gt_estat INTO er_estat.
    IF NOT i_estat IS INITIAL.
      CALL METHOD er_estat->get_estat
        IMPORTING
          e_estat = l_estat.
      IF i_estat = l_estat.
        EXIT.
      ENDIF.
    ELSE.
      IF er_estat->get_txt30( ) = i_txt30.
        EXIT.
      ENDIF.
    ENDIF.
    CLEAR er_estat.
  ENDLOOP.

ENDMETHOD.


METHOD get_estat_transitions .

  TYPES: BEGIN OF s_estat,
          estat     TYPE tj30-estat,
          stonr     TYPE tj30-stonr,
          nsonr     TYPE tj30-nsonr,
          hsonr     TYPE tj30-hsonr,
          txt30     TYPE tj30t-txt30,
         END OF s_estat.

  DATA: ls_estat_trans  TYPE rn1_estat_transition,
        lr_estat        TYPE REF TO cl_ish_estat,
        ls_tj30         TYPE tj30,
        ls_tj30t        TYPE tj30t.

  DATA: lt_estat        TYPE TABLE OF s_estat,
        ls_estat        TYPE s_estat,
        ls_estat2       TYPE s_estat.

* Load all estat objects.
  CALL METHOD get_t_estat.

* get data of estat objects
  LOOP AT gt_estat INTO lr_estat.
    CALL METHOD lr_estat->get_data
      IMPORTING
        es_tj30  = ls_tj30
        es_tj30t = ls_tj30t.

    ls_estat-estat = ls_tj30-estat.
    ls_estat-stonr = ls_tj30-stonr.
    ls_estat-nsonr = ls_tj30-nsonr.
    ls_estat-hsonr = ls_tj30-hsonr.
    ls_estat-txt30 = ls_tj30t-txt30.

    APPEND ls_estat TO lt_estat.
    CLEAR ls_estat.
  ENDLOOP.

*  sort estat entries
   sort lt_estat ascending by stonr.

* fill return table with estat transitions
  LOOP AT lt_estat INTO ls_estat.
    LOOP AT lt_estat INTO ls_estat2.
      IF ls_estat2-stonr = ls_estat-stonr
      OR ls_estat2-stonr < ls_estat-nsonr
      OR ls_estat2-stonr > ls_estat-hsonr.
        CLEAR ls_estat2.
        CONTINUE.
      ENDIF.

      ls_estat_trans-estat_pre  = ls_estat-estat.
      ls_estat_trans-txt30_pre  = ls_estat-txt30.
      ls_estat_trans-estat_post = ls_estat2-estat.
      ls_estat_trans-txt30_post = ls_estat2-txt30.
      APPEND ls_estat_trans TO rt_estat_trans.
      CLEAR ls_estat_trans.
    ENDLOOP.

    IF i_include_star = on.
      ls_estat_trans-estat_pre = '*'.
      ls_estat_trans-txt30_pre = '*'.
      ls_estat_trans-estat_post = ls_estat-estat.
      ls_estat_trans-txt30_post = ls_estat-txt30.
      APPEND ls_estat_trans TO rt_estat_trans.
      CLEAR ls_estat_trans.

      ls_estat_trans-estat_pre = ls_estat-estat.
      ls_estat_trans-txt30_pre = ls_estat-txt30.
      ls_estat_trans-estat_post = '*'.
      ls_estat_trans-txt30_post = '*'.
      APPEND ls_estat_trans TO rt_estat_trans.
      CLEAR ls_estat_trans.
    ENDIF.
  ENDLOOP.

ENDMETHOD.


METHOD get_initial_estat .

  DATA: l_inist TYPE tj30-inist.

* Ensure that all estat objects are loaded.
  CALL METHOD get_t_estat.

* Search for the inital estat object.
  LOOP AT gt_estat INTO er_estat.
    CALL METHOD er_estat->get_inist
      IMPORTING
        e_inist = l_inist.
    IF l_inist = on.
      EXIT.
    ENDIF.
    CLEAR er_estat.
  ENDLOOP.

ENDMETHOD.


METHOD get_next_estat.

  DATA: lr_estat        TYPE REF TO cl_ish_estat,
        ls_tj30         TYPE tj30,
        ls_tj30t        TYPE tj30t,
        l_stonr         TYPE tj30-stonr,
        l_nsonr         TYPE tj30-nsonr,
        l_hsonr         TYPE tj30-hsonr,
        l_stonr_next    TYPE tj30-stonr.

* Initializations (return imported estat).
  er_next_estat = ir_estat.
  e_next_estat  = i_estat.
  e_final_estat = off.

* At least one parameter must be supplied.
  CHECK NOT ir_estat IS INITIAL
     OR NOT i_estat  IS INITIAL.

  IF ir_estat IS INITIAL.
*   Get object of imported estat.
    CALL METHOD get_estat
      EXPORTING
        i_estat  = i_estat
      IMPORTING
        er_estat = lr_estat.
  ELSE.
*   Set imported estat object.
    lr_estat = ir_estat.
  ENDIF.

* There must be an estat object.
  CHECK NOT lr_estat IS INITIAL.

* Get estat data.
  CALL METHOD lr_estat->get_data
    IMPORTING
      es_tj30  = ls_tj30
      es_tj30t = ls_tj30t.

* Initializations (return current estat).
  er_next_estat = lr_estat.
  e_next_estat  = ls_tj30-estat.

* Save estat data.
  l_stonr = ls_tj30-stonr.
  l_nsonr = ls_tj30-nsonr.
  l_hsonr = ls_tj30-hsonr.

* Current stonr equal final stonr => no further processing.
  IF l_stonr = l_hsonr.
    e_final_estat = on.
  ENDIF.

* Ensure that all estat objects are loaded.
  CALL METHOD get_t_estat.

* Loop estat objects.
  LOOP AT gt_estat INTO lr_estat.
    CLEAR: ls_tj30, ls_tj30t.
*   Get estat data.
    CALL METHOD lr_estat->get_data
      IMPORTING
        es_tj30  = ls_tj30
        es_tj30t = ls_tj30t.
*   Compare stonr.
    CHECK ls_tj30-stonr > l_stonr.
    CHECK l_stonr_next IS INITIAL
       OR l_stonr_next >  ls_tj30-stonr.
*   Return next estat.
    er_next_estat = lr_estat.
    e_next_estat  = ls_tj30-estat.
*   Save stonr for compare.
    l_stonr_next  = ls_tj30-stonr.
  ENDLOOP.

ENDMETHOD.


METHOD get_stsma .

  r_stsma = gs_tj20-stsma.

ENDMETHOD.


METHOD get_stsma_object .

  DATA: lt_stsma TYPE ish_t_stsma.

* Initializations
  CLEAR: er_stsma.

* Get compdefs for i_obtyp
  CALL METHOD get_t_available_stsma
    EXPORTING
      i_obtyp  = i_obtyp
    IMPORTING
      et_stsma = lt_stsma.

* Get the specified stsma.
  LOOP AT lt_stsma INTO er_stsma.
    IF er_stsma->get_stsma( ) = i_stsma.
      EXIT.
    ENDIF.
    CLEAR er_stsma.
  ENDLOOP.

ENDMETHOD.


METHOD get_txt .

  r_txt = gs_tj20t-txt.

ENDMETHOD.


METHOD get_t_available_stsma .

  TYPES: BEGIN OF ty_join,
           ls_tj20     TYPE tj20,
           ls_tj20t    TYPE tj20t,
           ls_tj21     TYPE tj21,
         END OF ty_join.
  DATA: lt_join   TYPE TABLE OF ty_join,
        lr_stsma  TYPE REF TO cl_ish_stsma,
        ls_stsmaa TYPE rn1_stsmaa.
  FIELD-SYMBOLS: <ls_join>     TYPE ty_join,
                 <ls_stsmaa>   TYPE rn1_stsmaa.

  DATA: lt_tj20  TYPE TABLE OF tj20,   "Grill, ID-20652
        ls_tj20  TYPE tj20.            "Grill, ID-20652

* Determine if the specified stsma were already read.
  READ TABLE gt_stsmaa ASSIGNING <ls_stsmaa>
       WITH KEY obtyp = i_obtyp.
  IF sy-subrc = 0.
    IF i_refresh = on.
*     On refresh delete the entry and read again.
      DELETE gt_stsmaa INDEX sy-tabix.
    ELSE.
      IF et_stsma IS SUPPLIED.
        et_stsma = <ls_stsmaa>-t_stsma.
        EXIT.
      ENDIF.
    ENDIF.
  ENDIF.

* Create a new entry in gt_stsmaa.
  ls_stsmaa-obtyp = i_obtyp.

* Read all stsma with i_obtyp into lt_join.
* lt_join will contain 1-n entries for each stsma
* (one for each language)
  SELECT * INTO TABLE lt_join
      FROM ( tj20 AS a
             LEFT OUTER JOIN tj20t AS b
             ON a~stsma = b~stsma )
        INNER JOIN tj21 AS c                           "#EC CI_BUFFJOIN
        ON a~stsma = c~stsma
      WHERE c~obtyp = i_obtyp
      ORDER BY b~txt ASCENDING.

* Create a stsma object for each relevant stsma
* (depending on sy-langu).
  LOOP AT lt_join ASSIGNING <ls_join>.
*-- begin Grill ID-20652
*    CHECK <ls_join>-ls_tj20t-spras = sy-langu.              " ID 15502
    IF <ls_join>-ls_tj20t-spras <> sy-langu.
*     This stsma entry is not for the current language.
*     Is there a stsma for the current language?
      READ TABLE lt_join
        WITH KEY ls_tj20-stsma = <ls_join>-ls_tj20-stsma
                 ls_tj20t-spras = sy-langu
             TRANSPORTING NO FIELDS.
      IF sy-subrc = 0.
*       There is a stsma for the current language.
*       So ignore this entry.
        CONTINUE.
      ENDIF.
    ENDIF.
*-- end  Grill
*    IF <ls_join>-ls_tj20t-spras <> sy-langu.
**     This stsma entry is not for the current language.
**     Is there a stsma for the current language?
*      READ TABLE lt_join
*        WITH KEY ls_tj20-stsma = <ls_join>-ls_tj20-stsma
*                 ls_tj20t-spras = sy-langu
*        TRANSPORTING NO FIELDS.
*      IF sy-subrc = 0.
**       There is a stsma for the current language.
**       So ignore this entry.
*        CONTINUE.
*      ELSE.
**       There is no stsma for the current language.
**       So create a stsma object with empty text data.
*        CLEAR <ls_join>-ls_tj20t.
*        <ls_join>-ls_tj20t-spras = sy-langu.
*      ENDIF.
*    ENDIF.
*   Instantiate a new stsma object
*-- begin Grill ID-20652
    READ TABLE lt_tj20 INTO ls_tj20 WITH KEY stsma = <ls_join>-ls_tj20-stsma.
    CHECK sy-subrc NE 0.
*-- end Grill ID-20652
    CALL METHOD cl_ish_stsma=>load
      EXPORTING
        is_tj20     = <ls_join>-ls_tj20
        is_tj20t    = <ls_join>-ls_tj20t
      IMPORTING
        er_instance = lr_stsma.
*   Append the stsma object to ls_stsmaa.
    IF NOT lr_stsma IS INITIAL.
      APPEND lr_stsma TO ls_stsmaa-t_stsma.
      APPEND <ls_join>-ls_tj20 TO lt_tj20.           "Grill, ID-20652
    ENDIF.
*   ENDIF.
  ENDLOOP.

* Save the new entry.
  APPEND ls_stsmaa TO gt_stsmaa.

  CHECK et_stsma IS SUPPLIED.

  et_stsma = ls_stsmaa-t_stsma.

ENDMETHOD.


METHOD get_t_estat .

* Workareas
  DATA: lt_tj30  TYPE TABLE OF tj30,
        l_tj30   TYPE tj30,
        lt_tj30t TYPE TABLE OF tj30t,
        l_tj30t  TYPE tj30t,
        lr_estat TYPE REF TO cl_ish_estat.

  DATA: lt_check_estat TYPE TABLE OF tj30,  "Grill, ID-20652
        ls_check_estat TYPE tj30.           "Grill, ID-20652

* Initializations
  CLEAR: et_estat.

* if estat's already read -> return them
  IF g_estat_read = on.
    IF et_estat IS SUPPLIED.
      et_estat = gt_estat.
    ENDIF.
    EXIT.
  ENDIF.

* Read TJ30
  SELECT * FROM tj30
    INTO TABLE lt_tj30                                   "#EC CI_BYPASS
    WHERE stsma = gs_tj20-stsma
*    ORDER BY estat.                                 " REM ID 15785
    ORDER BY stonr.                                      " ID 15785
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

* Read TJ30T
  SELECT * FROM tj30t
    INTO TABLE lt_tj30t                                  "#EC CI_BYPASS
    WHERE stsma = gs_tj20-stsma
*          spras = sy-langu                            "Grill, ID-20652
    ORDER BY estat.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

* Create object CL_ISH_ESTAT for each entry
  LOOP AT lt_tj30 INTO l_tj30.
*-- begin Grill, ID-20652
    READ TABLE lt_tj30t INTO l_tj30t WITH KEY
         estat = l_tj30-estat
         spras = sy-langu.
    IF sy-subrc NE 0.
      READ TABLE lt_tj30t INTO l_tj30t WITH KEY
            estat = l_tj30-estat.
      CHECK sy-subrc EQ 0.

      READ TABLE lt_check_estat INTO ls_check_estat WITH KEY
       estat = l_tj30-estat.
      CHECK sy-subrc NE 0.
    ENDIF.
    CHECK  l_tj30t-estat = l_tj30-estat.
*    LOOP AT lt_tj30t INTO l_tj30t.
*      IF l_tj30t-estat = l_tj30-estat.
*-- end Grill, ID-20652
    CALL METHOD cl_ish_estat=>load
      EXPORTING
        is_tj30     = l_tj30
        is_tj30t    = l_tj30t
      IMPORTING
        er_instance = lr_estat.
    IF sy-subrc <> 0.
      CLEAR lr_estat.
    ENDIF.
    CHECK NOT lr_estat IS INITIAL.
    APPEND lr_estat TO gt_estat.
    APPEND l_tj30 TO lt_check_estat.    "Grill, ID-20652
*    EXIT.        "Grill, ID-20652
*  ENDIF.         "Grill, ID-20652
*    ENDLOOP.     "Grill, ID-20652
  ENDLOOP.

  g_estat_read = on.

  IF et_estat IS SUPPLIED.
    et_estat = gt_estat.
  ENDIF.

ENDMETHOD.


METHOD get_t_next_estat .

  DATA: lr_estat        TYPE REF TO cl_ish_estat,
        ls_tj30         TYPE tj30,
        ls_tj30t        TYPE tj30t,
        l_stonr         TYPE tj30-stonr,
        l_nsonr         TYPE tj30-nsonr,
        l_hsonr         TYPE tj30-hsonr.

* Check parameters.
  IF ir_estat IS INITIAL AND
     i_estat  IS INITIAL.
    EXIT.
  ENDIF.

  IF ir_estat IS INITIAL.
*   Get object for imported estat.
    CALL METHOD get_estat
      EXPORTING
        i_estat  = i_estat
      IMPORTING
        er_estat = lr_estat.
  ELSE.
*   Set imported estat object.
    lr_estat = ir_estat.
  ENDIF.
  CHECK NOT lr_estat IS INITIAL.

* Ensure that all estat objects are loaded.
  CALL METHOD get_t_estat.

* Get data of imported estat.
  CALL METHOD lr_estat->get_data
    IMPORTING
      es_tj30  = ls_tj30
      es_tj30t = ls_tj30t.

  l_stonr = ls_tj30-stonr.
  l_nsonr = ls_tj30-nsonr.
  l_hsonr = ls_tj30-hsonr.

* Get data of estat objects.
  CLEAR: lr_estat, ls_tj30, ls_tj30t.

* Loop estat objects.
  LOOP AT gt_estat INTO lr_estat.
    CALL METHOD lr_estat->get_data
      IMPORTING
        es_tj30  = ls_tj30
        es_tj30t = ls_tj30t.
*   Check stonr.
    CHECK ls_tj30-stonr >= l_nsonr AND
          ls_tj30-stonr <= l_hsonr.
    IF i_include_estat = off.
      CHECK ls_tj30-stonr <> l_stonr.
    ENDIF.

*   Set for export.
    APPEND lr_estat TO er_estat.
  ENDLOOP.

ENDMETHOD.


METHOD if_ish_identify_object~get_type .

  e_object_type = co_otype_stsma.

ENDMETHOD.


METHOD if_ish_identify_object~is_a .

  IF i_object_type = co_otype_stsma.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from .

  IF i_object_type = co_otype_stsma.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD load .

  DATA: ls_tj20  TYPE tj20,
        ls_tj20t TYPE tj20t,
        lt_tj20t TYPE TABLE OF tj20t. "Grill, ID-20652

  IF is_tj20 IS INITIAL.
*   Read TJ20
    SELECT SINGLE *
      FROM tj20
      INTO ls_tj20
      WHERE stsma = i_stsma.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    ls_tj20 = is_tj20.
  ENDIF.

  IF is_tj20t IS INITIAL.
*-- begin Grill, ID-20652
*--   Read TJ20T
    SELECT * FROM tj20t INTO TABLE lt_tj20t
      WHERE stsma = i_stsma.
    READ TABLE lt_tj20t INTO ls_tj20t with key
      spras = sy-langu.
    IF sy-subrc NE 0.
      READ TABLE lt_tj20t INTO ls_tj20t INDEX 1.
    ENDIF.
*-- begin delete Grill, ID-20652
**   Read TJ20T
*    SELECT SINGLE *
*      FROM tj20t
*      INTO ls_tj20t
*      WHERE stsma = i_stsma.
*       AND   spras = sy-langu.
*-- end Grill, ID-20652
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
  ELSE.
    ls_tj20t = is_tj20t.
  ENDIF.

* Create self
  CREATE OBJECT er_instance
    EXPORTING
    is_tj20 = ls_tj20
    is_tj20t = ls_tj20t.

ENDMETHOD.
ENDCLASS.
