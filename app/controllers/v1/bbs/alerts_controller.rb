module V1
  class Bbs::AlertsController < ApplicationController
    def create
      begin
        @alert = BbsAlert.new alert_params
        @alert.save!

        BbsAlertMailer.send_alert_email(@alert).deliver_later

        render json: {}, status: 200
      rescue => e
        Rails.logger.info "error log: #{e}"
        render json: {}, status: :unprocessable_entity
      end
    end

    private

    def alert_params
      params.permit(
        :user_name,
        :bbs_comment_id,
        :content
      )
    end
  end
end