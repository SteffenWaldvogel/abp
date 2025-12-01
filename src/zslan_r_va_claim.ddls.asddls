@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Urlaubsantrag Basic View'
define view entity ZSLAN_R_VA_CLAIM
  as select from zslan_va_claim
  association        to parent ZSLAN_R_EMPLOYEE as _Employee     on $projection.EmployeeUuid = _Employee.EmployeeUuid
  association [1..1] to ZSLAN_i_EmployeeText    as _EmployeeText on $projection.EmployeeUuid = _EmployeeText.EmployeeUuid



{
  key claim_uuid         as ClaimUuid,
      @ObjectModel.text.element: ['EmployeeName']
      employee_uuid      as EmployeeUuid,
      year_of_claim      as YearOfClaim,
      vacation_days      as VacationDays,
      created_by         as CreatedBy,
      created_at         as CreatedAt,
      last_changed_by    as LastChangedBy,
      last_changed_at    as LastChangedAt,

      //Association
      _EmployeeText.Name as EmployeeName,
      _Employee

}
