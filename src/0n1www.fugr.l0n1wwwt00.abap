*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: N1WWW...........................................*
DATA:  BEGIN OF STATUS_N1WWW                         .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_N1WWW                         .
CONTROLS: TCTRL_N1WWW
            TYPE TABLEVIEW USING SCREEN '0100'.
*.........table declarations:.................................*
TABLES: *N1WWW                         .
TABLES: N1WWW                          .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
