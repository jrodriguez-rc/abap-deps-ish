*----------------------------------------------------------------------*
***INCLUDE LN1CUSTOMER_TYPESI01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  ext_check  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE ext_check INPUT.
  perform ext_check.
ENDMODULE.                 " ext_check  INPUT

*&---------------------------------------------------------------------*
*&      Module  id_check  INPUT
*&---------------------------------------------------------------------*
MODULE id_check INPUT.

  if n1customer_types-clsid > 0.
    if n1customer_types-idname is initial.
      MESSAGE E856(NF).
*     Name muß eingegeben werden
    endif.
  endif.

ENDMODULE.                 " id_check  INPUT

*&---------------------------------------------------------------------*
*&      Module  desc_check  INPUT
*&---------------------------------------------------------------------*
MODULE desc_check INPUT.

  if n1customer_types-clsid > 0.
    if n1customer_types-description is initial.
      MESSAGE E545(NF1).
*     Es muß ein Text eingegeben werden
    endif.
  endif.

ENDMODULE.                 " desc_check  INPUT

*&---------------------------------------------------------------------*
*&      Module  num_check  INPUT
*&---------------------------------------------------------------------*
MODULE num_check INPUT.

  if not n1customer_types-clsid CO '0123456789'.
    MESSAGE E035(N1BASE).
*   Geben Sie nur nummerische Werte ein
  endif.

ENDMODULE.                 " num_check  INPUT
