class LessonsTalkRoom < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  has_many :comments, class_name: "LessonComment", foreign_key: 'talk_id'
end
