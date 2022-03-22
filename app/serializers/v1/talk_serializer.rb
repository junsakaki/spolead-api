module V1
  class TalkSerializer < ActiveModel::Serializer
    attributes :id
    attribute :users

    def users
      result = []
      user = {
        id: object.user.id,
        nickname: object.user.nickname
      }
      owner = {
        id: object.lesson.lesson_owner.id,
        nickname: object.lesson.lesson_owner.user.nickname
      }
      result.push(user)
      result.push(owner)
      return result
    end
    
    has_many :comments, serializer: V1::CommentSerializer
    belongs_to :lesson, serializer: V1::LessonSerializer
  end
end
