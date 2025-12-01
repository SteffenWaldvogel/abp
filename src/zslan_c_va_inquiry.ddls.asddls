@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Urlaubsantrag'
@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZSLAN_C_VA_INQUIRY
  as projection on ZSLAN_R_VA_INQUIRY
  
   
{
    key InquiryUuId,
    ApplicantUuid,
    @Search.defaultSearchElement: true
    ApplicantName,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'zslan_i_employeeuuidvh', element: 'EmployeeUuid' } }]
    ApproverUuid,
    ApproverName,
    BeginDate,
    EndDate,
    vacationdays,
    CommentText,
    @ObjectModel.text.element: [ 'StatusText' ]
    Status,
    StatusText,
     
    /* Administrative Daten */
    CreatedAt,
    CreatedBy,
    LastChangedAt,
    LastChangedBy,
    
    _Applicant : redirected to parent ZSLAN_C_EMPLOYEE,
    _Approver : redirected to ZSLAN_C_EMPLOYEE
}
