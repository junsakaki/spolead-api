class LessonComment < ApplicationRecord
    belongs_to :user
    belongs_to :talk, :foreign_key => 'talk_id', class_name: "LessonsTalkRoom"
    has_one :payment,  :foreign_key => 'lesson_comment_id', class_name: "LessonCommentPayment"
end
