class OrganizerServiceApplyMailer < ApplicationMailer
    default :from => ENV["REPORT_FROM"]

    def send_apply_email()
        mail( :to => ENV["REPORT_TO"],
        :subject => '主催者からサービス利用申請がありました' )
    end
end
