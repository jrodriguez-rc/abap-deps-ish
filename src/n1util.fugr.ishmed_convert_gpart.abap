FUNCTION ishmed_convert_gpart.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     VALUE(I_GET_PARAMETER) TYPE  ISH_ON_OFF DEFAULT OFF
*"     VALUE(I_CLEAR_IF_WRONG) TYPE  ISH_ON_OFF DEFAULT OFF
*"     VALUE(I_WITH_N1MAOE) TYPE  ISH_ON_OFF DEFAULT ON
*"     VALUE(I_EINRI) TYPE  TN01-EINRI OPTIONAL
*"     VALUE(I_DATE) TYPE  SY-DATUM DEFAULT SY-DATUM
*"     VALUE(I_OBJECT) TYPE REF TO  OBJECT OPTIONAL
*"  EXPORTING
*"     VALUE(E_RC) TYPE  ISH_METHOD_RC
*"  CHANGING
*"     REFERENCE(C_GPART) TYPE  NGPA-GPART
*"     REFERENCE(C_ERRORHANDLER) TYPE REF TO  CL_ISHMED_ERRORHANDLING
*"       OPTIONAL
*"----------------------------------------------------------------------
  DATA: l_gpart  TYPE ngpa-gpart,
        l_n1maoe TYPE c,
        l_rc     TYPE ish_method_rc.

* Initialization
  e_rc = 0.
  CLEAR l_gpart.

  IF i_get_parameter = on.
*   Get GPART from parameter, if that"s requested from the caller
    CALL FUNCTION 'ISH_GET_PARAMETER_ID'
      EXPORTING
        i_parameter_id    = 'VMA'
      IMPORTING
        e_parameter_value = l_gpart
        e_rc              = l_rc.
  ELSE.
*   GPART is given by the caller
    l_gpart = c_gpart.
  ENDIF.

* Führer, ID. 12494 convert only if there is a GPART
  IF NOT l_gpart IS INITIAL.
*   Convert GPART to correct internal format
    IF l_gpart CO ' 1234567890'.
      SHIFT l_gpart LEFT DELETING LEADING ' '.
      SHIFT l_gpart RIGHT DELETING TRAILING ' '.
      TRANSLATE l_gpart USING ' 0'.
    ELSE.
      TRANSLATE l_gpart TO UPPER CASE.                   "#EC TRANSLANG
      SHIFT l_gpart LEFT DELETING LEADING ' '.
    ENDIF.
  ENDIF.

* If requested, check the value of GPART
* Führer, ID. 12494 check only if there is a GPART
  IF NOT   l_gpart           IS INITIAL  AND
         ( i_clear_if_wrong  =  on       OR
           e_rc              IS SUPPLIED OR
           c_errorhandler    IS SUPPLIED ).
*  IF i_clear_if_wrong = on  OR
*     e_rc IS REQUESTED      OR
*     c_errorhandler IS REQUESTED.
    CALL FUNCTION 'ISHMED_CHECK_NGPA'
      EXPORTING
        ss_check           = 'M'
        ss_einri           = i_einri
        ss_gdatum          = i_date
        ss_pernr           = l_gpart
*       SS_CHK_AUTH        = 'X'
      EXCEPTIONS
        not_found          = 1
        not_valid          = 2
        not_auth           = 3
        OTHERS             = 4.
    e_rc = sy-subrc.
    IF e_rc = 0.
      c_gpart = l_gpart.
    ELSE.
      IF i_clear_if_wrong = on.
        CLEAR c_gpart.
      ENDIF.
      IF c_errorhandler IS REQUESTED.
        IF c_errorhandler IS INITIAL.
          CREATE OBJECT c_errorhandler.
        ENDIF.
        IF e_rc = 1  OR  e_rc = 2.
*         & ist kein gültiger Mitarbeiter
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ    = 'E'
              i_kla    = 'NF'
              i_num    = '011'
              i_mv1    = l_gpart
              i_last   = space
              i_object = i_object.
        ELSE.
          l_n1maoe = 'E'.
          IF i_with_n1maoe = on.
            CALL FUNCTION 'ISH_TN00R_READ'
              EXPORTING
                ss_einri  = i_einri
                ss_param  = 'N1MAOE'
              IMPORTING
                ss_value  = l_n1maoe
              EXCEPTIONS
                not_found = 1
                OTHERS    = 2.
            IF sy-subrc <> 0.
              l_n1maoe = 'E'.
            ENDIF.
          ENDIF.
*         Der Mitarbeiter ist nicht berechtigt
          CALL METHOD c_errorhandler->collect_messages
            EXPORTING
              i_typ    = l_n1maoe
              i_kla    = 'NF'
              i_num    = '613'
              i_mv1    = l_gpart
              i_last   = space
              i_object = i_object.
        ENDIF.
      ENDIF.   " if c_errorhandler is requested
    ENDIF.
* Führer, ID. 12494 return employee also if there was no check
  ELSE.
    c_gpart = l_gpart.
  ENDIF.
ENDFUNCTION.
