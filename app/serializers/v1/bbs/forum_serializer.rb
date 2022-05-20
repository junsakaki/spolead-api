module V1
  class Bbs::ForumSerializer < ActiveModel::Serializer

    attributes :id,
      :name,
      :user_name,
      :content,
      :thread_count,
      :comments_count

    has_many :bbs_threads, serializer: V1::Bbs::ThreadSerializer, parent: false, key: :thread, if: -> { instance_options[:children] }

    def comments_count
      counter = 0
      object.bbs_threads.each do |thread|
        counter += BbsComment.where(thread_id: thread.id).size
      end
      counter
    end
  end
end
