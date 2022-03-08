module V1
  class PlanSerializer < ActiveModel::Serializer
    attributes :id, 
      :name, 
      :caption,
      :amount,
      :plan_id
  end
end
