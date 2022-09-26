class RequestWithdrawalMailer < ApplicationMailer
    default :from => ENV["REPORT_FROM"]

    def send_request_email(user, amount)
        @user = user
        @amount = amount
        mail( :to => ENV["REPORT_TO"],
        :subject => '出金依頼がありました。' )
    end

end
