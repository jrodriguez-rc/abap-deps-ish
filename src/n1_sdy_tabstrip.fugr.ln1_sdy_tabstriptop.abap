FUNCTION-POOL n1_sdy_tabstrip.              "MESSAGE-ID ..


* The one and only screen object.
DATA: gr_scr_tabstrip  TYPE REF TO cl_ish_scr_tabstrip.

* Controls
CONTROLS: ts_tabstrip_100  TYPE TABSTRIP,
          ts_tabstrip_101  TYPE TABSTRIP,
          ts_tabstrip_102  TYPE TABSTRIP,
          ts_tabstrip_103  TYPE TABSTRIP,
          ts_tabstrip_104  TYPE TABSTRIP,
          ts_tabstrip_105  TYPE TABSTRIP,
          ts_tabstrip_106  TYPE TABSTRIP,
          ts_tabstrip_107  TYPE TABSTRIP,
          ts_tabstrip_108  TYPE TABSTRIP,
          ts_tabstrip_109  TYPE TABSTRIP,
          ts_tabstrip_110  TYPE TABSTRIP,
          ts_tabstrip_111  TYPE TABSTRIP,
          ts_tabstrip_112  TYPE TABSTRIP,
          ts_tabstrip_113  TYPE TABSTRIP,
          ts_tabstrip_114  TYPE TABSTRIP,
          ts_tabstrip_115  TYPE TABSTRIP,
          ts_tabstrip_116  TYPE TABSTRIP,
          ts_tabstrip_117  TYPE TABSTRIP,
          ts_tabstrip_118  TYPE TABSTRIP,
          ts_tabstrip_119  TYPE TABSTRIP.
CONTROLS: tspb_tab1        TYPE TABSTRIP,
          tspb_tab2        TYPE TABSTRIP,
          tspb_tab3        TYPE TABSTRIP,
          tspb_tab4        TYPE TABSTRIP,
          tspb_tab5        TYPE TABSTRIP,
          tspb_tab6        TYPE TABSTRIP,
          tspb_tab7        TYPE TABSTRIP,
          tspb_tab8        TYPE TABSTRIP,
          tspb_tab9        TYPE TABSTRIP,
          tspb_tab10       TYPE TABSTRIP,
          tspb_tab11       TYPE TABSTRIP,
          tspb_tab12       TYPE TABSTRIP,
          tspb_tab13       TYPE TABSTRIP,
          tspb_tab14       TYPE TABSTRIP,
          tspb_tab15       TYPE TABSTRIP,
          tspb_tab16       TYPE TABSTRIP,
          tspb_tab17       TYPE TABSTRIP,
          tspb_tab18       TYPE TABSTRIP,
          tspb_tab19       TYPE TABSTRIP,
          tspb_tab20       TYPE TABSTRIP.

* SC_TABSTRIP
DATA: g_dynpg_subscreen  TYPE sy-repid VALUE 'SAPLN1SC',
      g_dynnr_subscreen  TYPE sy-dynnr VALUE '0001'.
