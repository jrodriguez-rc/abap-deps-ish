class CL_ISH_DYN_CONTAINER definition
  public
  create protected .

*"* public components of class CL_ISH_DYN_CONTAINER
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_IDENTIFY_OBJECT .

  constants CO_OTYPE_DYN_CONTAINER type ISH_OBJECT_TYPE value 12018. "#EC NOTEXT
  data GR_SPLITTER type ref to CL_GUI_SPLITTER_CONTAINER .
  data G_COLUMNS type I .
  data G_CONTAINER_NAME type STRING .
  data G_ROWS type I .

  methods DESTROY .
  methods ADJUST_CONTAINER
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_CONTAINER type ref to CL_GUI_CONTAINER optional
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CONSTRUCTOR
    importing
      value(I_MAX_NEEDED_CONTAINER) type I default 25
      value(I_CONTAINER_NAME) type C optional
      !IR_PARENT_CONTAINER type ref to CL_GUI_CONTAINER optional
    exceptions
      INSTANCE_NOT_POSSIBLE
      WRONG_INPUT .
  class-methods CREATE
    importing
      value(I_MAX_NEEDED_CONTAINER) type I default 25
      value(I_CONTAINER_NAME) type C optional
      !IR_PARENT_CONTAINER type ref to CL_GUI_CONTAINER optional
    exporting
      !ER_INSTANCE type ref to CL_ISH_DYN_CONTAINER
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
protected section.
*"* protected components of class CL_ISH_DYN_CONTAINER
*"* do not include other source files here!!!

  types:
    begin of TY_POSITION,
           row          type i,
           column       type i,
           container    type ref to cl_gui_container,
         end   of ty_position .
  types:
    tyt_position type standard table of ty_position .

  data GR_PARENT_CONTAINER type ref to CL_GUI_CONTAINER .
  data GS_ACT_POSITION type TY_POSITION .
  data GT_POSITION type TYT_POSITION .

  methods INITIALIZE_CONTROL_PROCESSING
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
private section.
*"* private components of class CL_ISH_DYN_CONTAINER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_DYN_CONTAINER IMPLEMENTATION.


METHOD adjust_container.

* work areas
  DATA: ls_pos                  LIKE LINE OF gt_position.
* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_row                   TYPE i,
        l_column                TYPE i,
        l_height                TYPE i,
        l_width                 TYPE i.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* get height and width of container to set the correct (=max.)
* size of the actual container
  CALL METHOD gr_parent_container->get_height
    IMPORTING
      height     = l_height
    EXCEPTIONS
      cntl_error = 1
      OTHERS     = 2.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ----------
  CALL METHOD gr_parent_container->get_width
    IMPORTING
      width      = l_width
    EXCEPTIONS
      cntl_error = 1
      OTHERS     = 2.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* check if it's necessary to create a new container instance
  IF cr_container IS INITIAL.
*   get next free position for new container
*   ---------- ----------
    IF gs_act_position-column = g_columns.
*     no more columns exists
      IF gs_act_position-row < g_rows.
*       use first column of next row
        gs_act_position-row    = gs_act_position-row + 1.
        gs_act_position-column = 1.
      ELSE.
*       no more rows exists => error
        e_rc = 1.
        EXIT.
      ENDIF.
    ELSE.
*     use next column of same row
      gs_act_position-column = gs_act_position-column + 1.
      IF gs_act_position-row <= 0.
        gs_act_position-row = 1.
      ENDIF.
    ENDIF.     " IF gs_act_position-column = g_columns.
*   ---------- ----------
    ls_pos = gs_act_position.
*   ---------- ----------
*   set default values
    IF ls_pos-column IS INITIAL.
      ls_pos-column = 1.
    ENDIF.
*   ----------
*    IF ls_pos-row IS INITIAL.
*      ls_pos-row = 1.
*    ELSE.
*      ls_pos-row = ls_pos-row + 1.
*    ENDIF.
**   ----------
*    IF ls_pos-row > g_rows.
*      ls_pos-row     =  1.
*      ls_pos-column  =  ls_pos-column + 1.
*      IF ls_pos-column > g_columns.
*        e_rc  =  1.
*        EXIT.
*      ENDIF.
*    ENDIF.
*   ----------
*   get instance of container
    CALL METHOD gr_splitter->get_container
      EXPORTING
        row       = ls_pos-row
        column    = ls_pos-column
      RECEIVING
        container = ls_pos-container.
*   save container and position
    INSERT ls_pos INTO TABLE gt_position.
*   return new instance of container
    cr_container  =  ls_pos-container.
  ELSE.
*   instance of container was given, get position
    READ TABLE gt_position INTO ls_pos
       WITH KEY container = cr_container.
    CHECK sy-subrc = 0.
  ENDIF.
* ---------- ---------- ----------
* F A D E   I N   /   F A D E   O U T
* ---------- ----------
* height of row
  l_row = 1.
  WHILE l_row <= g_rows.
    IF l_row <> ls_pos-row.
*     fade out all rows exclusive current row
*     height = 0, fix and fade out splitter
      CALL METHOD gr_splitter->set_row_height
        EXPORTING
          id                = l_row
          height            = 0
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
*     fix splitter
      CALL METHOD gr_splitter->set_row_sash
        EXPORTING
          id                = l_row
          type              = cl_gui_splitter_container=>type_movable
          value             = cl_gui_splitter_container=>false
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
*     fade out splitter
      CALL METHOD gr_splitter->set_row_sash
        EXPORTING
          id              = l_row
          type            = cl_gui_splitter_container=>type_sashvisible
          value           = cl_gui_splitter_container=>false
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
    ELSE.
*     current row is visible; height = heigt of container (max. height)
      CALL METHOD gr_splitter->set_row_height
        EXPORTING
          id     = l_row
          height = l_height.
    ENDIF.
    l_row = l_row + 1.
  ENDWHILE.
* ---------- ----------
* widht of column
  l_column = 1.
  WHILE l_column <= g_columns.
    IF l_column <> ls_pos-column.
*     fade out all columns exclusive current column
*     height = 0, fix and fade out splitter
      CALL METHOD gr_splitter->set_column_width
        EXPORTING
          id                = l_column
          width             = 0
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
*     fix splitter
      CALL METHOD gr_splitter->set_column_sash
        EXPORTING
          id                = l_column
          type              = cl_gui_splitter_container=>type_movable
          value             = cl_gui_splitter_container=>false
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
*     fade out splitter
      CALL METHOD gr_splitter->set_column_sash
        EXPORTING
          id              = l_column
          type            = cl_gui_splitter_container=>type_sashvisible
          value           = cl_gui_splitter_container=>false
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
    ELSE.
*     current column is visible;
*     width = widht of container (max. width)
      CALL METHOD gr_splitter->set_column_width
        EXPORTING
          id                = l_column
          width             = l_width
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2
          OTHERS            = 3.
      IF sy-subrc <> 0.
        e_rc = sy-subrc.
        EXIT.
      ENDIF.
    ENDIF.
    l_column = l_column + 1.
  ENDWHILE.
* ---------- ---------- ----------

ENDMETHOD.


METHOD constructor.

* definitions
  DATA: l_result         TYPE i.
* ---------- ---------- ----------
* either parent container or name of container are
* mandatory
  IF i_container_name    IS INITIAL AND
     ir_parent_container IS INITIAL.
    RAISE wrong_input.
  ENDIF.
  gr_parent_container = ir_parent_container.
  g_container_name    = i_container_name.
* ---------- ---------- ----------
* compute needed rows and columns
  l_result = sqrt( i_max_needed_container ).
  g_rows    = l_result + 1.
  g_columns = l_result + 1.
* ---------- ---------- ----------

ENDMETHOD.


METHOD create.

* definitions
  DATA: l_rc                    TYPE ish_method_rc.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* create instance
  CREATE OBJECT er_instance
    EXPORTING
      i_max_needed_container = i_max_needed_container
      i_container_name       = i_container_name
      ir_parent_container    = ir_parent_container
    EXCEPTIONS
      instance_not_possible = 1
      wrong_input           = 2
      OTHERS                = 3.
  l_rc = sy-subrc.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
  CASE l_rc.
    WHEN 1.
*     Eine Instanz der Klasse & konnte nicht angelegt werden
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1BASE'
          i_num  = '003'
          i_mv1  = 'CL_ISH_DYN_CONTAINER'
          i_last = ' '.
    WHEN 2.
*     Konstruktor Klasse &: Übergabeparameter waren fehlerhaft
      CALL METHOD cr_errorhandler->collect_messages
        EXPORTING
          i_typ  = 'E'
          i_kla  = 'N1BASE'
          i_num  = '004'
          i_mv1  = 'CL_ISH_DYN_CONTAINER'
          i_last = space.
  ENDCASE.
* ---------- ---------- ----------
* initialize control processing (=container)
  CALL METHOD er_instance->initialize_control_processing
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD destroy.

* ---------- ---------- ----------
* initialize all container instances
  IF NOT gr_splitter IS INITIAL.
    CALL METHOD gr_splitter->free.
    CLEAR gr_splitter.
  ENDIF.
* ----------
  IF NOT gr_parent_container IS INITIAL.
    CALL METHOD gr_parent_container->free.
    CLEAR gr_parent_container.
  ENDIF.
* ---------- ---------- ----------
  CALL METHOD cl_gui_cfw=>update_view.
  CALL METHOD cl_gui_cfw=>flush.
* ---------- ---------- ----------
* initialize global attributes
  CLEAR: g_columns, g_container_name, g_rows, gt_position.
* ---------- ---------- ----------

ENDMETHOD.


method IF_ISH_IDENTIFY_OBJECT~GET_TYPE.
endmethod.


method IF_ISH_IDENTIFY_OBJECT~IS_A.
endmethod.


method IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM.
endmethod.


METHOD initialize_control_processing .

* definitions
  DATA: l_rc                    TYPE ish_method_rc,
        l_result                TYPE i,
        l_container_name        TYPE scrfname.
* object references
  DATA: lr_container            TYPE REF TO cl_gui_custom_container.
* ---------- ---------- ----------
* initialize
  e_rc = 0.
* create instance for errorhandling if necessary
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* if necessary create instance for parent container
  IF gr_parent_container IS INITIAL.
    l_container_name = g_container_name.
    CREATE OBJECT lr_container
      EXPORTING
        container_name              = l_container_name
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc = 0.
      gr_parent_container = lr_container.
    ELSE.
*     Control & konnte nicht angelegt werden (Returncode &)
      MESSAGE x090(nfcl) WITH l_container_name sy-subrc.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* create splitter container
  IF gr_splitter IS INITIAL.
    CREATE OBJECT gr_splitter
      EXPORTING
        parent            = gr_parent_container
        rows              = g_rows
        columns           = g_columns
      EXCEPTIONS
        cntl_error        = 1
        cntl_system_error = 2
        OTHERS            = 3.
    IF sy-subrc <> 0.
*     Control & konnte nicht angelegt werden (Returncode &)
      MESSAGE x090(nfcl) WITH 'GR_SPLITTER' sy-subrc.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.
ENDCLASS.
