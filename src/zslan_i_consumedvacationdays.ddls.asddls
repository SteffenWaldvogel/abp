
@AbapCatalog.sqlViewName: 'ZSLAN_I_CONSUME'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Consumed Vacation Days'
define view ZSLAN_I_CONSUMEDVACATIONDAYS as select from zslan_va_inquiry 
{
     applicant_uuid as employee,
     sum(
        case when end_date > $session.user_date and begin_date < $session.user_date
          then
           dats_days_between(begin_date, end_date) 
          when end_date < $session.user_date and begin_date < $session.user_date
          then
            vacation_days
           else 0
        end)       
 as ConsumedVacationDays
}
where status = 'G'
group by
applicant_uuid;
