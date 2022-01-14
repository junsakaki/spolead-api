module V1
  class CareersController < ApplicationController

    def create
      Rails.logger.info "@@@@@@@@@@@@@@@@"
      begin
        @career = Career.new params
        @career.save!

        render status: 200
      rescue => e
        Rails.logger.info "error log: #{e}"
        render json: {}, status: :unprocessable_entity
      end
    end

    private

    def params
      params.permit(
        :team_id,
        :content
      )
    end
  end
end