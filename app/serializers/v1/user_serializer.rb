module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :created_at, :updated_at, :role, :salons, :funds, :lessons
    has_many :fav, key: :favorite_teams

    def salons
      participating_array = []
      participatings = object.users_salons_participation
      participatings.each{|participating|
        owner = participating.salon.salon_owner
        plans = participating.plan
        participating_hash = participating.salon.attributes
        participating_hash[:owner] = owner
        participating_hash[:plans] = plans
        participating_array.push(participating_hash)
      }
      result = {  
        owned: object.salon_owned,
        participating: participating_array
      }
      return result
    end

    def funds
      purchased_array = []
      purchased = object.users_reductions_purchases
      purchased.each{|purchase|
        owner = purchase.reduction.fund.fund_owner.attributes
        reduction = purchase.reduction
        purchase_hash = purchase.attributes
        purchase_hash[:owner] = owner
        purchase_hash[:reduction] = reduction
        purchased_array.push(purchase_hash)
      }
      result = {  
        owned: object.fund_owned,
        purchased: purchased_array
      }
      return result
    end

    def lessons
      lessons_array = []
      lesson = object.lesson_owned
      lesson.each{|l|
        owner = l.lesson_owner
        lesson_hash = l.attributes
        lesson_hash[:owner] = owner
        lessons_array.push(lesson_hash)
      }
      result = {  
        lessons: lessons_array
      }
      return result
    end

  end
end
