class Matching < ApplicationRecord
    has_one :matching_owner
    # has_many :talks_comments


    def upsert_owner(owner)
        new_owner = MatchingOwner.find_or_initialize_by(id: owner[:id])
        new_owner.update(
            matching_id: self.id,
            user_id: owner[:user_id],
            name: owner[:name],
            address: owner[:address],
            mail_address: owner[:mail_address],
            birthday: owner[:birthday],
            tel: owner[:tel],
            identification_1: owner[:identification_1],
            identification_2: owner[:identification_2],
            transfer_account: owner[:transfer_account]
        )
        if new_owner.new_record?
            new_owner.save
            new_owner = nil
        end
        new_owner
    end
end
