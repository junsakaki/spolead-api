class BbsAlertMailer < ApplicationMailer
    default :from => ENV["ALERT_FROM"]

    def send_alert_email(alert)
      @alert = alert
      mail( :to => ENV["ALERT_TO"],
      :subject => 'コメントが通報されました' )
    end
end
