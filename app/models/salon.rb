class Salon < ApplicationRecord
    has_one :owner
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
            new_plan
        }
    end

    def upsert_owner(owner)
        new_owner = Owner.find_or_initialize_by(id: owner[:id])
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
        new_owner
    end
end
