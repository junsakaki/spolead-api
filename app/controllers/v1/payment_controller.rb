module V1
  class PaymentController < ApplicationController
    require 'payjp'

    def create_customer
      begin 
        Payjp::Customer.create(
          card: params[:token]
        )
        render json: {date: charge}, status: 200
      rescue => e
        render json: {error: e}, status: 500
      end
    end
    
    def plan
      begin 
        Payjp::Plan.create(
          amount: params[:amount],
          currency: 'jpy',
          interval: params[:interval]
        )
        render json: {date: charge}, status: 200
      rescue => e
        render json: {error: e}, status: 500
      end
    end

    def pay
      begin 
        if params[:type] == 'charge'
          charge = Payjp::Charge.create(
            :amount => params[:amount],
            :card => params[:token],
            :currency => 'jpy',
          )
        else
          charge = Payjp::Subscription.create(
            :plan => params[:plan],
            :customer => params[:customer]
          )
        end
        render json: {date: charge}, status: 200
      rescue => e
        render json: {error: e}, status: 500
      end
    end

    private
    def matching_params
        params.permit(
          :token,
          :type,
          :interval,
          :amount,
          :plan,
          :customer
        )
    end
  end
end
