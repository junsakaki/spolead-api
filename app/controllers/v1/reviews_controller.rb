module V1
  class ReviewsController < ApplicationController
    def create
      review = Review.new(reviews_params)

      if review.save
        # when status OK
        render 200
      else
        # when invalid status
        render 500
      end    
    end

    private
    def reviews_params
        params.require(:review).permit(
          :id, 
          :general_post, 
          :general_point,
          :policy_post, 
          :policy_point, 
          :organization_post, 
          :organization_point,
          :activity_post,
          :activity_point, 
          :environment_post, 
          :environment_point, 
          :event_post, 
          :event_point,
          :cost_post,
          :cost_point,
          :team_id,
          :user_id,
          :gender,
          :age_group,
          :enrollment_period,
          :player_flag         
        )
    end  
  end
end
