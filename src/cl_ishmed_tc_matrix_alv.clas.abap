class CL_ISHMED_TC_MATRIX_ALV definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !I_PARENT type ref to CL_GUI_CONTAINER
      !IT_MATRIX type RN1TC_MATRIX_T .
  methods FREE .
protected section.
private section.

  data GR_ALV_GRID type ref to CL_GUI_ALV_GRID .
  data GT_DATA type RN1TC_MATRIX_T .

  methods INIT_ALV
    importing
      !I_PARENT type ref to CL_GUI_CONTAINER .
ENDCLASS.



CLASS CL_ISHMED_TC_MATRIX_ALV IMPLEMENTATION.


method CONSTRUCTOR.
  gt_data = it_matrix.
  init_alv( i_parent = i_parent ).
endmethod.


method FREE.
  if gr_alv_grid is bound.
    gr_alv_grid->free( ).
  endif.

  free gt_data.
endmethod.


METHOD init_alv.

***********************************************************************
** data section
***********************************************************************
  DATA l_fcat    TYPE lvc_t_fcat.
  DATA l_layout	 TYPE lvc_s_layo.
  DATA l_wa_fcat TYPE lvc_s_fcat.
***********************************************************************

  CLEAR l_wa_fcat.
  CLEAR l_fcat.

***********************************************************************
** build fieldcatalog for structure N2TBS_SM_TAG
***********************************************************************
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'RN1TC_MATRIX'
    CHANGING
      ct_fieldcat      = l_fcat.

***********************************************************************
** make editable and hiden fields
***********************************************************************
  LOOP AT l_fcat INTO l_wa_fcat.
*    l_wa_fcat-colddictxt = 'M'.
    CASE l_wa_fcat-fieldname.
      WHEN 'DEPTOU'.
        l_wa_fcat-col_pos = 1.
        l_wa_fcat-outputlen = 20.
      WHEN 'TREAOU'.
        l_wa_fcat-col_pos = 2.
        l_wa_fcat-outputlen = 20.
      WHEN 'DAYS_EXT'.
        l_wa_fcat-col_pos = 3.
        l_wa_fcat-outputlen = 10.
      WHEN 'DAYS_APPL'.
        l_wa_fcat-col_pos = 4.
        l_wa_fcat-outputlen = 8.
      WHEN 'CLASSIFICATION'.
        l_wa_fcat-col_pos = 5.
        l_wa_fcat-outputlen = 11.
      WHEN 'RESP_TYPE'.
        l_wa_fcat-col_pos = 6.
        l_wa_fcat-outputlen = 12.
    ENDCASE.
    MODIFY l_fcat FROM l_wa_fcat.
  ENDLOOP.

***********************************************************************
** Make the tag ALV  object
***********************************************************************
  CREATE OBJECT gr_alv_grid
    EXPORTING
*      I_SHELLSTYLE      = 0
*      I_LIFETIME        =
      i_parent          = i_parent
*      I_APPL_EVENTS     = space
*      I_PARENTDBG       =
*      I_APPLOGPARENT    =
*      I_GRAPHICSPARENT  =
*      I_USE_VARIANT_CLASS = SPACE
*      I_NAME            =
     EXCEPTIONS
       error_cntl_create = 1
       error_cntl_init   = 2
       error_cntl_link   = 3
       error_dp_create   = 4
       OTHERS            = 5.

  IF sy-subrc <> 0.
*    MESSAGE ID 'N2GL_SDEF' TYPE 'E' NUMBER 026
*             WITH sy-subrc.
  ENDIF.

  CLEAR l_layout.
  l_layout-sgl_clk_hd = 'X'.
  l_layout-no_totline = 'X'.
  l_layout-no_toolbar = 'X'.


***********************************************************************
** now display data
***********************************************************************
  CALL METHOD gr_alv_grid->set_table_for_first_display
    EXPORTING
*     I_BUFFER_ACTIVE               =
*     I_STRUCTURE_NAME              =
*     IS_VARIANT                    =
*     I_SAVE                        =
*     I_DEFAULT                     = 'X'
      is_layout                     = l_layout
*     IS_PRINT                      =
*     IT_SPECIAL_GROUPS             =
*     it_toolbar_excluding          = lt_tbar_excl
*     IT_HYPERLINK                  =
*     IT_ALV_GRAPHICS               =
    CHANGING
      it_outtab                     = gt_data
      it_fieldcatalog               = l_fcat
*     IT_SORT                       =
*     IT_FILTER                     =
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4.

  IF sy-subrc <> 0.
*    MESSAGE s807(n2gl_sdef) WITH 'INIT_DIA' sy-subrc.
  ENDIF.


ENDMETHOD.
ENDCLASS.
