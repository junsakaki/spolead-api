class BbsComment < ApplicationRecord
    belongs_to :bbs_thread

  scope :search_columns, ->(search_word) do
    where('name like ?', "%#{search_word}%").
      or(where('content like ?', "%#{search_word}%"))
  end

end
