FUNCTION ishmed_vm_fvar_copy.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_FVAR) TYPE  RNFVAR
*"     VALUE(I_POPUP) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_VIEWTYPE) TYPE  NVIEWTYPE
*"     VALUE(I_VIEWID) TYPE  NVIEWID OPTIONAL
*"     VALUE(I_FVAR_TEXT) TYPE  NWFVARTXT DEFAULT SPACE
*"     VALUE(I_COMMIT) TYPE  ISH_ON_OFF DEFAULT 'X'
*"     VALUE(I_UPDATE_TASK) TYPE  ISH_ON_OFF DEFAULT SPACE
*"  EXPORTING
*"     VALUE(E_FVAR) TYPE  RNFVAR
*"     VALUE(E_RC) TYPE  SY-SUBRC
*"     VALUE(E_CANCEL) TYPE  ISH_ON_OFF
*"  TABLES
*"      T_MESSAGES STRUCTURE  BAPIRET2 OPTIONAL
*"----------------------------------------------------------------------

  TYPES: tyt_nwfvar       TYPE STANDARD TABLE OF v_nwfvar,
         ty_nwfvar        TYPE LINE OF tyt_nwfvar,
         tyt_nwfvarp      TYPE STANDARD TABLE OF v_nwfvarp,
         ty_nwfvarp       TYPE LINE OF tyt_nwfvarp,
         tyt_nwbutton     TYPE STANDARD TABLE OF v_nwbutton,
         ty_nwbutton      TYPE LINE OF tyt_nwbutton.

  DATA: l_wa_msg          TYPE bapiret2,
        l_nwfvar          TYPE ty_nwfvar,
        l_nwfvarp         TYPE ty_nwfvarp,
        l_nwbutton        TYPE ty_nwbutton,
        l_key             LIKE rnwp_gen_key-nwkey,
        l_rc              TYPE sy-subrc,
        l_poptext         TYPE char50,
        l_poptext_new     TYPE char50,
        lt_nwfvar         TYPE tyt_nwfvar,
        lt_nwfvarp        TYPE tyt_nwfvarp,
        lt_nwbutton       TYPE tyt_nwbutton,
        lt_messages       TYPE TABLE OF bapiret2.

  CLEAR:   e_rc, e_fvar, e_cancel,
           l_rc, l_key, l_poptext, l_poptext_new,
           l_nwfvar, l_nwfvarp, l_nwbutton.
  REFRESH: lt_nwfvar, lt_nwfvarp, lt_nwbutton.

  IF i_fvar IS INITIAL.
    EXIT.
  ENDIF.

* does the function variant exist?
  SELECT SINGLE * FROM nwfvar INTO l_nwfvar
         WHERE  viewtype  = i_viewtype
         AND    fvar      = i_fvar-fvariantid.             "#EC ENHOK
  IF sy-subrc <> 0.
*   function variant not found
    PERFORM build_bapiret2(sapmn1pa)
            USING 'E' 'NF1' '356' i_fvar-fvariantid space space space
                  space space space
            CHANGING l_wa_msg.
    APPEND l_wa_msg TO t_messages.
    e_rc = 1.
    EXIT.
  ENDIF.

* read function variant data
  CALL FUNCTION 'ISHMED_VM_FVAR_GET'
    EXPORTING
      i_viewtype   = i_viewtype
      i_fvariantid = i_fvar-fvariantid
    IMPORTING
      e_rc         = l_rc
    TABLES
      t_fvar       = lt_nwfvar
      t_fvarp      = lt_nwfvarp
      t_button     = lt_nwbutton
      t_messages   = lt_messages.
  APPEND LINES OF lt_messages TO t_messages.
  IF l_rc <> 0.
    e_rc = 1.
    EXIT.
  ENDIF.

* popup to get new function variant text
  IF i_fvar_text IS INITIAL.                                " ID 10499
    READ TABLE lt_nwfvar INTO l_nwfvar INDEX 1.
    l_poptext = l_nwfvar-txt.
  ELSE.                                                     " ID 10499
    l_poptext = i_fvar_text.                                " ID 10499
    IF i_popup = off.                                       " ID 10499
      LOOP AT lt_nwfvar INTO l_nwfvar.                      " ID 10499
        l_nwfvar-txt = l_poptext.                           " ID 10499
        MODIFY lt_nwfvar FROM l_nwfvar.                     " ID 10499
      ENDLOOP.                                              " ID 10499
    ENDIF.                                                  " ID 10499
  ENDIF.                                                    " ID 10499
  IF i_popup = on.
    CALL FUNCTION 'ISHMED_VM_VARIANT_TEXT_POPUP'
      EXPORTING
        i_text  = l_poptext
        i_titel = 'Funktionsvariante kopieren'(007)
        i_type  = 'F'
      IMPORTING
        e_text  = l_poptext_new
      EXCEPTIONS
        cancel  = 1
        OTHERS  = 2.
    IF sy-subrc <> 0.
      e_cancel = on.
      EXIT.
    ENDIF.
    IF NOT l_poptext_new IS INITIAL.
      LOOP AT lt_nwfvar INTO l_nwfvar.
        l_nwfvar-txt = l_poptext_new.
        MODIFY lt_nwfvar FROM l_nwfvar.
      ENDLOOP.
    ELSE.
      EXIT.
    ENDIF.
  ENDIF.

* get new id
  CALL FUNCTION 'ISHMED_VM_GENERATE_KEY'
    EXPORTING
      i_key_type      = 'F'
      i_user_specific = off
      i_viewtype      = i_viewtype
    IMPORTING
      e_key           = l_key
      e_rc            = l_rc
    TABLES
      t_messages      = lt_messages.
  APPEND LINES OF lt_messages TO t_messages.
  IF l_rc <> 0.
*   error on generating key
    e_rc = 1.
    EXIT.
  ELSE.
    LOOP AT lt_nwfvar INTO l_nwfvar.
      l_nwfvar-fvar = l_key.
      MODIFY lt_nwfvar FROM l_nwfvar.
    ENDLOOP.
    LOOP AT lt_nwfvarp INTO l_nwfvarp.
      l_nwfvarp-fvar = l_key.
      MODIFY lt_nwfvarp FROM l_nwfvarp.
    ENDLOOP.
    LOOP AT lt_nwbutton INTO l_nwbutton.
      l_nwbutton-fvar = l_key.
      MODIFY lt_nwbutton FROM l_nwbutton.
    ENDLOOP.
  ENDIF.

* copy function variant (= save tables with new id)
  PERFORM save_fvar TABLES lt_nwfvar lt_nwfvarp lt_nwbutton
                    USING  i_update_task.

* function variant has been copied
  e_fvar = i_fvar.
  e_fvar-fvariantid = l_key.

* success message - function variant & has been copied
  PERFORM build_bapiret2(sapmn1pa)
       USING 'S' 'NF1' '681' l_poptext space space space
                space space space
       CHANGING l_wa_msg.
  APPEND l_wa_msg TO t_messages.

  IF i_commit = on.
    IF e_rc = 0.
      COMMIT WORK AND WAIT.
    ELSE.
      ROLLBACK WORK.                 "#EC CI_ROLLBACK
    ENDIF.
  ENDIF.

ENDFUNCTION.
