class PasswordResetMailer < ApplicationMailer
    default :from => ENV["REPORT_FROM"]

    def send_reset_email(user, password)
        @user = user
        @password = password
        mail( :to => user.email,
        :subject => 'パスワードをリセットしました。' )
    end
end
