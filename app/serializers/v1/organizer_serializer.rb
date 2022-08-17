module V1
  class OrganizerSerializer < ActiveModel::Serializer
    attributes :email, :owned
    
    def owned
      salon_owned_array = []
      object.salon_owned.each{|own_salon|
        owner = own_salon.salon_owner
        owner_hash = own_salon.attributes
        owner_hash[:owner] = owner
        salon_owned_array.push(owner_hash)
      }
      fund_owned_array = []
      object.fund_owned.each{|own_fund|
        owner = own_fund.fund_owner
        owner_hash = own_fund.attributes
        owner_hash[:owner] = owner
        fund_owned_array.push(owner_hash)
      }
      lessons_array = []
      lesson = object.lesson_owned
      lesson.each{|l|
        owner = l.lesson_owner
        lesson_hash = l.attributes
        lesson_hash[:owner] = owner
        lessons_array.push(lesson_hash)
      }
      result = {  
        funds: fund_owned_array,
        salons: salon_owned_array,
        lessons: lessons_array
      }
      return result
    end

  end
end
