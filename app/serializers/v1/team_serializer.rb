module V1
  class TeamSerializer < ActiveModel::Serializer
    attributes :id, :name, :team_image, :sports_id, :address, :team_type, :target_age_type, :team_information, :created_at, :updated_at
  end
end
