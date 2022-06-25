*----------------------------------------------------------------------*
***INCLUDE LN1WORKPLACEO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  init_cua  OUTPUT
*&---------------------------------------------------------------------*
module init_cua output.

  set pf-status '0100'.
  set titlebar  '0100' with g_title_0100.

  perform fill_lb_open_nodes using 'G_100_OPEN_NODES' g_100_viewtype
                                                      g_100_act004.

endmodule.                 " init_cua  OUTPUT
