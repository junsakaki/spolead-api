class RequestWithdrawalMailer < ApplicationMailer
    default :from => ENV["REPORT_FROM"]

    def send_request_email(account, amount)
        @account = account
        @amount = amount
        mail( :to => ENV["REPORT_TO"],
        :subject => '出金依頼がありました。' )
    end

end
