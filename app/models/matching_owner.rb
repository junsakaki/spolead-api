class MatchingOwner < ApplicationRecord
    belongs_to :user
    belongs_to :matching
end
