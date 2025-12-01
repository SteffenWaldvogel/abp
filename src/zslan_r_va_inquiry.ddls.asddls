@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vacation Inquiry Basic View'
define view entity ZSLAN_R_VA_INQUIRY
  as select from zslan_va_inquiry
  association        to parent ZSLAN_R_EMPLOYEE as _Applicant             on $projection.ApplicantUuid = _Applicant.EmployeeUuid
  association [1..1] to ZSLAN_R_EMPLOYEE        as _Approver              on $projection.ApproverUuid = _Approver.EmployeeUuid
  association [1..1] to ZSLAN_i_EmployeeText    as _EmployeeNameApplicant on $projection.ApplicantUuid = _EmployeeNameApplicant.EmployeeUuid
  association [1..1] to ZSLAN_i_EmployeeText    as _EmployeeNameApprover  on $projection.ApproverUuid = _EmployeeNameApprover.EmployeeUuid
  association        to ZSLAN_I_StatusText         as _statustext        on $projection.InquiryUuId = _statustext.inquiry_uuid

{
  key inquiry_uuid                as InquiryUuId,

      applicant_uuid              as ApplicantUuid,

      approver_uuid               as ApproverUuid,
      begin_date                  as BeginDate,
      end_date                    as EndDate,
      status                      as Status,
      comment_text                as CommentText,
      vacation_days               as vacationdays,

      /* Administrative Data */
      @Semantics.user.createdBy: true
      created_by                  as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                  as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by             as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at             as LastChangedAt,


      case status when 'G' then 3
            when 'B' then 2
            when 'A' then 1
            else 0
      end                         as StatusCriticality,


      _EmployeeNameApplicant.Name as ApplicantName,
      _EmployeeNameApprover.Name  as ApproverName,
      _statustext.StatusText  as StatusText,
      


      /*Associations*/
      _Applicant,
      _Approver
}
