class Team < ApplicationRecord
  has_many :reviews

  scope :search_columns, ->(search_word) do
    where('name like ?', "%#{search_word}%").
      or(where('prefecture like ?', "%#{search_word}%")).
        or(where('city like ?', "%#{search_word}%")).
          or(where('street_number like ?', "%#{search_word}%"))
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
