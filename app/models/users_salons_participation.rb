class UsersSalonsParticipation < ApplicationRecord
    belongs_to :user
    belongs_to :plan
    belongs_to :salon
end
