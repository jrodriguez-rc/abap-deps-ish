*"* components of interface IF_ISH_GET_CASE
interface IF_ISH_GET_CASE
  public .


  methods GET_CASE
    exporting
      value(E_FALNR) type NFAL-FALNR
      value(E_RC) type ISH_METHOD_RC
      value(ES_NFAL) type NFAL
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
endinterface.
