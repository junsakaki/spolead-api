module V1
  class FundsController < ApplicationController

    def index
      funds = Fund.includes(:reductions, :fund_owner).where(approval: true)
      paginated_funds = pagenate(funds, params[:page])

      render json: paginated_funds, each_serializer: V1::FundSerializer, admin: false, meta: paginated_funds.total_pages
    end

    def manage_index
      funds = Fund.includes(:reductions, :fund_owner)
      paginated_funds = pagenate(funds, params[:page])

      render json: paginated_funds, each_serializer: V1::FundSerializer, admin: true, meta: paginated_funds.total_pages
    end
    
    def show
      render json: Fund.find(params[:id]), serializer: V1::FundSerializer
    end

    def create
      fund = Fund.new(
        name: params[:name],
        caption: params[:caption],
        image_top: params[:image_top],
        image_sub: params[:image_sub],
        content: params[:content],
        background: params[:background],
        self_introduction: params[:self_introduction],
        precautions: params[:precautions],
        target_money: params[:target_money],
        limit_date: params[:limit_date]
      )

      if params[:reductions].present?
        params[:reductions].each {|each_reduction|
            fund.reductions.build(
                name: each_reduction[:name],
                fund_id: fund.id,
                caption: each_reduction[:caption],
                amount: each_reduction[:amount]
            )
        }
      end 

      if params[:owner].present?
        fund.build_fund_owner(
          fund_id: fund.id,
          user_id: params[:owner][:user_id],
          name: params[:owner][:name],
          address: params[:owner][:address],
          mail_address: params[:owner][:mail_address],
          birthday: params[:owner][:birthday],
          tel: params[:owner][:tel],
          identification_1: params[:owner][:identification_1],
          identification_2: params[:owner][:identification_2],
          transfer_account: params[:owner][:transfer_account]
        )
      end

      if fund.save!
        render 200
      else
        render 500
      end
    end

    def update
      fund = Fund.find(params[:id])
      fund.name = params[:name]
      fund.caption = params[:caption]
      fund.image_top = params[:image_top]
      fund.image_sub = params[:image_sub]
      fund.content = params[:content]
      fund.background = params[:background]
      fund.self_introduction = params[:self_introduction]
      fund.precautions = params[:precautions]
      fund.target_money = params[:target_money]
      fund.limit_date = params[:limit_date]

      fund.reductions = fund.upsert_reductions(params[:reductions]) if params[:reductions].present?
      fund.fund_owner = fund.upsert_owner(params[:owner]) if params[:owner].present?

      if fund.save
        render 200
      else
        render 500
      end
    end

    def approval
      fund = Fund.find(params[:id])
      fund.approval = !fund.approval
      if fund.save
        render 200
      else
        render 500
      end
    end

    def purchase
      purchase = UsersReductionsPurchase.new(
        reduction_id: params[:id],
        user_id: params[:user_id],
        amount: params[:amount],
        payment_id: params[:payment_id],
        count: params[:count]
      )
      if purchase.save!
        render 200
      else
        render 500
      end
    end

    private
    def fund_params
        params.permit(
          :id,
          :name,
          :caption,
          :image_top, 
          :iamge_sub, 
          :content, 
          :background,
          :self_introduction,
          :precautions,
          :target_money,
          :limit_date,
          :user_id,
          :price,
          :amount,
          :count,
          :payment_id,
          reductions: [
            :id,
            :name,
            :caption,
            :price,
            :amount
          ],
          owner: [
            :id,
            :user_id,
            :name,
            :address,
            :mail_address,
            :birthday,
            :tel,
            :identification_1,
            :identification_2,
            :transfer_account
          ])
    end  
  end
end
