class BbsComment < ApplicationRecord
    self.table_name = "comments"
    belongs_to :bbs_thread, :foreign_key => 'thread_id'

  scope :search_columns, ->(search_word) do
    where('name like ?', "%#{search_word}%").
      or(where('content like ?', "%#{search_word}%"))
  end

end
