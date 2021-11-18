module V1
  class Bbs::ThreadSerializer < ActiveModel::Serializer

    attributes :id,
      :name,
      :user_name,
      :content,
      :views,
      :comments_count
  end
end
