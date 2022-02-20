module V1
  class FundsController < ApplicationController

    def index
      funds = Fund.includes(:reductions, :fund_owner)
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
        image_top: params[:imageTop],
        image_sub: params[:imageSub],
        content: params[:content],
        background: params[:background],
        self_introduction: params[:selfIntroduction],
        precautions: params[:precautions],
        target_money: params[:targetMoney],
        limit_date: params[:limitDate]
      )

      if params[:reductions].present?
        params[:reductions].each {|each_reduction|
            fund.reductions.build(
                name: each_reduction[:name],
                fund_id: fund.id,
                caption: each_reduction[:caption],
                price: each_reduction[:price]
            )
        }
      end 

      if params[:owner].present?
        fund.build_fund_owner(
          fund_id: fund.id,
          user_id: params[:owner][:user_id],
          name: params[:owner][:name],
          address: params[:owner][:address],
          mail_address: params[:owner][:mailAddress],
          birthday: params[:owner][:birthday],
          tel: params[:owner][:tel],
          identification_1: params[:owner][:identification1],
          identification_2: params[:owner][:identification2],
          transfer_account: params[:owner][:transferAccount]
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
      fund.image_top = params[:imageTop]
      fund.image_sub = params[:imageSub]
      fund.content = params[:content]
      fund.background = params[:background]
      fund.self_introduction = params[:selfIntroduction]
      fund.precautions = params[:precautions]
      fund.target_money = params[:targetMoney]
      fund.limit_date = params[:limitDate]

      fund.reductions = fund.upsert_reductions(reduction_params) if params[:reductions].present?
      fund.fund_owner = fund.upsert_owner(owner_params) if params[:owner].present?

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
        price: params[:price],
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
          :imageTop, 
          :iamgeSub, 
          :content, 
          :background,
          :selfIntroduction,
          :precautions,
          :targetMoney,
          :limitDate,
          :user_id,
          :price,
          :count,
          reductions: [
            :id,
            :name,
            :caption,
            :price
          ],
          owner: [
            :id,
            :user_id,
            :name,
            :address,
            :mailAddress,
            :birthday,
            :tel,
            :identification1,
            :identification2,
            :transferAccount
          ])
    end  
  end
end
