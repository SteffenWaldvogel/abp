@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Basic View'
define root view entity ZSLAN_R_EMPLOYEE
  as select from zslan_employee

  association [1..1] to ZSLAN_i_EmployeeText          as _EmployeeText on $projection.EmployeeUuid = _EmployeeText.EmployeeUuid
  composition [0..*] of ZSLAN_R_VA_CLAIM              as _Claim
  composition [0..*] of ZSLAN_R_VA_INQUIRY            as _Inquiry
  association [1..*] to ZSLAN_R_VA_INQUIRY            as _Applicant    on $projection.EmployeeUuid = _Applicant.ApplicantUuid
  association [1..*] to ZSLAN_R_VA_INQUIRY            as _Approver     on $projection.EmployeeUuid = _Approver.ApproverUuid
  association [1..1] to zslan_i_availablevacationdays as _availablevd  on $projection.EmployeeUuid = _availablevd.Employee
  association [1..1] to zslan_i_plannedvacationdays   as _plannedvd    on $projection.EmployeeUuid = _plannedvd.employee
  association [1..1] to ZSLAN_I_CONSUMEDVACATIONDAYS  as _consumedvd   on $projection.EmployeeUuid = _consumedvd.employee
{
      @ObjectModel.text.element: ['Employeename']
  key employee_uuid                      as EmployeeUuid,
      employee_id                        as EmployeeId,
      first_name                         as FirstName,
      last_name                          as LastName,
      entry_date                         as EntryDate,
      created_by                         as CreatedBy,
      created_at                         as CreatedAt,
      last_changed_by                    as LastChangedBy,
      last_changed_at                    as LastChangedAt,

      _consumedvd.ConsumedVacationDays   as ConsumedVacationDays,
      _plannedvd.PlannedVacationDays     as PlannedVacationDays,
      _availablevd.AvailableVacationDays as AvailableVacationDays,

      _Claim,
      _Approver,
      _Applicant,
      _Inquiry,

      _EmployeeText.Name                 as EmployeeName

}
