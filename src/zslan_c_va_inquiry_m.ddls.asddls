@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@EndUserText.label: 'Projection View Inquiries Manager'
@Metadata.allowExtensions: true

define view entity ZSLAN_C_VA_INQUIRY_M as projection on ZSLAN_R_VA_INQUIRY
{
    key InquiryUuId,
    ApplicantUuid,
    ApproverUuid,
    BeginDate,
    EndDate,
    @ObjectModel.text.element: [ 'StatusText' ]
    Status,
    StatusText,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    CommentText,
    vacationdays,
    
    
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
        
    
    StatusCriticality,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'zslan_i_employeetext', element: 'Name' } }]
    ApplicantName,
    ApproverName,
       
    
    /* Associations */
    _Applicant : redirected to parent ZSLAN_C_EMPLOYEE_M,
    _Approver : redirected to ZSLAN_C_EMPLOYEE_M
}
