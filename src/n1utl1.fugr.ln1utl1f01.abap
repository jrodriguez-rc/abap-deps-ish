*----------------------------------------------------------------------*
***INCLUDE LN1UTL1F01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  ENQ_GUSR_GET_WP
*&---------------------------------------------------------------------*
*       extract the workprocess number from enqueue owner id.
*       if the wp-nr in the enqueue owner id exceeds 99, the resulting
*       numeric wp-nr is set to 99.
*----------------------------------------------------------------------*
*  -->  user  enqueue owner id
*  <->  wp    workprocess-nr
*----------------------------------------------------------------------*
FORM enq_gusr_get_wp USING user TYPE eqeusr CHANGING wp TYPE eqewp.

  DATA: wp_c(2).

  wp_c = user+22(2).

  IF wp_c+0(1) BETWEEN '0' AND '9' AND
     wp_c+1(1) BETWEEN '0' AND '9'.
    wp = wp_c.
  ELSE.
    wp = 99.
  ENDIF.

ENDFORM.                    " SEQG3_GET_WP
