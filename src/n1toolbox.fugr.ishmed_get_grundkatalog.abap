FUNCTION ISHMED_GET_GRUNDKATALOG.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"       IMPORTING
*"             VALUE(EINRI) LIKE  NTPT-EINRI
*"       EXPORTING
*"             VALUE(KAT) LIKE  NTPT-TARIF
*"----------------------------------------------------------------------

  DATA: KATA(10).
  DATA: NU TYPE I.

  PERFORM REN00Q_TIME(SAPMNPA0) USING EINRI 'GTARIF' SY-DATUM KATA.
  NU = STRLEN( KATA ) - 2.
  SHIFT KATA LEFT BY NU PLACES.
  KAT = KATA.

ENDFUNCTION.
