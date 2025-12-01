
@AbapCatalog.sqlViewName: 'ZSLAN_I_PLANNED'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Planned Vacation Days'
define view zslan_i_plannedvacationdays as select from zslan_va_inquiry
{
    applicant_uuid as employee,
sum( 
case when begin_date > $session.system_date
then vacation_days
else 0
end) 
as PlannedVacationDays
}
where status <> 'A'
group by
applicant_uuid;
