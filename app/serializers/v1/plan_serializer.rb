module V1
  class PlanSerializer < ActiveModel::Serializer
    attributes :id, 
      :name, 
      :caption,
      :amount
  end
end
