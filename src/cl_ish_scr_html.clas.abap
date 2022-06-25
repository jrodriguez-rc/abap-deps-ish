class CL_ISH_SCR_HTML definition
  public
  inheriting from CL_ISH_SCR_CONTROL
  abstract
  create public .

*"* public components of class CL_ISH_SCR_HTML
*"* do not include other source files here!!!
public section.

  interfaces IF_ISH_SCR_HTML .

  aliases CO_UCOMM_LINK_CLICKED
    for IF_ISH_SCR_HTML~CO_UCOMM_LINK_CLICKED .
  aliases BUILD_UCOMM_LINK_CLICKED
    for IF_ISH_SCR_HTML~BUILD_UCOMM_LINK_CLICKED .
  aliases GET_CONFIG_HTML
    for IF_ISH_SCR_HTML~GET_CONFIG_HTML .
  aliases GET_DD_DOCUMENT
    for IF_ISH_SCR_HTML~GET_DD_DOCUMENT .
  aliases GET_UCOMM_KEYSTRING
    for IF_ISH_SCR_HTML~GET_UCOMM_KEYSTRING .

  constants CO_OTYPE_SCR_HTML type ISH_OBJECT_TYPE value 3022. "#EC NOTEXT

  methods IF_ISH_IDENTIFY_OBJECT~GET_TYPE
    redefinition .
  methods IF_ISH_IDENTIFY_OBJECT~IS_INHERITED_FROM
    redefinition .
  methods IF_ISH_SCREEN~OK_CODE_SCREEN
    redefinition .
  methods IF_ISH_SCREEN~PROCESS_BEFORE_OUTPUT
    redefinition .
  methods IF_ISH_SCREEN~TRANSPORT_TO_DY
    redefinition .
protected section.
*"* protected components of class CL_ISH_SCR_HTML
*"* do not include other source files here!!!

  data GR_DD_DOCUMENT type ref to CL_DD_DOCUMENT .

  methods HANDLE_LINK_CLICKED
    for event CLICKED of CL_DD_LINK_ELEMENT
    importing
      !SENDER .
  methods PROCESS_LINK_CLICKED
    importing
      !I_UCOMM type SY-UCOMM
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods PROCESS_LINK_CLICKED_INTERNAL
    importing
      !I_KEYSTRING type STRING
    exporting
      !E_UCOMM_HANDLED type ISH_ON_OFF
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_DD_DOCUMENT
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .
  methods BUILD_DD_DOCUMENT_INTERNAL
    exporting
      !E_RC type ISH_METHOD_RC
    changing
      !CR_DD_DOCUMENT type ref to CL_DD_DOCUMENT
      !CR_ERRORHANDLER type ref to CL_ISHMED_ERRORHANDLING optional .

  methods INITIALIZE_FIELD_VALUES
    redefinition .
private section.
*"* private components of class CL_ISH_SCR_HTML
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_SCR_HTML IMPLEMENTATION.


METHOD build_dd_document.

  DATA: lr_dd_document      TYPE REF TO cl_dd_document,
        l_dd_document_built TYPE ish_on_off,
        lr_config_html      TYPE REF TO if_ish_config_html.

* Initializations.
  e_rc = 0.

* Get the dd_document.
  CALL METHOD get_dd_document
    EXPORTING
      i_create        = on
    IMPORTING
      er_dd_document  = lr_dd_document
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK lr_dd_document IS BOUND.

* Initialize the dd_document.
*  CALL METHOD lr_dd_document->initialize_document.
  CALL METHOD lr_dd_document->initialize_document.
*    EXPORTING                                        "CDuerr, MED-34093
*      background_color = 8.                          "CDuerr, MED-34093

* Let the configuration build the dd_document.
  CALL METHOD get_config_html
    IMPORTING
      er_config_html  = lr_config_html
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_html IS INITIAL.
    CALL METHOD lr_config_html->build_dd_document
      EXPORTING
        ir_scr_html         = me
      IMPORTING
        e_rc                = e_rc
        e_dd_document_built = l_dd_document_built
      CHANGING
        cr_dd_document      = lr_dd_document
        cr_errorhandler     = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

* Now build the dd_document ourself.
  IF l_dd_document_built = off.
    CALL METHOD build_dd_document_internal
      IMPORTING
        e_rc            = e_rc
      CHANGING
        cr_dd_document  = lr_dd_document
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
  ENDIF.

ENDMETHOD.


METHOD build_dd_document_internal .

* This method should be redefined in derived classes to
* build the dd_document.

ENDMETHOD.


METHOD handle_link_clicked .

  DATA: l_ucomm          TYPE sy-ucomm,
        l_original_ucomm TYPE sy-ucomm,
        l_handled        TYPE ish_on_off,
        lr_errorhandler  TYPE REF TO cl_ishmed_errorhandling,
        l_rc             TYPE ish_method_rc.

* initial checking
  CHECK sender IS BOUND.

* Build the ucomm.
  l_original_ucomm = co_ucomm_link_clicked.
  l_ucomm          = l_original_ucomm.
  CALL METHOD build_ucomm_link_clicked
    EXPORTING
      ir_dd_link_element = sender
    CHANGING
      c_ucomm = l_ucomm.
  CHECK NOT l_ucomm IS INITIAL.

* Remember the ucomm.
  g_ucomm = l_ucomm.

* The link_clicked is always an application event.
* Therefore just raise ev_user_command.
  CALL METHOD raise_ev_user_command
    EXPORTING
      ir_screen = me
      i_ucomm   = l_ucomm.

ENDMETHOD.


METHOD if_ish_identify_object~get_type.

  e_object_type = co_otype_scr_html.

ENDMETHOD.


METHOD if_ish_identify_object~is_inherited_from.

  IF i_object_type = co_otype_scr_html.
    r_is_inherited_from = on.
  ELSE.
    r_is_inherited_from =
      super->if_ish_identify_object~is_inherited_from( i_object_type ).
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~ok_code_screen.

  DATA: l_ucomm           TYPE sy-ucomm,
        l_original_ucomm  TYPE sy-ucomm,
        l_ucomm_handled   TYPE ish_on_off,
        l_keystring       TYPE string.

* Initializations.
  e_rc = 0.

* Initial checking.
  CHECK NOT c_okcode IS INITIAL.
  CHECK is_ucomm_supported( c_okcode ) = on.

* Set l_ucomm.
  l_ucomm = c_okcode.

* Get the original ucomm.
  l_original_ucomm = get_original_ucomm( l_ucomm ).

* Process the ucomm.
  CASE l_original_ucomm.

*   LINK_CLICKED: Show document in popup.
    WHEN co_ucomm_link_clicked.
*     This ucomm is handled by self -> clear c_okcode.
      CLEAR c_okcode.
*     Process the ucomm.
      CALL METHOD process_link_clicked
        EXPORTING
          i_ucomm         = l_ucomm
        IMPORTING
          e_ucomm_handled = l_ucomm_handled
          e_rc            = e_rc
        CHANGING
          cr_errorhandler = c_errorhandler.
*   For all other ucomms call the super method.
    WHEN OTHERS.
      CALL METHOD super->if_ish_screen~ok_code_screen
        IMPORTING
          e_rc           = e_rc
        CHANGING
          c_errorhandler = c_errorhandler
          c_okcode       = c_okcode.

  ENDCASE.

ENDMETHOD.


METHOD if_ish_screen~process_before_output.

  DATA: lr_dd_document      TYPE REF TO cl_dd_document,
        lr_container        TYPE REF TO cl_gui_container,
        l_reuse_control     TYPE ish_on_off,
        l_rc                TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Clear g_ucomm.
  CLEAR g_ucomm.

* Build the dd_document.
  CALL METHOD build_dd_document
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Transport to dynpro.
  CALL METHOD transport_to_dy
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Set cursor.
  CALL METHOD set_cursor
    EXPORTING
      i_set_cursor   = on
    IMPORTING
      e_rc           = l_rc
    CHANGING
      c_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

* Process before output finished.
  CALL METHOD set_first_time
    EXPORTING
      i_first_time = off.

* Set old field values (for "check_changes")
  CALL METHOD set_fields_old
    IMPORTING
      e_rc            = l_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  IF l_rc <> 0.
    e_rc = l_rc.
  ENDIF.

ENDMETHOD.


METHOD if_ish_screen~transport_to_dy.

  DATA: lr_dd_document      TYPE REF TO cl_dd_document,
        lr_container        TYPE REF TO cl_gui_container,
        l_reuse_control     TYPE ish_on_off,
        l_rc                TYPE ish_method_rc.

* Initializations.
  e_rc = 0.

* Get the dd_document.
  CALL METHOD get_dd_document
    EXPORTING
      i_create        = off
    IMPORTING
      er_dd_document  = lr_dd_document
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_dd_document IS INITIAL.

* Merge the dd_document.
  CALL METHOD lr_dd_document->merge_document.

* Get the container.
  CALL METHOD get_container
    EXPORTING
      i_create        = off
    IMPORTING
      er_container    = lr_container
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_container IS INITIAL.

* Decide if control should be reused.
  l_reuse_control = on.
  IF g_first_time = on.
    l_reuse_control = off.
  ENDIF.

* Display the dd_document.
  CALL METHOD lr_dd_document->display_document
    EXPORTING
      reuse_control      = l_reuse_control
      parent             = lr_container
    EXCEPTIONS
      html_display_error = 1
      OTHERS             = 2.
  e_rc = sy-subrc.
  IF e_rc <> 0.
*   Fehler & beim Anlegen des Controls & (Klasse &)
    CALL METHOD cl_ish_utl_base=>collect_messages
      EXPORTING
        i_typ           = 'E'
        i_kla           = 'N1BASE'
        i_num           = '026'
        i_mv1           = e_rc
        i_mv2           = 'GR_DD_DOCUMENT'
        i_mv3           = 'CL_ISH_SCR_HTML'
      CHANGING
        cr_errorhandler = cr_errorhandler.
  ENDIF.

ENDMETHOD.


METHOD if_ish_scr_html~build_ucomm_link_clicked.

  CHECK ir_dd_link_element IS BOUND.

* Add the control id.
  CALL METHOD build_ucomm
    CHANGING
      c_ucomm = c_ucomm.

* Add the keystring.
  CONCATENATE c_ucomm
              ir_dd_link_element->name
         INTO c_ucomm
    SEPARATED BY '.'.

ENDMETHOD.


method IF_ISH_SCR_HTML~GET_CONFIG_HTML.

  DATA: lr_config_html  TYPE REF TO if_ish_config_HTML.

* Initializations.
  e_rc = 0.
  CLEAR er_config_html.

* Get the HTML config from the main config.
  CHECK NOT gr_config IS INITIAL.
  CALL METHOD gr_config->get_config_html
    EXPORTING
      ir_scr_html    = me
    IMPORTING
      er_config_html = lr_config_html
      e_rc               = e_rc
    CHANGING
      cr_errorhandler    = cr_errorhandler.
  CHECK e_rc = 0.

* Export.
  er_config_html = lr_config_html.

endmethod.


METHOD if_ish_scr_html~get_dd_document.

  DATA: lr_container    TYPE REF TO cl_gui_container,
        lr_dd_document  TYPE REF TO cl_dd_document.

* Initializations.
  CLEAR: e_rc,
         er_dd_document.
  IF cr_errorhandler IS INITIAL.
    CREATE OBJECT cr_errorhandler.
  ENDIF.

* Already loaded?
  er_dd_document = gr_dd_document.
  CHECK er_dd_document IS INITIAL.

* Not already loaded ->
*   -> instantiate the dd_document,
*      but only if the user specified.

  CHECK i_create = on.

* Get the container.
  CALL METHOD get_container
    IMPORTING
      er_container    = lr_container
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  CHECK NOT lr_container IS INITIAL.

* Create the dd_document object.
  CREATE OBJECT lr_dd_document
    EXPORTING
      background_color = lr_dd_document->col_background_level2.

* Remember the dd_document object.
  gr_dd_document = lr_dd_document.

* Export.
  er_dd_document = gr_dd_document.

ENDMETHOD.


METHOD if_ish_scr_html~get_ucomm_keystring.

  DATA: l_original_ucomm  TYPE sy-ucomm,
        l_cntl_id         TYPE n_numc5,
        l_keystring       TYPE string.

* Initializations.
  CLEAR r_keystring.

* Process only if the ucomm is supported by self.
  CHECK is_ucomm_supported( i_ucomm ) = on.

* Split the ucomm in its parts:
*   - original ucomm
*   - control id
*   - keystring
  SPLIT i_ucomm
      AT '.'
    INTO l_original_ucomm
         l_cntl_id
         l_keystring.

* Returning
  r_keystring = l_keystring.

ENDMETHOD.


METHOD initialize_field_values.

* Most html controls do not need field values.

ENDMETHOD.


METHOD process_link_clicked .

  DATA: l_keystring         TYPE string,
        l_ucomm_handled     TYPE ish_on_off,
        lr_config_html      TYPE REF TO if_ish_config_html.

* Initializations.
  e_rc = 0.
  e_ucomm_handled = off.

* Get the keystring from the given ucomm.
  l_keystring = get_ucomm_keystring( i_ucomm ).

* Let the configuration handle the user command.
  CALL METHOD get_config_html
    IMPORTING
      er_config_html  = lr_config_html
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.
  IF NOT lr_config_html IS INITIAL.
    CALL METHOD lr_config_html->process_link_clicked
      EXPORTING
        ir_scr_html     = me
        i_keystring     = l_keystring
      IMPORTING
        e_handled       = e_ucomm_handled
        e_rc            = e_rc
      CHANGING
        cr_errorhandler = cr_errorhandler.
    CHECK e_rc = 0.
    CHECK e_ucomm_handled = off.
  ENDIF.

* Do own user command processing.
  CALL METHOD process_link_clicked_internal
    EXPORTING
      i_keystring     = l_keystring
    IMPORTING
      e_ucomm_handled = e_ucomm_handled
      e_rc            = e_rc
    CHANGING
      cr_errorhandler = cr_errorhandler.
  CHECK e_rc = 0.

ENDMETHOD.


METHOD process_link_clicked_internal.

  e_rc = 0.
  e_ucomm_handled = off.

ENDMETHOD.
ENDCLASS.
