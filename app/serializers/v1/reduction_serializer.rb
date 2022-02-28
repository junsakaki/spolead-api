module V1
  class ReductionSerializer < ActiveModel::Serializer
    attributes :id, 
      :name, 
      :caption,
      :amount,
      :purhcased_count
  end
end
