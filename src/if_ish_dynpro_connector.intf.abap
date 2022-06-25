*"* components of interface IF_ISH_DYNPRO_CONNECTOR
interface IF_ISH_DYNPRO_CONNECTOR
  public .


  type-pools ABAP .
  methods CONNECT
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !I_DYNNR type RI_DYNNR
      !I_OVERWRITE type ABAP_BOOL default ABAP_FALSE
    returning
      value(RS_PARENT) type RNSCR_PARENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods CONNECT_FREE
    importing
      !IR_SCREEN type ref to IF_ISH_SCREEN
      !I_DYNNR_FROM type RI_DYNNR default '0000'
      !I_DYNNR_TO type RI_DYNNR default '9999'
    returning
      value(RS_PARENT) type RNSCR_PARENT
    raising
      CX_ISH_STATIC_HANDLER .
  methods DISCONNECT
    importing
      !I_DYNNR type RI_DYNNR
    returning
      value(RR_SCREEN) type ref to IF_ISH_SCREEN .
  methods GET_EMBEDDED_DYNPRO
    importing
      !I_DYNNR type RI_DYNNR
      !I_FIELDNAME type ISH_FIELDNAME
    returning
      value(RS_PARENT) type RNSCR_PARENT .
  methods GET_REPID
    returning
      value(R_REPID) type REPID .
  methods GET_SCREEN_FOR_DYNPRO
    importing
      !I_DYNNR type RI_DYNNR
    returning
      value(RR_SCREEN) type ref to IF_ISH_SCREEN .
  methods PROCESS_F1
    importing
      !I_DYNNR type RI_DYNNR .
  methods PROCESS_F4
    importing
      !I_DYNNR type RI_DYNNR .
  methods PROCESS_PAI
    importing
      !I_DYNNR type RI_DYNNR .
  methods PROCESS_PBO
    importing
      !I_DYNNR type RI_DYNNR .
endinterface.
