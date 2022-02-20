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
      reduction_params = JSON.parse(params[:reductions], symbolize_names: true) if params[:reductions].present?
      owner_params = JSON.parse(params[:owner], symbolize_names: true) if params[:owner].present?
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

      if reduction_params.present?
        reduction_params.each {|each_reduction|
            fund.reductions.build(
                name: each_reduction[:name],
                fund_id: fund.id,
                caption: each_reduction[:caption],
                price: each_reduction[:price]
            )
        }
      end 

      if owner_params.present?
        fund.build_fund_owner(
          fund_id: fund.id,
          user_id: owner_params[:user_id],
          name: owner_params[:name],
          address: owner_params[:address],
          mail_address: owner_params[:mailAddress],
          birthday: owner_params[:birthday],
          tel: owner_params[:tel],
          identification_1: owner_params[:identification1],
          identification_2: owner_params[:identification2],
          transfer_account: owner_params[:transferAccount]
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

      if params[:reductions].present?
        reduction_params = JSON.parse(params[:reductions], symbolize_names: true) 
        fund.reductions = fund.upsert_reductions(reduction_params)
      end
      if params[:owner].present?
        owner_params = JSON.parse(params[:owner], symbolize_names: true)
        fund.fund_owner = fund.upsert_owner(owner_params)
      end

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
