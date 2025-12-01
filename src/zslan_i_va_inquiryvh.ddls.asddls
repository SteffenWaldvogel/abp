
@AbapCatalog.sqlViewName: 'ZSLAN_I_VA_INQU'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Helper Vacation Inquiry'
define view ZSLAN_I_VA_INQUIRYVH as select from zslan_va_inquiry
{

    key inquiry_uuid as InquiryUuid,
    applicant_uuid as ApplicantUuid,
    approver_uuid as ApproverUuid,
    begin_date as BeginDate,
    end_date as EndDate,
    vacation_days as VacationDays,
    comment_text as CommentText,
    status as Status,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt
}
