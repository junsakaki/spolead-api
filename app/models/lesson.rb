class Lesson < ApplicationRecord
    has_one :lesson_owner
    has_many :lessons_talk_rooms

    def lesson_amount(term = nil)
        result_amount = 0
        rooms = term.present? ? lessons_talk_rooms.includes([{comments: [:payment]}]).where(created_at: (term)..(term.end_of_month)) : lessons_talk_rooms.includes([{comments: [:payment]}])
        rooms.each{|room|
            room.comments.each{|comment|
                result_amount += comment.payment.amount
            }
        }
        result_amount
    end

    def upsert_owner(owner)
        new_owner = LessonOwner.find_or_initialize_by(id: owner[:id])
        new_owner.update(
            lesson_id: self.id,
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
