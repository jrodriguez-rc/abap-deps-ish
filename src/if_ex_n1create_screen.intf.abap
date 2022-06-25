*"* components of interface IF_EX_N1CREATE_SCREEN
interface IF_EX_N1CREATE_SCREEN
  public .


  methods CREATE
    importing
      value(I_OBJECT_TYPE) type I optional
    exporting
      value(ER_INSTANCE) type ref to CL_ISH_SCREEN_STD
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
