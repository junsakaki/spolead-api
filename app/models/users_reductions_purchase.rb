class UsersReductionsPurchase < ApplicationRecord
    belongs_to :user
    belongs_to :reduction
    delegate :fund, to: :reduction
end
