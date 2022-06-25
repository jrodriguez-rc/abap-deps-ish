*"* components of interface IF_EX_ISHMED_CHECK_CASE_VALID
interface IF_EX_ISHMED_CHECK_CASE_VALID
  public .


  interfaces IF_BADI_INTERFACE .

  methods CHECK_CASE_VALID
    importing
      value(I_EINRI) type EINRI
      value(I_FALNR) type FALNR
      value(I_CALLER) type N1CALLER
      value(I_CHECK_ACCOUNTED) type ISH_ON_OFF default SPACE
      value(I_CLOSED) type CHAR1 optional
      value(I_CHECK_CLOSED) type ISH_ON_OFF default SPACE
    exporting
      value(E_ERR_LEVEL_ACCOUNTED) type CHAR1
      value(E_ERR_LEVEL_CLOSED) type CHAR1 .
endinterface.
