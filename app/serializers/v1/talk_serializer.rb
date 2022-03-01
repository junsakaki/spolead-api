module V1
  class TalkSerializer < ActiveModel::Serializer
    attributes :id, :users
    
    has_many :comments, serializer: V1::CommentSerializer
    
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
  end
end
