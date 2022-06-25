*----------------------------------------------------------------------*
***INCLUDE LN1TC_TOOLSF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  INIT_CONTROLS_100
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM init_controls_100 .

  IF gr_cont IS NOT BOUND.

    CREATE OBJECT gr_cont
       EXPORTING
*    PARENT                      =
         container_name              = 'CONT_MATRIX_ALV'
*    STYLE                       =
*    LIFETIME                    = lifetime_default
*    REPID                       =
*    DYNNR                       =
*    NO_AUTODEF_PROGID_DYNNR     =
*  EXCEPTIONS
*    CNTL_ERROR                  = 1
*    CNTL_SYSTEM_ERROR           = 2
*    CREATE_ERROR                = 3
*    LIFETIME_ERROR              = 4
*    LIFETIME_DYNPRO_DYNPRO_LINK = 5
*    others                      = 6
         .
    IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.


    CREATE OBJECT gr_matrix_alv
      EXPORTING
        i_parent  = gr_cont
        it_matrix = gt_matrix.

*    cl_gui_cfw=>flush( ).

  ENDIF.

ENDFORM.                    " INIT_CONTROLS_100
*&---------------------------------------------------------------------*
*&      Form  FREE_OBJECTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM free_objects .
  IF gr_matrix_alv IS BOUND.
    gr_matrix_alv->free( ).
    FREE gr_matrix_alv.
  ENDIF.

  gr_cont->free( ).
  FREE gr_cont.
ENDFORM.                    " FREE_OBJECTS
*&---------------------------------------------------------------------*
*&      Form  INIT_MATRIX_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM init_matrix_data USING p_inititution_id TYPE einri.
  DATA lr_api               TYPE REF TO cl_ishmed_tc_api.

  TRY.
      lr_api = cl_ishmed_tc_api=>load( p_inititution_id ).
    CATCH cx_ishmed_tc.
  ENDTRY.
  lr_api->get_matrix(
    IMPORTING
      et_tc_matrix = gt_matrix    " Die OE-USER Zuordungsmatrix des Behandlungsauftrages
  ).

ENDFORM.                    " INIT_MATRIX_DATA
