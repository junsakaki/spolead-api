module V1
  class PlanSerializer < ActiveModel::Serializer
    attributes :id, 
      :name, 
      :caption,
      :amount,
      :salon_id
  end
end
