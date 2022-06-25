*"* components of interface IF_ISH_CONFIG_SPLITTER
interface IF_ISH_CONFIG_SPLITTER
  public .


  interfaces IF_ISH_IDENTIFY_OBJECT .

  methods DESTROY
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods MODIFY_PROPERTIES
    importing
      !IR_SCR_SPLITTER type ref to IF_ISH_SCR_SPLITTER
    exporting
      value(E_MODIFIED) type ISH_ON_OFF
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_COLUMN_PROPERTIES
    importing
      !IR_SCR_SPLITTER type ref to IF_ISH_SCR_SPLITTER
      value(I_SAVED_PROP_FOUND) type ISH_ON_OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CS_SPLITPROP_COL type RN1_SPLITPROP_COL
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_COMMON_PROPERTIES
    importing
      !IR_SCR_SPLITTER type ref to IF_ISH_SCR_SPLITTER
      value(I_SAVED_PROP_FOUND) type ISH_ON_OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CS_SPLITPROP type RN1_SPLITPROP
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods INITIALIZE_ROW_PROPERTIES
    importing
      !IR_SCR_SPLITTER type ref to IF_ISH_SCR_SPLITTER
      value(I_SAVED_PROP_FOUND) type ISH_ON_OFF
    exporting
      value(E_RC) type ISH_METHOD_RC
    changing
      !CS_SPLITPROP_ROW type RN1_SPLITPROP_ROW
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods CLONE
    returning
      value(RR_CONFIG) type ref to IF_ISH_CONFIG_SPLITTER .
  methods COPY
    returning
      value(RR_CONFIG) type ref to IF_ISH_CONFIG_SPLITTER .
endinterface.
