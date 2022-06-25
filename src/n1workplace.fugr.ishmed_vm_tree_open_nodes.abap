FUNCTION ishmed_vm_tree_open_nodes.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_VIEW) TYPE  NWVIEW
*"     VALUE(I_PLACE) TYPE  NWPLACE
*"     VALUE(I_OPEN_NODES) TYPE  N_OPEN_NODES OPTIONAL
*"  EXPORTING
*"     VALUE(E_RC) LIKE  SY-SUBRC
*"     VALUE(E_OPEN_NODES) TYPE  N_OPEN_NODES
*"----------------------------------------------------------------------

  DATA: l_rc          LIKE sy-subrc,
        l_v_nwview    LIKE v_nwview.

  CLEAR: e_rc, e_open_nodes, g_title_0100,
         l_v_nwview, l_rc, g_100_open_nodes.

* Nur für Sichttypen mit ALV-Tree
  IF i_view-viewtype <> '004'.
    e_rc = 1.
    EXIT.
  ENDIF.

  g_100_viewtype = i_view-viewtype.

* Zuordnungs- oder Sichtbezeichnung für Popup-Titel lesen
  CALL FUNCTION 'ISHMED_VM_READ_VIEW_DATA'
    EXPORTING
      i_viewid    = i_view-viewid
      i_viewtype  = i_view-viewtype
      i_caller    = 'LN1WORKPLACEU05'
      i_placeid   = i_place-wplaceid
      i_placetype = i_place-wplacetype
    IMPORTING
      e_rc        = l_rc
      e_view      = l_v_nwview.
  IF l_rc <> 0 OR l_v_nwview-txt IS INITIAL.
    g_title_0100 = 'Offene Knoten festlegen'(002).
  ELSE.
    g_title_0100 = l_v_nwview-txt.
  ENDIF.

  IF i_view-viewtype = '004'.
    PERFORM open_nodes_004_specific USING i_view i_place.
  ENDIF.

  g_100_open_nodes = i_open_nodes.

  CALL SCREEN 100 STARTING AT 40 10
                  ENDING   AT 85 12.

  IF g_save_ok_code = 'ENTR'.
    e_open_nodes = g_100_open_nodes.
  ELSE.
    e_rc = 2.          " Cancel
  ENDIF.

ENDFUNCTION.
