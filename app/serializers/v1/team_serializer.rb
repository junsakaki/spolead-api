module V1
  class TeamSerializer < ActiveModel::Serializer
    # include ActiveModel::Serialization

    has_many :reviews, serializer: V1::ReviewSerializer
    has_many :celebrities
    has_many :careers

    attributes :id, 
      :name, 
      :mail_address,
      :team_image, 
      :sports_id, 
      :prefecture, 
      :prefecture_code, 
      :city,
      :city_code,
      :street_number,
      :team_type, 
      :target_age_type, 
      :team_information, 
      :created_at,
      :updated_at,
      :average_point,
      :url,
      :user_id,
      :latitude,
      :longitude,
      :total_pages

    def total_pages(object, **option)
      @total_pages = option[:total_pages]
    end
  
    def total_pages
      @total_pages
    end
  end
end
