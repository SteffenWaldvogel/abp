@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'VH: Employees'
define view entity ZSLAN_I_EMPLOYEEVH
  as select from zslan_employee
{

  key employee_uuid as EmployeeUuid,
      employee_id   as EmployeeId,
      first_name    as FirstName,
      last_name     as LastName,
      concat_with_space( first_name, last_name, 1 ) as Name

  // optional: Suchfelder
}
