class LessonOwner < ApplicationRecord
    belongs_to :user
    belongs_to :lesson
end
