*----------------------------------------------------------------------*
***INCLUDE LN1STATUSF01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  build_status_grid
*&---------------------------------------------------------------------*
*       build grid for status popup
*----------------------------------------------------------------------*
FORM build_status_grid .

  DATA: l_vcode         TYPE ish_vcode.

  l_vcode = g_vcode.

  IF g_container IS INITIAL.
*   Custom control container
    CREATE OBJECT g_container
      EXPORTING
        container_name    = 'CONTAINER'.
    IF sy-subrc <> 0.
    ENDIF.
*   ALV grid for status selection
    CREATE OBJECT g_grid_status
      EXPORTING
         i_parent         = g_container
         i_mark           = '2'
         i_caller         = 'LN1STATUSF01'
         i_obtyp          = g_obtyp
         it_stsma         = gt_stsma
         i_vcode          = l_vcode.
    IF sy-subrc <> 0.
    ENDIF.
*   premark status?
    PERFORM set_sel_entries_status.
  ENDIF.

ENDFORM.                    " build_status_grid
*&---------------------------------------------------------------------*
*&      Form  set_sel_entries_status
*&---------------------------------------------------------------------*
*       set selected status
*----------------------------------------------------------------------*
FORM set_sel_entries_status .

  CHECK NOT g_grid_status IS INITIAL.

  IF gt_status_marked[] IS INITIAL AND
     gt_stsma_marked[]  IS INITIAL AND
     gt_estat_marked[]  IS INITIAL.
    EXIT.
  ENDIF.

  CALL METHOD g_grid_status->set_selected_entries
    EXPORTING
      it_status = gt_status_marked
      it_stsma  = gt_stsma_marked
      it_estat  = gt_estat_marked.

ENDFORM.                    " set_sel_entries_status
*&---------------------------------------------------------------------*
*&      Form  get_sel_entries_status
*&---------------------------------------------------------------------*
*       get selected status
*----------------------------------------------------------------------*
FORM get_sel_entries_status.

  CHECK NOT g_grid_status IS INITIAL.

  CALL METHOD g_grid_status->get_selected_entries
    IMPORTING
      et_status     = gt_status_marked
      et_status_obj = gt_status_obj_marked
      et_stsma      = gt_stsma_marked
      et_estat      = gt_estat_marked.

ENDFORM.                    " get_sel_entries_status
*&---------------------------------------------------------------------*
*&      Form  free_status_grid
*&---------------------------------------------------------------------*
*       free status alv grid and container
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM free_status_grid .

  DATA: l_valid  TYPE i.

  IF NOT g_grid_status IS INITIAL.
    CALL METHOD g_grid_status->free.
    CLEAR g_grid_status.
  ENDIF.

  IF NOT g_container IS INITIAL.
    CALL METHOD g_container->is_valid
      IMPORTING
        RESULT = l_valid.
    IF l_valid EQ 1.
      CALL METHOD g_container->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      IF sy-subrc <> 0.
        MESSAGE s700(n4) WITH 'G_CONTAINER' sy-subrc.
      ENDIF.
    ENDIF.
    CLEAR g_container.
  ENDIF.

ENDFORM.                    " free_status_grid
