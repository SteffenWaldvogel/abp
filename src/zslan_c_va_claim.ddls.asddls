@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Urlaubsanspruch'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZSLAN_C_VA_CLAIM
  as projection on ZSLAN_R_VA_CLAIM

{
  key ClaimUuid,
      EmployeeUuid,
      YearOfClaim,
      VacationDays,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      EmployeeName,
      /* Associations */
      _Employee : redirected to parent ZSLAN_C_EMPLOYEE
}
