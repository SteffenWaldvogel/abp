
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text Element Status'

define view entity ZSLAN_I_StatusText as select from zslan_va_inquiry
{
     key inquiry_uuid,
      status,

      case
        when status = 'B' then 'Beantragt'
        when status = 'A' then 'Abgelehnt'
        when status = 'G' then 'Genehmigt'
        else ''
      end as StatusText
}
