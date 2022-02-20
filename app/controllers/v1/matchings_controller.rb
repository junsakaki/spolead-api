module V1
  class MatchingsController < ApplicationController

    def index
      matchings = Matching.includes(:matching_owner)
      paginated_matchings = pagenate(matchings, params[:page])

      render json: paginated_matchings, each_serializer: V1::MatchingSerializer, admin: false, meta: paginated_matchings.total_pages
    end

    def manage_index
      matchings = Matching.includes(:matching_owner)
      paginated_matchings = pagenate(matchings, params[:page])

      render json: paginated_matchings, each_serializer: V1::MatchingSerializer, admin: true, meta: paginated_matchings.total_pages
    end
    
    def show
      render json: Matching.find(params[:id]), serializer: V1::MatchingSerializer
    end

    def create
      matching = Matching.new(
        name: params[:name],
        caption: params[:caption],
        image_top: params[:imageTop],
        image_sub: params[:imageSub],
        content: params[:content],
        background: params[:background],
        self_introduction: params[:selfIntroduction],
        precautions: params[:precautions]
      )

      if params[:owner].present?
        matching.build_matching_owner(
          matching_id: matching.id,
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

      if matching.save!
        render 200
      else
        render 500
      end
    end

    def update
      matching = Matching.find(params[:id])
      matching.name = params[:name]
      matching.caption = params[:caption]
      matching.image_top = params[:imageTop]
      matching.image_sub = params[:imageSub]
      matching.content = params[:content]
      matching.background = params[:background]
      matching.self_introduction = params[:selfIntroduction]
      matching.precautions = params[:precautions]

      matching.matching_owner = matching.upsert_owner(owner_params) if params[:owner].present?

      if matching.save
        render 200
      else
        render 500
      end
    end

    def approval
      matching = Matching.find(params[:id])
      matching.approval = !matching.approval
      if matching.save
        render 200
      else
        render 500
      end
    end

    private
    def matching_params
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
