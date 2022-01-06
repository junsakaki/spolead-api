module V1
  class Bbs::ReportsController < ApplicationController
    def create
      begin
        @report = BbsReport.new report_params
        @report.save!

        BbsReportMailer.send_report_email(@report).deliver_later

        render json: {}, status: 200
      rescue => e
        Rails.logger.info "error log: #{e}"
        render json: {}, status: :unprocessable_entity
      end
    end

    private

    def report_params
      params.permit(
        :user_name,
        :comment_id,
        :content
      )
    end
  end
end