*----------------------------------------------------------------------*
***INCLUDE LZMEIKI_COMPCONF01 .
*----------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  exit_0100
*&---------------------------------------------------------------------*
*       ExitCommand on dynpro 0100.
*----------------------------------------------------------------------*
FORM exit_0100 .

  LEAVE TO SCREEN 0.

ENDFORM.                                                    " exit_0100


*&---------------------------------------------------------------------*
*&      Form pbo_0100
*&---------------------------------------------------------------------*
*       PBO for dynpro 0100.
*----------------------------------------------------------------------*
FORM pbo_0100 .

  DATA: l_maxty        TYPE ish_bapiretmaxty,
        l_send_if_one  TYPE c.

  CLEAR g_ucomm.

  SET TITLEBAR '0100' WITH sy-uname.

  SET PF-STATUS '0100'.

  IF gt_obtyp IS INITIAL.
    PERFORM create_t_obtyp.
    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING
        id              = 'GS_DYNP_0100-OBTYP'
        values          = gt_obtyp
      EXCEPTIONS
        id_illegal_name = 1
        OTHERS          = 2.
  ENDIF.

  IF gt_compid IS INITIAL.
    PERFORM create_t_compid.
    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING
        id              = 'GS_DYNP_0100-COMPID'
        values          = gt_compid
      EXCEPTIONS
        id_illegal_name = 1
        OTHERS          = 2.
    READ TABLE gt_compid
      WITH KEY key = gs_dynp_0100-compid
      TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      CLEAR gs_dynp_0100-compid.
    ENDIF.
  ENDIF.

  IF gt_compconid IS INITIAL.
    PERFORM create_t_compconid.
    CALL FUNCTION 'VRM_SET_VALUES'
      EXPORTING
        id              = 'GS_DYNP_0100-COMPCONID'
        values          = gt_compconid
      EXCEPTIONS
        id_illegal_name = 1
        OTHERS          = 2.
    READ TABLE gt_compconid
      WITH KEY key = gs_dynp_0100-compconid
      TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      CLEAR gs_dynp_0100-compconid.
    ENDIF.
  ENDIF.

  LOOP AT SCREEN.
    CASE screen-name.
      WHEN 'PB_UPDATE' OR
           'PB_DELETE'.
        IF gs_dynp_0100-compconid IS INITIAL.
          screen-input = 0.
        ENDIF.
      WHEN 'PB_INSERT'.
        IF gs_dynp_0100-new_compconid IS INITIAL.
          screen-input = 0.
        ENDIF.
      WHEN 'GS_DYNP_0100-NEW_COMPCONID' OR
           'GS_DYNP_0100-NEW_NAME'.
        IF gs_dynp_0100-compid IS INITIAL.
          screen-input = 0.
        ENDIF.
      WHEN OTHERS.
        CONTINUE.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.

  IF gr_errorhandler IS BOUND.
    CALL METHOD gr_errorhandler->get_max_errortype
      IMPORTING
        e_maxty = l_maxty.
    IF l_maxty = 'S'.
      l_send_if_one = 'X'.
    ELSE.
      l_send_if_one = '*'.
    ENDIF.
    CALL METHOD gr_errorhandler->display_messages
      EXPORTING
        i_send_if_one = l_send_if_one.
  ENDIF.

ENDFORM.                                                    " pbo_0100


*&---------------------------------------------------------------------*
*&      Form create_t_obtyp
*&---------------------------------------------------------------------*
*       Create gt_obtyp.
*----------------------------------------------------------------------*
FORM create_t_obtyp .

  CLEAR gt_obtyp.

  CHECK cl_ish_utl_system=>is_sap_system( ) = 'X'.

  SELECT DISTINCT obtyp                                 "#EC CI_NOWHERE
    FROM n1compdefa
    INTO TABLE gt_obtyp.

ENDFORM.                                              " create_t_obtyp


*&---------------------------------------------------------------------*
*&      Form create_t_compid
*&---------------------------------------------------------------------*
*       Create gt_compid.
*----------------------------------------------------------------------*
FORM create_t_compid .

  CLEAR gt_compid.

  SELECT DISTINCT compid                                "#EC CI_NOFIRST
    FROM n1compdefa
    INTO TABLE gt_compid
    WHERE obtyp = gs_dynp_0100-obtyp.

ENDFORM.                                             " create_t_compid


*&---------------------------------------------------------------------*
*&      Form create_t_compconid
*&---------------------------------------------------------------------*
*       Create gt_compconid.
*----------------------------------------------------------------------*
FORM create_t_compconid .

  CLEAR gt_compconid.

  CHECK NOT gs_dynp_0100-compid IS INITIAL.

  SELECT DISTINCT compconid
    FROM n1compcon
    INTO TABLE gt_compconid
    WHERE obtyp  = gs_dynp_0100-obtyp
      AND compid = gs_dynp_0100-compid.

ENDFORM.                                         " create_t_compconid


*&---------------------------------------------------------------------*
*&      Form pai_0100
*&---------------------------------------------------------------------*
*       PAI for dynpro 0100.
*----------------------------------------------------------------------*
FORM pai_0100 .

  DATA: l_cancelled  TYPE ish_on_off,
        l_rc         TYPE ish_method_rc.

* Michael Manoch, 10.10.2006, MED-9592   START
* Add transport functionality.
  DATA: ls_n1compcon  TYPE n1compcon,
        ls_n1compcont TYPE n1compcont.
* Michael Manoch, 10.10.2006, MED-9592   END

  IF gr_errorhandler IS BOUND.
    CALL METHOD gr_errorhandler->initialize.
  ENDIF.

  CASE g_ucomm.
    WHEN 'EXIT' OR
         'BACK'.
      LEAVE TO SCREEN 0.
      EXIT.
    WHEN 'LBX_OBTYP'.
      CLEAR gt_compid.
    WHEN 'LBX_COMPID'.
      CLEAR gt_compconid.
    WHEN 'PB_INSERT'.
      PERFORM insert_compcon
                  CHANGING
                     l_cancelled
                     l_rc.
*     Michael Manoch, 10.10.2006   START
*     Refresh the available compcons after insert.
      IF l_rc = 0.
        CLEAR gt_compconid.
      ENDIF.
*     Michael Manoch, 10.10.2006   END
    WHEN 'PB_UPDATE'.
      PERFORM update_compcon
                  CHANGING
                     l_cancelled
                     l_rc.
    WHEN 'PB_DELETE'.
      PERFORM delete_compcon
                  CHANGING
                     l_rc.
      IF l_rc = 0.
        CLEAR gt_compconid.
      ENDIF.
*   Michael Manoch, 10.10.2006, MED-9592   START
*   Add transport functionality.
    WHEN 'PB_TRANS'.
      PERFORM read_compcon_data
                  CHANGING
                     ls_n1compcon
                     ls_n1compcont
                     l_rc.
      CHECK l_rc = 0.
      PERFORM transport_compcon
                  USING
                     ls_n1compcon
                     ls_n1compcont
                  CHANGING
                     l_rc.
*   Michael Manoch, 10.10.2006, MED-9592   END
  ENDCASE.

ENDFORM.                                                    " pai_0100


*&---------------------------------------------------------------------*
*&      Form  read_compcon_data
*&---------------------------------------------------------------------*
*       Read compcon data.
*----------------------------------------------------------------------*
FORM read_compcon_data
       CHANGING ps_n1compcon  TYPE n1compcon
                ps_n1compcont TYPE n1compcont
                p_rc          TYPE ish_method_rc.

  SELECT SINGLE *
    FROM n1compcon
    INTO ps_n1compcon
    WHERE compconid = gs_dynp_0100-compconid.
  p_rc = sy-subrc.
  IF p_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '068'
        i_mv1           = gs_dynp_0100-compconid
      CHANGING
        cr_errorhandler = gr_errorhandler.
    EXIT.
  ENDIF.

* Read the corresponding n1compcont entry.
  SELECT SINGLE *
    FROM n1compcont
    INTO ps_n1compcont
    WHERE compconid = gs_dynp_0100-compconid
      AND spras     = sy-langu.
  p_rc = sy-subrc.
  IF p_rc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '068'
        i_mv1           = gs_dynp_0100-compconid
      CHANGING
        cr_errorhandler = gr_errorhandler.
    EXIT.
  ENDIF.

ENDFORM.                                          " read_compcon_data


*&---------------------------------------------------------------------*
*&      Form  show_popup
*&---------------------------------------------------------------------*
*       Show popup
*----------------------------------------------------------------------*
FORM show_popup
       USING    p_vcode       TYPE tndym-vcode
       CHANGING ps_n1compcon  TYPE n1compcon
                ps_n1compcont TYPE n1compcont
                p_cancelled   TYPE ish_on_off
                p_rc          TYPE ish_method_rc.

  DATA: lr_compdef        TYPE REF TO cl_ish_compdef,
        lr_comp           TYPE REF TO if_ish_component_base,
        lr_compcon        TYPE REF TO if_ish_component_config,
        lr_screen         TYPE REF TO if_ish_screen,
        lr_xml_document   TYPE REF TO if_ixml_document,
        l_popup_title     TYPE char70.

* Get the component.
  DO 1 TIMES.
    CALL METHOD cl_ish_compdef=>get_compdef
      EXPORTING
        i_obtyp    = ps_n1compcon-obtyp
        i_compid   = ps_n1compcon-compid
      IMPORTING
        er_compdef = lr_compdef.
    CHECK lr_compdef IS BOUND.
    CALL METHOD lr_compdef->get_component_base
      EXPORTING
        i_vcode         = p_vcode
        i_refresh       = 'X'
      IMPORTING
        er_component    = lr_comp
        e_rc            = p_rc
      CHANGING
        cr_errorhandler = gr_errorhandler.
    CHECK p_rc = 0.
  ENDDO.
  CHECK p_rc = 0.
  IF NOT lr_comp IS BOUND.
    p_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '033'
        i_mv1           = ps_n1compcon-compid
      CHANGING
        cr_errorhandler = gr_errorhandler.
    EXIT.
  ENDIF.

* Get the component's configuration.
  lr_compcon = lr_comp->get_component_config( ).
  IF NOT lr_compcon IS BOUND.
    CALL METHOD lr_comp->destroy.
    p_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '069'
        i_mv1           = ps_n1compcon-compid
      CHANGING
        cr_errorhandler = gr_errorhandler.
    EXIT.
  ENDIF.

* Get the compcon's screen.
  lr_screen = lr_compcon->get_screen( ).
  IF NOT lr_screen IS BOUND.
    CALL METHOD lr_comp->destroy.
    p_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '070'
        i_mv1           = ps_n1compcon-compconid
      CHANGING
        cr_errorhandler = gr_errorhandler.
    EXIT.
  ENDIF.

* Create the xml_document.
  CLEAR lr_xml_document.
  IF NOT ps_n1compcon-xml_data IS INITIAL.
    CALL FUNCTION 'SDIXML_XML_TO_DOM'
      EXPORTING
        xml           = ps_n1compcon-xml_data
      IMPORTING
        document      = lr_xml_document
      EXCEPTIONS
        invalid_input = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      CLEAR lr_xml_document.
    ENDIF.
    IF NOT lr_xml_document IS BOUND.
      CALL METHOD lr_comp->destroy.
      p_rc = 1.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '068'
          i_mv1           = ps_n1compcon-compconid
        CHANGING
          cr_errorhandler = gr_errorhandler.
      EXIT.
    ENDIF.
  ENDIF.

* Set the compcon's xml_document.
  IF lr_xml_document IS BOUND.
    CALL METHOD lr_compcon->set_data_by_xml_document
      EXPORTING
        ir_xml_document = lr_xml_document
      IMPORTING
        e_rc            = p_rc
      CHANGING
        cr_errorhandler = gr_errorhandler.
    IF p_rc <> 0.
      CALL METHOD lr_comp->destroy.
      EXIT.
    ENDIF.
  ENDIF.

* Build the popup title.
  l_popup_title = sy-uname.
  IF NOT ps_n1compcon-compconid IS INITIAL.
    CONCATENATE l_popup_title
                ': '
                ps_n1compcon-compconid
           INTO l_popup_title.
  ENDIF.

* Run the popup dialog.
  CALL METHOD lr_compcon->show_popup
    EXPORTING
      i_popup_title   = l_popup_title
      i_vcode         = p_vcode
    IMPORTING
      e_cancelled     = p_cancelled
      e_rc            = p_rc
    CHANGING
      cr_errorhandler = gr_errorhandler.
  IF p_rc <> 0 OR
     p_cancelled = 'X'.
    CALL METHOD lr_comp->destroy.
    EXIT.
  ENDIF.

* Get the xml_document.
  CALL METHOD lr_compcon->as_xml_document
    IMPORTING
      er_xml_document = lr_xml_document
      e_rc            = p_rc
    CHANGING
      cr_errorhandler = gr_errorhandler.
  IF p_rc <> 0.
    CALL METHOD lr_comp->destroy.
    EXIT.
  ENDIF.

* Stringify the xml_document.
  CALL FUNCTION 'SDIXML_DOM_TO_XML'
    EXPORTING
      document      = lr_xml_document
    IMPORTING
      xml_as_string = ps_n1compcon-xml_data
    EXCEPTIONS
      no_document   = 1
      OTHERS        = 2.
  p_rc = sy-subrc.

  CALL METHOD lr_comp->destroy.

ENDFORM.                                          " show_popup


*&---------------------------------------------------------------------*
*&      Form  insert_compcon
*&---------------------------------------------------------------------*
*       Insert component config.
*----------------------------------------------------------------------*
FORM insert_compcon
       CHANGING p_cancelled  TYPE ish_on_off
                p_rc         TYPE ish_method_rc.

  DATA: ls_n1compcon  TYPE n1compcon,
        ls_n1compcont TYPE n1compcont.

  SELECT SINGLE *
    FROM n1compcon
    INTO ls_n1compcon
    WHERE compconid = gs_dynp_0100-new_compconid.
  IF sy-subrc = 0.
    p_rc = 1.
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '071'
        i_mv1           = gs_dynp_0100-new_compconid
      CHANGING
        cr_errorhandler = gr_errorhandler.
    EXIT.
  ENDIF.

  CLEAR ls_n1compcon.
  ls_n1compcon-compconid = gs_dynp_0100-new_compconid.
  ls_n1compcon-obtyp     = gs_dynp_0100-obtyp.
  ls_n1compcon-compid    = gs_dynp_0100-compid.

  CLEAR ls_n1compcont.
  MOVE-CORRESPONDING ls_n1compcon TO ls_n1compcont.
  ls_n1compcont-spras = sy-langu.
  ls_n1compcont-name  = gs_dynp_0100-new_name.

  PERFORM show_popup
              USING
                 'INS'
              CHANGING
                 ls_n1compcon
                 ls_n1compcont
                 p_cancelled
                 p_rc.
  CHECK p_rc = 0.
  CHECK p_cancelled = space.

  INSERT INTO n1compcon VALUES ls_n1compcon.
  p_rc = sy-subrc.
  IF p_rc = 0.
    INSERT INTO n1compcont VALUES ls_n1compcont.
    p_rc = sy-subrc.
  ENDIF.
  IF p_rc = 0.
    COMMIT WORK AND WAIT.
    p_rc = sy-subrc.
  ELSE.
    ROLLBACK WORK.
  ENDIF.
  CHECK p_rc = 0.

  CALL METHOD cl_ish_utl_base=>collect_messages
    EXPORTING
      i_typ           = 'S'
      i_kla           = 'N1BASE'
      i_num           = '072'
      i_mv1           = gs_dynp_0100-new_compconid
    CHANGING
      cr_errorhandler = gr_errorhandler.

* Michael Manoch, 10.10.2006, MED-9592   START
* Add transport functionality.
  PERFORM transport_compcon
              USING
                 ls_n1compcon
                 ls_n1compcont
              CHANGING
                 p_rc.
* Michael Manoch, 10.10.2006, MED-9592   END

ENDFORM.                    " insert_compcon


*&---------------------------------------------------------------------*
*&      Form  update_compcon
*&---------------------------------------------------------------------*
*       Update component config.
*----------------------------------------------------------------------*
FORM update_compcon
       CHANGING p_cancelled  TYPE ish_on_off
                p_rc         TYPE ish_method_rc.

  DATA: ls_n1compcon  TYPE n1compcon,
        ls_n1compcont TYPE n1compcont.

  PERFORM read_compcon_data
              CHANGING
                 ls_n1compcon
                 ls_n1compcont
                 p_rc.
  CHECK p_rc = 0.

* Enqueue (MED-34335)
  CALL FUNCTION 'ENQUEUE_EN1COMPCON'
    EXPORTING
      compconid      = ls_n1compcon-compconid
      x_compconid    = abap_on
    EXCEPTIONS
      foreign_lock   = 1
      system_failure = 2
      OTHERS         = 3.

  CASE sy-subrc.
    WHEN  0.
    WHEN  1.
*     Already locked.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '154'
          i_mv1           = ls_n1compcon-compconid
          i_mv2           = sy-msgv1
        CHANGING
          cr_errorhandler = gr_errorhandler.
      p_rc = 1.
    WHEN OTHERS.
*     Any locking error.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '155'
          i_mv1           = ls_n1compcon-compconid
        CHANGING
          cr_errorhandler = gr_errorhandler.
      p_rc = 1.
  ENDCASE.
  CHECK p_rc = 0.

  PERFORM show_popup
              USING
                 'UPD'
              CHANGING
                 ls_n1compcon
                 ls_n1compcont
                 p_cancelled
                 p_rc.

* Dequeue (MED-34335)
  CALL FUNCTION 'DEQUEUE_EN1COMPCON'
    EXPORTING
      compconid   = ls_n1compcon-compconid
      x_compconid = abap_on.

  CHECK p_rc = 0.
  CHECK p_cancelled = space.

  UPDATE n1compcon FROM ls_n1compcon.
  p_rc = sy-subrc.
  IF p_rc = 0.
    UPDATE n1compcont FROM ls_n1compcont.
    p_rc = sy-subrc.
  ENDIF.
  IF p_rc = 0.
    COMMIT WORK AND WAIT.
    p_rc = sy-subrc.
  ELSE.
    ROLLBACK WORK.
  ENDIF.
  CHECK p_rc = 0.

  CALL METHOD cl_ish_utl_base=>collect_messages
    EXPORTING
      i_typ           = 'S'
      i_kla           = 'N1BASE'
      i_num           = '073'
      i_mv1           = gs_dynp_0100-compconid
    CHANGING
      cr_errorhandler = gr_errorhandler.

* Michael Manoch, 10.10.2006, MED-9592   START
* Add transport functionality.
  PERFORM transport_compcon
              USING
                 ls_n1compcon
                 ls_n1compcont
              CHANGING
                 p_rc.
* Michael Manoch, 10.10.2006, MED-9592   END

ENDFORM.                    " update_compcon


*&---------------------------------------------------------------------*
*&      Form  delete_compcon
*&---------------------------------------------------------------------*
*       Delete component config.
*----------------------------------------------------------------------*
FORM delete_compcon
       CHANGING p_rc         TYPE ish_method_rc.

* Michael Manoch, 10.10.2006, MED-9592   START
* Add transport functionality.
  DATA: ls_n1compcon   TYPE n1compcon,
        ls_n1compcont  TYPE n1compcont.

  PERFORM read_compcon_data
              CHANGING
                 ls_n1compcon
                 ls_n1compcont
                 p_rc.
  CHECK p_rc = 0.
* Michael Manoch, 10.10.2006, MED-9592   END

* Enqueue (MED-34335)
  CALL FUNCTION 'ENQUEUE_EN1COMPCON'
    EXPORTING
      compconid      = gs_dynp_0100-compconid
      x_compconid    = abap_on
    EXCEPTIONS
      foreign_lock   = 1
      system_failure = 2
      OTHERS         = 3.

  CASE sy-subrc.
    WHEN  0.
    WHEN  1.
*     Already locked.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '154'
          i_mv1           = gs_dynp_0100-compconid
          i_mv2           = sy-msgv1
        CHANGING
          cr_errorhandler = gr_errorhandler.
      p_rc = 1.
    WHEN OTHERS.
*     Any locking error.
      CALL METHOD cl_ish_utl_base=>collect_messages
        EXPORTING
          i_typ           = 'E'
          i_kla           = 'N1BASE'
          i_num           = '155'
          i_mv1           = gs_dynp_0100-compconid
        CHANGING
          cr_errorhandler = gr_errorhandler.
      p_rc = 1.
  ENDCASE.
  CHECK p_rc = 0.

  DELETE FROM n1compcon
    WHERE compconid = gs_dynp_0100-compconid.
  p_rc = sy-subrc.

* Dequeue (MED-34335)
  CALL FUNCTION 'DEQUEUE_EN1COMPCON'
    EXPORTING
      compconid   = gs_dynp_0100-compconid
      x_compconid = abap_on.

  IF p_rc = 0.
    DELETE FROM n1compcont
      WHERE compconid = gs_dynp_0100-compconid.
    p_rc = sy-subrc.
  ENDIF.
  IF p_rc = 0.
    COMMIT WORK AND WAIT.
    p_rc = sy-subrc.
  ELSE.
    ROLLBACK WORK.
  ENDIF.
  CHECK p_rc = 0.

  CALL METHOD cl_ish_utl_base=>collect_messages
    EXPORTING
      i_typ           = 'S'
      i_kla           = 'N1BASE'
      i_num           = '074'
      i_mv1           = gs_dynp_0100-compconid
    CHANGING
      cr_errorhandler = gr_errorhandler.

* Michael Manoch, 10.10.2006, MED-9592   START
* Add transport functionality.
  PERFORM transport_compcon
              USING
                 ls_n1compcon
                 ls_n1compcont
              CHANGING
                 p_rc.
* Michael Manoch, 10.10.2006, MED-9592   END

ENDFORM.                    " delete_compcon


* Michael Manoch, 10.10.2006, MED-9592   START
* Add transport functionality.
*&---------------------------------------------------------------------*
*&      Form  transport_compcon
*&---------------------------------------------------------------------*
*       Transport component config.
*----------------------------------------------------------------------*
FORM transport_compcon
       USING    ps_n1compcon   TYPE n1compcon
                ps_n1compcont  TYPE n1compcont
       CHANGING p_rc           TYPE ish_method_rc.

  DATA: BEGIN OF ls_n1compcon_key,
          mandt      TYPE n1compcon-mandt,
          compconid  TYPE n1compcon-compconid,
        END OF ls_n1compcon_key.

  DATA: BEGIN OF ls_n1compcont_key,
          mandt      TYPE n1compcont-mandt,
          compconid  TYPE n1compcont-compconid,
          spras      TYPE n1compcont-spras,
        END OF ls_n1compcont_key.

  DATA: l_trkorr  TYPE trkorr,
        lt_obj    TYPE tr_objects,
        ls_obj    LIKE LINE OF lt_obj,
        lt_key    TYPE tr_keys,
        ls_key    LIKE LINE OF lt_key.

* Initializations.
  p_rc = 0.

* Run popup for transport order.
  CALL FUNCTION 'TR_ORDER_CHOICE_CORRECTION'
    EXPORTING
      iv_category            = 'SYST'
      iv_cli_dep             = 'X'
    IMPORTING
      ev_task                = l_trkorr
    EXCEPTIONS
      invalid_category       = 1
      no_correction_selected = 2
      OTHERS                 = 3.
  CASE sy-subrc.
    WHEN 0.
    WHEN 2.
      RETURN.
    WHEN OTHERS.
      CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
        CHANGING
          cr_errorhandler = gr_errorhandler.
      p_rc = 1.
      RETURN.
  ENDCASE.
  CHECK l_trkorr IS NOT INITIAL.

* Build n1compcon obj.
  CLEAR: ls_obj.
  ls_obj-pgmid    = 'R3TR'.
  ls_obj-object   = 'TABU'.
  ls_obj-objfunc  = 'K'.
  ls_obj-obj_name = 'N1COMPCON'.
  APPEND ls_obj TO lt_obj.

* Build n1compcont obj.
  CLEAR: ls_obj.
  ls_obj-pgmid    = 'R3TR'.
  ls_obj-object   = 'TABU'.
  ls_obj-objfunc  = 'K'.
  ls_obj-obj_name = 'N1COMPCONT'.
  APPEND ls_obj TO lt_obj.

* Build n1compcon key.
  CLEAR: ls_key,
         ls_n1compcon_key.
  MOVE-CORRESPONDING ps_n1compcon TO ls_n1compcon_key.
  ls_n1compcon_key-mandt = sy-mandt.
  ls_key-pgmid      = 'R3TR'.
  ls_key-object     = 'TABU'.
  ls_key-mastertype = 'TABU'.
  ls_key-objname    = 'N1COMPCON'.
  ls_key-mastername = 'N1COMPCON'.
  ls_key-tabkey     = ls_n1compcon_key.
  APPEND ls_key TO lt_key.

* Build n1compcont key.
  CLEAR: ls_key,
         ls_n1compcont_key.
  MOVE-CORRESPONDING ps_n1compcont TO ls_n1compcont_key.
  ls_n1compcont_key-mandt = sy-mandt.
  ls_key-pgmid      = 'R3TR'.
  ls_key-object     = 'TABU'.
  ls_key-mastertype = 'TABU'.
  ls_key-objname    = 'N1COMPCONT'.
  ls_key-mastername = 'N1COMPCONT'.
  ls_key-tabkey     = ls_n1compcont_key.
  APPEND ls_key TO lt_key.

* Transport
  CALL FUNCTION 'TR_APPEND_TO_COMM_OBJS_KEYS'
    EXPORTING
      wi_suppress_key_check = 'X'
      wi_trkorr             = l_trkorr
    TABLES
      wt_e071               = lt_obj
      wt_e071k              = lt_key
    EXCEPTIONS
      OTHERS                = 1.
  IF sy-subrc <> 0.
    CALL METHOD cl_ish_utl_base=>collect_messages_by_syst
      CHANGING
        cr_errorhandler = gr_errorhandler.
    p_rc = 1.
    RETURN.
  ENDIF.

ENDFORM.                    " transport_compcon
* Michael Manoch, 10.10.2006, MED-9592   END
