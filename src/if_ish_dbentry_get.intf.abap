*"* components of interface IF_ISH_DBENTRY_GET
interface IF_ISH_DBENTRY_GET
  public .


  methods GET_ERDAT
    returning
      value(R_ERDAT) type RI_ERDAT .
  methods GET_ERTIM
    returning
      value(R_ERTIM) type RI_ERTIM .
  methods GET_ERUSR
    returning
      value(R_ERUSR) type RI_ERNAM .
  methods GET_LODAT
    returning
      value(R_LODAT) type RI_LODAT .
  methods GET_LOEKZ
    returning
      value(R_LOEKZ) type RI_LOEKZ .
  methods GET_LOTIM
    returning
      value(R_LOTIM) type RI_LOTIM .
  methods GET_LOUSR
    returning
      value(R_LOUSR) type RI_LOUSR .
  methods GET_MANDT
    returning
      value(R_MANDT) type MANDT .
  methods GET_ORIG_ERDAT
    returning
      value(R_ERDAT) type RI_ERDAT .
  methods GET_ORIG_ERTIM
    returning
      value(R_ERTIM) type RI_ERTIM .
  methods GET_ORIG_ERUSR
    returning
      value(R_ERUSR) type RI_ERNAM .
  methods GET_ORIG_FIELD_CONTENT
    importing
      !I_FIELDNAME type ISH_FIELDNAME
    changing
      !C_CONTENT type DATA
    raising
      CX_ISH_STATIC_HANDLER .
  methods GET_ORIG_LODAT
    returning
      value(R_LODAT) type RI_LODAT .
  methods GET_ORIG_LOEKZ
    returning
      value(R_LOEKZ) type RI_LOEKZ .
  methods GET_ORIG_LOTIM
    returning
      value(R_LOTIM) type RI_LOTIM .
  methods GET_ORIG_LOUSR
    returning
      value(R_LOUSR) type RI_LOUSR .
  methods GET_ORIG_MANDT
    returning
      value(R_MANDT) type MANDT .
  methods GET_ORIG_SPRAS
    returning
      value(R_SPRAS) type SPRAS .
  methods GET_ORIG_STODAT
    returning
      value(R_STODAT) type STORN_DAT .
  methods GET_ORIG_STOID
    returning
      value(R_STOID) type N1STOID .
  methods GET_ORIG_STOKZ
    returning
      value(R_STOKZ) type RI_STORN .
  methods GET_ORIG_STOTIM
    returning
      value(R_STOTIM) type ISH_STORN_TIM .
  methods GET_ORIG_STOUSR
    returning
      value(R_STOUSR) type STORN_USER .
  methods GET_ORIG_TIMESTAMP
    returning
      value(R_TIMESTAMP) type TIMESTAMPL .
  methods GET_ORIG_UPDAT
    returning
      value(R_UPDAT) type RI_UPDAT .
  methods GET_ORIG_UPTIM
    returning
      value(R_UPTIM) type RI_UPTIM .
  methods GET_ORIG_UPUSR
    returning
      value(R_UPUSR) type RI_UPNAM .
  methods GET_SPRAS
    returning
      value(R_SPRAS) type SPRAS .
  methods GET_STODAT
    returning
      value(R_STODAT) type STORN_DAT .
  methods GET_STOID
    returning
      value(R_STOID) type N1STOID .
  methods GET_STOKZ
    returning
      value(R_STOKZ) type RI_STORN .
  methods GET_STOTIM
    returning
      value(R_STOTIM) type ISH_STORN_TIM .
  methods GET_STOUSR
    returning
      value(R_STOUSR) type STORN_USER .
  methods GET_TIMESTAMP
    returning
      value(R_TIMESTAMP) type TIMESTAMPL .
  methods GET_UPDAT
    returning
      value(R_UPDAT) type RI_UPDAT .
  methods GET_UPTIM
    returning
      value(R_UPTIM) type RI_UPTIM .
  methods GET_UPUSR
    returning
      value(R_UPUSR) type RI_UPNAM .
endinterface.
