module V1
  class MatchingsController < ApplicationController

    def index
      matchings = Matching.includes(:matching_owner).where(approval: true)
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
        self_introduction: params[:self_introduction],
        precautions: params[:precautions]
      )

      if params[:owner].present?
        matching.build_matching_owner(
          matching_id: matching.id,
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
      matching.image_top = params[:image_top]
      matching.image_sub = params[:image_sub]
      matching.content = params[:content]
      matching.background = params[:background]
      matching.self_introduction = params[:self_introduction]
      matching.precautions = params[:precautions]

      matching.matching_owner = matching.upsert_owner(params[:owner]) if params[:owner].present?

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
          :image_top, 
          :iamge_sub, 
          :content, 
          :background,
          :self_introduction,
          :precautions,
          :user_id,
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
