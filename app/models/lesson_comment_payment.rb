class LessonCommentPayment < ApplicationRecord
    belongs_to :comment,  :foreign_key => 'lesson_comment_id', class_name: "LessonComment"
end
