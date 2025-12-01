CLASS zslan_CM_VAINQUIRY DEFINITION PUBLIC
  INHERITING FROM cx_static_check FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    " Interfaces
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    " Message Constants

    CONSTANTS:
      BEGIN OF vacrequest_decline,
        msgid TYPE symsgid      VALUE 'ZSLAN_VA_INQUIRY',
        msgno TYPE symsgno      VALUE '001',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_decline.

    CONSTANTS:
      BEGIN OF vacrequest_already_declined,
        msgid TYPE symsgid      VALUE 'ZSLAN_VA_INQUIRY',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_already_declined.

    CONSTANTS:
      BEGIN OF vacrequest_approved,
        msgid TYPE symsgid      VALUE 'ZSLAN_VA_INQUIRY',
        msgno TYPE symsgno      VALUE '003',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_approved.

    CONSTANTS:
      BEGIN OF vacrequest_already_approved,
        msgid TYPE symsgid      VALUE 'ZSLAN_VA_INQUIRY',
        msgno TYPE symsgno      VALUE '004',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_already_approved.

    CONSTANTS:
      BEGIN OF vacrequest_endbeforestart,
        msgid TYPE symsgid      VALUE 'ZSLAN_VA_INQUIRY',
        msgno TYPE symsgno      VALUE '005',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_endbeforestart.

    CONSTANTS:
      BEGIN OF vacrequest_novacationleft,
        msgid TYPE symsgid      VALUE 'ZSLAN_VA_INQUIRY',
        msgno TYPE symsgno      VALUE '006',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_novacationleft.

    CONSTANTS:
      BEGIN OF vacrequest_startdatepast,
        msgid TYPE symsgid      VALUE 'ZSLAN_VA_INQUIRY',
        msgno TYPE symsgno      VALUE '007',
        attr1 TYPE scx_attrname VALUE 'Comment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacrequest_startdatepast.

    " Attribute
    DATA Comment TYPE STRING.

    " Constructor
    METHODS constructor
      IMPORTING severity  TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
                textid    LIKE if_t100_message=>t100key         DEFAULT if_t100_message=>default_textid
                !previous LIKE previous                         OPTIONAL
                Comment   TYPE zslan_comment                   OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZSLAN_CM_VAINQUIRY IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
    me->comment = comment.
  ENDMETHOD.
ENDCLASS.
