CLASS lhc_Employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.


    METHODS get_global_authorization FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorization FOR zslan_r_employee RESULT result.
      METHODS get_global_authorization_i FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorization FOR zslan_r_va_inquiry RESULT result.

    METHODS ApproveVacationRequest FOR MODIFY
      IMPORTING keys FOR ACTION zslan_R_VA_INQUIRY~ApproveVacationRequest RESULT result.

    METHODS DeclineVacationRequest FOR MODIFY
      IMPORTING keys FOR ACTION zslan_R_VA_INQUIRY~DeclineVacationRequest RESULT result.

    METHODS DetermineStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zslan_R_VA_INQUIRY~DetermineStatus.

    METHODS DetermineVacationDays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zslan_R_VA_INQUIRY~DetermineVacationDays.

    METHODS ValidateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zslan_R_VA_INQUIRY~ValidateDates.

    METHODS ValidateVacDays FOR VALIDATE ON SAVE
      IMPORTING keys FOR zslan_R_VA_INQUIRY~ValidateVacDays.

ENDCLASS.

CLASS lhc_Employee IMPLEMENTATION.

  METHOD get_global_authorization.
  ENDMETHOD.
  METHOD get_global_authorization_i.
  Endmethod.
  METHOD ApproveVacationRequest.
    DATA message TYPE REF TO zslan_CM_VAINQUIRY.

    " Read Inquiry
    READ ENTITY IN LOCAL MODE zslan_r_va_inquiry
         FIELDS ( Status CommentText )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    " Process Inquiry
    LOOP AT vacrequests REFERENCE INTO DATA(vacrequest).

      " Validate State and Create Error Message
      IF vacrequest->Status = 'A'.
        message = NEW zslan_cm_vainquiry( textid   = zslan_cm_vainquiry=>vacrequest_already_declined
                                          severity = if_abap_behv_message=>severity-error
                                          comment  = vacrequest->CommentText ).
        APPEND VALUE #( %tky = vacrequest->%tky
                        %msg = message ) TO reported-zslan_r_va_inquiry.
        APPEND VALUE #( %tky = vacrequest->%tky ) TO failed-zslan_r_va_inquiry.
        DELETE vacrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF vacrequest->Status = 'G'.
        message = NEW zslan_cm_vainquiry( textid   = zslan_cm_vainquiry=>vacrequest_already_approved
                                          severity = if_abap_behv_message=>severity-error
                                          comment  = vacrequest->CommentText ).
        APPEND VALUE #( %tky = vacrequest->%tky
                        %msg = message ) TO reported-zslan_r_va_inquiry.
        APPEND VALUE #( %tky = vacrequest->%tky ) TO failed-zslan_r_va_inquiry.
        DELETE vacrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to G und Create Success Message
      vacrequest->Status = 'G'.
      message = NEW zslan_cm_vainquiry(
           textid = zslan_cm_vainquiry=>vacrequest_approved
          severity = if_abap_behv_message=>severity-success
         comment = vacrequest->CommentText
    ).
      APPEND VALUE #( %tky = vacrequest->%tky %msg = message ) TO reported-zslan_r_va_inquiry.
    ENDLOOP.

    " Modify Inquiry
    MODIFY ENTITY IN LOCAL MODE zslan_r_va_inquiry
           UPDATE FIELDS ( Status )
           WITH VALUE #( FOR lr IN vacrequests
                         ( %tky = lr-%tky Status = lr-Status ) ).

    " Set Result
    result = VALUE #( FOR lr IN vacrequests
                      ( %tky = lr-%tky %param = lr ) ).
  ENDMETHOD.

  METHOD DeclineVacationRequest.
    DATA message TYPE REF TO zslan_cm_vainquiry.

    " Read Inquiry
    READ ENTITY IN LOCAL MODE zslan_r_va_inquiry
        FIELDS ( Status CommentText )
        WITH CORRESPONDING #( keys )
        RESULT DATA(vacrequests).

    " Process Inquiry
    LOOP AT vacrequests REFERENCE INTO DATA(vacrequest).

      " Validate State and Create Error Message
      IF vacrequest->Status = 'A'.
        message = NEW zslan_cm_vainquiry(
            textid = zslan_cm_vainquiry=>vacrequest_already_declined
             severity = if_abap_behv_message=>severity-error
             comment  = vacrequest->CommentText
         ).
        APPEND VALUE #( %tky = vacrequest->%tky %msg = message ) TO reported-zslan_r_va_inquiry.
        APPEND VALUE #( %tky = vacrequest->%tky ) TO failed-zslan_r_va_inquiry.
        DELETE vacrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF vacrequest->Status = 'G'.
        message = NEW zslan_cm_vainquiry(
            textid = zslan_cm_vainquiry=>vacrequest_already_approved
            severity = if_abap_behv_message=>severity-error
            comment  = vacrequest->CommentText
        ).
        APPEND VALUE #( %tky = vacrequest->%tky %msg = message ) TO reported-zslan_r_va_inquiry.
        APPEND VALUE #( %tky = vacrequest->%tky ) TO failed-zslan_r_va_inquiry.
        DELETE vacrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set State to A und Create Success Message
      vacrequest->Status = 'A'.
      message = NEW zslan_cm_vainquiry(
         textid = zslan_cm_vainquiry=>vacrequest_decline
         severity = if_abap_behv_message=>severity-success
         comment = vacrequest->CommentText
      ).
      APPEND VALUE #( %tky = vacrequest->%tky %msg = message ) TO reported-zslan_r_va_inquiry.
    ENDLOOP.

    " Modify Inquiry
    MODIFY ENTITY IN LOCAL MODE zslan_r_va_inquiry
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR lr IN vacrequests ( %tky = lr-%tky Status = lr-Status ) ).

    " Set Result
    result = VALUE #( FOR lr IN vacrequests ( %tky = lr-%tky %param = lr ) ).
  ENDMETHOD.

  METHOD DetermineStatus.
    " Read Inquiries
    READ ENTITY IN LOCAL MODE zslan_r_va_inquiry
         FIELDS ( Status )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    " Modify Inquiries
    MODIFY ENTITY IN LOCAL MODE zslan_r_va_inquiry
           UPDATE FIELDS ( Status )
           WITH VALUE #( FOR vr IN vacrequests
                         ( %tky   = vr-%tky
                           Status = 'B' ) ).
  ENDMETHOD.

  METHOD DetermineVacationDays.
    " Read Inquiries
    READ ENTITY IN LOCAL MODE Zslan_r_va_inquiry
         FIELDS ( BeginDate EndDate )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    LOOP AT vacrequests INTO DATA(vacrequest).

      DATA(begindate) = vacrequest-Begindate.
      begindate = begindate - 1.
      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = begindate iv_end = vacrequest-EndDate ).
        CATCH cx_fhc_runtime.
      ENDTRY.

      MODIFY ENTITY IN LOCAL MODE zslan_r_va_inquiry
             UPDATE FIELDS ( Vacationdays )
             WITH VALUE #( FOR vr IN vacrequests
                           ( %tky   = vr-%tky
                             vacationdays = working_days ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateDates.
    DATA message TYPE REF TO zslan_cm_vainquiry.
    DATA(lo_context_info) = NEW cl_abap_context_info( ).
    DATA(lv_current_date) = lo_context_info->get_system_date( ).

    " Read Travels
    READ ENTITY IN LOCAL MODE zslan_r_va_inquiry
         FIELDS ( BeginDate EndDate )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    " Process Travels
    LOOP AT vacrequests INTO DATA(vacrequest).
      " Validate Dates and Create Error Message
      IF vacrequest-EndDate < vacrequest-BeginDate.
        message = NEW zslan_cm_vainquiry( textid = zslan_cm_vainquiry=>vacrequest_endbeforestart
        severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = vacrequest-%tky
                        %msg = message ) TO reported-zslan_r_va_inquiry.
        APPEND VALUE #( %tky = vacrequest-%tky ) TO failed-zslan_r_va_inquiry.
      ENDIF.

      IF vacrequest-BeginDate < lv_current_date.
        message = NEW zslan_cm_vainquiry( textid = zslan_cm_vainquiry=>vacrequest_startdatepast
        severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = vacrequest-%tky
                        %msg = message ) TO reported-zslan_r_va_inquiry.
        APPEND VALUE #( %tky = vacrequest-%tky ) TO failed-zslan_r_va_inquiry.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateVacDays.
    DATA message TYPE REF TO zslan_cm_vainquiry.

    " Read Travels
    READ ENTITY IN LOCAL MODE zslan_r_va_inquiry
         FIELDS ( BeginDate EndDate ApplicantName )
         WITH CORRESPONDING #( keys )
         RESULT DATA(vacrequests).

    " Process Travels
    LOOP AT vacrequests INTO DATA(vacrequest).
      TRY.
          DATA(startdate) = vacrequest-begindate.
          startdate -= 1.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = startdate
                                                                         iv_end   = vacrequest-EndDate ).
        CATCH cx_fhc_runtime.
      ENDTRY.

      SELECT FROM zslan_r_employee
           FIELDS  AvailableVacationDays
           WHERE Employeeuuid = @vacrequest-ApplicantUuid
           INTO @DATA(availablevacationdays).
      ENDSELECT.

      IF AvailableVacationDays < working_days.
        message = NEW zslan_cm_vainquiry( textid   = zslan_cm_vainquiry=>vacrequest_novacationleft
                                          severity = if_abap_behv_message=>severity-error ).
        APPEND VALUE #( %tky = vacrequest-%tky
                        %msg = message ) TO reported-zslan_r_va_inquiry.
        APPEND VALUE #( %tky = vacrequest-%tky ) TO failed-zslan_r_va_inquiry.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
