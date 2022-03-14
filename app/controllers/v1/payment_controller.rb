module V1
  class PaymentController < ApplicationController
    require 'payjp'

    def create_customer
      begin 
        charge = Payjp::Customer.create(
          card: params[:token]
        )
        render json: {data: charge}, status: 200
      rescue => e
        render json: {error: e}, status: 500
      end
    end
    
    def plan
      begin 
        charge = Payjp::Plan.create(
          amount: params[:amount],
          currency: 'jpy',
          interval: params[:interval]
        )
        render json: {data: charge}, status: 200
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
        render json: {data: charge}, status: 200
      rescue => e
        render json: {error: e}, status: 500
      end
    end
    
    def cancel
      begin
        if params[:type] == 'charge'
          charge = Payjp::Charge.retrieve(params[:payment_id])
          charge.refund
        else
          charge = Payjp::Subscription.retrieve(params[:payment_id])
          charge.cancel
        end
        render json: {data: charge}, status: 200
      rescue => e
        render json: {error: e}, status: 500
      end
    end

    def api_confirm
      begin 
        charge = Payjp::Charge.all
        render json: {data: charge}, status: 200
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
          :customer,
          :payment_id
        )
    end
  end
end
