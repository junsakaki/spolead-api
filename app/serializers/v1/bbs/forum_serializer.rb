module V1
  class Bbs::ForumSerializer < ActiveModel::Serializer

    attributes :id,
      :name,
      :user_name,
      :content,
      :thread_count,
      :comments_count

    has_many :bbs_threads, key: :thread, if: -> { instance_options[:children] }
  end
end
