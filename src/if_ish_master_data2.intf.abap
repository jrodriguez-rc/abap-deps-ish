*"* components of interface IF_ISH_MASTER_DATA2
interface IF_ISH_MASTER_DATA2
  public .


  interfaces IF_ISH_DATA_OBJECT .

  aliases CO_MAX_SNAPSHOTS
    for IF_ISH_DATA_OBJECT~CO_MAX_SNAPSHOTS .
  aliases CO_MODE_DELETE
    for IF_ISH_DATA_OBJECT~CO_MODE_DELETE .
  aliases CO_MODE_ERROR
    for IF_ISH_DATA_OBJECT~CO_MODE_ERROR .
  aliases CO_MODE_INSERT
    for IF_ISH_DATA_OBJECT~CO_MODE_INSERT .
  aliases CO_MODE_UNCHANGED
    for IF_ISH_DATA_OBJECT~CO_MODE_UNCHANGED .
  aliases CO_MODE_UPDATE
    for IF_ISH_DATA_OBJECT~CO_MODE_UPDATE .
  aliases FALSE
    for IF_ISH_DATA_OBJECT~FALSE .
  aliases OFF
    for IF_ISH_DATA_OBJECT~OFF .
  aliases ON
    for IF_ISH_DATA_OBJECT~ON .
  aliases TRUE
    for IF_ISH_DATA_OBJECT~TRUE .

  methods CHECK
    importing
      value(I_FILL_OBJECT) type ISH_ON_OFF default OFF
      value(I_WHAT_TO_CHECK) type ANY optional
    exporting
      value(E_RC) type I
    changing
      value(C_ERRORHANDLER) type ref to CL_ISHMED_ERRORHANDLING .
  methods SAVE
    importing
      value(I_TESTRUN) type ISH_ON_OFF default OFF
      value(I_TCODE) type SY-TCODE default SY-TCODE
    exporting
      value(E_RC) type I
    changing
      !C_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING .
endinterface.
