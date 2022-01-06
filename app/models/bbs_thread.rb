class BbsThread < ApplicationRecord
  self.table_name = "threads"
  attr_accessor :comments_count
  belongs_to :bbs_forum, :foreign_key => 'forum_id'
  has_many :bbs_comments, :foreign_key => 'thread_id'

  scope :search_columns, ->(search_word) do
    where('name like ?', "%#{search_word}%").
      or(where('content like ?', "%#{search_word}%"))
  end

  def views_count_up!
    self.views += 1
    save
  end

  def comments_count
    self.bbs_comments.size
  end
end
