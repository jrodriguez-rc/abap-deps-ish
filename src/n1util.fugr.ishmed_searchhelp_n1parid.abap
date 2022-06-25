FUNCTION ISHMED_SEARCHHELP_N1PARID.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  TABLES
*"      SHLP_TAB TYPE  SHLP_DESCT
*"      RECORD_TAB STRUCTURE  SEAHLPRES
*"  CHANGING
*"     VALUE(SHLP) TYPE  SHLP_DESCR
*"     VALUE(CALLCONTROL) TYPE  DDSHF4CTRL
*"----------------------------------------------------------------------
* Fichte, MED-80454: Function created
  TYPES: BEGIN OF lty_f4,
           n1parid TYPE n1orgpar-n1parid,
           ddtext  TYPE dd07t-ddtext,
         END OF lty_f4.
  DATA: lt_f4     TYPE STANDARD TABLE OF lty_f4,
        ls_f4     TYPE lty_f4,
        lr_orgpar TYPE REF TO if_ishmed_orgpar,
        lt_dd07t  TYPE STANDARD TABLE OF dd07t,
        lt_clskey TYPE seo_clskeys,
        lt_selopt TYPE RANGE OF dd07t-domvalue_l,
        ls_selopt LIKE LINE OF lt_selopt.
  FIELD-SYMBOLS:
    <ls_dd07t>  TYPE dd07t,
    <ls_clskey> TYPE seoclskey.

* EXIT immediately, if you do not want to handle this step
  IF callcontrol-step <> 'SELONE' AND
     callcontrol-step <> 'SELECT' AND
     callcontrol-step <> 'DISP'.
    EXIT.
  ENDIF.

*"----------------------------------------------------------------------
* STEP SELONE  (Select one of the elementary searchhelps)
*"----------------------------------------------------------------------
* This step is only called for collective searchhelps. It may be used
* to reduce the amount of elementary searchhelps given in SHLP_TAB.
* The compound searchhelp is given in SHLP.
* If you do not change CALLCONTROL-STEP, the next step is the
* dialog, to select one of the elementary searchhelps.
* If you want to skip this dialog, you have to return the selected
* elementary searchhelp in SHLP and to change CALLCONTROL-STEP to
* either to 'PRESEL' or to 'SELECT'.
  IF callcontrol-step = 'SELONE'.
*   PERFORM SELONE .........
    EXIT.
  ENDIF.

*"----------------------------------------------------------------------
* STEP PRESEL  (Enter selection conditions)
*"----------------------------------------------------------------------
* This step allows you, to influence the selection conditions either
* before they are displayed or in order to skip the dialog completely.
* If you want to skip the dialog, you should change CALLCONTROL-STEP
* to 'SELECT'.
* Normaly only SHLP-SELOPT should be changed in this step.
  IF callcontrol-step = 'PRESEL'.
*   PERFORM PRESEL ..........
    EXIT.
  ENDIF.
*"----------------------------------------------------------------------
* STEP SELECT    (Select values)
*"----------------------------------------------------------------------
* This step may be used to overtake the data selection completely.
* To skip the standard seletion, you should return 'DISP' as following
* step in CALLCONTROL-STEP.
* Normally RECORD_TAB should be filled after this step.
* Standard function module F4UT_RESULTS_MAP may be very helpfull in this
* step.
  IF callcontrol-step = 'SELECT'.
    CLEAR: lt_f4[].
*   Parameters defined in the old way are defined in domain N1ORGPAR
    CLEAR: lt_dd07t[].

*   Consider a searchpattern entered in the fields
    CLEAR: lt_selopt[].
    LOOP AT shlp-selopt ASSIGNING FIELD-SYMBOL(<ls_selopt>).
      CLEAR: ls_selopt.
      ls_selopt-sign   = <ls_selopt>-sign.
      ls_selopt-option = <ls_selopt>-option.
      ls_selopt-low    = <ls_selopt>-low.
      ls_selopt-high   = <ls_selopt>-high.
      APPEND ls_selopt TO lt_selopt.
    ENDLOOP.

    SELECT * FROM dd07t INTO TABLE lt_dd07t
             WHERE domname    = 'N1PARID'
             AND   ddlanguage = sy-langu
             AND   domvalue_l IN lt_selopt.

    LOOP AT lt_dd07t ASSIGNING <ls_dd07t>.
*     Ignore value of interval since this is only there to not getting an
*     error when entering interface based values
*     This interval is defined from "A" to "Z_______".
      CHECK <ls_dd07t>-domvalue_l <> cl_ishmed_utl_n1orgpar=>c_orgpar_interval.

      CLEAR: ls_f4.
      ls_f4-n1parid = <ls_dd07t>-domvalue_l.
      ls_f4-ddtext  = <ls_dd07t>-ddtext.
      APPEND ls_f4 TO lt_f4.
    ENDLOOP.

*   Parameters defined in the new way (implementing interface IF_ISHMED_ORGPAR)
    CLEAR: lt_clskey[].
    lt_clskey = cl_ish_utl_rtti=>get_interface_implementations(
      EXPORTING
        i_interface_name  = cl_ishmed_utl_n1orgpar=>c_orgpar_intf_name
        i_with_subclasses = abap_true ).
    LOOP AT lt_clskey ASSIGNING <ls_clskey>.
      TRY.
          CREATE OBJECT lr_orgpar TYPE (<ls_clskey>-clsname).
        CATCH cx_root.
          CONTINUE.
      ENDTRY.

      CLEAR: ls_f4.
      ls_f4-n1parid = lr_orgpar->get_parid( ).
      ls_f4-ddtext  = lr_orgpar->get_parid_description( ).

*     Only continue if class has its own parameter name. If this class is a
*     superclass, then it might not have its own parameter name.
      CHECK ls_f4-n1parid IS NOT INITIAL.
*     Also check if this parameter matches the search pattern (like "N1ME*") which
*     the user might have entered
      CHECK ls_f4-n1parid IN lt_selopt.

      APPEND ls_f4 TO lt_f4.
    ENDLOOP.

    SORT lt_f4 BY n1parid.

    CALL FUNCTION 'F4UT_RESULTS_MAP'
      TABLES
        shlp_tab          = shlp_tab
        record_tab        = record_tab
        source_tab        = lt_f4
      CHANGING
        shlp              = shlp
        callcontrol       = callcontrol
      EXCEPTIONS
        illegal_structure = 1
        OTHERS            = 2.
*   IF RC = 0.
    callcontrol-step = 'DISP'.
*   ELSE.
*     CALLCONTROL-STEP = 'EXIT'.
*   ENDIF.
    EXIT. "Don't process STEP DISP additionally in this call.
  ENDIF.

*"----------------------------------------------------------------------
* STEP DISP     (Display values)
*"----------------------------------------------------------------------
* This step is called, before the selected data is displayed.
* You can e.g. modify or reduce the data in RECORD_TAB
* according to the users authority.
* If you want to get the standard display dialog afterwards, you
* should not change CALLCONTROL-STEP.
* If you want to overtake the dialog on you own, you must return
* the following values in CALLCONTROL-STEP:
* - "RETURN" if one line was selected. The selected line must be
*   the only record left in RECORD_TAB. The corresponding fields of
*   this line are entered into the screen.
* - "EXIT" if the values request should be aborted
* - "PRESEL" if you want to return to the selection dialog
* Standard function modules F4UT_PARAMETER_VALUE_GET and
* F4UT_PARAMETER_RESULTS_PUT may be very helpfull in this step.
  IF callcontrol-step = 'DISP'.
*   PERFORM AUTHORITY_CHECK TABLES RECORD_TAB SHLP_TAB
*                           CHANGING SHLP CALLCONTROL.
    EXIT.
  ENDIF.
ENDFUNCTION.
