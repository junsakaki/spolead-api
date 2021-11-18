module V1
  class Bbs::CommentSerializer < ActiveModel::Serializer

    attributes :id,
      :content,
      :bbs_thread_id,
      :user_name
  end
end
