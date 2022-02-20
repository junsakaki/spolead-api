module V1
  class MatchingSerializer < ActiveModel::Serializer
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
      if object.matching_owner.present?
        if @admin 
          object.matching_owner
        else
          {name: object.matching_owner.name}
        end  
      end
    end

  end
end
