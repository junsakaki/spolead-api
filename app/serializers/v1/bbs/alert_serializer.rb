module V1
  class Bbs::AlertSerializer < ActiveModel::Serializer

    attributes :id,
      :name,
      :content
  end
end
