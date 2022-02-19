module V1
  class SalonSerializer < ActiveModel::Serializer
    attributes :id, 
      :name,
      :caption,
      :image_top, 
      :image_sub, 
      :content, 
      :background, 
      :self_introduction,
      :precautions

    attribute :approval, if: -> { instance_options[:admin?] }

    has_many :plans, serializer: V1::PlanSerializer
    has_one :owner, serializer: V1::OwnerUsualSerializer, if: -> { !instance_options[:admin?] }
    has_one :owner, serializer: V1::OwnerAdminSerializer, if: -> { instance_options[:admin?] }
  end
end
