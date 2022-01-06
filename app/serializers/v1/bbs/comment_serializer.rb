module V1
  class Bbs::CommentSerializer < ActiveModel::Serializer

    attributes :id,
      :content,
      :user_name,
      :reply_to,
      :forum

    belongs_to :bbs_thread, key: :thread

    def forum
      object.bbs_thread.bbs_forum
    end
  end
end
