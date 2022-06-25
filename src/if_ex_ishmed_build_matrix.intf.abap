*"* components of interface IF_EX_ISHMED_BUILD_MATRIX
interface IF_EX_ISHMED_BUILD_MATRIX
  public .


  interfaces IF_BADI_INTERFACE .

  methods BUILD_MATRIX
    importing
      !I_INSTITUTION_ID type EINRI
    exporting
      !ET_TC_MATRIX type RN1TC_MATRIX_T .
  methods BUILD_MATRIX_FOR_USER
    importing
      !I_INSTITUTION_ID type EINRI
      !I_UNAME type XUBNAME default SY-UNAME
    exporting
      !ET_TC_MATRIX type RN1TC_MATRIX_T
    raising
      CX_ISHMED_TC_CUST
      CX_ISHMED_TC .
  methods CREATE_MATRIX_FOR_USER
    importing
      !I_INSTITUTION_ID type EINRI
      !I_UNAME type XUBNAME default SY-UNAME .
endinterface.
