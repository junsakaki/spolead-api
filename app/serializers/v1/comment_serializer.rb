module V1
  class CommentSerializer < ActiveModel::Serializer
    attributes :id, 
      :content
    
    has_one :payment, serializer: V1::PaymentSerializer
    belongs_to :user

    class UserSerializer < ActiveModel::Serializer
      attributes :id, :nickname
    end

  end
end
