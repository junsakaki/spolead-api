class Salon < ApplicationRecord
    has_one :owner
    has_many :plans
    has_many :participations, class_name: 'UsersSalonsParticipation'
    has_many :users, through: :participations
end
