module V1
  class TeamSerializer < ActiveModel::Serializer
    attributes :id, 
      :name, 
      :mail_address,
      :team_image, 
      :sports_id, 
      :prefecture, 
      :city,
      :street_number,
      :team_type, 
      :target_age_type, 
      :team_information, 
      :created_at, 
      :updated_at
  end
end
