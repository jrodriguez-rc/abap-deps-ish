FUNCTION ISHMED_LSTCLASS_DEFAULT.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(I_EINRI) LIKE  TN01-EINRI
*"             VALUE(I_VWEND) OPTIONAL
*"       EXPORTING
*"             VALUE(E_NTPK) LIKE  NTPK STRUCTURE  NTPK
*"             VALUE(E_NTPT) LIKE  NTPT STRUCTURE  NTPT
*"             VALUE(E_N1TPM) LIKE  N1TPM STRUCTURE  N1TPM
*"----------------------------------------------------------------------

  CLEAR: E_NTPT, E_NTPK, E_N1TPM.
  PERFORM READ_GTARIF(SAPMN1PA) USING I_EINRI E_NTPK-TARIF.
*
  CASE I_VWEND.
    WHEN 'P'.
      E_NTPK-TALST = '?'.
      MOVE-CORRESPONDING E_NTPK TO E_NTPT.
      E_NTPT-KTXT1 = 'Sonstige Leistungen'(017).
    WHEN OTHERS.
      E_NTPK-TALST = '?'.
      MOVE-CORRESPONDING E_NTPK TO E_NTPT.
      E_NTPT-KTXT1 = 'Sonstige Leistungen'(017).
   ENDCASE.

ENDFUNCTION.
