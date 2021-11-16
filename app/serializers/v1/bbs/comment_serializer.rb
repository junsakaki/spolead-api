module V1
  class Bbs::CommentSerializer < ActiveModel::Serializer

    attributes :id,
      :name,
      :content,
      :user_name
  end
end
