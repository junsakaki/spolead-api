class BbsForum < ApplicationRecord
    attr_accessor :thread_count, :comments_count
    has_many :bbs_threads

    def comments_count
      counter = 0
      self.bbs_threads { |thread|
        counter += BbsComment.where(bbs_thread_id: thread.id).count
      }
      counter
    end

    def thread_count
      self.bbs_threads.size
    end
end
