class Fund < ApplicationRecord
    attr_accessor :supported_money, :supporters_count
    has_one :fund_owner
    has_many :reductions

    def upsert_reductions(reductions)
        reductions.map {|reduction|
            new_reduction = Reduction.find_or_initialize_by(id: reduction[:id])
            new_reduction.update(
                name: reduction[:name],
                fund_id: self.id,
                caption: reduction[:caption],
                price: reduction[:price]
            )
            if new_reduction.new_record?
                new_reduction.save
                new_reduction = nil
            end
            new_reduction
        }
    end

    def upsert_owner(owner)
        new_owner = FundOwner.find_or_initialize_by(id: owner[:id])
        new_owner.update(
            fund_id: self.id,
            user_id: owner[:user_id],
            name: owner[:name],
            address: owner[:address],
            mail_address: owner[:mailAddress],
            birthday: owner[:birthday],
            tel: owner[:tel],
            identification_1: owner[:identification1],
            identification_2: owner[:identification2],
            transfer_account: owner[:transferAccount]
        )
        if new_owner.new_record?
            new_owner.save
            new_owner = nil
        end
        new_owner
    end

    def supporters_count
        counter = 0
        self.reductions.each{|r| counter += r.purhcased_count}
        counter
    end

    def supported_money
        counter = 0
        self.reductions.each{|r| counter += r.total_price}
        counter
    end
    
end