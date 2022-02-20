module V1
  class SalonsController < ApplicationController

    def index
      salons = Salon.includes(:plans, :salon_owner)
      paginated_salons = pagenate(salons, params[:page])

      render json: paginated_salons, each_serializer: V1::SalonSerializer, admin: false, meta: paginated_salons.total_pages
    end

    def manage_index
      salons = Salon.includes(:plans, :salon_owner)
      paginated_salons = pagenate(salons, params[:page])

      render json: paginated_salons, each_serializer: V1::SalonSerializer, admin: true, meta: paginated_salons.total_pages
    end
    
    def show
      render json: Salon.find(params[:id]), serializer: V1::SalonSerializer
    end

    def create
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

      if params[:plan].present?
        params[:plan].each {|each_plan|
            salon.plans.build(
                name: each_plan[:name],
                salon_id: salon.id,
                caption: each_plan[:caption],
                price: each_plan[:price]
            )
        }
      end 

      if params[:owner].present?
        salon.build_salon_owner(
          salon_id: salon.id,
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

      if salon.save!
        render 200
      else
        render 500
      end
    end

    def update
      salon = Salon.find(params[:id])
      salon.name = params[:name]
      salon.caption = params[:caption]
      salon.image_top = params[:imageTop]
      salon.image_sub = params[:imageSub]
      salon.content = params[:content]
      salon.background = params[:background]
      salon.self_introduction = params[:selfIntroduction]
      salon.precautions = params[:precautions]

      salon.plans = salon.upsert_plans(params[:plans]) if params[:plans].present?
      salon.salon_owner = salon.upsert_owner(params[:owner]) if params[:owner].present?

      if salon.save
        render 200
      else
        render 500
      end
    end

    def approval
      salon = Salon.find(params[:id])
      salon.approval = !salon.approval
      if salon.save
        render 200
      else
        render 500
      end
    end

    def participate
      participation = UsersSalonsParticipation.new(
        salon_id: params[:id],
        user_id: params[:user_id]
      )
      if participation.save
        render 200
      else
        render 500
      end
    end

    def cancel
      begin
        UsersSalonsParticipation.find_by(salon_id: params[:id], user_id: params[:user_id]).destroy
        render 200
      rescue
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
          :user_id,
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
