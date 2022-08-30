class Plan < ApplicationRecord
    belongs_to :salon
    has_many :participations, class_name: 'UsersSalonsParticipation'
end
