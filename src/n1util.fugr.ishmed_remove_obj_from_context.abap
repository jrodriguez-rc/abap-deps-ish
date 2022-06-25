FUNCTION ishmed_remove_obj_from_context.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_OBJECT) TYPE REF TO  OBJECT
*"  EXPORTING
*"     VALUE(ET_CONTEXT) TYPE  ISH_OBJECTLIST
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     REFERENCE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"     REFERENCE(C_CANCEL) TYPE REF TO  CL_ISH_CANCEL OPTIONAL
*"----------------------------------------------------------------------
  DATA: l_rc           TYPE ish_method_rc,
        l_type         TYPE i,
        l_environment  TYPE REF TO cl_ish_environment,
        lt_obj         TYPE ish_objectlist,
        lt_obj_trigger TYPE ish_objectlist,
        l_obj          TYPE ish_object,
        lr_corder      TYPE REF TO cl_ish_corder,
        l_prereg       TYPE REF TO cl_ishmed_prereg,
        l_request      TYPE REF TO cl_ishmed_request,
        l_appmnt       TYPE REF TO cl_ish_appointment,
        l_context      TYPE REF TO cl_ish_context.

* Initialisierung
  e_rc = 0.
  REFRESH: et_context.
  REFRESH: lt_obj, lt_obj_trigger.
  CLEAR: l_environment, lr_corder, l_prereg, l_request, l_appmnt,
         l_context.

  CALL METHOD i_object->('GET_ENVIRONMENT')
    IMPORTING
      e_environment = l_environment.

* Zu dem übergebenen Objekt die Contexte ermitteln
  CALL METHOD i_object->('GET_TYPE')
    IMPORTING
      e_object_type = l_type.

  CASE l_type.
    WHEN cl_ish_corder=>co_otype_corder OR
         cl_ishmed_corder=>co_otype_corder_med.
      lr_corder ?= i_object.
      REFRESH lt_obj.
      CALL METHOD cl_ish_corder=>get_context_for_corder
        EXPORTING
          ir_corder          = lr_corder
          ir_environment     = l_environment
*         Hier überall auch die Daten mit gesetztem Stornoflag
*         zurückgeben, denn im Zuge des Stornos kann es sein, dass
*         z.B der Kontext schon das Stornoflag gesetzt hat!
          i_cancelled_datas  = on
        IMPORTING
          et_context         = lt_obj
          et_context_trigger = lt_obj_trigger
          e_rc               = l_rc
        CHANGING
          cr_errorhandler    = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.

*   Käfer, ID: 17836 - Begin
*   if the object is an order position, do nothing
*    WHEN ...=>co_otype_prereg OR
*         ...=>co_otype_cordpos_med.
*      l_prereg ?= i_object.
*      CALL METHOD l_prereg->get_corder
*        EXPORTING
*          ir_environment  = l_environment
*        IMPORTING
*          er_corder       = lr_corder
*          e_rc            = l_rc
*        CHANGING
*          cr_errorhandler = c_errorhandler.
*      IF l_rc = 0.
*        REFRESH lt_obj.
*        CALL METHOD cl_ish_corder=>get_context_for_corder
*          EXPORTING
*            ir_corder         = lr_corder
*            ir_environment    = l_environment
**           Hier überall auch die Daten mit gesetztem Stornoflag
**           zurückgeben, denn im Zuge des Stornos kann es sein, dass
**           z.B der Kontext schon das Stornoflag gesetzt hat!
*            i_cancelled_datas = on
*          IMPORTING
*            et_context        = lt_obj
*            et_context_trigger          = lt_obj_trigger
*            e_rc              = l_rc
*          CHANGING
*            cr_errorhandler   = c_errorhandler.
*        IF l_rc <> 0.
*          e_rc = l_rc.
*          EXIT.
*        ENDIF.
*      ELSE.
*        e_rc = l_rc.
*        EXIT.
*      ENDIF.
*   Käfer, ID: 17836 - End

    WHEN cl_ishmed_request=>co_otype_request.
      l_request ?= i_object.
      CALL METHOD cl_ishmed_request=>get_context_for_request
        EXPORTING
          i_request                   = l_request
          i_environment               = l_environment
*         Hier überall auch die Daten mit gesetztem Stornoflag
*         zurückgeben, denn im Zuge des Stornos kann es sein, dass
*         z.B der Kontext schon das Stornoflag gesetzt hat!
          i_cancelled_datas           = on
        IMPORTING
          et_context                  = lt_obj
          et_context_trigger          = lt_obj_trigger
          e_rc                        = l_rc
        CHANGING
          c_errorhandler              = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.

    WHEN cl_ish_appointment=>co_otype_appointment.
      l_appmnt ?= i_object.
      CALL METHOD cl_ish_appointment=>get_context_for_appmnt
        EXPORTING
          i_appointment               = l_appmnt
          i_environment               = l_environment
*         Hier überall auch die Daten mit gesetztem Stornoflag
*         zurückgeben, denn im Zuge des Stornos kann es sein, dass
*         z.B der Kontext schon das Stornoflag gesetzt hat!
          i_cancelled_datas           = on
        IMPORTING
          et_context                  = lt_obj
          et_context_trigger          = lt_obj_trigger
          e_rc                        = l_rc
        CHANGING
          c_errorhandler              = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.

    WHEN cl_ish_context=>co_otype_context.
      l_context ?= i_object.
      CALL METHOD cl_ish_context=>get_objects_for_context
        EXPORTING
*         Hier überall auch die Daten mit gesetztem Stornoflag
*         zurückgeben, denn im Zuge des Stornos kann es sein, dass
*         z.B der Kontext schon das Stornoflag gesetzt hat!
          i_cancelled_datas           = on
          i_context                   = l_context
          i_environment               = l_environment
        IMPORTING
          e_rc                        = l_rc
          et_objects                  = lt_obj
          et_context_trigger          = lt_obj_trigger
        CHANGING
          c_errorhandler              = c_errorhandler.
      IF l_rc <> 0.
        e_rc = l_rc.
        EXIT.
      ENDIF.
      LOOP AT lt_obj INTO l_obj.
*       Auslöserobjekte hier unbedingt weglassen, denn sonst
*       würden die auch storniert werden (und nicht nur die
*       Verbindungsobjekte (NCTO"s) zwischen Kontext und dem Objekt)
        READ TABLE lt_obj_trigger TRANSPORTING NO FIELDS
                   WITH KEY object = l_obj-object.
        CHECK sy-subrc <> 0.
        CALL FUNCTION 'ISHMED_REMOVE_OBJ_FROM_CONTEXT'
          EXPORTING
            i_object       = l_obj-object
          IMPORTING
            e_rc           = l_rc
          CHANGING
            c_errorhandler = c_errorhandler
            c_cancel       = c_cancel.
        IF l_rc <> 0.
          e_rc = l_rc.
          EXIT.
        ENDIF.
      ENDLOOP.
*     Da hier ja der Kontext selbst storniert werden soll, müssen
*     die NCTO-Sätze auch zu den Trigger-Objekten storniert werden
*     (aber natürlich NICHT die Trigger-Objekte selbst!)
      LOOP AT lt_obj_trigger INTO l_obj.
        CALL METHOD l_context->remove_obj_from_context
          EXPORTING
            i_object       = l_obj-object
          IMPORTING
            e_rc           = l_rc
          CHANGING
            c_errorhandler = c_errorhandler.
        IF l_rc <> 0.
          e_rc = l_rc.
        ENDIF.
      ENDLOOP.
      REFRESH lt_obj_trigger.

    WHEN OTHERS.
*     Hier keine Fehlermeldung ausgeben, sondern den FBS ohne
*     Aktion verlassen
      EXIT.
  ENDCASE.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

* Kontexte an den Aufrufer zurückgeben
  et_context[] = lt_obj[].

* Kontexte, bei denen das übergebene Objekt der Auslöser (Trigger)
* ist, werden komplett storniert (d.h. sowohl NCTX, als auch alle
* NCTO"s)
  LOOP AT lt_obj_trigger INTO l_obj.
    CALL METHOD l_obj-object->('GET_TYPE')
      IMPORTING
        e_object_type = l_type.
    CHECK l_type = cl_ish_context=>co_otype_context.

    l_context ?= l_obj-object.
    CALL METHOD l_context->cancel
      EXPORTING
        i_authority_check = on
        i_check_only      = off
      IMPORTING
        e_rc              = l_rc
      CHANGING
        c_errorhandler    = c_errorhandler
        c_cancel          = c_cancel.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
*   In LT_OBJ sind ALLE Kontexte, egal ob Auslöser oder nicht.
*   Deshalb von dort die Auslöser abziehen
    DELETE lt_obj WHERE object = l_obj-object.
*   Nicht vergessen auch das Triggerobjekt vom Kontext zu lösen
    CALL METHOD l_context->remove_obj_from_context
      EXPORTING
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.
  IF e_rc <> 0.
    EXIT.
  ENDIF.

* Kontexte, an denen das übergebene Objekt nur beteiligt ist,
* werden nicht storniert. Stattdessen wird nur die Verbindung
* des Objekts zum Kontext (NCTO) storniert
  LOOP AT lt_obj INTO l_obj.
    CALL METHOD l_obj-object->('GET_TYPE')
      IMPORTING
        e_object_type = l_type.
    CHECK l_type = cl_ish_context=>co_otype_context.

    l_context ?= l_obj-object.
    CALL METHOD l_context->remove_obj_from_context
      EXPORTING
        i_object       = i_object
      IMPORTING
        e_rc           = l_rc
      CHANGING
        c_errorhandler = c_errorhandler.
    IF l_rc <> 0.
      e_rc = l_rc.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.
