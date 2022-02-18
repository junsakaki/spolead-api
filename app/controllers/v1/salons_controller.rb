module V1
  class SalonsController < ApplicationController

    def index
      salons = Salon.includes(:plans, :owner)
      # pagenate logic -----------------------------------------------------------------
      page_per = 20 #display team number per 1page
      page = params[:page] || 1 #start page number
      paginated_salons = teams.order(created_at: :desc).page(page).per(page_per) #execute pagenation
      total_pages = paginated_salons.total_pages #obtain all page number that paginated_teams teamss
      # pagenate logic -----------------------------------------------------------------
      
      #meta has total_page infomation
      render json: paginated_salons, each_serializer: V1::SalonSerializer, meta: total_pages
    end

    def create
      plan_params = JSON.parse(params[:plan], symbolize_names: true) if params[:plan].present?
      owner_params = JSON.parse(params[:owner], symbolize_names: true) if params[:owner].present?
      salon = Salon.new(
        name: params[:name],
        caption: params[:caption],
        image_top: params[:imageTop],
        image_sub: params[:imageSub],
        content: params[:content],
        background: params[:background],
        self_introduction: params[:selfIntroduction],
        precautions: params[:precautions]
      )

      if plan_params.present?
        plan_params.each {|each_plan|
            salon.plans.build(
                name: each_plan[:name],
                caption: each_plan[:caption],
                price: each_plan[:price]
            )
        }
      end 

      if owner_params.present?
        salon.build_owner(
          salon_id: salon.id,
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

      if salon.save!
        render 200
      else
        render 500
      end
    end

    private
    def salon_params
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
          plans: [
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
