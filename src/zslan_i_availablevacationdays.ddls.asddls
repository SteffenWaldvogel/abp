
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View Available Vacation Days'
define view entity zslan_i_availablevacationdays as select from zslan_va_claim
    association [1..1] to zslan_i_plannedvacationdays as _plannedvd on $projection.Employee = _plannedvd.employee
    association [1..1] to ZSLAN_I_CONSUMEDVACATIONDAYS as _consumedvd on $projection.Employee = _consumedvd.employee
    

{
  key employee_uuid as Employee,
  sum(vacation_days) - coalesce(_consumedvd.ConsumedVacationDays, 0) - coalesce(_plannedvd.PlannedVacationDays, 0) as AvailableVacationDays
}

group by
employee_uuid, 
vacation_days,
_consumedvd.ConsumedVacationDays,
_plannedvd.PlannedVacationDays;
