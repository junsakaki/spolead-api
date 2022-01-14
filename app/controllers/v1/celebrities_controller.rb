module V1
  class CelebritiesController < ApplicationController

    def create
      begin
        @celebrity = Celebrity.new params
        @celebrity.save!

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