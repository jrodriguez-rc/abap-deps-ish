*"* components of interface IF_ISH_GET_PATIENT
interface IF_ISH_GET_PATIENT
  public .


  methods GET_PATIENT
    exporting
      value(E_PATNR) type NPAT-PATNR
      value(E_PAPID) type NPAP-PAPID
      !ER_PAP type ref to CL_ISH_PATIENT_PROVISIONAL
      value(E_RC) type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
