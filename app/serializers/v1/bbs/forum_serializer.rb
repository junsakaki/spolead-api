module V1
  class Bbs::ForumSerializer < ActiveModel::Serializer

    attributes :id,
      :name,
      :user_name,
      :content,
      :thread_count,
      :comments_count
  end
end
