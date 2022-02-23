module V1
  class PaymentController < ApplicationController
    require 'payjp'

    def pay
      begin 
        charge = Payjp::Charge.create(
          :amount => 3500,
          :card => params[:token],
          :currency => 'jpy',
        )
        render json: {date: charge}, status: 200
      rescue => e
        render json: {error: e}, status: 500
      end
    end

    private
    def matching_params
        params.permit(
          :token
        )
    end
  end
end
