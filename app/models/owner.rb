class Owner < ApplicationRecord
    belongs_to :user
    belongs_to :salon
end
