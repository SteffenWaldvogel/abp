@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Uuid Value Help'
define view entity zslan_i_employeeuuidvh
  as select from zslan_employee
{
      /* Fields */
      @EndUserText: { label: 'Employee Uuid', quickInfo: 'Employee Uuid' }
  key employee_uuid                                        as EmployeeUuid,
  
      @EndUserText: { label: 'Employee Id', quickInfo: 'Employee Id' }
      employee_id as EmployeeNumber,
      
      @EndUserText: { label: 'First name', quickInfo: 'First Name' }
      first_name                                         as FirstName,
      
      @EndUserText: { label: 'Surname', quickInfo: 'Last Name' }
      last_name                                          as LastName
}
