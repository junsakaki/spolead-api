module V1
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, 
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
      :user_id,
      :team_id,
      :created_at,
      :gender,
      :age_group,
      :enrollment_period,
      :player_flag
  end
end
