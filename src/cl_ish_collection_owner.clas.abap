class CL_ISH_COLLECTION_OWNER definition
  public
  create public .

public section.
*"* public components of class CL_ISH_COLLECTION_OWNER
*"* do not include other source files here!!!

  interfaces IF_ISH_COLLECTION_OWNER .

  aliases ALLOWS_DELETE
    for IF_ISH_COLLECTION_OWNER~ALLOWS_DELETE .
  aliases ALLOWS_INSERT
    for IF_ISH_COLLECTION_OWNER~ALLOWS_INSERT .
  aliases ALLOWS_UPDATE
    for IF_ISH_COLLECTION_OWNER~ALLOWS_UPDATE .

  methods ACTIVATE .
  methods ALLOW_ALL .
  methods ALLOW_DELETE .
  methods ALLOW_INSERT .
  methods ALLOW_ONLY_DELETE .
  methods ALLOW_ONLY_INSERT .
  methods ALLOW_ONLY_UPDATE .
  methods ALLOW_UPDATE .
  type-pools ABAP .
  methods CONSTRUCTOR
    importing
      !I_ALLOW_DELETE type ABAP_BOOL default ABAP_TRUE
      !I_ALLOW_INSERT type ABAP_BOOL default ABAP_TRUE
      !I_ALLOW_UPDATE type ABAP_BOOL default ABAP_TRUE
      !I_ACTIVE type ABAP_BOOL default ABAP_TRUE .
  methods DEACTIVATE .
  methods FORBID_ALL .
  methods FORBID_DELETE .
  methods FORBID_INSERT .
  methods FORBID_ONLY_DELETE .
  methods FORBID_ONLY_INSERT .
  methods FORBID_ONLY_UPDATE .
  methods FORBID_UPDATE .
  methods IS_ACTIVE
    returning
      value(R_ACTIVE) type ABAP_BOOL .
protected section.
*"* protected components of class CL_ISH_COLLECTION_OWNER
*"* do not include other source files here!!!

  type-pools ABAP .
  data G_ACTIVE type ABAP_BOOL value ABAP_TRUE. "#EC NOTEXT .
  data G_ALLOW_DELETE type ABAP_BOOL value ABAP_TRUE. "#EC NOTEXT .
  data G_ALLOW_INSERT type ABAP_BOOL value ABAP_TRUE. "#EC NOTEXT .
  data G_ALLOW_UPDATE type ABAP_BOOL value ABAP_TRUE. "#EC NOTEXT .
private section.
*"* private components of class CL_ISH_COLLECTION_OWNER
*"* do not include other source files here!!!
ENDCLASS.



CLASS CL_ISH_COLLECTION_OWNER IMPLEMENTATION.


METHOD activate.

  g_active = abap_true.

ENDMETHOD.


METHOD allow_all.

  g_allow_delete = abap_true.
  g_allow_insert = abap_true.
  g_allow_update = abap_true.

ENDMETHOD.


METHOD allow_delete.

  g_allow_delete = abap_true.

ENDMETHOD.


METHOD allow_insert.

  g_allow_insert = abap_true.

ENDMETHOD.


METHOD allow_only_delete.

  g_allow_delete = abap_true.

  g_allow_insert = abap_false.
  g_allow_update = abap_false.

ENDMETHOD.


METHOD allow_only_insert.

  g_allow_insert = abap_true.

  g_allow_delete = abap_false.
  g_allow_update = abap_false.

ENDMETHOD.


METHOD allow_only_update.

  g_allow_update = abap_true.

  g_allow_insert = abap_false.
  g_allow_delete = abap_false.

ENDMETHOD.


METHOD allow_update.

  g_allow_update = abap_true.

ENDMETHOD.


METHOD constructor.

  g_allow_delete = i_allow_delete.
  g_allow_insert = i_allow_insert.
  g_allow_update = i_allow_update.

  g_active = i_active.

ENDMETHOD.


METHOD deactivate.

  g_active = abap_false.

ENDMETHOD.


METHOD forbid_all.

  g_allow_delete = abap_false.
  g_allow_insert = abap_false.
  g_allow_update = abap_false.

ENDMETHOD.


METHOD forbid_delete.

  g_allow_delete = abap_false.

ENDMETHOD.


METHOD forbid_insert.

  g_allow_insert = abap_false.

ENDMETHOD.


METHOD forbid_only_delete.

  g_allow_delete = abap_false.

  g_allow_insert = abap_true.
  g_allow_update = abap_true.

ENDMETHOD.


METHOD forbid_only_insert.

  g_allow_insert = abap_false.

  g_allow_delete = abap_true.
  g_allow_update = abap_true.

ENDMETHOD.


METHOD forbid_only_update.

  g_allow_update = abap_false.

  g_allow_insert = abap_true.
  g_allow_delete = abap_true.

ENDMETHOD.


METHOD forbid_update.

  g_allow_update = abap_false.

ENDMETHOD.


METHOD if_ish_collection_owner~allows_delete.

  IF g_active       = abap_false OR
     g_allow_delete = abap_true.
    r_allows = abap_true.
  ENDIF.

ENDMETHOD.


METHOD if_ish_collection_owner~allows_insert.

  IF g_active       = abap_false OR
     g_allow_insert = abap_true.
    r_allows = abap_true.
  ENDIF.

ENDMETHOD.


METHOD if_ish_collection_owner~allows_update.

  IF g_active       = abap_false OR
     g_allow_update = abap_true.
    r_allows = abap_true.
  ENDIF.

ENDMETHOD.


METHOD is_active.

  r_active = g_active.

ENDMETHOD.
ENDCLASS.
