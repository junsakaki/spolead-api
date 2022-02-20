class Salon < ApplicationRecord
    has_one :salon_owner
    has_many :plans
    has_many :participations, class_name: 'UsersSalonsParticipation'
    has_many :users, through: :participations

    def upsert_plans(plans)
        plans.map {|plan|
            new_plan = Plan.find_or_initialize_by(id: plan[:id])
            new_plan.update(
                name: plan[:name],
                salon_id: self.id,
                caption: plan[:caption],
                price: plan[:price]
            )
            if new_plan.new_record?
                new_plan.save
                new_plan = nil
            end
            new_plan
        }
    end

    def upsert_owner(owner)
        new_owner = SalonOwner.find_or_initialize_by(id: owner[:id])
        new_owner.update(
            salon_id: self.id,
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
end
