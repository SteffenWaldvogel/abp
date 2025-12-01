@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Employee Manager'
define root view entity ZSLAN_C_EMPLOYEE_M 
provider contract transactional_query
as projection on ZSLAN_R_EMPLOYEE
{
    key EmployeeUuid,
    EmployeeId,
    FirstName,
    LastName,
    EntryDate,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    ConsumedVacationDays,
    PlannedVacationDays,
    AvailableVacationDays,
    EmployeeName,
    /* Associations */
    _Inquiry : redirected to composition child zslan_c_va_inquiry_m
}
