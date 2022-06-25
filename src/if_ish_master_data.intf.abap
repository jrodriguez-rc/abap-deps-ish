*"* components of interface IF_ISH_MASTER_DATA
interface IF_ISH_MASTER_DATA
  public .


  interfaces IF_ISH_DATA_OBJECT .

  methods CHECK
    importing
      value(I_FILL_OBJECT) type ISH_ON_OFF default SPACE
      value(I_WHAT_TO_CHECK) type ANY optional
    exporting
      value(E_RC) type I
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING .
  methods SAVE
    importing
      value(I_TESTRUN) type ISH_ON_OFF default SPACE
      value(I_TCODE) type SY-TCODE default SY-TCODE
    exporting
      value(E_RC) type I
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
endinterface.
