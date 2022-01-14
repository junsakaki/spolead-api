class Team < ApplicationRecord
  has_many :reviews
  has_many :celebrities
  has_many :careers

  belongs_to :user

  scope :search_columns, ->(search_word) do
    where('name like ?', "%#{search_word}%").
      or(where('prefecture like ?', "%#{search_word}%")).
        or(where('city like ?', "%#{search_word}%")).
          or(where('street_number like ?', "%#{search_word}%"))
  end
  
  after_find do |team|
    team.city_codes = team.city_codes.split(',') if team.city_codes.present?
    team.team_type = team.team_type.split(',') if team.team_type.present?
    team.target_age_type = team.target_age_type.split(',') if team.target_age_type.present?
  end
  # want to refactor with using below 

  # scope :search_columns, ->(columns, params) do
  #   search_word = "%#{params}%"
  #   conditon = nil
  #   columns.each do |column|
  #     condition = condition.nil? ? arel_table[column].matches(search_word) : condition.or(arel_table[column].matches(search_word))
  #   end
  
  #   where(condition)
  # end
  
end
