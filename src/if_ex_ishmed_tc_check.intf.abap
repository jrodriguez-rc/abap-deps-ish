*"* components of interface IF_EX_ISHMED_TC_CHECK
interface IF_EX_ISHMED_TC_CHECK
  public .


  interfaces IF_BADI_INTERFACE .

  methods CHECK
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_ID type PATNR
      !I_CASE_ID type FALNR optional
      !IT_MATRIX type RN1TC_MATRIX_T
    exporting
      !E_TC_REQUEST_POSSIBLE type ISH_TRUE_FALSE
      !E_TC_EXIST type ISH_TRUE_FALSE
      !E_RESP_TYPE type N1TC_OU_RESP_TYPE .
  methods CHECK_PATIENT_PROVISIONAL
    importing
      !I_INSTITUTION_ID type EINRI
      !I_PATIENT_PROVISIONAL_ID type ISH_PAPID
      !IT_MATRIX type RN1TC_MATRIX_T
    exporting
      !E_TC_EXIST type ISH_TRUE_FALSE .
endinterface.
