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
      :precautions,
      :owner

    attribute :approval

    def initialize(object, options = {})
      super
      @options = options
      @admin = options[:admin]
    end

    def owner
      if object.salon_owner.present?
        if @admin 
          object.salon_owner
        else
          {name: object.salon_owner.name}
        end  
      end
    end

    has_many :plans, serializer: V1::PlanSerializer
  end
end
