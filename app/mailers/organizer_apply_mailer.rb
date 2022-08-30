class OrganizerApplyMailer < ApplicationMailer
    default :from => ENV["REPORT_FROM"]

    def send_apply_email(organizer_info)
        @organizer_info = organizer_info
        mail( :to => ENV["REPORT_TO"],
        :subject => '主催者の新規申し込みがありました。' )
    end
end
