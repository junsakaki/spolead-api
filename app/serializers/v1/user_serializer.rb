module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :email, :created_at, :updated_at, :role, :salons, :funds, :lessons, :favorite_teams
    def favorite_teams
      object.favorite_teams.map{|fav_team|
        fav_team.team
      }
    end

    def salons
      participating_array = []
      participatings = object.users_salons_participation
      participatings.each{|participating|
        owner = participating.salon.salon_owner
        plans = participating.plan
        salon = participating.salon
        participating_hash = participating.attributes
        participating_hash[:owner] = owner
        participating_hash[:plans] = plans
        participating_hash[:salon] = salon
        participating_array.push(participating_hash)
      }
      owned_array = []
      object.salon_owned.each{|own_salon|
        owner = own_salon.salon_owner
        owner_hash = own_salon.attributes
        owner_hash[:owner] = owner
        owned_array.push(owner_hash)
      }
      result = {  
        owned: owned_array,
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
      owned_array = []
      object.fund_owned.each{|own_fund|
        owner = own_fund.fund_owner
        owner_hash = own_fund.attributes
        owner_hash[:owner] = owner
        owned_array.push(owner_hash)
      }
      result = {  
        owned: owned_array,
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
