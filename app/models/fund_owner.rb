class FundOwner < ApplicationRecord
    belongs_to :user
    belongs_to :fund
end
