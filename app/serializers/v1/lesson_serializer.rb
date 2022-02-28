module V1
  class LessonSerializer < ActiveModel::Serializer
    attributes :id, 
      :name,
      :caption,
      :image_top, 
      :image_sub, 
      :content, 
      :background, 
      :self_introduction,
      :precautions,
      :reqruitment_target,
      :contact_type,
      :payment_type,
      :owner

    attribute :approval

    def initialize(object, options = {})
      super
      @options = options
      @admin = options[:admin]
    end

    def owner
      if object.lesson_owner.present?
        if @admin 
          object.lesson_owner
        else
          {name: object.lesson_owner.name}
        end  
      end
    end

  end
end
