module V1
  class TeamSerializer < ActiveModel::Serializer
    has_many :reviews, serializer: V1::ReviewSerializer

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
      :average_point
      # :latest_review_date

      # def id
      #   object[0]
      # end
      
      # def name
      #   object[1]
      # end
      
      # def mail_address
      #   object[2]
      # end
      
      # def team_image
      #   object[3]
      # end
      
      # def sports_id
      #   object[4]
      # end
      
      # def prefecture
      #   object[5]
      # end
      
      # def prefecture_code
      #   object[6]
      # end
      
      # def city
      #   object[7]
      # end
      
      # def city_code
      #   object[8]
      # end
      
      # def street_number
      #   object[9]
      # end
      
      # def team_type
      #   object[10]
      # end
      
      # def target_age_type
      #   object[11]
      # end
      
      # def team_information
      #   object[12]
      # end
      # def created_at
      #   object[13]
      # end

      # def updated_at
      #   object[14]
      # end
      
  end
end
