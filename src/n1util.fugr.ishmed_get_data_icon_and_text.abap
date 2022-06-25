FUNCTION ishmed_get_data_icon_and_text.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_OBJECT) TYPE REF TO  OBJECT OPTIONAL
*"     VALUE(I_DATA_LINE) TYPE  ANY OPTIONAL
*"     VALUE(I_DATA_NAME) TYPE  ANY OPTIONAL
*"     VALUE(I_OBJTY) TYPE  NOBJTY OPTIONAL
*"     VALUE(I_POID) TYPE  N1POOBJECTTYPE-ID OPTIONAL
*"     VALUE(I_ICON_WITH_QINFO) TYPE  ISH_ON_OFF DEFAULT SPACE
*"     VALUE(I_CASE_REV) TYPE  ISH_SHIFT_TYPE OPTIONAL
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"     VALUE(E_ICON) TYPE  TV_IMAGE
*"     VALUE(E_TEXT) TYPE  ANY
*"     VALUE(E_TEXT_PLURAL) TYPE  ANY
*"  CHANGING
*"     REFERENCE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------
  DATA: l_type      TYPE i,
        l_objty     TYPE nobjty,
        l_data_type TYPE i,
        l_poid      TYPE n1poobjectid,
        l_n1poobj   TYPE n1poobjecttype,
        l_context   TYPE REF TO cl_ish_context,
        l_nctx      TYPE nctx,
        lt_ncxst    TYPE STANDARD TABLE OF ncxst,
        l_ncxst     TYPE ncxst,
        l_icon      TYPE tv_image,
        l_text      TYPE text50,
        l_text_plural TYPE text50,
        l_app       TYPE REF TO cl_ish_appointment,
*       Kennzeichen: Termin mit Bewegungsbezug.
        l_app_vis   TYPE ish_on_off,
*       Kennzeichen: Termin gehört zu einer Not-OP
        l_emerg_op  TYPE ish_on_off,
*       Kennzeichen: Auftragsposition ist 'vorgemerkt'
        l_prereg    TYPE ish_on_off,
        l_rc        TYPE ish_method_rc,
        l_ntmn      TYPE ntmn,
        l_nbew      TYPE nbew,
        l_n1vkg     TYPE n1vkg,
        l_einri     TYPE nlei-einri.
  FIELD-SYMBOLS: <l_field> TYPE any.

  DATA: l_part_of_chain TYPE ish_on_off.                    " ID 15207

* Initialisierungen
  e_rc = 0.
  CLEAR: e_icon,
         e_text,
         e_text_plural,
         l_icon,
         l_text,
         l_text_plural,
         l_text,
         l_data_type,
         l_poid,
         l_app_vis,
         l_emerg_op,
         l_prereg,
         l_app,
         l_rc.
  IF c_errorhandler IS INITIAL.
    CREATE OBJECT c_errorhandler.
  ENDIF.

* Objektorientierte Daten
  IF NOT i_object IS INITIAL.

    CALL METHOD i_object->('GET_TYPE')
      IMPORTING
        e_object_type = l_type.

    CALL METHOD cl_ish_environment=>convert_object_type
      EXPORTING
        i_object_type = l_type
      IMPORTING
        e_rc          = e_rc
        e_nobjty      = l_objty.

    CASE l_type.
      WHEN cl_ish_appointment=>co_otype_appointment.
        l_data_type = co_ltype_appmnt.
*       ----------
*       Termin-Daten ermitteln um zu prüfen ob der Termin
*       bereits einen Bezug zu einer Bewegung hat.
        CALL METHOD i_object->('GET_DATA')
          EXPORTING
            i_fill_appointment = space
          IMPORTING
            es_ntmn            = l_ntmn
            e_rc               = l_rc
          CHANGING
            c_errorhandler     = c_errorhandler.
        IF l_rc = 0.
          IF NOT l_ntmn-tmnlb IS INITIAL.
            l_app_vis = 'X'.
          ENDIF.
        ELSE.
          e_rc = l_rc.
          EXIT.
        ENDIF.
*       ----------
*       Prüfen, ob der Termin zu einer Not-OP gehört
        l_app ?= i_object.
        CALL FUNCTION 'ISHMED_CHECK_IS_EMERGENCY_OP'
          EXPORTING
            i_appointment    = l_app
*           I_DATA_CONTAINER =
*           IT_OBJECT        =
          IMPORTING
            e_emergency_op   = l_emerg_op
            e_rc             = l_rc
          CHANGING
            c_errorhandler   = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.

*       check if the appointment is part of a chain (ID 15207)
        l_app ?= i_object.
        CALL METHOD l_app->is_part_of_chain
          RECEIVING
            r_part_of_chain = l_part_of_chain.

      WHEN cl_ishmed_service=>co_otype_med_service.
        l_data_type = co_ltype_med_srv.

      WHEN cl_ishmed_patient_provisional=>co_otype_prov_patient.
        l_data_type = co_ltype_prov_pat.

      WHEN cl_ishmed_service=>co_otype_anchor_srv.
        l_data_type = co_ltype_anchor_srv.

      WHEN cl_ishmed_request=>co_otype_request.
        l_data_type = co_ltype_request.

*     ID 13178 ANDERLN -> todo replace through inherited_from
      WHEN cl_ish_corder=>co_otype_corder.
        l_data_type = co_ltype_corder.

      WHEN cl_ishmed_corder=>co_otype_corder_med.
        l_data_type = co_ltype_corder.

*     Medical order
      WHEN cl_ishmed_me_order=>co_otype_me_order.
        l_data_type = co_ltype_me_order.

*     Medical event
      WHEN cl_ishmed_me_event=>co_otype_me_event.
        l_data_type = co_ltype_me_event.

      WHEN cl_ishmed_prereg=>co_otype_prereg OR
           cl_ishmed_cordpos=>co_otype_cordpos_med.
        l_data_type = co_ltype_prereg.
*       ----------
        CALL METHOD i_object->('GET_DATA')
          IMPORTING
            e_rc           = l_rc
            e_n1vkg        = l_n1vkg
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc = 0.
          l_prereg = l_n1vkg-prereg.
        ELSE.
          e_rc = l_rc.
          EXIT.
        ENDIF.

      WHEN cl_ish_address=>co_otype_address.
        l_data_type = co_ltype_address.

      WHEN cl_ishmed_vitpar=>co_otype_vitpar.
        l_data_type = co_ltype_vitpar.

      WHEN cl_ishmed_team=>co_otype_team.
        l_data_type = co_ltype_team.

      WHEN cl_ish_context=>co_otype_context.
        l_data_type = co_ltype_context.
*       Icon hier speziell ermitteln
        l_context ?= i_object.
        CALL METHOD l_context->get_data
          EXPORTING
            i_fill_context = off
          IMPORTING
            e_rc           = l_rc
            e_nctx         = l_nctx.
        IF l_rc = 0  AND  NOT l_nctx-cxsta IS INITIAL.
          CALL METHOD cl_ish_master_dp=>read_context_status
            EXPORTING
              i_spras  = sy-langu
              i_cxtyp  = l_nctx-cxtyp
              i_cxsta  = l_nctx-cxsta
            IMPORTING
              e_rc     = l_rc
              et_ncxst = lt_ncxst.
          IF l_rc = 0.
            READ TABLE lt_ncxst INTO l_ncxst
                       WITH KEY cxsta = l_nctx-cxsta.
            IF sy-subrc = 0.
              l_icon = l_ncxst-cxsicon.
            ENDIF.
          ENDIF.
        ENDIF.

      WHEN cl_ish_prereg_procedure=>co_otype_prereg_procedure.
        l_data_type = co_ltype_prereg_proc.

      WHEN cl_ish_waiting_list_absence=>co_otype_wl_absence .
        l_data_type = co_ltype_wl_absence.

      WHEN cl_ish_insurance_policy_prov=>co_otype_prov_insurance_policy.
        l_data_type = co_ltype_prov_ins_pol.

      WHEN cl_ish_prereg_diagnosis=>co_otype_prereg_diagnosis.
        l_data_type = co_ltype_prereg_diag.

*     Hoebarth MED-33288 BEGIN
      WHEN cl_ishmed_srv_service=>co_otype_srv_service.
        l_data_type = co_ltype_srv_service.
*     Hoebarth MED-33288 END

*     Begin, Siegl MED-34863
      WHEN cl_ishmed_cycle_srv_tpl=>co_otype_cycle_srv_tpl.
        l_data_type = co_ltype_cysrvtpl.
*     End, Siegl MED-34863

    ENDCASE.
  ENDIF.

* Daten in herkömmlicher Form
  IF NOT i_data_name IS INITIAL.

    CALL METHOD cl_ish_environment=>convert_object_type
      EXPORTING
        i_data_name = i_data_name
      IMPORTING
        e_rc        = e_rc
        e_nobjty    = l_objty.

    CASE i_data_name.
      WHEN 'NBEW'.
        l_data_type = co_ltype_nbew.

*       Prüfen, ob es eine OP-Bewegung (Not-OP) ist
        l_nbew = i_data_line.
        CALL FUNCTION 'ISHMED_NBEW_CHECK_OP_TYPE'
          EXPORTING
            i_nbew         = l_nbew
          IMPORTING
            e_rc           = l_rc
            e_op_bew       = l_emerg_op
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.

      WHEN 'NDIA'.
        l_data_type = co_ltype_ndia.

      WHEN 'N1FAT'.
        l_data_type = co_ltype_n1fat.

      WHEN 'NDOC'.
        l_data_type = co_ltype_ndoc.
        ASSIGN COMPONENT 'EINRI' OF STRUCTURE i_data_line
               TO <l_field>.
        IF sy-subrc = 0  AND  NOT <l_field> IS INITIAL.
          l_einri = <l_field>.
          ASSIGN COMPONENT 'PCODE' OF STRUCTURE i_data_line
                 TO <l_field>.
          IF NOT <l_field> IS INITIAL.
            SELECT SINGLE icon FROM tn2flag INTO l_icon
                   WHERE einri  = l_einri
                   AND   flagid = <l_field>.
          ENDIF.
        ENDIF.

      WHEN 'NMATV'.
        l_data_type = co_ltype_nmatv.

      WHEN 'N2ZEITEN'.
        l_data_type = co_ltype_n2zeiten.

      WHEN 'N2OK'.
        l_data_type = co_ltype_n2ok.

      WHEN 'NICP'.
        l_data_type = co_ltype_nicp.

      WHEN 'NLEI'.
        l_data_type = co_ltype_ish_srv.

      WHEN 'N1BEZY'.
        l_data_type = co_ltype_cyclus.

      WHEN 'NPAP'.
        l_data_type = co_ltype_prov_pat.

      WHEN 'NTMN'.
        l_data_type = co_ltype_appmnt.
        l_ntmn = i_data_line.
*       ----------
*       Prüfen ob der Termin bereits Bewegungsbezug hat.
        ASSIGN COMPONENT 'TMNLB' OF STRUCTURE i_data_line
           TO <l_field>.
        IF sy-subrc = 0.
          IF NOT <l_field> IS INITIAL.
            l_app_vis = 'X'.
          ENDIF.
*         check if the appointment is part of a chain (ID 15207)
          IF l_ntmn-chainid IS NOT INITIAL.
            l_part_of_chain = on.
          ENDIF.
        ENDIF.
*       ----------

      WHEN 'NFAL'.                                          " ID 12776
        l_data_type = co_ltype_nfal.

      WHEN 'N1VKG'.
        l_data_type = co_ltype_prereg.
*       ----------
        ASSIGN COMPONENT 'PREREG' OF STRUCTURE i_data_line
           TO <l_field>.
        IF sy-subrc = 0.
          l_prereg = <l_field>.
        ENDIF.

      WHEN 'N1CORDER'.
        l_data_type = co_ltype_corder.

      WHEN 'N1ANF'.
        l_data_type = co_ltype_request.

    ENDCASE.

  ENDIF.   " if not i_data_name is initial

* case revision ------------------------------------------
  IF i_case_rev IS NOT INITIAL.
    CASE i_case_rev.
      WHEN gc_casrev_meddoc.
        l_data_type = co_ltype_meddoc.
      WHEN gc_casrev_medsurco.
        l_data_type = co_ltype_medsurco.
      WHEN gc_casrev_medsurti.
        l_data_type = co_ltype_medsurti.
      WHEN gc_casrev_medsuran.
        l_data_type = co_ltype_medsuran.
      WHEN gc_casrev_medsurre.
        l_data_type = co_ltype_medsurre.
      WHEN gc_casrev_mednlicz.
        l_data_type = co_ltype_mednlicz.
    ENDCASE.
  ENDIF.

* ---------------------------------------------------------
* Nun Icon und die Texte herleiten
  CASE l_data_type.
    WHEN co_ltype_appmnt.
      IF l_emerg_op = 'X'.
        l_icon        = icon_alarm.
        IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_false.
          l_text        = 'Not-Operation'(003).
          l_text_plural = 'Not-Operationen'(004).
        ELSE.
          l_text        = 'Unangemeldete OP'(137).
          l_text_plural = 'Unangemeldete OPs'(138).
        ENDIF.
      ELSEIF l_part_of_chain = 'X'.                         " ID 15207
        l_icon        = icon_ben_offer_open.
        l_text        = 'Serientermin'(121).
        l_text_plural = 'Serientermine'(122).
      ELSE.
        IF l_app_vis = 'X'.
          l_icon      = icon_visit.
        ELSE.
          l_icon      = icon_date.
        ENDIF.
        l_text        = 'Termin'(001).
        l_text_plural = 'Termine'(002).
      ENDIF.

    WHEN co_ltype_med_srv.
      l_icon        = icon_task.
      l_text        = 'Leistung'(005).
      l_text_plural = 'Leistungen'(006).

    WHEN co_ltype_ish_srv.
      l_icon        = icon_task.
      l_text        = 'Leistung'(005).
      l_text_plural = 'Leistungen'(006).

    WHEN co_ltype_prov_pat.
      l_icon        = icon_personnel_administration.
*     Bezeichung siehe Nr 9682, Punkt 2
      l_text        = 'Vorläufige PatStammdaten'(010).
      l_text_plural = 'Vorläufige PatStammdaten'(011).

    WHEN co_ltype_anchor_srv.
      l_icon        = icon_select_detail.
      l_text        = 'Operation'(015).
      l_text_plural = 'Operationen'(016).

    WHEN co_ltype_request.
      l_icon        = icon_ben_current_benefits.
      l_text        = 'Anforderung'(020).
      l_text_plural = 'Anforderungen'(021).

    WHEN co_ltype_corder.
      l_icon        = icon_ben_current_benefits.
      l_text        = 'Klinischer Auftrag'(007).
      l_text_plural = 'Klinische Aufträge'(008).

    WHEN co_ltype_prereg.
      IF l_prereg = on.
        l_icon      = icon_short_message.
      ELSE.
        l_icon      = icon_ben_current_benefits.
      ENDIF.
      l_text        = 'Auftragsposition'(027).
      l_text_plural = 'Auftragspositionen'(028).
*      l_text        = 'Vormerkung'(025).
*      l_text_plural = 'Vormerkungen'(026).

    WHEN co_ltype_address.
*      l_icon        =
      l_text        = 'Adresse'(030).
      l_text_plural = 'Adressen'(031).

    WHEN co_ltype_vitpar.
      l_icon        = icon_period.
      l_text        = 'Vitalparameter'(035).
      l_text_plural = 'Vitalparameter'(036).

    WHEN co_ltype_team.
      l_icon        = icon_employee.
      l_text        = 'Team'(040).
      l_text_plural = 'Team'(041).

    WHEN co_ltype_context.
*     l_icon        =
      l_text        = 'Kontext'(045).
      l_text_plural = 'Kontexte'(046).

    WHEN co_ltype_prereg_proc.
      l_icon        = icon_tools.
      l_text        = 'Prozedur'(050).
      l_text_plural = 'Prozeduren'(051).

    WHEN co_ltype_wl_absence.
*     l_icon        =
      l_text        = 'Warteliste Abwesenheit'(055).
      l_text_plural = 'Warteliste Abwesenheiten'(056).

    WHEN co_ltype_prov_ins_pol.
*      l_icon        =
      l_text        = 'Versicherungsverhältnis'(060).
      l_text_plural = 'Versicherungsverhältnis'(061).

    WHEN co_ltype_prereg_diag.
*     l_icon        =
      l_text        = 'Diagnose'(065).
      l_text_plural = 'Diagnosen'(066).

    WHEN co_ltype_nbew.
      IF l_emerg_op = 'X'.
        l_icon        = icon_alarm.
        IF cl_ishmed_switch_check=>ishmed_scd( ) = abap_false.
          l_text        = 'Not-Operation'(003).
          l_text_plural = 'Not-Operationen'(004).
        ELSE.
          l_text        = 'Unangemeldete OP'(137).
          l_text_plural = 'Unangemeldete OPs'(138).
        ENDIF.
      ELSE.
        l_icon        = icon_visit.
        l_text        = 'Bewegung'(070).
        l_text_plural = 'Bewegungen'(071).
      ENDIF.

    WHEN co_ltype_ndia.
*     l_icon        =
      l_text        = 'Diagnose'(065).
      l_text_plural = 'Diagnosen'(066).

    WHEN co_ltype_n1fat.
      l_icon        = icon_transport.
      l_text        = 'Fahrauftrag'(075).
      l_text_plural = 'Fahraufträge'(076).

    WHEN co_ltype_ndoc.
      IF l_icon IS INITIAL.
        l_icon        = icon_change_text.
      ENDIF.
      l_text        = 'Dokument'(080).
      l_text_plural = 'Dokumente'(081).

    WHEN co_ltype_nmatv.
      l_icon        = icon_material.
      l_text        = 'Material'(085).
      l_text_plural = 'Materialien'(086).

    WHEN co_ltype_n2zeiten.
      l_icon        = icon_time.
      l_text        = 'Zeitmarke'(090).
      l_text_plural = 'Zeitmarken'(091).

    WHEN co_ltype_n2ok.
      l_icon        = icon_message_warning_small.
      l_text        = 'Komplikation'(095).
      l_text_plural = 'Komplikationen'(096).

    WHEN co_ltype_nicp.
      l_icon        = icon_tools.
      l_text        = 'Prozedur'(050).
      l_text_plural = 'Prozeduren'(051).

    WHEN co_ltype_cyclus.
*     l_icon        =
      l_text        = 'Zyklus'(100).
      l_text_plural = 'Zyklen'(101).

    WHEN co_ltype_nfal.                                     " ID 12776
      l_icon        = icon_content_object.
      l_text        = 'Fall'(105).
      l_text_plural = 'Fälle'(106).

*   Medical order
    WHEN co_ltype_me_order.
      l_icon        = icon_intensify_critical.
      l_text        = 'Verordnung'(107).
      l_text_plural = 'Verordnungen'(108).

*   Medical event
    WHEN co_ltype_me_event.
      l_icon        = icon_ben_offer_default.
      l_text        = 'Ereignis'(109).
      l_text_plural = 'Ereignisse'(110).

*   Medical order drug
    WHEN co_ltype_me_odrug.
      l_text        = 'Medikament d. Verordn.'(111).
      l_text_plural = 'Medikamente d. Verordn.'(112).

*   Medical event drug
    WHEN co_ltype_me_edrug.
      l_text        = 'Medikament d. Ereign.'(113).
      l_text_plural = 'Medikamente d. Ereign.'(114).

*   Medical order rate
    WHEN co_ltype_me_orate.
      l_text        = 'Rate d. Verordn.'(115).
      l_text_plural = 'Raten d. Verordn.'(116).

*   Medical indications
    WHEN co_ltype_me_meorderthcla.
      l_text        = 'Indikation'(135).
      l_text_plural = 'Indikationen'(136).

*   Cycle
    WHEN co_ltype_cycle.
      l_text        = 'Zyklus'(117).
      l_text_plural = 'Zyklen'(118).

*   Cycle definition
    WHEN co_ltype_cycledef.
      l_text        = 'Zyklusdefinition'(119).
      l_text_plural = 'Zyklusdefinitionen'(120).

*   medical document
    WHEN co_ltype_meddoc.
      l_text        = 'Dokument'(123).
      l_text_plural = 'Dokumente'(124).

*   complications of surgery
    WHEN co_ltype_medsurco.
      l_text        = 'Komplikation'(125).
      l_text_plural = 'Komplikationen'(126).

*   times of surgery
    WHEN co_ltype_medsurti.
      l_text        = 'Zeit der OP'(127).
      l_text_plural = 'Zeiten zur OP'(128).

*   relations of surgery
    WHEN co_ltype_medsurre.
      l_text        = 'Zuordnung zur OP'(129).
      l_text_plural = 'Zuordnungen zur OP'(130).

*   relation of service to pocedure
    WHEN co_ltype_mednlicz.
      l_text        = 'Leistung zur OP'(131).
      l_text_plural = 'Leistungen zur OP'(132).

*   anchordata of surgery
    WHEN co_ltype_medsuran.
      l_text        = 'Verwaltungsdaten zur ChirDoku'(133).
      l_text_plural = 'Verwaltungsdaten zur ChirDoku'(134).

*   Hoebarth MED-33288 BEGIN
    WHEN co_ltype_srv_service.
      l_icon        = icon_task.
      l_text        = 'Leistung'(005).
      l_text_plural = 'Leistungen'(006).
*  Begin, Siegl MED-34863
*   Cycle Service Template
    WHEN co_ltype_cysrvtpl.
      l_icon        = icon_task.
      l_text        = 'beauftr. Leistung'(139).
      l_text_plural = 'beauftr. Leistungen'(140).
*  End, Siegl MED-34863
  ENDCASE.

* Gibt es für diesen Objekttyp in der N1POOBJECTTYPE ein
* Icon?
  IF NOT i_poid IS INITIAL.
    SELECT SINGLE * FROM n1poobjecttype INTO l_n1poobj
                    WHERE id = i_poid.
    IF sy-subrc = 0.
      l_icon = l_n1poobj-symbol.
    ENDIF.
  ENDIF.

* return icon with quick info?
  IF i_icon_with_qinfo = on AND
     l_icon IS NOT INITIAL  AND
     l_text IS NOT INITIAL.
    CONCATENATE l_icon(3) '\Q' l_text '@' INTO l_icon.
  ENDIF.

  e_icon        = l_icon.
  e_text        = l_text.
  e_text_plural = l_text_plural.

ENDFUNCTION.
