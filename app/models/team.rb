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

  scope :filter_by_team_type, ->(team_types) do
    team_types = team_types.split(',')
    ids = self.select {|t| 
      next false if t.team_type.blank?
      (t.team_type.split(',') - team_types).size < t.team_type.split(',').size
    }.pluck(:id)
    where(id: ids)
  end

  scope :filter_by_target_age_type, ->(target_age_types) do
    target_age_types = target_age_types.split(',')
    ids = self.select {|t| 
      next false if t.target_age_type.blank?
      (t.target_age_type.split(',') - target_age_types).size < t.target_age_type.split(',').size
    }.pluck(:id)
    where(id: ids)
  end

  scope :filter_by_lat_and_lon, ->(lat, lon) do
    ids = self.select{|t| self.distance(lat, lon, t.latitude, t.longitude)}.pluck(:id)
    where(id: ids)
  end

  def self.distance(lat1, lng1, lat2, lng2)
    return false if lat2.blank? || lng2.blank?
    x1 = lat1.to_f * Math::PI / 180
    y1 = lng1.to_f * Math::PI / 180
    x2 = lat2.to_f * Math::PI / 180
    y2 = lng2.to_f * Math::PI / 180

    radius = 6378.137
    diff_y = (y1 - y2).abs
    calc1 = Math.cos(x2) * Math.sin(diff_y)
    calc2 = Math.cos(x1) * Math.sin(x2) - Math.sin(x1) * Math.cos(x2) * Math.cos(diff_y)
    numerator = Math.sqrt(calc1 ** 2 + calc2 ** 2)
    denominator = Math.sin(x1) * Math.sin(x2) + Math.cos(x1) * Math.cos(x2) * Math.cos(diff_y)
    degree = Math.atan2(numerator, denominator)
    degree * radius <= 10
  end
  # after_find do |team|
  #   team.city_codes = team.city_codes.split(',') if team.city_codes.present?
  #   team.team_type = team.team_type.split(',') if team.team_type.present?
  #   team.target_age_type = team.target_age_type.split(',') if team.target_age_type.present?
  # end
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
