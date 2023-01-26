class RequestWithdrawalMailer < ApplicationMailer
    default :from => ENV["REPORT_FROM"]

    def send_request_email(userId, account, amount)
        @user = User.find(userId)
        @user_id = userId
        @user_email = @user[:email]
        @user_nickname = @user[:nickname] 
        @account = account
        @amount = amount
        mail( :to => ENV["REPORT_TO"],
        :subject => '出金依頼がありました。' )
    end

end
