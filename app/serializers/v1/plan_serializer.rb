module V1
  class PlanSerializer < ActiveModel::Serializer
    attributes :id, 
      :name, 
      :caption,
      :price
  end
end
