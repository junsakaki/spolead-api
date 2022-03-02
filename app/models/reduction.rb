class Reduction < ApplicationRecord
    attr_accessor :purhcased_count, :total_price
    has_many :purchases, class_name: 'UsersReductionsPurchase'
    belongs_to :fund
    
    def purhcased_count
        # 一応同じuser_idはかぶらないようにする
        (self.purchases.group(:user_id).size).length
    end

    def total_price
        self.purchases.pluck(:amount).sum
    end
    
end
