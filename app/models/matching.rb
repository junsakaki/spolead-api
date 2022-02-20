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
