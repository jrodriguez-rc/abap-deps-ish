*"* components of interface IF_ISH_GM_SEQNUM
interface IF_ISH_GM_SEQNUM
  public .


  interfaces IF_ISH_GM_COMPARABLE .

  aliases COMPARE_TO
    for IF_ISH_GM_COMPARABLE~COMPARE_TO .
  aliases GET_FIELD_CONTENT
    for IF_ISH_GM_COMPARABLE~GET_FIELD_CONTENT .
  aliases GET_SUPPORTED_FIELDS
    for IF_ISH_GM_COMPARABLE~GET_SUPPORTED_FIELDS .
  aliases IS_FIELD_SUPPORTED
    for IF_ISH_GM_COMPARABLE~IS_FIELD_SUPPORTED .
  aliases SET_FIELD_CONTENT
    for IF_ISH_GM_COMPARABLE~SET_FIELD_CONTENT .
  aliases EV_CHANGED
    for IF_ISH_GM_COMPARABLE~EV_CHANGED .

  methods GET_SEQNUM
    returning
      value(R_SEQNUM) type N1_SEQNUM .
  type-pools ABAP .
  methods SET_SEQNUM
    importing
      !I_SEQNUM type N1_SEQNUM
    returning
      value(R_CHANGED) type ABAP_BOOL
    raising
      CX_ISH_STATIC_HANDLER .
endinterface.
