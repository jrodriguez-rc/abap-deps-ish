*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: N1CUSTOMER_TYPES................................*
DATA:  BEGIN OF STATUS_N1CUSTOMER_TYPES              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_N1CUSTOMER_TYPES              .
CONTROLS: TCTRL_N1CUSTOMER_TYPES
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *N1CUSTOMER_TYPES              .
TABLES: N1CUSTOMER_TYPES               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
