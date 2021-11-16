class BbsThread < ApplicationRecord
  attr_accessor :comments_count
  belongs_to :bbs_forum
  has_many :bbs_comments

  scope :search_columns, ->(search_word) do
    where('name like ?', "%#{search_word}%").
      or(where('content like ?', "%#{search_word}%"))
  end

  def views_count_up!
    self.views += 1
    save
  end

  def comments_count
    self.bbs_commentss.size
  end
end
