class LessonComment < ApplicationRecord
    belongs_to :user
    belongs_to :talk, :foreign_key => 'talk_id', class_name: "LessonsTalkRoom"
    has_one :payment,  :foreign_key => 'lesson_comment_id', class_name: "LessonCommentPayment"

    scope :subscription, -> {
        joins(:payment)
            .merge(LessonCommentPayment.where.not(plan_id: nil).where(cancel: false))
    }

    scope :active, -> (month = nil) {
        if month.present?
            joins(:payment)
                .merge(LessonCommentPayment.where.not(plan_id: nil).where(cancel: false).or(LessonCommentPayment.where(plan_id: nil, created_at: month, cancel: false)))
        else
            joins(:payment)
                .merge(LessonCommentPayment.where.not(plan_id: nil).where(cancel: false).or(LessonCommentPayment.where(plan_id: nil, cancel: false)))
        end
    }

end
