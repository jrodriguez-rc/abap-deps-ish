class CL_ISH_WORKPOOL definition
  public
  abstract
  create public .

public section.
*"* public components of class CL_ISH_WORKPOOL
*"* do not include other source files here!!!
  type-pools ICON .
  class CL_GUI_RESOURCES definition load .

  interfaces IF_ISH_CONSTANT_DEFINITION .
  interfaces IF_ISH_IDENTIFY_OBJECT .
  interfaces IF_ISH_LIST_DISPLAY .

  aliases ACTIVE
    for IF_ISH_CONSTANT_DEFINITION~ACTIVE .
  aliases CO_MODE_DELETE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_CONSTANT_DEFINITION~CO_MODE_UPDATE .
  aliases CO_SEL_DSPCLS
    for IF_ISH_LIST_DISPLAY~CO_SEL_DSPCLS .
  aliases CO_SEL_DSPOBJ
    for IF_ISH_LIST_DISPLAY~CO_SEL_DSPOBJ .
  aliases CO_SEL_IMPOBJ
    for IF_ISH_LIST_DISPLAY~CO_SEL_IMPOBJ .
  aliases CO_SEL_OBJECT
    for IF_ISH_LIST_DISPLAY~CO_SEL_OBJECT .
  aliases CO_SEL_SRVOBJ
    for IF_ISH_LIST_DISPLAY~CO_SEL_SRVOBJ .
  aliases CO_SORT_DATE
    for IF_ISH_LIST_DISPLAY~CO_SORT_DATE .
  aliases CO_SORT_INDIVIDUAL
    for IF_ISH_LIST_DISPLAY~CO_SORT_INDIVIDUAL .
  aliases CO_SORT_OPOU
    for IF_ISH_LIST_DISPLAY~CO_SORT_OPOU .
  aliases CO_SORT_OP_STD
    for IF_ISH_LIST_DISPLAY~CO_SORT_OP_STD .
  aliases CO_SORT_REQUESTER
    for IF_ISH_LIST_DISPLAY~CO_SORT_REQUESTER .
  aliases CV_AUSTRIA
    for IF_ISH_CONSTANT_DEFINITION~CV_AUSTRIA .
  aliases CV_CANADA
    for IF_ISH_CONSTANT_DEFINITION~CV_CANADA .
  aliases CV_FRANCE
    for IF_ISH_CONSTANT_DEFINITION~CV_FRANCE .
  aliases CV_GERMANY
    for IF_ISH_CONSTANT_DEFINITION~CV_GERMANY .
  aliases CV_ITALY
    for IF_ISH_CONSTANT_DEFINITION~CV_ITALY .
  aliases CV_NETHERLANDS
    for IF_ISH_CONSTANT_DEFINITION~CV_NETHERLANDS .
  aliases CV_SINGAPORE
    for IF_ISH_CONSTANT_DEFINITION~CV_SINGAPORE .
  aliases CV_SPAIN
    for IF_ISH_CONSTANT_DEFINITION~CV_SPAIN .
  aliases CV_SWITZERLAND
    for IF_ISH_CONSTANT_DEFINITION~CV_SWITZERLAND .
  aliases FALSE
    for IF_ISH_CONSTANT_DEFINITION~FALSE .
  aliases INACTIVE
    for IF_ISH_CONSTANT_DEFINITION~INACTIVE .
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
  aliases CHECK_IF_EMPTY
    for IF_ISH_LIST_DISPLAY~CHECK_IF_EMPTY .
  aliases DESTROY
    for IF_ISH_LIST_DISPLAY~DESTROY .
  aliases DISPLAY
    for IF_ISH_LIST_DISPLAY~DISPLAY .
  aliases GET_DATA
    for IF_ISH_LIST_DISPLAY~GET_DATA .
  aliases GET_SELECTION
    for IF_ISH_LIST_DISPLAY~GET_SELECTION .
  aliases GET_TOOLBAR
    for IF_ISH_LIST_DISPLAY~GET_TOOLBAR .
  aliases GET_TYPE
    for IF_ISH_IDENTIFY_OBJECT~GET_TYPE .
  aliases INITIALIZE
    for IF_ISH_LIST_DISPLAY~INITIALIZE .
  aliases INSERT_DATA
    for IF_ISH_LIST_DISPLAY~INSERT_DATA .
  aliases REFRESH
    for IF_ISH_LIST_DISPLAY~REFRESH .
  aliases REFRESH_DATA
    for IF_ISH_LIST_DISPLAY~REFRESH_DATA .
  aliases REMOVE_DATA
    for IF_ISH_LIST_DISPLAY~REMOVE_DATA .
  aliases SET_LAYOUT
    for IF_ISH_LIST_DISPLAY~SET_LAYOUT .
  aliases SET_SCROLL_POSITION
    for IF_ISH_LIST_DISPLAY~SET_SCROLL_POSITION .
  aliases SET_SELECTION
    for IF_ISH_LIST_DISPLAY~SET_SELECTION .
  aliases SET_SORT_CRITERIA
    for IF_ISH_LIST_DISPLAY~SET_SORT_CRITERIA .
  aliases AFTER_USER_COMMAND
    for IF_ISH_LIST_DISPLAY~AFTER_USER_COMMAND .
  aliases BEFORE_USER_COMMAND
    for IF_ISH_LIST_DISPLAY~BEFORE_USER_COMMAND .
  aliases CONTEXT_MENU
    for IF_ISH_LIST_DISPLAY~CONTEXT_MENU .
  aliases DOUBLE_CLICK
    for IF_ISH_LIST_DISPLAY~DOUBLE_CLICK .
  aliases HOTSPOT_CLICK
    for IF_ISH_LIST_DISPLAY~HOTSPOT_CLICK .
  aliases IS_EMPTY
    for IF_ISH_LIST_DISPLAY~IS_EMPTY .
  aliases ONDRAG
    for IF_ISH_LIST_DISPLAY~ONDRAG .
  aliases ONDROP
    for IF_ISH_LIST_DISPLAY~ONDROP .
  aliases USER_COMMAND
    for IF_ISH_LIST_DISPLAY~USER_COMMAND .

  constants CO_OTYPE_WORKPOOL type ISH_OBJECT_TYPE value 12012. "#EC NOTEXT
  data GT_NODES_OPEN type ISHMED_T_DISPLAY_FIELDS .
  data G_DEFAULT_FCODE type SY-TCODE .
  data G_DRAGDROP type ref to CL_DRAGDROP .
  class-data G_DRAG_LINE type I .

  methods SET_NOSAVE
    importing
      value(I_NOSAVE) type ISH_ON_OFF .
  methods GET_FRONTEND_LAYOUT
    exporting
      value(E_LAYOUT) type LVC_S_LAYO
      value(ET_FIELDCAT) type LVC_T_FCAT
      value(ET_SORT) type LVC_T_SORT
      value(ET_FILTER) type LVC_T_FILT .
  methods GET_OBJECT_FOR_IDENT
    importing
      value(I_OBJECT) type ref to OBJECT
    exporting
      value(ET_SEL_OBJECT) type ISH_T_SEL_OBJECT
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_OBJECT_FOR_IMPOBJ
    importing
      value(I_IMPOBJ) type ref to OBJECT
    exporting
      value(ET_SEL_OBJECT) type ISH_T_SEL_OBJECT
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_WP_ISH_OBJECT
    importing
      value(I_SEL_ATTRIBUTE) type ISH_SEL_OBJECT-ATTRIBUTE default '*'
      value(I_SET_EXTERN_VALUES) type ISH_ON_OFF default SPACE
      value(I_INSTITUTION) type EINRI
      value(I_VIEW_ID) type NWVIEW-VIEWID
      value(I_VIEW_TYPE) type NWVIEW-VIEWTYPE
      value(IT_OBJECT) type ISH_T_SEL_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
      value(ET_ISH_OBJECT) type ISH_T_DRAG_DROP_DATA
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_NDIA
    importing
      !IT_NDIA type ISH_T_NDIA .
  methods NODE_OPENCLOSE_ALL
    importing
      value(I_NODE_ATTRIBUTE) type ISH_ON_OFF default '*'
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_PLANNING_OU
    importing
      value(I_PLANOE) type NTMN-TMNOE .
  methods SET_VIEW_DATA
    importing
      value(I_VIEWID) type NWVIEW-VIEWID
      value(I_PLACEID) type NWPLACE-WPLACEID .
  methods SET_WORK_FLAG
    importing
      value(I_IMPOBJ) type ref to OBJECT optional
      value(I_OBJECT) type ref to OBJECT
      value(I_WORK_FLAG) type ISH_ON_OFF default 'X'
      value(I_APP) type ref to CL_ISH_APPOINTMENT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_FUNCTION_CODE
    importing
      value(I_UCOMM) type SY-UCOMM .
protected section.
*"* protected components of class CL_ISH_WORKPOOL
*"* do not include other source files here!!!

  aliases GT_FIELDCAT
    for IF_ISH_LIST_DISPLAY~GT_FIELDCAT .
  aliases GT_FILTER
    for IF_ISH_LIST_DISPLAY~GT_FILTER .
  aliases GT_SEL_CRIT
    for IF_ISH_LIST_DISPLAY~GT_SEL_CRIT .
  aliases GT_SORT
    for IF_ISH_LIST_DISPLAY~GT_SORT .
  aliases G_CONSTRUCT
    for IF_ISH_LIST_DISPLAY~G_CONSTRUCT .
  aliases G_CONTAINER
    for IF_ISH_LIST_DISPLAY~G_CONTAINER .
  aliases G_LAYOUT
    for IF_ISH_LIST_DISPLAY~G_LAYOUT .
  aliases G_TOOLBAR
    for IF_ISH_LIST_DISPLAY~G_TOOLBAR .
  aliases BUILD_FIELDCAT
    for IF_ISH_LIST_DISPLAY~BUILD_FIELDCAT .

  types:
    begin of TY_IMP_OBJECT,
           impobj type ref to object,
           dspobj      type ref to object,
         end   of ty_imp_object .
  types:
    TYt_IMP_OBJECT type standard table of ty_imp_object .

  data G_NOSAVE type ISH_ON_OFF .
  constants CO_VIEWTYPE_OP type NWVIEW-VIEWTYPE value '011'. "#EC NOTEXT
  data GT_ALL_OBJECT type TYT_IMP_OBJECT .
  data GT_EXCEPT_QINFO type LVC_T_QINF .
  data GT_SORT_OBJECT type ISHMED_T_SORT_OBJECT .
  data GT_NDIA type ISH_T_NDIA .
  data GT_WPOOL_WORK type ISHMED_T_WPOOL_WORK .
  data G_DUMMY_CONTAINER type ref to CL_GUI_CUSTOM_CONTAINER .
  data G_ENVIRONMENT type ref to CL_ISH_ENVIRONMENT .
  data G_GRID type ref to CL_GUI_ALV_GRID .
  data G_INSTITUTION type TN01-EINRI .
  data G_NODES_OPEN type ISH_ON_OFF .
  data G_NODES_OPEN_OLD type ISH_ON_OFF .
  data G_PLANOE type NTMN-TMNOE .
  data G_SORT type N1SORTNO .
  data G_TREE type ref to CL_GUI_ALV_TREE .
  data G_VIEW_ID type NWVIEW-VIEWID .
  data G_VIEW_TYPE type NWVIEW-VIEWTYPE .
  data G_WPLACE_ID type NWPLACE-WPLACEID .

  methods ADD_DATA_TO_DRAG_DROP_CONT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional
      value(C_DRAGDROPOBJ) type ref to CL_ISH_DISPLAY_DRAG_DROP_CONT optional .
  methods BUILD_DRAGDROP_BEHAVIOUR
    importing
      value(I_FLAVOR) type C
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_DSPOBJ
    importing
      value(I_IMPOBJ) type N1OBJECTREF optional
      value(I_NODE_OPEN) type ISH_ON_OFF default 'X'
      value(I_DSPOBJ_TYPE) type I
    exporting
      value(E_DSPOBJ) type N1OBJECTREF
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_LAYOUT
    changing
      value(C_LAYOUT) type LVC_S_LAYO optional .
  methods BUILD_OUTTAB
    importing
      value(I_OPEN_NODE) type ISH_ON_OFF default SPACE
      value(I_CLOSE_NODE) type ISH_ON_OFF default SPACE
      value(I_NODE_OPEN) type ISH_ON_OFF default SPACE
      value(I_PAT_ANONYM) type ISH_ON_OFF default SPACE
      value(IT_OBJECT) type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(CT_OUTTAB) type ISHMED_T_DISPLAY_FIELDS
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_OUTTAB_LINE_DSPOBJ
    importing
      value(I_DSPOBJ) type N1OBJECTREF
      value(I_IMPOBJ) type N1OBJECTREF optional
    exporting
      value(ET_OUTTAB) type ISHMED_T_DISPLAY_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_OUTTAB_LINE_OPERATION
    importing
      value(I_DSPOBJ) type N1OBJECTREF
    exporting
      value(ET_OUTTAB) type ISHMED_T_DISPLAY_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_WORKTAB
    importing
      value(I_DSPOBJ) type ref to OBJECT
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CALL_BADI_VIEW_TITLE
    importing
      value(IT_OUTTAB) type ANY
    exporting
      value(E_TITLE) type LVC_S_LAYO-GRID_TITLE .
  methods CHECK_DD_OUTTAB_LINE
    importing
      value(I_OUTTAB) type RN1DISPLAY_FIELDS optional
      value(E_DRAGABLE) type ISH_ON_OFF optional
      value(E_DROPABLE) type ISH_ON_OFF optional .
  methods CHECK_DISPLAY_OBJECT
    importing
      value(I_IMPOBJ) type N1OBJECTREF optional
    exporting
      value(E_DSPOBJ_TYPE) type I .
  methods CHECK_IF_DISPLAY
    importing
      value(I_DSPOBJ) type ref to OBJECT
    exporting
      value(E_DISPLAY) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods EXCL_TOOLBAR
    exporting
      !ET_TOOLBAR_EXCL type UI_FUNCTIONS .
  methods GET_ROWID_FOR_OBJECT
    importing
      value(IT_OBJECT) type ISH_OBJECTLIST optional
    exporting
      value(ET_INDEX_ROWS) type LVC_T_ROW
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods HANDLE_GRID_AFTER_USER_COMMAND
    for event AFTER_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !E_NOT_PROCESSED .
  methods HANDLE_GRID_BEFORE_USER_COMM
    for event BEFORE_USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM
      !SENDER .
  methods HANDLE_GRID_CONTEXT_MENU
    for event CONTEXT_MENU_REQUEST of CL_GUI_ALV_GRID
    importing
      !E_OBJECT .
  methods HANDLE_GRID_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO .
  methods HANDLE_GRID_HOTSPOT_CLICK
    for event HOTSPOT_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW_ID
      !E_COLUMN_ID
      !ES_ROW_NO .
  methods HANDLE_GRID_MENU_BUTTON
    for event MENU_BUTTON of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_UCOMM .
  methods HANDLE_GRID_ONDRAG
    for event ONDRAG of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !E_DRAGDROPOBJ .
  methods HANDLE_GRID_ONDROP
    for event ONDROP of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO
      !E_DRAGDROPOBJ .
  methods HANDLE_GRID_TOOLBAR
    for event TOOLBAR of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_INTERACTIVE .
  methods HANDLE_GRID_USER_COMMAND
    for event USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  methods NODE_OPENCLOSE
    importing
      value(I_NODE_ATTRIBUTE) type ISH_ON_OFF default '*'
      value(I_OUTTAB) type RN1DISPLAY_FIELDS
      value(I_FIELDNAME) type LVC_FNAME
      value(IT_FIELDCAT) type LVC_T_FCAT
    exporting
      value(ET_OUTTAB) type ISHMED_T_DISPLAY_FIELDS
      value(E_REFRESH) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods READ_OUTTAB_LINE
    importing
      value(I_INDEX) type LVC_INDEX optional
      value(IT_INDEX_ROWS) type LVC_T_ROW optional
    exporting
      value(E_OUTTAB_LINE) type RN1DISPLAY_FIELDS
      value(ET_OUTTAB_LINES) type ISHMED_T_DISPLAY_FIELDS
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REFRESH_DISPLAY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REGISTER_EVENTS .
  methods SET_COLOR_OUTTAB_LINE
    importing
      value(I_OUTTAB) type RN1DISPLAY_FIELDS
    exporting
      value(E_LINECOLOR) type LVC_EMPHSZ
    changing
      value(CT_CELLCOLOR) type LVC_T_SCOL .
  methods SET_DRAGDROP_OUTTAB_LINE
    importing
      value(I_OUTTAB) type RN1DISPLAY_FIELDS
    exporting
      value(E_DRAGABLE) type ISH_ON_OFF
      value(E_DROPABLE) type ISH_ON_OFF
      value(ET_DRAGDROP) type LVC_T_DRDR .
  methods SET_PROPERTIES_DSPOBJ
    importing
      value(I_DSPOBJ) type N1OBJECTREF
      value(I_IMPOBJ) type N1OBJECTREF optional
      value(I_OPEN_NODE) type ISH_ON_OFF optional
      value(I_CLOSE_NODE) type ISH_ON_OFF optional
      value(I_PAT_ANONYM) type ISH_ON_OFF optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_PROPERTIES_OPERATION
    importing
      value(I_DSPOBJ) type ref to OBJECT
      value(I_OPEN_NODE) type ISH_ON_OFF optional
      value(I_CLOSE_NODE) type ISH_ON_OFF optional
      value(I_PAT_ANONYM) type ISH_ON_OFF optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_SEL_CRITERIA
    importing
      !IT_SEL_CRITERIA type ISHMED_T_RSPARAMS optional
      value(I_REFRESH) type ISH_ON_OFF default SPACE .
  methods SORT
    importing
      value(I_SORT) type N1SORTNO optional
      value(IT_SORT_OBJECT) type ISHMED_T_SORT_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional
      value(CT_OUTTAB) type STANDARD TABLE .
private section.
*"* private components of class CL_ISH_WORKPOOL
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_WORKPOOL IMPLEMENTATION.


METHOD add_data_to_drag_drop_cont .                         "#EC NEEDED

ENDMETHOD.


METHOD build_dragdrop_behaviour.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Drag & Drop instanzieren
  CREATE OBJECT g_dragdrop.
* ---------- ---------- ----------
* Verhalten für Drag&Drop festlegen
  CALL METHOD g_dragdrop->add
    EXPORTING
      flavor          = i_flavor
      dragsrc         = 'X'
      droptarget      = 'X'
      effect          = cl_dragdrop=>move
    EXCEPTIONS
      already_defined = 1
      obj_invalid     = 2
      OTHERS          = 3.
  IF sy-subrc <> 0.
    e_rc = sy-subrc.
*   Fehler & beim Aufruf der Methode & der Klasse &
    CALL METHOD c_errorhandler->collect_messages
      EXPORTING
        i_typ  = 'E'
        i_kla  = 'NFCL'
        i_num  = '091'
        i_mv1  = e_rc
        i_mv2  = 'ADD'
        i_mv3  = 'CL_DRAGDROP'
        i_last = space.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD build_dspobj.

* Hilfsfelder und -strukturen
  DATA: l_rc                TYPE ish_method_rc,
        l_cancelled         TYPE ish_on_off.
  DATA: lr_dspobj_op        TYPE REF TO cl_ishmed_dspobj_operation.
  DATA: lr_service          TYPE REF TO cl_ishmed_service.
  DATA: ls_nbew             TYPE nbew.
  DATA: ls_ndia             LIKE LINE OF gt_ndia.
  DATA: lt_ndia             TYPE ish_t_ndia.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
  IF i_impobj IS INITIAL.
    e_rc = 0.                                              " no error!
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  CASE i_dspobj_type.
*   ---------- ----------
*   Anzeigeobjekt "Operation"
    WHEN cl_ishmed_dspobj_operation=>co_otype_dspobj_operation.
      CALL METHOD cl_ishmed_dspobj_operation=>load
        EXPORTING
          i_object       = i_impobj
          i_node_open    = i_node_open
        IMPORTING
          e_instance     = e_dspobj
          e_cancelled    = l_cancelled
          e_rc           = l_rc
        CHANGING
          c_environment  = g_environment
          c_errorhandler = c_errorhandler.
      CASE l_rc.
        WHEN 0.
*         Sta/PN/MED-40483
          lr_dspobj_op ?= e_dspobj.
          lr_dspobj_op->set_nosave( g_nosave ).
          CALL METHOD lr_dspobj_op->get_anchor_service
            RECEIVING
              rr_service = lr_service.
          IF lr_service IS BOUND.
            CALL METHOD cl_ishmed_service=>get_movement_for_service
              EXPORTING
                i_service      = lr_service
              IMPORTING
                e_nbew         = ls_nbew
                e_rc           = e_rc
              CHANGING
                c_errorhandler = c_errorhandler.
            IF e_rc <> 0.
              RETURN.
            ENDIF.
            IF ls_nbew IS NOT INITIAL.
              LOOP AT gt_ndia INTO ls_ndia
                  WHERE  einri  = ls_nbew-einri
                    AND falnr   = ls_nbew-falnr
                    AND lfdbew  = ls_nbew-lfdnr.
                APPEND ls_ndia TO lt_ndia.
              ENDLOOP.
              CALL METHOD lr_dspobj_op->set_ndia
                EXPORTING
                  it_ndia = lt_ndia.
            ENDIF.
          ENDIF.
*         End/PN/MED-40483
*         OK -> Anzeigeobjekt 'Operation' wurde instanziert
*         Stornierte Operationen werden dzt. nicht unterstützt.
          IF l_cancelled = on.
            CLEAR: e_dspobj.
          ENDIF.
          EXIT.
        WHEN 99.
*         Keine Operation; keinen Returncode an den Aufrufer liefern.
          EXIT.
        WHEN OTHERS.
          e_rc = l_rc.
          EXIT.
      ENDCASE.
*   ---------- ----------
  ENDCASE.
* ---------- ---------- ----------

ENDMETHOD.


METHOD build_layout.

  c_layout-no_toolbar = ' '.           " no toolbar
  c_layout-cwidth_opt = ' '.           " optimize the column width

* declare field LINECOLOR for line coloring
  c_layout-info_fname = 'LINECOLOR'.

* declare table CELLCOLOR for cell coloring
  c_layout-ctab_fname = 'CELLCOLOR'.

* declare table DRAGDROP for drag&drop behaviour for
* special rows/cells
  c_layout-s_dragdrop-fieldname = 'DRAGDROP'.

* title
  c_layout-grid_title = 'Arbeitsvorrat'(001).
  c_layout-smalltitle = ' '.           " small title

ENDMETHOD.


METHOD build_outtab .

* Lokale Tabelle
  DATA: lt_outtab                    TYPE ishmed_t_display_fields,
        lt_imp_object                TYPE tyt_imp_object.
* Workareas
  DATA: l_object                     LIKE LINE OF it_object,
        l_imp_object                 LIKE LINE OF lt_imp_object,
        l_all_object                 LIKE LINE OF gt_all_object.
* Hilfsfelder und -strukturen
  DATA: l_dspobj_type                TYPE i,                "#EC NEEDED
        l_rc                         TYPE ish_method_rc,
        l_subrc                      TYPE sy-subrc,         "#EC NEEDED
        l_display                    TYPE ish_on_off.
* Objekt-Instanzen
  DATA: l_dspobj                     TYPE REF TO object.

  DATA: lt_outtab_tmp                TYPE ishmed_t_display_fields,
        ls_outtab                    LIKE LINE OF lt_outtab,
        ls_nodes_open                LIKE LINE OF gt_nodes_open,
        l_openclose                  TYPE ish_on_off,
        l_dspobj_operation           TYPE REF TO cl_ishmed_dspobj_operation,
        l_object_type                TYPE i.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* OO-Daten
  LOOP AT it_object INTO l_object.
    READ TABLE gt_all_object INTO l_imp_object
       WITH KEY impobj = l_object-object.
    IF sy-subrc <> 0.
      CLEAR: l_imp_object.
      l_imp_object-impobj = l_object-object.
    ENDIF.
    INSERT l_imp_object INTO TABLE lt_imp_object.
  ENDLOOP.
* ---------- ---------- ----------
* Falls keine zu aktualisierenden Daten übergeben wurden werden
* alle Daten aktualisiert.
  IF it_object[]   IS INITIAL.
    lt_imp_object = gt_all_object.
    CLEAR: ct_outtab[].
  ENDIF.
* ---------- ---------- ----------
  SORT lt_imp_object.
  DELETE ADJACENT DUPLICATES FROM lt_imp_object
     COMPARING ALL FIELDS.
* ---------- ---------- ----------
  LOOP AT lt_imp_object INTO l_imp_object.
*   ----------
*   Bestehende Einträge der Ausgabetabelle entfernen.
    DELETE ct_outtab WHERE impobj = l_imp_object-impobj.
*   ----------
    l_dspobj = l_imp_object-dspobj.
*   ----------
    IF l_dspobj IS INITIAL.
*     Entscheiden welches Anzeigeobjekt zu verwenden ist.
      CALL METHOD me->check_display_object
        EXPORTING
          i_impobj      = l_imp_object-impobj
        IMPORTING
          e_dspobj_type = l_dspobj_type.
      CALL METHOD me->build_dspobj
        EXPORTING
          i_impobj       = l_imp_object-impobj
          i_dspobj_type  = l_dspobj_type
          i_node_open    = i_node_open
        IMPORTING
          e_dspobj       = l_dspobj
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
*        e_rc = l_rc.                           " no error!
        CONTINUE.
      ENDIF.
    ENDIF.
*   ----------
*   Ohne Anzeigeobjekt mit nächstem Eintrag fortfahren.
    IF l_dspobj IS INITIAL.
      CONTINUE.
    ENDIF.
*   ----------
*   Anzeigeobjekt in die Tabelle mit sämtlichen globalen Objekten
*   aufnehmen.
    READ TABLE gt_all_object INTO l_all_object
       WITH KEY impobj      = l_imp_object-impobj.
    IF sy-subrc = 0.
      l_all_object-dspobj = l_dspobj.
      MODIFY gt_all_object FROM l_all_object INDEX sy-tabix.
    ENDIF.
*   ----------
*   Eigenschaften der Anzeigeobjekte setzen
    CALL METHOD me->set_properties_dspobj
      EXPORTING
        i_dspobj       = l_dspobj
        i_impobj       = l_imp_object-impobj
        i_open_node    = i_open_node
        i_close_node   = i_close_node
        i_pat_anonym   = i_pat_anonym
      IMPORTING
        e_rc           = l_rc
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
      CONTINUE.
    ENDIF.
*   ----------
    CALL METHOD me->build_outtab_line_dspobj
      EXPORTING
        i_dspobj       = l_dspobj
        i_impobj       = l_imp_object-impobj
      IMPORTING
        et_outtab      = lt_outtab
        e_rc           = l_rc
      CHANGING
        c_errorhandler = c_errorhandler.
*   ----------
    IF l_rc = 0.
*     ----------
*     Prüfen ob das Anzeigeobjekt in der Liste erscheinen soll
      CALL METHOD me->check_if_display
        EXPORTING
          i_dspobj       = l_dspobj
        IMPORTING
          e_display      = l_display
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc = 0.
        IF l_display = off.
          CONTINUE.
        ENDIF.
      ELSE.
        e_rc = l_rc.
        EXIT.
      ENDIF.
*     ----------
*     MED-30311: get saved status of node
      READ TABLE lt_outtab INTO ls_outtab INDEX 1.
      IF sy-subrc = 0.
        IF i_close_node IS INITIAL AND i_open_node IS INITIAL.
          READ TABLE gt_nodes_open INTO ls_nodes_open WITH KEY keyno = ls_outtab-keyno.
          IF sy-subrc = 0.
            CLEAR: lt_outtab_tmp[].
            CALL METHOD l_dspobj->('GET_TYPE')
              IMPORTING
                e_object_type = l_object_type.
            IF l_object_type = cl_ishmed_dspobj_operation=>co_otype_dspobj_operation.
              l_dspobj_operation ?= l_dspobj.
              IF ls_nodes_open-openclose <> l_dspobj_operation->g_node_open.
                IF ls_nodes_open-openclose = 'X'.
                  CALL METHOD l_dspobj_operation->if_ish_display_object~open_node
                    EXPORTING
                      it_fieldcat = gt_fieldcat
                    IMPORTING
                      et_outtab   = lt_outtab_tmp
                      e_rc        = l_rc.
                ELSE.
                  CALL METHOD l_dspobj_operation->if_ish_display_object~close_node
                    EXPORTING
                      it_fieldcat = gt_fieldcat
                    IMPORTING
                      et_outtab   = lt_outtab_tmp
                      e_rc        = l_rc.
                ENDIF.
              ENDIF.
              IF l_rc = 0 AND lt_outtab_tmp[] IS NOT INITIAL.
                CLEAR: lt_outtab[].
                lt_outtab[] = lt_outtab_tmp[].
              ENDIF.
            ENDIF.
          ENDIF.
        ELSE.
          CLEAR: lt_outtab_tmp[].
          CALL METHOD l_dspobj->('GET_TYPE')
            IMPORTING
              e_object_type = l_object_type.
          IF l_object_type = cl_ishmed_dspobj_operation=>co_otype_dspobj_operation.
            l_dspobj_operation ?= l_dspobj.
            IF i_open_node = 'X' AND l_dspobj_operation->g_node_open = ' '.
              CALL METHOD l_dspobj_operation->if_ish_display_object~open_node
                EXPORTING
                  it_fieldcat = gt_fieldcat
                IMPORTING
                  et_outtab   = lt_outtab_tmp
                  e_rc        = l_rc.
            ELSEIF i_close_node = 'X' AND l_dspobj_operation->g_node_open = 'X'.
              CALL METHOD l_dspobj_operation->if_ish_display_object~close_node
                EXPORTING
                  it_fieldcat = gt_fieldcat
                IMPORTING
                  et_outtab   = lt_outtab_tmp
                  e_rc        = l_rc.
            ENDIF.
            IF l_rc = 0 AND lt_outtab_tmp[] IS NOT INITIAL.
              CLEAR: lt_outtab[].
              lt_outtab[] = lt_outtab_tmp[].
            ENDIF.
*           remember state of node
            IF i_open_node = 'X'.
              l_openclose = 'X'.
            ELSE.
              l_openclose = ' '.
            ENDIF.
            READ TABLE gt_nodes_open INTO ls_nodes_open WITH KEY keyno = ls_outtab-keyno.
            IF sy-subrc = 0.
              ls_nodes_open-openclose = l_openclose.
              MODIFY gt_nodes_open FROM ls_nodes_open INDEX sy-tabix.
            ELSE.
              CLEAR ls_nodes_open.
              ls_nodes_open-keyno     = ls_outtab-keyno.
              ls_nodes_open-openclose = l_openclose.
              APPEND ls_nodes_open TO gt_nodes_open.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
*     ----------
      APPEND LINES OF lt_outtab TO ct_outtab.
    ELSE.
      e_rc = l_rc.
      EXIT.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------
* START MED-40483 2010/07/20
  CALL METHOD cl_ish_display_tools=>finalize_outtab
    EXPORTING
      it_fieldcat           = gt_fieldcat
      i_no_save             = g_nosave
      i_cancelled_data      = abap_false
      ir_environment        = g_environment
      it_selection_criteria = gt_sel_crit
    IMPORTING
      e_rc                  = l_rc
    CHANGING
      ct_outtab             = ct_outtab
      cr_errorhandler       = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
* END MED-40483
* ---------- ---------- ----------
ENDMETHOD.


METHOD build_outtab_line_dspobj .

* Lokale Tabellen
  DATA:  lt_outtab              TYPE ishmed_t_display_fields.
* Workareas
  DATA:  l_outtab               LIKE LINE OF lt_outtab.
* Hilfsfelder und -strukturen
  DATA:  l_rc                   TYPE ish_method_rc,
         l_obj_type             TYPE i.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_outtab[].
* ---------- ---------- ----------
* Typ des Anzeigeobjektes ermitteln
  CALL METHOD i_dspobj->('GET_TYPE')
    IMPORTING
      e_object_type = l_obj_type.
  CASE l_obj_type.
*   Anzeigeobjekt OPERATION
    WHEN cl_ishmed_dspobj_operation=>co_otype_dspobj_operation.
      CALL METHOD me->build_outtab_line_operation
        EXPORTING
          i_dspobj       = i_dspobj
        IMPORTING
          et_outtab      = lt_outtab
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
  ENDCASE.
* ---------- ---------- ----------
* Daten des Anzeigeobjektes müssen in die glob.
* Bearbeitungstabelle aufgenommen werden.
  CALL METHOD me->build_worktab
    EXPORTING
      i_dspobj       = i_dspobj
    IMPORTING
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.
* ---------- ---------- ----------
  LOOP AT lt_outtab INTO l_outtab.
    l_outtab-dspobj = i_dspobj.
    l_outtab-impobj = i_impobj.
    MODIFY lt_outtab FROM l_outtab.
  ENDLOOP.
  et_outtab = lt_outtab.
* ---------- ---------- ----------

ENDMETHOD.


METHOD build_outtab_line_operation .

* Lokale Tabellen
  DATA:  lt_outtab              TYPE ishmed_t_display_fields.
* Hilfsfelder und -strukturen
  DATA:  l_dspobj_operation     TYPE REF TO cl_ishmed_dspobj_operation.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_outtab[].
* ---------- ---------- ----------
  l_dspobj_operation ?= i_dspobj.
  IF l_dspobj_operation IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Ausgabetabelle des Anzeigeobjekts befüllen
  CALL METHOD l_dspobj_operation->convert_for_display
    EXPORTING
      it_fieldcat           = gt_fieldcat
      it_selection_criteria = gt_sel_crit
    IMPORTING
      et_outtab             = lt_outtab
      e_rc                  = e_rc
    CHANGING
      c_errorhandler        = c_errorhandler.
  CHECK e_rc = 0.
* ---------- ---------- ----------
  et_outtab = lt_outtab.
* ---------- ---------- ----------

ENDMETHOD.


METHOD build_worktab.

* Lokale Tabellen
  DATA: lt_object                  TYPE ish_objectlist.
* Workareas
  DATA: l_object                   TYPE ish_object,
        l_wpool_work               like line of gt_wpool_work.
* Hilfsfelder und -strukturen
  DATA: l_rc                       TYPE ish_method_rc,     "#EC NEEDED
        l_obj_type                 TYPE i.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Objekte aus dem Anzeigeobjekt ermitteln.
  CALL METHOD i_dspobj->('GET_DATA')
    IMPORTING
      et_object   = lt_object.
* ---------- ---------- ----------
  CALL METHOD i_dspobj->('GET_TYPE')
    IMPORTING
      e_object_type = l_obj_type.
  CASE l_obj_type.
*   Anzeigeobjekt Operation
*   ... Leistungen berücksichtigen (keine Ankerleistung!?)
    WHEN cl_ishmed_dspobj_operation=>co_otype_dspobj_operation.
      LOOP AT lt_object INTO l_object.
        CALL METHOD l_object-object->('GET_TYPE')
          IMPORTING
            e_object_type = l_obj_type.
        IF l_obj_type = cl_ishmed_service=>co_otype_anchor_srv.
          READ TABLE gt_wpool_work TRANSPORTING NO FIELDS
             WITH KEY dspobj = i_dspobj
                      object = l_object-object.
          IF sy-subrc <> 0.
            l_wpool_work-dspobj = i_dspobj.
            l_wpool_work-object = l_object-object.
            INSERT l_wpool_work INTO TABLE gt_wpool_work.
          ENDIF.
        ENDIF.
      ENDLOOP.
  ENDCASE.
* ---------- ---------- ----------

ENDMETHOD.


METHOD call_badi_view_title .

  CHECK NOT g_view_type IS INITIAL.

* change view title (user-defined with a BADI)
  CALL FUNCTION 'ISH_BADI_WP_VIEW_TITLE'
    EXPORTING
      i_view_type    = g_view_type
      it_sel_crit    = gt_sel_crit
      it_view_list_1 = it_outtab
    CHANGING
      i_title        = e_title.

ENDMETHOD.


method CHECK_DD_OUTTAB_LINE .  "#EC NEEDED

endmethod.


METHOD check_display_object.

* Derzeit können nur Anzeigeobjekte OPERATION vorkommen.
  e_dspobj_type = cl_ishmed_dspobj_operation=>co_otype_dspobj_operation.

ENDMETHOD.


METHOD check_if_display.

* Workareas
  DATA: l_wpool_work            LIKE LINE OF gt_wpool_work.
* Hilfsfelder und -strukturen
  DATA: l_cancelled             TYPE ish_on_off.
* Objekt-Instanzen
  DATA: l_app_obj               TYPE REF TO cl_ish_appointment.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  e_display = off.
* ---------- ---------- ----------
* Prüfung der übergeb. Daten
  IF i_dspobj IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Falls keine Einträge vorhanden sind wird der Eintrag default-
* mäßig angezeigt.
  IF gt_wpool_work[] IS INITIAL.
    e_display = on.
  ENDIF.
* ---------- ---------- ----------
* Falls bei min. einem der Objekte zu dem Anzeigeobjekt
* das Bearbeitungs-Kennzeichen noch nicht gesetzt ist wird
* das Anzeigeobjekt in die Liste aufgenommen.
  READ TABLE gt_wpool_work TRANSPORTING NO FIELDS
     WITH KEY dspobj    = i_dspobj
              work_flag = off.
  IF sy-subrc = 0.
    e_display = on.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  LOOP AT gt_wpool_work INTO l_wpool_work
     WHERE dspobj = i_dspobj.
    LOOP AT l_wpool_work-appmnts INTO l_app_obj.
*     Prüfen ob der Termin storniert ist.
      CALL METHOD l_app_obj->is_cancelled
        IMPORTING
          e_cancelled = l_cancelled.
      IF l_cancelled = on.
        DELETE l_wpool_work-appmnts. " FROM l_app_obj.
      ENDIF.
    ENDLOOP.
*   Prüfen ob min. 1 gültiger Termin vorhanden ist
    IF l_wpool_work-appmnts[] IS INITIAL.
      l_wpool_work-work_flag = off.
      MODIFY gt_wpool_work FROM l_wpool_work.
      e_display = on.
    ENDIF.
  ENDLOOP.
* ---------- ---------- ----------

ENDMETHOD.


METHOD excl_toolbar .

  CLASS cl_gui_alv_grid DEFINITION LOAD.

  REFRESH et_toolbar_excl.

* exclude all standard functions from toolbar
  APPEND cl_gui_alv_grid=>mc_mb_export           TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_detail           TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_sum              TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_mb_sum              TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_info             TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_subtot           TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_separator        TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_sort_asc         TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_sort_dsc         TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_filter           TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_find             TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_col_invisible    TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_col_optimize     TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_fix_columns      TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_unfix_columns    TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_print            TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_maintain_variant TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_current_variant  TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_load_variant     TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_save_variant     TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_graph            TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_views            TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_print_back       TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_print_prev       TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_loc_cut          TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_loc_copy         TO et_toolbar_excl.
  APPEND cl_gui_alv_grid=>mc_fc_loc_paste        TO et_toolbar_excl.

ENDMETHOD.


METHOD get_frontend_layout .

  CLEAR e_layout.
  REFRESH: et_fieldcat, et_sort, et_filter.

* get layout of ALV grid
  IF NOT g_grid IS INITIAL.
    CALL METHOD g_grid->get_frontend_layout
      IMPORTING
        es_layout = e_layout.
    CALL METHOD g_grid->get_frontend_fieldcatalog
      IMPORTING
        et_fieldcatalog = et_fieldcat.
    CALL METHOD g_grid->get_sort_criteria
      IMPORTING
        et_sort = et_sort.
    CALL METHOD g_grid->get_filter_criteria
      IMPORTING
        et_filter = et_filter.
  ENDIF.

* get layout of ALV tree
  IF NOT g_tree IS INITIAL.
    CALL METHOD g_tree->get_frontend_fieldcatalog
      IMPORTING
        et_fieldcatalog = et_fieldcat.
  ENDIF.

*  CALL METHOD cl_gui_cfw=>flush.                       " REM ID 18724

ENDMETHOD.


METHOD get_object_for_ident.  "#EC NEEDED
* Realisierung muss in den Subklassen erfolgen, da dort die
* Ausgabetabelle bekannt ist.
ENDMETHOD.


METHOD get_object_for_impobj .  "#EC NEEDED
* Realisierung muss in den Subklassen erfolgen, da dort die
* Ausgabetabelle bekannt ist.
ENDMETHOD.


METHOD get_rowid_for_object .                               "#EC NEEDED
* Diese Methode wird von den Subklassen implementiert.
ENDMETHOD.


METHOD get_wp_ish_object .

  e_rc = 0.

  CALL METHOD cl_ish_display_tools=>get_wp_ish_object
    EXPORTING
      i_sel_attribute     = i_sel_attribute
      i_set_extern_values = i_set_extern_values
      i_institution       = i_institution
      i_view_id           = i_view_id
      i_view_type         = i_view_type
      it_object           = it_object
    IMPORTING
      e_rc                = e_rc
      et_ish_object       = et_ish_object
    CHANGING
      c_errorhandler      = c_errorhandler.

ENDMETHOD.


method HANDLE_GRID_AFTER_USER_COMMAND .  "#EC NEEDED

endmethod.


method HANDLE_GRID_BEFORE_USER_COMM .

* raise event
  RAISE EVENT before_user_command
    EXPORTING
      i_ucomm = e_ucomm.

endmethod.


method HANDLE_GRID_CONTEXT_MENU .

* add context menu functions
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_current_variant
      text  = text-006.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_col_invisible
      text  = text-002.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_fix_columns
      text  = text-007.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_unfix_columns
      text  = text-008.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_col_optimize
      text  = text-003.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_find
      text  = text-004.
  CALL METHOD e_object->add_function
    EXPORTING
      fcode = cl_gui_alv_grid=>mc_fc_filter
      text  = text-005.

* raise event
  RAISE EVENT context_menu
    EXPORTING
      i_object = e_object.

endmethod.


METHOD handle_grid_double_click .

* Lokale Tabelle
  DATA: lt_outtab        TYPE ishmed_t_display_fields,
        lt_sel_object    TYPE ish_t_sel_object.
* Workareas
  DATA: l_outtab         LIKE LINE OF lt_outtab.
* Hilfsfelder und -strukturen
  DATA: l_rc             TYPE ish_method_rc,
        l_fieldname      TYPE lvc_fname,
        l_ucomm          TYPE sy-ucomm.

* ---------- ---------- ----------
* Zeile der Ausgabetabelle ermitteln
  CALL METHOD me->read_outtab_line
    EXPORTING
      i_index       = e_row-index
    IMPORTING
      e_outtab_line = l_outtab
      e_rc          = l_rc.
  CHECK l_rc = 0.
  CLEAR: lt_outtab[].
  INSERT l_outtab INTO TABLE lt_outtab.
* ---------- ---------- ----------
  l_fieldname = e_column.
* ---------- ---------- ----------
* Ereignis bevor Benutzeraktion
  l_ucomm = l_fieldname.
  RAISE EVENT before_user_command
    EXPORTING
      i_ucomm = l_ucomm.
* ---------- ---------- ----------
* Ermittlung der ausgewählten Objekte
  CLEAR: lt_sel_object[].
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls        = me
      i_fieldname     = l_fieldname
      it_outtab       = lt_outtab
    IMPORTING
      et_sel_object   = lt_sel_object.
* ---------- ---------- ----------
  RAISE EVENT double_click
    EXPORTING
      i_fieldname = l_fieldname
      it_object   = lt_sel_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_hotspot_click .

* Lokale Tabelle
  DATA: lt_outtab        TYPE ishmed_t_display_fields,
        lt_sel_object    TYPE ish_t_sel_object.
* Workareas
  DATA: l_outtab         LIKE LINE OF lt_outtab.
* Hilfsfelder und -strukturen
  DATA: l_rc             TYPE ish_method_rc,
        l_refresh        TYPE ish_on_off,
        l_fieldname      TYPE lvc_fname,
        l_ucomm          TYPE sy-ucomm.
* Objekte
  DATA: l_errorhandler   TYPE REF TO cl_ishmed_errorhandling.
* ---------- ---------- ----------
  CREATE OBJECT l_errorhandler.
  CLEAR: l_refresh.
* ---------- ---------- ----------
* Zeile der Ausgabetabelle ermitteln
  CALL METHOD me->read_outtab_line
    EXPORTING
      i_index       = e_row_id-index
    IMPORTING
      e_outtab_line = l_outtab
      e_rc          = l_rc.
  CHECK l_rc = 0.
  CLEAR: lt_outtab[].
  INSERT l_outtab INTO TABLE lt_outtab.
* ---------- ---------- ----------
  l_fieldname = e_column_id.
* ---------- ---------- ----------
* Ereignis bevor Benutzeraktion
  l_ucomm = l_fieldname.
  RAISE EVENT before_user_command
    EXPORTING
      i_ucomm = l_ucomm.
* ---------- ---------- ----------
* Ermittlung der ausgewählten Objekte
  CLEAR: lt_sel_object[].
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls        = me
      i_fieldname     = l_fieldname
      it_outtab       = lt_outtab
    IMPORTING
      et_sel_object   = lt_sel_object.
* ---------- ---------- ----------
* Knoten öffnen/schließen
  IF l_fieldname = 'OPENCLOSE'.
    CALL METHOD me->node_openclose
      EXPORTING
        i_outtab       = l_outtab
        i_fieldname    = l_fieldname
        it_fieldcat    = gt_fieldcat
      IMPORTING
        et_outtab      = lt_outtab
        e_refresh      = l_refresh
        e_rc           = l_rc
      CHANGING
        c_errorhandler = l_errorhandler.
    IF l_rc <> 0.
      EXIT.
    ENDIF.
*   ---------- ----------
*   Aktualisierung der Anzeige durchführen
    IF l_refresh = on.
      CALL METHOD me->refresh.
    ENDIF.
  ELSE.
*   Ereignis HOTSPOT CLICK
    RAISE EVENT hotspot_click
      EXPORTING
        i_fieldname = l_fieldname
        it_object   = lt_sel_object.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_menu_button .

* Lokale Tabelle
  DATA: lt_ctxmenu                  TYPE ttb_btnmnu,
        lt_ctx_functions            TYPE ui_funcattr.
* Workareas
  DATA: l_ctxmenu                   LIKE LINE OF lt_ctxmenu,
        l_ctx_function              LIKE LINE OF lt_ctx_functions.
* ---------- ---------- -----------
* Ermittlung der Funktionen, welche der Aufrufer eingetragen hat.
  IF NOT g_toolbar IS INITIAL.
    lt_ctxmenu = g_toolbar->m_table_ctxmenu.
  ENDIF.
* ---------- ---------- -----------
  LOOP AT lt_ctxmenu INTO l_ctxmenu
     WHERE function = e_ucomm.
    CALL METHOD l_ctxmenu-ctmenu->get_functions
      IMPORTING
        fcodes = lt_ctx_functions.
    LOOP AT lt_ctx_functions INTO l_ctx_function.
      CALL METHOD e_object->add_function
        EXPORTING
          fcode       = l_ctx_function-fcode
          text        = l_ctx_function-text
          icon        = l_ctx_function-icon
          ftype       = l_ctx_function-ftype
          disabled    = l_ctx_function-disabled
          hidden      = l_ctx_function-hidden
*         checked     = l_ctx_function-checked
          accelerator = l_ctx_function-accel.
    ENDLOOP.
  ENDLOOP.
* ---------- ---------- -----------

ENDMETHOD.


METHOD handle_grid_ondrag .

* Lokale Tabellen
  DATA: lt_outtab_complete   TYPE ishmed_t_display_fields,
        lt_sel_object        TYPE ish_t_sel_object,
        lt_index_rows        TYPE lvc_t_row,
        lt_cells             TYPE lvc_t_cell.
* Workareas
  DATA: l_cell               LIKE LINE OF lt_cells.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc,
        l_fieldname          TYPE lvc_fname.
* Objekt-Instanzen
  DATA: l_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        l_drag_object        TYPE REF TO cl_ish_display_drag_drop_cont.
* ---------- ---------- ----------
* Initialisierung
  l_rc = 0.
  CREATE OBJECT l_errorhandler.
* Obejekt für Drag & Drop instanzieren.
  CREATE OBJECT l_drag_object.
* ---------- ---------- ----------
  l_fieldname = e_column-fieldname.
* ---------- ---------- ----------
* Ermittlung der ausgewählte(n) Zeile(n).
* Bei DD kann dzt. immer nur eine gesamte Zeile gewählt werden.
  CLEAR: lt_index_rows[].
  CALL METHOD g_grid->get_selected_rows
    IMPORTING
      et_index_rows = lt_index_rows.
  IF lt_index_rows[] IS INITIAL.
*   Konnte keine Zeile ermittelt werden Ermittlung der ausgewählten
*   Zelle und daraus die Zeile bestimmen.
    CALL METHOD g_grid->get_selected_cells
      IMPORTING
        et_cell = lt_cells.
*   Bestimmtung der Zeilen.
    CLEAR: lt_index_rows[].
    LOOP AT lt_cells INTO l_cell.
      INSERT l_cell-row_id INTO TABLE lt_index_rows.
    ENDLOOP.
*   Markierung der Zeilen setzen (damit Auswahl transparenter wird).
    CALL METHOD g_grid->set_selected_rows
      EXPORTING
        it_index_rows = lt_index_rows.
  ENDIF.
* ---------- ---------- ----------
* Einträge der Ausgabetabelle ermitteln.
  CALL METHOD me->read_outtab_line
    EXPORTING
      it_index_rows   = lt_index_rows
    IMPORTING
      et_outtab_lines = lt_outtab_complete
      e_rc            = l_rc
    CHANGING
      c_errorhandler  = l_errorhandler.
  IF l_rc <> 0.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Jene ausgewähten Einträge aus der Tabelle entfernen,
* die nicht gedragt werden dürfen.
  DELETE lt_outtab_complete WHERE dragable = off.
* Bleibt kein Eintrag übrig Drag&Drop abbrechen.
  IF lt_outtab_complete[] IS INITIAL.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Ausgewählte Objekte ermitteln.
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls      = me
      it_outtab     = lt_outtab_complete
    IMPORTING
      et_sel_object = lt_sel_object.
* ---------- ---------- ----------
  l_drag_object->gt_sel_object[]  = lt_sel_object[].
  CALL METHOD me->add_data_to_drag_drop_cont
    IMPORTING
      e_rc           = l_rc
    CHANGING
      c_errorhandler = l_errorhandler
      c_dragdropobj  = l_drag_object.
  IF l_rc <> 0.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Object zuweisen
  e_dragdropobj->object = l_drag_object.
* ---------- ---------- ----------
* Ereignis auslösen
  RAISE EVENT ondrag
    EXPORTING
      e_fieldname     = l_fieldname
      e_drag_drop_obj = l_drag_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_ondrop.

* Lokale Tabellen
  DATA: lt_outtab_complete   TYPE ishmed_t_display_fields,
        lt_sel_object        TYPE ish_t_sel_object.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc,
        l_fieldname          TYPE lvc_fname,
        l_obj_type           TYPE i.
* Objekt-Instanzen
  DATA: l_errorhandler       TYPE REF TO cl_ishmed_errorhandling,
        l_drag_object        TYPE REF TO cl_ish_display_drag_drop_cont,
        lr_object            TYPE REF TO if_ish_identify_object.
* ---------- ---------- ----------
* Initialisierung
  l_rc = 0.
  CREATE OBJECT l_errorhandler
     EXPORTING
        i_control = on.
* ---------- ---------- ----------
  l_fieldname = e_column-fieldname.
* ---------- ---------- ----------
* Einträge der Ausgabetabelle ermitteln.
  CALL METHOD me->read_outtab_line
    EXPORTING
      i_index         = e_row-index
    IMPORTING
      et_outtab_lines = lt_outtab_complete
      e_rc            = l_rc
    CHANGING
      c_errorhandler  = l_errorhandler.
  IF l_rc <> 0.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Prüfen ob drop möglich ist.
  DELETE lt_outtab_complete WHERE dropable = off.
  IF lt_outtab_complete[] IS INITIAL.
    CALL METHOD e_dragdropobj->abort.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Prüfen, welche Art von Objekt gedragged wurde
  REFRESH lt_sel_object.
  lr_object ?= e_dragdropobj->object.
  CALL METHOD lr_object->('GET_TYPE')
    IMPORTING
      e_object_type = l_obj_type.
  CASE l_obj_type.
    WHEN cl_ish_display_drag_drop_cont=>co_otype_dd_obj_display.
*     Drag innerhalb des Klinischen Arbeitsplatzes
      l_drag_object ?= lr_object.
    WHEN OTHERS.
*     Drag kommt von außerhalb des Klin. Arbeitsplatzes
      CREATE OBJECT l_drag_object.
      l_drag_object->gr_dd_cont_variable ?= lr_object.
  ENDCASE.
* ---------- ---------- ----------
* Ausgewählte Objekte ermitteln.
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls      = me
      it_outtab     = lt_outtab_complete
    IMPORTING
      et_sel_object = lt_sel_object.
* ---------- ---------- ----------
  l_drag_object->gt_sel_object[]  = lt_sel_object[].
* ---------- ---------- ----------
* Ereignis auslösen
* ---------- ---------- ----------
  RAISE EVENT ondrop
    EXPORTING
      e_fieldname     = l_fieldname
      e_drag_drop_obj = l_drag_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD handle_grid_toolbar.

* Lokale Tabelle
  DATA: lt_toolbar_button           TYPE ttb_button.
* Workareas
  DATA: l_toolbar_button            LIKE LINE OF lt_toolbar_button,
        l_alv_toolbar               TYPE stb_button.
* Hilfsfelder und -strukturen
  DATA: l_index                     TYPE sy-tabix.
* ---------- ---------- -----------
* Ermittlung der Funktionen, welche der Aufrufer eingetragen hat.
  IF NOT g_toolbar IS INITIAL.
    lt_toolbar_button = g_toolbar->m_table_button.
  ENDIF.
* ---------- ---------- -----------
  LOOP AT lt_toolbar_button INTO l_toolbar_button.
    READ TABLE e_object->mt_toolbar INTO l_alv_toolbar
       WITH KEY function = l_toolbar_button-function.
    IF sy-subrc = 0.
      l_index = sy-tabix.
      l_alv_toolbar-icon      = l_toolbar_button-icon.
      l_alv_toolbar-quickinfo = l_toolbar_button-quickinfo.
      l_alv_toolbar-butn_type = l_toolbar_button-butn_type.
      l_alv_toolbar-text      = l_toolbar_button-text.
      l_alv_toolbar-checked   = l_toolbar_button-checked.
      MODIFY e_object->mt_toolbar FROM l_alv_toolbar
         INDEX l_index.
    ELSE.
      l_alv_toolbar-function  = l_toolbar_button-function.
      l_alv_toolbar-icon      = l_toolbar_button-icon.
      l_alv_toolbar-quickinfo = l_toolbar_button-quickinfo.
      l_alv_toolbar-butn_type = l_toolbar_button-butn_type.
      l_alv_toolbar-text      = l_toolbar_button-text.
      l_alv_toolbar-checked   = l_toolbar_button-checked.
      INSERT l_alv_toolbar INTO TABLE e_object->mt_toolbar.
    ENDIF.
  ENDLOOP.
* ---------- ---------- -----------

ENDMETHOD.


METHOD handle_grid_user_command .

* Lokale Tabellen
  DATA: lt_sel_object         TYPE ish_t_sel_object.
* Hilfsfelder und -strukturen
  DATA: l_fcode               TYPE n1fcode,
*        l_rc                  TYPE ish_method_rc,
        l_errorhandler        TYPE REF TO cl_ishmed_errorhandling.
* ---------- ---------- ----------
  CHECK NOT g_grid IS INITIAL.
* ---------- ---------- ----------
  CREATE OBJECT l_errorhandler.
* ---------- ---------- ----------
* Markierte Einträge holen
  CALL METHOD me->get_selection
    EXPORTING
      i_sel_attribute = '*'
    IMPORTING
      et_object       = lt_sel_object
*      e_rc            = l_rc
    CHANGING
      c_errorhandler  = l_errorhandler.
* ---------- ---------- ----------
* Ereigniss auslösen
  l_fcode = e_ucomm.
  RAISE EVENT user_command
    EXPORTING
      i_fcode        = l_fcode
      it_object      = lt_sel_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_identify_object~get_type .                    "#EC NEEDED

  e_object_type = co_otype_workpool.

ENDMETHOD.


METHOD if_ish_identify_object~is_a.                         "#EC NEEDED

  DATA: l_object_type  TYPE i.

  CALL METHOD me->get_type
    IMPORTING
      e_object_type = l_object_type.

  IF l_object_type = i_object_type.
    r_is_a = on.
  ELSE.
    r_is_a = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.            "#EC NEEDED

  IF i_object_type = co_otype_workpool.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from = off.
  ENDIF.

ENDMETHOD.


METHOD if_ish_list_display~build_fieldcat.   "#EC NEEDED

ENDMETHOD.


METHOD if_ish_list_display~check_if_empty .                 "#EC NEEDED

ENDMETHOD.


METHOD if_ish_list_display~destroy .

  DATA: l_is_valid       TYPE i.

* free ALV grid
  IF NOT g_grid IS INITIAL.
    CALL METHOD g_grid->is_valid
      IMPORTING
        RESULT = l_is_valid.
    IF l_is_valid EQ 1.
      CALL METHOD g_grid->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2.
      IF sy-subrc <> 0.
        MESSAGE a700(n4) WITH 'FREE_GRID' sy-subrc.
      ENDIF.
    ENDIF.
    CLEAR g_grid.
  ENDIF.

* free ALV tree
  IF NOT g_tree IS INITIAL.
    CALL METHOD g_tree->is_valid
      IMPORTING
        RESULT = l_is_valid.
    IF l_is_valid EQ 1.
      CALL METHOD g_tree->free
        EXCEPTIONS
          cntl_error        = 1
          cntl_system_error = 2.
      IF sy-subrc <> 0.
        MESSAGE s700(n4) WITH 'FREE_TREE' sy-subrc.
      ENDIF.
    ENDIF.
    CLEAR g_tree.
  ENDIF.

ENDMETHOD.


METHOD if_ish_list_display~display.  "#EC NEEDED

ENDMETHOD.


METHOD if_ish_list_display~get_data.   "#EC NEEDED

ENDMETHOD.


METHOD if_ish_list_display~get_selection.

* Lokale Tabellen
  DATA: lt_list_row_ids           TYPE lvc_t_row,
        lt_outtab                 TYPE ishmed_t_display_fields.
* Workareas
  DATA: l_list_row_id             LIKE LINE OF lt_list_row_ids,
        ls_row_id                 TYPE lvc_s_row.
* Hilfsfelder und -strukturen
  DATA: l_rc                      TYPE ish_method_rc.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
  CHECK NOT g_grid IS INITIAL.
* ---------- ---------- ----------
* Markierte Zeilen aus der Anzeige ermitteln.
  IF i_sel_type IS INITIAL OR i_sel_type = '*'.
    CALL METHOD g_grid->get_selected_rows
      IMPORTING
        et_index_rows = lt_list_row_ids.
  ENDIF.
  IF i_sel_type = 'Z' OR i_sel_type = '*'.
*   get marked cell from ALV grid
    CLEAR: ls_row_id, l_list_row_id.
    CALL METHOD g_grid->get_current_cell
      IMPORTING
        es_row_id = ls_row_id.
    l_list_row_id = ls_row_id.
    APPEND l_list_row_id TO lt_list_row_ids.
  ENDIF.
* ---------- ---------- ----------
  CHECK lt_list_row_ids[] IS NOT INITIAL.
* ---------- ---------- ----------
* Einträge der Ausgabetabelle ermitteln.
  CALL METHOD me->read_outtab_line
    EXPORTING
      it_index_rows   = lt_list_row_ids
    IMPORTING
      et_outtab_lines = lt_outtab
      e_rc            = l_rc
    CHANGING
      c_errorhandler  = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Ausgewählte Objekte ermitteln.
  CALL METHOD cl_ish_display_tools=>get_sel_object
    EXPORTING
      i_dspcls        = me
      i_sel_attribute = i_sel_attribute
      it_outtab       = lt_outtab
    IMPORTING
      et_sel_object   = et_object.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_list_display~get_toolbar.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: e_toolbar.
* ---------- ---------- ----------
  IF NOT g_toolbar IS INITIAL.
*   Weitere Verarbeitung nicht mehr nötig, Toolbar
*   bereits vorhanden.
    e_toolbar = g_toolbar.
    EXIT.
  ENDIF.
  CHECK g_toolbar IS INITIAL.
* ---------- ---------- ----------
* Dummy-Container instanzieren - falls nötig.
  IF g_dummy_container IS INITIAL.
    CREATE OBJECT g_dummy_container
      EXPORTING
        container_name              = 'DUMMY'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      e_rc = sy-subrc.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------
* Falls nötig Toolbar instanzieren.
  CREATE OBJECT g_toolbar
    EXPORTING
      parent             = g_dummy_container
    EXCEPTIONS
      cntl_install_error = 1
      cntl_error         = 2
      cntb_wrong_version = 3
      OTHERS             = 4.
  IF sy-subrc = 0.
    e_toolbar = g_toolbar.
  ELSE.
    e_rc = sy-subrc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_list_display~initialize .

  CLEAR: g_container,
         g_grid,
         g_tree,
         g_toolbar,
         g_construct,
         g_environment,
         g_institution,
         g_view_id,
         g_view_type,
         g_wplace_id,
         g_dragdrop,
         g_default_fcode,
         g_nodes_open,
         g_nodes_open_old,
         g_layout,
         g_planoe.

  CLEAR: gt_fieldcat[],
         gt_sort[],
         gt_filter[],
         gt_all_object[],
         gt_wpool_work[],
         gt_nodes_open[],
         gt_except_qinfo[].

ENDMETHOD.


METHOD if_ish_list_display~insert_data.    "#EC NEEDED

ENDMETHOD.


METHOD if_ish_list_display~refresh.  "#EC NEEDED

ENDMETHOD.


METHOD if_ish_list_display~refresh_data.  "#EC NEEDED

ENDMETHOD.


METHOD if_ish_list_display~remove_data . "#EC NEEDED

* Realisierung muss in den Subklassen erfolgen, da dort die
* Ausgabetabelle bekannt ist.

ENDMETHOD.


METHOD if_ish_list_display~set_layout.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
  g_layout    = i_layout.
  gt_fieldcat = it_fieldcat.
  gt_sort     = it_sort.
  gt_filter   = it_filter.
* ---------- ---------- ----------


ENDMETHOD.


METHOD if_ish_list_display~set_scroll_position.

* Lokale Tabellen
  DATA: lt_index_rows        TYPE lvc_t_row.
* Workareas
  DATA: l_index_row          LIKE LINE OF lt_index_rows.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc,
*        l_page_row_info      TYPE lvc_s_row,
        l_page_col_info      TYPE lvc_s_col.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Zeilenindex für übergebene (erzeugende) Objekte ermitteln.
  CALL METHOD me->get_rowid_for_object
    EXPORTING
      it_object      = it_object
    IMPORTING
      et_index_rows  = lt_index_rows
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
  CHECK NOT lt_index_rows[] IS INITIAL.
* ---------- ---------- ----------
  IF NOT g_grid IS INITIAL.
*   Ermittlung der "aktuellen" Zelle (Cursor-Pos.)
    CALL METHOD g_grid->get_current_cell
      IMPORTING
        es_col_id = l_page_col_info.
**   Aktuelle Scroll-Information bestimmen.
*    CALL METHOD g_grid->get_scroll_info_via_id         " REM ID 18724
*      IMPORTING
**        es_row_info = l_page_row_info
*        es_col_info = l_page_col_info.
**   Flush durchführen; damit Informationen auch
**   tatsächlich zur Verfügung stehen.
*    CALL METHOD cl_gui_cfw=>flush.                     " REM ID 18724
*   ---------- ----------
*   Positionierung auf ersten Eintrag vornehmen
    SORT lt_index_rows BY index ASCENDING.
    READ TABLE lt_index_rows INTO l_index_row
       INDEX 1.
*   Durch Methode "set_scroll_info_via_id" wird der
*   entsprechende Eintrag an erster Position angzeigt.
*   Dies soll verhindert werden da somit die Anzeige
*   nicht stabil bleibt (es gibt leider keine
*   Möglichkeit um zu entscheiden ob die entsprechende
*   Zeile "sichtbar" ist oder nicht).
*    CALL METHOD g_grid->set_scroll_info_via_id
*      EXPORTING
*        is_row_info = l_index_row
*        is_col_info = l_page_col_info.
*     Cursor in die zuvor ausgewählte Zelle positionieren
*   Durch Methode "set_current_cell_via_id" wird der
*   Cursor in die angegebene Zeile + Spalte positioniert.
*   Vorteil: falls angegebene Zeile nicht sichtbar wird
*   automatisch gescrollt
    CALL METHOD g_grid->set_current_cell_via_id
      EXPORTING
        is_row_id    = l_index_row
        is_column_id = l_page_col_info.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_list_display~set_selection.

* Lokale Tabellen
  DATA: lt_index_rows        TYPE lvc_t_row.
* Hilfsfelder und -strukturen
  DATA: l_rc                 TYPE ish_method_rc.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Zeilenindex für übergebene (erzeugende) Objekte ermitteln.
  CALL METHOD me->get_rowid_for_object
    EXPORTING
      it_object      = it_object
    IMPORTING
      et_index_rows  = lt_index_rows
      e_rc           = l_rc
    CHANGING
      c_errorhandler = c_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Zeilen markieren.
  IF NOT g_grid IS INITIAL.
    CALL METHOD g_grid->set_selected_rows
      EXPORTING
        it_index_rows = lt_index_rows.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD if_ish_list_display~set_sort_criteria .

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
  IF i_sort = co_sort_individual.
    gt_sort_object = it_sort_object.
  ENDIF.
  g_sort = i_sort.
* ---------- ---------- ----------

ENDMETHOD.


METHOD node_openclose .

  DATA: l_openclose              TYPE ish_on_off,
        ls_nodes_open            LIKE LINE OF gt_nodes_open.

* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
  CLEAR: et_outtab[], e_refresh, l_openclose.
* ---------- ---------- ----------
  IF i_outtab-dspobj IS INITIAL.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Derzeit gibt es pro Anzeigeklasse nur einen Knoten zu öffnen
* bzw. zu schliessen.
* Trotzdem Feldnamen angeben um in Zukunft flexibler zu sein.
  CHECK i_fieldname = 'OPENCLOSE'.
* ---------- ---------- ----------
  e_refresh = on.
* ---------- ---------- ----------
* i_node_attribute = 'X'
* => Knoten öffnen
  IF i_node_attribute = on.
    CALL METHOD i_outtab-dspobj->('SET_NODE')
      EXPORTING
        i_node_open = 'X'.
    l_openclose = 'X'.
* i_node_attribute = ' '
* => Knoten schließen
  ELSEIF i_node_attribute = off.
    CALL METHOD i_outtab-dspobj->('SET_NODE')
      EXPORTING
        i_node_open = ' '.
    l_openclose = ' '.
* i_node_attribute = '*'
* => Knoten schließen wenn geöffnet
*    Knoten öffnen wenn geschlossen
  ELSE.
    IF i_outtab-openclose = icon_closed_folder.
*     Knoten öffnen
      CALL METHOD i_outtab-dspobj->('SET_NODE')
        EXPORTING
          i_node_open = 'X'.
      l_openclose = 'X'.
    ELSEIF i_outtab-openclose = icon_open_folder.
*     Knoten schließen
      CALL METHOD i_outtab-dspobj->('SET_NODE')
        EXPORTING
          i_node_open = ' '.
      l_openclose = ' '.
    ELSE.
      e_refresh = off.
      EXIT.
    ENDIF.
  ENDIF.
* ---------- ---------- ----------

* MED-30311: remember state of node
  READ TABLE gt_nodes_open INTO ls_nodes_open WITH KEY keyno = i_outtab-keyno.
  IF sy-subrc = 0.
    ls_nodes_open-openclose = l_openclose.
    MODIFY gt_nodes_open FROM ls_nodes_open INDEX sy-tabix.
  ELSE.
    CLEAR ls_nodes_open.
    ls_nodes_open-keyno     = i_outtab-keyno.
    ls_nodes_open-openclose = l_openclose.
    APPEND ls_nodes_open TO gt_nodes_open.
  ENDIF.

ENDMETHOD.


METHOD node_openclose_all.                                  "#EC NEEDED

ENDMETHOD.


METHOD read_outtab_line .                                   "#EC NEEDED

ENDMETHOD.


METHOD refresh_display.

* Hilfsfelder und -strukturen
  DATA: l_stable              TYPE lvc_s_stbl.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
  CLEAR l_stable.
  l_stable-row = on.                   "fixing list position
  l_stable-col = on.
* ---------- ---------- ----------
  CALL METHOD me->build_layout
    CHANGING
      c_layout = g_layout.
* ---------- ---------- ----------
* Layout der Liste könnte durch Methode "set_layout" geändert worden
* sein - daher Inforamtionen an das ALV-Grid weiterreichen.
  CALL METHOD g_grid->set_frontend_fieldcatalog
    EXPORTING
      it_fieldcatalog = gt_fieldcat.
* Sortierkriterien zwar setzen; jedoch unbedingt verhindern dass
  CALL METHOD g_grid->set_sort_criteria
    EXPORTING
      it_sort = gt_sort.
  CALL METHOD g_grid->set_filter_criteria
    EXPORTING
      it_filter = gt_filter.
  CALL METHOD g_grid->set_frontend_layout
    EXPORTING
      is_layout = g_layout.
* ---------- ---------- ----------
  CALL METHOD g_grid->refresh_table_display
    EXPORTING
      is_stable      = l_stable
*     ACHTUNG: auf keinen Fall darf die Sortierung
*     geändert werden !
      i_soft_refresh = on.
* ---------- ---------- ----------

ENDMETHOD.


METHOD register_events .

  IF NOT g_grid IS INITIAL.
*   --- --- --- --- --- --- --- ---
*   Toolbar
    SET HANDLER me->handle_grid_toolbar FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Toolbar Menü Button
    SET HANDLER me->handle_grid_menu_button FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Vor einer Benutzeraktion
    SET HANDLER me->handle_grid_before_user_comm FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Benutzeraktion
    SET HANDLER me->handle_grid_user_command FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Nach einer Benutzeraktion
    SET HANDLER me->handle_grid_after_user_command FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Doppelklick
    SET HANDLER me->handle_grid_double_click FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Hotspot
    SET HANDLER me->handle_grid_hotspot_click FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Kontextmenü
    SET HANDLER me->handle_grid_context_menu FOR g_grid.
*   --- --- --- --- --- --- --- ---
*   Drag&Drop
    SET HANDLER me->handle_grid_ondrag FOR g_grid.
    SET HANDLER me->handle_grid_ondrop FOR g_grid.
*   --- --- --- --- --- --- --- ---
  ENDIF.

ENDMETHOD.


METHOD set_color_outtab_line.

* Hilfsfelder und -strukturen
  DATA: l_color                 TYPE lvc_s_scol.
* ---------- ---------- ----------
* "Wunschfelder" blau färben.
  CLEAR l_color.
  IF NOT i_outtab-wdate IS INITIAL.
    l_color-fname = 'WDATE'.
    l_color-color-col = cl_gui_resources=>list_col_heading.
    INSERT l_color INTO TABLE ct_cellcolor.
  ENDIF.
  CLEAR l_color.
  IF NOT i_outtab-wtime = '      '.
    l_color-fname = 'WTIME'.
    l_color-color-col = cl_gui_resources=>list_col_heading.
    INSERT l_color INTO TABLE ct_cellcolor.
  ENDIF.
  CLEAR l_color.
  IF NOT i_outtab-wroom IS INITIAL.
    l_color-fname = 'WROOM'.
    l_color-color-col = cl_gui_resources=>list_col_heading.
    INSERT l_color INTO TABLE ct_cellcolor.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_dragdrop_outtab_line .

* ---------- ---------- ----------
* Workareas
  DATA: l_dragdrop                LIKE LINE OF et_dragdrop.
* Hilfsfelder und -strukturen
  DATA: l_handle                  TYPE lvc_ddid.
*        l_type                    TYPE i.
* ---------- ---------- ----------
  CLEAR: et_dragdrop[], e_dragable, e_dropable.
* ---------- ---------- ----------
* Drag&Drop für Ausgabezeile bilden
*  CALL METHOD i_outtab-dspobj->('GET_TYPE')
*    IMPORTING
*      e_object_type = l_type.
* ---------- ---------- ----------
* Dzt. keine Einschränkung von Drag & Drop
  e_dragable = on.
  e_dropable = on.
* ---------- ---------- ----------
  IF e_dragable = on OR
     e_dropable = on.
    CALL METHOD g_dragdrop->get_handle
      IMPORTING
        handle      = l_handle
      EXCEPTIONS
        obj_invalid = 1.
    IF sy-subrc <> 0.
      EXIT.
    ENDIF.
*   ---------- ----------
    CLEAR: l_dragdrop.
    l_dragdrop-dragdropid = l_handle.
    INSERT l_dragdrop INTO TABLE et_dragdrop.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_function_code .

  CHECK NOT i_ucomm IS INITIAL.

* print the actual ALV grid
  IF NOT g_grid  IS INITIAL.
    CALL METHOD g_grid->set_function_code
      CHANGING
        c_ucomm = i_ucomm.
  ENDIF.

* print the actual ALV tree
  IF NOT g_tree IS INITIAL.
    CALL METHOD g_tree->set_function_code
      EXPORTING
        i_ucomm = i_ucomm.
  ENDIF.

  CALL METHOD cl_gui_cfw=>flush.

ENDMETHOD.


METHOD SET_NDIA.
* MED-40483
  gt_ndia = it_ndia.
ENDMETHOD.


METHOD set_nosave.
*Sta/PN/MED-40483
  g_nosave = i_nosave.
ENDMETHOD.


METHOD set_planning_ou.
  g_planoe = i_planoe.
ENDMETHOD.


METHOD set_properties_dspobj .

* Hilfsfelder und -strukturen
  DATA:  l_rc                   TYPE ish_method_rc,
         l_obj_type             TYPE i.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Typ des Anzeigeobjektes ermitteln
  CALL METHOD i_dspobj->('GET_TYPE')
    IMPORTING
      e_object_type = l_obj_type.
  CASE l_obj_type.
*   Anzeigeobjekt OPERATION
    WHEN cl_ishmed_dspobj_operation=>co_otype_dspobj_operation.
      CALL METHOD me->set_properties_operation
        EXPORTING
          i_dspobj       = i_dspobj
          i_open_node    = i_open_node
          i_close_node   = i_close_node
          i_pat_anonym   = i_pat_anonym
        IMPORTING
          e_rc           = l_rc
        CHANGING
          c_errorhandler = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
  ENDCASE.
* ---------- ---------- ----------

ENDMETHOD.


METHOD set_properties_operation .                           "#EC NEEDED

ENDMETHOD.


METHOD set_sel_criteria .

  DATA: l_repid      TYPE sy-repid.

* view-ID and view-type are necessary
* (workplace-ID could be empty)
  CHECK NOT g_view_id   IS INITIAL AND
        NOT g_view_type IS INITIAL.

  l_repid = sy-repid.

  REFRESH gt_sel_crit.

* START MED-40483 2010/06/18
  IF it_sel_criteria IS NOT INITIAL.
    gt_sel_crit = it_sel_criteria.
  ELSE.
* END MED-40483
    CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
      EXPORTING
        i_placeid  = g_wplace_id
        i_viewid   = g_view_id
        i_viewtype = g_view_type
        i_caller   = l_repid
      TABLES
        t_selvar   = gt_sel_crit.
  ENDIF.                                                    "MED-40483

ENDMETHOD.


METHOD set_view_data .

  g_view_id   = i_viewid.

  g_wplace_id = i_placeid.

ENDMETHOD.


METHOD set_work_flag.

* Workareas
  DATA: l_wpool_work             LIKE LINE OF gt_wpool_work,
        l_all_object             LIKE LINE OF gt_all_object.
* Hilfsfelder und -strukturen
  DATA: l_index                  TYPE sy-tabix.
* Objekt-Instanzen
  DATA: l_dspobj                 TYPE REF TO object.
* ---------- ---------- ----------
* Initialisierung
  e_rc = 0.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.
* ---------- ---------- ----------
* Prüfung der übergeb. Daten
  IF i_impobj IS INITIAL.
    e_rc = 1.
    EXIT.
  ENDIF.
* ---------- ---------- ----------
* Anzeigeobjekt ermitteln
  READ TABLE gt_all_object INTO l_all_object
     WITH KEY impobj = i_impobj.
  IF sy-subrc = 0.
    l_dspobj = l_all_object-dspobj.
  ENDIF.
* ---------- ---------- ----------
  READ TABLE gt_wpool_work INTO l_wpool_work
     WITH KEY dspobj = l_dspobj
              object = i_object.
  IF sy-subrc = 0.
    l_index = sy-tabix.
    l_wpool_work-work_flag = i_work_flag.
    IF NOT i_app IS INITIAL.
     READ TABLE l_wpool_work-appmnts TRANSPORTING NO FIELDS
        WITH KEY table_line = i_app.
      IF sy-subrc <> 0.
        INSERT i_app INTO TABLE l_wpool_work-appmnts.
      ENDIF.
    ENDIF.
    MODIFY gt_wpool_work FROM l_wpool_work
       INDEX l_index.
  ENDIF.
* ---------- ---------- ----------

ENDMETHOD.


METHOD sort .                                               "#EC NEEDED

ENDMETHOD.
ENDCLASS.
