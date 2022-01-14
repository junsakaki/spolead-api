module V1
  class Bbs::ThreadSerializer < ActiveModel::Serializer

    attributes :id,
      :name,
      :user_name,
      :content,
      :views,
      :comments_count,
      :created_at

    has_many :bbs_comments, key: :comments, serializer: V1::Bbs::CommentSerializer
    belongs_to :bbs_forum, key: :forum, serializer: V1::Bbs::ForumSerializer
  end
end
