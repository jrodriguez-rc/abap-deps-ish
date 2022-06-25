*"* components of interface IF_ISH_CB_ERRHDL
interface IF_ISH_CB_ERRHDL
  public .


  interfaces IF_MESSAGE .

  aliases GET_LONGTEXT
    for IF_MESSAGE~GET_LONGTEXT .
  aliases GET_TEXT
    for IF_MESSAGE~GET_TEXT .

  methods HOTSPOT_CLICK
    importing
      !IS_MESSAGE type RN1MESSAGE
      value(I_ROW_ID) type LVC_S_ROW optional
      value(I_COLUMN_ID) type LVC_S_COL optional
      value(IS_ROW_NO) type LVC_S_ROID optional
    exporting
      value(E_DONT_PROCEED) type ISH_ON_OFF .
endinterface.
