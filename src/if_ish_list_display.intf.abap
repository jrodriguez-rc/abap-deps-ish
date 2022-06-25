*"* components of interface IF_ISH_LIST_DISPLAY
interface IF_ISH_LIST_DISPLAY
  public .


  data GT_FIELDCAT type LVC_T_FCAT .
  data GT_FILTER type LVC_T_FILT .
  data GT_SEL_CRIT type ISHMED_T_RSPARAMS .
  data GT_SORT type LVC_T_SORT .
  class-data G_CONSTRUCT type ISH_ON_OFF .
  data G_CONTAINER type ref to CL_GUI_CONTAINER .
  data G_LAYOUT type LVC_S_LAYO .
  data G_TOOLBAR type ref to CL_GUI_TOOLBAR .
  constants CO_SEL_OBJECT type LVC_FNAME value 'OBJECT'. "#EC NOTEXT
  constants CO_SEL_SRVOBJ type LVC_FNAME value 'SRVOBJ'. "#EC NOTEXT
  constants CO_SEL_IMPOBJ type LVC_FNAME value 'IMPOBJ'. "#EC NOTEXT
  constants CO_SEL_DSPOBJ type LVC_FNAME value 'DSPOBJ'. "#EC NOTEXT
  constants CO_SEL_DSPCLS type LVC_FNAME value 'DSPCLS'. "#EC NOTEXT
  constants CO_SORT_DATE type N1SORTNO value '00001'. "#EC NOTEXT
  constants CO_SORT_OPOU type N1SORTNO value '00002'. "#EC NOTEXT
  constants CO_SORT_INDIVIDUAL type N1SORTNO value '00003'. "#EC NOTEXT
  constants CO_SORT_OP_STD type N1SORTNO value '00004'. "#EC NOTEXT
  constants CO_SORT_REQUESTER type N1SORTNO value '00005'. "#EC NOTEXT

  events AFTER_USER_COMMAND
    exporting
      value(I_UCOMM) type SY-UCOMM .
  events BEFORE_USER_COMMAND
    exporting
      value(I_UCOMM) type SY-UCOMM .
  events CONTEXT_MENU
    exporting
      value(I_OBJECT) type ref to CL_CTMENU optional .
  events DOUBLE_CLICK
    exporting
      value(I_FIELDNAME) type LVC_FNAME
      value(IT_OBJECT) type ISH_T_SEL_OBJECT optional .
  events HOTSPOT_CLICK
    exporting
      value(I_FIELDNAME) type LVC_FNAME
      value(IT_OBJECT) type ISH_T_SEL_OBJECT optional .
  events IS_EMPTY .
  events ONDRAG
    exporting
      value(E_FIELDNAME) type LVC_FNAME optional
      value(E_DRAG_DROP_OBJ) type ref to CL_ISH_DISPLAY_DRAG_DROP_CONT optional .
  events ONDROP
    exporting
      value(E_FIELDNAME) type LVC_FNAME optional
      value(E_DRAG_DROP_OBJ) type ref to CL_ISH_DISPLAY_DRAG_DROP_CONT optional .
  events USER_COMMAND
    exporting
      value(I_FCODE) type N1FCODE
      value(IT_OBJECT) type ISH_T_SEL_OBJECT optional .

  methods BUILD_FIELDCAT
    exporting
      !ET_FIELDCAT type LVC_T_FCAT
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CHECK_IF_EMPTY
    exporting
      value(E_EMPTY) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods DESTROY .
  methods DISPLAY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_DATA
    importing
      !IT_OBJECT type ISH_OBJECTLIST optional
    exporting
      !ET_OBJECT type ISH_OBJECTLIST
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_SELECTION
    importing
      value(I_SEL_ATTRIBUTE) type ISH_SEL_OBJECT-ATTRIBUTE default '*'
      value(I_SEL_TYPE) type N1LIST_SEL_TYPE default SPACE
    exporting
      !ET_OBJECT type ISH_T_SEL_OBJECT
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods GET_TOOLBAR
    exporting
      !E_TOOLBAR type ref to CL_GUI_TOOLBAR
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE .
  methods INSERT_DATA
    importing
      !IT_OBJECT type ISH_OBJECTLIST optional
      value(I_POSITION) type NUMC3 optional
      !I_AFTER_OBJECT type N1OBJECTREF optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REFRESH
    importing
      !IT_OBJECT type ISH_OBJECTLIST optional
      !IT_SEL_CRITERIA type ISHMED_T_RSPARAMS optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REFRESH_DATA
    importing
      !IT_OBJECT type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods REMOVE_DATA
    importing
      !IT_OBJECT type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_LAYOUT
    importing
      !I_LAYOUT type LVC_S_LAYO optional
      !IT_FIELDCAT type LVC_T_FCAT optional
      !IT_SORT type LVC_T_SORT optional
      !IT_FILTER type LVC_T_FILT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_SELECTION
    importing
      !IT_OBJECT type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_SORT_CRITERIA
    importing
      value(I_SORT) type N1SORTNO optional
      value(IT_SORT_OBJECT) type ISHMED_T_SORT_OBJECT optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING optional .
  methods SET_SCROLL_POSITION
    importing
      !IT_OBJECT type ISH_OBJECTLIST optional
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
