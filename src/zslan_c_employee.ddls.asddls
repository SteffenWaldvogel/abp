@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Mitarbeiter'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZSLAN_C_EMPLOYEE
provider contract transactional_query
  as projection on ZSLAN_R_EMPLOYEE
  
{
  key EmployeeUuid,
      
      @Search.defaultSearchElement: true
      EmployeeId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      FirstName,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      LastName,

      @Search.defaultSearchElement: true
      EntryDate,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      AvailableVacationDays,
      ConsumedVacationDays,
      PlannedVacationDays,

      /* Associations */
      
      _Claim : redirected to composition child ZSLAN_C_VA_CLAIM,
      _Inquiry  : redirected to composition child ZSLAN_C_VA_INQUIRY




}
