FUNCTION ishmed_doku_get_prcode.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_LANGU) LIKE  SY-LANGU DEFAULT SY-LANGU
*"  EXPORTING
*"     VALUE(LFDBEW) LIKE  NDOC-LFDBEW
*"  TABLES
*"      I_NDOC STRUCTURE  NDOC
*"      I_TN2FLAG STRUCTURE  TN2FLAG
*"  EXCEPTIONS
*"      NOT_FOUND
*"----------------------------------------------------------------------

  DATA: h_tn2flag   LIKE TABLE OF tn2flag WITH HEADER LINE,
        h_ndoc      LIKE TABLE OF ndoc    WITH HEADER LINE.

  CLEAR i_tn2flag. REFRESH i_tn2flag.
  CLEAR h_tn2flag. REFRESH h_tn2flag.
  CLEAR h_ndoc.    REFRESH h_ndoc.

  h_ndoc[] = i_ndoc[].

* ID 11879: at first delete duplicate documents (older versions!)
  SORT h_ndoc BY dokar ASCENDING doknr ASCENDING dokvr DESCENDING.
  DELETE ADJACENT DUPLICATES FROM h_ndoc COMPARING dokar doknr.

  SORT h_ndoc BY einri pcode.
  DELETE ADJACENT DUPLICATES FROM h_ndoc COMPARING einri pcode.

  DELETE h_ndoc WHERE pcode IS initial.

  DESCRIBE TABLE h_ndoc.
  CHECK sy-tfill > 0.

  SELECT * FROM tn2flag INTO TABLE h_tn2flag
           FOR ALL ENTRIES IN h_ndoc
           WHERE einri  = h_ndoc-einri
           AND   flagid = h_ndoc-pcode.

  SORT h_tn2flag DESCENDING BY prio.
  READ TABLE h_tn2flag INDEX 1.
  i_tn2flag = h_tn2flag.
  APPEND i_tn2flag.

ENDFUNCTION.
