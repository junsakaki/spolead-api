module V1
  class ReductionSerializer < ActiveModel::Serializer
    attributes :id, 
      :name, 
      :caption,
      :price,
      :purhcased_count,
      :payment_id
  end
end
