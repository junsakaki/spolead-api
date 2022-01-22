class BbsForum < ApplicationRecord
    self.table_name = "forums"
    attr_accessor :thread_count
    has_many :bbs_threads, :foreign_key => 'forum_id'

    def thread_count
      self.bbs_threads.size
    end
end
