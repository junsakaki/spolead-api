class BbsReportMailer < ApplicationMailer
    default :from => ENV["REPORT_FROM"]

    def send_report_email(report)
      @report = report
      mail( :to => ENV["REPORT_TO"],
      :subject => 'コメントが通報されました' )
    end
end
