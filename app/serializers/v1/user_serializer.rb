module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :created_at, :updated_at, :role, :salons, :funds, :lessons
    has_many :fav, key: :favorite_teams

    def salons
      participating_array = []
      participatings = object.participating
      participatings.each{|participating|
        owner = participating.salon_owner
        plans = participating.plans
        participating_hash = participating.attributes
        participating_hash[:owner] = owner
        participating_hash[:plans] = plans
        participating_array.push(participating_hash)
      }
      result = {  
        owned: object.fund_owned,
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
      lessons = object.lesson_owned
      lessons.each{|lesson|
        owner = lesson.lesson_owner
        lesson_hash = lesson.attributes
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
