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
    team.city_codes = team.city_codes.split(',')
    team.team_type = team.team_type.split(',')
    team.target_age_type = team.target_age_type.split(',')
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
